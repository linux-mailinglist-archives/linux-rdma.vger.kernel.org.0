Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB6C491BD2
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 04:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349136AbiARDJh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jan 2022 22:09:37 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:55469 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343828AbiARC5q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Jan 2022 21:57:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V29cRIl_1642474661;
Received: from 30.43.105.202(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V29cRIl_1642474661)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 10:57:42 +0800
Message-ID: <ea21f539-0d4b-5254-8325-dee74b2d26db@linux.alibaba.com>
Date:   Tue, 18 Jan 2022 10:57:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH rdma-next v2 03/11] RDMA/erdma: Add main include file
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20220117084828.80638-1-chengyou@linux.alibaba.com>
 <20220117084828.80638-4-chengyou@linux.alibaba.com>
 <20220117145814.GB8034@ziepe.ca>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220117145814.GB8034@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/17/22 10:58 PM, Jason Gunthorpe wrote:
> On Mon, Jan 17, 2022 at 04:48:20PM +0800, Cheng Xu wrote:
>> Add ERDMA driver main header file, defining internal used data structures
>> and operations. The defined data structures includes *cmdq*, which is used
>> as the communication channel between ERDMA driver and hardware.
>>
>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>>   drivers/infiniband/hw/erdma/erdma.h | 392 ++++++++++++++++++++++++++++
>>   1 file changed, 392 insertions(+)
>>   create mode 100644 drivers/infiniband/hw/erdma/erdma.h
>>
>> diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
>> new file mode 100644
>> index 000000000000..ae9ec98e99d0
>> +++ b/drivers/infiniband/hw/erdma/erdma.h
>> @@ -0,0 +1,392 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>> +
>> +/* Authors: Cheng Xu <chengyou@linux.alibaba.com> */
>> +/*          Kai Shen <kaishen@linux.alibaba.com> */
>> +/* Copyright (c) 2020-2022, Alibaba Group. */
>> +
>> +#ifndef __ERDMA_H__
>> +#define __ERDMA_H__
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/xarray.h>
>> +#include <rdma/ib_verbs.h>
>> +
>> +#include "erdma_hw.h"
>> +
>> +#define DRV_MODULE_NAME "erdma"
>> +
>> +struct erdma_eq {
>> +	void *qbuf;
>> +	dma_addr_t qbuf_dma_addr;
>> +
>> +	u32 depth;
>> +	u64 __iomem *db_addr;
>> +
>> +	spinlock_t lock;
>> +
>> +	u16 ci;
>> +	u16 owner;
>> +
>> +	atomic64_t event_num;
>> +	atomic64_t notify_num;
>> +
>> +	void *db_info;
>> +};
>> +
>> +struct erdma_cmdq_sq {
>> +	void *qbuf;
>> +	dma_addr_t qbuf_dma_addr;
>> +
>> +	spinlock_t lock;
>> +	u64 __iomem *db_addr;
>> +
>> +	u16 ci;
>> +	u16 pi;
>> +
>> +	u16 depth;
>> +	u16 wqebb_cnt;
>> +
>> +	void *db_info;
> 
> Why are there so many void *'s in these structs?
qbuf/db_addr/db_info are resources used by ERDMA driver & device.
'void *dev' is used for convenient access the pointer structure, and
is unnecessary indeed, I will check for this and remove if unnecessary.

> 
>> +struct erdma_cmdq_cq {
>> +	void *db_info;
> 
>> +struct erdma_cmdq {
>> +	void *dev;
> 
>> +struct erdma_irq_info {
>> +	void *data;
> 
>> +struct erdma_eq_cb {
>> +	void *dev;
> 
>> +struct erdma_dev {
>> +	void *dmadev;
>> +	void *drvdata;
>> +	/* reference to drvdata->cmdq */
>> +	struct erdma_cmdq *cmdq;
>> +
>> +	void (*release_handler)(void *drvdata);
> 
> Why??
> 

After reading all your review suggestions and questions, I think this 
question, and other questions in PCI probe/remove, module_exit 
functions, have a relationship with the ibdev generation mechanism of
this version's driver. I realize it is not proper, and I think you
already get the reason according your responses.

In the v1 driver, we create IB deivce in PCI probe function, and
register IB device in net notifiers. In the v2 driver, we introduce the
separated device structures (struct erdma_pci_drvdata/struct erdma_dev)
to support dynamic IB device creation, because we think the user should
control the lifecycle of IB device by 'rdma link' command, by mistake.

Back to the 'release_handler', it is used for cleanup the
erdma_pci_drvdata structure after IB device dealloc. We will fix all our
mechanism.

Thanks,
Cheng Xu


>> +	int cc_method;
>> +	int disable_dwqe;
>> +	int dwqe_pages;
>> +	int dwqe_entries;
> 
> Use proper types, bool unsinged int, etc.
> 

Will fix.

> 
>> +#define ERDMA_CMDQ_BUILD_REQ_HDR(hdr, mod, op)\
>> +do { \
>> +	*(u64 *)(hdr) = FIELD_PREP(ERDMA_CMD_HDR_SUB_MOD_MASK, mod);\
>> +	*(u64 *)(hdr) |= FIELD_PREP(ERDMA_CMD_HDR_OPCODE_MASK, op);\
>> +} while (0)
> 
> Would prefer an inline wrappered in a macro

Will fix.

> 
>> +int erdma_post_cmd_wait(struct erdma_cmdq *cmdq, u64 *req, u32 req_size, u64 *resp0, u64 *resp1);
>> +void erdma_cmdq_completion_handler(struct erdma_cmdq *cmdq);
>> +
>> +int erdma_ceqs_init(struct erdma_pci_drvdata *drvdata);
>> +void erdma_ceqs_uninit(struct erdma_pci_drvdata *drvdata);
>> +
>> +int erdma_aeq_init(struct erdma_pci_drvdata *drvdata);
>> +void erdma_aeq_destroy(struct erdma_pci_drvdata *drvdata);
>> +
>> +void erdma_aeq_event_handler(struct erdma_pci_drvdata *drvdata);
>> +void erdma_ceq_completion_handler(struct erdma_eq_cb *ceq_cb);
> 
> Don't use the word 'drvdata' in a driver if you can avoid it. It
> should only be used to describe the pointer stored in the struct
> device, and ib devices don't work that way.
> 
> Jason

OK, I get it, and will remove them in next version.

Thanks,
Cheng Xu
