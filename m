Return-Path: <linux-rdma+bounces-16155-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ETwLS8SemnH2AEAu9opvQ
	(envelope-from <linux-rdma+bounces-16155-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 14:42:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD5BA241C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 14:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AE1B300EF86
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED38353EC9;
	Wed, 28 Jan 2026 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qgzw8USD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C84E29D273
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769607670; cv=none; b=G1UMNscKW6HkKFfeL2L3p1CGOCyzdcvhOXIREz3/8jf1LSgKQHJ7dosKz6odkYc3RFGvJPTq332mSDIsD8ulSWKdQZeKMRlc35DJUfdJPhiU571uMbUv0STcrg74YDosYK+AaYt54Oen1W3koHUbpk9EmajtnXgDUl75DJKuNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769607670; c=relaxed/simple;
	bh=tjY3MSRlto3xmanc+UkvG+x9Vqg6LImD4tnOFfB9HcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV2jJOYLkCXD6vqDRLkyC+9PW4IUjcIuCjbmw8PJHIVzoWkR2HMObrMnXUJ6GAIM7yG6ScrjEGfm1DIw6fsLoTEwBiCkbH9uH/N0PE8bAAJA+U4RXCe5xehGqiL07vt4u8VI2Mls+yY8p4/uH1neDncYf+DIKniaEsNDkiguG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qgzw8USD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d256c2e6so6623092f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 05:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769607664; x=1770212464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IEjnNRBV1cO1ALg4JqFXNSzXrH1mabkMvlpmuN+ROc8=;
        b=qgzw8USDylBPPJc+Ls7wrJob583h3yCnzc17zHkdo8jneCI/iI6+MxcCgwedBhHrgM
         Kag1GnDMYpQEW49qLgiKOZUWOcqIGtqp7j/43eD+0pR6RQFK0CSt29ODXLlt//256vQa
         se28oBi0FKC6pj6zVymJ/6Wa7AQErGGx1VkfpVJ4iA+51MYXsVQoQjlPhtqXe4yQQGKO
         /sOi6i9s5zg/TEmM8IKwM4Ml9fMMqxMxvxCh4pc1nCJ6iixzaAN4Qf135tIQeSEujuz9
         yRaHLKhPLzs2eboy/IJ1okSx0MdaFMIqKXVqeJFBTzpSuwLr+IBDvMbKBJYSXoYlR9BC
         X0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769607664; x=1770212464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEjnNRBV1cO1ALg4JqFXNSzXrH1mabkMvlpmuN+ROc8=;
        b=Li359+VF5z8IPrcaEkEqwn4tU7GxBAm1YF8kCG8X4HVzniTQTv25PLqi4/CA+UUlV1
         vuTWzF+g0jjtvZ5BltBbzfwMYBQKl7dlUnbFIP30WgaFyk2y5TaenMpcym8gFEuKQtoz
         XImT4NXVhC5Ya+NLoo40WdrjEUasAoKs7iYzPlEmbUlYsZRHX/tIJo08jJa98US2V8pA
         +PloHUyc+Hvau+Ek9vMMiLaai9cptwlmk36rjdHt1SpVhlufY+mCi0Oek6C0JwvZBSmA
         w48AYSpEd2wgEybRUd3SuRVW++3SglWoxR4ucousx5hiHFjn9qKYk9hQvtlfzI/p22QZ
         PDnw==
X-Gm-Message-State: AOJu0Ywr5fRyXK/hnMbGx6vcD9s3nN3sXEhBjrZrbsVUjvVFX/fAzQ2S
	BFMl+wKt/NCdckWJ96AkXX4BkASqfpGK2WVHYusrO625tnNjYb9GNNC2XOo7RrvYl/Q=
X-Gm-Gg: AZuq6aJVbSuebDPIsCtZ20RlNEnp1DAMba6brcR7Wu8MFvasPttxkxXObrFHSvspt6t
	/voQOYbDT+jLxnfaDAH/3xMQQ2peHWordJJqcLPAbtpbZ5r0gsFKibkJ5Dve8Jf9c4/7fD+9XOJ
	kX4fxuoYjHZ6K3hx7jC/bA7PNaVAaI3huO+sM/dBy8DDyG013jDtoPz1MEWmnjAe36jcMsuUJOD
	I3uoJQKJMUQo1MBpto+Wja98VW6EUu4nfg6WnQ67IIzfe1Nt6HimKkXvcL+FRtqHJ50eiqb/ad+
	dF4tDl8tL1sJBsXcnZMlU4rkTaJaxZConPaUwVJmHkg89JGY2Hyf2GAbLE5VygVX8d0we7oeXm+
	ADW5abd50rckZ/Uh/JZ/nsWR7am0F9GLnyqiWEs0rmO69zHEX464Pp2e233GRMjyxkHz7hwZ2VY
	pwJ17tK+xTVycBFVz8NlGnXxg=
X-Received: by 2002:a05:6000:420c:b0:435:dbc4:3af0 with SMTP id ffacd0b85a97d-435dd05a4bamr7274160f8f.14.1769607664111;
        Wed, 28 Jan 2026 05:41:04 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354d43sm7674665f8f.43.2026.01.28.05.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:41:03 -0800 (PST)
Date: Wed, 28 Jan 2026 14:40:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, msanalla@nvidia.com, 
	maorg@nvidia.com, parav@nvidia.com, mbloch@nvidia.com, markzhang@nvidia.com, 
	marco.crivellari@suse.com, roman.gushchin@linux.dev, "Yanjun.Zhu" <yanjun.zhu@linux.dev>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
Message-ID: <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
References: <20260127093839.126291-1-jiri@resnulli.us>
 <21d63279-79a2-47aa-b305-30a55b8f40f4@I-love.SAKURA.ne.jp>
 <20260127160000.GG1641016@ziepe.ca>
 <05b40f3c-0d21-411a-b61a-156246482327@linux.dev>
 <9975b59a-58e2-4766-9e4e-c927a1d7a3d0@I-love.SAKURA.ne.jp>
 <f3402d0f-40a1-4792-a8e2-be65c71a176b@linux.dev>
 <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
 <0952d053-0de4-469c-88b4-509e6d29296c@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0952d053-0de4-469c-88b4-509e6d29296c@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16155-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: 1BD5BA241C
X-Rspamd-Action: no action

Wed, Jan 28, 2026 at 09:26:52AM +0100, penguin-kernel@I-love.SAKURA.ne.jp wrote:
>On 2026/01/28 13:52, Tetsuo Handa wrote:
>> Two things I worry about Jiri's patch are that
>> 
>>   refcount_set(&device->refcount, 2) in enable_device_and_get() becomes unsafe if 
>>   DEVICE_GID_UPDATES notifications can let someone to call ib_device_put()
>
>Well, since siw_netdev_event() is calling ib_device_put()
>( https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/infiniband/sw/siw/siw_main.c#L403 ),
>calling refcount_set() immediately before setting
>xa_set_mark(&devices, device->index, DEVICE_REGISTERED) is no longer safe.

I may be missing something. How exactly is the notifier in siw_main
related to this patch? I don't see it depends on DEVICE_GID_UPDATES
mark.


>
>> 
>> and
>> 
>>   I'm not convinced that it is safe/meaningful to keep DEVICE_GID_UPDATES notifications valid
>>   between wait_for_completion(&device->unreg_completion) in disable_device() and the beginning
>>   of ib_cache_cleanup_one() because I don't know whether DEVICE_GID_UPDATES notifications can
>>   make sense after device->refcount became 0
>> 
>> .
>> 
>

