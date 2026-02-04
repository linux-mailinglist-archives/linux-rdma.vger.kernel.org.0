Return-Path: <linux-rdma+bounces-16525-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBJqI+JRg2mJlQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16525-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 15:04:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EED0CE6D1D
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 15:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E332C30182AB
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D97440B6F2;
	Wed,  4 Feb 2026 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Bq+8YQwB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF64C3EDAB9;
	Wed,  4 Feb 2026 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213493; cv=none; b=Fm6MFLbRi0BLcq5xjQYxOIMy0vrrhPNflzYZLX9VYqgVJOPafNpp5EieZ5L+n3cbqZ2UDIAMy/g4WT+T8IdcxMr3w49fliyQJoVcq1PAitLv1nl1VhazWXj/FBKwB0qnTpdvxLnEcXfY5Ga59X6jUoXOA5ulwpGwxFjkNenk268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213493; c=relaxed/simple;
	bh=pvC0VsYcRAmKSgsw8BzjRLW7zgbHzHLclYysy+BsMpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZbSjhn7IwwYiK9jx0JbZcDXOC0aPQxeKLwV8o2QZeoig46LzTZifiY0oLhjjWmPYUjLbIKnI1pPNwe1e/4ofRY6b4bLU8HBSzb/uvmoHrbUsZ+bMSY5ZcQ2wW5LeisloRLB6i7tEUsn1nZ7QbT0HmbSQ3TVIQTvsTTUPPwlgxIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Bq+8YQwB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id AA46B20B7165; Wed,  4 Feb 2026 05:58:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA46B20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770213493;
	bh=PLwJJumRTsz9j7gCg6Gobs9azCo8OVYxtwSxuo3klCY=;
	h=From:To:Cc:Subject:Date:From;
	b=Bq+8YQwBZlTThifu+vwZfvIcKpx8BAe9/ksxsA8IU66z8qb40R2KfUtCnk/82FRLD
	 9heyB3ThMxGffFs8PZXjGV9Kb3VvJRmPHe5G2GxC2QMvs0rAVwPcd27ZSQ2s2OQNtq
	 8kr+tMkKC+RmnDFM0PfDnm4F9GMPMRDnM7EoEquY=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/mana_ib: return PD number to the user
Date: Wed,  4 Feb 2026 05:58:13 -0800
Message-ID: <20260204135813.870538-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16525-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EED0CE6D1D
X-Rspamd-Action: no action

From: Konstantin Taranov <kotaranov@microsoft.com>

Implement returning to userspace applications PDNs of created PDs.
Allow users to request short PDNs which are 16 bits.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 19 ++++++++++++++++++-
 include/net/mana/gdma.h           |  4 ++--
 include/uapi/rdma/mana-abi.h      | 14 ++++++++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index fac159f71..7ee4493cb 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -69,9 +69,11 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
 int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 {
 	struct mana_ib_pd *pd = container_of(ibpd, struct mana_ib_pd, ibpd);
+	struct mana_ib_alloc_pd_resp cmd_resp = {};
 	struct ib_device *ibdev = ibpd->device;
 	struct gdma_create_pd_resp resp = {};
 	struct gdma_create_pd_req req = {};
+	struct mana_ib_alloc_pd ucmd = {};
 	enum gdma_pd_flags flags = 0;
 	struct mana_ib_dev *dev;
 	struct gdma_context *gc;
@@ -83,8 +85,15 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
 			     sizeof(resp));
 
-	if (!udata)
+	if (!udata) {
 		flags |= GDMA_PD_FLAG_ALLOW_GPA_MR;
+	} else {
+		err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
+		if (err)
+			return err;
+		if (ucmd.flags & MANA_IB_PD_SHORT_PDN)
+			flags |= GDMA_PD_FLAG_SHORT_PDN;
+	}
 
 	req.flags = flags;
 	err = mana_gd_send_request(gc, sizeof(req), &req,
@@ -107,6 +116,14 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	mutex_init(&pd->vport_mutex);
 	pd->vport_use_count = 0;
+
+	if (udata) {
+		cmd_resp.pdn = resp.pd_id;
+		err = ib_copy_to_udata(udata, &cmd_resp, min(sizeof(cmd_resp), udata->outlen));
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 8649eb789..cebb9b2bd 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -824,8 +824,8 @@ struct gdma_destroy_dma_region_req {
 }; /* HW DATA */
 
 enum gdma_pd_flags {
-	GDMA_PD_FLAG_INVALID = 0,
-	GDMA_PD_FLAG_ALLOW_GPA_MR = 1,
+	GDMA_PD_FLAG_ALLOW_GPA_MR = BIT(0),
+	GDMA_PD_FLAG_SHORT_PDN = BIT(2),
 };
 
 struct gdma_create_pd_req {
diff --git a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h
index a75bf32b8..88b24ae50 100644
--- a/include/uapi/rdma/mana-abi.h
+++ b/include/uapi/rdma/mana-abi.h
@@ -87,4 +87,18 @@ struct mana_ib_create_qp_rss_resp {
 	struct rss_resp_entry entries[64];
 };
 
+enum mana_ib_create_pd_flags {
+	MANA_IB_PD_SHORT_PDN = 1 << 0,
+};
+
+struct mana_ib_alloc_pd {
+	__u32 flags;
+	__u32 reserved;
+};
+
+struct mana_ib_alloc_pd_resp {
+	__u32 pdn;
+	__u32 reserved;
+};
+
 #endif
-- 
2.43.0


