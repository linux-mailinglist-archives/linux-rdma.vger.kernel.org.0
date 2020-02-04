Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD7115168A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 08:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgBDHlu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 02:41:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbgBDHlu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 02:41:50 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ECC45F69354AFA45513A;
        Tue,  4 Feb 2020 15:41:43 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Feb 2020
 15:41:38 +0800
Subject: Re: [PATCH v7 for-next 2/2] RDMA/hns: Delayed flush cqe process with
 workqueue
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1579081753-2839-1-git-send-email-liuyixian@huawei.com>
 <1579081753-2839-3-git-send-email-liuyixian@huawei.com>
 <20200128195643.GA8107@ziepe.ca>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <ecef1a64-6aa0-c1f9-e0f8-cc40329eb335@huawei.com>
Date:   Tue, 4 Feb 2020 15:41:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20200128195643.GA8107@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/1/29 3:56, Jason Gunthorpe wrote:
> On Wed, Jan 15, 2020 at 05:49:13PM +0800, Yixian Liu wrote:
>> -			if (ret) {
>> -				spin_unlock_irqrestore(&qp->sq.lock, flags);
>> -				*bad_wr = wr;
>> -				return ret;
>> +			if (atomic_read(&qp->flush_cnt) == 0) {
>> +				atomic_set(&qp->flush_cnt, 1);
>> +				init_flush_work(hr_dev, qp);
>> +			} else {
>> +				atomic_inc(&qp->flush_cnt);
>>  			}
> 
> Surely this should be written using atomic_add_return ??
> 
> Jason

Hi Jason,

Thanks very much for your good suggestion!
The code then can be simplified as:

if (atomic_add_return(1, &qp->flush_cnt) == 1)
	init_flush_work(hr_dev, qp);

> 
> 

