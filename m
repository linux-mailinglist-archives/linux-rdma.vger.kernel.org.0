Return-Path: <linux-rdma+bounces-18837-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEvGA4u9y2kwKwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18837-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 14:26:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67106369746
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 14:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 547BD3023314
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFC33E1CF1;
	Tue, 31 Mar 2026 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="cz/Qtj9y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (jpmx.baidu.com [119.63.196.201])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 1D1A43E0C77;
	Tue, 31 Mar 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.63.196.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959986; cv=none; b=Cnmh9sfew1m7/JsCBkApotl6CWalSMF/9c+etbdziarubyCsnrTIcW31OCgCKZ3MA2hTj6D854oCo8Q4P8fQXSUFx8ANnSP1sF1B9nAW+qGdsE2YsBa2Kb6lBlSRDI/rXkAau4hEizz91fCUVdbe0AAoulQ0VVyER78/KFnDax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959986; c=relaxed/simple;
	bh=pCJYj+yIsvTQfbdDJAagLaKC2zgC2vgl8J602FoyfD8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u5lzNNVprq1Mp66CAmDUFaaEWCZCsoqmDCIpxVRddGW2Ad8JiCoqmDUExOa1zwiDtW1CdUjVgcRZamrx3Z0er+29VzRi7djXeRUvPcwQFJ7Tfa9BagtUTaUxMJzXkD0X29K17kMbNAkIjlRLMZzYpo67bpwtKpXKmCox6sBJ8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=cz/Qtj9y; arc=none smtp.client-ip=119.63.196.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Li RongQing <lirongqing@baidu.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH][net-next] net/mlx5: Move command entry freeing outside of spinlock
Date: Tue, 31 Mar 2026 08:26:04 -0400
Message-ID: <20260331122604.1933-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc3.internal.baidu.com (172.31.3.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1774959976;
	bh=ecjXzqLRA55slfTGCO4Yrp8OrmKK3TGwSqxDk6NDAvs=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=cz/Qtj9yCU/Rr0n+t7AprtHKdLgZq5YgoiAhxeRJAZa5IyVZNXK2jmHyN5oNounS7
	 XN4Ux5p6GhkvE2eCm4a8APzLBsn/H56/3QtSkK7nnpvrirJZsBCyJr3Kik5RAhj75Q
	 frf0411NGiW+guVzWf8qUmTavUS6LXy51ckDytkY2QdluOzgGjFsz03rQafynfgdiT
	 8m6gQppRWE5yRSofbq8XHK2vwSth2ekR1SNvIVPwJAM6YX1n7AwJN2RM2sk+RgbP4C
	 oIy9aIwnjjBIGEyK5ct1mMY3mYasNgtZudvEmkOahZMsTqSHjKepL5/OxV3bHcvFrI
	 3hbNlx/zTp4Wg==
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[baidu.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[baidu.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-18837-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baidu.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67106369746
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Li RongQing <lirongqing@baidu.com>

Move the kfree() call outside the critical section to reduce lock
holding time. This aligns with the general principle of minimizing
work under locks.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 6c99c7f..c89417c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -196,17 +196,18 @@ static void cmd_ent_put(struct mlx5_cmd_work_ent *ent)
 	unsigned long flags;
 
 	spin_lock_irqsave(&cmd->alloc_lock, flags);
-	if (!refcount_dec_and_test(&ent->refcnt))
-		goto out;
+	if (!refcount_dec_and_test(&ent->refcnt)) {
+		spin_unlock_irqrestore(&cmd->alloc_lock, flags);
+		return;
+	}
 
 	if (ent->idx >= 0) {
 		cmd_free_index(cmd, ent->idx);
 		up(ent->page_queue ? &cmd->vars.pages_sem : &cmd->vars.sem);
 	}
+	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 
 	cmd_free_ent(ent);
-out:
-	spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 }
 
 static struct mlx5_cmd_layout *get_inst(struct mlx5_cmd *cmd, int idx)
-- 
2.9.4


