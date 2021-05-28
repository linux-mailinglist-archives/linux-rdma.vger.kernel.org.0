Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684C0394908
	for <lists+linux-rdma@lfdr.de>; Sat, 29 May 2021 01:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhE1XLC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 19:11:02 -0400
Received: from mail-co1nam11on2043.outbound.protection.outlook.com ([40.107.220.43]:56288
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE1XLC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 19:11:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/IFUT7CLYjHcb0q8QVWuk4G2B2XKU5W90ptrzQp2zyUV6WMaTQAz0Xxfjv2ulzbA4jfDe1OFMYO7ZowxKRjkCzbLVjgmFLqwXuhTcdgvUSKKiZ8Z77+wvthjjSP5gfaXitcQCFYJc0yysy2tz8PRlchQ7l/Q9BSn/QTW4+eTQhqPMVLZo7K8I8BdFnXNru7wksA6dBWqgEvLH5spFK5MBqPMftArIUYltBM3Bx84i6Wfm8XtLyvR/ABLY2BBgu6lXVPL/vpJVtXFeq7s6Er5QlNNi5cUV3Kff0QQJiofUPcPic8uKzuvnwEmlabvJ4tuYN5jYU4RI8BeIRoaTpd8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kkhkt7M69U+Dam0iyyKEzvgQsenmQdpKFT34wVK/5Bc=;
 b=oGXLhfEhxuR0pgIgVDxHB2K7A06gO34uvD0raTOwFxKhIgCDzw4T43v0sYh6BlKpcTjl2gbulbICdF898spunpOk83544CEhX1ec5RwpKi+/2beutYBKmOxpeEm+QNTRgGotAIr1VJ/SwZyuF0olR9faJVBxDthgL1XeHny+LIkzs39LpC1XOGjz/l9q6RiG2cu+9JsYAQvRVXoxQwgZK4j255yW6M1Cwut4Ajy7R3YiyJZLXH1B+fl3MRg4qZg5f7yF7lvPfh7wfVHCAtVF+YpwuoM/dDrxtMay8Ut4g2ap9AoIdZqj3tsqW3XBw1fUzC2tFsJaYiejovKHL58IEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kkhkt7M69U+Dam0iyyKEzvgQsenmQdpKFT34wVK/5Bc=;
 b=YfPdeBrjd/f0+iJ2disUHmkohUmxgqEEISu50bC79xnsRVfLrLpFKFQ/1tgTQTyDqZZ4+GrL6pyIJcMlsvcxniIMWKkclvrP7wCCrWQW08/UiPOLZFB4gPkZGh+CNTuz71dF+NfrM6QTUNsOxuwTnqZ1GoVLIbCCPj9+mn97N5TBZzh9zZyjUfY4QofRAcvm6hccFRtvdvKNQI5I05TNO1J+/NMBMgXpFlzy/wdD//prCUngQpgcq7JxqvdlU2+OZa0Gb4kPMg6MhrO7fFod/eMCiQYyPg7LfsUqLwr/K7349d4kzcByPPdhZEgjl11RHzAvcICp9R6vCBU7X5/epQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 23:09:24 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 23:09:24 +0000
Date:   Fri, 28 May 2021 20:09:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Take qp type from mlx5_ib_qp
Message-ID: <20210528230922.GA3846871@nvidia.com>
References: <b2e16cd65b59cd24fa81c01c7989248da44e58ea.1621413899.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2e16cd65b59cd24fa81c01c7989248da44e58ea.1621413899.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:208:134::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:208:134::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 23:09:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmlbW-00G8lu-Bx; Fri, 28 May 2021 20:09:22 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2e6c373-2561-4469-ca27-08d9222da226
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB52086A873278B6709FC48C0BC2229@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQBAULGM9zGPVhORlZMRDFztFGq6CDrwlmMNHKiKLndqmndpFrR7TNkUFS+wT/q89rPq0siEUvzq8CtWYzJqDu/iqfRQqBA/7eXbzBO9/LlKOSQAFj24eWVmxA1lmxW+hAiKffRsA1+fhgzWirrJsJxy+DnYFZAx6b+ogotqoRVxHVeXqOTvicb1ISLzkJEG7BXgeRBMbAZeRCWczs4bTpw8vO0g+9K17Herl+CPUn2xsSzxvciwl2it5HFuKBIZ79b2WfrbGeySru5P12gQzZ3gSJqPbZ39Mq3qfVLg4IHsotmPt8bc5ZEESkxEeIcLZLasT9CYYoTTr+A69vvv4syeuPtv1X0TT+VX5Hgj3daDO2rHCXqWN0+piqLMxBqbBc2YK3lm/diA482YaYRbISeefswDvx0IEg3DxuhRKaN0ST+WZce6dj4jc9mLwG5mywL52XTGbk//XOszdyAw232K+C+u6sGqGd1MJfV+QnrxWW8R0nev50QQEz351Y1OmoGrhifdWGrTK/5LuJg3As9tcTeFkdwtpB7V3stn0oNtbnqnNpfI5AZFdSjaMkSJ6mCcYkYYBGcQuroHwUIb8rpcgc8xlYlhcxK+Xlz7kn4E9UaFKlW1mlUu6trVdIt27tgi7x1XR8rtnD1ScZXMi8w9q5+BbrE0ZBJ1aRA2vE4iew7wkEgShh5mrOzheaGF27CJBLyZB9XdFe4hEH9Qpp96psygoDfsIG9tolmgCvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(36756003)(316002)(4326008)(83380400001)(2906002)(5660300002)(9746002)(66946007)(54906003)(86362001)(478600001)(8676002)(966005)(66476007)(66556008)(26005)(6916009)(33656002)(8936002)(38100700002)(426003)(9786002)(186003)(2616005)(1076003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RyOVeMrwFrz5s0FVKOuBi40jWK6Hsekm8S6CERVY8W9p3ANZRv7Ejw0xWiDd?=
 =?us-ascii?Q?RFHauNjFvvEg6ERdIfGv+iNP39+Q5L8dP1YxHqOhkzATwgNrZSptstXjRxjc?=
 =?us-ascii?Q?NSJ0Xcu9gnprB2HBO+qeV/j68Q76EMtXUsX0iW4XlxaeIR1/Hoj+tIjBWYpF?=
 =?us-ascii?Q?NSlCYKwzItymW4u9l7z2FEBwBFEo8eve6lAExbijqjf5k1yif4w9PDFwZAGr?=
 =?us-ascii?Q?Y0LTGBPUSUQq2gwESKapPsl61TwLILVE0nFv7mdYBMQie8jJVHVPadjGkmxL?=
 =?us-ascii?Q?P6ArAORbZwMhc8vXd/T2d8LvnkgUv0NmDt3QidveVUx282cpOvIb5k24NgBr?=
 =?us-ascii?Q?TRE7gpf+8Xp3ClO5QbHBWJ8fj/STRrZvgvjioVmf0xoP6srg1RTZFLEa9j58?=
 =?us-ascii?Q?pOvmKbJJwjtURdarNYpN4/oo0baMCEJMbYBChk5R0QK4t4JU+X6nWTpuNKxz?=
 =?us-ascii?Q?dqXhfb8dUhi7ntEO7QHQEZI6g1NaVdSSzaAniRVESKoLkHlUx/5oyt+/+nZb?=
 =?us-ascii?Q?GHl6SwV8lYenuJxpEU+bqqLesZMemBRxmAjzlcHU6ZveN2LAbbpDy79ywBCa?=
 =?us-ascii?Q?OCOb1aRZPTv63lobCmXFL8ViB7QTClbItfaaj5QGJFZ5hy/+tG91eNFTu7fi?=
 =?us-ascii?Q?iuMh3y6EFxFwiA2UZ5sWKSmPd3Fk6LgZAGDD9Xia+XX9pZvulUJM4QkbgqV0?=
 =?us-ascii?Q?zdtgCJ3oyCFDixVFmQHjLLbgv1KrIafiLfUnU4u7bmaCzSLqmbpi+oETpIY+?=
 =?us-ascii?Q?ukqFoRBDKxtopfXNZS4jS79BARsqt17YPOhfUjNSJG0IYdtrNHz/nLww0oVi?=
 =?us-ascii?Q?Cz2UZZsnTC+Eo8MpaQOTbgn7Y9ndZHji4j2jB7n77tBR+49nAD40cYdoS+Ri?=
 =?us-ascii?Q?EaacQFGMbaoOUtl7KvVf+5RhwiZFtGOFDRRR71x5g27Po93UvxL73zrdM6dh?=
 =?us-ascii?Q?1Q4Vzcc7wKDEU15m9F4TnD18RWh3MajFdJ0WyuOEgCCAMOCAdDh9nI/h8THx?=
 =?us-ascii?Q?rHAjMGctkVX3OJzKyUIi1xkNKDnrZug1ujH6snhDVtYe5i1iMWVU6Ks2+hx5?=
 =?us-ascii?Q?x1LbggYs7jCMsg7F8UCBi5gNC4NQufd6odHRfm9Rcc8jhbW01e0LdHTRF9E/?=
 =?us-ascii?Q?ILrMKlLXd7S7DKqDzf09XXYmvN3SoKEFL4+uThdMhVvbYiVp4rxcZnu9vo3M?=
 =?us-ascii?Q?YMS+C2l2mvUFPHX3MQzNapcp/iKcjwjVu+RFD6j7z6OdG7lQpET4iZQXgQNA?=
 =?us-ascii?Q?mLG61n2EoICveRX8G1DY+WYfn8HZAc0VcYHeWWrUEMg9bktzSQdDoij9UffW?=
 =?us-ascii?Q?WdFXcJvYVxiIpBNHHcRX1a2T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e6c373-2561-4469-ca27-08d9222da226
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:09:24.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZvpVwfSI5qMtBnaJn88QvdWq7KWFSbYjiMNFNG0WY4o0Qto7Nw2zAs8DZjROjWI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 19, 2021 at 11:47:27AM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Change all the places in the mlx5_ib driver to take the
> qp type from the mlx5_ib_qp struct, except the QP initialization
> flow. It will ensure that we check the right QP type also for vendor
> specific QPs.
> 
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Followup to 
> https://lore.kernel.org/lkml/6eee15d63f09bb70787488e0cf96216e2957f5aa.1621413654.git.leonro@nvidia.com
> ---
>  drivers/infiniband/hw/mlx5/cq.c      |  2 +-
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
>  drivers/infiniband/hw/mlx5/odp.c     |  2 +-
>  drivers/infiniband/hw/mlx5/qp.c      | 53 +++++++++++++---------------
>  drivers/infiniband/hw/mlx5/wr.c      |  9 +++--
>  5 files changed, 31 insertions(+), 36 deletions(-)

Applied to for-next

Jason
