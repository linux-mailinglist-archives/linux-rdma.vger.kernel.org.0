Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5167F439DED
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhJYRz1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 13:55:27 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:64768
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230398AbhJYRz0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 13:55:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnmo90mugl0Nft28osrEl5Co+gXmBwBOGF+Crv+v3SPKmOvzSXrEkBH8MxPtuMNqPwLj86VMcwnodAIGoMx7xF1nPYdg8WVo1+oyfM3MWl6VX5tt//EuclbK9BOdNHuf47O+meOKKkrPzX/nhyxUQcfZDj3GwzdAWJqNIHCzp/j32jQHZFXHkjGokbODAEQUe2AfRqHuMmPMzfDq7v9mTBbDMJnRmO1Z7i5t+ANQDJMIhbnBZkJHv+2aIQoeKMRap+GjivSKmTpCw08Ak2WfcBaSs/dAr+WoRjgfP0HTrEpDZnO/o0lckjAWNQF2X4B1oga9mQybvWyY6WDsRT77iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+zDr8aB7ypwlqpTeTk94J5QV4tiTjpKvyiKIO9nIw4=;
 b=O1NlcFO+ct/MPMpAmhW6rkycFICxIwSKl990WnNHtlWT3UVBt/cRRfqT/VRGkyquTsrfd7ORamK5eKMyrDKNODG0HurSs8sEqzq/DKKFD6Si6HlKu6P7IvP8SlEifV/BlADmSj/DydJKEgSbrk4TIi+5vUz1xnK9b1X0n+Z9ZgnaA7+QFsKuSOBaaLDBXfZn/eKV0/WRTex1ZuyI7VKjI9WGOcGj5pKz9qVz56TENYfAzEyLoLujldN7e1kjACbt/jcy0RC0MuI/+TIt9Ig8yy5+pR9vv437gVRwvfGZOH0zRSACfVSkoZxsj7VwZRDfVqMIRrHsPudQLZ4/Gidl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+zDr8aB7ypwlqpTeTk94J5QV4tiTjpKvyiKIO9nIw4=;
 b=exYn6j6aIkO8sI/bbs8+LqzoZVoNZ9bBn0bbkF1jFYoHBbktM8Q5UkEJWBBWI9MLzhFqLTnTU11HbH9J1SIS/6uDgCWuhsT+EZfO/veYdvV2d/sPc7A5eqhZVLxaePTrYj0RK/g0Al/ZzBX/3K117qF3HUV57pPKP4DW0Cc5J71ty6OVXU9ErKmx1eoXdo7U0lQojd9TnBuzrmZFt2k8tGLJ9QyBVFgJr5Bcp/qMsXKa3W2z1E7DOEcG1AFRtvf6Lsb3DgAdt0wEOwSB6b7g9b/bjZPuTe4dbgsI02I0lNMZEcCgPeio+aAvIKXa2RAVccIPPvg/keaBKS+1SroBxQ==
Authentication-Results: linux.dev; dkim=none (message not signed)
 header.d=none;linux.dev; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5256.namprd12.prod.outlook.com (2603:10b6:208:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 17:53:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 17:53:03 +0000
Date:   Mon, 25 Oct 2021 14:52:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH 1/1] RDMA/irdma: remove the unused spin lock in struct
 irdma_qp_uk
Message-ID: <20211025175259.GA432965@nvidia.com>
References: <20211021230612.153812-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021230612.153812-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: SJ0PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.12 via Frontend Transport; Mon, 25 Oct 2021 17:53:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mf49b-001oe8-N7; Mon, 25 Oct 2021 14:52:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d753673-51f6-462d-e10f-08d997e04a8e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5256:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5256BB70A6268E1E025DBD5CC2839@BL1PR12MB5256.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LM4oq3ZP/6Gyvo8Pjk1zG99RVlz5hQ5sjawa2tkAVf7v5Gi6mh8iaIoy3/J9wVVxj9CduflzdvEWOPKBKchslsg8rIF05HmlgYkjSfm6y02SJBfmjMZryOkZGMQWxlJyvTA93PJYLQZJS1wudDFbzNs8ED7MTY1jpy6gj9GYCTWYXugVJLzaur/oeseljLOjmXj02xqxD+ohCEsQO4d/OsYEzXr7zr/097D+M5ZAOKHbiHs4qM/oPX9tB1PCtkG33Ed1CwNaT79ynH9eNJ/oD8qfjqvxL0zt995Iw89aPuDLhX/+rLNGyQw4A5/TERpE4aBKO/478/5dqXW4I4jH/0jYUI8kdBmeJ6+dXfgeeHn+lPiztqRw6t9y1pO1l8s6fWRfgPdl0UBiK/ZsoWlGB7NIFLleFANuzfzmncQ7S74U+a6yDn9nnA5OZkRX2IlOmo68ckFebzQ3TiCdZtheIjW/ag6FcqWlD/+CTvm6NotNLi4TI1FRh2xTRymoliFK00hG9wxBugaO1Hi9cEHiIyrErUW1QhTCxm5ivCm32rtwRmHaCM7a3tGwnE4hqSbaC05W44FfkrNCQmu10HarrWgCQQZxkRag+Sqbw5RCjYI4VWfntgouH+hWE0WbWPHpqveDrmmfVZzyAY2jgWpq4AAkl4TOO2cBRrdGpY8cTxYgLb1zOwrCURJT0220kWRw/nlfoTfMX81aDt0IxUWKzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(186003)(4744005)(26005)(9786002)(2906002)(2616005)(36756003)(38100700002)(8676002)(8936002)(66946007)(1076003)(86362001)(426003)(5660300002)(316002)(4326008)(66556008)(66476007)(83380400001)(508600001)(9746002)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rwXYRb7veFAW2HEwKoyOAqegdWz29qUwHkcBtUicH41g5YP8LNTMAEjVRG3j?=
 =?us-ascii?Q?pTi6S2YlmjIjuMtRK1ZZ3mo1hB126RCfbI4xaeU7EwdeaigXPdgXkxhxlceg?=
 =?us-ascii?Q?02Jao0W7CRFGjBP+yMKSSHgzSSsM2kvzsqkK3l+6c9c+ks1zXmykl0aWjJhG?=
 =?us-ascii?Q?adSyvT7BVA9WWOHvPY4nfJcGVcMKK/tkQD71SwnaetRR/AOLiHoYuBra/w0s?=
 =?us-ascii?Q?UrjWptLkgQzTqe8tRid5BSjOUgyRik62ltZHXMi4h/tdnSag9GWpXyX8Bab4?=
 =?us-ascii?Q?yfhURYFPUr/AcBz0xbgS+zEA51dm45kljo+cxRzND8VXWvvV8qqRG+w0WVk5?=
 =?us-ascii?Q?kNaWJeqGV5MLljkxDsWz2dpBYzBLwkSX8pZAkXQ9hARecoDsv9cwQ3PH2TgG?=
 =?us-ascii?Q?nfFCytM1fkJXk1dPF2xP91Nncw7tT0vhM/NXjiYAa72IlY8LxoYkXHGYj4uy?=
 =?us-ascii?Q?KZhc+YyDJXzj8/o9zY3YYt85ytQTXomUvdulyATkMSEQdVfjRd153j6+AITe?=
 =?us-ascii?Q?Rx2FFZK49Ibhf7x8IAZwLxl0+RePUjyMHfc5TuidY1zvKnG8WisihdoXJcna?=
 =?us-ascii?Q?QtO6xU9RSwUcOKVnYDu6/WuS9wwFwalQT4/PjN4yjrsd3pihYi8djpCV6aos?=
 =?us-ascii?Q?u9ikd04rkp6VAvZL/h1pNrQiYa5xSMwQ/Bi077VpSHBd44ut52GXCgmtEJcs?=
 =?us-ascii?Q?URSBvAKle5QT0tQg0sHGuagrLFfYTHXLpsRa6GYyj0XmbEXX4TrlbVVr6u4e?=
 =?us-ascii?Q?kYfB58KYfIa/+9gfsa05GifouTD8cQJs3aRdeiSz+F6Ji96rowf8cmb9GzHe?=
 =?us-ascii?Q?cDVALtByhhaTMai1h4gYOFuZWBit7Y+2dHbdqWGhCfiURHWvGNSxmIazYQVA?=
 =?us-ascii?Q?d09uJg0bE3W4f9XsSnQ3jjs2+ynAgNTHuyqlkzMjOFqrS6wPLSRVUJGgdFW3?=
 =?us-ascii?Q?kk79iEERShkZ9qPFGT2URQ4YQN3CA2v/c/6yjC8DnqWiBTgL17WZYao2SKwz?=
 =?us-ascii?Q?ILkFeu0DDwGWA4d7Xw81yFT1BfJ/d8OzIhYuhOEFq+Avo4AjKOvWkLfA3gBZ?=
 =?us-ascii?Q?2k3l/1x8v+SROPKMcGwjVcg1HqSHmZQBJmS6jI2lX3k12JkjPSH3WR3ifc6V?=
 =?us-ascii?Q?Hlr12Earda1J0qr23fYahyFvkZXqLgVDug/q10fMTVAhMlNCCzJAYSSXeldD?=
 =?us-ascii?Q?xOh2WQrbyfLtVxBW9Rgw/ryr3q3FLwqZ8CZvS26xr3Xs08NDA3oVC96BS/Is?=
 =?us-ascii?Q?lw/zob0FMr5hgx9gRfADhv9Q8TwRUn6ogoGMjp2SVjpH+c9kYoeCnudgOOrn?=
 =?us-ascii?Q?fwZJ5qrt9VfP2PsfSfF9ei5w5QdJoYBTeJhcMxIdAnFJe7F5taq2/woyjPrI?=
 =?us-ascii?Q?Oc+R6anEaRkruBM3TsL6BvgOLWtCzJ8MH1eTUeoVNuEluiwc/r5StzTevfdA?=
 =?us-ascii?Q?+IZj9iLENdi/LEF3FVDRRC/f3vKsqweZPdf6Asu5zw458AmraAWoKMlzthsR?=
 =?us-ascii?Q?f4bjGUFPpvMFq/MAZjLJ4r8KxmFlD+Kum/QIcGvpFHmAKD2g/LZM5s2NkZYf?=
 =?us-ascii?Q?neaBqTxWg8Y26JboP6I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d753673-51f6-462d-e10f-08d997e04a8e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:53:03.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5Mcyi/q1acHcFWbU/svyrN+X3RUtNdSkHD+PQDHCBKhDyaE9WziIgEunQYgdw2Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5256
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 21, 2021 at 07:06:12PM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The spin lock in struct irdma_qp_uk is not used. So remove it.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/user.h  | 1 -
>  drivers/infiniband/hw/irdma/verbs.c | 1 -
>  2 files changed, 2 deletions(-)

Applied to for-next, thanks

Jason
