Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19140EC0A8
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 10:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfKAJgo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 05:36:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5245 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbfKAJgo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Nov 2019 05:36:44 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EDF08D0BAC10A2DF05CB;
        Fri,  1 Nov 2019 17:36:42 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 1 Nov 2019
 17:36:37 +0800
From:   oulijun <oulijun@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: =?UTF-8?B?44CQQXNrIGZvciBoZWxw44CRIEEgcXVlc3Rpb24gZm9yIF9faWJfY2Fj?=
 =?UTF-8?B?aGVfZ2lkX2FkZCgp?=
Message-ID: <fd2a9385-f6c7-8471-b20c-476d4e9fada7@huawei.com>
Date:   Fri, 1 Nov 2019 17:36:36 +0800
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

Hi
  I am using the ubuntu system(5.0.0 kernel) to test the hip08 NIC port,. When I modify the perr mac1 to mac2,then restore to mac1, it will cause
the gid0 and gid 1 of the roce to be unavailable, and check that the /sys/class/infiniband/hns_0/ports/1/gid_attrs/ndevs/0 is show invalid.
the protocol stack print will appear.

  Oct 16 17:59:36 ubuntu kernel: [200635.496317] __ib_cache_gid_add: unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:9599 error=-28
Oct 16 17:59:37 ubuntu kernel: [200636.705848] 8021q: adding VLAN 0 to HW filter on device enp189s0f0
Oct 16 17:59:37 ubuntu kernel: [200636.705854] __ib_cache_gid_add: unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:9599 error=-28
Oct 16 17:59:39 ubuntu kernel: [200638.755828] hns3 0000:bd:00.0 enp189s0f0: link up
Oct 16 17:59:39 ubuntu kernel: [200638.755847] IPv6: ADDRCONF(NETDEV_CHANGE): enp189s0f0: link becomes ready
Oct 16 18:00:56 ubuntu kernel: [200715.699961] hns3 0000:bd:00.0 enp189s0f0: link down
Oct 16 18:00:56 ubuntu kernel: [200716.016142] __ib_cache_gid_add: unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:95f4 error=-28
Oct 16 18:00:58 ubuntu kernel: [200717.229857] 8021q: adding VLAN 0 to HW filter on device enp189s0f0
Oct 16 18:00:58 ubuntu kernel: [200717.229863] __ib_cache_gid_add: unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:95f4 error=-28

Has anyone else encounterd a similar problem ? I wonder if the _ib_cache_add_gid() is defective in 5.0 kernel?

Thanks
Lijun

