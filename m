Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7EB36A887
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Apr 2021 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhDYRXj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 13:23:39 -0400
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:54912
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230329AbhDYRXi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 25 Apr 2021 13:23:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwxlFGAQs5gb2eEYfcnL1Qf7HGR7SBzQAq+fBhdc6K58R2uyAIvTRncfw8PY38YVI9RU+WxOoxbJ02VHoOPxwpb7RroNW2Vn0/VDzLxEGcw/ZN1BvVE08f1vGevqfK4UMp+0wKkhEzCj4LJNn2y+mQs/yVw2sYPwI7uUhF+lEN1KH7XO4SRe9g26wrr6w1IEbwABqOOJEBDBvB9tdybr6rdDkTe5HK7nOZ4/c16tGc73P055yQv4JfTJETk0Ioxh/r0POfBBOX7sr3E8rcxOKxFneHor/BipKrd5JmOV0qJZD/2Br6jHguJaf+G3yi0FjLBSbPsVcMG2XC/p3Uf2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JElsW93gvAxOS3sbWGSMB4tLTw89FJ0ITnQvqTcfBN8=;
 b=L5aj22np+iMQJVdWn+9R3MOFRtgVSKqNUypGjH9WGl5X3zHwR0DG4jTgQK3h7Hqwj6qteaXrM2VDqtMJMlrbS3/wZKXER+nOkZOgXPJ/Kr/KHVRCmjPqKLF/A5PCvv9SVLGhUP3ygsrT6gzMvnERAM7skKMK+QSxx4m4etfj38Jhq0z+bxCliCmrqW5iQEcQwRUmFN383j5I4FYotXsTfnqFYldjXHC1Z5C/xiR6rS3dI9F9AY9YHDuEpQVPVUqDHZjvOCG5uLAzXXQwLNydcAYYJkpOuTyY5lJfnumevMAlxSQKeqnORNsHOJqk6n6XsX4fVxFSmaX0QAASfDzFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JElsW93gvAxOS3sbWGSMB4tLTw89FJ0ITnQvqTcfBN8=;
 b=A2wPHWhj+5rcCT9Jsbk7ZkWkXGvl5t6ADfj9+HoU+1HKaOOMkc14Pc2qldR6IKF8/ZX8BlCk2dIutEJuvvrmPdGNnnVucp72Q6dDP0mQ45nkeORzmJrdBLHkhKRG4dFbnBozuQ4uWG44Sgybh0U7i5stLNjV6aENI7TUSBv2P4I9SgZN7RnwCf8RWh+TTTyx3m3b/bOvClAat7f+o3vvZBgTVF9+vV58Wx6npaF4lSEIp8/aTWJoeom2E2KK2VBhsOErTt79FWiiUCIXVtiP+ioY5v62S79J2zQuRoMXcoI87atI3OdjUbb3rK5KUQ0yUj3fmmVmghQBYvah0fEpZw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Sun, 25 Apr
 2021 17:22:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.026; Sun, 25 Apr 2021
 17:22:56 +0000
Date:   Sun, 25 Apr 2021 14:22:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <20210425172254.GO1370958@nvidia.com>
References: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
 <20210420123950.GA2138447@nvidia.com>
 <YH7Ru5ZSr1kWGZoa@unreal>
 <20210420152541.GC1370958@nvidia.com>
 <YH+yGj3cLuA5ga8s@unreal>
 <20210422142939.GA2407382@nvidia.com>
 <YIVosxurbZGlmCOw@unreal>
 <20210425130857.GN1370958@nvidia.com>
 <YIVyV2A0QhUXF+rw@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIVyV2A0QhUXF+rw@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:208:120::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR10CA0026.namprd10.prod.outlook.com (2603:10b6:208:120::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend Transport; Sun, 25 Apr 2021 17:22:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1laiT8-00CmXN-Lj; Sun, 25 Apr 2021 14:22:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0c5e942-b4f6-4c26-bc13-08d9080ec3e8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4268A99823BCE25BD4BE946FC2439@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VzIAvm8l9GNFAjEJMebBjElLvX7HOZaSIjM6oAuv7kF/zriGan6AHEvBtl+Q5fEyDHw1lLQKcfu7NWLbSPlYquQ8B1pNF9QEbYnaPnptExQKCfTNTjkDHtLMGESsFh7ytTlljE5/ZAOgy9QhFeCL/o5k86Gk8vgw/3KdpF3id1snwKgb+gAR/oNE62QQ/wGX9lsZRC3yVAGanl9PwvdJFbUwJhMNr3Cxq3fVVrhg93++Gng9ZcsWIxPvrllx4ekysabsmjNufgwo+v3oGbxiOSZcEGtEHdBPd3Oxwcybnid68wjjt5AoYUmmhPvq4NtKDYYj6LH4iGrwP/gkFDuGsddno/ut91W4yxh05Q9vsoaf3PhGbCvck2JDO7gthcXk7+gOeNP7XPkYKoTm37t2YbFXjgZzWvAW80uOrjm5BqXMFGgTTPoiLmSz0lBjJWLYyXPs+QORLLfaDZGRJ0jguOFcfwYZpt/+dzXBrl6M28HxBZJCuQAw8Ccu+JE1T/EuuoMccBUeSz4kL4NsO/7m6jn2hDEpY3dUXTAT6NkkwiLKc6lJqbWpoVqDrNJDMNM2q9cGLxHYeyOBMOdfHI1lc2m/jSfn1NbL5cPCKXV2e2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(186003)(426003)(478600001)(2906002)(36756003)(33656002)(2616005)(26005)(4744005)(5660300002)(8676002)(8936002)(86362001)(316002)(54906003)(66556008)(4326008)(9746002)(66476007)(9786002)(38100700002)(1076003)(83380400001)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rDandBNmxleUtnWa7GwXgjlow2Rh+W/VWjcJJLq2xq+5GA01NykKxpAg162M?=
 =?us-ascii?Q?IJfAy4mAfcUATqFuzwo+Qte+Rwc/dcNTvubSo7S2Hjy5IQQVeZpJfXLaaEES?=
 =?us-ascii?Q?p8Ouju3WHzcDvp7REv3mkO/qrLOIqn9doTK1WMAUD9wSXBUUyPllD/bAs5hc?=
 =?us-ascii?Q?RuA+I4xFPtjqhgFft8kIg7YSlivzfb5PjRHtS4eGJ2BKWbq5yFGxfz6BLzS/?=
 =?us-ascii?Q?QVCMZoUVOJt82YhwdniBg5HWV8bSJ5PlUcPl4kzEEOdakIsmgaLVZ8UJ8W9Q?=
 =?us-ascii?Q?ZWhmKtwtvO3DiD/BQfVDrBkWiEXNowzWRFo3u6zxGlr2zxt5w2MHSRUWrz7M?=
 =?us-ascii?Q?zkvExBy8YBSp74GWbzRDIAgXfieOOXSC8uV+qx3ifbVJ38b436Dj7M5OjxSH?=
 =?us-ascii?Q?Qe2EFvvOsmC7k3MtnBkfKeDoy4U/DWwC1JeHJbcP9Yi3qehIsjNkeO+EsCon?=
 =?us-ascii?Q?GDtZWyMvm1EoAzXBJPYb8BT0KTvgWvg6Bo1y15SjFBguAfukgIToRoa2aiPH?=
 =?us-ascii?Q?fLm5xD3eeYRkchqHeNNZIb/+b2xWo2I4dv8EZiQinjQHXRb1b9o/9hqSoRqB?=
 =?us-ascii?Q?h/0aZFPtbhlpLznPytQ+tiYzzCAaXjsHiPfB/SKRPCN9qaIeT3HXQ2+wzjN8?=
 =?us-ascii?Q?8NXqaKRNKT7Mo+bf4UtKoEHVPw/u3Z0xIGWCOnTSi8MCTw8vWHnFKZBDwxw3?=
 =?us-ascii?Q?Xd4RZfIJ6QcJvqpZiKQJZIOReRud5kqbXI5fD4HQsQewUHIpK5ES+u2tDRQL?=
 =?us-ascii?Q?VdhEi92osCUZOMbv2n3BrNA1HxAEggCm5ZXwJ27RckrVoDnGr/2LnaFZhy1V?=
 =?us-ascii?Q?eiUtbpacQZvMQ2aN3BUtVqxnEwxuMZQl9dNdMKPDy5NvGPOqpqet6dhU4OZC?=
 =?us-ascii?Q?rsckPJjN3hl+3vGUVcBIz8Hkrvi5HfAht2axfuIBLG5yqFNODySqDjbROMma?=
 =?us-ascii?Q?0zzT5gcXMUKFGPc9rzAS9xdcPlqQowU/eIvQz1146CzLyK6gEVG/OWaau4tX?=
 =?us-ascii?Q?e4pzWDBZe8PeQhDeLlcGYawQuOaJMgEnE8V1lmXi2vh/q4mqJAE4tYAXCBnR?=
 =?us-ascii?Q?A+CbzAOgZBcl/hwHxXCh+9Xj4m478ZlKY53LE0Q6hZgMWlHDy6Mo0Lr6EENN?=
 =?us-ascii?Q?y8F91fl/WWeu54q8dbkHu93zdJGNaEBr7ytTFamsSushYktlv5oAcVHgO+AU?=
 =?us-ascii?Q?DXTcP5jck2/8PuQ10USjz68V0OepbMoNIDTQW0TI0bkIX0/h62ZG8M2Y6mGN?=
 =?us-ascii?Q?9WTS26wkSIr98MzxlR2rXP8p4TqjNoP11zOQe0T5J+YyMz6bfYOeurH8iado?=
 =?us-ascii?Q?RJ+A7P6OhKHIY7EDqHVTeXj4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c5e942-b4f6-4c26-bc13-08d9080ec3e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2021 17:22:56.2817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5f5LcDsuKzS4g7MsKFpk9pUVQo1Tl55/V/YudgqCErQGp9hm48JIDhNk16OQCPbb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 25, 2021 at 04:44:55PM +0300, Leon Romanovsky wrote:
> > > The proposed prepare/abort/finish flow is much harder to implement correctly.
> > > Let's take as an example ib_destroy_qp_user(), we called to rdma_rw_cleanup_mrs(),
> > > but didn't restore them after .destroy_qp() failure.
> > 
> > I think it is a bug we call rdma_rw code in a a user path.
> 
> It was an example of a flow that wasn't restored properly. 
> The same goes for ib_dealloc_pd_user(), release of __internal_mr.
> 
> Of course, these flows shouldn't fail because of being kernel flows, but it is not clear
> from the code.

Well, exactly, user flows are not allowed to do extra stuff before
calling the driver destroy

So the arrangement I gave is reasonable and make sense, it is
certainly better than the hodge podge of ordering that we have today

Jason
