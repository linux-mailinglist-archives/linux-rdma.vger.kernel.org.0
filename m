Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B9E45DFEA
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 18:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhKYRoS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 12:44:18 -0500
Received: from mail-bn8nam08on2056.outbound.protection.outlook.com ([40.107.100.56]:59457
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234255AbhKYRmR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 12:42:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=belUKt6HAT4fqWBfZm+OTfov8P7jQNP+u+C/rCycbPOxZdXQAH9OgjhRTJhNFV/4lkdie3cRva2JiXL2qZD789lnrS4Fws/sXYTQYqe6fWlV+lwwnROXpi8WQe33Sk9DVjc3+STpkpPjKK2zLsGhBIP1Pb6U4s1SOhF4UEV0wbcBmfDCYrk0prboqqBfdR699ykZxLElb7cJ5gvp5TbBKShUAdnPu3oOAkQ2juSbh5N+KnOIGH3VHkD77nF7WSkRCt9XAk7MCKJF6sZL5bgWyjhfFKf4xZG+krw7aZYsCwzkHvYGUC07YjkE0CSjEhJimoj3y3xa5AqJFfLjJVry5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17FJ4Fy5yobupNZTptvvxMj/SpgpMEBPqdEKXcOPC98=;
 b=lUL9mUyyMFRxP5pDnS2MQ/WoUSPHHcc/H4JRtsFhjksfC/J3Y0HANIppuRlp/NwpwNuJAnwvZJmdG6Y+xqYr1OVcK+30lvqV2wprYxERtqxnMiXgM5y+qXxueVr6POmTQ+qzPxy5q1L3T/pWvotWxWX9VoG09265HqwPdq0VOSLEt80iqPt2yS83Nfu6x8KB5JTYEI1zvFc1F42pguhXa/gGXlX1ZB5qsxnXdvO7Zw8dXjGO8p+OmBI+w5SiKfnfXeRNbGB0WNHJe7+3EdDOl6G5Sgl0Fm9P86/qNe3BP3UOS5c9MIFDVGjmVFBhOTLXP+9CNyLYy7iSRdH5xLrm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17FJ4Fy5yobupNZTptvvxMj/SpgpMEBPqdEKXcOPC98=;
 b=MX8ZP5QxSES6DqFAZWXMtUMnV9h3VWewccGS9xofaLjiCFfSk9aEPv6Pbf8aqiq5w+aTa+rXCYmoyfDKTs6DjewNLXjULVo0utvoQksvqwZAiVNs0m6zCDjsmyGPEjKfcU9T5bUREo/qPJjr0WEDuBkU+/OO4ZiDWXc5Wdz5jFLmQ1h7bayxf1elhEYczfSVYK5kAy8e8rnCAH70ro+sVrZhYNO06Mq+KJWJOPH6ZpvTbnROxFsoJz2wmz6+ALoM/i2y7HsImQN0Fcyt3/VVeKPghE0uT1pPk+fMFdi4Oblgb23R6qhBuw0RgDDMB3nLOexuMpETvCOffyscM3F7uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 25 Nov
 2021 17:37:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 17:37:59 +0000
Date:   Thu, 25 Nov 2021 13:37:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Remove pkey table
Message-ID: <20211125173758.GD504001@nvidia.com>
References: <20211125033615.483750-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125033615.483750-1-kamalheib1@gmail.com>
X-ClientProxiedBy: MN2PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR07CA0026.namprd07.prod.outlook.com (2603:10b6:208:1a0::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Thu, 25 Nov 2021 17:37:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqIh4-00279F-Nx; Thu, 25 Nov 2021 13:37:58 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b44b7fc-8e36-4035-9165-08d9b03a52e9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5349B1DEFA287BE036072CAFC2629@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2BQo6RJ0K8t3SAgvGt5cg1Ro05KEM8fMTkw1aoI/2DbRnLgaODXLeLLDL3aaeIzkNz5IZetLXspv3iYsJAInytESZzzSAOKI54emv4KSQbKJ5qX196fOFaSMxeahsVhvf8svs2S0cxdth7MZYipLFVQLLohXVPHwc6xwPIIvZOJZDkkN1zg3GyKyzMJDVgUb/pzPK3AbE+6xRwB70JOi07oHfUTV5VQxXPA6fbTAiYWhZHBtZ1cvfdw+cO25SY9UuoONsoXSDfyVmb8BBJOOsfqx6zgo5zHk/czKaPf4vbJY3/3tEgCpgM9qR6hJJ/Fz5xZAKFL4NH7q0/2LgBs9E/XBPlZ9grui5iXw5XmVw/bOOW/PMIHiaKmhGCiI34pxDuPtkbnDajx1DCf3IEJJfLG7Kw7xL586x/WrsFIyt8b/f0zmYFswOv8vWvGH0O8C1dTDOj58+X30uYYBpD/OOw7zS/XtFhPN0OiueB/dnhlXAYVqmnaRLHqwjviaIavBtVAUcsJRaP8lVXzurqb+TAOpP6P0srPx5bU0EStjt+z/pedwJncS0OYKOk6WSQN5fujm1SKJIOR8nKLNgYFSP5XeckCs8J+Bkj34ZndXJBfuPlazyeVOZPnDvCSlYyydkv0Yaxl3IU7E1PyapImBUU+F60aaviH/8u89lk1tBiLdXh9qQnW/dWLkIrMwYwcHzDFs03YMG+Sj0ERkSJZ8JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(66556008)(4744005)(66946007)(316002)(2906002)(36756003)(83380400001)(66476007)(2616005)(1076003)(4326008)(426003)(33656002)(8676002)(508600001)(8936002)(5660300002)(38100700002)(26005)(186003)(9746002)(9786002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dANYCfv29CDB8fS8JOndNgSAxGSbzZHI2w6Z5hN+v6IRyCnzVBSDOZWUBoRs?=
 =?us-ascii?Q?qZKPfWQI1XAUIJ6h5k4DQNQVd+9XO3CsX9QIdcOBArY/E5dSlr2hW+Zvs6LR?=
 =?us-ascii?Q?mJp6MFRv0klzBIXpejYmtfPU0/LWdOD+AwnnMR2PmdesTvkZEwor2EGujzjP?=
 =?us-ascii?Q?ZQxdy/C04Tsmi1ffp7HVuZNoEqUXuW1RIMxkmsNnAQYQPKKztJ/xxELJlarp?=
 =?us-ascii?Q?HXogOn6HePD8MSisXHppzk/ym3vSpEVCilryaOzfG4x9aDIyq+OBILSRjCdD?=
 =?us-ascii?Q?w08/7KyAH5+WlhYc0uAPNzuf8nSTiW3ViQIbLNYEhaffEG0T501MeBrTJAzt?=
 =?us-ascii?Q?p5jz+CowKQqLkOZxiADd2N5fPqXuNpeCxD77leIVXKapY2C4c/pLjZesDGDt?=
 =?us-ascii?Q?fqfVG0cPnMSq/6e3VVOtA1ZA2Mlpu61/cAqKPmumr6oaCnmA1YeW9Ot5oeZx?=
 =?us-ascii?Q?YmnSgRFDiY9IR5tjNUyjdlcdURf292RhBm8ZQG8t1J3QkZV/5yTEKnEJmyc7?=
 =?us-ascii?Q?wqFS2KO1fqMOXvjiIt16vZLSz7bRl7GYuv/HkpTQNlLUp3ho0ZYdhbxcIopy?=
 =?us-ascii?Q?XFq1iHV4fSXgZdV6H1H217g+rpcKoYMUR5FcvzUDKeuyL8XWluPaH5lI6sqb?=
 =?us-ascii?Q?B/n4Rjwcv8IP8BAgRypjZqfYKHNMzHFRzdvHoyLnVhBueNmzuwuwDu7JxU/B?=
 =?us-ascii?Q?FdSlZX5y9zCMplvWkBpLYv74L1zojKjMOis1iIhj3SDSDxjzc23++gCMXNwy?=
 =?us-ascii?Q?Qt6BT1KzWggGPKpV+2+Mf60/3eYbIm2N53EVnzFdN/xyYUwLMBLjD67YMbLX?=
 =?us-ascii?Q?cRo3hanZMOQwb6NvrscKpZjCP5RVwotJ5p/FEhoMte33V57o5HDwKUd/ma9x?=
 =?us-ascii?Q?6FdFKgGZlDx6HYIk8mRgzKrkNnzTcCt8SuIJenw2fqJEZH6mtx6nrDhKf536?=
 =?us-ascii?Q?/lRyVEyhEbYlg9q9f88HQcA5chUbQGrTcq5SDQWCLHM2KaBUqiB0D3bZqhkq?=
 =?us-ascii?Q?YPbgsYmb3pV4QQv8Q2RfuhGjHa+jrX5hXHw8zMh3Y+IpzSGnBXfVZ43ULSke?=
 =?us-ascii?Q?+o3Wo4MDRWMEsjWAg/0oxEqWVKDK5JZJU8XQVyuWe39+nXklPDa+m37PkqAu?=
 =?us-ascii?Q?lCebBDnYr2pVPjyG5oJ0AVxpdMLsR3FFkfZrczQ9QoSal0N4C78PVzwWCI23?=
 =?us-ascii?Q?sG3iYRQv8Xm2ZWWrhIglELqXJ4hLJSM66v6MGMgzYrWAE8/GcYaysjN8IOMx?=
 =?us-ascii?Q?ehqBjkn9rb3YTGXexicFA7UIg70g1MXYV9ZdHa9ZYsL8ATS4hWmrxTdftyRq?=
 =?us-ascii?Q?JoQaCpV82uRqxmGYECnckTwn4dKaAmT6uaR7xyCdRAPd0zsYwksliWs9pHTX?=
 =?us-ascii?Q?NoRmpqnxp2myC5+VBGbsqhiXS6KD8yoPpJ9pT0uhIaVPZFU04bMi1KFYhPHK?=
 =?us-ascii?Q?iqFUXTssWb1X8MGoCVhPeaGX3jaz9buB0Te43v0mNlJ+zIcfEjxNdOpj/epU?=
 =?us-ascii?Q?+JILB58HkqO8DrvEO93UO55hKXicKCC3GHZZErafo8KMViFTn+JaVygPIMZq?=
 =?us-ascii?Q?yx6YWQFIghUuQb1mvUY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b44b7fc-8e36-4035-9165-08d9b03a52e9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:37:59.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMtBJRMI71x1f0r/R+vfJ3fJP61Q4EJ9e12A3CtAwyDYW5PTKkikib6uW8tyBECM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 25, 2021 at 05:36:15AM +0200, Kamal Heib wrote:
> The RoCE spec requires RoCE devices to support only the default pkey.
> However the bnxt_re driver maintains 0xFFFF entries pkey table and uses
> only the first entry. Remove the pkey table and hard code a table of
> length one hard wired with the default pkey.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-By: Devesh Sharma <devesh.s.sharma@oracle.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  9 +--
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 11 ++-
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 50 ------------
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  7 --
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 99 +----------------------
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  9 ---
>  6 files changed, 10 insertions(+), 175 deletions(-)

Applied to for-next, thanks

Jason
