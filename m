Return-Path: <linux-rdma+bounces-22440-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ig4rLz1qO2p2XggAu9opvQ
	(envelope-from <linux-rdma+bounces-22440-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 07:25:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A73266BB87D
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 07:25:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=i4PMNbop;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22440-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22440-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2F7730148C2
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 05:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B8D188596;
	Wed, 24 Jun 2026 05:25:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D372263C8C
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 05:25:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278712; cv=fail; b=mBWm5vHugXBWCvaDZQhJocfhwJc3sIL+AtVvJPAAp+3aEInu9qFrdfpIJQlqcaBQJ4CzOU2+Gv2ZCnZMZ5mDemspLdzVwM+Rqa+x3L44Pggws75IVSbOC66OBwExE3yge/b+ByFtXiVSmV1lTt74lavcOn87XnnkidVB7zcPgMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278712; c=relaxed/simple;
	bh=yBDNqwXZOFEr8oTP1dC2GtQDxXoVuvUeYCiD4rrRWNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMNvErgClj6KWmGmv+4FRMp0b+/IOVDibhBXV1rKRF3VJ5f3RXqKEPNul3irvMp5yhmpGhshQkRbRU+RqW4aclWZUxgnnZQsO7R0jVY9udbFulMD+z4tiYFw7zp+SCcklFI2vATv+eddzwZife+nhz5A33O3P8tqUsj15AUtfDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=i4PMNbop; arc=fail smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O4toum2572253
	for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2026 22:25:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=obF+BXbpjwuxPtFMpKFj4tWFuIoMfWAxgPOaOEO/2Kk=; b=i4PMNbopiEyN
	dzJXF0sq4fQea/c+oGnEpQ3W40KWgQKMYp94BGV8TEah8W7YPRSPV0TWDxq9lK/c
	IH69OUDDNs4d0nLVIpJwr+XEv92pv/JuZswxBiUsvdERfmY5R4LlqN0TVFMY2Dvn
	08IxKg79hkxPM+eiEkYQh+L2YtGse+/WxlLJoLeIZTZ7DJJufjtjFVKTVUf07DeY
	Q0Fv1ltuXkx9gHTE8OgS6FoI4d2kaZ96QvTwthCibr43A1fFQI9UNcJYigi296TU
	3a6RjwS1xU1710l1vTTAfpyebNS7gpak3yb9NRra53jg5yCM5pdMRjLZuvUzzMdY
	3oI6N0shDA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eyv23dnkw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2026 22:25:06 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e932c1e6d7so1201071a34.1
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2026 22:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782278706; cv=none;
        d=google.com; s=arc-20240605;
        b=ZKq+eaw7DctxQYyNArYMCk/2cAXdNXFuwQqs82cHZm1/CkCa8RSrrjVCvtAOHJ4pkH
         E2yjHYI27cWKbzgC8VfqPQwFcOXAxuMHTfJeUrDSQrzQur1nW9/hHO9riBp1oI9yYB87
         6ykrsxfOCphgE2jObyt1kc2pg2mxQFVvGuuEjPGIsJDgtRo1HZU7a/thMF5SU+pDWqZ5
         2rrJCDYGkLRv3TaUwpNy/4Z7CMlxtQ/AblN/EDvVMlq2nfvcHy7/Zl+oSi/7EvBEBbYD
         4PYYrvP9Tq/jF0WKVn44vp6++wOgecb03SDzZ4Bw7W4ON9nYL/fvyJli6Tgi2JYLisEg
         Gfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=nmAO6MORM+JCILZd6Ab8MnktXVX1EvzetGEcyzVhRCY=;
        fh=m+deAQVrK5A/24IZfGRqlomIE2c/FC56EuVGYb+Ekms=;
        b=OddSH/gI0DahvDMAfc3M1/WwenqLZiD9xpf4B0KrWW8CNAi8NG7JWCxYmMMNw4B5c2
         VTbPgR40zLbKUR6NZP7Wb6G0qXqzxizkEeCBQjXNhXoIDQ6WHp6QM/4Idl9eYJpsopsa
         tTOu/NhC7qTJm28xnReKnvRPgA274eFyM+6K5IxVGEw9dlpIJGVq8fj37V1fWCIwisXD
         Ot/P1xtRMLlKY5DrcEOzjFzJJ2kPNVaUKSVEJIe3+sH7mlbEDPEN+dpgmX0DlzFNSzKV
         vrioWoCwDttDck7lrnu4BVX1jhtPYTQ+uAiuJ9p/1XQE720uyj+Jl9ZeHgxEDbHogxHn
         bD/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278706; x=1782883506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nmAO6MORM+JCILZd6Ab8MnktXVX1EvzetGEcyzVhRCY=;
        b=krLLQOdyPSOvkRUqvTvFqTZKWiKZQQKAKmlooCPmRdIWOtDt2CBAhwFuO/Vyld+PMu
         +/p0vWzjbNtRG3LboGfHzTwxGJ8uJYBZWDWkrl1puHDVU/sHvg2A1IO0Z77/rcMyFY4R
         sTqNJnIBDD54WV/gSp3rJ+34yS7xRrl3f5E7BpJnn4gqqdiMG/K6zaZWdki4J7FgzX1J
         43rItERpG4HVLICS5MvQWvcFjGl4HuX6AxZBUgJriyM0SVv4kiomvxIqSiZ6lJodRpbc
         93JQ6OlB9wy0DUH+QGKC1jdOhXkwF0y29I0s/CWUenQDLv1h3F10wC31YgV4xESjvIo5
         O/uQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mDzxkQqoeC/sNT+vUjkMCforDy+uTn1m6/YOrRLBrKXpyaIAWlEv3Q8B8/gpocTliJUNIVNuSafF+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Zh2lg2DhYw78TQDLGCJru6wUGCqunTqsdqdFt/hQ3dYUe8fZ
	jClpfRD00+7AmkCOmIC1gPoWi+AuqGftZPnLS7fUFck+CxG8NG289IFmYardkr8xnjmHxvvso8+
	jHccCs5/x8b2WfuB27h94XvnaCVQIfv0EtED8k8d1dnTlsayNh2e9DMMAdtUS1YKcYdRpf8Z69X
	fakdQK4OqWp69ljSWw/YA7jO7RiVRptp4h48RX
X-Gm-Gg: AfdE7clzvmT1s6kKFEZdiLHMuXJB+V+xZ58lUrztBB+VECbZbuJzAaA5FKDfIpwQQNk
	BmBfGKNUAJgmS9pq/LU2ZM4HZhNJmaDzKW/0wSzdHCDPrGDrqEuxR0z0rxP+/NsKS2vObsuEhW0
	Xc8mkvPkrPc/uOOU+mTPA//I2eWRGrqWMud8YOakAGCrJc0V7td/8GzFc2zUbois7sh/R+bHhvc
	F+mg1+L7Ik5BYnUyJEfxZ3VaSO12Q==
X-Received: by 2002:a05:6830:6c12:b0:7e6:f4a3:1dfc with SMTP id 46e09a7af769-7e986c83822mr1589293a34.23.1782278705594;
        Tue, 23 Jun 2026 22:25:05 -0700 (PDT)
X-Received: by 2002:a05:6830:6c12:b0:7e6:f4a3:1dfc with SMTP id
 46e09a7af769-7e986c83822mr1589274a34.23.1782278705036; Tue, 23 Jun 2026
 22:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622184211.2229399-1-zhipingz@meta.com> <20260622184211.2229399-4-zhipingz@meta.com>
 <20260623121736.4d9e38b9@shazbot.org>
In-Reply-To: <20260623121736.4d9e38b9@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 23 Jun 2026 22:24:54 -0700
X-Gm-Features: AVVi8CcrRluVCfzsDiRhgyOh9k6XVpc_dByJFZOVuR1nJUXz2ghm7PL2MvWIArU
Message-ID: <CAH3zFs25EfNMRpYTtDTPXNY3FcYg7tYWKExVm-rbcuQRE=qBLw@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA0MSBTYWx0ZWRfXyo9EqgTF0tp8
 iyQwdTw+UX6sI/pxfYK0Uys7GVTc/0+H3sk08gqm4HJEXCawRHepRjLxPVd4l+5mCNNCRFDXvod
 +oRLWb38n8FeJb5+CbX0dbeCGBowe0BaTGWLNcrEegkXAfjD30jmBUH4+SpIdYqQBWR2ScBa/CP
 ByRYpYcLh024yDAM/iUXHKzc+PLvBk1WyDOz8d0KxcusEvHK1gC3gO24/PF1pFJcjV1BrOmfBcW
 +TmSwEoWjAtU8jWUaEhuJdVTQ0BmZSdOHJJyNTby9Vek2EsjvoNR5w/QzQgkNYzhdzWzHjtanjk
 6irVLinB605QPAFGYy6sPhql7kzmQS7qsVO/rkP4In8OUaHJ98f1Cx40VlToyi5YUvGmHem2Zd0
 Ov3+unQhgqtwpTHcLTFjX0I/P7jWLA==
X-Proofpoint-ORIG-GUID: uLtEmuP-PaGUJtxe9a1YfOub-qkcW9JK
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a3b6a32 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=_DGCK_szeJEHVohcwy8A:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA0MSBTYWx0ZWRfXwwLDhcryG+a8
 75MQLD+3Dj8QC9beiTjxScxb8oEvVqtMyurN4b0e75pkI4va3jXygvAHLbu9TLCmP4lSISIcTHZ
 5Qil2gBJs9E+m3wQyQEjZ3NZ5WzlVmQ=
X-Proofpoint-GUID: uLtEmuP-PaGUJtxe9a1YfOub-qkcW9JK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_01,2026-06-23_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22440-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:michaelgur@nvidia.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,set_tph.ph:url,meta.com:dkim,meta.com:email,meta.com:from_mime,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A73266BB87D

On Tue, Jun 23, 2026 at 11:17=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> >
> On Mon, 22 Jun 2026 11:41:36 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Implement dma-buf get_pci_tph for vfio-pci exported dma-bufs and add
> > VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> > for a VFIO-owned device.
> >
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > uAPI carries both with explicit validity flags, and get_pci_tph()
> > returns the value matching the importer's requested namespace or
> > -EOPNOTSUPP.
> >
> > Publish and read the TPH descriptor under dmabuf->resv, matching the
> > locking used for other importer-visible dma-buf state. The SET ioctl
> > takes dma_resv_lock_interruptible(), while the callback runs under
> > DMA-buf's asserted resv lock.
> >
> > Reject requests the device cannot consume as a completer:
> > pcie_tph_completer_type() must report at least
> > PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
> > PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Make PROBE follow the same hardware
> > gate so the feature only probes as supported when the device can really
> > consume it.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |  3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 97 +++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
> >  include/uapi/linux/vfio.h          | 37 ++++++++++++
> >  4 files changed, 148 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index a28f1e99362c..c7d6902bc61b 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1572,6 +1572,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
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
> > index c16f460c01d6..d6f5dd321000 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -3,6 +3,7 @@
> >   */
> >  #include <linux/dma-buf-mapping.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pci-tph.h>
> >  #include <linux/dma-resv.h>
> >
> >  #include "vfio_pci_priv.h"
> > @@ -19,7 +20,14 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
> > +
> > +     /* Protected by dmabuf->resv. */
>
> Nit, it would be more accurate to say:
>
>         /*
>          * Updates protected by dmabuf->resv, @revoked additionally
>          * protected by memory_lock.
>          */
>
> revoked also has an unprotected read, but it's previously existing and
> benign, and likely just needs a READ_ONCE() annotation.
>

Agreed, I'll update the comment and add READ_ONCE() as well.

> > +     u16 tph_st_ext;
> > +     u8 tph_st;
> > +     u8 revoked:1;
> > +     u8 tph_st_valid:1;
> > +     u8 tph_st_ext_valid:1;
> > +     u8 tph_ph:2;
> >  };
> >
> >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > @@ -69,6 +77,26 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >       return ret;
> >  }
> >
> > +static int vfio_pci_dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool e=
xtended,
> > +                                     u16 *steering_tag, u8 *ph)
> > +{
> > +     struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +
> > +     dma_resv_assert_held(dmabuf->resv);
> > +
> > +     if (extended) {
> > +             if (!priv->tph_st_ext_valid)
> > +                     return -EOPNOTSUPP;
> > +             *steering_tag =3D priv->tph_st_ext;
> > +     } else {
> > +             if (!priv->tph_st_valid)
> > +                     return -EOPNOTSUPP;
> > +             *steering_tag =3D priv->tph_st;
> > +     }
> > +     *ph =3D priv->tph_ph;
> > +     return 0;
> > +}
> > +
> >  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachme=
nt,
> >                                  struct sg_table *sgt,
> >                                  enum dma_data_direction dir)
> > @@ -101,6 +129,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf=
 *dmabuf)
> >
> >  static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
> >       .attach =3D vfio_pci_dma_buf_attach,
> > +     .get_pci_tph =3D vfio_pci_dma_buf_get_pci_tph,
> >       .map_dma_buf =3D vfio_pci_dma_buf_map,
> >       .unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
> >       .release =3D vfio_pci_dma_buf_release,
> > @@ -333,6 +362,72 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
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
> > +     u8 comp;
> > +     int ret;
> > +
> > +     comp =3D pcie_tph_completer_type(vdev->pdev);
> > +     if (comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_NONE)
> > +             return -EOPNOTSUPP;
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
> > +     if (set_tph.ph & ~0x3)
> > +             return -EINVAL;
> > +
> > +     if ((set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT) &&
> > +         comp !=3D PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH)
> > +             return -EOPNOTSUPP;
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
> > +     if (priv->vdev !=3D vdev) {
> > +             ret =3D -EINVAL;
> > +             goto out_put;
> > +     }
> > +
> > +     ret =3D dma_resv_lock_interruptible(dmabuf->resv, NULL);
> > +     if (ret)
> > +             goto out_put;
> > +
> > +     priv->tph_st         =3D set_tph.steering_tag;
> > +     priv->tph_st_ext     =3D set_tph.steering_tag_ext;
> > +     priv->tph_ph         =3D set_tph.ph;
> > +     priv->tph_st_valid   =3D !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> > +     priv->tph_st_ext_valid =3D
> > +             !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
> > +     dma_resv_unlock(dmabuf->resv);
> > +     ret =3D 0;
> > +
> > +out_put:
> > +     dma_buf_put(dmabuf);
> > +     return ret;
> > +}
> > +
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool rev=
oked)
> >  {
> >       struct vfio_pci_dma_buf *priv;
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
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 5de618a3a5ee..2d30ba43e2cf 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,43 @@ struct vfio_device_feature_dma_buf {
> >   */
> >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >
> > +/**
> > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) m=
etadata
> > + * with a vfio-exported dma-buf. The dma-buf must have been created by
> > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must rep=
ort
> > + * TPH Completer support in Device Capabilities 2 (bits 13:12); reques=
ts
> > + * carrying VFIO_DMA_BUF_TPH_ST_EXT additionally require the device to
> > + * report the Extended TPH Completer encoding. Otherwise the ioctl
> > + * returns -EOPNOTSUPP.
> > + *
> > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DM=
A_BUF.
> > + *
> > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) a=
re
> > + * distinct namespaces. Userspace supplies whichever values are valid =
and sets
> > + * the matching VFIO_DMA_BUF_TPH_ST / VFIO_DMA_BUF_TPH_ST_EXT bits in =
@flags;
> > + * an importer requests one namespace and receives the matching value.
> > + *
> > + * @flags =3D=3D 0 marks any previously published ST / Extended-ST as =
invalid
> > + * for future PCI TPH queries on this dma-buf.
>
> I think we should avoid "published" as it still suggests we're somehow
> able to invalidate what was previously reported and consumed.  It's
> offset by the trailing clause here, but that's absent below.
>
> Also, we're noting @flags =3D=3D 0 as if it's a special case, but we real=
ly
> need the clarity that if either flag bit is not set, the corresponding
> field is marked invalid for future queries.  Perhaps something like:
>
>    * @flags is the authoritative validity for each namespace: when
>    * VFIO_DMA_BUF_TPH_ST is set, @steering_tag becomes the valid 8-bit ST=
; when
>    * VFIO_DMA_BUF_TPH_ST_EXT is set, @steering_tag_ext becomes the valid =
16-bit
>    * Extended ST.  A namespace whose bit is clear is marked invalid and
>    * reported as unsupported to importers requesting it.
>    *
>    * Each SET fully replaces the dma-buf's TPH state: any namespace not s=
elected
>    * in @flags is left invalid, so @flags =3D=3D 0 marks both ST and Exte=
nded ST
>    * invalid.  This only affects TPH queries made after the SET completes=
; an
>    * importer that has already retrieved a value is unaffected.  Userspac=
e must
>    * therefore configure TPH before handing the dma-buf fd to an importer.
>

Thanks, I'll use your suggested wording here.

> > + *
> > + * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
>
> Slight inconsistency here, @ph.  We might also help to silence the
> Sashiko warning to note:
>
>    * Undefined @flags and @ph bits must always be zero.
>

Yes, I'll fix @ph and add the undefined-bits-must-be-zero wording.

> > + *
> > + * Userspace must publish TPH before handing the dma-buf fd to an impo=
rter.
> > + * Calling SET again replaces the published values.
>
> The above suggestion is meant to replace this as well.
>
> > + */
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
>
> There are several series in-flight contending for device feature
> indexes, so this should really go in through the vfio tree to reduce
> the risk of duplicates.  We also still need acks from the relevant
> maintainers for PCI, dma-buf, and mlx5 before this can be queued for
> v7.3.  Thanks,
>
> Alex
>

Sure!

Thanks,
Zhiping

