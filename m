Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5D6C5452
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 19:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCVS5V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 14:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjCVS5A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 14:57:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7C06B318
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 11:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGN/mjVzoVp20lAZZVw7UFmGuyTO1gQDmHACLFDrROfIzKbZVXYqIl/94z54OJqssY4Fey/Fym/WGATaDJHV+tQiaASnwYaDsAyCva4bS1trAnE3aUviudblXZl4Djhnxm1KxtVUWKmXhPk3ETwB3wj4BLb5Ddblrgx9qdTrB2+FNFeBB3QzA+CMh+5ZVtdcU0pzuUZyq0tWxAVFWohtIsO2Sw6iQD8Wrz4ci+CCbcisFUoPMK9fI6HgmqNIE0lZJsi3T+KTEDAPZqb7quKDGf7y6JAhHQuDZ0Mi5JH1sb/q3awDMuUDZUAp7RvW5ytrBvDjKfsO4qWrtIc468F3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRRXzi7PPY2lLakTPPXDKmljZlNL9ExqbyUt7ieOjl4=;
 b=VqK+D1iUQEsoG6+XUx9qCLjvi9XgDBVEQsP+Stwcjn19hYm5psySfKl3H7/DRaO90Dt9xn0axHf3Lqd//LuSi+nPb+CtkDXy6siHkY5sXzI+8F9rVG7D38patXzs8d8jFx301qNsdC6A8fAJYExrWGJNpv574uDnlTZA9IUFqgGnrGvAayPE6JoTFBsg7Uz30Low2Ebhy5ak1cO/udmuJf5X3eS1qUN4EElpVLvAFS//tkLFElW2yaaTETtSh305wqzKHa+k9AixcuLHA/SUz8cE5LvWfIceTMAeGMZBm/OmwQG+zxnNOy/WUiw/y3ChPFRZOainsRZxINqb1RmQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRRXzi7PPY2lLakTPPXDKmljZlNL9ExqbyUt7ieOjl4=;
 b=KTInjTApB/cMZupnQ+pUXRUdYw3kIPRryL8JNpmtvuTEW33PA4rSjJqeIoMsJncwFVLhoI3/FZcOtIOpUZau7LqabzDbD+zeyqwBwmFpTpxLIkp3rk/DXZvuYHKTKUs9faGBE/runmGZqOTSbZmLy0yfN8DlxgnixqpdWmORby2RFlOYZXAmEAmN225wKTfIucgntKB7v/uWa1xpfUG2yAExC3Q47cn/cBwkP7QBIpwlar9A+2mGazHOVj2OrmOwa0F3lbxS+jBqq0nJ4hxczXnepWhlq/kMobAKAusIDI4+9wnUvwpiPy/sBe2tYwvFnPUrO+g1QKSlrtG9ujMrUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 18:55:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 18:55:23 +0000
Date:   Wed, 22 Mar 2023 15:55:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Margolin <mrgolin@amazon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
        matua@amazon.com, ynachum@amazon.com,
        Yehuda Yitschak <yehuday@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Add data polling capability feature bit
Message-ID: <ZBtPGqvu9bf/4DQ3@nvidia.com>
References: <20230219081328.10419-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219081328.10419-1-mrgolin@amazon.com>
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 0985dcc0-978e-4c93-9580-08db2b06fe33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPzFjF3gDiaVdKpLx3tLuFCpZ+16V7AIjdchFsfBVYAIl+U8y6jgQJtWyrp1NvHZyz+HbQaRd8idegVRWvZlvUf0SDg/sWKVr9O/tg1qlGqfmIqf4UVL+RxfmH83NcSi3B0yYQJeQp/ZyADYvT0x1JF7qpUtTuQJZzh67YvjNVD9Sw8P6e3O2rE5v/1UTJmZfmVu3u4EYIBT4evqBjzM/xUCsqIhypYJyL2bheQgyiBWc1AM6CpfNdtTKdA5GhDpy5XyuxEAtfCFGuNCWMadcjAtUyHkYpjOgZkR1ccdcAsI9JTZlKpEgWwmbfjh/X6AfN+CS2CagFEQHQWE9n4qiEuugFvOChPZW/bw60euh+4eGzRLpVBUx5uUJGot1Gz+8lW2g3NfSmKo8Bih8YERBHr7MzFXA8B1nr7H9vKEwxniTwwe68e6o0DgQ+RWCPrRy9GiOA+HeHG445+Kkwlm4R0JxY/rck4KTpCcAz40MyLL8xSVwwB0qUjEztnZFqLYYaBLVVEywonFB4PLx/LBbpIFDvP+ceSJHcZBIylR69pyXeLv8SwsITLTuPwofHkAQ8ChnKUVw8yqhdm6AWvX2fxNC9YofCoCUF9YM3b2wHIcJo9nNiYxD5js29C12eN+folLt82fGn6imOf69lRwrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199018)(86362001)(6506007)(38100700002)(4326008)(66476007)(4744005)(6916009)(66556008)(36756003)(6512007)(5660300002)(8936002)(66946007)(2906002)(41300700001)(26005)(186003)(2616005)(478600001)(316002)(6486002)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBcMFKHgL7OZQjbcm+/ferEopvjibYMNebZTMc+Vbxob9unEebFotkRj4owe?=
 =?us-ascii?Q?tgqZBT3V4322OjLlBZOXcPLfhFVgoUNTz/bBnehnoCP1tqoPe88N6yLaUbWh?=
 =?us-ascii?Q?wYJ9d5pv054xV5eoZaHLGieLuKX3UWYKn0fmq5SPBvLH8hs4XtQzBcuDyLs1?=
 =?us-ascii?Q?kDl6oPKdSSytLLpx9qzEY8G2dQvZjeobSgz+UFRxkqUDuwKXaVL5BDST5l+/?=
 =?us-ascii?Q?+OKMGOdax8en+WfDVBg4hl0rBZAwD88ap+OKvSsWgMqyEuRAk3sS5Kgl0uFP?=
 =?us-ascii?Q?GZBX8pExVlMM6s+mrWwSb/R3EvA3GD4hevfIJlN58DqgbRVMtUozh9nWOIBQ?=
 =?us-ascii?Q?F6Zl8KlBaZV6QiulYn3yNrq1upfJptU2LeA9++dbQ3j80F7A1zzV0E81TDaq?=
 =?us-ascii?Q?AnuQBROxPEz27Q1bweggOeIP0AMjiS/3rq2pWpw0OE0b9TmAOZG6hkhcKnXm?=
 =?us-ascii?Q?jOUdYKQQDluiQ7ntSlChPeI35C1/TFpcoOkB8Z+WwB7R23dKxB4xl3OqbY4N?=
 =?us-ascii?Q?jpv+Vpu8Rq6biNaTGLivt+23DmLjP1lQhgmxSWtwoT3WtoXamplLdref8nue?=
 =?us-ascii?Q?FiqsVsFyoLdHL1BMHMmnByE71n9b5YuwlSKplHU6BHGvmZFJ+0hyv1bcEqJx?=
 =?us-ascii?Q?T9v3FF+mMh67mneqOLYd5wGq/pG5WJaekxO2mVUvoP0zuYyKCfE2ZMFsGzJv?=
 =?us-ascii?Q?dR/fwlGv11L7sNmKMWBmOCN7gPKI1uf0+Xt/N4vmbLsKZc5Ay2MKOvkDufu+?=
 =?us-ascii?Q?spNxlTQgyo5GdgcyRnxLHwgK4OAYPLE0RPS1jhvDyfh8Sqlt8CrmrxA6vuFE?=
 =?us-ascii?Q?2fRxwTJfTY7+ESV4QHoGxpT2+VS7Ew6xNkBK5ya9EJPB2YGUcX3x0QWiwpUV?=
 =?us-ascii?Q?Aq+7tyqjGQx4XbNa18Ljl1fzG6GJxeReDllnxOt7z1q1ZbC7ga0Kk8VtJ/CU?=
 =?us-ascii?Q?TPsfDCJZUz4HQ1zbhRrh7ySfipwfNrt73KgpCY4x0gKAiXUTYFm9Fy0P285q?=
 =?us-ascii?Q?sKAWFhFXrfjAC2+uPEx350h99ubIFDRqHvtddlbaPQUxS2/uJlfXrs20eh58?=
 =?us-ascii?Q?wANEn7wCIlEbkwW5yqfLLPs75P7O18rjO5cm7XVL1zRhhS3Wc/BAedG3L5c8?=
 =?us-ascii?Q?jAJe2U9FGq+YZVjsBN6ij/C3Nal+Yvx8SHRl9Naic+yX//NvHC/NYs8dZyTp?=
 =?us-ascii?Q?oyrmrlLCnk9d2Qp9zR+jciuW10VBTQjETcjeLKzlQxKZKulCrNvJ63x9Zuvd?=
 =?us-ascii?Q?mqUCmVgg7BxQp9PRhU6wtrFexpztbX3VrmaMgQxeXD9Zz8Q/CgNEcvHHmOul?=
 =?us-ascii?Q?JrjnfbTpn/5e3Y98ueZphIvmy0BvcLnHBmvjpnvELrvRkt09xd8OyeR+SzLS?=
 =?us-ascii?Q?eHtyDxZU5ep97vPlwKWuAigwQ0D7GD7dsiiLOCp5sQPiIa7B+kOnfup0fdx+?=
 =?us-ascii?Q?1LuxBdNrbgJ0qKZFo+jzlU/hg73a2kRtguFBOwJFRm/cyPjiOLjgxttSKrdH?=
 =?us-ascii?Q?UeUYDrNwdT5dtnM6tc94J7/FbmAXdshCbaJd7m82B5h3p6clDTVlyq3DWQhF?=
 =?us-ascii?Q?0NUIzFnHLTWD9+wSqfR2ZvaLlonjcMKVg1YvjmdP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0985dcc0-978e-4c93-9580-08db2b06fe33
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 18:55:23.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CscnH6MGr4JH0yZpF+EZRS3OBAQIV1diGuBgSDYCH5citdFC5Fi+zsrgZ59kLpd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 19, 2023 at 08:13:28AM +0000, Michael Margolin wrote:
> From: Yonatan Nachum <ynachum@amazon.com>
> 
> Add feature bit to existing device caps field. EFA supports data polling
> of 128 bytes blocks.
> 
> Reviewed-by: Yehuda Yitschak <yehuday@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 7 +++++--
>  drivers/infiniband/hw/efa/efa_verbs.c           | 5 ++++-
>  include/uapi/rdma/efa-abi.h                     | 3 ++-
>  3 files changed, 11 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
