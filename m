Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89724BBF40
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Feb 2022 19:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbiBRSP2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Feb 2022 13:15:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiBRSP1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Feb 2022 13:15:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC2635DFC
        for <linux-rdma@vger.kernel.org>; Fri, 18 Feb 2022 10:15:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxnYC4dKFnokBXH+uHteIvVeFpx47f5oSsStOC0hMfZeBEAMtUep7HXI+59G1oaq3CfGrC1ImETRPzjKzIT5OreR0uv7WCQGGKdQBEC4yzTfVw0ePpgkISFsXiFJirjYuwfHsh9Y6IHSz1F8wdn4kLEoCLXe2koslmiJhNz5kd2mP7kj8vUOJUZHQaNjbUnwDMXPKBEQqqjN0Z9D+qmK/Xm793MasESlm1/AihCa2zJ//Mb4sSwa9Kzj3x/6E9XnaKWVIINVg1WxXn6i1uUybYEolkXSZvmWYUmQiiqK2e9OBIh93kQ8FWYVglf1xxiylIBcuIvpiWwMxbyoHWOWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vgeAyYVRkXEvxbWWr2uYg1uEJZX1aZgC2CxnE+ws90=;
 b=FmS8g/eMw0/PHrCSqadSdMsGACF4T8aHYyZ4AR68dD8EZGa4HqX6WIfCtPuAdjnCvmxW9lzCp7c21Hhta08aY8SWOZyx1VWZlfG0S6GtApWbaoYhW6gSnp9XfYsG2HLT06g02drh7tDGXUBM3ur0oYqvj7sWBBcMaoAYTQeML9g86rRsTaehFStPLJjlrNveihpwaa9aqb+lP8677lBt0Dn6vzqbFH8LdIL9/ZqkSa1wVJGXcs33dOVjyYRQ1HTiaUYWm+PmLSB9DfFjeB7VZAVZGQBR/TxF4nAIiWl3J3CILcVo3KsbswY1soWxc60VZU0Kdley5+y2WWstSL9hNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vgeAyYVRkXEvxbWWr2uYg1uEJZX1aZgC2CxnE+ws90=;
 b=MuiApfI95ynTlmoLMp56ssWDtFfS3+xWNn1BRoTYEy6RARtNCg8AvH6XvJ03vi2Baki7VhdTEgiUG38XgqOAfcZB9ls6XcmF9HSAVZx4IpIyHk8BRcKzJSSiJlV0LrmAcLAb+Q1Wg6cLLwrNW5XqxBZsyztx7B5bjKmP+4c/4+J4JiV5uhJ2KRG28KPvOUp9JVJmsUW1LoLCktzQEZHNsoASc3S9ARUjGd95VYM/4+z6FDGG1pdFRqIVwW0U1WKBPt0n2bO1P3OWWcjIg9E6NC6RCGw8dWAgOxJCYmL/g2qhl/WWDGrjDNO363U+mUEg/ADl4Nb9iYOkjC61Egb8ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1935.namprd12.prod.outlook.com (2603:10b6:300:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 18:15:09 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%5]) with mapi id 15.20.4995.024; Fri, 18 Feb 2022
 18:15:08 +0000
Date:   Fri, 18 Feb 2022 14:15:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        jinpu.wang@ionos.com, Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH v4 1/2] RDMA/rtrs-clt: Fix possible double free in error
 case
Message-ID: <20220218181507.GA1668864@nvidia.com>
References: <20220217030929.323849-1-haris.iqbal@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217030929.323849-1-haris.iqbal@ionos.com>
X-ClientProxiedBy: MN2PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:208:120::41) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b68278c5-4eaf-4d8a-b9bb-08d9f30a98b0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1935:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1935E9A70447624CDE133A71C2379@MWHPR12MB1935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2H0A3wvGu8qIMA+nmzJIa2ofviuE7Hhq5GC3lJQmmJXVD+Pl02sB56j79/mHW2iH1bN+nnXABfQ1kC8rhcvhRcKauqUnM+OkqmDIvbIPsrcmswttTcEKqmgkJsnClKLiRJB1fVL8IRZQH8c2pzVbZQB1LTJDiWPhhEnMWumT/2uxon+M3ktmCVRRk/kMJXeOc4zqo2llwNtEiZDHRxRT46mUWaPaPZnhE34W1+x3bjs42JpEH9qEYc967GN9to74wkcOw8Gv9jeToSMsV+YsJU7eYMqRoSWqlaiPTQNqVKUeOgUL2h//mjgL4FNnMSsEbuJRWqyttXiyDjgF5rNDlTEiwNvx5swiJmYojZygrtkWHGuRT0pczePeV9f0W+NxJKBYYpx74ko83pyJxyMGQrCWLRuB82m+8A0+Gxe7/9nXg8Mq41pqS83c8siaXMwhz5pXtKd4LbYjd2J4yyKodgEW852l8Hy/5yRKfveprJvB1/bNnUZoEgddPuYjCGG1JBHXT4bash1z13fFb6pR5pFhWTjhesb+yvrHq73m0Yp0bV/tzV9v7l+4iaLcs2o5cyZiCKN0IltxhfpLHLzAfJw4PnZHDzciHweiP3qlOxEMBfoT76iwZ2q1Ew11AY6XDIYV4gh2hhKz6SJw6DrRHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(38100700002)(6506007)(36756003)(86362001)(5660300002)(8936002)(2906002)(6916009)(4326008)(316002)(66476007)(66556008)(508600001)(8676002)(66946007)(6486002)(83380400001)(26005)(186003)(2616005)(1076003)(6512007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jCmSDynn668v18qy4rp+n0O5RclYgVb27NzksMo405TGlEUwUANaNYyiQVM/?=
 =?us-ascii?Q?6S0gD1+2DalwCMYpajCytzohMdIg2J+7s8O32FeGKw1UKFyZeUEdTZGlMzjm?=
 =?us-ascii?Q?iC8KW4fkLItd0P+X+wcAJcBS/y49xiH26satLLOKyzwm2+ggqkegnsPOUkdj?=
 =?us-ascii?Q?HvELPwYjy1/CZ3Ibu/kvML7ejlPahydoz/WVCLKNG0vhRIHncDJiwLBLDehk?=
 =?us-ascii?Q?AZdQnL2JJXkKWbJGk71x56zKmHxLZdFVyY4eC3agouagIZiEfSulDS83YpM1?=
 =?us-ascii?Q?V26J1lKyF0sRPu+XHHvVlm5W2ZOkrO8bLOhhfSrgbywQv1G1WdNS3hz1gCMn?=
 =?us-ascii?Q?F5/vNHY/DFSoJcErGdR/gp4YaAj4NSPyA7b8qornAdTr7vvDte8polO2b2Ts?=
 =?us-ascii?Q?V2tuRLtg2YavMVfoUoA/8wjfugqN0RU1euH3vpODM+MEBB6u0w2lJEPdF5LY?=
 =?us-ascii?Q?zUwV1OLG0RA9Z/+j/Ipv2hzd4Rv45LE70mAqURpxrjsrwYu9m6by143+jpkp?=
 =?us-ascii?Q?Od4kF+AN7QCkGyPxUcxx/Cy5hJ2xhxm63f38T5fFoj8tILf4u6YLK+3yPXTH?=
 =?us-ascii?Q?58ZyN9rGOgRquGcLil8aXT+Y20ibOMm/gvxCAxIC1pNuy/ZKHDDglExqZ4V4?=
 =?us-ascii?Q?GDh0VjW9NcM/ZpsM5tVxjfzlrQsRbGAm+9cwNG7Q5z9SUatxEcmM2zvvGluY?=
 =?us-ascii?Q?lm/+CJQrpuma6Cf6Xi3QLCfYapjxX7yr8RN75M31LUQcGsWIGtTMZTBhQuGR?=
 =?us-ascii?Q?57jZYWZsb2innd/cN238BR0xLFZOc5FfzsqYvX+i+3PiYFiRnT5UB5eOZSb9?=
 =?us-ascii?Q?kJliltHZchz0yv0sZWicY1FOk2a0tvqOKV2/WQwXtD/W5oWldmYJ2rEhO6Tv?=
 =?us-ascii?Q?cKcc/oTwUf2+2lr6a1t5H/sqqQ6Qh+TJriUgMqkDnhwsLcCSdo6nZGmZaAv0?=
 =?us-ascii?Q?Ai6IHbZ3zZV7fvmtDQKm/+RxJwFXbkoteqt63MGrVbLzZK+XjpXPi1mSXZbS?=
 =?us-ascii?Q?FoNMFw1FvPv4irNHJuFlGMgVIpyItXs5QfFzyvSyHcrb4isUqPAy2mSLJ1H2?=
 =?us-ascii?Q?ElMg1xZGq5H684pIGsAYEXi0DPk85dR/Nby19STBUZj4qogX+f5B045WNSCl?=
 =?us-ascii?Q?OsYl0u2/2CTZ42y/uzDvfQbyHYzo8niDV4bYD01z2LdRrO7FdoOknNYnLv6y?=
 =?us-ascii?Q?nO72Q+TgJbK+7l9gGLY4vHNWay10VaYempJxBlkUw8PKKFvjIKElsuLevJgX?=
 =?us-ascii?Q?8EQmCrPMa35jwzJNfutH/JW3o/tpFyozq0ErVEQItfspyC61KYuKCHnRIHeT?=
 =?us-ascii?Q?E0Pi4cBHAfFJbP8wnpMPKckidhT9iLfzKIHTUmLqGuagqY94LYVdU7dbwoQf?=
 =?us-ascii?Q?Dim4YEwgNSCyAOfNBW8lDXks3QH6g6nK+y5H6/2ayrpwjt1JJlCXMmhpiflI?=
 =?us-ascii?Q?ke+hVrJsVnzAH32RvaUMAm+9bDXixa9ZgNcVZM4eLji25Jsz/GWTVitgSS7P?=
 =?us-ascii?Q?XONodVKFu4UU6XS5jsoWx0K8TX7FA8JJqMvSe/9DqBqq0LoSpcMinlflPQON?=
 =?us-ascii?Q?nRlr4Xj3V+vFSKZwOio=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68278c5-4eaf-4d8a-b9bb-08d9f30a98b0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 18:15:08.9076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqa8hiduc4ZCaldsicDhzA0t7ydHTKfARmDvAHnXXJUXNTAh7mZ+pUacIW9CaJ9D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1935
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 17, 2022 at 04:09:28AM +0100, Md Haris Iqbal wrote:
> Callback function rtrs_clt_dev_release() for put_device() calls kfree(clt)
> to free memory. We shouldn't call kfree(clt) again, and we can't use the
> clt after kfree too.
> 
> Replace device_register with device_initialize and device_add so that
> dev_set_name can be used appropriately.
> 
> Move mutex_destroy to release function so it can be called in alloc_clt err
> path.
> 
> Fixes: eab098246625 ("RDMA/rtrs-clt: Refactor the failure cases in alloc_clt")
> Reported-by: Miaoqian Lin <linmq006@gmail.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> v3>v4:
> 	Add Fixes line
> v2>v3
> 	Fix dev_set_name
> v1>v2:
> 	Free clt->pcpu_path
> 
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 37 ++++++++++++++------------
>  1 file changed, 20 insertions(+), 17 deletions(-)

Applied to for-rc, thanks

Jason
