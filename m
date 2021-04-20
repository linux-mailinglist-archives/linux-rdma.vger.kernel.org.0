Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCCA365C25
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 17:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhDTP0R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 11:26:17 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59]:5708
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232902AbhDTP0P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 11:26:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk5A9VXPNFyB3IZdZypCG9l8Z0fiTOmc9xkmI3n5SrFU0AWtJpg3MxmClSj3BpNAD79JtE9CAVOaR8ZMTkXMTlv9qQIlKRlmW9sX+Tr2BqZYKjekGJeMElif7oNf1/sadxLsXKH9+1h0vTLR/DVvi3nA7+r+kO++A5BVk8VR53a5jFpxVvvB3bi/xmxYiBP/aHk7tcSU29KXSMUPX6EwZjOeF0jBMzS7esbTiFyZNpJ9BVt57LYa0QgikxeNO71zO4Icosib5z2gAngpAorH2k6YDjJn8/fe/MH0aI0vfbYe2QsIZWWT6a4Iaj8aKgD5/zex/YwhwxZBnkW/3yY9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VuZ8rvfyAOQ7PEiZ2gQCNGjakBkjhF5Xi71XGCy6NM=;
 b=lStsaoeHfcMW39Q5LFNFhmApAMpQBJ9RoA8G/y8ugWc0xUDyofkuZ0BNc5HE7K6KKcLAqJ9Of8M4fWdRXXJqdTcsqVl5ZL3AoA7bOxbaFAbuXJ7ek4CzWTqPbgCJ0A9qVeKIxhyeHHa4cLpLN/KfIFNWJgUuxHmNicSDc26BdxhRKOwFct+hDrzghHlY5GCpnKADQHhXMMPXk7SMDmPgcbbPFCVqDYm2UmnZN60ue2zuT/ra7LRih8i9244WvgGign5lI/ZsxsSgKbLnKfiFOzJqLT6G2HVBqUs1SAYa7N+2jW2x10XJbzndJXp0xbU9K50jmS9IS4Br3+0A0qCnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VuZ8rvfyAOQ7PEiZ2gQCNGjakBkjhF5Xi71XGCy6NM=;
 b=uKMorHjEEC+dzYb++waaEQCvCMzoi6H/d2NbV1bd0cIBDXSbAFtmFKuInFMVV6XSavB2ld55LvTiH6EFqgho0aN5UANleduQ3WUaIEYWCJ+oMxXid/vJ34NJGNQueuOTw4X7IWBEH+UrCNbn4LZTfKsvWiK8RuUea8dtuCHNjpkqTETczf3xdS6WQ3mHUN/oKpPPwVgaG469gSvSO7yWobKCmFk241hspkVn/tg4FfB/krwpwhyhG/3gesH/AP5mySIM308XQpm70MA4KzpL8+KRy/wdmkBnSXLqyxyZi7BwsOikNXIrQ1p5zIlVpaIVmgObJM0hiaEaUxGDNgmJYw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Tue, 20 Apr
 2021 15:25:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 15:25:42 +0000
Date:   Tue, 20 Apr 2021 12:25:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <20210420152541.GC1370958@nvidia.com>
References: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
 <20210420123950.GA2138447@nvidia.com>
 <YH7Ru5ZSr1kWGZoa@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH7Ru5ZSr1kWGZoa@unreal>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0100.namprd02.prod.outlook.com
 (2603:10b6:208:51::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0100.namprd02.prod.outlook.com (2603:10b6:208:51::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 15:25:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lYsFx-0095Iw-51; Tue, 20 Apr 2021 12:25:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb3dd3d9-8fee-4391-9c73-08d904108f89
X-MS-TrafficTypeDiagnostic: DM6PR12MB3835:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3835B213B349938A49772036C2489@DM6PR12MB3835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKJw8ae+IIa5fFfVbGlR6ZMio+8BH9Iyi64UmOdv3HLZLnDikVZplpW+lKLMuAyu82ib2UeAkzqOODJTCpBxcuL/HuGh+VTKCphTqucR0oxNj2/T4SqJsGr5AtWtLRAZk+7h6hHLYmUrxuXuNG3+RaCbs04XwxaUS4TGjKQksrK/BctW2ZgMuJ3muyyZvtpJG3sRFujgE5DJXUin0W5JYQssz9WNbKsXl0B/9P1+TbALAD2iuYR9LZreqkDDLPm9a1JYjwtayyP5uoaxG/qzyChL1wUZESkWXYEP+83fgtsE8YjQeL2/CAnwhblX9Os5Iowt5xqBIWWnbU121+tzfHv+Y/Z4Mmug2KTG8lZR2Elk6C2TDy+tYLrEunYz9b1L9us1MHE6yXFS420QIovOMzLF0K5l2L4eo5CN/YJ4y7HhVIehrRdwwm+K6vRbgQvOqpkgkQ+DJgyerT0Vdnv/ci6TZNj+8ciAjV6bImxoRdERk8HICxQkMrk3Kg0a4wau/EEmB/gFS5u++t7PpqAOadY3AENvSb4sowl9DGKQrRRyNBzPhKy5LimNx26an+YtgAg9T0z+9eVMVK8Mmz8E/+GfNPR4dOAo3NbzGEW64Iw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(83380400001)(1076003)(66946007)(2906002)(8936002)(2616005)(8676002)(26005)(4326008)(33656002)(186003)(36756003)(9786002)(5660300002)(66556008)(498600001)(66476007)(54906003)(426003)(9746002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vsKTh+6FldqPAv9bfEw9f2zWQzeKNMVfJl7vEC6lwXj3VEETzj8tdfmaS/2O?=
 =?us-ascii?Q?hWibYElK5YjsDq/7+TPAjWEgVFym3ORPjIgxYYYrVsT0P0AeM+FjVkNZLKkh?=
 =?us-ascii?Q?kDyur3WQ3VZQowejlBKt8qh9WuO/RQtREiFgHhvDOK9EVFdKm/4dzHv26+L6?=
 =?us-ascii?Q?E1TARnSJ/qOax/fDiFcy2mlPTh100mgpEmSOWIIHOYU/MZnzv5bQzRNV3N3o?=
 =?us-ascii?Q?hix0yxRbZan3HQT5Ht4HF8YJfsB98Mgzgf4o4L+iSsX6KRQNpmeeaUpb33KB?=
 =?us-ascii?Q?ViyuXpzNhDxHMQK4kpF45ZZYnZijWtNcZNlrTiBpSU1XRWbvCW6CUC130rWb?=
 =?us-ascii?Q?n2FtM7Kcknxr1Ll7ALH6rFj8w9kjEE5K3tw7ioo3hUwWzRidZDPU8Z0Sr634?=
 =?us-ascii?Q?681o+qadu5sQMPYRh4UIapDsgtknQeeljclyIUWXzS4srPgm0xy1OE277GVD?=
 =?us-ascii?Q?U1p3ROSjBX6QClwJRSA6Vdkh0W01BXpuwRGCuP7SjYuycc8WtvcSgZzB1ql9?=
 =?us-ascii?Q?5Fuxq1cEwV+idtXWFJqhNkA0OALNOoF9J85Dkaf9/JMJR4oQO0bIjPXos2cT?=
 =?us-ascii?Q?7bAYcgv5cFDn+RjRocBfMRpK0VbL9Lj54NfvXpASaRoxYL+r1IAVcdrnethi?=
 =?us-ascii?Q?+H6QIf+/fEGtZdwkWd1FQeJGxGEKdvCuUZx6hJPYqGmynyB1LSr1G5zdTLep?=
 =?us-ascii?Q?wPZLM7aZ14PtKS1957kpYZIs3MmmNqSrQXatK3CWGDwY74HGaYYK7KOTHeh0?=
 =?us-ascii?Q?N6rD9tQTVyYuFNMRdiSI8G9g8iheiY0khsiwrMRrsnmN5bO8KNio6wZ8Chsu?=
 =?us-ascii?Q?SzvHTrB7Zs4PKBBRmWDt61/aEOjq5/aVqUxYWIkt3KcRJm6mqHGO2e90iNTL?=
 =?us-ascii?Q?lc0c1h724k+zcq9UrjHYJWQmUwiNdP9JACpqhN8b71o0FxIorkWjGxcCLN50?=
 =?us-ascii?Q?756ZK3voM1UkyBm5i9MkvXB8bRsyQSxj8QyHyPr2j1PVsXHlI8RVMdcaCP5u?=
 =?us-ascii?Q?g4jxmf+cAjRD92h/hEAq6JjTgoKYoVIwZJ7pZjYZfSRHk2UhQ/ce734Mqoo6?=
 =?us-ascii?Q?P26vF8/DqDjecxQV/1n9VenSpIHqplXMlpKIuL/tJoujWG2FyeG+UyTwGhs9?=
 =?us-ascii?Q?AT71WiF04Ji5NjqF49cDJK1ee1Jdrth0NPmvE+Zt733Fdo4g5/+Z4yP5nMka?=
 =?us-ascii?Q?Y6voDtyx0MfBGgD8NKmZAwx7DCyvnuoWOEdDgFQHXjqrn/tBWZqkDNEnzgBM?=
 =?us-ascii?Q?2UAcB4NMdb5+fMFP9AnyBp57uZfSpW+qiJN1grFP+NYfzjTU8od+OezC/flR?=
 =?us-ascii?Q?IyU4FvrFOoOF3tWUzXK5AvpmBMf47iwlBAvqD87kMdG06A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3dd3d9-8fee-4391-9c73-08d904108f89
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 15:25:42.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCfo4uN+0RAvkR7+ag/r1fCWcGdfxgcTV6pq1PMz1gJsr0SMwGhKi+9KesrTQ2jD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3835
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 20, 2021 at 04:06:03PM +0300, Leon Romanovsky wrote:
> On Tue, Apr 20, 2021 at 09:39:50AM -0300, Jason Gunthorpe wrote:
> > On Sun, Apr 18, 2021 at 04:37:35PM +0300, Leon Romanovsky wrote:
> > > From: Shay Drory <shayd@nvidia.com>
> > > 
> > > Currently, in case of QP, the following use-after-free is possible:
> > > 
> > > 	cpu0				cpu1
> > >  res_get_common_dumpit()
> > >  rdma_restrack_get()
> > >  fill_res_qp_entry()
> > > 				ib_destroy_qp_user()
> > > 				 rdma_restrack_del()
> > > 				 qp->device->ops.destroy_qp()
> > >   ib_query_qp()
> > >   qp->device->ops.query_qp()
> > > 
> > > This is because rdma_restrack_del(), in case of QP, isn't waiting until
> > > all users are gone.
> > > 
> > > Fix it by making rdma_restrack_del() wait until all users are gone for
> > > QPs as well.
> > > 
> > > Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
> > > Signed-off-by: Shay Drory <shayd@nvidia.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > >  drivers/infiniband/core/restrack.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > > index ffabaf327242..def0c5b0efe9 100644
> > > +++ b/drivers/infiniband/core/restrack.c
> > > @@ -340,7 +340,7 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
> > >  	rt = &dev->res[res->type];
> > >  
> > >  	old = xa_erase(&rt->xa, res->id);
> > > -	if (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP)
> > > +	if (res->type == RDMA_RESTRACK_MR)
> > >  		return;
> > 
> > Why is MR skipping this?
> 
> I don't remember the justification for RDMA_RESTRACK_MR || RDMA_RESTRACK_QP check.
> My guess that it is related to the allocation flow (both are not converted) and
> have internal objects to the drivers.

Well, I don't understand why QP has a bug but MR would not have the
same one??

Jason
