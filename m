Return-Path: <linux-rdma+bounces-21029-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFt3IEKADWosyAUAu9opvQ
	(envelope-from <linux-rdma+bounces-21029-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 11:34:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0262958ADAC
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 11:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDF493100AAE
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 09:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E73B9DA4;
	Wed, 20 May 2026 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="g+8UR267"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B583B992A
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268057; cv=none; b=BQozpJunzXz1RqLD99qewfacUxFz4yM4UHy1w3gIkLQ317moyuTSCan7/+1O6FDBg133OlYoKjG1b4+J74mejCfCKuRJLPAubXm1xhAO8Ze210wCf3pLTYRToYWJOSAfoz7QqAvhdOQouKVDHMtACZSPjJSaPEa8RLy+U7mPweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268057; c=relaxed/simple;
	bh=iP5C7imm7fNRAObFMVC95SSs33oFyGPjWCCTSxHdBdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpX2KFDCqLJBZVFdH5F5F1e4H0JLTRP1hY5xcSv26snX7vGTeovRQePp7lc1HsY/JJgRZJWlGukXWumPllsdJMs67cxbdwaTMRBOBR3r1ONksHoN6091bF/LLyb8DBjzQjPHydB+XwYp+kit7RojBPEN1iTuuKh1QBHajdm6sAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=g+8UR267; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48909558b3aso48718895e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779268037; x=1779872837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEQMzHcSJK36bYzeEQ132N8lU42RWr9NLa9/kvn6vtk=;
        b=g+8UR267O7pYor3ZZpXRIWRSU2p3D2951aoanWWJoLeLAsgkIV7rjuw0VFmhg4v4nu
         MuFydlV1i7tMmmXgoBdtNdePOVwomZ2aRASEJuAoZVXDgkBmYEWFkKV8qU0Ws7ipuqds
         ZGwhueORCnioqfE9S3f2XFRnmbj4wXxgs+kEBP8C5rrAk477w5urg+Z70+b9CLCAXFwH
         8CBI+Pdx4lB9QHlczE+Gr5kfVY6+g/VHu0JQwLrPw9IrfprXJnbyPL4fsyFfaBS1YPoc
         RSNvCvpGn7eQSxlEaK7WRyEabSkIbJijgZ4iqoeOKC1Y6D18ZZxStnEHU8kNoCtgzKf1
         rFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268037; x=1779872837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEQMzHcSJK36bYzeEQ132N8lU42RWr9NLa9/kvn6vtk=;
        b=nhHaNjhitiE1C64M3kjNfwbA1N39dZmZeXZ5RhEnoFGvI5JKtbPUg+TnAYvweqNLbm
         6dOKNErYepHoFu/4LnWzQla4GnRpYDxRDowHgYd9phHjgthiF2o7pxIxHiOa7AZyX5wq
         S+Dc6Lr+iFWmnFG4BuPMDNs6u9tZ8o6Y4sD+Uhmab6+NI2WFf6J89SnKWVVt7RWOVd7f
         xAHksU77JLo2Io706xf92Ur0kz7Hu+SEArBsxUG873vJB00XfpHz6dyvW/8EJAotexaq
         c6C6HSeqtBBeCst89nvFEToCTMZ73fjbepI6bkSuF+FQEe/rQAMdF9JEZdK2ZykEoAtu
         4ASA==
X-Gm-Message-State: AOJu0YxFnmARDnvo9u6B0Wo2Oa2fXfz213V7yO3jtp+sZqUvB/ocIjKk
	Sx2tszEoGE5tbOerby4w9z5y3O3RZ16EGTZZvfbcGT+FBtXLN0Xi7zdiCN9Lu5qX24M=
X-Gm-Gg: Acq92OEBgdoOcE+eTffVHc7c0G0mU/ZONniUQRLv7DfKr+rQV6Hl7JIh58feRlQhv6I
	wlQPorH+u1n190WFAwNdiXhCaomkry3Z2mLV+iGUY+pNC3WDc/bAQpLCvWf+avUhHpXZR21DRyD
	xpn77nUitK3CQof8CQvmB+yTri/1X5bPF+Gw2Aed8++p6DcRXT+unUlTUGaA3MLidk+ljEtHOS9
	zdLksrzL4R/eoOROuV8tkEJsRkrO5GfoF73M4YtkLoPQAoKUqmX0bHpf55EPY8Iyr1b0pYNm3Av
	HCqKzYxVT9RXpnvt7+rbk2Z/lgJ9tdf3huZJ3jmnlJzOWpmhjTTuO8h2wRdD2Bl1WOzGufQswdA
	TsBHIemkYXtQiSOJP9/RWhmLJHKfWlYfmo8/vN9L0hANl+nx44SsXww9+xrjZLyxuwF9QwrDV2t
	BeY88K6SdjVetQbSkrIVSCaMJh5hzMkY30XhE6okqq6Po9
X-Received: by 2002:a05:600d:10:b0:48f:e230:2a21 with SMTP id 5b1f17b1804b1-48fe662fd6bmr295172935e9.32.1779268036624;
        Wed, 20 May 2026 02:07:16 -0700 (PDT)
Received: from FV6GYCPJ69 ([77.236.223.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab527asm429157625e9.11.2026.05.20.02.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:07:15 -0700 (PDT)
Date: Wed, 20 May 2026 11:07:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v5 00/15] RDMA: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <ag15o11ZvBNYqRIC@FV6GYCPJ69>
References: <20260517063006.2200680-1-jiri@resnulli.us>
 <20260518133054.GU33515@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518133054.GU33515@unreal>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-21029-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_DNSFAIL(0.00)[resnulli.us : query timed out];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0262958ADAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, May 18, 2026 at 03:30:54PM +0200, leon@kernel.org wrote:
>On Sun, May 17, 2026 at 08:29:51AM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> This patchset introduces a generic buffer descriptor infrastructure
>> for passing memory buffers (dma-buf or user VA) to uverbs commands,
>> and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
>> bnxt_re and mlx4 drivers.
>> 
>> Instead of adding ad-hoc per-buffer UAPI attributes for each new buffer
>> type, each command declares dedicated UVERBS_ATTR_UMEM attributes that
>> carry one buffer descriptor each. Each descriptor specifies a buffer
>> type, covering both VA and dma-buf. A consumption check ensures
>> userspace and driver agree on which attributes are used.
>> 
>> The patchset:
>> 1-2,4. Plumbing: rename ib_umem_get() to ib_umem_get_va() and re-route
>>    it through the new central ib_umem_get(); no behaviour change.
>> 3. Introduces the core buffer descriptor infrastructure and UAPI.
>> 5. Factors out CQ buffer umem processing into a helper.
>> 6. Adds the CQ buffer UMEM attribute and driver wrappers.
>> 7-10. Converts efa, mlx5, bnxt_re and mlx4 to use the new CQ helpers,
>>    with drivers taking umem ownership.
>> 11. Removes the legacy umem field from struct ib_cq, now that all
>>    drivers use the new helpers.
>> 12. Adds optional whole-QP, RQ and SQ UMEM attributes to QP creation.
>> 13. Converts mlx5 QP creation to use the new attributes.
>> 14-15. Adds mlx5 driver-namespace UMEM attributes for CQ and QP
>>    doorbell records.
>> 
>> ---
>> Based on top of: https://lore.kernel.org/all/0-v1-045258567bd6+9fe-ib_uverbs_support_ko_jgg@nvidia.com/
>
>The overall approach looks sane to me.
>
>I have a few minor comments, mostly related to how I expect the
>ib_umem_get_*() helpers to be used:
>
>1. We should hide the ib_umem_get() function and export only
>   ib_umem_get_va(), ib_umem_get_attr(), and
>   ib_umem_get_attr_or_va(). I do not want to see drivers relying on
>   ib_umem_get() again.
>
>2. Pass a struct uverbs_attr_bundle *attrs instead of struct ib_udata
>   *udata to ib_umem_get().
>
>3. Consider simplifying ib_umem_get() further by passing in the desc.
>   I am not fully convinced it helps, but it could allow handling
>   va_fallback outside of ib_umem_get().

Okay, addressing all of that in v6.

Thanks!


