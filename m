Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED03F611798
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Oct 2022 18:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJ1Qf0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Oct 2022 12:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJ1QfH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Oct 2022 12:35:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A4A15822
        for <linux-rdma@vger.kernel.org>; Fri, 28 Oct 2022 09:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPcoyLpPNeF/yj3Lg+Urf27K4RaDy04jKQTw+OR8JC6LWdDqUOCZbzJg9f3H4e8S15x7VzPrQ3XDARoa2w6BAjGF07xQWE3TuOHucNGV9iezlr0fYtR+B9ya2mwi7Vh3/MwaaaytGH0OufEh6uXOphOL83ZR+ATnmXy5hyW57dFLpFuo6rqmN3PFb7ODQE+ThmlSJsUVeQQKGCIXsJfYe8HpNMn2NvcQ4D9TOTMSqbD0TIsbCJOD34VJxMer4iO2BNCzJUvip6nTFWdHRJeg/GNvKlkJBS5NrI1EwbRC36dT8lFpRZhffc4k04jB/T89yZ4hiaYddWeHoNohpAHL4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5MRCM83duh8i/KgOxm45eWI111wEZYtQ4dnBj2vIq8=;
 b=DwczftYTuDO9jAZ/7aic3Clz6EhrnVWjLNRz3bJAPgBudwjcvICO6cWiVo+pHCXWmqVyZk+9MN61FNufogwq4i+KDhMcJW5Mb+B3GnAvyrYQY98KH1iv8CzunAuNpeuhryGSPc/uZKteoD4q7+hNTi7Au4P9leieiGbYpbzjY8o/ck4Zq5FwWUZXSHqPUE9/5ZiU/8oMIPquDC5edvRsZ0SxJxcRrHfJ+or6UhpOfuyowaDnO+cTDGZA9IvMD2r10l0jXp+5vpulI2y6wHhqtQOEPMwG2+pRNIN5xXaNmCyjAVtO7Q5PSEYECl+PbKqsWkdtMDPzT88Nw2CRyMaoBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5MRCM83duh8i/KgOxm45eWI111wEZYtQ4dnBj2vIq8=;
 b=Fk6V1B5tq2AguLsbqSe0kjwZEahAdYLxM/6S5LUUrCndI0myGeWULo9zR8EjqyOJYlk1LzsIhLhY7bHiMuxtR9FFei13tjQgcjqm34nZ9oosXUo1n1HBSXrLfxOya9c40WHyFlc29733QVbh3IwpcDALWfv4OyfudeKLgGCvtTaNQjYEImVYpO34P7/cEze+8RfGYGXMiI5mJhDdXIR6WPIT15HhAAruab8R6AdDRAemVJ/fp264uBW/dPfBA0j/K3mLleO3c4VHzhhwLuEaF9YCjPB1YIk/iFMusWLgh/gPQlmVqZz3uUlXpvVRGXQ2yZ6dz/yv4NyZuQdBpFxc7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 16:34:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 16:34:58 +0000
Date:   Fri, 28 Oct 2022 13:34:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH rdma-next] RDMA/nldev: Fix section mismatch warning for
 nldev
Message-ID: <Y1wEsfU3pJo3ztXy@nvidia.com>
References: <50e3139ef8cbbff5db858a4916be309e012313b1.1666940305.git.leon@kernel.org>
 <Y1v8m0HliWscL6bT@nvidia.com>
 <Y1v/2ArL1wyaoB8S@unreal>
 <Y1wAFOfdSMEU6+kB@nvidia.com>
 <Y1wBGFHsAEgbMPhA@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wBGFHsAEgbMPhA@unreal>
X-ClientProxiedBy: BL1PR13CA0406.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: cc0c7abc-b82e-4a8a-c6cf-08dab9025a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+Etddwte9gpxOVvpy9RAC3jhGBaTi2tMo72vafPcPxBHtNSkx67+j2lE4jbaud26vHumxNWgrSkogAiN8swJ1/iiPEhSYLvWPUJY8TOTafJJCV57vopxhU2P+QwywX0XPLrDoWM7l9HPbHKqMM/lGWgfNh0Oi+bp0tasA8GRDDOTU/jndrLH42Ou2LGzcaSz8K7/Zng+4bBB0zTLVoY0I7XL/GoVqiWNT+B/GGI1FhTJD4Z6aU5joYobIm2msegVzC7uY8yG3jacNXKDoBs0MTMrzCS1qfxcroDhUXL2nsyFdyOiOvSLOSdDdy0aUrW581P/QyN8egJq/Ab4BGXbC9TBDPFD+x0Yawi2ccuDgfdYULWAVaEozE1mwemWWXek3aHVGhB/2Wt8Fc1L5Q1eMGv2JYl+mKqN2j150SM4y+Rr4YsDtSFDMqzYxW0LXURpSViNV/UHTqekZRU+k/9vt6CuNYjw33uLJLa4/iDkNPFsSdJODS3JeOWI4IXDSXfbbDGRogxngCXAYqoO2PHDgfTvR30R7ykF3iisBkn0MzthEKAqsaVRCR35WOONrWAiricUBINhvKrnLruIhpqNSuNo+9auZTWQPhOo0HY/Q4X/Xciu6Dn+mZN1M7HbEi7TykSEIKwX7nOeetB7zfu5RF5y+l1nrWxbOovnEUTkLiJzLfBz4egzoSo9N90E/FcfOGGbyDxlDhmZlFpz0w+eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(316002)(66556008)(6916009)(8936002)(2616005)(83380400001)(6512007)(6506007)(5660300002)(66476007)(26005)(66946007)(186003)(4326008)(41300700001)(8676002)(86362001)(2906002)(6486002)(36756003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0WdzIDQlSCUkmzaADbwSvECDej8/3uUzbqs3hY6YpOeMS5VPiRHPfR5NgFme?=
 =?us-ascii?Q?6uv72PbpsSNiT6aNpGIZ9yVxCSBA0gWGYXknNRtIWxbfKwwppawB2j5fAbVb?=
 =?us-ascii?Q?aY62GKgi2EtGyUeFAbo+0btfd+GVTeECDNPQgfpvVLU0+BCemWZhn8Rfyt6U?=
 =?us-ascii?Q?cIihPVpRrusoiRyG1jpc34XIHFZT3zvk98PajYW+LzyN39xFK2IvF5ONPYQs?=
 =?us-ascii?Q?Ssn8hRdJsmhEa3AMnoRdvMrkJ8bfV/8ApNpPod+XrvJLmB7PzY3d+N/l1jm9?=
 =?us-ascii?Q?nwR2ga6IY1B796fiwo1WtDdFws4oY7BseyN/N8MDhZW5ggvpE2LH3m/7B892?=
 =?us-ascii?Q?qioMJrdwnnMQo9fmygusJkF36Pt6rqtlObjlW2R6RHezMrr3+Jj39ha2x6GF?=
 =?us-ascii?Q?jPJXOZn4nsfyV8pEvT4Ivm2dgi3WQrRh30DM0VdMfeHtfaEPTq9EdwuHvq6R?=
 =?us-ascii?Q?PhCGdw9lqEI8cYTiSTeI8GqSxXfnScZaVtS7koA9kN2tinKKvuQL37DSxGEi?=
 =?us-ascii?Q?VdQJq8H0VbTANhuJ+35XsW0VORgkt2YZ1s8JGwRvCTUCFuTzPxLbXcaR7nYt?=
 =?us-ascii?Q?tlbqoraHQDvr7y9yk90+HrXTsxJHSzbkeKLKn1h4NJSazKO8UU/UQ4mORsaI?=
 =?us-ascii?Q?xv5R4mYYDNkxCHil74kEazwc+PbWQvz6kCYlV7dRVOj+MgIveC0WilI9HujZ?=
 =?us-ascii?Q?ehzeAAnR2a+REtZCzCwAv0uaX0bwmRsPaeQGyBOsTLiGx4015cbbuNzmdeOP?=
 =?us-ascii?Q?PM6aPnvNCSFPTNTgETTNUpOHlh4+UJLDwkrSlNgKFSZrP3CzAwVr4zE251IZ?=
 =?us-ascii?Q?fboDJ7C0Idc+5904IOCyazsyx2Af8SBCIWfGUs+d41o9yHLUhqvJAxg6vAsB?=
 =?us-ascii?Q?85N9YuS3z5vwIPKlkJTOC6+RygO5K8jnLz7+2KqkFIrojVkTNl5riachHHCj?=
 =?us-ascii?Q?Md8S3omN5+dnq6rDXy1nZpDc+e4xqANElbTJPF71AmrbnkHZOPPdCRfyCxEq?=
 =?us-ascii?Q?PvQDlB0BsYDOtBQRUaAex6e+ZUWcxzMESfJJpyxCTsBgMjhLrbt4C6VC8tGJ?=
 =?us-ascii?Q?A8x3yc/Asv+33KXie4kYqv22petdrggpOif9WqGeE636Iv8YPFQKdwA6rSIN?=
 =?us-ascii?Q?bojzTAYH7Qc56hjNiExXBltHaEbyPZsDw7duJ4pFXK2cpEcW0ttmE/fkn/9L?=
 =?us-ascii?Q?RFxWCt5okcd6LjATdfb913nqhxdoXxoWeLUnqbwrbWgcVxS1x4FHxpJLXfHc?=
 =?us-ascii?Q?Pr7pMTR70A/G07wfZfFZDvVOzGS1HmJhhAL7fc2gFj8J9h6WBSaC+/aK43HO?=
 =?us-ascii?Q?KeUBq3tBicj7VNvsvx2IpBAd2rqPUppDO4OZbBuF7eha5W87JEapoQAaCk95?=
 =?us-ascii?Q?+jp5ZWlxHrOtYJMXRLbvdvWxE11A1ygwI/TyH+ZpQk15KZFI2Kf3wyhSyw2K?=
 =?us-ascii?Q?9qcQbNf6+ul8ahO164FDmEus97JXEr1riOiLbjxlJV3dU4ypwOlzGK/92gBi?=
 =?us-ascii?Q?Tuq+IqutzHdM4tC90t9tyIVqDgvVC4pzNGTIRFapzPgKMk+FSZfGYlfn2PLX?=
 =?us-ascii?Q?xxPmt+M5vd7PJvyiTgw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0c7abc-b82e-4a8a-c6cf-08dab9025a73
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 16:34:58.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJMPLy35v/PVUVUGAKa94e7Mjqu0x9Ctv7jocTtEsI7YPb559vh2sOoyAqmDuX7J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 28, 2022 at 07:19:36PM +0300, Leon Romanovsky wrote:
> On Fri, Oct 28, 2022 at 01:15:16PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 28, 2022 at 07:14:16PM +0300, Leon Romanovsky wrote:
> > > On Fri, Oct 28, 2022 at 01:00:27PM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Oct 28, 2022 at 09:58:56AM +0300, Leon Romanovsky wrote:
> > > > > ppc64_defconfig) produced this warning:
> > > > > 
> > > > > WARNING: modpost: drivers/infiniband/core/ib_core.o: section mismatch in reference: .init_module (section: .init.text) -> .nldev_exit (section: .exit.text)
> > > > > 
> > > > > Fix it by removing __init/__exit markers as nldev is part of ib_core.ko
> > > > > and as such doesn't require any special notations for entry/exit functions.
> > > > 
> > > > This isn't what the problem is, the patch Stephen reported:
> > > > 
> > > > commit ad9394a3da33995dff828dbfd4540421e535bec9 (ko-rdma/for-rc)
> > > > Author: Chen Zhongjin <chenzhongjin@huawei.com>
> > > > Date:   Tue Oct 25 10:41:46 2022 +0800
> > > > 
> > > >     RDMA/core: Fix null-ptr-deref in ib_core_cleanup()
> > > > 
> > > > Adds a call to an __exit function from an __init function:
> > > > 
> > > > @@ -2815,10 +2815,18 @@ static int __init ib_core_init(void)
> > > > 
> > > > +err_parent:
> > > > +       rdma_nl_unregister(RDMA_NL_LS);
> > > > +       nldev_exit();
> > > > +       unregister_pernet_device(&rdma_dev_net_ops);
> > > > 
> > > > Which is not allowed
> > > > 
> > > > All that is required is to drop the __exit from nldev_exit, 
> > > 
> > > This is why I dropped both __exit and __init. I see no value in keeping
> > > __init, without __exit.
> > 
> > __init works just fine, it will cause the code to be unload after the
> > module registration is compelted
> 
> The code will be unloaded as part of ib_core unload. It is not different
> from any other function call in ib_core_init() which is marked as __init.

Huh?

Only things marked __init are discarded after module load

Jason
