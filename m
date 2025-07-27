Return-Path: <linux-rdma+bounces-12491-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5CB12F45
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jul 2025 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A94E189789C
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jul 2025 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FEE20E715;
	Sun, 27 Jul 2025 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBaa1YlC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A418A6CF;
	Sun, 27 Jul 2025 11:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753614018; cv=none; b=oKf/3n45li21iTjxMtYExbtns4L4kqkEkYRc5D8WBx+Kyuc2pnddiZzNi99ix1LwkMSAcNXXWW4DjbQ27hUGlMgIC60xiQYnrKhrzJVMZbb5Xzc0aqe1+kdvoFS0pSG2Ik91z+fmQc4NlK+s6y7WJgJC5/z1knaf56unSUtouEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753614018; c=relaxed/simple;
	bh=6ypzSIXI2Y/q/zZlhmGNnNXHSMY20Q1NQBDm/5WD02g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lbB+XxmP39Wk3x4rsII1fTT5yaGFodPjcjFKRhsQLX8EOQHHVU1UeLYUjRX/KDSLfvnvaJQXPgXggi6r+hAa9HV90yuYoVi25vesReIyhdoRiDQSbOQTZDLRWbdf8EsMNu8CcQdljoVc+U39wnSR20h38nh0G5yrrxCZjPfbHRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBaa1YlC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so19271795e9.2;
        Sun, 27 Jul 2025 04:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753614015; x=1754218815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHeZkftYAbkyHtBV0wRRYYi4zatoiTrB+Y/dcAdYXbc=;
        b=SBaa1YlCYJ89h2u1uuySHTl+kfouKu7Z0AWInCckJaOVIqUHO9Itu45pyzR5l2vEaD
         pzLD+kRr4QUVWAC2nwlgmU+ypmsS+VwNlcc238Lwz40fOzajkPRHHSXZ1J142YZrerbt
         /RTR6Ook97XCup3SvpyViL5dp8mmjAPT1mmtM+KeWx1oGhNr8WSPkqgHciOMrjY3kG2E
         BN+iFV4uaH5BjYe2WkBeY/aTLR8CzSwyRl94CsapJcJwOusfLF88IMrX2yqc/54Yo0eO
         PK8F0+ZwC+gqrf8uorfhlzOdgb2O3L7IQIxb4wjj+GrAicv+E8k+1LsIPP/tp6jr3fQZ
         bkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753614015; x=1754218815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHeZkftYAbkyHtBV0wRRYYi4zatoiTrB+Y/dcAdYXbc=;
        b=XuFBqPUXJAl1srvPGMdBZsrvwIyogtt9Pr5fsBXNzEPRsynFCKMPnr9S1fzPm6MXXU
         ZyTcM3VieAVPOtd0GBgv4Nl4Mtjn2aRMGO6VMfbhrcqW+ISpFo2ylPyWT3Mi9QH1VGAR
         h+9VKhWqlgvDDgz/0jP26InM828P3/OTAF9ptlV9tkdnaTXNj7nw8EOcuuhaXHS2W9l0
         ha44qhn4+C3bkHjEB9BoOYAbvPivFFFhYCbcQXVPCM5Qiu88/J59R+XkOwQ0W+8LhJkO
         +lrza7aI1GQKhwN9LaK9wXgDE38q2XY9m1UW35jz5mg/M9j41wfGPkQOSKHSxSQuiAPm
         iEqA==
X-Forwarded-Encrypted: i=1; AJvYcCUB4n/AZL4pxVY7eYGrQh9YxyDDvMKYo7gC+2TiDg/BiS0iSSLcV6zAkfZUSdqiE8qMtFiSf77T/LrgXg==@vger.kernel.org, AJvYcCVVkDAfpwOMU9tgaLdWdkOnJt7TUbHHrykHEQhW/oxcOJ+nVbOEjFGwnwfzt8T1cAQ2sE1J6kZX@vger.kernel.org, AJvYcCWR8ARNd8wmaYSEowSeat2HOscexKHtWEVGG/Rs9xlEktS1cyeNX9Re1BPhIfdXdrDd/4kqyI3/O3c=@vger.kernel.org, AJvYcCXCnzBXjb47h1RIBCaEJeIDdKZcAxq8if1fpYOX2CNRCGLb8VVOLqYygGailYAARNJTR6ixIzyHtMYl+vkp@vger.kernel.org
X-Gm-Message-State: AOJu0YwibuXaCDftwhZhmYnUTv/p0GUN4A6MKoEu3jCWpoWXG1mBxikv
	cY3yFy3ewD14Uo1yn3NNuUqzwohs+WtL5mdIF9fX4pvSP4D93f8NoZax
X-Gm-Gg: ASbGncvnKES6j3JiF359B106LFMsNMahAeJvS1I2kjug/nPh2ZgCzPHuQpH/6cGMjKL
	AjJnQSycSum1Lrxd8SWjzt4WmYbH5f0JQWt/5BzrQHKndt2AxNeXmAUmFGJBcJ9VDs0CPe+EIFr
	m0NXUt3M8N+wQkF4TjK7l+R/OxoF5EK3jyQ4HJaWL7HVe/inaSYonhLQ+r/ON+pKGmxvdfMB2qE
	LWtyylNoCCfEQnjh55S8v3DwiFlCCFyzhF/PSG9PrhabYQKEorZ4G+fQGQZLwHFPjWCivYAoFdv
	NfeQLcNnW7MfuRHjzJzWtn2SdWkfqpRj4fGQ9M+N4F+UYIgsp0yAVgiO0dp8FWkBWyQ9udPIq7n
	bsty2ocPhHyMFVENAsxKqTb41KUuEDWhO58EG2x2Rosge3x0=
X-Google-Smtp-Source: AGHT+IEIAyE3PFazotUctyFhyDFZ5GBR5lJrudlJw2ZEAV7vCREIqwBAgJq24E3OBY15cTJoMkuygw==
X-Received: by 2002:a05:600c:1992:b0:441:d4e8:76c6 with SMTP id 5b1f17b1804b1-45876554b45mr78597285e9.30.1753614014454;
        Sun, 27 Jul 2025 04:00:14 -0700 (PDT)
Received: from [10.221.199.138] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587272b405sm93829525e9.19.2025.07.27.04.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 04:00:14 -0700 (PDT)
Message-ID: <3bf6714b-46d7-45ad-9d15-f5ce9d4b74e4@gmail.com>
Date: Sun, 27 Jul 2025 14:00:11 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] Expose grace period delay for devlink health
 reporter
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>,
 Jiri Pirko <jiri@nvidia.com>, Saeed Mahameed <saeed@kernel.org>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Shahar Shitrit <shshitrit@nvidia.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Brett Creeley <brett.creeley@amd.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Cai Huoqing
 <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Manish Chopra <manishc@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
References: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
 <20250718174737.1d1177cd@kernel.org>
 <6892bb46-e2eb-4373-9ac0-6c43eca78b8e@gmail.com>
 <20250724171011.2e8ebca4@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250724171011.2e8ebca4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25/07/2025 3:10, Jakub Kicinski wrote:
> On Thu, 24 Jul 2025 13:46:08 +0300 Tariq Toukan wrote:
>> Design alternatives considered:
>>
>> 1. Recover all queues upon any error:
>>      A brute-force approach that recovers all queues on any error.
>>      While simple, it is overly aggressive and disrupts unaffected queues
>>      unnecessarily. Also, because this is handled entirely within the
>>      driver, it leads to a driver-specific implementation rather than a
>>      generic one.
>>
>> 2. Per-queue reporter:
>>      This design would isolate recovery handling per SQ or RQ, effectively
>>      removing interdependencies between queues. While conceptually clean,
>>      it introduces significant scalability challenges as the number of
>>      queues grows, as well as synchronization challenges across multiple
>>      reporters.
>>
>> 3. Error aggregation with delayed handling:
>>      Errors arriving during the grace period are saved and processed after
>>      it ends. While addressing the issue of related errors whose recovery
>>      is aborted as grace period started, this adds complexity due to
>>      synchronization needs and contradicts the assumption that no errors
>>      should occur during a healthy system’s grace period. Also, this
>>      breaks the important role of grace period in preventing an infinite
>>      loop of immediate error detection following recovery. In such cases
>>      we want to stop.
>>
>> 4. Allowing a fixed burst of errors before starting grace period:
>>      Allows a set number of recoveries before the grace period begins.
>>      However, it also requires limiting the error reporting window.
>>      To keep the design simple, the burst threshold becomes redundant.
> 
> We're talking about burst on order of 100s, right?

It can be, typically up to O(num_cpus).

> The implementation
> is quite simple, store an array the size of burst in which you can
> save recovery timestamps (in a circular fashion). On error, count
> how many entries are in the past N msecs.
> 

I get your suggestion. I agree that it's also pretty simple to 
implement, and that it tolerates bursts.

However, I think it softens the grace period role too much. It has an 
important disadvantage, as it tolerates non-bursts as well. It lacks the 
"burstness" distinguishability.

IMO current grace_period has multiple goals, among them:

a. let the auto-recovery mechanism handle errors as long as they are 
followed by some long-enough "healthy" intervals.

b. break infinite loop of auto-recoveries, when the "healthy" interval 
is not long enough. Raise a flag to mark the need for admin intervention.

In your proposal, the above doesn't hold.
It won't prevent the infinite auto-recovery loop for a buggy system that 
has a constant rate of up to X failures in N msecs.

One can argue that this can be addressed by increasing the grace_period. 
i.e. a current system with grace_period=N is intuitively moved to 
burst_size=X and grace_period=X*N.

But increasing the grace_period by such a large factor has 
over-enforcement and hurts legitimate auto-recoveries.

Again, the main point is, it lacks the ability to properly distinguish 
between 1. a "burst" followed by a healthy interval, and 2. a buggy 
system with a rate of repeated errors.

> It's a clear generalization of current scheme which can be thought of
> as having an array of size 1 (only one most recent recovery time is
> saved).
> 

It is a simple generalization indeed.
But I don't agree it's a better filter.

>> The grace period delay design was chosen for its simplicity and
>> precision in addressing the problem at hand. It effectively captures
>> the temporal correlation of related errors and aligns with the original
>> intent of the grace period as a stabilization window where further
>> errors are unexpected, and if they do occur, they indicate an abnormal
>> system state.
> 
> Admittedly part of what I find extremely confusing when thinking about
> this API is that the period when recovery is **not** allowed is called
> "grace period".

Absolutely.
We discussed this exact same insight internally. The existing name is 
confusing, but we won't propose modifying it at this point.

> Now we add something called "grace period delay" in
> some places in the code referred to as "reporter_delay"..
> 
> It may be more palatable if we named the first period "error burst
> period" and, well, the later I suppose it's too late to rename..
It can be named after what it achieves (allows handling of more errors) 
or what it is (a shift of the grace_period). I'm fine with both, don't 
have strong preference.

I'd call it grace_period in case we didn't have one already :)

Please let me know what name you prefer.

