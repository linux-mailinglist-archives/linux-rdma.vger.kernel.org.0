Return-Path: <linux-rdma+bounces-10303-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D22B9AB3A96
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 16:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4188D860D9A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09574218AB9;
	Mon, 12 May 2025 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi5cKQKP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464B4A3C;
	Mon, 12 May 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060075; cv=none; b=ltkIKlzmSBpHXmUHdKPqDKtVDxe/M4yTspdX41SIvKMo9O+fb9Y8nLdRnBvPd6EH7SnAAEMLo7RhMvTCxybC4A84zCrVAyXeg7USk11WeYAZFRAVkVeE+58VFmWBgm8mRavTiAFAhnIaS0FI3vOwUfl/L7Cn2+qhIPmGX/rgMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060075; c=relaxed/simple;
	bh=wrYbJIgdDlhw9cxvmVJt4hGuLDKKXkSC6QXIYwjksdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/aJaZ9CUDY14XPiZLkgmUMBimcgrzoM3sU80czyOvoLTbltc2/ggh+P4weC3x40boEtry47Hk0EX6TMqkWbZKetI6jR7oZEiedGyC/LQLmqJTng9tq7VitCCsunUj4Gvb+0EbMIpuqNedBMR/v208TwOPujOldrTRlecNPq1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pi5cKQKP; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad243cdbe98so300182366b.0;
        Mon, 12 May 2025 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747060072; x=1747664872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqD5wGql76sXnlATbZ5iOStKuZGXz9IAXso+5X9hYxY=;
        b=Pi5cKQKP8nYho2NBBk1R6RBYSFPSrBCAuApy0F2+lPX9Wf0GzVGTfWGOsT+x72rCDk
         qkOGQqFtovvdh7tBuqmVUVngCW5G2XMOqgFXwyw0j/uPIvH1b5k74lsfEd1RTzEwZQfh
         shi3j1RuMnVwLn9TCjG7gvIyGcodcUBy671ZSBwqwhLdhrVHYh0vFVOlR+aCW+xGIIKE
         VmyzZF+M6gbACRQM4yiP5womAe7hpF4KYoXO0OOs5v7esmyLfgr+SBWmH8IGP0ZqNkGx
         BsmFKEN8tObVTdZtouIjrlQYatnyLFlQMGsNhtLs7XHDVyRJS79z6NK3N1VxUB8k+hZv
         nuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747060072; x=1747664872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqD5wGql76sXnlATbZ5iOStKuZGXz9IAXso+5X9hYxY=;
        b=AnxoRUnviMiw60UhxgIqiWCe7/wgBGOzdF0QsCGTFrZQDvWqSSU5K/18CxNxKAYmDd
         h+IZADYwypvNDgYl8HnJ5/zmqUxqwuTnCTvvxxuB8WnNMKsJb2Er3b6WaJG4k8k2VWva
         RHXY20ZyAiw4fLCeIX+x5xFZjirRg4pDpfcIA2eeMrccXvoSHCWLiHdCPnl7Pg9o8GG1
         lx1xgCUhql0lbdZhSxZkRAS+KM1nIVe2OKeiS04qWdlMMTmnrCLSlEBGlfPqsu1olvUX
         BHp2+SN6mphNudbkXeFPjM3HkACnHS5ULlQQHxqHTGubYGXrGrUjYveE5ojymTpDeVwg
         CXbA==
X-Forwarded-Encrypted: i=1; AJvYcCUzfVth/RUvAJ+tfXthfv/YiIPi8xEmVZSRbHQNPNL5EShy0XnFEzKkKABWNmiy4r5l1X3UUbQfnDr91FhC@vger.kernel.org, AJvYcCV0GX7rl+jvHwPFWLEqm7n3Qg0MhGOfMYx8auQeXgPbx9vZc74IYHqqg6nja9tIh6iXES3+OGl5xgY=@vger.kernel.org, AJvYcCVSQPzidtlKNviyBAxlGoObUBE1U3EfGBvvvi2YQ68B3lWX1Klunpw0BSmBaY1GBripv90FjXEF@vger.kernel.org, AJvYcCVvOSe02HEZnoY4ZrWIQX0Q14uVhU+U30i6vKFq+tKhVYF5u0uZJGypVW9foLZSZX85hKlNKCs4FIF8Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6yhVsyGYiyvR1ETZZwuVidvncFLQGoMtZlQvmHWg9Yp+getR
	Xg+ISF02WWPT+EOvgg51qri3ajadqi/atRK4BHouHqg9ZT0v6DnX
X-Gm-Gg: ASbGncs29iJJJiUHzDcR7HW92q/OGuYWUHA+SiKXTG9J35eP8U98dpxTy7BpfWzAMo3
	6SQ6xPzuw9CHfePoMcHQW3zHkynS66mMquKxWUXbhnAl4YBlU78R0c+z6JusqWf+MiCJAyOxTs6
	/C9d72DCStZ4uiUJ8dQs/bBe7QXRUiK5BA/sqDVCqEBfDde4cJifJz4a07oyJ42e52Ej1dNBSwA
	mZY3gpTj4UAsArDFjgScUjm/oqyUJCLzkCKTaBsxmOoJKltgqFniNoPjHdbVleI5YBO/v17kcGn
	twZAKB76SDJSjdXB2xUBML/nar522wuGKXPSHIQZvxR22O/fAaNDkbsnFTaDbwnaCfvT
X-Google-Smtp-Source: AGHT+IGj3fjTQReHuc5YhyvjBSiLTj9JvTTuTTRhjDoH1puY3E+pAcuTYhwFCamMNs47LPqZtpbz5g==
X-Received: by 2002:a17:907:3e12:b0:ad2:3bfc:232 with SMTP id a640c23a62f3a-ad23bfc9e4dmr749244266b.32.1747060071910;
        Mon, 12 May 2025 07:27:51 -0700 (PDT)
Received: from [10.80.1.87] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2290a4cc2sm516075966b.183.2025.05.12.07.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 07:27:51 -0700 (PDT)
Message-ID: <98386cab-11c0-4f74-9925-8230af2e65c8@gmail.com>
Date: Mon, 12 May 2025 17:27:48 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V9 1/5] devlink: Extend devlink rate API with
 traffic classes bandwidth management
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Donald Hunter
 <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Dragos Tatulea <dtatulea@nvidia.com>
References: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
 <1746769389-463484-2-git-send-email-tariqt@nvidia.com>
 <20250509081625.5d4589a5@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250509081625.5d4589a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/05/2025 18:16, Jakub Kicinski wrote:
> On Fri, 9 May 2025 08:43:05 +0300 Tariq Toukan wrote:
>> +  -
>> +    name:  devlink-rate-tc-index-max
>> +    header: uapi/linux/devlink.h
>> +    type: const
>> +    value: 7

Hi Jakub,

> 
> Ugh, still wrong, the user space headers don't have uAPI in the path
> when installed. They go to /usr/include/linux/$name.h
> But for defines "local" to the family you don't have to specify header:
> at all, just drop it.
> 
> And please do build tests the next version:
> 
> 	make -C tools/net/ynl/ W=1 -j
> 

Noted.

> I'm going to also give you a hint that my next complaint will be that
> there are no selftests in this series, and it extends uAPI.

I have some questions, looking for answers in an official source.

Most importantly, it is unclear to me when a selftest is required. What 
is the guideline?

Please point me to any guidance for this selftest requirement. Is it 
generic, or networking subsystem specific?

Let's make sure these things are well-defined, so we plan the extra 
effort accordingly in future features, and improve predictability.

I reviewed
Documentation/process/maintainer-netdev.rst
Documentation/dev-tools/testing-overview.rst
Documentation/dev-tools/testing-devices.rst
Documentation/dev-tools/kselftest.rst
but couldn't find all answers.

BTW, some sources like the webpage link 
https://kselftest.wiki.kernel.org/ in 
Documentation/dev-tools/kselftest.rst is marked "OBSOLETE CONTENT". 
Should be totally ignored?

Also, should the selftests require vendor-specific hardware to run? or 
they imply adding netdevsim implementation?

Regards,
Tariq


