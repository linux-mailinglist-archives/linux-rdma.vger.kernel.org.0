Return-Path: <linux-rdma+bounces-19441-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHANJod05mnKwgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19441-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 20:46:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E59433095
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 20:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FE0D301A17F
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 18:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2EB3B6356;
	Mon, 20 Apr 2026 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IXb6LQOt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41993B7B66
	for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2026 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710743; cv=none; b=WwFe05l12NtnRD33ptEQk1lqoJbntv1YJkbQJlO58QGfMEri8VItwYaiOcZ5esZzeeJznWxave3F3R6Px/KqnlZABAVtiXAEnQcrCWKMXeZPYIc+czhHnFaDzkigRNMEiNKmMgi0e9AAACkFVYNPm3JnjFmhvyQcp+Waxl3ai/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710743; c=relaxed/simple;
	bh=5n4SJ3GN2MNA5BgVK5udG9cp10uEwFtVzwQ/EzmMOe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUYzm/EABBz14mJpWKQArdgIpNzKfAxNMTBlLeWFfhuyFYfaQP2QHw5pbcE33PXhtZ1YQ/qZitHKWNrK6Q0x6eTrqN31IoFKjn2arXWdyc/vhNMxEQP1p0zsVYEsgl4LjEY5+Dg2F9Tnk5+yEQuZCOtXXXFcGpRBWLEuRLf8ucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IXb6LQOt; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K1C2Ca2527954
	for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2026 11:45:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=XhuZiiyrnopFqS0rKfTDKQudcjtEPD5wnNeB1aSoUSk=; b=IXb6LQOtkRlA
	c6H5k5+EYpIviOUfd4cUuKX2Yzyrl1hl+V5CbZ4uFDH63tg5XRQgl9Nc90K4ZAkP
	nrkHb04/0iul3QRoPacdSYaw3RjHiT16/Ki/9cT0sAy0MeamyhiCeo3ToMdkfhRE
	52QMEP6gF0cXqC2uvIwPxA7GFyWX/sPXWyW9M3QzDvr7/PQ6Xn+QJBeQtR6VNQH+
	6S4JBVzDQbk0erPceyfhX3MReGCjz63V476P76odP12l2Xb7pLCUKerOHLnQo3v+
	x6AspQpxCbv1VFnLNV9KDfXaFcH8D4NpcmnCtOIF2S5IA4WUdrhZOmXGKFyGzQpL
	Vy1Z/i7NCA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dm98etny9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 20 Apr 2026 11:45:38 -0700 (PDT)
Received: from twshared18017.01.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 20 Apr 2026 18:45:36 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 2485B113AA961; Mon, 20 Apr 2026 11:39:24 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Stanislav Fomichev <sdf@meta.com>, Keith Busch <kbusch@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai
 Hadas <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Date: Mon, 20 Apr 2026 11:39:15 -0700
Message-ID: <20260420183920.3626389-2-zhipingz@meta.com>
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
X-Authority-Analysis: v=2.4 cv=ZK/nX37b c=1 sm=1 tr=0 ts=69e67452 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VabnemYjAAAA:8 a=0e9SYv1gM71y3HGMkVkA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: ys3dLCZK1K-ZBRQyHw1Xgcdy0be1HfxC
X-Proofpoint-GUID: ys3dLCZK1K-ZBRQyHw1Xgcdy0be1HfxC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE4MiBTYWx0ZWRfX+dnWMRQPDdwU
 8mj7R2+srbWIJPpGyV/tER5ENXiYV+8JpwgDMdO7EMgvtbAlUjRBLX524aDp3pRwgTYseCXFmGW
 cjxYOBA1DhJRurY0vwqotJjd7Q5hLvsewF2GCyahZoyUCoW8Zq4+4E0yq0sLxO3wLpxwjNT9vad
 /B0K/NYLDtjbigLznll1ymNxIOVita1Wx8+1C1HPNQ8F/t1bu7xGq/INUdibicEQQYDYsbXlDus
 EANlbm0LXTB95VGKfskkgb4XxC81Une/PtE9OWTJgvryw4sO9G8kY9atVxFbO8ylVicncAiId/G
 lcaKHlbE2Weefd/h6YSwlygCYSTjEiRKGB0uM6kRSR3zjUlKBRHNeN4cDaxO1f+ronaGlxZM2YI
 RaqYfPq9wAgW4Zx7eN4+qOjmcagT+7tAGT6V5BW1VKxBdwK8v1UHyNY7PmDoTHJgOzPi1VvPXQa
 yPtwUl9NaxvC4hgB/vQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19441-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,meta.com:dkim,meta.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 40E59433095
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a dma-buf callback that returns raw TPH metadata from the exporter
so peer devices can reuse the steering tag and processing hint
associated with a VFIO-exported buffer.

Keep the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI layout intact by
using a flag plus one extra trailing entries[] object for the optional
TPH metadata. Rename the uAPI field dma_ranges to entries. The
nr_ranges field remains the DMA range count; when VFIO_DMABUF_FLAG_TPH
is set the kernel reads one extra entry beyond nr_ranges for the TPH
metadata.

Add an st_width parameter to get_tph() so the exporter can reject
steering tags that exceed the consumer's supported width (8 vs 16 bit).
When no TPH metadata was supplied, make get_tph() return -EOPNOTSUPP.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 62 +++++++++++++++++++++++-------
 include/linux/dma-buf.h            | 17 ++++++++
 include/uapi/linux/vfio.h          | 28 ++++++++++++--
 3 files changed, 89 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
index b1d658b8f7b5..fdc05f9ab3ae 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -17,6 +17,9 @@ struct vfio_pci_dma_buf {
 	struct phys_vec *phys_vec;
 	struct p2pdma_provider *provider;
 	u32 nr_ranges;
+	u16 steering_tag;
+	u8 ph;
+	u8 tph_present : 1;
 	u8 revoked : 1;
 };
=20
@@ -60,6 +63,22 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attach=
ment,
 				       priv->size, dir);
 }
=20
+static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steerin=
g_tag,
+				    u8 *ph, u8 st_width)
+{
+	struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
+
+	if (!priv->tph_present)
+		return -EOPNOTSUPP;
+
+	if (st_width < 16 && priv->steering_tag > ((1U << st_width) - 1))
+		return -EINVAL;
+
+	*steering_tag =3D priv->steering_tag;
+	*ph =3D priv->ph;
+	return 0;
+}
+
 static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment=
,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir)
@@ -89,6 +108,7 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D=
 {
 	.pin =3D vfio_pci_dma_buf_pin,
 	.unpin =3D vfio_pci_dma_buf_unpin,
 	.attach =3D vfio_pci_dma_buf_attach,
+	.get_tph =3D vfio_pci_dma_buf_get_tph,
 	.map_dma_buf =3D vfio_pci_dma_buf_map,
 	.unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
 	.release =3D vfio_pci_dma_buf_release,
@@ -211,7 +231,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_cor=
e_device *vdev, u32 flags,
 				  size_t argsz)
 {
 	struct vfio_device_feature_dma_buf get_dma_buf =3D {};
-	struct vfio_region_dma_range *dma_ranges;
+	bool tph_supplied;
+	u32 tph_index;
+	struct vfio_region_dma_range *entries;
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	struct vfio_pci_dma_buf *priv;
 	size_t length;
@@ -228,7 +250,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
 	if (copy_from_user(&get_dma_buf, arg, sizeof(get_dma_buf)))
 		return -EFAULT;
=20
-	if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
+	tph_supplied =3D !!(get_dma_buf.flags & VFIO_DMABUF_FLAG_TPH);
+	tph_index =3D get_dma_buf.nr_ranges;
+	if (!get_dma_buf.nr_ranges ||
+	    (get_dma_buf.flags & ~VFIO_DMABUF_FLAG_TPH))
 		return -EINVAL;
=20
 	/*
@@ -237,19 +262,21 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
 	if (get_dma_buf.region_index >=3D VFIO_PCI_ROM_REGION_INDEX)
 		return -ENODEV;
=20
-	dma_ranges =3D memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_range=
s,
-				       sizeof(*dma_ranges));
-	if (IS_ERR(dma_ranges))
-		return PTR_ERR(dma_ranges);
+	entries =3D memdup_array_user(&arg->entries,
+				    get_dma_buf.nr_ranges +
+					(tph_supplied ? 1 : 0),
+				    sizeof(*entries));
+	if (IS_ERR(entries))
+		return PTR_ERR(entries);
=20
-	ret =3D validate_dmabuf_input(&get_dma_buf, dma_ranges, &length);
+	ret =3D validate_dmabuf_input(&get_dma_buf, entries, &length);
 	if (ret)
-		goto err_free_ranges;
+		goto err_free_entries;
=20
 	priv =3D kzalloc_obj(*priv);
 	if (!priv) {
 		ret =3D -ENOMEM;
-		goto err_free_ranges;
+		goto err_free_entries;
 	}
 	priv->phys_vec =3D kzalloc_objs(*priv->phys_vec, get_dma_buf.nr_ranges)=
;
 	if (!priv->phys_vec) {
@@ -260,15 +287,22 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
 	priv->vdev =3D vdev;
 	priv->nr_ranges =3D get_dma_buf.nr_ranges;
 	priv->size =3D length;
+
+	if (tph_supplied) {
+		priv->steering_tag =3D entries[tph_index].tph.steering_tag;
+		priv->ph =3D entries[tph_index].tph.ph;
+		priv->tph_present =3D 1;
+	}
+
 	ret =3D vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
 					     get_dma_buf.region_index,
-					     priv->phys_vec, dma_ranges,
+					     priv->phys_vec, entries,
 					     priv->nr_ranges);
 	if (ret)
 		goto err_free_phys;
=20
-	kfree(dma_ranges);
-	dma_ranges =3D NULL;
+	kfree(entries);
+	entries =3D NULL;
=20
 	if (!vfio_device_try_get_registration(&vdev->vdev)) {
 		ret =3D -ENODEV;
@@ -311,8 +345,8 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_cor=
e_device *vdev, u32 flags,
 	kfree(priv->phys_vec);
 err_free_priv:
 	kfree(priv);
-err_free_ranges:
-	kfree(dma_ranges);
+err_free_entries:
+	kfree(entries);
 	return ret;
 }
=20
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 133b9e637b55..b0a79ccbe100 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,23 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_tph:
+	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
+	 * @steering_tag: Returns the raw TPH steering tag
+	 * @ph: Returns the TPH processing hint
+	 * @st_width: Consumer's supported steering tag width in bits (8 or 16)
+	 *
+	 * Return the TPH (TLP Processing Hints) metadata associated with this
+	 * DMA buffer. Exporters that do not provide TPH metadata should return
+	 * -EOPNOTSUPP. If the steering tag exceeds @st_width bits, return
+	 * -EINVAL.
+	 *
+	 * This callback is optional.
+	 */
+	int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
+		       u8 st_width);
+
 	/**
 	 * @map_dma_buf:
 	 *
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index bb7b89330d35..a0bd24623c52 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1490,16 +1490,36 @@ struct vfio_device_feature_bus_master {
  * open_flags are the typical flags passed to open(2), eg O_RDWR, O_CLOE=
XEC,
  * etc. offset/length specify a slice of the region to create the dmabuf=
 from.
  * nr_ranges is the total number of (P2P DMA) ranges that comprise the d=
mabuf.
+ * When VFIO_DMABUF_FLAG_TPH is set, entries[] contains one extra traili=
ng
+ * object after the nr_ranges DMA ranges carrying the TPH steering tag a=
nd
+ * processing hint.
  *
- * flags should be 0.
+ * flags should be 0 or VFIO_DMABUF_FLAG_TPH.
  *
  * Return: The fd number on success, -1 and errno is set on failure.
  */
 #define VFIO_DEVICE_FEATURE_DMA_BUF 11
=20
+enum vfio_device_feature_dma_buf_flags {
+	VFIO_DMABUF_FLAG_TPH =3D 1 << 0,
+};
+
+struct vfio_region_dma_tph {
+	__u16 steering_tag;
+	__u8 ph;
+	__u8 reserved;
+	__u32 reserved2;
+};
+
 struct vfio_region_dma_range {
-	__u64 offset;
-	__u64 length;
+	union {
+		__u64 offset;
+		struct vfio_region_dma_tph tph;
+	};
+	union {
+		__u64 length;
+		__u64 reserved;
+	};
 };
=20
 struct vfio_device_feature_dma_buf {
@@ -1507,7 +1527,7 @@ struct vfio_device_feature_dma_buf {
 	__u32	open_flags;
 	__u32   flags;
 	__u32   nr_ranges;
-	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
+	struct vfio_region_dma_range entries[];
 };
=20
 /* -------- API for Type1 VFIO IOMMU -------- */
--=20
2.52.0


