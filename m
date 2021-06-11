Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD93A3F1D
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 11:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhFKJfU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 11 Jun 2021 05:35:20 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5505 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhFKJfL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Jun 2021 05:35:11 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G1bDD6mFYzZg97;
        Fri, 11 Jun 2021 17:30:20 +0800 (CST)
Received: from dggpemm100002.china.huawei.com (7.185.36.179) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:33:12 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggpemm100002.china.huawei.com (7.185.36.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:33:12 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2176.012;
 Fri, 11 Jun 2021 17:33:12 +0800
From:   liweihang <liweihang@huawei.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        zhangjiaran <zhangjiaran@huawei.com>,
        chenglang <chenglang@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Solve the problem that dma_pool is
 used during the reset
Thread-Topic: [PATCH for-next] RDMA/hns: Solve the problem that dma_pool is
 used during the reset
Thread-Index: AQHXXqRvLEFVAPSt2UitBmW68KSyPw==
Date:   Fri, 11 Jun 2021 09:33:12 +0000
Message-ID: <4a8c28fe424542c286c204859e80d35d@huawei.com>
References: <1623403811-38752-1-git-send-email-liweihang@huawei.com>
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

On 2021/6/11 17:30, liweihang wrote:
> From: Jiaran Zhang <zhangjiaran@huawei.com>
> 
> During the reset, the driver calls dma_pool_destroy() to release the
> dma_pool resources. If the dma_pool_free interface is called during the
> modify_qp operation, an exception will occur. The completion
> synchronization mechanism is used to ensure that dma_pool_destroy() is
> executed after the dma_pool_free operation is complete.

Sorry, I forgot to add fixes tag, will send v2 soon.

Weihang
