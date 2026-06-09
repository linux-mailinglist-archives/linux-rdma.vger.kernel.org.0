Return-Path: <linux-rdma+bounces-22020-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kzadAjgpKGo+/QIAu9opvQ
	(envelope-from <linux-rdma+bounces-22020-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 16:54:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8D5661640
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 16:54:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=bofmRsKL;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22020-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22020-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A74B332021B9
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E918341062;
	Tue,  9 Jun 2026 14:39:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916032E126
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 14:39:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015962; cv=pass; b=cTfpaAWaqqH76KaulixHSG0rmpK63cQRL5lvj2bX/BdI3ch+EA2rhSST0YtotQnLT5RsddFxlnhYuesiGN2Cj2ms3IeV4LMOR0nZcHFw+FAqd4NX+oZ2ioYxEAj0aQg3/KsFM18DrsbBkAUuaQ0J+k6ZR2PJute8Bj4OJP1JJtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015962; c=relaxed/simple;
	bh=FbYR/k8DLxlAf8kVof4hhiKT8ECF5Pd8+LC9O69NXFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSk/iYnYne1FRHchD+y5dVSGBEymKdsB3eCDvVxfp49BU7vzy6/bW5Es+BncZN8qrewXbazYNw/iCsF+NvfcmbsZlti1+SYfD7B3oJTOLhZtiCBq3YKTSYAhW1nzu533mBZtmyyn/Q+c71Ey/fxIbEnqBWdvds8wwRnjbvSQoqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bofmRsKL; arc=pass smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659EYpfX1800003
	for <linux-rdma@vger.kernel.org>; Tue, 9 Jun 2026 07:39:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=kNeH4tXtKNJiFBFWJPRK
	N1EPfU64g+YPkV/H/UdFhBs=; b=bofmRsKLK4osQcAFWiwXbtpr69w36y9aEPuV
	DGBeGSJClR6Iux5v8lxlgpMiVzO5x2Rc7XvV3WDDGERk1A0vudeYRpxUQTgVJ8FP
	Vp24tp6sGkRRtgnEWh5ISlm3X8w10Fv5cHFadx3zazkv3Puh6lk2WAALivP4RcaP
	osrasMZGfR98HjII9TAhAiRWO3neAxrV6MDSF+gSO8eKfKkKXqCwiEoRahlhPycg
	4+6EMm9OA50YdVt23PeVBTNs8CTpAfdAPGVGJTNzDE3Lz+aVd4fRXAzpSV2n29Ro
	DBqbIiI7haSoaEF0q5UsONLcNWq3+7vIqLg83UvH33HJ3kZ2gw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4emgnb8uvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 07:39:20 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6b5976d74so10386289a34.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 07:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015960; cv=none;
        d=google.com; s=arc-20240605;
        b=COrL4azNz4nMT1cSWqkGLtsr7277BUpjtpKACF3llPPC3h26pyYmZ2oUlbu878MsyP
         pbdj8B1MqfZe+Q4x/oMy0TjBMf7ecejpYgnTqnlhhBLywY7awv1hhdpMebyj0JHsotbJ
         6Y0ZF6oP0DBVQHV2aKcop83tumlisq0RhDKvzCWbZ/PRfWD3mmnV+1eTW/YiniNpOR1/
         L7re/L561eVXVuwyZxGkElXni04JhlvE8dhZmps5KcJ4H5NSX+vL0UNE9waPWF+JoH5I
         TWqGBS7K35h3XwfuIcEkrY6BOg+qnMMTf70C4tLliFXn9VQs4pDU+EdjDN6P0zg0nPGD
         +TGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=kNeH4tXtKNJiFBFWJPRKN1EPfU64g+YPkV/H/UdFhBs=;
        fh=V8tv+JEmYiUDZvUX3PA1Z53td/UhrpthuFIUZLr6Tj0=;
        b=dmnKhURx+IeAhhW62FZ4V2Uk+vojqR7aiyY2/uQU9i9FvJUakpbM5WIhXFhilymE1g
         2sNo4VdXlBbeIZ3cvgOKQkpf8aKlxRqjlEsq7/A+VxapJ0DYQxe/MSpbEkoiIelHPfrz
         VXvPN85cLY+qMV54ZYQhW8p3CdulSRnRaMY2YbK7nzJjBh6jphtI004YdbRVw+O6JgHn
         /BbC6Rat+TPgZM4XGb/aG11p/S6N/+6+36J7ExPdirn9nEM156OOtk/UHuNiiRmsaJ9D
         X3VkKwRXcBEcPRMztSrll1FjozgPzgHPDWqxuH8YfSzuZfpxnfC3H8v3BO7ycl1S31ho
         5Zxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015960; x=1781620760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNeH4tXtKNJiFBFWJPRKN1EPfU64g+YPkV/H/UdFhBs=;
        b=NqIee93boecYopKjlZ1louh+xjxnvsKKHQhz94CEV+W911dhkd6OrOEQr2mQFGjSsa
         Eg5howdf4UdP3tj4rlqZbcIQhZmg8/meTfZ92W1R4pDD+ffJwTdKNYyGpW2sgbdIfcEo
         Eh4OgBVAABvr6IDAONYD5CBvPNXaRakpR0KDV2bwy5Dols4FLwCspyCwQhkDhhuxr0/g
         NkiNiJBNZl0uycQ2yXBuUXelG1X7ua5/S3KFG1+e5JrscxPU7Zd4jR6iu8XRMvkHYeBo
         tcdl9/sp6HIDtGy47Q4iCG37+7GTeeiZmxpvB0lJzuJwhxxGb6z/kXAZCX4jFLYsl8z1
         zB+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/iJ1xxSYdMCwZidm0daNgfVk0X3QHfwwzwm84gxe7Ldr6AoxKKJtQAKRa1j8wW4viZbKODQBa+N/La@vger.kernel.org
X-Gm-Message-State: AOJu0YwW5I5OPoxuKXbrOROXLYZkL9+G3r8D/xgvblSu1NQvGWPgznF2
	dbaxGhfP0KGgOTOHSrg4Gy1WxBe2DRofRfUcm4zWl2unyx9MvOUoHRdjnoQrKGKYlnJu2Ao/ZBI
	mUUI+l1770N5/oELU27UbP3OwSVSIFASVcP9VPGXNXX6v8yv2zqIEP39oTfBpdXWYKc80NZjkk/
	N/Ozif08gG1/+JZ1bs41APhYFq5NnCVxIWn05o
X-Gm-Gg: Acq92OEXny0oKtBQ4bQcIjyZwGKCqUNp6OsTTf4msLagSmzc4EentnkEeUWZllKuEY9
	IRLxU0X0VNQg/wVwcOeU5JGQo99cHk0Rs3PTOOPDjxDvcYEllc6K3Xm1olM4z844oRKknI2SlZd
	ZhXOagIySQFPCc2zNmF7Rd48Wxvaq0BJuLlqdG5qiX1d69eWhTyGJVv8kqNVy+vrorA8zC0cV2Q
	RZAXjr+2K2G9NEjG+enPmJ6I/itO05VnkvewBepx2Ltby7FR5E=
X-Received: by 2002:a05:6830:67f8:b0:7e6:ed97:ce6e with SMTP id 46e09a7af769-7e70ca3ef99mr13168179a34.19.1781015959842;
        Tue, 09 Jun 2026 07:39:19 -0700 (PDT)
X-Received: by 2002:a05:6830:67f8:b0:7e6:ed97:ce6e with SMTP id
 46e09a7af769-7e70ca3ef99mr13168142a34.19.1781015959353; Tue, 09 Jun 2026
 07:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com> <20260608185646.4085127-5-zhipingz@meta.com>
 <fdf1bb37-7158-46a0-b6a2-6cca0ac7ae20@amd.com>
In-Reply-To: <fdf1bb37-7158-46a0-b6a2-6cca0ac7ae20@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 07:39:08 -0700
X-Gm-Features: AVVi8CcZCg6NF1_DYHadZzneoVcOoxTF9hqIosFI2rLUJBAF8tno0qEb8k4EdV4
Message-ID: <CAH3zFs2FtVN9LZw487ei6cs3AMwh-30jRHenn3X87PAkZ8CmRA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: q5SjUzMkBjG88zsmQ5YB8kl73aj9V2Zg
X-Proofpoint-ORIG-GUID: q5SjUzMkBjG88zsmQ5YB8kl73aj9V2Zg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0MCBTYWx0ZWRfX7Iwxsu5Pb9RX
 XwDOJEhEMsmxsMF8SYOBaos1b4P7J8AZxJPz6a4cV6WLNKqxQO1TfVeBV4XnC6SXx3Kx0N68sAJ
 +idxo8FltDF1oEHDFvylBu8Y5t0Nu/JpUKn1u5OnJJf52a1JUpa9FO2NnR348+04p5vLuCSaiGB
 oJkuoO7Cp6y+fm4EGikNOanL2qRcSh+bAfAb883vg8SjYRMMfXxiBH9Ua5Mhi4X6KoKJMu2hz2M
 TVpmZKCLW8J9Hh3MR20bPoHovdxlozytFVoPxzvJrG5Rj4A2Osnc89P2ksAyCUHO/Nf2PYmAwrc
 yMMT4BQn+KjuvW3Crhbzsz35uAAHGjGAQKi4UMlaPNpuNAHVxRmRzpfHFb/9U++gMt8SVbAZImy
 Un5zDpi5R3dgH9iXvqOTNV4JXDlT+U4YeLnf5uVGNB7pI5BS7RB7u4U3IkpZGGw6jVN7gbUgxmY
 aByV98s7aQ2KtKEE5QA==
X-Authority-Analysis: v=2.4 cv=a70AM0SF c=1 sm=1 tr=0 ts=6a282598 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=zMbl56DWmGmIhi6d5aIA:9 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22020-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:christian.koenig@amd.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:dkim,meta.com:from_mime,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D8D5661640

> >  drivers/vfio/pci/vfio_pci_core.c   |  3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 92 +++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
> >  include/uapi/linux/vfio.h          | 45 +++++++++++++++
> >  4 files changed, 151 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 050e7542952e..4fa36f2f7555 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 1a177ce7de54..dd11a7db6b41 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -2,7 +2,9 @@
> >  /* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES.
> >   */
> >  #include <linux/dma-buf-mapping.h>
> > +#include <linux/mutex.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pci-tph.h>
> >  #include <linux/dma-resv.h>
> >
> >  #include "vfio_pci_priv.h"
> > @@ -19,7 +21,14 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
>
> > +     /* @tph_lock serializes TPH SET vs get_tph on the TPH fields below. */
> > +     struct mutex tph_lock;
>
> Clear NO-GO.
>
> When that info is exposed through DMA-buf it must be protected by the DMA-buf resv lock.
>
> Christian.
>

Understood, will fix in next revision.

Thanks,
Zhiping

