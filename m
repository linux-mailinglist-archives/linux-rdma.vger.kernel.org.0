Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAF477D306
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 21:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbjHOTJm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 15:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbjHOTJK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 15:09:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714CB1BD2
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 12:08:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur+Vxd1Ur11pr4bLENJkyfJY8HiJyqXJcinJmX9PQco9Vbis+BQqsp6jgMH3aBOt9LQsBYq2KsMtnqIBqN+/VNQVXSoiEsYmJOvk6kwGquz6rawiTiaT2aV+g0UHyWFDHobYeHdj/zehGN6GX67y1EJ3zvGCMlwrFGu89CpDiTOmUKpeXR9o/wmgvFeIDmMqpeCP08vZQdyNAf+T1YaY/Oyt359ym3PG+c0EPF3NrMzoLhMg6IhOE9zvXi4CmybYifyLdMbymf/Llzm/6YQMPYsbtKrYEcALpHHO6AQGVWcNJBqrOpqe8NhK6TDA7NcYVsesQadsiDzf/izbyux3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+dabASpgcJI3gwNJ4qiSXQvaKzE0kpkWq/9+xsoJ/s=;
 b=N2o5zJ/wOYa5pPz9r+4E2RU8lTnMQ1/AaPOZnLtiUQ+5rEtA0OovzcgknM3JhOtyDyc6j/+TiFZrX39XOAwFwJiiACdmwK+Lksuu3AXIXpnQOE5uXKCJORCDW8MjsjWsYHSmsWTrlwLnCqMXGboFMnd+hOPOwnDuIo4b4H4swwx/5v+LXrfBpFOheTnh/JrqiV5FhpMYiOBs4S9WFtBtqT9WSJwEU2OStI8F/ap4S4qIuaVoK2YizEZsdWCGXQWkupirxzvSmCcdIK8w+58Kq7XKB42E/TH5fh6qnzFAMc2cSKQEKVgPzjN7wFx6q2LG1ocqFCdNACYEKS7deOxe0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+dabASpgcJI3gwNJ4qiSXQvaKzE0kpkWq/9+xsoJ/s=;
 b=Sztbfr7XGB04FERSwo6Hg8EIpaJp0XEuOvEXVWbNA7NGG4ZJUmqlUx0DhD8MdeZnCIJPHuh/t+ui6C7/uXDpGk8Ok8WQuw49nj+o7b2aiv2dKBwct+rE8GupmHsbKc9fOqIM/zDad5U4W6VKpak6DYH+HXdqAHdkLwh1i8+uRhYEwGr5iy481ZvrnI31mKy6gDmk40flXpraLuAdFw0plF31LSmhwOcTSC1RjfOf9KHP3oUV+W987w5feFZGp/qU7zK0h1083MUqD9ssrYUA4eTTbv3ny6VRXJkoTBkmS/74G7raHxtuwKs4IKqQkVIrqIeHe6K+dSJwcEuQ+gtGzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYXPR12MB9319.namprd12.prod.outlook.com (2603:10b6:930:e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 19:08:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 19:08:16 +0000
Date:   Tue, 15 Aug 2023 16:08:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org, jhack@hpe.com
Subject: Re: [PATCH for-next v3 00/10] RDMA/rxe: Implement support for
 nonlinear packets
Message-ID: <ZNvNHVDDC55/n7LK@nvidia.com>
References: <20230727200128.65947-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727200128.65947-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYXPR12MB9319:EE_
X-MS-Office365-Filtering-Correlation-Id: b05cc23e-dabf-4205-66ef-08db9dc2fab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5v6HLimVcBgbmMowoyWbYY77V4l0Tgms2bJoieOrYv3gU2BaahY6rqNFxYTuX4hmy6Ect9BtLx2jo9oGPDY7A+t9HXegsvJVMtLrrcZwSVwba6es77EvPiAPJFTdUVK/zq6EboQGpkOcroYAyjJ4UFBkNQYWq3M4AZfMppDGvW6dxqJGYvcOl1C8+J/h3IPCC3Y84wPpJBdrbsK1RAlFFh+zcRFhvmEDEsi6pyW910neFcaRcx4wGIm+FP91qo5QzQfxw2RdLqBHYB2QeMhJ/j2donlkswkemYu6G2cDUb9tP2U2d/sf21dVPWdz6AGQTfmmgmk4C1OKkWnGDIrLBYWZO16L+dPWKJUdp+bAniTQirt8COow/DHbrYuQRFCm0Spab0/hWBamSbIKyuSPDHj7xiuv+wou4gEgVsy2g9cYg2aGIwW06fhi3CHqx9mTMfrUpfFnP7nA0865CyBYVN5PHwF/Sl3bC+VUPt0J0mobt5UocxmmR/ENF0s6Xo8gricaICX9gvJkV5RlebryOpzDzGUW/oBREQVnNgczfTKor9XfUw8UtytDGoKJ6Sc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199024)(1800799009)(186009)(5660300002)(4326008)(26005)(41300700001)(6916009)(66556008)(83380400001)(478600001)(8676002)(66946007)(86362001)(8936002)(2906002)(6486002)(2616005)(6666004)(6512007)(36756003)(6506007)(66476007)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WZqvxHYIh5QJfBUrVblKZBanI+jD5qXNnRJ+h3t8pfl+BzmJCptwtIu9IXwn?=
 =?us-ascii?Q?blPHOmYx7DWraJUlaLQcH0P4j7aYXzb8WwlhpIeX4fHdue/xKD51gWH7zNl4?=
 =?us-ascii?Q?4JdITG7PNy933bO7JnsOldVZRUK2M6eNc4nQOEiBCCVy4yTCYTyx8t+utgQv?=
 =?us-ascii?Q?2w6HJXxJLqWsdRDzcGZ2UuMma7ZQqWHpwk8IOkVdaSIOkHg2aYYathKVKruS?=
 =?us-ascii?Q?td8oVyBc/Xab3gF8uRMKYKZOtCQDihogcv1axj15TOY1ATAcFjlMIG7BaYGx?=
 =?us-ascii?Q?lT9hWqWLwYjYeFcgrTE9GOyt8OkSndMMdoNlHI3AxC8C7M6LiQddCrM3aZc5?=
 =?us-ascii?Q?OrUEou3QwrC9zejADeFtUWlTNRCuZ8inZn+9JNUQItrXZKQqDcLntzpL2kxR?=
 =?us-ascii?Q?kVveuHj75lvOtLzSY9N5/+8LZzgzpLYcOzAI9P1O3y3Em+t54Y6SkI7+yyZ2?=
 =?us-ascii?Q?0Y0mCBvA2FxQQbYaM9DqYP1MV5Wh2/uPUs3ozO8WNQZrqJuREvhevPStazux?=
 =?us-ascii?Q?tGA+7CS3z7+cRliDPboyPhv3YVTDdfXGZRoR8m3x99NWGejbguCoWOP9HYhB?=
 =?us-ascii?Q?ZXtrQgVAn+joS3x/uRxWae66rmth2SQLpGElkX80pHu0wkLryzFl3DcepnPz?=
 =?us-ascii?Q?MW8reRhBBodcRxpMFXQs8iVtKKq9v7j/5ZAQ8CBSGBeauvHj5/3JeOz0XHAh?=
 =?us-ascii?Q?6nCb1K4mObESmpGhImruyIGsOBM3MbSDhroG+v3431PidcTHrbhkyzpzfSuf?=
 =?us-ascii?Q?wlF/yLEkcogxWZcUboGY40dypsx4stZLR/tQxtd1vyp3F1+CWjq9pElSkMj+?=
 =?us-ascii?Q?yplbZbdHSkPlFO9oR8siLIbZ0Xrzp8Mf+12AhAFJ7m/dyEmaiY9SifVG8tap?=
 =?us-ascii?Q?0UuhWpO4dQ9ZGbQphbB+DJGAf38mdp878uRPy1tlJgWaAzkYdygG7dsDJW3l?=
 =?us-ascii?Q?UUtGrZWqvyHSxuh03RxBKu4lZdTdnKWsfkNToy1ZiipynuzzudAG+jsudyl6?=
 =?us-ascii?Q?P0bO73pUEn7njzhUspqkRS61NCO7MmbvawqhXJtu3c982QIrcfR4ADyrb6nh?=
 =?us-ascii?Q?xV1/tuQbJN7QO4BuFbckwBP0AmV58wyHIFeXWRJIGhKmCPpYWt4kpz7MPqWb?=
 =?us-ascii?Q?2u0naTTOWl0jhTrasQKy4fNHpsxVGDaPDDCK1mtl4JbvM8ljJ2vs3M7ig55S?=
 =?us-ascii?Q?aBUqPGhuDA+bzB213bDlDjwKn9k/X28OqYRfDPfJAfrJHFpKlwjqZy/ZeBr2?=
 =?us-ascii?Q?6+nYblfcB5Il6TAOsyMXIanaCMWaZkXpLyownMkhaN+Q/0HOvWNlzPb4GIlS?=
 =?us-ascii?Q?JLpxh1fNd0gf38QjnZVby2x2IDurHvhoqizx3HL1n01noW7a8JnHfn6XcS57?=
 =?us-ascii?Q?Wx1cbCgKio49CeJ0JGWJDlCniyzQE3ze3yzy5oYBLHTR7GveBTH5i6ADJaxX?=
 =?us-ascii?Q?uBO9r7NNWog9NHAZ7i31D9lxYPuGhOWe54aVgVFtz/xOjEIJZRnwVGHYd6MX?=
 =?us-ascii?Q?mPjq9eejpgLQ4cvCIvCR5/XdZ/604x00jXfFY+2N8Z7PoQ7FQKfWljHoVq71?=
 =?us-ascii?Q?2rWNIBNqfoK5ISDWiEQBdWKGPJNHbpjYT/ehEzbc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05cc23e-dabf-4205-66ef-08db9dc2fab6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 19:08:16.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOij6tCZPugcw5bHyXtOp/vrgP3hJjKywdxK1xCDBBjhZk4l7ry3P33jlm34UU3v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9319
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 27, 2023 at 03:01:19PM -0500, Bob Pearson wrote:
> This patch set is a revised version of an older set which implements 
> support for nonlinear or fragmented packets. This avoids extra copies
> in both the send and receive paths and gives significant performance
> improvement for large messages such as are used in storage applications.
> 
> This patch set has been heavily tested at large system scale and
> demonstrated a 2X improvement in file system read performance on
> a 200 Gb/sec network.
> 
> The patch set is rebased to the current for-next branch with the
> following previous patch sets applied:
> 	RDMA/rxe: Fix incomplete state save in rxe_requester
> 	RDMA/rxe: Misc fixes and cleanups
> 	Enable rcu locking of verbs objects
> 	RDMA/rxe: Misc cleanups
> 
> Bob Pearson (10):
>   RDMA/rxe: Add sg fragment ops
>   RDMA/rxe: Extend rxe_mr_copy to support skb frags
>   RDMA/rxe: Extend copy_data to support skb frags
>   RDMA/rxe: Extend rxe_init_packet() to support frags
>   RDMA/rxe: Extend rxe_icrc.c to support frags
>   RDMA/rxe: Extend rxe_init_req_packet() for frags
>   RDMA/rxe: Extend response packets for frags
>   RDMA/rxe: Extend send/write_data_in() for frags
>   RDMA/rxe: Extend do_read() in rxe_comp.c for frags
>   RDMA/rxe: Enable sg code in rxe

This does not apply to the tree so it will have to be rebased and
resent, it looked OK other than the module option question

Jason
