Return-Path: <linux-rdma+bounces-21937-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m0oAOTZOJmppUgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21937-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 07:08:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F648652B2E
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 07:08:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=p6Bv0wIY;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21937-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21937-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6301C300A4F0
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 05:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFB7352009;
	Mon,  8 Jun 2026 05:07:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9232E1C4E
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 05:07:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895279; cv=none; b=GYZy9vQQy+JC+8oiAPnNbUBExv8waGzxxZkChalZmPaVTcQ4XvX64Yg651ypH1vpq3Wzp+CtRXo8VToC89264AuM9KK32oACQCLuAM9fQgZf+Vgw1jvVYEQyjpERPavy0xlJZTWWMpczKfAKGwXniJdRpZpVtnWCJPkpSjwxjM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895279; c=relaxed/simple;
	bh=gugkmva3QX6dkfY5P+qeMowJEWEfTmHC7GSPBbnxQwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pt8iptCzrz+jQ3paXvCC7H5SXc3jGP/DUDpqH9Z87r+rgkK+ONjBSc+5qfozrtHL7jbRu3aFYmBBpxqOz8H1IFFryvOvJf02U81VSm5fmnUU/KdcQyXDJnp213wMgFv8poHdur91/oR6rCMOxZS7N+gsBgmBJf/Z3zuxRRnMo7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p6Bv0wIY; arc=none smtp.client-ip=91.218.175.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780895275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+DT/6+9d3Y7kivgMuLl9sU5JzLkE5jVP+zBhYgRYvA4=;
	b=p6Bv0wIYx0UV9XrPP6IAi6BXjK9YLOKHZuAY4fKv/HcqtgwVj7UElgCiHZWON7L3r7XIOW
	kJ88kueZATUnF86/tsiHdmNzSzNKDhnfCc5Ykn6P3StcAqlhexclBjkKvQegDhq3KzdmMu
	7ssv+owLsjY0h1LJjdc+b99Ju7YPawA=
From: Tao Cui <cui.tao@linux.dev>
To: leon@kernel.org,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next] RDMA/mlx5: Fix NULL pointer dereference on INTEGRITY MR dereg retry
Date: Mon,  8 Jun 2026 13:07:45 +0800
Message-ID: <20260608050745.2715590-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21937-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:from_mime,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F648652B2E

From: Tao Cui <cuitao@kylinos.cn>

In __mlx5_ib_dereg_mr(), the INTEGRITY MR cleanup block destroys PSVs
and frees mr->sig before calling mlx5r_handle_mkey_cleanup(). If the
mkey destroy fails and the function is retried, mr->sig is already
NULL but the PSV destroy code dereferences it unconditionally.

Add a NULL check on mr->sig to guard the PSV destroy and kfree block,
making the retry path safe. This is consistent with the existing NULL
checks on mr->mtt_mr and mr->klm_mr in the same cleanup block.

Fixes: e6fb246ccafb ("RDMA/mlx5: Consolidate MR destruction to mlx5_ib_dereg_mr()")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/infiniband/hw/mlx5/mr.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 254e6aa4ccaf..3b5216752017 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1436,15 +1436,18 @@ static int __mlx5_ib_dereg_mr(struct ib_mr *ibmr)
 			mr->klm_mr = NULL;
 		}
 
-		if (mlx5_core_destroy_psv(dev->mdev,
-					  mr->sig->psv_memory.psv_idx))
-			mlx5_ib_warn(dev, "failed to destroy mem psv %d\n",
-				     mr->sig->psv_memory.psv_idx);
-		if (mlx5_core_destroy_psv(dev->mdev, mr->sig->psv_wire.psv_idx))
-			mlx5_ib_warn(dev, "failed to destroy wire psv %d\n",
-				     mr->sig->psv_wire.psv_idx);
-		kfree(mr->sig);
-		mr->sig = NULL;
+		if (mr->sig) {
+			if (mlx5_core_destroy_psv(dev->mdev,
+						  mr->sig->psv_memory.psv_idx))
+				mlx5_ib_warn(dev, "failed to destroy mem psv %d\n",
+					     mr->sig->psv_memory.psv_idx);
+			if (mlx5_core_destroy_psv(dev->mdev,
+						  mr->sig->psv_wire.psv_idx))
+				mlx5_ib_warn(dev, "failed to destroy wire psv %d\n",
+					     mr->sig->psv_wire.psv_idx);
+			kfree(mr->sig);
+			mr->sig = NULL;
+		}
 	}
 
 	/* Stop DMA */
-- 
2.43.0


