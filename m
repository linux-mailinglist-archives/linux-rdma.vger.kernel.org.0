Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1D6465C2
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 01:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLHASA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 19:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHAR7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 19:17:59 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B409860EBC
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 16:17:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWUnS2K3GKUjPhZOvpFngLQ7wjjFZPLNYQi+WiXex5ozB02yUZULqDBM1+VOaYfZ28sHRbeW7jVRimRUtEhkcgKWeYuQOXQXvl43XdOCESRBYsODIT7vVt6SE25DgWH7cw7c54xwlBVJYvWfU5Q8HCvsE8ZnLBluROD3UbpUPM5cy7Hwuu5X6zz4id+PG15151pE2LX8bl9wX1m3IOHMh46QbdQXxyV655vXDrEBvrs8DJ82Ljmk4H3R7ZXSv+UpB3yMAQDBjPnazBUySIy+9YuFTtCi9lGx+ssaP47nadVH8dONunqDVjZBBJlc/wOIfJ7U1NgrIj90GdFlICypPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T8p2DZP0iyInaKaoG8AdliRXni9ExqlJsP8U5v0vYI=;
 b=W90Zbs3HFBIN88F8nFs2fPBS4sMJPF8kIVvpMfw1J44wItQY+57GfZiU3H1koQQppgf7TzT1e4CQNaHpas2rhus3F4bRJxaaiI5If864D9pgRSlMjWri1VHcO2tnJhhU2GQYf4auG3+WjlgZ2x7zG6d2fcb4n5ZVGAGmOGPQzOGndWBDpb7tVxqNVwF5/9fbv1tgXJYOIHjOn3QvWNGxDRs9R6NrFJQjOcoTdsJ0mfBffUFXm6G7dpsHFXXAQCwcicCDlwuCSHTWWw5sML+mJrsuZqnHwvcujlpL+qKy2DPuenWKYMUASLT5u5YiEYSbhyNgcHuwW5MLHCBHVAeszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T8p2DZP0iyInaKaoG8AdliRXni9ExqlJsP8U5v0vYI=;
 b=fWkT6RELYwliknOvbXkOiEohmeI6uilsVgIu4QZgQh2UkuhLSA6xLHcsqMktDSaPRBgQljm9vbDrq2lV1SomgmP0cS62dC2B4in7yJYVdIpacKu4A0x14k87FNQwizctDJoba7s2ipuB+mHoZfdABsSmYck0c6kkXuC/qcRoGJF2u/xybs1NS2rnza7u5RoaXdlkof8pq808JsTSUYbifCzoBSIB5cAEvQhCG18QaAGtdLQWDja07xlA1uVDOihCMlXTJZTS7hM+VMokTphX5SYehhv0eU7l4zH3pW6SlRtxgyvbkPKPWRlq3fjeaGgu/kvQ37HDyGHm7BCG99LKIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 00:17:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 00:17:57 +0000
Date:   Wed, 7 Dec 2022 20:17:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Guralnik <michaelgur@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com
Subject: Re: [PATCH v2 rdma-next 3/6] RDMA/mlx5: Change the cache structure
 to RB-tree
Message-ID: <Y5EtM/JEzBStGWny@nvidia.com>
References: <20221207085752.82458-1-michaelgur@nvidia.com>
 <20221207085752.82458-4-michaelgur@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207085752.82458-4-michaelgur@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0033.prod.exchangelabs.com (2603:10b6:208:10c::46)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 6218ed43-2f29-4157-b164-08dad8b1a845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpWRF/Ux1x+ivR9D8Syqk/tu57D+ZEZplJqJ239qhZNZLM9vqNZRTrumndJXOXggN7YpNYrt+KX2WL07Qve9Y9WqNXPof0Lv+B5vqfIMwCRSbd0IzA6w6iuenf6DUieeBHpdOyUNIvfqanZbm/c/5jsHu76Wn9/mWUti/NSmSh4+3XA8rowl9io6+IEV3f94qnPdJb7Yt/Mr8Z3lat6gtXXA/HzuXHN1fFYlYU91TqmMYq3tX1tRjWOvR2//OBbjgPfV+cIvzh5uQTONbfiMy27v7euZKdF9Ukg1MQVNeoUOS/9Fab4HcUROCssJKHNc1rmAf0vjLjfeu2HWJOVfpBrg1D0KEhtzv3meOMTnMx8dzqza08GU/EC+OsY2pUov2X6yfC7rC7FWX7ruOQSSoPgFERN7+LJQPF3yJhgKnr++2W5EDb7qjbUVlOo/Jz0qYCkpXKwx5X9/G1umRCdodqhVKyvlasjYfySy6dR6UL5HVTWnC6kkgTm352Impn5BPv4DL7PRGg1l6hswSeMg4A4c9JPV/5VsjyWBAuAXxPHyYFStkgnnMr3NFUnhd6Gxg5I07qQb8PeM0UfMb0sVFddHkU44U7XAnvLOhG+sA39UvJ9bme4w1RiGFap9W3+Zyj5DhpZngdkXZqrU96bF2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(6486002)(8936002)(86362001)(2906002)(5660300002)(6862004)(41300700001)(4744005)(4326008)(107886003)(186003)(26005)(6506007)(478600001)(6512007)(37006003)(2616005)(66946007)(66556008)(8676002)(38100700002)(6636002)(66476007)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NNTDxdp4I1Tl6ydX07e7onkfd5WkW98XYpCfTGY4roMV+G0+AOKzvXWiCuwl?=
 =?us-ascii?Q?K4BVoHlRA9LdxnnFMpKkXPkh3MTg5RR3A1lYywpXL99lCb/fOMJLlc4sjzoQ?=
 =?us-ascii?Q?xPYyf1CRJhJcWrVgqmIhlAtadjp4USQcd3eBFnvQ9juqRU2XucAyrg4/82OB?=
 =?us-ascii?Q?Oq1L+U6Z6hDk0haEZLmzWEbtzE6Tbgce3ForX0ydINlo5nATzbFubpM4KLSu?=
 =?us-ascii?Q?z7bTnwcegky6E5AcKTIKkYLnCBCo5AVycByD5F+NMkyaS4xYUEUsLpAeSkN+?=
 =?us-ascii?Q?Vd6bIie7+7xr7SF58XQvOiYro3fbyj5HyMWer3IBmNfWMUqDbIr4Jfbz0UtR?=
 =?us-ascii?Q?l7QOqkVKCgDShkZE5YeOi80op7MrrEpm7EYtRh8Iv7GQOP7HM5u15bCxELkM?=
 =?us-ascii?Q?1HdX0bTGsVao0vVqTTGSw0lr4xjjLBsLyahXCK3+VUDKv6DdnVjPdRiiRYrH?=
 =?us-ascii?Q?Ij9liLJ8N0Wobl4q95NHRZ8ozPLsKjIvnG8t1GExndZu/iYo2msLfj/Tovvd?=
 =?us-ascii?Q?Dp1yd9HX9r7+l8+3OYW0YB4wylK6hh+kUiQ6Uwxj68ZybhrJYhOC04gkSlv8?=
 =?us-ascii?Q?2p/cGXrUstl60giyGK/t6U2PdSVPLgk9Zl5q889+hWUHhOcykjIt143odHRW?=
 =?us-ascii?Q?mKqmsCUOIDXADnx8MKiHNMUG+bpNWQKuz1MKVwQqtSThQcT/qDDVCnNXWQP+?=
 =?us-ascii?Q?ADGYK3AmaWGRcas4ZDDcZMDdxDw7idZ/aUUXNQI+pRXUhq5nvxq/YlqWaDzb?=
 =?us-ascii?Q?TmLBdoEoZiM9AKsim/eyhLUOE/7Wv2QP6fY6eipOcYi+aoO6L2F3LiNCfWn1?=
 =?us-ascii?Q?H+3+4P0gM12IK7sO+H5r8fzFr7djrxXtqUQ+fuyq5zZwO7tX9G/HTff6Rf9S?=
 =?us-ascii?Q?EuriYUX8HQ6ticMoojPkI9CDnuOxHFHqzUIxk79ICkW+aBhmPHJBEtOqGV5/?=
 =?us-ascii?Q?pc2wgs0Xu3Vo6BRVpnjuFsw1ZzVKD0GbV8DcDr4uYMBk6GRDVfDHyiXJqHB7?=
 =?us-ascii?Q?oWHE9AGmGeQMLI6Vej9qBVcuwU+HXZ5YBXrfIo8Ra1jQvRWkivh0oCcguJgN?=
 =?us-ascii?Q?SaujvUWFvRqFU5gvRBFU3ZdffYo9RfG/VSVUPO94ibaeEThQGq7gnS4rvcLE?=
 =?us-ascii?Q?CbjmjOCsTaugPO0CMdWyGkCCYb9BM+/N3rYp2LdV/SW1wyRiGzQgaqUZk9j0?=
 =?us-ascii?Q?4gpzec1ACLpWgT1WLTZVLO7S1NZCFRQbspKwtGiPEQScqAB/qbzjeEagmvWd?=
 =?us-ascii?Q?6PO0W0b7Z62tMz/zxNv/oVY6vggmChX5Jy0D7Eo80NR2oGgaEjmLUn60bm9z?=
 =?us-ascii?Q?opTVeqhTQzxozubac8tRXDMZ4qo9JPz1PlAA36HYtNeaoel45ijPLC+hDyOH?=
 =?us-ascii?Q?8QaeccrgDH1XNiFLfDmq79FvSFGoQNRmRKZtC3GakQCs8bcgqbSQ1Bg9Y+v8?=
 =?us-ascii?Q?ADiU0EqtA5VC9K6ePZJ23z8GYIMXiOUgelsgZxq+12HbuKHy88eKb1U8QKca?=
 =?us-ascii?Q?9X35CzaXeVYiLnfjzZW4bxAQFtkQ+6uzNhUwQ13t6lCptNLJSRiJC8nNw6zx?=
 =?us-ascii?Q?4UgvhYqvdIwGgJXT60c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6218ed43-2f29-4157-b164-08dad8b1a845
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 00:17:57.1390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3BnPWVnFNK54nmcDZnM4aM2bLNI6jlfTAGsg4/xRrDRmHxqBEy2WAs9TdsgWEYm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 07, 2022 at 10:57:49AM +0200, Michael Guralnik wrote:

> @@ -1362,7 +1369,7 @@ static inline int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev,
>  static inline void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev) {}
>  static inline int mlx5_ib_odp_init(void) { return 0; }
>  static inline void mlx5_ib_odp_cleanup(void)				    {}
> -static inline void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent) {}
> +void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent) {}

Why?

Jason
