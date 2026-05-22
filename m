Return-Path: <linux-rdma+bounces-21174-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCCECa/sEGr+fQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21174-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 01:54:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1025BBA0C
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 01:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FE50300D4EB
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 23:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6D0392812;
	Fri, 22 May 2026 23:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HprCEILq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A18376BD0
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779494055; cv=fail; b=sxKwSCLB/ETUpZy23t8RAFTHsAyKofuD9zB2S2ACY3nxpnauthxz4xv0PyPKWz8l4DvexQsoulkTz18mgClCrmwZKtjHT3SRbRAZ+UZDV4D5JwS+PYz6HEoG5tkXb/zslZu/nTFV7+S0kbtfol/aXtyWqYE9blzz10TbgtJAKEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779494055; c=relaxed/simple;
	bh=DNlochln4KieL0hqL78IZaLMDPpl4uvB9y2dcgfjBMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fefk9PRQTMuy6oQl9r5dz+35dK59rnKqz3ZU4LzNs3Tjbws/w61GcN8jk4R7Ovi0ScbpchAF9jh2Pro6tbTriPaDTQnZ6ErPHFtY2OD70P13xlzTp9WwguJH2B9A+F04aZ4kSz3+359c+QYuWtcXueNk88986FQ/vaagnBCz1CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HprCEILq; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64MC4fTJ380426
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 16:54:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=BJr1ZIFg0dApTPOKxEBWywjJAcZm+0SNH1wNhtJCPaQ=; b=HprCEILqoF+v
	cvKFEdCNE4M+GpUSlWvyDFSrqaysRza2gDHyHcQxfxabuxsv4H4440tBNg3URcwe
	IhKiL8qQoEkEObdZ8T4MddEVks4EE4PSO6CZXR/hQWgOqfq0Q+wppM2H8BL8krGN
	uNuClSzb9I25LxnmtHxJuy+WHaYwlKKB9CDPtOCnGGkOzLjs9Gcv159bnoND0fCZ
	RbT7A9qW88aYhXODSOz7vErLtRl5Ls2rPEGm2Ezmoy6XkEhIM094HhFeAV9vJhdS
	beEubh96WirNIK+JJ8565yhP9ZS5sw9XApDZ6Hc8/1BAlCeyVndv+1AQyJfroCFI
	je2kIFe8xg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by m0001303.ppops.net (PPS) with ESMTPS id 4ea5x81gvn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 16:54:11 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e60dfccf42so1682138a34.0
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 16:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779494051; cv=none;
        d=google.com; s=arc-20240605;
        b=aUT7kFlZCQiVBvjaEv+ikGD4RRHPVAfc5QCX/5yUXPhfFKbW4oRGGW/0n/R/drAvYx
         6a2rl8RDm34DfyJFpL/nZvVC54EY4BF5zdy8T3tL2ahYjxUNFaiQh7nhD1yi2Y8U41OZ
         8/pPxz+wwZEJI+/iLZl/SKen/II6mwXBcP1knPHYemFJSDhp8CeVMl6zHuCGkvnhNyjL
         0Xj7t6NczAsjKrM/Wk/XLdTpNQezbMeTCmO0a6Lo6b+SgAEOn4DlwbnAd5jhJ0MO/BdO
         PADHD0BdKYeG44A7e70ipPx+CNlMmA6xW5Q/nUn8feqr7RXExtdXaxxgIrKytPaUEDLW
         I5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=xPbccRhP9AzeKhw0/hE7Uzqn/4Emm7Q1lz66iybs3r8=;
        fh=KBnadZOkBwpO4zSguJl6w1MGkCL5X2NSsqIBuC1OD68=;
        b=U12ivFaZ+Dk0D7Xsxk39L0DONhRbTWrvDxyDaB8Y1tyZWHvttbT2dt73qH7wbU1Ha9
         GZDTvPOd54B+LG2hKb+Jxyb38iwcQAKw1r0oB9Un2NMXkTmqVVY1f8OQdou3nXn5lfDG
         yuMeGtI6VMZK41p0z+zgcqyCffckxpdSY+yVP3CRFINBpldlKuT1nVF4agDIXNS/hXkK
         YLu4IpR7uTcVDWPUpFQ2J8SOIeM0aV2bPfhgE05qC6nSR7wIkKuBZ8fl0FoZBiJGjYuh
         XMJ/QYBJk9EYqQKGhWU/H7IZG5r0y1+FGnBoL9FF02uVkL5E66Ooa0pO6ZmkeALTELbq
         WTow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779494051; x=1780098851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPbccRhP9AzeKhw0/hE7Uzqn/4Emm7Q1lz66iybs3r8=;
        b=OMrc0hBpOluFRkQCk7fItsIRaHU5niIDJwyH1XNumg+lMKP+5Xyu0cFpMwOWcsNB8g
         8pBzzJ912dO9DG0UswYB8uk3rM6HU57JY/9C2/8N58sP97iOwsVkkRM9nHlB7/cHd6Ps
         +gG008WHbiosoE9EQ1QaH2CftTQTQee6IAYO6ZlQi0tAv2xFf/gkXZq3wKR2U/ISUGYd
         mxCHw9Yo1qzUN9d/uJ71E/cGxvNwOvAXMVJ27ULqeBs9PHv1/vA94VtecqZ0mpOa8mu+
         KMZQTw9PnjgY6Ug6O9XmccCKOxcx4GxUVnUizCndUxoec3rMmhKkM4rknAj2cqdbTfpk
         SLQg==
X-Forwarded-Encrypted: i=1; AFNElJ/wlNZmUF6saH/qd1xkGnDvNMb7F0LEtdpd0uCho8Z7wBtimUNKedzE/pDRuLc1hYMHaadkT1aY00g0@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKdqD3yQKEr5Uc3TNhwMaVA0OKlyn/oJijqnzvCDdwfeQK4bi
	XEmN8kawHtYT0DkiAJuCDwdcet82qQRJaSecj/L+7vAeCk6HmFoVGBqITTGISh6slic81Ro+U8J
	vXRvApABfvfY815iSEODPAhNdhwChsOaQiqE5ltyvAwThmgFEdT65GJC/3nqv/ohecFV3kiDW7T
	dfnYVZ9WGOJQNrQjm+4fDU9u+490dGREvqFA/b
X-Gm-Gg: Acq92OHqY7A1m9TkRJhaX+jiIyab/DAFxEMu32ZmS/sn70QQKLIfq2yxKJQ9kTKisHY
	kENiSTqF/29lfDTXdM51hhzKl6CtApICNYZygwoznYurPSGwbjEPwTdSCoiD2A/1XPjRpUPXHfd
	FTVi/g0zhlUwe1oCcuSsoL3Ce3/IJQaHOpvsziGax3b00qbExuIPL4Z7EcQZiKVWBZR30bUO7D+
	nRGdBxx1/34J075EHpFrm5hTUXUIKo=
X-Received: by 2002:a05:6830:3789:b0:7dd:b184:1338 with SMTP id 46e09a7af769-7e5fed5b607mr3897067a34.6.1779494050706;
        Fri, 22 May 2026 16:54:10 -0700 (PDT)
X-Received: by 2002:a05:6830:3789:b0:7dd:b184:1338 with SMTP id
 46e09a7af769-7e5fed5b607mr3897049a34.6.1779494050127; Fri, 22 May 2026
 16:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519201401.1558410-1-zhipingz@meta.com> <20260519201401.1558410-2-zhipingz@meta.com>
 <20260521160412.4fa75406@shazbot.org>
In-Reply-To: <20260521160412.4fa75406@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 22 May 2026 16:53:59 -0700
X-Gm-Features: AVHnY4Kei3lLPfGxalIVqJuqv9pOsHiferZdcWI224JMky8geVIn4yYyhSSh2jY
Message-ID: <CAH3zFs0ZUpHnc2WdyoLQBKuHRVDPNZDO6Zay-caW82Qk5ej+nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=daewG3Xe c=1 sm=1 tr=0 ts=6a10eca3 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=iTjJCpD9-klLVKPjRfgA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: ezT0T3mL6u8WK1eRWqHDqLpRAW7JSP5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzOSBTYWx0ZWRfX+l4V4dboyXOI
 b6N7y9O4gsk637OyxdxPwgisB4M+FtQRHqrIVqonOxa2/frujwKdNU4V7CpVbZ/Rh5QX7qGENQo
 AebcLDh3YPEvO9ekiZRDk2dEd/hhpxSniFD020eaaASgf3TQHByQznOpio35Mdpp6ByzEljPjiE
 /qNRGfNxS5sQ/MLElVpvLwzv6X/J6RVCMsIcKXbHlpnEtNi0CsJVzm/uhfT8XevDQXCCxI9TDwg
 wp5O+gV/N/arnltGJzfOVMkxwHSKEkEBrIRBeZHIbZN0VoyQZHrUg/Hk7/LWGTIgEKJjxHV583Q
 hwc2svhESjCJRje1dmr0koe5mUa29ChEcV24QjHDhk9nZ2uF+YtPtvlq9WkhBnUuF9s0YE1jAGt
 EoYD9LkasNtd/dIy0EhGGLKDxsFivwzLcBsW1inDmtRpnBlH4roEXQgabcqPpXqZCa5et0HbJ1v
 Xhv1WxqAahmKVOsm/PA==
X-Proofpoint-GUID: ezT0T3mL6u8WK1eRWqHDqLpRAW7JSP5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21174-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,meta.com:email,meta.com:dkim]
X-Rspamd-Queue-Id: BE1025BBA0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 3:04=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Tue, 19 May 2026 13:13:49 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add a dma-buf get_tph callback for exporters to return TPH
> > (TLP Processing Hints) metadata, and add VFIO_DEVICE_FEATURE_DMA_BUF_TPH
> > so userspace can attach that metadata to a VFIO-exported dma-buf.
>
> This should be two patches, the first extending the dma-buf framework
> for the get_tph callback for explicit approval from dma-buf maintainers
> (who are not even copied here).  The second the vfio-pci implementation
> of get_tph.

Agreed, let me split. v5 will have:
    1/2 dma-buf: add optional get_tph() callback
    2/2 vfio/pci: implement get_tph and VFIO_DEVICE_FEATURE_DMA_BUF_TPH
I will also add Sumit Semwal and Christian K=C3=B6nig, the dma-buf maintain=
ers.

>
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > uAPI carries both with explicit validity flags so importers get the
> > value matching their requested width. SET is write-once per dma-buf;
> > the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI is unchanged.
>
> I didn't see what motivated this write-once change, I thought we
> understood that it was a userspace problem that the tph values need to
> be set before providing the dma-buf fd to the importer and that races
> relative to that are a userspace ordering problem.  Write-once seems
> unnecessarily restrictive and there's no justification provided here.

Got it, yes the "set TPH before handing the fd to the importer" contract is=
 a
userspace ordering problem. I'll drop write-once. I'll allow SET to
overwrite and
document the ordering requirement in the uAPI comment instead.

>
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 134 +++++++++++++++++++++++++++--
> >  drivers/vfio/pci/vfio_pci_priv.h   |  12 +++
> >  include/linux/dma-buf.h            |  21 +++++
> >  include/uapi/linux/vfio.h          |  35 ++++++++
> >  5 files changed, 198 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index 3f8d093aacf8..94aa6dd95701 100644
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
> > index f87fd32e4a01..be1c65385670 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -19,7 +19,24 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
> > +     /*
> > +      * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> > +      * consumed by the @get_tph dma-buf callback.
> > +      *
> > +      * @tph_flags is the publish/consume gate: writers populate
> > +      * @steering_tag, @steering_tag_ext and @ph first, then store
> > +      * @tph_flags with smp_store_release(); readers do
> > +      * smp_load_acquire(&tph_flags) before accessing the value fields.
> > +      * @tph_flags =3D=3D 0 means "TPH not set". Writers publish a non=
-zero
> > +      * value only once per dma-buf and serialize via vdev->memory_loc=
k;
> > +      * readers stay lockless to avoid AB-BA against the dma_resv_lock=
 held
> > +      * by importers.
> > +      */
>
> Can you outline the ABBA hazard, I'm not seeing it.  You're acquiring
> memory_lock in the feature SET and dma_resv_lock doesn't appear to be
> held when calling .get_tph().  There's a lot of lockless complication
> here balanced on this claim of avoiding a hazard that doesn't appear
> present.

You're right: the release/acquire scheme is solving a problem that
doesn't exist.
v5 will drop it; see the reply to your follow-up for the replacement.

>
> > +     u32 tph_flags;
> > +     u16 steering_tag_ext;
> > +     u8 steering_tag;
> > +     u8 ph;
> > +     bool revoked;
>
> If we still used memory_lock for tph, these could be:
>
>         u8 tph_st_valid:1; /* memory_lock */
>         u8 tph_st_ext_valid:1; /* memory_lock */
>         u8 tph_ph:2; /* memory_lock */
>         u8 tph_st;
>         u16 tph_st_ext;
>         u8 revoked:1; /* dma_resv_lock */
>
> The existing change of @revoked from bitfield to bool has no rationale
> noted for it in the commit log.

Will adopt the bitfield layout you suggested in v5, with the lock annotatio=
ns.

>
> >  };
> >
> >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > @@ -69,6 +86,36 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >       return ret;
> >  }
> >
> > +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steer=
ing_tag,
> > +                                 u8 *ph, u8 st_width)
> > +{
> > +     struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +     u32 flags;
> > +
> > +     /* Pair with the smp_store_release() in VFIO_DEVICE_FEATURE_DMA_B=
UF_TPH. */
> > +     flags =3D smp_load_acquire(&priv->tph_flags);
> > +     if (!flags)
> > +             return -EOPNOTSUPP;
> > +
> > +     switch (st_width) {
> > +     case 8:
> > +             if (!(flags & VFIO_DMA_BUF_TPH_ST))
> > +                     return -EOPNOTSUPP;
> > +             *steering_tag =3D priv->steering_tag;
> > +             break;
> > +     case 16:
> > +             if (!(flags & VFIO_DMA_BUF_TPH_ST_EXT))
> > +                     return -EOPNOTSUPP;
> > +             *steering_tag =3D priv->steering_tag_ext;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     *ph =3D priv->ph;
> > +     return 0;
> > +}
> > +
> >  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachme=
nt,
> >                                  struct sg_table *sgt,
> >                                  enum dma_data_direction dir)
> > @@ -84,16 +131,17 @@ static void vfio_pci_dma_buf_unmap(struct dma_buf_=
attachment *attachment,
> >  static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
> >  {
> >       struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +     struct vfio_pci_core_device *vdev =3D READ_ONCE(priv->vdev);
> >
> >       /*
> >        * Either this or vfio_pci_dma_buf_cleanup() will remove from the=
 list.
> >        * The refcount prevents both.
> >        */
> > -     if (priv->vdev) {
> > -             down_write(&priv->vdev->memory_lock);
> > +     if (vdev) {
> > +             down_write(&vdev->memory_lock);
> >               list_del_init(&priv->dmabufs_elm);
> > -             up_write(&priv->vdev->memory_lock);
> > -             vfio_device_put_registration(&priv->vdev->vdev);
> > +             up_write(&vdev->memory_lock);
> > +             vfio_device_put_registration(&vdev->vdev);
> >       }
> >       kfree(priv->phys_vec);
> >       kfree(priv);
>
>
> This seems unnecessary.  I think this is just because priv->vdev is now
> (unnecessarily) set via WRITE_ONCE, right?  These are very well ordered
> paths, prior to exposing the dma-buf, while the device is opened, during
> release, after release. They don't seem to need the READ/WRITE_ONCE
> treatment.  This looks like noise from trying to make it lockless.

Got it, this is fallout from the lockless attempt. priv->vdev
transitions are already
well-ordered by memory_lock. I'll drop all the READ_ONCE/WRITE_ONCE on
priv->vdev in v5 and leave the existing accesses as they were.

>
>
> > @@ -101,6 +149,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf=
 *dmabuf)
> >
> >  static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
> >       .attach =3D vfio_pci_dma_buf_attach,
> > +     .get_tph =3D vfio_pci_dma_buf_get_tph,
> >       .map_dma_buf =3D vfio_pci_dma_buf_map,
> >       .unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
> >       .release =3D vfio_pci_dma_buf_release,
> > @@ -269,7 +318,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
> >               goto err_free_priv;
> >       }
> >
> > -     priv->vdev =3D vdev;
> > +     WRITE_ONCE(priv->vdev, vdev);
> >       priv->nr_ranges =3D get_dma_buf.nr_ranges;
> >       priv->size =3D length;
> >       ret =3D vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
> > @@ -331,6 +380,77 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
core_device *vdev, u32 flags,
> >       return ret;
> >  }
> >
> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vde=
v,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_=
tph __user *arg,
> > +                                   size_t argsz)
> > +{
> > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > +     struct vfio_pci_dma_buf *priv;
> > +     struct dma_buf *dmabuf;
> > +     int ret;
> > +
> > +     ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> > +                              sizeof(set_tph));
> > +     if (ret !=3D 1)
> > +             return ret;
> > +
> > +     if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +             return -EFAULT;
> > +
> > +     if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_E=
XT))
> > +             return -EINVAL;
> > +
> > +     if (!set_tph.flags)
> > +             return -EINVAL;
> > +
> > +     /* PCIe TLP Processing Hint is a 2-bit field. */
> > +     if (set_tph.ph & ~0x3)
> > +             return -EINVAL;
> > +
> > +     dmabuf =3D dma_buf_get(set_tph.dmabuf_fd);
> > +     if (IS_ERR(dmabuf))
> > +             return PTR_ERR(dmabuf);
> > +
> > +     if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops) {
> > +             ret =3D -EINVAL;
> > +             goto out_put;
> > +     }
> > +
> > +     priv =3D dmabuf->priv;
> > +     down_write(&vdev->memory_lock);
> > +     if (READ_ONCE(priv->vdev) !=3D vdev) {
> > +             ret =3D -EINVAL;
> > +             goto out_unlock;
> > +     }
> > +
> > +     /*
> > +      * TPH metadata is write-once per dma-buf so that lockless reader=
s only
> > +      * have to observe a single release-published transition from 0 -=
> flags.
> > +      */
> > +     if (READ_ONCE(priv->tph_flags)) {
> > +             ret =3D -EBUSY;
> > +             goto out_unlock;
> > +     }
> > +
> > +     priv->steering_tag =3D set_tph.steering_tag;
> > +     priv->steering_tag_ext =3D set_tph.steering_tag_ext;
> > +     priv->ph =3D set_tph.ph;
> > +     /*
> > +      * Publish the TPH values before the gate flag, so that lockless
> > +      * readers in vfio_pci_dma_buf_get_tph() see fully-initialized
> > +      * fields once they observe a non-zero tph_flags.
> > +      */
> > +     smp_store_release(&priv->tph_flags, set_tph.flags);
> > +     ret =3D 0;
> > +
> > +out_unlock:
> > +     up_write(&vdev->memory_lock);
> > +out_put:
> > +     dma_buf_put(dmabuf);
> > +     return ret;
> > +}
> > +
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool rev=
oked)
> >  {
> >       struct vfio_pci_dma_buf *priv;
> > @@ -388,7 +508,7 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_=
device *vdev)
> >
> >               dma_resv_lock(priv->dmabuf->resv, NULL);
> >               list_del_init(&priv->dmabufs_elm);
> > -             priv->vdev =3D NULL;
> > +             WRITE_ONCE(priv->vdev, NULL);
> >               priv->revoked =3D true;
> >               dma_buf_invalidate_mappings(priv->dmabuf);
> >               dma_resv_wait_timeout(priv->dmabuf->resv,
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_p=
ci_priv.h
> > index fca9d0dfac90..c58f369be4b3 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -118,6 +118,10 @@ static inline bool vfio_pci_is_vga(struct pci_dev =
*pdev)
> >  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u=
32 flags,
> >                                 struct vfio_device_feature_dma_buf __us=
er *arg,
> >                                 size_t argsz);
> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vde=
v,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_=
tph __user *arg,
> > +                                   size_t argsz);
> >  void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool rev=
oked);
> >  #else
> > @@ -128,6 +132,14 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core=
_device *vdev, u32 flags,
> >  {
> >       return -ENOTTY;
> >  }
> > +
> > +static inline int
> > +vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev, u=
32 flags,
> > +                               struct vfio_device_feature_dma_buf_tph =
__user *arg,
> > +                               size_t argsz)
> > +{
> > +     return -ENOTTY;
> > +}
> >  static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_devic=
e *vdev)
> >  {
> >  }
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..49eb6ad644a2 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,27 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @steering_tag: Returns the raw TPH steering tag for @st_width
> > +      * @ph: Returns the TPH processing hint (2-bit value)
> > +      * @st_width: Consumer's supported steering tag width in bits (8 =
or 16)
> > +      *
> > +      * Return the TPH (TLP Processing Hints) metadata associated with=
 this
> > +      * DMA buffer for the requested steering-tag width. 8-bit ST and =
16-bit
> > +      * Extended ST are distinct namespaces in the PCIe TPH ST table a=
nd may
> > +      * both be present with different values, so the exporter must se=
lect the
> > +      * value that matches @st_width and must not substitute one for t=
he other.
> > +      *
> > +      * Return 0 on success, -EOPNOTSUPP if no metadata is available f=
or the
> > +      * requested width, or -EINVAL if @st_width is not 8 or 16.
> > +      *
> > +      * This callback is optional.
> > +      */
> > +     int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
> > +                    u8 st_width);
> > +
> >       /**
> >        * @map_dma_buf:
> >        *
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 5de618a3a5ee..a9cb6cbc6ade 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,41 @@ struct vfio_device_feature_dma_buf {
> >   */
> >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >
> > +/**
> > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) m=
etadata
> > + * with a vfio-exported dma-buf. The dma-buf must have been created by
> > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device.
> > + *
> > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DM=
A_BUF.
> > + *
> > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) a=
re
> > + * distinct namespaces in the PCIe TPH ST table and may both be presen=
t with
> > + * different values. Userspace should populate the value(s) it has fro=
m the
> > + * firmware ST table for this device and set the matching VFIO_DMA_BUF=
_TPH_ST /
> > + * VFIO_DMA_BUF_TPH_ST_EXT bit in @flags. An importer requests a speci=
fic
> > + * width and receives the matching value; if the requested width is not
> > + * present, the importer is told TPH is unavailable for this dma-buf.
> > + *
> > + * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
> > + *
> > + * The user must set TPH on the dma-buf before the importer consumes i=
t.
> > + * TPH metadata is write-once per dma-buf; a second SET returns -EBUSY.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > +
> > +#define VFIO_DMA_BUF_TPH_ST          (1 << 0)  /* steering_tag valid */
> > +#define VFIO_DMA_BUF_TPH_ST_EXT              (1 << 1)  /* steering_tag=
_ext valid */
> > +
> > +struct vfio_device_feature_dma_buf_tph {
> > +     __s32   dmabuf_fd;
> > +     __u32   flags;
> > +     __u8    steering_tag;
> > +     __u8    ph;
> > +     __u16   steering_tag_ext;
> > +};
>
> Sure is tempting to make the ph field the first 2-bits of u8 flags.

I went back and worked through the layout both ways and I'd actually
like to keep ph as
its own field. I think the separate ph field reads better and costs nothing.

> Thanks,
>
> Alex

Thanks,
Zhiping

