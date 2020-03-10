Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E926C17EDEC
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 02:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgCJBTP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 9 Mar 2020 21:19:15 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3417 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbgCJBTP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Mar 2020 21:19:15 -0400
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id AF12F71816051E471296;
        Tue, 10 Mar 2020 09:19:12 +0800 (CST)
Received: from DGGEML522-MBX.china.huawei.com ([169.254.7.20]) by
 dggeml406-hub.china.huawei.com ([10.3.17.50]) with mapi id 14.03.0439.000;
 Tue, 10 Mar 2020 09:19:03 +0800
From:   liweihang <liweihang@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 4/5] RDMA/hns: Optimize base address table
 config flow for qp buffer
Thread-Topic: [PATCH v2 for-next 4/5] RDMA/hns: Optimize base address table
 config flow for qp buffer
Thread-Index: AQHV82HGA4glDhjZX0+nO5yu9zTtgw==
Date:   Tue, 10 Mar 2020 01:19:03 +0000
Message-ID: <B82435381E3B2943AA4D2826ADEF0B3A022789AE@DGGEML522-MBX.china.huawei.com>
References: <1583462694-43908-1-git-send-email-liweihang@huawei.com>
 <1583462694-43908-5-git-send-email-liweihang@huawei.com>
 <20200309151030.GC172334@unreal>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.168.149]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/3/9 23:10, Leon Romanovsky wrote:
>>  static int set_extend_sge_param(struct hns_roce_dev *hr_dev,
>>  				struct hns_roce_qp *hr_qp)
>>  {
>> @@ -768,7 +744,10 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
>>  static int map_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>>  		       u32 page_shift, bool is_user)
>>  {
>> -	dma_addr_t *buf_list[ARRAY_SIZE(hr_qp->regions)] = { NULL };
>> +/* WQE buffer include 3 parts: SQ, extend SGE and RQ. */
>> +#define HNS_ROCE_WQE_REGION_MAX	 3
>> +	struct hns_roce_buf_region regions[HNS_ROCE_WQE_REGION_MAX] = {};
>> +	dma_addr_t *buf_list[HNS_ROCE_WQE_REGION_MAX] = { NULL };
> Nitpick, NULL is not needed.
> 
> Thanks
> 

OK, thank you.

Weihang
