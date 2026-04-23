Return-Path: <linux-rdma+bounces-19504-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKcEM8ca6mkOuQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19504-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 15:12:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E84528E5
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 15:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D62C730589B3
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3F3EFD2E;
	Thu, 23 Apr 2026 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="P6dhOWme"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D53EF66A
	for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 13:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949710; cv=none; b=pP/Eu9gcar13+6tr63oVEwiS3yJ5CydZtDocKf5ukrM3SK1wAA8SMaDAzvDOVquv73oKX4UhU1int6JF38R9vB2Gx7t7a01x5gxHTYlgqgzLLjO2ySp5mRdr0o2pw6OTe8rifu29a6H2d/Au2Q4J4BuA8gbv+95yjk6HIJe0Vz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949710; c=relaxed/simple;
	bh=OkDTkhToRwDzCmMaGkip4+QzuX2WKP0dYRAj0n9QUDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB22ZltCaB9WO6sj9ARygYqFseFM1J6PFhoFN8HEq62s3WSZ0DNqTT6KHhwrI1CE1qeKSYC1RlsirW+vGaxO+x0pQZ2cBIMzbE1/qaT0i6XaPaHepijPW3/e7DHduTeiy8sNLipWLqRc5XVrWzST9G97/NFjDHtZfXfApQfhd6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=P6dhOWme; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d77f6092eso4588553f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 23 Apr 2026 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776949703; x=1777554503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGjBh78wQmXAHUVAsECrni8j5+F5B6VeLih63ZgIOW4=;
        b=P6dhOWmeGitf3ZtQuNyJTH9Dp/ho2p+GaMQjifWllIPDbvEGuZE9w9MaJROobyiJh2
         kjJTWwqzbo5qqlS+UbN/kVC5J7+yZ24bUa+fWR4nDHOGbO4uMvML3jACgHvR7PD7mZ0g
         5GDDwQJekjAT/Igi36SymKVG8w8aT/4u6lpdmtgwfxDPlbgTAGM6601o7wV0mKceRe1D
         UedXV6ZsvYr+aPxDhX/t2SXhqvQ84mWMKGHmSd66Bh+Pg+0RHuf2LpbLUkv9b0GEGxUr
         kyTdlvytKW6rC7ENDe3Bnmum3gUsuGJsWPZ2z+nYQRPo1TiyDVp1tTPEePfQwfh0YPDK
         st2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776949703; x=1777554503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGjBh78wQmXAHUVAsECrni8j5+F5B6VeLih63ZgIOW4=;
        b=dW2gzpptRzqTDlexlte+fzOWat1BxY1Qh7+u85M8vjHDkpoH8SGZrlX1EgbsDbVU6C
         I5rJC18cy7fJrXMgY0yFpsZYRZonenWGlnYMki65JTPJVFzYEQxNd9ur6IFo8tUdncXh
         x03AcOGZ8cF69s7NTf3AWnectWeKy1DcZd3fqqBgDtLJic6O+1G08Qui4ICaTyab+v5s
         51w2ZOOAvVuihc4lR29skDrkSq3E84wUXT7Qy16cgkxDbgCIjskBAOrYDWrvI6mHtOiO
         4Byg132WOP+AFw1CoDDxb5nndZE+oYPc6QQQ7xFyy5A68DSPNTWwGQt91qRg3De9B6tE
         SseQ==
X-Gm-Message-State: AOJu0Yxbq5JHCxynxJVKlY/pBJbTf/llWVzWycCjgU+ePwVmYURXXZeQ
	HWDZUSm1Xcn7CSoC9v71GuvzM6a3Pq9ytui2lw945qRKE0Y47v0T/YHFzm2ptB8Fwf0=
X-Gm-Gg: AeBDiesek4MfWBG8LucYMe51URIRiMWD1esrGKnafTI26tulc3NJ+4OdwY6x5xFG1WT
	5eVPs598nhnk+CFUuZAb/e+jV5/euB0CQ5XQvLucLjP3gfVAM2BiYY/ancPEcMo8X+90siQDS/g
	gwc+gjvsaxZyCc3+RDknTafUiM+7KQXFcJpHFyNF8NvqcKss1Re+uOYOPlup7trfcOnaK0c0wUH
	RhCJThaPI+KCZ2VQnsFtlLImuImKETTyOcikVbCt3GWud5IqPewmbDOOboXjsIs9ahvERQEgq/D
	D5sHySjHYRn04IvKqLH4EH/8HRXIEu/rTDGGgo2AvaXsSRnRo0VLMAMoDKnjA0Ho4VburjAJ0Qr
	ifwWyTEvfQylS44BfnuBlIsSsfOI3eIT1fexexas0y1Bgx/ZAIFhZQxCqytbv/mspzS6YLOWnha
	x5t8AMoCpCbKa28RX9L403oGi/weD1sn6IZTf0uyVHYbkCuyUWEI1o6w==
X-Received: by 2002:a5d:5d88:0:b0:43d:7d6f:f535 with SMTP id ffacd0b85a97d-43fe3e10c0dmr41056366f8f.35.1776949702730;
        Thu, 23 Apr 2026 06:08:22 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:1da0:a4b0:3706:f2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44123d23e0bsm14084068f8f.15.2026.04.23.06.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 06:08:21 -0700 (PDT)
Date: Thu, 23 Apr 2026 15:08:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <lyzh6ftbtjoznz2vrswoofy4tv5fqoqe6ajrlqdpqbd7aemtw4@lz3ilcid4vsx>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260421134635.GG3611611@ziepe.ca>
 <pun4bxcclwqmurxzxuqlkv5qdpiqcxqjpbhrz7vtsjf2paallz@6f3w32ww4gl7>
 <sdmwjrxzgbg4iz5cspcdkvvdb7rjgdggkw4njct3pkdsvhsq24@qstis6jnplap>
 <20260422165101.GO3611611@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422165101.GO3611611@ziepe.ca>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19504-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.232.135.74:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 6F6E84528E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, Apr 22, 2026 at 06:51:01PM +0200, jgg@ziepe.ca wrote:
>On Wed, Apr 22, 2026 at 04:06:03PM +0200, Jiri Pirko wrote:
>> >>Just brain storming, but if we let the driver pass in its uhw
>> >>information inot a getter:
>> >>
>> >>  struct ib_umem *uverbs_attr_get_umem(struct
>> >>      uverbs_attr_bundle *attrs, u16 idx,
>> >>      u64 uhw_umem_base, u64 umem_len);
>> >>
>> >>  dbr_umem = uverbs_attr_get_umem(attrs,
>> >>                     MLX5_IB_ATTR_QP_DBR, uhw->base, uhw->len);
>> >>
>> >>Then if the new attribute is provided the uhw is ignored, otherwise a
>> >>ib_uverbs_buffer_desc is created from the udata parameters instead.
>> >>
>> >>Drivers use the normal attr indexes to define their many umems for
>> >>something complicated lik QP.
>> >
>> >Won't this go backwards? I mean, I was under impression that we want to
>> >move the umem creation to core. What you suggest is the driver initiates
>> >the umem creation. I personally think that it is nicer the way you
>> >suggest, since the core is the owner and responsible for cleanup and
>> >umems are created upon need.
>
>Well, brainstorming idea. I'd like to hear from Leon too
>
>But if we set the general goals as:
>
>1) All umem creations should have a struct ib_uverbs_buffer_desc at
>   the UAPI boundary
>2) ib_uverbs_buffer_desc should pass directly to umem code without any
>   driver touching it. ib_uverbs_buffer_desc should be the only way to
>   create a umem from a driver.
>3) Existing UWH umem descriptions must continue to work if the desc is
>   not provided, by reforming them into a desc
>3) Cleanup and lifecycle should be centralized

Agreed.


>
>I know the initial thinking was coloured by the CQ design which had
>the core do everything, but this is echoing back to the old LWN
>article "the midlayer mistake":
>
>https://lwn.net/Articles/336262/
>
>And here we are making the basic choice if the midlayer should alloc
>the umem and pass it to the driver or the driver should call a library
>function to obtain it.
>
>The primary error to correct is pricipally #1, that the drivers did
>not have a standardized uAPI surface so it could not be extended to
>new forms of umem types.
>
>So, for instance if we restructure the CQ to follow the library
>pattern it would have drivers call some
>
>umem = uverbs_attr_get_cq_umem(attrs, cq, uhw->base, uhw->len);
>
>Which will internally obtain the ib_uverbs_buffer_desc:
> 1) Directly from the new ib_uverbs_buffer_desc native ATTR_CQ_BUFFER attr
> 2) By decoding and converting the existing attrs to
>    ib_uverbs_buffer_desc
> 3) By converting base/len into a VA type ib_uverbs_buffer_desc
>
>Then just ask the umem layer to build a ib_uverbs_buffer_desc.

Yep. I have that planned-out.


>
>We can follow the same pattern for the other cases. If the uAPI has a
>logical all-driver umem then a have a uverbs_attr_get_XX_umem() that
>uses a core attr
>
>Otherwise use a lower level function and the driver provides a
>driver-specific attr to handle its non-general umem.
>
>> >One think. How about the consumption checking? I remember that for my
>> >previous attempt on uverb umems you asked to check if each attr was
>> >processed or not and in case it was not, yell out at the user.
>> 
>> Well, I think I can still track consumption per loaded attr. I'm on it.
>
>Yeah, we need to come up with a good story for how the uAPI should
>work. As above there are three CQ options, what to do if the user
>provides something nonsensical? For CQ I imagine that the helper will
>do it internally with if statements.
>
>In general the uattr system doesn't validate that mandatory attributes
>where read by the driver. That might be an interesting debug feature
>for sure.
>
>I think my original remark was related to the lists, it is much easier
>to pass extra items in the list and that would create a uABI problem
>down the road if they are silently ignored by today's kernel.
>
>Whereas if the driver has to define mandatory attributes to pass its
>unique ib_uverbs_buffer_desc I'm not worried about future ABI because
>eveything is now clearly labled and the uattrs system already has a
>built in way to reject using a future kernel's driver attribute on an
>older kernel.

Hmm, but the attr may be optional, yet silently ignored (for example by
driver that does not support it). I think we still need to sanitize such
silent ignores.


>
>Jason

