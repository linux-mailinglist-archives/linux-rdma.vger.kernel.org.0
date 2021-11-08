Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C04447FC6
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Nov 2021 13:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbhKHMv0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Nov 2021 07:51:26 -0500
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:15681
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238443AbhKHMv0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Nov 2021 07:51:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icZamyOVi0yUCEla2dXS+QGVv3QchCP8mpqh/bme5qLIxm3ErUZNfSRnLWt4qkK9NIdEBgUN0DZ4VZMYrN0SmelAXgsv5Q5s6N9qK6hSATet4Jq3rl9S1McqpjHyii9QNkISWaf7BVxXt+rX7gksnTf6HUVAYI+VJO9huBgdk//5F3O1+FUGxdtINIbaWHvMZs0U17ZrXgxTvZVvTLrmK5sl4Mmw+oN67RdQ0ThhKifcSVDlR/OInFnVLURj0ieatDkcgnRppqSOvwSTw9H83c9maV8m171UW3V77Sjq0H3WR1i30JcUM4vLAH9X2pSpn1/RHTbAF0FMk1VloeBo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L37KjozOuMPmi+nL+1MouM7HDGLG1YrhS2Ng3a95PcU=;
 b=ax24HCUWzbuXLMdN39QdibtZuvcFRK+GxPnH35g6peIrjNh5T5Uwc1Daw30d211zx0wjDKtkr2TjaHR6Ni1oeLCaU3YfHJ/j0olxzVLDS4AKcbHISgXI8uwgBS/56MSn6U4dF2iwkdJwTOx4HuoLlc8ZuYJ55qJ1SN5lJSkMFc6ERnZ+KtOCTuMhPgzhLFtQMfr02lkES+vDMVtTAUHA5mH/XSYCHv/fZ29BXwAmIMosHOHaFlXl9S0lydN+6R19L3CY1zF4NljaYGlowQuBYaYiF1M5PN4biCvwz+E7gl6MoeMezc/nIt7hBLCQPzuHGEgZVezS0A+1Sum2YvjF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L37KjozOuMPmi+nL+1MouM7HDGLG1YrhS2Ng3a95PcU=;
 b=gC8+zvJXM7iyHCXOJeA0m/upKGZkN7kEXZkbcUUG18fbQj7ndvNREUc6l+FiXeZ/4q+osLjsvjXgogYmst/7JBZ8llBrU6MtT88gDL8lm3+PvZMuPo1YawXurzuqOAEsnVx6OjsQvgv6ReXtyVAKUY7D2j60Lbze6TuxKuJe1WZXigl5Z/8Tf1nMx4ha9GIB44cigMyddIiaf7Lvx4AQaTZZfVyPKTVJ0R+Msb6BOAjVwhLpgjvcMVjpTkZBlwdnaofw4niMecfbdP8+9JObiFXLT+w31ViQL7xfIpZLSRhSQLOOY1LLKZgv0k6xrbLVgNyntGfKk0jyNs2OOdoSdw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5378.namprd12.prod.outlook.com (2603:10b6:208:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Mon, 8 Nov
 2021 12:48:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 12:48:40 +0000
Date:   Mon, 8 Nov 2021 08:48:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/netlink: Annotate unused function that is
 needed for compilation check
Message-ID: <20211108124839.GW2744544@nvidia.com>
References: <4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com>
 <20211108123639.GT2744544@nvidia.com>
 <YYkcV9g8E3KhE92h@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYkcV9g8E3KhE92h@unreal>
X-ClientProxiedBy: MN2PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:208:239::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR08CA0012.namprd08.prod.outlook.com (2603:10b6:208:239::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 12:48:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mk44l-00795j-5o; Mon, 08 Nov 2021 08:48:39 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d658c5ab-d008-47f1-ccd3-08d9a2b616d2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5378:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5378E85C03B38E28CE20D754C2919@BL1PR12MB5378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:425;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRa9406U+C3Z27B2K4V40E7GufCPuil0POjGN0HgYE2CfPYOh6KpYgSy3zsfRrxEqM0NP4Il4Co8fv1Ie8ndDQM6btNLoVi+5N9QE+2ljOnMichiOvDwgu3FZat+KlksylsKNJgsU7UomvmYa2ve0MCi8rF8YTlour11alJqNF9ehaiCQDMfnuWIR+r3atV4MCmGhdhDWg/Mh7mTm/jrrWly5XV51vU16tQ6xXGyfOQWBo+WKdYzXuMuJ56vyRkharu3w2ajk+VxcJ7xMazWc4TQrcsl0l93sbb6dnvkIajATneirpdvf2nfrUkakHvgMJqSl4fyh9J7CDQXYapgqiL9wmoc0xorXqWzEDqnaMr5Ibu6xL21ItWiNe84vx7kIOSA2ERUMEO4Mn291kGSkh/j62rMX1vZfGdoyeNRQNs9SkWbho9/zrYqU2OwfC1UBwhvxIFlSAzTnP09Z4YU3ANDPD6mkkcTEMpFlyhS2jzmb+IX/IOZYu2ytt1oWgz8z7lrs3mKtfS28j5bqVJa/fy98pmktCp/6s9AyvCRD183LUT8y1iIR/poGgzSMBoIQpfDLM+W5J6e1A45EhUoH98KvcTd82ve3jzW7G3itkyRcQCsFXPiVDyapl+3kICPwyudXcEBqAuDgtgFrGGmoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(9746002)(8676002)(54906003)(38100700002)(316002)(1076003)(5660300002)(2616005)(2906002)(9786002)(66946007)(508600001)(426003)(186003)(66476007)(83380400001)(66556008)(4326008)(26005)(6916009)(33656002)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rXgBNtYoIrefc0ZB2AWqln1s/G5BxNqUGlNPLXeQnxuB1Yvnl2mcTsybxZA6?=
 =?us-ascii?Q?6MFdEn7DVwQz+vPK2kUZrtfTKjj0yZOUMUlJyjK4LdRPiBVNL5oqfFVPHlKH?=
 =?us-ascii?Q?Sm8+HKLWO/uNOjlci2U6WvqaZuVpDSHdgUx/YjkHSTr07PBBlNaBjul1xRls?=
 =?us-ascii?Q?JxzVIMcdsITz/Rg3Y7/wuA7Ie6F6vP8KG+DUEqDHmSVyFc0a9sZVQ6vawgAx?=
 =?us-ascii?Q?xDevzDNrSqcVJwTPB+NAbII4rLgjoAStSVszpeA7asQi6Q2moNVBx600iv8/?=
 =?us-ascii?Q?Gyd06gx5lTUhLlHxrb9Fs4UmnpAV9+q6bR1YxeX15LzPj4OiNTdMqNbWbK0B?=
 =?us-ascii?Q?EzmUFEHm19lCsJRxhCwSoiwNYeoY2p9qrsElBk817rkutUexeQvtrOqNRqcj?=
 =?us-ascii?Q?i6b2LbKY2Z6Kks6XmCSBNhMziYzmSMa5OvbBoS8a1235GlmtSu6kQGYfwRBk?=
 =?us-ascii?Q?yj82eOaMr7NHRdvlJqtcwawB/OAmLdk3HHAYshv7kn1ANocNpeOKzhq9KizK?=
 =?us-ascii?Q?95IsZjsYeWjJuU6t5P/dQVcKDJ1y5kdB6i1ZQoLNWncUSEh/vmrH4oYDZ5M8?=
 =?us-ascii?Q?0cKuXiEq8x1n1pYH7Z+VTUhoWH4UwVi60dyHHslzLENloZ3qJ52ZhLOR2i4V?=
 =?us-ascii?Q?N2Vho/bAWgcKFWQFd2ekwjQeARJ1LCBMxZztb9vtEUey9E0huO/H9INMkszv?=
 =?us-ascii?Q?O2m0uxDb8fBKsaK4v5rUpkIW+xum+2gfdMBdTUDrgUx7X+H7SKNcALTvGHNu?=
 =?us-ascii?Q?9eHj5twuT64Oa5PS0Zn38ulWe/Dccjc3phGcOE8BHUwBhb96Hweeph4HtuL9?=
 =?us-ascii?Q?VGMB+bQSRI57NFknGuaEbt3zs4VKosPWy9zzudNpzdTIE2sos+KN19UqP6EH?=
 =?us-ascii?Q?sIdzBTNw0vGJtOJ07N+xplB+7j4hqV0677RrqnUyPa4PgaPXk6M+0BsViG+W?=
 =?us-ascii?Q?vYFZtV6ihFsTWPTzqatOHMue9eRz0EG0zZNpmidU8gASMnKYUOzumCsyx3NE?=
 =?us-ascii?Q?I82BmE5U3ZlFwgnfBYvdd8ygc17D5SFZJawMoO/mlZlghv1tCLGP1nc0vui/?=
 =?us-ascii?Q?cuCAeMEPlzSvXGos09XhEVCFzLUmjnHTrEXgurGOqlDhQJz33zCX6W/PSskN?=
 =?us-ascii?Q?x3eYQSs/0gAewZvsR09QeSgwDjJBH7T/ejMIU+hb8QUQTRT0KiLG29MNiIsY?=
 =?us-ascii?Q?lTfOfmV1bVDGbKRT6B5ORA8BNoDfcHL+yDsoW+uLxCIgHfPdWGhf6ruS1ltu?=
 =?us-ascii?Q?t53hf7k3NBFrR5n99OJPC8KjWJJAJVQggQAdUwQedgH7ahyHNcU8FwcqEaTv?=
 =?us-ascii?Q?raO4NAvzKGzin4XZrtDVPnJ4SCk2L2qldfoQdtiOWgfoMuKGzqGmJnYRMom9?=
 =?us-ascii?Q?cUk9ejLgB2zVUxszvSAPH9vKZdas0Ipjswdn80tszd0ocjRa0hRHlNSgYBLa?=
 =?us-ascii?Q?vswy+woTT5d3tgddwFUCrFqaB39F2nLJMXzxvmBe07qI1JSrEX+6bU7BXHtt?=
 =?us-ascii?Q?j9j8ga7Cg4/7Y/U8C3Yrqga22XNc+BF4AEhg/06OLvWRHQLdPcq5be8pNrQP?=
 =?us-ascii?Q?CO1dVAiSUb6Jxwo4kJ8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d658c5ab-d008-47f1-ccd3-08d9a2b616d2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 12:48:40.1213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBnkwSs2jfcgXUm4ZCcbuNvetO7PEOIheayf8EBnHhdG7fn2oTbFvfPedUPDIOda
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5378
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 08, 2021 at 02:47:19PM +0200, Leon Romanovsky wrote:
> On Mon, Nov 08, 2021 at 08:36:39AM -0400, Jason Gunthorpe wrote:
> > On Sun, Nov 07, 2021 at 08:40:47AM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > >> drivers/infiniband/core/nldev.c:2543:1: warning: unused function '__chk_RDMA_NL_NLDEV'
> > >    MODULE_ALIAS_RDMA_NETLINK(RDMA_NL_NLDEV, 5);
> > >    ^
> > > 
> > > Fixes: e3bf14bdc17a ("rdma: Autoload netlink client modules")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > >  include/rdma/rdma_netlink.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
> > > index 2758d9df71ee..c2a79aeee113 100644
> > > +++ b/include/rdma/rdma_netlink.h
> > > @@ -30,7 +30,7 @@ enum rdma_nl_flags {
> > >   * constant as well and the compiler checks they are the same.
> > >   */
> > >  #define MODULE_ALIAS_RDMA_NETLINK(_index, _val)                                \
> > > -	static inline void __chk_##_index(void)                                \
> > > +	static inline void __maybe_unused __chk_##_index(void)                 \
> > >  	{                                                                      \
> > >  		BUILD_BUG_ON(_index != _val);                                  \
> > >  	}                                                                      \
> > 
> > This is a compiler bug, static inline should never need maybe_unsed
> 
> I saw many examples like this in arch code.
> For example, commit 4ac214574d2d ("KVM: MMU: mark role_regs and role accessors as maybe unused")
> 
> It is better to fix and forget instead of trying to fix clang.

"Because clang reports warnings for unused inlines declared in a .c file,
mark both sets of accessors as __maybe_unused."

Yikes, what a thing to do.

Jason
