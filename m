Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399B249252A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 12:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241032AbiARLr6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 06:47:58 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56096 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239760AbiARLr5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 06:47:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V2C1fVx_1642506474;
Received: from 30.43.105.202(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V2C1fVx_1642506474)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Jan 2022 19:47:55 +0800
Message-ID: <c3670360-2542-7c6b-9545-114afebfdfa1@linux.alibaba.com>
Date:   Tue, 18 Jan 2022 19:47:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the erdma module
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        tonylu@linux.alibaba.com
References: <20220117084828.80638-1-chengyou@linux.alibaba.com>
 <20220117084828.80638-10-chengyou@linux.alibaba.com>
 <20220117152217.GD8034@ziepe.ca>
 <54485395-089d-acdd-7296-d82c8e950599@linux.alibaba.com>
 <YeZ6M4z8amVc7ETT@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YeZ6M4z8amVc7ETT@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/18/22 4:28 PM, Leon Romanovsky wrote:
> On Tue, Jan 18, 2022 at 11:29:34AM +0800, Cheng Xu wrote:
>>
>>
>> On 1/17/22 11:22 PM, Jason Gunthorpe wrote:
>>> On Mon, Jan 17, 2022 at 04:48:26PM +0800, Cheng Xu wrote:
>>>> Add the main erdma module and debugfs files. The main module provides
>>>> interface to infiniband subsytem, and the debugfs module provides a way
>>>> to allow user can get the core status of the device and set the preferred
>>>> congestion control algorithm.
> 
> <...>
> 
>>>
>>>> +static __init int erdma_init_module(void)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	ret = erdma_cm_init();
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = pci_register_driver(&erdma_pci_driver);
>>>> +	if (ret) {
>>>> +		pr_err("Couldn't register erdma driver.\n");
>>>> +		goto uninit_cm;
>>>> +	}
>>>> +
>>>> +	ret = register_netdevice_notifier(&erdma_netdev_nb);
>>>> +	if (ret)
>>>> +		goto unregister_driver;
>>>
>>> And notifiers should not be registered without devices.
>>
>> I'm confused about this. irdma/bnxt_re/siw/rxe register net notifiers in
>> their module_init, and get their ibdev structures by function
>> 'ib_device_get_by_netdev'. Other drivers (mlx4/mlx5/hns) register notifiers
>> with devices.
> 
> Let's put siw and RXE aside, they are special. Regarding irdma - it is a
> bug and its register notifier logic should be in driver init code. It
> will ensure that notifications are received only when the ib device is
> ready.
> 
> And for the bnxt_re case, I didn't look too closely on why it is written
> how it is written.
> 
> Thanks

Get it, thanks.

Cheng Xu


