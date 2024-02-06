Return-Path: <linux-rdma+bounces-934-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717D084BC90
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 18:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49661F24A3F
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Feb 2024 17:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A52BCA4E;
	Tue,  6 Feb 2024 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gilJT2kq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3A9DDCF
	for <linux-rdma@vger.kernel.org>; Tue,  6 Feb 2024 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242104; cv=none; b=Cy7lESESk6s0axqmwfh1Q7DZcSDw6md1qIwX6J544i3RbxsE0yIjDM60z3cpCJZgcsnEAewvaUaZq/zP8+I9fKFJ+3aCk3dKX/x7ljvefsfICgBb8QpILy6vVaeL5JyhADfw9ycDL8Pya2Ql5pkroy5Q5ungPE74UbvlZKz1f4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242104; c=relaxed/simple;
	bh=T2uJDuLlKnMw+soQ+YGpdqkGvLode7wYEUi1KxGmoG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uHN/sOCJy2xXoZ+G0Qz9vnZDh3xm/pqb0uf15nH3FYpCeKQSx64m6dVlzuRSuPd+TWkXcbZAD1XsRFLhhBFUr8UzAv5A1avHfigp3zlj3EIStCDLhfGGZ4TXkdNjUva5bk4FT8pGFbJya5TIAKfZ9sb1ovcnxZJFn+HMwljor+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gilJT2kq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707242101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=11FWwPCLr2L7t6h4jrW8V5tYbwH6Nsg81N1xayKu+nw=;
	b=gilJT2kqaDQsZboOvek2apMcP2F1c/LQhEgTUlP6WDsmhs+FTiprBCUWbwt0PxW6I2iUJR
	EI/wDbddV3ivfm/rlMbfyyyvslLT45wcoG5YRApnQFoRHrg+SJQawMgq1hk0IdXHaEukDT
	ll40mxQ8+XPowfBqptvVpbLnQClhKS8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-_KWojetOOcuSuooxqF8EXg-1; Tue,
 06 Feb 2024 12:54:59 -0500
X-MC-Unique: _KWojetOOcuSuooxqF8EXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 753DC28B698C;
	Tue,  6 Feb 2024 17:54:59 +0000 (UTC)
Received: from fedora-x1.redhat.com (unknown [10.22.33.244])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EF3D0C07F51;
	Tue,  6 Feb 2024 17:54:58 +0000 (UTC)
From: Kamal Heib <kheib@redhat.com>
To: linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Michal Kalderon <mkalderon@marvell.com>,
	Ariel Elior <aelior@marvell.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH for-rc] RDMA/qedr: Fix qedr_create_user_qp error flow
Date: Tue,  6 Feb 2024 12:54:49 -0500
Message-ID: <20240206175449.1778317-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Avoid the following warning by making sure to call qedr_cleanup_user()
in case qedr_init_user_queue() failed.

-----------[ cut here ]-----------
WARNING: CPU: 0 PID: 143192 at drivers/infiniband/core/rdma_core.c:874 uverbs_destroy_ufile_hw+0xcf/0xf0 [ib_uverbs]
Modules linked in: tls target_core_user uio target_core_pscsi target_core_file target_core_iblock ib_srpt ib_srp scsi_transport_srp nfsd nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs 8021q garp mrp stp llc ext4 mbcache jbd2 opa_vnic ib_umad ib_ipoib sunrpc rdma_ucm ib_isert iscsi_target_mod target_core_mod ib_iser libiscsi scsi_transport_iscsi rdma_cm iw_cm ib_cm hfi1 intel_rapl_msr intel_rapl_common mgag200 qedr sb_edac drm_shmem_helper rdmavt x86_pkg_temp_thermal drm_kms_helper intel_powerclamp ib_uverbs coretemp i2c_algo_bit kvm_intel dell_wmi_descriptor ipmi_ssif sparse_keymap kvm ib_core rfkill syscopyarea sysfillrect video sysimgblt irqbypass ipmi_si ipmi_devintf fb_sys_fops rapl iTCO_wdt mxm_wmi iTCO_vendor_support intel_cstate pcspkr dcdbas intel_uncore ipmi_msghandler lpc_ich acpi_power_meter mei_me mei fuse drm xfs libcrc32c qede sd_mod ahci libahci t10_pi sg crct10dif_pclmul crc32_pclmul crc32c_intel qed libata tg3
ghash_clmulni_intel megaraid_sas crc8 wmi [last unloaded: ib_srpt]
CPU: 0 PID: 143192 Comm: fi_rdm_tagged_p Kdump: loaded Not tainted 5.14.0-408.el9.x86_64 #1
Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 2.14.0 01/25/2022
RIP: 0010:uverbs_destroy_ufile_hw+0xcf/0xf0 [ib_uverbs]
Code: 5d 41 5c 41 5d 41 5e e9 0f 26 1b dd 48 89 df e8 67 6a ff ff 49 8b 86 10 01 00 00 48 85 c0 74 9c 4c 89 e7 e8 83 c0 cb dd eb 92 <0f> 0b eb be 0f 0b be 04 00 00 00 48 89 df e8 8e f5 ff ff e9 6d ff
RSP: 0018:ffffb7c6cadfbc60 EFLAGS: 00010286
RAX: ffff8f0889ee3f60 RBX: ffff8f088c1a5200 RCX: 00000000802a0016
RDX: 00000000802a0017 RSI: 0000000000000001 RDI: ffff8f0880042600
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: ffff8f11fffd5000 R11: 0000000000039000 R12: ffff8f0d5b36cd80
R13: ffff8f088c1a5250 R14: ffff8f1206d91000 R15: 0000000000000000
FS: 0000000000000000(0000) GS:ffff8f11d7c00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000147069200e20 CR3: 00000001c7210002 CR4: 00000000001706f0
Call Trace:
<TASK>
? show_trace_log_lvl+0x1c4/0x2df
? show_trace_log_lvl+0x1c4/0x2df
? ib_uverbs_close+0x1f/0xb0 [ib_uverbs]
? uverbs_destroy_ufile_hw+0xcf/0xf0 [ib_uverbs]
? __warn+0x81/0x110
? uverbs_destroy_ufile_hw+0xcf/0xf0 [ib_uverbs]
? report_bug+0x10a/0x140
? handle_bug+0x3c/0x70
? exc_invalid_op+0x14/0x70
? asm_exc_invalid_op+0x16/0x20
? uverbs_destroy_ufile_hw+0xcf/0xf0 [ib_uverbs]
ib_uverbs_close+0x1f/0xb0 [ib_uverbs]
__fput+0x94/0x250
task_work_run+0x5c/0x90
do_exit+0x270/0x4a0
do_group_exit+0x2d/0x90
get_signal+0x87c/0x8c0
arch_do_signal_or_restart+0x25/0x100
? ib_uverbs_ioctl+0xc2/0x110 [ib_uverbs]
exit_to_user_mode_loop+0x9c/0x130
exit_to_user_mode_prepare+0xb6/0x100
syscall_exit_to_user_mode+0x12/0x40
do_syscall_64+0x69/0x90
? syscall_exit_work+0x103/0x130
? syscall_exit_to_user_mode+0x22/0x40
? do_syscall_64+0x69/0x90
? syscall_exit_work+0x103/0x130
? syscall_exit_to_user_mode+0x22/0x40
? do_syscall_64+0x69/0x90
? do_syscall_64+0x69/0x90
? common_interrupt+0x43/0xa0
entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x1470abe3ec6b
Code: Unable to access opcode bytes at RIP 0x1470abe3ec41.
RSP: 002b:00007fff13ce9108 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: fffffffffffffffc RBX: 00007fff13ce9218 RCX: 00001470abe3ec6b
RDX: 00007fff13ce9200 RSI: 00000000c0181b01 RDI: 0000000000000004
RBP: 00007fff13ce91e0 R08: 0000558d9655da10 R09: 0000558d9655dd00
R10: 00007fff13ce95c0 R11: 0000000000000246 R12: 00007fff13ce9358
R13: 0000000000000013 R14: 0000558d9655db50 R15: 00007fff13ce9470
</TASK>
--[ end trace 888a9b92e04c5c97 ]--

Fixes: df15856132bc ("RDMA/qedr: restructure functions that create/destroy QPs")
Signed-off-by: Kamal Heib <kheib@redhat.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 7887a6786ed4..0943abd4de27 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1880,7 +1880,7 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 		rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
 					  ureq.rq_len, true, 0, alloc_and_init);
 		if (rc)
-			return rc;
+			goto err1;
 	}
 
 	memset(&in_params, 0, sizeof(in_params));
-- 
2.43.0


