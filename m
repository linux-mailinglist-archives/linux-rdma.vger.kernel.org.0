Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4633B4754
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbhFYQXB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 12:23:01 -0400
Received: from mail-dm6nam08on2055.outbound.protection.outlook.com ([40.107.102.55]:24693
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229586AbhFYQXB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 12:23:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ld4NcRMYrKh3QUMW+zImQBVqIyt6+OaNSdyEqTYnZQtR7DFGdEsVfdZ4ekXEGdITF9V7HQZYQZgRiNZUebsCO0zKS93yQBtmAyurkLDQQivjSsfPlz41x1c2+H9rqhYdr0Cv3hfqNJX/IYSqz+XCRjOYjtVqodE4+t3qfHOPOpeq3aFnga1Kg77jSTSE47HZg2hHiI4p4Ka/fYNAqqJu57cFIsdhZQTFFuKmNIG5r8asO24bpKM0frTv9xIVJTjvc0AvhGiWRcwPLyAp98Z0G75vDKDvQfPXp1JmM3Uti83qpLHVWPr+i8Pqc7u+/ZWz1kjOV/Ho46CgBYQYY5CraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4PeFGDtpsHxVq8IHCdJMcZZoOWvHSWd/nJBjsQW/E0=;
 b=BF5pKXKaAZ9cWWlVP5BUUZY/AcTrvkDTsbCbnwOucvZvsVpYm4npEh4uxlqhr/GDsNd5fzc1ubDl+V1NIgTz6DKvbobGMgGq0Lnry4qkAUkS62zLWJZ5LJpoQnsxHeuMhrcT9peko2+sMJuSexU+GjY2HlxoRgAw0FyOyXIqW66Sd37SY/aSlb2gI38SsaqmKrDJ24v9je3AhlJCU1Vh7YPRvDdIoZ7z5HViBqGSHxZNbFwIXpHFb6N3uWflUNhoJStEeKBtmSpnkozi9tKyf4BgF2zo9E8QR1ptbwGnQoux43khAUnDZAIkGe/A/SM9iiPj9K3ykzGpyoq5zB7uNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4PeFGDtpsHxVq8IHCdJMcZZoOWvHSWd/nJBjsQW/E0=;
 b=l58doz9CMyq5pCvWV94Oa+9dQLGRK18OvYzQDYxrf6cHMGD6Ww7YB0ukwqP7LW79zTC+LxM6Y5c1wKmYit5k9OA8dOGJDILuwoBwDL8xmCoQuBXrNqAhTVBupOqdpWqr1GyDSkScJxvpQrNeGKfwXZIuCjWC7sf7EKpedYxT2mtmzDXLUirjfIzD/IPh8VKl/E9b/5GAvhvUC+5JI6HMisVfybdfGRxWKSsiNWqlIjUHHBIQsg5A6e3bENjrUVxTFSfNKczHpyHB0+6WA7bJkaMTv19uTroal4TWRocV0HCUYlymwWxLxouDl9igbHQWwp6sXuCATWzelQeMdAWd2Q==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 16:20:39 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 16:20:39 +0000
Date:   Fri, 25 Jun 2021 13:20:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: rxe MW PR for rdma-core
Message-ID: <20210625162038.GV2371267@nvidia.com>
References: <29c7ec8a-3190-cb75-855d-f8c9b483d896@gmail.com>
 <20210625143924.GU2371267@nvidia.com>
 <62f655f9-29f2-de99-29b0-16539f45e6fc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f655f9-29f2-de99-29b0-16539f45e6fc@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0089.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0089.namprd13.prod.outlook.com (2603:10b6:208:2b8::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.13 via Frontend Transport; Fri, 25 Jun 2021 16:20:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwoZK-00Cl00-6X; Fri, 25 Jun 2021 13:20:38 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04dbcc7a-e03f-4790-c2f8-08d937f52bde
X-MS-TrafficTypeDiagnostic: BL0PR12MB5521:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55218785143063867E7F9F7CC2069@BL0PR12MB5521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOtBdJR7Own6WD2kZwMyT1+hzzh1rdUfglnOGWZLC9G72Xwjx25QeHTTjG7z9+R3VYPgTNTxEMhvFJ2xuQ/aGUB8+RoakXp8nDiyjfVs70uZCfdrYiGagWNqg6175yOBYPdzlM8XhP7N1ebXNhDElT0gD6N90lhLagIp4VBNyxUgWV7NR0vJVGbERb416HeEKSmcE29YyWtLpOa7cX6hrMFLgM+FJqQOFkW4yr2O4dwB6MBeXUibKhPLSOsTukwlr5ZS85tdRbBXv3LDQI53/MUDXNNe+5cEJSZC1SylmRcR8y0F/dB6DZyiQ9vkdy+TAsKUbZQE7hQ0xSs7V916p2Eeg9cKnT5iPMLVkmJO+wV/yXcenG5vtZ3FhgYimMb3ZIRX/cfz6fABoLhKfCgMcIBS5r4ctGjc9W0REn8ljyn0ZZ91W+kToNG53HfoR1DpQndbZaTpN+StLY+28dCciwt6R7JFMCnj8VlRLJ4FZ0HKIu5bbFMLSdDSziwBeNUz+hXnmxTqdHRnz/djOGcHq103g4WaDwhbmfeEPNnlC7E1qTLbDHSDGaiQYhSGuUt2gYEyQPPHWOkx1LAKga6bw5H8lHxV0GY8KSisu9KliNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(86362001)(26005)(9746002)(33656002)(6916009)(83380400001)(2906002)(1076003)(2616005)(53546011)(426003)(54906003)(478600001)(186003)(316002)(8936002)(36756003)(4326008)(66946007)(8676002)(38100700002)(66556008)(66476007)(5660300002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TSvYPiqtWKIXoiufFIW5U3cfLmN0yt29Jab3IaSzVjGjs3jGGh0dc+KYPwAH?=
 =?us-ascii?Q?myOqL+sPpJDrposqgzWZdhhg/9FAU/WRRv+jRSI4FEtml4TIpA6ZzW0URz6b?=
 =?us-ascii?Q?uKedkZ6LOY4oyje/T2QiMirjmyjd6LBDLjzHwX+uPWKd1P9+CoaUBBM4QPe4?=
 =?us-ascii?Q?Ucdo+RJRoTWbMvcVeDaVavtP0HsJntz6TXNx/4GxYzceGvIgQimSyTWERs+T?=
 =?us-ascii?Q?ZoCAjq9r+YcSiHNx3BBUK3MxuuYcYY/bJKh3b3YFzxdsOxoyZVz0+KuecjUh?=
 =?us-ascii?Q?GAdzE+nDr66feLMT9SLjywtAxYBXVsndSmhHE6FFjxr/43pi+JwYIz5crnaG?=
 =?us-ascii?Q?SXObpdDnhu9k6QUrFmLo9e6qHud2DCQ5Gh5SyBBEb5F8Eb91Pd6Swa4hXBgx?=
 =?us-ascii?Q?AJLfUUIw8GXO6LWPT5mvOmtSVLRUz5zGKjZ3JSTBHv14TTjTjfw2eCKrjqx5?=
 =?us-ascii?Q?RS6Qh7ajqrKY2KbylswBtUdYvhQbps6h9Jp9EaWdk14kgZlk1AF5yKMsVMnU?=
 =?us-ascii?Q?3zmblgkk13laUrVKTiTGdwIEH4KrbARkAUE24yXUiHPDD/Lb81s9XwDKElrR?=
 =?us-ascii?Q?z65lxy6qDl+IgyW0B3e64nrVPFjFKpBOzSWHIJ0IPvVgrmP7I2kDjP0apXrK?=
 =?us-ascii?Q?1OzjS4BLOGkLdPwQSF5kyRYNX3l8YH4oyWMpSUBmSQvfxXjBFAjw2UwvUAbZ?=
 =?us-ascii?Q?rgseUqvQOSyGK17gf38RMKQeSaa/KjA5AvOV3GrpgV2B0kCuiBkQJL86lDV/?=
 =?us-ascii?Q?fEG5fOHB6msMqVY9Le3JK6VNP30CmiSZbf2/NCQVn53ySSuliiFqzGd20LU3?=
 =?us-ascii?Q?e+wkUEg+2ZKnglFvsWOot6OM8VDvhj+Ihz7wY/lMa82J9zmMpYQfFok7gq4u?=
 =?us-ascii?Q?92xgoC2A2wNVZrsRElbGCwmO9OtZeLsQ92cDN5nRZRFuJYxzFXmFSW8UYChI?=
 =?us-ascii?Q?unqqJ4iKbsIFaftNY079XfRPF6io43PZTKZsdzg+AnLuq6XW2UjxuZIaD/20?=
 =?us-ascii?Q?7jZhgX3GM5pEDZkydvPv0j3PCysezdCKjU7PePdRTZNfgTfKcQllYARKzer2?=
 =?us-ascii?Q?AsCeGOmF8aJ4dQW/NX/T2kfvkoAY0QFUiCjSEhqGE00DmCqMDVjmNgOCgVzl?=
 =?us-ascii?Q?tokogPyi1nAwvY7b58zWuZk0NcFO3ghPQ2XYqxjmZMnoMUha/tmc9hTSqWIi?=
 =?us-ascii?Q?prYgdsiNicZ76sw9dt+OaPCNSwba2wDTVJMSNQIu57WayzDklE+Ky+3lR1OY?=
 =?us-ascii?Q?j0kp1AUAKgwhBzmLar+O8vS1WL2KycwE5w7/BFaE3FTdqEKqx6srLw8w62fh?=
 =?us-ascii?Q?7LaR02Lc39BvuyDKjCcWCCv6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dbcc7a-e03f-4790-c2f8-08d937f52bde
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 16:20:39.3554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+3mBLW6b7JzQ4hZ5Xp9TGscTF4lo+aDJqscU6y19EzcARTMkhMC2dlbMIEfKmYv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5521
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 25, 2021 at 10:04:37AM -0500, Bob Pearson wrote:
> On 6/25/21 9:39 AM, Jason Gunthorpe wrote:
> > On Thu, Jun 24, 2021 at 11:59:14PM -0500, Bob Pearson wrote:
> > 
> >> It took a few hours but I finally managed to get rid of the merge
> >> commits in the rxe MW PR. It's back out there at github. I lost the
> >> name change Jason had made when I deleted and reforked my repo. I
> >> remade the update kernel headers commit without the ??. It still
> >> passes all the screening tests.
> > 
> > You should never have to delete and refork with git.
> > 
> > Force push fixes all mistakes.
> > 
> > The sequence to fix your situation is
> > 
> > 1) Starting at the bad branch merge to latest rdma-core
> > 2) Create a new branch on latest rdma-core
> > 3) Use 'git cherry-pick' on each non-merge commit from the
> >    bad branch
> > 4) Diff the bad/good branch to make sure nothing got missed in the
> >    merges
> > 5) Reset the bad branch to the new branch's commit ID.
> > 6) Force push the fixed branch to github.
> > 
> > In future use 'git rebase' instead of 'git merge'
> > 
> > Jason
> > 
> I have a question about how the various trees are arranged.
> I started by cloning the rdma-core tree from github to my local machine (i.e. origin master).
> Then later I added my own github account and forked the rdma-core tree.
> I have a link to is in my local .git/config (i.e. my-rdma-core).
> Normally I do a git pull from origin which is shorthand for git fetch + git merge (I think??)
> To rebase instead do you have to first do a fetch then a rebase or can you set the rebase flag in
> .git/config?
> I also do updates in the github web site from rdma-core to my copy there. I was having a hard time
> getting the private github tree and the local tree to match (because of merge commits)

Avoid creating merge commits in the first place, use rebase not merge
to rejoin different trees.

You should have in your git remotes something like:

github	   git@github.com:jgunthorpe/rdma-plumbing.git
lr-github  git@github.com:linux-rdma/rdma-core.git

Then when you do  a new task do something like

git fetch lr-github
git branch foo-task lr-github/master
git checkout foo-task
<blah blah>
git push -f github foo-task

And when you need to fix up foo-task don't merge but

git fetch lr-github
git rebase lr-github/master
git push -f github foo-task

> In the github docs that I read last evening they seem to recommend
> cloning the forked github tree instead of the upstream tree on your
> local system. Is this correct?

Who you clone from only setups a default remote called origin. You can
always change this with the 'git remote' commands to whatever you want

Jason
