Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC78743C9A
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jun 2023 15:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjF3NWb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jun 2023 09:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjF3NW2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jun 2023 09:22:28 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2091.outbound.protection.outlook.com [40.107.244.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124283C1F;
        Fri, 30 Jun 2023 06:22:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwsaenVRMlahP6411okVW8RAxeMg/jypxwfH2gyiGMab8U2tiAiDfCt4I92DW/UoaQyQ6MV5INmEV5Xa6wCFB0MRMSZxkU2tKUM9QmrDUSijSWBhIiebbvPLFgVs98yk+a9nLK35bl7XDQnoMNDxzH9G2RCSQkFxXOGpkIA1CdqW2hFd6gS9KESNpK010W3bWWcHaSfR8DFqtm9HCY3cx5JwJrP0PAq39AX9jq67TsWoGT7QuprH2A29IgC55s2AW6+RYN0pDJooV5j9q0XlsP62y22f6jB0bR01ZF5o6ZpfzQ7tyAsXvSaluIhbp0OEPUFkAkiH7cL+l7nVBAweLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52vkc/9IH49U/6R4drlBt9jJMITCmg5eoMPsxpt+IF4=;
 b=DYEjWSssnIfqCAbZTMP/iFzvhfjW1LECg5mJThSbj3N/ccxZulMnbpDkt/Y8tCv4kepzqA4yByTIFkrPzWQsBIFxKq/JJ9i+VOOFCLWUBuCCsXN115rc9eWTh6lklZfHJgB7dUTiSwPUTcAvu2Xvt46dvAIEDvBdtIe8Jif+de9a8gC9F7ysZCrObnp8nM5Jq/YSrOYBwngtTby37zM0vwkZwNViMi67fBEVDcoFmLYWUHYj+3TW8EIS1xjiW/shfLs+u7wA2NKCSeCMyBjx12XBy9k0RTUMAMq06mU5CzM294kJVwaBiJg9hnxeh1YPynlnRPt3rMKzwNJGDUoSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52vkc/9IH49U/6R4drlBt9jJMITCmg5eoMPsxpt+IF4=;
 b=U9sXArFKtjefGSRjMZz2oSVplbUxnBFncyq42Bm0WTIwB7h1Mp4ON9RTbttY/Bkla6MQ7MRgSu/RKUEhwpVG2STgu8MS2BT0zh3UYvZ0CUEq1kxswBrwix/5ifi1p7KyHKStfTUYI/4YKTGUgLBCRhNmg409Hye8fAZwmIHIpgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH0PR13MB5949.namprd13.prod.outlook.com (2603:10b6:510:167::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 13:22:22 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:22:22 +0000
Date:   Fri, 30 Jun 2023 15:22:15 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, saeedm@nvidia.com,
        leon@kernel.org, lkayal@nvidia.com, tariqt@nvidia.com,
        gal@nvidia.com, rrameshbabu@nvidia.com, vadfed@meta.com,
        ayal@nvidia.com, eranbe@nvidia.com, weiyongjun1@huawei.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH net,v2 2/2] net/mlx5e: fix memory leak in mlx5e_ptp_open
Message-ID: <ZJ7XB7psFXVCpR53@corigine.com>
References: <20230630014903.1082615-1-shaozhengchao@huawei.com>
 <20230630014903.1082615-3-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630014903.1082615-3-shaozhengchao@huawei.com>
X-ClientProxiedBy: AS4P189CA0038.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::10) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH0PR13MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 8282c06d-da7d-461c-d6a9-08db796d099c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ju7ZD7qVadJEJTg6Lrr5ZMhKF9jZSBQFbiyotAz59f/p6FcP7CvrXepqu/rfLvEojVLY9RbvSHrG59FPyzFqIaR/DWZhz4k5DqxBqkX0bTfO5A2WoBk2b2YSrwiUb6C2+NclZ6DLzevLtXFQeXrIJy0a3RHAPNkWdc7Rq8IWbG4XdeIZ2M/fMlKioUQP54OmmWXRL2ELk7pOFX/F/lVK7y/1UYulGYQGwpLTEeIhvXEud9qLZxc62CCmi2cUQiz/6zlfjZCE6vG5Yd59coKvglTKxs1JTaESw1ttEJN28qcHjPDbU4Vxw0Ju+bjAKq62CpH8suZ5xz5CG2mK+pvmD2xy6qeUuKnHfCiCT5Nhjo4lO5ryCueftydJ6KE+R+U1PNBfKBd1gzj47VxSN6taraPd9keoSd6A60Y7P1qxQ4NU5pRKULlmLTeZpV1XGXGe9cesBQVbjHeHxJOUW593qzjIlKGCrZlKWKkpUe/uc1XGcjCaR8SEr6YUXTpibtON3X5Pf3Uxgj0qRxgCD4NXJr0LAtq/6moGVQ9zJJRl+OgpV/fIO8MySAOE4tvCXTu9JpKTcsMSteiu0a1xgYex1/TRuXC2PC9xnUcH16PNloM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(136003)(366004)(376002)(396003)(451199021)(478600001)(6666004)(6486002)(2616005)(86362001)(6512007)(6506007)(66556008)(66476007)(4744005)(186003)(66946007)(2906002)(6916009)(8936002)(36756003)(4326008)(38100700002)(7416002)(5660300002)(316002)(41300700001)(44832011)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Vn493TOpebV2VQeHvL+u96Yin/YrmSfOsESEseyYWwFAtKgQE4JDcIQNhtH?=
 =?us-ascii?Q?CWmku+ai7U/5/4YMxRvb7wOZjdluKDTW/YS6sOYrvgGVMn9gKKSNbtX4xgNY?=
 =?us-ascii?Q?kRvPTv7zEIRLc4cGbcvGjQbXFVvRj7NHw0nf9ssDUaYRDSv4swl9tGLVJwzT?=
 =?us-ascii?Q?FBD2h753pPifEKc/f/Hejy2YyYso1xYvYZQUPTGxnCpCV16npbfZlqLjKBs0?=
 =?us-ascii?Q?fCRuT8VLgVkfJMfUnJ2+ojBiD3bIrCWlojIJ1V18qE9mQR7+E0JmoXyUouyg?=
 =?us-ascii?Q?+24ihcHjyu9zLKYycAvuFLY/E0t4GsKhIBxmo78fL4sEpudMBBlNDW4/0zYA?=
 =?us-ascii?Q?vQX+vZIvLSRXNHQq70Da/52S7sGfU/dSOHplNq0wtO7O4pMekm1pVNoZA5De?=
 =?us-ascii?Q?/eObykkZuQlp7FkqDCqMwInaePQXDQI5UUF+cg7EeqcPLyKTD3et+VWBHYYW?=
 =?us-ascii?Q?YNUueSCaSZfNvpgxYk1mnInlbaD0kgrkPoSekwucHKz3Y/hz0EYZJUMSpPLd?=
 =?us-ascii?Q?hYBosaoxbzyjpFs2SFQciajXz4fDOEEsT7gFlMGJD/4skg1oOLq5+HAgXoEi?=
 =?us-ascii?Q?Vh+J+gcqFnrdykOzkDbRAkW25jgUuaZhyeL8dvwT3UV0Lz8juw2wBHTHqNOO?=
 =?us-ascii?Q?9iB8aILy9TVvbTzkJJMAgQUqsgsb1yYsueEWJRPqsqXdCIyxJkFP/n3Zark9?=
 =?us-ascii?Q?UaVCmRL3XK2bkD7PyAyOKcmHVncwy85Z7OqQkuJJXe+BBEFXpTfaoPHSgVFP?=
 =?us-ascii?Q?q3+6ibfapPs3xVfUaA0g3c563OrSRkQ4krhr7FtpkA1szIgkOoaC6zV/dfAA?=
 =?us-ascii?Q?hZgT7zCLiCxZEhYsAonekqc61TEIU3X4mmu70G5MeZU5SGKdZoE3UJ0K4kFB?=
 =?us-ascii?Q?nm2vnxmGkgSY2AhbfWuKSETN+/O5dbN4v8jdwWJUTMfAw03aIzQ4beYiGXzw?=
 =?us-ascii?Q?i8xtdnEhb8IIm5ZGzBNfpsCnhNGKGNLoNqovkNnS4js8nWOpyMGHsYKU2GVF?=
 =?us-ascii?Q?sgqCpZ+k0LocZcWRwDqys/YgZ0oOiSIEoCk6vhw1O7AojnUkflyC0dr4K6Vp?=
 =?us-ascii?Q?qthDhchZovQVzY5KjQkInagaqzUjaCRoq84gYGAv/DUQpjc+zf//pfIxTjcF?=
 =?us-ascii?Q?RaCAto9ein1/3kKY0fe/sVqNI5NSPLAiKxX65aAxA6xztOAYhy8UgtQ3C0Rx?=
 =?us-ascii?Q?INcIrFKHIOzIoyJpTF0IN//LLZs9W3iEUHPbMvV5rwcxtlKvJ+C9pWaldyDg?=
 =?us-ascii?Q?jincniul9Cwc/y76eCvZpjLsHCbFJb0+ChnyExyWe7fQeQYmj4L0mjHh7Vox?=
 =?us-ascii?Q?ODZTyahVM5xxxxy3S0Y/097Sm3S2u+bbxoiWxJZG0DbkymEchszccMnUMcAO?=
 =?us-ascii?Q?uu03kvqe0q2jcGueBGF5kK+0bvBJk25BGvwk7IkLbeETQ0Mop0vK+SjueXeh?=
 =?us-ascii?Q?Xl8Y+ahU5Y/72N1OMv8XZ3z2oGRjKAN1VXLWFyLO8VtV5m+ceqWEv2w5y70Y?=
 =?us-ascii?Q?8uzoTjYffrSirjij2DCeXzM7lbOlPMbuUzNg4QgzAGUjC+FdFaS8ykbzsaTw?=
 =?us-ascii?Q?WEiw/gwFPcUObVmHhOFkZgfkW5yZi5iaXWYfFCzAGAolXQCFj55DukQR4JdX?=
 =?us-ascii?Q?jCh+q4MKWQYOT5Q0Lpfuu/4Lk9qAJr0pr8RKVlwlkcVnbxRyO8ewxmmTuW7s?=
 =?us-ascii?Q?VNKDEw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8282c06d-da7d-461c-d6a9-08db796d099c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:22:22.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJJ+kn8w9G8dEvunzr4+BOhHYN1ILLVeRWlNI9PtrTELOGKVsPra8TKEjEqYzRbIsxEdxana5XVsDj9UO9UzQB3FEH/L7mPNEkbilUC2aWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5949
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 30, 2023 at 09:49:03AM +0800, Zhengchao Shao wrote:
> When kvzalloc_node or kvzalloc failed in mlx5e_ptp_open, the memory
> pointed by "c" or "cparams" is not freed, which can lead to a memory
> leak. Fix by freeing the array in the error path.
> 
> Fixes: 145e5637d941 ("net/mlx5e: Add TX PTP port object support")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

