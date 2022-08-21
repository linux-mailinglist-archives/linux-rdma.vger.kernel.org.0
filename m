Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2758259B3CF
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Aug 2022 14:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiHUMvZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 08:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiHUMuX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 08:50:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B680631D
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 05:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBwuSGnwUgpeWLVwHQlo4/o2cUUN5UPoXO/pVgHUozlrg8kHB5vJ6IPwl0L20GOc+hAGozDNB6NlPmxzVu4tzwNTNxaRVAAFmFyzyPJVA5C6hTueiG5TrZsBCNeNc8T8IO8EUjfSlMtHpj8FLWU4HJMuqODwHSQYwXhbgmwED5JqbbP/TcMHGJSBKBhiXZ9zjIJtBTFB5PJq+GNWTLs8B7jrbRS2GxkTc00eM15WoxByNeV8bGldgGKDJBcAq8d5bOpPr5jz29Dujb3TGkx7Ldr5olwPgQfCO7qx82llY8G8MOkCV0HywHZmR44iF44kxMnxSVgEJM/2UBjkqKmhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhPi9W6IXwOSgY/XErNcu39wRUtSBlkHdYsNEdkEPJA=;
 b=fIRoBnr01OU9EcwQv4Htg8VV9fQbIoRbe33T3kJW+4Zw3vowMhjy4M4PdClp7krEu1ceHE6yVihjvR0/aNuVrJZJVbKtCKYCz2V0g4Me3U0QshJroMaYjf8E989ZW1GDGyUFQGoXv3xPSRCOAhEwZgRKP7LL9Pc8XHEoeF13Tz/mRZ4AZj7Eox+BhAOjQbcaBYKj6mi+87uU3s2I1WHY05D+L2aW1TxjdgxR9F5JfpI4tzQDbk6EAKXRxaRePv3YZaX4LU9BS1W40zC7VmLDEaxU1AQquvk/NhaQuQlZmIiCzFRotOWMyaJOqt34XE/uuwhvy65J7KBeB8eb1Y/nLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhPi9W6IXwOSgY/XErNcu39wRUtSBlkHdYsNEdkEPJA=;
 b=NBZsdXQk12hZqvKRVR27KvhARZtTaemq8Ts29MVW4KrXr1XEZptLGWwLqBUkbqgZpOSENYw7suKtMQ9Ph9hskUs5pUc2hYRcSYFg5rgtuUl/xna23eZ8z5UAlt0cRfkpCT3CdEToaZFuMYwjs6I1wXTtDIddpkY0++sLcaHS2pCbJy8FzHDr0tKT/PHZPwV9omLbiuUiUx0MjRzgBKTnRBBH2JqMDuKLtZGm7/uf45fUk1KfmJe4snlv1DE7jY9+L3NtGUHwX3itjoCyNB+OIcjN8ITJL9w08iLTHbhO/vlC+cAPLtHPeSPlS5EbqJSMLBpSdirZY1Rsl1dpwc6I3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Sun, 21 Aug
 2022 12:50:19 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::b9f8:7e48:f34a:70f9]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::b9f8:7e48:f34a:70f9%4]) with mapi id 15.20.5546.021; Sun, 21 Aug 2022
 12:50:19 +0000
Message-ID: <8863ab45-8b9f-3f1b-32c7-2c8f7e06b8ea@nvidia.com>
Date:   Sun, 21 Aug 2022 20:50:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH rdma-next 2/3] IB/cm: remove cm_id_priv->id.service_mask
 and service_mask parameter of cm_init_listen()
Content-Language: en-US
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     jgg@nvidia.com, dledford@redhat.com,
        jiapeng.chong@linux.alibaba.com, cgel.zte@gmail.com,
        linux-rdma@vger.kernel.org
References: <20220819090859.957943-1-markzhang@nvidia.com>
 <20220819090859.957943-3-markzhang@nvidia.com> <YwIYXI9xTSpw4Vtj@unreal>
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <YwIYXI9xTSpw4Vtj@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To CY4PR12MB1366.namprd12.prod.outlook.com
 (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c4ec4d4-2654-4896-e697-08da8373b412
X-MS-TrafficTypeDiagnostic: SA1PR12MB7040:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXXeVW5i97BqrpXffw1tJ2taOMASr9AVSjMi//BeiT8rsBT+HFU/yU7vpyBSe4k7VZBMxvTBdLjIZhgb4vzkSZ6u+mWdAAfwSizz/oOZ/i8wRm+ceDfNgaM7bT2pkeZPVyAxPY4hIXJtS+ZzAcAi2Rqf4ls7ee82z/mGI5YfnX0s24PhxmgTVjVlJuTnLoDhcIlo3qfw8lqtDxdOED/14WKdATzbkKrgigY8ymJFr2xy18xEKamQ3DF+Z6gRtvB/Jz/ZZaw+vGxoPKtGbTZb0Wr0G4fk+4xvxkcd3Q4u4brw57TEq7NpJsLCD9YBFZ8Ex7oLgFAimbH6noASoLetyumx7gr6mYGPB/MmXrn473pv87+wKM3EtoeOZkrFXCNvDOld2uq92eRUC8fqeCi8BdObe74xcfs7TaqpLkYZApdqsN7djnd+J5nrz9753hH3RIZbaLW42JBv+J6FWwVlGMkjHpON+QcTtZ5jookD2o3BQ/4PU7dJssMuDKXDD/OkVYeWDnQWmZL92ZLIOCOvYmEluFqz7s3lsbwHCl50z17dEILSAT8ZDdFq5WXqAP3IyrvIyPTS+N0sSWXpOrGifbp0fnGnXGge4LYvndPAT7tbsMVO86sfGgbhMvrUqowuz0z64HgLKf5Ann8bcBSwPuUYF2iBM2g1Ed0gUp7V5Q6BzttPS0Gc2XwMIhfst4cgFuLS0Ffmthsgsqulak8OjWpL/Ynl00CQFtABuxp0n0oZOOvbs/vGEmk88L0XfJwxs/wq7v+2lpLR4ijK82B1Y9IAGLBtlJ89KcN2eUazMVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(478600001)(41300700001)(6666004)(53546011)(6506007)(31696002)(86362001)(36756003)(6512007)(26005)(83380400001)(31686004)(2616005)(6486002)(186003)(66946007)(8676002)(66476007)(4326008)(6636002)(37006003)(316002)(66556008)(5660300002)(6862004)(8936002)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZqZ1BHWEt1Wm1ONFNidmJROE5LNnZQRXNVSEt5c1JyUXJxMitRRW8wdUow?=
 =?utf-8?B?dmJtRHZDYXpoWDhqWVhrZi9WdlcwNnlVR3VWY3FsL01FMjk2QXFyUHIxbjdj?=
 =?utf-8?B?aTFrejRkTXM2Mm9JZjBwQkhpOGlheTJQcE9zYkxpMkJ4K2dqSnBDQ3hXMzAr?=
 =?utf-8?B?OXAybmpDK1crUTN6c0FoR2xjWWxPckpqclNKT1EzRmg1V2lQTUNZNzhNR0Qz?=
 =?utf-8?B?N0NSaFNFNmoyTXdxTy9zSUxZYWJRMXhHUndJNUpPOTJ0aUM3TTZ5ZjNUdnp0?=
 =?utf-8?B?MkhpQjBTVVg3Y0J6eGxwanNaSkpxVGYyZ3U4cEdZd3UzOHRyVWREbkR2UCtl?=
 =?utf-8?B?WjNzN1NzNlJxUWt2OHcwVHV1WThVdFVneVI3SmJ4VDlSc3lDK1duRXFybVVW?=
 =?utf-8?B?Rmo4c1QxeXlDWFBWdzA4c093azNBRFY4cFFUTVBGSG1wWG5QSjRlODAvYWg2?=
 =?utf-8?B?N2tJZ1c4dWl6dXNHNmludkpRUDV2b25kTzBlcm9ISGlIaG5rc01YRStCTjl5?=
 =?utf-8?B?Z3pwU1J6S01KVURmMWhvZENLQ3lCL3V0VXNWTzFJbVY5NG96RnlnS2preG1G?=
 =?utf-8?B?aEh3Njg4K2hqYkJvbGlvNW12NENVOGpPb25CQ25yVkhVc1h1Z0JXNk9menJp?=
 =?utf-8?B?NFVsMDl0ajJqZk9oUTFxdW1Kam5ZNHF0cUVXbVVtVHZnOHZYT2QxZUxrWkY5?=
 =?utf-8?B?ZFg4cC9VbFhhNTBia0FnaEprcUQ5R3lUNjhsZmlvUFB4b09iUVhBYXBSTklP?=
 =?utf-8?B?NS9YQmdRMzBMcytQRlVhdDJ6TkhRNkNYUzFSSGgrNW9xSmxFbzc3WTVRMnBz?=
 =?utf-8?B?TjZTZ2JmUmtCaWhhVEFnTTh6ekVVNjhmeHVKVmZwaXZlZ3E1bWt0YnlwTE0x?=
 =?utf-8?B?M0J4aU1xTXZsVCtwYUlRb25WRU5xY05RSndGTXlJUW84MXVCK2hsRVdFK2kz?=
 =?utf-8?B?cXJEcDJ3T2pRSEJFZm1DcGdXc0J2eFZmQWdCbjVCRisraEZveDl3RVJFSzdy?=
 =?utf-8?B?WmRDbUh4SkJyRzhaL3R3UytFOFlCQnRzY0NuZEhuc0lESkxTMWlBdkZyTllv?=
 =?utf-8?B?QS9WVzZiSkxxNDFKRVA4Y3RPTEdZSy90MVJxakhwd0t3TFZyMURicW13VEdr?=
 =?utf-8?B?Y0RMSktUUm1id2tsZlRiNzV2K1BTSk43SjN3S3hndU9VM0ZObnFRU3UycExp?=
 =?utf-8?B?eU1lRXJOZlFJVE5PYXp0blBsK3RlUEJJMGZFUmhhK3RpODI1VHBzR0JmTllK?=
 =?utf-8?B?WEx6SUpORGNXNFAwTzArUklxMGluRWVEZWwwZ0cyeFQvd0FGVTZNZHdUYmJp?=
 =?utf-8?B?dEl5ZDgyNDh1cFUwazNMTnhudFNFWlI3dTVYSEY4Z1RhQmxCUFpGc1Z2alRK?=
 =?utf-8?B?U2FZbWFlQ21ycUpVcndsdU5EMGxBcUwxUkpQMDBDUXpQY3Q2Tm1TeVc1NStQ?=
 =?utf-8?B?UVZDVmFCVmhLM2I5MXZXbmJJenpEQTYzbXAyNWx0YWVORFFobms2eUVwS2dh?=
 =?utf-8?B?NWJERllwZkhaMTFldy9WcW5mSENtREVrQjZLRFEyTVdhRlU3ejR3L0w3NUtM?=
 =?utf-8?B?TWVyR090TVpCeVBVczRkYjdSejJvcE44cjl2dnBxSitvNXF3QVp1TnE2UkJl?=
 =?utf-8?B?bFlRM2RiVzMybVRtQk9odFB3M3FZcm42UWFOSDNHS1FTNHVCN2pUMFZpQlFC?=
 =?utf-8?B?dGNJRVozMi9BTm5hQ21PQTh6cU9IanFqcW5xMTJ4RWN1YVNpcFdRVUg4Ui84?=
 =?utf-8?B?VHZuUm5tSWs2MnVubUtvdXpzcUhzYWc1SFdTUTluZFl3bzhVTHZZSjFtcjlm?=
 =?utf-8?B?SXduZ1BtY1YzNUJsc1I4UE42VXI3SzBkaHluc3dpYXhlQ3BJbTNjaTNrQVR3?=
 =?utf-8?B?OWhmeTdYWnpZZzhzWG1rQkJ0MERnbStydVJzdG1RVE05TFZpd2dJNU12WXNG?=
 =?utf-8?B?SWhuY0MwUFM2SS9aYi8wSlVlV3NENHk0TzBzTUI4MkZ1VldqdFZBUk9NZTA2?=
 =?utf-8?B?N3h3dVJET0FFTVA1cHhJR3dQZkdkMUVUYmhTYnhXUmswNFFmUjg0NTlGZ2FL?=
 =?utf-8?B?b0J1NjFLandVYkNnaSthbENhbGJ0dG92dnJCNCt6bytVdFp1eUFZczN3bmxT?=
 =?utf-8?Q?WANpEu13XErTjT+P8YJprZiFy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4ec4d4-2654-4896-e697-08da8373b412
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2022 12:50:19.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKdD0ENMfrTJf06sZtPA1+qDo6+s/t325DdBgbaDFZ2Vk6yapLtEipVb2AI9i7YyPgw5bJIlrOjwrHDtv0D9TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/2022 7:34 PM, Leon Romanovsky wrote:
> On Fri, Aug 19, 2022 at 12:08:58PM +0300, Mark Zhang wrote:
>> The service_mask is always ~cpu_to_be64(0), so the result is always
>> a NOP when it is &'d with a service_id. Remove it for simplicity.
>>
>> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
>> ---
>>   drivers/infiniband/core/cm.c | 28 ++++++++--------------------
>>   include/rdma/ib_cm.h         |  1 -
>>   2 files changed, 8 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
>> index b59f864b3d79..84bb10799467 100644
>> --- a/drivers/infiniband/core/cm.c
>> +++ b/drivers/infiniband/core/cm.c
>> @@ -617,7 +617,6 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
>>   	struct rb_node *parent = NULL;
>>   	struct cm_id_private *cur_cm_id_priv;
>>   	__be64 service_id = cm_id_priv->id.service_id;
>> -	__be64 service_mask = cm_id_priv->id.service_mask;
>>   	unsigned long flags;
>>   
>>   	spin_lock_irqsave(&cm.lock, flags);
>> @@ -625,8 +624,7 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
>>   		parent = *link;
>>   		cur_cm_id_priv = rb_entry(parent, struct cm_id_private,
>>   					  service_node);
>> -		if ((cur_cm_id_priv->id.service_mask & service_id) ==
>> -		    (service_mask & cur_cm_id_priv->id.service_id) &&
>> +		if ((service_id == cur_cm_id_priv->id.service_id) &&
>>   		    (cm_id_priv->id.device == cur_cm_id_priv->id.device)) {
>>   			/*
>>   			 * Sharing an ib_cm_id with different handlers is not
>> @@ -670,8 +668,7 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
>>   
>>   	while (node) {
>>   		cm_id_priv = rb_entry(node, struct cm_id_private, service_node);
>> -		if ((cm_id_priv->id.service_mask & service_id) ==
>> -		     cm_id_priv->id.service_id &&
>> +		if ((service_id == cm_id_priv->id.service_id) &&
>>   		    (cm_id_priv->id.device == device)) {
>>   			refcount_inc(&cm_id_priv->refcount);
>>   			return cm_id_priv;
>> @@ -1158,22 +1155,17 @@ void ib_destroy_cm_id(struct ib_cm_id *cm_id)
>>   }
>>   EXPORT_SYMBOL(ib_destroy_cm_id);
>>   
>> -static int cm_init_listen(struct cm_id_private *cm_id_priv, __be64 service_id,
>> -			  __be64 service_mask)
>> +static int cm_init_listen(struct cm_id_private *cm_id_priv, __be64 service_id)
>>   {
>> -	service_mask = service_mask ? service_mask : ~cpu_to_be64(0);
>> -	service_id &= service_mask;
>>   	if ((service_id & IB_SERVICE_ID_AGN_MASK) == IB_CM_ASSIGN_SERVICE_ID &&
>>   	    (service_id != IB_CM_ASSIGN_SERVICE_ID))
>>   		return -EINVAL;
>>   
>> -	if (service_id == IB_CM_ASSIGN_SERVICE_ID) {
>> +	if (service_id == IB_CM_ASSIGN_SERVICE_ID)
>>   		cm_id_priv->id.service_id = cpu_to_be64(cm.listen_service_id++);
>> -		cm_id_priv->id.service_mask = ~cpu_to_be64(0);
>> -	} else {
>> +	else
>>   		cm_id_priv->id.service_id = service_id;
>> -		cm_id_priv->id.service_mask = service_mask;
>> -	}
> 
> If service_id != IB_CM_ASSIGN_SERVICE_ID, we had zero as service_mask
> and not FFF... like you wrote. It puts in question all
> cm_id_priv->id.service_mask & service_id => service_id conversions in
> this patch.

The id.service_mask field is removed in this patch, check the change in 
include/rdma/ib_cm.h

> 
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1199,7 +1191,7 @@ int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id)
>>   		goto out;
>>   	}
>>   
>> -	ret = cm_init_listen(cm_id_priv, service_id, 0);
>> +	ret = cm_init_listen(cm_id_priv, service_id);
>>   	if (ret)
>>   		goto out;
>>   
>> @@ -1247,7 +1239,7 @@ struct ib_cm_id *ib_cm_insert_listen(struct ib_device *device,
>>   	if (IS_ERR(cm_id_priv))
>>   		return ERR_CAST(cm_id_priv);
>>   
>> -	err = cm_init_listen(cm_id_priv, service_id, 0);
>> +	err = cm_init_listen(cm_id_priv, service_id);
>>   	if (err) {
>>   		ib_destroy_cm_id(&cm_id_priv->id);
>>   		return ERR_PTR(err);
>> @@ -1518,7 +1510,6 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
>>   		}
>>   	}
>>   	cm_id->service_id = param->service_id;
>> -	cm_id->service_mask = ~cpu_to_be64(0);
>>   	cm_id_priv->timeout_ms = cm_convert_to_ms(
>>   				    param->primary_path->packet_life_time) * 2 +
>>   				 cm_convert_to_ms(
>> @@ -2075,7 +2066,6 @@ static int cm_req_handler(struct cm_work *work)
>>   		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_COMM_ID, req_msg));
>>   	cm_id_priv->id.service_id =
>>   		cpu_to_be64(IBA_GET(CM_REQ_SERVICE_ID, req_msg));
>> -	cm_id_priv->id.service_mask = ~cpu_to_be64(0);
>>   	cm_id_priv->tid = req_msg->hdr.tid;
>>   	cm_id_priv->timeout_ms = cm_convert_to_ms(
>>   		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg));
>> @@ -3482,7 +3472,6 @@ int ib_send_cm_sidr_req(struct ib_cm_id *cm_id,
>>   	spin_lock_irqsave(&cm_id_priv->lock, flags);
>>   	cm_move_av_from_path(&cm_id_priv->av, &av);
>>   	cm_id->service_id = param->service_id;
>> -	cm_id->service_mask = ~cpu_to_be64(0);
>>   	cm_id_priv->timeout_ms = param->timeout_ms;
>>   	cm_id_priv->max_cm_retries = param->max_cm_retries;
>>   	if (cm_id->state != IB_CM_IDLE) {
>> @@ -3557,7 +3546,6 @@ static int cm_sidr_req_handler(struct cm_work *work)
>>   		cpu_to_be32(IBA_GET(CM_SIDR_REQ_REQUESTID, sidr_req_msg));
>>   	cm_id_priv->id.service_id =
>>   		cpu_to_be64(IBA_GET(CM_SIDR_REQ_SERVICEID, sidr_req_msg));
>> -	cm_id_priv->id.service_mask = ~cpu_to_be64(0);
>>   	cm_id_priv->tid = sidr_req_msg->hdr.tid;
>>   
>>   	wc = work->mad_recv_wc->wc;
>> diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
>> index fbf260c1b1df..8dae5847020a 100644
>> --- a/include/rdma/ib_cm.h
>> +++ b/include/rdma/ib_cm.h
>> @@ -294,7 +294,6 @@ struct ib_cm_id {
>>   	void			*context;
>>   	struct ib_device	*device;
>>   	__be64			service_id;
>> -	__be64			service_mask;
>>   	enum ib_cm_state	state;		/* internal CM/debug use */
>>   	enum ib_cm_lap_state	lap_state;	/* internal CM/debug use */
>>   	__be32			local_id;
>> -- 
>> 2.26.3
>>

