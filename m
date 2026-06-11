Return-Path: <linux-rdma+bounces-22131-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G4LQN53nKmqZzAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22131-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 18:51:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8EE673B8C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 18:51:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=GCRlI9JE;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22131-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22131-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AE613156198
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D552B38331F;
	Thu, 11 Jun 2026 16:46:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDFA42B733
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 16:46:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196386; cv=none; b=pWJLQn1Y/dhU6oU3u/bcFxlRDmRWmL06AcjQPsQQ79KHQzsV60h6kc5109D/LI6rjkTOJkpfQqU4pO5uhkILr/akZXkZpUHirqspAe0pdQsfGx7HS+UMerahwEcIN7wcnt9nm5UlpQdI5/A8GGYkuulowZ/JmtmjhHFPlyL8Zok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196386; c=relaxed/simple;
	bh=Atlcqwx1CSWgGgkvnS0mRZ+P+9R1RYqnbvptj2L+F+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qm3VjqyvjL8MnRbJWUbCJVP9KJaClBOQ8yhJfbQmWrZ+W/ir0u0GqCW6kHJx3Y10SMMQMEsfXCF1K+Ba2RsSpqXvtwPOb7vlQsEfm1wrgiwsdZfh+sXUBgFEqvofC98gYcxQZfEGtJiT9+VS39Xw90iK2I0haYLX1frRAblFB2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GCRlI9JE; arc=none smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BECju32241299
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 09:46:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=i0/fryQsHZZUsVpWLovLPhh4uANlkSKGKFUxbWvZ4kE=; b=GCRlI9JEnuhx
	Sl1/K5JKeGBIsRlXMmgFITWKUVKP+QzM4E6F+G4ncR11jjNlaKjygRt8WQahf5Qy
	5Owb3G2biK+qYe8Mrteh4smjeJyTLxIMjm54JOo8TGPbg7lY8vdwB/28lCB/yC1o
	4a8pyMTDOAZPISDgT0s4U/HqY+uFlxqDf1gLN2Tqqss3/433EXpzznMQ4SwooE5t
	EJ9idSicRgxxkkKsgvyzUgXnzbromuNz2NkT/NeO6mUfxew6vB6zEzEdPW9d4z8E
	9XBYPDj9EOCvtw22TvvR27nCEO4LlZUBFQWslmLBpsJif0EcLx4ZgmO1Y5YrponX
	SP5NXhy9DA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe81pqcy-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 09:46:23 -0700 (PDT)
Received: from twshared90953.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Thu, 11 Jun 2026 16:46:20 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 663463DD363EC; Thu, 11 Jun 2026 09:23:46 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: <netdev@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
Date: Thu, 11 Jun 2026 09:11:19 -0700
Message-ID: <20260611161546.4075580-5-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611161546.4075580-1-zhipingz@meta.com>
References: <20260611161546.4075580-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=d8nFDxjE c=1 sm=1 tr=0 ts=6a2ae65f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=VabnemYjAAAA:8 a=pIVkarnfHJxX8sQW8bgA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 2MRRLNjCWutnuqmcBOCUk-1zarBW5I1Y
X-Proofpoint-ORIG-GUID: 2MRRLNjCWutnuqmcBOCUk-1zarBW5I1Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfXxWs1e6H10Zv5
 GEOE+5djX1OLwT721pOn87ZyZUlIq4csIMXu5HhoPXjSY6NveCA2RYA9FIQvpNjVxaTUoLN5j3G
 CR+lGzvDJV/ADn7OBnZTJWyBHojHLRg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE2OCBTYWx0ZWRfX1jnI8oPB3Pb0
 VO7EuQ7x2x5KCb3su5P+p6ako3JfRh6bmu6Oqt3Va6U048iGdzjG9fEwoFefJFYX37HO+VDyW7w
 +wxpkiOiv+ifeZcciOyN0oDUXdgwGcrAa5PHqg/qfROPuhmvFfSel04jaJcOp2LGwYESoVve0y5
 VTn66b+buHURQh6wuwM7x5xkxzl9y1v2vSB9JJwhieiWfmAnAY2c2ojXD3II6tERfLhX4OjhdQn
 WSPJFhCdBgkLlnkBMSXQOV5g3J18W8jHif08KQgRFiHVSs7ds2YuLKTrlCMTfSoqfLBVByhgzTj
 J76JK3K17EQIQI1CiSNt+TUWy+fwE6vMGLOnMIv3wpyqgWpuaxKhtRQKJpj4c/S5Bv0i1XsOTL9
 1ApS3eZ7H7i3Zkw3YnnhdTu1ZbzQkxwERLhbZOS+zYIilAjY7BPPzs92Go4hu3WZffCXtvrqFai
 0jQGjzM/F6E9tpTzt3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22131-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:zhipingz@meta.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,set_tph.ph:url,meta.com:dkim,meta.com:email,meta.com:mid,meta.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E8EE673B8C

Implement dma-buf get_tph for vfio-pci exported dma-bufs and add
VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
for a VFIO-owned device.

8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
uAPI carries both with explicit validity flags, and get_tph() returns
the value matching the importer's requested namespace or -EOPNOTSUPP.

Publish and read the TPH descriptor under dmabuf->resv, matching the
locking used for other importer-visible dma-buf state. The SET ioctl
takes dma_resv_lock_interruptible(), while the callback runs under
DMA-buf's asserted resv lock.

Reject requests the device cannot consume as a completer:
pcie_tph_completer_type() must report at least
PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Validate fields before the completer
check so userspace gets the narrowest errno.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/vfio/pci/vfio_pci_core.c   |  3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c | 94 +++++++++++++++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
 include/uapi/linux/vfio.h          | 37 ++++++++++++
 4 files changed, 145 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
index 050e7542952e..4fa36f2f7555 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device =
*device, u32 flags,
 		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
 	case VFIO_DEVICE_FEATURE_DMA_BUF:
 		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
+	case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
+		return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
+							 argsz);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
index 1a177ce7de54..0a0705c8dbea 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -3,6 +3,7 @@
  */
 #include <linux/dma-buf-mapping.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pci-tph.h>
 #include <linux/dma-resv.h>
=20
 #include "vfio_pci_priv.h"
@@ -19,7 +20,12 @@ struct vfio_pci_dma_buf {
 	u32 nr_ranges;
 	struct kref kref;
 	struct completion comp;
-	u8 revoked : 1;
+	u8 tph_st_valid:1;
+	u8 tph_st_ext_valid:1;
+	u8 tph_ph:2;
+	u8 tph_st;
+	u16 tph_st_ext;
+	u8 revoked:1;
 };
=20
 static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
@@ -69,6 +75,26 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attach=
ment,
 	return ret;
 }
=20
+static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, bool extende=
d,
+				    u16 *steering_tag, u8 *ph)
+{
+	struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
+
+	dma_resv_assert_held(dmabuf->resv);
+
+	if (extended) {
+		if (!priv->tph_st_ext_valid)
+			return -EOPNOTSUPP;
+		*steering_tag =3D priv->tph_st_ext;
+	} else {
+		if (!priv->tph_st_valid)
+			return -EOPNOTSUPP;
+		*steering_tag =3D priv->tph_st;
+	}
+	*ph =3D priv->tph_ph;
+	return 0;
+}
+
 static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment=
,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir)
@@ -101,6 +127,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *=
dmabuf)
=20
 static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
 	.attach =3D vfio_pci_dma_buf_attach,
+	.get_tph =3D vfio_pci_dma_buf_get_tph,
 	.map_dma_buf =3D vfio_pci_dma_buf_map,
 	.unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
 	.release =3D vfio_pci_dma_buf_release,
@@ -333,6 +360,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
 	return ret;
 }
=20
+int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
+				      u32 flags,
+				      struct vfio_device_feature_dma_buf_tph __user *arg,
+				      size_t argsz)
+{
+	struct vfio_device_feature_dma_buf_tph set_tph;
+	struct vfio_pci_dma_buf *priv;
+	struct dma_buf *dmabuf;
+	u8 comp;
+	int ret;
+
+	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
+				 sizeof(set_tph));
+	if (ret !=3D 1)
+		return ret;
+
+	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
+		return -EFAULT;
+
+	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
+		return -EINVAL;
+
+	if (set_tph.ph & ~0x3)
+		return -EINVAL;
+
+	comp =3D pcie_tph_completer_type(vdev->pdev);
+	if (comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_NONE)
+		return -EOPNOTSUPP;
+	if ((set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT) &&
+	    comp !=3D PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH)
+		return -EOPNOTSUPP;
+
+	dmabuf =3D dma_buf_get(set_tph.dmabuf_fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops) {
+		ret =3D -EINVAL;
+		goto out_put;
+	}
+
+	priv =3D dmabuf->priv;
+	if (priv->vdev !=3D vdev) {
+		ret =3D -EINVAL;
+		goto out_put;
+	}
+
+	ret =3D dma_resv_lock_interruptible(dmabuf->resv, NULL);
+	if (ret)
+		goto out_put;
+
+	priv->tph_st         =3D set_tph.steering_tag;
+	priv->tph_st_ext     =3D set_tph.steering_tag_ext;
+	priv->tph_ph         =3D set_tph.ph;
+	priv->tph_st_valid   =3D !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
+	priv->tph_st_ext_valid =3D
+		!!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
+	dma_resv_unlock(dmabuf->resv);
+	ret =3D 0;
+
+out_put:
+	dma_buf_put(dmabuf);
+	return ret;
+}
+
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revok=
ed)
 {
 	struct vfio_pci_dma_buf *priv;
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci=
_priv.h
index fca9d0dfac90..c58f369be4b3 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -118,6 +118,10 @@ static inline bool vfio_pci_is_vga(struct pci_dev *p=
dev)
 int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32=
 flags,
 				  struct vfio_device_feature_dma_buf __user *arg,
 				  size_t argsz);
+int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
+				      u32 flags,
+				      struct vfio_device_feature_dma_buf_tph __user *arg,
+				      size_t argsz);
 void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
 void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revok=
ed);
 #else
@@ -128,6 +132,14 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_d=
evice *vdev, u32 flags,
 {
 	return -ENOTTY;
 }
+
+static inline int
+vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev, u32=
 flags,
+				  struct vfio_device_feature_dma_buf_tph __user *arg,
+				  size_t argsz)
+{
+	return -ENOTTY;
+}
 static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device =
*vdev)
 {
 }
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..5dd693220a0d 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,43 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
=20
+/**
+ * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) met=
adata
+ * with a vfio-exported dma-buf. The dma-buf must have been created by
+ * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must repor=
t
+ * TPH Completer support in Device Capabilities 2 (bits 13:12); requests
+ * carrying VFIO_DMA_BUF_TPH_ST_EXT additionally require the device to
+ * report the Extended TPH Completer encoding. Otherwise the ioctl
+ * returns -EOPNOTSUPP.
+ *
+ * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_=
BUF.
+ *
+ * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) are
+ * distinct namespaces. Userspace supplies whichever values are valid an=
d sets
+ * the matching VFIO_DMA_BUF_TPH_ST / VFIO_DMA_BUF_TPH_ST_EXT bits in @f=
lags;
+ * an importer requests one namespace and receives the matching value.
+ *
+ * @flags =3D=3D 0 marks any previously published ST / Extended-ST as in=
valid
+ * for future get_tph() requests on this dma-buf.
+ *
+ * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
+ *
+ * Userspace must publish TPH before handing the dma-buf fd to an import=
er.
+ * Calling SET again replaces the published values.
+ */
+#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
+
+#define VFIO_DMA_BUF_TPH_ST		(1 << 0)
+#define VFIO_DMA_BUF_TPH_ST_EXT		(1 << 1)
+
+struct vfio_device_feature_dma_buf_tph {
+	__s32	dmabuf_fd;
+	__u32	flags;
+	__u16	steering_tag_ext;
+	__u8	steering_tag;
+	__u8	ph;
+};
+
 /* -------- API for Type1 VFIO IOMMU -------- */
=20
 /**
--=20
2.53.0-Meta


