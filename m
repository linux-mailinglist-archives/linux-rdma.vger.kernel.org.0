Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F622C1FAA
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 09:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgKXIOy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 24 Nov 2020 03:14:54 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2071 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgKXIOy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Nov 2020 03:14:54 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CgGyJ4yMVzVh3f;
        Tue, 24 Nov 2020 16:14:16 +0800 (CST)
Received: from dggema752-chm.china.huawei.com (10.1.198.194) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 24 Nov 2020 16:14:51 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema752-chm.china.huawei.com (10.1.198.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 24 Nov 2020 16:14:50 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Tue, 24 Nov 2020 16:14:50 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Create QP with selected QPN for
 bank load balance
Thread-Topic: [PATCH v2 for-next] RDMA/hns: Create QP with selected QPN for
 bank load balance
Thread-Index: AQHWwbQnlQQbrzIbsEK+EdXDHVqsxg==
Date:   Tue, 24 Nov 2020 08:14:50 +0000
Message-ID: <481c1de575b841aca47a4c5ba97ad0ac@huawei.com>
References: <1606136808-32136-1-git-send-email-liweihang@huawei.com>
 <20201123161717.GV244516@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/11/24 0:17, Jason Gunthorpe wrote:
> On Mon, Nov 23, 2020 at 09:06:48PM +0800, Weihang Li wrote:
>> +static int alloc_qpn_with_bankid(struct hns_roce_bank *bank, u8 bankid,
>> +				 unsigned long *qpn)
>> +{
>> +	int id;
>> +
>> +	id = ida_alloc_range(&bank->ida, bank->min, bank->max, GFP_KERNEL);
>> +	if (id < 0) {
>> +		id = ida_alloc_range(&bank->ida, bank->rsv_bot, bank->min,
>> +				     GFP_KERNEL);
> 
> Shouldn't this one be bank->max not min? That is the usual way to write a
> cyclic allocator over this kind of API. See the logic in __xa_alloc_cyclic()
> 
> Jason
> 

Thanks for your advice, it's clearer to use bank->max here. We will refer to
how __xa_alloc_cyclic() is implemented.

Weihang
