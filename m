Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFB167EAC2
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jan 2023 17:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjA0QXP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Jan 2023 11:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234815AbjA0QXM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Jan 2023 11:23:12 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377021CACC
        for <linux-rdma@vger.kernel.org>; Fri, 27 Jan 2023 08:23:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMyn5kP8+d5gpyG/M183lEfL3T32rWBbYB2bKfI0qzuwdrRheFIRBpUcXe5h5A+MQ/LWaXYC9DlfoIZQollGBGPCdXZouODuCUukEuOHMQwntey56+DXHsqkE8YGgtFc8ddXh+9rog5FQb/5pr3NmbHbtixwRrOHfumyiVXfvW8izZ7a6c3ldise7rguUxfJBoDN0fyCaCGPIkQ+sOAHYZaXXdo3K0xY59gV3lQt8sNDu4GQXVc/pcE/7BRMSo2+jDN4ot3IW2jLBaWhKIlw9V3/7gtSgf+ASZEmO6d1He7TnQl0qCB2x0W+gBr2sQDbJlMvQcBXlOE8K0LReeKrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRJJFrA3F1M/tF2iRKBHOY1N8POW8hzwMgHmpYswScw=;
 b=UjnxW44ephShoLOtjbM7R/BvMpgucU0ml8ksPw5OPSISiFSGkTU4i64EOZ5jyYs78L9cv1/xcunh3P5C1KOrSFZKgTFlX5fF7yQj/1EUX202/tNp/L/SRF/Zzk0QnLT/L59L5vl7dLRbszaOKwv+cbhba05EX6WIojmpQ7YBPSVX9/ePMMzJKmcHtbzoX6QRbm1JyOuLQ1RzWRvSSGYSBozcJW8pFY9YrOO7enGRxjo5jmGv7Y4icx2RGieItq0Wo0V1SNHOLEhhY2IEyG5fqVA9bdFpT98AKFKy/+aRSXOKotg0nsaBvfKyyPT4F8e2ciHm5+/BeBrbJkjnWWkl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRJJFrA3F1M/tF2iRKBHOY1N8POW8hzwMgHmpYswScw=;
 b=bJ7Ri2RNyTgl9yxt2WfZB0fbTObBiCLSX1sDvUQl1f/srPzXj4wyf9LId4+voCXGv5IMiDsEQYfyfXqg0JMrxNdhmkVo3bTkSOyRz4F3IR5s+x6DckDkrzeXovdOy8EbYoTwKe18BpBG8gSuUo9Jzf6C8s9UDFakZVX87m73uhGzha7N+SOEFd1OS+f71Yq+dWG83pD+hiWjwhQakbhmETjmTa0+RSzi/EhFvWoUPWgdVx84Rj7PI4sMQghI7RBWqKs+mg683bKXDRSI8YbhXAjBNfX6yqVGU9g5/obs0to18bEwRc+Vq7xVjwhjto7Sb1yE9lImNq+FjH353/1ctA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 16:23:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.021; Fri, 27 Jan 2023
 16:23:09 +0000
Date:   Fri, 27 Jan 2023 12:23:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        lizhijian@fujitsu.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v7 0/6] RDMA/rxe: Replace mr page map with an
 xarray
Message-ID: <Y9P6bGbtTNYIdoWN@nvidia.com>
References: <20230119235936.19728-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119235936.19728-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:91::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2c1a06-0e84-468c-2421-08db0082c758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9bKAOYc20WAQ5C9QUNOvdog7f/VWhUcwKxxpfLxAdIBWNGfKbfAnAE72b8IyW7jL3cVL/JmVh+KVnEizvkja9bamg7xIprugu25iTqPVYf1OjDpktBjFVNoSIAD9a3BMzU8XZUmldMxbvgxtodLc+6tem2mHWbMdcXEbCDQa8NQAnaur+pxGliq8LC8L/9TYtf26Q7Bx0EdcekxL+e7fmLHDzBoKQ4Ehk86rSALScC/2/Jnz58Ab1mi4MaeEizKShRxwIU1NpLKlX/VZistqvKTgeRljCEtWeYKWCMu2kjeHePBY3r3WMqTscBIVWdzlu743DS/7Ubmt2hv0j2swYPjOISxXx6vEpwxnOIJDZHMVlKrkP+s/CIgscVOmfuDN+aa07bMnEn9lBt4/SkWR7JzTt1N2Fltr/xAzH/rNuzd6fH69N9gyZTccnL9fjOIxmO5tx5nXKBlZ30tLEM3N97giwbmZzTEMiAL5F+4d3lyA4DSRSt3pgYq/y2nqFbDxutfZBokLvOtQYewXdqMbxMHFL749dWFc9XG3WRQXzjxrW71FjF7iq5DoCfnRhW7VGSMqUOtf3hP4Qbl1WsNe5qZR+luaMaJ4VxFPp/gFiwidig/rMQt9LL4Ws8wD3Jkv7CLF7Bnchnl2vUmT4lGKJ3YhWndBkMGWoksS859wH2GZX7ixO8QYUTMGGMvDFBueFkP0CIB9NwiTYV5jqGiRTtRL3VYdxffXCUsMB/YU7xS7b2LvXTjC0lBmun+8jbVXgpxgbsDSrerIwj22o6Gsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199018)(8936002)(5660300002)(2906002)(41300700001)(316002)(6916009)(8676002)(6506007)(6486002)(478600001)(966005)(6512007)(83380400001)(2616005)(4326008)(26005)(186003)(66556008)(66476007)(66946007)(38100700002)(36756003)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yaxxsKJqU2JtCriYk2w/xLbWKmy8yjDyMpf2YJdE1OBPTGXgA4UZJyRkjkxf?=
 =?us-ascii?Q?r5ZFD6ZRcF3HBfAiyp3ji0LPBo3NRxQnn9ORPY7kHqXZtORENsw6zWCm2Qbh?=
 =?us-ascii?Q?0yNQJHdNIlYAekE4lW7RV4JR1PK5p/iu5w7yuG80kQFOlqR2egtKjzZWnLF0?=
 =?us-ascii?Q?rdMU9tuxX6pVyYni9rTgwqCdOk6wRSRaXFZ4CMelAPLZxEXmcG9brgcagXYA?=
 =?us-ascii?Q?tObaTSwPd7w6QBjzwUYBdFq8YGCSy/wCFaxxNJBYTQgnHegdp7I6hEk3ftzN?=
 =?us-ascii?Q?yiWwGqutx8BymWiT/Zj+rWLt0GBj5wMQu8n6l6AIHsYEos1O7oSuBBQUBHcj?=
 =?us-ascii?Q?By1zHWJMbRC3T+gEmTdVvL5C2DqmlGrFSLJjsTTL0o8Dx9/GVhozu5Wpbs1G?=
 =?us-ascii?Q?7n7MSh+eBI5U8INkfSuF9BXpcz+a0gfn5bebDGPxWXlcVq3P1IEol260VRRc?=
 =?us-ascii?Q?wR071Gs1vYM+pugOeRgH0J3pcTTbrOrOlRV7j/mlsWXH13kXRX+af552OceC?=
 =?us-ascii?Q?WVBwnc/aeW0elwFeMaykdJDFSr2dTVjkZgxukYOn9iNGYGK5w1hxavzpHe6i?=
 =?us-ascii?Q?Au9+4OszP1ImlzTK8UH17UBs2uYGanE1PORnTwx48b+ktp4aLZg1ndOGrAd7?=
 =?us-ascii?Q?BtX38jJOZXPLyQWfm/8Fn2R7kW/WGXe88iWqUn1QpYQ0Fjcs5SRi9aiY1Ysj?=
 =?us-ascii?Q?YPXEde2xolwXgB41pGmAgzn2mCeHkMZkG2L8QmCYcHZP6lG+VYZ9MA5EV9Rw?=
 =?us-ascii?Q?j3Cnd/+daDo22Qrt4yTpZt98QlRwY5nL/E2Fg7Khct+cIdV7o49DZRHaSiin?=
 =?us-ascii?Q?B2zdAiC7LgC4qK4GtblP9ob+a3U87RjNiDxdAkedWPn6raMLmPNvO3EZHIZa?=
 =?us-ascii?Q?0Y/pGZdXnvc58MaIiLV9MmRvpbq9FBmcoVAEeYE6W8IBEIDVvYBGJKUp8qzg?=
 =?us-ascii?Q?Ge4K7kiSkWgc9vBedUUaELCbuv1paohg2SD7CqiHBZhHcEuZhq3EzQhVVwBX?=
 =?us-ascii?Q?KkDko1j2F3b8eImF7YQ1wpcJuHEiNn9w4XQs1FzGtRE0ZOcYAKul+VggOfyC?=
 =?us-ascii?Q?ELUfH/gGgI/owEysLfc3A2HMFvaWm9viWjzig4EMLN4T0st5Ri9/kUNV5Jq/?=
 =?us-ascii?Q?LcfWF4m/+CUSfaQN8gV/asrlfUFed9WlG6NeJHJDYqrkazFiyPQYB2/ih6XZ?=
 =?us-ascii?Q?fkIRXvR9BEXWWxs0QWvIr6Jgk/eJT2X/qGfh5wAw0ly87IUT0RqCE7864Fx5?=
 =?us-ascii?Q?dHZWu7AjRakZnE37g9J71y9tRDJdw5ZBS+GMVmzOVTQWUdM07qWccLI0khYc?=
 =?us-ascii?Q?qHV//VMZP07QLee98rWw3Aj/juyWgK+ertS1U45AoLCw7H8s3vuatrU5yrLA?=
 =?us-ascii?Q?URhOwVRxQA6O6gu+MdGty8IaIXBIg2BeF/Z3Cy1XlPfNCw99SXVUVnkkLelP?=
 =?us-ascii?Q?2biT3qRKJjQQxsmPl3NOnGy8Rz2wonmpBiobqxdu5wYb0wG1fiSUisYebPIb?=
 =?us-ascii?Q?28sMaGimsZQp/EYIlZEc+6Bazo8J9d26VeN/77ikGz4gOdxMXQK7TnSqe0nf?=
 =?us-ascii?Q?7YU3Dn+H5biamQw9edfU4NL0qfLy/59zjBXDv3+N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2c1a06-0e84-468c-2421-08db0082c758
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 16:23:09.5435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lmFH0Cr8UlKiXV4YIr1eIVL5s8T1EMzSTie9bxh1KUjq/QlH+k/W+I9ZXbANIMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 19, 2023 at 05:59:31PM -0600, Bob Pearson wrote:
> This patch series replaces the page map carried in each memory region
> with a struct xarray. It is based on a sketch developed by Jason
> Gunthorpe. The first five patches are preparation that tries to
> cleanly isolate all the mr specific code into rxe_mr.c. The sixth
> patch is the actual change.
> 
> v7:
>   Link: https://lore.kernel.org/linux-rdma/Y8f53jdDAN0B9qy7@nvidia.com/
>   Made changes requested by Jason to return RESPST_ERR_XXX from rxe_mr.c
>   to rxe_resp.c.

I took it to for-next, but I made these changes, please check:

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index fe4049330c9f19..c80458634962c6 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -114,7 +114,8 @@ static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
 
 			if (persistent && !is_pmem_page(page)) {
 				rxe_dbg_mr(mr, "Page can't be persistent\n");
-				return -EINVAL;
+				xas_set_err(&xas, -EINVAL);
+				break;
 			}
 
 			xas_store(&xas, page);
@@ -213,7 +214,6 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
 {
 	struct rxe_mr *mr = to_rmr(ibmr);
 	struct page *page = virt_to_page(iova & mr->page_mask);
-	XA_STATE(xas, &mr->page_list, mr->nbuf);
 	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
 	int err;
 
@@ -225,13 +225,7 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
 	if (unlikely(mr->nbuf == mr->num_buf))
 		return -ENOMEM;
 
-	do {
-		xas_lock(&xas);
-		xas_store(&xas, page);
-		xas_unlock(&xas);
-	} while (xas_nomem(&xas, GFP_KERNEL));
-
-	err = xas_error(&xas);
+	err = xa_err(xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL));
 	if (err)
 		return err;
 
@@ -458,10 +452,8 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
 				mr_page_size(mr) - page_offset);
 
 		va = kmap_local_page(page);
-		if (!va)
-			return -EFAULT;
-
 		arch_wb_cache_pmem(va + page_offset, bytes);
+		kunmap_local(va);
 
 		length -= bytes;
 		iova += bytes;
