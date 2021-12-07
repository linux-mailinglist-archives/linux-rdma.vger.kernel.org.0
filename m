Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D732E46C306
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 19:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhLGSpd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 13:45:33 -0500
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:46755
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240658AbhLGSpd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 13:45:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyTtvdJe0XX9zkcNRECrqlLjJ3Jmxc59IyaiPoaPSvP5rh24M6RgiexBuQaLOH9H8wOeurx6Cd+n9lYUc82VN1kTBGRY5yzlNiwHSG6aWEngvmopx2nfIdCpAwKHFOiC2qaKsfPrZk0oAq75oZGQH5igXA0KZzEobub9DNqN4uDGRTcXk6gahAQBtimci62qHaeaYjVRb09hLyNoFQTLPCbkVTTAZah1ZsnmIATbymGaU70AOp1FDvItKsg3agrS1fS6y8el5fTMjW3H2GmU49I0Gpdk10/p6wtR5OVFxqpNqZx79cij5MFsV3/W8FV90F4I2sf4u+WwPZpICbFTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDyxJ76nrDC+lz214ii4XvtK0zrAGOvU0RZPEtRxOTY=;
 b=cdm2PYPtxK7+QFtPe++fVVJJTi1LEwn3ig9uSpLa5AUh00K4wce/ms7do5g2vP6qHEq3WyWh/8WIl8607BxCvpr+5g2AUMHb5PetHGtH9keevVzhvjYCN/a+CEwxCwx1Zopo636+BVn7JKX0MFezvUJRIEbUmLvC/z/ChE8HWKLPwP0NgzNS1m3KqVB+qEMaXt8N/YLMDmyWvrQitmZrmiEYZZi26wki3gv6iT7GoZu2iNTwYMjX/Tf59BO3DB9k9S+0gH70xebFbyJd+rkZcrN+EIUqW3dmRdakg9lnswsGp3tlg8PTdcpK7tkYPMEnth8Qhe+b6gjkUSdhEE13PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDyxJ76nrDC+lz214ii4XvtK0zrAGOvU0RZPEtRxOTY=;
 b=HYL4dZpht8BDHoRtgCskXvOQyTKCdZpfJzNuDULaSwM8UZUDLfHy9DAD/vstcRF5WLkvrsP2GdInJKUb2X5U+KrMDJfkvImEzeG2LYB1I/V/Dqtjng5XhaMKbVdBzuz+LdGHgukPKgl1+uobMGulBVkTm9qy4cd0JMTIaT4A3tD7P3dWTBK2cdxNJyBLI9tP0AfnzYa4FwNJ282TLGu5B9yzpsEqXLTU3H6/hO1N9YxpADjyBSL8St4rMiOosTVYwWUj8lVTqnjCom/hlYHoRfKJlYnHrRPJpbNCTjpJA+BHhETlkPQm6glk0OEG1LviZF9qx4T4bReOve7BzJT97A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 18:42:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 18:42:00 +0000
Date:   Tue, 7 Dec 2021 14:41:57 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next 1/3] RDMA/core: Modify rdma_query_gid() to
 return accurate error codes
Message-ID: <20211207184157.GA114160@nvidia.com>
References: <cover.1637581778.git.leonro@nvidia.com>
 <43f8d94766597cc2fa7f1c2e3f81a1b558f59128.1637581778.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43f8d94766597cc2fa7f1c2e3f81a1b558f59128.1637581778.git.leonro@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR13CA0032.namprd13.prod.outlook.com (2603:10b6:a03:2c2::7) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 18:42:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mufPZ-000Tka-3Q; Tue, 07 Dec 2021 14:41:57 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 748217a3-ea75-4ebf-0e47-08d9b9b1412e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5379:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB537960C524C08667B8F8ED51C26E9@BL1PR12MB5379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZR4a+avwANF2C6G8BzHF4zpRpJDNrC+UWeyXlFI7NN2G3QYLlzDotQPujUErot8rrmPlYQ+h+xcRYgA7n2ajm1ZpFyEM6Tawdb4KN2Kq8pN2eYNhZjlm1fszhQkr614DJPrts2o8A0VE4cMgYRVNGLZWINrLL+q0C840fZc/oUOXY7BKKMT2/vju9ouUxRLcaxzm23BxF/yZEBpWL0Ug+/iY30tyro/ozdcTg70AOVNemyH3xFpjKZhRt9HqLn5jnXuNhVvpH0t3CczeqrpFFZsyrqWcIqOvizQcN4QpwtLVVCD7tWsAjBB4JVHNFY7oVK3ylV12z5WiFATADQJNOQOSFeDMWwThIZw/st0/A/RUGeeG+VCvTovl7iUSnOFHlTWWoG7d3U8PmA6i+CH2HNj4KpeY9ePUSOLGhbvYslo6sdnTJKsPzEmgdWlq4LChS0xSwUSoj6F8d+Z3KNnKyFYdAntHSxiktNgQWgdTvqQLY7omc61Sr1pmhlSWaOumeEiHT3I3gYsyH/tIjy3x9zR51q3VCPHiNxvHPh/dn76Lu2+9gm+rWF7ehEnY5/Af0PX1xICYbOP8Hmk6YFeLi+R8IFiTzYqOY1T16O7QD/k8+kIKvcjguX4s3gcRM0OnYuOYLfJ+bstvE4SIdQaiU0f63wDN+I3NWl3wKWfyqQgT8/2CC7z5Ld9JoU9mgC81jLbo/1aTQs3dkffQEOkRmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(86362001)(26005)(36756003)(426003)(33656002)(54906003)(186003)(66556008)(66476007)(8936002)(5660300002)(1076003)(38100700002)(66946007)(2906002)(2616005)(8676002)(9786002)(316002)(6916009)(4326008)(9746002)(508600001)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RqHIWeRfmsy1EPPia+KwTAQQkke4cZwic8rLhjZ2Rn606sFvw/mCArU5CZ1p?=
 =?us-ascii?Q?WHdU2sjrLR9rUmeZFU3SGBCLXnFJECWjk+eByI/NJnDFXV5Sh31bZQynmxvB?=
 =?us-ascii?Q?+qnYSNBU8r2FSKcY2x5MtHKmmzpiQvZY+Ig7fPq/hI31T9axkDJYFVKHOpDm?=
 =?us-ascii?Q?9LdhvoNgG9wM6SyAwJUp/n4Y0UjW6kNSBc35b0uBWTQg14r7jQMcKaqZ51ec?=
 =?us-ascii?Q?yvsPi28quGccw67gcOY9sAu6w3MklW6DnspY+KLX3ZafIt5SeWHfsIWPMD2k?=
 =?us-ascii?Q?v4m33G5nOjnTBV0tZIjRmR4bQQJE3IVuHAnand3oKTDmu6UdTpVovayjD+f9?=
 =?us-ascii?Q?GqfkCuvWG3D03T+AM3O5rGW03GzA+IT6cbg1OwDJBONdZ+Lf0aajpcGOmB4C?=
 =?us-ascii?Q?P2gKMQZ/6SH5ERUCQOkvrn6NIv3K9rc9qJcBmp4ODZ4scABzElpmYFWlTjsV?=
 =?us-ascii?Q?ZTkfvhf25N2NQZPFgwqhsCMbPqsbsl0mAX3cCAUlwwmL+RtIVQl7rqsW3jM4?=
 =?us-ascii?Q?bQUL0ZwPlUbaNBx6JvDE3q0jthuiCo/K/TzT140HaAk1MI1zcRsSzRiZSDUZ?=
 =?us-ascii?Q?be0xSdQUZbXGcuX375nEiKqD5XxJ2kggfAo6MUrV3yptLyElVqdIM3+IOChA?=
 =?us-ascii?Q?LHk5xNvjYF66RuucdI5JPkL1tBHpW8PATdubrlJCQ4XV7FzNRM7cHSXa+WgA?=
 =?us-ascii?Q?kB0CquUzvsGAiXUxRwVgCsYJ/Bw/ARRZkq15u6wxNFQf02vUecpHFAQkVoEg?=
 =?us-ascii?Q?1S5wMjxbbZ/csZpiB2vLDgiYeWuYL+70g6NnkmN4lcHRRtCId4enlQuZ2SCb?=
 =?us-ascii?Q?V1TCETKx4MJeaO4wjs/PYN3NEVN2PS3xpObPqqSUbvFL/qsSL1RAHnfsh1FL?=
 =?us-ascii?Q?snd7n0vz48RIwIs8No/JO3aJjGH3sEnK2kVapJ9ZSSCSQC92hrS158LVhnED?=
 =?us-ascii?Q?93htgfIkPNscyiEUArt7bTorL3adOYpUagEgpdRW4vQvhj1F83avE3tXy+9Z?=
 =?us-ascii?Q?qYgFWbuUROVaOxP41lomml0c1vVlWIjueyWBecnbt7w8Ol05IHNIl6l7f0Up?=
 =?us-ascii?Q?OrBb8vVOOVhF8XFowmGFnuHom1buwS14Dphg3fD8N3DUAkBEA2t0pmXhbMCN?=
 =?us-ascii?Q?RG2/oIHjymhNhfIzDML2MqMIPrWgAK/L6rbLmHLJYWc7xNCNUPomdYpyUxND?=
 =?us-ascii?Q?qiyK8tuaxOBOQU+P7JeDzwLAZcY7ascWiFsY3nE2o3uALXI82ag2dtAzBlXh?=
 =?us-ascii?Q?5y8r2F9K59NAH9lMTTH/Njoows7aNVz5Wxk/+2YF1KbGU6EXb6GxQhLyADnC?=
 =?us-ascii?Q?l1AxknG74SDWangapjdgL3W+PCEDYf0F8M49t3uiyd5pgUWi87VNcq1BZh3M?=
 =?us-ascii?Q?r78aDZBCSA+UpjRG7dCVX/w+UpQxgIGVC4YaZAXT0OqQWz4uOBeScu6uH8BT?=
 =?us-ascii?Q?6GbeCufPVyqaxm5Aqjm9KpA086wyd8V22jBNkKUUnT1xj1lSjYLamVgCvteh?=
 =?us-ascii?Q?PKM2vsJn+z4BAEzt8s6krB50RorMwLoYifWvmz+O9QEB67dgTCVfjZqxKylF?=
 =?us-ascii?Q?G028QNjkd6p6hmCKw+M=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748217a3-ea75-4ebf-0e47-08d9b9b1412e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 18:42:00.6022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: heNjTW+jGdk014iaj9e0q85QmFFRtmv/r045DUDv78HJQ3WTSre4C740Xa1myvrP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 22, 2021 at 01:53:56PM +0200, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> Modify rdma_query_gid() to return -ENOENT for empty entries. This will
> make error reporting more accurate and will be used in next patches.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/cache.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index 0c98dd3dee67..dd66f1a6e792 100644
> +++ b/drivers/infiniband/core/cache.c
> @@ -963,9 +963,13 @@ int rdma_query_gid(struct ib_device *device, u32 port_num,
>  	table = rdma_gid_table(device, port_num);
>  	read_lock_irqsave(&table->rwlock, flags);
>  
> -	if (index < 0 || index >= table->sz ||
> -	    !is_gid_entry_valid(table->data_vec[index]))
> +	if (index < 0 || index >= table->sz)
> +		goto done;
> +
> +	if (!is_gid_entry_valid(table->data_vec[index])) {
> +		res = -ENOENT;
>  		goto done;
> +	}

Please get rid of the default assignment to res so this code is all
consistent

@@ -955,7 +955,7 @@ int rdma_query_gid(struct ib_device *device, u32 port_num,
 {
        struct ib_gid_table *table;
        unsigned long flags;
-       int res = -EINVAL;
+       int res;
 
        if (!rdma_is_port_valid(device, port_num))
                return -EINVAL;
@@ -963,9 +963,15 @@ int rdma_query_gid(struct ib_device *device, u32 port_num,
        table = rdma_gid_table(device, port_num);
        read_lock_irqsave(&table->rwlock, flags);
 
-       if (index < 0 || index >= table->sz ||
-           !is_gid_entry_valid(table->data_vec[index]))
+       if (index < 0 || index >= table->sz) {
+               res = -EINVAL;
                goto done;
+       }
+
+       if (!is_gid_entry_valid(table->data_vec[index])) {
+               res = -ENOENT;
+               goto done;
+       }

Jason
