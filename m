Return-Path: <linux-rdma+bounces-22145-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sjk8Ig49K2qn4wMAu9opvQ
	(envelope-from <linux-rdma+bounces-22145-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 00:56:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA85C675BA2
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 00:56:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=FDSJxjU9;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22145-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22145-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C67BA3267E4D
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 22:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E18F38D3F1;
	Thu, 11 Jun 2026 22:53:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560B358D3D
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 22:53:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218425; cv=fail; b=MRzjFRgWUVPQ8fs3v7Qkacf1DUxQ1BPMl/l8wiT/YrDfPfabMdTlROHE57tppTXfb6cyuURu1W498eOLAinrBwJ6W9VOLK4GLvmphHIXaXaRkeOf7qhojmpPrwapHkK7sFVucG32z0FiUEwAzjoj2etV+SFpYf/fMbxWcFMMvi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218425; c=relaxed/simple;
	bh=PxRZuLlxPed7g3+uVJRSQh6h+tl2QKNm0St8ryyYUCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o38iWxv0BZGY2DAiQHQ2qd8Q54Z7c11wZ8+ueKStcxCUnUqF9eAKmmWnERm6Y46+tjwc26m2cIEcCuu5AJP6LYK5In+y+Ywmpvv+Yk+UXHC5FyXDn7PglgcCdyhLrEzF0tZsgS/SN/asqpcxtEMFxqbOUXCDVPq78t3osv4+Lic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FDSJxjU9; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BECv7g1448060
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 15:53:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=PxRZuLlxPed7g3+uVJRSQh6h+tl2QKNm0St8ryyYUCM=; b=FDSJxjU9lKGB
	zYwQmQEO00hYYEJ0A/ovopPo9d7CqKqD1XADgRLIn8Vqp1BtdkAsscjzjFBtTOm5
	diVk99kItK4XNYmeAXC4rJxohR1w4XfXN9Bp6eaanw4NKiAW4gyJmERZSpkYpCSp
	omOvIhSNxK+sDVYMbPZyhsgC+FkoO1ml34CzJ/gxKRcU8wmkmA9aQAC3EODqW0kl
	lDxIU9Q+19d3J+fSdA/QNT4u7oggrCXALTCFp2seGU1YuaR3sFJx91cwBUas6m4P
	Q7RVyD542fkWdg5hhoszqMfbGG+JSljRyZ8BmrK8G5dKPiI9D7qpr9eZb7kxJzyG
	Yl+tOZEnCQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe78hb3m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 15:53:43 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6e385508bso525308a34.1
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 15:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781218422; cv=none;
        d=google.com; s=arc-20240605;
        b=Ej2lb3KdOhouZw9E5OtMKQHBH3/XoKGKKpY79mSN1yHqbQHAvoHs+AmwDoYqoCf3Ae
         UWvcPAM4PyXbiNA+Q1gdZPI106QbIwgaHR626fsqS2q7z+BtI6mJ+nVRcf90riUmoSGJ
         38fu+MLOr12A+YfxoHsqI5OruGX0Kn9N6h+rRvuV+/j9AYSkslIHZbW4RtoGm4ErKqKQ
         27KeqVYdWeBwNF24+n8XrehULbr6YVws82HhU6O/ur63tRmVbKzcbSdvXImJn2B61u8V
         UGYVOu0yewgwTDDudjndkgBENPQeEsczwrOQK/rb7ZmCFW1q0nyKOJKahiqA2kP80w6g
         05hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=bKpoPiSG0O/ElHpWyO7hVkQGPwY3Ah43xb7s+p7XAkg=;
        fh=NQHPIqr2zKO6eia0WnPrri7vWhOBcyU64MZKP0Gf5EY=;
        b=EzYCaXTad9Rx095n0pNlQZVlLLV6DGZcb87xibofPhhCASolKdmxcHP8pognvwqZex
         fFSAHaI4eoeo7GkNzhVANUKOpbcIHHCVufCD7pPXSe7TmXLEd41aXuiSKDrbV+GIPYa3
         fkBBQggii7E/DmT7pM9KbIqWbbJYR+++eMumS34r7Kte2x1ONvJzEzQ265LWUBjPBeyr
         FexjR+YhmQt92pJy0k5o9I6iHMmJB22begCO42uFOF2SAgUrLTmF2gy90WHPEt2uh5wb
         hmJtZOHTQntwGbAP9cloAER+ojxxAbJoXzF38NohMJKfma4ZUOF5xgaheub3vVzAKZoV
         wf/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781218422; x=1781823222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKpoPiSG0O/ElHpWyO7hVkQGPwY3Ah43xb7s+p7XAkg=;
        b=jII+i5Uk4CSt+gdTGe2dykdvYOkNM+wEpi6EiiL514VpKBKT5QmB8HP5wI8ZIyEFbD
         I0YziEwgtmRjaDz7a+PyueKz+0ZozoAlEPgCGbMNEAJts6maBZRKrYwK2FNYZAIq8k5E
         CT4aDi/Of8LAEg/4l4fA3d1CfozVT5pBmNoGGENS63Or/9rKcH6mTW6e8/SyvpLhsLCR
         qkpnWws++OQAWaysS6PKXR7xiGSUS0l3plxUrxhT3XS1fOvf816cM6BSDFxc6tN1y0ov
         fOmRBJ/CIN4vBiIjEpDIpc2oEvXAI683CYJ+VLdaKtwHuPHPCbV4FRUXxq+NKD51BZej
         eKqg==
X-Forwarded-Encrypted: i=1; AFNElJ8/hOcL4/bpKFOZYMxf16XYIVklCBak+kZit2Z3ACdrCaZWvvONhK0Rap79iezvuxvx6BksDHkPVpRz@vger.kernel.org
X-Gm-Message-State: AOJu0YyOoOzIOImbArhgePiEK+9FVuhpD+K0O5HSpezxORSKguvsD1ph
	eJTpmQG0VVD5V3BOiMsztZAxIPVUfVpdtnS5IkwHiA+IPPHrvWcmpCXwqcHiYWAyeVS3aDHZCbO
	QLzzWW4IojExZhmYUJSSc56yXkJsAtx/hT/ysYIz/TOnkSx7wvlpPbYzPU9Rg2hxjgSJAnGfl7m
	16dPezW/ghiXmzteiDOpS4dN04wPhyCV41mv1I
X-Gm-Gg: Acq92OE+4QPi236hCgSm+hAo6J016/cL60EeKWy4SZJvZKS2ZKMkrgh6tiXp1uS/nGN
	dXquNqvWWIGrSJqvrSvE0DzF3xcBJWaF4yJ8uakBalE4srab0yJ9wVEp1OfsW4D79remYlqX84I
	MYYf1H09fZTfxC2R/x5MSUSWLd+owJACNPa8h17DmzMqcO3Cql9uXhJcQRxGhSll0wgJu1o/mJ+
	Q6f621vhAn6oPkMjodbcw==
X-Received: by 2002:a05:6830:6d29:b0:7e6:d8ea:7dd9 with SMTP id 46e09a7af769-7e7847e1560mr60117a34.22.1781218422510;
        Thu, 11 Jun 2026 15:53:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6d29:b0:7e6:d8ea:7dd9 with SMTP id
 46e09a7af769-7e7847e1560mr60099a34.22.1781218422119; Thu, 11 Jun 2026
 15:53:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-2-zhipingz@meta.com>
 <555912e9-818f-4906-a883-6f14e0790672@amd.com>
In-Reply-To: <555912e9-818f-4906-a883-6f14e0790672@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 15:53:31 -0700
X-Gm-Features: AVVi8CcTcZoIZDdh8OjH1IktxPjhUF1A0IE6AmeFSJNyea8GfNww1HwPJ1RCIPA
Message-ID: <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
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
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: F2R51QVfBt-mzeCYM8qTtq8-BpZkZHhY
X-Proofpoint-GUID: F2R51QVfBt-mzeCYM8qTtq8-BpZkZHhY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIyOSBTYWx0ZWRfXzkuH3FsPqiVp
 88h2VgZKlVp3jzRKMkyjDlfDeBMHmaT+YVtLsutEQWvp7yqbF9/RajL3kKEb4YALtYKCNKk/Hy2
 Q8HOi1Azd9rATd7gHCV8hyF7J2fhOxPqiOXEx6ciafIRdJTK2+43/0rUFrBzaNRGoDlDdR2OKZd
 sTba6fd72G9P8v56KaYIHOhuuu/urGBxlZF0ZeKa8xvd2DsFEIs6cWf/k/Ma5gvHiKiRGt4H+pk
 z9BxYKWc/A/AKaH2qM7O6yV6yERD1WVHfEt4SBhXcgPrbHqjBc/DC2ipPzZwX65k93DiAJLcd/Y
 abhB9rfx+x/1OlVjjXjp/gaCm2I7948YJCU2EUvmvnrM9P09vpLNT9XrWdOaAKc89d2+JrlmaVq
 RUUxfP3aOxQ1U/Tfq/uiEvaRCahfjg+95X0gEO0ioQbjZaE/h17XakCFnCogBVZ3pMrvVI5KA3o
 0QhwQ0/ZP0bcSuBU3zw==
X-Authority-Analysis: v=2.4 cv=L98theT8 c=1 sm=1 tr=0 ts=6a2b3c77 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=zd2uoN0lAAAA:8 a=VabnemYjAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIyOSBTYWx0ZWRfXyCSPEKyMsbre
 lojhS0X/f+TUMHoCdqQqnqC5kLBEafiXRG7FlPog3NrF1TFd2IS+Ey3xc9I8ca6TTbGl8Ompj8u
 0N2XTti35IyyYQK01xVOSgb+MIuYz80=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-22145-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:christian.koenig@amd.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amd.com:email,vger.kernel.org:from_smtp,meta.com:dkim,meta.com:email,meta.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA85C675BA2

On Thu, Jun 11, 2026 at 12:47=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 6/10/26 21:31, Zhiping Zhang wrote:
> > When the last reference to an ST table entry is dropped,
> > mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> > backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> > therefore accumulate one struct mlx5_st_idx_data per cycle.
> >
> > Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> > struct matches the lifetime of the ST entry it tracks.
> >
> > Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
>
> Since this is an obvious bug fix I think it shouldn't be part of this pat=
ch set and go upstream completely independent.
>
> Regards,
> Christian.
>

Sure, Michael replied that he has made a patch to fix it, i will rebase on =
top.

