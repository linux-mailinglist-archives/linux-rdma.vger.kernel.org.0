Return-Path: <linux-rdma+bounces-12635-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B88CB1F449
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Aug 2025 12:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989753A6B56
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Aug 2025 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C63D26D4D4;
	Sat,  9 Aug 2025 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qkWWr+5F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-78.smtpout.orange.fr [80.12.242.78])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4099186E2D;
	Sat,  9 Aug 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754737160; cv=none; b=PJfVu6q4f9r0zVqpKfuRJ1fASnJGJfVqbU/d4Lar/9zqBhvVW+cCizWSOseuEd6R1veuB8vD0jtBlk/NbsY804ydMSx7yTADb5QGPqCt3m1LpiDylWoIUGmkpccXRU0nYkvPZgpSiVM5U/CDsuHPFQHUwwTXSKJCLs3WOxXcBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754737160; c=relaxed/simple;
	bh=aEBAJo6GU7hqra0E8lreqOsmPp5tWoSDoSmg9CwKSEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENusuRiPqnUj2rXxaAPJLiSqu1/ycizua3bWkg8RRRAgGvWzFD3KZ7lScUeSRW+boPTCJ5/gGB6s5yPKn/YQLlCDzYr81sZftOr7cPV0f6RExgTKejoM3JP2ThBYznUpaVCrbBJEuOP24Ghbe7oLS3SX7h3byGdg/TdAYaTpjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qkWWr+5F; arc=none smtp.client-ip=80.12.242.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id khH2unzT9eRX6khH2uto6O; Sat, 09 Aug 2025 12:58:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1754737087;
	bh=xA42f4aO7DFUZsQX7jAiZ0ePwTc8RgtUXdvfcDF/Z1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=qkWWr+5FMk685FQCGu6Ps4GDH5FnGrDZnQQLTgMjmsvRVtNWL0MFIzWsL0b1+YYy+
	 c1EL6jXiSXf+1iZAh6gxpVG7nbru0h3ZGi1r3Wrxl0CEK0+YkvmYcMCDotrHV+pmfg
	 GEldkOqoPvwpmWwUol9m/xaH18RrxZZ4KOZ7mGzGJv871lQS4BjDg4zjUFtDKYBA6n
	 A0DDiDSnM97W9RncWQ0SVBQVAf4guMOy5jSJpqdx8iFNNKHeJ2pX52RIc4rdcqbHy/
	 hn+fpuLk0Rzs8cA8pWce4mqg0C80QdVNVFaqrnoIvtLHrDAiIh3r3WBkz5vQU2nebB
	 6Y1wNAsaZcByA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 09 Aug 2025 12:58:07 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <0a5b8931-6f0e-497f-aea9-e1c77bfed027@wanadoo.fr>
Date: Sat, 9 Aug 2025 12:58:04 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] net: ionic: Create an auxiliary device for rdma
 driver
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: allen.hubbe@amd.com, nikhil.agarwal@amd.com, davem@davemloft.net,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 shannon.nelson@amd.com, brett.creeley@amd.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca,
 leon@kernel.org, andrew+netdev@lunn.ch
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-2-abhijit.gangurde@amd.com>
 <7044823e-c263-4789-b83c-ecb1eccde04f@wanadoo.fr>
 <7393e875-9e7b-929a-a999-2b5e23230da4@amd.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <7393e875-9e7b-929a-a999-2b5e23230da4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/08/2025 à 10:14, Abhijit Gangurde a écrit :
> 
> On 8/2/25 02:45, Christophe JAILLET wrote:
>> Le 23/07/2025 à 19:31, Abhijit Gangurde a écrit :
>>> To support RDMA capable ethernet device, create an auxiliary device in
>>> the ionic Ethernet driver. The RDMA device is modeled as an auxiliary
>>> device to the Ethernet device.
>>
>> ...
>>
>>> +static DEFINE_IDA(aux_ida);
>>> +
>>> +static void ionic_auxbus_release(struct device *dev)
>>> +{
>>> +    struct ionic_aux_dev *ionic_adev;
>>> +
>>> +    ionic_adev = container_of(dev, struct ionic_aux_dev, adev.dev);
>>> +    kfree(ionic_adev);
>>> +}
>>> +
>>> +int ionic_auxbus_register(struct ionic_lif *lif)
>>
>> The 2 places that uses thus function don't check its error code.
> 
> For the eth driver, RDMA functionality is optional hence return code was 
> missed. Although devlink parameter to control this is not included in 
> this series, where it needs return value from this function. Till that 
> point, I'll make it return void.

Don't bother with it.
If it is planned to be used later, I think it is fine to leave it as-is. 
This will save you some work.

Just ignore my comment.

CJ

