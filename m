Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97762B8B79
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Nov 2020 07:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgKSGPq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 19 Nov 2020 01:15:46 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2067 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKSGPq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Nov 2020 01:15:46 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Cc8YH1knyzVq9m;
        Thu, 19 Nov 2020 14:15:15 +0800 (CST)
Received: from dggema703-chm.china.huawei.com (10.3.20.67) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 19 Nov 2020 14:15:42 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema703-chm.china.huawei.com (10.3.20.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 19 Nov 2020 14:15:42 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Thu, 19 Nov 2020 14:15:42 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 7/7] RDMA/hns: Add support for UD inline
Thread-Topic: [PATCH v2 for-next 7/7] RDMA/hns: Add support for UD inline
Thread-Index: AQHWvAyZ1U9I9yddukaFoH2luFPjtw==
Date:   Thu, 19 Nov 2020 06:15:42 +0000
Message-ID: <7a7ee7427b68488f98ebc18d5b7c4d75@huawei.com>
References: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
 <1605526408-6936-8-git-send-email-liweihang@huawei.com>
 <20201118191051.GL244516@ziepe.ca>
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

On 2020/11/19 3:11, Jason Gunthorpe wrote:
> On Mon, Nov 16, 2020 at 07:33:28PM +0800, Weihang Li wrote:
>> @@ -503,7 +581,23 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
>>  	if (ret)
>>  		return ret;
>>  
>> -	set_extend_sge(qp, wr, &curr_idx, valid_num_sge);
>> +	if (wr->send_flags & IB_SEND_INLINE) {
>> +		ret = set_ud_inl(qp, wr, ud_sq_wqe, &curr_idx);
>> +		if (ret)
>> +			return ret;
> 
> Why are you implementing this in the kernel? No kernel ULP sets this
> flag?
> 
> Jason
> 
Hi Jason,

Sorry, I don't understand. Some kernel users may set IB_SEND_INLINE
when using UD, some may not, we just check this flag to decide how
to fill the data into UD SQ WQE here.

Thanks
Weihang
