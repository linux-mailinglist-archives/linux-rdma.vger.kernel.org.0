Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4380BAFB3A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 13:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfIKLNO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 07:13:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726781AbfIKLNO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Sep 2019 07:13:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D29B3CC8A783498EF95;
        Wed, 11 Sep 2019 19:13:12 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 19:13:07 +0800
Subject: =?UTF-8?B?UmU6IOOAkEJ1Z1JlcG9ydOOAkWlidl9zcnFfcGluZ3BvbmcgdGVzdCBi?=
 =?UTF-8?Q?ug?=
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "roland@topspin.com" <roland@topspin.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
References: <36d848a6254b46c097b94046e3569fac@huawei.com>
 <11ddbfb0-cefb-623a-a0bd-a1fa14cf7c96@dev.mellanox.co.il>
From:   oulijun <oulijun@huawei.com>
Message-ID: <b201e06a-c55b-8b82-118f-a46ebc1f63e4@huawei.com>
Date:   Wed, 11 Sep 2019 19:13:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <11ddbfb0-cefb-623a-a0bd-a1fa14cf7c96@dev.mellanox.co.il>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/9/11 18:33, Yishai Hadas 写道:
> On 9/11/2019 10:26 AM, oulijun wrote:
>> Hi, Roland Dreier and others
>>
>>            I am using ibv_srq_pingpong to test based on hip08. The test result as follows:
>>
>>            local address:  LID 0x0000, QPN 0x0000ff, PSN 0xdca3b1, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x000100, PSN 0xf62247, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x000101, PSN 0x7de385, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x000102, PSN 0xc5fcf0, GID ::
>>
>>           local address:  LID 0x0000, QPN 0x000103, PSN 0x3e0843, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x000104, PSN 0x320be9, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x000105, PSN 0xb82994, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x000106, PSN 0xf9e7fd, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x000107, PSN 0xdfee5d, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x000108, PSN 0x02891b, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x000109, PSN 0x37d823, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x00010a, PSN 0x75397a, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x00010b, PSN 0x0e02de, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x00010c, PSN 0x7e9633, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x00010d, PSN 0x5b4a75, GID ::
>>
>>            local address:  LID 0x0000, QPN 0x00010e, PSN 0xe9a195, GID ::
>>
>> Failed to modify QP[0] to RTR
>>
>
> As of the below trace it looks as you are using RoCE, correct ? if so, you need to supply a gid in the command line (e.g -g 0).
Yes. is this the limited for using this tool? I will try it. thanks.
>
>> Couldn't connect to remote QP
>>
>>            I am targeting as follows:
>>
>>            When called the ibv_modify_qp run and it will trace as follows:
>>
>> static int rdma_check_ah_attr(struct ib_device *device,
>>
>> 409                               struct rdma_ah_attr *ah_attr)
>>
>> 410 {
>>
>> 411         if (!rdma_is_port_valid(device, ah_attr->port_num))
>>
>> 412                 return -EINVAL;
>>
>> 413         printk("[%s, %d] point!\n", __func__, __LINE__);
>>
>> 414         printk("[%s, %d] rdma_is_grh_required(device, ah_attr->port_num) = %d\n",
>>
>> 415                 __func__, __LINE__, rdma_is_grh_required(device, ah_attr->port_num));
>>
>> 416         printk("[%s, %d] ah_attr->type = %d!\n", __func__, __LINE__, ah_attr->type);
>>
>> 417         printk("[%s, %d] ah_attr->ah_flags = %d!\n", __func__, __LINE__, ah_attr->ah_flags);
>>
>> 418         if ((rdma_is_grh_required(device, ah_attr->port_num) ||
>>
>> 419              ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) &&
>>
>> 420             !(ah_attr->ah_flags & IB_AH_GRH))
>>
>> 421                 return -EINVAL;
>>
>> 422         printk("[%s, %d] point!\n", __func__, __LINE__);
>>
>> 423         if (ah_attr->grh.sgid_attr) {
>>
>> 424                 /*
>>
>> 425                  * Make sure the passed sgid_attr is consistent with the
>>
>> 426                  * parameters
>>
>> 427                  */
>>
>> 428                 if (ah_attr->grh.sgid_attr->index != ah_attr->grh.sgid_index ||
>>
>> 429                     ah_attr->grh.sgid_attr->port_num != ah_attr->port_num)
>>
>> 430                         return -EINVAL;
>>
>> 431         }
>>
>> 432         printk("[%s, %d] point!\n", __func__, __LINE__);
>>
>> 433         return 0;
>>
>> When trace at 420 lines, it will return fail.  I don’t understand the lines. Because it should be right  when run roce mode.
>>
>> The ah_attr->ah_flags is RDMA_AH_ATTR_TYPE_ROCE and ah_attr->ah_flags should be IB_AH_GRH
>>
>> However the value of ah_attr->ah_flags is 2.  I think that the value of attr->ah_flags should have a protocol layer guarantee
>>
>> So, I doubt that the protocol layer or ibv_srq_pingpong have an achieve defects
>>
>> At the same time I used ibv_srq_pingpong to test on cx5,  the result is the same:
>>
>> root@ubuntu-51-7:~# ibv_srq_pingpong -d mlx5_0 -p 10002
>>
>>    local address:  LID 0x0000, QPN 0x0000ff, PSN 0xdca3b1, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x000100, PSN 0xf62247, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x000101, PSN 0x7de385, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x000102, PSN 0xc5fcf0, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x000103, PSN 0x3e0843, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x000104, PSN 0x320be9, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x000105, PSN 0xb82994, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x000106, PSN 0xf9e7fd, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x000107, PSN 0xdfee5d, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x000108, PSN 0x02891b, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x000109, PSN 0x37d823, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x00010a, PSN 0x75397a, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x00010b, PSN 0x0e02de, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x00010c, PSN 0x7e9633, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x00010d, PSN 0x5b4a75, GID ::
>>
>>    local address:  LID 0x0000, QPN 0x00010e, PSN 0xe9a195, GID ::
>>
>> Failed to modify QP[0] to RTR
>>
>> Couldn't connect to remote QP
>>
>> Thanks
>>
>> Lijun Ou
>>
>
>
> .
>


