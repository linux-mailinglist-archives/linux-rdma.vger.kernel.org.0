Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22375338E34
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 14:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhCLNDh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 08:03:37 -0500
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:10625
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229866AbhCLNDe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Mar 2021 08:03:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdPgx/gaNhYCruMyT+U5b1GS23vo/8Lb7LhzuHOR1B7Wu5Ks+szyZho85SFEIejX4deEG6a4CQh7RmHqN21xOBPMfkR1dUCuMr0JTerggkoNqqVqpu/oWS/vJtTcxus4ohfRKJbfjE2/vGi7OEL+JrDzrVJkp2B1VG2DfhGqVJWdwZLS8PGrG9y9cuZPGQ1gGcQjWNTPXfwqbHRjYUJwjS06AxZDfpG6WX4ziO33J00QOSgCmUqjG371QgaC2xqRPuMYzSyCVWRj3O1qEqjS2FVZVZFZeuFaa5D92NSOsjX8H804HuDeRE0ghGKuedMsHU07HGvC7xuXN2ZfBM0xMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ImM0wP6L7sOOGLZdddihAruU6XTsDI7U1GZnopTtx0=;
 b=U0uVKxRCZ8+vxqF8JScyBTkuwowToPxNnsnjhbB82RoheEzzLhkWoa5sxkGG46tj83+8hGciApF8z256NZ9qWDrdWL2rr8e9xpg9RzTxG8K6n1fG4bQIdfylayl4oPZR9vGn5tkji4gxrQVLKNi2vwXK8VowAwBXEqD0WcXIDQd5S+KHXL2meaSjQLH13KANiwLCOxO5TPDwLI+wvKtrtB3KZNVn5MiCmddRJSqhAuExNVxACopBLCIT3TnUTGdGBafcGOzzhBIfa//E5lBNrYA5jBBceKnP2+BWVVa0x74iG9O/c90UEw86uTdAgULwkyEME0IBWcdLLtFuimsLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ImM0wP6L7sOOGLZdddihAruU6XTsDI7U1GZnopTtx0=;
 b=OG5YBA2Bf/LXRyFLu6m1m8EM99rFd0o1sXAaxDW53svEQbe7LiIEE7uhElK0NERurxgsPc6kJjVrsVHMK6RswZ/tOySw5dQdQn3xS0IKJfMyUpouO9ebginDiDqNl9tpJTZhkP64W7kOrtQr8s+R4WiuCqDzFTi5YeJfx6a5+8UgkRjjsfMdQVVci+x9ppMa9NNpIH33kiP8HOn/K1VOnM4CRslWY903EVyGrrMS75N5OQOuOtS/bixEPX8VRYUfxvA4IZhao4OXFWs6RiaQMGDap/W2SoXp+MsvFmBXMEmbzXi9ChsV/qoOFMSZ9F0SQf9tDqxHMG3Bs3hziLyhkw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2779.namprd12.prod.outlook.com (2603:10b6:5:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.38; Fri, 12 Mar
 2021 13:03:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 13:03:33 +0000
Date:   Fri, 12 Mar 2021 09:03:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-next 2/3] RDMA/mlx5: Create ODP EQ only when ODP MR
 is created
Message-ID: <20210312130331.GV2356281@nvidia.com>
References: <20210304124517.1100608-1-leon@kernel.org>
 <20210304124517.1100608-3-leon@kernel.org>
 <20210312000739.GA2773739@nvidia.com>
 <YEsL9z9DCw6EGYJ7@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEsL9z9DCw6EGYJ7@unreal>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:208:238::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR22CA0019.namprd22.prod.outlook.com (2603:10b6:208:238::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 13:03:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKhRz-00Btbt-P6; Fri, 12 Mar 2021 09:03:31 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f16f2d63-2d22-417f-edee-08d8e5573d84
X-MS-TrafficTypeDiagnostic: DM6PR12MB2779:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2779B5548008A7ADC67176AFC26F9@DM6PR12MB2779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8RBuCe+zb6mF6gZkxRg4hb4j35I2Rk/Uto+AprUIGf3t2My5ubr6+KLbSE/ef8YsopV8r/Uqb/j93M25JUSNoGX2zc3WLKZ1Vuvqc6JEZ27NIfKpK75mnsz1eR9OifKHpB261VF1jxxSuZDFbu8XPBpcKSJKw21luyElSNXQSVca5fHlZtmI68vWvCaICPrJbleTkVAg0JLqD6eFXrd6BPyH4QePq2kMxdlayNFEWGUd5Y9YmTM2k6urydNcNmbWbiAgPLvqGi96G9cBX7b8QwiHsB7Z8BGqdK9AVWAYWOpqF5VPtwYhsJRYkEeNBzhadLrt4Vi2MoqT6a9YO5cr+sJMkaJ1LmTiIT8jy00UwikB1QDyNRqAt3thCQJrS/r9U08HfbflPpYrosrU6M4pJ69IcmnIzVITMYDAELcqqmqdIqR99KXgQckSwfcvTmLeGNJMRzZ9wB0RrXqsbs1/0PYOLPzidR08As+3byvrIRkXq9cchN3n/KAEc4GaILE7PkPwM4GPrdyYg7gYIHlRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(4744005)(107886003)(5660300002)(36756003)(86362001)(2616005)(66556008)(9746002)(478600001)(66946007)(316002)(8936002)(54906003)(1076003)(83380400001)(426003)(6916009)(66476007)(26005)(8676002)(4326008)(186003)(33656002)(9786002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iJLE8rCmSxod/iK7Ydj94d8B4djtAFHD95bgdp0aXcPQONKYWLxuxHfHAlZU?=
 =?us-ascii?Q?TKjNR+3zkR21INEx+PLS0vE5rSWqWmsA/C9zypqY1Oex4FlnJfo1XkELgJ6a?=
 =?us-ascii?Q?mqBQN8XVvOx3++S1ykMTvMnVsW32uG0BeQ2h3dl/qcjd1yMUR0LENs+MCKIK?=
 =?us-ascii?Q?DXDMKF67/8cOxzPYrH+UdIbIpTn3Un/mVoifGdLxjcrd2RP2r36xsbTc9cLM?=
 =?us-ascii?Q?azaoSvop+lNA/By7oipJFYfzG7dHntH+xGGpYRdh0SFh8Brs/Z8xOWV5o0a8?=
 =?us-ascii?Q?lxvy5lPdAKmW7xS+umdY8Pu7M8Fh8jsFnm/UCVm1M0vGSQOwJdMhkZGkjmDf?=
 =?us-ascii?Q?vBlK3snw59+OFmKhLZyqSCASSmcbZ6voBQj7xNmgVrFLePPCpnzC2I1ZVFML?=
 =?us-ascii?Q?qxQa1/H1aRymcC2iEKy32HA2sChLzy1+gTXOzEEuRbKElvpm8uvaixS3t0+s?=
 =?us-ascii?Q?uhfLMaOvrgmatONRNiRGbsHW68mEF2NY8qRoHM6vjFz5Fe8iVLC7BcKmZADg?=
 =?us-ascii?Q?okiXoyBDxt/dkmGRB+NvTDndhv8338lpcHKLg5UZ4y15OzuofAdcR2/MjQdb?=
 =?us-ascii?Q?1yXbAYmOKKrMi1+t2C4RZffHZMrA8qLSgY+Wy9yNhWlkTqdVQKOilKJbM9We?=
 =?us-ascii?Q?9LODoiITnzLFG2ZVDVUNneEpheNN6eaOT2StsCrAwXZYUjD+UAuhWLQiqgNx?=
 =?us-ascii?Q?6gWiK/8LC7jUGfOrTYLKODiCKRQRZTsd1v9iiNQ1tz5BlNek7xm23j49LJ0b?=
 =?us-ascii?Q?Yiw5vsaEjg8WJUoZIwWYPSOmnjsY8SMboPKBG6/hZ1NV1R4eOmOMpypA3b7t?=
 =?us-ascii?Q?eqz3JSVqmjdnLQkHWOmbdZ5SpiamdcKPzDyh7mx8Uq13yyTs2MZwG9jyLjRh?=
 =?us-ascii?Q?uCe3Gt9EM3/FkJlW9/Uuyt1RT4S3SJUCNYEGCppPUPJBBMUIBz3SLbXcYify?=
 =?us-ascii?Q?zw5DQmmM09S6JBsDetLpCsuSK+UmCrTnIh0g0gJHFtE1Uokm9Q2/icD+pvIe?=
 =?us-ascii?Q?ArtqGC8bmMhtTqlDaN92vQKLEHVICTwNWI+cCVPVLiG8bCMJsunG1EAttKlf?=
 =?us-ascii?Q?oGiA1iIQetc2wzg7IPFG74cBR8Bvskc7X1x2PU9p414oUuGuMy5kLjs+Y4Ev?=
 =?us-ascii?Q?8iHEIHd4ZHme11+NmAbfBSbS4XwGX8LKvJlT/1NU/UwbYsGmJHZeuJeE6s6Z?=
 =?us-ascii?Q?Lh8FRBxWDxQcj89Q8uL7Pqzow47pu6PHCobCLMHrwmp3BKk6on94OeqTiqm9?=
 =?us-ascii?Q?tmR7ZWb9THlrTwgdrDu8a5tLMjw+0vJk4TwlZaKM5hJlyIs2tnG1iun33B5i?=
 =?us-ascii?Q?vGFH2JHJXZ7lKQfWGzzaSNOKSeEenYZ+YDKT0LfV++eM0g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16f2d63-2d22-417f-edee-08d8e5573d84
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 13:03:33.2371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/wJRaRTo3PE41g3LqmGWSGk4ASy08OjSTjaqQRwrIE3+ubPi1VcCso0klQlHA+Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2779
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 12, 2021 at 08:36:39AM +0200, Leon Romanovsky wrote:
> On Thu, Mar 11, 2021 at 08:07:39PM -0400, Jason Gunthorpe wrote:
> > On Thu, Mar 04, 2021 at 02:45:16PM +0200, Leon Romanovsky wrote:
> > > -static int
> > > -mlx5_ib_create_pf_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
> > > +int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
> > >  {
> > >  	struct mlx5_eq_param param = {};
> > > -	int err;
> > > +	int err = 0;
> > >
> > > +	if (eq->core)
> > > +		return 0;
> > > +
> > > +	mutex_lock(&dev->odp_eq_mutex);
> >
> > The above if is locked wrong.
> 
> It is not wrong, but this is optimization for the case that will be
> always.

It is wrong because there is no release/acquire on eq->core

Jason
