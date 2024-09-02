Return-Path: <linux-rdma+bounces-4706-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0348F968C76
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 18:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DE51F22F9C
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FA41AB6C4;
	Mon,  2 Sep 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzUQJ/qO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDA018028;
	Mon,  2 Sep 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296119; cv=none; b=l9sxNYFCeeHKlkkxJA9WdJanPPqFDxYdUl1F8ni+RCrSHmUgW1e2EAioftIaa4BPrZVvlxVvNtqbxW2zRlE7dI5SHcGgy1LwQrjjPctNWET7ZDbePYa4q3bw8rHSBiJ0J0FWFOIT6YCtgHASf8178C6t6rXxLAjfxGX8MvJsTnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296119; c=relaxed/simple;
	bh=vdKmsuiLWAtPi6mgeRnngxz9TDYvaNZXxSxv0hxtzHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOhFs9BqKb1tcqV6mZZ1yzXPXDJ29dTDEn1cuc8W08mHc5Jc7BEcsuNijKAhyjguUoAuD8P02iDeEKFUIUMXmI74mlz1dBFHxut2/fPXCbSpGwbKFvgpKT8XrmSiFyWK7oTBJlUqPH3CCeZ/MlyWWTi9KnOsglNM7V8Q65NN5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzUQJ/qO; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a2a035b38so140417639f.0;
        Mon, 02 Sep 2024 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725296117; x=1725900917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQpcGGGmni0rMkMdSXEIUZwzleat0QK4FK0n4cA4aGE=;
        b=XzUQJ/qO4z0QYzgwLqdAmsFA/CB4P+SMg5KJDEfHl3zdChRVcYDCWuogZ/eKA+28Z9
         KOVfhWFSV3wkntPrAypvSyxEpuwPnd4YtEt3q2We+oV1Gq+dx9TW5gUcoSD1qJkPp5do
         CeYTZl/BExn5NhYYyAYz7YMK6btWU87c5DPNqaqXW4yrzRFWI+oieeLaXm1St02+c6Gt
         OFHkpPkl41i3fyyYsGOGNY6k58XRYPlLIzNuMocjE9/U0Rjipq+JTjnezgVKky8QbqHv
         vZSYxliw0b6UpdVNes0JjbmdZjijKU14UqNLNUfqOuB0U2viaVxQ8ayUAU32H/lerZr6
         tGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296117; x=1725900917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQpcGGGmni0rMkMdSXEIUZwzleat0QK4FK0n4cA4aGE=;
        b=vjQY8KyXW024oxN0aI4kKhyASTsIaLyFTwBvtdZtlHQEV0iPwq+e75Cx7a27Sjukqt
         LSxN/5mOW48vEBd/76hVwuiIblNDvYoBg4yVwk2ZRRdZp3SOIegr4gnNjdXgeIJcNFAb
         ImbN+GFWj7RZZujgUuF0QvDTDb6kmFQkJQW0byIeNJ5b2O8W0G1hS1AiL7DJzZaVVZR2
         z6ZXn4LK4xiuB2uo6zk+QtOwrQWkZ7sQYmLTagjRG+p96feyMKUHNcV+0O0z8/T32sJm
         9yVPeQkvnsiWNr3b6MFYYCTIJxHijcMTmUX+5xVVYkHesNUh7mYgzfdW+Q9hwrWCmHxi
         NrrA==
X-Forwarded-Encrypted: i=1; AJvYcCUNr2Apvuc89Cjw4LZ59urttYaZaTlTBSrwL2Kh8UOE7jWrhljQUh0S96oRRMNjrTANYmQ0fZF2@vger.kernel.org, AJvYcCX7KI+HPAJwI0l9OAZBYySN6JkcjNvm+U884RANwEDZDMFwzkOPZoXnBunqwYW9H55DgmVD55y4gLBD@vger.kernel.org
X-Gm-Message-State: AOJu0YxfFuMEw8Sqgnwhdb38NURvy/AspS10lyZBptDCn/Spr6U1R7U6
	3W+mv2TYQUr1o0BMmSzCEZGzFZ7xrEKMrlzC9Xincl2iDjyNEdf8
X-Google-Smtp-Source: AGHT+IEjHUBSQGk/7bddN0FuNfJIxYEsda/72zuex6LN9wGlFDYbyXDc9IMD2PDa7QzKE+8L2eWcwQ==
X-Received: by 2002:a05:6602:619a:b0:806:31ee:132 with SMTP id ca18e2360f4ac-82a36ecf496mr944493239f.4.1725296117361;
        Mon, 02 Sep 2024 09:55:17 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:1009:3a3e:c395:f649? ([2601:282:1e02:1040:1009:3a3e:c395:f649])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4ced2e96321sm2211100173.96.2024.09.02.09.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 09:55:16 -0700 (PDT)
Message-ID: <8e652f69-78d0-40f0-a712-60ef8733cf29@gmail.com>
Date: Mon, 2 Sep 2024 10:55:15 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC iproute2-next 2/4] rdma: Add support for rdma monitor
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: Michael Guralnik <michaelgur@nvidia.com>, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Chiara Meiohas <cmeiohas@nvidia.com>
References: <20240901005456.25275-1-michaelgur@nvidia.com>
 <20240901005456.25275-3-michaelgur@nvidia.com>
 <cad1d443-ccfb-4d10-ac2d-26bb10c99d05@gmail.com>
 <20240902075426.GD4026@unreal>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240902075426.GD4026@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/24 1:54 AM, Leon Romanovsky wrote:
> On Sun, Sep 01, 2024 at 08:22:50PM -0600, David Ahern wrote:
>> On 8/31/24 6:54 PM, Michael Guralnik wrote:
>>> $ echo 4 > /sys/class/net/eth2/device/sriov_numvfs
>>> [NETDEV_ATTACH]	dev 6 port 2 netdev 7
>>> [NETDEV_ATTACH]	dev 6 port 3 netdev 8
>>> [NETDEV_ATTACH]	dev 6 port 4 netdev 9
>>> [NETDEV_ATTACH]	dev 6 port 5 netdev 10
>>> [REGISTER]	dev 7
>>> [NETDEV_ATTACH]	dev 7 port 1 netdev 11
>>> [REGISTER]	dev 8
>>> [NETDEV_ATTACH]	dev 8 port 1 netdev 12
>>> [REGISTER]	dev 9
>>> [NETDEV_ATTACH]	dev 9 port 1 netdev 13
>>> [REGISTER]	dev 10
>>> [NETDEV_ATTACH]	dev 10 port 1 netdev 14
>>>
>>
>> at a minimum the netdev output can be device names not indices; I would
>> expect the same for IB devices (I think that is the `dev N` in the
>> output) though infrastructure might be needed in iproute2.
> 
> I understand the request and it is a good one for the users of the tool.
> 
> However, we will need to remember that "real" users of this monitoring
> UAPI (from kernel side) are the orchestration tools and they won't care
> about the names, but about the IDs, which won't be used in rdmatool.
> 

That's a big assumption.

It is trivial to convert indices to names, so this can be readable for both.

