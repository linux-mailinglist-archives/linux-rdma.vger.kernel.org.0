Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187C0683009
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Jan 2023 15:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjAaO7h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 09:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjAaO66 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 09:58:58 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B66A5D
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 06:58:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCGA1JxNhVv//Wm4tTT03yCbtX0uKueoJGrh1moXJgeBoIPmaklCvgO/7lY38UarXhCRYy5cpF1kBRxlcnzVVKSNwXQi70qYBfTz/Ap2S53MdFtjvUvVxmPcCu11x7QlfT8otivwhRESeXKnNUzDeJOepqX2tqPKjxY6BAI0GUKHvKsRZ2skP3UOg0VQzKJayxo2XmCwDsdBAfQMyJWyVfGeA9WvHS+wbHfQEZDrgOV3S/jDUaEjZZww/2Xwsb9EXRmks+5bWIOuCFzEt9FabJ3B/v1F7ZXVwreBxY7tap9KaH+gPIJiHYWUZuiSz/uedkJ3CkRO1L6PFp07LmzzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrRHENwCeNKy4fkvNG93kjO5msQxLo1PIzuPpTeu0II=;
 b=RmXxUdYreccvBynfBYWBYatUca6LcKpig6xKu52eYYfqhI33IIDSp7YV47pNZjrQBRawoBFG2elqdGRbSneCH2UF4x86QnXtn8VzBDMKTkPQ4LDAP0rl82N5hlipW1/iG01MYuEc43Feg+iD5LsJVrpWmFlSVvBazTQxE+I7QMF/iUVtAaOQgyD4yizdlUkdUfrPqXsyLJ8vzfg/v0LCivQ/thN3MU9Tp3563+MWraNiKGCxXL61zfMwAmLRVVDd8r3MqpgmdU4kLuyi8xb4PFMT7nC6ed3eVZ5qtCwd+dP37e5p7t8INFCykpmvBpkoaogq/gczHhOLP7VVXhNP0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrRHENwCeNKy4fkvNG93kjO5msQxLo1PIzuPpTeu0II=;
 b=Kqt83dbc3THvi59rJ3pYhzynOXhdAH1iWQ/FGTynTJYtJkoF5GHp+kSsmiPyo39oCBpeGFK3oxp35/Oo93sX+pvMyrdmiSKyrNo9Q7ijPrCD6XkA7R2egd64je4C7N4i6nuDLXcGUhiZ8wabbt3ZHmX+XF3p00SSQ26AQsPqozQ8F4ew3OaF7QVDW7fA/cohf+FUikhmqqj+ogRj1WAajc460Z8zYHbyiFXhq6xaz0AAw9GyYYYWVS00BjdmyQBzn4SBe/uBImCN2QlPQZYwF1RnWMccnVJ4Q4Pj3ArXoApokTzwh7QEWJS8yzwKHkbQksaV8ENNaZOlCZwl3Diz2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 14:58:55 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 14:58:55 +0000
Date:   Tue, 31 Jan 2023 10:58:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Message-ID: <Y9ksq0qce6iopG83@nvidia.com>
References: <Y8Pnn8NokWNsKQO/@unreal>
 <472565cb-e99d-95a6-4d20-6a34f77c8cf1@cornelisnetworks.com>
 <Y8T5602bNhscGixb@unreal>
 <a1efafe0-1c8e-60ae-cc77-b3592ea5b989@cornelisnetworks.com>
 <Y8rK16KNpj0lzQ2a@unreal>
 <Y8rSiD5s+ZFV666t@nvidia.com>
 <a830a1f2-0042-4fc6-7416-da8a8d2d1fe6@cornelisnetworks.com>
 <Y8z+ZH69DRxw+b6c@unreal>
 <6a495007-0c84-3c7b-e3bb-9eadb1b92f54@cornelisnetworks.com>
 <6e74d22f-a583-0cf5-fe06-ac641f976f0e@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e74d22f-a583-0cf5-fe06-ac641f976f0e@cornelisnetworks.com>
X-ClientProxiedBy: SJ0PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5355ff-1a8f-4c74-a9d4-08db039bac60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdP8YwWTc5pmY3w4JKRbWiSYK0nwF/fbU7C4xYsv+CEnTPhDrCrxQ51clAAq1LJXhEQF6d4aaBqKRI3jLtKCr9cuk80yXtftBWVAOpobx2DvBDlIs1SKjvpCdJUXgNAQCzXF4N+riIaQtGMx7BLF8FM2NQ8EacmrgcuhtLHgP8TBvcyVFrcfQEtZ7uaOhYqog+l4ttr4nHeNu6EwKCnI940RCnC3tauWZyS4VSH4VcfDDEMd6ZyI3EUJQW03eo0p3bXbnqLxlRj0ltXzxA+KgdGWn80qQoonax3rAUR/a13quA5A/hkYSbOxjHMGIL6y9ki0A/VUTRQIhX4Pbmuo+drZVuCni9AvAypGCZhloQ4C3mQ0y+cu87ZgPXC+vn8DSHbZYPS6bILJwfZnWaxKXXlp83rv+ET4Oxn5Jb1SGrfUM/v02YE3t4BbPISGWrFUWaObXp6ytbEgVV4/yvRa0CjWRUfbyW89MuzsAr3kCfveoYLlEoO7eGI1eGH8J0OwdsU4azarr6CzdUFRyMSTWmShzib9ccr85IB/tHMEyZjixyOzZnR5WmwGwSMK7wepe95BtB77XnLf0A0wXwMCvzOcboebSC2zZaG5W/BBTUJK68tJ4WQ2Ac4mnQ0GYxakjZOBJm5P1o3vSeElEyfuCU0g6Zd5Im6anPLyirFZUXTXaodzUT/6mQCyWHviyr1BY4uk9oH4O1KtvufgIDobHonuMzOwhH0JplfFmTdfZC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199018)(83380400001)(86362001)(36756003)(66556008)(6916009)(66946007)(8676002)(66476007)(4744005)(4326008)(2906002)(41300700001)(6486002)(966005)(478600001)(6506007)(54906003)(6666004)(316002)(8936002)(5660300002)(38100700002)(26005)(6512007)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ivyDKY9v7RWkTNn1wPdLV7deZ8ODYndE47Huf9n+QPvev0clZazGUM+tvDF5?=
 =?us-ascii?Q?5vm22RPXtSK0//KnF6lLUOIa5TgZsYAds3j2WpnOCVWVfLRGJUSppW8v6czo?=
 =?us-ascii?Q?8ZqmP10B+IlM/ZY/YXd2EnfjuvbMBvUTlqTuVOAsbYiWyAGwZJv7U3nf8y0T?=
 =?us-ascii?Q?VxsqYN96X6yGvc1irfpDBQtCoQ3JzDyuhxKHj9h/E4eh09GfAf8XyKtlT7TU?=
 =?us-ascii?Q?pP5mSnSPvfqlkZgqKRwvDdy0T+8mtPtw6eEr+w+WLckfkpBvuiWIUgfOVUH2?=
 =?us-ascii?Q?j02AKd1f+kyUPBqUNEllMHNrjRtHM0ZCWgu+Mm0BGZpK+WnEEV77LPBAzqMD?=
 =?us-ascii?Q?3sqC1a4G4e90sTtQA+FglId4WOXU9DNkqSKECpLq3T5+C/Qsb6W+9lxvt4Ds?=
 =?us-ascii?Q?6c9Lk3D5tG/sXD9dFbwACIJTTaEj+uWbjVh4ezl8h7oqh1M1/vu3jVnboXO/?=
 =?us-ascii?Q?4TWYOICaj2ymq5scdGYvJcBsFL/0godJewBmojnh51b3I+hcT7Ztk7d70Mv6?=
 =?us-ascii?Q?b43QPh2spViZCPPPfEKWEOMdJL+Vv3a3+POBEcNqlhMUKX3euyvCu8ifPGwG?=
 =?us-ascii?Q?bpvXA0SF7YW5V9/mK+V31ac27KQVbzUfR8DmnyyTI8XQd927kT0smgG3zFUn?=
 =?us-ascii?Q?enyluO6Vse3fvSsPdSje6YNNJ2huu5Wb24YdA4UpzwLJXDdRJlnG9xP7kOHe?=
 =?us-ascii?Q?TlvY9j5WIYaTpUJlmUTWqoeaGYQQnHTsctdnNAhAG9AXPput+XmC0/oKHLpJ?=
 =?us-ascii?Q?gRZTovk1VWKjsjL1Wi8LkrO1XlhlTKhAnWS697hLOishS8VI3kfa1ONQ2y+F?=
 =?us-ascii?Q?GTS+G1gCgFJJ9HjYng3peRIYtDhyvKUfz5a5sYwfavrCI1a7BQ0TC2mn/Emo?=
 =?us-ascii?Q?qzwLbE85zbnfysCA8hHMQ8ZH89H69iG0rN4lREBoYybEFoWjJZnkqlr7A8hT?=
 =?us-ascii?Q?w4tNWFnBmBliJvHN5xX9gdf/sp+E+qBdH+i+Ky37vC+zNKKREqe27LZsthb1?=
 =?us-ascii?Q?hHC0beRkxymLe4wI52pClX6HSWCNbf93/48yyERj1VzNiB/fMTDsNk2oIPp5?=
 =?us-ascii?Q?iv37oQcMgeFaIKz4ykLqXLgMSff6zDu3nnnJs2dhdbdf8lIhCX3NoVb+vKQM?=
 =?us-ascii?Q?XXhTHyR5pz6bC4pkeCVJDCI9f66duqbHojnb/xzBibFF0i5Gk4X9QK8LpABm?=
 =?us-ascii?Q?8vKSfSNQySSndouBgXV1c93LeQOITjdIuF9cPju1mHUIRdqiNe6VNP9ukuee?=
 =?us-ascii?Q?dbrOO/dZWgkbvt+jyTklsRvFrcYN93ZmMKKsIMRYLXp0vOmNbu8MlJcTz1HY?=
 =?us-ascii?Q?hbgLUXNg1BxoLFyb+a+VXH6YWeeOKIXCc7q7BT2NyKN/NKvHfiSxKA5lCtQF?=
 =?us-ascii?Q?oENAMe5T8YASEtPqgDOTZ25+aSDK9Q8JlvRiG+n07PwsqSOyjZkDqL0SLWdq?=
 =?us-ascii?Q?QObP4tdz7A8PNrlYOJlBYeX02/v2OLc5Ro8OrwTvlsiDSizXcyzwTE96/wD3?=
 =?us-ascii?Q?rP6BVHLFn6ku8g+toIphSWV0VuZYGVCifXf8FzwQPEptNOXzXIEYGsm8WI6f?=
 =?us-ascii?Q?7164v/r8Nl/p1UHFNjkcrxeUZpS6rjTCONUXDg4q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5355ff-1a8f-4c74-a9d4-08db039bac60
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 14:58:55.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rkg0GsCfO0YpV6cCWblZ6Kkp8yQArSroi1CkOz2Sej53NBQDuBMsch74ltpA2OE3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 30, 2023 at 04:57:56PM -0500, Dennis Dalessandro wrote:

> I didn't see this make it out yet. Can this still make it in for -rc? Based on
> Jason's reply [1] sounds like it will just work itself out in for-next.
> 
> [1] https://lore.kernel.org/linux-rdma/Y8rSiD5s+ZFV666t@nvidia.com/

Well, it looks OK to me, you should do a test merge yourself and
confirm nothing got mangled

Jason
