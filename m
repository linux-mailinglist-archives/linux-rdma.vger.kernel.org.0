Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BC94E6819
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Mar 2022 18:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243807AbiCXRy4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Mar 2022 13:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243776AbiCXRyz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Mar 2022 13:54:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC64EA0A
        for <linux-rdma@vger.kernel.org>; Thu, 24 Mar 2022 10:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSrs2Nnb/yaxjzkgtyKgJg0SgfNro+hYZhPssSdmsTf72s4Nu0rBjfPOvqtTUNmRu97nlWUZWOCF+EBl8znjPgtJlMzuyvrZPGg4zgTDYANsXopD8iE7PNT4lZ2GhgL587uT91jGeXNlUS4o+H3ce3C7e9YZ1vsv9hjl3CCnUJwNVdg/vKZUH+GXV40ZgD+pxVwLdxGqNtW9UtIWBiQhidabsXK0O/5JC863ndvcX2KxpgNVghG3j+EeZkpsFUiI5KV17oXPL84Toyio9Uzv3aezzQXl483BolBZ76tHeB+THJSrWQyUiwGgYtJnFgRrRVJlSwNL2Unh/jXCkJysSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRiQWkQ8Y37Mmb+wuBeHNdeIli9sNqmv34uMxLxD0Hg=;
 b=kYy/0UfY2B393Mdc/bMZotA4GxiEsty6vYLqKs3l2VdF1ggliHNq9bWVxbeoXv62HXL8uD81IYuyhOkkwsDIBA+7ZjIFD08MFRZnjstC5fnxCAspq2kaqJGNclX9HG34XN8EdcYKML4Si//vXVsGzUtc5wxou/b2Na3S0uWOm8fIM3LuHZWEbffmleK/v1TzXPYo1f5dPwmpt20Fe2+0qCaY0vwH4w6y79LB8f/KEUJkULAMvBYMwXR5nnh7Atp9d1CvNsT17KJCWedexnEDkRHCpextQLTWjIKz+9x45XpoutMQUHu/5YwTLlzEZoZg9NKjPEDpcj3v4qthr2LAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRiQWkQ8Y37Mmb+wuBeHNdeIli9sNqmv34uMxLxD0Hg=;
 b=pEqYUTwAangirDZvfy5HBfG61XtwzD5djJzdOQjjxJaOn3vyDmmYEN1rHpVH0mr9POxcxe9BNevVi9NLoiUamMiZ/FPo2Op83TOvTsviBMaXAebDxTnJ1YwrFXt1uZxqi9TOgUPB0JMGOQuf82goAM9GqO7BF2lSzzLRawUEerGQTwJE1zj/2ymEMTsHEBu1LkF7QD2WI+2RWQgZo1vBnLKsJ+mfZGPkgfydwu1Wx5Y4BDB22dunauIESYMpdMUMaF2ZUYydgPdwsKBpUr9cKEA3tX3AQ/wOUVsybtiOrQdJwG77pi6mcGjndUt0qMua/KyOyxOh8Q+U4zv3oa6EmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1122.namprd12.prod.outlook.com (2603:10b6:404:20::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 17:53:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 17:53:20 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Leon Romanovsky to RDMA maintainers
Date:   Thu, 24 Mar 2022 14:53:19 -0300
Message-Id: <0-v1-64175bea3d24+13436-leon_maint_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:208:236::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17ec0928-7d33-4746-eca8-08da0dbf2ef0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1122:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB112261AA501DA2EF675862BAC2199@BN6PR12MB1122.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXSCYpRYoaIzwLQIrmJu+mzNepIfwOo0nLi0lbuKZ0lgwf/SNfvpLqAlu06cuY5HCbwxTR1polbJHqVq5gFidnJHgyYMh6prqmaSwUNZQ4m6Pbh8lpSMxKKF/S/W/LaQ7X6XVgexBZJLPRunfY6fuZa/ryut3Kq6u2Q2MOHp3Gx0DsHGu/UhJCQ9NqF6Ch7o8zD2Ts2ruP0h/bmvv6wDvGcl7JUn2FwgMUNPPPNr6kAamn9q6u4btojgHZq707Q25pFFvtm5HZ0jTELFmeJxQl310aw9pcyapNOIY7JUsV2lymEvWa4R9lpw9RzDh8HZI/tewWim3l1cO6gu7NpHZ7Ogtor5qh/qtJWstKN9fzYYUyKD0lOwVqrggxlTwKQhi/AoMQLrMTNIl2/FrDmbgOSBMkannTyRcxRTvwxVqP3WrR3UY91fFJZKdzhUaOlOkod4Erya2AFcouwLHjCYNR109R5rhP4t4fMyU4E7X2FFpUGqy1csxgOpM6LumJtUYhiaMRkRQyLlvh/9+cNy6YKtp9rSW6SCDfBTVxbjhZwa8bxXIBKTXwWRAVh4rHKROaLg0lLaAD5T7UcYYC8M0wzL/AkAySs8aOndtJqeq3DCj1KKx30UawtiN+CY068oVx7ovHKCs6ODqkpQitoJOkoMOLXZTH0ugXqG12k+sdqAX+PKHW6pyOpLzRXdPTkYbIWJdZEpAL2aKBhBNSx2lOEwZE/go8sODv0BiB/bVkrWMVMD7HhZpyV8rCQwOCdimnP/W9ftzaHgjPWZMV18Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(5660300002)(66476007)(26005)(186003)(8936002)(2616005)(6512007)(66556008)(38100700002)(966005)(6486002)(6506007)(508600001)(316002)(8676002)(86362001)(2906002)(36756003)(4744005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EIjHzOFXIso6x6d8ybNAnfdQx4flsXwLCGsgbvOsfI5xIqcJFnIem/MdB7DW?=
 =?us-ascii?Q?sa5f13q7W6aXJfAQ8L5kUNef6fBiVD+FvB3DEZeC1oZ3MZBvEZplwbfey4xs?=
 =?us-ascii?Q?g2RjTkdn92JRXqBgBNSaGomq+KFBeQYXTaVc6BNxC5OLqu9Rc43NrEouQEJt?=
 =?us-ascii?Q?aCKU1iIu2vopwhANmFMPGHLKpOBZtJ+blEKpqgl+3Kr02Mm4rMHxAk03w3d+?=
 =?us-ascii?Q?Sx35NBdSZPWkaKD6NobvaEuHvsM2K8EnYL90rBF3X9juT1O3w3Fs6Co67v8d?=
 =?us-ascii?Q?quA0U10/I4HRnb7K2Wfooo1nr0sXR0+8iTXKUefjN7NxkTLManXBiARkMpoV?=
 =?us-ascii?Q?//z6GJE4ZjnxgoNo9rSy3wsldG3xdUr43Aqd09aYeoM1YMpxYwv8CFy0H5sb?=
 =?us-ascii?Q?bGJ7CVilXdi23q8F6A2Ugyt4lI31VEfJS17jxoRDecaIC9ksUhq1vCeYjjUE?=
 =?us-ascii?Q?o4pf9TKWdCCHnlM8RMSOJr1z0SrS5RK61Zoykn+tfFF5T0iT9/laIMAv1v0W?=
 =?us-ascii?Q?I/P+ponHtPf96Vk2b68OQnhLqDPKt/kla42vErybQsmmx/gJ5VXWUJiCnJXB?=
 =?us-ascii?Q?Nq7oEBhCw4IbadF8Jzs1rrFnhhqbbpGssiqBPy/QOG+XLfs4BrJwSGIjGbyH?=
 =?us-ascii?Q?JiKvLgKD/EJ1+NgR+6ppZnlf3Gjd3J4RRZkS7tGZcXsgSmRRABDQ3exN9Ofg?=
 =?us-ascii?Q?P3A3ksivUc3t+nP/cB3oB81PXoesGeY+3zuga/+j8zBINvi2vBS3kMwaa/aU?=
 =?us-ascii?Q?mrZdDM2E411rJGS22a1miy+KODPUpUDSWHPDlWD0ixZUiU+2zEZ3HdIpJ8Xp?=
 =?us-ascii?Q?vGFzY+Cw5Z4Ndbi/ffT8Jot9Oxbkvfb5eZARWETFUuY0tQR4BP0kOLc0NWVQ?=
 =?us-ascii?Q?2HRYt2touGHW9njatZZ0dl51evkokAXJoAmTg/7AcUn4Xa7mrmh3A+CD/vbV?=
 =?us-ascii?Q?i/q7cVG/emODU/qCXHdmY10kXLNw6O7qHrun02nGDsSD2LwYtzSkDh4X78A9?=
 =?us-ascii?Q?Fsb/YOmR0flaL8Wxj2kvKXS1YjBvg1O6cCsA1QB+VBRCNHHHmSE51mqbhI/s?=
 =?us-ascii?Q?P66mT3USqEQJB4MKzLp49AW9CICVbRJ+UnQhsj54DzCUPjz2ojl2BwftumaN?=
 =?us-ascii?Q?8TAZJllwdzO3GtXZGKQN86JepvhYAFRZiwi8IjpLBxYS5xKT5z6sfi9hiQ2b?=
 =?us-ascii?Q?ev0RYxu3FaAJVvUNOieMW2jtYX/TBQRFtbyItqSwUfSlmBCyhuxPzms0IGgM?=
 =?us-ascii?Q?/h8bhT/wE9EAl73VzfX0NY4Gf62tVKi2SRTYqck0srNKRZzm1ckdYXvYn3eX?=
 =?us-ascii?Q?psnSoUg17VwrNtBkUETsAPLoB3PiIT1qU2Mg3VUVd9tzCfPLglVigMhgRj3P?=
 =?us-ascii?Q?ZUky76g8mCvOKZAQnnDdjvw17F1bk/ONOwURALrp9AR5kGOBixHXFiVNZljY?=
 =?us-ascii?Q?hdmwCH5JZdqumkzgorpv3HIscWQLcV9Eu7UMwefBmiAA9M/dcXife64j9b7b?=
 =?us-ascii?Q?SmNdIUAJJ5tD2pkBFlk1h/tAB083KSSKvtR6Nv42OZa06uwpmBz+gPFVqFCz?=
 =?us-ascii?Q?pLAK1xa19w84wFecEwx8gmiSlSnahiVlt54xhsuaRTTn9ZGPoIZi3jyxGXTw?=
 =?us-ascii?Q?vvaNEoXzFWNMiFZ5+LTJfdgXtJwhpZZCbV0UHKUMu6mSA0e7AjZAUYw7/F3a?=
 =?us-ascii?Q?8mdgKXXLi7LN1LWyTHNAX9QtVuhkZVjfd+JPBAHMETDWSjT9d+4LViPRMZBS?=
 =?us-ascii?Q?lITkpxFZ3A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ec0928-7d33-4746-eca8-08da0dbf2ef0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 17:53:20.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAA0RbaFtX/CaodeZillNUYTnj7LNZJvsTdNujBqeLM+NDW6jCGHMiTOcsY/dIB7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1122
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Welcome Leon to the maintainer list so we continue to have two people on a
medium sized subsystem.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c91438481..8f05457f9be176 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9408,6 +9408,7 @@ F:	drivers/iio/pressure/dps310.c
 
 INFINIBAND SUBSYSTEM
 M:	Jason Gunthorpe <jgg@nvidia.com>
+M:	Leon Romanovsky <leonro@nvidia.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 W:	https://github.com/linux-rdma/rdma-core

base-commit: 87e0eacb176f9500c2063d140c0a1d7fa51ab8a5
-- 
2.35.1

