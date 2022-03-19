Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2734DE6EA
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 09:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiCSIMk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Mar 2022 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiCSIMi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Mar 2022 04:12:38 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C3617A2E1
        for <linux-rdma@vger.kernel.org>; Sat, 19 Mar 2022 01:11:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7aCaE6_1647677475;
Received: from 30.236.17.167(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V7aCaE6_1647677475)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Mar 2022 16:11:16 +0800
Message-ID: <acc74e08-0c47-0e4e-f083-af5608b69101@linux.alibaba.com>
Date:   Sat, 19 Mar 2022 16:11:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v4 04/12] RDMA/erdma: Add main include file
Content-Language: en-US
To:     Wenpeng Liang <liangwenpeng@huawei.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-5-chengyou@linux.alibaba.com>
 <8db3d093-59bf-0154-6320-47f8465a7338@huawei.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <8db3d093-59bf-0154-6320-47f8465a7338@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/18/22 6:35 PM, Wenpeng Liang wrote:
>> +struct erdma_dev {
>> +	struct ib_device ibdev;
>> +	struct net_device *netdev;
>> +	struct pci_dev *pdev;
>> +	struct notifier_block netdev_nb;
>> +
>> +	resource_size_t func_bar_addr;
>> +	resource_size_t func_bar_len;
>> +	u8 __iomem *func_bar;
>> +
>> +	struct erdma_devattr attrs;
>> +	/* physical port state (only one port per device) */
>> +	enum ib_port_state state;
>> +
>> +	/* cmdq and aeq use the same msix vector */
>> +	u32 comm_msix_vector;
>> +	char comm_irq_name[ERDMA_IRQNAME_SIZE];
>> +	struct erdma_cmdq cmdq;
>> +	struct erdma_eq aeq;
>> +	struct erdma_eq_cb ceqs[31];
> 
> Does "31" represent the device capacity of ceq?
> Seems like a magic number
> 

Will fix, and it should be
struct erdma_eq_cb ceqs[ERDMA_NUM_MSIX_VEC -1].

Thanks,
Cheng Xu

> Thanks,
> Wenpeng
> 
>> +
>> +	spinlock_t lock;
>> +	struct erdma_resource_cb res_cb[ERDMA_RES_CNT];
>> +	struct xarray qp_xa;
>> +	struct xarray cq_xa;
>> +
