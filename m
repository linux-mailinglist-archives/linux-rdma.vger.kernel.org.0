Return-Path: <linux-rdma+bounces-4971-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDEF97A626
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 18:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EB4284921
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 16:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70680158D8B;
	Mon, 16 Sep 2024 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="hFGc+dBL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CAC158A1F;
	Mon, 16 Sep 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726504700; cv=none; b=IBZ2RS6wPXQfntCLPgURMULAi4Q+Ia2g11uqY8hEaea3YNmmq7iMAmxm6fA07BxwEzkm+Q1nJ3+mj2IsGaNKn68Jxw2vzS8MCxUfxkynKO/k0H63NT2N+zQrjRo6I48Yz93ovXjt3j11zGh4oCV3gSgXIg9OzrIA4NxUW6Ip4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726504700; c=relaxed/simple;
	bh=dGxTv2gaT3Q7xiDlFELyes8E7cC0oDablyL8Nh0Cba8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1pZhYWrCFHIZrI0KoSY0ARb/LhriIRhiI/eV8d1jbLtucArWO4JzPuZS6EwhdPOo8ftvR/xfp+GXupU4Dy7MsIUzJ2mu+ksRR1V6g1ArcOOPFEkIwNXDNVjlCt7W9+0d70ErhCrvb/HYo7MfUK7BHHwzzoI7t9CK2KXLrP375g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=hFGc+dBL; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48GGbYwA031093
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 16 Sep 2024 18:37:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726504661; bh=HbubILUFQxsXkFofpq21I3CeytPToT3AZv0aCEpg4CU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hFGc+dBLhWw89E2XetJ2n2nkO1mcO3d646Zezs6krqb72tXKyV5vMfrepFcwf7lUo
	 O0TuBgne3cDx9iwzZ7OtF8OGgotSwGug68lcm5Ou4rIR/VhbGMbvMKP2aWBH0M7iXx
	 6L3NfMJHozr66EuYVQHvmXSw4xeWw6L0bFFG7Ntc=
Message-ID: <156f9ba7-7b85-46eb-9e70-606b0c4e0498@ans.pl>
Date: Mon, 16 Sep 2024 09:37:33 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] mlx4: Do not mask failure accessing page A2h
 (0x51)
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Tariq Toukan <tariqt@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
        Amir Vadai <amirv@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
References: <2aa0787e-a148-456e-b1b5-8f1e9785ed04@ans.pl>
 <8e5d257f-dc4e-44e9-96c8-7698451a71bb@intel.com>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <8e5d257f-dc4e-44e9-96c8-7698451a71bb@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16.09.2024 at 02:44, Przemek Kitszel wrote:
> On 9/12/24 08:41, Krzysztof Olędzki wrote:
>> Due to HW/FW limitation, page A2h (I2C 0x51) may not be available.
>> Do not mask the problem so the userspace can properly handle it.
>>
>> When returning the error to the userspace, use -EIO instead of
>> "err" because it holds MAD_STATUS.
>>
>> Fixes: f5826c8c9d57 ("net/mlx4_en: Fix wrong return value on ioctl EEPROM query failure")
>> Fixes: 32a173c7f9e9 ("net/mlx4_core: Introduce mlx4_get_module_info for cable module info reading")
>> Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
>> ---
>>   drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 2 +-
>>   drivers/net/ethernet/mellanox/mlx4/port.c       | 9 +--------
>>   2 files changed, 2 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
>> index 4c985d62af12..677917168bd5 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
>> @@ -2094,7 +2094,7 @@ static int mlx4_en_get_module_eeprom(struct net_device *dev,
>>   			en_err(priv,
>>   			       "mlx4_get_module_info i(%d) offset(%d) bytes_to_read(%d) - FAILED (0x%x)\n",
>>   			       i, offset, ee->len - i, ret);
>> -			return ret;
>> +			return -EIO;
> 
> here you are masking also all other explicit error paths of
> mlx4_get_module_info(), what is not good in general, I would instead
> mask below (see next comment)

I agree, for this reason mlx4_get_module_info() seems to be a much better choice.
Will update, thanks!

> 
>>   		}
>>   
>>   		i += ret;
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
>> index 1ebd459d1d21..8c2a384404f9 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/port.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/port.c
>> @@ -2198,14 +2198,7 @@ int mlx4_get_module_info(struct mlx4_dev *dev, u8 port,
>>   			  MLX4_ATTR_CABLE_INFO, port, i2c_addr, offset, size,
>>   			  ret, cable_info_mad_err_str(ret));
>>   
>> -		if (i2c_addr == I2C_ADDR_HIGH &&
>> -		    MAD_STATUS_2_CABLE_ERR(ret) == CABLE_INF_I2C_ADDR)
>> -			/* Some SFP cables do not support i2c slave
>> -			 * address 0x51 (high page), abort silently.
>> -			 */
>> -			ret = 0;
>> -		else
>> -			ret = -ret;
>> +		ret = -ret;
> 
> this is the only place that mlx4_get_module_info() returns non standard
> error code so, I believe, it's here where we want to overwrite with -EIO
> 
> then you could limit to just a single Fixes: tag (the second one)

Sure, I can handle it in mlx4_get_module_info(). I will also need to
cover the return from the call to mlx4_get_module_id() however.

Thanks,
 Krzysztof


