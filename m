Return-Path: <linux-rdma+bounces-19305-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN/BAug23WkmawkAu9opvQ
	(envelope-from <linux-rdma+bounces-19305-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 20:33:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E58D83F2181
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 20:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3B63301A082
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E13138B15B;
	Mon, 13 Apr 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BhCoaxeI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E41368946
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776105184; cv=fail; b=NAunQbTSl4PqOK2fYAVV8/TBL+14bBU/Jb1qrco0Ffi7WI3dYdGpQE/rP5utss1QvjzZFknj6B0ROtWdWn1Z232kM+A98jLkhRc3ZSwoNPXy6eusQdYOeiGSgB5VvISWd3ymDeDmOTipX1hNN8jadQ2dlPQycGSzl+ITGuQ7lok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776105184; c=relaxed/simple;
	bh=cBpXrkihGcjGQcaYRaWShDZmky7Cxex9eGcodqpepCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOaPjyW0KXxFO+fQPI5A0A12slNsioDi77LurFKxoRK0KESznIw/1ocKAiLYaZ3EOZIRBIWGg1hbIm6RATCrBcoB+cj85jE+st7i9Z3Ax/FOcTpQZmrhJ6lwv8gjc5wA0nxRwHxkJ9G7x9DLA/WZIJFRvuxXIG0DlrrALpnotvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BhCoaxeI; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D5HXRR1232769
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 11:33:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zG1i4GOJI0Qqxhx6X/y+OYVi9v31A3eEgoxO9M8dGo8=; b=BhCoaxeIAUTn
	YJ7JhPz3Cx4IihaBsBpITr2/1JYDB8qkbM1UsOnx6Hz7lD9+VdcpE1EJyypDO/KG
	WCuinBHxBNAbk1fqrW0/uMUNq3AFMFBcyij842gJXDxEArbnbnSFlkWcDzkkpHJw
	93uzWR86iB/Yoqf4nv/24SWhVkPlWjvuAPhNCj2eGDalRmeGG5B83FBpS4No7Y7L
	joGCbmbGXSXrXvzc89j++TyvF2Kco6Mo2SyFjdP79qHqn/VKxxhWFXQ309Ujk0O2
	ZWUwUErBjTlmgcLhxUNhmB9eD3sRs8I5KPtN+ckqJ0rrQA5u0slfiHH3Lke5SO3z
	mic2S/rLnA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dg7xfq6r0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 11:33:00 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dbd4fe0e15so30336a34.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 11:33:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776105180; cv=none;
        d=google.com; s=arc-20240605;
        b=NJQxXeb5IKSZ9vRzQmmrRuNOGPQ0iHeNfbsQTnK18XKkvJoLRcgoYyN47Bonkl4dvt
         Ccy4A9828gO0IoUnc1uBLby+bWgaVCeI2uX2Hw8j3iQyVIngucmtBNOQ85EqCYus0eep
         Iaird/ul+hgC8N+fGuXUmaKeCHmqNucpiotzT6UZ3L9xk0FFFc2wbwitRA7qBk3qkOss
         niv6BxU7gDiK+yHLPWfOl+sxG/Mpiw5TVQbZXYCwd2PeHj+o1JV/oxQWCUJJohCXLl7A
         afGXdr2TRIUk0FfV/EBEoKaUA7ZTjBirIxojdH4fbLMXjT0CiQMF/WPs2XwxFvE3Ag0o
         cg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=+JPsy6ZFn+T7uthNgDQuwBwhJArt54L0xqFFmpZV85I=;
        fh=uAlxtBAN2yNcyAYdLnQxBCXMwB1qARvReOekF/ry1PA=;
        b=PDUjSrS0f2ipKtFgySUg5irEVqJWoh/Rl/YGiHFnJ7X54U0Qmmxvn2/QPMwCMjN142
         TOaWj/uP7JmMyiD4ok5hBjc927R/uLTRrCqw85AznmTo+LtUIX0a6/zjU4Q4uiOrW6yc
         /NnmK9aQmuH107uEnV7rDdoGXpVpBlYHQBbmbYUiNRkXdbnwrk/qbNVlxQazMY0k4DPD
         hRuT9Vz/oWpN/C6VsKmgJDLcH7dbXEkEp0FBFlolfncu/o+qrHubCCBOQQQCBDXTcKcz
         p4H1sTbOwBpaQPvN5Ux+zLDIGPsp96q/1rosVY6IM9/br82cR0o08f9GoJt0Lt7c8Xlu
         Grag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776105180; x=1776709980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+JPsy6ZFn+T7uthNgDQuwBwhJArt54L0xqFFmpZV85I=;
        b=rDp/VvXM4t79+fjAlbVgvmDbck2IiLv6qPGKcyT1Zqv26RC3NMofnKebe4QLEI7fLH
         WseO2YC1MJqcss3VEEgz+DHWtLZoRtuPzYgZ5TAsV3vNmKmF7jtwrXet7jxCwjm40OTH
         raN7BjIaAP8da71qIUGsTEmh1XnMCMmcK+12HyVMT6bjXv4qC+QOreHMtu3+8oRiHLzG
         Vzw7lix1W+vwwNbolpiuyFLQppJOZFwgljvN55t3Bh1ppRZgppky7Ubv860XjXQm0czb
         AeGstJJv2dWp92qotjP1a9JOFKpr2Sc5OXxp/cOClvTJaXgmJCyz/7eVtLYW1y2CFWAf
         iTPg==
X-Forwarded-Encrypted: i=1; AFNElJ9zjtUK+yAgcJDlSv61bvqAH0zovFnOPVe7KnFaGUzRrTIaPUoOcMz42sBCJzancGu7vnAzzkEt0l7r@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuHpJe1OEUxY4CRWbkdUtEmV6Y+ADIaX1qzF58bVL4lpR+29w
	Ja1szcrGCkPJ+qFxwdH+U5HI9nXPZYrmp/uyXgwOLP6Ce4rdwf0iO6lMbLKFleKGb227jJXHzS7
	Kc1Cv235EOdS+bPRrlHJlV5IxMLDfVTNFjmuFyx/qol7GI6iabHCF1QN+HSHr9o174I3gmBhVxN
	GR10/z/wxCP8I55m6kVw39KzlfN2cgMW+djTDn
X-Gm-Gg: AeBDietSIRJLBDpezITGRUS1j9wcBkFh9kyGh/d5B54wLq8120M8oWAiRAvAEb94+vg
	Ym6TJvfQFYKG2iCbO3/Ze1uY845YyPtPBkPMH5v4pV3qZttZgTLbVUtf6KBDw2ZMUzpVRjbWdWF
	SztUsv6lIksIAes6Pxh5Vxdyi/zZWr/pJg/lvowkhsTNr7lD5YqmkNbosU7df+5sUlxBtF5Q/Ri
	+dxpF6b8M66ZOBcNj3WKjV802WKztex
X-Received: by 2002:a05:6830:488e:b0:7db:a0b2:b5d5 with SMTP id 46e09a7af769-7dc27e1ca9cmr8189333a34.24.1776105180115;
        Mon, 13 Apr 2026 11:33:00 -0700 (PDT)
X-Received: by 2002:a05:6830:488e:b0:7db:a0b2:b5d5 with SMTP id
 46e09a7af769-7dc27e1ca9cmr8189318a34.24.1776105179660; Mon, 13 Apr 2026
 11:32:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal> <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal> <acvNsvS5ShlQlrox@kbusch-mbp>
 <20260331140309.GH814676@unreal> <acvWplw67b3Gwlkc@kbusch-mbp>
 <20260331190220.GI814676@unreal> <acwkAo2k41xaxdTS@kbusch-mbp> <20260409120415.GF86584@unreal>
In-Reply-To: <20260409120415.GF86584@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 13 Apr 2026 11:32:48 -0700
X-Gm-Features: AQROBzDIIpZEN3aiHYPi89ixDuzK7SpFChCr2JMeXAVEQc6s_3ctAex9jcSvckQ
Message-ID: <CAH3zFs0hx_-3LetSUaPRMg=0jaL=GD7Mop3pEUhJ3O3qkaJrQg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE4MiBTYWx0ZWRfX33FhuU01i5V+
 coUwFtfm8YcnNWsvS+oyr9Sy/aqqRlA4oDHYQcXZUSHV50IyYt2/81lvG6bnYFcBQX5Ch21y7T8
 5yXdFYyzIamqykSQH23p7or8KqIPk//PfntfOeX+/LUyt6spjlATaxrlg1VYvZGP+r8zmtZeLmu
 BdleLPtJYZwAed4nxyMDVIEiF0wCm6snPXohfAAKCWsX8wRib4niNyL/S6usY2VJ19FFqg1ouju
 Ye/1ExbOQghYEv++Rp9kRTg/hmHEhX7ASjQPW4fCsya0bThKawTO5IH6d0sActdlKiCZNzjutDc
 UXOMR//GEAP9RXoS0KtWg2rvti/09spqr3Ti3G9ZrFzMh+TBKlDEHMFJY2zA1QWZtiyOJRXmlvB
 UPeMfeDBxRTlwdzP/ha1iVJvq/tOs5eTEK55lXAuP5zwaDbP/1EBnj2Mq2ckd+sEf5s+SO02hWh
 wY5vUTIqJ0sN+iY6SKQ==
X-Proofpoint-ORIG-GUID: 0W_ZunJfw9CM9d0cv6qD6C5k86-s1kJm
X-Authority-Analysis: v=2.4 cv=e9M2j6p/ c=1 sm=1 tr=0 ts=69dd36dc cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=VwQbUJbxAAAA:8 a=f99BUTzuh9MxvKowt8oA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: 0W_ZunJfw9CM9d0cv6qD6C5k86-s1kJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-19305-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+]
X-Rspamd-Queue-Id: E58D83F2181
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 5:04=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> >
> On Tue, Mar 31, 2026 at 01:44:02PM -0600, Keith Busch wrote:
> > On Tue, Mar 31, 2026 at 10:02:20PM +0300, Leon Romanovsky wrote:
> > >
> > > Right, what about adding TPH fields to struct vfio_region_dma_range
> > > instead of struct vfio_device_feature_dma_buf?
> >
> > You might have to show me with code what you're talking about because I
> > can't see any way we can add fields to any struct here without breaking
> > backward compatibility.
> >
> > If we can't claim bits out of the unused "flags" field for this feature,
> > then my initial reply is the only sane approach: we can introduce a new
> > feature and struct for it that closely mirrors the existing one, but
> > with the extra hint fields.
>
> Something like that, on top of this proposal:
>
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index 3961afa640391..70d5ee1e3ef7b 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -241,9 +241,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_cor=
e_device *vdev, u32 flags,
>                 return -EFAULT;
>
>         if (!get_dma_buf.nr_ranges ||
> -           (get_dma_buf.flags & ~(VFIO_DMABUF_FL_TPH |
> -                                  VFIO_DMABUF_TPH_PH_MASK |
> -                                  VFIO_DMABUF_TPH_ST_MASK)))
> +           (get_dma_buf.flags & ~VFIO_DMABUF_FLAG_TPH))
>                 return -EINVAL;
>
>         /*
> @@ -300,13 +298,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
>                 ret =3D PTR_ERR(priv->dmabuf);
>                 goto err_dev_put;
>         }
> -       if (get_dma_buf.flags & VFIO_DMABUF_FL_TPH) {
> -               priv->steering_tag =3D (get_dma_buf.flags &
> -                                     VFIO_DMABUF_TPH_ST_MASK) >>
> -                                    VFIO_DMABUF_TPH_ST_SHIFT;
> -               priv->ph =3D (get_dma_buf.flags &
> -                           VFIO_DMABUF_TPH_PH_MASK) >>
> -                          VFIO_DMABUF_TPH_PH_SHIFT;
> +       if (get_dma_buf.flags & VFIO_DMABUF_FLAG_TPH) {
> +               priv->steering_tag =3D
> +                       dma_ranges[get_dma_buf.nr_ranges + 1].tph.tag;
> +               priv->ph =3D dma_ranges[get_dma_buf.nr_ranges + 1].tph.ph;
>         }
>         /* dma_buf_put() now frees priv */
>         INIT_LIST_HEAD(&priv->dmabufs_elm);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index e2a8962641d2c..a8b8d8b1a3278 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1497,20 +1497,30 @@ struct vfio_device_feature_bus_master {
>   */
>  #define VFIO_DEVICE_FEATURE_DMA_BUF 11
>
> +struct vfio_region_dma_tph {
> +       u16 tag;
> +       u8 ph;
> +};
> +
>  struct vfio_region_dma_range {
> -       __u64 offset;
> -       __u64 length;
> +       union {
> +               __u64 offset;
> +               struct vfio_region_dma_tph tph;
> +       };
> +       union {
> +               __u64 length;
> +               __u64 reserved;
> +       };
> +};
> +
> +enum {
> +       VFIO_DMABUF_FLAG_TPH =3D 1 << 0,
>  };
>
>  struct vfio_device_feature_dma_buf {
>         __u32   region_index;
>         __u32   open_flags;
>         __u32   flags;
> -#define VFIO_DMABUF_FL_TPH             (1U << 0) /* TPH info is present =
*/
> -#define VFIO_DMABUF_TPH_PH_SHIFT       1         /* bits 1-2: PH (2-bit)=
 */
> -#define VFIO_DMABUF_TPH_PH_MASK        0x6U
> -#define VFIO_DMABUF_TPH_ST_SHIFT       16        /* bits 16-31: steering=
 tag */
> -#define VFIO_DMABUF_TPH_ST_MASK                0xffff0000U
>         __u32   nr_ranges;
>         struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>  };

Sounds good, thanks! We will follow up and move this RFC to a formal patch.

Zhiping

