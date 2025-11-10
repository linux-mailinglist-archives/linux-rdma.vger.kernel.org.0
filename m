Return-Path: <linux-rdma+bounces-14356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350C8C46C47
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 14:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D550E1881C3D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Nov 2025 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0802FE568;
	Mon, 10 Nov 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo3ZtH+P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0931AF4D5
	for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779963; cv=none; b=okXnuG9Flh4gKTFVdSVeD9EWDJBPL5UFP61YptyFpMNS1ZSMJ77omg6UrSQ1ueJVnsIleHwUeRap8VkSNQxG+zFCXynLWhcTh69y1RkYtYNxw7yQbrbBcFEjB8gwj2/FF4HPdsbBolL6zebzWZm554W9uveOMS1RsoTH/pUwW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779963; c=relaxed/simple;
	bh=tkAid+ncn0OiE3KRWyzpO3B2eBpJtoyCWaXJhHBI37I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRmlT00F9mmDpuPyCspnwcUrHEecOPuUgBcjfXCShlXQjVP0l3wN+BaueixAnSAo86rVT4XKYGkyXGK3qVnqpKQ82TKvzhRm0V2wevamsQsgpcq2ijFvwnO0NsutwTEqXk4RJ+pxs4cHgmfR/dpu6BXHRdpYqizJzzMpNaqUKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo3ZtH+P; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b22624bcdaso402554485a.3
        for <linux-rdma@vger.kernel.org>; Mon, 10 Nov 2025 05:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762779960; x=1763384760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YDJ2IN0Zya8uyamUgknQHfjkE1b693NA6xUsZI23zo=;
        b=Jo3ZtH+P71t3xp/24acBo7g98zfHwC+xAHdEj/p13u7XccEV9Qfga+Ml7DAfcc1kOA
         RbTiXDemn2AmSKnIBkjcJ+kAp3mlfZU6fEz8yU7zx4sdBnMiDVV+iH1S+Dr0B1Csdg6k
         zQJFhnqVwKVvH1ev5sVu3VAQNPUyaPD5247XhPGCmMNz1lkT+SpZUf9GQgR+/wW7QCH9
         Ztb7laGwULauKqIoN4y0lgCJcjr9lll3gxLHpeE9r+/K6UiOqTJGThQEvyoo9zDmK6gH
         3knhH9sDBHDq15tlC2I3ugq6rY9SnJpK0Kbb4w80ovltugXcSWjVK3uzfib/IBzxMWkG
         8ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779960; x=1763384760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YDJ2IN0Zya8uyamUgknQHfjkE1b693NA6xUsZI23zo=;
        b=N1OK1dZl/HqJQCbL9o17fhOPWP8D0ckoqF9bF+pbsH8IrFyjSCEmPfFaxRm8D+k/ze
         eFKHHRW5kS1Qw6HinkUDxEdq0BIBGOVkBY+zRl3Toh628SwSqDwmushbwqoXhpP20pRj
         XhDN1tqefwF54oQ6ER3B30pR//ZMNHiLfpA9BPklV03/HGZtTbpMEX8FfoFXRxnyGPdp
         L7b/WuYnmZpl6yQzaN1K0EDxED9lRaJZNTpmZkEBPKcgYmYZOLRuK6tDZA1UdsWuPa3M
         R00vVY3DKjMwXPZ13NHYZp+oBB4kw3LedZe28jrz/HJra+ee8DFaHHEtKknPXeuVTwqK
         VWGw==
X-Forwarded-Encrypted: i=1; AJvYcCXK/5RiOrA0oMRBijB/ovi26HbTE0EwbFxBewD3J1Erorw3Ree9vb/frPU5eicKNSRAiLEIaYsA92GF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Ous/8vQVz/ZALm5oS/v3+y8tUushFiAA20RvyU4Qu1RrLVxz
	c7XI8UEnxCl0LgI+uNJ4H7a7bKs73kWpXerNO7kh9JdqAQRuTjWScgfr
X-Gm-Gg: ASbGnct4LHPamPDaH1Mjb7CwkVS9VQXPR1sfFzjkcWMTzWcbBGh813o8Omr1ExlpPRc
	/Ryqc4jfOeKPNY825BlipnOAup8AobH6heJMqPc3AWfUA9a0VGOmN78skK+Oufx7FjoC8TcXQmR
	aexZ6x6lGv9jVPA9zL7MURcqVfwarMBWDjYH/9GZQxpysqQ7amJdT6xF1hSvKtJ2hSDuDOX2YsQ
	8kaAav+m8CG2z5IixatorNcY+z9uixtnjy4DQLk5g+x+4Z+kNn1A5sUJBS47ajtNajJ8BssnNhV
	Vix+bbe0qISNB5VlI29yW8Ix0OzLjwPV57sf7LsA9rX2VOGg3jJ5lRgwIoa8WOU/JxXSQENtQYe
	DKKemzSoqZWg846T6b1UmTLpKIeN1/T6B4F5F3gM+UBLuDtVFmfDOCGqAvkhPdBqBt8KpZECJpW
	MD17ClpwHVZW+wPJbc6k7+8qokAUxuGQ==
X-Google-Smtp-Source: AGHT+IHItn4s7icuGrWLzo0GYDNZ1tLgQrToLgg9q7HDTX1ld16PDLwn6BncR/yAsJAAE+zCLju5jQ==
X-Received: by 2002:a05:620a:31a5:b0:88d:125f:8b5c with SMTP id af79cd13be357-8b257f76fd0mr1053956585a.88.1762779960211;
        Mon, 10 Nov 2025 05:06:00 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:d8fa:5eb:c3a1:9f16? ([2620:10d:c091:500::4:ad9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355c20cfsm1010519285a.3.2025.11.10.05.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:05:59 -0800 (PST)
Message-ID: <25ebaf18-f009-45de-a3e4-fe440c42ef19@gmail.com>
Date: Mon, 10 Nov 2025 08:05:57 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Srujana Challa <schalla@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Manish Chopra <manishc@marvell.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Vladimir Oltean <olteanv@gmail.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Dave Ertman <david.m.ertman@intel.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
 <20251107204347.4060542-3-daniel.zahka@gmail.com>
 <mfuluoi4nebyc4avj52gkfs4nqikn6uwhqnkf4o6xfswtpceuq@zhpokcx6bb6l>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <mfuluoi4nebyc4avj52gkfs4nqikn6uwhqnkf4o6xfswtpceuq@zhpokcx6bb6l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/9/25 5:39 AM, Jiri Pirko wrote:
> Daniel, I asked twice if this could be a non-driver param. Jakub asked
> for clearer definition of this know in that context.
>
> Not sure why you are ignoring this :/
>

My apologies. I think there was a miscommunication. I assumed Jakub's 
question was directed towards you. I have no objection to making it a 
generic param; I will do so in v4. It sounded to me like Jakub was 
wanting more information on what exactly this setting does beyond what I 
was able to provide in the commit message and mlx5 devlink 
documentation. My understanding is that this setting pertains to tx 
csums and how the device expects the driver to prepare partial csums 
when doing tx cso. I don't really know more than that. Especially not 
something like what the FW's role in implementing this is.

