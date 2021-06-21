Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97CF3AF9CE
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 01:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhFUXzQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 19:55:16 -0400
Received: from mail-mw2nam10on2063.outbound.protection.outlook.com ([40.107.94.63]:62625
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231486AbhFUXzO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 19:55:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtXvhDS9rLb/SZ5NQut5pCog0H5lBiGIZCKkI24QlgjxYa2fg2S06vbWGkSgO9UZzrXIeVnUoAR0E+taOUr1xOAwtldfXDGNcG0H7VJGi9D3+RgJhM69PkZmcJ43hjkTDzkz1RysCakJjGrd1ZJykZ2QFa4ig9IVRNHPaSzsT9fbjIfdAgrqaQYUJfcCXGzhHRklrciF0Jkb4mD8La/3KFVZa7Us7v3GBpbFzlH23avQFWz/PeLI0M6mQbuRQKnNd6LewPhfP4S034k83UM65x/gxY1m1H18blua0qA4m0Rlaxei2O3l5YtOL+ObyOGu2fdNZGDHQYCkyljfbkmUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok/71n32DD6kgr8B330SreuCjN7/gl28Y2fTUPERJcc=;
 b=HYtXATkjeEBstwV2+f3f10prm204hHFkkARcCAi/2knp+yUpNDdMxYWNuGufo/XggyCFfii2yC9lNieYUCGWslaQfULMRLoq2hDlgTxUEqUyJvWO1gOYShjhTfVYTOg8xqhNibQIgpYERWEX300uAcJQJ6gZ7Dxp6LkwY5XgR3Rc7to3zLru4GWllUGax4ooh+HJAzmB0HvHmr2SPGrKF+YAutD2Hm4NP1vJ/sMgrcrzl7Jn/uV2TSM+qLwdBqt05bNPQ+5t2Oz3XF0Lw5JzThgKz6bGQGvWVi6mq6U7oaIwpNzQd3EcodehXBRLE8oDdrNrukE0rfqUzBlp6/6DSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok/71n32DD6kgr8B330SreuCjN7/gl28Y2fTUPERJcc=;
 b=I8949blzvVXe52C107CJavmt0LbN+H34O/VOY6SXhzk7s90g4Z9Ipjm+LCYJmPjSzVPbDdUgObSPr2e2CEZV2i7K+NKOESWRo5kWHE8AegXMhCpEv3FBN900vOIsN8liD7tTHKhPkvFfIArhrysqK/fsVGC+8IeAHnagAbrmuzi49wjDOIqYLlILsSdbFhFxMcwV+o/9OU0xmab1dqZU0/Ew/dFKWz+58q87oRghr3wp7f2nc4iEUgGDtXcXLByxrmNHD2kJfu3iepjZdFwo6Chog2oGpVfYo12xmN9MXyOLOl0GeARFMh6bj4cY8pSeWl5SkEocsfEQYZxAQuxtDg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 23:52:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 23:52:58 +0000
Date:   Mon, 21 Jun 2021 20:52:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, haakon.bugge@oracle.com, leon@kernel.org
Subject: Re: [PATCH v5 for-next 0/3] IB/core: Obtaining subnet_prefix from
 cache in
Message-ID: <20210621235257.GB2374294@nvidia.com>
References: <20210616154509.1047-1-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616154509.1047-1-anand.a.khoje@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR19CA0027.namprd19.prod.outlook.com
 (2603:10b6:208:178::40) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR19CA0027.namprd19.prod.outlook.com (2603:10b6:208:178::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 23:52:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvTir-009xgE-Nq; Mon, 21 Jun 2021 20:52:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3872935a-5d3b-47a2-18ac-08d9350fb28f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5318:
X-Microsoft-Antispam-PRVS: <BL1PR12MB531810A458D1BC60D0926F95C20A9@BL1PR12MB5318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPf61WluXSA993OZmP4ZMg57pWO1FHg2PXHw0foLXy0at20/02gD6tJia2mZEquxp37iOsmIZNpbA5a9uJ7RnSANV/u6sq63GyCOSI0pQ3wfvSlLKr664m7kpGzr49b4c+we9R7hJpPMButfsTCs7PfYGQeEURgUqcXjRu+3OiVR7WHkj7Nr03eaaT2uctfFkjLdAjEq/Rzal5HthoeTpH6O6zXvBS1M2zlrkHH/2oeq2PYLRpsfwvQItr8lFaOMEoQ0Yy7jLKIl0igKke41wUFBPX6Hiav36zWUGDK3dhZnYq+jN6Sm9Khjx9jbB6u33g6X/dG6N28k/8pgEo721xRsy49YSmT60is7jiVAeczNcj8LPrHKMGenCqWsC9T4sr9/pukFR5Ybi/Db4rzJSdj/Z9IlVsNc1Cd2NWhXd6bZnW/Wuhjsws1qyLdVcmtSjmL9iYO6rHzWqxfufqa8FXnU17qeT9VD8nqbkcfKLy1Io2X/rphJqGGFACnIL0vMdBwMt4re0dO3icDiZI0vnCVWE/sN6iYTc21uAMHfxZcqE9ho0q0DMiFz57npuR28uL1kRPWbnaE1JPIo7N6Pm7pzi+UPWTB8SthD1Gbd6XQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(6916009)(426003)(36756003)(8676002)(1076003)(316002)(2616005)(33656002)(83380400001)(66946007)(66476007)(478600001)(8936002)(38100700002)(9786002)(186003)(9746002)(86362001)(5660300002)(66556008)(4326008)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tv4Yn0zyoTwomAicMWt9nHn894/EW2i58uXKFY7ZIqfRFY/6NnZ2P9Ic5XFO?=
 =?us-ascii?Q?sNOg1sLxQIyJJ4+Z952HV1ZhC4Dg9Zr6zxkG0wMJPBMljar8eEDf9gPhvycK?=
 =?us-ascii?Q?UMAlrZSFqh3T2bM+1BNqaOw66HwMXtW882jE9TT23NtIFboyVA+wH7c/DCs0?=
 =?us-ascii?Q?cCgZvlCY8WGf/0QTvNWFb5xdo96VBr9SRQEnb1kmNkhEQ305eFBI94SvGGHT?=
 =?us-ascii?Q?E3i3urG+j+gTJeT9vlp5P8QjozjS1bqEl0CQ3IY6BSY2EVTtDByDp74wHeND?=
 =?us-ascii?Q?O2gR/mSxqE2fJu/FcPp0mrAmID22Jfofc7LCLgiOfs2/HOdxqm8OqIsn6DZ2?=
 =?us-ascii?Q?GbFuDDICT8npgmZ2zG9Lx+udX+yG6L1aZnlnoqrQmZqBAuiAzp7rF7yGwdvT?=
 =?us-ascii?Q?+ctahEa4xJwsC+XLzrFiebRhB8rRTOweSOCmdAldRGYVonE276HyeH3V3WO4?=
 =?us-ascii?Q?BFwp1awmrxXLJEKCAEO4l/zgb0FlE3FTbeU4rUj76GBkmgZrelafWxfrY+YU?=
 =?us-ascii?Q?eIv1s1CeBUXK8PsorqPnUlF4qRiei6wCP2JfYiBw/BQMPgRV+4LaCoGLfocQ?=
 =?us-ascii?Q?5AO7V1sVPWSZPIZiZVK9S3zHAb5yGIVualgHEowAvzhns+2Rrzvzdgrjf1Lm?=
 =?us-ascii?Q?8n8N20IJzsqBu6wqiFoy+mU4OPCoDptGs0qan5can2T6U7selrTSO5jBXUou?=
 =?us-ascii?Q?AGUneA9RVXZ2VyL6Oj90Xmh9e6umFaw8EvL9RTouJ6TR1xlnWDMgzJfZ7qqq?=
 =?us-ascii?Q?AlMwIWZI3oGf0OM4v8I0CUCSmWMB+lS0W4wNzNaYJ770YXrUHh+VAk6xsvZA?=
 =?us-ascii?Q?GzMPa3t9Dvr/fY/WiPvC8Xmf8+hnIB+9Nw3vJ89E+H7JPBJTgWg13ZYgGlvU?=
 =?us-ascii?Q?4BMJ5HGQk2E42baweNm/Fq+MXFbisRITR671UTrQc7cGCtEP89oAvkvTZt0y?=
 =?us-ascii?Q?QgPvrl4yscAaFkxPtb3LY2zqxdeo3ovzRU0PPrBmFnXQyYMMC3sPa9z1FdmY?=
 =?us-ascii?Q?ZWKLc2grI7jGMNSYXJ5pZhhdv1CkTHvNCVMDwkvQenAvTBOBoWZjx5JPA9Oz?=
 =?us-ascii?Q?vqO7RtZW5i/wxwd8oTulUX+DxMeX0+ay6K2ILVOaCQ4EEbZVKvh6SNcD46cV?=
 =?us-ascii?Q?TsUbHsKlGOwXgmCK4yGUgClQzFSbt+4b8+pYN3dCwQXiXgq5HRsf3Z3nDfcW?=
 =?us-ascii?Q?JefJCmzPpRE/hTgRnwl8Qg5YvgwP+GfXq4Oy6agGNnu6qhsYa+EDkej7AkRg?=
 =?us-ascii?Q?TfV+bK3uCOQ0eWQDCN/yju5mibHp4ni7d4blYvf9C6qVsXN9GSgTtqXBD6Rd?=
 =?us-ascii?Q?QhAk6WDLAv+o89pHDmGzOcXY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3872935a-5d3b-47a2-18ac-08d9350fb28f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 23:52:58.7593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWwyyWzCbyk/xEC5jeVDfEZMk3XBFwYshRx+JYxTc4G1yimr0j21Gtx9bHw2AwVp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 16, 2021 at 09:15:06PM +0530, Anand Khoje wrote:
> This v5 patch series is used to read the port_attribute subnet_prefix
> from a valid cache entry instead of having to call
> device->ops.query_gid() in Infiniband link-layer devices. This requires
> addition of a flag used to check that the cache entry is initialized and
> that a valid value is being read.
> 
> 1. Removed the port validity check from ib_get_cached_subnet_prefix.
> This check was not useful as the port_num is always valid.
> 
> 2. Shuffled locks pkey_lost_lock and netdev_lock in struct ib_port_data.
> This was done as output of pahole showed two 4-byte holes in the
> structure ib_port_data after pkey_list_lock and netdev_lock. Moving
> netdev_lock shaved off 8 bytes from the structure.
> 
> 3. Added a flag to struct ib_port_data. This is used to validate the
> status of cached subnet_prefix. This valid cache entry of subnet_prefix
> is used in function __ib_query_port().
> This allows the utilization of the cache entry and hence avoids a call
> into device->ops.query_gid(). We also ensure that in the event of a
> cache update, the value for subnet_prefix gets read from the newly updated
> GID cache and not via ib_query_port(), so that we do not end up reading a
> stale cache value.
> 
> Anand Khoje (3):
>   IB/core: Removed port validity check from ib_get_cached_subnet_prefix
>   IB/core: Shuffle locks in ib_port_data to save memory

I took these two, thanks

Jason
