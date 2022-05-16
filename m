Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92FC5286AB
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 16:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbiEPONh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 May 2022 10:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244463AbiEPONe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 May 2022 10:13:34 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E96B3B288
        for <linux-rdma@vger.kernel.org>; Mon, 16 May 2022 07:13:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIHCErTMiqznPYzJ1TPzVPmFaAJlD1s8TJNj9YpnmjddOKnAwWlTtGcX1hC4+H7oXpHsEKbCZod5afMaQzW4Y7z6hcHl5IfHdso5XFMsUNq4oqpXXrFQvhNJ/3MnG51hMz+ZGS7dm9cJd3IrTf/UY+KPhZgYvZzpOajN1AFOQMsIuLexYkEmXnyn4/5uwwbu+N+l4R9dV8rBMF4mPE3RoBqWGaQe668dlho5cSZZyjkaJuP95PnLLvAjGxRnny+2CVOrkE4xIfzk8M0K/WMzJoLmHJCVCTfhvqjIRaHuyztsw/I3LI1q3KELVg1RNrzdCO/3u6OC7hOgNgzEQ6PNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fxb5jQlojxgLn7eTBOu6eCTnNnMDCSpeFPUObCnb01E=;
 b=nxd9edYP2TzUFdRAZPqmFOn1CCF3T7yfO2JmTpNPC/tutka2mjle2MzgLrJ780Z6BCU++VzI27apbV8NkpOgB/TxIHJHkw/oOc3+vtmZGk7nv8VyGZSF5DQbmrU0HYEe430WioGf34ValXuH2PFAeBMumUxJidPjCcbR+BlMfbkHJi9Lxn4bbwgo4eB5wZW1uA+WnAl7CxHS9mWLgP47F4oGbwfuuwziGqW3ywItwz/uyLX4rvWlfRqEy+c7AHetSm41ixpXeAzptFp0ufVHi0g5meffXeKqeMudKcaBRZsCzlq6ELMZ7A0QVvI34eaKFaQoP7VyOCLIu+Tfy4CfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxb5jQlojxgLn7eTBOu6eCTnNnMDCSpeFPUObCnb01E=;
 b=BVH+FZmW0EKO+yllToT63+IvuC6oPU6rn2Ot4I0SWOP5xIMWbr0mwLdeQvOD9kI4vVBydB/BMhMDWqyc/jQNqnrPFSQJ5HRciuJk5jsM0MoW0euz2BaDkrXY/ppclxlCwJid+r9TBrR1mmlSBSxOc0aRh6dQvPYY+h6R2HR1K1O10ZipmyqhaIT6zYzsFtsElDLEOa97w8n3nd0VqeUf4YSzIdVEQlfgjH4KK8uLB1dMSeALBuTez6fmo4Ekunhye+OYVQyzNf0U66zRbAenV45wucWD3BRXhPOxaDRUzq5+KsZryHeSRbFiiOj8v+Z4KrkxRvBstXcikcuetz4HGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY5PR12MB6429.namprd12.prod.outlook.com (2603:10b6:930:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 14:13:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 14:13:21 +0000
Date:   Mon, 16 May 2022 11:13:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: Re: [PATCH for-next v7 00/12] Elastic RDMA Adapter (ERDMA) driver
Message-ID: <20220516141320.GY1343366@nvidia.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220510125038.GA1093446@nvidia.com>
 <d9376e3c-38cb-9c6e-1234-48d3ed08d78f@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9376e3c-38cb-9c6e-1234-48d3ed08d78f@linux.alibaba.com>
X-ClientProxiedBy: MN2PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:208:a8::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72b666b2-3319-4886-726a-08da37463b51
X-MS-TrafficTypeDiagnostic: CY5PR12MB6429:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB64296666AF3D12244C221C70C2CF9@CY5PR12MB6429.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vh1+0Ft1/pX/m6kK8EgC28Wla36khDJY/lsOVTlWZ8o9XuhVevYTB9jD6kXV7LoVTwqxmMgitxXL0Tklvry3G5NH9oGnIzl+kZ/07DMOF9xAWKzpnWJ2JsPzoqEqfIZnojn/DkKzpWR3YxMum/PBODD9OpV1WfHzhZAdjc/mCEBvCV9yFg9LqVIASaeZSEdg9bCwuaUODDlZwnzimrYdV1VUyBZ2TvVxLHdCjR6xnld3GQDn+PO8FXDx7FOP1D99IEbfra4fMmOyYIHOW8vB3bHtbfpEawWg9hS54TTII6J2w5BzVX4RafzMND7ZGWVYUJzXiHEYAlskI9i6Of4jt5q7P2R5070J170G8481pctXn8jHA3FhGxxdNe9RjzXEhz6SQw30gjob/uR2Dxr/pHhkgUOqzYxaimwArF+ZBQXaNox4n2+Z74MJumsn+f+ve6P5b3nxIu4iDqMlLxdXoAcmpgzyzYtEmeJR2CoQKRNx1cDBknJKzZibzpi4RrkDEQit8jdSptpBAjUrrzELuGZjAA+0xg+0IWYDRy+8AKPlSqM8xcpYZuJ+UFseePiyJMzsoYOShHAtWnrZ7arychK8jTzdvaz5BkMuwDEuWs6xPThe+s8oTULWy+D330TAM+s9ttXjGJnH+xvGFl+pXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(8676002)(66476007)(66556008)(186003)(1076003)(6916009)(4326008)(36756003)(508600001)(316002)(2616005)(33656002)(38100700002)(53546011)(2906002)(6506007)(6486002)(8936002)(86362001)(5660300002)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cmpxXS34wA/OVGvaDsyAy30g0jlUqOQ48InaP9ldTFsM7bZbibx15hczJJ+n?=
 =?us-ascii?Q?c07qhWPvDPwLEKUt0lyF/RcLVBz0qtlpToMn9+qs47rV5mGvljTmS12kI4L2?=
 =?us-ascii?Q?msDm4Us4xXJTBN0ZQ4y5ElmWQmvPIG3a55zZ37iciFDmzLqPkcZwyCg3WxDu?=
 =?us-ascii?Q?jE2CHKFzlnhk2t+Pp1WomBqnI2qR+jJxVLNnBB7GDlzl/AiAeWE19yE7vs/M?=
 =?us-ascii?Q?x8o66Avj9xp2mt4wOFb/9Q/vZwPCQPKyBdm+SB2nV6A4EmWUVNYqZkO0aKQt?=
 =?us-ascii?Q?mZNOpaR10ydr1qDOskVvtq9Bsgz2llvzssY56qSvZdQv2mJS1yg+1MnEg5Gc?=
 =?us-ascii?Q?G9YBTIOsrziEfMX8ALu26FFGtgH13+m7CvYAK5aVpQbXRI7Lj9xA7aeicoGA?=
 =?us-ascii?Q?XGhbtbRcNrRVPYKR9llWI+dVFdy9VRi0XlE/ecflMhCVUxW3fj0Afjf4bwxJ?=
 =?us-ascii?Q?pGMKTI9jegAUIQapLn+vNsJEiUlAksfE/hs+g2jkIgSwsrpfynzb2gUeDlaI?=
 =?us-ascii?Q?Ae09UNMJ0/9qHOTnMXC0e6FUs5zlqEcjxdonm1DBqic6nPQt3CZ8paHxKtPd?=
 =?us-ascii?Q?Oc5EQPXOCENL2P7PXG87KVapX6AcFYsvTyThg0Se5D3kWpTz2oQdEicRDG3o?=
 =?us-ascii?Q?G9jALNy6+0iReSkLGcdI76wpc/q/8teplucLotvu3J/U6Hety0m8lr21+u0W?=
 =?us-ascii?Q?9C9LsY/Yrg77/KDjL8s4b1J8m5ZIAR7lD0lnV+elEXw0xeiWQo9SODTjUsVc?=
 =?us-ascii?Q?zogI7Dq7+HZJbNaBbqUFkq78VbcDyVacdUp+1KLnwdMOLK5drofgj6TIHDA4?=
 =?us-ascii?Q?N1/ob3KMK9QQsSIWvxk6hkx+qriBaUldqUVqaCcDarVDlBZerwJCSeowREiL?=
 =?us-ascii?Q?aJRsr2UGOQGs/P2Lh+paX/HIzxfhK3DVYIbKPL5jKyXrIorhE2fyxuLzCPpx?=
 =?us-ascii?Q?jOfbJny2H7uDKD0KhCUrgUhwLpVfzTQyRnoKX9lUFaIYoTDF3BBja56oE0x+?=
 =?us-ascii?Q?Jjn2ta7sp2vqrRNcSJQ04KmBnEXzKcMJdm5ieHrxzCe3Y2eJBYjl16oQid91?=
 =?us-ascii?Q?ekJUxKnDnGOoIxptB34eXM4pGdY/uU4H4noKUIP8z1BJ8CzE4efuMDehb3mP?=
 =?us-ascii?Q?QUNgBzMs4kUGFCCjcJF30fSWTkgAKVV0uD8satW3o/jFHr09TtZVZxQWpW9w?=
 =?us-ascii?Q?4XoW5IHgLlOWCm9mx0+wUgAFbQ45TZDHpGct8AKOCXyMrrFvr8Rn5oEj77bT?=
 =?us-ascii?Q?nDIeOZH0iJGAHFiE0FktobUqcIEXBrpgFpQ9ISnR1KlpadLKyEPsIY0ss62n?=
 =?us-ascii?Q?HL9o4FGcpysXXGStYTvUeECuZvII1EIZ341ahruBWAti7ME0fh6eEurJ1CFL?=
 =?us-ascii?Q?3r83hY9G1L8QJTAJN8Jg1e53SvmERaYC1I9nN0HF9SjRFD+g4j8hD6IMKUkl?=
 =?us-ascii?Q?+0joQnj0bKEjgjv6msWfQmyj7DOfmvesaTpE0FGLZ1bx/7bYneKXLQFTK/i8?=
 =?us-ascii?Q?sy/ifD+e5XnCkv1xf1pWkMRF6W4gMUI03VnLvtZf14oIVbtV0ekR7ctJB/4L?=
 =?us-ascii?Q?Uuye+DRN2y+OM5YspbPBsobD5wAwCbw0njnDv4KGXIkRCK9gMtdDsMMn/1ka?=
 =?us-ascii?Q?8Ozil59ehFP74c53mK+i+7w5YJIfaBau/CBTettwcq5ZkQErZ99vnPL39of8?=
 =?us-ascii?Q?vYNbmP3O2m53p876N5sXwnSjWehkSSN3iqQvOJWjJlvCXBxTVm3URK1u9omB?=
 =?us-ascii?Q?29cVg88UXQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b666b2-3319-4886-726a-08da37463b51
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 14:13:21.0821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bW+2CmDQps2fhGc1T6gwn7wjAMdhALOMJUE3jZhAohnyOEIkpGb5FldtCBZJvs7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6429
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 16, 2022 at 10:30:08AM +0800, Cheng Xu wrote:
> 
> 
> On 5/10/22 8:50 PM, Jason Gunthorpe wrote:
> > On Thu, Apr 21, 2022 at 03:17:35PM +0800, Cheng Xu wrote:
> > > Hello all,
> > > 
> > > This v7 patch set introduces the Elastic RDMA Adapter (ERDMA) driver,
> > > which released in Apsara Conference 2021 by Alibaba. The PR of ERDMA
> > > userspace provider has already been created [1].
> > 
> > It doesn't compile:
> > 
> > ../drivers/infiniband/hw/erdma/erdma_verbs.c:291:8: error: no member named 'kernel_cap_flags' in 'struct ib_device_attr'
> >          attr->kernel_cap_flags = IBK_LOCAL_DMA_LKEY;
> >          ~~~~  ^
> > ../drivers/infiniband/hw/erdma/erdma_verbs.c:291:27: error: use of undeclared identifier 'IBK_LOCAL_DMA_LKEY'
> >          attr->kernel_cap_flags = IBK_LOCAL_DMA_LKEY;
> >                                   ^
> > 
> > Jason
> 
> This v7 patch set is based on the latest for-next branch. This
> change is introduced by (e945c653c, RDMA: Split kernel-only global device
> caps from uverbs device caps). Maybe you compile the patch set
> with for-rc?

Oh, Ok

Jason
