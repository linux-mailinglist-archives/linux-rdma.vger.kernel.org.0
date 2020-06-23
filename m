Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6742058AF
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 19:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732918AbgFWRdf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 13:33:35 -0400
Received: from mail-vi1eur05on2048.outbound.protection.outlook.com ([40.107.21.48]:61121
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732408AbgFWRde (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 13:33:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXuc99+ofeg2FIJ1n2RMJSGjIndhCHggUJogC1pwXRPMzulqu5f/Sxvrm6pzQDwX6aCPfWxwSJIBiBCQcI2gspHIJH/F6rHW/7+801jP20Z9TjJ6KX+Aw4nBTmXqojF9THuWomBX/3GqUDgnDsZ6q4/iq6i18M7DUu4kV6cRtSXYe4iop68VgnovQmqvClrR00XDebjh45Kx8TzfZF/r3tPxoHIfS+S2qGg77vLsEFzjjh5FkxmnYoe+CiMt8laNm8VPKuCT6D6KHplWIm3+cyv56KJdprOA8mxt+5k+MWeS/UCL5XBkMNZTIgvhrJnTY0cbxqYXDdRdAeTcZwpk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5eV8QgF1kw8Q+APcJiZmQbjfBfI8vrHSJLm18+j+40=;
 b=SW/wvjR67LE9n2GBWq1eoMsQ/wzmuSlW7mpe9P3XZsKLpe7f0EMjDLcYaNd5sCnV70yeU4Bt+Qm8T04kbqMAg6aw099xWj2JTGdtP86ieZzMetT5/hlsN45uAoN49rESRwk4W+1bSki8J3CThuTLn3TvZ0ViLNt3z+dG2ENWw5Hmt7wCgNbUt6yNwFsHcfK2LZFD6IT0LZ3ippNSf0YL9c97Duh3t5wpmFHScznATddEBy4O4NdSHBlpMocaVUfTPWbJUQNLTGhtH0XG5nNmbuwaB5zoAi/6E6ps6A6+EIfuWuhdj6T3+5CjQW3Yq1igydN+GAaDY5lJ+0jxxn9p3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5eV8QgF1kw8Q+APcJiZmQbjfBfI8vrHSJLm18+j+40=;
 b=bdCVxur+f0/7Xp4WC6sLcmxl7g9jbEG4tqr6UioBolnTFTETy/4lJMPrXIwPveSRzWr8AphXeTfI1W3YF1nYFB1drGKYMKy/knkKNBsjV9ZSoDz3f5AVcPa4JWcb7xxEenrGqm1sJ6vqFU4Pm/MI0dC7ZIs7x/3FNPdM8+653to=
Authentication-Results: dev.mellanox.co.il; dkim=none (message not signed)
 header.d=none;dev.mellanox.co.il; dmarc=none action=none
 header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR0502MB3696.eurprd05.prod.outlook.com (2603:10a6:803:2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 17:33:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3131.020; Tue, 23 Jun 2020
 17:33:31 +0000
Date:   Tue, 23 Jun 2020 14:33:24 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org,
        maorg@mellanox.com
Subject: Re: [PATCH rdma-core 10/13] mlx5: Implement the import/unimport MR
 verbs
Message-ID: <20200623173324.GK2874652@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-11-git-send-email-yishaih@mellanox.com>
 <20200619125003.GW65026@mellanox.com>
 <7923c6bc-d11a-e86f-02de-7da530c9e596@dev.mellanox.co.il>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7923c6bc-d11a-e86f-02de-7da530c9e596@dev.mellanox.co.il>
X-ClientProxiedBy: MN2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR07CA0024.namprd07.prod.outlook.com (2603:10b6:208:1a0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Tue, 23 Jun 2020 17:33:31 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jnmnU-00CyHJ-Vo; Tue, 23 Jun 2020 14:33:25 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 20215056-236e-4006-309e-08d8179b8c54
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0502MB36966499FE6B760CB31C47B1CF940@VI1PR0502MB3696.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Il6/RQMBB+A0obEA0qgbqcOsxs7bqjZUsnS5mKsl/H5sWaTlljYrZ2ShynLS8sOFcw4GNCZt/V4M99xLB6amCvtYQm7Vl92IM06+A65Iqnnq8ofGLYbegbZGvrNhmkqNOnQzTJORywpXUyLJCCpz5aOCkzgnptMATnIGFtMSL68PpQihknmrYE55hHV0rkgNSYwRpUjfwpRms/ZuyCMqc5xGJE/pUenGyF2d5kGN/xY8uV5+AYcId3sH6R78ATLsdFw80pxdtvu9tHYPRcXS9I69CUhO5gOgffgynTtwhZdkUaSa3fVWhY4S2UmWVpA2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39850400004)(346002)(136003)(396003)(376002)(8936002)(426003)(36756003)(2616005)(8676002)(33656002)(86362001)(6862004)(26005)(107886003)(9786002)(4326008)(186003)(53546011)(316002)(9746002)(1076003)(478600001)(5660300002)(66476007)(66946007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gRDHIowpiev1GTqn+4aX/MaEL2ZdIw6yUnuInwNtn5nVOIr/1k3V/Xip50GDNcCwxhi4O4UnsGhJduM9CsjjHjLRxUEobPNENw18iMM0WWcQTKIoJCSEibIrrKpSEC5qfX8yyGp9AlbNCVVSjDwTr4cZvxd9W54chIOoocEd3un+RRE22gtaWXG/JPqJPFGWW4OnlHUPSVnfFH1WPKhpeco4t7LJthkFH9g3skAY0OXJNGp/EBeXjWSsaX508eZKfGpUB8bb7Av256ly0mbI51pzRebeQay9q4IxZ7fGdQr05+17nkZ60drJ8hzXXE8WaPbtogUrmn8sNWe8jPeBE4F07XDtP9QWH8X1XFfXSTcW7gz6O9Ke4NezHd20Lk1Ar33/oVr81ShB9BZ44GCM6DtJ1Wq/1hqE5EabfM4rB09rt6wBkNzrj2tRjv8F2KX8CHRz7ziCiNmLd2ERY658864B0+D4awlvZHFX/3ozvS7bVXVmIOCSpDstgqkO2JHa
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20215056-236e-4006-309e-08d8179b8c54
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 17:33:31.5931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewCSDGUBvG+DMV89APYrTLK+7Qf9khSEsGJkKEppaQBqAHBaQ6ZaipMo88dvtWtkAzHyqk9e0pCrb4ufznRGfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3696
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 21, 2020 at 11:44:52AM +0300, Yishai Hadas wrote:
> On 6/19/2020 3:50 PM, Jason Gunthorpe wrote:
> > On Wed, Jun 17, 2020 at 10:45:53AM +0300, Yishai Hadas wrote:
> > > Implement the import/unimport MR verbs based on their definition as
> > > described in the man page.
> > > 
> > > It uses the query MR KABI to retrieve the original MR properties based
> > > on its given handle.
> > > 
> > > Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> > >   libibverbs/cmd_mr.c          | 35 +++++++++++++++++++++++++++++++++++
> > >   libibverbs/driver.h          |  3 +++
> > >   libibverbs/libibverbs.map.in |  1 +
> > >   providers/mlx5/mlx5.c        |  2 ++
> > >   providers/mlx5/mlx5.h        |  3 +++
> > >   providers/mlx5/verbs.c       | 24 ++++++++++++++++++++++++
> > >   6 files changed, 68 insertions(+)
> > > 
> > > diff --git a/libibverbs/cmd_mr.c b/libibverbs/cmd_mr.c
> > > index cb729b6..6984948 100644
> > > +++ b/libibverbs/cmd_mr.c
> > > @@ -85,3 +85,38 @@ int ibv_cmd_dereg_mr(struct verbs_mr *vmr)
> > >   		return ret;
> > >   	return 0;
> > >   }
> > > +
> > > +int ibv_cmd_query_mr(struct ibv_pd *pd, struct verbs_mr *vmr,
> > > +		     uint32_t mr_handle)
> > > +{
> > > +	DECLARE_FBCMD_BUFFER(cmd, UVERBS_OBJECT_MR,
> > > +			     UVERBS_METHOD_QUERY_MR,
> > > +			     5, NULL);
> > > +	struct ibv_mr *mr = &vmr->ibv_mr;
> > > +	uint64_t iova;
> > > +	int ret;
> > > +
> > > +	fill_attr_in_obj(cmd, UVERBS_ATTR_QUERY_MR_HANDLE, mr_handle);
> > > +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LKEY,
> > > +			  &mr->lkey);
> > > +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_RKEY,
> > > +			  &mr->rkey);
> > > +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LENGTH,
> > > +			  &mr->length);
> > > +	/* The iova may be used down the road, let's have it ready from kernel */
> > > +	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_IOVA,
> > > +			  &iova);
> > 
> > There isn't much reason to fill the attribute here..
> > 
> 
> We have defined this attribute from kernel perspective to be mandatory from
> day one as of other attributes above.
> Are you suggesting to change in kernel to let this attribute be optional and
> not fill it here ? other alternative ?

I'm not sure output attributes should be marked as mandatory?

Jason
