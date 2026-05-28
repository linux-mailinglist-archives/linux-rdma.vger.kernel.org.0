Return-Path: <linux-rdma+bounces-21411-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP5PAtLKF2o7RAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21411-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 06:55:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F75EC947
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 06:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66BFE30B63D8
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 04:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB9A314B6D;
	Thu, 28 May 2026 04:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AIyX69k6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7E3115B8
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 04:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779944137; cv=fail; b=EzXUPmqqi3AWJ088GDqHsFYFivyPVM6tOyFQuWtfhzyUszp1MGfQoKiLsrczKXwQB7f8B8ab99d4BS1B87YYQlEmK2ydX7OCn/fpVf7ONCxnffpITTtKJmLglDdP5WIuV/PbIrQntY1QgnM8nE5i//8Kyp38NCnVvdPrV9UMi3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779944137; c=relaxed/simple;
	bh=CYYXlTA7hFjEhQyRif4MBMndMkIgqNioaptIr/n0Y0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO3bEtNoz6OmBqNGe9HNbYV3eatnpcYVjNMyIGKMw6XmdqmWOYYGUjaO7nBNypLz2zCldt4+qC1tFlgMtNPESXUhJ39LDuV6CXcch9iNTByImzZbx6IsBa1pMoJ5BOeVKbdS/wPsiZNb28X2bX4AuTcs5xQF5HYsTuCNF4NxgUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AIyX69k6; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKoFNx257274
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 21:55:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=CYYXlTA7hFjEhQyRif4MBMndMkIgqNioaptIr/n0Y0M=; b=AIyX69k6A+c9
	mM1a5KjBZFSdIajJE7N6M+mQ7sGkngpIAcWIEq6pqulW9U5nSY+gI6sFNht86O+Z
	2D6jvDhopxPYZ1YE7naoN5Kloh1FC7xqcci30zbsC9zqOK5hXC7sYrpQFtCwvBAF
	CM6JDW47bs/SUBHJiMz/+G0F/SU/VgcW4J5HaITGfovQtixxblrvL48RNOE4hkl4
	QSltZkNb8/8gzsiQJteEhsP1K0aDt00kHUNwGqFqoNzF4bdIzG4nAfjSr3a8Np3W
	FHPEHYqrWlMwWuCKKAYylzQAXpY1Mcpxe88gvgN6QcAwDuFO547/X8h14sWFBIaG
	Xo82qWEcqw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee808t6h5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 21:55:35 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e56d2d6b9dso6352667a34.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 21:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779944135; cv=none;
        d=google.com; s=arc-20240605;
        b=OnNLBboLIoEk/p4GtCKLKRyhuk7C+x2Ex6e8izxh7xMN5EVlYzWco+OPelZA4lBCzq
         J8iGC4C4RziMiZ7XtZNSf/lXHfljIUmkATxXTgubwXYYeNN4nPzUILZSChDlhVbZx35H
         Lc1733YaVK8E7Nspi/mrPf1VPtNGu+S/XlOn+KZjfKaEIhrOPjzQ/7Q5JshJZc/7xWvV
         q1+1W5vMXfvFmzwGZ877E6nBBN53tuXIUHEfeqXCDTKfq7wfd8Haaz56/2YyLx97VhoL
         JRPCrYduuvFRTwvi4f4YBxTsZPlbL5o/ZG/43T3BpxR4xWIMCItYMRcO0WtR8VcJ4KRf
         s5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=2lex2yvH679GF+7VuxlXdYUBKG+oUT1Bop2JInZINhU=;
        fh=iKTWlsOGz7bil+zqIloHqYolUNw4decFHiXsoUzXgf0=;
        b=BS8pOU8LbKxILcbplPHUorIvlYKs1TZO++4A9GvrZQdCzlP7UPBNzVv3OTNGOVU5IG
         cppSdbA88NvuVM6Rs5rk2p7mibsj+xjAuG+/Jn9fiFh/8xnt3UtozTce/avqOpFsVWTA
         PNXH+vnJxnijwCqMsHGjzZYcQJ/298DmNtD/ApA386WIMmjdq4qIkAZ77EBksL6wDFqp
         3Hbu+GtbedRAJD4K7QatkxE68yecZUq42q9bRtBsDSFUzs8adeSqUGlc/hAFBgkDP2QU
         vZw9ThVcKfHPOYNPmP6y3r+3raieDvKDkcUTvtllT9VavZbL79RWh6JvM/JsmQZWthM0
         dOyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779944135; x=1780548935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2lex2yvH679GF+7VuxlXdYUBKG+oUT1Bop2JInZINhU=;
        b=s/r1ojLV/0IZizgNcvWOTqXNZ1TmrXGsPk7Obew+eoBSQBFlCvstZ3NjMr/PWVG36Z
         tA2CkwvuxDQURRHyqZDgk25MSSwHcOULp+de9X6J+HErkClHJ3cT20Ri65BPfrvFMDmk
         dUvSX6xc1iuQQGzvGl7ZlsnDrwyhevo7zsl8jRo9MmkCvlQ802jRo6AAiCH4rbtKL5Lm
         bWPUsbtDW56GF8VqxpQTKYpodMk7jqlXDOMMuUudG3na0HBUBREzB8ZUgeGR27E7Iiy9
         F4Vziph4v1CcaJDdrqGltbBrg6Q3Kgc80HBmGnAEdCF0YWBZpa2N7NhoUhIP/LKHiW3r
         L1Sg==
X-Forwarded-Encrypted: i=1; AFNElJ9Be/d+aWzi48kX68x8dQkEB3GD0swMcLFDCyhUUeL2kDtuYvmjRhg5qJjVfhPoz6xnN3w3Jevl2Jdr@vger.kernel.org
X-Gm-Message-State: AOJu0YyUjbwK1q0nb0C2SROoOlDd5u/QEUrALvMDdnSNFe1Wy4+uXwDW
	+M6B/9ZDfAwKmTNAMdcuRAABI3gHdmS/ZlHxH40NFOV+v74TAIV7ZoU/fYmS0qJqFzRYgJrA1UV
	h6qP7M1NGQHPpWQD0fx6FzOEJejFMbp39KfBM2CurlcSytmssK2Fv7U425xyLW19GonvcAkOicx
	5ECRSqfcUvfu5r8LQuPQmgXfHhSvKBMIduO0jB
X-Gm-Gg: Acq92OEd8yJODMJfFdbWUUpvKSX9PeWO/I9gCRtXoABM9T5pdJPTOzTyvgUxLn2Dcgs
	fWaCT4f21tZozoFYlO9uON4o0yZFj/bA+kEyUxjAnwJ7K2TvpE7FfP9/9kA0lAsCn7GuYvMesAs
	7PN8cXllBPgY+RQCae0uXC0fFbEyersUwucDnMwR6pAIY4lA8B1FmHEuKspb7qUQZ5mwHMEfBrC
	Y6hfZmcwOfmezdhOcuBJ0S5vFs2nN9NOQksn3KiRQRi5ejbKJc=
X-Received: by 2002:a05:6830:452a:b0:7d9:7209:4378 with SMTP id 46e09a7af769-7e5fee23f0bmr17184405a34.17.1779944134688;
        Wed, 27 May 2026 21:55:34 -0700 (PDT)
X-Received: by 2002:a05:6830:452a:b0:7d9:7209:4378 with SMTP id
 46e09a7af769-7e5fee23f0bmr17184388a34.17.1779944134274; Wed, 27 May 2026
 21:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca> <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca> <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
In-Reply-To: <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 21:55:23 -0700
X-Gm-Features: AVHnY4KjB7ggvEym3yYxunms23zRrE8n2XXaWHSRU_rJj67WeYLMsK98_vs1TJk
Message-ID: <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 5vEJFjdBDxaFsK21rZ64YkpvANd-tW0y
X-Authority-Analysis: v=2.4 cv=UYZhjqSN c=1 sm=1 tr=0 ts=6a17cac7 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=zd2uoN0lAAAA:8 a=Vls0teBZlVDq3xJ5GeUA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0NSBTYWx0ZWRfX6kCuufptnsA7
 21SKZ6WK9/McBNJODrBkcr1MwY9+nYP6PO9ht4AP+dwlGrWJ1AEVUiGlwYAq0PCPboy3mtJMzXh
 s9GXU3xEFcMMWGXIAp/gTMoqDgV3QjgAXp1VQDOJCYdHYemP7Xn2I+kSJHHFdiyKgoGu+qQS+cG
 0SzDpfPQI4b/c1TH+w86M1Fm4SyNrScZKEv/6aMN7iO5GF6SSUBrYT4ClV8uS8oCoo8tJfKNQBH
 fWbqzm/9PBmY8o80C+CGViXah3um6aEMz6IHW6J9dvgWW/GUiB6Lzmi88Zis4qvenegJYDslycj
 SG2PLv8LY+B19iaf3TRm+WVNt2Sg+J3RNfZd+WJc7FyQ4gObXD/qy5jsz8hXwV3Ax2bBqo4X8aM
 8QMYFbzSiQgul5tyX98HZKXYl/1DBmBpnMTLj6TDBuqbsiknJfGaoqjXTZOFW6vO0noMD3Vb/yz
 4d3ikWglbKid0CoV/Ng==
X-Proofpoint-GUID: 5vEJFjdBDxaFsK21rZ64YkpvANd-tW0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21411-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,amd.com:email,meta.com:dkim]
X-Rspamd-Queue-Id: A07F75EC947
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 5:53=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 5/27/26 14:36, Jason Gunthorpe wrote:
> > On Wed, May 27, 2026 at 02:23:46PM +0200, Christian K=C3=B6nig wrote:
> >
> >> Yeah that's a good point, I should probably rephrase the question.
> >>
> >> I'm aware of how TPH works by adding the extra ST to the TLP.
> >>
> >> But my question is how is that useful to a PCIe endpoint? What is the =
effect of the ST here?
> >
> > TBH I've never heard Meta explain what their device is doing with
> > it. At least it seems to be super important to their device..
>
> Yeah I think at least a brief description of what is going on here would =
be necessary for the review.
>
> Otherwise we have only the info that the exporter wants to give an opaque=
 ST for the importer to use and no technical description what that is good =
for, how to test it etc...
>
> Regards,
> Christian.
>
> >
> > Jason
>

Fair point =E2=80=94 I'll add a couple of paragraphs to the v6 cover letter=
 and the
patch's changelog as well.

The short version: in this series the vfio-pci device is the completer
of the P2P
writes and mlx5 is the requester. As Jason noted, ST semantics on the compl=
eter
are implementation-defined, so only the driver that owns the completer (her=
e,
vfio-pci on behalf of its userspace owner) can hand out a meaningful ST; the
importer treats it as opaque and just places it on the TLP.

Validation occurs at two levels: PCIe analyzer captures on P2P TLPs, and the
 end-to-end P2P workload yields only expected results.

Thanks,
Zhiping

