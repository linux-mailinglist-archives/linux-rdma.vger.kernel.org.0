Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2E7274D52
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 01:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgIVX1q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 19:27:46 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14427 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgIVX1p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Sep 2020 19:27:45 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6a88130000>; Tue, 22 Sep 2020 16:26:11 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 23:27:45 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 22 Sep 2020 23:27:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKnX26PtXZsT4e6jCH3s5/bWm93+iTd6JB9Oj/tlQS/TrdnTmar83oQdVWxs6xbvAPCZ+J5FnsLN4cRuDcu1AxDr+Ujy8F30/VvFfI0GYFAD+8p9LWMLn81Z3dB09Hk8G3HmZVxp9dfUJtpo1mmr0e61Iqy6I/aOmjVBNUHj9QrC/AxCoavmrd6lzXviNJJuk/JG7nnIvYQ1qk7e+WPXUDeUar4fGRvDMpmFz3n2EbTkU0wipLNXc8Sc9ZjAV6MyWjByZJllK7hCksijnpSWZpoX6oGwa6tjJ4qsYxZ6j6hZix4dVaAS/xxeUUTEqxTTRiX2FSwgOmHQg54pKlGD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ebTqIy1mK5qoSBQozq2XxN/mJHnpwzjizkWyr1Pm14=;
 b=WaN0kHAtRKrHcmqxdDUzvXSHbkFM8Vjtx8OlZdu6iaLk80Eg/mO59TsfNIx2fClYnAFh0aNpyILmnJTKFUjCKJ5c1j4FzGBc6UC2xHJCqg+VJWNI0AdioFlv7PbKdiRjCdAtnQ/QAayY/vf/ydOT9hIC6mn/0gx3GvwKkEXOKSO5b2vigCw8EwhrkwJNlNJev609tSxxJMm+YM9qywsExcdlgeEY7s4OWF3x3Z5ZZSfqduxneb7cs7w5hkUqwDlrHtatgDf72dCiyleINWrb8iKBeK78Ku9uWcEae7EUNsZawRQ4n8wyDUjRT6BhP9YE7JzT5fMp1wQ0eyjZ1kLl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: inria.fr; dkim=none (message not signed)
 header.d=none;inria.fr; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Tue, 22 Sep
 2020 23:27:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 23:27:43 +0000
Date:   Tue, 22 Sep 2020 20:27:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
CC:     Gal Pressman <galpress@amazon.com>,
        <kernel-janitors@vger.kernel.org>,
        Yossi Leybovich <sleybo@amazon.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/14] RDMA/efa: drop double zeroing
Message-ID: <20200922232742.GA809724@nvidia.com>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
 <1600601186-7420-6-git-send-email-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1600601186-7420-6-git-send-email-Julia.Lawall@inria.fr>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:208:239::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR08CA0011.namprd08.prod.outlook.com (2603:10b6:208:239::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 22 Sep 2020 23:27:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKrhG-003Oep-B4; Tue, 22 Sep 2020 20:27:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d30c3024-0a65-486e-d671-08d85f4f1b06
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43881C37166DBD8D15758BB3C23B0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+P/PVMYUakqXqY2+I9e/PX4NnJYuZtmkAD+pnIISs2/HwztujYL0p6X7RvQaFha3pb1W5p9dEOiq+3tf5F96MOBB6EcdOP3URpRhGxTLhl0fWpY+sTEnLOusK/aq3sbsuaM1aWDQILP/6PA9YzWoo6MzyfoUNmWPL68v5/1w+zElqXcW3xfN264KB29LuPTIPTj8WvbegF6k2dXwoLoqSsLMSYJzWbZP0Q+attJSdEu6GuhZtbLYwtBKr5dxqV66A6pTZgwYeqbsiHr5okqmXMyWsBgpOsdsPAM5Rwxy0uaw+k5uJ+Zs5jsfYvNAQ6TI7j8ZU2OmvQ6tV/AHtWne2wkZ9VvpGPJo6kRLbch8ZTFBWk+5Av0yDlFHY1WE2XIfuU6WkBRhlL3X+kJPLX4jmIGWLcM6MxNb9fzBUaEIjk3hVdnhucySZI9T98hAHfCRLfHtPLYzsO8cmSFp53pMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(33656002)(9746002)(4326008)(9786002)(186003)(8676002)(26005)(36756003)(54906003)(2906002)(83380400001)(8936002)(6916009)(5660300002)(86362001)(4744005)(66946007)(66556008)(1076003)(66476007)(316002)(478600001)(2616005)(426003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bEjaqROo7joihp6wfpA8hYBHIev/lpqDFuG0cXLhNZ4bPJXyHpKwKzR7vJyYZo7NnF1LQhMl1bpJdMKxkOuzDtmD5FBZs5RYvaUOXs9cJRUqo4456YwDhAKYp6etVZt+yXRnwz9cL2TRWNicZhZySH+rG/Hv/YF9DH/GjSuiA8WTALCCjAKCvAcYJFm57L6Me50knzvPQiOMfgipgYiVWJizWpCubAaGPuFkB7YJ6PxU7y0bxBT6I/pVX5RDI1LQb2oFegBO0IYqQ/hKRu8mhRCLSMn156Bx04d5/pxUOwkAAVyZ9Tz8McA99BAZ90beYD+rc+FDJGM4+HGgO5PGDhOs2LYhd8iSMaBD0IcDhcWF1tt/PXXSIz292MFKb7LTkehPWv7a2OMok9MHIDR3ALMpP3h+ZwoU+SjNbdplsEnW0c9oYxP3hwp52XsvLH1SCmPO/hMs30LvqTIqZT1MLaQQIuB2gSxeMHz4vVVi02kb3ShV5c41rHlIm+JXiOoO/XD87/n1Ez+5THf8yOSFQ0cS41iv02HF5bjfRyukgItGGeZ5H3xYfSCU1Wnap/pvXYsx7yDPqPkdbd7rV6jYgjbWyDe+EUQ+A9Ef2907CNIYmoGvR4k3C/pjEyhcbCwBQoTBw8corqFTYoBTyLKG0w==
X-MS-Exchange-CrossTenant-Network-Message-Id: d30c3024-0a65-486e-d671-08d85f4f1b06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 23:27:43.7890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBAZ5o9FwVv4bwfNNh0gLz27QQtZ32UUvWvJ7eenA9Ih5nSvLKBtz9c5LDT/tVVD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600817171; bh=3ebTqIy1mK5qoSBQozq2XxN/mJHnpwzjizkWyr1Pm14=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=hiSNN7zPJBjegx0nT2zlgs3lm30oW7413z26tZwn7Oqz+qzAmF81VOL3il5lyMOFQ
         ENNhl7m/8e31mTp+zLeobcfUFcI0GRy6eVX9m+E/uydW62lNZLmwPIadLdeheVNxea
         J5IM5aGzMEfd9VhJhClOqQnJbOvudeKE9ZOWuARFJZasnK18xkcCdvzDFzSvoeQTNj
         eEKYUYzaHuCxyZF0giS3uWD+CwdULAvHTzlikC/LK8s5Zvpe0ApHGbklrplO9EIATD
         KE9i3oas2HgJoHfTzq1s2BtVj9KBUabJXAaXUts3sRQnaRcbuXORgPWt9t7s64uWml
         aZ3W0qNupSZ+A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 20, 2020 at 01:26:17PM +0200, Julia Lawall wrote:
> sg_init_table zeroes its first argument, so the allocation of that argument
> doesn't have to.
> 
> the semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression x,n,flags;
> @@
> 
> x = 
> - kcalloc
> + kmalloc_array
>   (n,sizeof(*x),flags)
> ...
> sg_init_table(x,n)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> Acked-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to rdma.git for-next, thanks

Jason
