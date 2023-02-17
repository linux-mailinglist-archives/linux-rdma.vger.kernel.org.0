Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E474B69B409
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Feb 2023 21:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjBQUhx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Feb 2023 15:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBQUhw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Feb 2023 15:37:52 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117C33593
        for <linux-rdma@vger.kernel.org>; Fri, 17 Feb 2023 12:37:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvMf20J8YdtvFyJEoLB+37h34SV5qwJZQC/CgkL8VkAw5GB0GmkQLNRSVkVgAnD8WgG8ppxqUQ8a1gVSbpqfjgW9DXyz85TvhXKQ0A1s19w0nIfjfj/3+P/b9+u8mGvDRslQkjgj2JMvbeW4SBdKEbuG3gz0GlVyziE/ZkpAq0weVUSx0p5SkegC444ilMQbXdKkzlDmfVPLfVeyNs1Sx9tDL+u19yb9R/hi5cIvgZZHp5OCbXm9zSM3aM3PpVWu8ghjwEGWSCzSy9fSybVb43zrxLgAsgH8nApLZswpUYbHd/aP+zYnLDmEBeDNe2oFtXkAMjc70ywMDOizzmJTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO38Z4FcG3Fl0RsW5CBJhzue9sSGiA5Vd6XFYfNtkZs=;
 b=SPk9n4p0RN74s2UphTZISQ8qCiW6zODOcbIgQlpx5yUDp8lNKAIrORoDgccQ5KvIq2beDwSWKWSU/5A+nSpnsJf3YTFEi5fwF84XxRJJTc5yQoEpXCck6fpp7P+eLk3Y0zaxZwu17hXOkEXLjTc00k3RxJFJ/MKdnliYWLP6DuqhoA2jSlUXhHVJgjnz0PEghRF4/Bu0YaDBA06bQ/3rNys29xQFuug9dS+qp/VmNGBY5+/HeSw9lc0YRb1pbSp7wEJ966Z+vxKAw9dPYVbhwE0sUcifF/FbcHYjs/NNjPF39lYYKaRBAA0O3ddOI15x7JBqIzeJAzcu95Kvp0pxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO38Z4FcG3Fl0RsW5CBJhzue9sSGiA5Vd6XFYfNtkZs=;
 b=S98Cl2FYpICkQ0Hkhjm+K1icODRg214vL25BRKucabUR47XRgCwEAheOWO74qmhgOg9DFV4H+JdhV+zPw+M4mKCmxMAVRsez36PgmTlAxf/TwJUw1PU6lf5hRZHVZBFSZgsO6d/G8etSJ82tVG5bjd2E4jQtq0kcB1CI1r5KTiEsUM443XP468vbyVJ2+Rh99mijTP2eCSCWIMkRkXxVvnuaJCCDmhWl7mbT3eZqCA2ip91HW8lecWyDYp1ac6bvm3zbDo5dWPl6mfcoMzJdDkrA5hWt9z5ISinAMcH3vvwoWgwKckQ/KUzEALkrV5J4gd6ivBfLwy9bZ+axOdPjvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 20:37:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 20:37:49 +0000
Date:   Fri, 17 Feb 2023 16:37:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCHv4 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
 memory regions
Message-ID: <Y+/lm2FHuPISyh2C@nvidia.com>
References: <20230217011425.498847-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217011425.498847-1-yanjun.zhu@intel.com>
X-ClientProxiedBy: BL0PR0102CA0015.prod.exchangelabs.com
 (2603:10b6:207:18::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: adac1c01-2e38-4b27-62fd-08db1126d52e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7RxCQNUwRyWFVO/VdIXpUI/HkjLHeWaDJNBcyRqDyfwVSYTxX/68f5coR/QrykqqtfljO3Z0k6ns2X9QsVz7UTA+DdmzaobULAILf4MtS4bo9mmEIfRUTNqP7ZumIRBYjbyKGMBy/ytX3ynFwqG5C7xRybA38aP/nqaNIjlbtvmIQX93h/vqc4EAOY8SZdE76ioqsNZK6dRdZ58DBa9I9pv75J4sih6tx0TS6dsDz5HfZl8GZQocRKnS4ZQhlg/i1LoI+IWJHy0Jb5e0IOtZS/5clW3jKXFrAPRPpGabAwQ43F7pvAXUJb3M5BN0l23GFQqkvi/rUAElde3WNY4icBQpRdypb9KPzOSqOzOp0i0URBPJNjHlLh1lezYOsnFDAHqLsS47v18dUmg4X669jWIX4PwqNWAJzZscrpUlJlRZf3rp/k3odCgGDkTTguEAPX/Xo9HqaTwkt2071psdwFno+pyUw5kVzPKpYbMQHY4uMQrUFKhvx775I6Fz9w02XJPDCSPW2T2CfBVIoTavoRqHnrACGG10sGwimq8hEsdOYMF+z19chGKys1mqMyYxoPBAvP4T7u5SqTVyC7a8I2BiyngYIy8cnX4J8hIGRg1+0IataMK91OlNyaLnGJZHTnXOGHW90l5OBWAUqIso73uR1olTZ8NEPAxoIoSPWy3e5/BVBKDy/dr7LWKQHWG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199018)(86362001)(38100700002)(66556008)(36756003)(2906002)(5660300002)(66946007)(6916009)(8676002)(66476007)(8936002)(4326008)(2616005)(6512007)(186003)(83380400001)(316002)(6506007)(478600001)(6486002)(41300700001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ldSoBO6y/UoGYBHVwUSRLCoqyGn67r5nISKKX14rFzZ7wFoqf5aWn7epjXRL?=
 =?us-ascii?Q?gaX12jf2sPQvkNLXTIZqb7DsGGCgVzML1LzD/LzGV8tB6CWlnJni76MK92zG?=
 =?us-ascii?Q?iwiNJB8BZ8G4x2E/zTVJikpZ6t1/f3Oz/fbM4VIpQsNakrsN2fa3FEEckY/I?=
 =?us-ascii?Q?hJjIP1HRjB22t73eeNTB6xQDd89tHRYSaiQfY8KtiLK5GmQ9afIHcpNmiaLa?=
 =?us-ascii?Q?7TYZa6fDx+G7wxTO6icr5WtwgJ93n5cz2U94gTx4XgKrx9iBZxkNlM7EVfNm?=
 =?us-ascii?Q?czrsJqQYSS/DnjDnpDgpjd/rhNeegqWzDI8QHOdDTO37GGWrXEHC5rgUI49g?=
 =?us-ascii?Q?FwkdKtd+Jw0VDSWMpREpKQBfQhh5j8BPenoN4f7NMiRsQRAnGGiimOetAydO?=
 =?us-ascii?Q?jOhOMcVB6/4so0HVQR8K0xDEIkiuI/TQGxYOug/1NEQvilzzR08nVDQyh9j0?=
 =?us-ascii?Q?mvRmHp+hnA6r1vopsdbhVPZmPiJQlM6OOGho20WjYZ/R/xkshXEVrb2XbrpA?=
 =?us-ascii?Q?GNvtuJvKos4meoiKmZK0Bh+79VL30qFkzC8c4o5PA168cXax9PLrEep5TFgQ?=
 =?us-ascii?Q?htA7galJvGDZlNXtoUl3PF8G0Mg9Iy3A5FWjbIYBMqYhcvi7kiawHOSt5SXO?=
 =?us-ascii?Q?JeT+oXW5ltZSnYMe07sujZo33WNi8nY6rO5JKC5MZRvidaHJlAGx0xsYeM9f?=
 =?us-ascii?Q?pY4V2T0wIvXpRAylZfBB0YZLhjK279LZXjZ+yHVj8CEiwtH+3cphN+d2GJlK?=
 =?us-ascii?Q?PtWNUkItYgMxlBa8cjQBMzZ0oB1vFlNn4WSHYbcYfKnWAyveUEHZvS+U74GJ?=
 =?us-ascii?Q?HUOhTCRMHUAiTIz21mC2zDUyqiDtLAvd2rgh7C4SffE8Bj998gcgZhXsohkw?=
 =?us-ascii?Q?24qcN0GshDL8mq2QNljWpuVP+8bNgoxAM5rYxh4V4aRiTTVEgFO65awdjE9w?=
 =?us-ascii?Q?RoG3hWWh5Xm8BEaDAdxthZ8VHc3JzUJSviMJ1jmWl6c9O5MwpAVZZSzrod4I?=
 =?us-ascii?Q?c8xd+9kDqogCqXz9syMTw+GPlQdFA3wbAT+rLvPQdBJQ9WWh0VuV7ls4mhST?=
 =?us-ascii?Q?Qx2mYG+P12um4+C/v8n5Un0exgOwxL44TM5YPz13pSyZYlsv9tA4tdgmAvWa?=
 =?us-ascii?Q?JqckWnxxIOHsUO7r0xiYJjCZIoieVjXMJnI2XcpqMEqQeUUhB0SPsdrnD5RY?=
 =?us-ascii?Q?GD7WGULZMs2RrKFG/Z0uqfW/Y+CcjSMdTku2LqEAGsYw0Q7NySfGAX+GFPhc?=
 =?us-ascii?Q?wGGWUF7wEg74EXP6jW1VWjMJ9BTnRCvWWdfeBPk4oSqVPUlUVbZnv/OnPJkj?=
 =?us-ascii?Q?aF6RswkTcOQ1uyajcLlvSTXFIaoimtHG+2ye6D/04mij1NXEiFd2Jpq+G3s7?=
 =?us-ascii?Q?i+9wuKPFQ2iH7hXOiL2afYyx7Q10V8DVmtB6ArV5Af94ZOBKEfYycZs6H6UO?=
 =?us-ascii?Q?ysHx+kOANTRnvKibZL/3wdThsjePl2XfaMctCfHgSdQpYJN23BVLK2L+8e/H?=
 =?us-ascii?Q?ZsH4jnNFySAJJmtU472XGSmQTR9K4dB7zdOtnmty1ebW8RiALWeJ+GGgm7av?=
 =?us-ascii?Q?xsxUnQtBW0ukoaiJK5EWEE+bsSJ0fS6xV+1Cp9zO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adac1c01-2e38-4b27-62fd-08db1126d52e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 20:37:48.9510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yM0Lmq8E3FWn/vOg+zoG9as8eAeXm//qmHp2fCq0m1WOsbjlh3I13LNKB7Z2L6x7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 17, 2023 at 09:14:25AM +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> This is a followup to the EFA dmabuf[1]. Irdma driver currently does
> not support on-demand-paging(ODP). So it uses habanalabs as the
> dmabuf exporter, and irdma as the importer to allow for peer2peer
> access through libibverbs.
> 
> In this commit, the function ib_umem_dmabuf_get_pinned() is used.
> This function is introduced in EFA dmabuf[1] which allows the driver
> to get a dmabuf umem which is pinned and does not require move_notify
> callback implementation. The returned umem is pinned and DMA mapped
> like standard cpu umems, and is released through ib_umem_release().
> 
> [1]https://lore.kernel.org/lkml/20211007114018.GD2688930@ziepe.ca/t/
> 
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V3->V4: Remove inlen test
> V2->V3: Remove unnecessary variable initialization;
>         Use error handler;
> V1->V2: Thanks Shiraz Saleem, he gave me a lot of good suggestions.
>         This commit is based on the shared functions from refactored
>         irdma_reg_user_mr.
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 42 +++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Applied to for-next, thanks

Jason
