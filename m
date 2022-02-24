Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81714C205C
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 01:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245120AbiBXAFU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 19:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiBXAFT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 19:05:19 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2051.outbound.protection.outlook.com [40.107.95.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B658380
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 16:04:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUleIotg7TwiykSYxALUkOxr1YiRqWn8YU+MunxtgjmNKlKiEwa0B3RqEVzmCo/Lux6f5CZnVtny6ejX+prEpc9Io8oM7CQeFnC+aU7y/xoaPAMQbXVziqwyodidP8eYNz9kuKe7lxds3N6oIJHBi2w2w9WFpwf67JyeGSnr7NjK0t8VqCAW2Rqu5F8RB+5icDfVrPiiSnUqdVKCUEzyaqHeyPucBbXr+UHDibrk67kvIFzJId+1u5NnljyF+uq53T5Ed10Nv8kqTrmnPryMR/mKAixAy9JMtLbVGnXdObZ0P1CHUqyTfqsQ3Qm2MeFsmudvBu1Lq7WKyR33nryJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7KHa0aQoyx71Gn5OB6grkbDFvITm38Dw0kFpI3/wxg=;
 b=ZbNG1b1JGRcwXrqfEEFsldya9QlC5/DEmFz6MVyYqk0dZRB9SSYeLRoc35kcpwFF9G9vVEYo3ISrj3ruIvLAJ8klY8okM+xrXg0lmkRDLKA2DskyAwqS1h6/7thd/AQAVwWi28a5PyaeFnR/RdFseeWOaGvN9hYM5a0Rsm1RRsUavlY/XyV2jZsbO4uRLGsECKffhB8mFj1YytT2IXN9rZSlQCdMOwyPTeDnstk4JAQpBtQqlpLNccA3UVoU+PU5zLW3uCcyUjRPiJDxLjIPTwZBuiaUdH2V4ylg0P4uLYa8gd7pIJeMYsN0sZn41U26SMvtL5WSV3lDgM8Kpt3d+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7KHa0aQoyx71Gn5OB6grkbDFvITm38Dw0kFpI3/wxg=;
 b=H0Q1N8rcliCz5uCxiLYYrYjwCQ3uAs12C0B10HId1YK1qTQpypkq1sJVskcDJXTEfjxmUDWSSdcDPzEwduPjBudea/jp9lbDjtndKRZJGQjYKaL7c398h5MIk24hi8rbPFrChI+vBUtq20JJMw7zzH0YuL9P4/iemznV5NjLctBpxv/sNhR/EJRrORHf/18giv0bI8XTLpJ2luXcIxg5S6334gybb9gEc25xXL4mqVu2GVhoqjf9nSy3BI7wPCzDuQWnTkLn+38GGOO76FvW1FgMh1Jo5VDBAbUi8yj3cGao3EwTRCmk+Vr2i/tZexWHOWZV//v0xs1p9w6AFWh0pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR12MB1607.namprd12.prod.outlook.com (2603:10b6:910:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 00:04:47 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.022; Thu, 24 Feb 2022
 00:04:47 +0000
Date:   Wed, 23 Feb 2022 20:04:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v12 6/6] RDMA/rxe: Convert mca read locking to
 RCU
Message-ID: <20220224000446.GA409228@nvidia.com>
References: <20220218003543.205799-1-rpearsonhpe@gmail.com>
 <20220218003543.205799-7-rpearsonhpe@gmail.com>
 <20220223195222.GA420650@nvidia.com>
 <34b05c41-c674-7120-8d0c-0ceedab50b50@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34b05c41-c674-7120-8d0c-0ceedab50b50@gmail.com>
X-ClientProxiedBy: BLAPR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:208:32d::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42f27d8d-76fc-41ad-4301-08d9f7294524
X-MS-TrafficTypeDiagnostic: CY4PR12MB1607:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB160749DD40651D9817CC8EF3C23D9@CY4PR12MB1607.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2+GWjvrHrmcfxhGRovyKY+FQgMsXPPWajaOVwK2mubAmCHCEzQ89fQGZwKf43I9w5wZesuztaT/5d1V4YWiR5brD0wSO6mkw4u4P99PbwmSc9LIVVeaT+2bPgZPibYYezD2BQWqRRdVL5L/hj1WdGtrcMzivmxV27y8RCS/tIt1ow2Z3JtVaqcmIixEGhwkUNUM8BMiHiWeKHsPie/wWf5TghAjTLtR6vIKEDL3Ugk82J0RBf2+TTv6sHS5NWD8cBMuF8ePDjrDjrUpcZW03txURejJdEBzlsY/mK8Z/gp7HOJwgtomqatXVQ82R2nuJPLCcNkPrDRYCyIAOcIm1wEQd7KUGxCpp7Jr2dKy322Q89vj2YzqRHxTKDmWjRd1ubRZACzKmD8pms0dGhVtIFVtm9T77WNPVUAnl8NSi1GR3x/a63/qBCvyaGz/gtBxTC/wv0FLram2z5Rsblc4CvGBvV8r5z3CtfmpuKo7cBT/EnAGR/I5M5MU6WHAbcokMJys5n6/V6+H2Wz0P5eBlegy5koYLVFtrxO9cuZO/seGO14zucWq2gYkJSj2d00rLGMoCapovA9ajuwVWMno9kS8DIURbY8XnWo+KyO3F08c451BIfNXp4wSHT4FINE/mZ5IXWdKk0yZkolz6Xt7LrvoKAC4YUqnnDWfC10kAspJjcXxBhJPlOWJm0EAyaEa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(4744005)(83380400001)(6506007)(6916009)(2906002)(8936002)(36756003)(8676002)(6486002)(2616005)(4326008)(26005)(66946007)(66556008)(33656002)(38100700002)(6512007)(316002)(86362001)(1076003)(186003)(508600001)(66476007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kRCwWtjzwQfD/zbEdz5foNSEA1NVHmYpOmPZWK+vAoq0x1rnWfpwPXxB/B5I?=
 =?us-ascii?Q?0XnHFyA5DHs4n+MCawgj0wNZQ90za/9RnmoClcMYGWFzOdDPlRaObc4J00xf?=
 =?us-ascii?Q?6oIS8HpONaWpiZY4oiSKfRzkS9dYGBFGvWXh3ZeZMHVHQMhXjcikgwaXub8O?=
 =?us-ascii?Q?Qsh7XR52runuWkWklAmixqFFzjyu/6oVUA5uAEidll1/ogAwUPB+KKN6zjAX?=
 =?us-ascii?Q?/mjbD7isbXX8tzVeE9iolLeViL563BTjwkb0fzU0Ubt03kUOyQ/a0pzObQN9?=
 =?us-ascii?Q?nZRWrk7axKRxFeHR73vLRdRmplQ7U0lc7Fj9UJJPR8oOyj2dbJAcO3nzDK1f?=
 =?us-ascii?Q?FwGoR+FLugPcs6Qzo7nWHUaYRvP0k1+zyY4/CH/Aly8CCB9OAyjrt1UH6a0v?=
 =?us-ascii?Q?Rvvf2eJLZUH7sFob6mhei/nz5ULShNItVLrWqe21buEstLU8K5NZ62hxxAfp?=
 =?us-ascii?Q?tOZpX8AdBjWBjyOem3mMto1qTD1Ueeb7U3BwhcgVolKj977ii+KEWJoyBf0J?=
 =?us-ascii?Q?59FAOXT+meGb8ryW/FgqZA18DMQJPMtt0pLxCAipdygC2tyOYhBKM7l9zRzm?=
 =?us-ascii?Q?/zteM6zeugaYLXQ24LKC/6xaAwhF07xXqaZu69T/7fHfiP58yB1ahE5uRDSF?=
 =?us-ascii?Q?ojsY2MhF5vi+Sdhd1izfizdEr23O2vpdSCOYFjIQpCb7P/knCnFvXv9cXgkJ?=
 =?us-ascii?Q?pVsmkivY+kc0HR6+n+dgNNgSAuvx3nYyo93QnW13WNh0WOB5kjzP9CrVUvfD?=
 =?us-ascii?Q?VAp+p7sbLnSCf30T3Ov0HNjHtQkHK9XU9jrXCyZKwm4RwkWX6S8CKdP0Kzaf?=
 =?us-ascii?Q?gPBSWeZMYU0j9xW5Wos9eNUwg4b1fQYa5x2QXspPnG38SaLqGzKkfGvBYcd9?=
 =?us-ascii?Q?nmOI5zBvkyTfoFgRzRQKltJof1OfdtzGHblHG8XgaFcIEkd8FJxHIXygqfti?=
 =?us-ascii?Q?cI+h4BXGKJvLT+KJECsPWfq3M0Ifr4ek188jNMqie4T8b65090K8G7Hn1SsB?=
 =?us-ascii?Q?ur6E2zIIVuqOSNGreipN8tWpduiPdm4khFcHWAq0iMSZOjG6F/zx6Y7uxRLT?=
 =?us-ascii?Q?IdI7C/Rs3wEBqVgxWmITJIVcl/xGjvPf+zj/fMlAz2ctMumT1ySsJx3FFDIG?=
 =?us-ascii?Q?DdhQzzxEUvd9KznWakuQpgl4mM4nGBo0PQ334xFGYoDlZssxDCScGvZHDASG?=
 =?us-ascii?Q?3a5wEr3CoT/76m1eob1tD8kEwFv4nLQ6pTPSEFcy3i1uPBcvU1sOTZGZqOQM?=
 =?us-ascii?Q?YOujFW4Syna55FYoYtRxJ3dSrFMfgK0E9WtqQpUYZvSrS/0zLzOqTFiA3gP1?=
 =?us-ascii?Q?KutHP9vGkXvUJoIkFJu1BtuCIOA3svLXClnc1pPlaHCAgMiMhqrOSBt8XrP5?=
 =?us-ascii?Q?rx4JEtTWhvER/W+7bz/dUtwnhf+yNqOfW03nkSqsTlvLYg1kIzcuaEyjNpCg?=
 =?us-ascii?Q?0h18C9NY8jHTZkdM1ZI2C0hAlt1lCD+cHk7/eZ/qFaH4Y2swQ944wUoQweMv?=
 =?us-ascii?Q?XIqgIaOsO2aneqv5ybKm9NLN86AnUL2QBTjZs9pbUwbZzflAMTM7OrHUgJ3/?=
 =?us-ascii?Q?A8SkbNPE9xSKOZnEzJc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f27d8d-76fc-41ad-4301-08d9f7294524
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 00:04:47.6765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysconEPmjZ9DQH0kdOHN4wystjGicV53nEjYBXJ/MDIVBThe18K4TQXHXsWcD4yi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1607
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 23, 2022 at 04:40:19PM -0600, Bob Pearson wrote:

> OK I looked at this again. Here is what happens.
> 
> without the complete()/wait_for_completion() fix the test passes but
> the (private i.e. not visible to rdma-core) mca object is holding a
> reference on qp which will be freed after the call_rcu() subroutine
> takes place.  Meanwhile the ib_detach_mcast() call returns to
> rdma-core and since there is nothing left to do the test is over and
> the python code closes the device. But this generates a warning
> (rdma_core.c line 940) since not all the user objects (i.e. the qp)
> were freed. In other contexts we are planning on putting
> complete()/wait...()'s in all the other verbs calls which ref count
> objects for the same reason. I think it applies here too.

This explanation makes sense..

The mistake is on the QP side where it has a refcount but doesn't wait
for it to drain I suppose.

Jason
