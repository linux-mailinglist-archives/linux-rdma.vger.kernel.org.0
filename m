Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E54C69BAD2
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Feb 2023 16:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBRP7j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Feb 2023 10:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBRP7i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Feb 2023 10:59:38 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEEA18A91
        for <linux-rdma@vger.kernel.org>; Sat, 18 Feb 2023 07:59:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAqj+G+hrpMsqcS1n0GN7c0A+QkSgy9lOtd2JphJzkToe2pQiTo/hUycBW3z/kgnNHW60VNv1QNTNBFZYwMC2VRepesl4n4NrCeW38iI5O1xp5DNeaQUsSQ1PXbtNjZkJyBpkIOQIoXT4xUpQm2Dh2mbwMOc9gJhUqjSxoXMFcGTAh8DXQFNoV+iohmj5SUAvSt5juO04PgyiuyM8wnhXry+BmRo0mVlP4I2Uv66KBEyS0IDcoBEDalGx9yDlnBQPK3ESiIz1HbmZQ7HG4s8vySJ9sOPlg8f3EXhK6lhBlRvnsRXIu23d8CMo/r6ChwDl5ftUA+YtQ682T6nbqvOYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYEbkHUCZjEl5bdFrpsg+CPclEQ6vnsw0fJOci4oa00=;
 b=Ei7+vjyCl3T30GydlwQzUQNrT8Rdz1L3hMNQSGK1R3RuJeYkolZ5IltJWw8/XAqcQ6MEQAEmfDmZB/QHxZELwlHRETsimRciff+yzerjZd9MhOIbGzIXp6F9zupqazQMgXt5bEzshMa2XH0STtCtFjKEc8/tRvtGyhL/UaOqR4FVjeC2NFLTyH4MkBrPT1PT+xxFNlmiK8VIlaN3IKIV2z91lddswVav36acZJmU6D++tHYo1OaIdeUMRmLfmXIZgvjJ3cVDV8yCXrVKzYcFuC8Rt1dQCE9dSRBFCXfIPjB+oHJ0HfBADIx6q3X5Qzryo4m9/UhqEjvVrrB+nVZAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYEbkHUCZjEl5bdFrpsg+CPclEQ6vnsw0fJOci4oa00=;
 b=kxO3T3GB3/mG+AYl0eILNbWE/nyg+3DbkT8HnWOemnsToUK0L8y9yrMKiY+moQeH5PFddPtuejkcTcX9WtsLuyn/C+yPP414wvVjEShgPdQ/oMzMtP1vmwQXMp3vh3076568iwxbU3Mo3F48LED5+9PO0Ua0NRxR1K6O97pPOdP8ZLXutCMNxEfBaBRxana8/j67Qzo+jBpFdEfFCCitzkdvfg7jRHkTUqj+9VMJESM0TUR71TnAC28xRi3Dmw+IJi8A58QLYKdanyT7YBncpHslg2ZgnKoAku7Ivm33zUjegM4AJ1XvKAPezLi3p2URW2tJiJJUra/o5iq5bVNZIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sat, 18 Feb
 2023 15:59:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.013; Sat, 18 Feb 2023
 15:59:34 +0000
Date:   Sat, 18 Feb 2023 11:59:34 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Respin: Rework system pinning
Message-ID: <Y/D15urtDi5ZyZJ6@nvidia.com>
References: <167656602090.2223096.15523567129751109800.stgit@awfm-02.cornelisnetworks.com>
 <Y+/maP/69VMafscx@nvidia.com>
 <e21f555b-4429-fca0-b8b1-e3e1470261b4@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e21f555b-4429-fca0-b8b1-e3e1470261b4@cornelisnetworks.com>
X-ClientProxiedBy: BL0PR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:207:3d::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a837d8-4590-424f-6978-08db11c92142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ET+1Sr6Wewv/o7U5cCWY0nC6LHib3pwxgE1HhwUHdP7RGhvlT9rA8FMAgyAZ0C1wbHn6faX+K6mz3Et8mpDdDdwXV0pDUiTATBw9Yd6Cbg4+f/eEhUkUyo7qzov4VLu5kZf9GA2j5xkZiQ9/knyURE8Qqbu/j6aUiuMfG+7/eC0WmwO2EapVMuvdMS/GG0svo6z56Ie5NMnaYF6bEDZELrAEeGicd+odfQJu1k+VAxmOrxDOq8Tis4eE7xGUXSeWRxjwY32sHSQNrjg8jhZcGgyELq7+LjSLYbat+S8q7BMYvvBP0uyDPtcuUY5AJrqf2MyX92GQJN3ktnmrHeEWsGtJVBtn447VhVFU10sEbfu2L0ophgVcc4MLMSoyYba6wdxBSx1fDQ7dY2NarUCCI7m6DfiJr2Ot+LdO5Hmi7i89LCPthu0CoODt0f1IRmNusVHx37wyXKmNsmhtfxB4gYKQNeDFZiXrdWqmI3S9IQ6cPeRvyjCwJHQyAM0hVvm1atR3gYcXL6w6AE4ri1jdqEw9369du69K1+gGX4qhlbmR6Bt1F3KhxTPtHiGEa0YixJHwGtk5cS0dJ9Yu8DPm6OqYxztkA1SaiwOjrqot18N4uWfqIFsWi4Mw1GOFTz4mBEwlBRJXPAXq9EJqTKGlxeJZ1KQAGOcUwPfZM93nMR4YvvYycL52VF4/2h9mZloX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199018)(2906002)(38100700002)(53546011)(2616005)(86362001)(316002)(66946007)(8936002)(54906003)(36756003)(66556008)(5660300002)(6916009)(66476007)(8676002)(4326008)(41300700001)(478600001)(6512007)(6506007)(26005)(186003)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b+Ndf6rfUhVJPeCswrZOsRFVdDdIrIS3bEBFaIBdj8cj0yIr1sUiYC+OWuxp?=
 =?us-ascii?Q?1PWBi+o4QX2uDCzfuaMF3E4KU6hKnnYrsOAL5HBEsZKIsYJfmhHChbI0VNgt?=
 =?us-ascii?Q?3ZpvqoTkDY89v2RUHGGPHKu8idVxZcyXtaNs/AZOwHYv19/7BxfYPZGjnbiR?=
 =?us-ascii?Q?098Gvp7IR0VmRTmsDaIkhfDWNyFpHWqwXhfc7rg6kWMtg7s53lrteiYP1hr7?=
 =?us-ascii?Q?s6lHDpxIfIDfagVLnS06GV1eNaRyjC4DabZ4snFJTSJMbQGEA9FLI5gLYIAU?=
 =?us-ascii?Q?3vbFJDKYa+6q1eEBj9+TDaCmDZHZlrxXHX0lb8wX+BYCWsEeO5k9uucHr9fb?=
 =?us-ascii?Q?seshyH2qFR9V+oZK2ih/vG7B/8Opm4g11ggFuZEePZG5M37z1aoRzkjBjUK3?=
 =?us-ascii?Q?FAmzBxzE5dMwBIiYsx27kXxt//+4QbiXkhjj1QvFOkcPtqy0pBxem670VQFa?=
 =?us-ascii?Q?Oi5kpJGkvoI0adNTRDzQ4JQFp+lUUbBpO5q5OXAvWmEF0E7dpSM3qLueHRHL?=
 =?us-ascii?Q?ULQ2auEZDhXv0FRI9jmp+ZyKfNjzUmENroQz/yAywzB21yIeg0GdUZXDadr4?=
 =?us-ascii?Q?WqNtEZ+r7PdcMqSb+RisEKq38QWeguGpoqB1HVs6xnKbZFyZB6SlU19zNl2n?=
 =?us-ascii?Q?7dZraVmk47SYzi9/md+pZlQOHlb4q8a3SGaIICk6D6Ig5Jn6hpDXkhQDfCQc?=
 =?us-ascii?Q?R3wIvvDvdlG8aHUoSKUb51dGuVETaBRbCPZLxxfgw6r/1P+1XGTbUvNX9HyN?=
 =?us-ascii?Q?DYMmmmm4zRpGRJ6H5TQ1VvtyA1XOFMiWJG1CpQioD5+9arI8ri1vRUqfwNaN?=
 =?us-ascii?Q?B6xABJ0YOpceJbZzaoAR2z1QINLO+TE4va6MTn7Na1oV34SquO8RBraK3vHo?=
 =?us-ascii?Q?IEW3gUYi0Pc0r7qM6/nj/CZ9vgKfTDb+N3TC6r8qalGoJ31oPIix7TWqMSFg?=
 =?us-ascii?Q?YHUC2BZLjFNG0dqecYnIpAJa2d2vZJk3fXxucr2AGY2HRKWKmHVFmkwCDUOF?=
 =?us-ascii?Q?dzrBF24XDcZqDikZYALVnKnBNzhxI1AY/botgrESkroc9AaOnopZrpDFsy85?=
 =?us-ascii?Q?84j+L4dWjT16z767dFD042/GfGy8pjGvI+IDwPzMD9FnMzzmkwwJUjFgwzO1?=
 =?us-ascii?Q?g9FL7GevoCZOgEwivwfTllE6VSRGblrpaxwozz/6CYJkKzFfCTupvfKDgrBK?=
 =?us-ascii?Q?CFfRKUNvyVmakcoKvQ+R8aTFR5AbOsk64dKJpeBwVIXZ0/aOyni2m+PO5dwR?=
 =?us-ascii?Q?sxMha/kTE5QS6YUMkQEcQr9+kswBQ3wAQusKDzy3TsZGB032ls1vwaROUUQm?=
 =?us-ascii?Q?eHSaSo9yQeaaB/YHATxV+cBe6ts0h74cJVnsCouxN3XKkJP5B5OyxPOS/hhi?=
 =?us-ascii?Q?4WMpRida3RrfUDId477oCfsCPA5kGv5QJOW9WKNGPSc4ef2oJUZTaJ3TWNGU?=
 =?us-ascii?Q?53JIT1DL8W64x1chKkHV6ikgNjSSOJ/DxObkX/gW2TEAJYzY+EjK3UArRSrS?=
 =?us-ascii?Q?awf0jDYY+iiB8F7uiBGDIc1UJEYSG3LjD2E6siuEHcxNBcviQnQLtR56ZDvM?=
 =?us-ascii?Q?Ipyry17/fPbVNopuRsjy4F3LZ52JLlbBpRH7g1gV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a837d8-4590-424f-6978-08db11c92142
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2023 15:59:34.8093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onX5OVdd/kChYTetQHdjKZMMoJZ8d5JE758RfXTobkzU5S9yJTfNcZxwRim0wlEN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 17, 2023 at 04:40:32PM -0500, Dennis Dalessandro wrote:
> On 2/17/23 3:41 PM, Jason Gunthorpe wrote:
> > On Thu, Feb 16, 2023 at 11:56:18AM -0500, Dennis Dalessandro wrote:
> >> This is a respin on top of the latest rdma/for-next branch
> >> of the series being discussed on the list here:
> >> https://lore.kernel.org/linux-rdma/Y+EbyU4HkGyzPoFO@nvidia.com/T/#ma3d153151adf1dbe2b9800000fa9a01f95a80c1f
> >>
> >> We have added fixes lines, and Brendan has discovered a couple code hunks that
> >> do not need to be here in this submission. We have also removed the stats stuff
> >> until the user side code is readily available.
> >>
> >> ---
> >>
> >> Patrick Kelsey (3):
> >>       IB/hfi1: Fix math bugs in hfi1_can_pin_pages()
> >>       IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors
> > 
> > I took these two
> > 
> >>       IB/hfi1: Do SDMA memory-pinning through hfi1's pinning interface
> > 
> > But really? This is almost a thousand lines in just one patch, is that
> > really justified? Can you break it up?
> 
> The bulk of the code is moving functions from user_sdma.c and others into a new
> file, pin_system.c.
> 
> Not sure a bunch of commits "move XZY to pin_system.c" would be very
> helpful.

One doing code motion would be fine

> To be fair, the patch was posted originally almost 6 weeks ago. In that time no
> one has said anything so I don't think there are a bunch of people chomping at
> the bit to review this. Any suggestions to make it easier for your review?

Linus will look at it, it can't be totally crazy

Jason
