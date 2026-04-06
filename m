Return-Path: <linux-rdma+bounces-19034-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMtlFja102nLkgcAu9opvQ
	(envelope-from <linux-rdma+bounces-19034-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 15:29:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DFA3A38AE
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 15:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F7563009381
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AE372B3D;
	Mon,  6 Apr 2026 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HaWbwc+J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0826372EC5
	for <linux-rdma@vger.kernel.org>; Mon,  6 Apr 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482142; cv=none; b=SIW5Cb5ZXMVSb4hoBRIvrlTOFKOd/XVx+8AE534aMn18GSjW3KkKd1hWq++sW3sNhizBoyxwXbPch4DqsrcEN4cm3Lg5WMzyF47z/FpashSF2hxys9BGKkyUcplJHWwLNLLPqTHC87qO4nhLDtk8r//rLvvAUD0hzGihpZhESE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482142; c=relaxed/simple;
	bh=Ha8MhQXEzBEMq7mU9gwl6pNkOyFU4MXYfWIiPZxkUZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUWSS/azrxo5Bj+pO6Mezbm/VZI8OXfbqScxcd/pXrgK9r2qh1g8JRIGiveshNpB2jwzW+fW+dQOOIeLJFGSLPenaRCF3O0aoQo0tvMWt8LMi2J/1etW8fbkRdzUyYmtqB8poFPAS7rcv9wQxW+fWMLOB3Q/NhD6U71e3vcq8QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HaWbwc+J; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775482138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNtIUnZjrPQLnnsG3IaHRIZXfItDLqjxegoUagyMnos=;
	b=HaWbwc+JYBMksDSJvimj302IRTdp9frDJgPpRboIACt46VqgM+qeP2XAzVy1RhOkTSseEk
	o83DoHA9K7CRPglnN5rVQ5vdlwDUltmDF7DBAFRf4FLWgszmEfdNrlDqnt01dJR/zKXyyf
	RmVvNqr/W2QuOEeIk/dQ8tkijWG3lhs=
From: zhenwei pi <zhenwei.pi@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PATCH v4 1/4] RDMA/core: Fix memory free for GID table
Date: Mon,  6 Apr 2026 21:28:26 +0800
Message-ID: <20260406132830.435381-2-zhenwei.pi@linux.dev>
In-Reply-To: <20260406132830.435381-1-zhenwei.pi@linux.dev>
References: <20260406132830.435381-1-zhenwei.pi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19034-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenwei.pi@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54DFA3A38AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove RXE device, kernel shows:
RIP: 0010:free_large_kmalloc+0xf6/0x140
Code: 75 28 0f 0b 44 0f b6 2d a5 d6 d1 01 41 80 fd 01 0f 87 7c d1 ad ff 41 83 e5 01 74 3d 41 bc 00 f0 ff ff 45 31 ed e9 61 ff ff ff <0f> 0b 48 c7 c6 af b1 70 83 48 89 df e8 79 0a fa ff 5b 41 5c 41 5d
RSP: 0018:ffffd038c18074d8 EFLAGS: 00010293
RAX: 0017ffffc0000000 RBX: fffff86984219d00 RCX: 0000000000000000
RDX: 00000000000000f0 RSI: ffff899b88674000 RDI: fffff86984219d00
RBP: ffffd038c18074f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff899b88674000
R13: 0000000000000001 R14: ffff899b88674000 R15: ffff899b86180000
FS:  00007b163c71c740(0000) GS:ffff899c378bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007b163c730200 CR3: 0000000106a1d000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 kfree+0x163/0x3a0
 gid_table_release_one+0xaf/0xf0 [ib_core]
 ib_cache_release_one+0x66/0x80 [ib_core]
 ib_device_release+0x48/0xb0 [ib_core]
 device_release+0x44/0xa0
 kobject_put+0x9b/0x250
 put_device+0x13/0x30
 ib_unregister_device_and_put+0x40/0x60 [ib_core]
 nldev_dellink+0xd3/0x140 [ib_core]
 rdma_nl_rcv_msg+0x11d/0x300 [ib_core]
 ? netlink_bind+0x141/0x3a0
 rdma_nl_rcv_skb.constprop.0.isra.0+0xba/0x110 [ib_core]
 rdma_nl_rcv+0xe/0x20 [ib_core]
 netlink_unicast+0x28d/0x3e0
 netlink_sendmsg+0x214/0x470
 __sys_sendto+0x21f/0x230
 __x64_sys_sendto+0x24/0x40
 x64_sys_call+0x1888/0x26e0
 do_syscall_64+0xcb/0x14d0
 ? _copy_from_user+0x27/0x70
 ? do_sock_setsockopt+0xbd/0x190
 ? __sys_setsockopt+0x72/0xd0
 ? __x64_sys_setsockopt+0x1f/0x40
 ? x64_sys_call+0x221b/0x26e0
 ? do_syscall_64+0x109/0x14d0
 ? exc_page_fault+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

GID table is allocated by *kzalloc_flex* instead of raw *kzalloc_obj*,
it also should be released in new style.

Fixes: 74e2711bb2af ("RDMA/core: Use kzalloc_flex for GID table")
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
---
 drivers/infiniband/core/cache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 896486fa6185..647a547e2d7f 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -801,7 +801,6 @@ static void release_gid_table(struct ib_device *device,
 	}
 
 	mutex_destroy(&table->lock);
-	kfree(table->data_vec);
 	kfree(table);
 }
 
-- 
2.43.0


