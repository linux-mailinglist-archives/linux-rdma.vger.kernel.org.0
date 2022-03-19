Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C084DE72D
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 10:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbiCSJOb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Mar 2022 05:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242543AbiCSJOb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Mar 2022 05:14:31 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C55E2C66B
        for <linux-rdma@vger.kernel.org>; Sat, 19 Mar 2022 02:13:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7aDumk_1647681186;
Received: from 30.236.17.167(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V7aDumk_1647681186)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Mar 2022 17:13:07 +0800
Message-ID: <63cbec6a-0d12-a2d6-b251-5786a8b4d719@linux.alibaba.com>
Date:   Sat, 19 Mar 2022 17:13:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v4 10/12] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Wenpeng Liang <liangwenpeng@huawei.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-11-chengyou@linux.alibaba.com>
 <fb6f435b-3fc9-73d8-17e6-1c76cdd398c6@huawei.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <fb6f435b-3fc9-73d8-17e6-1c76cdd398c6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/18/22 8:46 PM, Wenpeng Liang wrote:
> On 2022/3/14 14:47, Cheng Xu wrote:
>> Add the main erdma module and debugfs files. The main module provides
>> interface to infiniband subsytem, and the debugfs module provides a way
>> to allow user can get the core status of the device and set the preferred
>> congestion control algorithm.
> 
> subsytem -> subsystem.

OK, and this comment is for patchset v1, I will fix it.


> 
> <...>
>> +static int erdma_request_vectors(struct erdma_dev *dev)
>> +{
>> +	int expect_irq_num = num_possible_cpus() + 1;
>> +
>> +	if (expect_irq_num > ERDMA_NUM_MSIX_VEC)
>> +		expect_irq_num = ERDMA_NUM_MSIX_VEC;
>> +
> 
> Consider using min() to value expect_irq_num.

Will fix.

> 
> <...>
>> +static int erdma_probe_dev(struct pci_dev *pdev)
>> +{
>> +	int err;
>> +	struct erdma_dev *dev;
>> +	u32 version;
>> +	int bars;
>> +
>> +	err = pci_enable_device(pdev);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "pci_enable_device failed(%d)\n", err);
>> +		return err;
>> +	}
>> +
>> +	pci_set_master(pdev);
>> +
>> +	dev = ib_alloc_device(erdma_dev, ibdev);
>> +	if (!dev) {
>> +		dev_err(&pdev->dev, "ib_alloc_device failed\n");
>> +		err = -ENOMEM;
>> +		goto err_disable_device;
>> +	}
>> +
>> +	pci_set_drvdata(pdev, dev);
>> +	dev->pdev = pdev;
>> +	dev->attrs.numa_node = pdev->dev.numa_node;
>> +
>> +	bars = pci_select_bars(pdev, IORESOURCE_MEM);
>> +	err = pci_request_selected_regions(pdev, bars, DRV_MODULE_NAME);
>> +	if (bars != ERDMA_BAR_MASK || err) {
>> +		err = err == 0 ? -EINVAL : err;
> 
> Consider using "err = err ? err : -EINVAL;"?

OK, it's better than the original code, will fix.

Thanks,
Cheng Xu

> 
> Thanks,
> Wenpeng
