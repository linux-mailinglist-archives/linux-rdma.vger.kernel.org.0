Return-Path: <linux-rdma+bounces-22569-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J6pGJPT1QmohKQoAu9opvQ
	(envelope-from <linux-rdma+bounces-22569-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 00:47:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A336DF17D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 00:47:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=D6Y+Suqj;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22569-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22569-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A42F3036D70
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2026 22:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0343CB8E5;
	Mon, 29 Jun 2026 22:46:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC13264DA
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 22:46:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782773206; cv=fail; b=i06eIvNfQe0s9lv63HeT19DkRnmmCPPS788d1XuJ7OWCrWbzWESh5qIw4uy/ZfU2ZQrCMiuZD/ZFGsP7nYhm8+CMMaEhtiG6dzrvbC8CmwmZyQwhnom8nKuw0thn3dAk/wuQzdpSmxe93kEqzVJxgmFg9+YBK/czLUb8rPtBU+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782773206; c=relaxed/simple;
	bh=LAAsXswdYRhoMmUQBXGAxhkMFD79zG1d6WTOgeAPZ4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RonNnEr5cM29KIW+CR0K003uqd4392WRmbDMauVbCnU0Wko7MQYeHLI17gmA9M4xw5+OPereV8+2ZJ6YrCoGoNlLX1HITkFYkmJUVQPs1WHL2nfpNBVvsDqhs2E1ECX+j8MyrAJ8sNX+DBYFOknOuhBkPI0lQcxyKLNDPU9+a/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=D6Y+Suqj; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TKgadQ3054194
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 15:46:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=wLX+q6aZUGU2+tNflRbeS5hmHMHpHmOV5uipQIZIRjc=; b=D6Y+SuqjEQrM
	f2QeVXHoqMHxZexgeghszFXVrZw4LS2kXjWpFfTX8mYzWTSEZtH/ttBdVAMkyWdy
	t22Kq702OWpcjEU/kF74grLjnJ54kbNPw0ntlbzzWsw9KEK4RR3CgBqUj3aHbeET
	ijCi6YifPqpFYhAvAOCkBJNfzC61asm2Ur9WnbU9jxmtIccXlhxFn7djlehRcrRk
	CI4mOnrSJnRZys+tAPctwAstQLwZ/r0gp8f8Cpuv+y14HBevZ8rrU6ANkQzUAHDJ
	nM51q117Utf29kv/dShBoc87MTcZ26F0vt+BK+TCjbX+Yw7l2sLH0bG+JlOh+Qz+
	pPe0+S/ERg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f305djm4m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 15:46:43 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e74781faaaso5360302a34.2
        for <linux-rdma@vger.kernel.org>; Mon, 29 Jun 2026 15:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782773202; cv=none;
        d=google.com; s=arc-20260327;
        b=MItKZCvSGUofi9oyrPP8BAX/2XdDndsxoSdc21L0ZLyw3Iu7TJRBBmgWutvctGelBF
         5I5XAwxBtzGJ2vg9kA3fLJwdDp4xYPp4H3Dx5d/jaEmypC1khm2pLI9e+owGirdGDEi+
         fQYBqWPKFpmGumvHquYldP0k4qPf+IL9Xhs6JHJVSVRvtvpzfY8ooFdeA7UMklq+7Y69
         oN6ikC8Sa4PczwI0/Vj+GPOpRzlTwZ+oa8slR20r/u/PckdmQOl0GHx4C/sFDGYsKvjF
         utKe469UoW5amDuoEl5geCWnFuE3QRafhQ3gMf/Vn75g73dNuQUz2vjC3VGqhA62G+ZG
         lz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=qoepALekrUydMw3++ECBWh0/IG+kKVdwdlDn299LcLI=;
        fh=3ssLvkSl39cUKOl94uD/oTZbOVCg5i4+aRy3COwQqX4=;
        b=gDl7BelpuyfHTcdxoCFLwEOKTvmOR1Yu1dnTQclQp7lfrKj07igXyQlirNua7B/eQq
         YxjmRADMnnkmbbLZ3xJ1K4kbwx54Jn18sVun5G8v7ZiQW29RoKENpsYYuRD6UW6Fdsd6
         tTg2ZOMgA6KKTEd34RIQOjslGNHWnohYmCwC9vAsqmYs0LyLux4FWaTb5Z4WNFeWqt+Z
         ZOfd17ENPbJC4xyR1kV0Tn0oTmSvUYw33w0W3mustTGkU1vgwB0/yVk0dTmZCyE52s6U
         h/31EJFYUrs/7ckwNdUaIpHRhyBNDyGnrYMbSUFUW1aiVpmZoBvjE+FljMqYl3fjIk1L
         KudQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782773202; x=1783378002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qoepALekrUydMw3++ECBWh0/IG+kKVdwdlDn299LcLI=;
        b=F7VyTd9aLQ2PGzzMbFhTP/68Nt56jmiYEODWSzG8tRsxZERfrgQIG8PoNWhhmuV5q7
         4IrFdvvIcrbAJP6LYZKoUBm8DdNkirHDpWxxnZdgIGtS2qg2HagAAKo1iMbbjxeyJkl/
         YoLXPZ4Aw+R3/U1EWJjDAymo3T9vgRqzexkRrMoUxNHZR+Vrz2erdZmkZLo23Q7RC9U3
         XZp2zE0cXHeElu3xJpJ93IphTjk8SnZBGJB0zStSK1J5mdqzrKuqc66KGdtG4YMCwrMh
         Hpd92N94Vj6p82nBH7WUhHGwQ7NYzVVzZrlghNo8gJ7sFdnKHhn1D8U/03PvoYLxIhIp
         N9kA==
X-Forwarded-Encrypted: i=1; AFNElJ9R6pcBNf1IIv/89Zw7Zyp6JHliIY8hXh65VqIlQoQzP56b+sHCGO/A4mnif0VoxqCjJ1WWoQZjURS7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqz7CusAMxejOHaoB17MWaDkSbkRod+lm/EzFTCXK0sn/x/DG8
	AFiyp+pYSkg+y2FS5M/v+rTVTxA/MrbFaahKnsBw2Sj+beiLEJStcpbNHe1BQG/UTElW/L12fT2
	yyWI7HCOjFiLaCoPUlQ+jzKhdplcqRDRgUDUH1AWOPTfk4vVqak9SOB0LWe8C+H9/F9DIYBzsA/
	dkeUVZkB3N0sXH5iLonYVWK76ahEzP4gbGWzci
X-Gm-Gg: AfdE7cna42xUMzOWwhpEtKN5PD5V6WkR5qYoKdIzwyNhIXX7r+WHUF5kVYTU3Nf1bnm
	mhZ6+FT2shFxw6b1LJ4aQkz8N05pJUUTeFlD4DBvG3HhAvnTxBKohK1U19feghfoQeH1LmwZWeJ
	NDV+sBQgyc78fyUYJrF2UvW23ubC1Yay6u/9U7zsAgCn0WyzR5fBE9S+3ZoaK1zB+Ll5Tgw0CLo
	7ifEuj3
X-Received: by 2002:a05:6830:6389:b0:7e9:e860:6ee with SMTP id 46e09a7af769-7e9ec7c6eaemr1372419a34.31.1782773202414;
        Mon, 29 Jun 2026 15:46:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6389:b0:7e9:e860:6ee with SMTP id
 46e09a7af769-7e9ec7c6eaemr1372389a34.31.1782773201883; Mon, 29 Jun 2026
 15:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622184211.2229399-1-zhipingz@meta.com> <20260622184211.2229399-5-zhipingz@meta.com>
 <b4c98f5a-b3a4-4dff-96ea-be2aa33cd1e8@nvidia.com>
In-Reply-To: <b4c98f5a-b3a4-4dff-96ea-be2aa33cd1e8@nvidia.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 29 Jun 2026 15:46:31 -0700
X-Gm-Features: AVVi8CfM8-1FZc35vpJ8kCojEp6xp5zFP0DjBW3kt6zGgKV_ax4f1nQ8Em8QwAQ
Message-ID: <CAH3zFs2LbjPCn9B2iCvFyW5yKoAirkZqdhwxmZh+U65wH9uy=Q@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Michael Gur <michaelgur@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE5NSBTYWx0ZWRfX/CkArTpN1DPN
 zsCYzYZ2C5Hl+0W7kjyCUUcqDdwqFLzf7AXgmo1P1vDws9LeK3fWhSTDb3R5Y4CEfiv94yBN85l
 gCHbliZYN7P7aqmr30jJgDYEsZzMQKw=
X-Proofpoint-GUID: hA6qhEawOGucFOSmMKpZTVR2HOpEGxpv
X-Proofpoint-ORIG-GUID: hA6qhEawOGucFOSmMKpZTVR2HOpEGxpv
X-Authority-Analysis: v=2.4 cv=Q/HiJY2a c=1 sm=1 tr=0 ts=6a42f5d3 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=Ikd4Dj_1AAAA:8 a=VabnemYjAAAA:8 a=CbDCq_QkAAAA:8 a=l0kR5rhSyQLp93Ybf_gA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
 a=1qrBK16LubpBFNPVNq2M:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE5NSBTYWx0ZWRfX2zJwflv1Fofv
 wp5Mlb0jMXm4B1Hw7vQy7mHeJBS4XOpQ4KYcDIiDBEXuc9EvtyTBmiu1vwcca+pfN0Mz20fsMZ5
 TDpkryyDq78h7zbgefFaNipxpyTbugaM3X6kJQNFomnOCWmomlYzsWDVTOJOvjqpAXJBpugIcZ4
 8YXhVoa3myjqzTQWl+fMADgKQXAh7cITMGwHmawOMdeTFK3WOrFOYnMLMt+rGtUfj76qZMJAOWi
 WPT/CbKEdNNaKCII+zp06HSTBm3fKP5d/TjuHOx5p3032Z9dfDFoK1e+VtYuFnkcnKXB8NaLqYF
 bAxY7w9d7ohkjI5styAv14C3yEDLISTAWGxm6NR7mXlgSW1LCTymTXOdTDGnRHEsCS7gnbOIHQG
 lvZTqlb1XWdozi6NpWqcgL3DjDrWLUxpz0WDyF6AyATCh0+X3zq/CBdyydg/yDo4T/lhOkTFZHI
 8mWKwV3Q5+HxMfI2BbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_05,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22569-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:michaelgur@nvidia.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:alex@shazbot.org,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mellanox.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:dkim,meta.com:email,meta.com:from_mime,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0A336DF17D

On Mon, Jun 29, 2026 at 12:11=E2=80=AFAM Michael Gur <michaelgur@nvidia.com=
> wrote:
>
> >
>
> On 6/22/2026 9:41 PM, Zhiping Zhang wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Peer-to-peer DMA between a mlx5 NIC and a foreign PCIe endpoint
> > (typically a GPU or a vfio-pci passthrough device) traverses the host
> > PCIe fabric. The endpoint exporting the dma-buf knows which PCIe TLP
> > Processing Hint (TPH) Steering Tag yields the best placement for the
> > traffic it will sink: per-endpoint hint selection lets the root complex
> > or switch direct DMA to a specific cache slice / NUMA node, cutting
> > cross-socket snoop traffic and DRAM pressure under sustained p2p
> > workloads.
> >
> > Until now the mlx5 importer had no way to learn the exporter's chosen
> > ST tag, so dma-buf MRs were registered without TPH and ran with the
> > default (no-hint) routing. With dma_buf_get_pci_tph() in place this
> > patch wires up mlx5_ib to query that metadata at MR registration time
> > for p2p access and use it to program requester-side TPH on the outbound
> > mkey. If the exporter has no metadata, fall back to the existing
> > no-TPH path so behavior for non-TPH-aware exporters is unchanged.
> >
> > Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> > steering tags into local ST entries when table mode is active, and add
> > mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> > index.
> >
> > For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> > lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> > creation and release it again when the MR is returned to the pool or
> > the backing mkey is destroyed, while leaving the generic FRMR pool
> > core unchanged.
> >
> > Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> > modular mlx5_ib builds link cleanly.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >   drivers/infiniband/hw/mlx5/main.c             |   1 +
> >   drivers/infiniband/hw/mlx5/mr.c               | 103 +++++++++++++++++-
> >   .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 +++++++--
> >   include/linux/mlx5/driver.h                   |  13 ++
> >   4 files changed, 157 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/=
mlx5/main.c
> > index 02809114fc79..a2b497f6b16b 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -60,6 +60,7 @@
> >   MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
> >   MODULE_DESCRIPTION("Mellanox 5th generation network adapters (Connect=
X series) IB driver");
> >   MODULE_LICENSE("Dual BSD/GPL");
> > +MODULE_IMPORT_NS("DMA_BUF");
> >
> >   struct mlx5_ib_event_work {
> >          struct work_struct      work;
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > index e6b74955d95d..7aced3f55456 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -39,6 +39,7 @@
> >   #include <linux/delay.h>
> >   #include <linux/dma-buf.h>
> >   #include <linux/dma-resv.h>
> > +#include <linux/pci-tph.h>
> >   #include <rdma/frmr_pools.h>
> >   #include <rdma/ib_umem_odp.h>
> >   #include "dm.h"
> > @@ -167,6 +168,32 @@ static int get_unchangeable_access_flags(struct ml=
x5_ib_dev *dev,
> >   #define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK GENMASK_ULL(23, 16)
> >   #define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK GENMASK_ULL(15, 0)
> >
> > +static int mlx5_ib_get_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
> > +                                         u16 st_index)
> > +{
> > +       if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> > +               return 0;
> > +
> > +       return mlx5_st_get_index(dev->mdev, st_index);
> > +}
> > +
> > +static void mlx5_ib_put_st_index_ref(struct mlx5_ib_dev *dev, u16 st_i=
ndex)
> > +{
> > +       if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> > +               return;
> > +
> > +       mlx5_st_dealloc_index(dev->mdev, st_index);
> > +}
> > +
> > +static void mlx5_ib_put_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
> > +                                          u64 kernel_vendor_key)
> > +{
> > +       u16 st_index =3D FIELD_GET(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_=
MASK,
> > +                                kernel_vendor_key);
> > +
> > +       mlx5_ib_put_st_index_ref(dev, st_index);
> > +}
> > +
>
> Please remove the _frmr_ from the functions naming.
> This is now unrelated to the frmr and is strictly tight to MRs.
>

Agreed. Will rename for v10:
    mlx5_ib_get_frmr_st_handle_ref() -> mlx5_ib_get_st_handle_ref()
    mlx5_ib_put_frmr_st_handle_ref() -> mlx5_ib_put_st_handle_ref()

> ....
>
> > @@ -335,6 +364,7 @@ static int mlx5r_build_frmr_key(struct ib_device *d=
evice,
> >                  get_unchangeable_access_flags(dev, in->access_flags);
> >          out->vendor_key =3D in->vendor_key;
> >          out->num_dma_blocks =3D in->num_dma_blocks;
> > +       out->kernel_vendor_key =3D in->kernel_vendor_key;
>
> This path is used to translate an frmr key passed from user-space to the
> right values, enforced and masked by the drivers.
> kernel_vendor_key is not allowed in this path as user-space is not
> allowed to control those.
> Please drop this line.
>
> Thanks,
> Michael
>

Good catch, will drop.

Thanks,
Zhiping

