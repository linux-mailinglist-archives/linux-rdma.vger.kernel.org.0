Return-Path: <linux-rdma+bounces-3806-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A613292D7E4
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 19:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62807281D0A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 17:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B201957F2;
	Wed, 10 Jul 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cazk+EWz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477151953BE
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720634357; cv=none; b=dYktKYwrnYuQhzRdon5dLtGEFRsAFjDMF6Xy8YElt+F9v90g3i0rx+J8OfyHVGJig7n/VYo8PXf3SZ7ZgA6B/OsvgQcLgfvlR/dlGIFKIwvWF7faOSRhhpSya8nX6uTEyTFVB/tpW9KilP1Oj+0llRew9YAurAjdDn63HY7P+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720634357; c=relaxed/simple;
	bh=Z67qO39yjatOi34BBGV4sj5Yeejib38x3BMQVUB2kds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEMuLkkkuQdBy1Q5HdDPFwjhxADvysoRtCbwTWTIQ7+GOq4VP8FGIvkzV821G4W0DOqvKEG8L718j3UKPGZrBg5LesTvv7uSju+lErg9pOhnzX3cLs0J/SlSV3uxGX8e0nafFjd3LlPp8Vj2Zr3rsFURBwArOFwnL6CE4P5IKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cazk+EWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8872C32781;
	Wed, 10 Jul 2024 17:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720634356;
	bh=Z67qO39yjatOi34BBGV4sj5Yeejib38x3BMQVUB2kds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cazk+EWz4ddDXjHaTT81Yz9b25AdzNABNwgO6ViItQ/5rRVCDrREIMV03Rc0dAhm/
	 RqmxLR14kuU03edDG4P4YRwgbwHL8ib2nl1hILP+fyWDw/5OUouZJFNw6uhwUkBOPP
	 f6ois5LoUYrlGjPIEIS97syPVFwhK/BhZf4bOiP4O6iRYDfnMrX4k0yzwnE6qX5MR0
	 7cbSPFIi7SGoEmNTKc29fzbiw/3Ldpk3gzhMtU2JvNymxB+E6dX395w1IHV3Ta3WLz
	 FcBMWTh8l8quTHhXslOXe52fyH8nxFTQ0ZSfCQgPdFXXzTmiQmdfanMUHMHycZkT5F
	 EBoGckVkL+JIw==
Message-ID: <4f38320c-22e4-403e-8d68-ce04e504cedc@kernel.org>
Date: Wed, 10 Jul 2024 10:59:15 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA: Fix netdev tracker in ib_device_set_netdev
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca
References: <20240709214455.17823-1-dsahern@kernel.org>
 <20240710060929.GI6668@unreal>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240710060929.GI6668@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/24 12:09 AM, Leon Romanovsky wrote:
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index 55aa7aa32d4a..7ddaec923569 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -2167,7 +2167,7 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
>>  	}
>>  
>>  	if (old_ndev)
>> -		netdev_tracker_free(ndev, &pdata->netdev_tracker);
>> +		netdev_put(old_ndev, &pdata->netdev_tracker);
> 
> It should stay netdev_tracker_free() and not netdev_put(). We are
> calling to __dev_put(old_ndev) later in the function.
> 

missed that and KASAN and refcount debugging did not complain ...

Anyways, why have the 2 split apart? ie., why not remove the __dev_put
and just do netdev_put here? old_ndev is not needed in between calls.
Asymmetric calls like this are always confusing.


