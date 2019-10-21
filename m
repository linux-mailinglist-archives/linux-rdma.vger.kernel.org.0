Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1AAFDEF4A
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 16:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfJUOUo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 10:20:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34920 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfJUOUo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Oct 2019 10:20:44 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 17E06D202B61AA6CA61D;
        Mon, 21 Oct 2019 22:20:43 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 21 Oct 2019
 22:20:32 +0800
Subject: Re: [RFC PATCH V2 for-next] RDMA/hns: Add UD support for hip08
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1571474772-2212-1-git-send-email-oulijun@huawei.com>
 <20191021141312.GD25178@ziepe.ca>
From:   oulijun <oulijun@huawei.com>
Message-ID: <9eea1f7b-fef1-080a-2f54-64b914822c94@huawei.com>
Date:   Mon, 21 Oct 2019 22:20:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20191021141312.GD25178@ziepe.ca>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ÔÚ 2019/10/21 22:13, Jason Gunthorpe Ð´µÀ:
> On Sat, Oct 19, 2019 at 04:46:12PM +0800, Lijun Ou wrote:
>> index bd78ff9..722cc5f 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> @@ -377,6 +377,10 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
>>  		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
>>  							(hr_qp->sq.max_gs - 2));
>>  
>> +	if (hr_qp->ibqp.qp_type == IB_QPT_UD)
>> +		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
>> +						       hr_qp->sq.max_gs);
>> +
>>  	if ((hr_qp->sq.max_gs > 2) && (hr_dev->pci_dev->revision == 0x20)) {
>>  		if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
>>  			dev_err(hr_dev->dev,
>> @@ -1022,6 +1026,9 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
>>  	int ret;
>>  
>>  	switch (init_attr->qp_type) {
>> +	case IB_QPT_UD:
>> +		if (!capable(CAP_NET_RAW))
>> +			return -EPERM;
> This needs a big comment explaining why this HW requires it.
>
> Jason
>
Add the detail comments for HW limit?
> .
>


