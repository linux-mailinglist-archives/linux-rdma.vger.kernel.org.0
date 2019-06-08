Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99E639B76
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 09:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfFHHFc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jun 2019 03:05:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbfFHHFc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 8 Jun 2019 03:05:32 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4D4E9305766CF644A940;
        Sat,  8 Jun 2019 15:05:29 +0800 (CST)
Received: from [127.0.0.1] (10.65.94.163) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Sat, 8 Jun 2019
 15:05:19 +0800
Subject: Re: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
To:     Jason Gunthorpe <jgg@ziepe.ca>, Lijun Ou <oulijun@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <linuxarm@huawei.com>, <leon@kernel.org>
References: <1559285867-29529-1-git-send-email-oulijun@huawei.com>
 <1559285867-29529-2-git-send-email-oulijun@huawei.com>
 <20190607164818.GA22156@ziepe.ca>
From:   wangxi <wangxi11@huawei.com>
Message-ID: <258390c2-7668-a88a-9346-d8faa83201bb@huawei.com>
Date:   Sat, 8 Jun 2019 15:05:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190607164818.GA22156@ziepe.ca>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.65.94.163]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



ÔÚ 2019/6/8 0:48, Jason Gunthorpe Ð´µÀ:
> On Fri, May 31, 2019 at 02:57:45PM +0800, Lijun Ou wrote:
>> +
>> +static int hns_roce_write_mtr(struct hns_roce_dev *hr_dev,
>> +			      struct hns_roce_mtr *mtr, dma_addr_t *bufs,
>> +			      struct hns_roce_buf_region *r)
>> +{
>> +	int offset;
>> +	int count;
>> +	int npage;
>> +	u64 *mtts;
>> +	int end;
>> +	int i;
>> +
>> +	offset = r->offset;
>> +	end = offset + r->count;
>> +	npage = 0;
>> +	while (offset < end) {
>> +		mtts = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
>> +						  offset, &count, NULL);
>> +		if (!mtts)
>> +			return -ENOBUFS;
>> +
>> +		/* Save page addr, low 12 bits : 0 */
>> +		for (i = 0; i < count; i++) {
>> +			if (hr_dev->hw_rev == HNS_ROCE_HW_VER1)
>> +				mtts[i] = cpu_to_le64(bufs[npage] >>
>> +							PAGE_ADDR_SHIFT);
>> +			else
>> +				mtts[i] = cpu_to_le64(bufs[npage]);
>> +
>> +			npage++;
>> +		}
>> +		offset += count;
>> +	}
>> +
>> +	/* Memory barrier */
>> +	mb();
> 
> Didn't we talk about this already? Comments for all memory barriers
> have to be very good.
> 
> Be really sure you are using the right barrier type for the right
> thing, because I won't take patches that get this stuff wrong.
> 
Very thanks for pointing out this problem. After analyzing the code flow,
I found that here just need a wmb, and there is already a wmb operation
after this function is called. so I will delete it directly.

>> +int hns_roce_mtr_find(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
>> +		      int offset, u64 *mtt_buf, int mtt_max, u64 *base_addr)
>> +{
>> +	u64 *mtts = mtt_buf;
>> +	int mtt_count;
>> +	int total = 0;
>> +	u64 *addr;
>> +	int npage;
>> +	int left;
>> +
>> +	if (mtts == NULL || mtt_max < 1)
>> +		goto done;
>> +
>> +	left = mtt_max;
>> +	while (left > 0) {
>> +		mtt_count = 0;
>> +		addr = hns_roce_hem_list_find_mtt(hr_dev, &mtr->hem_list,
>> +						  offset + total,
>> +						  &mtt_count, NULL);
>> +		if (!addr || !mtt_count)
>> +			goto done;
>> +
>> +		npage = min(mtt_count, left);
>> +		memcpy(&mtts[total], addr, BA_BYTE_LEN * npage);
>> +		left -= npage;
>> +		total += npage;
>> +	}
>> +
>> +done:
>> +	if (base_addr)
>> +		*base_addr = mtr->hem_list.root_ba;
>> +
>> +	return total;
>> +}
>> +EXPORT_SYMBOL_GPL(hns_roce_mtr_find);
> 
> Why is there an EXPROT_SYMBOL in a IB driver? I see many in
> hns. Please send a patch to remove all of them and respin this.
> 
> Jason
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm
> .
> 

