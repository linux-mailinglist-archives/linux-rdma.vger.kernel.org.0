Return-Path: <linux-rdma+bounces-20283-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AARQONbb/mnfxQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20283-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 09:01:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2844FE628
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 09:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDE6430177A3
	for <lists+linux-rdma@lfdr.de>; Sat,  9 May 2026 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9075C37CD2E;
	Sat,  9 May 2026 07:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="O39COjSE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8906C2F7AB0
	for <linux-rdma@vger.kernel.org>; Sat,  9 May 2026 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778310094; cv=none; b=cLPWS44/BO2eiSxiwwNBie7Ajer6/lLRy2b8GPXb8i3cdFAyzncpaxty7zAi//VlhoGNoHnZiazF4JsUhwev2hx2UbIJ4EJEG9sezZByTRSXxMHWP/mWsjOnr2YTbu1FJ34cUa5pgmtYyopTKAb4Tk/3S1BnI1V3aodqXS55wXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778310094; c=relaxed/simple;
	bh=Fdkwzh7nzXXsRdR+lBF6ucGH+k2FBnutbxMgBG+r9aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i33gnNWsLcHbWvWNYa1xV+MAjizMRPSF5eCF7rTjHPOrvV62jcX/ezvcmYnoi+Kmg7i12E1u8z7F7GdTJYXEXeNfUnZqJl1skPZlXDatYsV1gvdJIQkHvZuq0/NJEU+j56UDbb9ZeT2MjE9vZLfkawUwspejfS4mgLzn9pUCA1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=O39COjSE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48e56c1bf5dso16387395e9.3
        for <linux-rdma@vger.kernel.org>; Sat, 09 May 2026 00:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778310089; x=1778914889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aBUb6rJkP5kcBQ6tIPVqou1ctCmL/sfkRVBGBAME9Sk=;
        b=O39COjSETDTYb+Z7bD43p8tNEei8T9vTYSZjBbW2KOQQ9QIz9zAumYPYsJloJwh1l6
         jz03kvFvqJ+3KyBKHCZwGes4EIylOUT9BoJs4/ym5MiBQZktSg0e+kis+Fz9Fyi3Gj3Y
         17tENhANixFbAV0jyQQF9djR7/H3TwQC3wieMsl7J1yX6sZubNfzbq1Xya5SipjTiPs0
         9MCEFwL70k9omeeYtgOQT18u5a6G9KY9qr3vE1h8gZo4Kdk1IULGpFZyRbJFkTR+rQDw
         idAyG+3CTW4j5mFLUFbyGQgfx15FbUb1g9HNpa+pxDz2hFrEJknLRSEzcwGT7MC6atuD
         LTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778310089; x=1778914889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBUb6rJkP5kcBQ6tIPVqou1ctCmL/sfkRVBGBAME9Sk=;
        b=i36wwh3S9hbHe4zRi/nQgnlHOgMzdy2jS6PH9zWy1CTHsT9cpdSU+gmghVolpRzVG2
         O4di/2gEkoIB4nlfvVknJmgxXiT/+0WMGkk5A30C82x34Sd5t7dLHrfLqUrZKQZDJog8
         rXC0lV/sdrFHJg9nd7luGa3o6MEoWOBp0Go27lWQKINsreO0w02dIcMKvwTbcp3MD6Zn
         FgLRzB+L6FR7tGrrGoK6743f8Nout1Av/Mn2mUnWr0fCKUC5nSed0a2fvab7wqayBLBz
         N4ngaefmnsmhTkumd6PQuzyjBBruzuMhlsuULRYqbPxcA2W1GlCX83UZv7ZhU49b4itM
         v43A==
X-Forwarded-Encrypted: i=1; AFNElJ+EmqRcKHroYDPq4Un6FIPr+Z9asN/+CLGLiw2lL22WK63gAAnLQrATQxGpfoExY2JrG2oi3SWsnSXh@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9/Jh1KohBc/pSTkGMnZ4D1QvTjnfTges9mX1EU96cKxBSr79
	Pi6mGwCXGUqkqzvjSClmrxgCY14nzTAeaZDRB9TZw39vDJRDSvnU/Im8PR5xuQl+auc=
X-Gm-Gg: AeBDieuUq4byVrh/67NCSbqgjCTtJsEXvLuYtiaREhaMtTPUtgmswEvTdQdQGVd4NGR
	+QIRPHM5mD90qZoK5e/RIzZMT2gw6NJYcp0NYEW9nxvF0f/Zz/tjIxVQzl9rDU4V2zEmu/ZaJg7
	k0Nqqx+5itNgZ22mzcqSiTrXetTlEMcV2/xU+NKz/qskrzxn2haAS/Iste+XsWl8016udEPMbHI
	ORlg5NpPnu+lAdNbG6SkRdL7zo62V/HYg4XtFF4XT/3I7GCzETGl9fwRw3S3BL1HrjPgvRZjaqA
	x7Bw8R2kaC5fGcHzcBN/OFMr6FblIuAtcM/HzlBCv0/Pa0Z0b4PfAqUCsM/q3sVzGv7cluRKA7q
	p2KGaHKoecczr/LfV+q2Prr07jtv36DHCPKdIgKopiH8iJyaFETvu4gmlIaUCT89oyFjodyZCWK
	30RaCRzuSlQhUN+VzuwqFAKVzHBxA0t9TUnZc=
X-Received: by 2002:a05:600c:4e15:b0:489:1f04:96c3 with SMTP id 5b1f17b1804b1-48e70687e22mr20671555e9.2.1778310088900;
        Sat, 09 May 2026 00:01:28 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7040a8ffsm49536725e9.10.2026.05.09.00.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 00:01:27 -0700 (PDT)
Date: Sat, 9 May 2026 09:01:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mark Bloch <mbloch@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
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
Message-ID: <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
 <aftaW-irGmkfA7FS@FV6GYCPJ69>
 <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
 <afxvzOjqw-vxUAED@FV6GYCPJ69>
 <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
 <af4lBIJdCuN5VKq_@FV6GYCPJ69>
 <20260508175213.1952097f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508175213.1952097f@kernel.org>
X-Rspamd-Queue-Id: 7C2844FE628
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20283-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Sat, May 09, 2026 at 02:52:13AM +0200, kuba@kernel.org wrote:
>On Fri, 8 May 2026 20:07:44 +0200 Jiri Pirko wrote:
>> >I don't think switchdev by default should mean CX4+ in general. If we get
>> >there, I would expect it to be limited to the DPU/BlueField/ECPF case, where
>> >the host PF probe path can depend on the ECPF reaching switchdev. Changing the
>> >default for regular host NIC deployments feels like a much larger compatibility
>> >change.  
>> 
>> We can't travel throught time, but if from CX5 onwards the default would
>> be switchdev, nobody would feel broken in terms of compatibility. That
>> is my point. Having "legacy" as default is simply wrong for never NIC
>> generations. That is why it is called "legacy" and it should have been
>> rotten through and out since CX4 times.
>
>legacy vs switchdev only describes the eswitch configuration.
>As a non-SR-IOV user I really don't want to see the extra representors
>hanging around my systems, confusing all daemons. IIRC mlx5 had some
>limitations around the uplink representor. Maybe that's the disconnect.
>But for a real, fully featured switchdev eswitches having the
>PHY and PF representors on boot, always, will not make sense.

As "a non-SR-IOV user", what extra representors you talk about? When you
have pfs only, you don't have anything extra. Just 1 netdev per-pf, one
devlink port per-pf. What's extra about it? When you don't have VFs/SFs.
Everyhing is the same:

c-220-136-220-218:~$ sudo devlink dev eswitch show pci/0000:08:00.0
pci/0000:08:00.0: mode switchdev inline-mode none encap-mode basic
c-220-136-220-218:~$ sudo devlink dev eswitch show pci/0000:08:00.1
pci/0000:08:00.1: mode legacy inline-mode none encap-mode basic
c-220-136-220-218:~$ devlink dev
pci/0000:08:00.0: index 0
  nested_devlink:
    auxiliary/mlx5_core.eth.0
devlink_index/1: index 1
  nested_devlink:
    pci/0000:08:00.0
    pci/0000:08:00.1
auxiliary/mlx5_core.eth.0: index 2
pci/0000:08:00.1: index 3
  nested_devlink:
    auxiliary/mlx5_core.eth.1
auxiliary/mlx5_core.eth.1: index 4
c-220-136-220-218:~$ devlink port
auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false
auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false
c-220-136-220-218:~$ ip link
...
4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether b8:e9:24:f2:b7:6c brd ff:ff:ff:ff:ff:ff
    altname enp8s0f0np0
5: eth3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether b8:e9:24:f2:b7:6d brd ff:ff:ff:ff:ff:ff
    altname enp8s0f1np1


>
>IOW it's not a question of the generation of the card but of
>the deployment type / use case.

I don't think so, not in the case of mlx5. The difference is only when
you work with sr-iov, you either use legacy way (ip vf) or the new one.
Same usecase.


>
>> >For the ASIC/NV bit: maybe technically possible, but it feels like the wrong
>> >layer. This is boot/deployment policy, not a persistent hardware property, and
>> >storing it in NV memory would make the state persist across kernels/hosts in a
>> >surprising way.  
>> 
>> Well, as any other nv config, it persists across kernels/hosts. Think
>> about it as "unbreak-my-not-legacy-device" bit.
>
>For most devices the switchdev mode does not change anything
>substantial about the device. It's purely a kernel / driver config. 
>It changes what objects and default rules kernel / driver installs. 
>So I don't get why it would make sense to flash into the device
>nvmem a Linux SW stack specific config.

I look at it from the perspective that from some CX generation,
switchdev mode should be default. So that is a device-based decision.
I believe as such it can optionally be permanenty configured (nv config)
on older device. Why not?

[...]

