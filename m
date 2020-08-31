Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7732257C42
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgHaP0z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 11:26:55 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:19213 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgHaP0y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 31 Aug 2020 11:26:54 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d16bb0000>; Mon, 31 Aug 2020 23:26:51 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 08:26:51 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 31 Aug 2020 08:26:51 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 15:26:51 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 31 Aug 2020 15:26:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsWMB3fgU5eIpIIMEP+lZYsbe1cUmq13U66CrSnIeYOWuZBUv9wKEDlHbizb4+5JuVajUSz6iohmYLmolbHmNIGLTDBbSVtCd4/lIDFwEXLz/4tkWnAsVM+qJ97yYpS97oWbGVB2IU+pxWDXpa+2+94eoZp6xjYmgXpRO9V2MsbDmRmnJDn5wLPhDrFCz+4KyC3bFUL0KmlFSYfQyWRmSIVfPQhJlTYLH7sj1eGUthYjCR8oinwf+iw2BFUEQFJGHPdtI7wX4gYHCaiVfHHAjeLKSPuXZKJgKJ/D5FJskJYxsacT8dE/xfvc1vKkZpVARhyq3z9A7dwOQU2CBCPOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAJDpeRww9le1onb/d/11tAYjPwhclnnpl3QXORtFwE=;
 b=CZz1N3ZEf1gMcEmAyRgrw5Rh7l0SgIEWmOPlnhWFJC2UvBj0pdIPDfEkp5P0sdY0X/QF64d0gFPR814U60pG+CKLyTIf0b0YOgNlQnr0vYrJ6vCCrZjD5ACrg730hZFu5nUfTEy473LzT/lFulbEofyBvy5Oj3bUbU5c/uNPZfVfENGLq3qeiuVz5OUyASMhtwln3yMKfzx4PbC6nWcFM/bTRsqevNpLjFPiZcG0oYeBoI5g6XBhx6IgItYlUBNDOr6m8mm9QlnJ91nNSmmxIEATMlafNZfydL5UeoVpMFYW5R4qIGGfanIrO+skYN/qwdB6zlDYGBEqGUfL/EMH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 31 Aug
 2020 15:26:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 15:26:48 +0000
Date:   Mon, 31 Aug 2020 12:26:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] rdma_rxe: Added SPDX hdrs to rxe source files
Message-ID: <20200831152646.GD628533@nvidia.com>
References: <20200827145439.2273-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200827145439.2273-1-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:208:d4::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR04CA0005.namprd04.prod.outlook.com (2603:10b6:208:d4::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:26:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kClhm-002dY0-MN; Mon, 31 Aug 2020 12:26:46 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7445176b-0c2a-4a9a-f236-08d84dc246e2
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-Microsoft-Antispam-PRVS: <DM6PR12MB29407F22407BB85DEF97DD7FC2510@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yq9y2rF8ZqK8IAePI9/jVW6Y3xV1+7PA74+E/QRoTC9bdeMIw/1/Kj0UXAQJ5aDA9YIvw0FErT7rGpMXbl+rt5KwdTyLMnxmM4DuMnfe77qAqS2Ev5QIk1Na5vA0wxFRip9Y9qLEn6q+2lXod3X035rjBVoMwldVntytOENPR4NqkmK/+BGTce5oPrq4EevMfPH04mgIwsoP8Gbi+5BfaEkZyILiRfaf9dztyy1i8rvUKeHpuxZRrOjmgqgbKRGZsIT7srDM+B4oBCyBqSXOY5Z3A/a9UJ1yrWSaZCVVhlMy1h0EEhR06cVaO3w0Fj2bZMSjXGR73hd+AuiapEITsHNO6rRoCBGatBefd0WrfhjOLQNE7TTxasuBmPDLKjuy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(26005)(2906002)(5660300002)(36756003)(86362001)(478600001)(6916009)(8676002)(1076003)(33656002)(4326008)(2616005)(426003)(316002)(8936002)(66556008)(66476007)(66946007)(83380400001)(186003)(9746002)(9786002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5EBbDBaTjIar5boJA8PVA7E584V73qDTZLrMaFz59mf25foLALMkFK5M0K5iosxUZg4wv975m1SGZinrKXsElt4rwaXM3c9Ichk8MFAVEC1iy33SVbP0ltI3pu2KpAEj8OTBjX5mlpOj35sAQPIFPY9pxokQKStJ1QQLmCjFvKorbyTOkH3Y+vCZQUG98Phn8s6MS9OXY6wIzLmRblW5G/blC+yZTQjf28LKrcFaEjyp6eG/n3q8HHu6Lz3dhImNzZtoWbkKKL69iXe5Fac41fuiUd9Cyn8tugaDSxqPMANcMR3/se7vqkI9CsvFAGegs6dhGhSbE19xnsNPyd2DBKzE9bwtz94N4lnWHSChRq64gYrnhA01VWfMy5WxL8c3tYw1sRFheAI3gy9X/ZBWufC1ceZf+1dw6jGHoL8a+RASgrO2q5xvYurSsLMkGDiyzHUY65hmSL7Twgzp8HSr8j/UFQBVG7r2rQ+mJOAmDSpHpEtU5qde9+51+43LAw0rlbB+YgKQl5hjlegM6248GCwJSO/JNXjlP8GjxDbBVL17SuL3GtU1Iibvin2VFKHchCmCGDER0ASOrp5czAkwDOVX+U6ikV5liCuDvc/whiswKDyRiPUTlx1AayZzY43CsydgqntuaRwFG0VbwL+Q/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7445176b-0c2a-4a9a-f236-08d84dc246e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:26:48.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H321DmJC+IfoHVD5Z6cyA8a+geRXNfWz++S8UVRSWhFnMtFzsZbwbofDKvebDilI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598887611; bh=lAJDpeRww9le1onb/d/11tAYjPwhclnnpl3QXORtFwE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=i5lrMqhE1adaIozsjL07xw7yuQrYYpNh9MvuDnYSSWfQNNMxwEhvw44a3gUIbgEY1
         fBC9g4anjZZt0T3+K1kAu5E09BoaWXcGrVHAjC80b6LfuKYxhjzkSx9JT7wuLmu9WU
         gsEGRhHdaFu3QwnxBEqns/MxdCV41SH3tYHft+akjjU+vUa91Ey6e/zJyOEzB7Thfb
         EiCJTl6Nu2gCHnQOVF+YFYMrwDr7M+xV5Vgf8cEdc4AtrcnOAhD6FnzZUrnyqFFLSc
         sraX57MjElnYCK7bt/NMY8Dg234nesIdfnKyqAU6pNQV+UFH3SrrQacRi00G1nTFOP
         yxJdBXpQoDRnA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 27, 2020 at 09:54:40AM -0500, Bob Pearson wrote:
> Added SPDX headers to all tracked .c and .h files.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c             | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe.h             | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_av.c          | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_comp.c        | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_cq.c          | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_hdr.h         | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_hw_counters.c | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_hw_counters.h | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_icrc.c        | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_loc.h         | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_mcast.c       | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_mmap.c        | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_mr.c          | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_net.c         | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_net.h         | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_opcode.c      | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_opcode.h      | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_param.h       | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_pool.c        | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_pool.h        | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_qp.c          | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_queue.c       | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_queue.h       | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_recv.c        | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_req.c         | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_resp.c        | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_srq.c         | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_sysfs.c       | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_task.c        | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_task.h        | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_verbs.c       | 29 +--------------------
>  drivers/infiniband/sw/rxe/rxe_verbs.h       | 29 +--------------------
>  32 files changed, 32 insertions(+), 896 deletions(-)

Applied to for-next, thanks

Jason
