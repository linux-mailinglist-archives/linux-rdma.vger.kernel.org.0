Return-Path: <linux-rdma+bounces-16541-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCW5BoWJg2lDpAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16541-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 19:01:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BFEEB4E0
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 19:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2433630992FC
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBED3B8D6C;
	Wed,  4 Feb 2026 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="STmAxEvc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A23A7F66
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227803; cv=none; b=nJzzQkhDNe6UhWFXiABEfLN2Bc98WW9dSmIuhqBQQYQSKi4FQOLtF+0SM95DV0+c4M6Jo/omNbIFJMpVS9Ycj6a+0CjixBv139C2z7t0mRH6v/kEJWWnwVa5SByDqbWn0lTlH0J0dEJ5xyGbqxvCcWV3r23ysBPySu89jC9KXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227803; c=relaxed/simple;
	bh=JWCSTzcXvAj5GFyCJ9ZraH5jh6O6DAyQvwZt7guvJAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av0tpWk686EmynH3aUbF+qY0EnaKgU5NMfw5QiAISVyV8jAGIoknLB2J0jwKjdCyRgMD9R3sDRlfpn5NMrDgKho6Qf5oKQst6vQCBtaPxC+QhfF10WgFj+TosyDniZhHU0AU3gGmoaG9t0d7EyAgGvsdfLxjaQ3LoL5lVs7hvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=STmAxEvc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d2c96215so125978f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 09:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770227801; x=1770832601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJIbESDdAImf0JMHJLzZ1YzbfqoUdQWz/4BQ9AfMwh4=;
        b=STmAxEvc2BGAeGrP1ASrenrfTuR+m1tlXXFgIsyPGaFAoRyWH+vIDmq2ilspDYL+n/
         DzPg/EBsL7wi19tnUK3UVdcmL+7WSXsOI4fKky0QrmsUsCIMGPurbs1GYxvQ6iawxFMj
         TEGNGDY7zv9VNqtQeYj1soS4uECia8QF6xvR1wVWgskmMiCybY413HDogmDCVrAW8Pth
         rvF9Da6fCKRIOimr3Qnch1mB2a+L7Y87sFYuI/kFBq0Lh3t468w8S62dwxskRXPyQtTU
         PydzuZBhae8Gsz+42obe+bzT+6+zE9aOHQfj5vF3Fvnve7zCqsMoV2Vfwn17n8NaH7P4
         ljOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227801; x=1770832601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJIbESDdAImf0JMHJLzZ1YzbfqoUdQWz/4BQ9AfMwh4=;
        b=TojcDpIXIaK50X7gdzLah9/wZZSBOgz9OqWqxWNLhWzrBYkEKnNDCaGxtVrLSsZ21g
         p9zvYIYgQVcYvsUfc29yfFZu/ysHJtXRS2aAlDfiejqslLZfmhN5Jj2HjrjNXWIyzW8G
         9KX7AwQ3xRi8x0/5it4RqVTKr+N7EkcM9P/8AW1L6ZrnJ80zBgAnXyGOUcAFNvd7sNvf
         PPNKRzFp8OVhzE/J2Mo/5OCyJy8UOFEfH0xgK4R/9PBI2qvLCvOVb8IbqjK3wCOzQ5s+
         LmxKCPFyTaq2LtXSvl+FTqrZq2TsfYJXW/JEGh15U4WvZJ7/8uxvbLpQMCaAaEGuqdw0
         4cNA==
X-Forwarded-Encrypted: i=1; AJvYcCU+BhFeZQA7kiSrAeYPxw4JCepHuLe4uqg66RJOD8f4BUB/gSjMz965U+LVuAzaikqj9OY1xO92azd0@vger.kernel.org
X-Gm-Message-State: AOJu0YxfqHIWf+acTf94rE7I3C9Whf4uGSPdLr6a6Hio8/GUkicQWNKE
	y3y/sNj8HGahqrNwR1U9bYzteTkuH4EJqew04kABHC1J/W6NsDRrERmRzTqKchh5hv+/TAv1+ar
	D9cvT
X-Gm-Gg: AZuq6aLmLKg7LksbZ3D9TJLANFFWvlYTMjSYNuoitwvXcbw4E/i69RnxuiVVOxSWeD4
	/EwAxEz6yx3vRejp+1+QwwfUtVPgWKV51hyL/luMq1v3nO3NRJ13mnAMF9qoYqQYJ/9z05FLDeV
	PTdG97vDQUEVSI8o0zE+U3FtZjbvf7q8DdsRA5LwK4sqzXqykpvvSjKZka43GR6/FzLv/XkBRdF
	MYLdxj2zFEHYN9vdolDhJiO/IIgtA3mGDCDs6gxLXugQdTQnui1gTgkhDxwbfE4QWCtKrPI3mM1
	3/9EISLlO02iWctz3FAsIgDgzmh9V8Crhw5h7uQ+ELJ4moUiv14XqKFkl/XD5lrdA+rJUie3EDp
	8Mo9uLYoUxBL1zSjbLTxVlVzW46HdSDUocrSqQuhVu1RP8yUgfdo5kGOTVcItiYubQv8pnojsbn
	U2BV7cpizlFKtdsb9qQDYyuhU=
X-Received: by 2002:a05:6000:2883:b0:430:fb00:108f with SMTP id ffacd0b85a97d-43617e40001mr5299367f8f.18.1770227800296;
        Wed, 04 Feb 2026 09:56:40 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805f25dsm8325411f8f.29.2026.02.04.09.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:56:39 -0800 (PST)
Date: Wed, 4 Feb 2026 18:56:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, 
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <o6ndpzk7xfpiabyqckwe4ktps46ykw75ind52nt6bdlgznwfoe@qkniomhnbtbj>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203145138.GQ2328995@ziepe.ca>
 <424kifntiluu2rrsqea6k3aatduoqemjccmsun5z6rvx67xo43@6q4t3r44ql3e>
 <20260203165938.GS2328995@ziepe.ca>
 <q4cc35lcpl2xrziu7c7hkebib6mc4bnapztckk3duzv5uzyjv7@f4nqhsi57wi7>
 <20260204174615.GI2328995@ziepe.ca>
 <20260204175411.GB12824@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204175411.GB12824@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[resnulli-us.20230601.gappssmtp.com:server fail];
	TAGGED_FROM(0.00)[bounces-16541-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[leon.kernel.org:query timed out];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B9BFEEB4E0
X-Rspamd-Action: no action

Wed, Feb 04, 2026 at 06:54:11PM +0100, leon@kernel.org wrote:
>On Wed, Feb 04, 2026 at 01:46:15PM -0400, Jason Gunthorpe wrote:
>> On Wed, Feb 04, 2026 at 04:38:22PM +0100, Jiri Pirko wrote:
>> 
>> > >Generally I would not assign to the driver's umem storage until the
>> > >creation is completed to avoid this. ie it stays null until committed.
>> > >
>> > >But looking at mlx5 that looks like quite a maze there.. Yikes..
>> > >
>> > >So maybe mlx5 adds some NULL assignments on its error paths and less
>> > >convoluted drivers can use a simpler option?
>> > 
>> > How about we have:
>> > 	int (*create_cq_umem)(struct ib_cq *cq,
>> > 			      const struct ib_cq_init_attr *attr,
>> > 			      struct ib_umem **umem,
>> >                                              ^^
>> > 
>> > 			      struct uverbs_attr_bundle *attrs);
>> > 
>> > And instead of taking ref in the callee we just do *umem = NULL? :S
>> > 
>> > This would help to cover the error path vs destroy path differences,
>> > Tt could also be used to make sure the op consumed all umems; all
>> > should be NULLed on success.
>> > 
>> > Makes sense?
>> 
>> I'm ok with that, though never seen the pattern before. If the core
>> code fails on !NULL it would be pretty hard to use it wrong.
>
>I'm less excited to see unique coding patterns. We should rather invest
>time in effort to layer everything correctly.

Easy to leave this pattern after the effort you refer to brings fruits
:)

>
>Thanks
>
>> 
>> Jason
>> 

