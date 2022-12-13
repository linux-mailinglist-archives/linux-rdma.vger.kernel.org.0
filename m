Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4A664B4EF
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Dec 2022 13:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiLMMP6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Dec 2022 07:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiLMMOj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Dec 2022 07:14:39 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52861EC74
        for <linux-rdma@vger.kernel.org>; Tue, 13 Dec 2022 04:12:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoGxXFM4ye8A6R3OdpZdrlVPUqVUGBO3nP2lNNxs/v9vtRTxr3hFIFYlYcaznf95lhPpbxmtm7uB9zyOgNKXxOSn1lhdtxB+51FF1AxDEVPWs1aAIbQ3+mjQkaogL4Edi+DCSvT5o7LFewgVrA1eaNz2FwUn9xSLot3QhyjApguxPr2WUK3+g0it29J7fwaLrjrN1P4Ijm+OptaFOPMTyDB2I8I19WDng/yg5P56B1gzxry0EHYVUpslnN88etf0NnLKQ+osC9rur9Taw5ZiC6FLjIU1+YxQkzlW2RJb8/XhY+K08MXoxjA0UXvv4wKzto1ePbiNRf6sM1c2ajbJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bXVbofVjX5iwWZiTIPGmbreFImewt5kgOyxF7TtPr4=;
 b=UCDk4q+mMSliBfsNdB9E60Cd1nnfr77txi6dWvIzpMBlQ16bBbp6LsK+Jr57mlyumg7Bs8iZaASe2eks0zQL/SCAS64gXFzHyHelNZOtyZ2yta3/VU+G+8RwJTJ88ZwnRxwLQM7dwsul3uBad8S5KTmTXOm44h1LSc1mxEjjCZTb415+tPSGjkaOI5o8U3CaAULsXIf1qvhdC6yjOt2pMGgRLOkQyfbkQgT3d55ai4tDB05WcB4JOOuWqYJ5vSA1ZMM9H0+0Ltmr5gn5ElCLauocdeAefor83h4iaiVmLa7MGga0naKHV+j4FsOdEs5OJWKjNOk/Pt28ws1B1ARMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bXVbofVjX5iwWZiTIPGmbreFImewt5kgOyxF7TtPr4=;
 b=OGam92jEo5kAeF1U2WS23HiQrf5/NxMwMogJt2X1xsKRv2BPS8qBVLnxjuNlxf2muauLyZi5F818dEe5yp4omaqCni7x21HbXyLGltKvzQm2phi1+v9+1tX903Ts8Ow/VLYVkE6dIm6bybA4uL+mOi5A7mRhVfIWOecGEL61oCZqn/E1h8d5X++vk1z6+Zrp6OTr3/NhxZOYaDoC80iLAjCgHSIkMWxsA716wbdRorYIm6pGwGx2UoVQXHWte5ebKGR0+kce949Q1rLOAXiraviEz3oMeYP4TzDcxeWymGWxf8wlj9BGD4UK49scZSEuwpL09JHLWId+xw5hLWysrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 12:12:56 +0000
Received: from CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::535c:6961:e3f5:2335]) by CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::535c:6961:e3f5:2335%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 12:12:56 +0000
Message-ID: <55e2c90c-a4cf-7654-e980-d585570b307d@nvidia.com>
Date:   Tue, 13 Dec 2022 14:12:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 rdma-next 4/6] RDMA/mlx5: Introduce mlx5r_cache_rb_key
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com
References: <20221207085752.82458-1-michaelgur@nvidia.com>
 <20221207085752.82458-5-michaelgur@nvidia.com> <Y5EyQ+VFbEmbe+W+@nvidia.com>
From:   Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <Y5EyQ+VFbEmbe+W+@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To CY5PR12MB6084.namprd12.prod.outlook.com
 (2603:10b6:930:28::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6084:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 099fde37-10d3-4698-dc65-08dadd035e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mIAHNufgN43rUI/onwKqdBc5jyCwnRILOAhG/s756zgM+oPjtuH7FuVwls2pTVdLVMHuOtxYerwYaTZd+LO/nV4yeT2hLXX2gkRy0EOTT8oBER1In29glCdcKYHn/Ae0tq8T0V65JXFHwEnbdX9Ja+cdEIxYKcyFJAmlNMjRMwy232q1PJKSp6cibs7AhNyZggrd2Acyuu12zZBmYti1PwdfwJQIMH4OWx+xWdBcDbbrtip/3n6CEoE0sSOhp8qrsnjzJpKTZEeic1IpsnUfMBFqq4eJz7AIXLNLRoUrftpZ6U6HfsrIWk0ufZwvjhSFB12Hl6TycmxSR/gVtxF1KrpsBB/YgdsCVs4YAzk6D2NQfauUIsKED2qQwQnb96VXGoK/kKLr2XJV/rUblikonw+mwHJIFjWj9maFNuD8KLyShBAYbacG/pQN0menOKy6TBCLCuMBZz0CKSFAKKyAUnyayUvMIWr2UKA88w5foHc4wCI909ieDQsNjmMjTfc+jRtzEKnVEStgdb0ozwhMRV6sK2axKcy1Qf2J8qfo2gpBAk94g8Wde3J4viGqFcLQ4UJwtVA4MnGcuiiVJIIwHHZg0yiSj9O76lrw4cN3rF7MoNLhCLF2zLdiSnOzoWY/G9hY2n3l0yO944ptNWpFGzhQsTWkTSOGeE5+ZIAZkrarfEBiY0AQOrtUrs7Bk09US++XkUrQwA8MjSRnd2SXJDlryAHs64gVqYKosARizM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6084.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199015)(86362001)(31696002)(4326008)(41300700001)(8676002)(66556008)(66476007)(6862004)(8936002)(36756003)(2616005)(6636002)(316002)(37006003)(66946007)(6666004)(38100700002)(107886003)(26005)(186003)(5660300002)(6486002)(478600001)(53546011)(6506007)(83380400001)(6512007)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWFwMWE3V09tMmlTK0NSS2labTdldkFmV2JFa3VsZFlnR1RuTTR6cEhJRFlp?=
 =?utf-8?B?OGJIbXpRak9vY01KbFVudGFVdE5KWTRqT1hJUkVPNDcrUnBiYW45RS9iNWUr?=
 =?utf-8?B?OFVOc3JZWkpOZS8wMzVmdGgwSjRvb2ljdlJoL0llbk1ZdDZtdGtmYWErUEpS?=
 =?utf-8?B?dVF4REt0dS83alhzbkc4Zy9GeW0ycjVOS1Q5czhseUFrYWkzbE10WnhjNWEx?=
 =?utf-8?B?cFBqUWExTUZEeHVqTjlOcFhGeGpHUnBjWDhac2xsNDBnbG5RMXRSdkVJcVJ2?=
 =?utf-8?B?MTdtWk0xOEltdGd0KzY5WExaU0RFamFTenRMUG5OZWRZWnd3a002V3JIcWxw?=
 =?utf-8?B?V214TGRLSXhNbEdGYVM3b3dWcWVIWk14Kzh3K1ZVNS9YMVNNcGU4Y1VramFK?=
 =?utf-8?B?R1AxNmtmOGJGZEswR2R4eXpWWFFmNVV3SFhpUy9NNDA3VHhuU1czdVZTcGRl?=
 =?utf-8?B?cjMrVmRTZWduZzVUd2E3cHRQWHp2UDJpeWRJd281VzB0b3plS2xhSGZ6Smtu?=
 =?utf-8?B?K05udXZtSkszL0xtbjVScVdDdVVzZE5DSjg0ckxGQmhvZlZuMHBpQWkzMFVu?=
 =?utf-8?B?RE9LZGYxQzUrU0V6T3k4RFRJYmU0WTF4N3phMjdwWEZUVWNCWFNUK0sycEE1?=
 =?utf-8?B?NnZyZGN1VmtaWmVCTUNaVzVobEFDOGRWOStCUkEvMks3ZEh3YkI3d294M1ln?=
 =?utf-8?B?M0FmUlFPK21JQ0ZWQUJQK0QzUzJ3Zlk3TkZLa3lLNTdrMGpldFN0cno1VDBj?=
 =?utf-8?B?NWpxRkVPWFdDWG51Z0pVOXdHREtWd2EvMFhiVUhWbUVRRWZuQ2VibWkya1li?=
 =?utf-8?B?anhwSzU1cWZoeDNuMnFuUFdxZUsvbS9nMjZMencyb2x2WmdjbmRJZlhDU0M4?=
 =?utf-8?B?bHJlbnlzY0ZBc1FXdFNLRzhJUFRobmtGcitCWDBOVmVwOFNQYm9tS2F6QkZV?=
 =?utf-8?B?YXNIeXBWMXdpUisxSGdNWW14U1Nia0ZaQVR1NURQeHpONXZZVVV5d29CalJv?=
 =?utf-8?B?ZFRGZU9IZHlOaGIySC9UZTkwM2FkY0hLYTBiS21GZ3hvd2ltazQyVGpucWM1?=
 =?utf-8?B?aVY4RXdDZC9RSGJXUk5jdjkyVXpVY0JRNWxNY1dqNWkrM1NheDR5TmRjQ0JS?=
 =?utf-8?B?cXlrdXJJL0xTbU8vbUFINjc1U0xBZHhQbncrbkJXWE1HUjlYTUZGL2VtMlZu?=
 =?utf-8?B?T3NFeUtYSVE4ZFZNdnNVamZOcTM1VHZ4S29IdlAwbE8xbWt1eTcyRnhMRnVi?=
 =?utf-8?B?WjNYZnhGa29pMFIzTm90NHFBNzM0WVUvNWFQWlFMdnAyR2dFTWpDSzBzd3VQ?=
 =?utf-8?B?NDZHRm9JQVU2VWcrWXhWWWtsYXFRb2VwSXU5OWJrbTUwYjRscW1BRjNRb243?=
 =?utf-8?B?d2poK2JVZkJyNnVOZk5DbWhEMTE0V0gwTWhTWXNWVFhnL1oxZWNlUnBXZ3g1?=
 =?utf-8?B?S2x4MU41cUFQZEoveStJVkY2SVRKMWI1QlZVL2Vnc0xlNThlVmxVYTVWNzdq?=
 =?utf-8?B?ZVRxZERZRXJET3ZhVGxxejdGRFVHd1RxbXc2OEtrY01pdkxkVi96WGp1Q3Ax?=
 =?utf-8?B?SGM2UHZFc1hoZVIxaUpnSXlkNUxXVlN1aW1vRDVUUloybnhRZDJhSnhUOG16?=
 =?utf-8?B?cUgrNDg4V2hZQ3hOc2JwZ2hncGpnL3FRS3JJc3RMY1QyU1lyTGxTZ0pkcHBj?=
 =?utf-8?B?clU0QW5ldm8vQ2VRVk5iZEF4RVg5allXQmg5S2hQZHlqVXNGOTcvVncyL1Q0?=
 =?utf-8?B?RFlSeUxTNC9JOE9OQXFhUVlOZGV4ZEdPWXo2M1VHWUFORjhtOXRMZXQ3Uzlm?=
 =?utf-8?B?eGdEMXFZRnJ0WENqUCtac0hoTk1DT2haQ3RyQUtlL1EyeXhTMGNjS2lqYnFE?=
 =?utf-8?B?SU1lY3JSTkl2VmJLUnVwSWRTb1dvaFpiREtrTDZPSjQ0a2p3VTk0SkVabk8r?=
 =?utf-8?B?OWlIeExWNW91UEVabGtlSEZBYUxYbDNEcUZ5YkMzWCswVXB0T3drSVBRcDBz?=
 =?utf-8?B?S1VGQm5FYWFaZkNDTTNvcGF6ak52ZmdKakNBWVVwUWhpMGZuZHJzd1NhQWxM?=
 =?utf-8?B?WSs2V2hWUTg2d3pIK2NlelgraUJJUmZRVWtpTDlxZDdRc1FLZHp1dlM3aUJQ?=
 =?utf-8?Q?tU5m61fv95/We85TQ2h/Mcidp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099fde37-10d3-4698-dc65-08dadd035e30
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 12:12:56.3746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLOLK/jM5YMh5K3nCWatP8iAAV8qgwtaVmYTvJXdM9owA09Z0Z2KNi3LrfYK1R3Lz8tj2QUvUvj290eh+9W9uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/8/2022 2:39 AM, Jason Gunthorpe wrote:
> On Wed, Dec 07, 2022 at 10:57:50AM +0200, Michael Guralnik wrote:
>> Switch from using the mkey order to using the new struct as the key to
>> the RB tree of cache entries.
>> The key is all the mkey properties that UMR operations can't modify.
>> Using this key to define the cache entries and to search and create
>> cache mkeys.
>>
>> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
>> ---
>>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  32 +++--
>>   drivers/infiniband/hw/mlx5/mr.c      | 196 +++++++++++++++++++--------
>>   drivers/infiniband/hw/mlx5/odp.c     |  26 ++--
>>   3 files changed, 180 insertions(+), 74 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
>> index 10e22fb01e1b..d795e9fc2c2f 100644
>> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
>> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
>> @@ -731,17 +731,26 @@ struct umr_common {
>>   	unsigned int state;
>>   };
>>   
>> +struct mlx5r_cache_rb_key {
>> +	u8 ats:1;
>> +	unsigned int access_mode;
>> +	unsigned int access_flags;
>> +	/*
>> +	 * keep ndescs as the last member so entries with about the same ndescs
>> +	 * will be close in the tree
>> +	 */
> ? How does this happen? The compare function doesn't use memcmp..
>
> I think this comment should go in the compare function because the
> search function does this:
>
>> -	return smallest;
>> +	return (smallest &&
>> +		smallest->rb_key.access_mode == rb_key.access_mode &&
>> +		smallest->rb_key.access_flags == rb_key.access_flags &&
>> +		smallest->rb_key.ats == rb_key.ats) ?
>> +		       smallest :
>> +		       NULL;
> So it isn't that they have to be close in the tree, it is that
> "smallest" has to find a matching mode/flags/ats before finding the
> smallest ndescs of the matching list. Thus ndescs must always by the
> last thing in the compare ladder.
Correct, I'll move the comment to the compare function.
We've had a previous version of the compare that used memcmp but we've 
changed it so now the comment is not relevant in the struct anymore
I'll fix this and rest of the comments in v3.

Thanks
Michael

>
>> +struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
>> +				       int access_flags, int access_mode,
>> +				       int ndescs)
>> +{
>> +	struct mlx5r_cache_rb_key rb_key = {
>> +		.ndescs = ndescs,
>> +		.access_mode = access_mode,
>> +		.access_flags = get_unchangeable_access_flags(dev, access_flags)
>> +	};
>> +	struct mlx5_cache_ent *ent = mkey_cache_ent_from_rb_key(dev, rb_key);
>> +	if (!ent)
> Missing newline
>
>>   struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
>> -					      int order)
>> +					      struct mlx5r_cache_rb_key rb_key,
>> +					      bool debugfs)
>>   {
>>   	struct mlx5_cache_ent *ent;
>>   	int ret;
>> @@ -808,7 +873,10 @@ struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
>>   		return ERR_PTR(-ENOMEM);
>>   
>>   	xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
>> -	ent->order = order;
>> +	ent->rb_key.ats = rb_key.ats;
>> +	ent->rb_key.access_mode = rb_key.access_mode;
>> +	ent->rb_key.access_flags = rb_key.access_flags;
>> +	ent->rb_key.ndescs = rb_key.ndescs;
> ent->rb_key = rb_key
>
>>   int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
>>   {
>> +	struct mlx5r_cache_rb_key rb_key = {
>> +		.access_mode = MLX5_MKC_ACCESS_MODE_MTT,
>> +	};
>>   	struct mlx5_mkey_cache *cache = &dev->cache;
>>   	struct mlx5_cache_ent *ent;
>>   	int i;
>> @@ -838,19 +913,26 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
>>   
>>   	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
>>   	timer_setup(&dev->delay_timer, delay_time_func, 0);
>> +	mlx5_mkey_cache_debugfs_init(dev);
>>   	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
>> -		ent = mlx5r_cache_create_ent(dev, i);
>> -
>> -		if (i > MKEY_CACHE_LAST_STD_ENTRY) {
>> -			mlx5_odp_init_mkey_cache_entry(ent);
>> +		if (i > mkey_cache_max_order(dev))
>>   			continue;
> This is goofy, just make the for loop go from 2 to
> mkey_cache_max_order() + 2 (and probably have the function do the + 2
> internally)
>
> Get rid of MAX_MKEY_CACHE_ENTRIES
>> +
>> +		if (i == MLX5_IMR_KSM_CACHE_ENTRY) {
>> +			ent = mlx5_odp_init_mkey_cache_entry(dev);
>> +			if (!ent)
>> +				continue;
> This too, just call mlx5_odp_init_mkey_cache_entry() outside the loop
>
> And rename it to something like mlx5_odp_init_mkey_cache(), and don't
> return ent.
>
> Set ent->limit inside mlx5r_cache_create_ent()
>
> And run over the whole rbtree in a final loop to do the final
> queue_adjust_cache_locked() step.
>
>> -void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
>> +struct mlx5_cache_ent *mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev)
>>   {
>> -	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
>> -		return;
>> -	ent->ndescs = mlx5_imr_ksm_entries;
>> -	ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
>> +	struct mlx5r_cache_rb_key rb_key = {
>> +		.ats = 0,
>> +		.access_mode = MLX5_MKC_ACCESS_MODE_KSM,
>> +		.access_flags = 0,
>> +		.ndescs = mlx5_imr_ksm_entries,
> Don't need to zero init things here
>
> Jason
