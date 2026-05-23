Return-Path: <linux-rdma+bounces-21189-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PnjCyD9EGoUgQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21189-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 03:04:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC44E5BC3FD
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 03:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC2E3011847
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2026 01:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E31A6836;
	Sat, 23 May 2026 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fT1NcaLS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D78181ACA
	for <linux-rdma@vger.kernel.org>; Sat, 23 May 2026 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779498253; cv=fail; b=cdASHBTcdOsa92/252GIvo/HHMem0fHY2gb3Ss1pnDHo4CpdGk+CA8uhFzGA6+zOPg/LyjTfNRKs3ENmWoXk+Fg07Zy9iysUbazR8xNMtokQ1Llu0Tj/DL9/BxMglQdQMORcgWKYXWKdnBtJCWpDUQZ1uJ59dAViy2UJG5EkbwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779498253; c=relaxed/simple;
	bh=/A4hX39HcRR7SH4Q02RYznjGYalKTiQUMXi+zCxotsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmz9YtFZxSELKc7WgLt8sgNMWdrwxaRfvBUvGJclEScdhYp1vC/4MvwFp8pW6jLveKhSWTmtabQr+4x/J5nvkhvbSP4rh2G7rTJUZKacj9ghL5dV8lm25HeLVzviC2VsGx5WEjpnDhePLeQJfxw/Q1Md66fwJTHS5PriGbPxS34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fT1NcaLS; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N0cXlg1174553
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 18:04:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ZSYPnXqPgD1WmWUsBlypXTMK46Ru/H45VtdzBiXsUQo=; b=fT1NcaLS0als
	V0CzITn5MusJzO7wCLcepvtcBFTpq0bJwdQSvOVtuXxphbNRdr5w4GkHaTzTSf3+
	1R03uZUVNbYR09SXtNfze33jf0vl16nQtWNHx7IejIEpQwTNM6Zdr4URIJIP4IUZ
	/MxPR0PRQGLKj5okI7T8m28gwIvEkhfg4k5DlHcYM4LKRk6uMqHrbOKc8yy5HHtZ
	5eqDNEm/6fylQhFYaVIcSOMFDFs1Klh81XfuQ3MBoRuhLL4csUmWciCvrsH6JK3j
	sIxVPa7SHf06LM2veBJyy78S1WcvHjVGrhiGukFXNTCVAfsoQEefzYCSC/aL5enj
	hOGP41Rqtg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ea30s35eg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 18:04:10 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-479e99d2aa5so12319561b6e.2
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 18:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779498249; cv=none;
        d=google.com; s=arc-20240605;
        b=iUXW/aC4StiHzdQqYalAaKvTbyhYDwOqF35WxdnKTb1V3wLDwQGgCBgwDOEAlH+JDW
         KCSKOSQLOMYuJbJyZmhVzxLpvav58m7fJbRrBRnxlbuKHDcr8oY/5xgkCWrjllLGE8HE
         qElDfyYfrAT6SCzLtIUjS6cWtjthrJTc9/fVmZvI0op7+GCfmGhSBAB1Qff/o7I/1P6I
         KH8WFqN/gxZb7Y4leXFERs5CaXC+mONZCYjXvDJBdgVi5+ewLKJcAb/cbhDoImrsT3na
         s6DplbmHE7x0yBNmqw5J4JWB0HSxW0cov5Int5WrI8I8vzR0x4TLgsSCVVLjgqhRkV9d
         7EmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ckSywFlrQVuSq3t4EfSWLfDKEF0bsmOAyDZjQDxER6Y=;
        fh=h+xN7aZhKcILBoANaojaKqEohxNFvi6AcKGPrjZMfmo=;
        b=Tr8Y0KQcW70XEbxenSvWCFHOGTEBQ4gTEBmmA4FSa6w3PMTH46am5HJX/byM6/roya
         lEKxrUzq1badsAPPsMZoiHiptYvhZxlnKR8HeNVJoBfOnvqF7WKnj8VCi3Z7txn+vCzK
         YUb6pwkZsE5Uf6J1+p1nLyGWln2JTdvTZq8rvzKgc4d80Tmw4+Hy1OSM83RxUydP771o
         S1f90pBjwueRDzrA17M42vJDAz8dqjFJlBnfRKoYJfYC5e3uUs0t1IbTY50v2ciB+WZu
         FCN0tjo9LzHwJrZZWk1gWTCOI7xMwY8UGXnNSZ+kFSfYY+3tAPeohyHad96qL96MmB7G
         v9mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779498249; x=1780103049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckSywFlrQVuSq3t4EfSWLfDKEF0bsmOAyDZjQDxER6Y=;
        b=UxvdveEx4heK93VOiNnQieczC2R/KsJc2++fkXwL2szLs83D2S0SXD6j4sgdiOSnuu
         81Eyva+uh3BOqu1uyAk32mZat4g4qEh7b5DMazdHgxh/zZvBpWaXrbbobSPjyQLCad5d
         cQKguq2ngNZK/7uA3BUpZqn+4rWr77/rdCFAWP6zxYcN/3jDybjED0+6Jm0nYHJoAbMV
         aqX/rsnC+on7CSUATrbusvMOtORLztuncDCN39yOooJ/l6gJDjyQcV6bGF8p1GLKtZ0l
         lvHlbpcnX2D1ZmIsOFSSmI5U5Lkm9Ot1IbQcSvtSsnQjQ2E4IJ7t9M/BHLJGnpMQ92GX
         RNmA==
X-Forwarded-Encrypted: i=1; AFNElJ8+q09dqdq4/Ih2Gc1mWemtHeh2vx71gHM7YIpz4IOsoQAXGtUDTqKyB5exgVDRJXEIZnG66FIYFopn@vger.kernel.org
X-Gm-Message-State: AOJu0YzVedooSyqSHCCEoxRBGV+C3UUhbq+s3/IxzCId2E4tMOSDsLJ/
	ZjgE0uA7xVDRKIEaRZyWlwv4t349L3tcDc7asbMuVczRHFRiu+pu9M5J3PctIV67g4JKQPwkW79
	FkoNhlN9fhT5jKm1sRowpeWkVWFPU9lQLdKcS9O0gnVd9nQ6Fl2TrjbzzPvEs/EdwU/UGVKCcS4
	XL7eRYrh3y4gAgL8M3L2C1Z0TnW6fFtkB0bzrA
X-Gm-Gg: Acq92OEsJuGvIaBfXSWaFZhpfKnnGaEczZ/RPvoMJcGFuHhCo8Y+jSHxBVTv/a6iKuc
	WUSd24b7cFLddkvOcqo+ms+1XzgdKufmO+YQ0KFkB0Iuu4z9PVtMj5t1evbXxUWotr3ECkt3WZV
	euvhtVGZNUaq4QrPeB8VDhSm3F9rY4vXTD1pjg5TOBwxUpUeY+kTcBxws5wgkpFRbirxidK+N/4
	gIO
X-Received: by 2002:a05:6808:f0c:b0:479:de32:b310 with SMTP id 5614622812f47-48549902f22mr3459522b6e.0.1779498249489;
        Fri, 22 May 2026 18:04:09 -0700 (PDT)
X-Received: by 2002:a05:6808:f0c:b0:479:de32:b310 with SMTP id
 5614622812f47-48549902f22mr3459507b6e.0.1779498248992; Fri, 22 May 2026
 18:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519201401.1558410-1-zhipingz@meta.com> <20260519201401.1558410-2-zhipingz@meta.com>
 <20260521160412.4fa75406@shazbot.org> <20260521162437.406085db@shazbot.org>
In-Reply-To: <20260521162437.406085db@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 22 May 2026 18:03:57 -0700
X-Gm-Features: AVHnY4InmgAbt-a7ZIoyl3OFAhk-P34lQOEjx6K7zj7MuEim3oYM-YaMDsRZ4E8
Message-ID: <CAH3zFs1gh6UZewMf9GJ6CtO5v0yWNokp-eZQ8G2QnyAyxD7-wQ@mail.gmail.com>
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
X-Proofpoint-GUID: PQUwl2yNb6VoriXP2D5Ba3nMRngHvqO_
X-Proofpoint-ORIG-GUID: PQUwl2yNb6VoriXP2D5Ba3nMRngHvqO_
X-Authority-Analysis: v=2.4 cv=Aa6B2XXG c=1 sm=1 tr=0 ts=6a10fd0a cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=LZULGAC3ikq4sroI4wUA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDAwNyBTYWx0ZWRfX40bP6lQSiR6J
 jW0apSZga0W72e2m5q8l/nGRnbkUWOWJwWsikRCvUoLYlLr3TlRg0biFWQXV68nLXEUlyQtAhkR
 npKzfFV/SgtKySX/6orGV1/kFYi+mFMB1Z5ZC9qS+/09qpZXxXpTXchnSUNKbVg2SmbHp8ajLuw
 DVNTOSq80XgUYDVHwWtM25lMXR2HVNV3SA255HUd4crmfsws0VTvTI7/LCIbYN4CGUoLjdK7NoK
 vIi7/liVp4t4lp8EWF97v6Id8v+TgAEgz7X0BAT1ZW8bgjmpAPpHKuNu+SVtDTRhaAJ+kEEe8Ro
 sYfF3/1/KaGFCUZX5q1O2VsenAY3tVsmI/hq2Im2Mg8lmuaAGTyhZWMFV19DAzqF9iH4MilR06D
 dpAfBxbWisRii3eOZ3M5YTlU5M1T3FAEhHFck0qKI8JeL5e8QAuO6w4kicguOQvkmZQgwBezL0N
 cm/aon0ReAXqgK/7+LA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21189-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,meta.com:email,meta.com:dkim]
X-Rspamd-Queue-Id: CC44E5BC3FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 3:24=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 21 May 2026 16:04:12 -0600
> Alex Williamson <alex@shazbot.org> wrote:
>
> > On Tue, 19 May 2026 13:13:49 -0700
> > Zhiping Zhang <zhipingz@meta.com> wrote:
> >
> > > Add a dma-buf get_tph callback for exporters to return TPH
> > > (TLP Processing Hints) metadata, and add VFIO_DEVICE_FEATURE_DMA_BUF_=
TPH
> > > so userspace can attach that metadata to a VFIO-exported dma-buf.
> >
> > This should be two patches, the first extending the dma-buf framework
> > for the get_tph callback for explicit approval from dma-buf maintainers
> > (who are not even copied here).  The second the vfio-pci implementation
> > of get_tph.
> >
> > > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > > uAPI carries both with explicit validity flags so importers get the
> > > value matching their requested width. SET is write-once per dma-buf;
> > > the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI is unchanged.
> >
> > I didn't see what motivated this write-once change, I thought we
> > understood that it was a userspace problem that the tph values need to
> > be set before providing the dma-buf fd to the importer and that races
> > relative to that are a userspace ordering problem.  Write-once seems
> > unnecessarily restrictive and there's no justification provided here.
> >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 134 +++++++++++++++++++++++++++=
--
> > >  drivers/vfio/pci/vfio_pci_priv.h   |  12 +++
> > >  include/linux/dma-buf.h            |  21 +++++
> > >  include/uapi/linux/vfio.h          |  35 ++++++++
> > >  5 files changed, 198 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio=
_pci_core.c
> > > index 3f8d093aacf8..94aa6dd95701 100644
> > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_dev=
ice *device, u32 flags,
> > >             return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> > >     case VFIO_DEVICE_FEATURE_DMA_BUF:
> > >             return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > > +   case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > > +           return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > > +                                                    argsz);
> > >     default:
> > >             return -ENOTTY;
> > >     }
> > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vf=
io_pci_dmabuf.c
> > > index f87fd32e4a01..be1c65385670 100644
> > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > @@ -19,7 +19,24 @@ struct vfio_pci_dma_buf {
> > >     u32 nr_ranges;
> > >     struct kref kref;
> > >     struct completion comp;
> > > -   u8 revoked : 1;
> > > +   /*
> > > +    * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> > > +    * consumed by the @get_tph dma-buf callback.
> > > +    *
> > > +    * @tph_flags is the publish/consume gate: writers populate
> > > +    * @steering_tag, @steering_tag_ext and @ph first, then store
> > > +    * @tph_flags with smp_store_release(); readers do
> > > +    * smp_load_acquire(&tph_flags) before accessing the value fields.
> > > +    * @tph_flags =3D=3D 0 means "TPH not set". Writers publish a non=
-zero
> > > +    * value only once per dma-buf and serialize via vdev->memory_loc=
k;
> > > +    * readers stay lockless to avoid AB-BA against the dma_resv_lock=
 held
> > > +    * by importers.
> > > +    */
> >
> > Can you outline the ABBA hazard, I'm not seeing it.  You're acquiring
> > memory_lock in the feature SET and dma_resv_lock doesn't appear to be
> > held when calling .get_tph().  There's a lot of lockless complication
> > here balanced on this claim of avoiding a hazard that doesn't appear
> > present.
> >
> > > +   u32 tph_flags;
> > > +   u16 steering_tag_ext;
> > > +   u8 steering_tag;
> > > +   u8 ph;
> > > +   bool revoked;
> >
> > If we still used memory_lock for tph, these could be:
> >
> >       u8 tph_st_valid:1; /* memory_lock */
> >       u8 tph_st_ext_valid:1; /* memory_lock */
> >       u8 tph_ph:2; /* memory_lock */
> >       u8 tph_st;
> >       u16 tph_st_ext;
> >       u8 revoked:1; /* dma_resv_lock */
> >
> > The existing change of @revoked from bitfield to bool has no rationale
> > noted for it in the commit log.
>
> On second thought, what dependency does anything here have on
> memory_lock?  I think we're jumping through hoops to avoid a lock we
> don't even need.  If we just want to serialize SET vs get_tph we could
> have a mutex on the dma-buf structure, or use RCU if we want to manage
> it locklessly and make sure get_tph always sees a fully consistent set
> of values.  Thanks,
>
> Alex

Agreed, we don't need memory_lock in this path. For v5 I'll instead add a
struct mutex lock to struct vfio_pci_dma_buf and take it in SET,
get_tph,
and around the priv->vdev =3D NULL store in cleanup.

Thanks,
Zhiping

