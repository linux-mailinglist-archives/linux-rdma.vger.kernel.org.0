Return-Path: <linux-rdma+bounces-19468-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOz8GVOz6GmIOwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19468-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 13:38:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C96CF445836
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 13:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37DD73047DEA
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7267937F8A1;
	Wed, 22 Apr 2026 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="f9LRfX9N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129E35DA48
	for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857597; cv=none; b=hnM9AONMwXA5UtRyPx/OE6ZwS8KRdRBGz3oQJdf6ScXvj6TkjvrAGJA3gSN9tY58Q6GE77yL+t8onpgfrH/gD/YYUZm5B4jkch86aKb7luqV/NcHvlvRVPTEqdBMPLpCkpfrx6IB6AxGiQkfCgV0sa5ZPHV0qmFXrPvSP+Gw7o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857597; c=relaxed/simple;
	bh=7+8IRm0qojfPVAZfYmgc/hIjtjSqIZuednlIQWlVODY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy0rs0zLHoV9zGu3v5FCj1e2kjuqo35uIrSIq9XwBgb8biCtr6pp+TORKyettRMhMFO+RrkO/riEr7S3+cSgy77UwIHd3ouUQeI9eZ2WfTI5RbpZFYZLM1E/sgTmqYt+SQC1h/GTS887Auen1kpmBzni5A7WecFUUZY/4ttPigk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=f9LRfX9N; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4890098abbaso38034465e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 04:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776857592; x=1777462392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4vyLiMv1zi5HKWYgVI4Qwkd4iritRTqvdbC/ZDauTvs=;
        b=f9LRfX9NMHICAfEroqmeD1qXEj4Dxclrd6GRR1btp3rptO2B65D11fFSxN6wpXl/0K
         6IzgqVpynsZCxqvlY92N8rHw1Wsz2P9DSL5whNXOiW62RKfTlokmOWMyxCZEidJKbrXx
         s49j5kDsULMTIB9bRk3dxhUUKdXsQjctvwca/Duptyou0WKgO0syRkgkl9w7YTh5T9z/
         u7/Ur5NixT5ug6DmEkPjhuuULAcAC+BkQxhkmyvNhMM75ezasZkHWsb2vPGmQ/FA2Zno
         4mB7uiD2bBcBAQymtmk19krSgmJ3tObz2zs3/jkHmIXh8dkcWkVdTK7ZPOP8rQNn/YOY
         HiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776857592; x=1777462392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vyLiMv1zi5HKWYgVI4Qwkd4iritRTqvdbC/ZDauTvs=;
        b=bqg+WrQ0ZUH3cVCzUfhA5bin/1dwY5YVhucDFdLM3Wu78rJzKG2CrkvHczqkG0ijcF
         YEFgLcAd46TKh1fpSoxLSEpU/069ip/ITy69d6TQPHaA2nigfjLR3uYXQ2KhORhg5NOJ
         xWOvv58g74gbMiCyfUhZpfUPmUZ/xC4QfKoz61kqTy3lgE2RkCDSxNKM8ZYgqu4BRt/s
         R0P3n9EqgS8tBh57rSDd4I1cQHn9/aNYPV8dBT2AP6LF8tEtFJPd82ykHAFBFIAGNGeP
         z9eY8jN1rmAelPCMbjqKAR4d0AhN34Zdgr2EotHUhWPB3DdSrT5OacTbEcZiS/b7KAAa
         Niaw==
X-Gm-Message-State: AOJu0YyQ4PU1+2Hwtc4YaNYwD8V8T0TqF705aZUImshp2NQyGX6IXB8O
	FXfSg4HZV5TYuMzz9rmKiEyJFuQFTAqFhNOUyTvorJnOkunqKotSRejcTvSMwpWWdWg=
X-Gm-Gg: AeBDievd3G2PMui5LUhjN3q41JBGtNJCXXAMd/ftMOmVPOC9KqXitKevuJ4W+o/G5EG
	UJSxB6SO7yiTTc6oxOZ13Fbjp4qWEYhpwqmXYd0jmzP7hXOU0O6Vf36QqgkZAMZa/ItvseU5YwF
	c+MWIEuIMwgtAuj8erQkd3QED/iJ66IqY/9GfRuA3fzqvUIRNk9kcnNgxlm2ooznzCt6I5Qk/EM
	nVyFAFeZbddy4QQbEAgVX+DW0gL7qXmKZBp6aIwX5LE+/ulYqPildLRjX/6bDmKb7WSZWbkfZF/
	MaX1ONTCpraXGX0RQwkd6Jc93ZM3y47kU4VLkqMaRAau1DSzVPH5dbOqJSGykeXck8FMSlk/snl
	Qr86hdbszVelYaZTCjmcgOH+MMhtV4iqumH58rWZpKbWcPXGACpxz1OF4/5bnt+8YQOR6URuoZJ
	YlTxpdUXVMk2VDA6chUYNelApV+LNtZghjXCD4ZDBTfhWDTA==
X-Received: by 2002:a05:600c:8908:b0:48a:58e1:6d02 with SMTP id 5b1f17b1804b1-48a58e16eb2mr49402215e9.19.1776857591470;
        Wed, 22 Apr 2026 04:33:11 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f82bbsm744567055e9.3.2026.04.22.04.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 04:33:10 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:33:06 +0200
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
Message-ID: <pun4bxcclwqmurxzxuqlkv5qdpiqcxqjpbhrz7vtsjf2paallz@6f3w32ww4gl7>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260421134635.GG3611611@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421134635.GG3611611@ziepe.ca>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19468-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C96CF445836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, Apr 21, 2026 at 03:46:35PM +0200, jgg@ziepe.ca wrote:
>On Sat, Apr 11, 2026 at 04:49:01PM +0200, Jiri Pirko wrote:
>> @@ -332,3 +333,250 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>
>> +struct ib_umem_list *ib_umem_list_create(struct ib_device *device,
>> +					 const struct uverbs_attr_bundle *attrs,
>> +					 unsigned int slot_max)
>> +{
>> +	const struct ib_uverbs_buffer_desc *descs;
>> +	struct ib_umem_dmabuf *umem_dmabuf;
>> +	struct ib_umem_list *list;
>> +	struct ib_umem *umem;
>> +	unsigned int count;
>> +	int num_descs;
>> +	int err;
>> +	int i;
>> +
>> +	if (WARN_ON_ONCE(slot_max >= BITS_PER_LONG))
>> +		return ERR_PTR(-EINVAL);
>> +	count = slot_max + 1;
>> +
>> +	num_descs = uverbs_attr_ptr_get_array_size(
>> +		(struct uverbs_attr_bundle *)attrs, UVERBS_ATTR_BUFFERS,
>> +		sizeof(*descs));
>
>uverbs_attr_ptr_get_array_size() should get a const on the parameter,
>seems to have been missed originally

Okay.


>
>> +/*
>> + * Describes a single buffer backed by dma-buf or user virtual address.
>> + * Passed as an array via UVERBS_ATTR_BUFFERS. Each uverb command that
>> + * accepts this attribute defines its own per-command buffer slot enum.
>> + * The index field selects the buffer slot this descriptor maps to.
>> + *
>> + * @fd: dma-buf file descriptor (valid for IB_UVERBS_BUFFER_TYPE_DMABUF)
>> + * @type: buffer type from enum ib_uverbs_buffer_type
>> + * @index: per-command buffer slot index
>> + * @reserved: must be zero
>> + * @addr: offset within dma-buf, or user virtual address for VA
>> + * @length: buffer length in bytes
>> + */
>> +struct ib_uverbs_buffer_desc {
>> +	__s32 fd;
>> +	__u32 type;
>> +	__u32 index;
>> +	__u32 reserved;
>> +	__aligned_u64 addr;
>> +	__aligned_u64 length;
>> +};
>
>This seems like a good idea, we should have done it earlier :\

Yeah :/


>
>Arguably if you do this then the first issue of being more flexible
>with umems is addressed, so a uverbs_attr_ptr_get_umem() looks much
>more feasible.
>
>Just brain storming, but if we let the driver pass in its uhw
>information inot a getter:
>
>  struct ib_umem *uverbs_attr_get_umem(struct
>      uverbs_attr_bundle *attrs, u16 idx,
>      u64 uhw_umem_base, u64 umem_len);
>
>  dbr_umem = uverbs_attr_get_umem(attrs,
>                     MLX5_IB_ATTR_QP_DBR, uhw->base, uhw->len);
>
>Then if the new attribute is provided the uhw is ignored, otherwise a
>ib_uverbs_buffer_desc is created from the udata parameters instead.
>
>Drivers use the normal attr indexes to define their many umems for
>something complicated lik QP.

Won't this go backwards? I mean, I was under impression that we want to
move the umem creation to core. What you suggest is the driver initiates
the umem creation. I personally think that it is nicer the way you
suggest, since the core is the owner and responsible for cleanup and
umems are created upon need.

One think. How about the consumption checking? I remember that for my
previous attempt on uverb umems you asked to check if each attr was
processed or not and in case it was not, yell out at the user.


>
>For the lifecycle.. This series adds a 
>  +       cq->umem_list     = umem_list;
> 
>So it is not a big leap to imagine a linked list in the object that is
>appended by the umem create function. Pass the list head into the umem
>allocator, free the whole linked list in the core code.

Yeah, that would be okay.

>
>This has some appeal because it is an easier conversion of all the
>drivers, instead of re-threading their flows to accept a pre-created
>umem they just have to be updated to call the new function in all the
>places they are currently getting umems.
>
>You'd probably have a further helper for cq that could extract the
>existing common cq attrs to a ib_uverbs_buffer_desc:
>
>  cq_umem = uverbs_attr_get_cq_umem(attrs, cq, uhw->base, uhw->len);
>
>Probably similar for mr and a common mr attribute.

Got it.


>
>This will be easier to put revocable and dynamic ops into the scheme,
>they can be passed as arugments to the get function instead of some
>complicated thing in the central ops structure.
>
>Jason

