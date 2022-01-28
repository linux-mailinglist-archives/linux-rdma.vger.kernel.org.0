Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E1A49FE66
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 17:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245567AbiA1Qv6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 11:51:58 -0500
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:52010
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350326AbiA1Qvw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 11:51:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaprgUGk1Cz2kDvcHfiv4wUalXrk11j1DMLAkEImD4H03VKnTWIA1MLZXQY9IhzrYWH+qHWddxB2TrDwqaNFbDVUldhTAHTFS1Cg+Oewh/lGk0IgqzYYHy0cNy/zrRDCQQ6Fve1+7lORs0jvhVFOzQC976WxNQqzj+uICQbZ9W2LNb7esO7RO6p7JiWZmhNKWG0doQc5GGYqfCHFgG07sjBGNjXoeoc0/DR9PUTrdXavVkosbYwjmyC6py1ar69Q9tkr+q4StRWbrnb8y/uKaeqVY6nHZveUimai9tk0CuwGTVInlWWsUlkjlQikQIwkQ1SJcOuQpUvsblk/zYwjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5Br8HC3G3bkFeHaZa9ZYpAmq+VQxKcozH0kDkxKISQ=;
 b=K6W8A7eR7mkc4W1LzVewdLAVl+qk9WI/KCngbWSzBAd2H9d0BRftuPoXrHwznAz5d0Czw/OXqG6H8RYi2Rqp2eQUhvwk/QPtOO7UYjjN2oG+gSwpkYUhE7ee4wh2+BW4uuonAjbuzRIIbjtiS6cZnXNI2NlYW5Cm2AB0tn7dvUPZjwSUf8G6Lh3+mVgvXnYJgHd6imoNz8CBVGGmSvF628mAUMHKmtfhukWe2Q4SdBgf8a9wkHeVKWHMTdJyeCdWLAk/ORNmGHOC6njeJXTu9R0RP8glbl2QQnuqsNSP2IWIsRARmt+/JbpjP3k4QhwXVOx8ySlbuvSVrdwfZH9bnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5Br8HC3G3bkFeHaZa9ZYpAmq+VQxKcozH0kDkxKISQ=;
 b=Jw7GmQ7PkXpwppOsH08gVG3o8OATVSftQwNcM2xCmBFaV8lUAtFg+gMKt7yX3jTW+4FU+4Ud80bhfL8ro7FkqPehe4qJygKrfrWu4TGqJWEhkhWWZ52AGSIkyZlSCgjnbXjrmBiudSXh7ASEZtEX8EcSa24M9MVMSvnS/Z1Z/yMJU/fubkkYV39UZ1HVyQL1iwpmV8L1sBvwVf6bPh+1BRzBqWhpT11m//9NxFxwfhGDudalCSOcIqlQDpXhQGNw8wPp1yP0WYoZyiqvC1E8mTGQVOJwC4n9RAiyXtUf2Ru5SIlVPWU7z0seBPEHnpjk1Uq5aTjrcYLQN5gxz/Ua9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB3857.namprd12.prod.outlook.com (2603:10b6:a03:196::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 16:51:40 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.020; Fri, 28 Jan 2022
 16:51:40 +0000
Date:   Fri, 28 Jan 2022 12:51:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     mike.marciniszyn@cornelisnetworks.com
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] IB/rdmavt: Validate remote_addr during loopback
 atomic tests
Message-ID: <20220128165139.GB1870180@nvidia.com>
References: <1642584489-141005-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1642584489-141005-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
X-ClientProxiedBy: BL1PR13CA0308.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de63adab-01e6-4252-4448-08d9e27e74e0
X-MS-TrafficTypeDiagnostic: BY5PR12MB3857:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38571FB7AD3529CF9E74F74FC2229@BY5PR12MB3857.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmkBhdDCVqzhK+MufnHOmVbD73lGwdw72s4Sh61dFPqHjmDiIi0Lmt5SFagM0AghqYQo8rWh0QS3CgUU+pVO1mPyIlTRokUuqn/vYjldEwm0LHThYJHnvq3sYWudI+tl4Xyt6A4LPdHU+tCTCeH3IhyFxdRngEyNqS/T+sFTbWZjmEjTCLkqPD7SQ12sZmUhs6k/3Q7EjKO+qpZGcj077NQpT/dzzotDlGAd9Ff8vyNAxpNmhc/1/TAP/iegoRpkBqwRY4/VNQ+I9bNZU0Ve3hQa5NaAdPvYIGV+tq25FFXjeupaD/HiFgk1+VEmMAwdutqZ64IWlRWFqU23ju3u/nBTcWyRehdAqOgiGrDTVq6wNnrSRjrQ7p6n/c1DDsD3q3r58o4X/Eb4v2TzWnQu0o6d3dMEyZVPS0PVHUDvAxBeg7uOkfqpiv6kLPGgJDa/MOv8gUi2+hDGyquoYD35H4/xuBX6JLRrGYimvnSFbkBfAL2RqJWph8saE2QorCQVvpzr+nTRYoigMFuTXMKjLpjpN2/wD1X6nuqj/tFJ57O88KpWxMwrLaO9tH+Q208T5tzWkyLmwUqPvUBUKqJwIWYLvRFNqZCPicCbZ3qzbrGEdYO2yAylJ2E14M5QhtII+OmJUl5LVcPVOucGXAapmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(33656002)(508600001)(4744005)(26005)(316002)(38100700002)(6916009)(6486002)(2906002)(86362001)(15650500001)(186003)(1076003)(66946007)(66476007)(66556008)(83380400001)(2616005)(4326008)(8676002)(8936002)(36756003)(6512007)(6506007)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3oyV/lnD5kkbCpF9slKw3j4F8bmJ4EFL5sncf6NNblETBnEwhDwAeYpZe3xB?=
 =?us-ascii?Q?MxcJTtpNCBJ68tNQkiL7xNNebVKAZgfUXvGA28v0URsLiB+mkkZlPwfCETBE?=
 =?us-ascii?Q?HkHx+IbzeJhWtax2pH+p7bXbiR/WAX5utlRPnFjZA9bvWW3/uWMflE+rw3/f?=
 =?us-ascii?Q?2arhuwqTL2dNl+shwg9R6IAS9dy0nJ1oyBoqYdwRU8VaywwOGNqu/3u1eqpm?=
 =?us-ascii?Q?vWonlfwpX0RvUfQ6DDzC96+f+gW0CDU6Q2Ktexq6sySLnK5fD83P+hSmVY8q?=
 =?us-ascii?Q?SYM1OFLXlPOcSAhGpNPDY6xCYzRTdCVctmtzDACVg1tejyhm7awj8Wy3Sw0d?=
 =?us-ascii?Q?Rmvr3OkPBM8S2rX9cIIow9/HmOer5rZrlEJsHVqfO24K6qiawc1gNDDF/q3L?=
 =?us-ascii?Q?Ie4iE4h6BbefeJ8p6hHzJzVq9P/n96H3q4HbYLlmo2nnGj6cZKMT6oqgNzu/?=
 =?us-ascii?Q?u/MEWjHGDOroDqWQHF6LGQNDTx6dXHkABtA92daaoxceAZx9axROsqPFSK84?=
 =?us-ascii?Q?qzJJhnKoc3P71h+5fLR65XL2hxg8pxTAi5n/nht4P/lxNfHM+L++AwZZQTcG?=
 =?us-ascii?Q?4aroLZvsI7MLgs1kZXY7fIUaTv7Ly+S/vSIJ2IwrUdtN5AP0cdahmWr8Nm+N?=
 =?us-ascii?Q?ItmBdL8BYRvdtbtuS8XvzOT0Mq6mOYkEt1+JlsQZn4UrgWWo5MxlPrX9lRwr?=
 =?us-ascii?Q?AD5QxI9707Uk1AADdE+yUe/uxTtFHHcMdSMPfhM8AMgYXAaWOVc+2S7MMX5X?=
 =?us-ascii?Q?zlF8o05NGwRaEH1w/fVFs61hPvzzsWC9xDK9PexJXbwfitEytN2+4JEzxUwV?=
 =?us-ascii?Q?dFFD/6xzy9t2yVRE3j649Y4qRp1UYpoxWFReK48ZMW6Gc6tD8Tv+tqi0qAGp?=
 =?us-ascii?Q?Y/wvra+UFc9EZSzzCMbjACCWXI350YEf+E0Qg+WPYuMmruOZ166+t2+UaYn+?=
 =?us-ascii?Q?rddlGBTuDTf7xQrZByRTw3xxvcXR5QT8ySZLmarVTbNIMun0cQtYRrOPYWw+?=
 =?us-ascii?Q?UAK0uB4thsTpuONE/PURL9rXmd8PQ2AjV3V/vzOwDEEzaiRUJWvxMPCff7Bm?=
 =?us-ascii?Q?JoJ0dztl8Wz7TqExw0R7Cr8Ay1vgHMn1TBQcVzsiZzboVH+CQqSFt6IF5J8k?=
 =?us-ascii?Q?vaeUufQCMUhHBUhqukctBfxI/gHdD93zkGgOoGQry//Nv9PMCc0ZqSHINK7l?=
 =?us-ascii?Q?4Xq1lvlJ4WBfrSGKIPa1Z1yL0bLdIvFazIW7/Id65E1nv4vaEiZ6LZhr5ezR?=
 =?us-ascii?Q?4kD2MRjXH+QtMIE9B0xVYk9+B95UP4DsVHRFNdUAUR6Kz90vVEmGdL5OZgSO?=
 =?us-ascii?Q?Cda/z53h96rIOQIwFq/IvqoRmiH/Bq1kH4TQvt5STY9ZmmYogk2xHL4oysED?=
 =?us-ascii?Q?ZsF9KBorsIgrNxTf/O1XxTYLRotu/6dWjjsAU0afZ6KRjRteBdSHX0nLnCzD?=
 =?us-ascii?Q?9Y3PPIM3PXKGJDIDhm4imtDEV+URgJ7iX3+OHNrcHvLsNuY2nO3HttpyWW5B?=
 =?us-ascii?Q?tzun/7YGSHM8OfvEPPNw1Mkvf8snzxeNjIcnKGWppbJf3gGMwsXWOg0fGy8s?=
 =?us-ascii?Q?qvf+nzY56qnkDVSj2IY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de63adab-01e6-4252-4448-08d9e27e74e0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 16:51:40.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzuYU1qBpR1CjkxftSxdavdxUJcEDZPPmxBNeZ2PlOf8vbWEE27ZjcJRrKMmEXwd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3857
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 19, 2022 at 04:28:09AM -0500, mike.marciniszyn@cornelisnetworks.com wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> The rdma-core test suite sends an unaligned remote address
> and expects a failure.
> 
> ERROR: test_atomic_non_aligned_addr (tests.test_atomic.AtomicTest)
> 
> The qib/hfi1 rc handling validates properly, but the test has the
> client and server on the same system.
> 
> The loopback of these operations is a distinct code path.
> 
> Fix by syntaxing the proposed remote address in the loopback
> code path.
> 
> Fixes: 15703461533a ("IB/{hfi1, qib, rdmavt}: Move ruc_loopback to rdmavt")
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-rc, thanks

Jason
