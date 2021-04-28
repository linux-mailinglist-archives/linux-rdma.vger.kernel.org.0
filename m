Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4635536D1F7
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Apr 2021 08:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbhD1GDu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Apr 2021 02:03:50 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:34624 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbhD1GDu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Apr 2021 02:03:50 -0400
Received: by mail-il1-f197.google.com with SMTP id g7-20020a056e021a27b02901663a2bc830so31937352ile.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 Apr 2021 23:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KQBdgCXRi0vVbbjXE3+OlGcHNGy78080xma3h8MfGpE=;
        b=FLsikhJWEzibuUNUgVwlMWvGu7BJgRqUE7cwYiiP1SxQiIPDTvCGC9R35Chvxb1L7z
         GqYmgSjRVAEJKyTCmIdfrderCBzQVFaZ9xK+46FLnbGszHAZWdbZD0IoLN0cjRE3HDQr
         g0aswfZQ3vKwCjSu/XvU5JgXV0Mqyb71FI2fzPb71PR9lB4mCEJL3exeqjWfJ5t+AVJf
         zJk42n8S1O1DEDh99ANzI0ngAesdrTnToPf8BKhNbA6PKYw5e7ukG5JICmeOxzOYZrwo
         ljz2nm0SvGpgu7S7eS6VoC63TvEgEaC0HjI1WhSh0sR/nFjsdUWJJBdmIG7r37rXnESB
         Mb4g==
X-Gm-Message-State: AOAM533g7KXpvdFcfw/6wPQ6W56efAlTrmBPSowrHU495UIGfwspLFds
        xkWTKrYgFNq0vUEv5B6wN/v00FNEruho1wWjBbTOP1XeJuY+
X-Google-Smtp-Source: ABdhPJxGb5l1W3BMkqnAWksON5zDw2/21/EBORC+QrENGz9bKXJDdnmDDpw6IKOjcBffc9o1vRacd3A9q+cfGybNRUjsFXpS2cGz
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1123:: with SMTP id f3mr24764695jar.35.1619589784550;
 Tue, 27 Apr 2021 23:03:04 -0700 (PDT)
Date:   Tue, 27 Apr 2021 23:03:04 -0700
In-Reply-To: <20200403185707.GE8514@mellanox.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca459305c102216e@google.com>
Subject: Re: general protection fault in rdma_resolve_route
From:   syzbot <syzbot+69226cc89d87fd4f8f40@syzkaller.appspotmail.com>
To:     dledford@redhat.com, george.kennedy@oracle.com,
        haakon.bugge@oracle.com, jgg@mellanox.com,
        linux-rdma@vger.kernel.org, syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

00-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
[    0.058488] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x23fffffff] -> [mem 0x00000000-0x23fffffff]
[    0.060840] NODE_DATA(0) allocated [mem 0x23fffa000-0x23fffdfff]
[    0.103932] Zone ranges:
[    0.105131]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.107499]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.109481]   Normal   [mem 0x0000000100000000-0x000000023fffffff]
[    0.112322] Movable zone start for each node
[    0.113517] Early memory node ranges
[    0.114833]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.116844]   node   0: [mem 0x0000000000100000-0x00000000bfffcfff]
[    0.117754]   node   0: [mem 0x0000000100000000-0x000000023fffffff]
[    0.119114] Zeroed struct page in unavailable ranges: 101 pages
[    0.119121] Initmem setup node 0 [mem 0x0000000000001000-0x000000023fffffff]
[    0.488208] kasan: KernelAddressSanitizer initialized
[    0.491077] ACPI: PM-Timer IO Port: 0xb008
[    0.492273] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.493758] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.496178] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.498589] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.499528] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.501455] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.505310] Using ACPI (MADT) for SMP configuration information
[    0.507171] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.508243] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.509621] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.510867] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.511960] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.513141] PM: hibernation: Registered nosave memory: [mem 0xbfffd000-0xbfffffff]
[    0.514253] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xfffbbfff]
[    0.515989] PM: hibernation: Registered nosave memory: [mem 0xfffbc000-0xffffffff]
[    0.517624] [mem 0xc0000000-0xfffbbfff] available for PCI devices
[    0.518566] Booting paravirtualized kernel on KVM
[    0.519719] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.521833] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2 nr_node_ids:1
[    0.523803] percpu: Embedded 65 pages/cpu s228040 r8192 d30008 u1048576
[    0.525712] kvm-guest: stealtime: cpu 0, msr 1f6820300
[    0.526590] kvm-guest: PV spinlocks enabled
[    0.527219] PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.528285] Built 1 zonelists, mobility grouping on.  Total pages: 2064262
[    0.529218] Policy zone: Normal
[    0.530013] Kernel command line: BOOT_IMAGE=/vmlinuz root=/dev/sda1 console=ttyS0 earlyprintk=serial vsyscall=native net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1
[    0.535469] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.538483] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.540453] mem auto-init: stack:off, heap alloc:off, heap free:off
[    1.404586] Memory: 6936940K/8388204K available (104477K kernel code, 16962K rwdata, 19800K rodata, 2716K init, 14576K bss, 1451008K reserved, 0K cma-reserved)
[    1.409491] Running RCU self tests
[    1.410244] rcu: Preemptible hierarchical RCU implementation.
[    1.411041] rcu: 	RCU lockdep checking is enabled.
[    1.411868] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
[    1.413172] rcu: 	RCU callback double-/use-after-free debug enabled.
[    1.414100] 	Trampoline variant of Tasks RCU enabled.
[    1.414856] 	Tracing variant of Tasks RCU enabled.
[    1.415720] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    1.416920] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    1.434818] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
[    1.436389] random: get_random_bytes called from start_kernel+0x248/0x452 with crng_init=0
[    1.438577] Console: colour VGA+ 80x25
[    1.440431] printk: console [ttyS0] enabled
[    1.440431] printk: console [ttyS0] enabled
[    1.442758] printk: bootconsole [earlyser0] disabled
[    1.442758] printk: bootconsole [earlyser0] disabled
[    1.445364] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    1.446561] ... MAX_LOCKDEP_SUBCLASSES:  8
[    1.447268] ... MAX_LOCK_DEPTH:          48
[    1.448234] ... MAX_LOCKDEP_KEYS:        8192
[    1.449368] ... CLASSHASH_SIZE:          4096
[    1.450383] ... MAX_LOCKDEP_ENTRIES:     32768
[    1.451040] ... MAX_LOCKDEP_CHAINS:      65536
[    1.451749] ... CHAINHASH_SIZE:          32768
[    1.452760]  memory used by lock dependency info: 6365 kB
[    1.453563]  memory used for stack traces: 4224 kB
[    1.454931]  per task-struct memory footprint: 1920 bytes
[    1.456060] ACPI: Core revision 20210105
[    1.457395] APIC: Switch to symmetric I/O mode setup
[    1.459143] x2apic enabled
[    1.463697] Switched APIC routing to physical x2apic.
[    1.471104] ..TIMER: vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1
[    1.472880] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x212733415c7, max_idle_ns: 440795236380 ns
[    1.474596] Calibrating delay loop (skipped) preset value.. 4599.99 BogoMIPS (lpj=22999980)
[    1.475862] pid_max: default: 32768 minimum: 301
[    1.477131] LSM: Security Framework initializing
[    1.484641] Yama: becoming mindful.
[    1.485728] AppArmor: AppArmor initialized
[    1.486377] TOMOYO Linux initialized
[    1.487338] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    1.488572] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    1.492797] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    1.493825] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    1.494613] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    1.496256] Spectre V2 : Spectre mitigation: kernel not compiled with retpoline; no mitigation available!
[    1.496268] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    1.499114] MDS: Mitigation: Clear CPU buffers
[    1.500421] Freeing SMP alternatives memory: 96K
[    1.625192] smpboot: CPU0: Intel(R) Xeon(R) CPU @ 2.30GHz (family: 0x6, model: 0x3f, stepping: 0x0)
[    1.628822] Running RCU-tasks wait API self tests
[    1.734790] Performance Events: unsupported p6 CPU model 63 no PMU driver, software events only.
[    1.737061] rcu: Hierarchical SRCU implementation.
[    1.738746] NMI watchdog: Perf NMI watchdog permanently disabled
[    1.740308] smp: Bringing up secondary CPUs ...
[    1.743161] x86: Booting SMP configuration:
[    1.744082] .... node  #0, CPUs:      #1
[    0.048290] kvm-clock: cpu 1, msr 9ff4041, secondary cpu clock
[    1.746880] kvm-guest: stealtime: cpu 1, msr 1f6920300
[    1.746880] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    1.746893] smp: Brought up 1 node, 2 CPUs
[    1.747731] smpboot: Max logical packages: 1
[    1.748615] smpboot: Total of 2 processors activated (9199.99 BogoMIPS)
[    1.756137] devtmpfs: initialized
[    1.766996] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    1.767107] kworker/u4:0 (25) used greatest stack depth: 27696 bytes left
[    1.768357] futex hash table entries: 512 (order: 4, 65536 bytes, linear)
[    1.774706] Callback from call_rcu_tasks_trace() invoked.
[    1.776981] PM: RTC time: 05:54:04, date: 2021-04-28
[    1.779484] NET: Registered protocol family 16
[    1.782350] audit: initializing netlink subsys (disabled)
[    1.789010] thermal_sys: Registered thermal governor 'step_wise'
[    1.789025] thermal_sys: Registered thermal governor 'user_space'
[    1.792224] audit: type=2000 audit(1619589244.902:1): state=initialized audit_enabled=0 res=1
[    1.793888] cpuidle: using governor menu
[    1.795710] ACPI: bus type PCI registered
[    1.797887] dca service started, version 1.12.1
[    1.799280] PCI: Using configuration type 1 for base access
[    1.834628] kworker/u4:1 (80) used greatest stack depth: 27664 bytes left
[    1.954755] kworker/u4:0 (374) used greatest stack depth: 27048 bytes left
[    2.309454] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    2.314763] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.325575] cryptd: max_cpu_qlen set to 1000
[    2.345279] Callback from call_rcu_tasks() invoked.
[    2.524609] raid6: avx2x4   gen() 15219 MB/s
[    2.694788] raid6: avx2x4   xor()  7262 MB/s
[    2.864594] raid6: avx2x2   gen() 11255 MB/s
[    3.034606] raid6: avx2x2   xor()  5120 MB/s
[    3.202375] raid6: avx2x1   gen()  6250 MB/s
[    3.372377] raid6: avx2x1   xor()  3156 MB/s
[    3.542374] raid6: sse2x4   gen()  6546 MB/s
[    3.714623] raid6: sse2x4   xor()  3857 MB/s
[    3.884599] raid6: sse2x2   gen()  5919 MB/s
[    4.054587] raid6: sse2x2   xor()  2612 MB/s
[    4.224587] raid6: sse2x1   gen()  3308 MB/s
[    4.394590] raid6: sse2x1   xor()  1499 MB/s
[    4.395909] raid6: using algorithm avx2x4 gen() 15219 MB/s
[    4.397145] raid6: .... xor() 7262 MB/s, rmw enabled
[    4.398231] raid6: using avx2x2 recovery algorithm
[    4.400027] ACPI: Added _OSI(Module Device)
[    4.401320] ACPI: Added _OSI(Processor Device)
[    4.402230] ACPI: Added _OSI(3.0 _SCP Extensions)
[    4.403371] ACPI: Added _OSI(Processor Aggregator Device)
[    4.404341] ACPI: Added _OSI(Linux-Dell-Video)
[    4.404601] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    4.405681] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    4.443090] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    4.483327] ACPI: Interpreter enabled
[    4.484827] ACPI: (supports S0 S3 S4 S5)
[    4.485492] ACPI: Using IOAPIC for interrupt routing
[    4.487197] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    4.490999] ACPI: Enabled 16 GPEs in block 00 to 0F
[    4.570375] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    4.571871] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    4.573808] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    4.578475] PCI host bridge to bus 0000:00
[    4.579556] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    4.581578] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    4.582582] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    4.584602] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfefff window]
[    4.585897] pci_bus 0000:00: root bus resource [bus 00-ff]
[    4.586983] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    4.596270] pci 0000:00:01.0: [8086:7110] type 00 class 0x060100
[    4.635352] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    4.663128] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
[    4.667290] pci 0000:00:03.0: [1af4:1004] type 00 class 0x000000
[    4.681139] pci 0000:00:03.0: reg 0x10: [io  0xc000-0xc03f]
[    4.689913] pci 0000:00:03.0: reg 0x14: [mem 0xfe800000-0xfe80007f]
[    4.715281] pci 0000:00:04.0: [1af4:1000] type 00 class 0x020000
[    4.724631] pci 0000:00:04.0: reg 0x10: [io  0xc040-0xc07f]
[    4.732306] pci 0000:00:04.0: reg 0x14: [mem 0xfe801000-0xfe80107f]
[    4.755983] pci 0000:00:05.0: [1ae0:a002] type 00 class 0x030000
[    4.768756] pci 0000:00:05.0: reg 0x10: [mem 0xfe000000-0xfe7fffff]
[    4.804905] pci 0000:00:06.0: [1af4:1002] type 00 class 0x00ff00
[    4.814599] pci 0000:00:06.0: reg 0x10: [io  0xc080-0xc09f]
[    4.845385] pci 0000:00:07.0: [1af4:1005] type 00 class 0x00ff00
[    4.854677] pci 0000:00:07.0: reg 0x10: [io  0xc0a0-0xc0bf]
[    4.862019] pci 0000:00:07.0: reg 0x14: [mem 0xfe802000-0xfe80203f]
[    4.895345] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    4.900887] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    4.905638] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    4.910451] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    4.914692] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    4.926383] iommu: Default domain type: Translated 
[    4.928005] pci 0000:00:05.0: vgaarb: setting as boot VGA device
[    4.928005] pci 0000:00:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    4.928031] pci 0000:00:05.0: vgaarb: bridge control possible
[    4.929711] vgaarb: loaded
[    4.935676] SCSI subsystem initialized
[    4.938811] ACPI: bus type USB registered
[    4.940933] usbcore: registered new interface driver usbfs
[    4.944914] usbcore: registered new interface driver hub
[    4.946468] usbcore: registered new device driver usb
[    4.951257] mc: Linux media interface: v0.10
[    4.952541] videodev: Linux video capture interface: v2.00
[    4.957213] pps_core: LinuxPPS API ver. 1 registered
[    4.958276] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    4.963112] PTP clock support registered
[    4.966465] EDAC MC: Ver: 3.0.0
[    4.968630] Advanced Linux Sound Architecture Driver Initialized.
[    4.976928] Bluetooth: Core ver 2.22
[    4.979044] NET: Registered protocol family 31
[    4.980769] Bluetooth: HCI device and connection manager initialized
[    4.982902] Bluetooth: HCI socket layer initialized
[    4.984625] Bluetooth: L2CAP socket layer initialized
[    4.986482] Bluetooth: SCO socket layer initialized
[    4.988517] NET: Registered protocol family 8
[    4.990235] NET: Registered protocol family 20
[    4.992391] NetLabel: Initializing
[    4.994618] NetLabel:  domain hash size = 128
[    4.996509] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    4.998942] NetLabel:  unlabeled traffic allowed by default
[    5.001549] nfc: nfc_init: NFC Core ver 0.1
[    5.001549] NET: Registered protocol family 39
[    5.001549] PCI: Using ACPI for IRQ routing
[    5.005939] clocksource: Switched to clocksource kvm-clock
[    5.331782] VFS: Disk quotas dquot_6.6.0
[    5.334522] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    5.337855] FS-Cache: Loaded
[    5.340293] CacheFiles: Loaded
[    5.342072] TOMOYO: 2.6.0
[    5.343045] Profile 0 (used by '<kernel>') is not defined.
[    5.345255] Userland tools for TOMOYO 2.6 must be installed and policy must be initialized.
[    5.348577] Please see https://tomoyo.osdn.jp/2.6/ for more information.
[    5.351443] Kernel panic - not syncing: STOP!
[    5.353059] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc2-syzkaller #0
[    5.355230] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
[    5.355230] Call Trace:
[    5.355230]  dump_stack+0x156/0x1a5
[    5.355230]  panic+0x2ea/0x687
[    5.355230]  ? __warn_printk+0xf3/0xf3
[    5.355230]  ? lock_release+0x47c/0x970
[    5.355230]  ? lock_downgrade+0x8a0/0x8a0
[    5.355230]  ? vprintk_func+0x76/0x180
[    5.355230]  tomoyo_check_profile.cold+0xc9/0xe9
[    5.355230]  tomoyo_load_builtin_policy+0x27b/0x2c2
[    5.355230]  ? smack_nf_ip_init+0x77/0x77
[    5.355230]  ? tomoyo_write_domain2+0x1b0/0x1b0
[    5.355230]  ? securityfs_create_dentry+0x13a/0x530
[    5.355230]  tomoyo_initerface_init+0x1b7/0x1c2
[    5.355230]  ? tomoyo_mm_init+0x257/0x257
[    5.355230]  do_one_initcall+0xef/0x640
[    5.355230]  ? perf_trace_initcall_level+0x3d0/0x3d0
[    5.355230]  ? __this_cpu_preempt_check+0x1d/0x30
[    5.355230]  ? lock_is_held_type+0x100/0x140
[    5.355230]  kernel_init_freeable+0x58a/0x5f9
[    5.355230]  ? rest_init+0x2e4/0x2e4
[    5.355230]  kernel_init+0x12/0x16c
[    5.355230]  ret_from_fork+0x1f/0x30
[    5.355230] Rebooting in 86400 seconds..


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=17af81e1d00000


Tested on:

commit:         6cc9e215 RDMA/nldev: Add copy-on-fork attribute to get sys..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=d845af22fa44b27a
dashboard link: https://syzkaller.appspot.com/bug?extid=69226cc89d87fd4f8f40
compiler:       

