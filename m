Return-Path: <linux-rdma+bounces-12458-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC71AB10806
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 12:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51A2AE3F90
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jul 2025 10:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EA026A1A8;
	Thu, 24 Jul 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIYbS6ke"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA86E26A08A;
	Thu, 24 Jul 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353975; cv=none; b=B3xHZJGgH7sSL7x4FyGGYPuiQASBsP7frydoKN+DEeuCc+Yj1nKUb5CNfuZT4iGwGZL5PgwBYyNsQIWJXz2LZhau34R40AmHRflWBurRQLMbcVUJ6HprzpBrRtTRmdrJO7G8OpdnJV1kDv5O8WghahlIs5xkKJixuFzUrzquFqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353975; c=relaxed/simple;
	bh=xmBaVTQvnV6kaGGqhu7GbZCc1bl8sDliNYMy72sS7/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzoCXIuLiVzUfiQU+90MT5oFFmLDXd6fChjJEMbjDPytwuE7Rx0YhjMBErD28kz7EYZ0ectTRFcGwy85cINFl8dO2Ct+jhhiny2TYM+/DSR0PIs22hKSKHR94IkTMSOn0sZoz4bPMTCM9BzH19oOMdbNSQrIuCFnGirN/xzYaSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIYbS6ke; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so7145365e9.0;
        Thu, 24 Jul 2025 03:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753353972; x=1753958772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEUPeEfAoqVDN5AzS+Zi6ECP6+DLN/BEyFRoJmYLtxk=;
        b=eIYbS6ke9+Ne07xsRwGNXSjwnmxvlbS4Dvu6GQeICRGSNdY326fKODTho5Qm+PlJVV
         sn6hXXl0qRfhD1/on4/0AvoVO0MCVpRgy2fXO92BQ10ZVBe9umhDoTfzVe8PEIqNazy7
         Anid5U4Qvok2cA3bLVcksmotnwqg7q2LkORETH1sTMNeZfj+yLtc98brNTFZvvlK9mbQ
         TIU7Kboh67iWlegoqHnJYIvwoRF9QdxcyRoKR1O87voZf7qJGHv821WFT2cIQ1djanDr
         9dZ8rEk7mwZO6+L6T7YzJ3j3NjGlhW+v/uJFpWoTk9ZCQojYy5LJDzDx4solviOMnEWe
         Oytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753353972; x=1753958772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YEUPeEfAoqVDN5AzS+Zi6ECP6+DLN/BEyFRoJmYLtxk=;
        b=Vl7BRqCKwyE8/pX2v1HLmOtF3HjY42H7rtCSLdKYeGQv1fphk+Qm2ofFZ51BrpjHY6
         xbq9CNiWppIkIaGPU+7/wh0pjryWBbTF9xUVMDPFWGc0ZZExOeRtFn5hCBcwhH5dGoaM
         4wQ6MkTMmIhJiccIRtZxdVOjkFMPyU7izY1XmYFjzQlFiLU/pcmCk9lYxlzAuuBxPGFi
         U4mKOPIt7DapyJGihG5W0BdGEaV/eJ665XrndTY4VDIC93Jt7HbOEMAieT1aHNdG3PAW
         ke5lZH0jxGGBXNXCzlduijkkdNdozwlQXGx0sE5KH+HeiNsdVdDLMpAJo//Wj1OTcJ7A
         usWA==
X-Forwarded-Encrypted: i=1; AJvYcCU8PBMBg62KCw1OBJQRswVrar+q45o1x5FL3MD+2IRpJ6GKZq3+3rqOLSZ5/Y7EQYS+7YPQkM2g6ck=@vger.kernel.org, AJvYcCX0F454YosScXQUOKJJc2RWmPhkkWlgjr1MS3hAn1bUBUtr/q1hiRCUppC7N32F2LjSclKdiQZz@vger.kernel.org, AJvYcCX4sVpOADnmhJZwNxJAkcpeLFH/CuesLmKDjwljudoqBUsaZxFCmcp4HeVctolgmH/Y7YCNIAIlyWBURlb3@vger.kernel.org, AJvYcCXhbHtUQDniIa3tuYxGtqkt1NxyO/wEVLdKiaUxryHA2dG4jAhZjYzDUbGGhQ9LkcPV1TPsVTwIRs2khg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQp6dbZ7RlOETJoIMm3L3+3Vxd6aH43sbiPGopdiYOutnAtJB
	GxcKxMHPb7GoBsFb105DNaRr4eWK3Vkt0Nkayc19XgLCkEsn521iKMkw
X-Gm-Gg: ASbGncs5ceVeLePsXEjC5D0Ri8JKGpsQ5QfkwfrG7LeJi0bEq5qVrLBicFJbM8G1vev
	tTPZRT63FO/fosS38Y+gbRCIegnw0WvbCWVw4euL8nQdoOT/L28yBtPDPHYFBgUP9zlHQ+TkM+f
	INS+L+HVC47VEcPh76P3AdQvcz89rOP2wkjzhm/iMbMU0928LWWV/thWv2EKIbBc0R/NJoDeUJg
	WbPSwMqJuRKlwvGrkB/CBjBOSzNV1sEOrAYRK22iTKw9FwZ+OOwdsoUsi6W4SV5jtY++StOKTiB
	zIhYQSo4TEjcTYZU/HSEySk+xonRrpvNpDuPkFXDQka7MXXr2Lg30cKE7AB6nDF0JUXdxJJyYwg
	Ztz+pYlI1tVol8L7kmSqWh4XBl/W703DtUNkfmHLld95ap/w=
X-Google-Smtp-Source: AGHT+IGtbri2LyVwVV5y2rXjxBpJkNTC31WMYq6VcMg7L3LFbeb1UNBKa0ttb0d56fjHKoQjRi9rpw==
X-Received: by 2002:a05:600c:4f06:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-45870973ccbmr11393355e9.0.1753353971581;
        Thu, 24 Jul 2025 03:46:11 -0700 (PDT)
Received: from [10.221.199.138] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcb8205sm1773660f8f.55.2025.07.24.03.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 03:46:11 -0700 (PDT)
Message-ID: <6892bb46-e2eb-4373-9ac0-6c43eca78b8e@gmail.com>
Date: Thu, 24 Jul 2025 13:46:08 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] Expose grace period delay for devlink health
 reporter
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>,
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
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250718174737.1d1177cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/07/2025 3:47, Jakub Kicinski wrote:
> On Thu, 17 Jul 2025 19:07:17 +0300 Tariq Toukan wrote:
>> Currently, the devlink health reporter initiates the grace period
>> immediately after recovering an error, which blocks further recovery
>> attempts until the grace period concludes. Since additional errors
>> are not generally expected during this short interval, any new error
>> reported during the grace period is not only rejected but also causes
>> the reporter to enter an error state that requires manual intervention.
>>
>> This approach poses a problem in scenarios where a single root cause
>> triggers multiple related errors in quick succession - for example,
>> a PCI issue affecting multiple hardware queues. Because these errors
>> are closely related and occur rapidly, it is more effective to handle
>> them together rather than handling only the first one reported and
>> blocking any subsequent recovery attempts. Furthermore, setting the
>> reporter to an error state in this context can be misleading, as these
>> multiple errors are manifestations of a single underlying issue, making
>> it unlike the general case where additional errors are not expected
>> during the grace period.
>>
>> To resolve this, introduce a configurable grace period delay attribute
>> to the devlink health reporter. This delay starts when the first error
>> is recovered and lasts for a user-defined duration. Once this grace
>> period delay expires, the actual grace period begins. After the grace
>> period ends, a new reported error will start the same flow again.
>>
>> Timeline summary:
>>
>> ----|--------|------------------------------/----------------------/--
>> error is  error is    grace period delay          grace period
>> reported  recovered  (recoveries allowed)     (recoveries blocked)
>>
>> With grace period delay, create a time window during which recovery
>> attempts are permitted, allowing all reported errors to be handled
>> sequentially before the grace period starts. Once the grace period
>> begins, it prevents any further error recoveries until it ends.
> 
> We are rate limiting recoveries, the "networking solution" to the
> problem you're describing would be to introduce a burst size.
> Some kind of poor man's token bucket filter.
> 
> Could you say more about what designs were considered and why this
> one was chosen?
> 

Please see below.
If no more comments, I'll add the below to the cover letter and re-spin.

Regards,
Tariq

Design alternatives considered:

1. Recover all queues upon any error:
    A brute-force approach that recovers all queues on any error.
    While simple, it is overly aggressive and disrupts unaffected queues
    unnecessarily. Also, because this is handled entirely within the
    driver, it leads to a driver-specific implementation rather than a
    generic one.

2. Per-queue reporter:
    This design would isolate recovery handling per SQ or RQ, effectively
    removing interdependencies between queues. While conceptually clean,
    it introduces significant scalability challenges as the number of
    queues grows, as well as synchronization challenges across multiple
    reporters.

3. Error aggregation with delayed handling:
    Errors arriving during the grace period are saved and processed after
    it ends. While addressing the issue of related errors whose recovery
    is aborted as grace period started, this adds complexity due to
    synchronization needs and contradicts the assumption that no errors
    should occur during a healthy system’s grace period. Also, this
    breaks the important role of grace period in preventing an infinite
    loop of immediate error detection following recovery. In such cases
    we want to stop.

4. Allowing a fixed burst of errors before starting grace period:
    Allows a set number of recoveries before the grace period begins.
    However, it also requires limiting the error reporting window.
    To keep the design simple, the burst threshold becomes redundant.

The grace period delay design was chosen for its simplicity and
precision in addressing the problem at hand. It effectively captures
the temporal correlation of related errors and aligns with the original
intent of the grace period as a stabilization window where further
errors are unexpected, and if they do occur, they indicate an abnormal
system state.




