Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF8611754
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 18:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJ1QQk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiJ1QP7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 12:15:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0F27D1C4
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 09:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg/IEzf0MrQPWNGQaS5y4hoLUQ3y6Z3Oo6l8Hg9wDfM6GhgJkmn30+amUEHv2pNlHdbBJTecazeJww4wLphu9ic99izL72U5Qpm7oXTUC82wTaJ4inR7QdkRJg3C89/XvFuI9CEoo1Pe8W6xHEhext0m3aBOe1emdF/R34+zwxf0clHZjhJWPdbW9t4x+fSXdRE8JpqbgQBsRRpw7hRYJ4CBo5g3mDSOtJKDmhMDMwMFfzuKBgd7xkS9tfuA7jftdixojNWGhcfp7Tn/bOc0QNBCMxlGkB1E1XudbqpkUnkx4zRDp07CpU0xMpINTMT7oZhmfTIUTyGRMbqDySZ15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPjbcosngNfdSiGNJxadU69iqsAt9kgfC9WrHoBvvzc=;
 b=EclmaUrskJOih/gHdE3DhPvLBMhzzR9nRhtZfN9OaPtqPMb8B4icXvbrHk3yLYhrWfvSrcb5S9Qo4XkPXqvN2CU1kQdT0/wBHzWxD4ZQ7e4H8DJ5cS+6kfHqGt7+C4HO/IS66dk5PSdQDiyb7BhVN6KT8WKmT8LcO8nBKKKK72Ty44j0A+RlRveYX1TpIuQqD1MuBc5ZTidDO8UwoNcd9SE/PBDjQyLil8nZgqNZ76zUoxdmi9kvnQ2BnB8Nx6AunICZn+2xNX10dyQ0biQo3JiszqZSoJD4bpv7acrUlr6C1MdTiEtX9Wxw9V7kYQEFJSMxHI6OCzssYlFDnsxdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPjbcosngNfdSiGNJxadU69iqsAt9kgfC9WrHoBvvzc=;
 b=iiOPyFRHd4ILFQhN76wXyJVsc68voJdLuvAAZsSthd8pg1ae1q096kCbOfi/LeP04B0aLbi6/hDhgyVX//xnY/nFXhZplRZX8zrx8KKrVCSlXZOlVYA9l4F4tX0uCXb4YFiIdAcVFtlQ8Le+H97wd+POgvdPutwo41CYOgYrr4//qH2MiRvkZK57fenlFkgFMPBs0apxle8n3LbSgT+FmundPEI76Z3pZpDi1T/bCJW7pe2bIh92cPdeSc4ALWphMzSKKnUhAimqZGQW5kPTJon972gjLZ8YKsRuyjwrh4wNVT6qplgk0sUsjyGABo3mpXBVewufOd+2KJKzJyQFiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Fri, 28 Oct 2022 16:15:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 16:15:17 +0000
Date:   Fri, 28 Oct 2022 13:15:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH rdma-next] RDMA/nldev: Fix section mismatch warning for
 nldev
Message-ID: <Y1wAFOfdSMEU6+kB@nvidia.com>
References: <50e3139ef8cbbff5db858a4916be309e012313b1.1666940305.git.leon@kernel.org>
 <Y1v8m0HliWscL6bT@nvidia.com>
 <Y1v/2ArL1wyaoB8S@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1v/2ArL1wyaoB8S@unreal>
X-ClientProxiedBy: MN2PR20CA0060.namprd20.prod.outlook.com
 (2603:10b6:208:235::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 2976242e-4fa6-4e96-08fc-08dab8ff9aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOzTa3UaeT4FBFcournS3d9mfqYFtpsgZUR0CsrwUxQfumSd6PS345A1Ot1rF7zquSPsb0ssI3v/RCylA2zenx81FfO9vQQZeAl9RaWV+ah6XVrreNpTO5SA67gj14mGAtI0j/VswPQ6FS0y52uWAQSKfh6cLGEYLOCVzA7Iw/90ybDlpMM+KrqImbGcA8lrVMB3WgxPbHDsiJyzTaJgi7Tces+vT3g0h8Fvb3lVAfABD9j3l9lBPSBWgULTT+DXs4ixJtlCVbsxrIowjxFDepagjzSHI8SoQ/NwEfYKjPVA245a5n4Vb68qwMIRJqGicjyYc8vPgkizLt25Y2chZCu1lh4Wl5znzUgJzA649ax2vQnbLL2S9UtwiMq+5guDaMLLdFb73aXe39Hi64/YSkgzlrNyeGieJ5Zhe5N6u4zx3/2TZh2tUSgAgZNk4yVlZg+2nvc4Edy32oh1XQdr3T6pwotEF8kuU5VuF8GhJx8ol5bYE75wf/qn1mQbqVmRTMY6cDPGDhiXV1QvaT+7cWhnvmRwW3wXkl47q/xVre9lezVrbg3kOGIwGHP//tCysP1FxhId6QEfbo4CS93l3/O/jFwZGjwtgMAuzpY4YxXfCd86nx+fT6Wcl8oA99JfgeQ5hSaKrRad+i2WDjfOgtFKwb6/8eFy5gYpILpysyk1F0aHDqnDV9OdX2M4bXbKVeE+wCb811HBEWgV1m3iftxEOaPFet7Z7vavyxPYoy24WFCqUOG5CZ3oxb/qKniW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(186003)(2616005)(316002)(26005)(41300700001)(6916009)(2906002)(66556008)(6506007)(83380400001)(66476007)(86362001)(8936002)(4326008)(36756003)(8676002)(66946007)(5660300002)(478600001)(6486002)(6512007)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jtEPRt2/l9RXH9pJxtKXFX4RXqg2WNVPpgLuCmUrg5R8WhnCU5FmrO3AQS3k?=
 =?us-ascii?Q?Ah6AtK3SCXaIZ+7RlOh+h70TU7tzlUFPXgDsmlgGbal0OH9d6asPjNSjX1IW?=
 =?us-ascii?Q?cnlPM8YlPJP4wD/joT8/4hGc96dDD2K7eSYl8UaG/mO06+qhyG9MFtSexA4K?=
 =?us-ascii?Q?RBuQvDqZOP367gKS3OiZn8U6VsTuAwRvNihK5Vk3WE7rvuUdv2ktOMoNVbaY?=
 =?us-ascii?Q?pAZAs2j+734H2ssdZsVuVysIpydGNfzLBpxz8+YG9kYWOPIeEdg/Y77Be3M9?=
 =?us-ascii?Q?aKlnS/FzQgvlZN09z+Q/nPbKiZAs09SXfWFKiERnAh/0RVmEdcl/DeAas7DC?=
 =?us-ascii?Q?ua7OLVxTSOKPL7hCpefFRAvXpAqZL5+L3wapHKTP9TAqxtRLpyLvn9m+l3Jt?=
 =?us-ascii?Q?IOKlCyi/11m0z+Z0p517TOIHM01A8HrX9sdI7Muh5JlRFNYMZbfgFo+qlh7t?=
 =?us-ascii?Q?DWj1x0YsMjM5ZBMYBtX8Ltyv1RvPqolyCD3cxd8ryjPobtcRinHwgOn4y4lY?=
 =?us-ascii?Q?DlQRE+HXspj4MsxJtPYRnfwCsZDE5qzr6IUBmHl5aVyUt7zOjvvXedha3Daa?=
 =?us-ascii?Q?/aHGWYbqE550eYDehIUOUewnOWP/VWlEGin4K6futh5l0uNKWrAgm5eU0u2l?=
 =?us-ascii?Q?qrW8lVgx3gJVuALyUI93STxIsmFK/BHoYvbbB0gnzIHYkNJMihuvS9UQysh+?=
 =?us-ascii?Q?vt6eXPIDHSth+jbYx63jTQ0veAmUblkvdJgRHQJAf6WQNAO3H541E7JWRyCi?=
 =?us-ascii?Q?OZuZbpnnE0s7gVVGjX5Um97pJDfgE2x3ZW0xzuPQTInF+vol4s635r9TM4xK?=
 =?us-ascii?Q?p1/bINFtalJluOBY7fHNIv5ZoHmO6Rb+ByozfFUTw1/3b05WlGsAoh2D6xBc?=
 =?us-ascii?Q?i70TNTxZYr8wB3zvUDKjMnjzePYlhYiOAJJiEngqqsBBhnrbc+aKmTzfyd5g?=
 =?us-ascii?Q?l5yUvYYPtNHB/1cDAIjtQo7yvx7EekHTjxCZ2W+TRh/3a4ZSP6lEYzozbd6m?=
 =?us-ascii?Q?cKY+VtBhePoXutVLyUbbB0Vray0WYJDK9RJZONXx0kNuvMeRwkR3l93yv/BF?=
 =?us-ascii?Q?9fhBjTPjfDODUr6GJgOpqAASnfXt/+49rfH5NVfD+ZwNov29UlaVJVFG69kI?=
 =?us-ascii?Q?IaVZyouTmzl0xhslhjLIvsgxIrHSI6stAm9ERlJwdsYTuUJj88djus8Jf+qI?=
 =?us-ascii?Q?sOEPrSXcjyOk6g6jKR2URNC/3djclOoTpwNDnAwGXbzcPM0vBxJheJcKHwsp?=
 =?us-ascii?Q?ycbVPKViMkr4atUTnglI39i5Dirpf6X42IazdrwYdBnl/Gs5hYTgsbqyOOZt?=
 =?us-ascii?Q?/K5Nb5WqexT5k13I4vEn/UxF28hp1CWPaeGpPVf5PMOouFBXuJe0xFIxpLJG?=
 =?us-ascii?Q?A34Md9ZsxX6yHAuXOcJP22hJ6i7uU86nPLoDXnRBdDYk1FDwiuJL6LFyOiiH?=
 =?us-ascii?Q?6CzaT2YmOuCNroYB5zh7Wumd5hw696l2MK/1XUPnq5luO5dOk3gEQpesIQ3g?=
 =?us-ascii?Q?qMP/PZPITwnErBsOnCm+WGPqO9T1FwjUCTCNzGqS/22wA0Zoz3y2dDTLbkdq?=
 =?us-ascii?Q?8T99IyPrwlSt6VFe6lo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2976242e-4fa6-4e96-08fc-08dab8ff9aa2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 16:15:17.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSULffVCYHCHV7ppUvb9hz/o+s3JDkZWbSZYOKumtbmhm1nG/QsPsyyHtUNNJBqA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 28, 2022 at 07:14:16PM +0300, Leon Romanovsky wrote:
> On Fri, Oct 28, 2022 at 01:00:27PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 28, 2022 at 09:58:56AM +0300, Leon Romanovsky wrote:
> > > ppc64_defconfig) produced this warning:
> > > 
> > > WARNING: modpost: drivers/infiniband/core/ib_core.o: section mismatch in reference: .init_module (section: .init.text) -> .nldev_exit (section: .exit.text)
> > > 
> > > Fix it by removing __init/__exit markers as nldev is part of ib_core.ko
> > > and as such doesn't require any special notations for entry/exit functions.
> > 
> > This isn't what the problem is, the patch Stephen reported:
> > 
> > commit ad9394a3da33995dff828dbfd4540421e535bec9 (ko-rdma/for-rc)
> > Author: Chen Zhongjin <chenzhongjin@huawei.com>
> > Date:   Tue Oct 25 10:41:46 2022 +0800
> > 
> >     RDMA/core: Fix null-ptr-deref in ib_core_cleanup()
> > 
> > Adds a call to an __exit function from an __init function:
> > 
> > @@ -2815,10 +2815,18 @@ static int __init ib_core_init(void)
> > 
> > +err_parent:
> > +       rdma_nl_unregister(RDMA_NL_LS);
> > +       nldev_exit();
> > +       unregister_pernet_device(&rdma_dev_net_ops);
> > 
> > Which is not allowed
> > 
> > All that is required is to drop the __exit from nldev_exit, 
> 
> This is why I dropped both __exit and __init. I see no value in keeping
> __init, without __exit.

__init works just fine, it will cause the code to be unload after the
module registration is compelted

__exit allows the code to be removed if the module is compiled in and
the __exit is never called

Jason
