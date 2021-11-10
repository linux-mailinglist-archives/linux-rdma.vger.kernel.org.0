Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39F44C36F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Nov 2021 15:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhKJO5e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Nov 2021 09:57:34 -0500
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:9312
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231743AbhKJO5d (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Nov 2021 09:57:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxjo6a93r8az0iTlJa/IUXRk5nTnwQMgKvmBRITk259180I/nXiqODmyrNwkQ5AGnqd1/41kDlSKEo9fJbRucaX/FbPDRBrJttv0SL05jW6TEF9vwOI5lkxY9DDuUZgogcocaY4gAPGWSvY5wHF8OS5P/Vx/yW9ShcZuB/vdJ4ItuEU1yydSmfaQQBAc46FB2cyINgXLHBBYbQwSrje1zGwFafDp2DJhZ25mUyOK+/NFSD6vb4rPjKaxorhvH2y1pxBW7mX3fG227U50NxBWnvyAiKRkZz7CQ0btBWZQf0D2YAZwwz2XThs8uO1dgJTbl9AqnWGu/jUt52Ag69s/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9qPEJ2+em7miIvqekGFDWj8VU3dWJk4G4pRo0V8mCM=;
 b=lOvOhrF9tw4jDWo98VWULlZo+OMWx1kFgRywcqkSMcc12+E1hYrhpYauJcW4cETYOIHU/cjBa8EOU4Qfk5HIyGf5ZlRmBsU3V4XZWnJe6kfertt2oc+zaytuwafOOr39w5qtXc0zvASn8yZ0lz/0rSMYNsa7+15FTBo888QWxs8qYRoHEuMFOWnY9fl4K0Gv/C6i3SWODsvi2755zoswuWmB+uv6+rpkPRxWmIZOGUX4JQ4+tfLvq29K4IS6IbgEMY/iVefn5kpNtdpQWgMRPEMGx8zcUYKnew18k101muDIvEoeE1HyMnOguyqBmuKInZM1BciFn/Hz/FVfOeSY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9qPEJ2+em7miIvqekGFDWj8VU3dWJk4G4pRo0V8mCM=;
 b=n6xJnnFGdEFeAvYxs4ej5NuWvt6DrXeA675qWdoi2sK1Wj3YxKgXJvhtsUCbmgNGQe+Rp/BAUOCwII45YwFiFHnXaON5JyF6OlMeJx9nKeebyXesIcMm8tgAanTURVDXA6/6THmFPhBCQD8W7AF9Rb5k0gjQLn46qsRqqqgRaW81mLUQctANTSLEE0TNrpSP51qI7pA50v3DlN3ZB4VYBFbC4hKOzBcp+PVotpfWOL0EM017OU0mMnGuz6S/5onhgpkZRsYkFMEsqL5hNEw6vNMPDML1dNG0dPDJiniKNqYsF0TpRT3zZsj+vjvndQmCLyYyWTOPGG8klfCm2kcmtg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 10 Nov
 2021 14:54:44 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 14:54:44 +0000
Date:   Wed, 10 Nov 2021 10:54:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/netlink: Annotate unused function that is
 needed for compilation check
Message-ID: <20211110145442.GV1740502@nvidia.com>
References: <4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com>
 <20211108123639.GT2744544@nvidia.com>
 <YYkcV9g8E3KhE92h@unreal>
 <20211108124839.GW2744544@nvidia.com>
 <YYvVL8myawsp49RB@unreal>
 <20211110144244.GU1740502@nvidia.com>
 <YYvcvUZpGfQerupd@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYvcvUZpGfQerupd@unreal>
X-ClientProxiedBy: YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::13) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 10 Nov 2021 14:54:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mkozq-0080Nq-JK; Wed, 10 Nov 2021 10:54:42 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68d31702-40c5-43f2-4a22-08d9a45a083e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5047D708CF509325D9D3EB0AC2939@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:240;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmTNav/S6YcBve4+mwS00q4VqRF3Rv2esItaRlHH36uLS/oBSqFp5tjYWzcJn3+0DZ1sX0144hQxGq3JQfTs5D5TzQTCM3Er58D4nsjoNEhvHbSkUlNaPB3kaKMETm36il+rwQeFo9LxhZjzn1sAdOxBMKhjzcIZCpTA+rTY1MtkcEYGSN0gPhQ+VnF+hnT7sEaqfeScdvwt+NSXo7rkY4K6L9Zh7mLuh77KxmB6GXECwpVNlTvTcYZ638ggmurG4cHuRy5GHMO/9zDv6VRNcW0KJ3QiHKIb9Ugsa0l21Au4hZeezouttTpK/5C7ZYXjq208+XZ7PSOpIWydT82C7TKE9yyjVy3Wkat/vUvhYyEB7rPthymJWmVxczqPXe6IToVNonZyfX9UHZ+/j6zVMa+R/D/Fl+JnGBRc4KeGpXCALrj6HpGORumrWe7hmi0qtfrGJpFh8h39h7vX2llOqTGVnNCn2CF/7wEFKFN9+BYT7u0NL4SdwvkbwqY6ZUpF2DvDfsYXT9z1vKp97FW0U41OrfKG7c8dCzaGHUuHS/CHr7QGPoEa32dbcwpbKZQxU7N3hTSvqaNdb6cfdO4gT8+yI6eaevmTyVuZzqneSCpi1X40rNTr/BKBjBEjqg5Jsd1lZ1d/VBl84EM2VQ68NNUOs9+yE9WWBXp5PK8BkJ/FM8MrBh3JGwMLkH9/Y1HGYUxHCcA2hpE8dXT0myTCcw8yv0qKvxHLgNBt85q2ReI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(1076003)(66476007)(4326008)(5660300002)(6916009)(316002)(33656002)(83380400001)(426003)(66556008)(2906002)(66946007)(8676002)(36756003)(9786002)(8936002)(186003)(9746002)(26005)(38100700002)(966005)(508600001)(54906003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Y7Rd6zz1uOR8euc+0oCHDgwxl5Lr2DHYOzfvWkyt8tVWdKKV42Z/LXQq7Ij?=
 =?us-ascii?Q?4tXv8AxOPO0TSwQJQY9LX1SAQI6m5iuvaxqgsODH4Z0PbXJ6QRYx4OhoyAXw?=
 =?us-ascii?Q?gOQ6dvFrmXdFNza7f2Qho73Du9Y894grqWPLDSJvvtu/vn8iaXpbV2cMszkE?=
 =?us-ascii?Q?M2Yjsdcdm1G2pTysrWnK7mT/WbuefQb+RSuxZszf7JV9EHoG8DGZBcbKjJDA?=
 =?us-ascii?Q?3fkC9BrUfziZtcmGOefK2xQuMvDY3nEuZGRYSG/iLg5X6X1tFDDMWsFRSsfV?=
 =?us-ascii?Q?m43dUIs2gtVoiXUSj0VZyrjfTwqeRFC2MHjaK3y5wUObrXTcDR5XZ6ILkKIv?=
 =?us-ascii?Q?TEXQ1dNYnBg26AHOjPT6NwPdLLl4gKJoI810B1Ge1E8Dd1iVMqt3UNHPN2tQ?=
 =?us-ascii?Q?Tr5Vv2AN+Ixbmp0Nn70olHlYLuamoafYihvOBWxZBPrkJ/vVRLHQd1Fi4R3r?=
 =?us-ascii?Q?USSSUXQCzJZB7QvW3bpFx6l3cJt9QG0TXb1FV3HuJKttrlJMs5bjigptz1er?=
 =?us-ascii?Q?eJzV2gcFcKbpg5PRZvfX/hnoy9Z0BAL0GwbsS0m50arNRkaTL4/Oibm1Zqu6?=
 =?us-ascii?Q?T4Geae7oKgc7oSKqV0nXnjzzi6iAwjKrX2ADHEb42SNK9YWf4cdacMe6Fmr7?=
 =?us-ascii?Q?U9R2HC7Piq1sir5aJyxhwsauy212UfZ/sDDT+Wj5WKNJJzbUr1I23eUWOiUz?=
 =?us-ascii?Q?SNnOr89hU25WGOycE5GegG3K1+uy7aP/dID72yJ31GrmK5Uatt1qF9ub2OIJ?=
 =?us-ascii?Q?iPa8p051VvaKlC+gx0PcfqcKSyQ2BH+uUyNlPJ5IgIQHv9Zw0xpMwmWkLTpp?=
 =?us-ascii?Q?WE0RBPLyIubiPmqxDDixtne3CHwNMZWORDOjgc9QZM886XSfD/QdrmkG9ivD?=
 =?us-ascii?Q?vyJh3am6NFkZHmgw3WUGr7mQQj4eYaOLjMrklZInII24+xpy+wEyVcXXM/4c?=
 =?us-ascii?Q?YK3ra/5bleDpccgneZGODFa3IejksDWlrteEK4Tnz0ybAP0BsZPzO0uE528+?=
 =?us-ascii?Q?Bq8eLo1aIs/l6Zy6oCzjJDYaE+Kf3/hUd/R7wpS31DXxK7d+fRrWfsthIqp9?=
 =?us-ascii?Q?jbw1ICRq7oQVRxvZ0UgvuRBIYmcoyR/jnyjVafedgXKYYV+n3KRcBv1CGEvp?=
 =?us-ascii?Q?TZmkRd141ejEfC7I/g3fTEPqL14fRxw+a9eo0oUq5x/w0hIbpfsGN6xJLBiI?=
 =?us-ascii?Q?lmVgW9hpfYOUkMijLCaJn54Zc3GNgYTlJwUWdg8O9xZIH0CJ6Rhcd5G73rNe?=
 =?us-ascii?Q?Tn0b7+7+vga50+JMkDSIcEEdMKEC37rm2Rw/hKEYjp1qUW6XtyF5SQFkwAIT?=
 =?us-ascii?Q?/2HZfHuXfHtWNvmikN08RWwowFxsjEbH+FqfimlgfqOs7ylY9aE8yGhPS43V?=
 =?us-ascii?Q?FlLMxAqyVHpS5OvmCVCQTANFgJUVlP/aMLhv49TX8YJbEzJ8BKrxWTLlYeh8?=
 =?us-ascii?Q?GK9RpwubAk5yyXnCF9JQWuTUg2aPtWGvvnadpz/DOFedi5CTL5AwI8qsHZEp?=
 =?us-ascii?Q?PgLTsV7p/qEp2xiXBYdhS06Iaem44v0Ze8POix4zHZ1IzUNceuIxkmvazfc6?=
 =?us-ascii?Q?qMOig4NcQSOWZMT8eYI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d31702-40c5-43f2-4a22-08d9a45a083e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 14:54:44.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAjIIrb9lsplF4M0Kqb3sRjWvaaUr53zTw9krG1jxWpzf4gs0PhEPgSXSFAXD0BR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 10, 2021 at 04:52:45PM +0200, Leon Romanovsky wrote:
> On Wed, Nov 10, 2021 at 10:42:44AM -0400, Jason Gunthorpe wrote:
> > On Wed, Nov 10, 2021 at 04:20:31PM +0200, Leon Romanovsky wrote:
> > > On Mon, Nov 08, 2021 at 08:48:39AM -0400, Jason Gunthorpe wrote:
> > > > On Mon, Nov 08, 2021 at 02:47:19PM +0200, Leon Romanovsky wrote:
> > > > > On Mon, Nov 08, 2021 at 08:36:39AM -0400, Jason Gunthorpe wrote:
> > > > > > On Sun, Nov 07, 2021 at 08:40:47AM +0200, Leon Romanovsky wrote:
> > > > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > > > 
> > > > > > > >> drivers/infiniband/core/nldev.c:2543:1: warning: unused function '__chk_RDMA_NL_NLDEV'
> > > > > > >    MODULE_ALIAS_RDMA_NETLINK(RDMA_NL_NLDEV, 5);
> > > > > > >    ^
> > > > > > > 
> > > > > > > Fixes: e3bf14bdc17a ("rdma: Autoload netlink client modules")
> > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > > >  include/rdma/rdma_netlink.h | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
> > > > > > > index 2758d9df71ee..c2a79aeee113 100644
> > > > > > > +++ b/include/rdma/rdma_netlink.h
> > > > > > > @@ -30,7 +30,7 @@ enum rdma_nl_flags {
> > > > > > >   * constant as well and the compiler checks they are the same.
> > > > > > >   */
> > > > > > >  #define MODULE_ALIAS_RDMA_NETLINK(_index, _val)                                \
> > > > > > > -	static inline void __chk_##_index(void)                                \
> > > > > > > +	static inline void __maybe_unused __chk_##_index(void)                 \
> > > > > > >  	{                                                                      \
> > > > > > >  		BUILD_BUG_ON(_index != _val);                                  \
> > > > > > >  	}                                                                      \
> > > > > > 
> > > > > > This is a compiler bug, static inline should never need maybe_unsed
> > > > > 
> > > > > I saw many examples like this in arch code.
> > > > > For example, commit 4ac214574d2d ("KVM: MMU: mark role_regs and role accessors as maybe unused")
> > > > > 
> > > > > It is better to fix and forget instead of trying to fix clang.
> > > > 
> > > > "Because clang reports warnings for unused inlines declared in a .c file,
> > > > mark both sets of accessors as __maybe_unused."
> > > > 
> > > > Yikes, what a thing to do.
> > > 
> > > Jason,
> > > 
> > > I don't see this patch in the tree and patchworks status says that it is "new".
> > > https://patchwork.kernel.org/project/linux-rdma/patch/4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com/
> > > 
> > > Should I do anything extra to progress with this patch?
> > 
> > It is merge window, I'm not doing anything with patches until rc1
> > unless it is an emergency and a random clang failure on mips isn't
> > an emergency.
> 
> ok, I didn't know that build failure is not important.

It is a warning then the clang mips compiler crashes, so <shrug>

None of this is new code, frankly I'm confused why we are only seeing
it now since I'm running clang 12 builds standard.. Is it W=1 or something?

Jason
