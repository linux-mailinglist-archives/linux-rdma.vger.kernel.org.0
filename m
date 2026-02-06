Return-Path: <linux-rdma+bounces-16646-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGAQDSrOhWn0GgQAu9opvQ
	(envelope-from <linux-rdma+bounces-16646-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 12:19:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA18BFD1EA
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 12:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C2C0300B44D
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8287F399003;
	Fri,  6 Feb 2026 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R59gNhVS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461222FC876;
	Fri,  6 Feb 2026 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376743; cv=none; b=H4iCZGF1W1hPC4nXQlQp3dBeNZEB/svG7LbhyzHmpiz+Svaw67n7aj32YptVHbE6MWzwyvnQQQ5G9RuezVINUiVU19R0HgpNe9EiaeBonon71abjErcG+yhZFUei52i2ukNsDbd5t9XKA/umW7OameIPItIespxzsOBkn1tckxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376743; c=relaxed/simple;
	bh=wl5BfWgYTseqk1ZgYJBv5Eul62MeNgFDmYdNk0ivSp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HQnYBM1/lBlagpSTBNg43cQiLhjGC9BXhMag83iKmHKa7fAhuos+k8pIl4AGWwUi4cff+CJ7zHXbHqmMnFK0j4GuX2L5etwg1BH4RItSy8d5KuRfnMKNL73FY27iHXaORpRvz8zqMzAYLOs93q74JQ6BaOn2sqeW9t0s8pcD+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R59gNhVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB3EC116C6;
	Fri,  6 Feb 2026 11:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770376742;
	bh=wl5BfWgYTseqk1ZgYJBv5Eul62MeNgFDmYdNk0ivSp0=;
	h=From:Date:Subject:To:Cc:From;
	b=R59gNhVSk5fV9SN/NxX5obrS8vZzFdn6Cd8bv4xAXtJ/0Sl0VAqmj+K8uF2kAWmI6
	 IhbaMqcEiyEd/5S6RqO+YRh1xQebidJdooP9upd5ZGGPjiqZstg4fpmIdtuo/x5wf7
	 u6ocvdOaJO/XB5+hhRioWy6K9HDCly+2Hnn5TimJdlvZq2eaSNAnjgLwdZ28ZOnrvj
	 oNyXjhXr7d5Q68hkQxfLz9VDpmrbmZF3CJDrjttFaKzpqL4I0HAiZxTRxqsRyQ7cd1
	 HBehmMMUWIBlbnIkKiXZlRsicEchPUtBSPKx5St/EENtgjATYwRqqXfWgknYAGMVh1
	 RElyzBcJXIh8g==
From: Simon Horman <horms@kernel.org>
Date: Fri, 06 Feb 2026 11:18:51 +0000
Subject: [PATCH net-next] net/mlx5e: remove declarations of
 mlx5e_shampo_{fill_umr,dealloc_hd}
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-shampo-v1-1-75b20c6657e5@kernel.org>
X-B4-Tracking: v=1; b=H4sIABrOhWkC/x3MQQqAIBBA0avIrBMmo6KuEi1smnIWmWhEEN49a
 fng819IHIUTjOqFyLckOX1BXSkgZ/3OWtZiMGg6NNjp5OwRTl0v1Ax9S2QXhBKHyJs8/2gCz5f
 2/Fww5/wB/F+OF2IAAAA=
X-Change-ID: 20260206-shampo-1bc3975ccab0
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16646-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA18BFD1EA
X-Rspamd-Action: no action

These functions were recently removed by commit 24cf78c73831
("net/mlx5e: SHAMPO, Switch to header memcpy"), however,
their declarations were left behind.

This patch removes those declarations.

Flagged by review-prompts while I was exercising Orc mode locally.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 843f732e4eedb005eba58b9a9ebe48c6703906e5..a7de3a3efc49f6c237ea42b0b932fbe1f5aca847 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1034,8 +1034,6 @@ void mlx5e_build_ptys2ethtool_map(void);
 bool mlx5e_check_fragmented_striding_rq_cap(struct mlx5_core_dev *mdev, u8 page_shift,
 					    enum mlx5e_mpwrq_umr_mode umr_mode);
 
-void mlx5e_shampo_fill_umr(struct mlx5e_rq *rq, int len);
-void mlx5e_shampo_dealloc_hd(struct mlx5e_rq *rq);
 void mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats);
 void mlx5e_fold_sw_stats64(struct mlx5e_priv *priv, struct rtnl_link_stats64 *s);
 




