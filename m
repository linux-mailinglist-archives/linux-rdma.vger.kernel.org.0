Return-Path: <linux-rdma+bounces-19469-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHANK2TX6GlJQwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19469-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 16:12:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A194471E4
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 16:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81B5C300FEE3
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B2F3ECBE2;
	Wed, 22 Apr 2026 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="pyAqnze3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C93EBF02
	for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776866772; cv=none; b=jduutRMoayeXX5JQuuPtcjJZ9o3d5piYAV3SPyR2pUIVJS1DKT2KSaEmtN/GJi8TQjW6v/zviEZxhC9yoL/49+P7qaPGE7IvrwaIOPQIs4wBBT/i68BUp1v6DM4nvQsoriVsS0aT0e8AbuHxF1bAgJRuZFi1b4Y0eBrY7U+6K5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776866772; c=relaxed/simple;
	bh=rjfPfsfmbPP9z3gwMHV1AFsk0NukmUITYp/7qx1pF2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzJOU/X7/c5ugniXRDxpf4URTwDrAu19LMrLQz4SFvNTzSFYfrImBEu6ZeuqBkGc+b2ytPehHnYXjUlCAPtAv0v0C11gMASiWd1zsHIrjJYn1V/bWvrF8SQJVvMzVH+PAm9ntUqukYqeN311v4dx9i1AkrMiL35/Zs/RNLnub6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=pyAqnze3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso75353055e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776866766; x=1777471566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8bIK72kV9fQN3WhiNh15srx48+WV7B7NYhUj83gfrI=;
        b=pyAqnze3doBEv6YH+kivl9BrWxBNkQtisG/8Enp9D/feBzysRm9BuId41940WJ7QJj
         dHeK033GyvCiCYOluAsDYnrxQHw/QVIRdJTk1zk3NnU/mfry8ktNhTb1YOQh9PsOmo0/
         RPCn5n9MwGuZnKOhF25vNTi3SBLKcunVV1Sp27p6ANzpZ3Ts9liVebDS9UD7GYvmz6Lc
         1jJ1WaHWuN7UUtdNKzSK034VsKZwFGj81NQsu70GK5WTvX4Ueud5M4IT5kZnRadIaMD/
         w1kYFxzqBMJbKoY4dmOd82YBGwYkwKDiwBBT/U5+3N1DPM8p+FypC9MpJ5DmLbqG+/iG
         3BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776866766; x=1777471566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8bIK72kV9fQN3WhiNh15srx48+WV7B7NYhUj83gfrI=;
        b=fI3LITsATnKWd5ajVwnxoCiT3zufmaF4ulVWRkRrQCtPv3wQvAAr/Wi0CfYnISaOAj
         jqNf/55nFgzl6TEEhy7T/8H4tToit/6iC2x+Rw4Vhdt6TtW82NyP8Q1yT39adFBkidY6
         Uf+mZa7nm99jqP8fMpFqIIQLt9g4IzwQswTzzCKMmLmzzAVnhfOLZEXurpDsHkzc/FGO
         S2kFnUQaaQ7dA+BjImB2iglem3RHdUbEgdTQ8QVHEZUFLfxHXtiOjl2eDQxPM27X6/A/
         o+H4PI+fGi9oc09L30muTzpQDpX7Uq44ZS/NH3E86YsyrEqanxWUXxcV6rnSvpHOndol
         ykUw==
X-Gm-Message-State: AOJu0YwFKa35ZUjKSasy916jeLVD1xMaoDkk26C9sIz7tpkIAE5U5eUt
	V9cEVXCwpG1pTPnJktKmkVmXQBxcPLd4OWY92dSkKfC2Hn9ghcYvF+vrYtjkq+iLmLw=
X-Gm-Gg: AeBDiev2FpyGBREEfOqR7A2gs2pSPRkRLlyiFoMGyujblGrmCDJrxr/73uEpPlrfPOo
	/ff5/n20/Sh5GLS9gqY98RBjjHiFP+7Sl1PKJNnW3doFBj7qsGiQk6ijBrT1YeXxryUHcYbmN3q
	fwj9TXVkM9ywsHZe09k/WzX2mU16crr3UCwnV9EqO4Q2Uqa9fnMESxAu3FDpBnUqiaOwMeKvf2G
	JBdvcXSVaGHgUznQuMBosS6VI75Q0JZc1J/XPZTpBg4no/QH8IMwP/dUIvy0r0X/EEn31E3SA/z
	s01WmH5M9yZ1eAJz0AJw4FPkUIM1xwiNI4dbfJojEHFJwt9D8rReODzdtIUxHKepkp2aS+E8xfT
	D+go/quAv/eokfns0Xy2dXBBNt12+SQJPWnTOZ53tJtFysM2VUUHmmG8si689PeRsrTH9x9wLBf
	UPQ2H+eyAMs4SJVh8QhI/FsvlhzjwrB8yvbXXvKMhXGKO8ZygVWArpQSJC
X-Received: by 2002:a05:600c:4e4f:b0:488:a2ac:a34c with SMTP id 5b1f17b1804b1-488fb7433ddmr322882965e9.12.1776866766301;
        Wed, 22 Apr 2026 07:06:06 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a341sm49813065f8f.24.2026.04.22.07.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:06:05 -0700 (PDT)
Date: Wed, 22 Apr 2026 16:06:03 +0200
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
Message-ID: <sdmwjrxzgbg4iz5cspcdkvvdb7rjgdggkw4njct3pkdsvhsq24@qstis6jnplap>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260421134635.GG3611611@ziepe.ca>
 <pun4bxcclwqmurxzxuqlkv5qdpiqcxqjpbhrz7vtsjf2paallz@6f3w32ww4gl7>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pun4bxcclwqmurxzxuqlkv5qdpiqcxqjpbhrz7vtsjf2paallz@6f3w32ww4gl7>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19469-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 19A194471E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, Apr 22, 2026 at 01:33:06PM +0200, jiri@resnulli.us wrote:
>Tue, Apr 21, 2026 at 03:46:35PM +0200, jgg@ziepe.ca wrote:
>>On Sat, Apr 11, 2026 at 04:49:01PM +0200, Jiri Pirko wrote:
>>> @@ -332,3 +333,250 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>>
>>> +struct ib_umem_list *ib_umem_list_create(struct ib_device *device,
>>> +					 const struct uverbs_attr_bundle *attrs,
>>> +					 unsigned int slot_max)
>>> +{
>>> +	const struct ib_uverbs_buffer_desc *descs;
>>> +	struct ib_umem_dmabuf *umem_dmabuf;
>>> +	struct ib_umem_list *list;
>>> +	struct ib_umem *umem;
>>> +	unsigned int count;
>>> +	int num_descs;
>>> +	int err;
>>> +	int i;
>>> +
>>> +	if (WARN_ON_ONCE(slot_max >= BITS_PER_LONG))
>>> +		return ERR_PTR(-EINVAL);
>>> +	count = slot_max + 1;
>>> +
>>> +	num_descs = uverbs_attr_ptr_get_array_size(
>>> +		(struct uverbs_attr_bundle *)attrs, UVERBS_ATTR_BUFFERS,
>>> +		sizeof(*descs));
>>
>>uverbs_attr_ptr_get_array_size() should get a const on the parameter,
>>seems to have been missed originally
>
>Okay.
>
>
>>
>>> +/*
>>> + * Describes a single buffer backed by dma-buf or user virtual address.
>>> + * Passed as an array via UVERBS_ATTR_BUFFERS. Each uverb command that
>>> + * accepts this attribute defines its own per-command buffer slot enum.
>>> + * The index field selects the buffer slot this descriptor maps to.
>>> + *
>>> + * @fd: dma-buf file descriptor (valid for IB_UVERBS_BUFFER_TYPE_DMABUF)
>>> + * @type: buffer type from enum ib_uverbs_buffer_type
>>> + * @index: per-command buffer slot index
>>> + * @reserved: must be zero
>>> + * @addr: offset within dma-buf, or user virtual address for VA
>>> + * @length: buffer length in bytes
>>> + */
>>> +struct ib_uverbs_buffer_desc {
>>> +	__s32 fd;
>>> +	__u32 type;
>>> +	__u32 index;
>>> +	__u32 reserved;
>>> +	__aligned_u64 addr;
>>> +	__aligned_u64 length;
>>> +};
>>
>>This seems like a good idea, we should have done it earlier :\
>
>Yeah :/
>
>
>>
>>Arguably if you do this then the first issue of being more flexible
>>with umems is addressed, so a uverbs_attr_ptr_get_umem() looks much
>>more feasible.
>>
>>Just brain storming, but if we let the driver pass in its uhw
>>information inot a getter:
>>
>>  struct ib_umem *uverbs_attr_get_umem(struct
>>      uverbs_attr_bundle *attrs, u16 idx,
>>      u64 uhw_umem_base, u64 umem_len);
>>
>>  dbr_umem = uverbs_attr_get_umem(attrs,
>>                     MLX5_IB_ATTR_QP_DBR, uhw->base, uhw->len);
>>
>>Then if the new attribute is provided the uhw is ignored, otherwise a
>>ib_uverbs_buffer_desc is created from the udata parameters instead.
>>
>>Drivers use the normal attr indexes to define their many umems for
>>something complicated lik QP.
>
>Won't this go backwards? I mean, I was under impression that we want to
>move the umem creation to core. What you suggest is the driver initiates
>the umem creation. I personally think that it is nicer the way you
>suggest, since the core is the owner and responsible for cleanup and
>umems are created upon need.
>
>One think. How about the consumption checking? I remember that for my
>previous attempt on uverb umems you asked to check if each attr was
>processed or not and in case it was not, yell out at the user.

Well, I think I can still track consumption per loaded attr. I'm on it.


>
>
>>
>>For the lifecycle.. This series adds a 
>>  +       cq->umem_list     = umem_list;
>> 
>>So it is not a big leap to imagine a linked list in the object that is
>>appended by the umem create function. Pass the list head into the umem
>>allocator, free the whole linked list in the core code.
>
>Yeah, that would be okay.
>
>>
>>This has some appeal because it is an easier conversion of all the
>>drivers, instead of re-threading their flows to accept a pre-created
>>umem they just have to be updated to call the new function in all the
>>places they are currently getting umems.
>>
>>You'd probably have a further helper for cq that could extract the
>>existing common cq attrs to a ib_uverbs_buffer_desc:
>>
>>  cq_umem = uverbs_attr_get_cq_umem(attrs, cq, uhw->base, uhw->len);
>>
>>Probably similar for mr and a common mr attribute.
>
>Got it.
>
>
>>
>>This will be easier to put revocable and dynamic ops into the scheme,
>>they can be passed as arugments to the get function instead of some
>>complicated thing in the central ops structure.
>>
>>Jason

