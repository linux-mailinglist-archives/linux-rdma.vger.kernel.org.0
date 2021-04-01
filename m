Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434D0350C7F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 04:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhDACTQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 22:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230284AbhDACS7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Mar 2021 22:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617243539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=uGHycMZOsGzCQrxJb24nQYOzqF03RJshIL6JzhAKhdM=;
        b=Xdbo1p0jm1t6FRf+y/Y6NZg4ymt6l6Lku44nQlsnCAbvbmOpoCkI2W2E3/sI+p4UEIlCiy
        h4J5YH56wCzMudD3epmhH6j/RK7o4jaXerNIwkrLPp7U4JUb99N4jaZpEbEtkaM9XsJxL4
        B/dK8z7X/6tYr2RE/T4QpKuywcTb7zs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-k64kZnFdMWuCTy9GWO1vXQ-1; Wed, 31 Mar 2021 22:18:56 -0400
X-MC-Unique: k64kZnFdMWuCTy9GWO1vXQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4507817476;
        Thu,  1 Apr 2021 02:18:55 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D1DF5D72F;
        Thu,  1 Apr 2021 02:18:55 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 929A21809C81;
        Thu,  1 Apr 2021 02:18:55 +0000 (UTC)
Date:   Wed, 31 Mar 2021 22:18:55 -0400 (EDT)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Bart Van Assche <bvanassche@acm.org>
Message-ID: <76827202.1204697.1617243535445.JavaMail.zimbra@redhat.com>
In-Reply-To: <437391804.1204407.1617243001994.JavaMail.zimbra@redhat.com>
Subject: [bug report]kernel NULL pointer at siw_tx_hdt+0x128/0x978 [siw]
 with blktests nvmeof-mp/002
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.8]
Thread-Topic: kernel NULL pointer at siw_tx_hdt+0x128/0x978 [siw] with blktests nvmeof-mp/002
Thread-Index: PwQEC1IPu98voOrcu4/ruwbv3S2gwQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello

I reproduced this issue with blktests nvmeof-mp/002 on 5.12.0-rc5 aarch64, pls help check it and let me know if you need any testing for it, thanks. 

[18381.922840] run blktests nvmeof-mp/002 at 2021-03-31 20:42:40
[18382.123208] null_blk: module loaded
[18382.345093] SoftiWARP attached
[18382.507549] nvmet: adding nsid 1 to subsystem nvme-test
[18382.536043] iwpm_register_pid: Unable to send a nlmsg (client = 2)
[18382.542985] nvmet_rdma: enabling port 1 (10.19.241.109:7777)
[18382.703578] nvmet: creating controller 1 for subsystem nvme-test for NQN nqn.2014-08.org.nvmexpress:uuid:a6ba6b82-f083-4df3-9ee2-cd3f635a8418.
[18382.717201] nvme nvme0: creating 32 I/O queues.
[18382.751581] nvme nvme0: mapped 32/0/0 default/read/poll queues.
[18382.768935] nvme nvme0: new ctrl: NQN "nvme-test", addr 10.19.241.109:7777
[18382.811275] device-mapper: multipath service-time: version 0.3.0 loaded
[18383.611572] EXT4-fs (dm-3): mounted filesystem without journal. Opts: (null). Quota mode: none.
[18383.620343] ext4 filesystem being mounted at /root/blktests/results/tmpdir.nvmeof-mp.002.pnM/mnt0 supports timestamps until 2038 (0x7fffffff)
[18411.156005] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
[18411.156046] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
[18411.164790] Mem abort info:
[18411.173564] Mem abort info:
[18411.173565]   ESR = 0x96000006
[18411.173567]   EC = 0x25: DABT (current EL), IL = 32 bits
[18411.173569]   SET = 0, FnV = 0
[18411.176349]   ESR = 0x96000006
[18411.179129]   EA = 0, S1PTW = 0
[18411.182170]   EC = 0x25: DABT (current EL), IL = 32 bits
[18411.187473] Data abort info:
[18411.190513]   SET = 0, FnV = 0
[18411.193558]   ISV = 0, ISS = 0x00000006
[18411.196685]   EA = 0, S1PTW = 0
[18411.201982]   CM = 0, WnR = 0
[18411.204853] Data abort info:
[18411.207893] user pgtable: 64k pages, 42-bit VAs, pgdp=00000009c33b0000
[18411.211714]   ISV = 0, ISS = 0x00000006
[18411.214846] [0000000000000030] pgd=0000000000000000
[18411.217800]   CM = 0, WnR = 0
[18411.220666] , p4d=0000000000000000
[18411.227184] user pgtable: 64k pages, 42-bit VAs, pgdp=00000009c33b0000
[18411.231005] , pud=0000000000000000
[18411.235873] [0000000000000030] pgd=0000000000000000
[18411.238826] , pmd=0000000000000000
[18411.242214] , p4d=0000000000000000
[18411.248733] 
[18411.252120] , pud=0000000000000000
[18411.256990] Internal error: Oops: 96000006 [#1] SMP
[18411.260376] , pmd=0000000000000000
[18411.263764] Modules linked in: ext4 mbcache jbd2 dm_service_time nvme_rdma
[18411.265247] 
[18411.268634]  nvme_fabrics nvme nvmet_rdma nvmet siw null_blk dm_multipath nvme_core rfkill rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_target_mod ib_umad target_core_mod vfat fat ib_iser ib_ipoib libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm mlx4_ib ib_uverbs ib_core acpi_ipmi crct10dif_ce ghash_ce ipmi_ssif sha1_ce sbsa_gwdt ipmi_devintf ipmi_msghandler xgene_hwmon ip_tables xfs libcrc32c mlx4_en sr_mod cdrom sg ast drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_ttm_helper ttm drm mlx4_core igb sha2_ce sha256_arm64 i2c_designware_platform ahci_platform i2c_algo_bit i2c_designware_core gpio_dwapb libahci_platform i2c_xgene_slimpro uas usb_storage dm_mirror dm_region_hash dm_log dm_mod [last unloaded: nvme_core]
[18411.351792] CPU: 13 PID: 19581 Comm: siw_tx/13 Not tainted 5.12.0-rc5 #1
[18411.368293] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[18411.374287] pc : siw_tx_hdt+0x128/0x978 [siw]
[18411.378641] lr : siw_qp_sq_process+0xc4/0xa80 [siw]
[18411.383512] sp : fffffe001acafa90
[18411.386813] x29: fffffe001acafa90 x28: fffffc083f9a4238 
[18411.392114] x27: 0000000000000003 x26: 000000000000ef70 
[18411.397414] x25: 0000000000000003 x24: 0000000000000000 
[18411.402714] x23: 0000000000000000 x22: 0000000000000000 
[18411.408014] x21: fffffc083f9a4270 x20: fffffc083f9a41c8 
[18411.413313] x19: 0000000000000000 x18: 0000000000000000 
[18411.418612] x17: 0000000000000000 x16: 0000000000000000 
[18411.423912] x15: 0000000000000000 x14: 0000000000000000 
[18411.429211] x13: b6f8a80000001000 x12: fffffc093fe37000 
[18411.434511] x11: b6f8a80000000040 x10: 0000000000000001 
[18411.439810] x9 : 0000000000000000 x8 : 0000000000000000 
[18411.445110] x7 : 0000000000000014 x6 : 000000000000ffc8 
[18411.450409] x5 : fffffc083f9a4238 x4 : fffffe001acafc40 
[18411.455709] x3 : 0000000000000020 x2 : fffffc083f9a4238 
[18411.461009] x1 : fffffc083f9a4248 x0 : 0000000000000000 
[18411.466309] Call trace:
[18411.468743]  siw_tx_hdt+0x128/0x978 [siw]
[18411.472746]  siw_qp_sq_process+0xc4/0xa80 [siw]
[18411.477270]  siw_sq_resume+0x48/0x168 [siw]
[18411.481446]  siw_run_sq+0xc8/0x290 [siw]
[18411.485362]  kthread+0x114/0x118
[18411.488580]  ret_from_fork+0x10/0x18
[18411.492146] Code: 370800c1 f9403fe1 8b214c41 f9403c37 (f9401ae1) 
[18411.498237] ---[ end trace 67f55110d28671a3 ]---
[18411.502842] Kernel panic - not syncing: Oops: Fatal exception
[18411.508580] SMP: stopping secondary CPUs
[18412.537491] SMP: failed to stop secondary CPUs 11,13
[18412.542445] Kernel Offset: disabled
[18412.545920] CPU features: 0x00240002,61802008
[18412.550264] Memory Limit: none
[18412.553311] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---


Best Regards,
  Yi Zhang


