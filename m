Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D764383AEB
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 19:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbhEQRPH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 13:15:07 -0400
Received: from mail-bn1nam07on2068.outbound.protection.outlook.com ([40.107.212.68]:42977
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235848AbhEQRPH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 13:15:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gkke/LhEE5J/T5Gpzih3DQTC5DCNCQzyURC6xl3enGaRqAKIBQgT8kfi+STFkLiLM/kRUcNKpoWL7fXf5SXMUaHiX3xSdzTHAbNoa5ugajiTT8G5Jh6pEblG0OtDG+uva7ofkmOpkfTRmbQfYdNiHrD6bjvtLLWwKg4RfihiTzDkyYikMSNcI2K0VZ/N1xn+wi5Eiu9W2MNAlFLxrxY9STUHKhWFaFrg2RI9sLzNilT3JdOusheroOXYzzULB9+ow3eqvgqcM0ioYSDITHKEkRbKASW4zjLsujN1r4jzCxxbv/P60RFU8ysX/u2Fvtw8tmYg4lmwBe8aYDhQ8tIZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbsNSSF5rtxMVQ/295WFi/BKHc+v3aV1zcatKv6PrZQ=;
 b=aLlmf3+eYZZ5MD1v56qWJgJM4CpK7ZDchU0gNDTZJUf+N0+us1sCFuDQFCDDc3IBkEmdtufj+fIvHajLULu6vIMLBCmzAkCjUj9nU97Hag22Xusq8JAuAy8KZisoHPqR4gkQMFGSYRJpfjBrlKOelID2qoJiSla9XRFFthdPEi9jNWX3CBtWYOgq3yOhskvcoV3TC6I4thiPa+d22Ph+gDKWjnYdBsI5kheck+l5zcDO6irecKlAQGnLxLqpzxi3A6p0FNuFnz97NhgHFPKJ0eECM8ulzQF+R/isLC8Q3lXDIIc9FbB7fMflc1oIpJhRjTc1qEPv8K1TQBY++yzCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbsNSSF5rtxMVQ/295WFi/BKHc+v3aV1zcatKv6PrZQ=;
 b=j537ub7FaZCEQzVJkVYR8b7h68D2xm0iLUcWankzT82QJ8uFgIu7Mn6c1vqS4jjIpomJLNFBBa5HbCL5XqY2aG1MpgDAE2Lojrg82r2OdRg6Iju3O6W25F7eDQ57ZrAKxftELA64IzdJzp/veW07pkRk9/Y4g6nuMSbpORtI/7Ou6Di/qvPAh4EOad065MxYU4viZkgAw5s59Ggp0aNxfJBjbHLBbZQhL/5kM6lMgcnxKmBLy1jtFbIdsrwNXnE038LPPkuw+QY/bPcjszPBTtHdMYp7O/M+hSH0Qx33nHqrRx6bwHEK8jnUOiwUKu9H9ZbnHKfPR3BzmmxRcO0fvw==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2489.namprd12.prod.outlook.com (2603:10b6:3:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 17:13:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 17:13:49 +0000
Date:   Mon, 17 May 2021 14:13:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 11/13] RDMA/qib: Use attributes for the port sysfs
Message-ID: <20210517171347.GS1002214@nvidia.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <11-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <YKKj2Fx+9t0KnoGr@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKKj2Fx+9t0KnoGr@kroah.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR01CA0035.prod.exchangelabs.com (2603:10b6:208:71::48)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR01CA0035.prod.exchangelabs.com (2603:10b6:208:71::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 17:13:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ligoN-009P5d-Pe; Mon, 17 May 2021 14:13:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef10b7fc-2291-43fd-0be9-08d9195722f7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2489:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24898418CCB829471AF3281EC22D9@DM5PR1201MB2489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Z9ArOKTI0mVwsipE5uJb6Ld4Yi0m/vZpH7EBbXmkbopgtFzMVZBcH5NtCdPKS/fjBvq1kMUHOcMcD4g0UtdBqRjirEBr1b3rAkskY9TtPc0l2Jlou1Qr4ELuvTFiFtyfWbzRspvwcg578t2WnZSHZ94/aD1bCNP/I6yb3iFAZelHbtR4g/hnsUYPONdjNOPBEFlJZCfPFhoRIGz8DFuLohVbBHW0hvr6H6lJP7t88G1YRZKhIOzcs88eulB5qWOWpqrUXF7YrePytGeJ9oCRDRahXsGEtqgdWvSFDkJ03/8CXj7+cUT08LUpubVLYW0N3qLQO9BiUlYo+J47495bjxxdgbfdBthYIR3CJBPUseJsXAy+bufvFKL5bdROFHO8QiIXmx/bajfWoUhsPohdmOdJXm45WjJWAnc2Iadj9+wy2pW76jYnHq9RcfpgVpsn2uzg8GlLxpjqx/OFUT8qxU0QTiy7ysdvStx9anoXYJWrb4g33dku21begXXaiEgcE6GL+DXb7BpGpbIErs3B4s7v/ctI7zD4aFsZAnYB9cT08bSftuWSNU3XuZ3mxydcRzcSsU2hI7IWV+tHtQRRMSEvt59sXBN4QhtTuPGJeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(316002)(38100700002)(66946007)(5660300002)(1076003)(9746002)(4326008)(9786002)(54906003)(66556008)(26005)(478600001)(66476007)(8676002)(36756003)(2616005)(426003)(8936002)(6916009)(186003)(83380400001)(33656002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?xrE5GAP6xPd3hrZTqTp1BXmAtY7pkghG9ZZS2yWn5EFU8If030uTflac11N2?=
 =?us-ascii?Q?j0MRnSfqZWoq26Eq+T+k6QadeqgVycdeB0hU5/gEqqz5kZg9n2zx+Lz/6efW?=
 =?us-ascii?Q?OQlJgnNuf2JXtu3DW4t6rNlwre91yfXMVtSmNn5jdfLJzX48qWer5KY6KdMY?=
 =?us-ascii?Q?uf/5qvK7yFOWWD/v91D5niYudczEseImxOGBk2kRrjWb/MNDLMTZ72gGGQKM?=
 =?us-ascii?Q?llYuiJfDHQNI3Q5kKb9XdBBg0UJvA+yvDV0YxK2aXTuLzNbBBtWTTz0OXSkZ?=
 =?us-ascii?Q?+nKEOMFbDxs4TV3VsIds7WBGSfyGU3CJAmWyMCpnC//toLvpGq5KVaA7CnQq?=
 =?us-ascii?Q?6o3TLCOG+KmKXDUD5V/VQq/tEwDn/A6ZngHHtmdhyqMVINXmTfoljZeT5sV9?=
 =?us-ascii?Q?cuIMCG1es1+GSlmyCD60R1x/uORIYnvp1+zxaneyMae/3wmWA+N/4E7xWrFQ?=
 =?us-ascii?Q?GCIOihEHx7rNZk6JbBSEZdNby6rENCk69H+LCtcYXGWvdEMPAheARxoOTfp/?=
 =?us-ascii?Q?R6W+VL4LQWVPPH3EwFmISvQQSjs/j96l5b5XZkURXGSTjlyI7FkSZsFfe2yl?=
 =?us-ascii?Q?GpZqQe79gfSL2P30/juwHnIf1djvs8fnFqjjAvjDjeA1YzXxjeGHicLpeX3F?=
 =?us-ascii?Q?wxQUsnstxbpcsqpIcumVLxgDC4IyNI5oEN6oKBecfSFqG00obAe1+0fpU+mG?=
 =?us-ascii?Q?Pojfos+vb9l/+K0mC81Yebnz82vTsG9ZaCES8IdcN9eeKsWC7P9SP4HToyyI?=
 =?us-ascii?Q?/PyJq3pvH8JZiJ2mdWDU6kbP/hSu2Vy+2oJLoRFRb8j2RHf4Z15um1Ivt3ev?=
 =?us-ascii?Q?9nxYDiLUfuZdAFaEKcxgpJXTICG3WGqFHyIx1sP8VEtjE3irT5mR/y1+HwU2?=
 =?us-ascii?Q?/ESp0FaKBiHA6lnaYTCOXNhnjndNeXBLcRp7tmhMTvEw+iUvj9FWUYr/KbjH?=
 =?us-ascii?Q?6I3FQbHeUg2Xl3sX9pnyPb+U7H7/msZVzwzeM6Xna2LVTrp4DYJiPzToWK7L?=
 =?us-ascii?Q?ZruX/yIhZPZ2eFRDf1JIAp6QNaVh5Bso4ucE0tomi2UNuo7sqJf7C50EGmYO?=
 =?us-ascii?Q?TdSN4zC3FXUbWr/APFbUYDK5AZuC77yD8rXPe38bbwXsXzqxc3wcJtQXLbLM?=
 =?us-ascii?Q?7o5F2Dv27h9o+7IhcAOdIroFG7Jj6zg3qUvJgqh/oa5iC4mfrRYZylsl/fPU?=
 =?us-ascii?Q?LUCC3sfmdwSLzZEgn5gufduGY88gt3Q5/DwPJawZHeL32XR81ZX/FsEpnl22?=
 =?us-ascii?Q?9opn3FKw1ufef502piyJ13HTcd2LjOmTVEGuQRnKIQjCakjlgZt7wiC1249X?=
 =?us-ascii?Q?pJ5FHUqDngiqYJkgFxoPm7fK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef10b7fc-2291-43fd-0be9-08d9195722f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 17:13:49.0589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDdSBZE1K4m6egtSEEVbdUbywqdA19JOFV8cjrJfG/n8GRT4w2ydIFZR7PlwaUsH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2489
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 17, 2021 at 07:11:52PM +0200, Greg KH wrote:
> On Mon, May 17, 2021 at 01:47:39PM -0300, Jason Gunthorpe wrote:
> > qib should not be creating a mess of kobjects to attach to the port
> > kobject - this is all attributes. The proper API is to create an
> > attribute_group list and create it against the port's kobject.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >  drivers/infiniband/hw/qib/qib.h       |   5 +-
> >  drivers/infiniband/hw/qib/qib_sysfs.c | 596 +++++++++++---------------
> >  2 files changed, 248 insertions(+), 353 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
> > index 88497739029e02..3decd6d0843172 100644
> > +++ b/drivers/infiniband/hw/qib/qib.h
> > @@ -521,10 +521,7 @@ struct qib_pportdata {
> >  
> >  	struct qib_devdata *dd;
> >  	struct qib_chippport_specific *cpspec; /* chip-specific per-port */
> > -	struct kobject pport_kobj;
> > -	struct kobject pport_cc_kobj;
> > -	struct kobject sl2vl_kobj;
> > -	struct kobject diagc_kobj;
> > +	const struct attribute_group *groups[5];
> 
> As you initialize these all at once, why not just make this:
> 	struct attribute_group **groups;
> 
> and then set the groups up at build time instead of runtime as part of a
> larger structure like the ATTRIBUTE_GROUPS() macro does for "simple"
> drivers?  That way you aren't fixed at the array size here and someone
> has to go and check to verify you really have properly 0 terminated the
> list and set up the pointers properly.

qib has a variable list of group memberships that can only be
determined at runtime:

        if (qib_cc_table_size && ppd->congestion_entries_shadow)
                *cur_group++ = &port_ccmgta_attribute_group;

So it can't be setup statically at compile time.

hfi1 was transformed as you describe.

Thanks,
Jason
