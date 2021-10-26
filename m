Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3105943B1E0
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Oct 2021 14:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhJZMIm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Oct 2021 08:08:42 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:23009
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235873AbhJZMIV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Oct 2021 08:08:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kALJc8+ziulU3YDunsa8GC43e9H0QmhEFCw8d7kACwUQCoqc33O1lnkmvpXuX2aSBAMSURJPExnI8TLCFU4PXcdEGa1tws8KSfWqB/V1UNJq1VAEifsSumdFhAZypplLyn2QQEGpnykKc5lB0udfo9ujktxcNw0qZsUF0YyaDcfbV+0y0Mmtjp00H1RJNRCKzcgkVHRymwHn546wtkhOuTeP/rsdkOJiEHHHNYw08dCUEyvZjkqbTcum1rgrektuA/Dq2G0jQn48RiEqJA00ag91Sb3AjgupzieGRcpcVqGdOKqo/6I9rHPoyAfL2yMC2rTteZnnmeo1ifEEJzmiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eel/BU5mnn7KJlIPEnETp8R4+91Xpf2gbLJ7r32ZNmg=;
 b=FWorfqGlCUmpWM74LORm7pzRtRdCoaB7mTS1P0ub2El7QgX+wcPOa/5wkrgl6WIt9qd31fHUa/1C0GNlMnc+EgWDhqPmv+fvpRq/JmoU2JaFXVcogZn+DV0Ra9kwH7l+ghHtI5VwjXMVP+w+SSKJ8hxAuVnu3aVHJxhswOuTs4msMb0x3D+l6M/5CcHJ+98G3fu+HnYcunSLOb63OazPRrDvjx7GJo9G6ulyvBdUzFyRfry6itJZQ+L0yZRIGm96hFI4IFD9S/PL6q8Hqmg/k3vIo7YRs455DKWNDwO5rynB5x85lgkWTUwfFtmrKx1qwcGlCcXjYlkrr3M01O1slw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eel/BU5mnn7KJlIPEnETp8R4+91Xpf2gbLJ7r32ZNmg=;
 b=nk2/KBWA6El0MvDKSuyPBW72mQWOldly0LTfBkjQfi2F8Ob8ibpzXjx1EPkXqaFtKO3yJEs5a6SGhRzlt5LiaLcecZ7ibpAF6Ze9yjdUSyVuy0hp9pjq56UMNMD9eT/ia51a5eCmZ1YkFbUS6yN3mUVVPdrl5pZ42OoO+4cTVL9wxxSZA9qBa3x9grUSJp/xKFszj6ApQnuM+6VuCxJWer+no6QBjWNPfvKV5q6ycvCtW8HZQUv6CYzHnR+e+5faeoRheCYDpPCvGplI+kSyL1mbp8Gi3l5uHRZLpHuDHZQ+KPhdpVIjGex1TfB0nL58fojUZdcGL7njo+7WNtpetw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Tue, 26 Oct
 2021 12:05:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.014; Tue, 26 Oct 2021
 12:05:56 +0000
Date:   Tue, 26 Oct 2021 09:05:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Fleck <john.fleck@intel.com>,
        Kaike Wan <kaike.wan@intel.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Mark Bloch <markb@mellanox.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-rc 2/2] RDMA/core: Initialize lock when allocate a
 rdma_hw_stats structure
Message-ID: <20211026120554.GO2744544@nvidia.com>
References: <cover.1635055496.git.leonro@nvidia.com>
 <89baeee29503df46dd28a6a5edbad9ec1a1d86f1.1635055496.git.leonro@nvidia.com>
 <20211025145043.GA357677@nvidia.com>
 <YXe8DaH6gSFvbEyu@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXe8DaH6gSFvbEyu@unreal>
X-ClientProxiedBy: YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend Transport; Tue, 26 Oct 2021 12:05:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mfLDG-0023z6-UG; Tue, 26 Oct 2021 09:05:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66b06916-a65c-4429-5eb9-08d99878f767
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52086310451735C19333A7D4C2849@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ibh1BEAIJCrQdUNmE+l82XtP2WVlcCS//EelsGJddUeD3jPkLDjK0SqYk1VEfqMfk/QMCZ5+1mLd2yu+ly53NS7OzvEG8hKLnBV2VyReVXiTJ8sjql+QfHtKXPiqFTtrKJm0xJP8Tw3HnWKovwcfnw5pgN69Iq+o1AzItEb2wuGPzym0nk4CcN9TVu53FN99rmd428T32GKFSWL/AEHFoni4RiHdd+Kfjx9bC/O/WN6mADzpbFlaZxkzDxUaQUxyhSdJ2xkpKy1BBBmlWpALxeRYko7HXE9Gvqw8sG712990gumN2pjsnMEX6bqugYTb88WVyLbCKDrnXcaXxDKx4xWRmudVRyB58NEExoHYNPn2KQfmYT+xq0FooXr9QlAphDj4dYp/pvciufKs6w90ZvZuPdE3XDuFc86WcOJBDZ+jyutqwgh/QPNCDF2ZPlstWK8RyvGN7C/Q2uFVwu8kZN38mr/YmzkkeN8qIddQZ4aedwAbbK7WyzljHG5x4oldsEJcvNZnjnT8b2oOF42kwUpeAboPiZUPjPTR/7n6Ela63DcWWqnZvHdaEAjAvzIG0CTv6v8DpbTxSG04hrIfy5d3pVJJVKVeeYWWBHaY4fxlcVGs52SaE4McFvnd0K4r9VfUEl3ARKL27Ol9LXxYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(107886003)(54906003)(9746002)(1076003)(508600001)(33656002)(36756003)(2616005)(83380400001)(426003)(86362001)(8676002)(66556008)(316002)(26005)(8936002)(4326008)(5660300002)(6916009)(38100700002)(66946007)(186003)(66476007)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eSShONvZTevqYaeXiGqKGd9xGbXDvHk0Sg+IQDUn2GfvK6o8wXIpy9h9kw8i?=
 =?us-ascii?Q?hNDz8yCZEu0EVFKNrOBmN6lzmXAb2wwiCxTIrZgtmdvhfRncw7hQmsc/fu+W?=
 =?us-ascii?Q?WobdsjF3UrrvfpPw3LgXMGTW+XSVABBykmhxn2gOAxQf/o/nTIQzEWkWnvTA?=
 =?us-ascii?Q?2nJ6l/QvIP0GONNwNNGCngkbHsInMmxTY+8NECBm6VuKbWjL/ELutjxe2W+T?=
 =?us-ascii?Q?iu4OWcvkAtKDuUTHwWoXh966hx5c51DiYOV/OR+I5X4QDPglv1PX64MgvhfA?=
 =?us-ascii?Q?sKUeqA62E7FfK5dv6IiWku+KgB44+ZNf0FXNqFDmWiuYH53YrhyoknoQNoYQ?=
 =?us-ascii?Q?KB48FYDSexAoXJY9a2CcfqUJSLCuZFaPeUAEivVpF2LhToMfVlh1sURStOcn?=
 =?us-ascii?Q?CPSwcDfaaoaw9gHFrFtfGQxHciuw1Tcx0HZ2NXqD/EDyPm1ShoDRXVAPEds6?=
 =?us-ascii?Q?eS3BY2fpoxbHchntAabd6m1ohCo3kBMZRQEuzit4gvU0mEtQAOuF0ormwusR?=
 =?us-ascii?Q?NYFEiKdvkYSRasN6NDJvxIPswx/Xz5v+XVzO6BEhdZRZ8bkPLlSdNoHNZ6av?=
 =?us-ascii?Q?dwk/hG7mYfIaaC5pfZo7ggmTcaTTVOMD8AKlKmg3bDSCBg+8W8ZMZxQqpYJC?=
 =?us-ascii?Q?HU9nYxM6MO4p2U+sLI1rpVz/zYyYFp8nN4BJfa3tosbWYctsw4fmPimeTK9o?=
 =?us-ascii?Q?iv+Gq0UUqTDiMbjlkmLn2MmOo7Jdcw+XHezT+1Q0NonE3nSVPCgQHaOFRcVK?=
 =?us-ascii?Q?D3Z3BDCHCImfNJeOxJ49YoGwhMe/ItXHXuM9V7bozdIa6o46b6llttujAMcZ?=
 =?us-ascii?Q?TzhlLTa1052oeKYgRKrEptv/uekJTfdPvTETWI4VjI8dmUYEkUlatGrL01QY?=
 =?us-ascii?Q?ohFV2z+JfBlq7mM2kpuaaVamYeRE7ywJmN95pVi7xXCnlNm3sAfnTnEUSt1x?=
 =?us-ascii?Q?D0AOQVj5ZSpUFWhlir07P+u5BkVktnQVw49c48REeu3YXjrEa41hE/Y0pXWb?=
 =?us-ascii?Q?rfGECdBzFfjzM/gMCxBsmx9MIHEzGbTaXja+iws99p+o4Ng7W8N9qUie+QSc?=
 =?us-ascii?Q?j0x3mD39/90m9/Vw698OeCR4xRqwcb/cUKvaapGU6gewDc8thx8b0y09D20T?=
 =?us-ascii?Q?QyV3ySUnA8CKgSshaYNikDbYnyJ2BZV/BM9mm3xLKlaofIeomYhX0mGk/rwR?=
 =?us-ascii?Q?R9zlS1/hvk8lmNIpjMQNFtPBA21hW1l1O91Wq9oqUIwcMk33rVpJk1Pg7tz2?=
 =?us-ascii?Q?+4KdKtmfNHoAR+NWmmeUYyyHwNc7YVWhu09EKvDclVDSJP5uBmyC2nv61KX3?=
 =?us-ascii?Q?xwJtkRjmHmj8XcTytn3lVoDWJVmhYDOMVI3ci3+93eJgEaThI6BXRmDR2lRt?=
 =?us-ascii?Q?u38Yr2aXu9fMVr7yZ4sX1aLazH4EHWVzgiQ6Hk9JQZn2LqdbJrEkjhEQZb9W?=
 =?us-ascii?Q?7o+mXi+V31Z36j18KAo4p4++ys10A0Oc3PwMbCcyq9sa/seYaBSiJJWhSKlC?=
 =?us-ascii?Q?kwwWBSh5lCmofBSclMY/8QC1UtA8KtyREp3t0GYIfg38ejSFeQjTOtLr3u6m?=
 =?us-ascii?Q?Hx7YOD9yNJ0PxpuG4Tc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b06916-a65c-4429-5eb9-08d99878f767
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 12:05:56.5931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1qQwoP9jvRtohY9Ka+ZeYXI5E+1P0tG8+Nm5/OEDpmh0mixErj+EiuL5bbAy7zb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 26, 2021 at 11:27:57AM +0300, Leon Romanovsky wrote:
> On Mon, Oct 25, 2021 at 11:50:43AM -0300, Jason Gunthorpe wrote:
> > On Sun, Oct 24, 2021 at 09:08:21AM +0300, Leon Romanovsky wrote:
> > > From: Mark Zhang <markzhang@nvidia.com>
> > > 
> > > Initialize the rdma_hw_stats "lock" field when do allocation, to fix the
> > > warning below. Then we don't need to initialize it in sysfs, remove it.
> > 
> > This is a fine cleanup, but this does not describe the bug properly,
> > or have the right fixes line..
> 
> I think that this Fixes line should be instead.
> Fixes: 0a0800ce2a6a ("RDMA/core: Add a helper API rdma_free_hw_stats_struct")

No, I don't think so, it should be the commit that added
alloc_and_bind()

> > The issue is here:
> > 
> > static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u32 port,
> > 					   struct ib_qp *qp,
> > 					   enum rdma_nl_counter_mode mode)
> > {
> > 	counter->stats = dev->ops.counter_alloc_stats(counter);
> > 	if (!counter->stats)
> > 		goto err_stats;
> > 
> > Which does not init counter->stat's mutex.
> 
> This is exactly what Mark is doing here.
> 
> alloc_and_bind()
>  -> dev->ops.counter_alloc_stats
>   -> mlx5_ib_counter_alloc_stats
>    -> do_alloc_stats()
>     -> rdma_alloc_hw_stats_struct()
>      -> mutex_init(&stats->lock); <- Mark's change.

Yes, I know, the patch is fine, the commit message just needs to be
accurate
 
> > And trim the oops reports, don't include the usless ? fns, timestamps
> > or other junk.
> 
> I don't like when people "beatify" kernel reports, many times whey are
> removing too much information.

There is too much junk in the raw oops messages

Jason
