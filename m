Return-Path: <linux-rdma+bounces-20134-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FFqNHxx/GkEQQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20134-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 13:03:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F89D4E72D9
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 13:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22F6B301DEED
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 11:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3266934F24E;
	Thu,  7 May 2026 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="ReYzco9Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69440308F07
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151798; cv=none; b=M3EMuRn3aaXK2donUHaQfsyP9UYVOX0hpGeOQw4Cirtad5zEGERBr/xtl06/WnWk81fTyJi3HamSA0N0+XzlNbWHFiqyZ859IDV+3l8Z0xI0aXR3A8Fvb/nujn1TIVWjT8ht77mBUwKHHdNUru86jgv9f5D8NftxullEnPVKzS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151798; c=relaxed/simple;
	bh=980NOX7dWNrknY5Yk4nVOzgX46BS3p5+nFO0T7e/fJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HttlypKVek1hauLmCMQPmWPLSP9iBgdZxq7qQ7b6fZ3nzuL6OM0iyf4h8v0bswvZeik4FoTV3fXLxm2B6O+/UjXyxIxxyG6oyQTzDoHLrBohESm+LzI9QwOpGHsXa5rttxw8erES8cPLjXGCDdQPBjOjGZSZN20ETXIo5a3DkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ReYzco9Z; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso6104555e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778151794; x=1778756594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZHy3FEoaiutkBHBHyFqnRvVmB/IvEeWiPTq0EU2YHc=;
        b=ReYzco9Zadvkvd1/0xCL0X4t83zAxYIGFgFCwVnkWHparVa6XuHv0DtzqblwgceSxK
         oaSMlFf/YnT+9liQscEgO8Ygx6nBX69Oi97p580A8b2dJPrFdAISBzYeHLEBfTiyjMil
         bbWLQv3eyqXk3NLHUjhwUv3ZR947uVqP/OnlOFowFE4aFhzgZ1mZyLZJ4S4+mGeVtv40
         3Jm70zu3f4w2XtXPQreAjslzCaeeIKyLiyaDBigyoW2Mz8oP0s28xi91htIVOcwd5YoC
         vXfFvFYR9TO+ErgYUmkyOX4OwyCEBv40DCeUfindB6RdcmwILWNkBRaJDsVpEPq+hfg6
         Yb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151794; x=1778756594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZHy3FEoaiutkBHBHyFqnRvVmB/IvEeWiPTq0EU2YHc=;
        b=GWkyHcxkl351A/ei0KsUiVdDMUCtvZooFbOtW2z9T92FtxvWRsPfxCmNhfJS0Qbr2a
         F0PD7+tx+zelgX8Yd6kjLDnYUkwOD2zyU2Z7e2u3Rn81/muxE2CwbFoRLFi1UlWZBhz/
         AE9uhFaSTA2jV5CIk4Mm2TJAXaapvHnwo1oZycBaA4sSAxRm5930RpA71Xx7oUQT5qRp
         qSdVnas4EjPCQreHaV6LDpC2Fplwi281tXAAk9OQpiNE7SAEuJBe/JCFP48UtRO2L8xP
         cWJVI2hbLPSgHr7hAhmkYZxrMVnkUbc3tzqghiNIP44L6TARu7MaQFDsHXm9BJ5/HS3c
         FZxw==
X-Forwarded-Encrypted: i=1; AFNElJ/Q4stOva9dBzqTqvvibeddi/PuOHrN+8L8HBraC5I7qhKIH6B4mKSBUrpiwWbGh6JDAmfj/qMLCCPP@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5bubKP6rKXWz2maBXuW37miusYkQtgjoBgMqtxNXC0IQM37I
	nxASOJ32nknlGsu1ZF9l4EyGge+KkR23wTiGJlRqp9OyvSv5XHRL6ZUEy10SFaov1mU=
X-Gm-Gg: AeBDieuYVzh4DKXao6oDQB1ORhSO2HXskapCWX1FrxL7dcCstsQAGwjVaQsx/tyXssb
	e89bFJJHU1gLH3f47Zy//c31IxgZSda3kQVle/G7GTbloYDA4pXsvw3UEhFPCVI0yjKpRkL5iMS
	GxEeSPrIYE5MsF5GWT5UcYBgGp16hhyO2zl372uqFLKjSjwuLAXR2F/dtH698GQP3spZF6Irq4g
	ycnAhg8egj4mP4bIaBsr2N5MNmcb2nWKtARU52hTZAG49ZGT9HNXtmZo0w1uyIY/iIufo0GE6If
	RPjjt8pAmaHK8IDbIRPe3lnnR7eInjKnfAF/ufmdgxJow9lCnqG6YdQnYI5UObJaQcvLmDq9Lkb
	MuqZiWd4zmy96eMw4BvI1FBs2f92C4sI+ADYci8pvOgGcbIDSAz3WklXcjB7+DOLbagj9PTjFro
	qZ5ENqr/Yr96OyChsFL78wJ+A5arsuuWkHlqjwyILyZcczoOniJZhqndNS50bnfm3E
X-Received: by 2002:a05:600c:a30b:b0:489:1c1f:35f9 with SMTP id 5b1f17b1804b1-48e51e1773bmr90083345e9.9.1778151793380;
        Thu, 07 May 2026 04:03:13 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:6064:31aa:7680:7221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530b05d9sm53089215e9.3.2026.05.07.04.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 04:03:12 -0700 (PDT)
Date: Thu, 7 May 2026 13:03:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Randy Dunlap <rdunlap@infradead.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Christian Brauner <brauner@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Li RongQing <lirongqing@baidu.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 0/4] devlink: Add boot-time defaults
Message-ID: <afxvzOjqw-vxUAED@FV6GYCPJ69>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
 <aftaW-irGmkfA7FS@FV6GYCPJ69>
 <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
X-Rspamd-Queue-Id: 3F89D4E72D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20134-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Wed, May 06, 2026 at 07:35:10PM +0200, mbloch@nvidia.com wrote:
>
>
>On 06/05/2026 18:22, Jiri Pirko wrote:
>> Wed, May 06, 2026 at 02:37:35PM +0200, mbloch@nvidia.com wrote:
>>> This series adds a devlink= kernel command line parameter for applying
>>> selected devlink settings during device initialization.
>>>
>>> Following a discussion with Jakub[1], I am sending this RFC to get the
>>> conversation moving. I started from Jakub's example/request and extended
>>> it to cover requirements from production systems and configurations that
>>> customers use.
>>>
>>> One important caveat is that the parsing logic in this RFC was written
>>> with AI assistance. I am also not sure whether the resulting syntax and
>>> parser are too complex for a kernel command line interface. This is part
>>> of why I am sending it as an RFC: to understand what direction and level
>>> of complexity would be acceptable to people.
>>>
>>> The implementation is intended to support the following properties:
>>>
>>> - A system may have multiple devlink devices that usually need the same
>>>  configuration. For a configuration such as eswitch mode switchdev, a
>>>  user should be able to specify multiple devices to which that
>>>  configuration applies.
>>>
>>> - There may be ordering dependencies between options. For example, in
>>>  mlx5, flow_steering_mode should be set before moving to switchdev.
>>>  With this in mind, defaults are applied per device in the left-to-right
>>>  order in which they appear on the command line.
>>>
>>> The intent is to let deployments set devlink defaults before normal
>>> userspace orchestration runs, while still using devlink concepts and
>> 
>> "defaults before normal userspace orchestrarion". I read it as config
>> before config, which eventually could be skipped.
>> 
>> 
>>> driver callbacks rather than adding driver-specific module parameters.
>>> A default is scoped to one or more devlink handles, for example:
>>>
>>>  devlink=[pci/0000:08:00.0]:esw:mode:switchdev
>>>  devlink=[pci/0000:08:00.0]:param:flow_steering_mode:smfs
>>>  devlink=[pci/0000:08:00.0,pci/0000:08:00.1]:param:flow_steering_mode:hmfs,[pci/0000:08:00.0,pci/0000:08:00.1]:esw:mode:switchdev
>> 
>> I don't like this. What you do, you are basically introducing user
>> configuration tool on kernel cmdline.
>> 
>> The same you would achieve with a proper userspace tool/daemon.
>> I did try to come up with it and push it here:
>> https://github.com/systemd/systemd/pull/37393
>> That didn't get merged for unknown reason, but the idea is sound. You
>> provide configuration files for devlink object and systemd-devlinkd
>> will apply when they appear. Wouldn't this help your case?
>
>I agree that systemd-devlinkd is the right shape for normal
>devlink configuration, and it could probably replace the udev/devlink
>plumbing we use today.
>
>The case I am trying to cover is earlier than that.
>
>On BlueField/ECPF/DPU systems, the host PF driver cannot always finish
>probing independently of the ECPF side. When the ECPF is the eswitch
>manager, the host PF is kept in initializing state until the ECPF eswitch
>side is set up and mlx5 enables the external host PF HCA. That happens as
>part of moving the ECPF to switchdev.
>
>Today userspace observes the ECPF instance and then switches the
>mode through devlink, usually via udev or similar plumbing. That still
>leaves a window where the ECPF has probed, userspace has not applied the
>mode yet, and the host PF is waiting. With many ECPFs this becomes visible
>in host PF probe/boot time. A daemon reacting to the devlink object
>appearing can make the userspace side cleaner, but it still runs after the
>device has appeared and after userspace scheduling/uevent handling.
>
>Long term, for these DPU deployments, we would like mlx5 to initialize
>directly in switchdev. I am hesitant to make that unconditional because it
>changes existing behavior and there is no early opt-out before probe. The
>cmdline parameter was meant as an explicit opt-in middle step: ask the
>driver to apply the same devlink operation during init, before this path
>depends on userspace.
>
>We previously tried to address this with an mlx5 module parameter. By
>design, that was too coarse: it applied to all mlx5 devices handled by the
>module. That makes it usable only for narrow DPU-only configurations. The
>devlink-handle based cmdline syntax was intended to keep the opt-in scoped
>to the specific devices that need this early switchdev transition.

The switchdev mode was introduced at roughly the time CX4 was out. What
stopped us from making it default for CX4+ ?

Introducing this horrible plumbing only bacause we were not able to
change the default sounds so absurd.

Can we write the default mode as a bit in ASIC NV memory perhaps? Simple
devlink cmode permanent param to write it, the driver can read this bit
during init to decide the init flow path?

