Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA6E532C39
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbiEXObu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbiEXObs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 10:31:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678E13E3B;
        Tue, 24 May 2022 07:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKP/uL9vJm69t29ZK+tEyishPmFUX2MC8lc5ctbnKH6xmHZHYxgKnuVqRSRPY+kbXymYKJDzgrozWk4/xXO8FeH6xPqmf8IV6Q0pkYG9g//FYEw7mezq0g4XWzkarcKJVs83pJpmb/oDQgG+rnDTES6FLvWu5vxmmhkleZ5FyQ8mUPvYfPZISezbCOYkrBUFCbYc/RS4Xfnj3zC93oQ9Om5OnNtLEqhvDQ6aJNqogQ0rGiSViRDJLeh8NA7DHBQIMTc1LSQi1+nEuj8zCisQBzCnn/0+WVN6PrFXU6u6tShRpZ/dBedjjEHvIytS/++ZE268khgkhf0abwzkyIv9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aynC4StSFz06oDWicAERO5+/fY5atUA1T5gn0xmXWjw=;
 b=eBgehxhYizPADXkOnvNr8jzc52LxeuUtcoyf+DJ4UYrwVpXtqkza1rWPsDFevE7iD1zP68byiaLdDwT76gbON6gGyoEOXIsf1vOCOc+H2yQiMwpBqonWyP97+aK9zBSGvRjndeNlu6BIQQUMX3HmbBM/YEwHw5iKSVfcT2igoBnQpa5H84UjE/5cs4K10cjPLBHpz0NAfd372IKTAp9XuX/EoFEVWfW1aMwHcbDLaiBo3pXX4YgAaTDw/XnJHukbEhwZI2cCrPURzWFwIO7+xHlQ8KAXkwMCUPNQVWnY8CfEm2LTx5TtwEpu3TmveHjRonvrGbxN/6K06lBTi656Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aynC4StSFz06oDWicAERO5+/fY5atUA1T5gn0xmXWjw=;
 b=InZTdtw3E/wcxplILsW5kv7YvuknVXI7YicQChmL0RtGdo6YTW2vCAWMfNphS5zuCk1O8Inuq0UMSCay/aQv1aSmSdgXeHHDJlD0PYp6FM2bpvniBaL7D3YhLAgU8CbNVglkQ+GEpxQyFF19vxnfJmPwpkkVfoprL5SK0itsyPKeJ0kO74DsypjE5lvdLki25iCPRzYEXwfKDB4CPtrikvO5z7YqGdloZXuUpUkHMwLZwWs8AwoQGwDPVbhwtScdXNVLnTVz17ZW718wJjA/14cSmbcmDKjP63plTi2HDFO6UyXUcbDjCPUMX8EqCHGcVshprD0asq21r8eMtb0Fkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB4594.namprd12.prod.outlook.com (2603:10b6:408:a2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Tue, 24 May
 2022 14:31:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 14:31:42 +0000
Date:   Tue, 24 May 2022 11:31:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     kernel-janitors@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: fix typo in comment
Message-ID: <20220524143141.GE2679903@nvidia.com>
References: <20220521111145.81697-87-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-87-Julia.Lawall@inria.fr>
X-ClientProxiedBy: MN2PR19CA0045.namprd19.prod.outlook.com
 (2603:10b6:208:19b::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79de40e2-43c4-4c3a-2d1e-08da3d921f2d
X-MS-TrafficTypeDiagnostic: BN8PR12MB4594:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB459480FA0A47895A0B76CB0AC2D79@BN8PR12MB4594.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oe9bA8DzPtKA1CL6SXza9loKxEfyaJfzQfecAW6N5nVNDFTmsUwCgCWAAAt7F7qLXYKsKrSJDmTLpIfsyT0wFXIaYfi/DJEzMkTUo7pn7qmGe4J4ZSz7jVRfgRuLQh5QEEtkjC4oWv+v28IxGnF9tbJH8Oa1EEjzdYFg6nrPHKE5aTqq3n1bAcsaXMHrl5UftuSEJ1Q13JvLBbGQ0Eyl+v8ouSSNuqF3+vkwqKDhj3X3k5VxlawzABUI2kfxvDAR19RhBZPDtARDM3/GOOBDu3eASmFmOA2T3iWavv5amntvJbPF10HYgf2WHknPQKNKa3bjjYJfHcsg9t7m1i00Xu3HR5XRztpJW/A88gJbuuCafyAs5oHnJoBdzEplU3eK/3MNQUSmD+j2Hdj+qezUbWkTOXv1G55lzUZpoTLIiXfyYMyEglI43f0HLqOxYvZoxXttMAM/v4+kFncPL5tAnh4BABIWW66ryTifkzMsTVUzTdf07+UUV9iIZNt63q96QBJgA4NVKUtHhC6T5lSi+mY0F4BrEHH2U/GGY8m1lMyq8CQUMD2fI/yVfoiFwFpFCGxT/YhiXUmuB1mIKfMv0uqWYY0GO4ZWxogFBi10aFp4rW9Z97OENeac12wsGBRE6BbcUNYzftEdAh1E8z6cng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(6486002)(8936002)(86362001)(4744005)(4326008)(33656002)(38100700002)(2906002)(6916009)(83380400001)(8676002)(2616005)(316002)(1076003)(508600001)(186003)(6512007)(66476007)(66556008)(66946007)(6506007)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1VL/1WA2JZECNt/9xBRG9DIDWCghb+lRblcHPPOz1Xatl3jekQR/aP/nzzza?=
 =?us-ascii?Q?G0Amgf7fB6c4VJuo4bsl8Uumc992GLdFlGS418s6DmkQ9dvhpr9duw9cpcBp?=
 =?us-ascii?Q?qflPGHSA81IwaABlmnoCYllF+W2kdQVAKxiAP6+ydfugduLRD0T9Y6xV0cjz?=
 =?us-ascii?Q?Y0ReCA48NPlmersvjYTKCuzyxWQV/UYoeuvrdQGj4iGn75bXd6I72pxrWWGG?=
 =?us-ascii?Q?kUluSMIodBhQF/VOcYE7xLGR4+0Qju/1j5dyuyyCXTABu5gd9AjTHChZBHjI?=
 =?us-ascii?Q?fQdfhml9QoujU0V1Z4dmtfH8/59+jLcWp72honLyy1cgCk7SluDql+vvYVMO?=
 =?us-ascii?Q?eU4vv+wz5yX1X/hh/PrcC0Mwz4cYPxw4TTUP7khC77wDgZvPppMtpH0epvr/?=
 =?us-ascii?Q?N2WN5ZoRoA4CbFbQeEpfl4nkY12NK6LXMZ/v5HGbtjZ/MbRGUysrz7Y4N4gd?=
 =?us-ascii?Q?wPgBEg9cXL/LY5LRJXbrCz3t49Gr6UnPSBp80LpGfs7ywOpS7/UyKL561IY6?=
 =?us-ascii?Q?IKltZvo3em8uEYwQsGssWDA8GZ1fmeoP4szHLCp0y5Sm+uLrIgMAe9kLuwij?=
 =?us-ascii?Q?ZdfS3L0ygRt2xzTvtGo5g7lPLMc4bmxTMKzobkV2AN78okTEOmvKhLOupTGV?=
 =?us-ascii?Q?YHiu4m9WZ8d/IP8e6lhXsYiBUbVfYdQYch7B9p3UxAUbiUh0FI1dYypECKP9?=
 =?us-ascii?Q?2jMlZfEPo6QljTeLmEv234AeiwAr318dRAGocHFBz5J4e4cmxhAEpdeAC4uF?=
 =?us-ascii?Q?6cxFx2q97/oF4R4L4TOIOcVPe1uvcVXvwSWwMf78lEvUUb598ZCYUuN93TMW?=
 =?us-ascii?Q?gJV/oMEs1Au2Pj9q06RhiJylD1EhvzUNC3JvueIe0uL3lhhBg9LtcSteEfI0?=
 =?us-ascii?Q?PqjM1rT/+ggHpmppXa0ljkOuorW0J2FHR8P4hDX3rORa7Nomw+caJ5ciKrrJ?=
 =?us-ascii?Q?88MucFPTu0SZJM4CTS7ppBJtfCQce0PTReMm5UWeKUCSuiMi0YZnUw8RrxJM?=
 =?us-ascii?Q?da/P+5y+8f5r1op/OhTbz/UGYMUALKiCzyk2yFx01v0RwFsGAyPRWkVfTT1R?=
 =?us-ascii?Q?ZQSVofzZyz0wWYDTIAD8ZzRJs/71sG/ixXw9c+UPJ4X1lziUmTRxTndLg6E9?=
 =?us-ascii?Q?CJpKccNPtLqf4wAhqa0H/MW9RxqkdI7XfEiimrkodJTobvgeqI1elpMb6bze?=
 =?us-ascii?Q?7K39fhCkgVxx+9ZWSy6l870KD55Mvw0Dyg3f3KUTWYmvSIRvsWExj7Ezk61t?=
 =?us-ascii?Q?vumrGecOU1bJ/I5C6PHpc4AO6ZJIlqSsJ1eRf52cXBaFSE1VfxQGgnn6c3YZ?=
 =?us-ascii?Q?PsoNgOTQmye1aExYkgJ15H1XLbTcVRbRiyzjV6u/+qPTzm161ZT1+uRNQ7ht?=
 =?us-ascii?Q?Al24OPjZ/QSBD0NFz/QBcWjj9nqA5naOe2nmQ9dgwuOWn7oV+GGM2uuf5DFW?=
 =?us-ascii?Q?H1ZuWlP7TLEKYZ4JH69SXZrN8UrtSy5VQilADgQOMDLPYj3b5RKffvlHEkW7?=
 =?us-ascii?Q?OxJXCx13ukkSBW4XPYkGwyfx0hjS+OW6nVo2K9/s7QssV+DVrj7KydyZp4T2?=
 =?us-ascii?Q?NlP7/8PCv9XzvCn1JhfuN5dCBcXgazzqU1RoPxAijMZFLt3d2IJq8DUqeZt2?=
 =?us-ascii?Q?3HO8vveMChpbH5xHPYZwQNrQbOqzvM9gZX3jZp99+VAAW1p6NzszYDjfgGUw?=
 =?us-ascii?Q?AeBFmyEHhJoQgZEpLgI+ieobsdZEdw71ILFmF71y3Pqu6lrpXfUqpI2oFEKp?=
 =?us-ascii?Q?tBzGEMZHbA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79de40e2-43c4-4c3a-2d1e-08da3d921f2d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 14:31:42.5482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E97GxEdMk/tStOtGJSBITfEFy0HjiREM2MY/ROwxR6vLzbXmuUBFF9FzuskY2gZq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4594
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 21, 2022 at 01:11:37PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> ---
>  drivers/infiniband/core/umem_odp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
