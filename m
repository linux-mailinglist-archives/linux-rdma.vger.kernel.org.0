Return-Path: <linux-rdma+bounces-21331-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGYEEbP3FWpxgQcAu9opvQ
	(envelope-from <linux-rdma+bounces-21331-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 21:42:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB45DC146
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 21:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 603663036EFD
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120E83B0AC6;
	Tue, 26 May 2026 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ou69T/le"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A543846A;
	Tue, 26 May 2026 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824558; cv=none; b=d7EIu+C+q9AL+1HnTfV61z5TZwKA/WOqSTeI1Y1KDIqqYnLw60wxuYjuP2AhYEC82kpXiwRGRMRN3KMzwY4AEpvVo2O5h4L/SLkOtoP55YjH4c/OetuOXFJn2APZrljPkWcAb1ht/9Knmq+zL+FIPXJx4w6X3b47PEPDPqdcL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824558; c=relaxed/simple;
	bh=xbwdOBPTyubHnb2jO4iZFxAqyyoh11zXV+c6XpzNCSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Le5SEZFAPu0flgVRNs2LQrW4CdfYlBG8CIyIE9Y2qOnkWIbN2BLpp2iNGZVfQN2X4O2Oj73dho2BLKHxd81L4GIZUTnrYS1DC4cjpCxRzw/fpEQ5yWDshtStkFf1xvMttE0XVg15pu5IWP3rQpTMaTlu8RomOuI2Zl7V1ykk7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ou69T/le; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 6825B20B7167; Tue, 26 May 2026 12:42:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6825B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779824547;
	bh=dLUmmtUvSXk1MaPTPB67RF67cBIyhuaAnVNoEfWqh4o=;
	h=From:To:Cc:Subject:Date:From;
	b=ou69T/leaolzX+Q2+0y3bOEeo/d65UjGWSFH/zMSe3sTnuYMNTLhQricARcAwBeG8
	 eqDT1rKX0dacobgwYF0KQYhrhsHpoxwByB9FofkIPvVQKcJvr1bwr9Yo33yYzBvvSY
	 JbAlK2f+Fuc9Is6v5f0D5AVXImsaWhrQerHurQ+k=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH rdma-next v4] RDMA: Change capability fields in ib_device_attr from int to u32
Date: Tue, 26 May 2026 12:42:25 -0700
Message-ID: <20260526194225.1338210-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21331-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 92AB45DC146
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The capability counter fields in struct ib_device_attr are declared
as signed int, but these values are inherently non-negative. Drivers
maintain their cached caps as u32 and assign them directly into these
int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
negative value visible to the IB core.

Change the signed int capability fields to u32 to match the
underlying nature of the data.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v4:
* Drop clamping the values in mana_ib_query_device, instead update
  the props values from int to u32.
Changes in v3:
* Drop clamping from mana_ib_gd_query_adapter_caps(). The internal u32
  caps cache does not need to be clamped.
* Move all clamping exclusively to mana_ib_query_device(), which is the
  only place the cached u32 values are narrowed into the signed int
  fields of struct ib_device_attr.
* Reframe commit message: this is a u32-to-int type boundary fix, not a
  CVM/untrusted-hardware hardening patch.
Changes in v2:
* Update patch title.
---
 include/rdma/ib_verbs.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9dd76f489a0b..805ae294963c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -406,21 +406,21 @@ struct ib_device_attr {
 	u32			vendor_id;
 	u32			vendor_part_id;
 	u32			hw_ver;
-	int			max_qp;
-	int			max_qp_wr;
+	u32			max_qp;
+	u32			max_qp_wr;
 	u64			device_cap_flags;
 	u64			kernel_cap_flags;
-	int			max_send_sge;
-	int			max_recv_sge;
-	int			max_sge_rd;
-	int			max_cq;
-	int			max_cqe;
-	int			max_mr;
-	int			max_pd;
-	int			max_qp_rd_atom;
+	u32			max_send_sge;
+	u32			max_recv_sge;
+	u32			max_sge_rd;
+	u32			max_cq;
+	u32			max_cqe;
+	u32			max_mr;
+	u32			max_pd;
+	u32			max_qp_rd_atom;
 	int			max_ee_rd_atom;
-	int			max_res_rd_atom;
-	int			max_qp_init_rd_atom;
+	u32			max_res_rd_atom;
+	u32			max_qp_init_rd_atom;
 	int			max_ee_init_rd_atom;
 	enum ib_atomic_cap	atomic_cap;
 	enum ib_atomic_cap	masked_atomic_cap;
-- 
2.34.1


