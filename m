Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102697781AF
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Aug 2023 21:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbjHJTi2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Aug 2023 15:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjHJTi1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Aug 2023 15:38:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23838213B
        for <linux-rdma@vger.kernel.org>; Thu, 10 Aug 2023 12:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar/96dx8VOx8S2birJlFeJje3KJUt1rDOvD7BeRH1QD8I/c//camsbietBANZ07G8FYYe2fPK9JMltDuLFa8MmD+ynM4nbjHR5hXfUjwzuTx0x5qWqUUNP4DKaRsWxUp6wweDQFwUum3M6Q3HNW0Kt98sWdIFZ5R89uA2PjAy2McmTB6zqVi+NHRPFnx2zv9MCB1y7k4RyRAe5yDHddGD3LU/dj6HqQJdrCmtZGvJkZ7xg3KsgQBx5rxomFarMOaZxUh0n1z65zSsrqz/no8tzI2E56FzZjpLxHhHA/nuNfnlTdw9EszD74F+RWIKFefth+Nqw3Gk2ANewt+awTBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqsWZ2HPkYJ1lFqD+OxJx21K/aFZLEUXg8upbqou1H8=;
 b=Fe2t1IuLEnCKJeC8NRkQ3U2EyYN/dtVwfHhRhMB+KYxtsq3F+Xi3GIu6NLsOgWhKbay1nNwtZcMeA1FozDqNInG/ffwc86NY/UhNko/aKn+ZD8jtPV+R7UeBHc2L/5yp3ImeCPY8ertiGYQ4zLnPgvsiWEJz8Zhpz8zwEq+vNJH0cV0u2dcQz2WVSLcISDGZaVtTuyX4D0piEejW8fC+cBvGWKS07psDrVxy6ito1TE9FgdgFo0b9PMelONaZFJ9xpTgQCQljiBHeLRDJyjAZ59qnRq1TaYIjsybosB/lj0jDawdVq+b73H6/I9W7sivwWPbK0O2vdpklr2HDUpOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqsWZ2HPkYJ1lFqD+OxJx21K/aFZLEUXg8upbqou1H8=;
 b=T/V/OLiOW1Ehor+VW8PUfWN3IZPh386Jabh48x2zEtEFWrhOQJkEBvg3sETmeTLAPON84sR2OmqI1L0VR1vMWTjgP29dEH8QDvYU7dPAPpCY63TEGcZ5oAjIOHrVUZ65d3qzqvIjDCiY04bfc/w/EXdTgkfKB1pqbzpq9d5ndk9u4AHIjWNWE+eNRv1J1ArdK+F5XOhtWZp93uKGRcQUr1HWZOBaJy3aO3mSh2U80MihnHNc897QzqTITBEdVom62DSmVwnF/4C0QdYK0NxbkVOlNM+0RDtid4xfXecT5E2z0L6z0QAHltYsdSBSKHUHxYbHqvp0Xwo3AdhWv8EteA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4872.namprd12.prod.outlook.com (2603:10b6:a03:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:38:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 19:38:24 +0000
Date:   Thu, 10 Aug 2023 16:38:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-rc 0/3] RDMA/bnxt_re: Bug fixes
Message-ID: <ZNU8rXDNEj7mGiuQ@nvidia.com>
References: <1691642677-21369-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1691642677-21369-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: YT3PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5fc5b8-4cd3-428a-7dfe-08db99d95c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYmzWlllw25f62b6evbbehhYqzbAAdstmecGhiIQ30KL/x8AH8cfyP4z8vniq0Nbn/BYjLF6oY3VY+1Y1970KiY5BzxYS9yQQ2bBU16TR4i0o19uU5CL5psAUHpcJNyWkyyT/8TbgK1vygcvJeueKULIUeN6CwhKOaedsrHDbKr92YzzYctf760WP1tlyMk74neZblQewqV2g1WJqpDWuelRpifcBw+yaBBJFrPT2itIoqDXzQPUnogyAHIzD8lgFJJf79EYQUu439kIZhAEu32qlGJ0Nc2Yvn3HToDGAQeKY8CjiqVloUqN2O+NlU0Vs061HltI9TSUg43zDOt2hpA0wiSa35WJgSHQNPCUtu1h0LryQqVOtGEPJvg0LjJ3Fyth99m1+3Oo1QCMsW+d7COH82QbbFD91eFJ1ryLUOVOMV4ite/jOC11d/qqIdpONsvvsfCbKZzdCLnSdrR6SkHFm3UQDi+2g0gk9dT+jLBkgzsrycSYW2ZoXk1QCefSkebQ+x8xXTUrIBw+jsth/d5fyA55RU7BZ2RAMQIASF7f86vDJLRFpYVNg1Sxz3O9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(186006)(1800799006)(4744005)(2906002)(41300700001)(8676002)(316002)(8936002)(5660300002)(36756003)(86362001)(38100700002)(478600001)(2616005)(26005)(6506007)(6486002)(6666004)(6512007)(4326008)(6916009)(66556008)(66476007)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0DmSFKu/M5/47FxykzSms4BX2iir0fhdQBcNGcyPoDREabvXa9fGYjbbLOCJ?=
 =?us-ascii?Q?Lj1XvjDDVNf5yyXpQXouh/fpZ2E1c6pQK87gf7/mBYl2AWF/zc53ckmNueeY?=
 =?us-ascii?Q?aO2hTL8ugaAaccLD3fbTTVSj9bGRtcAcrGtLFSsCdlZ2th1Fpe0hMytM0VEL?=
 =?us-ascii?Q?v4Wncjooo3DGmbGodNzFTWAvoQgbEcWX/TOmh72HfcXIo1nmm3GqVV2F/skE?=
 =?us-ascii?Q?FPsmoCevjsGx1VVjEyHpNkiCbtsSzMtVK8A6L0ERHo1ygZ8LD8IJtn18OIVg?=
 =?us-ascii?Q?k8gb68kMxpi+6/mSsoyE5SwBWP0hKWoM+uRJXZoZB9a300VVVVq5I4HGathy?=
 =?us-ascii?Q?mWVOJkIx/K1+UyxYGhVHlb4q6DSG61G7XipJtw6exIL8Y7J60zijSqVlegyO?=
 =?us-ascii?Q?riLbbWfJyhbSLi6oPU94Z6WNWtBzDBnllteVAlEscXlmhrIjGJKG4GDbWwsN?=
 =?us-ascii?Q?mKtr9cgImGoEILbxR9ow4VpSUf0RsLfV/CKrUWKBgJWnJycWJLEWFB1hXOhW?=
 =?us-ascii?Q?Gyqx77lXwtb9E3VtHJgdR7etjw08MGFvuBsAiDUrWZUuYefaLZh4nM48F2XG?=
 =?us-ascii?Q?5CdoB8ayQK7aHXl/EEUdPzP7ZuXMRDt7iGk5fDV11cPpOy8JUb9klvFCbCeJ?=
 =?us-ascii?Q?H1BKVthKLK1gRw6FFwGAkDM+0IV+qnFRFZEzlGQbKJPbaYhm++L0IpaeIXpa?=
 =?us-ascii?Q?Frtq4Cbxa65g1IsXOC1S+jWS69T47WnXIniOLlBOofz+Bn+7bC0YgzXQf0EB?=
 =?us-ascii?Q?bUShT+EqcmGgI8MHP732A7AArXz3D2FozI6tb+NLJkPBbzcoOjKZ3I4+PjE/?=
 =?us-ascii?Q?etRY1E8j6gacl2GfppRE+KiAmFKFYvV8WF6TsF7eYrDxxv1EqpJbX39rmDyG?=
 =?us-ascii?Q?UG+1AEz7sGh1dtswrYYyETJC4n19SPqvK/Km/ltascd58Dr5mLewLcPZwsjP?=
 =?us-ascii?Q?nKoTffPWJULtQyi7MyNZ1XEl9+KCEDbNHOC+qaZ9CSneFqCniIU/nAPBv0Aq?=
 =?us-ascii?Q?JFyLCPh7srW9yAoLREwBx2dd7PqbXKRR82ZRxfOpDz4O7YmMZvl7tzazt+yA?=
 =?us-ascii?Q?jUFLANHF9s1FObiaWQe8t2yG7knbuFwf4283KQ+75k4Y7b0GgIJRscJEu0dU?=
 =?us-ascii?Q?Y8nHw7+kGUFNy5kqNLHfvFGhXgGsgn9XXSHiqMKK+NiemgLGm6YxyTE8RKa7?=
 =?us-ascii?Q?IloumBQnlQgADz7k2T1fpMeBqmkJBwWBytPZ7DeNyEynLiywMh9eL6B78jDv?=
 =?us-ascii?Q?Dx8lNjP2DmV0bEXjrcXhvqufAxQh3JzSI9QzFe62YEzWnhOmlkxi9wIXKF5m?=
 =?us-ascii?Q?0hoMrPPFBoo+0xrdxjWuQIeaD0HoeloUdDjDbI3xd/gQS2xqmjnK9Mq9lURI?=
 =?us-ascii?Q?MTwK9DK9XH/YYbRdJaErh+BxA3Kpp0w8ogBaHM+/t4SuB5iYxWLXQZNyDSfv?=
 =?us-ascii?Q?qsu4cDmRfNbJ/vKNb0Jv7J9vUmFZO33oNAsRRy92DYHuiE5IUnjRUptREIjA?=
 =?us-ascii?Q?6wCvSKvIb+9+NwtFbTilG0tnrhEoWc+d4emsH7DHrpr3sK2/d5cPbnk1dkS5?=
 =?us-ascii?Q?+86plZ47Vy/6vjLlF7akPwZpSe+HigGcyJvPPazF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5fc5b8-4cd3-428a-7dfe-08db99d95c32
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:38:24.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HllJQzFpM8I+Sc3qLX9qzNZU9lsfM2/My9zWRAR/ufB8kGAzrrAn++Y8VkOEVis6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 09, 2023 at 09:44:34PM -0700, Selvin Xavier wrote:
> Includes few bug fixes in the driver.
> Please review and apply.
> 
> Thanks,
> Selvin
> 
> Kalesh AP (1):
>   RDMA/bnxt_re: Fix error handling in probe failure path
> 
> Kashyap Desai (1):
>   RDMA/bnxt_re: Initialize dpi_tbl_lock mutex
> 
> Selvin Xavier (1):
>   RDMA/bnxt_re: Fix ib device unalloc

Applied to for-rc, thanks

Jason

