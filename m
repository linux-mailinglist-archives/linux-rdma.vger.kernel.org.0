Return-Path: <linux-rdma+bounces-19480-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKg4F2X/6Gl5SgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19480-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 19:03:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B894491F1
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 19:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73D34305E124
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 16:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7440390C8A;
	Wed, 22 Apr 2026 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eoVh3+xB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28DB37D11B
	for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876665; cv=none; b=N9/9QdRIqcg0UneTJSxdnMZMuQI66+n5ZdGN3G4Fa3ozz2GUlr59VC8QikeQ6DtkYCeA96/+DFtNelLsmVkkkVS16n5ddK9/NVEgQq/JYhULGWbV7aGC70P6npzxnpuf7DYWEgNT94J/laAafb5qfvcjLSL6Ygb7lWKYQnYaP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876665; c=relaxed/simple;
	bh=0FzT8GrzfqbdF4w8YSObjiCxj8dy7d+xn0cBHnCUg/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fri04QgchMeEtlCC8rb3kSEBx5oJV59iyPTGQNDrH7n20Pd8ewPTkWwfjUC5ci/iQeitn2KtG/S83MTju4BKiCmouuyeC8kvzpirU4NCmK8Y5aEY6BZeCcQoTMPgJ8xjAGZFmBjV4pSpsY4jJWSVUlEQgn0Aw4UyZcyarUQQPUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eoVh3+xB; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50faeb8317bso23527921cf.2
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776876663; x=1777481463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+KEXcrItm5uU4UN8RM23enI8p5k0OEwjrYwWwdm+9w=;
        b=eoVh3+xBNASrrcfX4GrPQIdGVRn8vCY8h0KC7nmi/q38rxE48yJn52lm3jIh+b4jyy
         Q0u4GRabAON6MdqAqmtlyHYvTPuBAj99A4D95D1Wasa0I60MqjwnjoshpMlcSWbOk9HI
         cUCGh3HjshsLYGbxueDvf+2gRA2PB7Bxy+L1D5yWi/jAXH1S4klQ/UYT+0fOTrTP0jlj
         JaxGPlq89DRWIcbgfIjJfAWA26H6L8mgttYKDV1hyvMSHD0aJ4JQCTxB8Y2FsnIm6oOy
         IKgxxM+9dLQ6ApEl5PocSURxAGbvzlAI2Hx/TxLwC4e0QNbOqlk+SwpZwQ0WO5W/4Zr1
         HZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776876663; x=1777481463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+KEXcrItm5uU4UN8RM23enI8p5k0OEwjrYwWwdm+9w=;
        b=DuIXT/AYgej79vo/U6IyzPl1UFoTU0GaipFHIods+zToclKQtbdMKgw2ymEOx+SHVi
         bn9sAnhgt43ROHA1gbDSLnBa8v8ouhyoBUVuAGVBATh66HwI/L5e0lt64sGFV1ppUtZv
         7db1jiP4k0eNw+wVnHIWMp7ICPKKXRiNnP6MsF0wBS++7Q/vmCr+4OWL5iswZfg1eK+S
         gTHvoY3KLnLhTiLjLPoDj5R9mMC5Pp5+RAn90eU5wmiT72H3PswS/BOWupUkGdoKQBr6
         SyTAXE9xcUgw9Mms+3HBrMvRLLY1AEbOc99IQSrEtOyOGMiQH3U7H3ylmMEnn2W4Fnn1
         wVlA==
X-Gm-Message-State: AOJu0YwXv/H8cxi+xhu4Xg/xUpHuyMY2OTDqGNOVOsf2XOo03vmF+RnT
	noGx8exUFiFXAcZb0K634HWG7A1CS0C9VvCCrERfStsM3v4PynNJLO6FA5ycn/4LxDs=
X-Gm-Gg: AeBDiesEAHstuo9pgn09/LqyKRtIYvMC6n08juOUcsI1FAxzKUIrKumOp6tyOOLx+1k
	yunjGLntUB0J8dfouJSfIoKRMZUggqdYBX2N+0pKccrNDGORTmesdhc+3Z/XoSENwkQJF5NqRIp
	vPy5VEgRxT4aunc5Znav9oKo97dIlJaCuQLD2uVDbYQjWE/ztgnOPoP8iWFRHrFpw4TdTXf0Fdp
	jklNVe41wWmjcG+SPVI61u+Ix3ovjAAYAqZ1I+SbelB0qd1GzBKl7sgiVwFSDdSiFFABiMOUC8Q
	/oDqsxya5yobbzhKr85HYiRpy8+p5tu3O4WVYZ303xvCz3ICiCfXxvKjwSbmG1JSnVx8dh9RczG
	8Iz5UAZqg8U0OIHGRBj9V4fWO8FAp2+OQpzNKfpKDWgir1pq270MNNF5jqWNhtopC6Y4ToMTyCh
	13IJQ+y9RKuNsY89/2+XsF+m8tqbGOfnheQ8NRAXBRVnBrQN0/vOIXEQGdiGUmaNWVRSJopF9ys
	QbfVvTkE9yhOicI
X-Received: by 2002:ac8:5d12:0:b0:50f:ba44:ce4e with SMTP id d75a77b69052e-50fba44d76fmr96328431cf.6.1776876662660;
        Wed, 22 Apr 2026 09:51:02 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac7834esm131439086d6.18.2026.04.22.09.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:51:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFamz-00000008i4p-2OWv;
	Wed, 22 Apr 2026 13:51:01 -0300
Date: Wed, 22 Apr 2026 13:51:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260422165101.GO3611611@ziepe.ca>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260421134635.GG3611611@ziepe.ca>
 <pun4bxcclwqmurxzxuqlkv5qdpiqcxqjpbhrz7vtsjf2paallz@6f3w32ww4gl7>
 <sdmwjrxzgbg4iz5cspcdkvvdb7rjgdggkw4njct3pkdsvhsq24@qstis6jnplap>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sdmwjrxzgbg4iz5cspcdkvvdb7rjgdggkw4njct3pkdsvhsq24@qstis6jnplap>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19480-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: E7B894491F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 04:06:03PM +0200, Jiri Pirko wrote:
> >>Just brain storming, but if we let the driver pass in its uhw
> >>information inot a getter:
> >>
> >>  struct ib_umem *uverbs_attr_get_umem(struct
> >>      uverbs_attr_bundle *attrs, u16 idx,
> >>      u64 uhw_umem_base, u64 umem_len);
> >>
> >>  dbr_umem = uverbs_attr_get_umem(attrs,
> >>                     MLX5_IB_ATTR_QP_DBR, uhw->base, uhw->len);
> >>
> >>Then if the new attribute is provided the uhw is ignored, otherwise a
> >>ib_uverbs_buffer_desc is created from the udata parameters instead.
> >>
> >>Drivers use the normal attr indexes to define their many umems for
> >>something complicated lik QP.
> >
> >Won't this go backwards? I mean, I was under impression that we want to
> >move the umem creation to core. What you suggest is the driver initiates
> >the umem creation. I personally think that it is nicer the way you
> >suggest, since the core is the owner and responsible for cleanup and
> >umems are created upon need.

Well, brainstorming idea. I'd like to hear from Leon too

But if we set the general goals as:

1) All umem creations should have a struct ib_uverbs_buffer_desc at
   the UAPI boundary
2) ib_uverbs_buffer_desc should pass directly to umem code without any
   driver touching it. ib_uverbs_buffer_desc should be the only way to
   create a umem from a driver.
3) Existing UWH umem descriptions must continue to work if the desc is
   not provided, by reforming them into a desc
3) Cleanup and lifecycle should be centralized

I know the initial thinking was coloured by the CQ design which had
the core do everything, but this is echoing back to the old LWN
article "the midlayer mistake":

https://lwn.net/Articles/336262/

And here we are making the basic choice if the midlayer should alloc
the umem and pass it to the driver or the driver should call a library
function to obtain it.

The primary error to correct is pricipally #1, that the drivers did
not have a standardized uAPI surface so it could not be extended to
new forms of umem types.

So, for instance if we restructure the CQ to follow the library
pattern it would have drivers call some

umem = uverbs_attr_get_cq_umem(attrs, cq, uhw->base, uhw->len);

Which will internally obtain the ib_uverbs_buffer_desc:
 1) Directly from the new ib_uverbs_buffer_desc native ATTR_CQ_BUFFER attr
 2) By decoding and converting the existing attrs to
    ib_uverbs_buffer_desc
 3) By converting base/len into a VA type ib_uverbs_buffer_desc

Then just ask the umem layer to build a ib_uverbs_buffer_desc.

We can follow the same pattern for the other cases. If the uAPI has a
logical all-driver umem then a have a uverbs_attr_get_XX_umem() that
uses a core attr

Otherwise use a lower level function and the driver provides a
driver-specific attr to handle its non-general umem.

> >One think. How about the consumption checking? I remember that for my
> >previous attempt on uverb umems you asked to check if each attr was
> >processed or not and in case it was not, yell out at the user.
> 
> Well, I think I can still track consumption per loaded attr. I'm on it.

Yeah, we need to come up with a good story for how the uAPI should
work. As above there are three CQ options, what to do if the user
provides something nonsensical? For CQ I imagine that the helper will
do it internally with if statements.

In general the uattr system doesn't validate that mandatory attributes
where read by the driver. That might be an interesting debug feature
for sure.

I think my original remark was related to the lists, it is much easier
to pass extra items in the list and that would create a uABI problem
down the road if they are silently ignored by today's kernel.

Whereas if the driver has to define mandatory attributes to pass its
unique ib_uverbs_buffer_desc I'm not worried about future ABI because
eveything is now clearly labled and the uattrs system already has a
built in way to reject using a future kernel's driver attribute on an
older kernel.

Jason

