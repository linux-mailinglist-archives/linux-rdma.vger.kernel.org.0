Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402132D6D88
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 02:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgLKB25 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 10 Dec 2020 20:28:57 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4112 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbgLKB2n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 20:28:43 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CsY742w7bzXlxm;
        Fri, 11 Dec 2020 09:27:28 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 11 Dec 2020 09:27:57 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 11 Dec 2020 09:27:57 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Fri, 11 Dec 2020 09:27:57 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v4 for-next 00/11] RDMA/hns: Updates for 5.11
Thread-Topic: [PATCH v4 for-next 00/11] RDMA/hns: Updates for 5.11
Thread-Index: AQHWzvyRsBUceKGxqEyJpWg1WxvDMw==
Date:   Fri, 11 Dec 2020 01:27:56 +0000
Message-ID: <9786ecef015b4f8d9efa2b264dbe89d9@huawei.com>
References: <1607608479-54518-1-git-send-email-liweihang@huawei.com>
 <20201211001620.GA2159051@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/12/11 8:16, Jason Gunthorpe wrote:
> On Thu, Dec 10, 2020 at 09:54:28PM +0800, Weihang Li wrote:
>> There are miscellaneous updates for hns driver:
>> * #1 fixes a potential length issue when copying udata.
>> * #2 fixes the unreasonable judgment when using HEM of SRQ and SCCC.
>> * #3 fixes wrong value of Traffic Class.
>> * #4 and #5 fix issues about Service Level.
>> * #6 ~ #11 are cleanups, including removing dead code, fixing coding style
>>   issues and so on.
> 
> Doesn't compile:
> 
> In file included from drivers/infiniband/hw/hns/hns_roce_hw_v1.c:40:
> drivers/infiniband/hw/hns/hns_roce_hw_v1.c: In function ‘set_eq_cons_index_v1’:
> drivers/infiniband/hw/hns/hns_roce_hw_v1.c:3606:42: error: ‘struct hns_roce_eq’ has no member named ‘db_reg’
>  3606 |          (req_not << eq->log_entries), eq->db_reg);
>       |                                          ^~
> drivers/infiniband/hw/hns/hns_roce_common.h:39:49: note: in definition of macro ‘roce_raw_write’
>    39 |  __raw_writel((__force u32)cpu_to_le32(value), (addr))
>       |                                                 ^~~~
> 
> Jason
> 

Sorry for that, will fix it later.

Weihang
