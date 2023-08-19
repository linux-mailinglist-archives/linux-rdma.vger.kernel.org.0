Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F297818CC
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Aug 2023 12:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjHSKjp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Aug 2023 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHSKjn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Aug 2023 06:39:43 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7548237FF;
        Sat, 19 Aug 2023 02:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n58tSsE4dZe4hPIFipWBCplhQO8GKS4OXiuLtT9k3xNk01ouR8pa6A2f5IXHIMQPqXaqrOuGTq5Jg3wX6eASqtgypjKaDSoapBqmIsO+E6lSlAdh+7LsqqDr5kXyOUTKNQn/CxbmKWQZ2GHZiqfxi/BrW18dXzr2UMayFaLld3HVGcJIkCmQksg1QIhNv/L8rY0frhIOccEe8u53YJ6aFqIfWKRbupOUxbsUGwpBWLy7QIPuDX6r7+4zwwzPWUY14E2kLBQXbgnytr1cCxVlr1Xphav0kUKdBB4uAhgZwLL0vV1Lw5AWyh0aY5BJCTz/cxHWeDHibwxIjFqS+I9xZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPxUtZWySbiGTGrRPvA0DUF9rBbptj/lgYAwolGRsTo=;
 b=Wes0t5HdFXHKNQqzjXNOcJxK1eux1RA+lr1AxZgNmqG9zFEsxU3/Lb+Oji050bNXp7gRDAA66iNglDj9E8IZSbCGBYdcTbnxY0PJ0oaDmFepAKvgyFFY6DF/Owe7pbkBMsnc7o0SuwBYoCJYLdA34qJgKXYb8jXtBBoHqulVmMBN/SE2PtZ/xza06isUR/zp8wBPHb2q4Hw1/53Mb/eC9tBM3W9XP6yYyaxhHJMzKoQADLzzk0d+hu77wB6D806BSKRb/kxeKDAVOIaB4261wu8/guwfLQ3KYsSt2iVcHNqw5LHqViA4udFeU8zwkALO40YtcQtvdWGEebVFIq9/nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPxUtZWySbiGTGrRPvA0DUF9rBbptj/lgYAwolGRsTo=;
 b=fy0Cz9fdb6Z1x0PQfztO8QPOgeLUmGymo6Bmj4BnhrJdz0gXqQJL7MvZdmsHsmShSuxxdfHLKEJbRd+aZJnbu+kdOq/LbdUaKVsZvXVV9CIxxBAR+oSpJS2/fNfYpZxk+eaFkRYI+vvW5auMuRG6JKsqF0Xb+1vusECOYCqrJ4xj76tGe9JAR97sNzS9l/mFt45G7ynDnOSjRKS+JrYrp8CwD7n6jOljRJOzzKBdYCNlZa98b8mlKBnhxRSVvUVfAXNSH9hMrX5ZCB+GO6AiVZYRlm5ot5iIjWo2311rpe3IqNUqRHuoptNnoZcJGSIr6V7AtiBQwNRRqBgNGgUyiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by VI1PR04MB6990.eurprd04.prod.outlook.com
 (2603:10a6:803:138::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 09:19:59 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::da23:cf17:3db5:8010]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::da23:cf17:3db5:8010%3]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 09:19:59 +0000
Message-ID: <93326217-3d6a-7b2b-023e-d7725f1523b3@suse.com>
Date:   Sat, 19 Aug 2023 11:19:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/10] mlx4: Replace the mlx4_interface.event
 callback with a notifier
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230813145127.10653-1-petr.pavlu@suse.com>
 <20230813145127.10653-4-petr.pavlu@suse.com> <20230813165449.GL7707@unreal>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20230813165449.GL7707@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0197.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::18) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|VI1PR04MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: fe75bd72-fe1d-409b-65f5-08dba09575b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LOUU6eEgd66QE8cYQuZmw7mTKe6vpKm9DQ0RvnEIP1w/WXaJUaC5YydmdV4tQZ5NKfhUokIOcuxuWtcunxI3/hyseq7ywybvY5hUYYhtot7NkXeUeNTjuIRDQV8AbqUrMdceUm9+XVmBmFw+iRIKkvvPG7cysLFW4wKtnvo0xdx/1i5jkbwQ3/MBV110XPsPXugrWIjtfe4LcAXH6dPnNRMs01pMn5WiieGD3WcikDXULevIS5wLQ3gJ7+wFTk45CUDYa4WVNeo8w+9rhrg7QsqG43eIkPDfWpFKTO+14W542eJRmJOEyMYD5+Fy3xEKxjf1QKUm+Ack4f7VtiJyz9XQxeLymBXwozPfszedp8vta0v8FVqCpNWUXnkMucKbnSrrt8IBR0Lpp9Oj05xc1D4Tzm8ttJpVQHoNMidVnDeImqoY16eEVa3Hl5cfzJH/dmYCfXn4Zb7ROhQ51vJkL/E5Yv0c3J6a/h3g9zkJBithWlsvXMCMs9cVj2Y/wkX2r4EU0foE6bfX7hW1VkriPIU8ppmToljqI2cwoJEg0B55GT3THFQ/cgkZQspN8kAZafGsZCieTdXiMgh//83W8YtbhltJp9NoqBjdWdL2fnskbyct8VfKOU9ovE+mVBX9dkUXFwPK8cGRWyIQHUTbKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39850400004)(1800799009)(186009)(451199024)(8936002)(8676002)(4326008)(44832011)(66899024)(5660300002)(86362001)(38100700002)(31696002)(2616005)(53546011)(478600001)(6512007)(26005)(6666004)(55236004)(6506007)(6486002)(83380400001)(41300700001)(30864003)(7416002)(66556008)(66476007)(66946007)(36756003)(316002)(2906002)(6916009)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3NlbXhiZDlaU3h6VGhVdzBDT0tSdS95dlQ5bUVJQUpGOTgwMmxXMzdyUi9v?=
 =?utf-8?B?UUlmbnZZMDZ2cEFXa0V0SlloYUJBWTBHelNOTURCY3lITTVrWE5ydStnbFFG?=
 =?utf-8?B?N0VxTnhSc3J1enhIS2JNK3VNbTFCSElBQ3lZd0JicUhMN3NsWmJ6S3lScDA2?=
 =?utf-8?B?K1FMcGtVbVAwdUJ3WWJWOFh1OXJ1dUdrMGpObUxLRlRDU3hGS2dXWGQ1UUVl?=
 =?utf-8?B?aWV1OVVncWdwdU41NUNOc1o0WVltbldSZDhJZ2VnRWNGSWZBb1o1SUxHU08v?=
 =?utf-8?B?Y2RZYnJCVTBYK0lOQWVwRVFhNzdtYi9nUDJpS213YlNybmt5aWV3T1F2and2?=
 =?utf-8?B?SW5UUGJtTlljK2lVT1lQZGJmU1J4REw5SzF0Y3FuODR2N0JtTG8za21Kd2RI?=
 =?utf-8?B?anNZY0dOSGlRd3RFKzkxbUhKemp0WUhTay8xMUYwalNjYy92bDV2Q1NXUytQ?=
 =?utf-8?B?MWhGY0Vpay9OQWNVdS9oK1hhS2NKZys3TkpvdTN4SEtCUGVocUpBTVVKTnB4?=
 =?utf-8?B?MGxBMjBPRE10b0htY1UvQXRVenF4d3NER3EwY1R0dVo5UVZHWEVRMi85LzhO?=
 =?utf-8?B?YlRzTXFHZHNvRHdoanhpbUpYd0d4RUZTWVRvMW02UjZNVUV1M0lhUDNzVG5D?=
 =?utf-8?B?Uk5pL3lLU0xmQU5vUXYvbkp6bGx4Wk90OUtheGR2TEV1OE5LZ1U3Z2VSVytH?=
 =?utf-8?B?ZWRSSEtSblFFOWJZbkxGRDFxbTNIQVFnZ1hzVHZ2czFiZGIrYlAvWnNORmwx?=
 =?utf-8?B?T3ZiWGNyQUczZXJJQW93czduTzFhRW11RU40RmFiWC9YUXkwMlJCQ3A3aFQw?=
 =?utf-8?B?TDRXTXlPUm9maFNPblEvVC9leTJaN0crbEU4Y0ljRmVSV2hVTUFtM1hBK1JI?=
 =?utf-8?B?Yk4vdmFuc3kvUTVxUGNLRThVYWgvWHVJazFWM0QxVlluUVFCZkxuc3R3SzlY?=
 =?utf-8?B?NUgxeFByY3ZFWXZabzBsdXVHdUM1NDhUa1llekxtNjJYS2pVVTkxUFh2Yzlv?=
 =?utf-8?B?NlBUMGlYR1pPMHl1VFV6YTBBOEE2cXFxUTIzR2s4WGNPNVNzd2FMbFRQaXNn?=
 =?utf-8?B?YmViQlRWall5bWw0WDNrOTlvSzIrRE13WFJpU3BlOVZaNkM4dEVrZWpyZEN5?=
 =?utf-8?B?d2tyK2Y4ZFRLUXYzbXNkM0FJbTBiRFlNaWZ6OWpQUG0rZ2ViSk05NmJSYjRN?=
 =?utf-8?B?WXJxeTRhRXJKbzRHa1IraXNWTzZwc2RDclQ0akM0YkR4ektmcXlxSldHR1Ax?=
 =?utf-8?B?RHBZZHlLUlIxTnpmVjJXK09rY1ZYVUptelBCYUMvL0NjNmlVVlVPNmNuQzhO?=
 =?utf-8?B?YzlNQjlTdFkzN25wbUNYaFlUNlZtUTc0amRROFU3RHMxYXBNNzBOeDREelB6?=
 =?utf-8?B?Y3N6NG16QzlsNnZTM1kza0p2ckNmQmJvMDZkTlNyY0RRb1pZeEFpZlZ0c1Bs?=
 =?utf-8?B?dlhvc2pjWlpJYlN4cUt3NTBXc2VXWi9FT29vekNpMUQyOUJnaFNhTWhRdno5?=
 =?utf-8?B?aFFNODBIRFhkUDkrcmZhY2ttOS93NTR1MlI0aFlmSjVUZm1Cc2RUOXlxamYr?=
 =?utf-8?B?TDJNTUgwaWhpNWgrL0JDRVhpQ1VoaTRiTllZclBLYTMzQlozaFZ4bEltMU4r?=
 =?utf-8?B?dXZtWFFLbVNaUXpIS1h3N2VrOVpEeXgvOVhPdW5KMC9JbEdNQ3hWKzRzZlZZ?=
 =?utf-8?B?TTRZbGxmL05uTnBaWlJQVDdxdUJyRjJYMktjak1aOFNyK2xHK3MrSTUvT1hu?=
 =?utf-8?B?TGJzRXJhU0dKcFFXR21WbEwzZTJmdzhlcVFXVnJSREZJWlpiQUJOOXcrbGY1?=
 =?utf-8?B?Vnc5d2JtR2UwNjVKSDdTN2gyVXFxTmR2SjRjQXUzZnUvLzF6UzduUW1LVWJJ?=
 =?utf-8?B?Y2NjT0pKdDhTT01YNjNGT3VtN0piUlNxNVhmNjVRZVU3a3drd3gvckJ0VTFP?=
 =?utf-8?B?d1RDUnBoYkhxMWZiUlYvV1VseFF0akxhcmZGUVRCZzhyblp3VUtTbWl1clha?=
 =?utf-8?B?OFFZR0FjTGVmNnZscGcrSThKZFA3N1lkcGZoY1ZRR0U1d3Y0OXAzY2Z6V1Z1?=
 =?utf-8?B?MUNnSWUweHRZbG8zV0F1SHJMVzdmWXlNdVcvdDVYUzVtNUdOUHdFMGdac1Np?=
 =?utf-8?Q?E+phk0GE6I01GZhX1Gcl/Z4Iz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe75bd72-fe1d-409b-65f5-08dba09575b9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 09:19:59.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7idl8XDTXKxl1yMtU7j3QwkpIoA6auEbix+brHtbRVyzKur6KNjgzR07Dp/SQKg2ygadMfLf+vzrVKBdvaWWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6990
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/13/23 18:54, Leon Romanovsky wrote:
> On Sun, Aug 13, 2023 at 04:51:20PM +0200, Petr Pavlu wrote:
>> Use a notifier to implement mlx4_dispatch_event() in preparation to
>> switch mlx4_en and mlx4_ib to be an auxiliary device.
>>
>> A problem is that if the mlx4_interface.event callback was replaced with
>> something as mlx4_adrv.event then the implementation of
>> mlx4_dispatch_event() would need to acquire a lock on a given device
>> before executing this callback. That is necessary because otherwise
>> there is no guarantee that the associated driver cannot get unbound when
>> the callback is running. However, taking this lock is not possible
>> because mlx4_dispatch_event() can be invoked from the hardirq context.
>> Using an atomic notifier allows the driver to accurately record when it
>> wants to receive these events and solves this problem.
>>
>> A handler registration is done by both mlx4_en and mlx4_ib at the end of
>> their mlx4_interface.add callback. This matches the current situation
>> when mlx4_add_device() would enable events for a given device
>> immediately after this callback, by adding the device on the
>> mlx4_priv.list.
>>
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> Tested-by: Leon Romanovsky <leonro@nvidia.com>
>> Acked-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>  drivers/infiniband/hw/mlx4/main.c            | 41 +++++++++++++-------
>>  drivers/infiniband/hw/mlx4/mlx4_ib.h         |  2 +
>>  drivers/net/ethernet/mellanox/mlx4/en_main.c | 27 +++++++++----
>>  drivers/net/ethernet/mellanox/mlx4/intf.c    | 24 ++++++++----
>>  drivers/net/ethernet/mellanox/mlx4/main.c    |  2 +
>>  drivers/net/ethernet/mellanox/mlx4/mlx4.h    |  2 +
>>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h |  2 +
>>  include/linux/mlx4/driver.h                  |  8 +++-
>>  8 files changed, 77 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
>> index 7dd70d778b6b..0761c465120b 100644
>> --- a/drivers/infiniband/hw/mlx4/main.c
>> +++ b/drivers/infiniband/hw/mlx4/main.c
>> @@ -82,6 +82,8 @@ static const char mlx4_ib_version[] =
>>  static void do_slave_init(struct mlx4_ib_dev *ibdev, int slave, int do_init);
>>  static enum rdma_link_layer mlx4_ib_port_link_layer(struct ib_device *device,
>>  						    u32 port_num);
>> +static int mlx4_ib_event(struct notifier_block *this, unsigned long event,
>> +			 void *ptr);
>>  
>>  static struct workqueue_struct *wq;
>>  
>> @@ -2836,6 +2838,12 @@ static void *mlx4_ib_add(struct mlx4_dev *dev)
>>  				do_slave_init(ibdev, j, 1);
>>  		}
>>  	}
>> +
>> +	/* register mlx4 core notifier */
>> +	ibdev->mlx_nb.notifier_call = mlx4_ib_event;
>> +	err = mlx4_register_event_notifier(dev, &ibdev->mlx_nb);
>> +	WARN(err, "failed to register mlx4 event notifier (%d)", err);
>> +
>>  	return ibdev;
>>  
>>  err_notif:
>> @@ -2953,6 +2961,8 @@ static void mlx4_ib_remove(struct mlx4_dev *dev, void *ibdev_ptr)
>>  	int p;
>>  	int i;
>>  
>> +	mlx4_unregister_event_notifier(dev, &ibdev->mlx_nb);
>> +
>>  	mlx4_foreach_port(i, dev, MLX4_PORT_TYPE_IB)
>>  		devlink_port_type_clear(mlx4_get_devlink_port(dev, i));
>>  	ibdev->ib_active = false;
>> @@ -3173,11 +3183,14 @@ void mlx4_sched_ib_sl2vl_update_work(struct mlx4_ib_dev *ibdev,
>>  	}
>>  }
>>  
>> -static void mlx4_ib_event(struct mlx4_dev *dev, void *ibdev_ptr,
>> -			  enum mlx4_dev_event event, unsigned long param)
>> +static int mlx4_ib_event(struct notifier_block *this, unsigned long event,
>> +			 void *ptr)
>>  {
>> +	struct mlx4_ib_dev *ibdev =
>> +		container_of(this, struct mlx4_ib_dev, mlx_nb);
>> +	struct mlx4_dev *dev = ibdev->dev;
>> +	unsigned long param = *(unsigned long *)ptr;
> 
> You don't need this assignment here as later, you will cast param again,
> in your next patches:
> 
>   3227         if (event == MLX4_DEV_EVENT_PORT_MGMT_CHANGE)
>   3228                 eqe = (struct mlx4_eqe *)param;
>   3229         else
>   3230                 p = (int) param;
> 
> so use ptr directly:
> 
>          if (event == MLX4_DEV_EVENT_PORT_MGMT_CHANGE)
>                  eqe = param;
>          else
>                  p = *(int *) param;

Function mlx4_dispatch_event() currently takes an 'unsigned long' as its
event parameter. The patch updates the function to use
atomic_notifier_call_chain() which however expects 'void *' as the
'param' value. To solve the mismatch, mlx4_dispatch_event() passes to
atomic_notifier_call_chain() an address of the original 'param'. This
creates one additional level of indirection which the handlers, such as
mlx4_ib_event(), need to deal with. Line
'unsigned long param = *(unsigned long *)ptr;' is added for that.

I think the best way to avoid this complexity would be for
mlx4_dispatch_event() to take 'void *' as its 'param' in the first
place. I would add the following patch before this one in v3 of the
series.


From e17d6b8fb32e6caeba2929764ad0249a2e136049 Mon Sep 17 00:00:00 2001
From: Petr Pavlu <petr.pavlu@suse.com>
Date: Fri, 18 Aug 2023 12:55:30 +0200
Subject: [PATCH] mlx4: Use 'void *' as the event param of
 mlx4_dispatch_event()

Function mlx4_dispatch_event() takes an 'unsigned long' as its event
parameter. The actual value is none (MLX4_DEV_EVENT_CATASTROPHIC_ERROR),
a pointer to mlx4_eqe (MLX4_DEV_EVENT_PORT_MGMT_CHANGE), or a 32-bit
integer (remaining events).

In preparation to switch mlx4_en and mlx4_ib to be an auxiliary device,
the mlx4_interface.event callback is replaced with a notifier and
function mlx4_dispatch_event() gets updated to invoke
atomic_notifier_call_chain(). This requires forwarding the input 'param'
value from the former function to the latter. A problem is that the
notifier call takes 'void *' as its 'param' value, compared to
'unsigned long' used by mlx4_dispatch_event(). Re-passing the value
would need either punning it to 'void *' or passing down the address of
the input 'param'. Both approaches create a number of unnecessary casts.

Change instead the input 'param' of mlx4_dispatch_event() from
'unsigned long' to 'void *'. A mlx4_eqe pointer can be passed directly,
callers using an int value are adjusted to pass its address.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/infiniband/hw/mlx4/main.c            | 14 ++++++++++----
 drivers/net/ethernet/mellanox/mlx4/catas.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c     |  4 ++--
 drivers/net/ethernet/mellanox/mlx4/en_main.c | 17 +++++++++++++++--
 drivers/net/ethernet/mellanox/mlx4/eq.c      | 15 ++++++++-------
 drivers/net/ethernet/mellanox/mlx4/intf.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h    |  2 +-
 include/linux/mlx4/driver.h                  |  2 +-
 8 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 7dd70d778b6b..2c5fd8174b3c 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -3174,7 +3174,7 @@ void mlx4_sched_ib_sl2vl_update_work(struct mlx4_ib_dev *ibdev,
 }
 
 static void mlx4_ib_event(struct mlx4_dev *dev, void *ibdev_ptr,
-			  enum mlx4_dev_event event, unsigned long param)
+			  enum mlx4_dev_event event, void *param)
 {
 	struct ib_event ibev;
 	struct mlx4_ib_dev *ibdev = to_mdev((struct ib_device *) ibdev_ptr);
@@ -3194,10 +3194,16 @@ static void mlx4_ib_event(struct mlx4_dev *dev, void *ibdev_ptr,
 		return;
 	}
 
-	if (event == MLX4_DEV_EVENT_PORT_MGMT_CHANGE)
+	switch (event) {
+	case MLX4_DEV_EVENT_CATASTROPHIC_ERROR:
+		break;
+	case MLX4_DEV_EVENT_PORT_MGMT_CHANGE:
 		eqe = (struct mlx4_eqe *)param;
-	else
-		p = (int) param;
+		break;
+	default:
+		p = *(int *)param;
+		break;
+	}
 
 	switch (event) {
 	case MLX4_DEV_EVENT_PORT_UP:
diff --git a/drivers/net/ethernet/mellanox/mlx4/catas.c b/drivers/net/ethernet/mellanox/mlx4/catas.c
index 0eb7b83637d8..0d8a362c2673 100644
--- a/drivers/net/ethernet/mellanox/mlx4/catas.c
+++ b/drivers/net/ethernet/mellanox/mlx4/catas.c
@@ -194,7 +194,7 @@ void mlx4_enter_error_state(struct mlx4_dev_persistent *persist)
 	mutex_unlock(&persist->device_state_mutex);
 
 	/* At that step HW was already reset, now notify clients */
-	mlx4_dispatch_event(dev, MLX4_DEV_EVENT_CATASTROPHIC_ERROR, 0);
+	mlx4_dispatch_event(dev, MLX4_DEV_EVENT_CATASTROPHIC_ERROR, NULL);
 	mlx4_cmd_wake_completions(dev);
 	return;
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
index c56d2194cbfc..f5b1f8c7834f 100644
--- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
@@ -2113,7 +2113,7 @@ static void mlx4_master_do_cmd(struct mlx4_dev *dev, int slave, u8 cmd,
 		if (MLX4_COMM_CMD_FLR == slave_state[slave].last_cmd)
 			goto inform_slave_state;
 
-		mlx4_dispatch_event(dev, MLX4_DEV_EVENT_SLAVE_SHUTDOWN, slave);
+		mlx4_dispatch_event(dev, MLX4_DEV_EVENT_SLAVE_SHUTDOWN, &slave);
 
 		/* write the version in the event field */
 		reply |= mlx4_comm_get_version();
@@ -2152,7 +2152,7 @@ static void mlx4_master_do_cmd(struct mlx4_dev *dev, int slave, u8 cmd,
 		if (mlx4_master_activate_admin_state(priv, slave))
 				goto reset_slave;
 		slave_state[slave].active = true;
-		mlx4_dispatch_event(dev, MLX4_DEV_EVENT_SLAVE_INIT, slave);
+		mlx4_dispatch_event(dev, MLX4_DEV_EVENT_SLAVE_INIT, &slave);
 		break;
 	case MLX4_COMM_CMD_VHCR_POST:
 		if ((slave_state[slave].last_cmd != MLX4_COMM_CMD_VHCR_EN) &&
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_main.c b/drivers/net/ethernet/mellanox/mlx4/en_main.c
index be8ba34c9025..83dae886ade6 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_main.c
@@ -184,10 +184,22 @@ static void mlx4_en_get_profile(struct mlx4_en_dev *mdev)
 }
 
 static void mlx4_en_event(struct mlx4_dev *dev, void *endev_ptr,
-			  enum mlx4_dev_event event, unsigned long port)
+			  enum mlx4_dev_event event, void *param)
 {
 	struct mlx4_en_dev *mdev = (struct mlx4_en_dev *) endev_ptr;
 	struct mlx4_en_priv *priv;
+	int port;
+
+	switch (event) {
+	case MLX4_DEV_EVENT_CATASTROPHIC_ERROR:
+	case MLX4_DEV_EVENT_PORT_MGMT_CHANGE:
+	case MLX4_DEV_EVENT_SLAVE_INIT:
+	case MLX4_DEV_EVENT_SLAVE_SHUTDOWN:
+		break;
+	default:
+		port = *(int *)param;
+		break;
+	}
 
 	switch (event) {
 	case MLX4_DEV_EVENT_PORT_UP:
@@ -205,6 +217,7 @@ static void mlx4_en_event(struct mlx4_dev *dev, void *endev_ptr,
 		mlx4_err(mdev, "Internal error detected, restarting device\n");
 		break;
 
+	case MLX4_DEV_EVENT_PORT_MGMT_CHANGE:
 	case MLX4_DEV_EVENT_SLAVE_INIT:
 	case MLX4_DEV_EVENT_SLAVE_SHUTDOWN:
 		break;
@@ -213,7 +226,7 @@ static void mlx4_en_event(struct mlx4_dev *dev, void *endev_ptr,
 		    !mdev->pndev[port])
 			return;
 		mlx4_warn(mdev, "Unhandled event %d for port %d\n", event,
-			  (int) port);
+			  port);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/eq.c b/drivers/net/ethernet/mellanox/mlx4/eq.c
index 414e390e6b48..6598b10a9ff4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
@@ -501,7 +501,7 @@ static int mlx4_eq_int(struct mlx4_dev *dev, struct mlx4_eq *eq)
 	int port;
 	int slave = 0;
 	int ret;
-	u32 flr_slave;
+	int flr_slave;
 	u8 update_slave_state;
 	int i;
 	enum slave_port_gen_event gen_event;
@@ -606,8 +606,8 @@ static int mlx4_eq_int(struct mlx4_dev *dev, struct mlx4_eq *eq)
 			port = be32_to_cpu(eqe->event.port_change.port) >> 28;
 			slaves_port = mlx4_phys_to_slaves_pport(dev, port);
 			if (eqe->subtype == MLX4_PORT_CHANGE_SUBTYPE_DOWN) {
-				mlx4_dispatch_event(dev, MLX4_DEV_EVENT_PORT_DOWN,
-						    port);
+				mlx4_dispatch_event(
+					dev, MLX4_DEV_EVENT_PORT_DOWN, &port);
 				mlx4_priv(dev)->sense.do_sense_port[port] = 1;
 				if (!mlx4_is_master(dev))
 					break;
@@ -647,7 +647,8 @@ static int mlx4_eq_int(struct mlx4_dev *dev, struct mlx4_eq *eq)
 					}
 				}
 			} else {
-				mlx4_dispatch_event(dev, MLX4_DEV_EVENT_PORT_UP, port);
+				mlx4_dispatch_event(dev, MLX4_DEV_EVENT_PORT_UP,
+						    &port);
 
 				mlx4_priv(dev)->sense.do_sense_port[port] = 0;
 
@@ -758,7 +759,7 @@ static int mlx4_eq_int(struct mlx4_dev *dev, struct mlx4_eq *eq)
 			}
 			spin_unlock_irqrestore(&priv->mfunc.master.slave_state_lock, flags);
 			mlx4_dispatch_event(dev, MLX4_DEV_EVENT_SLAVE_SHUTDOWN,
-					    flr_slave);
+					    &flr_slave);
 			queue_work(priv->mfunc.master.comm_wq,
 				   &priv->mfunc.master.slave_flr_event_work);
 			break;
@@ -787,8 +788,8 @@ static int mlx4_eq_int(struct mlx4_dev *dev, struct mlx4_eq *eq)
 			break;
 
 		case MLX4_EVENT_TYPE_PORT_MNG_CHG_EVENT:
-			mlx4_dispatch_event(dev, MLX4_DEV_EVENT_PORT_MGMT_CHANGE,
-					    (unsigned long) eqe);
+			mlx4_dispatch_event(
+				dev, MLX4_DEV_EVENT_PORT_MGMT_CHANGE, eqe);
 			break;
 
 		case MLX4_EVENT_TYPE_RECOVERABLE_ERROR_EVENT:
diff --git a/drivers/net/ethernet/mellanox/mlx4/intf.c b/drivers/net/ethernet/mellanox/mlx4/intf.c
index 28d7da925d36..a761971cd0c4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/intf.c
+++ b/drivers/net/ethernet/mellanox/mlx4/intf.c
@@ -180,7 +180,7 @@ int mlx4_do_bond(struct mlx4_dev *dev, bool enable)
 }
 
 void mlx4_dispatch_event(struct mlx4_dev *dev, enum mlx4_dev_event type,
-			 unsigned long param)
+			 void *param)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
 	struct mlx4_device_context *dev_ctx;
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4.h b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
index 6ccf340660d9..de5699a4ddaa 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
@@ -1048,7 +1048,7 @@ int mlx4_restart_one(struct pci_dev *pdev);
 int mlx4_register_device(struct mlx4_dev *dev);
 void mlx4_unregister_device(struct mlx4_dev *dev);
 void mlx4_dispatch_event(struct mlx4_dev *dev, enum mlx4_dev_event type,
-			 unsigned long param);
+			 void *param);
 
 struct mlx4_dev_cap;
 struct mlx4_init_hca_param;
diff --git a/include/linux/mlx4/driver.h b/include/linux/mlx4/driver.h
index 923951e19300..032d7f5bfef6 100644
--- a/include/linux/mlx4/driver.h
+++ b/include/linux/mlx4/driver.h
@@ -58,7 +58,7 @@ struct mlx4_interface {
 	void *			(*add)	 (struct mlx4_dev *dev);
 	void			(*remove)(struct mlx4_dev *dev, void *context);
 	void			(*event) (struct mlx4_dev *dev, void *context,
-					  enum mlx4_dev_event event, unsigned long param);
+					  enum mlx4_dev_event event, void *param);
 	void			(*activate)(struct mlx4_dev *dev, void *context);
 	struct list_head	list;
 	enum mlx4_protocol	protocol;
-- 
2.35.3

