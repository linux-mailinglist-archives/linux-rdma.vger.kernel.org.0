Return-Path: <linux-rdma+bounces-4959-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D6979C09
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 09:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3DC1F234CD
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2024 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63C284D34;
	Mon, 16 Sep 2024 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="UCXP/s8y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55FF3BBF2;
	Mon, 16 Sep 2024 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471880; cv=none; b=Una7cHeGqZpR2o+3I2710Tyg3u14bu6b+FMxdLdprnsmhCHSYf4y7DMAge2az8KPbVXJrLXhuermrmxarHjwWdIoeJjoJl5hid0YiMH11Fu9DNB+4SBxtLj621SNHJJlZHBBtSpgfPdTx28w2pUeXfxM288+Omn0ZowjoqA/Q2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471880; c=relaxed/simple;
	bh=wV66XkjyTpNkoyeZotLMXVvkLUdot/azOFZS/uyvFPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5A/1rqhniUFwmSEWlsrQhuzPw+IhZB0NbyjZbP2JCobZS1PwTL83DncD5NoV5xPq/pbM/eZ4XbkSaDf85vfBvZkBGuTt8GTk/9Xg301ESpGPhqNKtkzKZxtlBS3YvZhwSkpuxkFq1HEc6vN/NaDRS9K1NedPO7DeiVk3SBKt8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=UCXP/s8y; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48G7UYZu003300
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 16 Sep 2024 09:30:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726471838; bh=cvEij/gxRFLQnCrhRknoRQ0KgLrD/8wzAdDGvVBA6n8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UCXP/s8yM49QZEtgFguI9l90H7S1RtqcYtM0wu2fLJwWmmPRrPKV84uEFWW6nf3G2
	 gLvXQwfA93EahggDJJIQEp8/VET+/bNdjFPWvCtFmlu3W1s82MWusw4LksCqIygLwk
	 MOkUjRjEPQriy3brBVtVqWG7yyR7QYr3znGUlDps=
Message-ID: <8a0c724e-d2fb-4ae6-bf5d-74bbd0a7581b@ans.pl>
Date: Mon, 16 Sep 2024 00:30:32 -0700
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
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <12092059-4212-44c5-9b13-dc7698933f76@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16.09.2024 at 00:16, Gal Pressman wrote:
> Hi Krzysztof,

Hi Gal,

Thank you so much for your prompt review!

> On 12/09/2024 9:38, Krzysztof Olędzki wrote:
>> Use SFF8024 constants defined in linux/sfp.h instead of private ones.
>>
>> Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look
>> as close as possible to each other.
> 
> Please split mlx4 and mlx5 changes to two patches.

Sure, will do.

>> Simplify the logic for selecting SFF_8436 vs SFF_8636.
>>
>> Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
>> ---
>>  .../net/ethernet/mellanox/mlx4/en_ethtool.c   | 33 ++++++++++---------
>>  drivers/net/ethernet/mellanox/mlx4/port.c     |  9 ++---
>>  .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 28 +++++++++-------
>>  .../net/ethernet/mellanox/mlx5/core/port.c    |  9 ++---
>>  include/linux/mlx4/device.h                   |  7 ----
>>  include/linux/mlx5/port.h                     |  8 -----
>>  6 files changed, 44 insertions(+), 50 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
>> index cd17a3f4faf8..4c985d62af12 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
>> @@ -40,6 +40,7 @@
>>  #include <net/ip.h>
>>  #include <linux/bitmap.h>
>>  #include <linux/mii.h>
>> +#include <linux/sfp.h>
>>  
>>  #include "mlx4_en.h"
>>  #include "en_port.h"
>> @@ -2029,33 +2030,35 @@ static int mlx4_en_get_module_info(struct net_device *dev,
>>  
>>  	/* Read first 2 bytes to get Module & REV ID */
>>  	ret = mlx4_get_module_info(mdev->dev, priv->port,
>> -				   0/*offset*/, 2/*size*/, data);
>> +				   0 /*offset*/, 2 /*size*/, data);
> 
> Why?

I tried to be consistent with the other places, some examples:
fw.c:   err = mlx4_cmd(dev, mailbox->dma, 0x01 /* subn mgmt class */,
en_tx.c:                                                0, 0 /* Non-NAPI caller */);

Would you like me to drop this part of the change?

> 
>>  	if (ret < 2)
>>  		return -EIO;
>>  
>> -	switch (data[0] /* identifier */) {
>> -	case MLX4_MODULE_ID_QSFP:
>> -		modinfo->type = ETH_MODULE_SFF_8436;
>> +	/* data[0] = identifier byte */
>> +	switch (data[0]) {
>> +	case SFF8024_ID_QSFP_8438:
>> +		modinfo->type       = ETH_MODULE_SFF_8436;
>>  		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>>  		break;
>> -	case MLX4_MODULE_ID_QSFP_PLUS:
>> -		if (data[1] >= 0x3) { /* revision id */
>> -			modinfo->type = ETH_MODULE_SFF_8636;
>> -			modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>> -		} else {
>> -			modinfo->type = ETH_MODULE_SFF_8436;
>> +	case SFF8024_ID_QSFP_8436_8636:
>> +		/* data[1] = revision id */
>> +		if (data[1] < 0x3) {
>> +			modinfo->type       = ETH_MODULE_SFF_8436;
>>  			modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>> +			break;
>>  		}
>> -		break;
>> -	case MLX4_MODULE_ID_QSFP28:
>> -		modinfo->type = ETH_MODULE_SFF_8636;
>> +		fallthrough;
>> +	case SFF8024_ID_QSFP28_8636:
>> +		modinfo->type       = ETH_MODULE_SFF_8636;
>>  		modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>>  		break;
>> -	case MLX4_MODULE_ID_SFP:
>> -		modinfo->type = ETH_MODULE_SFF_8472;
>> +	case SFF8024_ID_SFP:
>> +		modinfo->type       = ETH_MODULE_SFF_8472;
>>  		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
>>  		break;
>>  	default:
>> +		netdev_err(dev, "%s: cable type not recognized: 0x%x\n",
>> +			   __func__, data[0]);
> 
> 0x%x -> %#x.

Ah, sure.

>>  		return -EINVAL;
>>  	}
>>  
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
>> index 4e43f4a7d246..6dbd505e7f30 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/port.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/port.c
>> @@ -34,6 +34,7 @@
>>  #include <linux/if_ether.h>
>>  #include <linux/if_vlan.h>
>>  #include <linux/export.h>
>> +#include <linux/sfp.h>
>>  
>>  #include <linux/mlx4/cmd.h>
>>  
>> @@ -2139,12 +2140,12 @@ int mlx4_get_module_info(struct mlx4_dev *dev, u8 port,
>>  		return ret;
>>  
>>  	switch (module_id) {
>> -	case MLX4_MODULE_ID_SFP:
>> +	case SFF8024_ID_SFP:
>>  		mlx4_sfp_eeprom_params_set(&i2c_addr, &page_num, &offset);
>>  		break;
>> -	case MLX4_MODULE_ID_QSFP:
>> -	case MLX4_MODULE_ID_QSFP_PLUS:
>> -	case MLX4_MODULE_ID_QSFP28:
>> +	case SFF8024_ID_QSFP_8438:
>> +	case SFF8024_ID_QSFP_8436_8636:
>> +	case SFF8024_ID_QSFP28_8636:
>>  		mlx4_qsfp_eeprom_params_set(&i2c_addr, &page_num, &offset);
>>  		break;
>>  	default:
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> index 4d123dae912c..12a22e5c60ae 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> @@ -32,6 +32,7 @@
>>  
>>  #include <linux/dim.h>
>>  #include <linux/ethtool_netlink.h>
>> +#include <linux/sfp.h>
>>  
>>  #include "en.h"
>>  #include "en/channels.h"
>> @@ -1899,36 +1900,39 @@ static int mlx5e_get_module_info(struct net_device *netdev,
>>  {
>>  	struct mlx5e_priv *priv = netdev_priv(netdev);
>>  	struct mlx5_core_dev *dev = priv->mdev;
>> -	int size_read = 0;
>> +	int ret;
> 
> Why did you rename this variable?

To be consistent with the mlx4 variant of this function and because it can be either
the size or the error code, so just "ret" looked better for me. Would you prefer
to keep it as size_read here but rename it in mlx4_en_get_module_info()?
 
>>  	u8 data[4] = {0};
>>  
>> -	size_read = mlx5_query_module_eeprom(dev, 0, 2, data);
>> -	if (size_read < 2)
>> +	/* Read first 2 bytes to get Module & REV ID */
>> +	ret = mlx5_query_module_eeprom(dev,
>> +				       0 /*offset*/, 2 /*size*/, data);
>> +	if (ret < 2)
> 
> This whole hunk is not needed.

You mean the rename? Again, I did this for the consistency between mlx4_en_get_module_info()
and mlx5e_en_get_module_info().
 
>>  		return -EIO;
>>  
>>  	/* data[0] = identifier byte */
>>  	switch (data[0]) {
>> -	case MLX5_MODULE_ID_QSFP:
>> +	case SFF8024_ID_QSFP_8438:
>>  		modinfo->type       = ETH_MODULE_SFF_8436;
>>  		modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>>  		break;
>> -	case MLX5_MODULE_ID_QSFP_PLUS:
>> -	case MLX5_MODULE_ID_QSFP28:
>> +	case SFF8024_ID_QSFP_8436_8636:
>>  		/* data[1] = revision id */
>> -		if (data[0] == MLX5_MODULE_ID_QSFP28 || data[1] >= 0x3) {
>> -			modinfo->type       = ETH_MODULE_SFF_8636;
>> -			modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>> -		} else {
>> +		if (data[1] < 0x3) {
>>  			modinfo->type       = ETH_MODULE_SFF_8436;
>>  			modinfo->eeprom_len = ETH_MODULE_SFF_8436_MAX_LEN;
>> +			break;
>>  		}
>> +		fallthrough;
>> +	case SFF8024_ID_QSFP28_8636:
>> +		modinfo->type       = ETH_MODULE_SFF_8636;
>> +		modinfo->eeprom_len = ETH_MODULE_SFF_8636_MAX_LEN;
>>  		break;
>> -	case MLX5_MODULE_ID_SFP:
>> +	case SFF8024_ID_SFP:
>>  		modinfo->type       = ETH_MODULE_SFF_8472;
>>  		modinfo->eeprom_len = ETH_MODULE_SFF_8472_LEN;
>>  		break;
>>  	default:
>> -		netdev_err(priv->netdev, "%s: cable type not recognized:0x%x\n",
>> +		netdev_err(priv->netdev, "%s: cable type not recognized: 0x%x\n",
> 
> Unrelated to this patch, but OK.

I assume you also want it to be "%#x"?

Thanks,
 Krzysztof


