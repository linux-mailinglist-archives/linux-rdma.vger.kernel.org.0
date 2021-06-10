Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A363A2A84
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFJLoX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:44:23 -0400
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com ([40.107.237.73]:54720
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229895AbhFJLoW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 07:44:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnMcFxQuaPYwn6ZOwoK3CabzeNBV5ktLK6SmjF4Tl70qohzKo2vWLrPBBUDbcMwLRaH3wKl2ywi7lGMK5d4U+TfI5w29TidUYaBuu2LNLc1IV/KBsUJObaxXBWxk32s4ig3Zlkl7RURrp2vX4BksakZwLGabDZgypF5Ukf3PMY/KItUj7SguF7yhQi0r7XZVFnuWHRZp+Uh4GHhrmPj48wNA7PI/zJJ3O0tIOYNAzRV3qSM+Ti7aohGWpAqVhVctQyKPp4ZLN7RYZTmHAAKDfrBLp0QyvPFrtnIOX1pbY+fJUlr1Wa5xoG8VICoEOwAwLjYdolFl6IfR8ewF+Z4hlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxqaYtf7XDXaygX0/g+nZTdkmBx4LBtX4w6UPqoKsiw=;
 b=TL4yJR79TLocXGeehL6S7EPqrpTEMOirkM8sNmF7utncOJTj28taui4BvqrTl0iadaaqTp9uFFGOEovlWqKZwvuSLY1AAlDXFqqrJKSHckQserPAcA3R4t1f8ANo0frqMUJREZvCMVVog1qwWVzHziXNxyRHakzh+OxNjumL3l1nRdRqzkWhJAK95XDvQfNx3HbGsnX5s/nYCu0fb7eQafhFp7fl5f1vKtu/qCFeF50Fed0x7H5pSxPqnD44aesGeGZR/CLxRA9MGfUyL4RGwr2+eOyPp4JSpDSJTI7QvhObrnmYGXmEdtBOg2JcgOgXGIrJR7ws1L85Z1ZK6FyzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxqaYtf7XDXaygX0/g+nZTdkmBx4LBtX4w6UPqoKsiw=;
 b=NvrdiE96LAvg5Ry55L1iGily8USQbg86TQGNDsV22IEI221sy0EWjWO4ed+aA2mXSNz6+ofeZwIgKVCFA//PRPqDjwzIjoZpAZ6aaTjByuIvIwPVKAMcur56K9vWpy07folsuUA5uvCqYfzgVqjQhTct4heaKwVpXfwkdy1yshmEWmpWdnXEBbffClO4xFDVJvzE+9wiAvQgxPCFUXeCv8rii+l0e+UircpQamB7Saz4RsV0RTEXSxRoZEmRvHtE719mtp2DiJ3QBhQEyDoaqPCJYEU3Q13cVuVV94w0DS6P+LizB4R8iNeOHDcrM5jixDp20EQfZuE8X3yp26+DJA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 11:42:25 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 11:42:25 +0000
Date:   Thu, 10 Jun 2021 08:42:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        yishaih@mellanox.com, maorg@mellanox.com, phaddad@nvidia.com,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-core 2/4] mlx5: Implement
 ibv_query_qp_data_in_order() verb
Message-ID: <20210610114224.GJ1002214@nvidia.com>
References: <20210609155932.218005-1-yishaih@nvidia.com>
 <20210609155932.218005-3-yishaih@nvidia.com>
 <YMGoQ2ZmTjSun54y@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMGoQ2ZmTjSun54y@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR0102CA0022.prod.exchangelabs.com
 (2603:10b6:207:18::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR0102CA0022.prod.exchangelabs.com (2603:10b6:207:18::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 11:42:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lrJ4q-0051tC-5E; Thu, 10 Jun 2021 08:42:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74487e3b-f872-4453-ecae-08d92c04d134
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB527177D68C608EE3472BE5EEC2359@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ixyhc0hwlUsNLLj2FCV2k8weAJxvlERO65SEf9HADuJ7roSaOytdmjNCddBM5UXoXhHZXwBpru2ci1bF1Hl5zEhpVZElBjfp33Bn+dbOwiGsUoa47rwqVdyYN7lXFtzQ/Api4x7XJsc1SlqUmk7Qz2sS3QXXGG3GhA45WIRpOEh6szozTuWHi4VfPq9nek9UFeSQ9D8zEVA15w8S59SDw5/MLu8Fl/JgcU6vvDdzH7yDmv0sGjzGTndqlkoAS+I6K7hDKQu5bg9UlMxwNCZE4wlbLXi+4YBn6BmWr0Mk4orrEXlkqJ0GwkZ0p+EK8MkIL6L2EQq6lIrT4anL/laWSaS922kMAt8PkrzPHGJVBgdfR8Tydy6UHkn3fps1hzogkVJVigJAvN2DQvOZIEeD93HRJYcvDCjTN3QQTnZq6JWa2grgFh8l9EGcYl9sxdDMrG/8Qe6e+wbNNAiuu7cDMGRQcD0+M7nMJTpw0XGuzZXXghwJnqx+WYxa8VZmLyiDUBVralA5PoTAq75w6LbzEOBrZa003zPNf7yevyajTscNikH2j+MRwlxQzjZjs5dV9f7Uyx9Nek3M2ryOxb/urKM+cvM9PzIrHEzAMAxUirA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(1076003)(2906002)(186003)(83380400001)(5660300002)(86362001)(36756003)(426003)(9746002)(9786002)(38100700002)(107886003)(8936002)(4326008)(2616005)(478600001)(66946007)(33656002)(316002)(66556008)(26005)(8676002)(6916009)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gBrKJ8ln3CFB9z5rcwQBZdwnN1LBB3eanpv6hNJ2p3t7lSflgXYMX+M7BEbo?=
 =?us-ascii?Q?3OCSIJFip4R+//JR4+rECE5fKFxy02wtGq6Y6KCDGkK0cGo8NDbdT7+FpFMG?=
 =?us-ascii?Q?I6wS0nAORNZv42vPhTWkEqCEK/Szr578tUFo57fxcvE8zY4eKobx5LLaxkDf?=
 =?us-ascii?Q?V5AFkahQpgWPQQc46tyf5+HRAlLAg59zoAnfsFuvEGYx7jNmCoeaCiC67omL?=
 =?us-ascii?Q?CbyznfPki2sfg0HLF71uF4vX6zn53oUM6s8yHJpdGAUhcM1Eb0xaa9ohtVDi?=
 =?us-ascii?Q?vb6WzDlddwqC6T5cENMYG1SvKY9FDH+L+anm2vYrdgVBjpMX8NBUQc1ftAQX?=
 =?us-ascii?Q?puzY5T+ND09+/MGd+tGIp5ujZmacFz9ImBVEBOKLodyGjHR2CHl29y7OpazF?=
 =?us-ascii?Q?RlJLZCpYaDv7hq2Z/0uEMmuBE8iFW+2xE1Pj+yDX9HZlLZqQM8fA4bCUB2pd?=
 =?us-ascii?Q?nI2kDWAygqHu2jWQIlAEPIJ2cTmhr/pCQFOaRkHCxdS3zstM0tJWophZjjsI?=
 =?us-ascii?Q?7aMtdbD4M+ob8NkTL26RLQfemyaQwXX8AATETJD2S4cNdzqWfhrCsB/N4aSI?=
 =?us-ascii?Q?PqgNOdyfE7hzhUZSZbq+f65TgWkFu8xpBLgCqGbMfUly1WhehqtwwgHt+Zr2?=
 =?us-ascii?Q?oBDEGkLMiK8Fe61QSOKlrBW4CBtuBRwuaWqMFMi6PAvB2i23rnxlA2IPUYi5?=
 =?us-ascii?Q?xlRCD8VKRbpGut4TDomxZBEnifOKs2OlejyIs/pMQnlL3JRFvPsP6+j7RQ8s?=
 =?us-ascii?Q?9aXu2+lMAMXT/VDEvJH5IpkgckgwjAbeZGEU1vJKqFLhvEIZWvrJI2J945g9?=
 =?us-ascii?Q?VS9usVrfOgw1dpdjM7xj/Wbfd0PanLn/FkrUWmM6jgjza8uG7CyUJSJ89SH9?=
 =?us-ascii?Q?KuegtpB+ZZSK0wHSZbk8rJ0qI7iF1tE1lwoITZnknGmVfE638QrWmKdQ7kG0?=
 =?us-ascii?Q?Edhv1N/oX3FqWrjuAHIyKzyECFCT7uZGqVkJr0GOxXlS7brbu9hI++nm5X7J?=
 =?us-ascii?Q?Augu7Tgya1wBNL+48y83wbVSB8ozXh9/MxOK2NJ125QcMHIr7ht22aSMyvhz?=
 =?us-ascii?Q?WFNXAZdvQeySVJ+G1Mno6d6Ps9B6xnOuW2i5WdIOP2bzaSAl5I8bQ1ZgfRUm?=
 =?us-ascii?Q?I+D8CP1z9h8H+ZhFBCgeJbSE9IDbxiKlWRRnhVwK5M76VXFzfc17UGXT3xPI?=
 =?us-ascii?Q?yMBTUpHBf/cCoikrfHHiRbv5Ud3k+b/sBQ0394gbt8TFCnfktGpLD0ez3ZNZ?=
 =?us-ascii?Q?MfvOW8rYgZhPXzTWjU/bLUgFY+X0U1qtpggx+jJoS1up67oBGK125JyTK+6U?=
 =?us-ascii?Q?Inu9FG3BoDcyZ8gEofgf8moq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74487e3b-f872-4453-ecae-08d92c04d134
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 11:42:25.2128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sh79ose3vGs0Eamwpdxk4DsyzIJDayWA60rXjIwztyk447S+dA6FXXvmYmHu4p5J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 10, 2021 at 08:50:59AM +0300, Leon Romanovsky wrote:
> On Wed, Jun 09, 2021 at 06:59:30PM +0300, Yishai Hadas wrote:
> > From: Patrisious Haddad <phaddad@nvidia.com>
> > 
> > Implement the ibv_query_qp_data_in_order() verb by using DEVX to read
> > from firmware the 'in_order_data' capability.
> > 
> > Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> > Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> >  providers/mlx5/mlx5.c     |  1 +
> >  providers/mlx5/mlx5.h     |  3 +++
> >  providers/mlx5/mlx5_ifc.h | 39 +++++++++++++++++++++++++++++++--
> >  providers/mlx5/verbs.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 96 insertions(+), 2 deletions(-)
> 
> <...>
> 
> > +int mlx5_query_qp_data_in_order(struct ibv_qp *qp, enum ibv_wr_opcode op,
> > +				uint32_t flags)
> > +{
> > +	uint32_t in_qp[DEVX_ST_SZ_DW(query_qp_in)] = {};
> > +	uint32_t out_qp[DEVX_ST_SZ_DW(query_qp_out)] = {};
> > +	struct mlx5_context *mctx = to_mctx(qp->context);
> > +	struct mlx5_qp *mqp = to_mqp(qp);
> > +	int ret;
> > +
> > +/* Currently this API is only supported for x86 architectures since most
> > + * non-x86 platforms are known to be OOO and need to do a per-platform study.
> > + */
> > +#if !defined(__i386__) && !defined(__x86_64__)
> > +	return 0;
> > +#endif
> 
> Does it compile without warnings/errors on such platforms?
> You have "return 0;" in the middle of function, so the right thing to do
> it is to write with "#if ..." over function or inside like below, as
> long as "#else" exists.
> 
> int mlx5_query_qp_data_in_order(struct ibv_qp *qp, enum ibv_wr_opcode op,
> 				uint32_t flags)
> {
> #if !defined(__i386__) && !defined(__x86_64__)
> 	/* Currently this API is only supported for x86 architectures since most
> 	 * non-x86 platforms are known to be OOO and need to do a per-platform study.
> 	 */
> 	 return 0;
> #else
> .....
> #endif

We should probably put the above in the core code anyhow

Jason
