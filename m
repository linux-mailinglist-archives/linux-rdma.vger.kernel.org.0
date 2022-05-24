Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B865329D3
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 13:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiEXL56 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 07:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbiEXL55 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 07:57:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102BA62BE5
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 04:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxCSzvHQdjR8bKHrRzUaL3TKf3gGonU8jNV0YcADbS5OkMoith22roFCLvDAKgwlEt8qGSQ8mBaqgB/8BSD7gOBRBq55bflSPqg5LIraV/FJhIo03iP0mepcwHCqZ9JuLNf8WC880D1F0kY/BxpAUek6yhYtoz2kybiRFmruYRgSGG3bCmh5DRlWj4bzr4AMOILdoizIXVBkHZBohLkH9nC6NupjpwvVlAUvyxLKXGHt33t+zmBgztk0WXU7GnzVCt9uh/ylyvJ8IYsXjyAI0V4t4pdTBmy79LrrrPJftxodOcw6bfxglL0F7VLSR3Vv0en7VyZPa3rj4ncrjcEHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsR5p74ofOUPlh9oDNvuf1Vmm81yKneL+FaLmrlcxmY=;
 b=RTKYyKH3ISlbCOSSCF/gbL3kt647z+BFU/g+wT+dq/5aR0sWFHdFkUANhB77j6eR0tu0vNQ7eqRct6257rD3ew89TG68pNki8gaHRWztt92qRZNhIqQXz3NMAc+XA1b4LXIdHvKmvEgXGyziW78vUDPH9Or1hwTIkrIkP7BInRpeC5uxmly6BNJXbgEajsA0P9oRRYuO674jwCtZBC3pMuSMok6rtqjrb4DkPPYTmRcHc2rNgSYeKZsWC2hMnIgY1pC1c032kkV2xb7L5OKQ86XNXvGNDsGt01/j9yk7hd3AnwbPcZIdNwd3Q/Jn1IZKi0OjXjVXUrCjYWtPRmK2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsR5p74ofOUPlh9oDNvuf1Vmm81yKneL+FaLmrlcxmY=;
 b=seikdazD+9w8MbLlCBLbHNP+Qq5U6fAkGRFfcQETDlHphL9d3xCrONW1XSkbxorwYlwdypqF979451TtIPG529j33dKGhTqnVtjEEgK4TvpNLDEXHukYEMOXNRctZFTRhogtG7E5n0K+prSWT1LPhMkzkTNaUDgVrZQrDxUhiVG4l43kOwhc44GHtG8TP1aezK2JAdZAK9h74P+s+kyseuBBIHsttTU3rywT6O5LLxn4WarVg35pSgnGxvOTiwBRJ/2xAhxxJ0a+tx1d2XSvUxWPNQWdHbrvZv1saBj+dKhg18bUp/3tEfaLcIN5OswxlCdho/reVfO5RsRGRsg9Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Tue, 24 May
 2022 11:57:54 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:57:54 +0000
Date:   Tue, 24 May 2022 08:57:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v14 00/10] Fix race conditions in rxe_pool
Message-ID: <20220524115753.GO1343366@nvidia.com>
References: <20220421014042.26985-1-rpearsonhpe@gmail.com>
 <20220509182353.GA927104@nvidia.com>
 <6012bc26-a2f6-c05f-a056-36aac02797e8@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6012bc26-a2f6-c05f-a056-36aac02797e8@fujitsu.com>
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9680bac1-54e0-44af-a666-08da3d7ca2c9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB28128C51DED77D7794F1CF84C2D79@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3SNtN7K5ung9gvcSFf/X0kyMdkk2PsBiowIEhWsZQwYmrTcuHFS1w215mnh19oHWDrssc1nnopMwjC/bIhwH1uH2DjpDAeKncUDZzFRkZtwfunVuPCJvWn8zNPVQcLZnjh4sbpNOkgUiKzB5qDFKph6E/dyMDigDzqimxPnCMZF13NBO+DrpEMolaGLqbo/29Dmkj6+bjZBQvBBsRtiF/tWTiXbKcDII3FjGSdTLjqQV886PsMzn52Nqt4j4qqWWPUg/FBgWLVhle1/1E38gPj0HOwLgkUNt8xWMPM5rRxTJpYDst6+6mD6pP9OqVoOS+JNiFptWyxNgSoHR/wiaX0L6cCT3gaRzuaizbN6bwc+XO6K0hFM9gtU7oKjMW/zlSEbALx1MUJ6jkuEfalAeGK7KvSxmefmlIq/gfrCT7YcQCKDBJ1jEqx81onp+7/eCjymczzMAL7QUlBJlp32bl8v+90etu+Vi2Tx6qGQXqKOr4nd1DE8XDbyIJmfkvgvNf5+VxwDbshK91tsSvk+QfrWEiQgmxZkcRxK9urM+RyA9qgAPVE/6pfO92q81Q1fwh7Lg1WVmIAqDpBdwikygLX3uHm9CvgSXv/8hnYpJlvLqkVl+DUlux2Bd9WqcjcpLxUFnv0BLuvJABUoPZby4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6486002)(86362001)(508600001)(2906002)(83380400001)(8936002)(6916009)(66946007)(316002)(53546011)(8676002)(66476007)(4326008)(66556008)(1076003)(186003)(6506007)(38100700002)(33656002)(2616005)(5660300002)(6512007)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xr+A7ZNJ/PC16fgPCDyqhJiXOyDS59XEy2PXBXpX6bxzPQckC2xOsPLJmmZe?=
 =?us-ascii?Q?DXQqnvptINbzrzj0CNDXDG5hFtVk9FynV0pVV+qYqPJxXcoMmXizBUG4EhQW?=
 =?us-ascii?Q?1TY/SMxFBb1O2f2lmuKSLU5DedW5Kzhb385w0FRE3kAsl+B7lipV1a56nqt8?=
 =?us-ascii?Q?X32AkODsFh7jw/uLQ8uthxyLETyH9JRb5x6BDgW/R/+vcNP4v7omVjrVisfD?=
 =?us-ascii?Q?v7Xk+hBE5+tX1pIqhUP1QJnF30S0m6lOC3JRq0ZIm5sUEQ0iJB1Vka7vTaSw?=
 =?us-ascii?Q?TD3tX+2aRBpuX3KgUE0j+ToIFpv3kdwQDHoFofI8IO5yb6A1ofzaY5mlUCQH?=
 =?us-ascii?Q?29TUSocYGr9Bx6ZkgEIQhfPbKLvEHUhe/tCeoLEgSOeQSsms+mjZJ3i3Zr6U?=
 =?us-ascii?Q?Le9ve4KQzobjD4Iiv+Nvqt8jbXP2Dt9MuKFz54TuvjWgjEwYcUsvVmuI9kN1?=
 =?us-ascii?Q?9NwM08B2pCPtLoI0mPr6hQQVCTlHnIvcVD7xYY2pYAoiP1ADCOeH50bnqXFp?=
 =?us-ascii?Q?VfmSsODvDyKkx6gnrRhyYw8Y/3r2LnAGj2GUh9TUeIxIT99iptHbJe5E0Hp2?=
 =?us-ascii?Q?a6ccTDb0iTT8B/l486YhByyL6a2VNws/U2S6QvMQPoh5ESZt44DrHRHlQOYN?=
 =?us-ascii?Q?ZlaMogMBCDVVTTHBxKqcE6VMwF2/zk3Dk9r8dDcoH0t3unKU0D7r6uI70Sbc?=
 =?us-ascii?Q?1JeqLrGQwHl3/810l611BAn8ASfIgi1SE0im1s1sZO1eX5+hZTyj7WjbbguM?=
 =?us-ascii?Q?O8cqJoKGg5EW5O8AWag3QRyY2SqK+ZuY/r6BhH7v8bDO/xCNWVGKiZgyFGvp?=
 =?us-ascii?Q?ux55Mn0kXRdW4ovg5enenm6d/u2QqYn0M76ohm0rXhvzzUXfPGDyzVJZr/US?=
 =?us-ascii?Q?taTWmAFQOpKgZzrEM+8IINnDSCSixrOBkSkexE8Irk7L8yQ7VevYzTijHa/z?=
 =?us-ascii?Q?8eLtbhJ1kAh64k3VgTNkoc2fDbnU35iAVRuShCIvy9D2jNe4EYkPX0E6easT?=
 =?us-ascii?Q?OtfYXvUGXhy2SHedjWEmlE6TAL9ONQYwYPPf0BJW0dEfHHMbe0C3PA08DBar?=
 =?us-ascii?Q?hqZ4+6lH7gXM4UrYP0lmfl4lKlgC0zF/7yU7U7BXYBnGwN+Yd7/GnZUY8HSW?=
 =?us-ascii?Q?dIyU8hr1vhSz2FN7eDjDltCcqNMhEvyZaxalVE1sCHgdXbF5/lwoFAsJ4/XD?=
 =?us-ascii?Q?BQLOGgDdYKlToqqs9J3IKOB2vPeZh4R78wdEP/5mVWRG3u+86jDR2mWSe3LT?=
 =?us-ascii?Q?1qSiTBo6wOL1rF722Z9d+ccmukDUijOAcpkrvuDa6hFuxPC+l7mEJEKLkeFe?=
 =?us-ascii?Q?aYwpd6zqXjflFIZEmUHQALu0AZZzrTVMwvEq2rwgynz7/OUQVh4SbdPaQ1Rk?=
 =?us-ascii?Q?5QjBRSmnmcaNxgMvtLzPrQ7RvhrbHVDzD4Si7PLqew4H5sitin4S403odaiT?=
 =?us-ascii?Q?NyJRvtJkifXupE/KmrwC0RG/KOiTtK8wvv81/I/1rziLyNrYKOPNYrMzkRuq?=
 =?us-ascii?Q?fO20g1wZYKi2LeRd0RNaD3qSzerqL3FRu5A93LIV/Htx0i6JR4jNT/YDwa12?=
 =?us-ascii?Q?oGiSJTdfP7lhEGUgFlF8Y+wFmA7gj9CLHk9X4Id2C8L8xX1t6gv1A0AIY/dm?=
 =?us-ascii?Q?dl3xy79WjxFTRPdRr7s2jdTZcqLt3AZRBc6nrq03ofcR9Z9PWz7Iaf0/he71?=
 =?us-ascii?Q?49AJMw+i86TVZxnHMxyhnExmZA1SQ3VUI6k3w+QEkt7MoDqrgmNjkQmZN3sk?=
 =?us-ascii?Q?Cr3U36f1vQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9680bac1-54e0-44af-a666-08da3d7ca2c9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:57:54.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zZfjhbNWa4wAAR3SBYmtZj7WbkVvA2BbqCUu78v7juT43zo/lhNVeAkln6UQEKq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 24, 2022 at 03:53:30AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/5/10 2:23, Jason Gunthorpe wrote:
> > On Wed, Apr 20, 2022 at 08:40:33PM -0500, Bob Pearson wrote:
> > 
> >> Bob Pearson (10):
> >>    RDMA/rxe: Remove IB_SRQ_INIT_MASK
> >>    RDMA/rxe: Add rxe_srq_cleanup()
> >>    RDMA/rxe: Check rxe_get() return value
> >>    RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
> >>    RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
> >>    RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
> >>    RDMA/rxe: Enforce IBA C11-17
> > 
> > I took these patches with the small edits I noted
> > 
> >>    RDMA/rxe: Stop lookup of partially built objects
> >>    RDMA/rxe: Convert read side locking to rcu
> >>    RDMA/rxe: Cleanup rxe_pool.c
> > 
> > It seems OK, but we need to fix the AH problem at least in the destroy
> > path first - lets try to fix it in alloc as well?
> Hi Jason, Bob
> 
> Could you tell me what the AH problem is? Thanks a lot.

rxe doesn't implement RDMA_CREATE_AH_SLEEPABLE /
RDMA_DESTROY_AH_SLEEPABLE

Jason
