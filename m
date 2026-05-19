Return-Path: <linux-rdma+bounces-20990-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFWfCVeWDGp1jAUAu9opvQ
	(envelope-from <linux-rdma+bounces-20990-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 18:56:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1D6582B62
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 18:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BB1B3055952
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 16:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33014EA397;
	Tue, 19 May 2026 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="b7LR6Svc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7F367B80
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209772; cv=fail; b=RYc25jZ+6JhEbLBU73VpHySPBwJYkxzUuAM2VO+YSz85cAgZcsnpTWkHtFiZD2EqrlR2lmGrJW3tXD7bf0qBnB5GJn5L5XKTRkwM0N/fv8JjtG+S5Ba+2DL8c2GNNM25t3v7FIwMKL9q5R/VfCoszfYUgG14GGIbn6ipjPIJbJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209772; c=relaxed/simple;
	bh=/+rl+zGXxntfm2bGL1v8tsZRWvzSR5a1GeZPV80zZ2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaJl+3It3AbERIs3060XWsiim8sDPdmspBfQ8J5jdFTtRENw/1MMSsrk0z/BNh/tfdDgDRVaPZeXs9rmCkYJGQqPZq5MbRrGdFJn1E8h2jS3bXZG+4GZHdOdN7eDkpQdYEJ2+w54eGkc6Ea55h1UeyXCyW6sKjCuy3fjSX7z9ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=b7LR6Svc; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JDZlKj2072118
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 09:56:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=OJtNZW12z9Y05Vrht3lzMMxtJE0LDmlKnN/pERYf24w=; b=b7LR6SvcC44C
	UpwxWr7TYF+7fb+Uzzk2ww5cNZ9ld6C00isxqo7ahUos4G4ySo1jKCXpB2Kvk9LE
	Vc5ab3eqbVVbVgvRv/Cuqh3hqNMpNEkAx65HatqfUBopmFyDqeWWjnXqVkQofFA0
	F3AEy+31DqwwxGy+ncXGfgAWxcKdSH3ur1f3lNyw317XY//cX7BiE396TU+WLM31
	sCZ1a0LIOTRtK+anXD+bpch50n9pFuhxOKxtcXU15cZBamh0GVYLn8rF31dXg+9P
	oFOXOzREYfHk76+VyzzBoRuHef62cW3P6Fh3M7cp3cF16N52lABpWD2/D27H4B7Q
	C2nac3cq+g==
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e8rvv9cdb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 09:56:08 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-439d6202259so7696368fac.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 09:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779209768; cv=none;
        d=google.com; s=arc-20240605;
        b=FHi8xhZAN8BKDmSoSnEVUYjXKHiqFPaOS0emX/diveWZNK1q0S9WpAZeLHEOTx+BfB
         7HsTzv1FIaB7IkUAqwPVF9xdVRGW1Lz59SGTGl50KdCb5+qnvxg9DNEGGeFOc0oWhHbn
         WFFeiJdnHAA99BWxvJiEsNg31WqBIJd8RcpeaQ5JioGfGxTYll/IAVNkfCvWhXu5P9D2
         n2Vi0iBIeRQubRPsBN7WpAvsDqK7ITcKgyS849qYSqnI8+WJ4EixHI/eQE9hSY3ZZdK3
         iGOrhsVg0Wv29a2HRkRrjmXUstJX1NXoyF9XhVgZLdMbOXBBAKeffwmB8CyNNnN8AitF
         2RSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=aJk9gSpAyyZLXyKE7r6q+vOPfRd8FFOsqzGXdkoLHG8=;
        fh=uC9WWn0PwtKSaDIvAdRsi9s/fd9My139s6HwwC/vK2Y=;
        b=G9BlChhLchbTM70u1crxOZVoBBh93DG8qVtC/w7jKEARIgiACb/HPTq/KEOohMhwam
         1NstIom6TqtpIU+XcI4bG6EJ0oT3J2TFFTEvohBqiaBdbvAx9m6NpXXbAlzVrzPoSlHo
         0F/Y9PAerDdsawanVlwOyzFiYCLYQi7UflxrqEHgcLi9FXsz8W/QKVzUNnGCzAyKflRy
         72BGJ4GEhgp2r3NgL01BhF18pxre53nw0o+4jcOtN5/nca/9/K60lcyR08ghziqyIaY2
         toGJyj/GJ0++Nds6cm160BZz4qvgBc0HtRnQxPZJZ82AyL8qX0eKHaeHfY7gtdJ87Mr6
         rllg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779209768; x=1779814568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aJk9gSpAyyZLXyKE7r6q+vOPfRd8FFOsqzGXdkoLHG8=;
        b=IRbXIG/GLpEsV/S2dNI16zd7U1U3BAzlrR4vxW7Mc+NMdxT2lUSQxbsAbiwlAIgoHG
         PAxhAX6Jk1+4iwb1oaItw11Czs73ULboa/8wso3PRyncFBUU5uFWe/pYpXG972RN+2Ud
         nlDFX5X9InUik11lvh3NtJzKfC7dvgHvjIjhbHqOtMCZ57PBvwEIX2rHCVNg9bzyB6K3
         WUWkJ7E730QjPqK8dEWEKvieEOL5hQJK0qI1OLhNeOPwbHtg0hDXzTl5+W+AullcLnmY
         04sEdBQ6LBgYx2YLsiE0f4Nz0XTQA1KqEbcBUzYLbebfEBwJ8mNctNwpRea0TWuUmCKn
         k5fA==
X-Forwarded-Encrypted: i=1; AFNElJ8fvunhIRm5L+2pki5rktCk1zK3Mels6HHOjY5A47ctvCLme/UK0cpuhZaZYB1kH/Yq6bTLZGKRaDbn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpnbx4gpoBUEhvSVOIYEh6HwgOGcTyPPi0G4YKOo/uBXEwe2eQ
	Kl70Ny7VaH33whbCvL0hdqlJXCTa8Y0LRlOYkKbw1VvLbvsv7OvBU3Svzrk+9Y53LRyXjk0XKd/
	8QmpTD3Va/2qxi+FMKdQvaAvLimE1mxKH6QYeLBHGWlA1bZowT8W2bCR2QLrsek0z1QqrNo3Xy4
	4ZgqgO3UmkEgO/+8c+G4A6pcLkx/6gF6Ut7pzn
X-Gm-Gg: Acq92OG2LvGvYsUga8f92+HBcsH9lNHWZn5p2GVhZwfxIcWIh5tsowPHbjxNquSwIfO
	mucknWjHb/RZpixcROooHjYQpsEY11JCfNOP2m3S3UhzIkyQu1mCEGpdrwssukUVJ9/UFceSncF
	vzGut7AoqVFAPqZIxom/+nyG0h5SRCrjexKiCHkjWmTdeugzbmLnHkK22ul3klN4naZRtODnUUB
	JYWZso1+2X6LR0pE68=
X-Received: by 2002:a05:6808:3a14:b0:45e:f0af:5148 with SMTP id 5614622812f47-482e572b473mr12912261b6e.30.1779209767836;
        Tue, 19 May 2026 09:56:07 -0700 (PDT)
X-Received: by 2002:a05:6808:3a14:b0:45e:f0af:5148 with SMTP id
 5614622812f47-482e572b473mr12912231b6e.30.1779209767200; Tue, 19 May 2026
 09:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512184755.4137227-1-zhipingz@meta.com> <20260512184755.4137227-2-zhipingz@meta.com>
 <e6928a10-77b1-4fdf-8bc3-cd0154b4d4c5@huawei.com> <CAH3zFs2W5cB5Jhk8pm9K=O3-DyN3tHm7h5q9Hu26ekV=_gBEvw@mail.gmail.com>
In-Reply-To: <CAH3zFs2W5cB5Jhk8pm9K=O3-DyN3tHm7h5q9Hu26ekV=_gBEvw@mail.gmail.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 19 May 2026 09:55:56 -0700
X-Gm-Features: AVHnY4II7Geh49KwlOFnaMEUnIiyWZTiYUlxcqTc_0jLUETaJ7j0xzUGRx7Zyn4
Message-ID: <CAH3zFs0u2j-PdNjmtCuu8rZm5F0aVQYFo3NuSk0ptByUwrz2ng@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Keith Busch <kbusch@kernel.org>,
        Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2OSBTYWx0ZWRfXx5SXT+fGXEvE
 PFSTCHagUc9vvmv2/y9IeBL6gyvUW/wIwJyypspp4DBev1LIvXWBFtVYu9gSTdG4ZBwl0HYSUfH
 12Y8hi+3CIpXNpl/F1aozp8J8afoiO8//y/R8jCoJ1h81oKcUYFPb/QA382C+IgTUuw9pVTFKZ7
 phmUySLP93RS0P2lPy2FE5hM6w3rIppKvSpnJyNn+6t+uuMdL7MW3BKqevW3phd8G71LSF0ERgY
 8oN3jSwS5RSin3uUitxoDZrBGL4POvLwAm/6SYl6sEZtWg4Skihn0hoyn9NGQ6r1ZIhrvoaTp1v
 gPnthbrpczqLhMoT0fYEszng96f6S0tXKrBgaPckaVsvkRTIfNXOsoQvYoVOGhb7WfLikITssUV
 aClqxfY71rtrSgbXGh9r/tB0rIGpos530ThtK5vDL+iEERW8TkS7bZfeoZIA7YLxOV5YtTW+rmh
 NDI7g8XGPgxCf1REfqw==
X-Authority-Analysis: v=2.4 cv=KfHidwYD c=1 sm=1 tr=0 ts=6a0c9628 cx=c_pps
 a=Z3eh007fzM5o9awBa1HkYQ==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=VabnemYjAAAA:8 a=i0EeH86SAAAA:8 a=Tw_J5DVj0enz2h0_CHoA:9 a=QEXdDO2ut3YA:10
 a=eBU8X_Hb5SQ8N-bgNfv4:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: m6S7ycbqiGjMevj36tc9rbOQcEDe5yS2
X-Proofpoint-GUID: m6S7ycbqiGjMevj36tc9rbOQcEDe5yS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,mail.gmail.com:mid,meta.com:email,meta.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_FROM(0.00)[bounces-20990-lists,linux-rdma=lfdr.de];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+]
X-Rspamd-Queue-Id: DD1D6582B62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 13, 2026 at 11:08=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com> =
wrote:
>
> On Tue, May 12, 2026 at 6:33=E2=80=AFPM fengchengwen <fengchengwen@huawei=
.com> wrote:
> >
> > > >
> > Hi Zhiping,
> >
> > I have several suggestions:
> >
> > 1. In struct vfio_device_feature_dma_buf_tph, steering_tag is defined as
> >    __u16, but PCIe TPH base steering tag is only 8-bit. We can use __u8
> >    for steering_tag to shrink structure size and reduce reserved paddin=
g.
> >
> > 2. The flags field seems unnecessary. We can use value 0 of steering_tag
> >    or steering_tag_ext to indicate the corresponding ST entry is not
> >    available, which simplifies the uAPI design.
> >
> > 3. All TPH metadata fields (st, ext st, ph) fit within 32 bits. We can
> >    wrap them into a union with atomic_t, then use atomic read/write
> >    instead of memory_lock plus smp_load_acquire/smp_store_release. This
> >    makes lockless access cleaner and avoids ordering maintenance.
> >
> > For details, see the text.
> >
>
>   Hi Feng,
>
>   Thanks for the detailed review.
>
>   1) Regular TPH uses an 8-bit ST, while Extended TPH uses a 16-bit ST, so
>   so Extended TPH in Flit mode TLP can carry a 16-bit steering tag in
> the request.
>
>   2) I still think I need an explicit validity indication rather than usi=
ng
>   `0` to mean "not present". ST and Extended ST can coexist with
>   different values (including the value 0).
>
>    3) I also do not think packing the fields into `atomic_t` removes the =
need
>   for `memory_lock` here, because the write side still needs the lock for
>   `priv->vdev` ownership/lifetime checks and the dma-buf list/cleanup
>   paths. Open for discussion, though.
>
>   Thanks,
>   Zhiping
>
>
>
>
> > On 5/13/2026 2:47 AM, Zhiping Zhang wrote:
> > > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > > so peer devices can reuse the steering tag and processing hint
> > > associated with a VFIO-exported buffer. Add a new
> > > VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
> > > VFIO_DEVICE_FEATURE_DMA_BUF along with the TPH values, validates the =
fd
> > > is a vfio-exported dma-buf belonging to this device, and stores the T=
PH
> > > metadata under memory_lock. The existing VFIO_DEVICE_FEATURE_DMA_BUF
> > > uAPI is unchanged.
> > >
> > > 8-bit ST and 16-bit Extended ST are distinct namespaces in the PCIe T=
PH
> > > ST table (firmware reports them as separate fields with separate
> > > validity bits in the ACPI _DSM ST table), so the uAPI carries both
> > > values along with a flags field that indicates which value(s) are
> > > valid for this device. The exporter selects the value that matches the
> > > importer's requested width and returns -EOPNOTSUPP if that width is
> > > not present, instead of substituting a value across namespaces.
> > >
> > > Publish the TPH fields under memory_lock and gate readers on a
> > > release/acquire on the flags field; this lets get_tph() run lockless
> > > and avoids inverting the memory_lock -> dma_resv_lock ordering set up
> > > by vfio_pci_dma_buf_move(). Convert the @revoked bitfield to a plain =
bool
> > > so concurrent updates of @revoked (under dma_resv_lock) and the new T=
PH
> > > fields (under memory_lock) cannot race on a shared bitfield byte.
> >
> > The commit log includes many implementation details, why not remove or =
simply it.
> >

sure, will do!

> > >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > >
> > > ---
> > >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 113 +++++++++++++++++++++++++++=
+-
> > >  drivers/vfio/pci/vfio_pci_priv.h   |  11 +++
> > >  include/linux/dma-buf.h            |  21 ++++++
> > >  include/uapi/linux/vfio.h          |  35 +++++++++
> > >  5 files changed, 182 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio=
_pci_core.c
> > > index 3f8d093aacf8..94aa6dd95701 100644
> > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_dev=
ice *device, u32 flags,
> > >               return vfio_pci_core_feature_token(vdev, flags, arg, ar=
gsz);
> > >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> > >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, =
argsz);
> > > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, a=
rg,
> > > +                                                      argsz);
> > >       default:
> > >               return -ENOTTY;
> > >       }
> > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vf=
io_pci_dmabuf.c
> > > index f87fd32e4a01..28247602e359 100644
> > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > @@ -19,7 +19,23 @@ struct vfio_pci_dma_buf {
> > >       u32 nr_ranges;
> > >       struct kref kref;
> > >       struct completion comp;
> > > -     u8 revoked : 1;
> > > +     /*
> > > +      * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> > > +      * consumed by the @get_tph dma-buf callback.
> > > +      *
> > > +      * @tph_flags is the publish/consume gate: writers populate
> > > +      * @steering_tag, @steering_tag_ext and @ph first, then store
> > > +      * @tph_flags with smp_store_release(); readers do
> > > +      * smp_load_acquire(&tph_flags) before accessing the value fiel=
ds.
> > > +      * @tph_flags =3D=3D 0 means "TPH not set". Writers serialize v=
ia
> > > +      * vdev->memory_lock; readers are lockless to avoid AB-BA again=
st
> > > +      * the dma_resv_lock held by importers.
> > > +      */
> > > +     u32 tph_flags;
> >
> > As subsequent comments, can proceed without tph_flags
> >
> > > +     u16 steering_tag;
> > > +     u16 steering_tag_ext;
> > > +     u8 ph;
> >
> > struct dma_buf_tph {
> >         union {
> >                 atomic_t val;
> >                 struct {
> >                         u16 st_ext;
> >                         u8 st;
> >                         u8 ph;
> >                 };
> >         };
> > };
> > Set and get are done with atomic operation, no need for lock
> >
> > > +     bool revoked;
> > >  };
> > >
> > >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > > @@ -69,6 +85,35 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *at=
tachment,
> > >       return ret;
> > >  }
> > >
> >
> > ...
> >
> > >
> > > +     /**
> > > +      * @get_tph:
> > > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > > +      * @steering_tag: Returns the raw TPH steering tag for @st_width
> > > +      * @ph: Returns the TPH processing hint (2-bit value)
> > > +      * @st_width: Consumer's supported steering tag width in bits (=
8 or 16)
> > > +      *
> > > +      * Return the TPH (TLP Processing Hints) metadata associated wi=
th this
> > > +      * DMA buffer for the requested steering-tag width. 8-bit ST an=
d 16-bit
> > > +      * Extended ST are distinct namespaces in the PCIe TPH ST table=
, so the
> > > +      * exporter must select the value that matches @st_width and mu=
st not
> > > +      * substitute one for the other.
> > > +      *
> > > +      * Return 0 on success, -EOPNOTSUPP if no metadata is available=
 for the
> > > +      * requested width, or -EINVAL if @st_width is not 8 or 16.
> > > +      *
> > > +      * This callback is optional.
> > > +      */
> > > +     int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *p=
h,
> > > +                    u8 st_width);
> >
> > how about rename steering_tag to st?
> >

I'd like to keep "steering_tag" in this signature if you don't mind.
The verbose name keeps the signature self-documenting.

> > > +
> > >       /**
> > >        * @map_dma_buf:
> > >        *
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 5de618a3a5ee..53b2bbd9fc1e 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -1534,6 +1534,41 @@ struct vfio_device_feature_dma_buf {
> > >   */
> > >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> > >
> > > +/**
> > > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints)=
 metadata
> > > + * with a vfio-exported dma-buf. The dma-buf must have been created =
by
> > > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device.
> > > + *
> > > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_=
DMA_BUF.
> > > + *
> > > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext)=
 are
> > > + * distinct namespaces in the PCIe TPH ST table; userspace should po=
pulate
> > > + * the value(s) it has from the firmware ST table for this device an=
d set
> > > + * the matching VFIO_DMA_BUF_TPH_ST / VFIO_DMA_BUF_TPH_ST_EXT bit in=
 @flags.
> > > + * An importer requests a specific width and receives the matching v=
alue;
> > > + * if the requested width is not present, the importer is told TPH is
> > > + * unavailable for this dma-buf.
> > > + *
> > > + * ph is the 2-bit TLP Processing Hint and must be in the range [0, =
3].
> > > + *
> > > + * The user must set TPH on the dma-buf before the importer consumes=
 it.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> >
> > -1 and errno is set on failure.
> >

This documents the kernel-side return value;
the -1 / errno form is what the libc ioctl(2) wrapper presents to userspace.

> > > + */
> > > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > > +
> > > +#define VFIO_DMA_BUF_TPH_ST          (1 << 0)  /* steering_tag valid=
 */
> > > +#define VFIO_DMA_BUF_TPH_ST_EXT              (1 << 1)  /* steering_t=
ag_ext valid */
> >
> > It could be represented by judge whether steering_tag/ext =3D=3D 0
> >
> > > +
> > > +struct vfio_device_feature_dma_buf_tph {
> > > +     __s32   dmabuf_fd;
> > > +     __u32   flags;
> > > +     __u16   steering_tag;
> > > +     __u16   steering_tag_ext;
> > > +     __u8    ph;
> > > +     __u8    reserved[3];
> >
> > How about:
> > struct vfio_device_feature_dma_buf_tph {
> >         __s32   dmabuf_fd;
> >         __u16   st_ext;
> >         __u8    st;
> >         __u8    ph;
> > }
> > If st_ext is not zero means it valid, and also with st field.
> >
> > Thanks
> >
> > > +};
> > > +
> > >  /* -------- API for Type1 VFIO IOMMU -------- */
> > >
> > >  /**
> >

