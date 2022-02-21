Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584E14BD5D2
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Feb 2022 07:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345057AbiBUGRa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Feb 2022 01:17:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbiBUGR1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Feb 2022 01:17:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B4D6E90
        for <linux-rdma@vger.kernel.org>; Sun, 20 Feb 2022 22:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645424223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=lzpzupneu+PyOELCBCeklYDAebOUBMWynAwABT94OUI=;
        b=Ep7IAX1JBXp9RfmdhXRZ60gQmORKc4v7bBlR2ms59ajmafjIXlas4FKyhJ10N+SUNe1aOd
        TLHi9ehXStatachWy+ChEaJE5Te80IA3ktjc4PL+K6dsPYj5eNgHq5Iuvd7JJ6XH5NxYyb
        59Xo4CaIqwVRMy3ECbxK2hspzX0cICo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-FvtH-yV1OOu633BeBRULnw-1; Mon, 21 Feb 2022 01:17:00 -0500
X-MC-Unique: FvtH-yV1OOu633BeBRULnw-1
Received: by mail-pg1-f198.google.com with SMTP id t18-20020a63dd12000000b00342725203b5so8899067pgg.16
        for <linux-rdma@vger.kernel.org>; Sun, 20 Feb 2022 22:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lzpzupneu+PyOELCBCeklYDAebOUBMWynAwABT94OUI=;
        b=TaPbp9LOvOD4XAgnlzN3+UtACmEb/xLvfaRqmhXwIJpqz550fVu8C6isPQcaAhdaS1
         Dl+Tvk/sLTTxbg0sjAcYFYifK71rxEne5LZ/MMTztScIlQjfZ7C61fktD0uDZnipCNFb
         u8L5yo4J1VkClSixjCYezccbXxs5oQbeMxR9/f1bzu/DmrpqcSfLG1txcitQo6snVW9V
         kSHjOBBMMXrOcT17Yii66yCrZaRYpZ0whsUnQWNzTtUi0jAmwg+RWMieUD40Eierq3GD
         u9huHxHze3Jkcs3OHP4tjS9Bez7XtLbkmU9QhgEfBZR1eNAiizXoqj1w05GJydT9zCLC
         JAwg==
X-Gm-Message-State: AOAM5307oykH6ng4r4bUUiihMNIyPAz7MDn5ipNa4GDzd2/Hpp2tIAng
        FvZ6nVLXoDh2TfGc9VzlBulRDORBjj+3DX+2kH6LnWvBUwYXYbmKoMRXDm9MAu1wCqa61T6HD4v
        LjYEdP9nwdI/Iz7O3Kpqh53qLPbCmZICuOWpB2w==
X-Received: by 2002:a63:f555:0:b0:373:9ad0:ca08 with SMTP id e21-20020a63f555000000b003739ad0ca08mr14960390pgk.315.1645424219194;
        Sun, 20 Feb 2022 22:16:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyelIYMPR79BUIxK5ggcO9hePSQ6Fgqi5EfynIbREZ31uaILJh6wdhAPdga4Awn8LtLpDSoKTAuGXhzNMhbuyU=
X-Received: by 2002:a63:f555:0:b0:373:9ad0:ca08 with SMTP id
 e21-20020a63f555000000b003739ad0ca08mr14960379pgk.315.1645424218939; Sun, 20
 Feb 2022 22:16:58 -0800 (PST)
MIME-Version: 1.0
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Mon, 21 Feb 2022 14:16:47 +0800
Message-ID: <CAHj4cs_=1bFXGe+dqf0os0nvMwSnVtMJ3aZ12EAydcXGNSwo6w@mail.gmail.com>
Subject: [bug report] NVMe/IB: WARNING at kernel/dma/debug.c:571
 add_dma_entry+0x36a/0x4c0 observed on host side after connect
To:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello
The below WARNING was triggered on the host side after a connection on
5.17.0-rc3, here is the full log, let me if you need any tests for it,
thanks

HW:
# lspci | grep -i mel
04:00.0 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]
04:00.1 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]

dmesg:
[  507.229417] ------------[ cut here ]------------
[  507.235233] DMA-API: mlx5_core 0000:04:00.0: cacheline tracking
EEXIST, overlapping mappings aren't supported
[  507.246475] WARNING: CPU: 10 PID: 855 at kernel/dma/debug.c:571
add_dma_entry+0x36a/0x4c0
[  507.255751] Modules linked in: nvme_rdma nvme_fabrics nvme_core
8021q garp mrp bonding bridge stp llc rfkill rpcrdma sunrpc rdma_ucm
ib_srpt ib_isert iscsi_target_mod target_core_mod ib_iser libiscsi
ib_umad scsi_transport_iscsi rdma_cm ib_ipoib iw_cm ib_cm
intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal
intel_powerclamp coretemp kvm_intel kvm mlx5_ib iTCO_wdt
iTCO_vendor_support irqbypass ib_uverbs crct10dif_pclmul crc32_pclmul
ib_core ghash_clmulni_intel rapl intel_cstate intel_uncore pcspkr
lpc_ich mei_me mxm_wmi ipmi_ssif mei ipmi_si ipmi_devintf
ipmi_msghandler acpi_power_meter xfs libcrc32c mgag200 i2c_algo_bit
drm_shmem_helper sd_mod drm_kms_helper t10_pi sg syscopyarea
sysfillrect sysimgblt fb_sys_fops mlx5_core drm ahci mlxfw libahci
crc32c_intel pci_hyperv_intf tls tg3 libata psample wmi dm_mirror
dm_region_hash dm_log dm_mod
[  507.341004] CPU: 10 PID: 855 Comm: kworker/u80:3 Tainted: G S
         5.17.0-rc3.rc3.debug #3
[  507.351351] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS
2.9.1 12/07/2018
[  507.361252] Workqueue: ib_addr process_one_req [ib_core]
[  507.368756] RIP: 0010:add_dma_entry+0x36a/0x4c0
[  507.375291] Code: 01 00 00 4c 8b 6d 50 4d 85 ed 0f 84 9d 00 00 00
48 89 ef e8 18 e5 0e 01 48 89 c6 4c 89 ea 48 c7 c7 80 a0 8c 8d e8 a6
d6 da 01 <0f> 0b 48 85 db 0f 85 20 c9 dc 01 8b 05 75 56 24 04 85 c0 0f
85 c2
[  507.399392] RSP: 0018:ffff8890b6aaf7a0 EFLAGS: 00010282
[  507.406756] RAX: 0000000000000000 RBX: ffff8885d1d6e600 RCX: 0000000000000000
[  507.416302] RDX: 0000000000000001 RSI: ffffffff8da92ac0 RDI: ffffffff90ff9880
[  507.425860] RBP: ffff8882580640d0 R08: ffffed11854bfb39 R09: ffffed11854bfb39
[  507.435450] R10: ffff888c2a5fd9c7 R11: ffffed11854bfb38 R12: 1ffff11216d55ef6
[  507.445054] R13: ffff889086697b20 R14: 00000000ffffffef R15: 0000000000000202
[  507.454683] FS:  0000000000000000(0000) GS:ffff888c2a400000(0000)
knlGS:0000000000000000
[  507.465423] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  507.473553] CR2: 00007f080b8fe000 CR3: 00000017fd62c001 CR4: 00000000001706e0
[  507.483282] Call Trace:
[  507.487748]  <TASK>
[  507.491829]  ? dma_debug_init+0x130/0x130
[  507.498064]  ? debug_dma_map_page+0x278/0x320
[  507.504722]  dma_map_page_attrs+0x3bb/0xa90
[  507.511191]  ? dma_need_sync+0x100/0x100
[  507.517369]  ? kmem_cache_alloc_trace+0x13b/0x220
[  507.524457]  nvme_rdma_create_queue_ib+0x8a6/0x12c0 [nvme_rdma]
[  507.532949]  ? nvme_rdma_reconnect_ctrl_work+0x60/0x60 [nvme_rdma]
[  507.541744]  ? rdma_restrack_add+0xfb/0x4a0 [ib_core]
[  507.549302]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  507.556469]  nvme_rdma_cm_handler+0x71e/0xa20 [nvme_rdma]
[  507.564436]  ? nvme_rdma_create_queue_ib+0x12c0/0x12c0 [nvme_rdma]
[  507.573293]  ? lock_release+0x42f/0xc90
[  507.579540]  ? lock_downgrade+0x6b0/0x6b0
[  507.585978]  ? lock_is_held_type+0xd9/0x130
[  507.592632]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  507.599879]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  507.606842]  ? lock_is_held_type+0xd9/0x130
[  507.613510]  cma_cm_event_handler+0xf2/0x530 [rdma_cm]
[  507.621292]  addr_handler+0x189/0x2a0 [rdma_cm]
[  507.628405]  ? cma_work_handler+0x220/0x220 [rdma_cm]
[  507.636179]  ? cma_work_handler+0x220/0x220 [rdma_cm]
[  507.643834]  process_one_req+0xdd/0x590 [ib_core]
[  507.651094]  process_one_work+0x97e/0x1700
[  507.657607]  ? pwq_dec_nr_in_flight+0x270/0x270
[  507.664571]  worker_thread+0x87/0xb30
[  507.670501]  ? process_one_work+0x1700/0x1700
[  507.677145]  kthread+0x29d/0x340
[  507.682465]  ? kthread_complete_and_exit+0x20/0x20
[  507.689503]  ret_from_fork+0x22/0x30
[  507.695143]  </TASK>
[  507.699133] irq event stamp: 473271
[  507.704543] hardirqs last  enabled at (473281):
[<ffffffff8b39a9b2>] __up_console_sem+0x52/0x60
[  507.715840] hardirqs last disabled at (473290):
[<ffffffff8b39a997>] __up_console_sem+0x37/0x60
[  507.727102] softirqs last  enabled at (473218):
[<ffffffff8d60064a>] __do_softirq+0x64a/0xa4c
[  507.738185] softirqs last disabled at (473309):
[<ffffffff8b21561e>] irq_exit_rcu+0x1ce/0x240
[  507.749206] ---[ end trace 0000000000000000 ]---
[  507.755780] DMA-API: Mapped at:
[  507.760660]  debug_dma_map_page+0x86/0x320
[  507.766603]  dma_map_page_attrs+0x3bb/0xa90
[  507.772628]  nvme_rdma_create_queue_ib+0x8a6/0x12c0 [nvme_rdma]
[  507.780613]  nvme_rdma_cm_handler+0x71e/0xa20 [nvme_rdma]
[  507.788009]  cma_cm_event_handler+0xf2/0x530 [rdma_cm]
[  508.648545] mlx5_ib0.8008: multicast join failed for
ff12:401b:8008:0000:0000:0000:ffff:ffff, status -22
[  509.655833] nvme nvme0: creating 40 I/O queues.
[  509.672625] mlx5_ib0.8016: multicast join failed for
ff12:401b:8016:0000:0000:0000:ffff:ffff, status -22
[  511.267023] DMA-API: dma_debug_entry pool grown to 2162688 (3300%)
[  520.572519] DMA-API: dma_debug_entry pool grown to 2228224 (3400%)
[  523.451478] nvme nvme0: mapped 40/0/0 default/read/poll queues.
[  523.631836] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.0.202:4420


-- 
Best Regards,
  Yi Zhang

