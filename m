Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF74A4FE2FC
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 15:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356213AbiDLNpV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 09:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356215AbiDLNpU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 09:45:20 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD74F444
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 06:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYFh+q6H5NUM9N8bvfWVMdzVNcD7izs9R8Lq+iAFSWBIrFaozBqpapHjivvLYSjHBYdxNkqBjehjbIkdecdo2B/Gm4URvz/xm9ffpz4Q/YRAvNwGOQMY1zBviUl5zs5OoOaE1laTV16r31n46Lu+0IZrfC4Wa3lRJJ72lcw6TdSFEQ4e4skl01s4bjx4lY6bN3p4ltjASIGKrs3OESMdTN3fd4ChRqU23H8gnVuWW8oFvRGToliTxj6AmevP5tfWeshcjYWpmI8D0MVIVFJsShZCxF2N5Yg/f4CCoaUnP/+qLEnHI4HFBPJOorfzHqrz+jzlEwuDJJv1q6y03Z1Nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhY/+t7MGoXvC0+e0xMx5+dp/GKcORrkUaiMKQ7PMlY=;
 b=KIFuAbmcIrgZpk755tdXHea3qwZ+VhI/nrb7LzM/p/Borqr+5tkm9B52VnT2L6BiZ3oglX47c0TV5VXmcprYo8NsqOsghUMh/lvmVd4c9OW9Qf+XndYvm/c0+YCEgFiv8q3Nm0x9AZIn0hwp/iWw7VZbe63FUyQiZdV911VUqsvOZGNM8hUcNTuyPN4/ezneKXxYHoYrQ/r6IdxItnk+71j+RJgGZJDOE3H1GCkrFD+fZNeR1YwBhJg0o0sH6sSwPSJ9xGqbqInZbaoq2OFduCelifIkRDbpQdNbkPNSzSHbSrAGheBQ23Kz3dMIUDVdsiCR+abP8xsQMHtKJi4VFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhY/+t7MGoXvC0+e0xMx5+dp/GKcORrkUaiMKQ7PMlY=;
 b=JzcmPmo17bDaeaSQxvcxmpJxPeYdPqCUJ8fVHvOgJwLdjpb+QKjGx4b6N51Gcg/21zfxwMaeDW448oDXrAwgjepq9QsZ1LUrFFZfAkzlahCN9g26jMdLGuUwJJxUjf2joseopxD5s263CMgsPQ9isdvun241nGqM+kO4XAVMzaCrFfKckojVTjaxtIzMkdJViPhDN/+ZqELv6Q5F34QCCwxow6DIYvNf5o7A2/u4mW6U6Af5H5Y2i1XFQvth9Ix4Sc61lOgQ0PugcaPopylACHkCTxdgSF8aafiGw6XQ6bbdvqrAmmVNhMA7t7Ppc2qx0GSAvWEZHuzCTl7OS7/iIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 13:42:47 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c911:71b5:78e6:3a38]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c911:71b5:78e6:3a38%8]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 13:42:47 +0000
Date:   Tue, 12 Apr 2022 10:42:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/5] RDMA/hns: Cleanup for removing redundant
 statements and judging return values
Message-ID: <20220412134246.GA191499@nvidia.com>
References: <20220409083254.9696-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409083254.9696-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: MN2PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:208:134::47) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 790dff49-03cc-44cd-6fe9-08da1c8a5455
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB268897A0C37EC65B40CDE84BC2ED9@SN6PR12MB2688.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ap1GX4rLHL5UF2fQa9tvhDvMKpBVF2jUQmI4wCk1Y7iaosKp2A6gzeNxjwmP0iWRfo18K6TdnalRVczoOUeErQSlMYS+JIFv+GdpXVQsXNKNrQ0AJ4+9RbmkAsnTctOobH2sBhU/LvPLUvPHmNDdknDb08DVddPiL1TwbYG0g1wOkQaOdtbJ3+ixSmBN1WVgPkQyxiYgncoIreSEdgoVzkAU4sRc/tpzySJhRgnc5zXOT7LHcM926VWqkDkbOJWjVVeB2VaKrLdAj/9fdrzhI/tGwB/dzJj83KZCyNBfunXAAQnV8L3WdMjStbux2/L5S0OI4xaZg+1ksZow8sJ0MwIjL4hK4+LFTK+1bGfv+0Vr8EuUY/hx1JGRbaUbntBI5kad5wxAZR75tmn8EWe7PPtIsP6C7uS5IKlCzg9+DYkcW+6SVUwXRDqD4issoWQKRXylp44EXVqHlDK/gj9He69krOfWuATDezToWW65wDC3aeaTh6XlDPQ/r868Dwh6VWQlfyMq2VTzpfKwnHGZZEjvUixYKqXISN/zS1m+jeD9dkOQU7p3ras0fcHYhp+jCWH2p1VgWaCOPgBqmhAHTIpi8jC6QWspQdOorFGOUezcBKDjal1ff4qvXYo5P+1zkhoHvwF/TCZsFvuNFFPsmiPvTUmUsSG2GT8qHpTtMqq5He5TNW+YEkC32xzJQH8gOeexYCzlxuYdPEYqqJERig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8936002)(66556008)(38100700002)(508600001)(6486002)(6506007)(5660300002)(66946007)(4326008)(316002)(8676002)(1076003)(66476007)(186003)(26005)(4744005)(6916009)(83380400001)(2616005)(6512007)(33656002)(36756003)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GFB68knVu+aZ/AgWkSLISALZrKMz4V9tZ3CsZ1T0lLTAns42ZQdnB3uADPBU?=
 =?us-ascii?Q?KF6QoUfNe2EIth4Xqhkcdg/MJqcYM1QTJlVKD/yFn1lBgZgpyFjvt/WRURfz?=
 =?us-ascii?Q?MdFmoLZDN3J4xErXRR09cKSz7csBOyeEC2Kd+dZNTiKToEdRpdbT4BwapJVK?=
 =?us-ascii?Q?fGLzb+/Tixu7HtOBiRvRz/KQ+F8kx44if/fdQn2m3mtrrXLaEIn3cm84NCID?=
 =?us-ascii?Q?O1tTmXJ9F92WPV0LZ7ZhExGiIVSZ/veXAMr2F8AGz+OKnNacvC+1lZ1BmwVw?=
 =?us-ascii?Q?Csvgu+SDwBfJTJQLkzaXa6iV8JCUUNym2/eu3UML0HFqnVHQOkSXvKowx2cO?=
 =?us-ascii?Q?JA9elvMiSlr+QclZBEfcQ1DDiKVVbpox+XC99KMaiqXByYoroQdoB6BLkQQ7?=
 =?us-ascii?Q?ITdxbz+LXGf5+Q1bnujdy5m5DmtB19p0A5dY6i3JKcbPQavbur5WWqxk3GB2?=
 =?us-ascii?Q?NpRyOxDo2DgoqgMYm13GAETODmz9dOYNed4u5vyQeWptrghvhBHob09iQwny?=
 =?us-ascii?Q?D3VR/Ka5sV0CZLTime3SL8NwEpsWOyiJG1E5HEAq9qoF+dYAMHmgI+QOg1x2?=
 =?us-ascii?Q?QYEqxgCI/6KLSBhT8hILUdR2/WYEpnJSpoGDjWE95F11x6pFvmNMlOucEAIH?=
 =?us-ascii?Q?iInHOM1d2hsa9wZOM6Kd8nZM1QYaHgLldIFX97lk0IraKU9f4ANBy5KkroHX?=
 =?us-ascii?Q?f54CpMC6hi0pCkW9BcA2Lomc2mg1/8bisFLQXScCx/i/dOsrRDymcgeUEHE3?=
 =?us-ascii?Q?Jkx3eqSuXOMZmuWUZWIySM5ZC4Hyc7MdQ0kAayEcxYvYBfjdSc7fUqZnvjHj?=
 =?us-ascii?Q?JVWHmQGfLAfdqYaplSM17XSEoWUqLnRz9aKoQvxnFr3j3rNTHk/HfxfYzSll?=
 =?us-ascii?Q?NMNyl9zda4jrG69ACcscjjbXnRn0vNvvfGLftp2mJQoAqAx59gUH9Dvv1/5g?=
 =?us-ascii?Q?8SI9fXerJdJXqF4PwPSYuxvSmgxXy1cw5KNIV8RvEqY1p+X/HzNiRJILOeG7?=
 =?us-ascii?Q?Bar+KBiXJARhOzykmjE+OppoLkKN0+6cU4Vp49pQFEMEgS74fagrc++xygHn?=
 =?us-ascii?Q?SN3gUtk7q4xY8OdjCjYBYL4LTUO5VLVhOnHQDChK5DciO7LwHt0UCe4Yr1Il?=
 =?us-ascii?Q?mR/I16TfXlzwezka6LtSX/udzK7MC+duWZBYhC8olb1OG06N/nysz20nI2MZ?=
 =?us-ascii?Q?iLHwNwrcfZ2csddY0JKM3At4Zd/oO0ctjxQA5SjLV6IFYuHNmpZKMLd4jqxB?=
 =?us-ascii?Q?liQNt6HVvsB919X7K45F4wTei8MdQ/HFueL7obQrlDLZN/jx1X/SsGUX4Cw4?=
 =?us-ascii?Q?nX9i917Ifzrl0NSpwc4NxzPAdw6waZU9IBuxNHKIEeED1FslEC2Vy0BwDsGE?=
 =?us-ascii?Q?MFSrOaHvxMVoFC836UJ4uxSxEa1V8QFLFGJ0h4jD7eMw1ggDOEW44iH2Te39?=
 =?us-ascii?Q?tSgf+lrp+V88FYueEWhBq61wi9kb/kdgjBcp2sawYCQk9LlYL/O5HopbUf6O?=
 =?us-ascii?Q?AetdTtZIl6OAv/gfAfHyFkKOpxj247IhRwhlE2aFQC6mgmnKEO6I0Yc8h6LA?=
 =?us-ascii?Q?d4JC9J3TF+7wQNsrog20gsrz7aM4vDPnx/VY9EoHu/PZ0GSDwdYY/PG9Jpdk?=
 =?us-ascii?Q?CmtqNuoYBuTjffp0BfIb+0BpcdqaZUldSBmeHTYe+06SoTZqDDLERwHux0mi?=
 =?us-ascii?Q?vFROfraqmK2fPVQiJIZsbhbHVOFeUBoQMBetaDatsvWDjlmXnuHw+UpzbEaL?=
 =?us-ascii?Q?J8Ci/Ii4Ig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790dff49-03cc-44cd-6fe9-08da1c8a5455
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 13:42:47.3701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vEGy+Wek/UZ71vRQLeq6FpnfCj4uA/bfgOY42PwusYTcb5FLHdMHKRKAm/7XQYv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 09, 2022 at 04:32:49PM +0800, Wenpeng Liang wrote:
> Most static warnings are detected by tools, mainly about:
> 
> (1) #1~3: Remove redundant statements.
> (2) #4~5: About the return value of the function.
> 
> Chengchang Tang (1):
>   RDMA/hns: Remove unnecessary check for the sgid_attr when modifying QP
> 
> Guofeng Yue (1):
>   RDMA/hns: Remove redundant variable "ret"
> 
> Haoyue Xu (1):
>   RDMA/hns: Init the variable at the suitable place
> 
> Wenpeng Liang (1):
>   RDMA/hns: Add judgment on the execution result of CMDQ that free vf
>     resource
> 
> Yixing Liu (1):
>   RDMA/hns: Remove unused function to_hns_roce_state()
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h | 11 --------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 29 ++++++++++++---------
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 20 --------------
>  3 files changed, 17 insertions(+), 43 deletions(-)

Applied to for-next, thanks

Jason
