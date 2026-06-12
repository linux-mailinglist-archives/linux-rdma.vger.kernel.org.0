Return-Path: <linux-rdma+bounces-22184-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uFYYBRdpLGpGQgQAu9opvQ
	(envelope-from <linux-rdma+bounces-22184-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 22:16:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5828267C3FB
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 22:16:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=UxeVAoLK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22184-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22184-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EDC03026169
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 20:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B78F3B83E0;
	Fri, 12 Jun 2026 20:16:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381F0346AC4;
	Fri, 12 Jun 2026 20:16:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781295376; cv=none; b=knraji0sKAivvRg4lrsWlikTZriuW7P0i038Q62ZkymaSZt6y0WFseh0Ps2wuhf1/i7BZwUGBIeVzvfAImOK855IJ+SDPAFJSqHY87Ko1DljaUFXvY59qFfQ5HqqMUgHAG1patb+9/OSjjuwhUskhPGV2zWeSptM9WR4OEJxYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781295376; c=relaxed/simple;
	bh=HEVvnUHz+ElwnNN03w8VODJ4A0gPtm8Ueqtx+ckSyj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U2uYx4eQRq+wO7kzBRbcKyBYP/9zfiI7zftwGO8lXFyTz2aOG6LVEE0UREzrmH3VTXHDMon9QXI4cWYCKH5h1KeI6bOwyOWUCKFKByzmQQQSGm3K9+GBa/9F0ncxwNqJq7x4CkL7d0HbZoparvKjbo9r6v7iRbEvMm3anb/qkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxeVAoLK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9131F000E9;
	Fri, 12 Jun 2026 20:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781295374;
	bh=D8VYR55FPfcLqtvHNW5sRMi7TqOpjWGafJVkcnlztgY=;
	h=From:To:Cc:Subject:Date;
	b=UxeVAoLKjXr4G19OLuvR+PdGjg1i81M9t1M8OciMtcEL/QPHLujw+mgarj8Bp4QNm
	 WQLRtKybNQrBy/KLLv/hx3gXjiobjZRrwtPD7/Ave9uAOYRhsP730ZiMHwLGuT/RNZ
	 7B0XGawbu/oIYvMq1aDbyfpc1B1sOm7EieE/VzB56VY8sv4HAD8Vf/60YPpMsKMpF4
	 RHJEmfRi3kG5SloAe9LEK5v4d0iFyKXEVu9msmsLoyJJ54TzXUplIPN+KWq0NQcEIQ
	 io6PIfPkhSS5WLcBQqmQnMZCiP8Oukd5tR/hkPgUBm9FtNcvwbcjOILfpr+pDOxh8B
	 DHlKljhRUDu4A==
From: Arnd Bergmann <arnd@kernel.org>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mlx5: avoid frame overflow warning
Date: Fri, 12 Jun 2026 22:15:59 +0200
Message-Id: <20260612201611.4127750-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22184-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:arnd@arndb.de,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[arnd@kernel.org,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5828267C3FB

From: Arnd Bergmann <arnd@arndb.de>

Building mlx5 on s390 shows a rather high stack usage that can exceed
the warning limit when that is set to a lower but still reasonable value:

drivers/infiniband/hw/mlx5/wr.c:1051:5: error: stack frame size (1328) exceeds limit (1280) in 'mlx5_ib_post_send' [-Werror,-Wframe-larger-than]

The problem here is 'struct ib_reg_wr' on the stack of
handle_reg_mr_integrity(), which gets inlined into mlx5_ib_post_send()
along with a number of smaller functions.

Keeping the inner function out of line like gcc does avoids the
warning and reduces the total stack usage in other functions called
from mlx5_ib_post_send(), though handle_reg_mr_integrity() itself
still has the same problem as before.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Dynamically allocating ib_reg_wr would be another option, actually
reducing the stack usage but adding a little bit of complexity
from error handling.
---
 drivers/infiniband/hw/mlx5/wr.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index 9947feb7fb8a..fca9e1d9d5e9 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -840,13 +840,15 @@ static int handle_psv(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	return err;
 }
 
-static int handle_reg_mr_integrity(struct mlx5_ib_dev *dev,
-				   struct mlx5_ib_qp *qp,
-				   const struct ib_send_wr *wr,
-				   struct mlx5_wqe_ctrl_seg **ctrl, void **seg,
-				   int *size, void **cur_edge,
-				   unsigned int *idx, int nreq, u8 fence,
-				   u8 next_fence)
+static noinline_for_stack int handle_reg_mr_integrity(struct mlx5_ib_dev *dev,
+						      struct mlx5_ib_qp *qp,
+						      const struct ib_send_wr *wr,
+						      struct mlx5_wqe_ctrl_seg **ctrl,
+						      void **seg,
+						      int *size, void **cur_edge,
+						      unsigned int *idx, int nreq,
+						      u8 fence,
+						      u8 next_fence)
 {
 	struct mlx5_ib_mr *mr;
 	struct mlx5_ib_mr *pi_mr;
-- 
2.39.5


