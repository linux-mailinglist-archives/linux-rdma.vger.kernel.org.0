Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEC77AF87F
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Sep 2023 05:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjI0DPD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 23:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjI0DNC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 23:13:02 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED2D55A7
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 19:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxKFd9veEeM9AmiXjV9V+Av66aPoCCOJiPHCt9/0S1BLXPL/RFeTHyGTl5ns222XbF2h9r++nT3+JHcRqNbhtThtdu6Q7If2qutuvlvlfAbJ1+PspAD7gFoSzMPFwIcYJxU+YQ/1BDOlMyuXKzkotBA/Er98Sj5/JDg/mu+E8PSLeP+Jb5GV3mIx/mXOMbEoCnKWncuds033yYtyvs1Fq3mtgT2wZ3geukVyra9GoZOz2wdLH/Vxaq5K631bFMQ0FjevnXsNNZIleXn4G7Zrt8NDkM4XlmUjc2qcaKitZGQqIEgcr/o+Ta/TUpRa4kw26Vqwitw8CU+3pGtHn1XQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGyXlXMro1mMiq1UyLPgAMTVab1TR0dP5LyzXOiRZnE=;
 b=L5tl8EFVWzF0wx0F8t3mg6+44d+O0X40RIw8Gzl7nMoVx0B9gjEZAoZVhg6TXAZp9L0d0ASTnLUTSvJskZT2CxOV2ZPDbBTvO+NXCg5Bd1794LguYVgybnwiNHlfLuoS1NFE3vL/X2VRCH5JkxpgP93g1DWRZcmefyflWVHBmTws79ZBsX45MEiwyBWgeYEXHCOaCB+RQsIA6Ivic8e8+YBcPvsmviEO8xE8UGjrvnGHCRAw63Ud2nxN/081jfYvNckO8lqEC4s1xN08SCbUGI1RAWpqj6ql+zACGscujnupy7tXOaVxJbYUC0bME0dEvGgpES/T9jm/PdVl5m5iSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGyXlXMro1mMiq1UyLPgAMTVab1TR0dP5LyzXOiRZnE=;
 b=ACNdjA/59e+NB4tZvgREFnqMfa8e4uC0LRAB0dxcauLNn+Hjkxy463CLLXW5DpWJjY6paIDmoF+kp/Gm9PQGiRkTXhNLpH3gXRFcyz2a/A40tZuqDppGGj75F+WWgoVzX0uX36IyjqA+M9SZosM2HQSm3qFTY1+68eFCvNI12YqGyqyPbUwS5IHQ+iSN+IFnMwLey0UFRTNFhMJSP37WyXOC+YPxHnjG4kWyRyaPl84Y8LClRUsnM3b7cnBLoRsv9X+hRqvVIM36voxfq9C/cNjROCs4fxu3SFHvJaXkKvObk18wRvC94qgam6G0Yw33NFmsmEKaQE7f5OgjtP8Xyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7495.namprd12.prod.outlook.com (2603:10b6:208:419::11)
 by PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 02:31:00 +0000
Received: from IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::f69e:f37f:2c20:1731]) by IA1PR12MB7495.namprd12.prod.outlook.com
 ([fe80::f69e:f37f:2c20:1731%7]) with mapi id 15.20.6768.029; Wed, 27 Sep 2023
 02:30:59 +0000
Message-ID: <ad6ba804-0a58-589a-ef0c-0a012c47d3dc@nvidia.com>
Date:   Wed, 27 Sep 2023 10:30:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH rdma-next] RDMA/cma: Initialize traffic_class to 0 for
 multicast path records
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
References: <20230926072541.564177-1-markzhang@nvidia.com>
 <20230926110957.GK1642130@unreal>
Content-Language: en-US
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <20230926110957.GK1642130@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To IA1PR12MB7495.namprd12.prod.outlook.com
 (2603:10b6:208:419::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7495:EE_|PH0PR12MB5420:EE_
X-MS-Office365-Filtering-Correlation-Id: 2737225d-62a4-447f-8958-08dbbf01c853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRhxc3riKU7FwaCiZq1cWCJWLWhLSNrXPXeFJHXtL87jpcMVobNi9PPQ46fJ3olkSbgZFS0KrOegKpDsYCTf9XXy6rl9aFXFpXuNrjwcMaYU0YKaT0O4lXYTdRPivQ9AU4Pdy2MxGP4FNZVZGycJ2Et56b+FxeG7UC8bh/8X8F0hvnyv5RYiGQRDQnTuw7YyqiC1Hey5nOyarkR9yJhjGhOJnJ86IYZrUA6xYzNydDY7dim8ABcVe0pLEd8VjCS9LJMK9vjrVIAF7G2n5YNABytYAeXKWB/xXZ7g+AXCGN+4GAG7ZYQfmNuyuZHgD2D05r3j9N04cnwkZifu1r9jvUPFmIFZYtFSjL6gte9CPxgJ4woT6KyA/DIxOHOd2vEJrR2G+fKZgjzMwlOraksIsk/TYKsMuBoSCM1xX940jLbWuENiNdYf/zPIpuGUGdUjfSVf4INJUN5EkQKaPPicdDF6oZbdm5PWzKAY2kiYA/htg1sj/UEbuRsskq4Cy+b5Gn8eF41qpn7L/v/evTcbm500nFwaqX3c+L6WvcyrFGUS8YEt+m+NNP3kNcrbdqgPdVoziyi7Z9YcvVICz4jQAmnlv5zASsyn/8AZCWeqnhi7NDaQWBk5zTrq/+tb+kcRIBlsT4LE0xSezWSmlHrIBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(186009)(1800799009)(451199024)(38100700002)(6486002)(2906002)(5660300002)(4326008)(6862004)(8936002)(8676002)(6636002)(66556008)(66476007)(37006003)(316002)(66946007)(2616005)(41300700001)(6666004)(83380400001)(36756003)(26005)(53546011)(478600001)(31696002)(6506007)(31686004)(6512007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0sxU21pbzhEMjdEZlczdGZWM2NVcXRSc3VrdTZZeDhreDZ6STBoU2tSZUxs?=
 =?utf-8?B?NDFPZmlxNFV3WGJWNkhJM1VwekJILytIalFpeXpuYklncys2MDI5ekVDR2Y0?=
 =?utf-8?B?WGpFbmEvTzFPN1pxVlEzeVhmdTN6U2Q0YXZrUnR5NXpLQUQ3OFhGUHhVREUz?=
 =?utf-8?B?T0F3TlBjbEc1NXljSU9PeEI5c2RkMjBaeVNiYkZUbDRKVktzZzN4a05Sd1U4?=
 =?utf-8?B?L3hobHRnQnJoRmluM3Y2MVlnQ0hXQUlpZDE0aXN0cUltODBWVWE4ZmYrYjZs?=
 =?utf-8?B?TkovL1IxRjR3SktnNlhCYjdqMzI2VDk3bWFnYjR6VHlEcEo5aFJnQ3dmRzBk?=
 =?utf-8?B?S1J1RllNN3NScFc2TXlsOUlMSkUzM3pRM3RVbFhoSWh1UjV2eUFKaXFwazdQ?=
 =?utf-8?B?SzN4WUxGVkFyWVhWQUFNaGM5cHcrZmIyWk9oNHZMQXFRVzY3T09ra3BLUVZX?=
 =?utf-8?B?aW5RVEl6MjZIbmZBOUQ5Mmwza3JDZHcremltNldBOXNWVEhodzFQMEo4NmNO?=
 =?utf-8?B?VTM4b1V5UjBwZmhibm5tUSt4YXVpTkswaG1wNTM2WHdldnNRNHVxb1ZhTVps?=
 =?utf-8?B?VGN4RXc1cjJ3UXBJTTJjTHp2QVVHaHF3dXZpVVFVcjJBaXhzaGFSekZxU3Vw?=
 =?utf-8?B?YlkxOSs0ODV5NmRHUXpIQ2pjTGRFbHRETm9qRjcvdVlkQk1McEJyTy9VZ3Ez?=
 =?utf-8?B?ZG1jNS95ZmlDTE9JYU0rOSthck5yTk15N2toKzdXUjRHd3YyMEtuOGtuVXVx?=
 =?utf-8?B?cWxwUGFyRVBndmI3NVdJTWRlTDRRd20veGV4MHl3ZFdUektQSktuVUVKYWFr?=
 =?utf-8?B?MUs0dmRTSWhUdHptU280Ykc0STFtY0xJOHdtdXBrYjVmMkc4bUhCS2k0OWRu?=
 =?utf-8?B?dlhGTkdFbWZ0Nk0zVXYrU3hCUnE2SzdjQmlrYUxaSnNRZkNzb0RuMUVYSkxm?=
 =?utf-8?B?RC8yUzlpRjFpY1hBblA2ZHF0TENaV0JVRjBpaTVxZFFoaXM5aEpNUEI0TXFr?=
 =?utf-8?B?cVNnYWRsbVliZnZFZmthRHNFZS8yMTlQRmowM1ZuSW4zSkgyY1Zqb3V5dFRV?=
 =?utf-8?B?SWM0VDhFU3g2Ym1xL21wcDFzb1dBbjdNbHZMMnJWMG9PZzYvRG5ibUQ5V2VN?=
 =?utf-8?B?SXYvSDM1VGlMRkppbURnd1VHUXM2aGNVd0hDWXRLVjlScXR0VDV3VjlObEVw?=
 =?utf-8?B?T2ZIT29ZNUJzM0Q3N2hiNHU3NXEwZUt2NEVGbXQ4WVZwTXFZWkRDQXFXWnpS?=
 =?utf-8?B?R2llWUQ4Uk8xZk9IK3NybHRNNzRuNGFwL0F5bC9NNjI3MnR2QSttMW82WUdo?=
 =?utf-8?B?aWppbHh5SmJsb1B0aDFwN1hrQ2QycUxMWHNrV3ZhcjhDbWkwdFJvd1RmalRa?=
 =?utf-8?B?NVNqeGhsOEtiRU5YbVR3RXJueUsxZnV1elk2UmlXOGpaRnEwbTd2bDVubWtX?=
 =?utf-8?B?UFhjMWZRcmFXK1h3c0pYVzdHQ1VCeVFISkJnb3FiSkc2cmxFZ3gydG85THh4?=
 =?utf-8?B?NkpYUjF6N2l0NzJ3ZDVmSmFCNElid29QVFRXaFZrZTNqUjBJVEN1T1dhWGYz?=
 =?utf-8?B?TzdqZllyQ0JKaE5EL21YNlZZNmRiVno2WEcwMGNyckdLT0ErQmt5eE9HcEJF?=
 =?utf-8?B?cW1GWkNrRVM3TTNkMUg3MEpidy9GdnBCQ2VHWFl5eEkvZXhaVVlBSFFwK1Z0?=
 =?utf-8?B?Ymk2c1NaWERDc0orMStpdUxFRTd3Y3JPbTRpMlE2cWhrR1NuaVN2VyszV08w?=
 =?utf-8?B?bUlhOWU5UkROYk9pem95YkFWQUx4OWwvbm1mdnBjNUsrSDBqQ1Y4UVdCRlVL?=
 =?utf-8?B?Z0M2cWdIaFRiQU9JYjVlM1cyUnBYRitDVmNOdzkyN3BQVE1MVHRoa2FKU1o3?=
 =?utf-8?B?d3ltMW4zbzRnaUdzM0p3UDBLcmZqVVBIbnBhd2JQS3diRmg3T0hNT2dUaHFy?=
 =?utf-8?B?MU9iNGwzNG1Bc2Y3RnB0ZUVLeTVWS2pBQ21Bdy91Y0RjT3AzaVozcHkzUUJj?=
 =?utf-8?B?ZGN6US8yaWJMY01MbWFJMjhsT3k3MFNkdGFJaFMxakdiZk9WNWljQ3A2SFRI?=
 =?utf-8?B?a3pPbitBTnhua3pMdHVhM1BRNkFCaGprUXlHQUlHS2g1b3ZXWnhsTEI1WFpQ?=
 =?utf-8?Q?hL49exrgF0WDUJ9FpoBxOuTsL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2737225d-62a4-447f-8958-08dbbf01c853
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 02:30:58.3333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CW9lUPJbzuex2ZqMZTsCnMd0sI3CJI5cwHisIbtitouVTGM+yi85b1SybCzoDpNJbHRNNCK95mGbLq5nwRuJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/26/2023 7:09 PM, Leon Romanovsky wrote:
> On Tue, Sep 26, 2023 at 10:25:41AM +0300, Mark Zhang wrote:
>> Initialize traffic_class to 0 so that it wouldn't have a random value,
>> which causes a random IP DSCP in RoCEv2.
> 
> It will be great to see call trace which explains how. I think that
> ib.rec.sl has same issue.

Yes ib.rec.sl and ib.rec.flow_label should have the same issue, I just 
not able to reproduce as somehow they are 0 in my setups.

These fields will be used to generate the ah:
   cma_iboe_join_multicast
     cma_make_mc_event
       ib_init_ah_from_mcmember

> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index c343edf2f664..1e2cd7c8716e 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -4968,7 +4968,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
>          int err = 0;
>          struct sockaddr *addr = (struct sockaddr *)&mc->addr;
>          struct net_device *ndev = NULL;
> -       struct ib_sa_multicast ib;
> +       struct ib_sa_multicast ib = {};
>          enum ib_gid_type gid_type;
>          bool send_only;

I think this patch is great. So what should I do now? Send this as v1, 
or you will do it?

Thanks

> Thanks
> 
>>
>> Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast join")
>> Signed-off-by: Mark Zhang <markzhang@nvidia.com>
>> ---
>>   drivers/infiniband/core/cma.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>> index c343edf2f664..d3a72f4b9863 100644
>> --- a/drivers/infiniband/core/cma.c
>> +++ b/drivers/infiniband/core/cma.c
>> @@ -4990,6 +4990,7 @@ static int cma_iboe_join_multicast(struct rdma_id_private *id_priv,
>>   	ib.rec.rate = IB_RATE_PORT_CURRENT;
>>   	ib.rec.hop_limit = 1;
>>   	ib.rec.mtu = iboe_get_mtu(ndev->mtu);
>> +	ib.rec.traffic_class = 0;
>>   
>>   	if (addr->sa_family == AF_INET) {
>>   		if (gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) {
>> -- 
>> 2.37.1
>>

