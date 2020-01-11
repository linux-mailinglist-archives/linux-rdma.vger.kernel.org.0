Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7692137CCA
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jan 2020 10:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgAKJuL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 11 Jan 2020 04:50:11 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57634 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728772AbgAKJuL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 11 Jan 2020 04:50:11 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 030C3A213FABD2DC1023;
        Sat, 11 Jan 2020 17:50:09 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 11 Jan 2020
 17:49:59 +0800
Subject: Re: [PATCH v5 for-next 1/2] RDMA/hns: Add the workqueue framework for
 flush cqe handler
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1577503735-26685-1-git-send-email-liuyixian@huawei.com>
 <1577503735-26685-2-git-send-email-liuyixian@huawei.com>
 <20200110152602.GC8765@ziepe.ca>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <0c78d7db-21ce-10bd-8a75-f712d18a1c83@huawei.com>
Date:   Sat, 11 Jan 2020 17:49:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20200110152602.GC8765@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/1/10 23:26, Jason Gunthorpe wrote:
> On Sat, Dec 28, 2019 at 11:28:54AM +0800, Yixian Liu wrote:
>> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
>> +{
>> +	struct hns_roce_work *flush_work;
>> +
>> +	flush_work = kzalloc(sizeof(struct hns_roce_work), GFP_ATOMIC);
>> +	if (!flush_work)
>> +		return;
> 
> You changed it to only queue once, so why do we need the allocation
> now? That was the whole point..
> 
> And the other patch shouldn't be manipulating being_pushed without
> some kind of locking

Hi Jason, thanks for your suggestion, I will consider them in next version.

> 
> Jason
> 
> 

