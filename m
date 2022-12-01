Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1F163FC54
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Dec 2022 00:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLAX4B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 18:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiLAX4A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 18:56:00 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CB3C4CD0
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 15:55:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a99XdP/HHohphr/TJtbJ/+enZSOmw/LimHrY0Y0AtE4rYru/BOculSLPY6G/ZnCGBv8OY44uZmX1Og/q2YJIEwPdVbdktdeUK+DfKrAH8DcJ4tJjh1pMDaf7DWHS3p5lCNQw9h4b8w2V3r6GyA20TzsQrWnuX7IZFNl/8JhOZoe9ukwwK8l1U0jUcpjvzU8YXajfncHj6ss2HoDACTVvuLe1+ZHGQMyD4HoLXyOjfguFr+Bpv8XDXD53TkjuSVx7m/pWn1W5mTEQ5Bu9rl9oZtbg4Qdp0zM3HkBH5eglojR5KscV6vhi4gOJE0VdYEIEFnSZbtm9XVF7gHiYFGT6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6u71IR8ibiVl36bySKKB9daQFNhpQfxQ+EtRHP5c0U=;
 b=GOwPSeKsCaArcSM2TBLyrPsJWEG19RYOMw0OFTTzAt15Khydp0fijRvRKzRt4HejWptOqdODyEIdOZ352iYKO+gkJRuL3bXxEwjFw9s40mTBH8NdMOWmZnXPsB6WU+jfqxJsQEyDUmjbl3z3VilmcgPnry4HNOiN8R+wlnHUmoh0ZcFsTnCZfc2zngi6vct362lWEN21wrzpb3nD+4vN3w3njPiQYH0V28LVCvDtqHWTWqSTq6K0ZjWfrOoRHVgPQLL8rHniw9mw2/Xa68dm+iAOc25TWSTSF5Wg+ng7tE9MaV5a9rtVUigyDwImEk47g3aBp2/0C1ykohS+kMdQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6u71IR8ibiVl36bySKKB9daQFNhpQfxQ+EtRHP5c0U=;
 b=GhUbNBY/J1nwlNNRJO1uaR9txeAeXFKuQSwjOdlWiCQ2KzK3yrMourVRHCv9GYZICWPWH93vbTN7UHFnZkxHHmQOJSb8HIej5WUSqINGbJuVCjOJX2QZZzKxuTI4UhEaulqADnWLdmCgtTJnw2U8J6gOksDAiMsX+VX0ohdEefSIdDW1R6Cgph8gMcJxBVj9anBUMh41UGYg851Ji19W1SyiG5Q0DlEz+PG0qggapXBAtPHwobQDJ8oOQk88sWIa2X7lH8AUwWX5/+ENDqUjOlKjmincSEN4kVx4lKFpxugrQU92hfUyXx4i0d0J17bEiO2gnp9jrEOLOAmrHfkPZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 23:55:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 23:55:57 +0000
Date:   Thu, 1 Dec 2022 19:55:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com, leon@kernel.org,
        lizhijian@fujitsu.com, y-goto@fujitsu.com, zyjzyj2000@gmail.com
Subject: Re: [PATCH v7 0/8] RDMA/rxe: Add atomic write operation
Message-ID: <Y4k/DKgScOz9vpVc@nvidia.com>
References: <1669905432-14-1-git-send-email-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669905432-14-1-git-send-email-yangx.jy@fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:256::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 627a8a90-5937-42b3-db57-08dad3f79702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yQkyJBVazp2q1N7rluvE3RY9seA77VlHK0lNvDgCJtBqYM+KWzleMKc4aJ0DN+TLoTTfrt7O1JIa+L+encY+GuSkU1UCeqeangpzFwW0f5JUR4NcUz12xdsVMvH5eRKCQb1i0QaXpO/f59WJahz5eFJSFHrEgv3K0eHUApuNkvjn6LjJ3CKfRdHRapUC55qbU6N1I91m8EuDWNbGfs3jVEkvaeAiBwwHaYsUAMfsTmwAtAjHrtO18PTu9obsru26cY7N2CaKxCC+EahrHpNXfeH842ipciMUNnDHwry9Wx2bkPiz7ZrzgyMptX/vjfO0KrS0CTQ97T3EoKFImCbZwxaOY/AUFTu8Zp7dyFXdEW0Lub81T+aNsPWJ+U4NbNNDPaaStQC+k74ptmt4vjeYMUVWOZ2KeVGGa61rz4ijyit75pp+q4fAN7zPliJ1mVxqXcS+njI+rxqYGT2cosutSlsCyqgS/LV2QBjMSGgH4FnWatXfNKJZYlD8ERYEtszm3aFn72HDBdlRBqt1yai2B6RFIzKK4kEYS2Pfsphf6pvmtVqYI2VAlmC/dZKCQxKDVg1jI3aXyUjAskWy1Xbyi610DaTNHiqLAbGEpvqwhtjFxvRA+b1OFx31h22Jm8PfpyKXiHZlLsJmzGchCEiVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199015)(478600001)(6486002)(83380400001)(2906002)(86362001)(6916009)(5660300002)(38100700002)(4744005)(66946007)(66556008)(36756003)(8936002)(6506007)(41300700001)(2616005)(66476007)(8676002)(4326008)(26005)(6512007)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QssQs5YBqnEPP/UJ+AzujDecPM9Wdhdjz4gwKzC6Uloxd+HCd3yTecnX9naY?=
 =?us-ascii?Q?p4VBh9nVAurlbi6V1jdb9Q4zmfBe4gzrTmlM1yb8Ab0Pi5naAYyxAWEMlPiz?=
 =?us-ascii?Q?ENQzLlYbYSJUwL4fWfESw/OUEpiHOI0bTpFRJ5zGYuawFUcENYK5OxVrsKVq?=
 =?us-ascii?Q?ze2kThL8bM7TiWac63PaFk7TuzpIk+siuYC0ndlFftSjkzfdY+xhM49h1qQ5?=
 =?us-ascii?Q?7b9cJ04ScoBzxxZ0xpqG9b3r0bOcKxgff6ozEsq1RNeIiXSSQU9P3pRsmvjM?=
 =?us-ascii?Q?CzQsWnoDkHCZXVfxYADpqpaQkyU3/48sYf+vcj01D6vbn0LGwdtyTzij6JC0?=
 =?us-ascii?Q?UqZKFrwgQbJFYrtNsXYbeJbvCx7IKj1GF7KeHsrEB91cjJ4IkKm+8iVnhyJ5?=
 =?us-ascii?Q?HSEhW0+JDdRMujh4LhECWGczhvbxmwQSf4dzcOncK9hY9WjohfALdRrdAhYY?=
 =?us-ascii?Q?WQQTKqyfWDMKi1wUTp3wD7eEQS3fB8xXwr5USDSX/pwOe8vSe/D/gN6OdaCE?=
 =?us-ascii?Q?SEGS7nXFYRseXMMicHBdHdTvQqbi+uGVvf9zrsyCF1G1ERqjaRB4/fBJmW2k?=
 =?us-ascii?Q?WnXYOfR83JjX9MfNwoYjjbKSJ1EA7z2dC/aHbWiySPzr1EO7k3eSFfhpGgqo?=
 =?us-ascii?Q?DSTwoGBLFJwmiK+1lt6mlQ4o9eMByIxY+4CAnaiPppNZJORa0aqbYhxt0Izu?=
 =?us-ascii?Q?+5ch65+94EppYbOPhJCeJJ1IcEZOGXIpp/nL4fClzaE0r6GYURvJoyCgvcUf?=
 =?us-ascii?Q?28Dgy1y+Js0rqtszZuYHkjQCuIfINrX9rJUG5BnCll7E5nT9bqV7flTCsuyy?=
 =?us-ascii?Q?JV8OQEyduz/7gJ1JySwJVlrwMwl6Uh4QdM+/DB5aDbJoHvVNxGkp7VvWTjXU?=
 =?us-ascii?Q?umVqS4Qg4zhwtWVpGw+hzYZDxj6O+7oBmDOlZ+YGWNvkMLhe053OG4KDiKBM?=
 =?us-ascii?Q?1WxLMssYzbNA2aWO7GWeh3qn3LTdWG+rCMOZDi79O3WuNOgGAG4/ko131OqZ?=
 =?us-ascii?Q?WUCYTg1VVNzzQD+Rnwp6XkBW5ptuHDlYP7l1a+uCzu8bJ+XoNNTTNg1qSban?=
 =?us-ascii?Q?Eo074rYC8XSi/FXScnmdC7ZS0SZyqn5K92ztkbH0sXCd/+2M0muFhRNK2v/u?=
 =?us-ascii?Q?v1SAsCFM8W5x3uQl+5rUhZcsJrcfRgPrsc2Xp80Ztvc5vcrAApB8TIbiwOMl?=
 =?us-ascii?Q?Tl2E5mWdv98e648nkBcWoBPXbehpvbiNM2fytTtDCvWwxCdRNRQCiLBI3M1r?=
 =?us-ascii?Q?u3kzfjJSNbvTJ/GqhqGprsTIBbPDNrQnW9LJMc7vGmIElVS3lxjZq8IXTUDr?=
 =?us-ascii?Q?U9pQu3wzYtVqHq2hMcFu2vLuiWeR6CU6BUDk9xPRrOLsMbBXaVOwSDqHm+eh?=
 =?us-ascii?Q?ilJZSP5VAswvAnlnYxBh71wIfQj+LQaO+WH7sFOvm7Os+muY1Lj+p1acrs4v?=
 =?us-ascii?Q?THKUog761bvdgl1og8QXYaobuJNZHtWOC6UCZ6lc5U3oyu6Td5WNNpt5qrps?=
 =?us-ascii?Q?R5Cb7VDnXU1xuZIyGenyBqKLuuTQKQ1SmsisCTQkxZKelGVeSszwuEsYV139?=
 =?us-ascii?Q?WW1qB0ZPvuFWjsa9DmE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627a8a90-5937-42b3-db57-08dad3f79702
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 23:55:57.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tw7VFmGRvAdarrdiezgnBCQ43Zc4/ZwhEGfT1+5Mn7GKdf4IT3AMtcfwWh3xEOuV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 01, 2022 at 02:37:04PM +0000, Xiao Yang wrote:

> Xiao Yang (8):
>   RDMA: Extend RDMA user ABI to support atomic write
>   RDMA: Extend RDMA kernel ABI to support atomic write
>   RDMA/rxe: Extend rxe user ABI to support atomic write
>   RDMA/rxe: Extend rxe packet format to support atomic write
>   RDMA/rxe: Make requester support atomic write on RC service
>   RDMA/rxe: Make responder support atomic write on RC service
>   RDMA/rxe: Implement atomic write completion
>   RDMA/rxe: Enable atomic write capability for rxe device

Applied to for-next, thanks

Jason
