Return-Path: <linux-rdma+bounces-20102-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJI0FmGH+2lpcQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20102-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 20:24:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A471E4DF4AB
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 20:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192253026A84
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 18:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9CE48C8C7;
	Wed,  6 May 2026 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ecrKNO8M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDFE4A3412
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091814; cv=fail; b=gEOBDbQq/QSxumTBwseSRHhi6aKRSvvd5eA3lFC+uSdJMfBD20RNthP7yfORk1dpzT9RFUEs2lDEhZuamTie4Wuz21NZtI+p/DsKUeuqg+yj2CbMB+z32t9f5TyPYEo+uckwVUPRnGvlHZHk6wdqNHYuWAR2OYL8cbYP1PglPO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091814; c=relaxed/simple;
	bh=bW6VioqM1I6vjQsLLVeVP3XOu1uhGTd03bArfH78eFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGjncXD/Ubuubgv9OXC60UzuKC9c8zKdtZMcTxv2q5rPOSNiT+iqdSRvo0dM6GHLpsWByFjYBzg+ckjX/n8klewhgPhOojLx7kVtXAgGX3+Oe7axm9grn7UdsrVaHuraXcdi59gOzeHlgSACUI4diYf68IVGL9F8e4P/b8fvmIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ecrKNO8M; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6461tolk1342554
	for <linux-rdma@vger.kernel.org>; Wed, 6 May 2026 11:23:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=2YYLKXiToPfzzk84iAjnpM/kE1au7fYknVhGTQOnVXE=; b=ecrKNO8MJk5q
	oKIjdTP3cT9AdMHpRtYIW89FhY5abcRsfaMChsqaI29WSGcVqrxmCW6KF0syyjsU
	vXI+L5TDYQh9jgaGGd8jj0BHllL5waomMFt0M0n9CBCiB1dPI9YoWYdjX9Ms3CAr
	/SAHXyeletOuK9p8msNRfKXlukH2yHk5gRcTM18srPB6KJhdvGbk2B06ATSaEUy0
	GNA4BpGfx4il8hopju1ylXLm53Xe1Jd0huucKOv9aqixb3LuPoCYJS2o5kzLnMkP
	tS+7rw11iVZoYfP9udWgz/AiMp9YnhOy+Cp1r+syjSjMfpGJEU/w5r3R/fpUCjql
	KHoh0wEEWw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx315pp67-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 11:23:32 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7dbd4fe0e15so46246a34.3
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 11:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778091811; cv=none;
        d=google.com; s=arc-20240605;
        b=AApvAeW677s9TYnK6G/3mZ+9IDhIqjDqaRYpf3aq7mBFm0boy7Arl+nQR1UlLtbcv6
         K/HKgRs7k9a8E6KCGp77TWiw5rEpY1XzYCU4RSpGpVGrzwGho1fsyP9nKfLf9uXEO1Ga
         xOjY1wzcajihQiNBGHRAEra+8PeJMuZT9bLXhPgx8ehpmNAlrNUs3ALkQ70wpPRdcZhj
         Tv5+JifJt0TO0o6ewnb3/L/lONZka2CxoaIlDOHUKFXy88Nbw1rtTogpUJG5+FvTvSe2
         EMADTL21mOgQzEb4uZoXFf+vGjx5qmsGU4Wn+KV2TdBZRKWE49yJu9k58RxEYBvIHKUH
         x9ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=06MsYmJiQI0tIH7Lw/430OArMXdAJd2jDLxFSIS0mBU=;
        fh=gkp3QGeLUVYySA9cajv9rtYFMyjmCr+Mm/RqKMAvRvM=;
        b=jTo3aHv6I/9LylmN2WrRH3L16DYdvKMvefYA6HPl0Ntxsz35U/zrMQZlJiaH62iToH
         ciUncU1Awgs8wdDHxhrGmM9EHNRzfCcorUKAKMnl8bM8DZ+iA6/FOdNUHrKnQcvADlx3
         jGPilZ/OTTmNVEI7drDCzfqMiZPTvndYTug/Sm2wRU806t5CxHN8Y7JjNe9kWYZHGsvS
         2Jif1v+Y7TU2tYaoPNeTnUblwiFRK7bOw2N02I236CpWYSG1Km1H1F9/11c64QO+V+8a
         kuTOAW+wi47Xfju4IlXldZpcPi+G/sdG3W+rmDPBjySCV3Y1xhylK70ukc4Mp5X72vAc
         sjcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091811; x=1778696611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=06MsYmJiQI0tIH7Lw/430OArMXdAJd2jDLxFSIS0mBU=;
        b=crlJjSarsTxpQ0NhWhQLJ+OSY0+Pz5I4rT2izahIk7Ch3mLv6BmlcuYp3Jxp724oZL
         4V3N8aMW6GQEDknsAApCV/jP9whuQTSccastWO3C16sNKqBukcQWmY8d+FbBCw41olbG
         Ii71yJ5+3lr2JqzJGrR/NPbFI2F7a9d0mAIdpQD4FAm1l6qpFrq6JlI4qsHH7F+7cJt4
         h8vZ0c+Rh/fY2aqjUemGa5lZyk7Zo99d/V5R0yNLlTYnZXRHeiBoCgUrqIyderl5T2mI
         GewZ7tZ66+ZTZARn93TNBXqxeSosEHYLPIMbR6Ks/NvZsesU7+F8gwyh4d2/2gnFkauF
         xxqg==
X-Forwarded-Encrypted: i=1; AFNElJ9R9MxkiIpj3h6SjpsKVbjEm2UjTaGXmN4g+LjyKEbm6EHVR5Skrb2dFJ1XqXbX/QxkHHRKtrfbbXHZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+EvJI6SSYzxazVTOrSg5zNY3n+bzc9oi1ACLqOws2wjfkM+E8
	CXer4t5diN0XkQGaO6Vw2ziYzpxgRNA1/a7pW0eH8KYaeMey8VlBNvEOyUu55HXDNLLLyLOUW5l
	tR5ggmQ4pSGrWCWAzpKWcUKSNFuEbyTsXcxRaDTWYI/owf340VN8xFsELyOFFQMY2dy6Bgr2Wej
	4dv5Oit/yGgr983wCQgSaROv+m/tXk3BklktSa4jlhlxkwIFg=
X-Gm-Gg: AeBDietJFI23a3agKWUn5bt40d/wKwGlMx+JaULbPmUysB9jgjV4wDpNsEnv0fr0UvK
	WFF/xb/nZjpb3PLp2HxNg4o1ty6sEiUvW94ONVa/EeyLKQ+6hqS7GiGySUQppfVARESEvpEmEol
	zFtF7IsUjgLISFy0XaKPnP/8uPFPZIYji86/cbpDqkRlWZ/P0NPHIlffMSTfahWEOc/O49Fifm6
	4da/PIyTBJoeO0LY+Ek9lhyDM5PEAJi3pvMjkVSaag=
X-Received: by 2002:a05:6830:4986:b0:7dc:e032:9b5f with SMTP id 46e09a7af769-7e1df220611mr2715783a34.25.1778091811270;
        Wed, 06 May 2026 11:23:31 -0700 (PDT)
X-Received: by 2002:a05:6830:4986:b0:7dc:e032:9b5f with SMTP id
 46e09a7af769-7e1df220611mr2715758a34.25.1778091810773; Wed, 06 May 2026
 11:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com> <20260430200704.352228-2-zhipingz@meta.com>
 <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com>
In-Reply-To: <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 6 May 2026 11:23:19 -0700
X-Gm-Features: AVHnY4Lr6ainK1nflhUwWMi2SscR_b7hHjj8HpGh-ezHilmWJEso71FyiVM42gA
Message-ID: <CAH3zFs2x2QebpqDC0qwQg_GP2FVs-qqNxPupck40cEHNrBMEsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: omVoS6IjK_IEgssBQtlO5Tg2m5oJzeW7
X-Proofpoint-ORIG-GUID: omVoS6IjK_IEgssBQtlO5Tg2m5oJzeW7
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69fb8724 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=jjQCJkVV9gP_kkOIbcAA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4MCBTYWx0ZWRfX6HnI0hJRi73h
 dcDj3LX82UJWaDtJHnUvD83+gJYMVLXynu/9vkgA/YNxVpiLHNkwd0n3Afut7B/yjMDV8M6uwMc
 h8W4JGcuiNqwFFSb1S7bAj6zZHpgZfgWEwSB794zCc5WoRO6NZor9sROLkNYXp2nxyA0Mm0A8JE
 CB5fO44j54rkorBH5euuCKcaYIKL07mGxyChYcpwgJ892fpsSaTaxEX37ivwJ/bBTbexofrROE9
 0qa8jrFhXumNWFgALUus3YNA5Sh8onzopig70BbSqdvY5/TM30SNSwRJUkC5RWsKCkZ3gGjOydo
 Rbm5EEqxHrPnIMtj87AYiJAudbCwB+d+tHPfpdx7A4AIBlcDg6p/5oZyIUsMq2SZu6wrTsrRWUD
 yjVQqE8tcNql1L1Qd+cKkmvveRJkQLdOggui/uoArBa5+M1ulb4zciYxFFtwH5/S1BtUbZDG1E1
 F3qh6xZYUBbwC5NgM1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Rspamd-Queue-Id: A471E4DF4AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20102-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,meta.com:dkim,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]

On Tue, May 5, 2026 at 11:58=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/1/2026 4:06 AM, Zhiping Zhang wrote:
> > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > so peer devices can reuse the steering tag and processing hint
> > associated with a VFIO-exported buffer.
> >
> > Add a new VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
> > VFIO_DEVICE_FEATURE_DMA_BUF along with a steering tag and processing
> > hint, validates the fd is a vfio-exported dma-buf belonging to this
> > device, and stores the TPH values under memory_lock. This keeps the
> > existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI completely unchanged.
> >
> > The user sequences setting TPH on the dma-buf before the importer
> > consumes it.
> >
> > Add an st_width parameter to get_tph() so the exporter can reject
> > steering tags that exceed the consumer's supported width (8 vs 16 bit).
> > When no TPH metadata was supplied, get_tph() returns -EOPNOTSUPP.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
e *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -19,6 +19,9 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > +     u16 steering_tag;
> > +     u8 ph;
> > +     u8 tph_present : 1;
> >       u8 revoked : 1;
> >  };
> >
> > @@ -69,6 +72,22 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >       return ret;
> >  }
> >
> > +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steer=
ing_tag,
> > +                                 u8 *ph, u8 st_width)
> > +{
> > +     struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +
> > +     if (!priv->tph_present)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (st_width < 16 && priv->steering_tag > ((1U << st_width) - 1))
> > +             return -EINVAL;
>
> The checker will failed in following cases:
> 1. If the exporter passed 8bit st, and importer support 16bit st, then it=
 will pass
>    the checker.
> 2. The exporter enabled 16bit st and its st is < 256 (note: the pcie prot=
ocol doesn't
>    restrict 16bit-st must >=3D256), and importer only support 8bit st, th=
en it will also
>    pass the checker
>
> Suggest userspace passing both st(8bit) and extend-st(16bit), and importe=
r chose the
> right one.
>

 Agreed =E2=80=94 8-bit ST and 16-bit Extended ST are distinct namespaces
(firmware returns
them as separate fields with separate validity bits), so a numeric
range check is insufficient.
For v3 I'll change the uAPI to carry both, gated by a flags field:

  #define VFIO_DMA_BUF_TPH_ST (1 << 0)  /* steering_tag valid */
  #define VFIO_DMA_BUF_TPH_ST_EXT (1 << 1)  /* steering_tag_ext valid
*/
  struct vfio_device_feature_dma_buf_tph {
      __s32 dmabuf_fd;
      __u32 flags;
      __u16 steering_tag;       /* 8-bit ST */
      __u16 steering_tag_ext;   /* 16-bit Extended ST */
      __u8  ph;
      __u8  reserved[3];
  };

get_tph() then picks the field matching the importer's st_width and
returns -EOPNOTSUPP
if that one isn't valid.

Thanks,
Zhiping

