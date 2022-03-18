Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F614DD9EC
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 13:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiCRMsG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 08:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiCRMsF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 08:48:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA212E415F
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 05:46:47 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KKkHw4DJzzfYqd;
        Fri, 18 Mar 2022 20:45:16 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 20:46:45 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 20:46:45 +0800
Subject: Re: [PATCH for-next v4 10/12] RDMA/erdma: Add the erdma module
To:     Cheng Xu <chengyou@linux.alibaba.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-11-chengyou@linux.alibaba.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <KaiShen@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
        <BMT@zurich.ibm.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <fb6f435b-3fc9-73d8-17e6-1c76cdd398c6@huawei.com>
Date:   Fri, 18 Mar 2022 20:46:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220314064739.81647-11-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/3/14 14:47, Cheng Xu wrote:
> Add the main erdma module and debugfs files. The main module provides
> interface to infiniband subsytem, and the debugfs module provides a way
> to allow user can get the core status of the device and set the preferred
> congestion control algorithm.

subsytem -> subsystem.

<...>
> +static int erdma_request_vectors(struct erdma_dev *dev)
> +{
> +	int expect_irq_num = num_possible_cpus() + 1;
> +
> +	if (expect_irq_num > ERDMA_NUM_MSIX_VEC)
> +		expect_irq_num = ERDMA_NUM_MSIX_VEC;
> +

Consider using min() to value expect_irq_num.

<...>
> +static int erdma_probe_dev(struct pci_dev *pdev)
> +{
> +	int err;
> +	struct erdma_dev *dev;
> +	u32 version;
> +	int bars;
> +
> +	err = pci_enable_device(pdev);
> +	if (err) {
> +		dev_err(&pdev->dev, "pci_enable_device failed(%d)\n", err);
> +		return err;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	dev = ib_alloc_device(erdma_dev, ibdev);
> +	if (!dev) {
> +		dev_err(&pdev->dev, "ib_alloc_device failed\n");
> +		err = -ENOMEM;
> +		goto err_disable_device;
> +	}
> +
> +	pci_set_drvdata(pdev, dev);
> +	dev->pdev = pdev;
> +	dev->attrs.numa_node = pdev->dev.numa_node;
> +
> +	bars = pci_select_bars(pdev, IORESOURCE_MEM);
> +	err = pci_request_selected_regions(pdev, bars, DRV_MODULE_NAME);
> +	if (bars != ERDMA_BAR_MASK || err) {
> +		err = err == 0 ? -EINVAL : err;

Consider using "err = err ? err : -EINVAL;"?

Thanks,
Wenpeng
