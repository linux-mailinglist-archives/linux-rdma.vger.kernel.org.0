Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA872161B8
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 00:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgGFWyh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 18:54:37 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19816 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGFWyg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 18:54:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f03ab430000>; Mon, 06 Jul 2020 15:52:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Jul 2020 15:54:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Jul 2020 15:54:36 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 22:54:30 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 6 Jul 2020 22:54:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0Mp3fEMj8QP6UnBfK9XNVowRveRJEfZNvcOY+3mSVmfSdSagSqTLio7I1YBf0G77W4jsqqpd4zXhI4l2oM8jEeqWJ9XvE8WOXhY7e/qzIQ8w+OyGXwfusIU6VckHQ7QqgKNhGlMySLR7H1fGABIQd+qSefruiq7VZ7FIy6o6hfJxij1K9bGUoXRyi+PUqwIpfweXTOj3WPU1jAPVPSz9PJQfXLbEoKzeKalrwjTt3VB/0NYK/8nrdKayJI20mB/MXa+WtcgKMpKxmWXWTKVJrJPuGXkqzmZgYeqpc03Zs9MK03Fa3GSWwAxFPZ5zUEXBs0aQXqmwc7g7qWjvtUEJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ranq94tKhhpKCT5xpsb6BJITX1uR1bjIuP0ZEvuKhHk=;
 b=PQ18PNaEeAJ8glB060TPFZ5pZhqnS9MjGVcmcVRnlBPqMThS/Q81zuE9y7EaQSo1wpMK7h47uMN8RvLVUgv1Vb7tq/cb6U5Ry7qdMP2ZXpBkuY8q5omcXXtv5RHONAySXeEAZIK3xZ1RsD4W7RpQzZRvuxcUcSYvwcFpM4qikRXltnm9KOHAQcK6zDoYZYiz00FeITKR92baqsntoAC8vyM+CU8AoAH20Cg5JVo9FT7fUDwuDFfLXwr5QHr716XvGipA0OaWGyiTiuvjr8BCYzbKoo+72q60NKfGACnD+7BccvuEpp89tL5LZS5QJwLDqnvALai5PGzIQOxdu9foPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Mon, 6 Jul
 2020 22:54:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 22:54:29 +0000
Date:   Mon, 6 Jul 2020 19:54:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        Steve Wise <larrystevenwise@gmail.com>,
        "Yishai Hadas" <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 0/7] Introduce UAPIs to query UCONTEXT, PD
 and MR properties
Message-ID: <20200706225427.GA1282671@nvidia.com>
References: <20200630093916.332097-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200630093916.332097-1-leon@kernel.org>
X-ClientProxiedBy: YTOPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 22:54:28 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jsa0J-005Nh4-AZ; Mon, 06 Jul 2020 19:54:27 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d20e7584-7bf8-4ee8-92e0-08d821ff89ed
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28128507A17D90E7DAC7EC29C2690@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eWSfcLxvG9ksrnF649uIBOQNBLolHjWvTqKy6oK4zHCVQ9xjkrkCHAshtrE1RgEeorpKAAnCjkgbMEzkD3PnSD3ftRDdmgehTUnY6CkcJ6vNTxzO+hcYXREU1Hee9nBP/eprqkSLesMmhZ7sf4Ve+QOv5AmcFGB7ujXj9m4oHvYVwRNdM7OysYD34b0WGAvwIHp3qmz5ricxHfeZtDsOD6Ew0c5y++xvyrgNrtxcHVLNXiJ3wq4zRAYrqsS9sVDcfgrrLou7Imb2/tIQZwH1ZmrYHX0prm/ASYEmQTBSa3ctMbXWPlOD37sYvWlpimXtgWLcWLKqq+sODlQE/jRuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(316002)(54906003)(4326008)(66946007)(66556008)(1076003)(2616005)(4744005)(66476007)(5660300002)(6916009)(2906002)(86362001)(186003)(36756003)(426003)(33656002)(26005)(478600001)(8936002)(8676002)(9746002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kNRUh9x5gWaByzHm9kOBl+6Ettzvv2bguH/btIX+tGHiGsHI12Sff8N7v4hAU7hDZh3RU37ORzzSOeu6LzGIjbEm786CsrpIGd2kEmbqeFmh1FgHoYycU+8D7bf8zK7IvISBEEpx+YluFJnEo+VgX/OTmnLg8ygk0jPS+zOalvzIPHzPB5nFsZp0mzWqzonnVCj+NMBmWjiluYer0UpBWsz2KcK7xVOeOpRqPb2SyKesbnkrFb/wQRGWkmKP2bsM7QmXqho5auImiG7YrDJaRwyYdtn3oZDWfmtVivhtT3LWkSo+hHZSw9oc7cgljr89VPtZnnPmXJ5PFOd0QdftCX2939zZS+liZsuTaacjPfFRm3CsfEIr23uI1/i61K5DHfJvkVKEpgZYYd7p1h862lsTtzT0YDqfWJikIlT5DKVmVcgIDDUaZ6kwoWTHt7iYP4tpqxXTqlA0OsdtFgINAjn6x0hXDWlKeXbniLyHqkYtBAyDVOUEiv86M2bWDZ4F
X-MS-Exchange-CrossTenant-Network-Message-Id: d20e7584-7bf8-4ee8-92e0-08d821ff89ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 22:54:28.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sETLi+z6M3hR7LDlQBnh/54Nq0w+5eZQNwDWNJJSATcBws8tZ0Zxc23r6Qe+bCj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594075971; bh=ranq94tKhhpKCT5xpsb6BJITX1uR1bjIuP0ZEvuKhHk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
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
        b=LX1wv+HLpiCam4bzBIPfyXnDvHwRTpbeNA3yuvnwJaVTLSFxJDX6NlI3FElj/u9O/
         QpeQ5GQOyQis6DE4Lb+dPwF8FysjiSUOIKbRLRlQFXWjbueOpPa7nO9t0CQ2Uqcyjv
         07T7uYLS7cMIfjain5U7WtiG/jphB6yT8rWHoWCFqLooMxn4ssCpLu3eXEcRerTZeE
         x8KUc1AtU7jJzHQ8CiGqse1UfRLjhCEkZEiahTgcGD2ZS2vP3WQT5wYytX7OGpKgAi
         jMcGNdEUcjT/zvgomMHrV0Pt3+2Tajt/a+YgPp5vD+ljtIEOYzoJxVYLrl3uRl+EWu
         Yg+qdKSV74bqw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 12:39:09PM +0300, Leon Romanovsky wrote:
> Yishai Hadas (7):
>   IB/uverbs: Enable CQ ioctl commands by default
>   IB/uverbs: Set IOVA on IB MR in uverbs layer
>   IB/uverbs: Expose UAPI to query ucontext
>   RDMA/mlx5: Refactor mlx5_ib_alloc_ucontext() response
>   RDMA/mlx5: Implement the query ucontext functionality
>   RDMA/mlx5: Introduce UAPI to query PD attributes
>   IB/uverbs: Expose UAPI to query MR

Applied to for-next, thanks

Jason
