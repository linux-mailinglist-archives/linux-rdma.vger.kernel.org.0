Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1D83F9AD8
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 16:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhH0O0G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 10:26:06 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:59589
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245308AbhH0O0G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Aug 2021 10:26:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irJycWcuVm9FcjukX0y9bmrPdpKJT19CSzCkoVKgKGmIc7ppR0QDvoUK2ic5JplCp1jN21pQe/iGN7JlzEnPm6GKsDRQmb+MwOoIwfzDz9VD7HTmRQGrElAYqdCk44EFVREZBok5+GIhfCaaZY5VM9xYzOrOWXwP63kgw+kjV7JBSI7/a+9bd2BFskeNvhdKP1rkT0jc0gikIhmpA1QbKkhVIQwmzolpHXUBNbSdU11pwYaWcROAT5jtSfhM/DFI2hf03xrEvbrNMcDlBMq85wbj3mW1FOeJDxJzo2k1W+ob0kjW+9E04lg96M69AYJyLxsK2w3dvHvqzP/NaDYRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eyQIzFqnbgn5d3nOFk89nloJZVSoTd+1odadL53zLg=;
 b=j/v2PDBX1WF1p/VcWiA+ZdIpHMpaaT3RmzLw9M3qqVV5DNdtgAasrEafe+X3DQCz1XX3HrNHJjyZcm0dhVGEHPAMKvIqql4enryxrI+0r44F0uSsKkRBb/DiFR5M+8R3GCZe5Y5aO+5LBBgWmxPKIsyvAQZB09WyT9XImzTIv/AbPncvGnpIFnckE+IiV6Jov8ITbWId5hCWQugcvkszXsTMdmzPwd7wfg2FKJ0eLwtac7sb3viB+2LYDjJVRkveQnoTVgTbZEJtiwKFIQWf7974f4zdjsPC+q58yQ1q64FOY1PzjwS1POsZxsmAgPOGgnOMzaYnEUF63moWczcVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eyQIzFqnbgn5d3nOFk89nloJZVSoTd+1odadL53zLg=;
 b=PvJAfhqOr9nvrlhHoEtg8+/P1nzcVn0jqKJ9q9Yb935ecrNPvnk3+XVsvLdgDIwj+C14Doidld7mAIdZz4h2qoYD973Ie4MfwC3ILWT4gcMaTfre2IZ/j5UBEnF5CAlCefN7jq8lUbo8JDHKtXdZmFNXbdgVxyvRh7wlA6dVJhJVC0176BpRNa48QwTPdoUXSy5kjXnQJeGni0cUTh9I1aewUC/nHWTJl7jw3S/NzGG+sGU7C7d9uvIn0i8Y8UQxY296RE9peXIB0gpdwHrK8KkX93sl1K+NhMkOWNvNZLDPwWY0Y/cftxNFK/NBkn5T0PdFm76i65Z5/mWtgc918Q==
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5247.namprd12.prod.outlook.com (2603:10b6:5:39b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.20; Fri, 27 Aug 2021 14:25:14 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::81bc:3e01:d9e0:6c52%9]) with mapi id 15.20.4436.024; Fri, 27 Aug 2021
 14:25:14 +0000
Date:   Fri, 27 Aug 2021 11:25:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        zyjzyj2000@gmail.com, leon@kernel.org
Subject: Re: [PATCH 0/3] RDMA/rxe: Do some cleanup
Message-ID: <20210827142513.GA1359754@nvidia.com>
References: <20210823092256.287154-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823092256.287154-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::10) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0215.namprd13.prod.outlook.com (2603:10b6:208:2bf::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.6 via Frontend Transport; Fri, 27 Aug 2021 14:25:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mJcnB-005hku-GG; Fri, 27 Aug 2021 11:25:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78af8cef-cee0-42ae-a296-08d969667c7f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5247:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5247868DE8D6BC6E4CB08E36C2C89@DM4PR12MB5247.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0gXc7NzKZeUGCgo4dfBDzAFwb4VTpWXDIO9LfkAbfXWEIrc0cGFDt7Mdoap1aaVtq2rzYAFW6q/kmkeSe7hdytm3hT21i4LWEBf6XV1XJxGk7cHBnYwfHqFsXvht3oBXrUqAhmY2KUYQunThFTNeCQJldonVmDaRrt0OcHtvvm1kmEldNEK8P9on2m3hTlmSAPpNORwheYO0Dk8wljRjpy+6oe9OQKxtg4xoSoTwK4pGeiJqs8hJisOI+QkNARJVAEin/AO8lE8mDUaQD7ck/Dz+SkZHtMcyP6plYhZzIjyiFS00JI7BnlfTeV/vKQSkIb+O6IkavU8Yt2//W7IgHVu+VL2rgQ1YYY0UB4q2WSc6pUuxE0vg+Yau+c+AhMC5tPhVkPFq/8lqcPTAgsHaUBfhkBUz9uQXGlYrQaeBSYugNjWWrJe4tda/n9aM+ld/ttWnQHlsSdlkC6sK3G+JUMVDF1DOIHC+t+n0bLWHOyh5BK3YHdcWJzrsACqTY95DqJCstpky9UEjZI/jJBLSNG+L646tcdydkI9UdvXk3EqTXWPYQJnhYU95EJYMoUFsH36k3jBhY/ILLw0wN9ER4oQdbSqzQ0ZqG8jLu/ewety7w9dP4+3BgsTJ67+kch9E/o/MY8PrMioHB4SZ4np6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(4744005)(86362001)(426003)(478600001)(6916009)(5660300002)(2616005)(33656002)(8676002)(186003)(8936002)(1076003)(316002)(83380400001)(9746002)(9786002)(4326008)(26005)(66556008)(66476007)(2906002)(38100700002)(36756003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4xfqciThB6+0OVmreQFXukHB6NT765GyvHENgqF0z6zEmp2LPe5NCNjEFntb?=
 =?us-ascii?Q?K8I+iUzHFVZrCiS8WwPaHFmvBNmsds69dIrmQiQFaW9hKEIXj676NnmFtK8p?=
 =?us-ascii?Q?7Xgjs6tJzrwCoOzXRFpUmxWOyF5v8mIRhKCe3nNXr+s+1xzhMgM6nLrprsiF?=
 =?us-ascii?Q?ADFB0WbvMIkcvuVNjZH3c/m5NuHVKouiQaoTWYXVgUEILUCCwifkxzkXXU7j?=
 =?us-ascii?Q?FnamVB4rFZWC7zqrfrcKO5lOoJ+jxmvyIVwapfA698O2KgLQMH9TsjBbcyrw?=
 =?us-ascii?Q?45cfH3xxt5xzJdNJLuXr6a8zONKnoCVyKh2F8Vd3O8xuPVMfdNBZi8UoIpT2?=
 =?us-ascii?Q?PU6f+lNRXGtmLu34aaou+RfMdIVM/xpYJLJqeUC/V2FieqlRyoRLT1evAHu4?=
 =?us-ascii?Q?XUBLQbUdLQV7dHTZF/EEQ6ANWbnW1AUHm3GgvTs1w+pz5gsD9TFVdM/kEH0S?=
 =?us-ascii?Q?vLDdpEuzyrXlKQxx4K9hZCAd1USDgYWatVeAQyyN4lpaM3qHH3fzb7Sw8LZR?=
 =?us-ascii?Q?Fi8SRleyAIWlPSn7tba1Qln99lDeqpBQGkOh6vYnfHEJVAyEjc8qUJ8yKHD9?=
 =?us-ascii?Q?uWQrO0MPCwyAVUsywrV3LNK1NyfScEOvqLYOtmYbbmFN2Sukjdhtu4HT9uV9?=
 =?us-ascii?Q?kV9/384aca1qGDXJ2bM7xEqHBJmdqidiYC8rwUSjrORcVK1fvEPG4QdAalJY?=
 =?us-ascii?Q?yWiUNUpX9XqK72cysR8I6aXV4SH4SKDQHWWvpgbwRKCFCJswtuN1aMyW/Ncv?=
 =?us-ascii?Q?uC6/sStBYxTwc2uvou6b/nQEOWeK0dUKthFW6QP+K2p4x6hKIih3QfN5078h?=
 =?us-ascii?Q?+YtaB2f35WwoDGPlql1ZOc4GTaUz6FNzaqhGwUDrBNVRE/HpFUecgM50m7Jw?=
 =?us-ascii?Q?jiXwOfdSAF3vIYWdOxpIiRg4VALF8A2UABMJUacrksP40tWG6eZ0duiQLY3p?=
 =?us-ascii?Q?e6S4olh6YN1rBTc6EHUx5JtWPjrh9zMurxzGgCIbO7S6PSvedN+4sO352bdM?=
 =?us-ascii?Q?P8imK2iARPf0e69gBHt66p3Ce3PBFBfFg1aNyw54nEA9HTTnSUNPrwJ4uiCd?=
 =?us-ascii?Q?PMq5XvOQFXR3efJDXttQAb5MuVHjRMgWXmr6MUeqftHreSAZFUjDd7gCw/yE?=
 =?us-ascii?Q?yBE2GiMu0W+klvbHTkaseOVGkk4H/uwk6h5aqCmr/P8QFsUCj6XbIBCGqjFn?=
 =?us-ascii?Q?9pOp0cY0834VOGlqAmW/fU/omZT4b/l0jOM65pY3wWwPnYflFx0am19q4z6f?=
 =?us-ascii?Q?7U14eOGohCj1PD5zrti72FYAtHZG9tK+TkxjIYI6TJF1xoH2bt6WoZ5+1wOx?=
 =?us-ascii?Q?a9Ea2EhmP50lVwoBpbVT1kvV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78af8cef-cee0-42ae-a296-08d969667c7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 14:25:14.7270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HktHIiyFiMq1bK1B1JB+qItzKOPanQzp5kMRHWSX/2mXQf5fbqc6r9RBhhb6o1AH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5247
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 05:22:53PM +0800, Xiao Yang wrote:
> Xiao Yang (3):
>   RDMA/rxe: Remove unnecessary check for qp->is_user/cq->is_user
>   RDMA/rxe: Remove the common is_user member of struct rxe_qp
>   RDMA/rxe: Change the is_user member of struct rxe_cq to bool
> 
>  drivers/infiniband/sw/rxe/rxe_comp.c  |  6 ++--
>  drivers/infiniband/sw/rxe/rxe_cq.c    |  3 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c    |  5 ++--
>  drivers/infiniband/sw/rxe/rxe_req.c   |  4 +--
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 10 +++----
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 42 +++++++--------------------
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  3 +-
>  7 files changed, 25 insertions(+), 48 deletions(-)

This will have to wait until v5.15-rc1

Jason
