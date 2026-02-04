Return-Path: <linux-rdma+bounces-16499-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNGeCHbwgmmWfQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16499-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 08:08:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C610E2894
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 08:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD60303A5ED
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 07:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADE138947F;
	Wed,  4 Feb 2026 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1whEmtu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE737F728
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770188897; cv=none; b=Sr+2FiBGgMjxm7qCsYHD671WYM8KumY4uPxni0Too3Qt9EqZGmHABI4AgB/BJJSejn067xd85bkoXvW3/p+hUWMBkbgx5iF0VLw08nVxGEQxMkcKh6GTzHej7hZOPLyQG1Sd1cwiReDOBvo0bBww9IJwfQaVkAbW4MCNS3T8em0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770188897; c=relaxed/simple;
	bh=nZc2xi5zdfE0k9aodqhuuyxCv5YS9Ogmy++z4WwGvlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFIryj0VbMNUNd3xJSNwbGhp5RQNuPbZloma1JQuzw9A761Flb8oYClXC0U/42hhIxMS1X6d33gKLIvvayK/dZhvt5yDAy82rFDmpffIDG1lFty2CrUpRa4yTHECzUzZOK5tXzXYWUkJwJIh69wXK8brrS+K0kMPREBjZrIWUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1whEmtu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4359108fd24so208137f8f.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 23:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770188895; x=1770793695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kqnpITCCQiIQonzXq9ScSS11b9xv/CuzslKyMe7TLdE=;
        b=e1whEmtun5UfQZIiU3dL0el4NLpHcA6q7nJ9jVU3drGNTu/II5icMGTQrmlseujkh8
         /WpdCBKYX5A17RO+yOPUdPEUu+l9ho+fpYEyI3/eJZHCUPAoU+DRvpOYTy6lLU7BNFVI
         ZYq1+hHv1LpC5s5fXpAGZK4pD+pWfgDR/ROL4rMjBY7W7V7AuoJW6cyL3dO00Qxy+A5q
         gouWd3js2G56adcwcC1D6bwFESyzmX7F2mZ1xF1RRz+L0HRzCUQRxz+/oBx1uCZ5KRpn
         c9G0hifSfNtNOOqTip7goKYOkvrsPoTK7Ipzngxg5G/I43webNNsljdrHS2ZTide7vTA
         r1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770188895; x=1770793695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqnpITCCQiIQonzXq9ScSS11b9xv/CuzslKyMe7TLdE=;
        b=t5i3vy2HvgSDCc7+o4h8/8a8ow9Fu/1P/2EcY9eTl0Z88CALaMTmVtjv4HgUlpK3lV
         4CmVOSzrIHI6t63DKE844Wf+1vjtpIpPjyjlpV0AS0ujqxfheOpmr8EFi5kgnnJlvcID
         i+EtHcKW224cWGpLE+2F7D/cQkyrWZhyOqTReX9sluE8ErBH43zBmbSY1HALk4SxNTNv
         J9ZSSVQeKkqoINgvbBpS+1ZTGphKUAe9AD4A1gIMPYdIuIhPDWc0pMw19ghc/J9gXQMd
         sLfGho3hMpPcnhU7blSXh9w4k8PAyQZns+dfffXANESkl7AWiXU9//rGJb7AgQOj4IbC
         KuAw==
X-Forwarded-Encrypted: i=1; AJvYcCWe0w62JJidODEgnPM5mAfdGi3XjswkYr9xD5mtZKDHa79iYAIzlNAxSfgXFiTKXQkcrgrgJZu/9kq3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6lI7lRCuXH3XSclMJUJgyH+I3e2x7GRq3KuiUDv/o1RjRcZAj
	3TLh9wnCTtXXYaHKFBOfZvbAT/ZUvKCMWfWz9zx6JDA6+foFYRBxs2L1
X-Gm-Gg: AZuq6aIFHwnFZ9nMr4ipjHX7xLxdLmeJXAjGHeumz4UF27WkTBwzY5iYGA3XyaDY4YB
	t6J1AeGCTRw9dGg78jfi5uliqW12AYTw+yLHT1BMmCtGQhGhGCleR8hxAMQiZ+35SjRRV2uSpJ9
	3Cg/4wt29M/7izdLeZ6KLm+49S2jC3BgMPHpdM8NFF47QIAZ5M9cQ8LbeiyPt2tKlz8vqj+FQ7a
	ZguMsjHeSn6cRv19zRhtrZJalTIXooNncgDeJSidf2ZAwbmTjWGJcAUYWvLvLFJt1kPC+DkcBKM
	+XaWHuHJFrEcZUDOha2/BalgZhjY637TxrAcafaTpeTb/TM4k2RF8cS9MIv3hTVphsOkgLq0Ygb
	pkobFLrwWDj18VNvzYcTqhoMhj6z81821QV6fAakx/iC5IpWD+Wu5TTRSl8iJBABOLvAxKKIEy6
	YNL9P6kCOalYyCV3C7LgwNxHBtZfqN
X-Received: by 2002:a05:6000:2888:b0:435:8d02:b9cd with SMTP id ffacd0b85a97d-43617e3d500mr2536235f8f.26.1770188894959;
        Tue, 03 Feb 2026 23:08:14 -0800 (PST)
Received: from [10.80.1.200] ([72.25.96.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e38fbbsm4578360f8f.13.2026.02.03.23.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 23:08:14 -0800 (PST)
Message-ID: <f3e5ef08-c073-4f96-b874-8fcf8c72af2a@gmail.com>
Date: Wed, 4 Feb 2026 09:08:13 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] selftest: netdevsim: Add devlink port
 resource test
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
 <20260203071033.1709445-5-tariqt@nvidia.com>
 <ce09e17d-2b74-4bda-a8ec-352c92659a6e@redhat.com>
 <20260203182652.39a3620d@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260203182652.39a3620d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,google.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16499-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7C610E2894
X-Rspamd-Action: no action



On 04/02/2026 4:26, Jakub Kicinski wrote:
> On Tue, 3 Feb 2026 11:16:45 +0100 Paolo Abeni wrote:
>> # Error: netdevsim: Exceeded number of supported fib entries.
>> # Error: netdevsim: Exceeded number of supported fib entries.
>> # kernel answers: Operation not permitted
>> # TEST: resource test                                                 [ OK ]
>> # Command "resource" not found
>> # Command "resource" not found
>> # TEST: port resource test                                            [FAIL]
>> # Failed to show port resource for netdevsim/netdevsim10/0
>> # TEST: dev_info test                                                 [ OK ]
>> # TEST: empty reporter test                                           [ OK ]
>> # kernel answers: Success
>> # kernel answers: Success
>> # ./devlink.sh: line 614: echo: write error: Invalid argument
>> # Error: netdevsim: User setup the recover to fail for testing purposes.
> 
> I suppose this is because iproute2 needs patching. Tariq, could you
> post the user space bits or share a link where we can pull them from?
> I'll revive this in PW once we have CLI updated..
> 

Right. I'll include a pointer in the next submission.
We're fixing the code to fail gracefully (i.e. skip) if userspace 
doesn't have the needed support.



