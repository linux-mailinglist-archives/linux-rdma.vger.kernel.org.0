Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF3A414908
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 14:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbhIVMjW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 08:39:22 -0400
Received: from mail-dm6nam10on2105.outbound.protection.outlook.com ([40.107.93.105]:29216
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230171AbhIVMjU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Sep 2021 08:39:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiUCTTscDqNLxGaW6QGgb4iW0lf8kNsXcEJTtq5UMz0QH20OSLDcx8ezepG8Kdov2CuNQhaAVoB1Gk/kBGYxOC7a8r0GjprRLygJG3MvfUnmjfv+GsVLD60ifFDGJV773sFH81f9menSLHAg2ELL7tc+xqoDHMjbzdtcbzr8e7mf1pCP8RptWXiiQwHIQS/ajvNug9kzGKhKaUdN2BTGax2kX5/TYxUFjarRMO01nOMJC26c5IUbDKaBTo7eU/XiErlglqU0OqTmcJk+UGI5+akjV1LcixM1fIxWU/syva6kZJQHQ+TZ0b7M7YJZpSrIIRdhBwmcheUO8IHh+2auEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=K4u3yl+AhFwzsMkrGjImyQvVfFs9bwOJNX8uDFcYyv0=;
 b=MfiYnQMQnTpcsshjYjgjoUAA2Qo76EBcD49y8O9rSuvq7rXrN2aqtVeOT12S4T2FXdh35C14E2Pe2uWIDHOHFSOWtT9Z3ZOxJdh65Zsas+gkYEFWrfvX484OdrSzQkor1/da2hnjaAs7lt5CGjq7VWnQwhfdwvlZkIeAnTpAz3n/O5umFIUcZBLAoA3T4OgxSUBTo1Hh6fthFDGBw6YOghG3WbehUX8UnzM1CLAe23ZTe1VVJ7qiJ5EpmfPptZ0fIe8l8YA66DSmLlDijCB3CBiu9FWcNp4yHjW21IoFKMGwkoxUkNKNW7qGxOj9BIxfEwmYfHkbKiyKlTbnHGMVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4u3yl+AhFwzsMkrGjImyQvVfFs9bwOJNX8uDFcYyv0=;
 b=ge92Ncm2as/SbC+Stlc0s0xzJpVrVTtPezdawNSseMfsh182YE9N8heLbKJhiKXdkEkXloMqUHVfZMB0PRw5J9dccY/Vtajf6YDMJmxhdtA0IbG5d/dL09wMqFs3dpymMooifzpiQzdGoOary7hlcHzUMqb7kg/SMbVXr5xNnsb5tkIA0VzT6n1y+irUUK+zMTYXAiqtdDNjQwFoJ/J0CxbTv2xQCZjU2CWeo73PDMgLmon3y5yPcFOki9wn4IDjp7ieDrZLlhiqt+diFK9sDU31PWQEEt2OPoled7U/JDjE9BBRbi760ioCNgst7c4B0J43uEBnzKETiD7jVJQobw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6487.prod.exchangelabs.com (2603:10b6:510:16::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Wed, 22 Sep 2021 12:37:47 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::88df:62ca:347:917f]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::88df:62ca:347:917f%6]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 12:37:47 +0000
Subject: Re: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210922123341.601450-1-qtxuning1999@sjtu.edu.cn>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <9b93b143-2dfa-56d7-e1ab-30945c1617c1@cornelisnetworks.com>
Date:   Wed, 22 Sep 2021 08:37:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210922123341.601450-1-qtxuning1999@sjtu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0445.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::30) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by BL1PR13CA0445.namprd13.prod.outlook.com (2603:10b6:208:2c3::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Wed, 22 Sep 2021 12:37:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3b8704f-0bd7-412c-601b-08d97dc5c829
X-MS-TrafficTypeDiagnostic: PH0PR01MB6487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6487CCA73E40F110E48EFD3DF4A29@PH0PR01MB6487.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:246;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeAEochqwhBjWYFo7iESbbz9TchpuCTokRiYQZi6tiDHQP7qi/1OGXDqG+fMAFikQ68cfW0LAsjy6Q6YC7mMFckqGvVCy2Fx8eABAEhxdJiIguzxrQ9CLLcO6C26EzcSoKaeI616z9OBhJGgmCflkiQSWW6uOjr08w21lS/ohD/G0Vpn3Icu3PKOH21QVCR/TOHgXxpw+3EwnWPJjau2RYTVvdpQlTTP7mGz0rRLKT4ZtTKOBh4clesS+qCAOo7EYOdtt8Bz7ZzvHfU4BZTuMOtDQbS+UGD3jwA9DID+KBnzgwKas4wDsPoFZpU8nIcwJHWlmDx0RLXqelxMleaswncYuSTtrRM7YtG6H+JghvDJGz8KF6OXmHoi+LNyWy6ekW+LV0YR6Cb++riEr9aDBsB1NvXVBeqZbx1cOWB1vxmjfUhoOW7mx9pL0ly9fSiO03JMPFHj0UW6vNBXKybxquqXqQFOrAbvTKDGXLzS1pe55yxBfrg88hWwMQJaTFvLtuz6vyeWAxS2IbHH54F2s89U1GyaFPGihvGSNXRMqcMMiFlj/ZF0Z2ljuPwVg3vvWD/exkenyDzJrb2fuW/srM4E/BxNNSdQRGME8SXjnr6RKrSTzxWnLcaCX9ixd25Ob8aSuMi4MPIuDfpGXeqKXru9eEr7LsR3bYPjwnEMq+vxu8SomqqtMeM2MACerZ4N2+kzZT+JcykGc4ezj50dEYjAAbmq+UCniFQW/1CmP4Z8f+odEzcT/zlgpHSw6jZWt2WU+YEZa8k5TbsmSOiIww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39840400004)(346002)(86362001)(6512007)(6486002)(8676002)(4326008)(38100700002)(31686004)(26005)(6506007)(31696002)(66476007)(83380400001)(6666004)(44832011)(66946007)(508600001)(2616005)(52116002)(36756003)(956004)(2906002)(53546011)(5660300002)(66556008)(38350700002)(186003)(316002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDI3b21QWUR2ako4SjFJM1hZSGVUcVNwNlRFTDRSakNNWmNPbFdSRjdKOERx?=
 =?utf-8?B?Ulh2RTFzYkJIS2FJVy94YnpxRjRiODB2MlJtbllIbHpxYUlPcitUL3dJMi9z?=
 =?utf-8?B?MDlYQ1ZtYlFjQ2NCcUUyOWx1SmkwdUNyRE84Y05NajNEUFpoSE04Tzg0cjR5?=
 =?utf-8?B?Nys3cEZuc09WTDB5ejJhbFg4QkQwc09EdzYvVjYzSWEwRGpsMDB2V3VlbVVY?=
 =?utf-8?B?di93QWlwOElUMFFFNlpPS2VSYnk0U0tlUUZyN2Fadjhwc0xiaDNxV1RyWXEr?=
 =?utf-8?B?aU94T1ViWlVoNytIaFB6dDU1aU5lYS9qWmp5allKNWVTd1FiUy9uMEZxU3F2?=
 =?utf-8?B?OFN1MFhyRzlsVW1EeTlzbStPWG8rSVJQd05IRkVEUnVhVmhENmxMM1RsZ1pz?=
 =?utf-8?B?aDNSa09IaVJoVTgyNDc4V010bUF1WWpyS0hZYlIvejdnZDhWcjQ0V0oySnhR?=
 =?utf-8?B?ZFFHRGV3TkxSTnVXREc3UUpqMHA1bE1mK0oyMFQ2Ris2ZjI2S2hJT2pPSGQ5?=
 =?utf-8?B?cFZYVU11clpzUnFOWmpxZWlWMlREckE0eHNhbHp6cDIwaWFvTkVleXBxZUl0?=
 =?utf-8?B?WVRhNS9mM0s0SWd5LzAwV3NKai9xeS8xVFlNUmJpZHdwaTd6ZjY1VjluOGJm?=
 =?utf-8?B?akNIU2NMUUExK0JYL1N3cVFHTDUvcm91ZzVQM3RRTGVxK2JLdGlad1UrRHMz?=
 =?utf-8?B?anYxZyszMFFKbURJRWFTOW9DSnRNYjE3K2dYVW5BdVBTNjZGODl2SHBFdXJK?=
 =?utf-8?B?K3ZDdUtJcGtHRTN5VXprbnZnUy9NNHFTSTY2encrMFNHTWtTR3lDYnJ5UXhY?=
 =?utf-8?B?Mzg0ZnVPZmMrS3BZVk54cEEyeXZXZk8vV0hqc3JHMENpajZBM0dRZ2FqL29N?=
 =?utf-8?B?WGhJQ3BFMWlrUFptUGYrVzZ6UE52aW4xekM2cVkrb0hPcGpWVlU2dEQ5VUNl?=
 =?utf-8?B?cTlvQ2ozRlgrRzZTZVVyOEl2SWdVWnpmeHE2ai9CSTVNc1dhR3IzUUQ0QVFy?=
 =?utf-8?B?MjJ2NXMza25hVVFrYlFhaCt5UW1ka0ZrWExDekpTZ3BrRUphRHNpK3oyY3dB?=
 =?utf-8?B?MENYZFJ3RmczMDBBTERoS2dIY0ExbGJGNWtPSWRXei9ZS3Z4TGkzUVdmcnE0?=
 =?utf-8?B?SHRjSmpta3RNVGhUV1puQUhTcVpSNyt3cG9oMDBEUSt5VVF0M0ZtTExnUXI0?=
 =?utf-8?B?U1hQd1RQVEt2VGFyYXJ0SWREQnpzV2pjNzBWWmF2aVhyRWI2cHdUYjBEY3RE?=
 =?utf-8?B?TDRIeXV1SFJFUUdxdWkyeGVLekJrRVQ5QlE3Q0V5QzZDK0xXbFJOenZjRTFp?=
 =?utf-8?B?SmhkNWV1anV6T0RhYVMzd2tRaXkxR3JMSjJlU0pSRUl2ZXdUZnB4MUUxMjhz?=
 =?utf-8?B?M2QwVUNJSnJRZEhnSkZTVjlwTFFoelZoOWpZc3VVaEtjR3BibS94YlB3eUta?=
 =?utf-8?B?V3ZJckUrVmg2NU5kOFdmNVBLbnhuTTh3SzVzYWR0cHAyMUN4aVpLb3RGZkhP?=
 =?utf-8?B?bW9jZjFGOW9PMWJOTzJXWjJMMXFIakhyWHVmMU1kamlNcFU2NGRUOHBOTXZB?=
 =?utf-8?B?SDJHYXhBRWNYL1Z6cDRFeU82alBqSjdQa2NjMFMvK2RueXR6QWJRYnhNZkFx?=
 =?utf-8?B?L09NTytoaXpmd1grbU1USG10Um1udVVBNDBoakI4NGcrRDdEN1hJR2tJb0ZS?=
 =?utf-8?B?ZFBOckRubjNaVjFvbUcvUXgvcnY4OWh5T2tnRFNwYjV3Ulo4UkcwbWdOUHh0?=
 =?utf-8?Q?ochK0+bkGfOOM8QIhK7cKVAraikaIZTEAzCEz4s?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b8704f-0bd7-412c-601b-08d97dc5c829
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:37:47.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDt+YPcslQeaUwHicIToJcMdm36eXfZkwm1ZLk3vg315+dZ7vaAAYZfPCG4aaUEiEABI/OmMe12b+bIjfU5E3BbTsNRqKdryGhnf25nNrHAXN2aNcBOTcSGFBhrRUFrv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6487
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/22/21 8:33 AM, Guo Zhi wrote:
> Pointers should be printed with %p or %px rather than
> cast to (unsigned long long) and printed with %llx.
> Change %llx to %p to print the pointer.

You are still casting to (unsigned long long) though.

> 
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  drivers/infiniband/hw/hfi1/ipoib_tx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
> index e74ddbe4658..7381f352311 100644
> --- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
> +++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
> @@ -876,13 +876,13 @@ void hfi1_ipoib_tx_timeout(struct net_device *dev, unsigned int q)
>  	struct hfi1_ipoib_txq *txq = &priv->txqs[q];
>  	u64 completed = atomic64_read(&txq->complete_txreqs);
>  
> -	dd_dev_info(priv->dd, "timeout txq %llx q %u stopped %u stops %d no_desc %d ring_full %d\n",
> +	dd_dev_info(priv->dd, "timeout txq %p q %u stopped %u stops %d no_desc %d ring_full %d\n",
>  		    (unsigned long long)txq, q,
>  		    __netif_subqueue_stopped(dev, txq->q_idx),
>  		    atomic_read(&txq->stops),
>  		    atomic_read(&txq->no_desc),
>  		    atomic_read(&txq->ring_full));
> -	dd_dev_info(priv->dd, "sde %llx engine %u\n",
> +	dd_dev_info(priv->dd, "sde %p engine %u\n",
>  		    (unsigned long long)txq->sde,
>  		    txq->sde ? txq->sde->this_idx : 0);
>  	dd_dev_info(priv->dd, "flow %x\n", txq->flow.as_int);
> 
