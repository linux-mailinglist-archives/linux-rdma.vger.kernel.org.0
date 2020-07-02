Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E060A212B68
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 19:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgGBRnP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 13:43:15 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17307 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgGBRnP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jul 2020 13:43:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efe1c4d0000>; Thu, 02 Jul 2020 10:41:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 Jul 2020 10:43:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 Jul 2020 10:43:14 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jul
 2020 17:43:05 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 2 Jul 2020 17:43:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrP2MbKIKLIzWeaOPIUSHBNSZug37dvUIvcHLxBPeHbaE0U4poEeWsnik2eHdd5LB+JX9eRqBzcBTW82wbZzEhdXSc/D27mKLzAgvtvfvZmi+BADrXlsJGbDhEEnZeWCkCXd2MMs2YxSZeCgQ4fuKYUiCTaxMI6qTuPS0WhA/xBVYnGREXAw91pT8Lq9vfnYGqBqAmR5DUiw+KlBEyu3wcnRlGnGLd6co1YTPk4wa1L7gf61EbOvGTag86iYfdJ+8OB01nNhkMzTqral9byWpevhPTggpJpFpZ/wjgVAJk/23FY4V+peqyYYQKzpkaGeBj0O63NgMfGAqTHU+bgNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytVyZSfZModpS9KZynLb8XF35AqPjWONFpZRPFxaNzA=;
 b=UjthxQ1mrgj9FLn+NOESZMiOTMUn7ByFru93vTGm2EcPAs5mlVD+wo3HzYUAnj1l1BYkTa+MlFCamg0TWJPIHE5S/F3pNPe8FGtqhInhLlkCDekpCBooKaLoqG+ex/QaVXKn7n6xL/NZdNVf088iFWsl7jPq5xfylmeslXeLhuL41U3kiWHQ92cVCHydvtrByM4wdJwPwaKWsPPRgVyCVlOY3oXkI3zjurGburno3tvaQ2Gkm5KgFm1/lnReZT5SzbofNE7HtDwnF5ox17guEZOjBpzpmMVNqJrQSnXcnPOLFYUmJWbk+XGl5B95I11Qvl84kg+2d2kXyuY9syy1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: dev.mellanox.co.il; dkim=none (message not signed)
 header.d=none;dev.mellanox.co.il; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Thu, 2 Jul
 2020 17:43:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 17:43:05 +0000
Date:   Thu, 2 Jul 2020 14:42:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
CC:     Yishai Hadas <yishaih@mellanox.com>, <linux-rdma@vger.kernel.org>,
        <maorg@mellanox.com>
Subject: Re: [PATCH rdma-core 10/13] mlx5: Implement the import/unimport MR
 verbs
Message-ID: <20200702174259.GA720780@nvidia.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-11-git-send-email-yishaih@mellanox.com>
 <20200619125003.GW65026@mellanox.com>
 <7923c6bc-d11a-e86f-02de-7da530c9e596@dev.mellanox.co.il>
 <20200623173324.GK2874652@mellanox.com>
 <653b5832-c934-5460-1874-697809ff885d@dev.mellanox.co.il>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <653b5832-c934-5460-1874-697809ff885d@dev.mellanox.co.il>
X-ClientProxiedBy: BL0PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:207:3d::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by BL0PR02CA0044.namprd02.prod.outlook.com (2603:10b6:207:3d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Thu, 2 Jul 2020 17:43:04 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jr3Eh-0031W6-G4; Thu, 02 Jul 2020 14:42:59 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1642440e-227e-41cc-fee9-08d81eaf5fcc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB440272BAC89060E2771ABB82C26D0@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uO8DG+nBaU6gx0Ft00bNdM5SqRKr7hZGJNTWAJoLzl8cS6YvCuTnro+duacfkWcTOc7jb245uxr4sQ6aInaFsiqixV266dEsLN2IX3nbtUKoNSeSGSxmvBGCeMCQKgeuslRfHKr3PU3muAuv97aa5dK5dyNBIuYNPdrMcsD7Ns0zywYALwHYFDi9hHq02oH34nTxi7IxQOyu7Tv77Dqk6Gp2ZJQMOdclUtK1nVGV/khimPkL3avDOZAxVhVGN4hnkLM7bKt9r2f9airURvkJ7EhQrygBuhycoLCG0LN/NThjzMp9sQBBFGNYpxPLWQduYTKD9rok1pLaAthRhVJoA1EatGlkJhJVfVeB8nexPm6Dqmx1WzvGTgEFpxFZjI6m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(6916009)(8936002)(86362001)(26005)(8676002)(83380400001)(53546011)(2906002)(478600001)(36756003)(5660300002)(1076003)(4326008)(33656002)(66476007)(66556008)(9786002)(9746002)(426003)(186003)(316002)(2616005)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Q0KtdXpEUz1Mo1NS75peQqO+ZmPrPhkN/+5uVkAPsUIJ6kD0uRKWJ5wzA+EQGg87gZPHzGQiF7YCBqsuEMGxyPfhlbrYl2Fgb725iL+dEDV2siRPPQDxPEw6v3NBQNzKJL7cP1CIx4DJS1wmjMIefXngIak3jHOwW5Xp+V1QW0LurFzq3rZmCYeb6WfpzpNGSpen49q3Y5jzn/ynYn4NA8WZ5Rk9wbIKKDRoDZjQSDEiioX617CXLR4cxeGyQcdQ/x2QvtlB3obag30TpRFyg06J9VdOqn/LB5CRNhX4Fs8IIaFVxy+K6fM215BYvgck4HaK8KMCkERUfnhES+bQeiMnXUFVadjerX1Vlg8nWvJBz8b4FMevwRr30QbeEHXNmh83aGX5ZLwPdQGOAThGYSj8LRKHUu8goykLQoQZFpXPYomHI6Qi38Hk2Ivr/m1qBt3GijwQkOLVwybDVY31YTxDEjMMjn6fMz2Te/bm56Aie3nGWEWUpK+csfOxCXZu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1642440e-227e-41cc-fee9-08d81eaf5fcc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 17:43:05.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4rLWaTytVaupNHQiPAok1RJX/JiNyG9113NOT13H2pq9cZf+vZA9F9/t0mWudk3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593711693; bh=ytVyZSfZModpS9KZynLb8XF35AqPjWONFpZRPFxaNzA=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=XCPeaN7aqJtQoF5t7mNx1khoTyoLFLHBQ6eMUzEgw32iRTYvMxFm91VQ+4HsclbrR
         Q/xdJCOvxr5qpRfrxmhurKccZ/T3rc/p2mH/GRA/Qopu0irmPZ2S5FuS3gNffMkoVP
         v6g3ueQKZ+lPKd+3PRhvYPTnFWI7bZEDy5vN/fK7dXyagT2oaCqH+3RJwzOHkJKAJp
         0cgk4CR4LT5vbWDZWuXEskAo89YYAH4qsh0z8xWUenvnv9jCbwyWmOpXVG/L97QFOl
         pDRZXnyXfPITmg6WKxmsxVkalE6HXv6cSdMiSBLLjblpc5le9pZaCTFbBYQVRadgKX
         bIX0AvkK/EtNQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 01, 2020 at 03:28:24PM +0300, Yishai Hadas wrote:
> On 6/23/2020 8:33 PM, Jason Gunthorpe wrote:
> > On Sun, Jun 21, 2020 at 11:44:52AM +0300, Yishai Hadas wrote:
> > > On 6/19/2020 3:50 PM, Jason Gunthorpe wrote:
> > > > On Wed, Jun 17, 2020 at 10:45:53AM +0300, Yishai Hadas wrote:
> > > > > Implement the import/unimport MR verbs based on their definition as
> > > > > described in the man page.
> > > > > 
> > > > > It uses the query MR KABI to retrieve the original MR properties based
> > > > > on its given handle.
> > > > > 
> > > > > Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> > > > >    libibverbs/cmd_mr.c          | 35 +++++++++++++++++++++++++++++++++++
> > > > >    libibverbs/driver.h          |  3 +++
> > > > >    libibverbs/libibverbs.map.in |  1 +
> > > > >    providers/mlx5/mlx5.c        |  2 ++
> > > > >    providers/mlx5/mlx5.h        |  3 +++
> > > > >    providers/mlx5/verbs.c       | 24 ++++++++++++++++++++++++
> > > > >    6 files changed, 68 insertions(+)
> > > > > 
> > > > > diff --git a/libibverbs/cmd_mr.c b/libibverbs/cmd_mr.c
> > > > > index cb729b6..6984948 100644
> > > > > +++ b/libibverbs/cmd_mr.c
> > > > > @@ -85,3 +85,38 @@ int ibv_cmd_dereg_mr(struct verbs_mr *vmr)
> > > > >    		return ret;
> > > > >    	return 0;
> > > > >    }
> > > > > +
> > > > > +int ibv_cmd_query_mr(struct ibv_pd *pd, struct verbs_mr *vmr,
> > > > > +		     uint32_t mr_handle)
> > > > > +{
> > > > > +	DECLARE_FBCMD_BUFFER(cmd, UVERBS_OBJECT_MR,
> > > > > +			     UVERBS_METHOD_QUERY_MR,
> > > > > +			     5, NULL);
> > > > > +	struct ibv_mr *mr = &vmr->ibv_mr;
> > > > > +	uint64_t iova;
> > > > > +	int ret;
> > > > > +
> > > > > +	fill_attr_in_obj(cmd, UVERBS_ATTR_QUERY_MR_HANDLE, mr_handle);
> > > > > +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LKEY,
> > > > > +			  &mr->lkey);
> > > > > +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_RKEY,
> > > > > +			  &mr->rkey);
> > > > > +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LENGTH,
> > > > > +			  &mr->length);
> > > > > +	/* The iova may be used down the road, let's have it ready from kernel */
> > > > > +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_IOVA,
> > > > > +			  &iova);
> > > > 
> > > > There isn't much reason to fill the attribute here..
> > > > 
> > > 
> > > We have defined this attribute from kernel perspective to be mandatory from
> > > day one as of other attributes above.
> > > Are you suggesting to change in kernel to let this attribute be optional and
> > > not fill it here ? other alternative ?
> > 
> > I'm not sure output attributes should be marked as mandatory?
> > 
> 
> OK, this attribute was changed to be optional in V1 kernel series, the PR
> was updated to not fill this attribute at all, thanks.

The kernel series looks OK, someone will send the v1?

Jason
