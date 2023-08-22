Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0981B7842B5
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjHVOBk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjHVOBj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B5E1B2;
        Tue, 22 Aug 2023 07:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B572062021;
        Tue, 22 Aug 2023 14:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E665C433C7;
        Tue, 22 Aug 2023 14:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692712896;
        bh=essh1gfmzZMr9fWQLfaMC1kG/YtIJOrMUVcfGQ40p5c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Pv02/vIZ1XyZ7AgAZnniFzHpfkt4XK996/olNqCeySelNrElyGcpKMHg4kJPbZtOm
         k7g+hHAT5LGSskxTkPLGEKTifSXHKZZtz6t4Ts/Z6do/x1pPEl9l7he+JztCanq5uu
         0QN0DgzFgRd4KWdI+r/f1Q0leE2tQR33YXP7PRUPyo8v5Ga7k70z16XRFyNWGgnzpd
         oxgMA2bNdw6EmKrSkLC3A3LUjeF3MkOx01kL+foepznOPyHhlYwG+agtN6rArbhnLQ
         +ENpRZ2SOtCrXh4ZWAkamh9t01uvXxw1lrWRGmA8AxSvmJWM0ziE9ChMjf1OycJI/r
         iRrGzGhGT/2Fg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        target-devel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <a27982d3235005c58f6d321f3fad5eb6e1beaf9e.1692604607.git.leonro@nvidia.com>
References: <a27982d3235005c58f6d321f3fad5eb6e1beaf9e.1692604607.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next] Revert "IB/isert: Fix incorrect release of
 isert connection"
Message-Id: <169271289280.21405.15379209163849066033.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:01:32 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 21 Aug 2023 10:57:14 +0300, Leon Romanovsky wrote:
> Commit: 699826f4e30a ("IB/isert: Fix incorrect release of isert connection") is
> causing problems on OPA when DEVICE_REMOVAL is happening.
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 52 PID: 2117247 at drivers/infiniband/core/cq.c:359
> ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
>  Modules linked in: nfsd nfs_acl target_core_user uio tcm_fc libfc
> scsi_transport_fc tcm_loop target_core_pscsi target_core_iblock target_core_file
> rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs
> rfkill rpcrdma rdma_ucm ib_srpt sunrpc ib_isert iscsi_target_mod target_core_mod
> opa_vnic ib_iser libiscsi ib_umad scsi_transport_iscsi rdma_cm ib_ipoib iw_cm
> ib_cm hfi1(-) rdmavt ib_uverbs intel_rapl_msr intel_rapl_common sb_edac ib_core
> x86_pkg_temp_thermal intel_powerclamp coretemp i2c_i801 mxm_wmi rapl iTCO_wdt
> ipmi_si iTCO_vendor_support mei_me ipmi_devintf mei intel_cstate ioatdma
> intel_uncore i2c_smbus joydev pcspkr lpc_ich ipmi_msghandler acpi_power_meter
> acpi_pad xfs libcrc32c sr_mod sd_mod cdrom t10_pi sg crct10dif_pclmul
> crc32_pclmul crc32c_intel drm_kms_helper drm_shmem_helper ahci libahci
> ghash_clmulni_intel igb drm libata dca i2c_algo_bit wmi fuse
>  CPU: 52 PID: 2117247 Comm: modprobe Not tainted 6.5.0-rc1+ #1
>  Hardware name: Intel Corporation S2600CWR/S2600CW, BIOS
> SE5C610.86B.01.01.0014.121820151719 12/18/2015
>  RIP: 0010:ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
>  Code: ff 48 8b 43 40 48 8d 7b 40 48 83 e8 40 4c 39 e7 75 b3 49 83
> c4 10 4d 39 fc 75 94 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc <0f> 0b eb a1
> 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f
>  RSP: 0018:ffffc10bea13fc80 EFLAGS: 00010206
>  RAX: 000000000000010c RBX: ffff9bf5c7e66c00 RCX: 000000008020001d
>  RDX: 000000008020001e RSI: fffff175221f9900 RDI: ffff9bf5c7e67640
>  RBP: ffff9bf5c7e67600 R08: ffff9bf5c7e64400 R09: 000000008020001d
>  R10: 0000000040000000 R11: 0000000000000000 R12: ffff9bee4b1e8a18
>  R13: dead000000000122 R14: dead000000000100 R15: ffff9bee4b1e8a38
>  FS:  00007ff1e6d38740(0000) GS:ffff9bfd9fb00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00005652044ecc68 CR3: 0000000889b5c005 CR4: 00000000001706e0
>  Call Trace:
>   <TASK>
>   ? __warn+0x80/0x130
>   ? ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
>   ? report_bug+0x195/0x1a0
>   ? handle_bug+0x3c/0x70
>   ? exc_invalid_op+0x14/0x70
>   ? asm_exc_invalid_op+0x16/0x20
>   ? ib_cq_pool_cleanup+0xac/0xb0 [ib_core]
>   disable_device+0x9d/0x160 [ib_core]
>   __ib_unregister_device+0x42/0xb0 [ib_core]
>   ib_unregister_device+0x22/0x30 [ib_core]
>   rvt_unregister_device+0x20/0x90 [rdmavt]
>   hfi1_unregister_ib_device+0x16/0xf0 [hfi1]
>   remove_one+0x55/0x1a0 [hfi1]
>   pci_device_remove+0x36/0xa0
>   device_release_driver_internal+0x193/0x200
>   driver_detach+0x44/0x90
>   bus_remove_driver+0x69/0xf0
>   pci_unregister_driver+0x2a/0xb0
>   hfi1_mod_cleanup+0xc/0x3c [hfi1]
>   __do_sys_delete_module.constprop.0+0x17a/0x2f0
>   ? exit_to_user_mode_prepare+0xc4/0xd0
>   ? syscall_trace_enter.constprop.0+0x126/0x1a0
>   do_syscall_64+0x5c/0x90
>   ? syscall_exit_to_user_mode+0x12/0x30
>   ? do_syscall_64+0x69/0x90
>   ? syscall_exit_work+0x103/0x130
>   ? syscall_exit_to_user_mode+0x12/0x30
>   ? do_syscall_64+0x69/0x90
>   ? exc_page_fault+0x65/0x150
>   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>  RIP: 0033:0x7ff1e643f5ab
>  Code: 73 01 c3 48 8b 0d 75 a8 1b 00 f7 d8 64 89 01 48 83 c8 ff c3
> 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0
> ff ff 73 01 c3 48 8b 0d 45 a8 1b 00 f7 d8 64 89 01 48
>  RSP: 002b:00007ffec9103cc8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>  RAX: ffffffffffffffda RBX: 00005615267fdc50 RCX: 00007ff1e643f5ab
>  RDX: 0000000000000000 RSI: 0000000000000800 RDI: 00005615267fdcb8
>  RBP: 00005615267fdc50 R08: 0000000000000000 R09: 0000000000000000
>  R10: 00007ff1e659eac0 R11: 0000000000000206 R12: 00005615267fdcb8
>  R13: 0000000000000000 R14: 00005615267fdcb8 R15: 00007ffec9105ff8
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied, thanks!

[1/1] Revert "IB/isert: Fix incorrect release of isert connection"
      https://git.kernel.org/rdma/rdma/c/dfe261107c0807

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
