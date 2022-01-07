Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808CB487F7D
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jan 2022 00:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiAGXjV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 18:39:21 -0500
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:14976
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231519AbiAGXjV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 18:39:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTe99sm99pNBvqS7dym0sxBdTU8RGkwqeuTmtmAPzqG2pwtVuOR4Q5aEkTMgolQO9lQqKEUoeinOXvkSLpP8aS0dhf8o19/oCXU0m7elrpNu6g0OSBEnyk8ewu5BNwjAcLQpTaBm/se4nHsPuXmQPRRE4nsI4ogGr8Tpt7lDjCe0de1+6q29eOjXR6SHMGOpZxbW1kaZ9k1Y4C8puf5ixMNkHdpxdRmiPmbPmE3H+UcjFL3t6F7q0Cw1lGIwJyqnqdYozB+RqOKyu+TFi+0bwCUBpHf15sOcPKOuCUUqxu52dL1pJtmlqPya3U1vVJ5ed1rGdH/xFrPTYHpkP8egrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hihKkz4rKNcpEh4hdMg+FrQmw8ejAEmsZCWlL8hIgcI=;
 b=WKfcRMJxvFK2zPq0mGOTnsvPwVjAg5gfZ40tR5+Z7o5UzW8qdZrHaFn0G78bNJ651GWyuVsMpOUrutegrhFZr4ICgEW3ZYWCtXcI/shDBK474cDobtN43soODBNF27XwfOHFU12MV9uVj6WUOiRFRUah5VH+b7E/zS0cdjxJcVatqO6xFDJVsUzQZvxfjNZLJqGsOCVQgLrJ3XLYUsDJMyOkL/QfrWKCtSZewnWW7tpfS7hZw/y3Ps21LYihCjwLTtetWOgQpal9Gtj0ISU+OJGYFV7HBChzU5b7Du0REjjueAa0SnsM2RCpDGV8OaM1HR/fD/r5UXQQVxdmo95GQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hihKkz4rKNcpEh4hdMg+FrQmw8ejAEmsZCWlL8hIgcI=;
 b=Q4CUu/gL51UsoT1321Q45ZgTfLC1AF2d/lY0W9yoJ6M3HRqTPCVLkiGYBPwOrV7LPalk2u/ksPz3rPjmwGyvn9VXpzowIpgBuQDsyEzADbyElfgUowj1LXFc2TF+oX5fXpIKXzdtaIOVRxQRqS8+f5zuFFhOLCvqm5qLYL9meif1uet0PXItuEN/FXfzpf0RYm+/qso/+hpCTNlm+wrAXygyHMwZh540TEYGmKRo6y9qodiqM8Nz2XI13nYmCEbdpFL7m/TvnzfKbwsL4GnES0YWmhHpWakl1KVRLPRhpsTeYDrxexJ8nho92rievaVK6wAjU19bGpagzzlZ2yTYZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 7 Jan
 2022 23:39:19 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 23:39:19 +0000
Date:   Fri, 7 Jan 2022 19:39:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, leonro@nvidia.com
Subject: Re: [PATCH v3 0/4] Generate UDP src port with flow label or lqpn/rqpn
Message-ID: <20220107233918.GA3130820@nvidia.com>
References: <20220106180359.2915060-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106180359.2915060-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: BL0PR02CA0112.namprd02.prod.outlook.com
 (2603:10b6:208:35::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 141964ec-20aa-41d0-135e-08d9d236ecce
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55073122BB9275D03B604FC5C24D9@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZRPmTIETIwTV3nR9nre2GEWGyBHHeluLxyZzEFAqQSMLHWoGgbCM/PKnn5zVugNfaJ1lJ5Po2qzKdJ8J+07aLcpPdmcaP9eyoRVe63D140YY4k+YGBaShAiDTYdvuof38FU2nrPUQjwNtv8KL/cev0Y5UdTiy5gztfBFR5Uok0YckT/rbPtdJgNQQUXMWlb+ZmuwFQ4uqZ/iN+Xxo79/icmuMFNGBRq4aG1s7mVn3vOrdu7mscJED9ZpLFMhPipPm5pF1TBCjMA9AZjamt+68HgGg7x16AlDLVeDAfwnw7umFymvBXnAeR1VQduCSAubmz30sT1T2dXeYImKdJBk2Hs+CkEco/BLAhuUU3IpIDwgXzxd7/fVwYzrr2pyMezi00QcQRF+IAbeJQ8rrR+zUptEkw+kGa/NS4JdHZ7FktAJexl/+A01ZCbnk9skELxMk+4vvuolW+qXe8uTSydb/VRFTSEbfP8RQ1xfVYxbghHIvy10o8TXMTthVxn0gGim2RU6aD6QDwq2btsEzdpIGL4GCwMwgOEBFL2ztyqDugOFVovIwf8Bba1ygc8iFB1Cvw2mFVbnNG+cgpEaqmdU0CTSpiu+ga9LB81o2KAYv1jDHcjad0Pd+L4aj5kFjisLcfK/bHWoMw2whhqTsYXt9ctz1vQYRxdrqqQXOMHyGInUO5BO1Shny4xIxcKq58LkQbrFsvBNBcS0/JphdCDjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(186003)(6486002)(33656002)(66946007)(66476007)(2906002)(6916009)(508600001)(26005)(66556008)(6506007)(8676002)(5660300002)(4744005)(107886003)(8936002)(4326008)(6512007)(2616005)(316002)(38100700002)(86362001)(36756003)(20673002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vZqnzEJphhJeCqzeYbFwmIvjjISzAJJPmbvodUxdPt5IRRWDutIWfojrf8t0?=
 =?us-ascii?Q?u8LXFFjQhQRu8huDzBRbMdYGvDg/EpLwR5nzXE+dSa13vnuOyiFcoDRP+Ij2?=
 =?us-ascii?Q?ha1zFEUF/ZqFGSiM4CjGLA+NAnMFraW+rLf4mIkUoBcIcUQ0IJDzhqVr86JR?=
 =?us-ascii?Q?VpSRYPXBj9RqCrbO4TIM36oP/MgTXX6/w24aY4QKgo3CuV8MK03GCoGy5NNp?=
 =?us-ascii?Q?nTvHaZIzZFj6HK1BvaCeMEvgz5t+6inqNWQnktq2SWPomixi1ncuCBc3E7bm?=
 =?us-ascii?Q?ki0D3C0BtPX5FV6afUy3XQMSYrdDb8n7RU/X1dGHaFwEvkmeN4ZX/sYAeB7a?=
 =?us-ascii?Q?X23liwBovmfnqstHKZa3iTvuR3hsMWs3YZjltnU+xiVjJ7bbAZOiJVnKiv7W?=
 =?us-ascii?Q?F3T95OKECasLhMpyGEO3lDgq+dQOkUpy0/IiaGmyOqfBzt50NlxU97wAGf9p?=
 =?us-ascii?Q?6TmeEpBPAEL0dMQCkP8knq+G5iAQ8P0LTHt5sFXj3NxtiTERbfkzoBPjy7um?=
 =?us-ascii?Q?GrDezKNP24f67lMM3IA0v0qBMZqklCnrtcGpdyncy9U2SJZPQ1jeugd2l7b6?=
 =?us-ascii?Q?ihSvgZ3p2v2qkJiwQauJ2Wjws/p9dWNzw6r48MaRXQ02w0aE+QnoFxS3Gj48?=
 =?us-ascii?Q?8ufPRDwxfmA92indwGvHiY2FzkOs/uQ5BWmJaiXRmtkV+mERT13t7u8izaft?=
 =?us-ascii?Q?6q4jQyYdhFBZEUFyHVKnbsXzN7Cps3zR1EowvvEieYiqNC8H3DatzKe0RocG?=
 =?us-ascii?Q?M+wBi7TnnXEzFyEQGVCHyaU0G5JoNTcsDZSJQ/Dmv88zq/S8TkYh8WEAmiBU?=
 =?us-ascii?Q?DOZqjrrJZtuskeQ0wq0Oy/E45KP293exsNkkLn0hNltmH+LQgmJGkx1lxCsx?=
 =?us-ascii?Q?cN/89BXVKvqKOK+m7qGi4DRps4vSX90J0xzYsC4Lx1QtoYf+1+7vKF1HduNS?=
 =?us-ascii?Q?PXPw+tAB4Iy33XA7rgsdo71G72J8DF88GJJCKIRxGS7BUOEpRr8+me3Bpd8r?=
 =?us-ascii?Q?BZAZqcLgN9DZcqFurzTrWme80Wa0VlPMN6c/tVvGzTmpiF9j7/valS9xOudy?=
 =?us-ascii?Q?3a4pfXkYeAM4lotGu7IVpKVi0/k75GxpdoXJWeLRke35Z7QQfLD7y47Wh33d?=
 =?us-ascii?Q?Njrov91zkjngmm1qngK1o8NIsGpELxpL7vDzgdruB5/qm0HTpUHpOehk1DHl?=
 =?us-ascii?Q?BhdNFJ4QTIwosO8Wd+BK4ZkjNNNs3gNqDYMNpu9uDucKPeMGDhL03VfA53jK?=
 =?us-ascii?Q?fTHpZ/KfamQUQXAH7gtk2OnkH3jqRxC/qobu6CTHAMFpdFA5dP9klxOfY/N1?=
 =?us-ascii?Q?Tj+Ns0XU3A4fSbQEA8q1bR6HW6fu/pmqet1JmE+hVkgVvD0APfgVCrFZf+tw?=
 =?us-ascii?Q?LRBepgHQv6B2CMVk2DsPdtoWrZ3BkfDepR0GT8AGtP85BUR4BsVlYNlXEhjv?=
 =?us-ascii?Q?6E6stm+TSfnICf01QcehyTXGnHruiesPac/UgmdS/1jaSB670/+KL0AkWzdn?=
 =?us-ascii?Q?5tlzhQ/fr6n9my+YqCA5NkDfeAx9AtVtAbS1TGA01bHlqTxHpDa/EPfOF8eB?=
 =?us-ascii?Q?EI7KDgwrVsIeohnvRIU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141964ec-20aa-41d0-135e-08d9d236ecce
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 23:39:19.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owal5zyZpwP1VGs6ilnUMjmhZrqobepHzSTwDRemN6NOzsztEcgw0ad+tICSgNX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 06, 2022 at 01:03:55PM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Follow the advice from Leon Romanovsky, rdma_get_udp_sport is moved to
> ib_verbs.h. several drivers generate udp source port with this function.
> 
> ---
> v2->v3:Because in-subnet communications, GRH is optional. Without thei
>        randomization for src_port done in rxe_qp_init_req, udp source
>        port will be 0xC000 in that case.
> v1->v2:Remove the local variables in commits "RDMA/irdma: Make the source
>        udp port vary" and "RDMA/rxe: Use the standard method to produce
>        udp source port". A new commit is added to remove the redundant
>        randomization for UDP source port in RXE.
> ---
> 
> 
> 
> Zhu Yanjun (4):
>   RDMA/core: Calculate UDP source port based on flow label or lqpn/rqpn
>   RDMA/hns: Replace get_udp_sport with rdma_get_udp_sport
>   RDMA/irdma: Make the source udp port vary
>   RDMA/rxe: Use the standard method to produce udp source port

Applied to for-next, thanks

Jason
