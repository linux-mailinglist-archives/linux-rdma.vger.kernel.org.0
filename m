Return-Path: <linux-rdma+bounces-22038-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3hALIk6mKGqdHAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22038-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 01:48:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 271A2664D8C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 01:48:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=OZKBis2V;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22038-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22038-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72FFE300AB0E
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 23:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36DA3EFFCB;
	Tue,  9 Jun 2026 23:48:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE2372ED0
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 23:48:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048896; cv=pass; b=QGyRh8ID3cK3dZVElezUYQGMPhaLRCFO3P1X1xzYm1dvsizDVz9j22gn76P4ETbOzCBaVOJQH/0xqg+KkqLIGDpthHYWjkUwQfiKytKHR3K1uTx/rrs0cSU4M19E778TmT1N5dMV7OF3jHfKbOGu4pusADPcI10fxaHIDklEfpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048896; c=relaxed/simple;
	bh=rzFi8rHbjUN/4EV94L92+v7yzItUHCmPw4oD5yP0uJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEn6cAs5v2DhW8sEItyf3npfBn3GE/4z354BbOKlBKFB6Hf+NqpwotIczpleiBmDCE0mzRdfSEAt8JfT0PmMUCkV4U2qQHCuq6ABSgZRYqBQtdpw0uziDbxWlcr4kQ04FkQxUjbvVU4CBPFzMH3dDpotkyKgFfdW/tiJEJn1zs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OZKBis2V; arc=pass smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659FncFN3251896
	for <linux-rdma@vger.kernel.org>; Tue, 9 Jun 2026 16:48:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=2oke7nd3qgzSpwUghUx6
	5sQAoKy1HMHaETHva/Kk8Jw=; b=OZKBis2ViNPY7hO90BNGQapT/XbUSMHitxwk
	n9XV/Gazcj+2wD9m1KqBMuPmB9/KzpVT1nBJ6WPualsEDo7qL0Vtzy+VzpzOy4WO
	VJIhhmj08GYtZwFIjFfi83tEXNicBAxgVk0RaCm2kYxY8pYZ7r7p0XmODAFwWTKL
	TQm2udjgflTsDrm3B3obBvMx4aAmTTMePMUsDel0/p/JTzF3k6rH2qDUyVCJv8XZ
	rvlRdpBmF/Gt6Ek/OaG5ScR5kK8TQn1MNMSEQ16qjRMigOILwgvGGUt7t+zhrnYT
	ox3vb1WsVoPy1SXQ5ySWLbIoP0woSdDUhL2pkCkc2mLTW+2m1A==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4epnt9k6ff-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 16:48:14 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e71adbb398so234418a34.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 16:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781048893; cv=none;
        d=google.com; s=arc-20240605;
        b=hiUvAG9zAmyePYor+eHv7N7dvGTfMjNOeUKlVyzk6YTSrb6SEoLVT4bnM2FEwZYNoM
         nko8dx2Bc30zbZi6Zzu2sRNAy6b/c0M6qhZ6TORP3CwlCIcmwFOfwgn64xT5mk5Aehp5
         PJ/FDJjL/HvpeYsVFb5gyq8wpF6f2fmAXMNCnaIrQ9UiKW8/EIH+cuUupwG+dqG48KKO
         wj7G6fH4rUlGzComfiZYE9g1tXBAr18W5oQt9cuknbYIAekXchjDQymawsEO8OcBleRd
         I6JrcWZug3u9de65NDUwFpiDZh19odLfL5hh+4FQgy2uzbHLZWe90fBeVAD4MtcCEgx5
         DteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=2oke7nd3qgzSpwUghUx65sQAoKy1HMHaETHva/Kk8Jw=;
        fh=l8Uj2uE+S0lqbAmOUWeulp1YTzDr4vIX2xySQ9tjI8I=;
        b=Sf2xgG6hU+u3PEuXjtwkLgRhvDo4GfjDaLD8Cf6N3s9pBjFFgk8i5kTcL33X0d5mD0
         lVONRPNBlTx7ARonQLMeRXECCzZbim4/Bsde2DHHRVlcJpjkPZe5vKZ1KEszxNCyhz71
         Be3BdfIj3rlE0NqgE9zBB10LNCgNEI6hi0KPYjQ+wWQEXWx0J7zLHrsNqE0taMLiupOt
         xsyD3c1ekUwWf7OL/nmkzcnt6N1j/GrglvNlDAQs6TH8jHNPtbST+N6UrLK2pygfxS8s
         QMq/faSL0au0LdA0tgD5g+fvkopKo2yMFYlADTkqnNnEUSGkXT93k9yIIA5aUirRgP6W
         HYbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781048893; x=1781653693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oke7nd3qgzSpwUghUx65sQAoKy1HMHaETHva/Kk8Jw=;
        b=JZe1vS05Ue4WagZSZngm8jCIBcA3NwNH+H9MerwqYcW+ScfYKrLxAg6EHKSoxGr1Qz
         /pne3SzxZ+ggYtYv6d4XOfDP2YMULC+I+d63UrOPeykHChKtIgtwiNE4QlJNNVFhQcS4
         R/mky9Y+rfAkHdl7MIhmX9pFrO824hma0HtJY9N+T/KfWJTGxUH56O155zogOFbFm/1Q
         kxNysyRU8vwv9xmVrjmBOS1veZjiUxMIhdTqpao4rsrzSs/5krcZYT5z/SZMmhFlVRuO
         ACHSLzfjC17qdmkDM15P5jG8Ik5ZlCIgwmHzQGr1y6sdQ3f2sZ+D6TL8Ck0GgEAUf4jz
         lHOg==
X-Forwarded-Encrypted: i=1; AFNElJ/BYQ4wUnOv2Ca15H44NBcmCjkkBsMXEpOTNrsYUoigYgPtc4AbdP0QiQRcAQzokPOsg0a0h96jIJz1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvm3YRNNn75L05e6LRSeXyM6FJsCa+B/AUIxRSqF3C1CPK5pv7
	d4PzfCnIKBDoNiXEabSEGld06dekjvHYwfHtXSoecGgdsq8ie1fIkSRYt7dYB5/Cgrw4JHfL29E
	sFewywZuIGsl1r/5c57FLwi8wYPyWwv1gn6WMM5VmtU7EztR+w5kuj5bg5drEg4c9w2dtpcIWwj
	sNKkdslYZU+VDej+meA9ozcICokAbojdUNygoj
X-Gm-Gg: Acq92OE75yukhBUxFsI+TpeRb5EobmEvEzNib5nCCvKj07DwFHo7BWkYQldKIoZFmaN
	lnsGMMQ2fD8DXDimLexnEJaj8gEr8nMADobrBmvI+hXx4wrA6o2FMn9Hr+1j4EgoLf6PtNUuD1I
	MU8JPGFiwE/Xl+/T3avdQo5B//UHCWTHDXa8NMLx99gRslnPxSC032QECDIavYeP5A7maJHhiVp
	fpE8GDdNmHzsyMjvA9KB5Zw12PcKg==
X-Received: by 2002:a05:6830:4990:b0:7e6:fdea:7aee with SMTP id 46e09a7af769-7e70ca37187mr16012142a34.24.1781048893463;
        Tue, 09 Jun 2026 16:48:13 -0700 (PDT)
X-Received: by 2002:a05:6830:4990:b0:7e6:fdea:7aee with SMTP id
 46e09a7af769-7e70ca37187mr16012114a34.24.1781048892924; Tue, 09 Jun 2026
 16:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com> <20260608185646.4085127-5-zhipingz@meta.com>
 <20260609154634.46ee8328@shazbot.org>
In-Reply-To: <20260609154634.46ee8328@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 16:48:00 -0700
X-Gm-Features: AVVi8Ccv--t4yFPwVmIF6GS96siJpbic6hR37JvTtMZG4eYFQdBVvAgfn5CrAeU
Message-ID: <CAH3zFs2UEpVV2MDkPvd5qW=OAFZ=MFMn1FTTpGa=sM-Kc8vcXw@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: zUff6-gadL2oTby1wgxR9KhAWEvj_9pE
X-Proofpoint-GUID: zUff6-gadL2oTby1wgxR9KhAWEvj_9pE
X-Authority-Analysis: v=2.4 cv=SsCgLvO0 c=1 sm=1 tr=0 ts=6a28a63e cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=Udk1dkG43rCpktSCSPQA:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIyNCBTYWx0ZWRfXxbpSPAE6Sc3n
 uDEriU86zRZNMXyLSehPjwxYRx7ZBycplkFUxgZUNHvzFj40uzSc+UA7P4S3k3PyTcU/P81xtTV
 ZS7XW6uabVldw0SWg2ydddrUKVDim9tc8sGz3y/eFskCfXX1Fec17XeVQH8yNxsoQf0Ry3mCZH8
 g6SKysBAnVZsNBwWMF7qQVxrifC5NIyI+4IRwmTdim/UpGlLfNlqy8AkInB2N5H+uLJLiFXiZZ8
 IhifoocjgbDYs4HPvRRlz1ObYWZTirv0ge9suPIUPmiE2jVBDeofYdbZmH4L7Fl2auwVkawYf/g
 PRZdJQHjJLESCSn++wmgASantjYxxVk0Ni8w1qdjOLYKPp4K0+XkxYadSM1bit2es/HTaZkOlGl
 EoQB7hqz1kI55EPQVT9KdGzfl67NUv0w7qLXK3xHklUl841GcIssn+6pnvez3CwkcleT/ZBkVSw
 PyYUubPFW9F3aVWIDYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22038-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,meta.com:dkim,meta.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 271A2664D8C

> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_tph __user *arg,
> > +                                   size_t argsz)
> > +{
> > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > +     struct vfio_pci_dma_buf *priv;
> > +     struct dma_buf *dmabuf;
> > +     int ret;
> > +
> > +     if (!pcie_tph_supported(vdev->pdev))
> > +             return -EOPNOTSUPP;
>
> This tests for the TPH capability, but the TPH capability is only a
> requirement for functions that generate TLPs with TPH, ie. a requester.
> This feature is about providing TPH steering tags when the device is a
> completer.  Bits 13:12 of the Device Capabilities 2 register indicate
> if the device is supported as a TPH completer.
>
> Additionally these bits indicate if the device supports standard and
> extended TPH, which means we should not only fail if the device reports
> 00b, but should reject extended steering tags unless the device reports
> 11b.
>

You are right: pcie_tph_supported is not correct here.
Let me use a helper function to return something like this:
PCI_TPH_COMP_{NONE, TPH_ONLY, EXT_TPH}.

> > +
> > +     ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> > +                              sizeof(set_tph));
> > +     if (ret != 1)
> > +             return ret;
> > +
> > +     if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +             return -EFAULT;
> > +
> > +     if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> > +             return -EINVAL;
> > +
> > +     /* PCIe TLP Processing Hint is a 2-bit field. */
> > +     if (set_tph.ph & ~0x3)
> > +             return -EINVAL;
>
> Sashiko notes what appears to be a false positive here, the uAPI states
> ph is to be in the range [0, 3] and nowhere else says that it's allowed
> to be garbage for a clear operation.
>

Agreed - i will leave it as is.

> > +
> > +     dmabuf = dma_buf_get(set_tph.dmabuf_fd);
> > +     if (IS_ERR(dmabuf))
> > +             return PTR_ERR(dmabuf);
> > +
> > +     if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
> > +             ret = -EINVAL;
> > +             goto out_put;
> > +     }
> > +
> > +     priv = dmabuf->priv;
> > +     if (priv->vdev != vdev) {
> > +             ret = -EINVAL;
> > +             goto out_put;
> > +     }
>
> Sashiko notes this may need READ_ONCE()/WRITE_ONCE() semantics, but
> that may get fixed as part of the resv lock usage.
>

Ack.

> > +
> > +     scoped_guard(mutex, &priv->tph_lock) {
> > +             priv->tph_st = set_tph.steering_tag;
> > +             priv->tph_st_ext = set_tph.steering_tag_ext;
> > +             priv->tph_ph = set_tph.ph;
> > +             priv->tph_st_valid = !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> > +             priv->tph_st_ext_valid =
> > +                     !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
> > +     }
> > +     ret = 0;
> > +
> > +out_put:
> > +     dma_buf_put(dmabuf);
> > +     return ret;
> > +}
> > +
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> >  {
> >       struct vfio_pci_dma_buf *priv;
> ...
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 5de618a3a5ee..0ca26721849b 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,51 @@ struct vfio_device_feature_dma_buf {
> >   */
> >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >
> > +/**
> > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) metadata
> > + * with a vfio-exported dma-buf. The dma-buf must have been created by
> > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must expose the
> > + * TPH Extended Capability (otherwise the ioctl returns -EOPNOTSUPP).
> > + *
> > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_BUF.
> > + *
> > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) are
> > + * distinct namespaces in the PCIe TPH ST table and may both be present with
> > + * different values. Userspace should populate the value(s) it has from the
> > + * firmware ST table for this device and set the matching VFIO_DMA_BUF_TPH_ST /
> > + * VFIO_DMA_BUF_TPH_ST_EXT bit in @flags. An importer requests a specific
> > + * width and receives the matching value; if the requested width is not
> > + * present, the importer is told TPH is unavailable for this dma-buf.
> > + *
> > + * This publishes the PCI SIG-defined ST/PH tuple for a VFIO-owned PCIe
> > + * completer. The dma-buf core treats the tuple as opaque completer-owned
> > + * metadata; an importer simply requests the namespace it supports and places
> > + * the returned value on generated TLPs.
> > + *
> > + * @flags == 0 clears any previously published metadata.
>
> This is overselling the invalidation.  It only flags the fields as
> invalid for future get_tph() requests, it does nothing to clear
> previously published metadata from importers.  Thanks,
>
> Alex
>

Good catch, let me re-word.

Thanks,
Zhiping

