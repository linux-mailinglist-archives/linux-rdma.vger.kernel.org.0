Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B42646566
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 00:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiLGXs4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 18:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiLGXsu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 18:48:50 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E5370615
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 15:48:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX/N9oHT9BsB8UqfOA510gJeyLdCoZygEnm4FCugHqhVEATccdGX08rTE2H/zgke7jOk9TExNna+cwW2g6qPRK0G8i8NDBxP8/S+coIjO/yxrXo20DQP2ZOGRLdd+Ohv2XxD1PUEESG8UJB064RHU5s0Ama/IJ/0wkmbzH90IZeHvOfYPjO6uZoYoo4hqy+5yK74cjMiY2+6bRYh0dtH3Loy7TJpSjDb1mQqFgbto7n72pOH3wYo5Qxax7U136b9syJKxomvO++O7ulxgbmF9wEgsJ5OFyzEPaXVFcxZJw22tmnxLvdbzXwbAI9eI85SY8drseimO6+3e8FOD0SaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMg2s0+HFqvkkWmk2WHj8QK/RMVAw4i5p9O6dzxcJto=;
 b=PBFtPmlCh9S4J8w9vsgvMKRY85CDx/GJCj8RWb/P6uNkGr/Ezbkm+v3mp0qAATD4nqjLyBHISvcmUv7UTb4bVmN1xf8dgMvXrFkiQRZGLCzLTFbJLEZNEqGfDCyZYw3ewZHl4ryXH8XJ/M8qszNmilaixf12oGQOaV81h24f23eiyT3CruzXmiRsobGvXVAkSBXtP5MjTaDd0Vyvg7pIa71urIXxDMmfCJh+I1XrIq/ozbSjoxBeReDxxKqfnTRFwSi3z5Kjih9swUTYH3Bmuy2dxm3wqa/PlKNwZ54mh7EH18wrzPMOeAoqqTWlNeFsuRdNUHWFUDfxTZmXnbYAOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMg2s0+HFqvkkWmk2WHj8QK/RMVAw4i5p9O6dzxcJto=;
 b=fwPfflpQrJcXVgCK82leHywHs9ofxxdp1rmU0vLKR4y/4VRu3B+kJOuDn6nIYB415AsBYixf6WkhiJQSQp3gR2FA6g3HbYV1e4dV9Tvtr1NhbjTgRsfSEnxmS5j6+2WwctITc940YlHNa6MNusQoVubnkrE1eyCJiwEPeOUMg4orPnHXT+ll6Wvzp8kqBZP844FatgzsInxH05Mvvmnpg1hm1+MfWKZH91fCmsRaJAgJ70OCA9vyzRmfqYMwmhFgUGjIo2GnU723nMpa6wQ8RiPZovcv5w8OTnCutB3wxx1vyvi70EbH6xljEdg8NLWSXUgjQcvlUJm5vCvnp4f8cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 23:48:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 23:48:42 +0000
Date:   Wed, 7 Dec 2022 19:48:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chao Leng <lengchao@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] infiniband:cma: change iboe packet life time from 18 to
 16
Message-ID: <Y5EmWTRqSJiNyX76@nvidia.com>
References: <20221125010026.755-1-lengchao@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125010026.755-1-lengchao@huawei.com>
X-ClientProxiedBy: BLAPR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:208:32a::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f4195f-b473-4de6-4863-08dad8ad9286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFLm3BPASlufiNB8s244kLRqiWmwsUg06/FxcE7PIH8IuCKD6KW4dsiwbQD9MgCbgaUjZ4fpdKQml/SmA79EpdN5uoBODQWP5XuIEoua8FhKSaLM7zJeFRGsOo2X0TX6rmLynAjNNpzKi6XLRhokMuvhO5l4O+xuNz7WFJHX3MTKEvZolHG48KoYR8cuc13e+OA1FsmEMQOJcE52lScWV6/DOjZMcqKd9VbScZlFTKdZPsH3z6cfx/4kkDP0yVZwfCZ3yhBvHazDnhxeV8018md7CVey5fAUlXMmdG13Dg7XY6Tfo/tf4hwPNhtEd/IDhVh2gBIHfU2wWVGHKDFRtinmEX14aeRXbIkZ7VTFj1SSFBpSvW0Ayw183ERkhwR59FmKfDO5aGJE3dtDIFa7UO9uMSY4Sq7UDcJbau+RjGOlk2lnJLpgAAd2sxm9BexvWzmzDl9fugjEw3YKd/vXZ3hBxXOHVJKoFitsX9INWXj4Z9OX9FUMoNfqZ2Eh50hevXx/P7B/vOzhny3h3EtS/NTsBYvX9KewUotLnJxh41iTu3tl+3aOgvXuq2qblzPGU4IUWi1T3xfeyBuRioVA60s66DCOJc+Wqoj4cxlbzm2w2pEnYMKs+NR1I2u6yYAWmKQPzO33+ST63aInsL8Zxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199015)(83380400001)(5660300002)(41300700001)(186003)(8936002)(478600001)(2906002)(38100700002)(66556008)(6512007)(26005)(4326008)(6486002)(66946007)(8676002)(2616005)(6916009)(66476007)(36756003)(316002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BMBamTnTaCD44RwxIFNLh0uocq21pZqlDFnSSSMUeLac7P4K2Xs9hnNIkXIM?=
 =?us-ascii?Q?t4kI3T5xnbUxXap3JBz0NBfIEl2XmFUtB8m7BHMpvB8hdCg7xPOQH8U87Lfp?=
 =?us-ascii?Q?U2WZ5okyejiW/ZG+YvNK5SfWvhfb+8bb2dakPbnnPRcjwWgO1qNyvH+m3aKp?=
 =?us-ascii?Q?3zrpltFQAr0i3sZ7BgPzxfrV/ILZIurdXmIeQGkHfDrzhuhC0VwXLF2O7GEB?=
 =?us-ascii?Q?jnliYZrhRD7hgKKeBswweJSgGVn3jWlnqwwVHGWXZSfWxwUyAQVQlTtmHZLB?=
 =?us-ascii?Q?NHHcct7BL7YiUuuDqozRm0XlWRdoRgd5nDN7SHPB/IUWws53XGmQu2R/wJtr?=
 =?us-ascii?Q?LmJXNcs15VQ2YIcLaCJRPhTRER6FRWpHuyjo8qvj/9Gp6gQdGt8F4VslL51Q?=
 =?us-ascii?Q?rJ4RQNIzUcTL+fodLUPQAneHBV2GLxbUYvq8O2JwK54t5IYhMuhbqtEXrwUg?=
 =?us-ascii?Q?pTxtBxWgao4CF493/SLtyMdfvghPbvO2QHemc+fPv1R/46yPb3R1hiNBzOg2?=
 =?us-ascii?Q?FU8yZ9bgHQcR8DrRFy4oc1OtfIP6c4+ab15JYIS2cBq9z1htW8irN2HYnW8q?=
 =?us-ascii?Q?3DG1ejtHwJyHwgCZEsGtOEfgSrFT8CHTMLQLuNVTtt+s4wC76pIDBgc2zjHE?=
 =?us-ascii?Q?04lw9WGBgnWohGFCy3CEjyfL6q/TFMSQLgeVsDgQLHsiymvgVktvhogC12jY?=
 =?us-ascii?Q?EBjaYT3lU4fLe0rbBR26Cq9tplEhpJYh3yEDVxTCwuJVQ4X2DxUZtjcly1TA?=
 =?us-ascii?Q?YFBs5PxEJEzTNGHVEk+LXH0k5lPoEZEOsG59/MHa3gOjFA23vNVRxjqKPxHq?=
 =?us-ascii?Q?vUbuE1NYjsejB5XQ7zrf5AcMnDpTDOOTX8g6UWFKrQS8UTZMO1V1nvGwbEHq?=
 =?us-ascii?Q?4QieWEdxs9ZoT4QQX9LQXzpFPhhOcV4fQA237i2gOR2hUgEEkwc4BSOelpVv?=
 =?us-ascii?Q?PpbukAlNogDpwcGo6Cgp1k4nqtTF+A7tuTWsTpqoUlPCmvqh25t+52RPumgY?=
 =?us-ascii?Q?v14UrZLh4SJeupMook5azOl3CQzlAI0Xj3RwDh28fe35Fea1dPbO+BEEs//F?=
 =?us-ascii?Q?srvXXxXAQ7FIKtliajfWLYF0mrHY4EvyPd1z0/D3GuWSvKKam9XuEJ8um4oe?=
 =?us-ascii?Q?XtSA6hT8F2VmQTzMgi7cHWDhMu/xCgYHH22yk+sNLP0MiGlfXX9ifFJzOPrA?=
 =?us-ascii?Q?TjoBh1hHNhaI7FcoowLks5mVVJtHRmn9tFQSDnydGKUqFGs5FOmf9ZQQZPbR?=
 =?us-ascii?Q?NdQTFR43Oq9XnrtbS//b8KMrdaxTdGGMqT6ErmuK+TZTMuRGKTbNo6Xq5rnw?=
 =?us-ascii?Q?Jhnl0eMLfCYpghQIvUFtkHvBK9ySNtpx9k5gKoGtF8AUZmzGgT6TZ8bVDMRq?=
 =?us-ascii?Q?3H3zMQ6KczpZA7QNI8wy517jt2z4HpNS8hIH/ayGYAdDRh5XLxnNh6GiqEw4?=
 =?us-ascii?Q?hvagJEUdOBAxM7SNXATfT543jD9Ny5zK/8sXc30+I8pLQeBpe1qEhy6gNqBp?=
 =?us-ascii?Q?WxgaKgHM9wRM1+0Z28srlfhHDz7ECnei85A0nDLCUbwqYcAQ7pDPjcgr+iQE?=
 =?us-ascii?Q?PrI1ZzCGa/LMrHKY4Zfq/TzC8NgUCOs2w5Nc6Lu7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f4195f-b473-4de6-4863-08dad8ad9286
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 23:48:42.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsoD1w+AF2V8sxx90yk/L5ER9y8gcKaDyQhgjq97Ng8cgOiOcYVE3qc/sRMW01wR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 25, 2022 at 09:00:26AM +0800, Chao Leng wrote:
> The ack timeout retransmission time is affected by the following two
> factors: one is packet life time, another is the HCA processing time.
> Now the default packet lifetime(CMA_IBOE_PACKET_LIFETIME) is 18.
> That means the minimum ack timeout is 2 seconds(2^(18+1)*4us=2.097seconds).
> The packet lifetime means the maximum transmission time of packets
> on the network, 2 seconds is too long.
> Assume the network is a clos topology with three layers, every packet
> will pass through five hops of switches. Assume the buffer of every
> switch is 128MB and the port transmission rate is 25 Gbit/s,
> the maximum transmission time of the packet is 200ms(128MB*5/25Gbit/s).
> Add double redundancy, it is less than 500ms.
> So change the CMA_IBOE_PACKET_LIFETIME to 16,
> the maximum transmission time of the packet will be about 500+ms,
> it is long enough.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>  drivers/infiniband/core/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
