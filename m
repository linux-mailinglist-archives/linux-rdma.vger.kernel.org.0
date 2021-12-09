Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A630C46E40F
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 09:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhLIIZF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 03:25:05 -0500
Received: from mail-co1nam11on2067.outbound.protection.outlook.com ([40.107.220.67]:12640
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230064AbhLIIZE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 9 Dec 2021 03:25:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U82wOnKYhb0ISFvg+DSQRaEfMug/yerNvesWfxtpeEP/51rBCclVIgz5luEp6VGETIlrBoBBPC2FZ82kJ8yH2EwyhrNj6IwzPHfBTf5cLuLHo9BUPvhqm0cj2YpstFFmwLWeSFpurNPImMuj2QQkPDRIyvHE2xFQ1a3Vjz7RAGY+RlAqkMSrP0ZSPdUcOvrcUmKg+666+QL6WC/XieIrJI6SMm9LKPgKOj84X7fz8czE9a9ofgJkDXUkMV29IPV+OQRFdnW/5uiSwR0PMRt2jfiqgwGRTABsWxiDEU/DHZqJ3jqh8wBhoS5papkvw5ReMIAGPtuKCGjebdDWfQgruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InsOBt63Dv4MNLsqgxj9WpiBPn7IP3h2XnvygpgsC98=;
 b=VQktqg1uDel4vpDhDZDk/PXEtJbph34romWQhUIwJyfSMQ9J1vxB/4Xm6twd9uIp4kG+kPvj/XexW0z1BKUtLopsoHiYkGG6NKND7NkaZAGQpY/UH9p+kQ1sBdf3TXLy0dGd/7V1XD6XVNvw5V35DacuwMzxu47ype2wNsGLa4HVR5qRg0t4vWbEVhJ1b7ygR6SJVCoAMGOlLlUazqBvfBWQgeDAsKkBjdDAQaQmtQtDPupADUgXDZQkRtRZXw0ixEi03LW0+NXYPACDQbt+Kz1Z57HfrP+cgQQIfXEZuw+UffsFfSCbmAGCmFF86PSGLJR4hkT5lkBaxuseZNi34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InsOBt63Dv4MNLsqgxj9WpiBPn7IP3h2XnvygpgsC98=;
 b=VIU2LLx72pAKulVu5ort3R0/ueOkCr8DxRYqgQnaQpP3Fm5voVoSpcrb9ykn0ze9AB2uL2qmD71pn+1B4TUkQ939dy/Cjoue1KlEAvqj5OmoXDbDZpcfoXrBjdekauLfggT2Wdoy+tQhQtFyxFopOjDGzo3IxPO/ln46cngCcOe7oBQZTOy0ZY6jfi2ocl0S9WOj6Hw4MyE91gPaj/ElPuXuq1KMpXWE9riD2eh4sVkJqIUrXdwDjx8vV0lKqGywDy27p2jcOMJHC0d+OIGuQAkUcyimwbtfjrWo9SfiDtGMcf5YV8UlXMoA4d+GXX09gbTJgrJu3pcvd8zt1zlx3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3255.namprd12.prod.outlook.com (2603:10b6:a03:12e::25)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 08:21:30 +0000
Received: from BYAPR12MB3255.namprd12.prod.outlook.com
 ([fe80::f54c:a7bc:ba9e:f814]) by BYAPR12MB3255.namprd12.prod.outlook.com
 ([fe80::f54c:a7bc:ba9e:f814%6]) with mapi id 15.20.4755.021; Thu, 9 Dec 2021
 08:21:30 +0000
Message-ID: <9c1d9ad2-0619-16cb-4be3-c763668639de@nvidia.com>
Date:   Thu, 9 Dec 2021 10:21:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH rdma-next 2/7] RDMA/mlx5: Replace cache list with Xarray
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <cover.1638781506.git.leonro@nvidia.com>
 <63a833106bcb03298489a80e88b1086684c76595.1638781506.git.leonro@nvidia.com>
 <20211208164611.GB6385@nvidia.com>
From:   Aharon Landau <aharonl@nvidia.com>
In-Reply-To: <20211208164611.GB6385@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P193CA0134.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::39) To BYAPR12MB3255.namprd12.prod.outlook.com
 (2603:10b6:a03:12e::25)
MIME-Version: 1.0
Received: from [172.27.15.47] (193.47.165.251) by AM6P193CA0134.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Thu, 9 Dec 2021 08:21:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77c52334-a78a-4e80-d896-08d9baece70c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4919:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49192AA0737FDFA23FDF247CDF709@BY5PR12MB4919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wedIaN1PHFdN0wYCpy/gD6te3oURK/RnqgTTLJKkSuAlYlrtBIKTzeJJnlv6LDY+45BX5B/Eh4vK+1Fq8EoZNvFYZwtqjWEqntkT3m6ZGI3IX75NJVINBbyEzf+JvVuJ+OgJzXOle/YPWA49H6TG9YmvTsR6G7e/7K9LQccVqg9vVB4SN0VxLk2nNCRTYHBNdOpiaZzdVmiK7oI6k0ye0h3r5uqOTQ3r9GgKsHZECwZkd4kL7OvtRhl0rJwO4dh3NedKajd1PEFpHCu3vGivR1rarHUuypbHuA+yxCzljhQLIt5qBcmN3bEwb6MrIi6iEBdg+MbZ52e2C+nVatDjUl23nd0hMRopvgUdVIFmv8Lfid/ywTuVH+WF24T6PGEHEv9Mv1/2CyH51VFBjkzkIR1lRd3zmsODExp7wVVABSSsqAbFk7G5XMcJ3gn34aD+oX20Mf2JO+kN6bn2agmG6T0lzjtMk9snNof5HWnaSZ9ZwcydpFfwPNbVBOhI9hZ26VqC/C4bx0GmibxrgWtraoKEPKTMI9YeHIj3NnKKQfaLLnHnAOonNJPpB1/cL7fQEV9rTAUVk3K/2UhQHtEh16d86yqovsnXA+jFcjeGJaflqHwi0/eU9Luw1uGE1PNlQqpRTQB4saH4wOLQ3FLn+c2GO3L0NHyVsKR8bRPfYigODw+axeUZVrG1EURHooaL93Q/w0W/7c+pO1W/rVnlYXd3oNHN7VGzEjwY1ahSlM3kC3Fo2riqtPTfry7na7qpqlbFNdO+5dHHL5+DCi6P3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3255.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(186003)(956004)(86362001)(8936002)(2616005)(83380400001)(508600001)(31696002)(38100700002)(38350700002)(26005)(2906002)(36756003)(16576012)(31686004)(4326008)(6666004)(6486002)(66556008)(316002)(5660300002)(110136005)(66946007)(66476007)(53546011)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFh5VjN1OFZhLzJ1NVZTcHhPNE02aCs3Rnp6SXBRbTFLeGIvL2xTRkE1ZWp2?=
 =?utf-8?B?bG4zVzJuMFFXNklXV2l3QlZFVkttdTRsajJxTTBwRW5BSXNPNnJ4dHJJYlNX?=
 =?utf-8?B?cHhmYWFDcEdLMmw4V3B6KzMzS214b1p3N29BdE1xb3RBb1N1UURGZFJkVGRv?=
 =?utf-8?B?Yy9UR2UxdGNjUHhLNlRTcnRtZG85YmhsTDUyeW1RTW8wZ0plR1puV2VaWnpQ?=
 =?utf-8?B?MWc2NkNQUkNEVG5KeUltWmF3dXhXZW9keHQ5WmtDdC9BS3V4ODBlYkRCMkhh?=
 =?utf-8?B?L1dhV2JFemlyaVBvc2czYjg5KytBUjNqR0RLUCtnNFNTbm9KeXdyMzczWUti?=
 =?utf-8?B?azFjNS9qWVpwUzNhbEt3cTRQWVZ1MkI2QkxybVkrMkhQNDVjVFZRRnc2TVZm?=
 =?utf-8?B?VlZhaWZkRkpwdk9uQmVaV01zbGpqVldHT29VMWVGTXliMThBZEMvRCsrdUpq?=
 =?utf-8?B?WUNHcDg1WENXSGt6V25uRkd5OEpmeXZpOFFJWXNsS3pyc09xM1N2azMxWExj?=
 =?utf-8?B?VXR0K2c2bWY0SjJOMXlXK2EzS0dLaWhzZ0hBV093SmFIMEYyMG41ZkVob2Fv?=
 =?utf-8?B?Umhtbkl3UEtkMHZOUnAyZlJqNVlHTHl1eEhrSGlyT1BocG9xbEI5c25kMS9k?=
 =?utf-8?B?ZUliQit6SDRXem5od05YZzVZZmJHK3RlN2dPbWp6Y3p4S0V0UlVZRzdjSWxp?=
 =?utf-8?B?d3NSQVFmT0trckpiMTc4T0xEcVBsNHEyYkdPbXFEMXZ4dmQxaGRVRmFhdENP?=
 =?utf-8?B?UGR0WFVvaHhBcmE1aDRleW1KUGxjSnI1aldpeVJLL25pYjFmZzZmUWpOaTFF?=
 =?utf-8?B?TzJBODdZdjlweFc2SjJDWFpWdi93RSs4amE4MmE5L250MEw0RDUxc0hSTk1K?=
 =?utf-8?B?RnFsMThIekc1SElPb0xBQUZ0TDYzRlFwQkYwNko0d044VVV2TnFVOUZ0NUQ3?=
 =?utf-8?B?Zm9BT1FrUDdST25iY1BLTzgyQ05UZXYxSmxlWWdaV0czbXJ4czdaS2xnSVJa?=
 =?utf-8?B?cFVxYjQ2dEZxb3BKczNMcTdZUWxod0pqN25rS1JxWERWYm5Vakw1YXk1NnpW?=
 =?utf-8?B?SVQwaDlLVVRGTXZ3NDFpVm1kUVQ5ZDIvZC96Y3RjZlBEaUJFMDZveE5DSllC?=
 =?utf-8?B?SXVNTTIzcWxKOVIzZE5tQ3lYMDVrMzIzM3FjTFQxR2NUbnVTV1pidzVNRjlw?=
 =?utf-8?B?QWFUUndQc211bzdCbEdiamsyU3ZTUkJhNWsrTzBVaVg1MFRMcngrdlo4T2V6?=
 =?utf-8?B?WThzcWJ5ZnpDdy9jeDR1M2VVeWxTY2g0N1ZrQ3dhZFlPaTlKdEhOTXNJQ3Ry?=
 =?utf-8?B?d0VoaFdPbUV0c21XL1kvUkpDYjdFcHdpQk9jaGhocmo2YTVNT05PUExEdkxm?=
 =?utf-8?B?SVdVQ1oyeXpzQ3JVbThpYnF4LzBrVDNmUzR1OTgvMTBOaHBaSUZWcXlOcWow?=
 =?utf-8?B?NXZ4VmJ3bUJUcmhtTEtuRTB0MlBOcTFWOUxUWGJQZmdQeUlVa3FRNExyWFl6?=
 =?utf-8?B?YzJUTjJORlM5QjFrb1lFRTZNcngzQ09yWXJqeGRxOVo5RDlHTUhXSjhUbmVv?=
 =?utf-8?B?U29TK2V4NUZ0eUFCQ2FWbVowS3M0U2Z1bzBuK1lGQUhnT05LbG5ibFBZUDc5?=
 =?utf-8?B?MzVsQ09EeUNwODI3VElxQlVobGd0ak91UE9kUlVudUF1bnVudkcvUC9LVzJZ?=
 =?utf-8?B?eENaNFNuRm5xTTNzRlVuM2JwZWMwQ2UxeFh2NE1Md2d5c3lFc1BodE4vZXBX?=
 =?utf-8?B?ajNLQXZEZWQycUxXc1hEOHdtSzhuSDdYRndHNVN4UHFGRm9mcCtvd2czdTV4?=
 =?utf-8?B?b296YkVKOHFWMVZGQ3l4OTM0eVRZOE9PUmtjendWdUJScTZXaEVxNk9nZE1x?=
 =?utf-8?B?WitQbEdvWkltVkpmdlArNlBJM2xGL2N2Wit2Snd0bDR2VTBucHFsTlZDM2oy?=
 =?utf-8?B?cjl6MVVscnprSjZoQTFtaFhUZk8xU0hvN2ZyVmpDUkh4Y010dW84MUxvSjY3?=
 =?utf-8?B?cUhDbEtXUEhLeUgxbGlKQVNReUY1Zyt1dSt6eGJkaDd3OWlrckF0dUYrWWY4?=
 =?utf-8?B?QTR5RzZpM2tuQVozOG1PTDIwMTQ3aDVyTkRqSzRGc2J4WGFoZmdRVEZEejE1?=
 =?utf-8?B?L3haYzVKNUFxekFrQkFhdDV4Rkp3eFZkNmR0YU1YSVM5QmtFWm9wQWpQeDdw?=
 =?utf-8?Q?pLx8KqLP9yzdC+t+TeUPeOQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c52334-a78a-4e80-d896-08d9baece70c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3255.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 08:21:30.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuJ4pnweEfaPYPkU6DR+6f0nPkGkS4WxEYz+qYz02bSaENrJQwTyqH+z8RcucFHYJtv92eWNeCbfEhUx1yUJZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/8/2021 6:46 PM, Jason Gunthorpe wrote:
>> @@ -166,14 +169,14 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
>>   
>>   	WRITE_ONCE(dev->cache.last_add, jiffies);
>>   
>> -	spin_lock_irqsave(&ent->lock, flags);
>> -	list_add_tail(&mr->list, &ent->head);
>> -	ent->available_mrs++;
>> +	xa_lock_irqsave(&ent->mkeys, flags);
>> +	xa_ent = __xa_store(&ent->mkeys, ent->stored++, mr, GFP_ATOMIC);
>> +	WARN_ON(xa_ent != NULL);
>> +	ent->pending--;
>>   	ent->total_mrs++;
>>   	/* If we are doing fill_to_high_water then keep going. */
>>   	queue_adjust_cache_locked(ent);
>> -	ent->pending--;
>> -	spin_unlock_irqrestore(&ent->lock, flags);
>> +	xa_unlock_irqrestore(&ent->mkeys, flags);
>>   }
>>   
>>   static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
>> @@ -196,6 +199,25 @@ static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
>>   	return mr;
>>   }
>>   
>> +static int _push_reserve_mkey(struct mlx5_cache_ent *ent)
>> +{
>> +	unsigned long to_reserve;
>> +	int rc;
>> +
>> +	while (true) {
>> +		to_reserve = ent->reserved;
>> +		rc = xa_err(__xa_cmpxchg(&ent->mkeys, to_reserve, NULL,
>> +					 XA_ZERO_ENTRY, GFP_KERNEL));
>> +		if (rc)
>> +			return rc;
> What about when old != NULL ?
>
>> +		if (to_reserve != ent->reserved)
>> +			continue;
> There is an edge case where where reserved could have shrunk alot
> while the lock was released, and xa_cmpxchg could succeed. The above
> if will protect things, however a ZERO_ENTRY will have been written to
> some weird place in the XA. It needs a
>
>   if (old == NULL) // ie we stored something someplace weird
>      __xa_erase(&ent->mkeys, to_reserve)
>
>> +		ent->reserved++;
>> +		break;
>> +	}
>> +	return 0;
>> +}
>> +
>>   /* Asynchronously schedule new MRs to be populated in the cache. */
>>   static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
>>   {
>> @@ -217,23 +239,32 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
>>   			err = -ENOMEM;
>>   			break;
>>   		}
>> -		spin_lock_irq(&ent->lock);
>> +		xa_lock_irq(&ent->mkeys);
>>   		if (ent->pending >= MAX_PENDING_REG_MR) {
>> +			xa_unlock_irq(&ent->mkeys);
>>   			err = -EAGAIN;
>> -			spin_unlock_irq(&ent->lock);
>> +			kfree(mr);
>> +			break;
>> +		}
>> +
>> +		err = _push_reserve_mkey(ent);
> The test of ent->pending is out of date now since this can drop the
> lock
>
> It feels like pending and (reserved - stored) are really the same
> thing, so maybe just directly limit the number of reserved and test it
> after
The mlx5_ib_dereg_mr is reserving entries as well. Should I limit 
create_mkey_cb due to pending deregs?
>> @@ -287,39 +318,37 @@ static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
>>   {
>>   	struct mlx5_ib_mr *mr;
>>   
>> -	lockdep_assert_held(&ent->lock);
>> -	if (list_empty(&ent->head))
>> +	if (!ent->stored)
>>   		return;
>> -	mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
>> -	list_del(&mr->list);
>> -	ent->available_mrs--;
>> +	mr = __xa_store(&ent->mkeys, --ent->stored, NULL, GFP_KERNEL);
>> +	WARN_ON(mr == NULL || xa_is_err(mr));
> Add a if (reserved != stored)  before the below?
I initiated the xarray using XA_FLAGS_ALLOC, therefore, the __xa_store 
above will mark the entry as ZERO_ENTRY.
>
>> +	WARN_ON(__xa_erase(&ent->mkeys, --ent->reserved) != NULL);
> Also please avoid writing WARN_ON(something with side effects)
>
>    old = __xa_erase(&ent->mkeys, --ent->reserved);
>    WARN_ON(old != NULL);
>
> Same for all places
>
>>   static int resize_available_mrs(struct mlx5_cache_ent *ent, unsigned int target,
>>   				bool limit_fill)
>> +	 __acquires(&ent->lock) __releases(&ent->lock)
> Why?
>
>>   {
>>   	int err;
>>   
>> -	lockdep_assert_held(&ent->lock);
>> -
> Why?
>
>>   static void clean_keys(struct mlx5_ib_dev *dev, int c)
>>   {
>>   	struct mlx5_mr_cache *cache = &dev->cache;
>>   	struct mlx5_cache_ent *ent = &cache->ent[c];
>> -	struct mlx5_ib_mr *tmp_mr;
>>   	struct mlx5_ib_mr *mr;
>> -	LIST_HEAD(del_list);
>> +	unsigned long index;
>>   
>>   	cancel_delayed_work(&ent->dwork);
>> -	while (1) {
>> -		spin_lock_irq(&ent->lock);
>> -		if (list_empty(&ent->head)) {
>> -			spin_unlock_irq(&ent->lock);
>> -			break;
>> -		}
>> -		mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
>> -		list_move(&mr->list, &del_list);
>> -		ent->available_mrs--;
>> +	xa_for_each(&ent->mkeys, index, mr) {
> This isn't quite the same thing, the above tolerates concurrent add,
> this does not.
>
> It should be more like
>
> while (ent->stored) {
>     mr = __xa_erase(stored--);
>
>> @@ -1886,6 +1901,17 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
>>   	}
>>   }
>>   
>> +static int push_reserve_mkey(struct mlx5_cache_ent *ent)
>> +{
>> +	int ret;
>> +
>> +	xa_lock_irq(&ent->mkeys);
>> +	ret = _push_reserve_mkey(ent);
>> +	xa_unlock_irq(&ent->mkeys);
>> +
>> +	return ret;
>> +}
> Put this close to _push_reserve_mkey() please
>
> Jason
