Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27F047CB5F
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Dec 2021 03:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhLVCeC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 21:34:02 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59256 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230172AbhLVCeC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Dec 2021 21:34:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V.NnUMa_1640140439;
Received: from 30.43.106.56(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V.NnUMa_1640140439)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Dec 2021 10:34:00 +0800
Message-ID: <7458a37a-486a-8ed8-4e0b-caf31922b6fe@linux.alibaba.com>
Date:   Wed, 22 Dec 2021 10:33:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH rdma-next 09/11] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20211221024858.25938-1-chengyou@linux.alibaba.com>
 <20211221024858.25938-10-chengyou@linux.alibaba.com>
 <YcHV/+VeD2xxIU3I@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YcHV/+VeD2xxIU3I@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/21/21 9:26 PM, Leon Romanovsky wrote:
> On Tue, Dec 21, 2021 at 10:48:56AM +0800, Cheng Xu wrote:
>> Add the main erdma module and debugfs files. The main module provides
>> interface to infiniband subsytem, and the debugfs module provides a way
>> to allow user can get the core status of the device and set the preferred
>> congestion control algorithm.
> 
> debugfs is for debug - dump various information.
> It is not the right interface to set configuration properties.

I agree. At first we want to implement 'device_group' interface, but it
is not recommended for new drivers, and we find current netlink command
do not meet our requirement (maybe we missed something). So we use
debugfs as the cc configuration interface temporarily. It would be
better if you could give us some suggestions.

>>
>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>> ---
>>   drivers/infiniband/hw/erdma/erdma_debug.c | 314 ++++++++++
>>   drivers/infiniband/hw/erdma/erdma_debug.h |  18 +
>>   drivers/infiniband/hw/erdma/erdma_main.c  | 711 ++++++++++++++++++++++
>>   3 files changed, 1043 insertions(+)
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_debug.c
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_debug.h
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma_main.c
>>
>> diff --git a/drivers/infiniband/hw/erdma/erdma_debug.c b/drivers/infiniband/hw/erdma/erdma_debug.c
>> new file mode 100644
>> index 000000000000..3cbed4dde0e2
>> --- /dev/null
>> +++ b/drivers/infiniband/hw/erdma/erdma_debug.c
>> @@ -0,0 +1,314 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Authors: Cheng Xu <chengyou@linux.alibaba.com>
>> + *          Kai Shen <kaishen@linux.alibaba.com>
>> + * Copyright (c) 2020-2021, Alibaba Group.
>> + */
>> +#include <linux/errno.h>
>> +#include <linux/types.h>
>> +#include <linux/list.h>
>> +#include <linux/debugfs.h>
>> +
>> +#include <rdma/iw_cm.h>
>> +#include <rdma/ib_verbs.h>
>> +#include <rdma/ib_smi.h>
>> +#include <rdma/ib_user_verbs.h>
>> +
>> +#include "erdma.h"
>> +#include "erdma_cm.h"
>> +#include "erdma_debug.h"
>> +#include "erdma_verbs.h"
>> +
>> +char *cc_method_string[ERDMA_CC_METHODS_NUM] = {
>> +	[ERDMA_CC_NEWRENO] = "newreno",
>> +	[ERDMA_CC_CUBIC] = "cubic",
>> +	[ERDMA_CC_HPCC_RTT] = "hpcc_rtt",
>> +	[ERDMA_CC_HPCC_ECN] = "hpcc_ecn",
>> +	[ERDMA_CC_HPCC_INT] = "hpcc_int"
>> +};
>> +
>> +static struct dentry *erdma_debugfs;
>> +
>> +
>> +static int erdma_dbgfs_file_open(struct inode *inode, struct file *fp)
>> +{
>> +	fp->private_data = inode->i_private;
>> +	return nonseekable_open(inode, fp);
>> +}
>> +
>> +static ssize_t erdma_show_stats(struct file *fp, char __user *buf, size_t space,
>> +			      loff_t *ppos)
>> +{
>> +	struct erdma_dev *dev = fp->private_data;
>> +	char *kbuf = NULL;
>> +	int len = 0;
>> +
>> +	if (*ppos)
>> +		goto out;
>> +
>> +	kbuf = kmalloc(space, GFP_KERNEL);
>> +	if (!kbuf)
>> +		goto out;
>> +
>> +	len = snprintf(kbuf, space, "Resource Summary of %s:\n"
>> +		"%s: %d\n%s: %d\n%s: %d\n%s: %d\n%s: %d\n%s: %d\n",
>> +		dev->ibdev.name,
>> +		"ucontext ", atomic_read(&dev->num_ctx),
>> +		"pd       ", atomic_read(&dev->num_pd),
>> +		"qp       ", atomic_read(&dev->num_qp),
>> +		"cq       ", atomic_read(&dev->num_cq),
>> +		"mr       ", atomic_read(&dev->num_mr),
> 
> Why do you need to duplicate "restrack res ..."?

We will remove this unnecessary code.

Thanks,
Cheng Xu

> 
>> +		"cep      ", atomic_read(&dev->num_cep));
>> +	if (len > space)
>> +		len = space;
>> +out:
>> +	if (len)
>> +		len = simple_read_from_buffer(buf, len, ppos, kbuf, len);
>> +
>> +	kfree(kbuf);
>> +	return len;
>> +
>> +}
>> +
> 
> Thanks
