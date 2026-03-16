Return-Path: <linux-rdma+bounces-18191-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHkrDUFHuGmLbAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18191-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:09:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFE729ED6A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 19:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A907301DDD2
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 18:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A68389109;
	Mon, 16 Mar 2026 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="W6pixMuE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B2346782
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684541; cv=none; b=Lmw43imDvr4BOzXmYhDcbKVHzNpiCiQvslaJAEGd4NFfOtBM/j8VP9lMSqHKEaM3mvl+AjmZsWWyIgQyx+uPjYLYYhBPtmP3Q6wzAXCZsKSDX98qcKwBAZvIRISFoBKdCPshfLh5h6tPrD9dMwjfkflPE6ErROGfpRDPrc0s82Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684541; c=relaxed/simple;
	bh=z3MeVHkvelwytsaKT/kgirwb6yLGocCJT+boM7S6jf0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QaX3UMq4MI0+AdckYb/1ik1XXOgWjPQFUJsArYQSWFNRtaLNNUkTs5x6y34QOuVbi8Rcc9wP7hTv39cGHmXLQDkImrldV9bUEF6KQvJlhwIHn7C02VWD/ujYzVq0rW0MNfkfTBgvFWsHMZ0r3nMcecrFdw3sVOpu8gdMytKyA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=W6pixMuE; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773684538; x=1805220538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d47aH07NMKw9Fyv2jUIxN9W+gKf7SWb6HLd2msxv/FM=;
  b=W6pixMuEMeI3nMZ6eWhEJ1XJXbo0YL0C0EZxecAQyIzjxya/k31EtVYP
   Ba1JlcZDfWSSGeTTF7qyBXzqSJUGsLf7AxKbEolfZAAcrZC/d6yzyXhrq
   nLkPhM5le69gHz0ODkBeac2UGdZW3srtejxmplmlhqOqwTvHFmgESermt
   WvDyBmwHuMPC98HlXUaAi8Yqvfx+TiuGkwzlf2mcyTKIdWocUrZ99oXG3
   Yrfs1bLm0lQuf9S8eUwUtM3tsh+VO3CjCJXGaqSMym0K2ddB8HfASEBqw
   aFa45HbHXZB+J1cmPs/KzzWtlEd/JZAC1XMCG5HGlS3hbpIylohzGFJRG
   Q==;
X-CSE-ConnectionGUID: /FK5VtbMSqW2olrfqW8wOA==
X-CSE-MsgGUID: CZrBExr7T3WXAzlDYaRvbQ==
X-IronPort-AV: E=Sophos;i="6.23,124,1770595200"; 
   d="scan'208";a="15133613"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 18:08:55 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:28687]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.164:2525] with esmtp (Farcaster)
 id 88c0cd42-2a77-43f5-96bd-42c143351b99; Mon, 16 Mar 2026 18:08:55 +0000 (UTC)
X-Farcaster-Flow-ID: 88c0cd42-2a77-43f5-96bd-42c143351b99
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 16 Mar 2026 18:08:55 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 16 Mar 2026
 18:08:53 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>
Subject: [PATCH for-next] RDMA/efa: Rename alloc_ucontext comp_mask to supported_caps
Date: Mon, 16 Mar 2026 18:08:46 +0000
Message-ID: <20260316180846.30273-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18191-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EAFE729ED6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Following discussion [1], rename the comp_mask field in
efa_ibv_alloc_ucontext_cmd to supported_caps to reflect its actual
usage as a capabilities handshake mechanism rather than a standard
comp_mask. Rename related constants and align function and macro names.

[1] https://lore.kernel.org/linux-rdma/20260312120858.GH1448102@nvidia.com/

Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 17 +++++++++--------
 include/uapi/rdma/efa-abi.h           |  6 +++---
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index fc498663cd37..283c62d9cb3d 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1917,22 +1917,23 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
 	return efa_com_dealloc_uar(&dev->edev, &params);
 }
 
-#define EFA_CHECK_USER_COMP(_dev, _comp_mask, _attr, _mask, _attr_str) \
-	(_attr_str = (!(_dev)->dev_attr._attr || ((_comp_mask) & (_mask))) ? \
+#define EFA_CHECK_USER_SUPP(_dev, _supported_caps, _attr, _mask, _attr_str) \
+	(_attr_str = (!(_dev)->dev_attr._attr || ((_supported_caps) & (_mask))) ? \
 		     NULL : #_attr)
 
-static int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
+static int efa_user_supp_handshake(const struct ib_ucontext *ibucontext,
 				   const struct efa_ibv_alloc_ucontext_cmd *cmd)
 {
 	struct efa_dev *dev = to_edev(ibucontext->device);
 	char *attr_str;
 
-	if (EFA_CHECK_USER_COMP(dev, cmd->comp_mask, max_tx_batch,
-				EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH, attr_str))
+	if (EFA_CHECK_USER_SUPP(dev, cmd->supported_caps, max_tx_batch,
+				EFA_ALLOC_UCONTEXT_CMD_SUPP_CAPS_TX_BATCH,
+				attr_str))
 		goto err;
 
-	if (EFA_CHECK_USER_COMP(dev, cmd->comp_mask, min_sq_depth,
-				EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR,
+	if (EFA_CHECK_USER_SUPP(dev, cmd->supported_caps, min_sq_depth,
+				EFA_ALLOC_UCONTEXT_CMD_SUPP_CAPS_MIN_SQ_WR,
 				attr_str))
 		goto err;
 
@@ -1966,7 +1967,7 @@ int efa_alloc_ucontext(struct ib_ucontext *ibucontext, struct ib_udata *udata)
 		goto err_out;
 	}
 
-	err = efa_user_comp_handshake(ibucontext, &cmd);
+	err = efa_user_supp_handshake(ibucontext, &cmd);
 	if (err)
 		goto err_out;
 
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 13225b038124..d5c18f8de182 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -22,12 +22,12 @@
  */
 
 enum {
-	EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH  = 1 << 0,
-	EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR = 1 << 1,
+	EFA_ALLOC_UCONTEXT_CMD_SUPP_CAPS_TX_BATCH  = 1 << 0,
+	EFA_ALLOC_UCONTEXT_CMD_SUPP_CAPS_MIN_SQ_WR = 1 << 1,
 };
 
 struct efa_ibv_alloc_ucontext_cmd {
-	__u32 comp_mask;
+	__u32 supported_caps;
 	__u8 reserved_20[4];
 };
 
-- 
2.47.3


