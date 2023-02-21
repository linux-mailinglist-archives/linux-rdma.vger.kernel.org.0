Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A5B69E227
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Feb 2023 15:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbjBUOTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Feb 2023 09:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbjBUOTJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Feb 2023 09:19:09 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0D127D62
        for <linux-rdma@vger.kernel.org>; Tue, 21 Feb 2023 06:19:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJNLoQnTTEVa7q4sonb2BA+Dc0G04uXgz5nHc0y+y2L2qa6bwlSR5/H+LLmqPIUMKlJcJc5RO3WEYnhhMEBo9Rog1rVPkz8THlEz+PVi+PIIcGNkDzy2F/VYpECf4y7XLqmKKBI7dm4+fkbGXvQROZuzMJ5jFmDkNeQeHxRLHgSMKEDOiykselgOa4v9hN9MnO6/N4Sd39lFUOKbQp8iCnFGqFPisyBhBqgKiAEWcES6iZWUmLtd+mpJPrO/nfeHuPbg9YUwrTJhD2hA8UoDmBR5jXeifb0wPL9US2B/uXCY2F/5i2qwmYozPlhOfbihP16RJsU6m/vP7hpjw3qGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGkULyIwuuOt1SrL560ZWDZeSQgFY6CYP3qBIFI0kro=;
 b=CNA/3XBFwvoK1TDO10W54Geo6fJEcBN8nKt7JQreug+p7fiE7U4eOIFtzFm2dmFEq3wHVoPcoKc0w/Rs6gb0KDSlX+gma7lo7F0fF/bjawxiSEG8O7mip3uFTswqPLhqx5P0vq5dg1dqry8pmK2ZOgVAj7J+/D/OgkIIxFULiDosQgxTFskXQh5/06Z4J2PlL/SCYckWn/Y1ub8++F/vEbRCgFO/f7BlHLUa4NOXNp9TmMFGFXQnwWavTAq0O0uru+4acE+aRE9ycKH7eWhU2M7q3dRuuAblyM3zDjQ1vbi4rfJaQDU3xjsNccqupCVvyUzUFdfCmzDPgUnWa+xeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGkULyIwuuOt1SrL560ZWDZeSQgFY6CYP3qBIFI0kro=;
 b=I8GiID2IHxp6Vi3Lk+byEf7lTlwDq7eWiqCRItd3Q4iqlWQDfsiHNRZvejfgK8jEqkOMYwhhZBzK9xOr3cGeyTvelHRwt7XHYXxoC2YILZyziOAbhbWAy+SXSeXv5ajo6KGTJrIQq8XZfq2yIDIw72XlOJGI643P4YGfxW94rqLKLTBkbBRrpdHpm1sDOIcnjar+8JZbmNkA0f0Ld/NmrP8k76yK8MnXiRwb0qowttcVKCeScbs1ORBP/5JqRg9RFgqN2rGBZ/yoTUQpvKw+5MkkDky0ovKhcV1ioKDEF4quDunPsdGFNX5ObsEhXjVd/qjbJmCKxbr7EYf00hwKlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 14:19:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 14:19:04 +0000
Date:   Tue, 21 Feb 2023 10:19:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Margolin <mrgolin@amazon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
        matua@amazon.com, ynachum@amazon.com,
        Yehuda Yitschak <yehuday@amazon.com>
Subject: Re: [PATCH] RDMA/efa: Add data polling capability feature bit
Message-ID: <Y/TS1hBcscBxmM6u@nvidia.com>
References: <20230219081328.10419-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219081328.10419-1-mrgolin@amazon.com>
X-ClientProxiedBy: MN2PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:208:a8::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5f7eae-3e6b-4f93-6b99-08db141695d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tRH53XwWwUS+xx4y7Ru1ajyDOSQCuOQV5B5Mo1ke2JvPAnO/tKfT8UCx6IcZnE5IgFudOh1fpBJCYmGGrZ4kzP6SNpmjflUnyXYc++Vef+OF6U7MHkB+wkCt8ZZryPGBeN+6OKsoP61VtRHoZvpaOE8QkjXV82vUxqxuGQ15osMsNHJCvxA5OlGt13bU99noEy6KDtOUvgE+YR+6gxx5haUufs2573fuByKTn59aRGsHNQ5z532/kRhV7BQZzLky4lvSFY5FXzkEWFDasohs+jd3PmNktbY2xBYFRA27kMRj+uhNk5Pqk+8Qo8B+qGlL64GoyhDvFNzDv0xZmg/ca8s2/im21dK7K/t/vH1QfEbDK+LvZ1oZ28/BHYlV4QWp72hXCf8yZOEETODErgWb2l1CILuwXjZbAAALPhbi8N9CNkVAJ01mV1EAma/BAGgwozNlJy/0fUXd1sbpylwKL3+WDjzkhF+5PGbBX4a38G2J4Otm46MXhDMW9mHrQ+c/f508utAN7ixgMGBjCOdGE0XBcxS2ELwb8rWc4TPRqDC+lUygarWAFsbqMGXjfM1RHUTohm6126thqDTHSujByJvtddBbVsGByFnE+3dKhIFMi2VxLecuEZUxoNUazJZCOoHMiRygaoWlkcIliPpyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199018)(38100700002)(83380400001)(86362001)(2616005)(316002)(6916009)(8936002)(4326008)(5660300002)(4744005)(8676002)(36756003)(66556008)(6486002)(478600001)(41300700001)(66946007)(66476007)(2906002)(6506007)(6512007)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W5m+szDJUql4YU4+Cg09is8/m21fvHvLMk8/jR7V7vthWFoLcZ7XaxKXXmWi?=
 =?us-ascii?Q?Guf8eoEUPbpTjAdt4tZ5IrJzl/jWMg3ctMGtmUz8QIdhOxiJQeED5r7jF/Nt?=
 =?us-ascii?Q?xFjpjRkDt5rlsxAXBw+vrY91M7yw9TB+mikVdUCW8NYSLVZo6Os6Ux+RNEef?=
 =?us-ascii?Q?k54aXAPiiTAVzW3DjN0q7lTDLii9tSEsvBJoCo48xp9whH9yewIa4vgBOyHB?=
 =?us-ascii?Q?Uny7NdqU2GJRD25ncJnPCovjUwBPDVDzChM12fRF7Jg33UcLrh9QfDX8f1Fp?=
 =?us-ascii?Q?YbStrRnV37OcuI8HAspnbin11twu9AYxICZrGoACzjm59hOXivJcTrYonaYr?=
 =?us-ascii?Q?QkiZJ3UlWwLLhKtOTFuvdDGqAhZPwiMjiBqGEJYAiXx/3i1wWGwjc9HjADcC?=
 =?us-ascii?Q?RCCMBjVji5M+PVJqW02MlfV4V5yXKWpJYktccYoigqYu3oR4Wqdok7kPxOma?=
 =?us-ascii?Q?uhshi/aJE40Rhz7nD5ZlelQah63ZaAFPC1UQCSxDvWKY7oUMv136rAFsXvyB?=
 =?us-ascii?Q?h12jWjA3vGpUv3Mc+glIjR/KefJwrliXM8IFHVmGKOs5YqCqOoTWSt/3AsuF?=
 =?us-ascii?Q?2Eu+zX3lS5T4eIksE5Fjf7epB0yo9TBmwlA+9S6oNQ8iWlTmbIdkfY/+w0Qq?=
 =?us-ascii?Q?lwMYhAj3H+T/6cJE5u7G/8f3c62ACAZsL8/Z6fS0KteVAdQIANAwyJtrTHcu?=
 =?us-ascii?Q?JQze0TTMfr4fZniPtedOmKk9bHzkLzu+Qy2aQYdVn8+F20Ww8uIeT33bSWpY?=
 =?us-ascii?Q?VSnZHRhunxhkWBc7B9XPcIlGbZdr8Uy1AUfeOnQhyWKf3boihkKBoXgk1cdS?=
 =?us-ascii?Q?56SOfzYURXEnAx/u2mg2rs8+nAUkLHTZsW9l0ByXAc/7Hth+G6C78t45RLGO?=
 =?us-ascii?Q?4KHzOBd0apE9tYGdXxisZv6NFfZK1aXeXNB+D6MVxIJiSjMjuonnajaH+dqY?=
 =?us-ascii?Q?ADY/x+De3BLNe7S/87DLKYti6zKUprXikF653iWrmuUamwFyxogs3Xh9PBnX?=
 =?us-ascii?Q?C9Lig+2xgc7VmuWNa3lf06E88/uspBswNfGTYJKy20LXZ+yPVHkBjrD0+Scp?=
 =?us-ascii?Q?e+G6FLpcyAQ5mvlcZD7DiUHTF+LhAzQzA/fxLELy9UgPEx4mtB7T+bDEFGyU?=
 =?us-ascii?Q?iEiilTbNcNdNbEfofwLtZ/FqM3RQhxP3p9E8US8oSkD001mJlDnbfXz7S3Vs?=
 =?us-ascii?Q?vGwfEgtH7szlYYwshAxclL7DDsB/SIXVp4yXoNy+bwPrll7Af09Nj6mxvwDl?=
 =?us-ascii?Q?7cOvyE68J2MGOqroa4S+sWUjrY+MKC4ncBm+VB3TH1R6WfJYjN2SO1Kf6jrN?=
 =?us-ascii?Q?EBE2xjrQF2oukKchv4RlZM9QUWiJ7qfl7tFFmrIDyryODanz9KuGi7yhqRtq?=
 =?us-ascii?Q?2FfqeZTGBspgQEUkNQgpIazXj3eTRodHL5ov+LVeed0reohcnXiJFdkhsoIT?=
 =?us-ascii?Q?w0grlAcqLFPEQlPQVs3BAOmU+yKhvFuji/RJ3QtOTMe2kOk3XUpNc/NXgd6l?=
 =?us-ascii?Q?OxoSo3mhdeDIdf7gG+bRPvX/B00LNOFi9ZIqtcRBfYTkVcKAXQaRL63OZMEx?=
 =?us-ascii?Q?xJOZn+8rvxoeKRSNDeoIgWMlgaGWcd8RVDzE1QcD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5f7eae-3e6b-4f93-6b99-08db141695d1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 14:19:03.9985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XcCgwCFF+K2Ji/9oWlu43hTlDKPXr6lr7+p6zQKdbFLvzV+GeiCsnY/yI3BKGZTF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

For UAPI changed you need to open PRs on rdma-core github before it
can be reviewed.

Jason
