Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E03C14B
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 04:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390830AbfFKCik (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 22:38:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390244AbfFKCik (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 22:38:40 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4E83EB249BA789F898A6;
        Tue, 11 Jun 2019 10:38:38 +0800 (CST)
Received: from [127.0.0.1] (10.65.94.163) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Jun 2019
 10:38:32 +0800
Subject: Re: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        <dledford@redhat.com>, <linuxarm@huawei.com>, <leon@kernel.org>
References: <1559285867-29529-1-git-send-email-oulijun@huawei.com>
 <1559285867-29529-2-git-send-email-oulijun@huawei.com>
 <20190607164818.GA22156@ziepe.ca>
 <26040386-e155-7223-b2b7-48e74e92b521@huawei.com>
 <20190610132716.GC18468@ziepe.ca>
From:   wangxi <wangxi11@huawei.com>
Message-ID: <1e1f3980-6c31-c562-7f23-7734bf739ef4@huawei.com>
Date:   Tue, 11 Jun 2019 10:37:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190610132716.GC18468@ziepe.ca>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.65.94.163]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



ÔÚ 2019/6/10 21:27, Jason Gunthorpe Ð´µÀ:
> On Sat, Jun 08, 2019 at 10:24:15AM +0800, wangxi wrote:
> 
>>> Why is there an EXPROT_SYMBOL in a IB driver? I see many in
>>> hns. Please send a patch to remove all of them and respin this.
>>>
>> There are 2 modules in our ib driver, one is hns_roce.ko, another
>> is hns_roce_hw_v2.ko. all extern symbols are named like hns_roce_xxx,
>> this function defined in hns_roce.ko, and invoked in
>> hns_roce_hw_v2.ko.
> 
> seems unnecessarily complicated
> 
> Jason
> .
> 
Hi,Jason,

The hns ib driver was originally designed for the hip06. When designing the
driver for the new hardware hip08, in order to maximize the reuse of the
existing hip06 code, the common part of the code is separated into the
hns_roce.ko, and the hardware difference code is defined into hns_roce_hw_v1.ko
for hip06 and hns_roce_hw_v2.ko for hip08.

The mtr code is designed as a public part in this patchset, so it is defined
in hns_roce.ko. It can be used for hi16xx series hardware with mixed mutihop
addressing feature. Currently, hip08 supports this feature, so it is be called
in hns_roce_hw_v2.ko.

Xi Wang

