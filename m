Return-Path: <linux-rdma+bounces-16199-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC8GDOdUe2nRDwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16199-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 13:39:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEBBB01AC
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 13:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D8B630015BB
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 12:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB393876D2;
	Thu, 29 Jan 2026 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AjW9ysM6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C8344D8C
	for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769690337; cv=none; b=Ikk7oohOBUL56BlWxGyObN4paCXgoz3jC1ojcA15cuxomh8pvP/MbbnFWojd35WvY5/fBh/ykeZbZSvgI246inqMjkFrtUKopUSJ+DVyPQ4+7l3nO+T3VGX8pqN6s3+zoTuUAWKEMoj6rwn4tdocjxMnzpn5qtXUwcTWqnHklbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769690337; c=relaxed/simple;
	bh=D+7VFe+wOhAqnlNeURIMhsZqXgKHA9v/nFULcfyYEAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcAEWpXlykjVzeGGDVZ7ziV5zndNtNuKhXNQ94sZAPkTahhKs122kNrWpIZOksmt3XRCr2AJM5Fgo7aadpE8MGq/KbmF4sVm6oHGeFpzX037Nzhxr1XvAJMgnA9XyJMKtQbgshSkb9hAmtAHAeq4uaOP0SNhHNMP+iFYv2HLQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AjW9ysM6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so9524765e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 04:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769690333; x=1770295133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F1neAC+0vw0p8Oq5u6fkTk35DQPzxGhsNGzoL1CaZkE=;
        b=AjW9ysM6mt1ZCFqPb8cLnDvjr/lZ8TYDVYOnO25y3VcRff6Bvp+BTPcuo6ehTECEi/
         iGJdd+qIsA255mRIMFqt8sTi2/AnzNkF3/sbkqIRnHwhzI5fpL/nzMoyn55IU5zV8jaZ
         LSEcbKpy+BN1UpOWQFi6J2RGQfbps9QdrQaQ+4VtkK3gYP7LEz5uPbf1/Tsfqux5AL4n
         cdD90WkFSOWXQwMeN/5Inomjv4JIVIUHlMEJ0ebLnqc9KaJ93BzF2/14J4B93boEMKOz
         8DsJn3WvQhofetH/bka7H/XL5afspvrNHN2MJ0T55hZD0h5BAUhsQ717BLbHynUju+4b
         06tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769690333; x=1770295133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1neAC+0vw0p8Oq5u6fkTk35DQPzxGhsNGzoL1CaZkE=;
        b=tsFcCdQVmMtyNpHkvyvyoFUIFlqdCQ9pDT9N72ML941RH4LoHr0VG+kAIQa809v2+9
         LMhavWabt5cuWDIKRcs55M25SXlWL7Ekewrt5WGQ4pgTsrmSFKtIwaG5Cs6Gboxd108+
         GsBeciFAj3ThfWL28n6lBk6SpgCBrc6GUCq+xxjdSDbxgem3dEpIjRpn2fh54H+x2xxk
         ZqdseRDG8P4GWcQiUfgrpdykKN9Z1u/xpFO1qziZZ/PT0qzNGlcVcqRWh6vHj4i1To9y
         1LE91MGhHiSBztcu3Qq0M+gdBpfDCFQ1f8IK81N6Fxwe7+L6LPy3ljuCqgotxicnBZiY
         tC2g==
X-Gm-Message-State: AOJu0YzxOlCQapYnnYoK5KD4n5x19trYYghNxvavG7HkyEg9UCM2hY9L
	nbjCKoYevxDMRORrvT/9XbiBoimHYS/0VtsquVktdUuHKPNkTZtHQcsdf0tWFfOSFNotQFOONTA
	8Nk3N
X-Gm-Gg: AZuq6aICl+mf2+TtkE77mMYEHnzjv9LMhuXUSVFwt7uL6F5vg0W/TCB8Co5jQ3HlcHI
	ByY1lXatKCbD4G0WN6DCvMKPl809kjWbDnaIqPsvd8E4W9eTv8eluURadj5RcXs7F2WiXUM2oFi
	hvqWpmh6pN2lsIM9WgcVbI28/6l3uyvJiX95QOlEOBU6xrQAbSj7ZwtQbKr+qMslJmDL/kdBj0W
	HFLJZSsyxYXmcpWWQybITzyQUDO2DPxN0LHsJ3/OuE57XrplE0TUxUIJXrb/Q/yUANnleXjl2T4
	QMhUBVnEpIjv6u+ot2WQHUQreyaNCTOaxLApPaCf4GoU0BsiAf0WF262lqMq9QYIWBjkE4j0xfy
	pnBvyM1+byvfSRbwi/FDNgj7tt4NOL+3UH+iIXRmlE+oINau0xsyvi+1Hptsn/QLy5v+NLhuzN1
	LHIDu9T3BslQMKiq5fVcM=
X-Received: by 2002:a05:600c:524a:b0:479:1ac2:f9b8 with SMTP id 5b1f17b1804b1-48069c556b8mr26627385e9.21.1769690333018;
        Thu, 29 Jan 2026 04:38:53 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c37433sm176722255e9.10.2026.01.29.04.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 04:38:52 -0800 (PST)
Date: Thu, 29 Jan 2026 13:38:50 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, msanalla@nvidia.com, 
	maorg@nvidia.com, parav@nvidia.com, mbloch@nvidia.com, markzhang@nvidia.com, 
	marco.crivellari@suse.com, roman.gushchin@linux.dev, "Yanjun.Zhu" <yanjun.zhu@linux.dev>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
Message-ID: <inp2nyil62tkkvahvjvwvgp63ld5cffgowqhwlbssabhd2gaka@52lfxbmxvbzi>
References: <20260127093839.126291-1-jiri@resnulli.us>
 <21d63279-79a2-47aa-b305-30a55b8f40f4@I-love.SAKURA.ne.jp>
 <20260127160000.GG1641016@ziepe.ca>
 <05b40f3c-0d21-411a-b61a-156246482327@linux.dev>
 <9975b59a-58e2-4766-9e4e-c927a1d7a3d0@I-love.SAKURA.ne.jp>
 <f3402d0f-40a1-4792-a8e2-be65c71a176b@linux.dev>
 <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
 <0952d053-0de4-469c-88b4-509e6d29296c@I-love.SAKURA.ne.jp>
 <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
 <1dc21045-4030-4d37-9ae6-3dd2c42b8e88@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dc21045-4030-4d37-9ae6-3dd2c42b8e88@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16199-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,i-love.sakura.ne.jp:email,bootlin.com:url]
X-Rspamd-Queue-Id: 3CEBBB01AC
X-Rspamd-Action: no action

Thu, Jan 29, 2026 at 07:06:31AM +0100, penguin-kernel@I-love.SAKURA.ne.jp wrote:
>On 2026/01/28 22:40, Jiri Pirko wrote:
>> Wed, Jan 28, 2026 at 09:26:52AM +0100, penguin-kernel@I-love.SAKURA.ne.jp wrote:
>>> On 2026/01/28 13:52, Tetsuo Handa wrote:
>>>> Two things I worry about Jiri's patch are that
>>>>
>>>>   refcount_set(&device->refcount, 2) in enable_device_and_get() becomes unsafe if 
>>>>   DEVICE_GID_UPDATES notifications can let someone to call ib_device_put()
>>>
>>> Well, since siw_netdev_event() is calling ib_device_put()
>>> ( https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/infiniband/sw/siw/siw_main.c#L403 ),
>>> calling refcount_set() immediately before setting
>>> xa_set_mark(&devices, device->index, DEVICE_REGISTERED) is no longer safe.
>> 
>> I may be missing something. How exactly is the notifier in siw_main
>> related to this patch? I don't see it depends on DEVICE_GID_UPDATES
>> mark.
>
>I don't have an accurate and complete list of notifier callback functions that are called by
>DEVICE_GID_UPDATES notifications. But in general, I think that there is a pattern that an IB
>notifier callback function tries to grab a reference to "struct ib_device" before doing
>something, and releases that reference after doing something.
>
>If you can prove that none of callback functions that are called by DEVICE_GID_UPDATES
>notifications follows this pattern, it will be fine for now. But that might change in future.
>Enabling callback before initializing refcount is a source of refcount imbalance troubles.
>I expect your proposal to include
>
> struct ib_device {
> 	(...snipped...)
>+	bool device_was_fully_initialized;
> }
>
> static inline bool ib_device_try_get(struct ib_device *dev)
> {
>+	BUG_ON(!device_was_fully_initialized);
> 	return refcount_inc_not_zero(&dev->refcount);
> }
>
> void ib_device_put(struct ib_device *device)
> {
>+	BUG_ON(!dev->device_was_fully_initialized);
> 	if (refcount_dec_and_test(&device->refcount))
> 		complete(&device->unreg_completion);
> }
>
> static int enable_device_and_get(struct ib_device *device)
> {
> 	(...snipped...)
> 	refcount_set(&device->refcount, 2);
>+	device->device_was_fully_initialized = true;
> 	down_write(&devices_rwsem);
> 	xa_set_mark(&devices, device->index, DEVICE_REGISTERED);
> 	(...snipped...)
> }

Since the notifiers I'm trying to fix don't use
ib_device_try_get/ib_device_put, I don't see how your proposal is
related to my fix. Feel free to send it as a separate patch if you like.


>
>for proving that there is no race.
>
>Also, I don't know whether we even need to introduce DEVICE_GID_UPDATES.
>Your patch description sounds to me that calling rdma_roce_rescan_device()
>generates GIDs with current MAC. Then, why not call rdma_roce_rescan_device()
>once again after xa_set_mark(&devices, device->index, DEVICE_REGISTERED) ?

Investigate the rdma_roce_rescan_device() code properly. Unlike what the
name might suggest, this is only initialization. It does not count with
having existing entries in. I think that processing events properly when
they come is a superior solution.

If I'm not mistaken, you didn't pointed out any real issue with my patch,
only some guesses. So do you see any real issue?

