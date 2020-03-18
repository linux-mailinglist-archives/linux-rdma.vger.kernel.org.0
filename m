Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92AC18A937
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 00:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCRXbH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 19:31:07 -0400
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:47052
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgCRXbH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 19:31:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj548AEv8pYJWr2zhEfkjUgttjL98BwerAICoq4c6vDgAFBZY1aVSy1RDTID4HfTYwtb4H40VCmRpYWB1sZ/nJhrSd5Pg+bCxmqZNAdAaZlfH/DtP0YfsKmdCbBTb4niQQnFspkkwe6kAKaoS855rianqffGWALWJt6VddRNZ6a6gs7wzWj10iLdVc/lN4Tv3D+MRMIoWy1i4ZSd6e6cRkRriaQYTFjp3T80cSpaeM4TPeRiXvA+ja+VoD7ivLD3nSgQmyp2PSern+wIOIuUhc7Klb64ndcwMfWk4SzgazQ1lpI426NuDDYe8Lri9DsKG4eIwuzXp7HIoXitn6Mv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBFNkX7W4JNRHNpQCBpgH8Zk0uw+mrz1rPAk/1LLETU=;
 b=kktD5g99y8DQiizCmef5/JtolArwWx9o0vU1Nn4JdITjx9c0sGWUAWc4DdSgtCN/InozRq+Ttv+iHom+YMn0jageeoj8Qw4yzobFVFEAR3VbmgUT3NLk3q671wuA/TvnruIlqgxea2I8R2S3iXBdFvGPXKg0mh6i7FK/5mVZRlhrK1XsYrDXd8qhXn3EHTgonuhsH60yzb46AZBvFggwJ+t2QS9bsKecQPmGa+W3JCrJcjnZNlMp1euGzOWL5vzcPYu4KowSnzdgPGQB6swnE5si6behTK36qPItPl4eI6KizWyOLViOjdN6KdgGcFh1+qhprPw6eiqnOLc9L71EyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBFNkX7W4JNRHNpQCBpgH8Zk0uw+mrz1rPAk/1LLETU=;
 b=PbmSNXWTnD/ASqHyh+f2Gk2pA3cxy6VPZn9TxRpzYBI9dDlerYiCI8b+5ikMlwKwLD8d+WmiwbzjYMG0B86Rxzb8HBQPb0AtD0HHr06n7/Y56+p/Cc7g1xBglO03ERv7vuDclpM0wQuE6JaLBTK3YmGSujSqvva5Y/iE16/yNcU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6784.eurprd05.prod.outlook.com (10.186.163.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Wed, 18 Mar 2020 23:31:04 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2814.025; Wed, 18 Mar 2020
 23:31:04 +0000
Date:   Wed, 18 Mar 2020 20:31:01 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH rdma-next] MAINTAINERS: Clean RXE section and add Zhu as
 RXE maintainer
Message-ID: <20200318233101.GA18746@ziepe.ca>
References: <20200312083658.29603-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312083658.29603-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:208:236::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.12 via Frontend Transport; Wed, 18 Mar 2020 23:31:04 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jEi9N-0004tz-2t; Wed, 18 Mar 2020 20:31:01 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d26d9f48-397c-4fff-7f3e-08d7cb946d0d
X-MS-TrafficTypeDiagnostic: VI1PR05MB6784:|VI1PR05MB6784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB67844B02C417570D42B3F299CFF70@VI1PR05MB6784.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(199004)(316002)(8676002)(81166006)(81156014)(8936002)(2906002)(4326008)(52116002)(186003)(26005)(86362001)(54906003)(1076003)(9686003)(4744005)(66946007)(66556008)(66476007)(33656002)(107886003)(36756003)(478600001)(6916009)(9786002)(5660300002)(9746002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6784;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0yF1TQBYrM1MMwWjkDddtxhvPVOsj/epwxRN1O17rGmslrtFBme+QrftLa5bDZb+9Nj282prHhClcv+0TZX3A6yG4Gzz7WtsJ1gM4YeytezRenNhwH9Hqr5zReBvk45LjawnYx9aX0m4mVpkXYcTT3kdK0ZYe2LvEzT9Wt4J/12miMzC34tf1kDTTrM8yHTRViG8KRVxUBlEwtw3dCqQp3yVd8C1pwI8aediB9HHZhqcPUQYEnvkSZtSDUmATHyWFTyErmMDalL6v7X0a/kWJH8G/RMx0xsw0U7bMxbufZbT2gQaDJTL5birQ1g8jqZCLFuTTmWSJfVXebsC5LU1S8ly7X05oQsZHtzuzYsS9o/Vni2MHAk/tEB/7xPPtd7zfbIug7gWjK4WrFRfu7W109Oo1LZvCQmQmy3kdL0R5qHwzwIEPst+NChzEVm8TmJgup5Ajc8oVHqeyY6VnhVrwrPKx7KOv0+istiDCGIEQAPZPX1EJkA+VZEXi5c6b6N
X-MS-Exchange-AntiSpam-MessageData: rHawJkbIPGtNrDIr/vAcI/7tGM0zTcWcNn3fCZqS2u/rO0vGJuH+zviiempA+H45qYMwe+6/E/fyMM4OUGxfVegoDwpyF1VWcLx7yt2yjAxDIFAr+zC85O7ToGXgaCw+ofiAWqYK5WcJ3VCkzNzRLQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26d9f48-397c-4fff-7f3e-08d7cb946d0d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 23:31:04.2923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjvXVIi+kr+6Nr/UqbOJ0hSUZURCcOZhzserw8JOdcnMvOaLnHrFbn2phOmhLZA61MGbB1r7SJQP2jRsaBJQiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6784
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 12, 2020 at 10:36:58AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Zhu Yanjun contributed many patches to RXE and expressed genuine
> interest in improve RXE even more. Let's add him as a maintainer.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> --
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Moni has moved on to other areas and is having trouble sending plain
text emails, he gave a verbal:

Acked-by: Moni Shoua <monis@mellanox.com>

Jason
