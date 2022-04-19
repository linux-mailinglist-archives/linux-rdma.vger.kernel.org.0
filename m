Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585225072D6
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Apr 2022 18:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiDSQUx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Apr 2022 12:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiDSQUv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Apr 2022 12:20:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656AC39BA5
        for <linux-rdma@vger.kernel.org>; Tue, 19 Apr 2022 09:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMejqCd/IIWY0CxXo8CArrLOxFbMc7y2sVLSaQ0Ik0S0yA/Xw+zJP2ax+/TDzCi6gzZC0jfA1lwu1VxPcQEYOvOzav4Y9T33yp2lH4ywAoXoN9bhKy3t2fzkH/uIHoMq24TzwU4Biih6XJYYflaqEl7Uxi8W2XPu38EsRwFPL+DB+w8p8xrD4nPJsVpeExpC4IViRErONcl5syzObLtOR0CC3e2Ckr5cI7MeNWFD63UsLqru4b+h6096B1EWJAIP3inAUoG0A1qiLMnupYAyd+DGnh9lNJkgz6LvSwdGH9y71QBAHbKVfWBgy5aHuGJNYz+GH+JUPTd/oXB7VkPuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSw7bcwoHxxG0t+6ZhIpX52lwEbdLJ2dBS3x3Si/u4c=;
 b=ewt5IjQttFinq7Qw606G5eGP3WMvMvUNg+wmVkblRNamUnP8V3qM5UJRlzk4+L4F7xUiRjXZ/Q7S7zptLu4Ay8z5xMIUaQVLK0T7yxCoT6sFdFQvt0olHRk+NhxS5pARO93bbzYx0gUrSn9s56Ce9eJhgAq0QQlEbk5aGZqVaNr2061PILeGHNFzQ46sBGMrXfQeIY3as1GpKQgWa/rxMf/3Zjwag+7MIEQEi4ITpz4hHavmTZovMut8NJThaFtU2owwCBAvRPFIKBCYPfKo52+6TZlDp4VQdzIUvH4DZHOUGoI/KgFYNQ2n/f/5V52IBnjgvjAGbGrezY8HyRp7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSw7bcwoHxxG0t+6ZhIpX52lwEbdLJ2dBS3x3Si/u4c=;
 b=YZQtX+/247viwhIZpmk9RtJp5GC56XdFo4D/iH1zbsK00/sq7Fd6uDTM+RgD4KumtRYc7/tQUP0hVFam2CUxQD03qdX1sotFZZb6m2CigCZS+jpI3pwXt+JQqxKJk1au7PhVGhSqI8+f+0BE8lS4orJPG+WWNp+3lvCTzS0PlqANkG7AjEGFo+St1hTLTIz7sYTQKJX7JD48E1OJ8GzsCFYkoI1SdMkzwPqCl2SbIaW+U7AGXc8o815ETniS/wPCP0d5EOepyiDjQj0G+fwjT291375Ghy22kg5C/xB0YMqrr5lsXIJybFxJJBNo2peYBpaZ4KAlUBsbrn0wQ5Q97w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1741.namprd12.prod.outlook.com (2603:10b6:300:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 19 Apr
 2022 16:18:06 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 16:18:06 +0000
Date:   Tue, 19 Apr 2022 13:18:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix "Replace mr by rkey in
 responder resources"
Message-ID: <20220419161805.GA1245827@nvidia.com>
References: <20220418174103.3040-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418174103.3040-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf56f45-e9d7-476f-4e71-08da22202fb8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1741:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17417C8B56AE5A6E9CB31679C2F29@MWHPR12MB1741.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwsaEujdL+GpmMEtryp1DXNZhSoT1fBTc3o/lj++IPgI56REZwUFb1GGtVHKio+7he5/kVdnJ3hLmZ7tzznr+0CvlxvmgG28hbaa4i7KR6HjwNOXrC9/mzJViS9Yx1aRwfGrabW+tLrkU3aVk8mnydk8oAX+4lvpAI+14HwrrIGW1vQ3gemQCt0u9WQ+BXEZFhya5frqNgweu/m/iQGa7hcAMJX7lsLptMcUsWKvW30AcRrRDMdaiOFiJIo7Z3aTi0DqhjD6mKZRTVoOek1sjW+IkioXQB3d7QwjCQ0L1nXzVFd44olD04CqpHQUW0jsnSG4cnOySpJ6weCPvAf9QnYU8V45mzvmjaRe1Ed3WTbGeH4AYGEzELV++rNBLwsF4WtdJWLqavBynOKUtn8dc6AvURrVo/Du9IFuqytUx/lIzTNblEnXyet5Yeq9aeX3PYKa4o2hr624eHgYKE58rBJtoJtJtyoY7qUPfGGJCec3eRzzNJwdsAyAIHw0spMvTnvpc5Rw0TedDadz/QAjD5sx3xjYVxwI3Yi53y5Vp13rRrV2dGRKSlJO49qI84NY0GBjn4cEpfUIkvtzjvhiRawpchqTxK9SNMEAVvojKdqJvKm17Wqzal7at+GLlYbyhq3QQN9nUgGmeWkj90kp215dsYhTu44nK4aTrOZlmE8b90R1tRg1+zsznPDqaOjDXGzEZZo9HecZqLvX1RIGgJ60X4y3oOnZUnD9jSUMeUx/+kPD53Dn2J7yhsOfrS/3wqF+AkAai3lcS6QfwAPOzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(1076003)(6506007)(6512007)(2616005)(83380400001)(2906002)(5660300002)(8936002)(4744005)(316002)(508600001)(6916009)(66946007)(966005)(6486002)(66556008)(66476007)(8676002)(4326008)(38100700002)(36756003)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hzChs1DYZWF99p257AKxhpvCgxxLgNxR6tcS0aeYa+adkhTSi8gBKfyPFjNA?=
 =?us-ascii?Q?HurPfAzmvL7qBjn25eLICAGaso6HeCjTJoRkQaGs9Z/Al2lULvh7La1/LWrd?=
 =?us-ascii?Q?jsrp5sVLT3VvmyKf26Yia+KPZm+XCfF6MVICuDervVcR5uvrHAmDuLv4d/f/?=
 =?us-ascii?Q?B247dyMC1l997bMd3FBDNOY0lIFIIfQG5u8C7Xg8Vc/L0j15ja6DNmXsHmue?=
 =?us-ascii?Q?s3QMtya4j45bvSgclw/4FzXiZ7mCrrifiykXQyZ9R0Sb51JXonFJXFd2c19V?=
 =?us-ascii?Q?13xQDyAU0PRZdYZDwrCqHghxfuqqYaiO5Wb3oLD84lA8Mc+P/gL0w6rY5afH?=
 =?us-ascii?Q?2z/UsXuueIkkgbEqsFzJGhb3Awi0N2iu1/AF5oMbgqM4ebmUd/o+NtmQn12g?=
 =?us-ascii?Q?ZlLSjJB0c9IlO06gQlpG5kY2Ofx6LEX7pvrd+J3M9McW9S8z5BwW9P0/oEgf?=
 =?us-ascii?Q?ZIYlU9WF2rr+JX9V95tmOL9asJURqT6bO2ymZopLpLd7C5c3n98WhRhp0/De?=
 =?us-ascii?Q?lXehXTEW+v0CiH+dNsED/GwJthlRquB+Ka69gA6wU6MmOkN0tKuaGkDilpxP?=
 =?us-ascii?Q?asjKbWloUeTtTd+jJk5HaUsUipBJ68PUewJoBUsqJul6UGKlMuQ9oDUI3Bv8?=
 =?us-ascii?Q?Wpm6YOKUnn85sTO0sVj9Y2Ao9WCWsrSve7khLQlRl8ZXIQjHUbfhuXj7iaGs?=
 =?us-ascii?Q?kZLb7wwBbB21anP+AqebFtPg6WkdwT/0apKC1WHMhQzOvaIshpJ4fFxcql4g?=
 =?us-ascii?Q?gRQFRxsxNaMXJrUiK9aEXq3SqhErxj3wsSbCGydSx4MyXaJBiiI45qv7PljC?=
 =?us-ascii?Q?8WrU4wFysXUXj28KpzlktUBiML8g42aIsDwwZnQx6qKoW7e8MFATlY5OfB6D?=
 =?us-ascii?Q?w0wH8P60sVVn7S4CJsrzzA7Tt9t3IGKu/WHHuU7hQwBDuNqyZf3B8uLTXWTu?=
 =?us-ascii?Q?MLcNuofQ6iNiYh5VWYaufmnO1TgVP/tXdGGKEu8gy6J2vFaMMvdgsxth71ZM?=
 =?us-ascii?Q?IzgZkVNFL4NAp4DwtfOfYig/l9J8Ti2h28g7gv42ehWHb19Ke1MN6NShu5qI?=
 =?us-ascii?Q?ZuzDefIbCqrl0uMPVJDlCCh38mb3u4dmd9M/o7nGy6eAJBOZXDW0KOvMYQWB?=
 =?us-ascii?Q?LwgLsSnTgp+ZsMygfBLlP9th3efieOG6SPSsNo0KDAiB8dvXqNXneoANYgiL?=
 =?us-ascii?Q?+prjLZJH9X8lI8IDgy/6tEdQkheBF1H7n6vGE6IusJmsFKcdy1tPLwVZOguF?=
 =?us-ascii?Q?tD2gcl1hsPE6k6NXm7UFZNvN/tHfk6o/vZn+mL4xww+X3UCOwHueKhW6ASHi?=
 =?us-ascii?Q?B/8F+12NYO8WrxlImKrynLxS4CtKNHb+t2rlKNA2+TpXcdj68FpCPUIJ4chN?=
 =?us-ascii?Q?MCHb0NWsoOoSjSBXqRX768Fj76J/29JuSRRP740chxn7UA7xeIFrsOKm2P+O?=
 =?us-ascii?Q?M4VaN8Z1xsKsN4VJFcjsy3zYRHx1kF03Bna5Tjh9aRo8DSwnirflPAhVENMI?=
 =?us-ascii?Q?SRMIS5ZA3GqzZtKUlAjVC0tFYHrdWg2yTuHnBHATqY7hbSitLdulgsMGZ8dy?=
 =?us-ascii?Q?vx4RDeh11yYKGXop5RP5Fx3L6mJW4QLZxZTWtJs9CzivRWX7G0OFHKFs3zI/?=
 =?us-ascii?Q?EKMRbCvR7XUF3v9uEGfQj5P5hikSnHl3lDCdMfbGXWV6hziBSjtSe5SQcV36?=
 =?us-ascii?Q?HSut/D1mw21IJbmd8GTQ3x19ZChp9dKVJ07lzDdwEls9QGjxHSTqvq2HqeRd?=
 =?us-ascii?Q?Wp9sDWxh/A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf56f45-e9d7-476f-4e71-08da22202fb8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 16:18:06.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D//EYiUxkr3R5iYb2Y651RUoYOOd2Z1M3f3KL6nE5cvxIK+U8agh29ONU0LQwNi2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1741
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 18, 2022 at 12:41:04PM -0500, Bob Pearson wrote:
> The rping benchmark fails on long runs. The root cause of this
> failure has been traced to a failure to compute a nonzero value of mr
> in rare situations.
> 
> Fix this failure by correctly handling the computation of mr in
> read_reply() in rxe_resp.c in the replay flow.
> 
> Fixes: 8a1a0be894da ("RDMA/rxe: Replace mr by rkey in responder resources")
> Link: https://lore.kernel.org/linux-rdma/1a9a9190-368d-3442-0a62-443b1a6c1209@linux.dev/
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2
>   Renamed commit
>   Changed fixes line to correctly ID the bug
>   Added a link to the reported mr == NULL issue
> 
>  drivers/infiniband/sw/rxe/rxe_resp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

I'm confused, does this one replace this patch:

https://lore.kernel.org/all/20220411030647.20011-1-rpearsonhpe@gmail.com/

?

It has the same title but is completely different

Jason
