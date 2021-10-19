Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6DF434211
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Oct 2021 01:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJSXaz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 19:30:55 -0400
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:3992
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229554AbhJSXaz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 19:30:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8jUmYAkSdIANd87S6wFKEhoeZpzA4NjpNuTexsa/u3ohMqgChY/EKhJHQ8ziZ52IYbrIrW7POQXTmbg9CVkpmT2Dae2PHKjFKDOPtGBMa0hyi5wFTnvr5fy4quyFY3DbsJDhnYofwVMeYO20u2hmbwjcatncDXRItxn4IbYOzFNNMABVwRAZ9zDIeiep8Nd5xC40AilT9/wLh7yydt9/0KtOEAlcVNnBCg/YyfltxOwVyAHVU8wGGXJMFZZd1XOtQ17VLdp9RpO58cUSJbmOKE7V1nQKnQ+YU1cRySJNxgdk3YnCynWcJYzfo11Yg7EkJBKK+VVnuspT/ACVcCZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBywJRo2di2kJoEEhu4FNtT6pxYgRxzaBGcozz6p5To=;
 b=oT9tVXG4sn5Ms9fiv/3mWzX3IeHv4zQha67+JbnZqtnD+ASznPxcyn9l6CXVT6/+3CK/w7fetl4NeTcOJ3MM/Z/UTqNKx8akakDibTXusSFdMeITe4BblGdetwm/7TLjOGVI+kfWH3NTUmC4oJ02VgHt/aMO2IkmwntScvG6rGlc6Xd4v/FDy5vNd+cPGVTpnOyDTZP5oKOjaWapWKhZYfhl8ByFdsBe1ERPbVNbL2FDh2kc+krDRTXHqhd1PO77UCmqMvDLmwAL1s2pxYXZMMNLv3OcLi91iH+Sf6kG7VNOwpV6/h5iZkQEE1dwt7KFZNpnWDXLOkXBW94bHgwQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBywJRo2di2kJoEEhu4FNtT6pxYgRxzaBGcozz6p5To=;
 b=FUaiIeK1aHbzQWo1viIjDVUjpnZKr+VyGwsu9JGw0MNxExwpuvdvJfch6HTijnRZlaq2Nh5hUzQCfM0I09YBhWjcS/afTJzPysDx/YVi4K6C4Rk8XVionxJkoZ7oBzSiWRxHz5lK/P/gxuJMowVv5Tdf7skAnJaPtIY+UAmFLxJmZcNluXDGzEmECt4kNoeHq+yn4qVQ6tQJtS7a5yrUV4Xpgv35rsRWiqYXvTfhnvu23+nrMYLrZyLLMgBKOftZBt/a+C76dE10Y1epftT+5dWdNcXEa6ctim5idJhfSeDcxB0lfXe8ID2c4c0PaSZCOnRIzI5Hd2k13DyMRZlfEQ==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM6PR12MB5550.namprd12.prod.outlook.com (2603:10b6:5:1b6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Tue, 19 Oct 2021 23:28:40 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b%5]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 23:28:40 +0000
Date:   Tue, 19 Oct 2021 20:28:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>
Subject: Re: [PATCH rdma-rc 1/2] RDMA/irdma: Set VLAN in UD work completion
 correctly
Message-ID: <20211019232839.GC4135767@nvidia.com>
References: <20211019151654.1943-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019151654.1943-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:208:234::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Tue, 19 Oct 2021 23:28:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mcyX9-00HLwC-1T; Tue, 19 Oct 2021 20:28:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82fbb8ba-f724-4373-7b9e-08d993582ed3
X-MS-TrafficTypeDiagnostic: DM6PR12MB5550:
X-Microsoft-Antispam-PRVS: <DM6PR12MB55503060F9D1D5FD3390FCD1C2BD9@DM6PR12MB5550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jpql6ory2/d+4VkuW/ltkENhO7My88BzYysGNEUr3bon/uzGXrEBXFQ4XBavE4icivmgha4uw5HhTe8A1CZNkPuxKsznx+hM6GYDYa2ihQ4CgxyxtWBji0VixABeCmm8IcPga+eo56+zIhD0VP+/9LJz1lLK4XLQfDJED6y3dihAwldImR2U2O054h1U4zIIxqIcnJwVvMjbPN4WhDd9lW7iZ7LLG579ji3+3k1aMO3Ct417MUNuW4xt//Rcw9F7yeZmiYIBixaMmtkGSOtKycLUK77+B/3kyzjWhEouVGmWj5+9GfHeD64FOQarA/2YppWX0Pbv/9k0UmBgBa7G0U5OhacqBFaAujuQ1nlIwQFRQET9e6qUaAnr7PX/l1wIkBjeYn8sL1GQIvMpN8eziska2M6lplbKDxiqSqu2bzh3qa6wJ7ZZtDMiB3IOiCnB2Zl6tb28sSed6LndlU4dGAly3Cm7fPMUTkVTYTbMgLZfntgkNZV1tgYz2IEPcSTV6jFc5hmZ1cM3SrJpSsj0hevx3Ar1RLGiV3VQe2SusoMobmHFgzzgvdZQFZ7rnlAGMBp2S8hs1MTPZhgyey66c8ZuK78DJg7YgBosrURkPwnllT2LCiAHoA9kk9CFHOBonCHEM6r//E2/qiQ8APP65Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(2616005)(426003)(4744005)(9746002)(9786002)(38100700002)(1076003)(36756003)(6916009)(508600001)(5660300002)(66556008)(66476007)(33656002)(8676002)(4326008)(186003)(26005)(8936002)(316002)(66946007)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nf+el2KhIvJl4+ZS+fcFka/HWrLsb/HJSokOe3f/MaYMu7qoNgiEhQIn/hsT?=
 =?us-ascii?Q?t7r8roQRapN5g3M5v6JqtadYGxbOkMAU1PX/iRnqyv9P++wMt4iuSDI1e0b2?=
 =?us-ascii?Q?pHuvfq/Ck5lo0GIcHymwfluHsZnRbZv3odkxZwOTLt7oGI1nBQkfNMwKGJB3?=
 =?us-ascii?Q?ciBqTs8Bd2HibtF76NJm54Kh6fBUCmcvmoGMb9RJLmY2mXTB3sEAh2rV2YEw?=
 =?us-ascii?Q?4e89TVqAsXLPlllgwACJEgJpbXiW0G+WKqCxrM+uV/uhWWEQDZscPMecWKZm?=
 =?us-ascii?Q?Nky0pPlzKuV0J4FxK69n5ls4Z3R0bUmvuLWotX8P+GtqBghnDjKPtRZkvUA0?=
 =?us-ascii?Q?aa98qeWuXH9s2EMul3jdjaLN5NSPyamyOYlvW/kUJo8fk44nT788msaPFzrw?=
 =?us-ascii?Q?ZDd//ZADivWiYdV2E17sLtS2Rljkwz0bNh6bXxRI4aMmXmrnMzedrsVSC7/s?=
 =?us-ascii?Q?2DlaT9leghZz1lND5s80jo/u5uITUbMUk71DOoOE4ahEVBhaYF+6WmYHY/kF?=
 =?us-ascii?Q?U8fa9oKP79lKmRLAW0URBg7C59BgFugDz2A1qzI5v1l8wYW1opoj7rOpikGP?=
 =?us-ascii?Q?b1hFVa+KxszowaHEWjpFnIBrNhA4+DrmChapQG2J9Uu7WwxKxIsQLBghCwlf?=
 =?us-ascii?Q?lx3kKtYD0G0Bw1hXflC6cqQ7pkHqf1tTgG34fuOP3vIYE9lXh82QRVHYoeLY?=
 =?us-ascii?Q?2LBJQ47xkum/j3aljPvzVsF/u6GmTuDP5Yjk/nCf1SXA1H/d9TqVXWSDmflo?=
 =?us-ascii?Q?a9VOIhlUePF0kzPXDVF3knkujM4mskD6e9TG2H51Z1LH1dFh3y+3PILilntR?=
 =?us-ascii?Q?+NTLUCfbwbWhJivKnQ6VdylbnplbHvXoVB/vK+4FsX7t4XSXx8hPq1eb/3KJ?=
 =?us-ascii?Q?EYK0gfVyNngwvUz5pgdJb1mOgJNQYdvxGoix4DUz3sXX8YxkrwaPa6GLAitO?=
 =?us-ascii?Q?qjPWIJCc7uTMlO1DEzY39gbrmSSyZO5ozCRp0gTccuba+uXLDjlrgfvJosZI?=
 =?us-ascii?Q?Mv2T3EYQPxLGgpPY1spKHDQbFLkyGYjEGf1mEL93c9eFfNogA1Qc/Oqo+RAP?=
 =?us-ascii?Q?98KQ7zyKVElQOlzUUGMQTMP8QGuqvyvtvusZqsKBgWUerQLQbpvddp5Apt3j?=
 =?us-ascii?Q?DZ06U1uauOOKj534RLby1queajFFH8oGKa1odDL0+ESO5CpDYBpz2iBjDmuP?=
 =?us-ascii?Q?etRL2iMZKfShEXxi673sbt/VOxoeaK52vW1g/1HeI/GLAE7cCr/Bhua4S6+p?=
 =?us-ascii?Q?ztdx65jNDD5Sa75KN9KO1wD5KljFzqnLFdXPqdlUCHLDFd9WBKZKZohiLUQ1?=
 =?us-ascii?Q?k2dkC6uYh+LjJs/TIG//WbvS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fbb8ba-f724-4373-7b9e-08d993582ed3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:28:40.5256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JJcqF6t/fGdeJ97QSsmcrzpckzi3fQwh+Qo81q4gSWwcXpp7t29PPgnQ93ykFl6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5550
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 10:16:53AM -0500, Shiraz Saleem wrote:
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Currently VLAN is reported in UD work completion when VLAN id is zero,
> i.e. no VLAN case.
> 
> Report VLAN in UD work completion only when VLAN id is non-zero.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

These two patches applied to for-rc, thanks

Jason
