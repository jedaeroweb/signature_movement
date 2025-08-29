
(() => {
    'use strict'

    const getStoredTheme = () => localStorage.getItem('theme')
    const setStoredTheme = (theme) => localStorage.setItem('theme', theme)

    const getPreferredTheme = () => {
        const storedTheme = getStoredTheme()
        if (storedTheme) {
            return storedTheme
        }
        return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
    }

    const updateThemeIcon = (theme) => {
        const iconElement = document.querySelector('.current-theme-icon')
        if (!iconElement) return

        iconElement.innerHTML = document.querySelector('.dropdown-item[data-bs-theme-value="'+theme+'"] .icon')?.textContent.trim();
    }

    const setTheme = (theme) => {
        if (theme === 'auto') {
            const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches
            document.documentElement.setAttribute('data-bs-theme', prefersDark ? 'dark' : 'light')
        } else {
            document.documentElement.setAttribute('data-bs-theme', theme)
        }

        updateThemeIcon(theme)

        // Update active state in dropdown
        document.querySelectorAll('[data-bs-theme-value]').forEach(button => {
            button.classList.remove('active')
            if (button.getAttribute('data-bs-theme-value') === theme) {
                button.classList.add('active')
            }
        })
    }

    const initializeTheme = () => {
        // Set initial theme
        const theme = getPreferredTheme()
        setTheme(theme)

        // Add event listeners to buttons
        document.querySelectorAll('[data-bs-theme-value]').forEach(button => {
            button.addEventListener('click', () => {
                const theme = button.getAttribute('data-bs-theme-value')
                setStoredTheme(theme)
                setTheme(theme)
            })
        })
    }

    // Listen for system theme changes
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
        const storedTheme = getStoredTheme()
        if (storedTheme === 'auto') {
            setTheme('auto')
        }
    })

    // Initialize on first load
    initializeTheme()

    // Initialize on Turbo Drive load
    document.addEventListener('turbo:load', initializeTheme)
})()

