Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E8B3432AB
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 14:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhCUNDd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 09:03:33 -0400
Received: from mail-eopbgr760081.outbound.protection.outlook.com ([40.107.76.81]:15663
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229815AbhCUNDS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Mar 2021 09:03:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9ufWrMJVQg9gPbGGvx5D2fk6vZnKKfd7coPCOaMZf7xOedJ6mmSE9jp2gVNiwexCHx8JTKIb6baxGnLTBzwJhuU6K//6XplwXiSCJcRHJnDmyoNykdFxBQxBeJroM5J9ktlHb6Oz4sld6BJcJHd+k2DJPAW59TQV1FHgw6bs2q/vkxqZBU+7K8lHQqsdiZhOM2YpEp6CSCl4i0Uj4HrsJG8CfaQKajo9GeCOP5bvovNkVxGmDhONWuhau+UFzPb3Nv+FBnVCGm4+9wnuZlt291060N0Y+1m49EN3K6lyxcfbsAN3XMAB8+tLIgcvm6umIKjHlpNPnmMEgJktrqCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dkmo7YOjf6z2amr9Qze+YehmAyddy1otoftEXuBWHUU=;
 b=ct/Nmgu976vi9IloLo/zGsY6k6AVdkclzak+XSfca1ilzAffG9qcds8REfczaYhdq8PJ0iu4j+daJy4Ozt8Ta3KV+qJksJNpISEDbeIovMPMzaEGWQbVeBOWSaqGwxahNv8Ix+65NRYB8fs26uzZesza0dvRsoZXXx2fD3HKzXffYqIkWlmlcOQ6PRujHwgLqpkj74Fxc3dTjdsQRnl7gvdFYeP7tZxITKYVrYXgWZQnJwqRkluvlkWKyMD+Mj3JLLze/1A92Y11ocnwN2iH9umcSj8ZgmmLaBpWsKmrVzZrGPM8RwyiarigVpza+S52AeG/I6JdxAEdRcyLyb1WBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dkmo7YOjf6z2amr9Qze+YehmAyddy1otoftEXuBWHUU=;
 b=iZSwGrF7sxFeP2k37xoGMAvbOi0/7U7V34Q+OaIZL1FyW5rHCek7As5TicxyD3GDUwEAgAzq0hJcM1zfW+YWegdY83OIJ8djHF+81xKu+GuS/GySSWvB6dIvpAFf3aaOQrsAYBDoWsxfO85R/8gvxtqKj49w2jc1ZaqROa9d7Mp6EMD/ag1QZS+enhlgHuiOXrKWw6Nqgjygm+RclPMNFWYasYC7yGSKUPLL0j7urx6NDrs5DLXK9l9xxU8LQCX12vO6vp/2jFcMLuSVhAcdOlvesW7prLfe4eB3EjOUsMKCltMTUwMSW3C91hOPZg6iF+tzF+yR+yfAb5QWYk7d8g==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sun, 21 Mar
 2021 13:03:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Sun, 21 Mar 2021
 13:03:16 +0000
Date:   Sun, 21 Mar 2021 10:03:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <20210321130315.GN2356281@nvidia.com>
References: <20210312140104.GX2356281@nvidia.com>
 <CAD=hENcNLNvX1isjUYutfsDrXzjpJZWBMaB4EkeBMTz7F4x=pw@mail.gmail.com>
 <20210319130059.GQ2356281@nvidia.com>
 <CAD=hENfH6CZ5AFZ4jVTguA75eLFk0w1JVMzu0od_XGQPfxHTtw@mail.gmail.com>
 <20210319134845.GR2356281@nvidia.com>
 <CAD=hENcN8dfD9ZGQ-2in2dUeJ9Wzd2+WFWFbhUgovxwCrETL1A@mail.gmail.com>
 <20210320203832.GJ2356281@nvidia.com>
 <CAD=hENf2mcmCk+22dt8H_O1FRFUQzcLqiknEzoOma=_VR0fz+g@mail.gmail.com>
 <20210321120725.GK2356281@nvidia.com>
 <CAD=hENeP0LNGgZdQ6sc+xVN9OAh2C3RQJFVRcmxKJfKdFoOvPQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENeP0LNGgZdQ6sc+xVN9OAh2C3RQJFVRcmxKJfKdFoOvPQ@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:208:e8::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0003.namprd20.prod.outlook.com (2603:10b6:208:e8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sun, 21 Mar 2021 13:03:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNxjf-000XTW-6G; Sun, 21 Mar 2021 10:03:15 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c2a08a6-d7c9-4b76-0b32-08d8ec69b147
X-MS-TrafficTypeDiagnostic: DM6PR12MB4500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB450006DB603F372C1FE9CD2BC2669@DM6PR12MB4500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqt8n2uFvce6UWeTLzBhl+wxNIwvGi4+GBcd2VGbfXnmShqUdDMCuBpr+YLJVVlx5eBUXb65JBs2Y8vMaKEF7k6Bmdb/pD2iKiOFn2IM9Y6LCQAbOMFnBX8Mf2Et/temHb6ao0d/ozWJKCqzi8MZFsN/jyD65fkN0Pm2ptzPXlqzbaxkGd1yyrl0F0zqu8WW4yzMic//5PCZ+x/mx62+01NuS3eDe0DDsO6DQYdcTrzylmUBLzwOQB8DzECIr22guk4mz4ozgJR8yO0keZsH3I8seN+ryBT3bubzrPJsERA91iBYMjmohEPv+EQfTZlNdZelCFhXSxz3Y8KGCGWjsRJSxCGDrAl1e7g3ffD/4P642Du5Ey+wUJD19GRmlN9w5xTMDuqVJSlZ0IkEXmyv+bFqTrBPUSDhPnBgbtVZQ9TGyGVFizCa9cD5qs1Bpy3Ru03C6OOovU80Pc73rciU6nCifaEaQAnKGoJJ3YsYNtppq9lk2ZPsKalKwPmGRe/upPnIMKXLdFlAHWTpX93hfLSm7v23LK18xK/2in2BYQqjOpM2uVqWq/SC/mWN9DOfzcC6aqyM9Z0rOj/03SJj1r+A7/pEXRK7+sx9Ynu3+LY0UsYyvaLBG599lhNVroScy5YmXI/9vbu0g8UhOgCbreaW2A02OSGN6e224rXVdZgNBjbR5qc0FKk6jVKq88uvOus+b7GGJOz8xokjimkXdmcvKVIt9/utVtsbtjkN3093SogdJc1/qWuiPGCh7JeY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(38100700001)(8676002)(2616005)(1076003)(426003)(478600001)(66946007)(54906003)(5660300002)(33656002)(66556008)(86362001)(8936002)(66476007)(53546011)(6916009)(107886003)(966005)(186003)(9786002)(316002)(9746002)(26005)(83380400001)(4326008)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/uE47ilLMhiwr4lYO2yDIZUsTzIMXv3IP/JkFOleM9cpdohgwV1GBWG60LVS?=
 =?us-ascii?Q?8Dl3dkEjfl/3m8l5+RIDjpUTGW7dac87nEQQlXsedhQVklTT16J9Bn3pDZxj?=
 =?us-ascii?Q?P1wqGvKBcwp6ygbiiErGIZwhh0xjHieRj+6Ec40Oy9qN14YB8bIbZ0VaUIp7?=
 =?us-ascii?Q?5mrys9281TDbU6SvK1me3TNycDizbAk4CHAVgRNn/pKHItRBtONvTDohwqsq?=
 =?us-ascii?Q?kWVWuMEgq+q4ygSohT8+QCew/1qEaydavSpct1vM+1guzAF7oVEuOPzJnRyk?=
 =?us-ascii?Q?aicYtQEDexfhkcDHKyO9JPTVSihSM7mZWwxb3NrVZIPx6NxP0KinzB06EtoJ?=
 =?us-ascii?Q?/rsAApKv9p5gQceIf3+eFo3rjvxLZor3RX3GSWWDJSNa8OKtF4AMSFTUfwrC?=
 =?us-ascii?Q?Ok1Mb1K3FbOQ9NodlY8Msh12MtFnNv+FraVMcI+0RigL+y0d5onA7DgmC+xp?=
 =?us-ascii?Q?/T0emD/a1Osj6zgYmgZzFldg3KSO6p7VPQD4iWyrsH4W9s5gDN3QBkVtIQkn?=
 =?us-ascii?Q?3L07CqPKb4IPHGzJdHqk+vOGBkQStGmg53keDBDmLHBmP3vQ/S/I4zYeU2Ki?=
 =?us-ascii?Q?vxxwU++Hml+iSMNYlUMZxtk5g7Bst1znfe60SKsq8LYNQA7ZuwgGWHCmCXrE?=
 =?us-ascii?Q?pM9O5Q+ZCv3pxyQFCDDHbgOnGQZny89fo/nOmhx7cKXLtitxKVkwZhFkf/86?=
 =?us-ascii?Q?dYWEVfbYopF6mNllUq0SACE210ypAiVX5gHJryrFaCnPyoVMNiGDeS1Uk/5X?=
 =?us-ascii?Q?D0dRYGsy7zIXiJNMiDSW3tB+LHKqHfkmE2O4dTj/B3Q+mFRSFMzQ2xgU2+xy?=
 =?us-ascii?Q?3hixShOfuj5A7n0OX1SdBOhbO+IbPIuuGvgwl8AgnSudgqRY5+MGW42rUtx0?=
 =?us-ascii?Q?vFdmoOonbQ711n4bSqxgZGVwCJwic+2y9zlTnKc9joyeLub0ci8C3KXSabwt?=
 =?us-ascii?Q?jKe/nRXc8zZhE0okuSDt/UwumALI63TLMYYzfLUWT0FH/nRefgFlMmT/PWfn?=
 =?us-ascii?Q?nPAHSO6nQ5719YHP2a1wnHj+h9X4P5yQbMUC17lwWUL+HQ3c9qy7H29dKCLw?=
 =?us-ascii?Q?sSWg0Bg9Qfbld38KdhLSpAX7wtSD2gBgLL6AObCYd3VP5pDDEoox4rCxgm95?=
 =?us-ascii?Q?jfAC+X5c/KScXKCG2OIXvHTtuEYRnv9cADo8Zi1rjI4STqaZwJFJa/MfETI5?=
 =?us-ascii?Q?L3+DnwYrgwLELcwCe6hFPvNUwYLaMse5uWB7BTWIgy+TYHyMdil66c9vgR22?=
 =?us-ascii?Q?3gUT3z2oVXZtUhjZmsyvYd1pEJRe/rs4pEHLmSTmfFvY6qVQ6DRZE7XABIcH?=
 =?us-ascii?Q?jqLyW4hD3MZaiHBGb3pd2j1O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2a08a6-d7c9-4b76-0b32-08d8ec69b147
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 13:03:16.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZdmIVGWXUFVZGODx/Gnht07OL2+R/PUQ5nVevwRCfi9VC+3GvhvMEO/nodaIzQk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 21, 2021 at 08:54:31PM +0800, Zhu Yanjun wrote:
> On Sun, Mar 21, 2021 at 8:07 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Sun, Mar 21, 2021 at 04:06:07PM +0800, Zhu Yanjun wrote:
> > > > > > You are reporting 4k pages, if max_segment is larger than 4k there is
> > > > > > no such thing as "too big"
> > > > > >
> > > > > > I assume it is "too small" because of some maths overflow.
> > > > >
> > > > >  459                 while (n_pages && page_to_pfn(pages[0]) == paddr) {
> > > > >  460                         if (prv->length + PAGE_SIZE >
> > > > > max_segment)  <--it max_segment is big, n_pages is zero.
> > > >
> > > > What does n_pages have to do with max_segment?
> > >
> > > With the following snippet
> > > "
> > >         struct ib_umem *region;
> > >         region = ib_umem_get(pd->device, start, len, access);
> > >
> > >         page_size = ib_umem_find_best_pgsz(region,
> > >                                            SZ_4K | SZ_2M | SZ_1G,
> > >                                            virt);
> > > "
> >
> > Can you please stop posting random bits of code that do nothing to
> > answer the question?
> >
> > > IMHO, you can reproduce this problem in your local host.
> >
> > Uh, no, you need to communicate effectively or stop posting please.
> 
> can you read the following link again
> 
> https://patchwork.kernel.org/project/linux-rdma/patch/CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com/#24031643
> 
> In this link, I explained it in details.

No, this is all nonsense

> Since the max_segment is very big, so normally the prv->length +
> PAGE_SIZE is less than max_segment, it will loop over and over again,
> until n_pages is zero,

And each iteration increases

			prv->length += PAGE_SIZE;
			n_pages--;

Where prv is the last sgl entry, so decreasing n_pages cannot also
yield a 4k sgl entry like you are reporting.

You get 4k sgl entries if max_segment is *too small* not too big!

Jason
