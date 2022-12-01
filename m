Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283CB63F453
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 16:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiLAPlQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 10:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbiLAPkz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 10:40:55 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DECAB5DA8
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 07:39:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwYm8Lxf7KZwkzmeuaTj1zq6HXwZ0Scmxr68cvufMs8f/jsMDqX5W65pBFPepuKYxtttnaZoYN/IE96WkE+VUhLdOQCr/RmhskVXXwuKxENy/ElcM3JIM5Q4GfD1ZzF4ZQLoKveRhtkFBUXSGXOpGkdQVURTuPku9gHqceIGKqMbYwQvNZVmgN0XrfhNKxoJo7rPr5GS894brKEObJibFINByOymtxs9TMccopLeM5SlEfVpBTaPMsnmQOBEFNTa2rXcwyV+o7qtxDZKCeC/Cp/A4pNZ+igKUmwK70ecQ//SDN2zllBUb3Cbd+8LaknB3HvrWijFXkmbnUe1vqGZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bkl0X9nFnQkLqhNxL6BUb4FQLuJzENYSpe5LuxcXI1Y=;
 b=cxe6ezZjRDuzKoWFOlz9Z3uA0qD448IzI+3SpyhnYvhvM+YaT6QV3DEvXUF44MIPcx2Wyy9qLQzA+9YGFehBhwnSPWvLrGB0dIE+T0hIJ9rZIKcDgu8A2rfWghXg57nYSunbhNlg6isNHicHOLlKzdsyrhUOFU6EY9uChbp31ZBrgTWmg0XzAcbQrKYetm0vkEsFZL5EfBNKBk9o3X0XEXmx086EXV/ZQxrg3Ydixw86Y0EZSJEjv8ZYON0CSju84aYSPQfAHEyM2p8wH0y38zto5Gg6EuSOTvXUNgYmhg0AGiYkHApFYfXnRBz0A+aSVR2qZKlWc86nVT0TInyeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bkl0X9nFnQkLqhNxL6BUb4FQLuJzENYSpe5LuxcXI1Y=;
 b=Z8oeyYfn382WdGM/egKFaAj/eoRFn8RAIgaS6x3nT6Dbrh45eqHJq4XRBH1jhfY8QIMzo6tC48vIZIlfUX7bdASrWBkB1+l/IpHIQ5zWDq7c/1D0VVEhu3dHZnzpWcqPAke7PHSmcifSeeoYKodiWTX6VhqsxVMYrfvUYk3OVxrdMhMVwcdC+0bQP0/UCzpsGzv99VVdgTXHfQsz3ssaK/OfrfJUMXdJwTFoSH5Jxu/YyOPE2JFjZQuEwoEhKzMhr5e9ZJdjEhwmASsuyJBjyqY2uBpiIQGysPDF/BA8hf5ntnBMJy8/dAHIB9xE+0n+OP/AJLyrytyq26TmAfRIDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Thu, 1 Dec
 2022 15:39:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 15:39:54 +0000
Date:   Thu, 1 Dec 2022 11:39:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 06/18] RDMA/rxe: Add rxe_add_frag() to
 rxe_mr.c
Message-ID: <Y4jKyHYosuveRQrj@nvidia.com>
References: <Y3/Bqa7obMROAtr8@nvidia.com>
 <7ebc82bd-3d1c-e2d3-be4f-2e5c95073a65@gmail.com>
 <Y4fo6tknpuCveRgq@nvidia.com>
 <fd788906-6e40-8109-f6a1-5f281361c68c@gmail.com>
 <Y4fzZk7D9GgLNhy9@nvidia.com>
 <eff1e3d7-03a5-97fc-e494-f9ba93c185d6@gmail.com>
 <Y4f4NkV+4ZbubQjp@nvidia.com>
 <d80f31c4-2e51-c726-2954-a7039befe329@gmail.com>
 <82449ff1-2602-a6d0-e33d-af783545bcb0@gmail.com>
 <443943ee-6f79-b6df-4533-723953173a5e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443943ee-6f79-b6df-4533-723953173a5e@gmail.com>
X-ClientProxiedBy: DM6PR02CA0125.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca1bb44-dbe2-401c-5feb-08dad3b24b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KFy2FsqnOsys43zmZxRm7a3S94IUo6D4qSZgAfBrj+gIZE2K9vLL8pHSgAEmlNhee297GyQ6KEMJNz9qfWpFfu0n0a4bMz3HPPeBC7ACA4Ua4pQ1VzBhPsS4bBa2/QFczfyKNtwQhkCNBuo5flV1q2WdhXpyhi+H5cW0/efuDFQvW2UQkBmui3iUMoeKKVpvH/pGW7M5uqVjjJPfN8wd0ZJNUTnltHmNXTuHzHeP00nOo+JLN2Sa+mPoGzoUiE9mXPsUBvfdw7ijlMcqciz5uExHvqO8a133O7mAl2E/s87Wbt281CjWdBJyJIe0VfB0V6f/imzTX3UNr8cg9QjpfphyRAfoREvrpHJ7ieI3Ig+o7Qlb9GRsA81AhDp21SjZTXXV2+j0oQs8EvvHUkDUd1jodNgBEqIjgH7CcRvym1BDMCn0NV14t2fznVL2Bx2hGFSEBTQ8YaZmcw13wBkucns9ndP5yJ4AC60klTT4vLG895RYdbq53X9MOnQan9cHP0j6/8qyVIHrm2t/pgzbHD3U72KwxIef8SWLupgiKrX5Isw0yYwAO5XSaIjU7l1nm1I4sl+7YsbbQCWkgIrprTgJSz6NO3Kp/b2E6CJq4rky3OzT/7ywXdeI9QxwkRGWlDCiIU2pBlqN6Pub+2yR4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(86362001)(36756003)(6916009)(6486002)(316002)(478600001)(2906002)(4744005)(8676002)(66556008)(66476007)(4326008)(66946007)(8936002)(41300700001)(5660300002)(83380400001)(38100700002)(26005)(6512007)(6506007)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4IYz55st4dqTXtMKBFOjO2+jGLjQ09j8jqVMiX2tmqx6wwqG2JsnAG26abGW?=
 =?us-ascii?Q?C3yaecQ/n+oEaafKkv5DE07rBMxd6n3kxsvsa0ff5pDNgLBQAv7Mt3WaXKBw?=
 =?us-ascii?Q?MKkDIRokLiPoSjmO8lY2lhDGPZr82SKW0dsZ7nyaZohXxkfuVTx8MACxiwTV?=
 =?us-ascii?Q?01gO8abEbVQHdSqZD0H6UrDRXdIfW/7gE2tHc4Fg2b37bXlVZ2VxRu/SD0Xd?=
 =?us-ascii?Q?lYJ6soG9dvx783wUq8gdp7NJYLilCUYB/XfCGw/id+SXmt4J7gX8yYX3Gs24?=
 =?us-ascii?Q?6L+XJwNRalIGJPgkAhJaofGFBgD6fUFDDtKyqLiwrGaWAWHXPlrO7beHV5DA?=
 =?us-ascii?Q?lco3gZtUD1c9NjPMUWI/ivgKh7F4+eJz9Hle8ck4yqPUkrEWClmmxJZBOjc4?=
 =?us-ascii?Q?1jqz5RKlsK3JZX4RY7Uk6Shu607epLqcpYtYBdDRBKodVoyNB6fncPGrOM6F?=
 =?us-ascii?Q?SVF2BEEBva+FWWz7qTTvH/gOtNXMlW7Ad4UpfxQ97ALIXIjn8iHegWW40kvC?=
 =?us-ascii?Q?rrrvk2SP7tQIH1vNGbsjHI8u0OwN/m4i1VteFd38YV1DnadtQFlAvK/C9qjA?=
 =?us-ascii?Q?0FQ1AKuavkmZ2SY5jMOsr8/1uIfMqaQnZwAM6CEqZox2gpQ0gu8/6tyKPAXz?=
 =?us-ascii?Q?1U8zBXyXR7tyzJiHY3DX4Rq3EowWkqTBRGLNmDFbkUe1+Bt6MDZOY2nV7aKz?=
 =?us-ascii?Q?jXOFYRUx0CSezHO+l9wVvNUkM2stbgEK+9/kxtbWgt242EgQXbyaChx+L9YA?=
 =?us-ascii?Q?+YDaPSqb7SvcXxznw2po5Fl5VEbCBiw9jhak0bVIa9/suv2dguMIwbWh2blU?=
 =?us-ascii?Q?IIJcPZGNDahhSypbTERBkJtNO50afIJ92+0v4RZ3XGVUafjmGXN929m1KEXU?=
 =?us-ascii?Q?R/gf70kqBHedYKGJ9LxnockgSweyisrnkq2y+xzsOgXwQ1lq9jmk3cP0uaZ+?=
 =?us-ascii?Q?Un1qxrOLtxyKDo+ASoC9/l79JADyutQXuPyA+yEBAwddWdMco06Y9xoXZ/eL?=
 =?us-ascii?Q?mrVo3CL7YsU2JCkBwNYe15xPjRWgM8rKIJRikyfyo4b8SNvUJBkbNLUaKZHS?=
 =?us-ascii?Q?EMT2N+mcIU502ENz5wibsJWLYhRMcRE0O53YaPRyHWHvjgv+PEShvBorCQD8?=
 =?us-ascii?Q?6bzucQohBfcG0HPfUjuYCl32l8giXUYVnBxFuNQYP+zYtXKK4d7+PNxsctvA?=
 =?us-ascii?Q?PUc0ZPJG/xu14tSaHyQQjtUTB6ashjzCxM2mnojpWNppi7qss4r//8nxbVl+?=
 =?us-ascii?Q?8HsGlKkJnyA/0quZhVSNpUpnnuGpvCOzjxYyM0aEnLb/d86JBQPPFqh+Ur3m?=
 =?us-ascii?Q?Ax3hN/1PyedCJd4P9X/4IgMdo+9N+26rq9flxrJ90d5dyjGFAagMOKwY1HOJ?=
 =?us-ascii?Q?l5eUn3xOcSYAYLJ6SOMZQwQuhkq8HrkP75Pl3QYCBd9ggySgFocv1XZ5pr5p?=
 =?us-ascii?Q?vbYq8cwzfY5ZKmrd4z9nF3sWxfb1T4tstbcQGa3ihshuZ+4EJa7pATzbNFfj?=
 =?us-ascii?Q?SCk8WGhPm0Wj42Vq48LIsHIt2/itP/hHX+CPCTt7HZnTnlqeHc6p1UObOCk3?=
 =?us-ascii?Q?YRUwJQ9ZgfAzYZ1269w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca1bb44-dbe2-401c-5feb-08dad3b24b32
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 15:39:54.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6d6juI8IZxvKHUt4WkXEUORuRsYcEdfFbHOSfYlbR8wyoMYmTsGQptsUOEgT7j3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 01, 2022 at 09:38:10AM -0600, Bob Pearson wrote:

> Further, looking at ipoib as an example, it builds sge lists using the lkey from get_dma_mr()
> and sets the sge->addr to a kernel virtual memory address after previously calling
> ib_dma_map_single() so the addresses are mapped for dma access and visible before use.
> They are unmapped after the read/write operation completes. What is the point of kmapping
> the address after dma mapping them?

Because not everything is ipoib, and things like block will map sgls
with struct pages, not kva.

Jason
