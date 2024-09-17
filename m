Return-Path: <linux-rdma+bounces-4976-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3040797AAB9
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2024 06:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005C3B2206A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Sep 2024 04:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5640D381D5;
	Tue, 17 Sep 2024 04:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="JPVMFEZX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F6E20EB;
	Tue, 17 Sep 2024 04:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726546806; cv=none; b=TN4MFsnhy8dX5Bc5+riOZMHg58s7IEA1bJ0UMgZppkeGxcUF8dkluY2IwsOHuLK7WLVo/z8JfTym6u5B6j9SorEdL8ZicUhQYeQfx0PZzIRIC3o76tTg7rLZHAncFxcb9pjknchdggctZ2B2Uwsu1M0p1ie2D049Izypyabv8cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726546806; c=relaxed/simple;
	bh=NNruu2rRJmBusbp23E3Jox6mmHkmpuxQt3+youoOL4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uv6Knbv1Z7a+e9pXOGr+0/h4lToWSP6KAqVQ4aSSLav5W2xumGDYIa4nS2oUn/j6KDSDSRZizfFbwxz8hznkVEz0WQw08tPdUypWo4/61qeAZQ5w9mUHQUQPeiDmSF/SvT8I0UOEA7ID+D1jaMFWdEz0N064hXFXBgjOU31vnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=JPVMFEZX; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48H4JWgC003995
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 17 Sep 2024 06:19:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726546778; bh=ih6ilAYP6GVlay1n2G2rK3g/+S5tedQG2u0VH6+8pzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JPVMFEZXuwvGGEsEjluS8Fm6PcXe6sNWBO/uNHhNnG6dCZ497dLKfhoE+4A+keCpG
	 xWazE2UtguJHvBIk5lkqy4oty22T1AsT+Ys3s1sjjly1IlVqA4wZxOQYl4QtuVEDaD
	 a+puGurjj2YqGEtjj7AjMz5YRBNGGLgD5kumnbIY=
Message-ID: <1ad0402c-9c6a-44bc-9776-cb02c8e55a87@ans.pl>
Date: Mon, 16 Sep 2024 21:19:29 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] mlx4/mlx5: {mlx4,mlx5e}_en_get_module_info
 cleanup
To: Gal Pressman <gal@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Yishai Hadas <yishaih@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org
References: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
 <12092059-4212-44c5-9b13-dc7698933f76@nvidia.com>
 <8a0c724e-d2fb-4ae6-bf5d-74bbd0a7581b@ans.pl>
 <55ffb761-170b-4a1c-8565-7e6f531d423c@nvidia.com>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <55ffb761-170b-4a1c-8565-7e6f531d423c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16.09.2024 at 01:44, Gal Pressman wrote:
> On 16/09/2024 10:30, Krzysztof Olędzki wrote:
>> On 16.09.2024 at 00:16, Gal Pressman wrote:
>>> Hi Krzysztof,
>>
>> Hi Gal,
>>
>> Thank you so much for your prompt review!
>>
>>> On 12/09/2024 9:38, Krzysztof Olędzki wrote:
>>>> Use SFF8024 constants defined in linux/sfp.h instead of private ones.
>>>>
>>>> Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look
>>>> as close as possible to each other.
> 
> mlx4 and mlx5 don't necessarily have to be similar to each other.

Agreed, however it was not a random goal. My motivation was that since
the functions are doing exactly the same thing, it would be beneficial
for them to look the same, so if more changes are needed in the future,
it should be easier to make them.

Here is BTW the diff between them after all the changes:

-static int mlx4_en_get_module_info(struct net_device *dev,
-                                  struct ethtool_modinfo *modinfo)
+static int mlx5e_get_module_info(struct net_device *netdev,
+                                struct ethtool_modinfo *modinfo)
 {
-       struct mlx4_en_priv *priv = netdev_priv(dev);
-       struct mlx4_en_dev *mdev = priv->mdev;
+       struct mlx5e_priv *priv = netdev_priv(netdev);
+       struct mlx5_core_dev *dev = priv->mdev;
        int ret;
-       u8 data[4];
+       u8 data[4] = {0};

        /* Read first 2 bytes to get Module & REV ID */
-       ret = mlx4_get_module_info(mdev->dev, priv->port,
-                                  0 /*offset*/, 2 /*size*/, data);
+       ret = mlx5_query_module_eeprom(dev,
+                                      0 /*offset*/, 2 /*size*/, data);
        if (ret < 2)
                return -EIO;

@@ -2057,7 +1932,7 @@
                modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
                break;
        default:
-               netdev_err(dev, "%s: cable type not recognized: 0x%x\n",
+               netdev_err(priv->netdev, "%s: cable type not recognized: 0x%x\n",
                           __func__, data[0]);
                return -EINVAL;
        }
@@ -2065,113 +1940,715 @@
        return 0;
 }


> 
>>>> Simplify the logic for selecting SFF_8436 vs SFF_8636.
> 
> This commit message reflects my main issue with this patch, patches
> should be concise, this patch tries to achieve (at least) three
> different things in one.

Fair. So, what we really have here:
 1. Use SFF8024 constants defined in linux/sfp.h instead of private ones.
 2. Simplify the logic for selecting SFF_8436 vs SFF_8636
 3. Improving coding style
 4. Adding extra logging in mlx4_en_get_module_info(), which is also what mlx5e_get_module_info() does.
 5. Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look as close as possible to each other.

As requested, I'm splitting mlx4 vs mlx5 changes into separate patches
Could you please advise if it is OK for them to cover all of the above
*as long as I correctly capture this in the description*, or should
I split them even more?

Perhaps 1+2 (x2: mlx4+mlx5), 4, 3+5 (mlx4+mlx5) - so 5 total?
 
>>>>
>>>> Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
>>>> @@ -2029,33 +2030,35 @@ static int mlx4_en_get_module_info(struct net_device *dev,
>>>>  
>>>>  	/* Read first 2 bytes to get Module & REV ID */
>>>>  	ret = mlx4_get_module_info(mdev->dev, priv->port,
>>>> -				   0/*offset*/, 2/*size*/, data);
>>>> +				   0 /*offset*/, 2 /*size*/, data);
>>>
>>> Why?
>>
>> I tried to be consistent with the other places, some examples:
>> fw.c:   err = mlx4_cmd(dev, mailbox->dma, 0x01 /* subn mgmt class */,
>> en_tx.c:                                                0, 0 /* Non-NAPI caller */);
>>
>> Would you like me to drop this part of the change?
> 
> I didn't see the commit message mention anything about changing coding
> style.

My bad. I assumed it was a minor thing that would be fine to be just added there and
does not require additional comments. Will address in v2.

>>
>>>
>>>>  	if (ret < 2)
>>>>  		return -EIO;
>>>>  
>>>> -	switch (data[0] /* identifier */) {
>>>> -	case MLX4_MODULE_ID_QSFP:
>>>> -		modinfo->type = ETH_MODULE_SFF_8436;
>>>> +	/* data[0] = identifier byte */
>>>> +	switch (data[0]) {
>>>> +	case SFF8024_ID_QSFP_8438:
>>>> +		modinfo->type       = ETH_MODULE_SFF_8436;
>>>>  		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>>>>  		break;
>>>> -	case MLX4_MODULE_ID_QSFP_PLUS:
>>>> -		if (data[1] >= 0x3) { /* revision id */
>>>> -			modinfo->type = ETH_MODULE_SFF_8636;
>>>> -			modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>>>> -		} else {
>>>> -			modinfo->type = ETH_MODULE_SFF_8436;
>>>> +	case SFF8024_ID_QSFP_8436_8636:
>>>> +		/* data[1] = revision id */
>>>> +		if (data[1] < 0x3) {
>>>> +			modinfo->type       = ETH_MODULE_SFF_8436;
>>>>  			modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>>>> +			break;
>>>>  		}
>>>> -		break;
>>>> -	case MLX4_MODULE_ID_QSFP28:
>>>> -		modinfo->type = ETH_MODULE_SFF_8636;
>>>> +		fallthrough;
>>>> +	case SFF8024_ID_QSFP28_8636:
>>>> +		modinfo->type       = ETH_MODULE_SFF_8636;
>>>>  		modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>>>>  		break;
>>>> -	case MLX4_MODULE_ID_SFP:
>>>> -		modinfo->type = ETH_MODULE_SFF_8472;
>>>> +	case SFF8024_ID_SFP:
>>>> +		modinfo->type       = ETH_MODULE_SFF_8472;
>>>>  		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
>>>>  		break;
>>>>  	default:
>>>> +		netdev_err(dev, "%s: cable type not recognized: 0x%x\n",
>>>> +			   __func__, data[0]);
>>>
>>> 0x%x -> %#x.
>>
>> Ah, sure.
> 
> Continuing my previous comment, I didn't see the commit message mention
> anything about adding new prints.

Right, will also fix in v2. My [apparently incorrect] assumption was that since
we have it in mlx5e_get_module_info(), simply saying "Make mlx4_en_get_module_info() and
mlx5e_get_module_info() to look as close as possible to each other." would be sufficient.

I agree I should have called it explicitly.

Thanks,
 Krzysztof


