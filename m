Return-Path: <linux-rdma+bounces-16687-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA3EOp4gimnLHQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16687-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 18:59:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC36113562
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 18:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57E8D3032058
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Feb 2026 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032652FE048;
	Mon,  9 Feb 2026 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lPTF3F6F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8012425F984
	for <linux-rdma@vger.kernel.org>; Mon,  9 Feb 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770659740; cv=none; b=hF6B2vLbyR26tOgccms1QtvHHl+bFDZGn4U1bPkaxLpc+aM0UbE99/MMLS6taxBpWQEdrMGD+mZSjXXbrq/kLHZDcYu2YPfcMq6PSqaY6R908T12eaJxWZwUVkGelCsNdo+a5e1U2qs6tes8mtYCiLlwjnDduvJkNE7d4GDtakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770659740; c=relaxed/simple;
	bh=k6JJU6/Xv5Bve7ALmeRsOaz8DO0O0Gst3Ha4Joxtbys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EuhxMbwcZQoevGX16ad3U6Db1xcq3zNX6agjoEdZJDTr/JfMq4a1Bgq8Zj+XNDAlvWuueXaGsFIFHqspPL0zBxnpzHy5ZYuZfDW+lCWz+ykqE7U6UGghPSyBcLleUMvleKikZhqgqXikfiMTpcXiVZ+rhfcVrlaLwh0TbqxHvpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lPTF3F6F; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 619EwaLK2753846
	for <linux-rdma@vger.kernel.org>; Mon, 9 Feb 2026 09:55:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=+Hrz8y6M1gcSbgUEcxq2AJOX4snqaTvaf+bpG7ruQ0Y=; b=lPTF3F6FAHtN
	n9m8df3I8z31wV0sf7KA2m6LazgppTTUqROOSpEK9iMN27vSzOzIi1HHPOQ27VaC
	Mp1EsA3TF0yFqp3qfZWLVXZaRkvrTQT+Adg7uL+3cXJi/cZE14MaXcekRddKuh2v
	rZrSBHqIhMHmtHd7nroOc1ebTS79/BNV3LP/DpGSQvRulXVMooDfu8CxgeZqozL5
	1PD8BjEic18YshxzA/5h/sOho8BU/T3zPGAndCeoPBqm9GZYfMPdwWRytU9Udqbz
	DR3CHUxT0r4w6t/Ozpe4/c/jpTwsUqLCsknL06Yf5Tbe+kNvQGTnHH2TkIIv5SVJ
	XR4dY93/+Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4c7htntdrj-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 09 Feb 2026 09:55:39 -0800 (PST)
Received: from twshared18017.01.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 9 Feb 2026 17:55:36 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 74677100D0420; Mon,  9 Feb 2026 09:53:19 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC 1/2] Vfio: add callback to get tph info for dmabuf
Date: Mon, 9 Feb 2026 09:53:11 -0800
Message-ID: <20260209175317.1713406-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260209175317.1713406-1-zhipingz@meta.com>
References: <20260209175317.1713406-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FtUIPmrq c=1 sm=1 tr=0 ts=698a1f9b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VabnemYjAAAA:8 a=66hUaM2K5p8tY_kFZzUA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: cDw0XkxQBgQ7m1TESIbIm1amOfo7WfSy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDE1MSBTYWx0ZWRfX/L4LlQK1QOPF
 XqqSP+jabmOPZgMPYMqmrdfNiK8nnIcXNqoN7QWfhjfS+QtF1sUw3fD/r0aQcC0G6DlqkdANyYr
 vfA/zm0LYTgfqNIQR1ruqvpuY9UAJhTcoElKKZiokJ93fRkoP8QBzCC+ozr5wsx2Sga9n0ztMXW
 CvgaI22rJQhwjOiIv++i3Iuh7ug+hvRhnNUNOjzse2g1ihsPKUI7fq+0Y6p0GOcwKNY594+EQJv
 C9/Heuc71+ZLyaqnc3IJbqMrRHix6k24M26uawFuE5sRO+d5IuB3Hf9Mt0H0tb+FxS8JH6dwEK0
 6ZQJDYY5H69z0f7dugMjDubyeMdbh08bHGBUxZlYA2fMn7T0we4Cl1JELgFWZYPJ9O99tKj3dUJ
 a39SI/e6xPpPWm0ickSkRXGxCxmXzRek2MshBvqO+cvyvBNpdBho0HK3FFYYyppJX/4QgYBf6C5
 tEmi/BwWbjhivNMdgpQ==
X-Proofpoint-ORIG-GUID: cDw0XkxQBgQ7m1TESIbIm1amOfo7WfSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16687-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4AC36113562
X-Rspamd-Action: no action

This RFC patch adds a callback to get the tph info on DMA buffer exporter=
s.
The tph info includes both the steering tag and the process hint (ph).

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 15 ++++++++++++++-
 include/linux/dma-buf.h            | 30 ++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h          |  2 ++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
index d4d0f7d08c53..4da1a6cc306f 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -17,6 +17,8 @@ struct vfio_pci_dma_buf {
 	struct dma_buf_phys_vec *phys_vec;
 	struct p2pdma_provider *provider;
 	u32 nr_ranges;
+	u16 steering_tag;
+	u8 ph;
 	u8 revoked : 1;
 };
=20
@@ -50,6 +52,15 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attach=
ment,
 				       priv->size, dir);
 }
=20
+static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steerin=
g_tag,
+				    u8 *ph)
+{
+	struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
+	*steering_tag =3D priv->steering_tag;
+	*ph =3D priv->ph;
+	return 0;
+}
+
 static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment=
,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir)
@@ -78,6 +89,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dm=
abuf)
 static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
 	.attach =3D vfio_pci_dma_buf_attach,
 	.map_dma_buf =3D vfio_pci_dma_buf_map,
+	.get_tph =3D vfio_pci_dma_buf_get_tph,
 	.unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
 	.release =3D vfio_pci_dma_buf_release,
 };
@@ -274,7 +286,8 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_cor=
e_device *vdev, u32 flags,
 		ret =3D PTR_ERR(priv->dmabuf);
 		goto err_dev_put;
 	}
-
+	priv->steering_tag =3D get_dma_buf.steering_tag;
+	priv->ph =3D get_dma_buf.ph;
 	/* dma_buf_put() now frees priv */
 	INIT_LIST_HEAD(&priv->dmabufs_elm);
 	down_write(&vdev->memory_lock);
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 0bc492090237..466290c02ebf 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,36 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_tph:
+	 *
+	 * Get the TPH (TLP Processing Hints) for this DMA buffer.
+	 *
+	 * This callback allows DMA buffer exporters to provide TPH including
+	 * both the steering tag and the process hints (ph), which can be used
+	 * to optimize peer-to-peer (P2P) memory access. The TPH info is typica=
lly
+	 * used in scenarios where:
+	 * - A PCIe device (e.g., RDMA NIC) needs to access memory on another
+	 *   PCIe device (e.g., GPU),
+	 * - The system supports TPH and can use steering tags / ph to optimize
+	 *   cache placement and memory access patterns,
+	 * - The memory is exported via DMABUF for cross-device sharing.
+	 *
+	 * @dmabuf: [in] The DMA buffer for which to retrieve TPH
+	 * @steering_tag: [out] Pointer to store the 16-bit TPH steering tag va=
lue
+	 * @ph: [out] Pointer to store the 8-bit TPH processing-hint value
+	 *
+	 * Returns:
+	 * * 0 - Success, steering tag stored in @tph
+	 * * -EOPNOTSUPP - TPH steering tags not supported for this buffer
+	 * * -EINVAL - Invalid parameters
+	 *
+	 * This callback is optional. If not implemented, the buffer does not
+	 * support TPH.
+	 *
+	 */
+	int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph);
+
 	/**
 	 * @map_dma_buf:
 	 *
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index ac2329f24141..bff2f5f7e38d 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1501,6 +1501,8 @@ struct vfio_region_dma_range {
 struct vfio_device_feature_dma_buf {
 	__u32	region_index;
 	__u32	open_flags;
+	__u16   steering_tag;
+	__u8    ph;
 	__u32   flags;
 	__u32   nr_ranges;
 	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
--=20
2.47.3


