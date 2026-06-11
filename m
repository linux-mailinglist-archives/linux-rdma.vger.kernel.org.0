Return-Path: <linux-rdma+bounces-22148-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WVrQKi5JK2r75gMAu9opvQ
	(envelope-from <linux-rdma+bounces-22148-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 01:47:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00142675DA4
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 01:47:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b="C/D5WLO0";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22148-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22148-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F143332122B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 23:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E5C3E3179;
	Thu, 11 Jun 2026 23:46:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCC53DDDAE
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 23:45:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781221561; cv=fail; b=UKZdTWAcJSoPEADE7ZG8wsnkb5BqFHyZMhF90FbhTkDzp439A3rB/ZFTOVUGGsOsWhn7ba8tvGplQvIvQLm8jrlrYBs1bN0B9EkzgRggrb8kWwEd30sKomJgIZCH+2DabXW2WFu2u8Gx//N0nBfpTx7UWVo+OhNl1QQCYIh8ehI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781221561; c=relaxed/simple;
	bh=wM82CBZM/T/B4tXhf63AjAwD1f2VxLY1SoQyRorBE9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khM+MAVEtKhRtCqmoz7kfyUsS93mDTJgARIlw7sdxeq6qguYpEBHWJQvs7eRwJCTBMfWDqtt/pkMIyepQUgwBe4pVscWt8Np18wxSK8BFWmMNVBrryOLs6t6FgOdxBKo/qnGnJb1WT3zRsamYXpb19KMA4ByE3yIibqBOe1EAho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C/D5WLO0; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BKdZDO4190005
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 16:45:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=wM82CBZM/T/B4tXhf63AjAwD1f2VxLY1SoQyRorBE9I=; b=C/D5WLO0mmbA
	Ud0JqF5B+NiRYogOXFY27nmYpBJEirm9IRllvwozXjgx8OIFD5ZV8faeqTA3bkPS
	QQWZkebPb05AEUyMH8P16H5UX/fEBtNpeSpSliXT4oXjzyno6ILLCxFInu9/96z5
	1EJj/KLr2YVNpfd/nUoJ5mhagh5nM7sa5TvPfzFUJ71l8C1p7W0tPydae6CxTcqV
	tYwT6puC45+P6mMcS1ezBsA7Os1dhZQGhyxQyH3i47tvMD+VBY2zLGJ1L2IC/Muy
	9fS62yBoiRy7/k9VAoZ+zz+a3YlY8q3mXa4pSOy8Nssbs4fwqZWQUMQUW7GP/2Hm
	q3IRLexocQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe78sx09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 16:45:54 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6fa8bba1dso944279a34.2
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 16:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781221553; cv=none;
        d=google.com; s=arc-20240605;
        b=MhZIJ3Yh4K+cSt8M169wMR4V16vR2vFdXrF31zuUiiHcv2WmCmqhD/4eiMvDpv0t/B
         tqlFbhfB/KoN92kW0YX+EqWe11DyZqFGAedogwMB7FbAMbRgY5coPsH5XpCxewS7Fv1E
         rPiDvKaFBfml34FLsgsv9GgLBSBocd97xPryZnURrazZQy/MTprP8EYM6vFH/ZDSHD5F
         pI5NZxMY8efyer8WXN7t+Y7+hX37h3IJ7cSpYwTCqDZuDsdogLzNBRvz+bbeB3GvNOhq
         cXKxFIhTybzwJMEm83ZxFMeYNF3Xy+h0Q4+nanhYCTJ2YPQBMu7MTsDc6GW282F9EFYE
         l7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=1UnBtkB8A80kDFmam85CYV9Oy02dqYtmeBOXBtV1LT0=;
        fh=REIZUSOf/oriKqBHiIws9gFQ32SdhTvTPpJ95LtX650=;
        b=LmDUCS+GZkBvmx9uGDzuQ5BiCT8xziGf7pZ9XswBzDV5Jixk+4oenuING0tQ2dxGmu
         PLM/qQXKaVYtq1FlmhuQujQuaGrxoJXdlCdX6c1rudPqqMEm40f+0dai73HobCG3DHRh
         ORXPIqPchYLt9cby1npETL9QhYuxjGeZev1M+Tpu1164cX31tWbJDvo3mKUSWi6TkAXo
         stFuozdPWpey6zIpcbS230V/L3fMpVoJM1plOkgvOvgZR5Lhx5AxOYPMm5XLYGY5N3El
         ZUqEfvd752spLaRdDN8Q/iHgaYoCsmhJSSO+BpdldQT1RsK5iXxjnLNWi7RyvK4rHzFc
         qohw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781221553; x=1781826353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UnBtkB8A80kDFmam85CYV9Oy02dqYtmeBOXBtV1LT0=;
        b=QTJf3zg7wQXPFTCqw13y3Mft1rKzBlfrqwcJPxIaaj5iXo97qzl1S7wynwo+rTTXZY
         p4krktE0cH8WauwcqrVdZAEOUuV20Y68r6BXiYfg0S1Ln+rrDPnSHJHsu2Gk7tuM5y5J
         HRbcmIfTSr5RqgZc7MxUi/QCftP2DJV502hqTsXJ8O34QHTG9pp57i2wkJ2uPCRPUyp5
         KqLi4P6xzJQH1exRYOBD3e1WRUGjxhdK3LyOPu7dgILZ5DTF08hT35QHKRlNQVW4jqJ0
         8l23gPjzC+GgGd4DCND7QPoiuhDL1RveK2QaI7PIacNpZY7we95zsb0b/3LvwDnnsOGN
         f+2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9fuUQuv01Y0fFb7p2yAupk4s4bnGwvKqRzE0w0WH+fECnPIsCq3pY5BR7plT74JQi1i2ped25Ghucr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7NeStZiIxuyf6xFHfB3A41v4JivLFXZl+HGI9gpPyuKAYW6tJ
	Q3VsyH/XazfqEGSPqfIY7rARwX9xSiOZRMF3jAFulo2G9oW91MMDC6yjJpGGQDU6zB9X/QgX66z
	Wet0eIP6R4DHtPFSJFWLnsQv2eo9JgZRZ4lMsVaNKNRdFcssUEZI+ScrruLravSk2gZ4DThjyS+
	s23DZJd3LZIJ0ZrJwkNwA3EDNE8fUlNlqSE20U
X-Gm-Gg: Acq92OFKPgK1OB5njYc7mPtuzxD0pF34KtY5iCtacGimyWxJia5d98p8948J51Ng1ft
	/y447d1ZaZ2Kxl0zfdPm71Qh5mZko1LtU+QYf/+fUjwr1PfOO9gxANaARZMhQoAxaFguwMdeFez
	Pa0+4RUx8PliQBqyEXoWvduiUtfna7lgsXor9LVOBc0ppbVbTuYiHujevxJ7K7QkXwtSGKj8Yzh
	B2mPsx8nhQ8RmQNxDkcJg==
X-Received: by 2002:a05:6830:6734:b0:7e7:571:114e with SMTP id 46e09a7af769-7e784871fe1mr152172a34.20.1781221553597;
        Thu, 11 Jun 2026 16:45:53 -0700 (PDT)
X-Received: by 2002:a05:6830:6734:b0:7e7:571:114e with SMTP id
 46e09a7af769-7e784871fe1mr152160a34.20.1781221553208; Thu, 11 Jun 2026
 16:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-2-zhipingz@meta.com>
 <555912e9-818f-4906-a883-6f14e0790672@amd.com> <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
In-Reply-To: <CAH3zFs2UeZfqm2M5tX5bBA6VRw2DjcyT45oGJJag5oT2WvKPJw@mail.gmail.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:45:41 -0700
X-Gm-Features: AVVi8Cfn8yu04sl-GzuR397tWS6RCJ76opDbk_4XDQqGmuG536f9nq5T-lNoRa0
Message-ID: <CAH3zFs21OjkJtYKSqV5rjnEqOU=221LQLY2qXo9pMb79kRSQgQ@mail.gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzOCBTYWx0ZWRfX/y8jO25zEHJN
 IduTAxAOj9bEfLnzL8UcJRWJw8QzguUSrSWtbuKbTKvbUxJriGuMFFypL6tyRSnYKPBTqZ5BKtM
 9r38os4PLE8oUsUlRCbmbMwi7P4t5LxJOrZupXdN6APjztHD324p86io6Aq259gqfBQaHedwzWR
 QtvDRtQ2yAqcwvBmqk/jT+pTq1rIVoN/UnJ7TfHc2O1YxS8K3vB28GpfG3XmVq08y01ar4zyRrK
 GvzQLooPJVLAQqhhHmC+sSZnLkWqjVNnMGc0mtZCwr+990hsWfcbPfcKdqiE1EMbf3Aj51f3L9J
 1qHKdDFV38b77qH9hdtmssvn+jYX3ezoAxqP3hmej1uPybHF2qm2D5vBBvWVPpulNc27YVHFxwv
 +DXAggUJbCror+FV+y5frM0Ox0p9vy6SRWa/jcQWfxgwpVeE6Dpvh7Awemw67pIE1d4SiapdYb5
 QXgT8fBjJzl6ldDPw8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzOCBTYWx0ZWRfX95cIfKfwJF1v
 ic9bgkGQo5sXikFz0tRohyC+Tot4SFI5PhHkYmZXQlNuqzwUW72QCJ7UbQQlo1XXFrnymW4hsnz
 cqfXe3mjw5IJKjaTw3Z/fueUnTwfTKo=
X-Proofpoint-ORIG-GUID: nasbdDIxUR3DqPGMWCKHN-GYnr_RrY6b
X-Proofpoint-GUID: nasbdDIxUR3DqPGMWCKHN-GYnr_RrY6b
X-Authority-Analysis: v=2.4 cv=ZaAt8MVA c=1 sm=1 tr=0 ts=6a2b48b2 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=VabnemYjAAAA:8 a=zd2uoN0lAAAA:8 a=iziE14hG8lcdKKJlCxoA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
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
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-22148-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,meta.com:dkim,meta.com:email,meta.com:from_mime,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00142675DA4

On Thu, Jun 11, 2026 at 3:53=E2=80=AFPM Zhiping Zhang <zhipingz@meta.com> w=
rote:
>
> On Thu, Jun 11, 2026 at 12:47=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > > >
> > On 6/10/26 21:31, Zhiping Zhang wrote:
> > > When the last reference to an ST table entry is dropped,
> > > mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> > > backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> > > therefore accumulate one struct mlx5_st_idx_data per cycle.
> > >
> > > Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> > > struct matches the lifetime of the ST entry it tracks.
> > >
> > > Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > Since this is an obvious bug fix I think it shouldn't be part of this p=
atch set and go upstream completely independent.
> >
> > Regards,
> > Christian.
> >
>
> Sure, Michael replied that he has made a patch to fix it, i will rebase o=
n top.

Never mind, it seems Michael's patch did not contain the fix, let me
submit a separate set.

Thanks,
Zhiping

