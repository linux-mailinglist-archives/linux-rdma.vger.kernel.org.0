Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C8B277DA6
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 03:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIYBb6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 24 Sep 2020 21:31:58 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3531 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbgIYBb6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Sep 2020 21:31:58 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id F1924C33246FC6F3EACA;
        Fri, 25 Sep 2020 09:31:55 +0800 (CST)
Received: from dggema703-chm.china.huawei.com (10.3.20.67) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 25 Sep 2020 09:31:55 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema703-chm.china.huawei.com (10.3.20.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 25 Sep 2020 09:31:55 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Fri, 25 Sep 2020 09:31:55 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next 1/8] RDMA/hns: Refactor process about opcode
 in post_send()
Thread-Topic: [PATCH v3 for-next 1/8] RDMA/hns: Refactor process about opcode
 in post_send()
Thread-Index: AQHWjmxTk69OEk4ydkyGuhFBp6a9GA==
Date:   Fri, 25 Sep 2020 01:31:55 +0000
Message-ID: <ab444314df4645dc9478ec79d18635a2@huawei.com>
References: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
 <1600509802-44382-2-git-send-email-liweihang@huawei.com>
 <20200924185949.GA116461@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/9/25 3:00, Jason Gunthorpe wrote:
> On Sat, Sep 19, 2020 at 06:03:15PM +0800, Weihang Li wrote:
>> According to the IB specifications, the verbs should return an immediate
>> error when the users set an unsupported opcode. Furthermore, refactor codes
>> about opcode in process of post_send to make the difference between opcodes
>> clearer.
>>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 133 +++++++++++++++++------------
>>  1 file changed, 78 insertions(+), 55 deletions(-)
> 
> This gives compile warnings:
> 
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function ‘set_ud_wqe’:
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:330:20: warning: unused variable ‘ibdev’ [-Wunused-variable]
>   330 |  struct ib_device *ibdev = &hr_dev->ib_dev;
>       |                    ^~~~~
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function ‘set_rc_wqe’:
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:468:20: warning: unused variable ‘ibdev’ [-Wunused-variable]
>   468 |  struct ib_device *ibdev = &to_hr_dev(qp->ibqp.device)->ib_dev;
>       |                    ^~~~~
> 
> I deleted the unused variables
> 
> Jason
> 

I forgot to remove them when I replace the prints with WARN_ON(), thank you :)

Weihang
