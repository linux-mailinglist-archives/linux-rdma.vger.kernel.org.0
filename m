Return-Path: <linux-rdma+bounces-18593-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJtSOaQjw2l6ogQAu9opvQ
	(envelope-from <linux-rdma+bounces-18593-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 00:52:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF4131DD1A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 00:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B48B30B37F5
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 23:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1168E3ACA4C;
	Tue, 24 Mar 2026 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VDQr8Afa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B9264617
	for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396316; cv=none; b=Pc1JGE1hUbWIe2enmFPWDtyeEMKpfbhY2bJdME3Egm0VeJgNqKONxPoooi021EEPcgyFirWHNLzZfdVnnsSPmxffJpwO2IqAZn7vRQCefqgztVQkiyqwRJqq5yeee0so5v1r+EgYNncI6LyoXuNW+tjXzyyUyGR32QLGnv/o0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396316; c=relaxed/simple;
	bh=bTY2kSZ8d0y76wdgYY4Ktc2YHV+f+ThnXpVEOY1Mkzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhGz3BV+yvsNjQGjcAeaOrBhQ9mwumRO600Djt1dnSNBRHfDls+PxabAXkBS4pSPF99R+aM4iiR0dlsG4AU9kbWvu0SHPAT/ySIbRj6v/u+7oiGCxv4uk1Gnagw8Nliz2YLWlSVmznzSgd15aKc7lwAm7aTlTLMzR/UXwgLTH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VDQr8Afa; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OKfGns1831230
	for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 16:51:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=oGyXd3xG5pggurnnSOT71i0oSkKn9mw956kLM6mwDgM=; b=VDQr8AfaXbHH
	CXynrSWPSPxPAjkD3kcSwIcmegl0Sz5fpHZyNkdUGDfRt33TtKZPFqYk/iqR64IV
	ZQK5YC27Ayu0nDD5EcbUn+mHXSLEH1+p/S6ebARVBaUwgPLjBuLtgXjnt36l8E0e
	cQgtw5nOPLsTZSG+yhfYaQjezIS9/M4TlvJO8QB6XJDLrAe3zF9Vo+9IUgOs/vME
	tmmON1rwWrP/CrVdpAuBaJ/0x0IG9SILhL8qGSX3ZRAD5Eg6tMYMuCxToLPaj67z
	0PqA41C84edawzAwX63UH961xsYfZ1qpiq6a3GYeJk5CxuXJSEBEZh7ppBgrvfh5
	LQeEsTLeVg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d41vat0hh-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Tue, 24 Mar 2026 16:51:53 -0700 (PDT)
Received: from twshared18017.01.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Mar 2026 23:51:51 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 496D01D7CF69; Tue, 24 Mar 2026 16:46:28 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>,
        Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC v2 2/2] RDMA/mlx5: get tph for p2p access when registering dmabuf mr
Date: Tue, 24 Mar 2026 16:46:03 -0700
Message-ID: <20260324234615.3731237-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260324234615.3731237-1-zhipingz@meta.com>
References: <20260324234615.3731237-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=D8pK6/Rj c=1 sm=1 tr=0 ts=69c32399 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VabnemYjAAAA:8 a=YIu6cGBJ8C_R0mlkFEgA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 0udrhTFuUv-vlrKu8YkRaXVnGm8TOgVE
X-Proofpoint-GUID: 0udrhTFuUv-vlrKu8YkRaXVnGm8TOgVE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE4NCBTYWx0ZWRfXwd2oEE6dYo4R
 98ydleHE8YNh81IyCz4z2k7v0PYxHIPvCnbeA2WhbZkIPGJD9gBPvr/lGQyGHRnREdIIq13nhHf
 HmJuFcYbW4cl2zLUwq7Y2yS6gmlRszAki3R3ff3MHyjGhys2bjjBGANeTSC1nG6c34w3Kvt/Cf9
 /wmlkgd4jGVMJKPsMvES/4wCr5olGfFwxnpn6dJlMOtNxcgljmrRxXca7M/f4yIeL6vU05O1/If
 cI3Sk6oadSLzTdfKli1ppnPgCZN/ih94twHrA6aMO5OSsKdCugI3ii4UbCBx4XPSWOFPSPYGGgc
 y6MkylbtTXXrP4zHaU8vWHOOyXrbGgwEh2pe4zU8Mzv5FBdKGtT7o61fOmyx0qQ4dERHaE7g5+9
 Nsr/VmqKgBqnoiiE7QRblzmhlR8FnrWyt0MrpAmdhTu/WoaOlKmhBKPxSO7PF9BCLmjkK/Auaih
 56lYjvCWyfCxL4FPa1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18593-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:dkim,meta.com:email,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6BF4131DD1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch adds support to retrieve tph info from dmabuf during mr
registration for P2P memory access. A new helper get_tph_mr_dmabuf()
queries the dmabuf exporter for tph (steering tag and processing hint)
and converts the raw steering tag to an st_index via
mlx5_st_alloc_index_by_tag(). The DMAH workflow for CPU still takes
precedence in the process.

The new mlx5_st_alloc_index_by_tag() API is extracted from
mlx5_st_alloc_index() to allow callers that already have a raw steering
tag value (e.g., from a dmabuf) to allocate an st_index directly,
without requiring a CPU ID and memory type lookup.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/infiniband/hw/mlx5/mr.c               | 34 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 23 +++++++++----
 include/linux/mlx5/driver.h                   |  7 ++++
 3 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
index 665323b90b64..041922ba3bff 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -46,6 +46,8 @@
 #include "data_direct.h"
 #include "dmah.h"

+MODULE_IMPORT_NS("DMA_BUF");
+
 enum {
 	MAX_PENDING_REG_MR =3D 8,
 };
@@ -1622,6 +1624,36 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
 	.move_notify =3D mlx5_ib_dmabuf_invalidate_cb,
 };

+static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st_i=
ndex,
+			      u8 *ph)
+{
+	struct dma_buf *dmabuf;
+	u16 steering_tag;
+	int ret;
+
+	dmabuf =3D dma_buf_get(fd);
+	if (IS_ERR(dmabuf))
+		return;
+
+	if (!dmabuf->ops->get_tph)
+		goto end_dbuf_put;
+
+	ret =3D dmabuf->ops->get_tph(dmabuf, &steering_tag, ph);
+	if (ret) {
+		mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
+		goto end_dbuf_put;
+	}
+
+	ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_index);
+	if (ret) {
+		*ph =3D MLX5_IB_NO_PH;
+		mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", ret);
+	}
+
+end_dbuf_put:
+	dma_buf_put(dmabuf);
+}
+
 static struct ib_mr *
 reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		   u64 offset, u64 length, u64 virt_addr,
@@ -1664,6 +1696,8 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device =
*dma_device,
 		ph =3D dmah->ph;
 		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
 			st_index =3D mdmah->st_index;
+	} else {
+		get_tph_mr_dmabuf(dev, fd, &st_index, &ph);
 	}

 	mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
index 997be91f0a13..112c55ede731 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -92,23 +92,18 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
 	kfree(st);
 }

-int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
-			unsigned int cpu_uid, u16 *st_index)
+int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
+			       u16 *st_index)
 {
 	struct mlx5_st_idx_data *idx_data;
 	struct mlx5_st *st =3D dev->st;
 	unsigned long index;
 	u32 xa_id;
-	u16 tag;
 	int ret;

 	if (!st)
 		return -EOPNOTSUPP;

-	ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
-	if (ret)
-		return ret;
-
 	if (st->direct_mode) {
 		*st_index =3D tag;
 		return 0;
@@ -152,6 +147,20 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev, e=
num tph_mem_type mem_type,
 	mutex_unlock(&st->lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
+
+int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
+			unsigned int cpu_uid, u16 *st_index)
+{
+	u16 tag;
+	int ret;
+
+	ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
+	if (ret)
+		return ret;
+
+	return mlx5_st_alloc_index_by_tag(dev, tag, st_index);
+}
 EXPORT_SYMBOL_GPL(mlx5_st_alloc_index);

 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04dcd09f7517..c1d2d603bd96 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1177,10 +1177,17 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *=
dev, enum mlx5_sw_icm_type type
 			   u64 length, u16 uid, phys_addr_t addr, u32 obj_id);

 #ifdef CONFIG_PCIE_TPH
+int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
+			       u16 *st_index);
 int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type mem=
_type,
 			unsigned int cpu_uid, u16 *st_index);
 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index);
 #else
+static inline int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev,
+					     u16 tag, u16 *st_index)
+{
+	return -EOPNOTSUPP;
+}
 static inline int mlx5_st_alloc_index(struct mlx5_core_dev *dev,
 				      enum tph_mem_type mem_type,
 				      unsigned int cpu_uid, u16 *st_index)
--
2.52.0


