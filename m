Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91FC341289
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 02:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhCSBzD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 18 Mar 2021 21:55:03 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3370 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhCSByd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Mar 2021 21:54:33 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F1n2F38RBz5djj;
        Fri, 19 Mar 2021 09:52:05 +0800 (CST)
Received: from dggpeml100017.china.huawei.com (7.185.36.161) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 19 Mar 2021 09:54:30 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpeml100017.china.huawei.com (7.185.36.161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 09:54:30 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Fri, 19 Mar 2021 09:54:30 +0800
From:   liweihang <liweihang@huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        liangwenpeng <liangwenpeng@huawei.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] RDMA/hns: Add support for XRC on HIP09
Thread-Topic: [bug report] RDMA/hns: Add support for XRC on HIP09
Thread-Index: AQHXG/jDi8cy3zSyj06VZ8dzAI8jOw==
Date:   Fri, 19 Mar 2021 01:54:30 +0000
Message-ID: <6d9a0640d40f4326a9c213ea0b5648bc@huawei.com>
References: <YFM1hQ4p/uL7zyRY@mwanda>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/3/18 21:15, Dan Carpenter wrote:
> Hello Wenpeng Liang,
> 
> The patch 32548870d438: "RDMA/hns: Add support for XRC on HIP09" from
> Mar 4, 2021, leads to the following static checker warning:
> 
> 	drivers/infiniband/hw/hns/hns_roce_pd.c:143 hns_roce_xrcd_alloc()
> 	warn: passing casted pointer 'xrcdn' to 'hns_roce_bitmap_alloc()' 32 vs 64.
> 
> drivers/infiniband/hw/hns/hns_roce_pd.c
>    141  static int hns_roce_xrcd_alloc(struct hns_roce_dev *hr_dev, u32 *xrcdn)
>    142  {
>    143          return hns_roce_bitmap_alloc(&hr_dev->xrcd_bitmap,
>    144                                       (unsigned long *)xrcdn);
> 
> The hns_roce_bitmap_alloc() is going to write a ulong to &xrcd->xrcdn
> so this will lead to memory corruption.
> 
>    145  }
>    146  
> 
> regards,
> dan carpenter
> 

Hi Dan,

Thanks for your reminder, we fill fix it ASAP.

Weihang
