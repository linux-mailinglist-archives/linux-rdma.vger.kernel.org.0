Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A6556A3B7
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jul 2022 15:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiGGNdM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jul 2022 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbiGGNdJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jul 2022 09:33:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C1431DF4
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 06:33:04 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ldy443w7pzkXPb;
        Thu,  7 Jul 2022 21:31:32 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 21:33:01 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Jul
 2022 21:33:00 +0800
Subject: Re: [PATCH for-next 5/5] RDMA/hns: Recover 1bit-ECC error of RAM on
 chip
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220624110845.48184-1-liangwenpeng@huawei.com>
 <20220624110845.48184-6-liangwenpeng@huawei.com>
 <20220704134935.GA1422797@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <4d882ff4-08aa-dfbf-e79e-8ea2cdb5c274@huawei.com>
Date:   Thu, 7 Jul 2022 21:32:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220704134935.GA1422797@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2022/7/4 21:49, Jason Gunthorpe wrote:
>> +static const struct {
>> +	char *name;
> const char *
> 

I will fix it in v2.

>> +	ret = hns_roce_cmq_send(hr_dev, &desc, 1);
>> +	if (ret) {
>> +		dev_err(hr_dev->dev,
>> +			"failed to execute cmd to read gmv, ret = %d.\n", ret);
>> +		return ret;
> Shouldn't all these prints use the IB version of the loggers?
> 

Some types of interrupts may be generated before the ib device
is registered, so all these prints use dev_err().

>> +static irqreturn_t abnormal_interrupt_others(struct hns_roce_dev *hr_dev)
>> +{
>> +	struct hns_roce_work *ecc_work;
>> +
>> +	ecc_work = kzalloc(sizeof(*ecc_work), GFP_ATOMIC);
>> +	if (!ecc_work)
>> +		return IRQ_NONE;
>> +
>> +	ecc_work->hr_dev = hr_dev;
> Since there is nothing in this work you should just embed it in the
> struct hns_roce_dev and use container_of to get the hr_dev. Then there
> is no allocation here.
> 

Fix it in v2.

Thanks,
Wenpeng

> Jason
> .
> 
