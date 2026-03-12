Return-Path: <linux-rdma+bounces-18115-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOJoBkHPsmmPPwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18115-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 15:35:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B582727376A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 15:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C1E23187279
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1B136D9E4;
	Thu, 12 Mar 2026 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kt1cPIX4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24235F19C
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325802; cv=none; b=ssT/oUsJcpVzqwA9QYRC22+OvQJxlMtt1R476lKagxKWF/UrDT6NcK2bBLvoqp8x7lW7V6cmSfYAHZ4TQzd0y7K/GxfB1ACWjp4G0QwK1piq0EMWa+WqNDlkfMKrFp0j7i1k/a/1Wke3uGH9DOCFM97dwAVWN+qmxZa0bOvUSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325802; c=relaxed/simple;
	bh=UWFL9/AlWB4G82QemscP/h3YWNXqRlJRdDFLB62NK4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/wj7U0Hvk91XvX60uB9d+BKKrSG/a8vLNej7JyYL0xPgOO8AGPk6H8H1z0BybjFAoNq/INxYyphxOTibb/P6HOrzbgNfL3EvEHmsr+TsJCfXOr17UtwQAc8PQNtCi9uFbUFqI3kBEDxbRs0twBmibEziyCwCgTqCU8E4czQlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kt1cPIX4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b78b638eso1226342f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773325797; x=1773930597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EujO5n+9D3v/kt3E/tW4gqS3T8Dw8WwoBPDrs2+L3Eg=;
        b=kt1cPIX4SQMB3s7vdIw+iPpUjsp3fMEmpWCWkgExSGiljACs3dH/SJEMPuwFTVyT5Y
         QmcjwoYDTsnp0U1t/uc5GiqxTtSymRj1UHH89MIj7QAHXJJhhOH3KEO0Pu91F2b5I/yp
         2Zn2OZiNSS2REBgKuYUmmrgpj49h3LAWb/SmYINg6F2GiI1ijqgww1IQM1v6y6VrBLuJ
         aJ9x/lwL06WR7B+RlG1L80o7MtVM67Nk2sCZIsJGUv7taEF6pWthUs9KYZ03ymFvNgPi
         xZPYN468g4F8vKHGozCDxG4eVhEqgihGfhvQ7bgSmUsMkM3m0aUTPG2lzTDPzQzyy7kH
         Wc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773325797; x=1773930597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EujO5n+9D3v/kt3E/tW4gqS3T8Dw8WwoBPDrs2+L3Eg=;
        b=txYvnQsGHecYnxjTthLuYjO2c5UFpnRVW2GZd6mgZ45lEFvz3/2WzVDkwG3RE6bFhU
         LBmETjeWFj9ML5knzzIktXluPfcCSjv7t6eh+ET0VIODX0xoEDY4s8Jeo+kp4RdPKovY
         WhUlgx4ZxfhXKROeC2TLe9RU/BRaNUTk8zj4D1HmO75J4UVAjmF5ZoytIgmLjsN40HuQ
         1ewt/SWPgvad2kUrBKV2u7BUo8jKYJRbjyeFLuZME3wChQNRnyk9+ArLjrbBi/C0mE61
         lIon35j87YH/P/lyZ/HHih+6XUKk42UNCVgfTOAkv0xM17/lAygjy/JZnK95QmA9J3xr
         ubBA==
X-Forwarded-Encrypted: i=1; AJvYcCWDL+dTr9/krlNNnhWM0jepyQNG0MY99LgcLo5zOuj41GyE/hMTi1rfxJccI3HaB2UHBAIyxZXihzdo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7tTsE71qf2L21fxsoH0+DrbjDBG0NWfFSGKSc1zan15HwF+J
	JS52sU7bNU4VcwgSfisXbZy0ZkHzHW5jTIDqp7KA5Ks/HgRj3R3JEygaBwsXyt4530o=
X-Gm-Gg: ATEYQzzPkGU1q5WVC9JEGu/uSuaU0I9ce83YnQUvMiFoVidazP/tIgZfWTlQxUIt+g5
	q7l5AxWu6v71MGMlEOTzNw+duF860wSl+mr5H9XSaqXo1/LxJePaOnc/ktba2HExR7tRZJ8QT09
	EFLMPyknbS0ydMJdPtHF5DtmPcpA+TsRSYuIwuY3dxfHj4yzInRQwu+2iYg13UoE8ah1gZCTo/f
	rfdIfMkDlR7RDidTfGkoIa4jaklWwYq3+BIb6IAMYTb0Rb778M5LnhYUsqkypJUv07y7aTmyBfz
	r6khjXuQhIOIPaAfzOArRwwX//MTtoiFNS5f32Scx42BAgztkqu/vIJvUYTvlq2HqU0g9t9lwA2
	tjX+4HgHc5hb6K8PKhCXrKz0HOPyNFFH1C4u7aS6oDhHOPeB4ruE22OC+YORqb3mYt7hey1DppJ
	TqfBjPQp+/subiNqCEYKQUGcwkmIcM5Vk=
X-Received: by 2002:a5d:5f86:0:b0:439:c279:32e9 with SMTP id ffacd0b85a97d-439f8423c4cmr12520707f8f.39.1773325797433;
        Thu, 12 Mar 2026 07:29:57 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1b287dsm8471226f8f.17.2026.03.12.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:29:56 -0700 (PDT)
Date: Thu, 12 Mar 2026 15:29:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource support
Message-ID: <fw6blzybx7hmvxvqoiy7civmzbf4yuhn2xzdna4apypkuwvck7@xh7iwjt27vi6>
References: <np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
 <20260305063729.7e40775d@kernel.org>
 <ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
 <20260306120301.0ebe1ab2@kernel.org>
 <74dcd7c5-8a2b-49a7-a23c-174d17a61955@nvidia.com>
 <20260309133341.7e08b35d@kernel.org>
 <5de5103e-e2e4-4b72-9c3c-22847728fbb8@nvidia.com>
 <20260311145126.7dcca532@kernel.org>
 <go5wr5qa7wxe7i4kkcbmecomshpkesr26alq4qmlbpjr72hxgt@mpwq6eufylpn>
 <20260312071916.6b759c3f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312071916.6b759c3f@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18115-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B582727376A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, Mar 12, 2026 at 03:19:16PM +0100, kuba@kernel.org wrote:
>On Thu, 12 Mar 2026 09:34:52 +0100 Jiri Pirko wrote:
>> >> devlink resource show scope dev
>> >> pci/0000:03:00.0:
>> >> <resource>
>> >> pci/0000:03:00.1:
>> >> <resource>  
>> >
>> >LGTM  
>> 
>> I don't see the benefit of exposing the scope to the user to be honest.
>> I mean, dump would show all, dump with "dev" handle would be used as a
>> selector to dump only things related to "dev". What is the use case of
>> this "scope" granularity?
>
>If we follow the logic that dump should show the user relevant
>resources, no matter which sub-object they are attached to -
>having a dev specified should only filter the objects to match
>the dev, including resources which are on ports of that dev.
>
>IDK if there's a strong use case for allowing the user to set
>scope on CLI but also - I don't see why not?

At least some small sense of consistency with other dumps? Health
reporter and region does not have scope and output mixture of dev-based
and port-based objects. Why to confuse user?


>
>> >> For the do-it command:
>> >> devlink resource show pci/0000:03:00.0
>> >> pci/0000:03:00.0:
>> >> <resource>
>> >> pci/0000:03:00.0/196608:
>> >> <port-resource>
>> >> pci/0000:03:00.0/196609:
>> >> <port-resource>
>> >> 
>> >> devlink resource show pci/0000:03:00.0 scope port
>> >> pci/0000:03:00.0/196608:
>> >> <port-resource>
>> >> pci/0000:03:00.0/196609:
>> >> <port-resource>
>> >> 
>> >> devlink resource show pci/0000:03:00.0  scope dev
>> >> pci/0000:03:00.0:
>> >> <resource>  
>> >
>> >Do we have to touch doit? Maybe we should let doit be what it is now
>> >and consider it legacy going forward? doit which is in fact a filtered
>> >dump is a bit of a mistake in the first place, from Netlink's
>> >perspective.  
>> 
>> I don't think we should. If user wants doit, he is going to specify the
>> object (dev/port). If user is interested only in things related to
>> single device, he should do dump with selector (dev).
>
>Could you confirm that you're agreeing that we should leave doit as is?
>I'm not 100% sure after reading this twice :)

Yes.

