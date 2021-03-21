Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B14343240
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 13:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCUMIu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 08:08:50 -0400
Received: from mail-eopbgr700067.outbound.protection.outlook.com ([40.107.70.67]:5088
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229886AbhCUMIt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Mar 2021 08:08:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTPGP1grJsPjw3AZGDmikaArRpBldmw5ShMxyj447X+t2leTH+k1PapwGBzyGD2ZyN2aU4ULpC6F6K1agrR/OU/VoILlVXQsVxpabUv/Fp96ubNI7HnBPAF5iqY+0R7vvCG/kuL9fcdK+AevZNQD9EFSGEQS3GkOH9vbm9oazPikYpJYV0tvUtKKPorQ4cRRuO/B9UQpczVDhf5DJf6+7p/LE3ZCmI4Acs3PYdR6K/d1gRmV/kQ+GKZ03L+yrGKKMfIsS/8m1MU4eKlqenV43ymT5nkbYhk9CDC+VK+KlNbhyPPeLfmWNMl6pCSVcZaJd3xr1HjYwpRKBdSBrFsVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHIPMGmls3c538f4C5HskGWAK/DdKpe0DyTWswe17Q0=;
 b=n7rvZb1Sbtar5w5/nyWs6HRFf4XSzDwfILpNnXRA4Pk0zrz2ZMfh/bijWRFJqX+z6YyxXaHd1wF3SL1J5W926ma4Kl+4DpE0fNAaVfL0Nsd9G1alOoYGDgvjFwpAWyQw67CXQhStsIe3LQjjiXFHQVXKM2lxz9h7BjfIfYihLshQtOXJPY/CQFVcMOE4rb63WLbizVdPn80tbhHXdRpGCf+WVwuPIi2rSA7g/dnGw0RPxgL8wnYzNLH2Wina0Qzn4g2RHIFn5Zh5pIgwvx0ftEzxZtEKrMU9wNhVCvnBIomTUNeH8Lf1iNLB2DPol/Yqr390DQWOg1WhLFAwzL3mlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHIPMGmls3c538f4C5HskGWAK/DdKpe0DyTWswe17Q0=;
 b=lBqWKV0lnjUS504i9myOULb6IPTudjVukjs6E3TrPM11FrsaFD9OUO4D8/sKJqN7UVqckY0A9Rvbho0t8aDrhTSShF/C2AmcwJnBehEvSctIus3vtxD7U98TJ4ukRLB0l9oPw3eS5RVBaIaG9Gtp3nFbdsxcax1mFe4UtziGWZdlm9UVs+D5SEp3v+8ATzh7VhgJU5c/nv55hhYNsLDipEwTOq1wAmdKpeKRT0lqeG7Mw+378IlpQibrC9Ic4shq0jOARdO8nPt9/zXA/S08P5MmbJvBDUJp1hCZgff+X0y/Vy3VDqxq7lsf3A/52wXFyUF9mEzd2YSccMt+BmC4Jg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sun, 21 Mar
 2021 12:08:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Sun, 21 Mar 2021
 12:08:48 +0000
Date:   Sun, 21 Mar 2021 09:08:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Hefty, Sean" <sean.hefty@intel.com>
Cc:     "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210321120846.GL2356281@nvidia.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <DM6PR11MB460924762347AF1EA22C1E8D9E689@DM6PR11MB4609.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB460924762347AF1EA22C1E8D9E689@DM6PR11MB4609.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0179.namprd13.prod.outlook.com (2603:10b6:208:2bd::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Sun, 21 Mar 2021 12:08:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNwsw-000V7o-DM; Sun, 21 Mar 2021 09:08:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 870667a9-b579-4825-178c-08d8ec621539
X-MS-TrafficTypeDiagnostic: DM6PR12MB3210:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3210815210DB6CC661BB2895C2669@DM6PR12MB3210.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4d8Ec7K4c1Gg1DsIvWN/+w/yaOPWY518IRB/mRfcbUSu9stH79M4qtFdoAtPFtBclqd6TFtjE2RV0/CeiTkXyrNrStwieViwbnPEkP95SO1laHBb0ryulUR86fUTIjUeiErMC6QRR7yOQ6zAfGYeT6qXHYR6OTm7Ez9nkxQ//VGeNtzNow5L3gnYdzeJasswFwiC6blKacOM49DKqZ9zUbGXK3qEVtw90b2nukc+xTYXVTp8HpZfdfoBb9uqV142dj1/Lm4a6KjYY17MR3nxyCd4KUXj105iPDmYmqHUO+KvxUqowQ7d7/mqMzMBg/jW1Kis2ramR72D+/KIa1reUWfLXjVvfYf6kVAFbr6jrsUgdDcbziBnIclpIPuf8jLL+J63SxphplNX7pPQuF9Qqoz8aqyIM5H0AtwSQ1fiMU/Az6P6s8L6aUl+EusTBu0sP+lUIVIbmuEmKbwlqG9iiYT7Obw4m5HXnG8VdpurGxZQJzqgniPG4hAHhzwv9vYboP4jEekRRCwsIcByvJAWZMglqS/B574py4ZsnJIZ8Tl+orDWb+sDl5HanLldznhOCdAyPl8fqNn/N9SH3XoNsXIG15eRWcF8bLeJQ7V0E3rPukv81+mwY2sCqMpv1FtsLvNFeRoisck7H+tcrZuzNAbljfLcB4ZWCxL91gBtR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(186003)(6916009)(26005)(5660300002)(426003)(66946007)(66476007)(2906002)(66556008)(8936002)(478600001)(2616005)(86362001)(316002)(4326008)(8676002)(33656002)(1076003)(36756003)(9746002)(9786002)(38100700001)(54906003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3Vyg3RJgi51mchL1LwPB4IHUqslOkASEFWsULjMSjEW1db+fTSS2g7VgPfyH?=
 =?us-ascii?Q?BCOV7V519se2qbZNEzoM6EKtkiEtQMhbkpyi3Tt4PPpR8EF73s7sLy+U0TII?=
 =?us-ascii?Q?ecjXwYqbT4HA0Nx185FiAF+qX3hDxwTVjSTgr9Ss6XHoYWVsTt1ZjbTBhI4C?=
 =?us-ascii?Q?cSVfQASowaiPExfqRO4jdrdgImUAq7pnLci67HmF/GLTtRPCXaSiAFOJ1nsW?=
 =?us-ascii?Q?ycv7+CbXBqpNIsVgB6gKOI8qkghfz7M4U5jWnS4OiIOAv+zu4Ea2kfFYJYPw?=
 =?us-ascii?Q?CxlrfxWS8JHLCUVonfd++VR80LYJ5u6zqsRisEo9EAnuWhNA7VH0QUdSS3Xg?=
 =?us-ascii?Q?BGuBSQKPYwfQow1Dqk8tDX1goiqLNWi7lRp+vnHMpV0Zqe9ReG/YgOfaIz2P?=
 =?us-ascii?Q?PkZNQXiGLBmh0fhqyCbajlQYkQuDbDtUOV4+32FVb/f90HLlc2iySvVBQegs?=
 =?us-ascii?Q?rn55qlYBPs1SGw4xrAmohl2BlIkTvTR9ZTMDzo9wqbeLiIDee7JsOoa8havo?=
 =?us-ascii?Q?+s6C7ydegzjLV638JMah3rNk7Q1fWnocgLLAXnim3XrTvG7fJEjY/GaKt2ZG?=
 =?us-ascii?Q?poQ81uuR9Mqa69Zs5HPrr8kyX18kFJzQGaWT8Chg4Bx9P/UwNRmf1nv6M+EF?=
 =?us-ascii?Q?mZz13Pvzq0kf+2gFhp3Y0sYdiT/pvQXevqON6PfPrf2Ik3HSYmI7sU+ZxGzE?=
 =?us-ascii?Q?DyYABRZWrbUixSNqlwy+xIemusj1spbR74AAb/uyeLoIy3g2ZUrN4c09gx2C?=
 =?us-ascii?Q?DZ7iWcMaGwQ7ORD3m17xckfGZCpJ3+0y9rtsjThot/enILx1Gwu0OvuSjqS2?=
 =?us-ascii?Q?4D3kGV6pl6TVBIr4gcgHdnWipeApK6lu5pNsGHl8OnZIMdlJQr2P9Mqk9Y6m?=
 =?us-ascii?Q?lCyUhj7VMRLUjLDZsS/NGrTK6b2EPXrd5IpfveB4BaYvBrDwIHeKg0eVSITy?=
 =?us-ascii?Q?chEscnusPljwOrtJXxHspi6DcmG53dRkfsZ3+hY5QTfotOtc3gCqslHOqJxR?=
 =?us-ascii?Q?Jd93SrCAM+0VEfkTMA/v/ydQXLXFr3kJt+C41lKjV7oi2uKXKB8993KQf+GE?=
 =?us-ascii?Q?l2KQR9jGEkJravlMDGr9N4KAWb+E+25zxs+5iMytflkNZNeqItjxKF7YhLE3?=
 =?us-ascii?Q?mvEGL/cWLZFWTXcCmdRdQKq37JBvhX75qobqbdb8TcgwxzxwcNq1YEIWBhFy?=
 =?us-ascii?Q?MaXE9tilreoWRhRZY1mMeS7B0AqeJc25sVOWUm3V7uhChjNacd02NFq9v/d0?=
 =?us-ascii?Q?4KVeMN6QCMAMtNEuwsTYzVxV79l2zlKtHRte2HmSEl7jGTB0yhlIvezOgovb?=
 =?us-ascii?Q?MhoIhki5tMb4b9KMVKuKfox+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870667a9-b579-4825-178c-08d8ec621539
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 12:08:48.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puAm6XqD36f8t7hzXqABBR/zJcthQzvQL26k8mTnvgZSY4DhAjyHKQyCXu/2Jbib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3210
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 08:34:17PM +0000, Hefty, Sean wrote:
> > > > I also don't know why you picked the name rv, this looks like it has little to do
> > > > with the usual MPI rendezvous protocol. This is all about bulk transfers. It is
> > > > actually a lot like RDS. Maybe you should be using RDS?
> > 
> > > [Wan, Kaike] While there are similarities in concepts, details are
> > > different.
> > 
> > You should list these differences.
> > 
> > > Quite frankly this could be viewed as an application accelerator
> > > much like RDS served that purpose for Oracle, which continues to be
> > > its main use case.
> > 
> > Obviously, except it seems to be doing the same basic acceleration
> > technique as RDS.
> 
> A better name for this might be "scalable RDMA service", with RDMA
> meaning the transport operation.  My understanding is this is
> intended to be usable over any IB/RoCE device.

It looks like it is really all about bulk zero-copy transfers with
kernel involvment.

Jason
