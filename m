Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159FB73BE89
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 20:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjFWSiD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 14:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjFWShu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 14:37:50 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2B9294E
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 11:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Icpw747poj4SJwCnvm6Xo5DUIZZ8uVzgUhsjG8lclNPfogRD76LnOJEZB6cKEdZL9tKtlyGlUa/C6FKQ2H6u73DnM6MhoQD3ar9ShiE6NGdCCmxnJ0yDSRvSlyJ+07gD4PyLba4hZ8XUKVW2stzCWHAHrXPQdEkgHZZc1JOIR6ax4qmwY2ftZsD8w4lnPnOQQ9eXtmEZnncGqqI5HpjdS6tklzTSJ+BFgu1tpegw/O1DRKEngLWhsbHpBIZZyh+3+6XwR7V6wlQWosckv1VsQPL10qqc9GNPfKHa/Ytyki/P+gBiHeRysBkTeKfXcKkWkonWcM3KD9yLxBjBbWrZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8geRPb0bkhXe0CKUuaKAxFP4oiGttGXEbB1HnQNiUA=;
 b=EkXkrbNe2kwbLqTL+J3Tbx4qSEgDxxFYCzJhLnOt+Aq4aqhaRhFqciYRxp5oMgSIWf9Ev4Yet5jIF+AR8TZZQ1CxWoG6z3fV6sMXuWyFx3LBXSBu9onxrJscyRHFO17EjsYpoPHshCEWTmI02tshxYXhoiBUMk7tcc3YtPFhM/z+ECpeh6tQpXvpkpmgUh3M/Bqm0XU2RT5ZD/Q3Q7FYwwgZTcM5r73YlgP9mvKcTgNU/LhAdjJOsBQk57UJkIzHJeg9LQQl58wLNoMsqPcW4MynN4lCDm3KJD4yA8W+TxH4c1q7bZw73QzibJMq3NlcaU7KkTEKHHG3vJLxey6V9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 PH0PR01MB6454.prod.exchangelabs.com (2603:10b6:510:1b::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Fri, 23 Jun 2023 18:37:20 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 18:37:20 +0000
Message-ID: <496bdd0c-a214-b9e8-86d8-2f5c5eea0db4@talpey.com>
Date:   Fri, 23 Jun 2023 14:37:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/4] RDMA/core: Set gid_attr.ndev for iWARP devices
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>, jgg@nvidia.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        BMT@zurich.ibm.com
References: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
 <168675124698.2279.15699248221119454150.stgit@manet.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <168675124698.2279.15699248221119454150.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0033.namprd10.prod.outlook.com
 (2603:10b6:208:120::46) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|PH0PR01MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eda4a2f-0561-4560-9c52-08db7418e098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6npZM8Z183F/LmcNevdAN9PqyAJIOBk1UztssohBXXpywe0KWNBMzfpmV9ypIlE1ZI3qwSfm+4Rz1UXFgM7KApO9DQga9bO846vsWicxBNwFuSf/7StKf2OQ2sQ9A033iB9eKLIOJeGl2rGvz0M5BB/7DbuBt4VmCQ+57Arkc3XEML2b7/K5KHUdqZP1mlphlJVeoKULfzSXNsPv6R8lhc2nEXpCqrmmYYYTb/NA5gDOAQGC6T4VBvkxFAqRFvB+Nv+SwXJBqVgW5VRyFwZYrhgP+h+2BtektZhWdFpkfGFhwvf7mZ7xGo87wgNZPuidbkroR9kgl+UdlVb1SBqllOVPtqrQtt+1KPu9D1/vNucgrdBMqz26uvAvh/M58X3Ib8GeNM2iryuVKrzRoT/C8Ppx6IA2II6RN/osR2CHkrYhfzg53wN2Sj4iP+KFrmw8n/c7XtvABhza19btjpCV4BEQ7708T2f34yP23JYstjykzlXfynzqg6jcg5/NeLKnsRyQkGCZaJqQc3TD9NO9MTKVjm2le8u1RcAWPvtZ6mMRetM6TICmgSRsHlWaulZfda0c98loLHrAEDU7ScZp+Q2ALPZrrUHJPICdBsh3d7jcY3bqxrRwhH4Gn+RSMMDDXO3GY5uXGu5FMgUPnFzwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39830400003)(346002)(396003)(366004)(136003)(451199021)(31686004)(52116002)(478600001)(4326008)(83380400001)(31696002)(86362001)(36756003)(2616005)(38100700002)(2906002)(6512007)(26005)(186003)(6486002)(38350700002)(6506007)(53546011)(41300700001)(8676002)(66946007)(8936002)(66556008)(66476007)(316002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFlyOTJUQmVrQ2VQNG5xM1RXQWJnTldVTUsvMzVsU0dpblg4OWJZMzY0eGhL?=
 =?utf-8?B?RnFYL1FXKzRzUmJHZms5U2s5akx0Z2dLdFN6UTdSRlU0c2VJeS96TzhkaGtO?=
 =?utf-8?B?ZnpJTy9SdXFiV1M1SURybHhJTTVGK2FoUmgxUGtHWUtJRGE4Z0FlL2IxcFRV?=
 =?utf-8?B?U2dTYnRldFNEbzJ2QzNWUmxWQ25JQStiSjE0bm9UcmplNlZkaG5QcmZrb0ZO?=
 =?utf-8?B?dk5xUzJVQVVvUjNudUdlWEE2SGh2Vm8wVUNlUXVTYTlzS3NoM0RkaVJOTndI?=
 =?utf-8?B?NDQvSXQ3Nlk0eVk0S29paWpFNnV5MUlZcEhrQ3U3RnVDN1BiS00rVEV2N0hw?=
 =?utf-8?B?Z2JvMnhrQXlvTDRVSUVsYjFqMGkzQTRCUzR2N3hwcTZzZWhXaEZHTWtkbFo4?=
 =?utf-8?B?VlljZzVRbU1heFBoQmtrby9iRnIvclVONVZLUk4vVEFSaVIvTDNLcldsNTRq?=
 =?utf-8?B?dUdJZmpvSEpVc284Zmx2bEk4eFdLNFdFaDFVQ25BM2FyL3U4ZzdXWmhPRWVT?=
 =?utf-8?B?aVJjUnprV0xzY1FZWDVRbDBYVUZoUnBKVGtoZTBKZ1lmdzBRaGc3b1B5SWRJ?=
 =?utf-8?B?MkpZU29xeDU2YXJFZDdiODFIdDFQQzh6T1hmeHplajFVdjhaWXFwQnlUd1Zz?=
 =?utf-8?B?OW9JVE1qTGtubjkvQVVWbjg2RzhIWm5manhWaXREWDczWURoRThDd1ByYUZj?=
 =?utf-8?B?TWU2QWRJYjZBTkMyMk5UZVVLdkdUUXNmZXhjRjJWaFp6ckVUZ1Z2SnczY0Fp?=
 =?utf-8?B?QlFQOEpFbEdMQmZhSFRtQjB3RkIvclVJQk9HcUJkRVBONWFUMGdDVThvUStI?=
 =?utf-8?B?MFhhd2t3OFBXSXZZeVo2Z1BqZEgwcE9meEtFZlpkNHpZQVg5WTRZQ0ppdyth?=
 =?utf-8?B?ajRlTENvS0wyWEZ3K2ZsN1U1ckdOdW00eFI4WmxwNGVydFNrbHVYWXhnSUlC?=
 =?utf-8?B?QjJKSER3WGpCQ0xiSzJSZnFNS2NKWURiT2hFOHFHQXRod2RtblhCWTRCdWU1?=
 =?utf-8?B?MkFwNTVJcTRFOFNwZ2tKalo2WWxsMlBZL0pERmdvMWszWm1sdmhRNXJLMXZT?=
 =?utf-8?B?dFVCemltaHFoVkM5K0UrM2JLaFRLck4zT0VmdkpMczQ5R25NTlRqRHJCUGZF?=
 =?utf-8?B?MkhYZUxSSlp6cVpQa1VPSDcrZGdiVFFMbXlyUXRlY3RuNFpScEljMzVWUTdM?=
 =?utf-8?B?eFlLd0lZeU9PK3NaMVBVM21KQnBxVUFyUitOSms2b3kwc1QxQ1BOYVN0YjNH?=
 =?utf-8?B?ekV3bXhKVjVodEpNbDkwb3pGcFM5NzBHbDhESy9EcGRxK3BTWGJOdTFQbGRZ?=
 =?utf-8?B?a2FPTzJvSERBb05tWjlQTGNVcEdlMEJ4MmNkQ0dnclZjWjczdGZHNUpTYVZB?=
 =?utf-8?B?aUd5TXFmUTcwdURuYUs2NTIyTGJVR1FPR2RPV0lOWDVLRU5CeHZNQnk2aEpW?=
 =?utf-8?B?WWh0S1h4bWhiL25STE4wdHE5eEdNSkNWOW9ZOUpWNGt1em9IcEkvVElEcnRY?=
 =?utf-8?B?WDR5U01Mb0dCOU8wZVZZMWNqVzNVNUE1bDc3bmNrVzcvcXNOdThZTFpHZzlu?=
 =?utf-8?B?eGpUeXNONzVVeGV5ZHd5b2Z0MUNETnZTS000L3MrNGtvcjRTZ1BOUVJ2WDlr?=
 =?utf-8?B?T2MvNlZlbWU2RnlnSmFXbWVqQzNiT0tRUll5ZmVEYTluZnFKWGcxbTRzZ0Qy?=
 =?utf-8?B?cWNDRHAzNHRDbFNzT2RLbWVaLzQyQjFZQW41QzRneDB2dTZHYlBqRUlCU0Js?=
 =?utf-8?B?QXJDeThMd2dKU0NmNFEyU20vdFVmVWltcU0rNkdXdm9PRjJYS3FDOG1XZVhN?=
 =?utf-8?B?ckNRL2pPVGprT2xTNmgzYUFvQW5tMW1FWmdCWEt6Z2hoQTNGRlJYbEZ4emVG?=
 =?utf-8?B?dTd6SzBsNytGSDFuYVRJN0EzMzVneDE1Y0hTMG9pQ1pXcXBXdURCeDJBdzJv?=
 =?utf-8?B?UWVOQVNsOFQ0ZGRJTWtORVgwUlZDVjVFVkU2dDlJc0tEcFFIdCtXU1dPc0Fs?=
 =?utf-8?B?bmo1R2d1N1lEUHNGSnk5QWc4UTBjYklOYUpyRm1YdXJSZnpSWDhBSTJjdzZP?=
 =?utf-8?B?ZlBBcGlsY1VMQ25WeWEzZ09rTkJFalJsREZhOFllQUJCR29EQkdKTkZ3NWhm?=
 =?utf-8?Q?bdHvwgY37R2Gwo152hLEtSnQ2?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eda4a2f-0561-4560-9c52-08db7418e098
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:37:20.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j0A43Fq5DsCBCHVs95m1GRAQm5QTv0mZo0gqV3EN1tNv166jEVBRgvM2gdxpWxW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6454
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/14/2023 10:00 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Have the iwarp side properly set the ndev in the device's sgid_attrs
> so that address resolution can treat it more like a RoCE device.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   drivers/infiniband/core/cache.c |   12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 2e91d8879326..717524fe8a39 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1439,6 +1439,7 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>   {
>   	struct ib_gid_attr gid_attr = {};
>   	struct ib_gid_table *table;
> +	struct net_device *ndev;
>   	int ret = 0;
>   	int i;
>   
> @@ -1457,10 +1458,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>   				 i);
>   			goto err;
>   		}
> +
> +		ndev = NULL;
> +		if (rdma_protocol_iwarp(device, port)) {
> +			ndev = ib_device_get_netdev(device, port);
> +			if (!ndev)
> +				continue;
> +			RCU_INIT_POINTER(gid_attr.ndev, ndev);
> +		}
> +
>   		gid_attr.index = i;
>   		tprops->subnet_prefix =
>   			be64_to_cpu(gid_attr.gid.global.subnet_prefix);
>   		add_modify_gid(table, &gid_attr);
> +
> +		dev_put(ndev);

I'm not sure about two things here...

1) is it correct to dev_put(ndev) when returning? It seems that this
may risk the device may vanish when it's still present in the cache.
Feel free to tell me I'm confused.

2) Assuming yes, shouldn't the dev_put(ndev) move to within the new
if(iwarp) block just above?

Tom.

>   	}
>   err:
>   	mutex_unlock(&table->lock);
> 
> 
> 
