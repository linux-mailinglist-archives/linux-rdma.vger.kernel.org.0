Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010E44DD7FB
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 11:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiCRKgp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 06:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiCRKg1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 06:36:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350E9261DE8
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 03:35:06 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KKgPf0mMnzcZxP;
        Fri, 18 Mar 2022 18:35:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 18:35:04 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 18:35:04 +0800
Subject: Re: [PATCH for-next v4 04/12] RDMA/erdma: Add main include file
To:     Cheng Xu <chengyou@linux.alibaba.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-5-chengyou@linux.alibaba.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <KaiShen@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
        <BMT@zurich.ibm.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <8db3d093-59bf-0154-6320-47f8465a7338@huawei.com>
Date:   Fri, 18 Mar 2022 18:35:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220314064739.81647-5-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

> +struct erdma_dev {
> +	struct ib_device ibdev;
> +	struct net_device *netdev;
> +	struct pci_dev *pdev;
> +	struct notifier_block netdev_nb;
> +
> +	resource_size_t func_bar_addr;
> +	resource_size_t func_bar_len;
> +	u8 __iomem *func_bar;
> +
> +	struct erdma_devattr attrs;
> +	/* physical port state (only one port per device) */
> +	enum ib_port_state state;
> +
> +	/* cmdq and aeq use the same msix vector */
> +	u32 comm_msix_vector;
> +	char comm_irq_name[ERDMA_IRQNAME_SIZE];
> +	struct erdma_cmdq cmdq;
> +	struct erdma_eq aeq;
> +	struct erdma_eq_cb ceqs[31];

Does "31" represent the device capacity of ceq?
Seems like a magic number

Thanks,
Wenpeng

> +
> +	spinlock_t lock;
> +	struct erdma_resource_cb res_cb[ERDMA_RES_CNT];
> +	struct xarray qp_xa;
> +	struct xarray cq_xa;
> +
