Return-Path: <linux-rdma+bounces-20494-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJDUEOZAA2ro2AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20494-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 17:01:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D4E5232BC
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DF2A345055D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C26C3A8742;
	Tue, 12 May 2026 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="a1AKBlkb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7673A8385
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594838; cv=none; b=CrYzrV+Wzan3BbrUsDtXoIBlVOXdeuu9sd4ad3wffWUCZ3rF8ZZP4WPHVT2XOQanBbja9EsyS8rzYVaw+7psbLhtnp525cAMR0/MGkzCYEIy7v0piLCnM1gr9RVEiuy8Ltg4oKo+ZddAfIOI32l0+EZ7+sLDoxnzrsNDZmK20Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594838; c=relaxed/simple;
	bh=bgBCtNkJnsiY/BqSw+6iZ38DMKEEFC29v57mwpmfH+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8Gxt09LS8neQPTgTOLijfTW7GPGwKDdkb+1ZoLbUftrxIEgTOxiDj1cFzZczcvjjeEtU9/+Bsxr+v5DMYjvZS458Ru++XpAGYEtVGbpAkHdV772rrzRcKGAyIajqr1srIlITYNkOMpsiQaOiYqRoZ1c9H/3TALm0sZ+RmTjFkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=a1AKBlkb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so94741865e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778594834; x=1779199634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEuT8mU5zwj23z5tjg7/0cCroKq2YLlwPoM85Ob95Js=;
        b=a1AKBlkb+zbjKzr07CAkgRAWlSxhhCfxvhMVUJtl54NRRR3SzBFMSHkFXqxZ0CvFH0
         iykelWeVpz5jqx2sWOMkX1zpUKUqmUlJumpneggyJocP76N5ObtIS9wLFaMZLQnSKl8k
         zJmnek8cMvX7V0a3vUCT5uJvmpMYaN59HhNaRy7kNyoV0MPtM7nUss9WAw10rjZrmLRE
         3r0PYgcK320mAkTBC9fQHgzs+zijdiSji4Zus1qJNscR2/NJKgnQEEkQ29WeXLoVUpeC
         ufbYJLvUIrXy+hXWSW8pOTc3Ss5xLcJLKC3A+e6iw3AMoIesVhAWwOgTbTmE/vMR97gq
         anSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594834; x=1779199634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEuT8mU5zwj23z5tjg7/0cCroKq2YLlwPoM85Ob95Js=;
        b=oszLFRTs9cYjgN6sWV8FLR3rmB3R/wXXXY9SK3u5Iuj8BRM1SFEwSX+lpj9wjDmaEm
         dMlAOvo7WH2nSUDnMIRab4SXGDHKg24C1NOCqlZItjQA0fEu3p8PjpHxojEHI9nUiL2W
         7Y4VmZDnVkya9Yo9/3e+VaYmAtzz84jAiqEpSPb+1ie7cu6SP/4epobtJJ2wK/G2TBuZ
         hTIe9pymrfhB5ZziSx4xgCUyT2AfVaA4zaNcHK/dgkzDmDH6NylUHKAspeb7Te7iE3rl
         DDOcMZ7a027kKGXZCuPfqYaaUUdwwoSgdDQEM43yGtFxZwJdh6dI0RaXK8yf7wxi6RIE
         ufzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/komwaTiNc8vaZ6vxDxjuO4jNLJedvIjjBGovep/qc+AHGiiSc/BB4gcUf/f9s2m8A5EAheIzg7WYH@vger.kernel.org
X-Gm-Message-State: AOJu0YyRwsylakdbwOgw+aagDyzIgmVO3YZ48dTmWWsTq1RaDaMbTRRH
	5WPo56ZAEzYIbQDOBpDc96U0F2S2YDGkjoR5MxVD+vhXQfkZeD+qrL3v8IK7J+nq7ZE=
X-Gm-Gg: Acq92OHvmbggEwve/Oinj4SCb+75PBaEKtyQueooQWOyHAD2W5JYrmLcO8cf7I9oGHK
	8rzo7cTtEM+csCIX3uzVUaCYAsYI92pZtPdwouoEiXQvDciOzRMiSuiHABMZj5I0A4joA/MWPqT
	P+W3zWugbtRLrqRfucEIoAfH2IRaA2KDmVlH7kGvV2zABvpFMbnlGdejW9QD8JWf49eWThle2hh
	j4s2P4vBtNRxccjHyfrWqj2gmbcSE8FV7EMsqA/MV+/fG5feci3hYaxj/DowlHJIbLWMCrCAzDK
	t5JLDLNNRFs0vCNslBMwIRVmhCq72GB+gwyPJqHySzvZojXbVlzAl/eRJhdZSYGq3wW7MSEddWB
	FXAHJ4D8zZNkEfA3FCQpSo3yebTEb4H1q9fb2v6dswVvvNozoK4YGLRflEnaTY4gJgDQa/eZ6tj
	pdB8mNKcjh0L9z2irc4+xqMigvLR2HE2QNpWs=
X-Received: by 2002:a05:600c:8115:b0:48a:9540:1a3a with SMTP id 5b1f17b1804b1-48e51e196f9mr466793535e9.8.1778594834461;
        Tue, 12 May 2026 07:07:14 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d19854sm520285e9.1.2026.05.12.07.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:07:13 -0700 (PDT)
Date: Tue, 12 May 2026 16:07:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [RFC net-next 0/4] devlink: Add boot-time defaults
Message-ID: <agM0DsiaAH8-Ox7N@FV6GYCPJ69>
References: <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
 <afxvzOjqw-vxUAED@FV6GYCPJ69>
 <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
 <af4lBIJdCuN5VKq_@FV6GYCPJ69>
 <20260508175213.1952097f@kernel.org>
 <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
 <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
 <SJ0PR12MB68068C50EE9776A3D9060635DC382@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agLoeZtsSizR-R24@FV6GYCPJ69>
 <SJ0PR12MB68061C61AA2BF5D81005984FDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR12MB68061C61AA2BF5D81005984FDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
X-Rspamd-Queue-Id: 86D4E5232BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20494-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[resnulli-us.20251104.gappssmtp.com:query timed out,resnulli.us:query timed out,nvidia.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli.us:email]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 03:48:32PM CEST, parav@nvidia.com wrote:
>
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: 12 May 2026 02:16 PM
>> 
>> Mon, May 11, 2026 at 08:21:37PM +0200, parav@nvidia.com wrote:
>> >
>> >> From: Mark Bloch <mbloch@nvidia.com>
>> >> Sent: 10 May 2026 06:02 PM
>> >>
>> >
>> >[..]
>> >
>> >> > I look at it from the perspective that from some CX generation,
>> >> > switchdev mode should be default. So that is a device-based decision.
>> >> > I believe as such it can optionally be permanenty configured (nv config)
>> >> > on older device. Why not?
>> >>
>> >Because sometimes switchdev_inactive is needed and sometimes not.
>> >Such knob is not device decision.
>> 
>> That is what I would call corner case. In that, user can use userspace
>> configuration to change the mode in runtime.
>> 
>Corner vs common depends on users one talks to. :)
>If fw has switchdev(active) as default, and then 
>And user needs to run switchdev_inactive, it will actually break their switching applications.

Can you describe the actutal breakage please?

>
>So, one needs to invent switchdev_inactive in the FW.
>
>Jakub's suggestion in this RFC is covering both the scenarios uniformly without above problems.
>Single uapi for all the cases, so looks good to me.
>
>Moreover, do not understand how alternative solves such problems.
>i.e. user is unable to configure the fw because driver is not yet loaded/up.

See my other reply in this thread. I don't think there is a need to
configure anything in FW. If we fix the behaviour in switchdev mode for
non-sriov user and change the default, no fw knob needed. What am I
missing?


>
>> 
>> >If it is placed in the device, orchestration needs to yet use additional vendor tool to configure in the device.
>> >And that theoretical tool cannot even run yet because driver is not yet loaded.
>> >
>> >That sort of defeats the purpose.
>> >
>> >> This is a deployment policy decision, not a permanent property of the card.
>> >+1
>> >
>> >> The same adapter can be used in a regular host/RDMA setup or in a
>> >> switchdev/offload setup. If we store this in NVM, that Linux switchdev policy
>> >> follows the device across hosts, kernels and use cases, and can surprise the
>> >> next deployment that just expects a normal NIC.
>> >>
>> >> I'll send another RFC v2 with support limited to:
>> >> devlink=[...]:esw:mode:{ switchdev | switchdev_inactive | legacy }
>> >> and let's see where we land with that.
>> >>
>> >This looks elegant to me as well covering all eswitch modes and still sw is in control.

