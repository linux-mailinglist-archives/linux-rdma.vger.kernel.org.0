Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0854A320476
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Feb 2021 09:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhBTIkq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 20 Feb 2021 03:40:46 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2905 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBTIkq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 20 Feb 2021 03:40:46 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DjMKC0BZ3z5T0Y;
        Sat, 20 Feb 2021 16:38:07 +0800 (CST)
Received: from dggema752-chm.china.huawei.com (10.1.198.194) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 20 Feb 2021 16:40:03 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema752-chm.china.huawei.com (10.1.198.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 20 Feb 2021 16:40:02 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.006;
 Sat, 20 Feb 2021 16:40:02 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC rdma-core 0/5] libhns: Add support for Dynamic Context
 Attachment
Thread-Topic: [PATCH RFC rdma-core 0/5] libhns: Add support for Dynamic
 Context Attachment
Thread-Index: AQHW/P+g64h4ciCwYkiRw06zMjvQFw==
Date:   Sat, 20 Feb 2021 08:40:02 +0000
Message-ID: <fa076ca278504bf58da2c1e521be6748@huawei.com>
References: <1612667574-56673-1-git-send-email-liweihang@huawei.com>
 <20210209195359.GT4247@nvidia.com>
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

On 2021/2/10 3:54, Jason Gunthorpe wrote:
> On Sun, Feb 07, 2021 at 11:12:49AM +0800, Weihang Li wrote:
>> The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
>> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
>> enables DCA feature, the WQE's buffer will not be allocated when creating
>> but when the users start to post WRs. This will reduce the memory
>> consumption when there are too many QPs are inactive.
>> One a WQE buffer is allocated it still acts as a normal WQE ring
> buffer? So this DCA logic is to remap the send queue buffer based on
> demand for SQEs? How does it interact with the normal max send queue
> entries reported?
> 

Not exactly. If DCA is enabled, we first allocate a memory pool with a
default size when opening device. Each time we trying to post WR(s) to a
QP, the driver will check if current QP has WQE buffer.

If not, the driver will check whether there is enough free memory in the
DCA memory pool. If there is, the QP will get WQE buffer from the pool,
including SQ buffer in size of max_send_wr, RQ buffer in size of
max_recv_wr and extended sge buffer. If there is no enough space for the
WQE buffer in the DCA pool, the driver will expand the size of pool and
then assign the buffer to the QP.

And if the WQE buffer of a QP is not used, this buffer would be recycled
and the DCA memory pool would be shrinked.

> Would like to see proper man pages explaining how this all works for
> rdma-core.
> 
> Jason
> 
OK, will add man pages for DCA in next version.

Thanks
Weihang
