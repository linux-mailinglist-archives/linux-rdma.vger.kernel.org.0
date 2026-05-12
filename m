Return-Path: <linux-rdma+bounces-20512-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC6TK/F3A2ri6AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20512-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:56:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BA552845D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4E1030ABE29
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA1C2F8E9B;
	Tue, 12 May 2026 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="w+APLFvZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21A2D23A4
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610917; cv=none; b=VOM7L/1kqHCqH7VAeOvlyEiZpimqsc73I+WY47umM6D09tp26F9VATlUuGDBUfbRgAefcZI5rFLilyRXC/Oxp67wO/WXHlPsDb7JbGITh2kDHKK9PTbSngZjFFZHHpUE/KvGLuImqEuvzGPxqwTV8Y/igr6zVN5cwm/3RzIqUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610917; c=relaxed/simple;
	bh=tpx/Mo33YZRPuGNo2ZG79570yOSTf76m9zQ3fljpeBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWIgYhZeyZn8MdcIKNpyvDrZYfPrHobXyvUlAKiGjstqU9iE4JRsEWQhIayUvhZGDx9ZYYzxEinbnJ6bOGIhWWLPN9CZsgl6K28rKMC7+kcCj6U57ytYrwSLDMIeoS3a3ete9Lnvz7S93/alTz9cvdE6Y/LXRy2i7TU6v6n8kPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=w+APLFvZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso53873045e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778610914; x=1779215714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=448c9IXFWf3BzecYkP3HsCZJTYpIC1o7jRhCi9pch8w=;
        b=w+APLFvZXBkz+9eaCLuLAF2s7qu2uwT7EaiEA3Jc2pFzGocciws+4cxdOi7tJUoWyJ
         FLBku92a27xkhkMHmN6K98vSiFwnotvTxBu/kq4ll9ygGVlxk7Nnwb6UMdcTJW8giI0F
         yUUV2NdGZP6Bk0paRNpDyaPs7ukA1yMjdS/sBbWLoduNLcAMeazIKy7BHrh9Sxfes84I
         JVPO6ghXwGa7OC9pRJSI9CCGJ68tefBQpRch+M3j9dmmwY5kvdD8unYhr7MPI4afFZK+
         1PPw7CQnJ/kOWZZIEs7Djo9oRYYAvmTqwJEbPTeqbr2GPV7CX92Lhxb7SHKWxsQXevk0
         HKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610914; x=1779215714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=448c9IXFWf3BzecYkP3HsCZJTYpIC1o7jRhCi9pch8w=;
        b=ZeoBtQjliSKvHO4t85o+ZTunoIbX54UGjxhw7GrK+NvXW4QUEZGYTvpEE+6YIUrC9T
         k1o7zdEIvvqwk797WbOkx9hwPa7fZ91cjrjOMWtzLSI0V4R9BYNb/8mGDrXmdwyZUM/k
         oNqiBSU2qNdtXwgbnuAGaVCkeZuZd/tt85MVKBB/fAMWi3fDid9zTPwNNf9fZLX7lqyT
         HHjfolTQqlctGpiEvchrmMqN8pvi5qEK6aOOS0aVXQbEC5elkdrjCEguWORxsBcB1Sj3
         2vIlY38y10pLhT1ekEDM7j5XHtNEAPbx6ys3HUxFDrPRw0RxqZTFf87bDvfMloLCfpqE
         gnxA==
X-Forwarded-Encrypted: i=1; AFNElJ+c+BjELg9MRDDps3EkaWGK2MX2q+a7RvXcdciibnJZ1Y8CiOKYLlNIskEBIj1ilFIHl1W5E2lEWs0q@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbm8sRkFdj5U9bYUtz2OUHop/ZlLgUOM1KnlrOoQlIeHw8IzXb
	TwEo9uX4M3XJitqVkKzLGH14gRSiuMiTMyIfrnA+v32LlphohpbEcbTrfJi0aMcUujU=
X-Gm-Gg: Acq92OH9sIeX2bsd/R3vsp8bxnkppWKTKUMvwu90lee7fIYotmMN1USs6XAbYA6Hn7Y
	xMzP43D29gfByGR6qpGokbFq9Ntm8cNziRUlRaABrQDkHH3vxI9JzI6uHhAwoujDLoImuL5XFcn
	F3XZqqADyLgTdV+7i4HMlI0QHjKI6FpoPBXh7aMNvY6p+FgMJVA2AqJ62VTa40JdJi35saDUdLB
	9GmphyhgqtICLWInngFJfQDYfNwX43KSj31i7Mbyn9VqDZr+uaaxl0NOabcSeiZINUZSJh89b/d
	gq5ia/qCxtULhek5ChE+23tFAcRk3rktK9OdyQ0kIlovJdsrXMbCSCo+IBRgRSTKY9dzrUH8gIt
	SYFdWLZVDzvT7gIaCf507+/3tcL2ECwPm9+7BPxaU0BBbrJch9JycWQkhlocjDK/yR97H97KJX4
	HgECxUzhVN8TYEDUMdwZsfkKl0wx3SK1PqlQ==
X-Received: by 2002:a05:600c:8b41:b0:488:acbc:b2e with SMTP id 5b1f17b1804b1-48fc9a33179mr1144555e9.17.1778610914207;
        Tue, 12 May 2026 11:35:14 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.211.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d21c72sm13265985e9.7.2026.05.12.11.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:35:13 -0700 (PDT)
Date: Tue, 12 May 2026 20:35:09 +0200
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
Message-ID: <agNy3RF9WCHBPev5@FV6GYCPJ69>
References: <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
 <af4lBIJdCuN5VKq_@FV6GYCPJ69>
 <20260508175213.1952097f@kernel.org>
 <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
 <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
 <SJ0PR12MB68068C50EE9776A3D9060635DC382@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agLoeZtsSizR-R24@FV6GYCPJ69>
 <SJ0PR12MB68061C61AA2BF5D81005984FDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agM0DsiaAH8-Ox7N@FV6GYCPJ69>
 <SJ0PR12MB6806D8ADF943B30AD3B479CCDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR12MB6806D8ADF943B30AD3B479CCDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
X-Rspamd-Queue-Id: 06BA552845D
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
	TAGGED_FROM(0.00)[bounces-20512-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 05:25:21PM CEST, parav@nvidia.com wrote:
>
>
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: 12 May 2026 07:37 PM
>> 
>> Tue, May 12, 2026 at 03:48:32PM CEST, parav@nvidia.com wrote:
>> >
>> >> From: Jiri Pirko <jiri@resnulli.us>
>> >> Sent: 12 May 2026 02:16 PM
>> >>
>> >> Mon, May 11, 2026 at 08:21:37PM +0200, parav@nvidia.com wrote:
>> >> >
>> >> >> From: Mark Bloch <mbloch@nvidia.com>
>> >> >> Sent: 10 May 2026 06:02 PM
>> >> >>
>> >> >
>> >> >[..]
>> >> >
>> >> >> > I look at it from the perspective that from some CX generation,
>> >> >> > switchdev mode should be default. So that is a device-based decision.
>> >> >> > I believe as such it can optionally be permanenty configured (nv config)
>> >> >> > on older device. Why not?
>> >> >>
>> >> >Because sometimes switchdev_inactive is needed and sometimes not.
>> >> >Such knob is not device decision.
>> >>
>> >> That is what I would call corner case. In that, user can use userspace
>> >> configuration to change the mode in runtime.
>> >>
>> >Corner vs common depends on users one talks to. :)
>> >If fw has switchdev(active) as default, and then
>> >And user needs to run switchdev_inactive, it will actually break their switching applications.
>> 
>> Can you describe the actutal breakage please?
>> 
>Driver default was switchdev so all the traffic is forwarded to the switch,
>and user didn't have chance to setup the fdb rules.
>So packets are dropped but user didn't expect the traffic to be forwarded.

User may switch mode to switchdev_inactive early on, before any of the
representors are created. What's the issue then?


>
>With this RFC, the device would start in the switchdev_inactive.
>And user's goal is achieved.
>
>> >
>> >So, one needs to invent switchdev_inactive in the FW.
>> >
>> >Jakub's suggestion in this RFC is covering both the scenarios uniformly without above problems.
>> >Single uapi for all the cases, so looks good to me.
>> >
>> >Moreover, do not understand how alternative solves such problems.
>> >i.e. user is unable to configure the fw because driver is not yet loaded/up.
>> 
>> See my other reply in this thread. I don't think there is a need to
>> configure anything in FW. If we fix the behaviour in switchdev mode for
>> non-sriov user and change the default, no fw knob needed. What am I
>> missing?
>> 
>If I understood your suggestion right, is it the devlinkd based solution?

The suggestion is to use "switchdev" as default with user configuration
no matter if it is devlinkd or something else.


>
>If yes, then Mark explained that it has the issue of all drivers to be loaded, followed by user space to start.

