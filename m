Return-Path: <linux-rdma+bounces-22345-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7wmzJMGLM2oXDQYAu9opvQ
	(envelope-from <linux-rdma+bounces-22345-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 08:10:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E8669DCB9
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 08:10:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b="v/PNqA1x";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22345-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22345-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA1873016023
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EEF33260F;
	Thu, 18 Jun 2026 06:10:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7987331214
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 06:10:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781763006; cv=fail; b=qxPHGoYSDBvyamC+M5hSj6Sol6E61krww+WKHkCxissp2b34vi2Cval5ialCvJaerSW16GnN7U0y2iXDTrutScDzp6LxiwKXx2VC4ypYNiZjzyYBPguuhTlI38davtVaLl6RoAgVDc6aedqasrzBKZ742vEzDoFtk05lokOUfkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781763006; c=relaxed/simple;
	bh=6/T0Dclshlhmnc1UxrEhCEHM4cymDyecbTC6Ux8+uFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPIyHUXHNfNdorHc/GRLPRIXB6d97OCRzJUvQdKqyIdDOMx1sNxN+SN1J3JuV71FFcI6wui/o2JatU3hoMd9b+iyDt+NDOyaGfEY/jZAwCPboRNIsqmjUu8AEwdu5xq5Nze1OuAHj046UV3z3UtEN8LH8U4CojD7zaOF3DvS6jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=v/PNqA1x; arc=fail smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65I5R0Iw1967048
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 23:10:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=6/T0Dclshlhmnc1UxrEhCEHM4cymDyecbTC6Ux8+uFA=; b=v/PNqA1xBXvG
	hxasA0LzJ8yq94mP/vLG9ehEDNugAO22PhggvV4w6bqGrDNdz+I5GVtpeVimerEm
	uQBbADRTqFkt4j39n2wuBQO0TJMx0k/Ngsr/XypO3PKVRwiKmvh4Fej+Aga7MC9b
	SW5npdoy0mfJQ2gKUZm2NjxDs+U6T2IMmgYmFXjYTvdZIOpbnaLPBLLnoXNEvfc7
	iabwsALTLrmBCaTpNjhGZBs9JP2hcI6hMQgOEm5TRf/VAIkH5wj2q3y76PUcwfDQ
	7Jhe6K6dHnRe/0Myi50bJqPCe/2OBqPV5juk7YchPYXVwYkfOdTu4kMRyv7cWYYL
	TS+Mvy0faQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4euegy9x8m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 23:10:04 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6fa8bba1dso1111759a34.2
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 23:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781763003; cv=none;
        d=google.com; s=arc-20240605;
        b=k0NklA2YUX7hyuRA5sWDcXBQP5CjXLyWTTJbFahBA1d4inUCOiKyH+t0E114srZl8O
         DsIfmjM2RHoV0qSogFVOtfrWt+oSDffx5ztNDBpu29pgzmx2zcRjgb+yie43mArF8IqW
         NGfRkdSd3LX1CJvOkgdlPzDD+KiIX6S77IzLRhPFINzdwn/vtifXLTX4j69fLQF0SIVo
         1d5VR3tPC6SVuLLL4HAorHy7Q/zrTj+t0FEkcnZNR5lasfqlvj0P33IlXc4j3KahLouB
         Cy1X+wvgAY43fsVtJt9CdowiV6glYBVnogQIIY7efZD9OBH1G3m38GwelzYT5uj19gx+
         tacw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=zpTmQ37GmXWdpWUeDrqTjiaqwbJfjoWYHVp4s39Z4p0=;
        fh=xsdDLIZG7PIvp19LHrOM1cBJK7135DGMSkqYSgWuQOE=;
        b=X/PGlAXxJaeKUwiufgy7vJUq7GIVwSPVpVmdOsWRy62a4rWanAIqx0loO6gzUoRpe4
         UoiymzCiPzzRaUHGAqKW1l6E80ltcTaeETCAc7n6R252fKSIFLVJ1C9Qw8KvwMjvJho6
         RN/i82HVoleZ6mWny6QvTjwjitB2nXsW+chutO3pTOY3+IIiBry5Wg5m4cetB27ycGlK
         H+mGqHq8rANKuFcHaam7XIETGfN1WuO40HLQoh3A020F6pkZReSpAhTXQD5zaOPxjc6c
         Cyo3BCMGuwLu4TyUBw8OnGoA40RhtohmANpVx9n90oqAZheuidQ6nQqH2Yp+1aeetMLa
         bfgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781763003; x=1782367803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zpTmQ37GmXWdpWUeDrqTjiaqwbJfjoWYHVp4s39Z4p0=;
        b=EnIvrW573LZrJw+nMjGPxEGixbiI3BzZQGDw5QVUEnKG7h2Vu9hF76Qwa5YiQI4v1t
         AZc4cSFdbpulIas0s16W0CZxaP/yh8btG+gOPMm1KfyTQqKbARVn8CIW5H5fh+O104vt
         fdNqfbWmY8k6IxcMy35Vcrfz7d5bJzx9NvImTNOXjtXN46xHG/pa0NuHjK8SBIAgB282
         tn3kMlOR65TC/jN7jpWFbMf/JDRGuvn+ihRB5j6IXT2rrrvw0Z8k/qjo3rxGVktJ+vIu
         GoYyQq9huns9DYKk8YEjbWDOr2f90GLb5qSfGfmjJg3tGmN/gaIInO647y1H0DX71ssI
         PIeA==
X-Forwarded-Encrypted: i=1; AFNElJ/JUUqhfLP3nMQWaRCPSeecdCLXJHtq2z5EU9Hs8s4MTcvKlvik8PhV+TnFs8lkHvAVKmzhWJWL531X@vger.kernel.org
X-Gm-Message-State: AOJu0YxFc8KsEAVd0HdlmbIM1YPjfvn3pwbGXqqCnmqc7lzu8Ns88e5N
	T3aPcgaCMGnewCF+Gk15fVQrda5Wz6YhHbq8LXj3Hp7LFbhoBDtgP1i+dBKOxslWq/uDlvIpzGF
	6Xd9hBTQ8AOo7nwfsZSr6/UjQ/EvzfsjuVykVQWNQAs85kY7nSO5d8OeGZJv1abclvUUdmaQBPa
	crg/8eWcoYyqcOGg7/CC6O4Y0mfysMsXCqIXJO
X-Gm-Gg: Acq92OF2HKLP91Nhbv/T7ps/xuf8T49D7zafoFMnbjvFauM08ZbUoBWda2oxb9o7w9B
	ceV89pQOEB2mbu38hRKKwNu83wB0RTLBZ86ycVaMp3vmPEOp8GO4O4P+pVLTd4g5JfRZS541EBa
	3pAGRUP/RAUDo5KMwIiO5t3UxMJcT31R9JtMt9ZOjdLPLA5MLLmVCVbNmjzgu8PxZT1fRpnxNa+
	KYsko39CNcNOT2kbOQ6fvRSmd61YQ==
X-Received: by 2002:a05:6830:67f5:b0:7e7:57d8:a8c2 with SMTP id 46e09a7af769-7e90b3b9930mr6882341a34.12.1781763003199;
        Wed, 17 Jun 2026 23:10:03 -0700 (PDT)
X-Received: by 2002:a05:6830:67f5:b0:7e7:57d8:a8c2 with SMTP id
 46e09a7af769-7e90b3b9930mr6882279a34.12.1781763001909; Wed, 17 Jun 2026
 23:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615065912.2177918-1-zhipingz@meta.com> <20260615065912.2177918-5-zhipingz@meta.com>
 <20260617092550.GT327369@unreal>
In-Reply-To: <20260617092550.GT327369@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 17 Jun 2026 23:09:49 -0700
X-Gm-Features: AVVi8Cd9LqQxIAml-YNLrnCpxwyq6SYcSY7qEQ2JpeKmDJHK_hh3DSp6GvPOQmk
Message-ID: <CAH3zFs3xfc5k0fhgedCpNAfgfoAvfk0V2pF-xqA1_Q2sGkLnig@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ObWoyBTY c=1 sm=1 tr=0 ts=6a338bbc cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=wthcJ2XvByERRjf4MtwA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX2UKzKjPwVUfg
 +mTzTjdedivfsPn9BxdQTYlZ9JDOk/rzHKUiZB+qIJonAYN/FOLt8JZ/Gtg0hMTmh5IqqFBB+He
 oGuYIu5zjgCFw2r87hy6GLU26xfdN0Wy/dghXDtQWxlAKmB8dy3bDmPN8GNfB0XyEvjaVd8pfkx
 VPmBRtXlo9/Se0vcv30zKvqOksJ1TJkxJulMoidIjwTxgL7+z4FUl7dh5/Me8CSeQAi2aWBVzzl
 yYaN3MRU0uwzTOjTy7OGFrQ5I/fiK0WyK5yq8Srt6HEP8wYpBQKhsb8ibsDY27aM2ycxmLVOcCU
 SawA3X1jB/Avuk4fWnjBx1skXuvWAJ3yJsfCYLVcjEu7samTdFVLC/Q83Xvq8pzVt59cli1t6O/
 4sXFf/LtXT5qLJl0GF/xhJo6PFya+PQaLGv7rZPVdcbKZ2HODW74WE2jtVvkZyJ5QYbpx2AtPKd
 VLMXf7XGhURvB7Hx88w==
X-Proofpoint-ORIG-GUID: Rj_kA5K7kt8_pHPhwswaZsb2PiIoezFc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX4ML/hZGbo1YK
 D7BfSKlU0vZDyVf9ETgvG57H0Y0zdQA32JqsX6GcHha+NRdLldw660D+H+Dq5s6ml+J8iUkG2Zp
 U2/GGEeJROl4gVcXbCjDyEzLckSKGJE=
X-Proofpoint-GUID: Rj_kA5K7kt8_pHPhwswaZsb2PiIoezFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22345-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:michaelgur@nvidia.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:alex@shazbot.org,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33E8669DCB9

On Wed, Jun 17, 2026 at 2:25=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Sun, Jun 14, 2026 at 11:59:01PM -0700, Zhiping Zhang wrote:
> > Query dma-buf PCI TPH metadata when registering a dma-buf MR for
> > peer-to-peer access to a PCIe endpoint and use it to program
> > requester-side TPH on the outbound mkey. If the exporter has no
> > metadata, fall back to the existing no-TPH path.
> >
> > Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> > steering tags into local ST entries when table mode is active, and add
> > mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> > index.
> >
> > For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> > lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> > creation and release it again when the MR is returned to the pool or
> > the backing mkey is destroyed, while leaving the generic FRMR pool core
> > unchanged.
> >
> > Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> > modular mlx5_ib builds link cleanly.
>
> The commit message explains *what* the patch does, but it lacks context on
> *why* the change is needed. The 'what' is mostly clear from reading the c=
ode;
> the important part missing here is the rationale behind the change.
>
> Thanks

Noted, will change the msg in the next version.

Thanks,
Zhiping

