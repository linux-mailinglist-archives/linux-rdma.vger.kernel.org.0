Return-Path: <linux-rdma+bounces-14818-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B4CC91BE2
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Nov 2025 12:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D69294E3688
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Nov 2025 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE34B30CD94;
	Fri, 28 Nov 2025 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="w70ePudf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC21C84C6
	for <linux-rdma@vger.kernel.org>; Fri, 28 Nov 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764327630; cv=none; b=S4QcLcBKA+4aiTepBFIi9K8wK4odw/mYEQv1AIM1zWMHqnKVJT1Vrjvu0u2m71+rqRAq2pyUSDw0xTP1/3ticD6ATyIGO5WNY0fKCqw6PM0mtXanTc1+lMI4RYd347jMVdLT9AVkzEzQN1xBRH50B0ByLaChe5+rGsclvczgIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764327630; c=relaxed/simple;
	bh=IOp9FOj2LIhICws0CZA3s1Txc6WT22N2oWG0LaQYt9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcjTFwa0VrhfxTr0Y2nukc7dVRRU1OhTUXCR2a8DEdXCWJYBRKBFdOrjXdX4pGsaFC0aXFWs2ffWFC+6//z1Ft/IM73vW0FKkFlJkCcEPqsEJfz5WIpH9BjkemHmnD9p4HVC9RDy+ikZxTLt6WyREc5s6FtiMoZ0D7uvcxtQHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=w70ePudf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47790b080e4so7957085e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 28 Nov 2025 03:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1764327618; x=1764932418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMP7NxIv6VSfQPw6RM4ADyAf9vxAYhGGdSQXULfVZvo=;
        b=w70ePudfIseNA4V4Fka1OnvCsiXyD/eoqwDj6dEdj2wpr02TjTcyPg2mq2w9IMNU1F
         oqw/rL99kwYCMykeL3JefPxe/JkwpXR+bQPUcimIu4biGfpj0lAGmsnNR0ufuNF3QsdU
         UMljr9rtmilc3HWip1pdRaW3L37AU/gc8Ws7jDs1fAFL1EsnCtaDzYAQCofa/EhOK4Jo
         i6Y8wNwTDq8w5xErv1f8XX0ppE/t1EaTSIhZn2gcRUlt/c1Z54PoQCZNUHId7MrI6vpH
         AqMSu9EjHtkUPwjb8sXo9NeAemI3trPIDsDgMSgoET4pj2+tTQdoPYrqfXRlSdGYQZfM
         kf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764327618; x=1764932418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMP7NxIv6VSfQPw6RM4ADyAf9vxAYhGGdSQXULfVZvo=;
        b=gPHqnxEPqatO3PhWrwsZJb06brRDm8dLaaQUah6505YQEXGGJ1Am06dZ9uEmBf5J4m
         J5dz3JYDMKu7CjQc0tu3+NiZ6yXhIkPUuvMQO8cMSAFYYsRozeEHZB8TL03EHLPLyKpI
         qAEwEER9QaZ0QvM/yGPt4k1XZJrBbtmlspnvRc+prZ+SbDhb8YQdQ63mZSMXf3Pk/7fo
         JeCNhzzZkR5NWp+JvqvZd477PpXcqB3suipH1r6s69ODdl1PH/qjiNZ/BPBA4A7xrMpL
         k64eoXfpoRx5UXjvKKrj/nCRPYqWbqr/k0Ucb5bMmPTIEicyv6hpqMj5g1Dy8FAtgErb
         jpIA==
X-Forwarded-Encrypted: i=1; AJvYcCW1hFgTWcLNZh1xzgI7mLDkzCzB2pdYWuw2J7IRdEuOA2NWcz03dYSQjre/pqOFkYQneB1OIo4ny82N@vger.kernel.org
X-Gm-Message-State: AOJu0YxRc77w81ieXj71nNdGFEq1iqvIhBUkp2MgtT2lHsqJWozY41kj
	KDSpeTlc5UNMd7zKxRm57ynDthBdo02mHOdmZnMb7TTjaVXJlHrM34E4tREPuQkZmVk=
X-Gm-Gg: ASbGnctw60FBg/OejeLn9WzhywLpQVMStK1aS+df+bLdsYwoSrhFnyo1USL/hXUdDZU
	+sqljCD1DPrNjj0LPpWw8L9xn/hhz/ZfMdNVwJ0qtLTsUjUJt/60/zUViyHfvuC6Nc67Qcpyf+l
	MLlrsgKeVXLKxRvN5rXzAEm74mUk2a6QnhwDR1gcmZGwUXOYFcYqbyaQTZooleuxxl8gmpMLQTy
	lL3H0cL5qGffl+XkZgN7GeIg0VVPWwxIB2lj0V8H1gh3BxvktXtARVMbTPMDerwvt9kfT1hMUf4
	Dwnx914QPGXpwizB2EUoFTS5EzaIryi4dhWe0KgZL+/16YUzDjB8mmJe4iS5/+K9h6kQQ1MABmk
	UwMy84mSCfiJJUsWtDtnR8zDCdg5sBYaBnF5KcfMuYBfF2KX/+2sgxJFWeUKNBmAQ9N2qfK5Zgn
	OqEceLoOi8taQemsegl+gpCQ==
X-Google-Smtp-Source: AGHT+IHr+HluN0/afECBvJB5uKGQxbjPYYaAYttBXWOLzsrdqK/9MTRQRSzlPUFo2aX63sZzbC1ryQ==
X-Received: by 2002:a05:600c:354d:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-477c10d7003mr270158135e9.11.1764327617269;
        Fri, 28 Nov 2025 03:00:17 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c3c8csm11157723f8f.2.2025.11.28.03.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 03:00:16 -0800 (PST)
Date: Fri, 28 Nov 2025 12:00:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH net-next V4 02/14] documentation: networking: add shared
 devlink documentation
Message-ID: <hidhx467pn6pcisuoxdw3pykyvnlq7rdicmjksbozw4dtqysti@yd5lin3qft4q>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
 <1764101173-1312171-3-git-send-email-tariqt@nvidia.com>
 <20251127201645.3d7a10f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127201645.3d7a10f6@kernel.org>

Fri, Nov 28, 2025 at 05:16:45AM +0100, kuba@kernel.org wrote:
>On Tue, 25 Nov 2025 22:06:01 +0200 Tariq Toukan wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Document shared devlink instances for multiple PFs on the same chip.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>  .../networking/devlink/devlink-shared.rst     | 66 +++++++++++++++++++
>>  Documentation/networking/devlink/index.rst    |  1 +
>>  2 files changed, 67 insertions(+)
>>  create mode 100644 Documentation/networking/devlink/devlink-shared.rst
>> 
>> diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
>> new file mode 100644
>> index 000000000000..be9dd6f295df
>> --- /dev/null
>> +++ b/Documentation/networking/devlink/devlink-shared.rst
>> @@ -0,0 +1,66 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +============================
>> +Devlink Shared Instances
>> +============================
>> +
>> +Overview
>> +========
>> +
>> +Shared devlink instances allow multiple physical functions (PFs) on the same
>> +chip to share an additional devlink instance for chip-wide operations. This
>> +should be implemented within individual drivers alongside the individual PF
>> +devlink instances, not replacing them.
>> +
>> +The shared devlink instance should be backed by a faux device and should
>> +provide a common interface for operations that affect the entire chip
>> +rather than individual PFs.
>
>If we go with this we must state very clearly that this is a crutch and
>_not_ the recommended configuration...

Why "not recommented". If there is a usecase for this in a dirrerent
driver, it is probably good to utilize the shared instance, isn't it?
Perhaps I'm missing something.



>
>> +Implementation
>> +==============
>> +
>> +Architecture
>> +------------
>> +
>> +The implementation should use:
>> +
>> +* **Faux device**: Virtual device backing the shared devlink instance
>> +* **Chip identification**: PFs are grouped by chip using a driver-specific identifier
>> +* **Shared instance management**: Global list of shared instances with reference counting
>> +
>> +Initialization Flow
>> +-------------------
>> +
>> +1. **PF calls shared devlink init** during driver probe
>> +2. **Chip identification** using driver-specific method to determine device identity
>> +3. **Lookup existing shared instance** for this chip identifier
>> +4. **Create new shared instance** if none exists:
>> +
>> +   * Create faux device with chip identifier as name
>> +   * Allocate and register devlink instance
>> +   * Add to global shared instances list
>> +
>> +5. **Add PF to shared instance** PF list
>> +6. **Set nested devlink instance** for the PF devlink instance
>
>... because presumably we could use this infra to manage a single
>devlink instance? Which is what I asked for initially.

I'm not sure I follow. If there is only one PF bound, there is 1:1
relationship. Depends on how many PFs of the same ASIC you have.


>
>> +Cleanup Flow
>> +------------
>> +
>> +1. **Cleanup** when PF is removed; destroy shared instance when last PF is removed
>> +
>> +Chip Identification
>> +-------------------
>> +
>> +PFs belonging to the same chip are identified using a driver-specific method.
>> +The driver is free to choose any identifier that is suitable for determining
>> +whether two PFs are part of the same device. Examples include VPD serial numbers,
>> +device tree properties, or other hardware-specific identifiers.
>> +
>> +Locking
>> +-------
>> +
>> +A global per-driver mutex protects the shared instances list and individual shared
>> +instance PF lists during registration/deregistration.
>
>Why can't this mutex live in the core?

Well, the mutex protect the list of instances which are managed in the
driver. If you want to move the mutex, I don't see how to do it without
moving all the code related to shared devlink instances, including faux
probe etc. Is that what you suggest?


>
>> +Similarly to other nested devlink instance relationships, devlink lock of
>> +the shared instance should be always taken after the devlink lock of PF.
>> diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
>> index 35b12a2bfeba..f7ba7dcf477d 100644
>> --- a/Documentation/networking/devlink/index.rst
>> +++ b/Documentation/networking/devlink/index.rst
>> @@ -68,6 +68,7 @@ general.
>>     devlink-resource
>>     devlink-selftests
>>     devlink-trap
>> +   devlink-shared
>>  
>>  Driver-specific documentation
>>  -----------------------------
>

