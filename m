Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7602625EE
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 05:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIIDlP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 8 Sep 2020 23:41:15 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3503 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbgIIDlO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Sep 2020 23:41:14 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id CAF8AD742D0ADA064076;
        Wed,  9 Sep 2020 11:41:12 +0800 (CST)
Received: from dggema754-chm.china.huawei.com (10.1.198.196) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 9 Sep 2020 11:41:12 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema754-chm.china.huawei.com (10.1.198.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 9 Sep 2020 11:41:12 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Wed, 9 Sep 2020 11:41:12 +0800
From:   liweihang <liweihang@huawei.com>
To:     chenglang <chenglang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH for-next 1/9] RDMA/hns: Refactor process about opcode in
 post_send()
Thread-Topic: [PATCH for-next 1/9] RDMA/hns: Refactor process about opcode in
 post_send()
Thread-Index: AQHWhlJ8GyGhLOg/U0S+S1zJF5C7dQ==
Date:   Wed, 9 Sep 2020 03:41:11 +0000
Message-ID: <c98d57a88d0645d98e2e8135805b5bf9@huawei.com>
References: <1599485808-29940-1-git-send-email-liweihang@huawei.com>
 <1599485808-29940-2-git-send-email-liweihang@huawei.com>
 <b29f111d-7c46-c7e2-66fa-1085f20e3220@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/9/9 10:39, chenglang wrote:
>> @@ -440,36 +501,6 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
>>   	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_CQE_S,
>>   		     (wr->send_flags & IB_SEND_SIGNALED) ? 1 : 0);
>>   
>> -	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OWNER_S,
>> -		     owner_bit);
> Seems we lost this field.
> 

Thank you for reminding me of that, will fix it :)

Weihang
