Return-Path: <linux-rdma+bounces-8644-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD61AA5EEA0
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 09:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896D818894A6
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 08:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE238263C7C;
	Thu, 13 Mar 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivWwWQ9x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514F25F992
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856211; cv=none; b=c7cf8pP9wX+NTgKgf/oei3g4aNkvQNc1CvpLVuZcekhpExfRVicOMGlvkIf54XiMRpnPBTBhbqGScWyBNLAFlF3bi2pllWVOJRdJ/38tI6vbmaDvUXQPliX+g86Wrgwam+8VaTjJulLxKNuH1y22PEEz688mPaJNrHaBxzHFDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856211; c=relaxed/simple;
	bh=MN2o2MYobQJl9px7sHfTeadgYO6AsM8ahCPbVurX5dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwQWmTOoyld+f8abR9LVLJLJJFdBTl4a+JRtRTxiG+7z8RtDJ3zn+naJ8HKmToLird3HYC7A/ga1BwKDX5mGh95bSQfDmAln/utMBwMeo7sD2ZpDYAuHr6UiyDzcR0wGl/rE+I9h3mXxeaQrna7IlKIKeLIjaLFdHtO86pacp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivWwWQ9x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741856208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oq+24fkQG9B36+j3ofSLg7Afq2zSvxuROfzYWAGMCrQ=;
	b=ivWwWQ9xBLeO24OYZ+uugZGKTx4bx9pI3b2KO6FuHfnZmMUtNg3sof5D7FHQWZaWoVbWdR
	YKyjualHWDpi0VFFT7+F31md6z3akYLDf6xx/D4BV6nN6nFha0YVXW0AM6ApTxdF4e7+40
	e6gbYBQPLRn8AN/Ds/EMl/eAvqXUu60=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-3aiP-YYnM26CqPzl-SovUQ-1; Thu, 13 Mar 2025 04:56:45 -0400
X-MC-Unique: 3aiP-YYnM26CqPzl-SovUQ-1
X-Mimecast-MFC-AGG-ID: 3aiP-YYnM26CqPzl-SovUQ_1741856204
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39135d31ca4so354030f8f.1
        for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 01:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856204; x=1742461004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oq+24fkQG9B36+j3ofSLg7Afq2zSvxuROfzYWAGMCrQ=;
        b=C9a5r9p3XgDmk8AhPJ3pG9gXKx95fKC6fOFMZ2fV9kinpQucHQrHQ+/xltK89YUcb8
         rZEnSEVE1qWeXZR3PTucUe5Q50itVPMPoea1uePEVpd8gSzrWfW8T0JwdMab6gBrQSUP
         35X7G4tx1P3Ls1yuZz+ZOVtZRP0aXiZHfR61quIBa8lZjV9om70oOfVp0wHrKcSF0fJ8
         01sXZwq39zs0YGK7VLXYm+6Gt5VlK1zd4zwPboPpIjtaEuKUIH4sKnCKj8RaYoLK7jO8
         kGgLE709PRcDWWtOwAGLgaq90FrrZhZkVtFawQpjoqhjD2tLpwdSzYURAK18pLv0/Gqh
         RVpg==
X-Forwarded-Encrypted: i=1; AJvYcCWnJ+NMQPtPVusETPF4KMTq7IX+97RwLEaHvZ3iJyHp5YCMixTEXEBgXKp00J26bh7uYnc+kTkZVNqO@vger.kernel.org
X-Gm-Message-State: AOJu0YwN3IdSdcxaLET6PwWh50biUb69ytybtxPINYi+sUFZ3mUIrYry
	v/IfWGaY67VSr27PXfj3rX6YTE+iBfe6JvprFMuPs4l2HS9BaEFIwVo3EMdMtYtRz7G2olVLUsD
	uEGN1SLNl9nGvW5BCXa/qcIXOcbUAqby+o8o+GCkDbRm+WgtiFF9fvRolRos=
X-Gm-Gg: ASbGncs9KpD1fpxsLB31zFPAUQCErM0qcCdN0Jxz5R1aLLt5y5Egb+OKKNKat0KS37Y
	ckHuvltn9CYFiIWETTKSrFh6tJ9vOYJ+V2c3YSvCfgtHTJIeJP+mZV5qPHnSsKdzgFVmEYoPuH5
	6BTESpaA2X3ya/iNdubp5nry6Vz2NYK8HvzgGFXQ0xwubSEfQdDy/ljhYrHuNxXSDLwEMDqGyJk
	VamMQNsMAtalQqB3nPVYi8LEp1QV7HhqWLNGE1VwBqum3YhLjWFh04kk+cZB9AA3To6Bn6i21N8
	JbRU6lJheIo2IG6KJh/qLQg/kKF1EqjtKUMyuFROoC0=
X-Received: by 2002:a5d:59a3:0:b0:390:e904:63ee with SMTP id ffacd0b85a97d-395b954eb3fmr1140380f8f.17.1741856204169;
        Thu, 13 Mar 2025 01:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2waDP34RqXt0KBDw48jv4ij3ndaEJeyaWFw4ma7prQWIWMBKhbkdZzIvaLpui+87fLLt/Nw==
X-Received: by 2002:a5d:59a3:0:b0:390:e904:63ee with SMTP id ffacd0b85a97d-395b954eb3fmr1140348f8f.17.1741856203847;
        Thu, 13 Mar 2025 01:56:43 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-237.dyn.eolo.it. [146.241.7.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d188b0092sm13287825e9.5.2025.03.13.01.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 01:56:43 -0700 (PDT)
Message-ID: <2ff2d876-84b4-4f2f-a8cc-5eeb0affed2b@redhat.com>
Date: Thu, 13 Mar 2025 09:56:41 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [pull-request] mlx5-next updates 2025-03-10
To: Tariq Toukan <ttoukan.linux@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, leon@kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, mbloch@nvidia.com, moshe@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, leonro@nvidia.com, ychemla@nvidia.com,
 Tariq Toukan <tariqt@nvidia.com>
References: <1741608293-41436-1-git-send-email-tariqt@nvidia.com>
 <174168972325.3890771.16087738431627229920.git-patchwork-notify@kernel.org>
 <9960fce1-991e-4aa3-b2a9-b3b212a03631@gmail.com>
 <20250312212942.56d778e7@kernel.org>
 <f30ee793-6538-4ec8-b90d-90e7513a5b3c@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <f30ee793-6538-4ec8-b90d-90e7513a5b3c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/25 9:07 AM, Tariq Toukan wrote:
> On 12/03/2025 22:29, Jakub Kicinski wrote:
>> On Tue, 11 Mar 2025 22:50:24 +0200 Tariq Toukan wrote:
>>>> This pull request was applied to bpf/bpf-next.git (net)
>>>
>>> Seems to be mistakenly applied to bpf-next instead of net-next.
>>
>> The bot gets confused. You should probably throw the date into the tag
>> to make its job a little easier.
> 
> It did not pull the intended patch in this PR:
> f550694e88b7 net/mlx5: Add IFC bits for PPCNT recovery counters group
> 
> Anything wrong with the PR itself?
> Or it is bot issue?
> 
>> In any case, the tag pulls 6 commits
>> for me now.. (I may have missed repost, I'm quite behind on the ML
>> traffic)
> 
> How do we get the patch pulled?

My [limited] understanding is as follow: nobody actually processed the
PR yet, the bot was just confused by the generic tag name.

I can pull the tag right now/soon, if you confirm that this tag:

https://web.git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next

is still valid/correct.

> It's necessary for my next feature in queue...

Please note that due to the concurrent NetDev conference we are
processing patches with limited capacity, please expect considerable delay.

Thanks,

Paolo


