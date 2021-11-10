Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AD944C33B
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Nov 2021 15:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhKJOpf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Nov 2021 09:45:35 -0500
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com ([40.107.244.67]:35265
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232057AbhKJOpf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Nov 2021 09:45:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0GiK98Bqj09taqBGehGW9IXGhpMNo/6g/giiPveM+FSmOFqHwvZ4P1IL152YQNGqZzmxt2LM9FVPcBFXVyKhp9PpoXfADgOWLaVpeaAtnDjJSFFeer4xV5BZxUn7sKn7/HomQmyLtnFYfb38iqQ7vuAt50TQTOuxZdSxLhG5XJjMRRwXuFstKjRf43cGJ6wVNPyyQgxGhDIQzItjkIxd6+hj0yLROzLCa2ycAU9wnTePl3BYOpbS9MBehFcBqiINXxhA/N4hicKeoB1CaO3nwjVLO5aFFYCMRFQ0B8qTz3Ve/SFymAJLVdpRt4j3juO1fkD0uq8rXp72OF8ZUoVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzQzO0wONBaNDwo9giw7YPZqHtjIv3r1viJ2MUkcvt0=;
 b=kDophVF9q7opZJpjz4sCM4hX7eGSUqY2zDjZBeQ51vWiOx/kPEJo1f3fqKyzcl7Kyo43zIsPYcA/DStupP2kZ0pijM0uM41SBPW/mnlAgG8RB3wzuHhkaoNMI2aX5m6mxtqqXzmDV+6pDpwlDSFQLjMkF4SFxd41ro+icEH4K20c2O6Cfv8oNlX4iApfdmQf5LCutK6u9KQm8yD5djLC6F62fVTWvxRSIfOTTr+/welRha+ivyAW9/Q4aYUJmB7rWCKTuWetrCMlSie7+9ejwOVlaeCqL2frvN6eEQWy1m7tXLDgFv+P+g/VKRKecpVNXwSKBsaZ0dWqPou9WMaTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzQzO0wONBaNDwo9giw7YPZqHtjIv3r1viJ2MUkcvt0=;
 b=rVF6Md7qJ5vDFYPvfDVOq/61n4tR+WQbnIHU64lQF36o/k+qkYgU2dlsYK/523m5nFSix2u0fH5oDrxxz0Sk08GCcvw8hA5BZLRsStdOtJyc+Mk8XK3eBWBGYsKvQXYLQ9/w/VqHdfP44QmSNwCynNYadlzz/IBZ9codHWKN0Fux7Zh4hrz7WMIYAAxx0ndq/1PM0+XKdr/ZhrLSOgnhvH+hf/zfl5Aog2K7MgjxxmxQndXa8Erw+mJ+IUZKHgh03K9wIDi++uHSGT76lNK6DLUkXcytwN3Au4NTZLA4Gouco39vdIxrsDQHZtScF3cu8HSCB0nQEVxeEeB3dFa3tQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 14:42:46 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 14:42:46 +0000
Date:   Wed, 10 Nov 2021 10:42:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/netlink: Annotate unused function that is
 needed for compilation check
Message-ID: <20211110144244.GU1740502@nvidia.com>
References: <4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com>
 <20211108123639.GT2744544@nvidia.com>
 <YYkcV9g8E3KhE92h@unreal>
 <20211108124839.GW2744544@nvidia.com>
 <YYvVL8myawsp49RB@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYvVL8myawsp49RB@unreal>
X-ClientProxiedBy: CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 14:42:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mkooG-007zyA-MX; Wed, 10 Nov 2021 10:42:44 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a079b8f-0509-41dd-3e39-08d9a4585c1c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5288:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52880F6C97E7EA437CB15279C2939@BL1PR12MB5288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQRLwEEhC6oVtG95Ql0r7iIQNatk/9vogpgGiIb/BGcoJLIuOE670Wk5JjolywHzoWQwiXotaW969mEL8fOaNpjIxxiyNK1mJtYfAshHIGJP5SfLXmNYZWUtMZTtr/7ehOd9Ia5DFGPwPjJLYnJtreLNMGFTg8a7pjsgTlBtDaiE9o/6clz2nnShOqYW5JXq2/fxjLqAvJfN0ZSiAafPeLlZ6l8LwFJ5zBmHqcVxC0TG3EEW5xFFk5/7VM7R4De60g/4KG6lJ7PXv1ur1RR0IuYF16fUboK38Wq4c1J8gj4VOC7wcrI6IBINXtfxkd6hJ13JF7IrgM/hFz/PmowNA+8HBbLS8TuRBAAc3qhMN6x3+Iki5OvJyqfg1tcwoF2rKe9rYmC907qMlstrZE5CSNAN3o0XSprXgP8Un9AvCo43dJBO/sEVpk9RHyxEHV672M3km5oic/64yHIZSYG+7B76suDbRoO7bUTLKV9Yk8aG2UHS7rqeGldEbTFXDBVA+8lkaO8JRcNhd3WwOra9F++MUvzOaTvfGTMinHi1kDpcAat4fYHFbrrjxUFEhvhSiYBJ7ciovNL5wgNzFqtwss7ms5gFB/t5S3xWtSTj+rX32FNp8QobHWB8tKxwTL6mFJyEQzouspZdK43jCAN5AKPSP44wiYAz9RuAoqo8LaskeADfEVpJoLT0iism9PD0ibN9PllaNMJdUEJEO1xbtPsPQ8AJn/FXx+DSkTvMcwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(426003)(1076003)(2616005)(66476007)(966005)(36756003)(38100700002)(66556008)(26005)(508600001)(66946007)(186003)(2906002)(5660300002)(4326008)(8936002)(6916009)(316002)(8676002)(9786002)(9746002)(83380400001)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V+w/6aq0ehuvIDygjLc6BKpWXvy9In9dgnszsWwo+Ow0uXTyryMjGohh79wq?=
 =?us-ascii?Q?9ohYQGsvjBdYTqAt7eQrjI+Z57L2d3BquuLv4ZmfvscRIqZucfnEMoYtPIkJ?=
 =?us-ascii?Q?OfhPinwHx8sY8fWtuDk6kmvVTostppOd8axVL3XVoc2+cfWsKhoFQ+swzFLL?=
 =?us-ascii?Q?M+g6g91Jd7ZzXrevd5CKHIsCtNBLsxN6xsQ4cREkgYUNEGiyazQCWipmJ5/3?=
 =?us-ascii?Q?gE1dM0KDwA+EhlLV+vujMF3blcqJURUsVmMi8eJUjTsxR51NAs1gycYWjnDS?=
 =?us-ascii?Q?saidzEnsjTRTP7QCXN4y3VrHvSWfiLCdt6oW4g2nhBPYmVefY/QqB+d7a6gd?=
 =?us-ascii?Q?Ytp58mdP7qLLwsc7NzB6FTKk4fNchA/TUGTxN78wiSui6snxBxkM22dVE7ck?=
 =?us-ascii?Q?qwB6oG4KGs3cz7wiz92qvprT01UUO6qMMklq70LOKgWQhGHLwO7Jvq4mM004?=
 =?us-ascii?Q?q1MTmzYitpupOLuptZ61GEHCyPHyq0x1bpv/FGdavV4NXAYEQIRaUTR9QcVE?=
 =?us-ascii?Q?5PBfOLHnSlKRu4Pm5iAIFg92Cb+IFNPTcn+V6z4SnSmHbxVP0+VBKP27VVLF?=
 =?us-ascii?Q?q7bfoAmoxpkWLlhWN8eMIYuxqRep/wkhVMTAWyRAfirxWoKU7D+U0D+jJyTN?=
 =?us-ascii?Q?LHh8KhzpRP/avFBDtzBqEpragS74x3LSLC0c+zFROiWp3+DjRDwVuQl0yy1S?=
 =?us-ascii?Q?DeUS5siSYDRDRU7R9pKGnAJ6UMQ6qHU/NuPXy5neCQqxGCmEHSS1s+1wCa8b?=
 =?us-ascii?Q?lLINtCEdN7T9ZBFlCZTOU2KXv+J07FB6mjaFifaVrlYJEqEZWiCj0kzW1MuP?=
 =?us-ascii?Q?364023L+Qhd6pbs0YFALC7UPeWs8twQJP5wS4mz82cecoMypROYEsgtt6b59?=
 =?us-ascii?Q?1bLP9mtbu8M4HI7Xv1b1mtKzAM33o2e18qGjKlzCrAbAYJOGCzQcNKGZpUlh?=
 =?us-ascii?Q?ZqO7CiW37nMb5xiryxIXyohcoKR6tMlUX4DYJRtvwyPkhMo+VtGqp3rAXPI6?=
 =?us-ascii?Q?4Et3Vi/9JPodLCSqdVFWR1H6xbFj/g6Y49hkV44ovNyavkmlgaliMrS/P6RU?=
 =?us-ascii?Q?0/q8FMy4ATlh/AyIR/ovpW2gXtPnF5dD8fSsfJIkAYihAIQi5VSYSwWBbFBw?=
 =?us-ascii?Q?5Ar+sK+jloMWhWtKXSndJc/kRmwfvRbrwcUnRgYc+E6nkbjbtU8ZOYSm8+GT?=
 =?us-ascii?Q?TnoEFgn8pTcxo7U4SMiN3e9PeAloa3LHEKZdsktOyUlWEV1+2tySYxSKUQuK?=
 =?us-ascii?Q?Ns96Gr2WiXHtp0CcopHjC4hlK+HgqHeWEQ3HOvdL5lbDg2ZE5hNOsKTbvmoF?=
 =?us-ascii?Q?PB3ksLlQEIg0bMipDGXpEO/pEF5Zz2CxSwOm8iFiwpjG25ciXiDaAhhxVAFe?=
 =?us-ascii?Q?bVmDK+vMCDn8RC7BtkUIeHj01XcbXrDcWlENaef8z7NVaiMLqcpwcLdS3ErL?=
 =?us-ascii?Q?vzCHVbC9NbvDm1Ot/4u2KqrILAYijz+oUIH+1gqerkp5NK64SM1dYYeL/dgz?=
 =?us-ascii?Q?/EUlRXE1OJNSAM4Icj98g/FQlzbBcqUtHbJnQ7nR2i7bgmgV//Hm34cb1cXp?=
 =?us-ascii?Q?mDcMtWN/qTXC5UURPfY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a079b8f-0509-41dd-3e39-08d9a4585c1c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 14:42:46.0621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fEMRvFf7O76IrDKuIYMLnHL54PFJKMcZS8h7n2oug1sZBAPYOFtLwMPs3LbvdXd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 10, 2021 at 04:20:31PM +0200, Leon Romanovsky wrote:
> On Mon, Nov 08, 2021 at 08:48:39AM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 08, 2021 at 02:47:19PM +0200, Leon Romanovsky wrote:
> > > On Mon, Nov 08, 2021 at 08:36:39AM -0400, Jason Gunthorpe wrote:
> > > > On Sun, Nov 07, 2021 at 08:40:47AM +0200, Leon Romanovsky wrote:
> > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > 
> > > > > >> drivers/infiniband/core/nldev.c:2543:1: warning: unused function '__chk_RDMA_NL_NLDEV'
> > > > >    MODULE_ALIAS_RDMA_NETLINK(RDMA_NL_NLDEV, 5);
> > > > >    ^
> > > > > 
> > > > > Fixes: e3bf14bdc17a ("rdma: Autoload netlink client modules")
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > >  include/rdma/rdma_netlink.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
> > > > > index 2758d9df71ee..c2a79aeee113 100644
> > > > > +++ b/include/rdma/rdma_netlink.h
> > > > > @@ -30,7 +30,7 @@ enum rdma_nl_flags {
> > > > >   * constant as well and the compiler checks they are the same.
> > > > >   */
> > > > >  #define MODULE_ALIAS_RDMA_NETLINK(_index, _val)                                \
> > > > > -	static inline void __chk_##_index(void)                                \
> > > > > +	static inline void __maybe_unused __chk_##_index(void)                 \
> > > > >  	{                                                                      \
> > > > >  		BUILD_BUG_ON(_index != _val);                                  \
> > > > >  	}                                                                      \
> > > > 
> > > > This is a compiler bug, static inline should never need maybe_unsed
> > > 
> > > I saw many examples like this in arch code.
> > > For example, commit 4ac214574d2d ("KVM: MMU: mark role_regs and role accessors as maybe unused")
> > > 
> > > It is better to fix and forget instead of trying to fix clang.
> > 
> > "Because clang reports warnings for unused inlines declared in a .c file,
> > mark both sets of accessors as __maybe_unused."
> > 
> > Yikes, what a thing to do.
> 
> Jason,
> 
> I don't see this patch in the tree and patchworks status says that it is "new".
> https://patchwork.kernel.org/project/linux-rdma/patch/4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com/
> 
> Should I do anything extra to progress with this patch?

It is merge window, I'm not doing anything with patches until rc1
unless it is an emergency and a random clang failure on mips isn't
an emergency.

Jason
