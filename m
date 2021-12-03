Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2C5466FAE
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Dec 2021 03:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350004AbhLCCYA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 21:24:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244477AbhLCCYA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 21:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638498036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=bQFbPCpLlyX6KdtEU7wD4eCWPdeDM9ANkJXW47Njn4s=;
        b=YACLxYa6WYtXh3PHe4uHQO5mUkPvUCqL7QwqOTAB/O4zCujBggL81Wo8m1zrpTgAV2lp4Q
        R+rL4zs2nqMIijJTTToEaOAqt4umnESL8jTS9iUR5MrxolzHsdpXB+bCYGO7X9nY/eFyRq
        bDTcEHH//0SIp+Jf/Umm2fto56rG2oQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-8ru0pZNvOhahbmoyeoilGw-1; Thu, 02 Dec 2021 21:20:35 -0500
X-MC-Unique: 8ru0pZNvOhahbmoyeoilGw-1
Received: by mail-yb1-f197.google.com with SMTP id y17-20020a2586d1000000b005f6596e8760so3575480ybm.17
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 18:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bQFbPCpLlyX6KdtEU7wD4eCWPdeDM9ANkJXW47Njn4s=;
        b=Qzayal1ORv1VyjjAfOGqhivttN1HD6CmJPSDjNc3bjpbsS9wI15x/bVPd8DkS/otEW
         Vw7sTT+TRP4vYoC8qnTUDCQFTn3KDhm0o1w9w8ZKzKqo2qh1t8klp3gXPp3F/8GaTjo2
         C08IWr+Fpj3h57OYLg1CMmVkBZdj9YEg1KyYc1JEHkJLt5Pe+/XZeNli7GX5orSztJok
         5hw0ctMDwKTBCpOpxp61fLqZTgHTMvV4YwBhv7NU/hgrTO34GbIbVkN3sS5bqhGcf40E
         ITo9KfcEFCVECQyvzKvEdeD0k76+TX5+c3JTbLXozZqkzpd0RiTkOAJu6bv3DoXOI768
         n5Sw==
X-Gm-Message-State: AOAM5302kIKDsLZ8NWuBARXUGNOTyJDgxHFVMlSWPiaPmg80KOud9Fyk
        lWqlN0/gARIn8QQpN3suzEMVMHcqkcTlZADwib0F4etD6EdYN0s4Q9yiI3Gt0TA4nIsBeMwlW/D
        aG4Xmx8T21105SJ9tlVrD/l39DO4y4UvWG3PoAQ==
X-Received: by 2002:a25:13c2:: with SMTP id 185mr21122738ybt.676.1638498035039;
        Thu, 02 Dec 2021 18:20:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnb/R2d4+h5tqQNWY7M9Y9p7DGdUDvbqk93vTkXk6hBVCudN8OZmdNBACMQ7biTWJqGdHTUGThd84G6cPv7Jw=
X-Received: by 2002:a25:13c2:: with SMTP id 185mr21122701ybt.676.1638498034595;
 Thu, 02 Dec 2021 18:20:34 -0800 (PST)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Fri, 3 Dec 2021 10:20:23 +0800
Message-ID: <CAHj4cs8h3e_fY6cKb3XL9aEp8_MT3Po8-W6cL35kKEAvj6qs0Q@mail.gmail.com>
Subject: [bug report]concurrent blktests nvme-rdma execution lead kernel null pointer
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello
With the concurrent blktests nvme-rdma execution with both rdma_rxe
and siw lead kernel BUG on 5.16.0-rc3, pls help check it, thanks.

Reproducer:
Run blktests nvme-rdma on two terminal at the same time
terminal 1:
# use_siw=1 nvme_trtype=rdma ./check nvme/
terminal 2:
# nvme_trtype=rdma ./check nvme/

[ 1685.584327] run blktests nvme/013 at 2021-12-02 21:08:46
[ 1685.669804] eno2 speed is unknown, defaulting to 1000
[ 1685.674866] eno2 speed is unknown, defaulting to 1000
[ 1685.679941] eno2 speed is unknown, defaulting to 1000
[ 1685.686033] eno2 speed is unknown, defaulting to 1000
[ 1685.691087] eno2 speed is unknown, defaulting to 1000
[ 1685.697677] eno2 speed is unknown, defaulting to 1000
[ 1685.703727] eno3 speed is unknown, defaulting to 1000
[ 1685.708798] eno3 speed is unknown, defaulting to 1000
[ 1685.713863] eno3 speed is unknown, defaulting to 1000
[ 1685.719965] eno3 speed is unknown, defaulting to 1000
[ 1685.725043] eno3 speed is unknown, defaulting to 1000
[ 1685.731688] eno2 speed is unknown, defaulting to 1000
[ 1685.736763] eno3 speed is unknown, defaulting to 1000
[ 1685.742818] eno4 speed is unknown, defaulting to 1000
[ 1685.747881] eno4 speed is unknown, defaulting to 1000
[ 1685.752949] eno4 speed is unknown, defaulting to 1000
[ 1685.759134] eno4 speed is unknown, defaulting to 1000
[ 1685.764195] eno4 speed is unknown, defaulting to 1000
[ 1685.770914] eno2 speed is unknown, defaulting to 1000
[ 1685.775980] eno3 speed is unknown, defaulting to 1000
[ 1685.781047] eno4 speed is unknown, defaulting to 1000
[ 1686.002801] eno2 speed is unknown, defaulting to 1000
[ 1686.007867] eno3 speed is unknown, defaulting to 1000
[ 1686.012934] eno4 speed is unknown, defaulting to 1000
[ 1686.022521] rdma_rxe: rxe-ah pool destroyed with unfree'd elem
[ 1686.289384] run blktests nvme/013 at 2021-12-02 21:08:46
[ 1686.356666] eno2 speed is unknown, defaulting to 1000
[ 1686.361735] eno2 speed is unknown, defaulting to 1000
[ 1686.366807] eno2 speed is unknown, defaulting to 1000
[ 1686.371876] eno2 speed is unknown, defaulting to 1000
[ 1686.378400] eno2 speed is unknown, defaulting to 1000
[ 1686.384419] eno3 speed is unknown, defaulting to 1000
[ 1686.389494] eno3 speed is unknown, defaulting to 1000
[ 1686.394583] eno3 speed is unknown, defaulting to 1000
[ 1686.399660] eno3 speed is unknown, defaulting to 1000
[ 1686.406219] eno2 speed is unknown, defaulting to 1000
[ 1686.411291] eno3 speed is unknown, defaulting to 1000
[ 1686.417275] eno4 speed is unknown, defaulting to 1000
[ 1686.422338] eno4 speed is unknown, defaulting to 1000
[ 1686.427401] eno4 speed is unknown, defaulting to 1000
[ 1686.432475] eno4 speed is unknown, defaulting to 1000
[ 1686.439038] eno2 speed is unknown, defaulting to 1000
[ 1686.444109] eno3 speed is unknown, defaulting to 1000
[ 1686.449180] eno4 speed is unknown, defaulting to 1000
[ 1686.873596] xfs filesystem being mounted at /mnt/blktests supports
timestamps until 2038 (0x7fffffff)
[ 1687.540606] xfs filesystem being mounted at /mnt/blktests supports
timestamps until 2038 (0x7fffffff)
[ 1693.658327] block nvme0n1: no available path - failing I/O
[ 1693.663038] block nvme0n1: no available path - failing I/O
[ 1693.663828] XFS (nvme0n1): log I/O error -5
[ 1693.665024] block nvme0n1: no available path - failing I/O
[ 1693.665041] XFS (nvme0n1): log I/O error -5
[ 1693.665044] XFS (nvme0n1): Log I/O Error (0x2) detected at
xlog_ioend_work+0x71/0x80 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting
down filesystem.
[ 1693.665142] XFS (nvme0n1): Please unmount the filesystem and
rectify the problem(s)
[ 1693.720462] block nvme0n1: no available path - failing I/O
[ 1693.728150] nvmet_rdma: post_recv cmd failed
[ 1693.732432] nvmet_rdma: sending cmd response failed
[ 1693.836083] eno2 speed is unknown, defaulting to 1000
[ 1693.841152] eno3 speed is unknown, defaulting to 1000
[ 1693.846217] eno4 speed is unknown, defaulting to 1000
[ 1693.852280] BUG: unable to handle page fault for address: ffffffffc09d2680
[ 1693.859156] #PF: supervisor instruction fetch in kernel mode
[ 1693.864815] #PF: error_code(0x0010) - not-present page
[ 1693.869953] PGD 2b5813067 P4D 2b5813067 PUD 2b5815067 PMD 13a157067 PTE 0
[ 1693.876740] Oops: 0010 [#1] PREEMPT SMP NOPTI
[ 1693.881098] CPU: 15 PID: 16091 Comm: rdma Tainted: G S        I
  5.16.0-rc3 #1
[ 1693.888751] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS
2.11.2 004/21/2021
[ 1693.896403] RIP: 0010:0xffffffffc09d2680
[ 1693.900329] Code: Unable to access opcode bytes at RIP 0xffffffffc09d2656.
[ 1693.907202] RSP: 0018:ffffb3d5456237b0 EFLAGS: 00010286
[ 1693.912428] RAX: ffffffffc09d2680 RBX: ffff9d4adade2000 RCX: 0000000000000001
[ 1693.919559] RDX: 0000000080000001 RSI: ffffb3d5456237e8 RDI: ffff9d4adade2000
[ 1693.926693] RBP: ffffb3d5456237e8 R08: ffffb3d545623850 R09: 0000000000000230
[ 1693.933823] R10: 0000000000000002 R11: ffffb3d545623840 R12: ffff9d4adade2270
[ 1693.940957] R13: ffff9d4adade21e0 R14: 0000000000000005 R15: ffff9d4adade2220
[ 1693.948089] FS:  00007f2f0601c000(0000) GS:ffff9d59ffdc0000(0000)
knlGS:0000000000000000
[ 1693.956176] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1693.961921] CR2: ffffffffc09d2656 CR3: 0000000180578004 CR4: 00000000007706e0
[ 1693.969052] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1693.976177] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1693.983309] PKRU: 55555554
[ 1693.986023] Call Trace:
[ 1693.988474]  <TASK>
[ 1693.990582]  ? cma_cm_event_handler+0x1d/0xd0 [rdma_cm]
[ 1693.995817]  ? cma_process_remove+0x73/0x290 [rdma_cm]
[ 1694.000954]  ? cma_remove_one+0x5a/0xd0 [rdma_cm]
[ 1694.005661]  ? remove_client_context+0x88/0xd0 [ib_core]
[ 1694.010990]  ? disable_device+0x8c/0x130 [ib_core]
[ 1694.015790]  ? xa_load+0x73/0xa0
[ 1694.019024]  ? __ib_unregister_device+0x40/0xa0 [ib_core]
[ 1694.024431]  ? ib_unregister_device_and_put+0x33/0x50 [ib_core]
[ 1694.030360]  ? nldev_dellink+0x86/0xe0 [ib_core]
[ 1694.035000]  ? rdma_nl_rcv_msg+0x109/0x200 [ib_core]
[ 1694.039978]  ? __alloc_skb+0x8c/0x1b0
[ 1694.043645]  ? __kmalloc_node_track_caller+0x184/0x340
[ 1694.048785]  ? rdma_nl_rcv+0xc8/0x110 [ib_core]
[ 1694.053325]  ? netlink_unicast+0x1a2/0x280
[ 1694.057424]  ? netlink_sendmsg+0x244/0x480
[ 1694.061524]  ? sock_sendmsg+0x58/0x60
[ 1694.065188]  ? __sys_sendto+0xee/0x160
[ 1694.068944]  ? netlink_setsockopt+0x26e/0x3d0
[ 1694.073300]  ? __sys_setsockopt+0xdc/0x1d0
[ 1694.077400]  ? __x64_sys_sendto+0x24/0x30
[ 1694.081414]  ? do_syscall_64+0x37/0x80
[ 1694.085164]  ? entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1694.090391]  </TASK>
[ 1694.092584] Modules linked in: siw rpcrdma rdma_ucm ib_uverbs
ib_srpt ib_isert iscsi_target_mod target_core_mod loop ib_iser
libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm ib_core
rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache
netfs rfkill sunrpc vfat fat dm_multipath intel_rapl_msr
intel_rapl_common isst_if_common skx_edac x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel ipmi_ssif kvm mgag200 i2c_algo_bit
drm_kms_helper iTCO_wdt iTCO_vendor_support syscopyarea irqbypass
sysfillrect crct10dif_pclmul sysimgblt crc32_pclmul fb_sys_fops
ghash_clmulni_intel acpi_ipmi drm rapl ipmi_si intel_cstate mei_me
intel_uncore i2c_i801 mei ipmi_devintf nd_pmem dax_pmem_compat
wmi_bmof pcspkr device_dax intel_pch_thermal i2c_smbus lpc_ich
ipmi_msghandler nd_btt dax_pmem_core acpi_power_meter xfs libcrc32c
sd_mod t10_pi sg ahci libahci libata megaraid_sas nfit tg3
crc32c_intel libnvdimm wmi dm_mirror dm_region_hash dm_log dm_mod
[last unloaded: nvmet]
[ 1694.178277] CR2: ffffffffc09d2680
[ 1694.181596] ---[ end trace 9c234cd612cbb92a ]---
[ 1694.217410] RIP: 0010:0xffffffffc09d2680
[ 1694.221343] Code: Unable to access opcode bytes at RIP 0xffffffffc09d2656.
[ 1694.228212] RSP: 0018:ffffb3d5456237b0 EFLAGS: 00010286
[ 1694.233437] RAX: ffffffffc09d2680 RBX: ffff9d4adade2000 RCX: 0000000000000001
[ 1694.240570] RDX: 0000000080000001 RSI: ffffb3d5456237e8 RDI: ffff9d4adade2000
[ 1694.247702] RBP: ffffb3d5456237e8 R08: ffffb3d545623850 R09: 0000000000000230
[ 1694.254828] R10: 0000000000000002 R11: ffffb3d545623840 R12: ffff9d4adade2270
[ 1694.261958] R13: ffff9d4adade21e0 R14: 0000000000000005 R15: ffff9d4adade2220
[ 1694.269091] FS:  00007f2f0601c000(0000) GS:ffff9d59ffdc0000(0000)
knlGS:0000000000000000
[ 1694.277178] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1694.282922] CR2: ffffffffc09d2656 CR3: 0000000180578004 CR4: 00000000007706e0
[ 1694.290054] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1694.297180] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1694.304312] PKRU: 55555554
[ 1694.307025] Kernel panic - not syncing: Fatal exception
[ 1694.772244] Kernel Offset: 0x35c00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 1694.794394] ---[ end Kernel panic - not syncing: Fatal exception ]---


-- 
Best Regards,
  Yi Zhang

