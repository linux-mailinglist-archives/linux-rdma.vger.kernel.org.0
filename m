Return-Path: <linux-rdma+bounces-19442-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JEnCKB45mmFwwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19442-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 21:04:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69585433254
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 21:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7788301D330
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 18:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE4C3BB9EF;
	Mon, 20 Apr 2026 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jnuippCf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A360A27FB0E
	for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2026 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711511; cv=none; b=IvwAmS7NmJ236dTzzPhUc4kukq2TgGqXMwGnA3pQ7L8FZ1GMJn47GVVUgr7HMk4gFto03Hk8BO6CnaWmyaudXtJ6OBHvMc4kNheQOj2/B5Xm+mKs3GhopWxyQak719PEsHIAoxLHK1ggAwb4RypEoHoDBkg/+F4hnVTi3imyvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711511; c=relaxed/simple;
	bh=c+H6CmWoXBftXy4LNSdCRn2nogXkmEI7pZXWLEFW3g8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYwed5G71Tv3EuDMTgmyHEj9nFUSnYa/ym0nspNkYX6jwAoN6TncqgrVzcOu95gxDmi0Ybf0/Z7ncW8hSt1BpFRPL+9vCA+7z0e0sq+nyPB1be+B+4H6a4iqOjiMj41nTdPZTthEswUC4i0/DHVAM22bYj6dff/nM7VFg2WFlQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jnuippCf; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KIcBNE1903351
	for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2026 11:58:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=DGqOu01vpSuNphcdtrhRRkwLn0VqkagmIQlTluku0bA=; b=jnuippCfhRbm
	HkPxmEAYYUi2QERkMuRu+8exogPBuVqeUQk+QsD2paT+AJA4Uff+XHVqyhhD5rrZ
	kbkalvv7jUat0+5FhZuI0DmhU+NzckxDXnU4aZMZNnb0RPYc52dZs5EL99NzYOt1
	dWTrKN4qAFnFMaLBtjeK9AKyuwzRnWDOTnQS1SkeURvLLHZWw3rycsa8q829GwpA
	4d6/71Pfcfuxu22I+N5+a0j9AIZhqskybM9fznRu13B46hsB4rAI4H+G7C3gjKb5
	6YiZoh/aQQcBm4Fh0ZfLLNuRzoFadx627hnW1bc/km3rr+PkOK+eSOv+4pMjqiQd
	DFwD7SVBfg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dm7fau4c8-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2026 11:58:28 -0700 (PDT)
Received: from twshared77462.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 20 Apr 2026 18:58:25 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id F065D113E69D0; Mon, 20 Apr 2026 11:51:21 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Stanislav Fomichev <sdf@meta.com>, Keith Busch <kbusch@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai
 Hadas <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v1 2/2] RDMA/mlx5: get tph for p2p access when registering dma-buf mr
Date: Mon, 20 Apr 2026 11:39:16 -0700
Message-ID: <20260420183920.3626389-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420183920.3626389-1-zhipingz@meta.com>
References: <20260420183920.3626389-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE4NCBTYWx0ZWRfXxC9jioeo19Wf
 LP5hShWLRIsu/aWpMOALxhctGTz7O15A22N2fx9qx2BYAH+QF8Zvhq0HaW2j2rUnAavoFJPwUAF
 4jiUnh5URvSmSDufxCELIYiCWpaon+o4pCFW2dY0ZfkkGGGoS2TFEc8HQ5G+h4jmGd/2jr1J/jz
 sVwzWbS2KqKcpy2thDFKeDt08wd9MflPS8B1x7aEulJ/w6y+zoR/TiXh6rb9jFBsRZAEbLIp0+I
 kph4fp9/H3Odrt21/ZWgALieONgho09UhxW2IKdSBZdj4VnBFFoAb/LK7QKRQAehrPsan3m3O7H
 avvY+Ap2+AoJeeNbFbGhzw8/gKcarIoit2gXhRuH5BM18jj1b2JbFekfao2KDbbLedB3bSnKnxH
 BGHfm2uhfnop+gwBmXav+wMBFWhvprLyU2HMwwyhfbWFRxxRkLbDvdjOHmMjR3OJ85ahQedwVZT
 AMZGEZ2DWF+nYQ5knYA==
X-Proofpoint-ORIG-GUID: XN6r8hBtxi37CBkxmJF9vhGRkW_x0A41
X-Authority-Analysis: v=2.4 cv=VevH+lp9 c=1 sm=1 tr=0 ts=69e67754 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VabnemYjAAAA:8 a=c4au4WjlRKfxtgWlyl4A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: XN6r8hBtxi37CBkxmJF9vhGRkW_x0A41
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19442-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 69585433254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Query dma-buf TPH metadata when registering a dma-buf MR for peer to
peer access and translate the raw steering tag into an mlx5 steering tag
index. Factor mlx5_st_alloc_index() so callers that already have a raw
steering tag can allocate the corresponding mlx5 index directly. Keep the
DMAH path as the first priority and only fall back to dma-buf metadata wh=
en
no DMAH is supplied.

Pass the device's supported ST width (8 or 16 bit, derived from
pdev->tph_req_type) to get_tph() so the exporter can reject tags that
exceed the consumer's capability. Initialize ret in mlx5_st_create() so t=
he
cached steering-tag path returns success cleanly under clang builds.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/infiniband/hw/mlx5/mr.c               | 38 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 25 ++++++++----
 include/linux/mlx5/driver.h                   |  7 ++++
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
index 665323b90b64..618c84815d48 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -46,6 +46,8 @@
 #include "data_direct.h"
 #include "dmah.h"
=20
+MODULE_IMPORT_NS("DMA_BUF");
+
 enum {
 	MAX_PENDING_REG_MR =3D 8,
 };
@@ -1622,6 +1624,40 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
 	.move_notify =3D mlx5_ib_dmabuf_invalidate_cb,
 };
=20
+static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st_i=
ndex,
+			      u8 *ph)
+{
+	struct pci_dev *pdev =3D dev->mdev->pdev;
+	struct dma_buf *dmabuf;
+	u16 steering_tag;
+	u8 st_width;
+	int ret;
+
+	st_width =3D (pdev->tph_req_type =3D=3D PCI_TPH_REQ_EXT_TPH) ? 16 : 8;
+
+	dmabuf =3D dma_buf_get(fd);
+	if (IS_ERR(dmabuf))
+		return;
+
+	if (!dmabuf->ops->get_tph)
+		goto end_dbuf_put;
+
+	ret =3D dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
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
@@ -1664,6 +1700,8 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device =
*dma_device,
 		ph =3D dmah->ph;
 		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
 			st_index =3D mdmah->st_index;
+	} else {
+		get_tph_mr_dmabuf(dev, fd, &st_index, &ph);
 	}
=20
 	mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/n=
et/ethernet/mellanox/mlx5/core/lib/st.c
index 997be91f0a13..724b67c3f3a6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
@@ -29,7 +29,7 @@ struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *de=
v)
 	u8 direct_mode =3D 0;
 	u16 num_entries;
 	u32 tbl_loc;
-	int ret;
+	int ret =3D 0;
=20
 	if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
 		return NULL;
@@ -92,23 +92,18 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
 	kfree(st);
 }
=20
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
=20
 	if (!st)
 		return -EOPNOTSUPP;
=20
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
=20
 int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04dcd09f7517..c1d2d603bd96 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1177,10 +1177,17 @@ int mlx5_dm_sw_icm_dealloc(struct mlx5_core_dev *=
dev, enum mlx5_sw_icm_type type
 			   u64 length, u16 uid, phys_addr_t addr, u32 obj_id);
=20
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
--=20
2.52.0


