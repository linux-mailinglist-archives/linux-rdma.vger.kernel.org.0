Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1782FEC43
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 14:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbhAUNt6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 21 Jan 2021 08:49:58 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2867 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730280AbhAUNtn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 08:49:43 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DM3c31Prgz5JKj;
        Thu, 21 Jan 2021 21:47:31 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 21 Jan 2021 21:48:56 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 21 Jan 2021 21:48:56 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.002;
 Thu, 21 Jan 2021 21:48:56 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC 1/7] RDMA/hns: Introduce DCA for RC QP
Thread-Topic: [PATCH RFC 1/7] RDMA/hns: Introduce DCA for RC QP
Thread-Index: AQHW7/oITeBBndE4CkiFjIHgF/TJug==
Date:   Thu, 21 Jan 2021 13:48:56 +0000
Message-ID: <14243f680ba6428789b878078f766967@huawei.com>
References: <1610706138-4219-1-git-send-email-liweihang@huawei.com>
 <1610706138-4219-2-git-send-email-liweihang@huawei.com>
 <20210120081025.GA225873@unreal>
 <8d255812177a4f53becd3c912d00c528@huawei.com>
 <20210121085325.GC320304@unreal>
 <96d7fb7db36e4bce8c556d0de5c8f961@huawei.com>
 <20210121133445.GY4147@nvidia.com>
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

On 2021/1/21 21:36, Jason Gunthorpe wrote:
> On Thu, Jan 21, 2021 at 01:33:42PM +0000, liweihang wrote:
> 
>> We need to allocate memory while spin_lock is hold, how about using GFP_KERNEL or
>> GFP_NOWAIT?
> 
> You should try hard not to do that. Convert he spinlock to a mutex,
> for instance.
> 
> Jason
> 

But what if some kernel users call ib_post_send() when holding a spinlock?

Thanks
Weihang
