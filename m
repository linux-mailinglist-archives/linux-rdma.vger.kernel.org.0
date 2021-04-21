Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0837B3675F5
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 01:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhDUX7q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 19:59:46 -0400
Received: from mail-bn8nam12on2064.outbound.protection.outlook.com ([40.107.237.64]:38479
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234886AbhDUX7q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Apr 2021 19:59:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBnR2rlQj601AbKLysJuvTF0kDcz+EkjeeEublWD0NIQgVJ//ZM5rL1DPMXJ5kDhWSmPWBFzlLva09gfQ7NbIom1jkrO0mCuqqRbOImbiZ9HOEluZ4sXRZJvzOVfTRsq+RC+dAcFzzRXZOVjz1eT5sG6vKcbgud/uuBi3TVu4bhjzJTEsArrADI8QnQ1ERxP8rfotX7gugDUmR/2p4gauykJUmD5ZEgZEDiTMKVwa19PL4KoIX7r51iGe7W3bku5K4BXnGuha2hu8J0YcIIkqb3EYsWLLl0WCXcIYe6/kMkv61Mzsiqg7cl03WrHEsgHpb7VvI6Sfz/oQWxHu7np8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8VnGAYUmc4Zf/1yusJreM5/jjJfgeSEkK4vvkRThRs=;
 b=USnJE5PXeVpPAAnFxEeHWDlhMX978yl/6CbceUSsXXwRqn3HqhfJkHUuVFdFMznj4sJ0V8UlnETjIyDcVkRtZNTiN6JQI7XLUdsPUeIghFtqwjfaDoazekJpxP9BCXN5fqa+uhMEj+VCq/Ku7IC71a1hKjHTeMH6+p2bkEGZjkXzKhUKFC1rXOEeY5+6uwSV6Q/9SmYUZFtO9LDOLtEetkrinhx1u0TXPla0k8FJ3lP3JWcxsqq8E5BIqEPhEjQ5qzh3J4zaYYWKcU4LyREQd/1x9RITg7an5PLl5anbNf3Mhn4SXsd0MGzkFTceM4dunN83HxT7W223w0CG4FK0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8VnGAYUmc4Zf/1yusJreM5/jjJfgeSEkK4vvkRThRs=;
 b=FcV6PWCsvsBzEZxnTnmznDlpw79b7g1E+l8yhqyuIKG8IijuJhx86HD81PuUPODilwkat2Ymc7VLJponsA/bqhPplepeqTqQWThjCgXcYl9iQfwzrVGRBkUxknvCaWWbsWAyVWhxjVraGCWAshr+h6SYDN0jSUJQq10cfnieFFovitVUd+Th7yoitcBKWoSVROGq1i17ZRE7QQiG76+7KTX5/an6J7tNTcRM/GzilXri0faIrkQI8C2/RzLyYpknoLKojAwDLFHcpFKR8xDSpCbRYkbUCwRrUgfn38BWaOh5+PPKB0D6I+Lw9vbpmwuqv/6Vodgu+1mJLxOTzmdygQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4620.namprd12.prod.outlook.com (2603:10b6:5:76::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 23:59:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 23:59:10 +0000
Date:   Wed, 21 Apr 2021 20:59:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Krishna Kumar <krkumar2@in.ibm.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-next 0/3] CMA fixes
Message-ID: <20210421235909.GA2329448@nvidia.com>
References: <cover.1618753862.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618753862.git.leonro@nvidia.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:208:178::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR19CA0008.namprd19.prod.outlook.com (2603:10b6:208:178::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 23:59:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZMkP-009m11-6R; Wed, 21 Apr 2021 20:59:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9428c246-743a-4670-395c-08d9052174d3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4620A8014B060D1186F26623C2479@DM6PR12MB4620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VqT2eXkml2AXrdNRTRwKB92n6AcL+sWDcKcvNRB+26Fp0v23+OVWMU9JnP/S7Q0YGjqrn1dZJZH0gWeFHRSVP0JkiL2MgaW9b4YTR/Tzj/nlaLXu2Q3sZPsrXaQDtBv8UN5Yrbg2jw3mR304LRAaGtQXHbR330aehkxkWprZIkVL4sgk2TbH42gVHy+uzwIBRZBkPMfnWSv0onFrO1UBIWPNHLUaFI7CPR8rGl2IQAVXeb9OYXIPFHPkE6NE1uMgHybNRCt95JaZnkk/DH/XpDD9BFykWofZlAbJfThv7skpZ7YF7rOWcojXCnRMLXOZQ96uNaTvQUcZsxmG7WNky5Q1OigbiULi0K0v/R6NJj7eHtlAbhgHvBxOl+G0dSae7XUJ54M6++GdwBgnx3UZ+PhgN/nRYwYG6FWIXRH9tXrugjiT+SPJRIvX9I7NRWEstcNfYeNsECGp1tdZvD4Zp2OCb1hTrI+Dkje1GzhPqt6NHPN3deMwjQcANTyZIGgIosQe9EL8f+E2Dnj/gwM7s/l/csfsGUqBUwX3rj/U6zXurJH8jd0gr9IJIQNhFaXX2MVOg9mLk0dv2Kk0LHVn8DPGiGWGpW7zIZZb1fjWMvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(8676002)(2906002)(426003)(4744005)(478600001)(38100700002)(26005)(6916009)(66476007)(36756003)(66556008)(2616005)(33656002)(186003)(86362001)(107886003)(66946007)(9746002)(9786002)(8936002)(316002)(5660300002)(1076003)(54906003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nYNHHTrvAuYqXn6ZplauwkLIZJQfozgM6eyP89b+XfqeS9YqFuhB8sduiM1M?=
 =?us-ascii?Q?GCmfLRjA/uoRbhur5RZl/zZ79xAYy6WtQTWwxYhz6A+rfdY0c6/MFMyL2cCV?=
 =?us-ascii?Q?QfHbcWscDneWxNWpF+3d7RGQ0+hTld3mVHglEmuJkTN+0T8SZYIbfcOWkFMH?=
 =?us-ascii?Q?2Y6xBSt/+xDJCy6sVLazo0P7lJsNNXnDYO7qq5pD3uxCyrfeH+8MOWd+thHl?=
 =?us-ascii?Q?6fugqrUN3fMiTFcrVWYL18sFqqJx7naK0dAMifP5PJ1+nn4uaCrM0RhMgGmo?=
 =?us-ascii?Q?Mf8ymOcnaY8UM+WMUvYZWnMw46GM5Wv5+hAWj2sv5AIcK+XhYrRA/lwTeQb6?=
 =?us-ascii?Q?lIrgPG3VtwLc+XldcNb8hCbmFTKFt0zJYRAF4qR9dto40l3IolE6f69dtemM?=
 =?us-ascii?Q?Hw6acI3IvsQjYBqu08/hW8r32nzr6uWxDA/Ox7r6YZdMJSy0+lTwJVkqv3kp?=
 =?us-ascii?Q?vaSWoxUoJsDDHU3MK312v3jDBGYfDNS9i49OB5z4Y8Gaeibe8YuyhhTst3I2?=
 =?us-ascii?Q?mYXGLC/3cmU2stRuLri+jDk834uRKMwPkkl9S8HNoXFnpjXY4feYT2E+2xoL?=
 =?us-ascii?Q?8XBf8Neb83RWOQUEiGsFIihZ8cYH2PRALwq/9q0pgXuu9qABT6iLja/SX6EC?=
 =?us-ascii?Q?34fUsDGDzwQaToYEQShCtVPRdR/pANae3jzYU6m4msoDqhO2oF3RHilbkYgS?=
 =?us-ascii?Q?OaR3o7D7dmoKGNTrdYzQSQoZk5VVjxaaTkFKa3tGRWIlzHUoMA8UQfGKAqXc?=
 =?us-ascii?Q?3Ds0rliD/+LcfFwxOCXTAWzpmDqUPg9y7sa1CGeVtDbacwqrBjRg4LCnJaHK?=
 =?us-ascii?Q?wdnblPWKp3NEAIcbg7JgiEEmTbQDPj+0Kxpt3EUgB5xoBnqQDRp6TXOq9AWK?=
 =?us-ascii?Q?IAO/OVmZgHm3rPcWY8SEqo0DDeSaVrkzYxC8cS8q4P/tMbibPLTp5cH/UPAG?=
 =?us-ascii?Q?Nes6nJLCKiRQcXKp+NnUEJwNB/d6sK2lkTxFUgQ/VhMsu2xAtqhf+NCsTjah?=
 =?us-ascii?Q?MFkjyWewKUB9cEPaxUxuOD6Nf2sdyN+YonWZaZ5Vygj9yLv1QAGEGi/Xq3I7?=
 =?us-ascii?Q?XvgEpJUnekGJmDZigV24sx/XDrO7AsgoFqD+dKVPhqIeMq2cmiSpnUW6Y0pD?=
 =?us-ascii?Q?PTEZ/KDKHEFp1eHOG4Qtxdf78bM/UH0FTVhE9CG1i/L1gXNI2znMRrT7RDeg?=
 =?us-ascii?Q?Cm06nxijm4jqsSFLvaecr/FeO5qXXEmIjuK0RbSQbyvj5uu8zFzBxxuHPWxY?=
 =?us-ascii?Q?qpPqfZkR0AIOEyePzqYKztvBBmuMrhN/SVSNiE7TzV3fa5jr+59C6+SKq+Zv?=
 =?us-ascii?Q?1kwAko9o4Q4M6JTbOIPOkujYiqDPFmpXduojlb0diBzEbQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9428c246-743a-4670-395c-08d9052174d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 23:59:10.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8YmuvQkseZJLXfaaJk2s7/1VBLICx9cRgUmk9Ds8jvn9Aebk5yGr0bIKBSK3nxR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4620
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 18, 2021 at 04:55:51PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Another round of fixes to cma.c
> 
> Parav Pandit (1):
>   RDMA/cma: Skip device which doesn't support CM
> 
> Shay Drory (2):
>   RDMA/core: Add CM to restrack after successful attachment to a device

These two applied to for-next

>   RDMA/core: Fix check of device in rdma_listen()

Lets think about this one some more

Thanks,
Jason
