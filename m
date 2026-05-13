Return-Path: <linux-rdma+bounces-20565-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM48ILRcBGrbHQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20565-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 13:12:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3888B531FA5
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 13:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 672863025A42
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C953FD140;
	Wed, 13 May 2026 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="JE77P9uY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E7D3FAE00
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670703; cv=none; b=UJHSdSnR1E+d1cJkqUi9qnEv3Ev2Jn6D4thUG2gQNRXQ9mskz2xH4Q7O+qTDdDijPtCB0N+ypWnc5LlOFIgqsitrFATepgJgb460sIrPdxO1Mzc/EhoOD22s+iG+rTtxq1UKR1WWWxet6kO+l9vbpv03c0FxzPmXRD9Ak0SPXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670703; c=relaxed/simple;
	bh=ZXwAclxswpH9W2j+/oYb3qv3cmJKlKRNjuaVJ2ukMfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROIHfLcsoJGqLZtvesQzDcLsx8KGqYmNL87J8i7jAb1ISBGxFE11tz4oxOgDbAEE64+1Wg/GiDPflE188a2N/ADiDY7jH4Et65dHLyp2xyTOqjDgF0OF0iYAdg0xTcD5PFlYkwxDwz+gMvnuWqj0DF5AGLfiP0kAPfX6Mw8uz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=JE77P9uY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48d146705b4so80146125e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778670699; x=1779275499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yDTQJL+RHs/YBzKpujLCRoZVSafUqZXfMLZzEz8A6w=;
        b=JE77P9uYkoqDBF9sOHO24gEkrwieIf/eMyVZr2mmVjIES2j7yKsKwgGftwBiAywZd6
         Kik08oN23TrTMT2FCSCBSvpySsis9P7BUP7jHNcWQcNadU1pmEgSofLnCFp0EUv9A2i8
         tNcDg9EgJwyvueTOn/QFpnR/DjgmjvObZiGSeg5D0VLJFEY2liLmHtI+u5vl5IWDJdke
         pqiIFNl5yW4rDK1crx6kWLD5QkJgMwsTUDVWbAe3aUnzVZrEdWcGOF/a5tUEJ58OfI8s
         bR2l27MqSMnXyUU8x6ykto74E/Qy7nBObTlRNN0LdPfZ784B1fCF4VTuvLER7Zulnf4X
         nP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778670699; x=1779275499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yDTQJL+RHs/YBzKpujLCRoZVSafUqZXfMLZzEz8A6w=;
        b=kC520Ouo0nTt5HxBTz5wWLmvhUHTcdIX7iX2uCLRGDEtCXCGzkle5tcyJjc8XYnDtp
         zm4WAQnUg+2+WGrARdGSTrLALf1X/0TLh5KhK6mFj9Nwfjn8F+EXH8o0dk7/Hkbaxg9T
         3eUjIGCr0dE5uLXvqddQiMwfrNFBJUdTVR4CZRocPmLKhyZwVqg+95dlFFgDELQ+5Sy2
         9HOqBcqtrmiEExbv0Wh2Vexa5yU7CZzU2DSB3cnt8Vau8M/nxVFOQ4tjYb4ec333c74V
         9JT7ls7DfRgCS/JYnAKxqi4euVimmXdR1pwl1qDICdkTZj4MWyQhttLyqeW1GxMIQkRr
         dLjg==
X-Forwarded-Encrypted: i=1; AFNElJ/I/EDT6ZbtK2ljacaKO0p9VRvNJFDvpxbb/YF3c+o6o3YKhn7VPp2p5u0bcIDqUKdvRr7WxHZTxsjB@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFHSadj6hI/VOeNyjn/vZwCCCgAySg5L4odaZgwV+zobLeoOJ
	0Rp3AVyriwbTFOJalyb++LI/ccH1xbI0oZRKH/VG668J0EtZwdw8NEx03YLlRk4AWRM=
X-Gm-Gg: Acq92OEniP66zEO/W+DGVXmn//gZvW3toLuMhABDJRasm0XymCR1UV5ZCllqFnUeTcw
	Zh8sLljpMTDV6waUdCdIwmGlM3CUH/meD+JAr4fPOueDDd7FI4ZOR/pOYyZ3HkYjaejiR5H5uoN
	4wqNbDuz8azniNOLwoWlk2uRgnn/bG8y3Z1rsrSSsvjvSd4qEw+TZNB25sDoaYYSlNWQ2HFI0Vl
	JBWmextod9zpiBAlsYetoTbFRErDLaZgFmcZs/B9ysjAjO/Ry/wQ2CJdz2Ob15tX4KTgfQnHpHW
	5mZ+8VAH61AAaDBkYPVSMTSTXpUTRBwBqrwHwRfyxz7B5i6EF898eWBurC0YK99H87oOeCOqDLI
	bqu6TPP9i3OJztVY0us49imJutArsNCX6r1hmwMmvrsseHede7hxLdhPi0cCthgXMS0xPRHAkqX
	srtbZ6O+rS0cYsIwH8foj2WpmkIYllmfQzeeJWvoaQUS8qPQ==
X-Received: by 2002:a05:600c:4494:b0:48f:d410:6065 with SMTP id 5b1f17b1804b1-48fd410610dmr4475165e9.29.1778670698381;
        Wed, 13 May 2026 04:11:38 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d624fbsm153171235e9.10.2026.05.13.04.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:11:37 -0700 (PDT)
Date: Wed, 13 May 2026 13:11:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <agRcYDkjsQuS7ArD@FV6GYCPJ69>
References: <20260508175213.1952097f@kernel.org>
 <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
 <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
 <SJ0PR12MB68068C50EE9776A3D9060635DC382@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agLoeZtsSizR-R24@FV6GYCPJ69>
 <SJ0PR12MB68061C61AA2BF5D81005984FDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agM0DsiaAH8-Ox7N@FV6GYCPJ69>
 <SJ0PR12MB6806D8ADF943B30AD3B479CCDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agNy3RF9WCHBPev5@FV6GYCPJ69>
 <29868c1b-5751-421a-9f2b-2ac0f3324904@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29868c1b-5751-421a-9f2b-2ac0f3324904@nvidia.com>
X-Rspamd-Queue-Id: 3888B531FA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20565-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:email]
X-Rspamd-Action: no action

Wed, May 13, 2026 at 07:53:05AM CEST, mbloch@nvidia.com wrote:
>
>
>On 12/05/2026 21:35, Jiri Pirko wrote:
>> Tue, May 12, 2026 at 05:25:21PM CEST, parav@nvidia.com wrote:
>>>
>>>
>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>> Sent: 12 May 2026 07:37 PM
>>>>
>>>> Tue, May 12, 2026 at 03:48:32PM CEST, parav@nvidia.com wrote:
>>>>>
>>>>>> From: Jiri Pirko <jiri@resnulli.us>
>>>>>> Sent: 12 May 2026 02:16 PM
>>>>>>
>>>>>> Mon, May 11, 2026 at 08:21:37PM +0200, parav@nvidia.com wrote:
>>>>>>>
>>>>>>>> From: Mark Bloch <mbloch@nvidia.com>
>>>>>>>> Sent: 10 May 2026 06:02 PM
>>>>>>>>
>>>>>>>
>>>>>>> [..]
>>>>>>>
>>>>>>>>> I look at it from the perspective that from some CX generation,
>>>>>>>>> switchdev mode should be default. So that is a device-based decision.
>>>>>>>>> I believe as such it can optionally be permanenty configured (nv config)
>>>>>>>>> on older device. Why not?
>>>>>>>>
>>>>>>> Because sometimes switchdev_inactive is needed and sometimes not.
>>>>>>> Such knob is not device decision.
>>>>>>
>>>>>> That is what I would call corner case. In that, user can use userspace
>>>>>> configuration to change the mode in runtime.
>>>>>>
>>>>> Corner vs common depends on users one talks to. :)
>>>>> If fw has switchdev(active) as default, and then
>>>>> And user needs to run switchdev_inactive, it will actually break their switching applications.
>>>>
>>>> Can you describe the actutal breakage please?
>>>>
>>> Driver default was switchdev so all the traffic is forwarded to the switch,
>>> and user didn't have chance to setup the fdb rules.
>>> So packets are dropped but user didn't expect the traffic to be forwarded.
>> 
>> User may switch mode to switchdev_inactive early on, before any of the
>> representors are created. What's the issue then?
>
>That is the ordering problem I am trying to solve.
>
>On a DPU, the host PF cannot finish loading until the ECPF moves the eswitch to
>switchdev/switchdev_inactive. So we need to do that transition during ECPF
>driver init, as early as possible. Waiting for userspace means the host PF stays
>blocked until userspace is up and has the right logic.
>
>That is not always true in practice, the driver may be built in, loaded from an
>initramfs, or the initramfs may simply not contain the devlink policy we need.
>
>Also, after talking with Parav, my understanding is that we need to support both
>switchdev and switchdev_inactive, since different customers want different boot
>behavior. Once we do the transition, the host PF can load and may start sending
>packets. At that point the initial mode already matters: in switchdev_inactive
>packets are dropped until userspace programs the pipeline; in switchdev they may
>reach the FDB before the pipeline is ready.
>
>So I do not think an early userspace transition is equivalent here. The initial
>mode needs to be known by the kernel before userspace runs, which is why I am
>proposing the devlink= command line default.

Okay fair enough. Could you please at least make sure this is mode only
config and noone would ever think about abusing this for any other
configuration? Perhaps call it "devlink_eswitch_mode=" to remove
the "devlink=" namespace flexibility?

