Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A2029F733
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 22:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJ2Vy1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 17:54:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:29741 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ2Vy1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Oct 2020 17:54:27 -0400
IronPort-SDR: zYJ0/cmW/G0wq7Eg8vdcHkvOX01S0ZGupMrG3yXQ8ulaRs9czxQ7ZZwZL6izW2o8pavduc6Lw1
 SmFGrkBOkjTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="165932569"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="165932569"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 14:54:26 -0700
IronPort-SDR: wkflvBlkfgWI+z6JttE/tnY67RzNSgAuFfXLmdRP4TzF9KCC7Lb9xPYe2bz7jTgBqjhw19Twps
 582CZD7HjN3w==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="469290039"
Received: from ddalessa-mobl.amr.corp.intel.com (HELO [10.254.207.225]) ([10.254.207.225])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 14:54:25 -0700
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: hfi1 broken due to dma_device changes in ib_register
Message-ID: <ad690c34-4260-91a1-d64a-2954a8ae1c54@cornelisnetworks.com>
Date:   Thu, 29 Oct 2020 17:54:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Just a heads up, 5.10-rc1 is broken for rdmavt/hfi1 after:

e0477b34d9d11 "(RDMA: Explicitly pass in the dma_device to 
ib_register_device)"

Running with that change causes the call trace below. Reverting the 
patch works around the problem.  I haven't yet had a chance to look at 
what the actual cause is, but will and follow up with a proposed patch 
hopefully soon.

[   61.331005] ------------[ cut here ]------------
[   61.336590] WARNING: CPU: 0 PID: 155 at kernel/dma/mapping.c:149 
dma_map_page_attrs+0x145/0x1d0
[   61.346735] Modules linked in: rpcrdma ib_isert iscsi_target_mod 
target_core_mod ib_iser libiscsi scsi_transport_iscsi ib_ipoib rdma_ucm 
ib_umad rdma_cm hfi1(+) ib_cm iw_cm rdmavt ib_uverbs ib_core 
rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace nfs_ssc 
fscache sunrpc dm_mirror dm_region_hash dm_log dm_mod iTCO_wdt 
iTCO_vendor_support mxm_wmi sb_edac x86_pkg_temp_thermal 
intel_powerclamp coretemp crct10dif_pclmul mgag200 crc32_pclmul 
i2c_algo_bit ghash_clmulni_intel drm_kms_helper ipmi_si aesni_intel 
syscopyarea crypto_simd sysfillrect sysimgblt ipmi_devintf cryptd 
glue_helper fb_sys_fops pcspkr ipmi_msghandler i2c_i801 drm mei_me sg 
i2c_smbus lpc_ich mei mfd_core i2c_core ioatdma wmi acpi_power_meter 
acpi_pad ip_tables ext4 mbcache jbd2 sd_mod t10_pi crc32c_intel ixgbe 
mdio ahci ptp libahci pps_core dca libata
[   61.431901] CPU: 0 PID: 155 Comm: kworker/0:2 Tainted: G S 
     5.10.0-rc1+ #19
[   61.441572] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS 
SE5C610.86B.01.01.0018.C4.072020161249 07/20/2016
[   61.454087] Workqueue: events work_for_cpu_fn
[   61.459521] RIP: 0010:dma_map_page_attrs+0x145/0x1d0
[   61.465637] Code: 1c 25 28 00 00 00 0f 85 97 00 00 00 48 83 c4 10 5b 
5d 41 5c 41 5d c3 4c 89 da eb d7 48 89 f2 48 2b 50 18 48 89 d0 eb 94 0f 
0b <0f> 0b 48 c7 c0 ff ff ff ff eb c3 48 89 d9 48 8b 40 40 e8 34 95 af
[   61.487826] RSP: 0018:ffffc90006a23b70 EFLAGS: 00010246
[   61.494274] RAX: ffffffff81e25280 RBX: 0000000000000828 RCX: 
0000000000000000
[   61.502874] RDX: 00000000000000b8 RSI: ffffea0004113e00 RDI: 
ffff8881152104e8
[   61.511487] RBP: ffff8881044f8000 R08: 0000000000000002 R09: 
0000000000000000
[   61.520111] R10: 0000000000000002 R11: ffff8881044f8000 R12: 
ffff888106847870
[   61.528743] R13: ffff8881068478a8 R14: ffff8881152104e8 R15: 
0000000000000828
[   61.537387] FS:  0000000000000000(0000) GS:ffff888667a00000(0000) 
knlGS:0000000000000000
[   61.547114] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   61.554230] CR2: 00007f5ed8962248 CR3: 000000000220a004 CR4: 
00000000001706f0
[   61.562913] Call Trace:
[   61.566393]  ib_mad_post_receive_mads+0xd7/0x320 [ib_core]
[   61.573263]  ? _ib_modify_qp+0x310/0x350 [ib_core]
[   61.579360]  ? ib_find_pkey+0x98/0xe0 [ib_core]
[   61.585174]  ib_mad_init_device+0x45f/0x640 [ib_core]
[   61.591579]  add_client_context+0x12b/0x1c0 [ib_core]
[   61.598020]  enable_device_and_get+0xe4/0x1e0 [ib_core]
[   61.604660]  ib_register_device+0x4fb/0x590 [ib_core]
[   61.611109]  ? __vmalloc_node+0x44/0x70
[   61.616211]  rvt_register_device+0x122/0x250 [rdmavt]
[   61.622737]  hfi1_register_ib_device+0x62e/0x6a0 [hfi1]
[   61.629432]  init_one.cold.36+0x284/0x44d [hfi1]
[   61.635418]  local_pci_probe+0x42/0x80
[   61.640428]  work_for_cpu_fn+0x16/0x20
[   61.645434]  process_one_work+0x1aa/0x340
[   61.650732]  ? create_worker+0x1a0/0x1a0
[   61.655931]  worker_thread+0x1cf/0x390
[   61.660934]  ? create_worker+0x1a0/0x1a0
[   61.666126]  kthread+0x116/0x130
[   61.670531]  ? kthread_park+0x80/0x80
[   61.675420]  ret_from_fork+0x22/0x30
[   61.680202] CPU: 0 PID: 155 Comm: kworker/0:2 Tainted: G S 
     5.10.0-rc1+ #19
[   61.690132] Hardware name: Intel Corporation S2600WTT/S2600WTT, BIOS 
SE5C610.86B.01.01.0018.C4.072020161249 07/20/2016
[   61.702892] Workqueue: events work_for_cpu_fn
[   61.708565] Call Trace:
[   61.712091]  dump_stack+0x6d/0x88
[   61.716566]  __warn.cold.14+0xe/0x3d
[   61.721309]  ? dma_map_page_attrs+0x145/0x1d0
[   61.726907]  report_bug+0xbd/0xf0
[   61.731319]  handle_bug+0x3c/0x90
[   61.735706]  exc_invalid_op+0x13/0x60
[   61.740460]  asm_exc_invalid_op+0x12/0x20
[   61.745579] RIP: 0010:dma_map_page_attrs+0x145/0x1d0
[   61.751758] Code: 1c 25 28 00 00 00 0f 85 97 00 00 00 48 83 c4 10 5b 
5d 41 5c 41 5d c3 4c 89 da eb d7 48 89 f2 48 2b 50 18 48 89 d0 eb 94 0f 
0b <0f> 0b 48 c7 c0 ff ff ff ff eb c3 48 89 d9 48 8b 40 40 e8 34 95 af
[   61.774015] RSP: 0018:ffffc90006a23b70 EFLAGS: 00010246
[   61.780496] RAX: ffffffff81e25280 RBX: 0000000000000828 RCX: 
0000000000000000
[   61.789103] RDX: 00000000000000b8 RSI: ffffea0004113e00 RDI: 
ffff8881152104e8
[   61.797689] RBP: ffff8881044f8000 R08: 0000000000000002 R09: 
0000000000000000
[   61.806278] R10: 0000000000000002 R11: ffff8881044f8000 R12: 
ffff888106847870
[   61.814868] R13: ffff8881068478a8 R14: ffff8881152104e8 R15: 
0000000000000828
[   61.823461]  ib_mad_post_receive_mads+0xd7/0x320 [ib_core]
[   61.830214]  ? _ib_modify_qp+0x310/0x350 [ib_core]
[   61.836184]  ? ib_find_pkey+0x98/0xe0 [ib_core]
[   61.841866]  ib_mad_init_device+0x45f/0x640 [ib_core]
[   61.848110]  add_client_context+0x12b/0x1c0 [ib_core]
[   61.854354]  enable_device_and_get+0xe4/0x1e0 [ib_core]
[   61.860789]  ib_register_device+0x4fb/0x590 [ib_core]
[   61.867015]  ? __vmalloc_node+0x44/0x70
[   61.871881]  rvt_register_device+0x122/0x250 [rdmavt]
[   61.878133]  hfi1_register_ib_device+0x62e/0x6a0 [hfi1]
[   61.884585]  init_one.cold.36+0x284/0x44d [hfi1]
[   61.890328]  local_pci_probe+0x42/0x80
[   61.895099]  work_for_cpu_fn+0x16/0x20
[   61.899864]  process_one_work+0x1aa/0x340
[   61.904919]  ? create_worker+0x1a0/0x1a0
[   61.909874]  worker_thread+0x1cf/0x390
[   61.914631]  ? create_worker+0x1a0/0x1a0
[   61.919580]  kthread+0x116/0x130
[   61.923747]  ? kthread_park+0x80/0x80
[   61.928397]  ret_from_fork+0x22/0x30
[   61.932956] ---[ end trace b9195d1a0ae0f872 ]---

-Denny
