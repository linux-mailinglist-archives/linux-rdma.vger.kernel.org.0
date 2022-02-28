Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47C14C70B2
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 16:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiB1PeL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 10:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbiB1PeJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 10:34:09 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D60E19280
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 07:33:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNPrMLDpNyPVdkObshx8c60bAn+IASqunsI3og6AXJJWUyEadVYIXyfDP/qm9W42oZ30pAnDIvVcvmKKsLsS3D0pKvQN3wHItyZ9orfkt9JAejqSc1imX7hRd2AIi0YjLtE5Q82XPqlf/9uM1xIMQyVnnjPCFdVqFY94FnOxkSKldMgv72ZVF5XfGDer5JxftHytr/81l/Vr6Cl4gWhlZbpMgTHZa9Jki8wvI8PyahSatfeAfX9pUNQGyVVNP5sc5UeWzrl45iSru8T1qbnzIK6hA/6G/5oVXSXsc1fT5FmullJjxO+P3XjxBVD361P2sDBeyCR1nOdIFR/Yj9VtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEkmfZfqXjQxbZcBaJHI1aeMbOIMfz/du4wERx9VqWU=;
 b=QobxvOtO5dUfcHmq8kcNpOJK72Tdso7Vi3RwZf0wkkt1SJctMMUnQ/sT/58zhKY95XtTjsK0JQz0XHHw2xpd2qSh8RDLoZvL8M3ozK8OOgi+8dZnFqW4A63pGYH+Cbi20xFZIcTFLUvkQeb7BxWFm4iPZ2d7yyE5ZrKgy4xUoG6lrcvDsqzL4ny1i2pYDicKPEeGCdsXhHHbNp/V7YY2xeq0mry8VLnjSiXMiL0+WHCvrAlAzKQIgQGoUJijsBAC79Vi4+yFuQQj03q4AzTknbxADIIaSuC8F/abvT2s6/+kNv5C+pHS9PqB1yWoVDuZ2cPkOiN1/9HxGgRnKzRpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEkmfZfqXjQxbZcBaJHI1aeMbOIMfz/du4wERx9VqWU=;
 b=FW0n4tvCqPlq6OLus40lt6HkSJyzCp9e3eWGzEj+CrT7gazJfOKxu2vE0qgs6bayajgpMEB307BIds3ggDBaLl4JlwUkJilHD2SlGVoT892DWDnu5+Jk8/rYs0g3R/fzPUhWucmr05SIeqevUb3ME7O0ryJ1cpOa/SXv25Lott+qq1rRPP3rHg9TJ6ZMAaA7ms3AavInP/MAIAJZkkPzZm8w/54IWmQ0hPa5SlK5w71cjMJP3tEHERAss47tAdtRSlcjhCEEItoZnipKKbaHtg1T84rDSFkX0B3pZvJnhfGFlT11LbhHCS3K1u2poh2ZaUweYZVD6q562PsQ5L3INA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR1201MB0198.namprd12.prod.outlook.com (2603:10b6:910:17::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 15:33:28 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 15:33:28 +0000
Date:   Mon, 28 Feb 2022 11:33:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCHv2 1/1] RDMA/irdma: Make irdma_create_mg_ctx return a void
Message-ID: <20220228153327.GA589487@nvidia.com>
References: <20220224182832.3896686-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224182832.3896686-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: MN2PR01CA0032.prod.exchangelabs.com (2603:10b6:208:10c::45)
 To MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8c28b3f-d74b-47fd-53c1-08d9facfaabb
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0198:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB019882DAFE6BB5EFBC16EAB6C2019@CY4PR1201MB0198.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1VuB9hH87VWpqXeOvygBRnSlc24AAdczol1kVR79J4OdtPJEkiCjZg/0CQbp8zikOdqEcGr8UuiaE3UgWlJL655R6cp42yboPXlIZ8yoA7ELU0fWacjfG0XILJqoosuKZ5E6xeN4nczU7x8JeNqJJz0XT6JKpKDn8tsFbqCbx9Y5mI9tlUkQNKRA272hRBw7jJ6rWkP8KYt3hcknDhuKFV5zc7F+BB1biAeljRExWxml2UFzAJlrrkI1GqwRfD+CyL1fV1y0cpT03v5SzU/HozrWA0JEXxRBXYPFM0/wDDCfl4CtcG5KRb4bE23/iOCriqg0v7TDhickv53niGVFyCFrIXprIgKHenPGPCA3twxSqBvfHm37lproKOWClbS2igpi4ATqjPV9+6ny1VTreMnz/Aiv2+uaO7FDXBKbiF8l3ggS01rJAKbdMbYYzzeUMDumAscI5EkPeO62KnQYZFLlczRCO5ATjK4ZzPOAscf4GM/pekTScuQFcaZbTvgPBGxwEG/FZot+byseNc1gmI4PNTqsDGV+iKNEsu7lC2E9f+ZMr6/Hw8HutNZ/WgjXd21HYPP7DxCPQ1KY/bxwAdUAtHvJB3QyHDYg7hx/edNKPqHh1iPsjViICtpSV7/9x/wAZh1w4cJolzqvDh+Tou+ar1VW+n5T2xI67PzEIS+fhpLA/4fEJPc1EBDlK+BKNvZNPUWN3HXgpp2zJlMWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(5660300002)(8936002)(2616005)(316002)(6512007)(1076003)(8676002)(66476007)(66556008)(66946007)(4326008)(2906002)(4744005)(186003)(26005)(38100700002)(36756003)(6506007)(6486002)(83380400001)(508600001)(6916009)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YIvFA4iOyNJwFbBCjJye3CmVJ756kwiDvKOQomEM86P78UywaefqKPJDBnag?=
 =?us-ascii?Q?4DAsh8WR1PO0xTR74TSxjNSW5LmFYezlUAVbzR0f+ZbLKXUa2/ji6rTGDWWR?=
 =?us-ascii?Q?si+3Ks+a0G8wLDgzwNlU+wNoZ+/Ng+rjv9Mpui1NLBbuWMAeIybt3NahxO9k?=
 =?us-ascii?Q?/C1uzat0RNyvia5LnOxiaEg3gzs3CxBuao8110h2ujNXuzdCZx+YD8O2lDxj?=
 =?us-ascii?Q?nktAC51t1b11ju1kZXCeRs3Ijsi09EdcJkuURSspoB2rBiUlt6/9QjyG3UUK?=
 =?us-ascii?Q?e0A0sMGf5sF12PnpRLZGLa6Qrg1Yms5+wi1xiZzklDeQhR1FSJJmxQylR756?=
 =?us-ascii?Q?cSOslM1WbG6mFI4vmdlHKikTDsYT3FMf6Hy8blLrkblVyYscGuC/6X1uTkdF?=
 =?us-ascii?Q?1DAqVNjRO/IY8mxLeI2L5BaLZZe59JJRihaoo5s0iEjuOA/aiaXBo1c4iE94?=
 =?us-ascii?Q?cFXZetFEMBYQc0kOY5WwBOzxNF2gHLTry9PenfGhz8JLZVhwMU83Z2FRm7pF?=
 =?us-ascii?Q?gsc/Yqqr2YUyd4xQOTlJePTvWD+ToTPPNm7NBI7AT7L+/zvwWTBDiy5X1SUf?=
 =?us-ascii?Q?x0YysNHPicxfGwLpj3XyRNq0kPwgVTgOquhe9acFg2AwDjMD2TCmaLh3Zh7H?=
 =?us-ascii?Q?SDrsjVZVj1bJPeDq5wng3eMnOGUhuPMHccFcjNDFow1uPfmGmMkbB76Bi5xk?=
 =?us-ascii?Q?zXc9qBYjpb3XEd61fKLmtu6jqYhdS3c/Sxplly6nkveif1pSNjF2yv7ZrWw8?=
 =?us-ascii?Q?5K9cUkPIDkTdGXNIdeXUwp3cCbl0WRh+sVL5QR0p3CLE36WcB83DahbIJuAJ?=
 =?us-ascii?Q?0+VpuwQABjd1DWXu2WcvDEtlRvLXA6TJe3SyBIq7GUEaBc81ZlH6oh6lqqdD?=
 =?us-ascii?Q?4FHo+YQELJRSXLBEUjj2npydWrfM8U/uSq99yqSgRhYL0ys+iT7VDIwlGIju?=
 =?us-ascii?Q?n5MqBO4zorN3vdIBSVIkuk9vOymeWc0qofY6Gq2xba6/TC6pBvmrLMZr9Sm1?=
 =?us-ascii?Q?rDy66UubW6EJ/V7WOwKv3HWNsUsklbZRE4s804C6OY/f/jAOQGXxquKGjHwk?=
 =?us-ascii?Q?5TRMsGbKgVNsgBPjiYgJ9ep1FCS+FqE1jkGZ3k6rZFSHqRyRy6caDsRctUjm?=
 =?us-ascii?Q?u+Q7MPENiUeRhVt/qZc1+jHK1u8NsV/iOHYUhFaRaVQoxygt2AdyRfT3CW/+?=
 =?us-ascii?Q?bt9jX31E6zVXErJc81mlvfJGVjdBiZCzbuvCkKI9jgsanIWOWYpPlKc7bi6W?=
 =?us-ascii?Q?8NK5dPun3LmcuAkKBqcNSoSDo9cKwIN0blXfduJSrW4mniJSlwRKW7fibidq?=
 =?us-ascii?Q?ZduxVlk0u6SYAqmJRbWkpT/NPcv4cYxHYz+RSu9wxnbgX8cuDNrHDPkHkbS6?=
 =?us-ascii?Q?GQDiJOpkqRCLRGnwinUbhWavMb0c246o+vqkQcPg2v0lPvAt00djb176PZfL?=
 =?us-ascii?Q?35oesbJRTRHe2MOtlbTxktVDEnr83xWJtTq8McSJ6upuYPcRDFZWmh/QbkwQ?=
 =?us-ascii?Q?AL9kFBHoRW7vE4bgF9Nd0b+ZNTHFWGkAQH8gth0BjQDMxaid6Ne6mMU47jLo?=
 =?us-ascii?Q?k+yZTkNqVPmF7ZU7Py0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c28b3f-d74b-47fd-53c1-08d9facfaabb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 15:33:28.2796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IfYLErkJxdgyHzK3wHLSQphlA4spc+PwuTaa2VYlneevy5N6ptEGHbWf/VF8Djq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0198
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 24, 2022 at 01:28:32PM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The function irdma_create_mg_ctx always returns 0,
> so make it void and delete the return value check.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
> V1->V2: Remove the unused ret_code and rebase to the commit 2322d17abf0a
>         ("RDMA/irdma: Remove excess error variables")
> ---
>  drivers/infiniband/hw/irdma/uda.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Applied to for-next, thanks

Jason
