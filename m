Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576501D676F
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2020 12:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgEQKhc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 06:37:32 -0400
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:26117
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727081AbgEQKhc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 May 2020 06:37:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2JJU89g9FNS1fBhPsgIM8Q6nzRX/R7CplYU1TIv4PX5bknjWH60GZTHo7pwWvuSBau8tMrBr4UKQvoNi3lVS4zhmVBGbAoV1ZKy6qtT7eZgzqqRQjvklivAN+sWhSL9/dhulLKJAYPg9U3XuVrt7HpOXzDvmFBgTjKinUJ9HKZcrScMq2EBAdM9vhNkLdWgwm5Zb+RX1CnU/Sut4Y5UDI7YxlQymi69P3u22uyKRMgHdXORu1fLc7SiFa16L+7E42FNpQvHAXFXGA5xsBQ2nLeXzHJhKYyAz0onjani8hcciGh9Ac7eWgk1w1ltIHRf9m38rOArG5PusZuWRObBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHBN1RH6n6fa81d//NbhntRa9XL17aUwyEaahLsve6o=;
 b=F3ccl+Y3esgo84STgEJrfS+jiUhWpVUe3isLT2OC7ZLx08/3VoxZAbR92g6JOX5E+dtpBEKYhBtxLlqmVEsdtv/2MHlB3exWr6PB8NAfNXK/AnTyzK3vkCHdP+bT4zWvzHBIrPbR07GIAFVtcq/hvyVnbhqzcX+zzSy2T7zoKFPK6fQbpnM+b3EjSnr2FfFM2PXnXnjD/s22U9LEB7IpUAM+xbXggx8SSwB6bGfJlZbocTFDUyjIa526xuVeZhaYYM/EdI8NGp+DqUbe1Lacx5dVrdE0SQg5JR8sCu3oo5HALCL0jKICFJI38lLBgKv3/V7OW2/8xWlfwE3bbT+dUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHBN1RH6n6fa81d//NbhntRa9XL17aUwyEaahLsve6o=;
 b=ORIC9vUjtwabQMWlK3FmdLfrsrPv4Zgh3fqHnU7diGb3OW2s+QCQaMU8f7RuazUnO63PGYykG+To0x555On/HvjpQCFX1wrSld9b0s4QqbtQESJTwBAkd/CD3wCivgyu1rAAh63pzTxs+APA0LFTSMNBJMFzIWHNWYcmqMXyHKY=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4148.eurprd05.prod.outlook.com (2603:10a6:208:60::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Sun, 17 May
 2020 10:37:28 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.3000.022; Sun, 17 May 2020
 10:37:28 +0000
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     Gal Pressman <galpress@amazon.com>, bvanassche@acm.org,
        jgg@mellanox.com, linux-rdma@vger.kernel.org, dledford@redhat.com,
        leon@kernel.org
Cc:     sagi@grimberg.me, israelr@mellanox.com, shlomin@mellanox.com
References: <20200514120305.189738-1-maxg@mellanox.com>
 <995f4a0d-4026-de1e-c604-ca56801e5193@amazon.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <6209072a-bd92-f535-3eb6-871c1bd69962@mellanox.com>
Date:   Sun, 17 May 2020 13:37:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <995f4a0d-4026-de1e-c604-ca56801e5193@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0109.eurprd05.prod.outlook.com
 (2603:10a6:207:2::11) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM3PR05CA0109.eurprd05.prod.outlook.com (2603:10a6:207:2::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Sun, 17 May 2020 10:37:26 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b471f17a-a7cf-4d4f-e42c-08d7fa4e4b89
X-MS-TrafficTypeDiagnostic: AM0PR05MB4148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB41483543EAC9B2F86EA2C5E6B6BB0@AM0PR05MB4148.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040655413E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2n+v20rMQvEQPOCwosZ2zbkUXxBNa6Q3ZutEg9ghmsQXzs9OhxkSJhHYp2X6szXliIhN25IFNZ2jzb/jx+p7BOrrikStGBCh7ar67fy2JduhFrDt/un28UtiibAbia/+DoCd6GnZnntFZNHagZsxz3Mkhg0meDn3BAPbCbWfBRDJMBUsGtIBr96BuzwoMTgTQgdWp7YypjZZYHPk06HOaSl2XaULcCG3lTxlSMyXbhphl7bT38Qc/CAfkdGFzbis6FyZ+DbmSU9KCU1RnTl3Ze+tXbnUaLD6JgJOh8e6aE1mngJF8YeQNymsitqmWwq47JCOnD1J+ulmIkvXPg6RVOEPdaX8fVQOvLPBn5YTCjq4y4qCkKfkFVNrqoBhanMj28G8aPXHQD89xFHJIt471U3rn0dRCFzodwmO1h0Ne2Pm+XhQ3TjSCOQunfOcAA70O7qQhUcvG+dON6T/F/Ae2UiVvwLbD1uZxfARU2dQh7wUc72pOWbCxcwpO+nJvT8G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(107886003)(478600001)(16576012)(66556008)(36756003)(31696002)(316002)(6666004)(31686004)(4326008)(8936002)(2616005)(66476007)(66946007)(956004)(2906002)(6486002)(186003)(16526019)(53546011)(26005)(52116002)(86362001)(5660300002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yJcWtgX+pJrTzERbkURTtHmpp/+oHUBmE20LWjloexQ63SDkVsFRIZBsO+eBZGGrv65tbkFy+QB04j30v/fYgIBwfkljcmnHkX/YeS6ZQQryMYUMT21pX7tgJeJj3Hhj6lna2AcHwvw/4vyK6Bn5E0cAqNQkG2O2hTpz1Xu0k4BrSFpaGpOEnVQGCFBF86gyPwTlYXv8XwOMJzNMYzKMhH0yVfq/npnASXoTB7EpHkfZPwG13JDG4KIsgsrYbAOCYgY/Q76QW5ynU2me4Z9rAsXwjFinUBcpfpQ60iaMLrqmQ5eW0rMGEXKSOX2s4fXf/1LwWWcPXaMD2g/I3RNnysG6LUGD98yhS3Q5lIU5tDuRiEorznNE8/7DPnUrkuZXv/jyN3xF3LEkv0PrWcR/TlGqTDc31VrE2B7iZolP0CUSIUYAxcpBt6acXA0zTb3E33JcC01pKPHklUWXblyQEQ6CDpXJ68KvZyMIJJ9fQR4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b471f17a-a7cf-4d4f-e42c-08d7fa4e4b89
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2020 10:37:28.0534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOosFaXh57PL3ckLxqqIJjL5tQUwlZY2719JNd4LJK/66zkWlgC8YT/ZoAsmD/Vs01LFDx7AycuTiB8hcX58uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4148
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/14/2020 7:00 PM, Gal Pressman wrote:
> On 14/05/2020 15:02, Max Gurtovoy wrote:
>> This series removes the support for FMR mode to register memory. This ancient
>> mode is unsafe and not maintained/tested in the last few years. It also doesn't
>> have any reasonable advantage over other memory registration methods such as
>> FRWR (that is implemented in all the recent RDMA adapters). This series should
>> be reviewed and approved by the maintainer of the effected drivers and I
>> suggest to test it as well.
>>
>> The tests that I made for this series (fio benchmarks and fio verify data):
>> 1. iSER initiator on ConnectX-4
>> 2. iSER initiator on ConnectX-3
>> 3. SRP initiator on ConnectX-4 (loopback to SRP target)
>> 4. SRP initiator on ConnectX-3
>>
>> Not tested:
>> 1. RDS
>> 2. mthca
>> 3. rdmavt
> I think there are a few leftovers:
>
>  From f289a67b47e03d268469211065bf114cbb1c7125 Mon Sep 17 00:00:00 2001
> From: Gal Pressman <galpress@amazon.com>
> Date: Wed, 13 May 2020 10:49:09 +0300
> Subject: [PATCH] RDMA/mlx5: Remove FMR leftovers
>
> Remove a few leftovers from FMR functionality which are no longer used.
>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>   drivers/infiniband/hw/mlx5/mlx5_ib.h | 8 --------
>   1 file changed, 8 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 482b54eb9764..40c461017763 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -675,12 +675,6 @@ struct umr_common {
>   	struct semaphore	sem;
>   };
>   
> -enum {
> -	MLX5_FMR_INVALID,
> -	MLX5_FMR_VALID,
> -	MLX5_FMR_BUSY,
> -};
> -
>   struct mlx5_cache_ent {
>   	struct list_head	head;
>   	/* sync access to the cahce entry
> @@ -1253,8 +1247,6 @@ int mlx5_query_mad_ifc_port(struct ib_device *ibdev, u8 port,
>   			    struct ib_port_attr *props);
>   int mlx5_ib_query_port(struct ib_device *ibdev, u8 port,
>   		       struct ib_port_attr *props);
> -int mlx5_ib_init_fmr(struct mlx5_ib_dev *dev);
> -void mlx5_ib_cleanup_fmr(struct mlx5_ib_dev *dev);
>   void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
>   			unsigned long max_page_shift,
>   			int *count, int *shift,

Thanks Gal.

This is a dead code regardless to this series but I'll add it.

