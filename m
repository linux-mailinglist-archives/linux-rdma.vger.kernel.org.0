Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B99772CE23
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbjFLS3U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbjFLS3D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 14:29:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060071BF4
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 11:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCqhrLVOKzU1DQak/1H0YNSWoXNX33yAFiZ7MkR8XWsAgLfbBT5+yr7S1auzcguTQGAV71MVLnba284IgLcD+o1rxg/T5Bi9TLWyP+sXoske/gAApy/u6NoELWKXldnBhhQuQl7cIopb9j+tHiJLWs6zXlPwxn3c3mnP5ofTGt1MQr4jOW/8umSQRXFT30SdJ6yWoXkpV6ZUymbikgq+fYRLTN6WSqyGJd5/LGOc3u1UOkzY47vl9a8Rdsw7FgKFKO/ZWW7pb93N5zIattvRAO9/PpN8vGEjCCFcfUOUig4qXHlPaCZEQLhULUzxa/6mH0Ycdvg+cjJGlojxaxuGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/3MZ+sausugz4lPTgBo0055Vs9iUJk8Zc+rPJs2jd8=;
 b=ChzX6/lLf0OJTyLdppC7DeW1Jn3/yg73EgPHYsQq5+yJ5RsTLD9YCxz4WVNteSU8NIYDVpkjqj4W1UZsTdI0JLGORsQhfYeinoSIevpQWJHPCNXKFcnHSqp0uoUJ/XxcocIt/dWY0gRoeTUrZ93FAnTocVKiIbaycaoGbnDm0JSN+MRMUvDZUHUY1l0bcoq3clo2kIuzu7wPUNe+z4PjJtXctsRoSU+58bVsKgYnqyxpLy+ZVa0GovTwLdoKqt/nsZo5U8BqNJZhMveMHUKykL/pbKbQwqTyxZPvR8X9rHmk0Ksu+2nJg4CCB+SL1ak41fd3aPbnnm/FttmsS6PRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/3MZ+sausugz4lPTgBo0055Vs9iUJk8Zc+rPJs2jd8=;
 b=cCiZCUhi9Y4Ih2R61qs61VDLdZX+M1gxEkMXATFJpDJMCIU8wri4+/bLKj5qHxrWO4E+D8AH3dYbVQ3DadfY/zDI9w2cN5r2ONgsjgcAxcoY0cgqfZx9RNKL9VOj/Frb3vFM84mqQMe2Q/R5pp3kk6CFDK+ic08HGICurNrWK4J3FHEH1FqsNl6f/LC7rkrglnZ2vjVupkVDbzUjs/K1joKwuXr8hhB0nfZPo+ZJfAnm6hIZw92+P/+DoxJ6Ag6SV1I1wBZb9+Tl5pwC8DjLo8XLz4Sicr5H3ySU3uT4WA+ju2hvog8OZ+ew7mmTyuEo8BzFLZB6YRTe7SJnhlCaCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 18:27:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 18:27:53 +0000
Date:   Mon, 12 Jun 2023 15:27:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Fix rxe_cq_post
Message-ID: <ZIdjqAVIjqHUEEnj@nvidia.com>
References: <20230612155032.17036-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612155032.17036-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:c0::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: 275515bf-9050-41d0-7ec1-08db6b72bca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNcHnW/sweRjhi4K0bkMekhAN+XJ4N4riu190Yg7AfGPeLxQC2JaXs8R9CdJ74rG4M52T8T4/os2K3tqhVCgaogSlsSOAzbVxkAUeP2G9MT1EuyURjRWK43AijdH8Sq3tag1v8peDgdAi1dSNpwmxI3olHI4I1DWbcQHBo9mRZ7w1BfujUeIIebuL9esEVslnsy1L3JjFYzU2MeVbXMy3RGQ4GSNjReU9PbdQXPEIraSweMnAew26YDjfMjVmwIdPHDrPPc54+iaiYE8ylJWCH0QPR6yCZveXR8aJIrtVcgHiJY3aH17leoyGEjmsWKjnjuL3W2OTwxpHfcly1DmhKDfAZ80mf78+j+/AmJkhnHyYPlmepCN5CzG/E5L4gcAxBcLL6WjpY4ivcYeM28wkoC2oKkzrP9K39V8AP6WFN/P87mwPZo8lyJcQuLiM+OCFlOA/BxhnQD23z42zckFdXCyTs+PeijD6Xb6mKPyTdyFipxegI5kqnb34HWBYHJfU9fiGgOFruv6JYgjp0xHW3KI5p4u5bSsllkM1lV3oj6zHLKXkTwdkTx6Toh+Y1vO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(6486002)(36756003)(83380400001)(2616005)(38100700002)(86362001)(6506007)(6512007)(26005)(186003)(2906002)(4744005)(6916009)(316002)(4326008)(66476007)(41300700001)(478600001)(5660300002)(66556008)(66946007)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rTUiXbJQHwZWrocO+2MoGmE5PVsn1+fvA8mPTKPYJck8m/Xxapy36hqKC4cI?=
 =?us-ascii?Q?Cm/2GDI8Qyrp+ydC2jtj5KEeNx6q6mJI19mCQ8zTK6Cfs1djb3ivRTPoq9GN?=
 =?us-ascii?Q?s0WJ36N+TDTIroV0Ya26W+QmCzupeMua8UL1AGf07NIfjRNoZiHPWUJvHgdJ?=
 =?us-ascii?Q?Dg1vwfoF57hE3HDwJizdfwzlMEE6opgl3PRVJej02Gki6tN+xAnS2seumE4i?=
 =?us-ascii?Q?2Cx/IB7TRHUDewowqvNhdehGxQNMD8QcH9j+q7tHWGBDnv6shBTktL6r3BFp?=
 =?us-ascii?Q?t2Br8AHXHJIfLL2HYIryYVsFdfZ00AAjA1eqywwQG4Ka6Tazi9kVt2DTDgZz?=
 =?us-ascii?Q?FqQrbRNotzErNOVEvLux/T+RDPXpfSHyq4jxCxQv/LiQgMvL2S1W9qHZEbsk?=
 =?us-ascii?Q?DdSEC9pKNlqeKeausPCKYj6VdyUb840DVGUG6mF7NVDq4+abWL8uxPhxgecY?=
 =?us-ascii?Q?fMlwTJtqBVIy0S688As+H9xCZlSheC5RNQaexcgr+kGY4pRYXdjxCTx3rJuD?=
 =?us-ascii?Q?fpGpMXw5cS0RjEeGpDFFptnZJAzxtaHmjUw0F0ifl2EJ6c626+793QtEqyEk?=
 =?us-ascii?Q?BoQQUZDlcRonDrkWY/AqE3Cym2/NTRN6s4M5hUxYxZI3mt8yFK0NO6UiEJbJ?=
 =?us-ascii?Q?tXyrNGXO84Y6O9Afxg+IsGx+4yy0tVRq4KMGvPtdr5x2R3qKaO0i2/Qz0dBC?=
 =?us-ascii?Q?bKyAD4QunivJQmD26nk+Uw/2PupoRghapjoRF+I7bLXyJ3MC84KWaKrNvyv4?=
 =?us-ascii?Q?PJi4qyYtHfarE/pFKfqTF8Wv5qRJF7ZlZJ4+4y4NUezY0vDUE2kPNW/6RUje?=
 =?us-ascii?Q?5RSbACIoCCoy13xVvlW2lkvOE6wPmA4by6hL+D4D54KNMsGKd/TRFv/TQkez?=
 =?us-ascii?Q?w7Rpj4nIjkuGuixDGwbO05yIqzv0/AdRsTSZAdr8oxy7VPlF9L0rjppNMQZm?=
 =?us-ascii?Q?KiA7K88HWRhEjvwYu4U51AHn7G9Vk0wkAgmnxEu8GlOmbEwX9Hp9GDRBvVIn?=
 =?us-ascii?Q?HSS9u2Aue6cpARwDmVWADn57d/bWmrnz6hi3WhoIj//zjdZDtwNJH8weqxZz?=
 =?us-ascii?Q?fg0zNCuKgs1I84NBCOWWcpDxD7k6OgvU+a9AUYauiY8JA1cefwxpqAnvLB1p?=
 =?us-ascii?Q?VZapbpJq+6mUELDzCAUTvFWhU2IuAhJqYeIX+1GOX94L3n2++1mC00psUMLM?=
 =?us-ascii?Q?ZY5lET30thRrmfEdYQ5MkBjN2h+O0sne4rNkGAXiWUQtbN4lNRX+Hgjceatw?=
 =?us-ascii?Q?FcHER5jA/OxFr1NNWpWfyO9vVFUhIFDldagw7+soL0WWTDQr4kf6m393MLxT?=
 =?us-ascii?Q?Yra4SbZEqFPgru0o7ko/7Ou1QwiLjxZGhgLILtsYDYtqwdGfU6Yzdx88udBV?=
 =?us-ascii?Q?TrzQZENqeD04evYRhmQd7tv0BaJUWho8bWbQlc/TcVVMTsNS4iy9Xtl4lZt7?=
 =?us-ascii?Q?4eLTFyOFe2JTzzPngVkntgyhMNjkKNqgJLhLx3RvTtwbE59+8ueWUycAV3zw?=
 =?us-ascii?Q?gNxtk50OclgFocfcDJKXNa/2ggCj9zU6QKauy41WrAXBC2g3JVUIcXPGApYz?=
 =?us-ascii?Q?31GeAn4wRrbhzZ72jQO/uM9WNRkIEgBLDTY1LuA/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275515bf-9050-41d0-7ec1-08db6b72bca0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 18:27:53.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXGeXY18HgO8fzJl7k5q7CPyvT5EfXOxq9QFb5X9HptNZoO4ardOUlWaDf8IDqU8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 12, 2023 at 10:50:33AM -0500, Bob Pearson wrote:
> A recent patch replaced a tasklet execution of cq->comp_handler
> by a direct call. While this made sense it let changes to cq->notify
> state be unprotected and assumed that the cq completion machinery
> and the ulp done callbacks were reentrant. The result is that in
> some cases completion events can be lost. This patch moves the
> cq->comp_handler call inside of the spinlock in rxe_cq_post which
> solves both issues. This is compatible with the matching code in
> the request notify verb.
> 
> Fixes: 78b26a335310 ("RDMA/rxe: Remove tasklet call from rxe_cq.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
