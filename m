Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE28136A766
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Apr 2021 15:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhDYNJk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 09:09:40 -0400
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com ([40.107.244.62]:24000
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229659AbhDYNJj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 25 Apr 2021 09:09:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aysOeYrpE/uTIA63DKlc+ahr0HbgMOrs0mtSXdeJsngjG3xU7HLspOtw3jWSQZ9dJ0dBk1h1SabhcM1xZJoj8oTWmYhRKtenfll/tYxPuJlU0j8d42aj8X+0BpE3WBqwMTupD/X/04HbzmLvOIWbJqP3G+bk21kaTH+TXNSr/J+yhxZhD/anq9YKwDR1bwfDFOmdUIkruu+p3DTDTx1ePiYgMYTIHlgIxbs1NwOfXVSRRKWnj6WUiJJiDOHr9Y3iVG+W9C3FDwReYwsfh5PDHVmA+Z1tQfIMH5zqF/Uv1ZHpBewiX2pjAAiG0/j+hjewoccCtkkSnVelNBbi5sT/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0GWzdJLekzLEHxeoCIJkGuaaLGiebRDL3q28zbAHTw=;
 b=P16tw5/YTmD9TkfajUDV3x/od9ZuZlfgf+QbRPl8LD4d1TbYk8vm0ZAxln2yaw/EhAxmBylGH9avohwdIKWI49axWjjvc8muEITnXAnmKl37X3NKOgldnAij0WC3CebfIzbFzwomg8m9Db0vgm7WHkkaUchsTGP6bbzMM9wpBA9MWwFsvbW8EiPoPdQUF01SiH0UtpYeJ5xIcGW2bZsLzi4L1GhlKsEZUQs6aIi0F3UC46uJp/pnIfC0iXv0dZs26XDi4aFiKh7w9LVGGqVWJ6zPZux8v1OTPvVR3IRtL5eXRxnoArpYaFxbH8jFAFXZrGC6MYUATFa7AOAAyMGsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0GWzdJLekzLEHxeoCIJkGuaaLGiebRDL3q28zbAHTw=;
 b=i9R5JZxtPGCzY8V6EIT7QKNWxCTEAF/1nkw7hzKGwgSAYGEKg3HYTI1syjvGnRrLeMAQsg/DgJCp5jCkjSNdpilwUV9wTQW6qqJv7oNn9cznWXJuf0KSODKR8k8gWDgXKmaw6HxScNL2bxgOjZEQ7HxVMKRIUX/tcoVFEme+XH/RlnrKW4kKlZLmrs91VmNimaHoByKcMXlhUVHjc/rXigBx8vHCK6Fgx2A4TX/Gc4XYqYgtgcOyPortpIpcv0oyDgdyMnFJ/sRz6R823m9BeCvyxlCVycV3A72tw8WUomTie2TwEwAgz39OFPG98In3gt92LmYp3F+sZl7k4ZOqxw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Sun, 25 Apr
 2021 13:08:59 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.025; Sun, 25 Apr 2021
 13:08:59 +0000
Date:   Sun, 25 Apr 2021 10:08:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <20210425130857.GN1370958@nvidia.com>
References: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
 <20210420123950.GA2138447@nvidia.com>
 <YH7Ru5ZSr1kWGZoa@unreal>
 <20210420152541.GC1370958@nvidia.com>
 <YH+yGj3cLuA5ga8s@unreal>
 <20210422142939.GA2407382@nvidia.com>
 <YIVosxurbZGlmCOw@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIVosxurbZGlmCOw@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:208:91::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:91::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Sun, 25 Apr 2021 13:08:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1laeVN-00CjaA-1p; Sun, 25 Apr 2021 10:08:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cb01876-8a10-4273-676b-08d907eb49cc
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0204:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB020427EDAD274A8AC50026C9C2439@DM5PR1201MB0204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AugWYfVEbGrzHXVtsS6ajLXQjEgFko/mPzMPEMaxFWhXXQIXkpf85Jur4wtgQuQe1ccW9EGg8coZI2qEU9qtEj3um2Cgt++hmy3I61CgLHc0YtpQpC6ADobHNZN2AL+9YBR1AnA3FBWl2AlbOdR4B17eCeG4piLf9Eu/0U2KOdHbytFCCeu13NQyTP4eJtRosriPP7t1InQNZuY/a/8z4JYgLEJ2+9V4Rwaxbo5sPjzvxYvqyemYS9bjRqfIcsE6lZhzSxw6na0vT+jiZ1vsLf1Yl9dAOpwzomwcM2ubjJ+MOYPKK4Z36LzXyi0Kzcxab7PxhgcPGzk3iEAafdLRZtdwJJlyfTSjvu/WHm6fGmqykWvZ/vaPYubErb6QJR8N1snHdbjVCJVq438WUGxmC98hZjxKC+QyOR0Pd4Aoq7vb3EX2JoqwRQOOvZwX5YGyFy/2KZDKzHcBDROO4s3w+BMUXAAMpG8NuUqvr9eJ/9vN7OW8PUHA5+p0BRC5f2tf9ht7b/WxMl8+A5D1xoZ0Jso5k/GGPACpJx00kDTfihOSzUkSqnMjiiVEowzgMw+meUdWL5nIHcYRPV0ceY+PuSqgNjxkdr/CsQsd5Moy7/QCodC7MYadfAl7Fu93bdm/jOV+7kifyb5ErFeaHiYNlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(38100700002)(4326008)(2616005)(26005)(478600001)(426003)(54906003)(8676002)(316002)(86362001)(9746002)(9786002)(36756003)(6916009)(186003)(33656002)(66556008)(66946007)(8936002)(66476007)(1076003)(83380400001)(2906002)(5660300002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ae/RnhGhUgMmPFsAxQTe8EFPGYPhbMYAylaQ204C6XFq7ee6LPXpQfbSYQWk?=
 =?us-ascii?Q?22a1IN4EYmWYPNJegPRAU4QS7iBGZqS/imhGNdfanltaipvZtgNZNwFh8W/q?=
 =?us-ascii?Q?1nAHZaH+X2JpM6pWsuIuBNpGZ87C+UKeWaRFlK7DUWM6IEXKEfHayJDZUFBK?=
 =?us-ascii?Q?886NsW578Zs/AWtSqQ9nkl15wclonQNiOKrtqjhIN94qpJvCcqKpgN0BFVGt?=
 =?us-ascii?Q?Z4PwoSV4Fn982dBRtVGGE7+E+qxCfTEn3NUebp2sePuFSeaNC50PpNV5OKfp?=
 =?us-ascii?Q?61U19lbYqpdEJ2Mkr3r31IEVz6ljQxJwgpFRqOoeuB0jCQ8OtYOYnpklHT2c?=
 =?us-ascii?Q?lOnhKt544RKQaa5Lz1jaMAXTbmj0jFXDkf8W0IbNE9f1ZgYvnlijFN0xkE1r?=
 =?us-ascii?Q?toKZqO5ropzjJ1l1k4UIx2qByZ9PQD80xWpKBaaLtnG9FXkIx21vH9dmmEza?=
 =?us-ascii?Q?EHp9H+8riG4x4dy18VV6lOz4MuCOLY4jiie0Rmoq048FrctDVyY8FtOJ3Xdj?=
 =?us-ascii?Q?ORS70huazpITWFj37eW4x3xrKrQZWGzrABJJ1veX8wdz5ZdRoUBbnLiOaz5J?=
 =?us-ascii?Q?bF5yMchkmo0mQClZAqVr7ZMuD2evnceAYJafh9JerA6VbZlwOuKARZdWex+p?=
 =?us-ascii?Q?nqzxguqIZk/ViU/bDlh3ugId9ynV1s7vQFOz2I7Mi3pWlf4gNwY4VwqkJMbU?=
 =?us-ascii?Q?AoP8ByiptOYzfiOkC32F9qu4957nP0+fXvk1Vm3w2sZy4acO726+e3YDV66u?=
 =?us-ascii?Q?y+08X+ffXEHhZfcepL09oWIvFRg+zVCfKhpSeWQXcHIvS7X3V52ViHUzqY/H?=
 =?us-ascii?Q?fB7QbLAqlvJHGxkm1/dG94uiil8cYrDb3mXK5tmzvzsc+Dkm7l95aPOiTYCO?=
 =?us-ascii?Q?rZMJ3kaTlQtQ2o+7YpxcXcEe+3W0JJ9YskeTxYZeR/FKF9liVLLECQ2mx9jl?=
 =?us-ascii?Q?r9N5t6jP1yVNeIjIZYOXggN+gn5boXcy00ZSWwSr5taW+cYB9sXLNGUlEFgq?=
 =?us-ascii?Q?RLch7ZWwhQ/nUAVharSwtyX3Vp0soUxCw8GFqDCOVCByF8FnW7I4NtLJn7tb?=
 =?us-ascii?Q?Q+hArB8ILS7NJjIex0AmaKSXvs+c0ABl75YsVc20ziLKPsDceagfou+cvirp?=
 =?us-ascii?Q?oLRxpfgBokObPCmDpXUZFwxzVvAe2lcBA3U9BLgVtDHIvA83U6lyXOGTfURq?=
 =?us-ascii?Q?X6gnqDsxZ0E87ODK5ZgKTCwCnPIR7fgWcgQpg7JJ0zf/5yWmtQH5PLAfBXv6?=
 =?us-ascii?Q?hNATU/zvdIBe83QX3oelwuVpISaH/jBjQiAnI4577vjKwUMLHzdXUQy9GQ8N?=
 =?us-ascii?Q?xm8nSaSKDCWBZ+6nlMLFdV8w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb01876-8a10-4273-676b-08d907eb49cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2021 13:08:58.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+Uzs28oOwJiwlHvUeVK8N6Z9N9cvECmugNYVTUJ08NRWnC9Em86NBFi+uyEYq9P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0204
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 25, 2021 at 04:03:47PM +0300, Leon Romanovsky wrote:
> On Thu, Apr 22, 2021 at 11:29:39AM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 21, 2021 at 08:03:22AM +0300, Leon Romanovsky wrote:
> > 
> > > I didn't understand when reviewed either, but decided to post it anyway
> > > to get possible explanation for this RDMA_RESTRACK_MR || RDMA_RESTRACK_QP
> > > check.
> > 
> > I think the whole thing should look more like this and we delete the
> > if entirely.
> 
> I have mixed feelings about this approach. Before "destroy can fail disaster",
> the restrack goal was to provide the following flow:
> 1. create new memory object - rdma_restrack_new()
> 2. create new HW object - .create_XXX() callback in the driver
> 3. add HW object to the DB - rdma_restrack_del()
> ....
> 4. wait for any work on this HW object to complete - rdma_restrack_del()
> 5. safely destroy HW object - .destroy_XXX()
> 
> I really would like to stay with this flow and block any access to the
> object that failed to destruct - maybe add to some zombie list.

That isn't the semantic we now have for destroy.
 
> The proposed prepare/abort/finish flow is much harder to implement correctly.
> Let's take as an example ib_destroy_qp_user(), we called to rdma_rw_cleanup_mrs(),
> but didn't restore them after .destroy_qp() failure.

I think it is a bug we call rdma_rw code in a a user path.

Jason
