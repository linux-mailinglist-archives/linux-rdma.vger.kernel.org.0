Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0566EEF785
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 09:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfKEIrs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 03:47:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725806AbfKEIrr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 03:47:47 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BF6AE1E40C4243119B71;
        Tue,  5 Nov 2019 16:47:45 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 5 Nov 2019
 16:47:41 +0800
Subject: =?UTF-8?B?UmU6IOOAkEFzayBmb3IgaGVscOOAkSBBIHF1ZXN0aW9uIGZvciBfX2li?=
 =?UTF-8?B?X2NhY2hlX2dpZF9hZGQoKQ==?=
To:     Mark Zhang <markz@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Parav Pandit" <parav@mellanox.com>
CC:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <fd2a9385-f6c7-8471-b20c-476d4e9fada7@huawei.com>
 <20191101130540.GB30938@ziepe.ca>
 <f16f1832-6ca2-e606-259e-d039e8e47804@mellanox.com>
From:   oulijun <oulijun@huawei.com>
Message-ID: <1cd67a16-cd8f-7337-1ac0-854314b441b9@huawei.com>
Date:   Tue, 5 Nov 2019 16:47:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <f16f1832-6ca2-e606-259e-d039e8e47804@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/11/1 21:21, Mark Zhang 写道:
> On 11/1/2019 9:05 PM, Jason Gunthorpe wrote:
>> On Fri, Nov 01, 2019 at 05:36:36PM +0800, oulijun wrote:
>>> Hi
>>>    I am using the ubuntu system(5.0.0 kernel) to test the hip08 NIC port,. When I modify the perr mac1 to mac2,then restore to mac1, it will cause
>>> the gid0 and gid 1 of the roce to be unavailable, and check that the /sys/class/infiniband/hns_0/ports/1/gid_attrs/ndevs/0 is show invalid.
>>> the protocol stack print will appear.
>>>
>>>    Oct 16 17:59:36 ubuntu kernel: [200635.496317] __ib_cache_gid_add: unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:9599 error=-28
>>> Oct 16 17:59:37 ubuntu kernel: [200636.705848] 8021q: adding VLAN 0 to HW filter on device enp189s0f0
>>> Oct 16 17:59:37 ubuntu kernel: [200636.705854] __ib_cache_gid_add: unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:9599 error=-28
>>> Oct 16 17:59:39 ubuntu kernel: [200638.755828] hns3 0000:bd:00.0 enp189s0f0: link up
>>> Oct 16 17:59:39 ubuntu kernel: [200638.755847] IPv6: ADDRCONF(NETDEV_CHANGE): enp189s0f0: link becomes ready
>>> Oct 16 18:00:56 ubuntu kernel: [200715.699961] hns3 0000:bd:00.0 enp189s0f0: link down
>>> Oct 16 18:00:56 ubuntu kernel: [200716.016142] __ib_cache_gid_add: unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:95f4 error=-28
>>> Oct 16 18:00:58 ubuntu kernel: [200717.229857] 8021q: adding VLAN 0 to HW filter on device enp189s0f0
>>> Oct 16 18:00:58 ubuntu kernel: [200717.229863] __ib_cache_gid_add: unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:95f4 error=-28
>>>
>>> Has anyone else encounterd a similar problem ? I wonder if the _ib_cache_add_gid() is defective in 5.0 kernel?
>> Maybe Parav knows?
>>
> One possibility is, during the operation you have port reset; Then
> all gids will be deleted and re-created. But during gids re-build
> gid entry #0 and #1 is in use, so they cannot be deleted then you
> get this error.
Thank your reply. I will check it acording to my logs.
>> Jason
>>


