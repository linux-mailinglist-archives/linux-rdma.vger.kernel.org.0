Return-Path: <linux-rdma+bounces-22147-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UtcHDj9AK2qY5AMAu9opvQ
	(envelope-from <linux-rdma+bounces-22147-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 01:09:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DBA675C51
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 01:09:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=USTVjs2G;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22147-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22147-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8677131E2D6D
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 23:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04238C412;
	Thu, 11 Jun 2026 23:09:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A549357CED
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 23:09:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219379; cv=fail; b=OLNe0MdjvM2UqrTQiAMDi1YD3HkP85SMTMqS+xTfVQAW/zPDiXEXpdEFLYs70VjTNlHAIDa9km4ke75tRgRR7ukCpvxvzuR4mt+32IKiu1V3LKDyyMwL4JPuYEFdE3KQAj4I7PtyfMfpayoR3KkfM3647P3KAYuQbh/3SftjpgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219379; c=relaxed/simple;
	bh=cBWMYoXs/GgliNDLcM7BNjaQh0ZcTgZ/O0lwWDyHBjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDIa1zl8pVts2jKbOz/847V3RODuOaCn4SmOzCfPRDPABNH646way2rx+a5HFy/XdOBTV4Z57zVVYJJoTWuWwR5OH3W9nXes80fghXB6JHsnS0sB4QXu/O5QfU5nFwJbBQGBNvaXaMQSMIlIV079fhGcUFCX0+uveBc848P6cls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=USTVjs2G; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65BKXKsR2367273
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 16:09:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=cBWMYoXs/GgliNDLcM7BNjaQh0ZcTgZ/O0lwWDyHBjk=; b=USTVjs2GSY6c
	zWNomSf5E8qjahkAqgjmiQDPFbjEPZsjQeJ/b94zb0GF9NeM8mlmXX9Gk+kwYdrj
	cTftYVPuOSFB/1Nr+8gqaK6p3IfQ3KYjnHVtCfJwHBjSmm33QENUybqoFyJiQ/fu
	n4EJcipp1CqI7B0zNUDMYv+OiLaw5YrOS8y/AuI2CPHIovD+hq3X3/vXm3tTqiTy
	HHxPhprLBQNWDBST0hkTSIsZqY1y3fvMFa5eDd8O3gaW+GcwgHrjI92X6wE8vhNV
	AHzq3kcWmOiBGIroHAC2qW3JwOJCgC75sMNCqZsKh1VQyolLrORLN0mB76o4eHEv
	+bQz7LwmGQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by m0001303.ppops.net (PPS) with ESMTPS id 4eqe7a9mrh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 16:09:37 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6f45ce9ceso578885a34.2
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 16:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219376; cv=none;
        d=google.com; s=arc-20240605;
        b=HGYzLZQ6d/B9J8B2u/JcdRJ2rWKO4URJJbM0vzn/dBKuYK5/UKExjK8K4XFTye/3+f
         WEdI9XhievV2BTMan12eg3tEVoy1R15uvUrUrbHYaOR/3y6JW+XsqNM8VLWSKeIPtZUG
         sf05zJbqV2sPW0sjDKHPOmklMrcoRtB+/G0lVaeJ1yCz4bliZtcMWuYDKt8aPyjFxcK/
         zAie2JXmQ3tQtCaw7BFeMjIJ+PyhJGwqn5YrNLwCBuUhd3cG+hpAOh2nafrI1xGhbYnj
         J0QcTGL2l3hTNqW9juDb6fUAjTKot+xLlFnrjilhvOS/NTerxXRLLOQ08/YP3q17JPbw
         aSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=a/OR5+y+259I5l0RIDoEhbbMuNcwkwEsP+caYwaJh3c=;
        fh=2QQOTzVs5Ph3+RP5NvuvcVrWK9DXM1se4nYHZpsiMAQ=;
        b=fsvwLopYidtmGKJPjZMJLfRLYtn5lmfZYXyxCB0fuVDumEawQjfa1ctz0Nw9Vcx2z/
         jcZj7A3M84QHQwYVp7qlFozSAFRd3bQKmp4UfoH0kGRaB6KILxsWlQ/+81df62WKhGIj
         CDpOXIsXJEtnO9CBScEAw5BQThS12qL5Eg7yqvQkFUEC1jWaWj/QiEje+e3KvXxiX2Qc
         JSNu0qiZks0KkyHu7DevMbmOeEObP+3cRrqxiQW3JsrfehVhKMSw2MpDfUgbKZkM/PLE
         ZM/GgiCONrpKXykxH7ypQ0MaruLP8oEOEjS+kIvcPIuKXXSuRkc6+dm+GDkviGilyDmi
         w+Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219376; x=1781824176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a/OR5+y+259I5l0RIDoEhbbMuNcwkwEsP+caYwaJh3c=;
        b=tNTBVBCuDUjfgObhGRnsO1jifLwI7Z8K1/ek6Nw4yJnSd8VmuO9DPmD1o2TCx0ZFql
         97X7+kCto30TvWd8sC99z11lylC/Yc43fop+CDPUn9ZgE+xIyYe4Z7lV7r1IW2OTNnRJ
         EKrI4oj7OpeOvY1FlBNHbGi0ipBtsyZDD35Q4c21t6vhiEDayN3RV/jw+4vK7wSsVWn9
         X4GzHtgdJqV0VFpr87xTJm/prv6KJcLUH6Rn/REC4yAdmrhUuuCAgXfi+ZfUDjdtIXh+
         G3dj0V7tTk9sg+AbcuhkLqoEsF+a72e9gUqd3QV0tLx82LeZxE93r4xIqy+oSavuPTGC
         721w==
X-Forwarded-Encrypted: i=1; AFNElJ+9AhR7XAb/tedA+Ry9OK0EAlu6FSIZWIv8e/wQQV7ISFvIZsTssGiWV1fNxgqmP4X2BkN8t3oTQfyx@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAY5wOP5ni4MG4KJpfMCB4g4tKvD0nHGb8mWVggPwdee7aNtZ
	S+/ta5qGzSbtq2qr1qh/voxEGkmRDL6Upul00/+6mRIG6uz+9PvT/P8GWiJUa83jZCGS7ilZMGo
	X34daYC8Sx4D8vs6wji+Xau1SOLEKvmQWaWK4wK9KMKgjlS9Qq/U9QxP+V4gh+LdUqpNZmcLp3n
	clGdsKgidt+SxQI+IfdGhfe+7RizHmKR7TPt5K
X-Gm-Gg: Acq92OFBw2VfQ8rK5JWLOOwa0M9p5dr2tq/AjWR7OSDoIOwJW1rd3iGuezUbFnrkWUq
	DQAwjaPYkbm48nRPuvroVqL64buvRzKIkmG9PQg4amaE0WHqdIhyznXr4ZcVAWy5h3D1ILNYfxm
	maUbBShRShBNm/YTuhF9h479chtCYU9z3ZNGEvbBSbMpD1MnehiSxH3deYMloHjsn9KX0ogck2I
	M61hR9uzfmMaNpumzabJQ==
X-Received: by 2002:a05:6830:83b1:b0:7e6:7dc7:4542 with SMTP id 46e09a7af769-7e78473ec89mr120380a34.16.1781219376589;
        Thu, 11 Jun 2026 16:09:36 -0700 (PDT)
X-Received: by 2002:a05:6830:83b1:b0:7e6:7dc7:4542 with SMTP id
 46e09a7af769-7e78473ec89mr120344a34.16.1781219376083; Thu, 11 Jun 2026
 16:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-6-zhipingz@meta.com>
 <4dc9ad01-97ce-4c97-9c8d-189822da53b2@nvidia.com>
In-Reply-To: <4dc9ad01-97ce-4c97-9c8d-189822da53b2@nvidia.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:09:25 -0700
X-Gm-Features: AVVi8CeB8nmACAn2v-1nCwadZsgAxPl-ide5TeaDE88hJZn8TEKcdfaG5LmdPSE
Message-ID: <CAH3zFs3ngOXvA5DRzur-_gQ2e0N+-3Az2KmwxZTYczqw34n_Xw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Michael Gur <michaelgur@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMiBTYWx0ZWRfX8RnrgNcA2Isc
 FEIrMfrhIt5j/o+3Us2rjy7Cm4V4h+hfWPeRy+Mim8aN1ooemSn3mVJdOKhGCzbKooOg7OtJLqv
 Nm63r4KuutJY7cSwb5Dl4rof3sOm51F1P8YHohhYXB+rFEwjWzgxPSVk+sQOFVKAFAu7TJoL+kt
 /qieLfGu+yqZ7js3fAuN26h80/u6ibrPpg6JJMQYsUG0A6zBV14Flx90pDmZz7RdUKCJcT30+0S
 uFlP/txNXVdrPvwalCcy4598EM7h7etl7P4GDGLUqbalf2qbIR1uXxhUZZDGujm3EE9yy40qqY/
 MyoIVbbkpyVm75ksdE7QWbfxuv0LJMzIXGtVimR8fzhUAwTH7X06DDD/PcTVu8bD+e89l91Y7u9
 PPzJlwqYZZUtEUilD6xnt9BsH1FEMq9aPxuvznvVXIyqOrU60uoh/+Kro9lkimUcXX7/4I9rfK0
 oir6RkGnIq4rNOmnrEw==
X-Authority-Analysis: v=2.4 cv=AKrEjgtd c=1 sm=1 tr=0 ts=6a2b4031 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=Ikd4Dj_1AAAA:8 a=G2Tmg7Ww-o-apaxFWtcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Qr-dYQpi82RLaoKcpYAswHM5mpc5tad1
X-Proofpoint-ORIG-GUID: Qr-dYQpi82RLaoKcpYAswHM5mpc5tad1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMiBTYWx0ZWRfX1NPDkaBG+DQq
 S6VKYzZ9pQ7N3ASiz4HovtUVI7daEVQJK6WQCab9RinQkA90WLM8Yy0WgcXbPzLlgiHaLLdS0UH
 bXthW2PeXYyQUjENg8L2jtnXIgbKZIQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-22147-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michaelgur@nvidia.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,meta.com:dkim,meta.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5DBA675C51

On Thu, Jun 11, 2026 at 5:44=E2=80=AFAM Michael Gur <michaelgur@nvidia.com>=
 wrote:
>
> >
>
> On 6/10/2026 10:31 PM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> > peer access to a PCIe endpoint and use it to program requester-side TPH
> > on the outbound mkey. If the exporter has no metadata, fall back to the
> > existing no-TPH path.
> >
> > For TPH-backed FRMRs, make the extra ST-table reference belong to the
> > hardware mkey handle rather than the transient MR object. Extend the
> > FRMR pool API so reuse and final destroy can transfer and drop that ref
> > at the handle lifetime boundaries, and add mlx5_st_get_index() to take
> > a ref on an already-known ST index.
> I'd keep the ST reference tied to MRs, where the ST is actually in use.
> There's no functional need to couple ST refcounting to mkey lifetime.
> Once an MR is destroyed and its mkey revoked, the mkey can no longer
> generate traffic, it's just an idle entry in the FRMR pool waiting to be
> aged out or reused.
> This lets us drop all FRMR pool changes from this patch and keep a
> simple flow of 'acquire on MR create, release on MR destroy'.
> > Also decode PH from kernel_vendor_key when recreating pooled mkeys so
> > the requester hint matches the pool key.
> I've fixed that in a series I've sent earlier this week, please rebase
> next version on top of it.
>
> Thanks,
> Michael

ack, thanks!

