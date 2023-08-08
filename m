Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24244773C10
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjHHP7u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 11:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjHHP6R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 11:58:17 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DEB2703;
        Tue,  8 Aug 2023 08:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZdUKLzPkZvXfTfaKr+siFGw1vsZ+KMubbWW8+zacvWNfo4qtgjaNG96MyatyZ4Y7n6VdBT48LrjNfqqzka+AcEnaGJNv+U74p1E2+1wps6I0e4EN+vuyQyRQr2o4r+ch6tLMdMT+eRqaRdY4b+HfpPkD1WbAo6updmiY8jHZzLgL8zHa38CJIvsHA950w7Pb4f3fyUTTxcSgravudRxgEJukb+yrB+vRzmNtF+bYc8cn6pHmnqJpr/HltNGkgeL+Zn9dcrH1lAJ36qgnKHzkbK2y7GbyPlV9J2tfuzpBcMlGpZ2Qa4OS0tExtG5nQsEkvYqQqk3cVWtuGZm9LYSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N12KerHdu1ydYS1SiMV7LxAfl8IAef5F8oDw90Umk+I=;
 b=FsbZKcAF3yN2rWs9yvkTrI8Ga3ny2ZhyaKB78QE++p6opX3LeS2gMH5QXUHNI8DAk/haZbSlSobFh2uqvBzH5TOjP9PZTaLVsUcoYxjhcOP5v0U3EFS92TC32XzBoqcOak2DAfsaVkMfhUq8OTDpDWD5BDdL06SvoMoJW1m0/J5Ni1PQikp9PAdmcjnm/T+qLRFI7ksHu5W7BEpltjRw0Vc9AMSGTi+SC8c7G2+zKqyDifeHvFJ3dO0E+Ni7ccrUtF5Gq9O1cBYhTUH3lJJvLN9m/Xcomtv30kwAkDmqPyPQbU5dzxphEfMT8P8j1+K7j+8cUSVrtCWoPH9iNExM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N12KerHdu1ydYS1SiMV7LxAfl8IAef5F8oDw90Umk+I=;
 b=5psEx+8WLW9yYB3+t2qFA4oZtB1R33+0uFdvtQI7c+27VI45LAfEUqiTTnKDmUW4d9lqS44wuwqyWCCYDAR0dzQ99XnPk38k2pForWA/it2o69J9qzz/x6N/8s3LvcIaPBypOReygl0gv4LfYyCsUsjEhKJ9Le5OPk9dmawSMySZAx3+kv11+pAgTGYoGiRhxJYvv7jO+TUNHq6KFQcv/hVzSXSWlXDxVQFnq2IGo6zJ9Wnvad4cFLDpO+8ARRjq5XAzipaxDsImSEajefq1p7siCGh8OkahAQQPf9vx6nLIqUJyG3jCx4IS1urEh3nIVXT0bXg2PAmkNmooBbHubQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AM8PR04MB8019.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 12:17:55 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::da23:cf17:3db5:8010]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::da23:cf17:3db5:8010%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 12:17:55 +0000
Message-ID: <b3c9f23c-71e5-bd2c-1574-119027636b15@suse.com>
Date:   Tue, 8 Aug 2023 14:17:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/10] mlx4: Register mlx4 devices to an
 auxiliary virtual bus
Content-Language: en-US
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, leon@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jgg@ziepe.ca, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-8-petr.pavlu@suse.com>
 <4479c1a6-6e9b-b3ff-fda8-b6ef9955637b@linux.dev>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <4479c1a6-6e9b-b3ff-fda8-b6ef9955637b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:803:1::23) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AM8PR04MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 779dd7e5-0728-4a67-cc3c-08db98097e9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /cVIt+okjc/LgdV6GX0jlp/LRgM6ArROeIizVElECWL8jntkZm2NII/wcoCpd2Hpy/DR3OcwMBlKRQntnjPi2zt2KUrI6Tl5W2mPDo3PImChMyZPeJskvw4e0jIe17xGbamLyYeeBDTdf9tFOXBImesUVSC4lxdirH9MpQXLoZinWsIpGBy/y+SJhsCnhC0UdgYuC5FJ0xM0Q5vyCksisogTSAIvG4W7ePl+0LfjETmPwFzXWwubE5poOIwNCLLozLnPqn4MznyXld8h7MtSBzlfk0iCI/KFUf212RGsqmiBGZmZFsPgPnWJQGqIE30b2zIayTKyHvGokr8gOEJKWCph3+h7xkPblrO0Ljko/mnGoEkDDE2guiSY/lIRKXc+9tij+28hcMESL+fwaZQsT7sHe46lBYeOVDZVlETheKC9QZXJHK1MHLn+a/y717WyMAI8eexR5Bh3oETPOI7TgL3OBGmB30qq1ylT6jUh3G/slQNpJUvRBkp0FpGBuuciWojgy4vUBpnjywjtXZ1nwTeeL4WZF/95ErtgaB814qKrmW7ijYYP+tjhqnM0WPm+sevUVLU16hrfm3VhMWDB0c7w487K51OEfhh7us0EjdEUF6/n+0gJuoKpCmJQ7lI1csP2jEfOSu1hYlTU1zZLQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(186006)(1800799003)(451199021)(41300700001)(26005)(2906002)(44832011)(5660300002)(83380400001)(31686004)(7416002)(8936002)(8676002)(2616005)(478600001)(6916009)(86362001)(6506007)(316002)(31696002)(53546011)(38100700002)(66556008)(66476007)(6486002)(66946007)(6512007)(4326008)(36756003)(55236004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3V6R2pRN1hhU1N2ME0rbERwRVNXelFqRzYrclAxQWRMU3hVVUpoMnJ1U0xp?=
 =?utf-8?B?VUJ1SElobHJZeXBXOXBDM1RrMVc1ampSb2xHVHJsWGtrZzBnT3hTZWVSUSsy?=
 =?utf-8?B?dWdWeC9hbjUwQkUwMmM1YUJ4UmMyNHpTTDhZY2QzaHdmak5leWVRZGFXUkor?=
 =?utf-8?B?djJDRkE0QkZXR1VWZmZoOGgwSklxbk00TDRNNkxQODFwSVk5SExvd0hCL2lZ?=
 =?utf-8?B?bUlyYnJOcVQ0MVpBbXVaR0VVbXhiMC9IUUxlZnNDNnBxYk5qcUlES1RhQlhp?=
 =?utf-8?B?RE90MXl4UDMzUEpMRHdIZFkrUE9TWkl3UVR6VW5iV2JwZTdBY1RsQlFNdy8w?=
 =?utf-8?B?OTVmd2lmaldLY3FCcVkyS0doMXA0UmtOVGtoZEQ5QmROaDhNK1JPbHpDWlIz?=
 =?utf-8?B?V2xqRHo2S1NuM3FVeHQyblNoeXo4VWpMSE42R3hmblRFZnBPeisrMlR3R3E3?=
 =?utf-8?B?ZiszZmJqSUlDS1EzeVVnMW16OWEwOWQ4MnlxSlV5ODUyYzJPOW9xU3R4aThN?=
 =?utf-8?B?YjlxbXByd3ZKSG9OMlhlYlpVZjJoRnFRSmJ3SVVtZ1c0QmtTWTdIRmtCYkor?=
 =?utf-8?B?VlFmMTFvM2RidnpzcnVTLzk2aHV3Qkd4aUZqSWZ4dzA0Wlp0MmluOXJzN3Vo?=
 =?utf-8?B?NjlDRTNzcU1Vb01oTnVZR3hsTGxZRFBydWlyRTBVcXRlQzFLMkp6YlRaazJD?=
 =?utf-8?B?bVpyK3JxWW5ZSUVIMTJGR2JVRGxlTmJwZmExTm5FdE05N1pUSEM0bmZLNjkx?=
 =?utf-8?B?UHFpSmkwS0pCQVBhWnV0WmNYU0p4cVRFcWl0di91MXBweW9Rd3lDV1JqeVpB?=
 =?utf-8?B?dW9HbmVkMmdmbUE4eUZORjkxODE5eENEckhOTEVTZlFKa1VkWGxPOXBWaEp3?=
 =?utf-8?B?Y3hJRUhwOXFMNXRzTW5MTmx6bnFCWlVzdHVuN3lVQXNFcXVVSDNOMnVocjRk?=
 =?utf-8?B?dDBzNlRwMktkUHRkMzhNNXRheVZjV0hoTUJMQ0tCZ0NrRHducEpHRGQwaUti?=
 =?utf-8?B?WUZOSU96ckk0cWZkUTBsNDhFNVRPb0F4UTE1dm1oWm9wUWg2Z1YzU2xrc0dH?=
 =?utf-8?B?NGl3c3lDaklMeHgwYklRKzIvTEw4TldUcUZqUWQzdWVlWjNLZXl1MkdseG5N?=
 =?utf-8?B?N3RuSWJadFc1Z3JnZXJyc2toMFIrVFJNRUs4ZlI1RDdmOHYwaU52VDRVRUV4?=
 =?utf-8?B?OUN5YmV6Q1IzTWpOQmNmNCtPYlowU1BzN2l3UkxDOU1zR1dxclhuMlBqY2pT?=
 =?utf-8?B?NWpMaHluWHBDWlM1dzZ3WkgyRmlyRUxxc01HM3V6Y09xcVZvWVVFcTF2M1dy?=
 =?utf-8?B?MVJGNU9nblZKaThTRmdqZkdleVYrcVFucUdOSHlxOU9ocTdIakRTWGNKU0RQ?=
 =?utf-8?B?eUpoTERuL21OcFpIVE42b0Z0TmkvVEQ1dm9HT3Irc1VPTDV6OWdVb25sK0Qy?=
 =?utf-8?B?bGtpdGlMMFhKSHkyZ1pnTWovcmlJTVBlWjRzdFp5dkVETG5OV2psTGlNemI0?=
 =?utf-8?B?VGZKZ3dEVGNFWndwaDlWbGNKejhrUEt3TFFTdnJBTmx1aitQdXVNbTFYdzh4?=
 =?utf-8?B?UnVoTkZkd2lQWHN0VnFLUXBDMTZlMkJOcVVQL0RYeFNZQmhOcTZFelZZc3pW?=
 =?utf-8?B?blFIaWlRQ3A0My9Qa0ZjN1l1OVhmRUcvZ09VZ2twR2FVYWFPNjRXVjdwVzBC?=
 =?utf-8?B?YlBYMFFiMStLSUtSaXE2REFiOGwrc21ONGNOZ1poWWlmWXhtSWRmcW5nUGRM?=
 =?utf-8?B?blBCSE9uWUV2ZStQN1BndURNT1dFYXV2S3ZjWkxoU2FyS2t5czdXUGJiaEJw?=
 =?utf-8?B?SzY0TldaNmN6clNvNUpJMndPYVhQcG9OdFBtTTdmRFlPeEsxaUliN0pXUFFk?=
 =?utf-8?B?TDc4ODJ3V2NSNGhOTERaWEhRWkFSVmluUDNTOXp2bng1bklGdGlqaTRtTzZ0?=
 =?utf-8?B?UHRVaHYzZ2FLbWVEUUFoSE5QVmZETVRQaTNBQXNuTGg3bnFpR2wzMWNOT1Jr?=
 =?utf-8?B?R2hCZGp1bzlsZWVhVnpQN3ppRjQySDFkNmxBQk9xSEhXOGlyYzNVWkRpMnl4?=
 =?utf-8?B?TU1SN0FmNjFMNXR0SzJwcjNLZUE4QmZ6QzRRVG5QZ3VOaXBWekV0ck1OWVdC?=
 =?utf-8?Q?LJG75qcQHVWM+0VS8SoZDGpUY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779dd7e5-0728-4a67-cc3c-08db98097e9a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 12:17:55.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UszCcZZfk6N7hM41+2ZzronyHTe+YDOqFIRIUyexa8PTy2IBRrLuN3QmQHs8+lK1Le4pt2aEqFhXn4FSsMvTAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/6/23 05:16, Zhu Yanjun wrote:
> 在 2023/8/4 23:05, Petr Pavlu 写道:
>> Add an auxiliary virtual bus to model the mlx4 driver structure. The
>> code is added along the current custom device management logic.
>> Subsequent patches switch mlx4_en and mlx4_ib to the auxiliary bus and
>> the old interface is then removed.
>>
>> Structure mlx4_priv gains a new adev dynamic array to keep track of its
>> auxiliary devices. Access to the array is protected by the global
>> mlx4_intf mutex.
>>
>> Functions mlx4_register_device() and mlx4_unregister_device() are
>> updated to expose auxiliary devices on the bus in order to load mlx4_en
>> and/or mlx4_ib. Functions mlx4_register_auxiliary_driver() and
>> mlx4_unregister_auxiliary_driver() are added to substitute
>> mlx4_register_interface() and mlx4_unregister_interface(), respectively.
>> Function mlx4_do_bond() is adjusted to walk over the adev array and
>> re-adds a specific auxiliary device if its driver sets the
>> MLX4_INTFF_BONDING flag.
>>
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> Tested-by: Leon Romanovsky <leon@kernel.org>
>> ---
>>   drivers/net/ethernet/mellanox/mlx4/Kconfig |   1 +
>>   drivers/net/ethernet/mellanox/mlx4/intf.c  | 230 ++++++++++++++++++++-
>>   drivers/net/ethernet/mellanox/mlx4/main.c  |  17 +-
>>   drivers/net/ethernet/mellanox/mlx4/mlx4.h  |   6 +
>>   include/linux/mlx4/device.h                |   7 +
>>   include/linux/mlx4/driver.h                |  11 +
>>   6 files changed, 268 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/Kconfig b/drivers/net/ethernet/mellanox/mlx4/Kconfig
>> index 1b4b1f642317..825e05fb8607 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/Kconfig
>> +++ b/drivers/net/ethernet/mellanox/mlx4/Kconfig
>> @@ -27,6 +27,7 @@ config MLX4_EN_DCB
>>   config MLX4_CORE
>>   	tristate
>>   	depends on PCI
>> +	select AUXILIARY_BUS
>>   	select NET_DEVLINK
>>   	default n
>>   
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
>> index 30aead34ce08..4b1e18e4a682 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/intf.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
>> @@ -48,6 +48,89 @@ struct mlx4_device_context {
>>   static LIST_HEAD(intf_list);
>>   static LIST_HEAD(dev_list);
>>   static DEFINE_MUTEX(intf_mutex);
>> +static DEFINE_IDA(mlx4_adev_ida);
>> +
>> +static const struct mlx4_adev_device {
>> +	const char *suffix;
>> +	bool (*is_supported)(struct mlx4_dev *dev);
>> +} mlx4_adev_devices[1] = {};
>> +
>> +int mlx4_adev_init(struct mlx4_dev *dev)
>> +{
>> +	struct mlx4_priv *priv = mlx4_priv(dev);
>> +
>> +	priv->adev_idx = ida_alloc(&mlx4_adev_ida, GFP_KERNEL);
>> +	if (priv->adev_idx < 0)
>> +		return priv->adev_idx;
>> +
>> +	priv->adev = kcalloc(ARRAY_SIZE(mlx4_adev_devices),
>> +			     sizeof(struct mlx4_adev *), GFP_KERNEL);
>> +	if (!priv->adev) {
>> +		ida_free(&mlx4_adev_ida, priv->adev_idx);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +void mlx4_adev_cleanup(struct mlx4_dev *dev)
>> +{
>> +	struct mlx4_priv *priv = mlx4_priv(dev);
>> +
>> +	kfree(priv->adev);
>> +	ida_free(&mlx4_adev_ida, priv->adev_idx);
>> +}
>> +
>> +static void adev_release(struct device *dev)
>> +{
>> +	struct mlx4_adev *mlx4_adev =
>> +		container_of(dev, struct mlx4_adev, adev.dev);
>> +	struct mlx4_priv *priv = mlx4_priv(mlx4_adev->mdev);
>> +	int idx = mlx4_adev->idx;
>> +
>> +	kfree(mlx4_adev);
>> +	priv->adev[idx] = NULL;
>> +}
>> +
>> +static struct mlx4_adev *add_adev(struct mlx4_dev *dev, int idx)
>> +{
>> +	struct mlx4_priv *priv = mlx4_priv(dev);
>> +	const char *suffix = mlx4_adev_devices[idx].suffix;
>> +	struct auxiliary_device *adev;
>> +	struct mlx4_adev *madev;
>> +	int ret;
>> +
>> +	madev = kzalloc(sizeof(*madev), GFP_KERNEL);
>> +	if (!madev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	adev = &madev->adev;
>> +	adev->id = priv->adev_idx;
>> +	adev->name = suffix;
>> +	adev->dev.parent = &dev->persist->pdev->dev;
>> +	adev->dev.release = adev_release;
>> +	madev->mdev = dev;
>> +	madev->idx = idx;
>> +
>> +	ret = auxiliary_device_init(adev);
>> +	if (ret) {
>> +		kfree(madev);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	ret = auxiliary_device_add(adev);
>> +	if (ret) {
> 
> madev is allocated, but it is not handled here when auxiliary_device_add 
> error. It should be freed, too?
> That is, add "kfree(madev);" here?
> 
> If madev will be handled in other place, please add some comments here 
> to indicate madev is handled in other place.

A successful call to auxiliary_device_init() registers the device's
.release callback. The madev storage is freed by calling
auxiliary_device_uninit() which invokes adev_release() -> kfree().

Thanks,
Petr
