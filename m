Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D335A065
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfF1QIG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 12:08:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbfF1QIG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 12:08:06 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 19DEF29759364A34F3A8
        for <linux-rdma@vger.kernel.org>; Sat, 29 Jun 2019 00:08:04 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 29 Jun 2019
 00:07:54 +0800
To:     Jason Gunthorpe <jgg@ziepe.ca>, <shiraz.saleem@intel.com>
From:   oulijun <oulijun@huawei.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: [BUGReport for rdma in kernel5.2-rc4]
Message-ID: <eaa1f156-c9df-f2f6-3c23-f2c1b23e484c@huawei.com>
Date:   Sat, 29 Jun 2019 00:07:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Hi Shiraz & Jason,

We have observed a crash when run perftest on a hisilicon arm64 platform in kernel-5.2-rc4.

We also tested with different kernel version and found it started from the the following commit:
   d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in SGEs")

Could you please share any hint how to resolve this kind issue?
Thanks!

The command we are using to run the perftest is as:

ib_write_bw -d hns_2 -n 5 &
ib_write_bw -d hns_2 -n 5 192.168.10.110

The log is as below:

root@(none)$ ib_write_bw -d hns_2 -n 5 &
[[1] 1149
  484.818219] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
[  484.818219] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
[  484.832330] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
[  484.832330] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1

************************************
* Waiting for client to connect... *
************************************
root@(none)$ ib_write_bw -d hns_2 -n 5 192.168.10.110
[  488.215284] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
[  488.215284] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
[  488.228526] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
[  488.228526] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
cqe = 5, less than minimum CQE nu[mber.
cqe = 5, less than minimum CQE number.
---------------------------------------------------------------------------------------
                    RDMA_Write BW Test
 Dual-port       : OFF		Device         : hns_2
 Number of qps   : 1		Transport type : IB
 Connection type : RC		Using SRQ      : OFF
 TX depth        : 5
 CQ Moderation   : 5
 Mtu             : 1024[B]
 Link type       : Ethernet
 GID index       : 2
 Max inline data : 0[B]
 rdma_cm QPs	 : OFF
 Data ex. method : Ethernet
---------------------------------------------------------------------------------------
 local address: LID 0000 QPN 0x000d PSN 0x7d8986 RKey 0x000200 VAddr 0x00ffffbd254000
 GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
  489.244399] BUG: Bad page map in process ib_write_bw  pte:e800305b55ef53 pmd:3fb6044003
[  489.244399] BUG: Bad page map in process ib_write_bw  pte:e800305b55ef53 pmd:3fb6044003
[  489.327926] page:ffff7e1d416d5780 refcount:1 mapcount:-1 mapping:ffff875fb60453c9 index:0x0
[  489.327926] page:ffff7e1d416d5780 refcount:1 mapcount:-1 mapping:ffff875fb60453c9 index:0x0
[  489.344651] anon
[  489.344651] anon
[  489.344652] flags: 0x5fffe00000080034(uptodate|lru|active|swapbacked)
[  489.344652] flags: 0x5fffe00000080034(uptodate|lru|active|swapbacked)
[  489.361380] raw: 5fffe00000080034 ffff7e1d416d5a48 ffff7e1d416d5c48 ffff875fb60453c9
[  489.361380] raw: 5fffe00000080034 ffff7e1d416d5a48 ffff7e1d416d5c48 ffff875fb60453c9
[  489.376884] raw: 0000000000000000 0000000000000000 00000001fffffffe ffff874fbf6b4000
[  489.376884] raw: 0000000000000000 0000000000000000 00000001fffffffe ffff874fbf6b4000
[  489.392387] page dumped because: bad pte
[  489.392387] page dumped because: bad pte
[  489.400228] page->mem_cgroup:ffff874fbf6b4000
[  489.400228] page->mem_cgroup:ffff874fbf6b4000
[  489.408941] addr:(____ptrval____) vm_flags:00100073 anon_vma:(____ptrval____) mapping:(____ptrval____) index:ffffb5a54
[  489.408941] addr:(____ptrval____) vm_flags:00100073 anon_vma:(____ptrval____) mapping:(____ptrval____) index:ffffb5a54


Best Regards,

Lijun

