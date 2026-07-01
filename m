Return-Path: <linux-rdma+bounces-22665-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zN40E4+BRWpQBQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22665-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 23:07:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF2C6F1BDE
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 23:07:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=JriekQid;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22665-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22665-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62CCE3008601
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 21:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A963815E8;
	Wed,  1 Jul 2026 21:07:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29936F908
	for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2026 21:07:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940041; cv=pass; b=XML/kxIUFIyO5LkiE4PvhOYoUSrmfscXOdJ7vtYL+sKvRmFi7iXCgNRe9OI+UXf+7Oz4L7lr/zZzXQe1cv2hcde7Q0dUppsjVWVFos4fIyKEmuu0/y6VCwydpLzDlAx7RDWucAxqx18P8ZEwGYDlJzRoNoemGNrAu41B6KAtytM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940041; c=relaxed/simple;
	bh=Ceo/eQzTqKQOw6VV30yrUBdtzlEqkC/54DauyHODWuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsRxo4n75EiIQmWlMLmeKM43cmL7dpLlDbma/Aywco+CMLVsZ/ib05R7uFUvZKKrVJqhKYU5W3R1/F6fIH+UQgRY6lNGf6hK5CXrdRIKirJRsuDw8OxSR8Drsqp5MZvC9griO8U+Uy9H+AfH4J//W2/PpgWXiASR6bBS7p7zyLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JriekQid; arc=pass smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GqCIW525508
	for <linux-rdma@vger.kernel.org>; Wed, 1 Jul 2026 14:07:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=24aInYXtnwOY36q1nTcGx+GLSA67zMg6UsmTMMOvEvo=; b=JriekQidIHFn
	3OZIro8QTgAFnzTOmG7w3ybAxj4FiStpeTTRGBLMAMypxTBXO/RGcUhrKlV7/8+I
	NGp2k1oxd1md4lnH8eLkzcoRP6bO/irin9BMsg0lfaoBV8svypOfCmDIAXLNW5sK
	GtZ3MwaSl62Wu0/6dVeDLcyETxRKmxu3+aaDSQG1+4lqXzSIaR/Z73n1wWbswdiY
	JS+tG40E48v0uq/02iJ0qwE/0HOR2lWNrkfJif1YbJnyfmSRCgkJvV3Ifv5Qcrni
	D5okVxBynFuMB98gOqC6WhFZmaUI875K2RzzzSTr2Jczefn/3aJenaP3WDlVdFCR
	x47wIFjeLg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f46kw039s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2026 14:07:19 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7ead3468408so785684a34.0
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2026 14:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782940039; cv=none;
        d=google.com; s=arc-20260327;
        b=mO1qp+x4icJEguFto1+lQfVHfkTydKdxTcHG7q4mZEoUPal1mJ5Ureb/bCDEFeUjhh
         ZWyPK2ItSopOC0dF+1WBOQ+RZTBQWa08hMPqOD+CEd0LvfJlVXoTS67tTlBeUaie87Gh
         qtogYPtlUQrKYUdCCKF3A8LmeD9uVp9g/R2zrhVrdguQFRp52e6Pwi8JeGU3YYDnRzwr
         nhIdGQFC+Qm4QxlsXQj8/j3w+w9O5PJsWTrq8N0y2/pQtwRx5sGZHb/ijGzgvIjGYLcc
         LS+y87gcs6UUhlbwAbl+O3bWB6I9yrTMXE41JvK2IOxjCQeKQI95SXgNQ3mtH6XtpnsA
         kOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=24aInYXtnwOY36q1nTcGx+GLSA67zMg6UsmTMMOvEvo=;
        fh=rDG/aUyOjgvS/f1SncRXzSSaYvI0hZcJyUvhdpkGbWc=;
        b=ZmyHNM8VdXEWt5ziX+VKwA9L+qe247KYAcWPXHypis10Aa/f+5ThdamZmdRei/3m+c
         IKyPbm18dIrQ3kJfp9BOa8YMhg4362ToWcS7iamvidgmazhhV53HBkF81JcFYBW4n61E
         x2hFZ2iFTesvZvLwHrPSKsfkcr8wGFoeTxMoLQ8e0cP6Q7330cVmXvVuEOycWMzu4D9D
         JgTByUGgffPoz97QQ2kTRDCJtACm2/yluFvIZoC1rSrBSZl89hZigKvqnp1rTM4tqqc0
         wYqZ1dx0FE2x65VJfMVRESXxdZuqafADbF7rDxvi2uPfrfq1Y9j0TducxLuyj1dhn7Go
         HUDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782940039; x=1783544839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24aInYXtnwOY36q1nTcGx+GLSA67zMg6UsmTMMOvEvo=;
        b=n3ogLsaqHOhjxmPcfyk3xGxVWxz1EL1LR+fxMhyeOFtoLW8jDAARSnbV6jAOrSnmdz
         GvFqcMIMhVrNLHeecXAazys6ZYqCj3xhbho1030Q2nJM0TaWnNl1rmsZTu+KVS3f4uYB
         207WnEdsQW6ZnCxwcqDrsRmR4sfTRQBo9GnTt3QaPPAWD5wa1t+L4u2OqQmvhAD7kTJ9
         KMgmha6u+4XUfvJ6A6i3Y1+omUsqidhq1zv81Vi6gyWFnZUiSUcVs2XssurC4oE5NKW0
         u/mcvVF4lnlt3J5fLYR2ywHdV0/BobTvnmR3jRN2fk2Lw18OVk6PJ9Gb38NGw4ZZSnhu
         jw8w==
X-Forwarded-Encrypted: i=1; AFNElJ+ZX+fgjmmvWK7I884hNCpd4mdi0KLFIwHLVk372fkKVPbHHD/PjVnnMYhDERr0A1XYN0wJaxhdk1fG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8rNtXPz7oYucc+TOOJw0ZwSVq4emgk0miIWdhlsMWDxSlDnvY
	s3SsUhSor9BiMRlSVCxpfrHX0pkfpWVZrIK09l8wvj0SvmzDSjrRmxyLJAZZcieZdl/6wmN3y+O
	wK9OFPQaCr4Vr4aoDjqvMD3lF5p92lM1sCPXMKP4VIRemM+nLauEhorkEHLsaEr5FcB3YdPLJW7
	+4WLDK9nz6MziwzPhjHxBykJYEV2+kT+FJ3TzY
X-Gm-Gg: AfdE7ckfpKtmUTk7j38jrSp4S4wDmneygvJ9lJ+IusGRv/Gkuaf/e2GrXW/+7Pqt7BM
	+2kFajoddBCe5v1rAAF+1Ta7w7PSeVA3DuQ18p+I9LonT+WRfjhgIpoVnweBDBDjHDYiMbrvTbD
	sHFR0Qqs/njOTl+7GQU0w6n63ME+DwI3s2sxwbGykhDQaxo4mk5rPIjzoije7kF2PqaEyJJmClM
	V5pot7QuQ==
X-Received: by 2002:a05:6830:82b5:b0:7e9:c481:ff8a with SMTP id 46e09a7af769-7eb48b0dad2mr2267487a34.11.1782940039005;
        Wed, 01 Jul 2026 14:07:19 -0700 (PDT)
X-Received: by 2002:a05:6830:82b5:b0:7e9:c481:ff8a with SMTP id
 46e09a7af769-7eb48b0dad2mr2267473a34.11.1782940038625; Wed, 01 Jul 2026
 14:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630224328.3218796-1-zhipingz@meta.com> <20260630224328.3218796-4-zhipingz@meta.com>
 <20260701120700.58bcafa1@shazbot.org>
In-Reply-To: <20260701120700.58bcafa1@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 1 Jul 2026 14:07:06 -0700
X-Gm-Features: AVVi8CfZM9KJwSZGN9TaUIufGVTMoHcKZ-xzBFuNkplSBdDCFbtywxUsQs319WM
Message-ID: <CAH3zFs0bmTTTtw-WZsbhFqzdPfriwOOqp4XAgo4TGekA8HYw0g@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
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
X-Proofpoint-ORIG-GUID: N03d8ybd_pMKygyvyQClPSzF7VAClHQp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyNiBTYWx0ZWRfXzwRlO3CSybj+
 7/RCHmXqtpFtKQSJNTVQJrO2sxNGZKssJuyJDm78QkKWg6O+I2H1GJ5GXyujJaBzAy2A2ZReV44
 x9xuybSbcYQF/3o3KVk6YN4MYQDMC8Q=
X-Proofpoint-GUID: N03d8ybd_pMKygyvyQClPSzF7VAClHQp
X-Authority-Analysis: v=2.4 cv=RJCD2Yi+ c=1 sm=1 tr=0 ts=6a458187 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8 a=vGJ5o9TXFsc4WUGASEEA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyNiBTYWx0ZWRfX9x2A/XGrKH0T
 UXye5bQQEz6rN7nBEZ+6ztxZ8F9pGvbNv8jlyGlwQYpkJIyCOmu11uLFG0wmk3xv7+zIhG8CCtQ
 CbJCHPu6cKvricf4ZrhtiWlMmjbVltOdFgLnf/mZhaNv+S6uP7t7lMUwpkKJler1AJ4lhNOC3Bv
 7R/31vMUg/VsIofcErmhSYC4YrBL9QdRnlNaBs2+jwb+EI3g8JreJRLxk6h7JptzPqArFBSIhW7
 is9CPb8KRwu3+5dAaRpzs890xoxFtbNr8DwikifBXZzXUBAwSAGTjPOznPOZKJRpEqD/c6eak+4
 Hesd02wS/UGT/LiJ/+einjOGgNK0Ci1V6eKEpDe9mSMTKn4n4Q1PZa1XJVg8W1Z+eT4IHIIUR0/
 w3fogiM36rHkJ29UW8oaoxnzeYcnZVZPzH4dZ/JkUxgBUyvqrCe9K/WtwXw0UKR0imn4n0rMJv3
 hCknOQTmXrt/FA9wV8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22665-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:michaelgur@nvidia.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,shazbot.org:email,meta.com:dkim,meta.com:email,meta.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BF2C6F1BDE

> Since it seems there will be a v11, note again the comment made here on
> v9:
>
> On Tue, 23 Jun 2026 22:24:54 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
> > On Tue, Jun 23, 2026 at 11:17=E2=80=AFAM Alex Williamson <alex@shazbot.=
org> wrote:
> > >
> > > Nit, it would be more accurate to say:
> > >
> > >         /*
> > >          * Updates protected by dmabuf->resv, @revoked additionally
> > >          * protected by memory_lock.
> > >          */
> > >
> > > revoked also has an unprotected read, but it's previously existing an=
d
> > > benign, and likely just needs a READ_ONCE() annotation.
> > >
> >
> > Agreed, I'll update the comment and add READ_ONCE() as well.
>
> The READ_ONCE was added, but the comment remains as in v9.  The
> READ_ONCE rationale should be described in the commit log too.  Thanks,
>
> Alex

Sure, sorry for the miss. will do!

Thanks,
Zhiping

