Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C853077B2
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 15:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhA1OJZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 28 Jan 2021 09:09:25 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2971 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhA1OJY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 09:09:24 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DRMjS01p7z5MN2;
        Thu, 28 Jan 2021 22:07:08 +0800 (CST)
Received: from dggema751-chm.china.huawei.com (10.1.198.193) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 28 Jan 2021 22:08:21 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema751-chm.china.huawei.com (10.1.198.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 28 Jan 2021 22:08:21 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.002;
 Thu, 28 Jan 2021 22:08:21 +0800
From:   liweihang <liweihang@huawei.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Question about the mechanism of RoCEv2 VLAN validation
Thread-Topic: Question about the mechanism of RoCEv2 VLAN validation
Thread-Index: AQHW9X8IxKfQwUKiHkePfWN8w4hMZA==
Date:   Thu, 28 Jan 2021 14:08:21 +0000
Message-ID: <ff917571dbae45fe9c9d840bac400404@huawei.com>
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

Hi All,

I'm confusing at the VLAN validation mechanism of RoCEv2.

Assuming that we have two nodes with an HCA that supports RoCE v2. And we add
a VLAN (id = 1) on each nodes, but they are of different network segments. The
IP and VLAN configuration are as follows:

              NODE_A                                     NODE_B
+--------+---------------+------+          +--------+---------------+------+
| device |     IP        | VLAN |          | device |     IP        | VLAN |
+--------+---------------+------+          +--------+---------------+------+
| eth0   | 192.168.97.1  |   0  |     /----| eth0   | 192.168.100.2 |   0  |
+--------+---------------+------+    /     +--------+---------------+------+
| eth0.1 | 192.168.100.3 |   1  |---/      | eth0.1 | 192.168.98.2  |   1  |
+--------+---------------+------+          +--------+---------------+------+

Now I try to ping eth0 on NODE_B from eth0.1 on NODE_A, of cource it fails
becauce these devices are using different VLAN ID.

Then I do some tests on RoCE, the first one is a simple RC send test:

NODE_A: ib_send_bw -d mlx5_0 -x 5 (the sgid 5 belongs to eth0.1)
NODE_B: ib_send_bw -d mlx5_0 -x 3 <server ip> (the sgid 3 belongs to eth0)

The result is as expected, the RoCEv2 packet with unmatched VLAN ID was
dropped. I think the reason is that for RC service, the VLAN information
of a QP is recorded in QPC, and the HCA can check it when receiving a packet.

But when I run a simple UD send test:

NODE_A: ib_send_bw -d mlx5_0 -x 5 -c UD (the sgid 5 belongs to eth0.1)
NODE_B: ib_send_bw -d mlx5_0 -x 3 -c UD  <server ip> (the sgid 3 belongs to eth0)

The test ends without error successfully. So the question is, RoCEv2 is based
on Ethernet, shouldn't a RoCEv2 node check the VLAN ID of every incoming
packets?

UD is connectionless-oriented, an UD QP won't record VLAN info in it's QPC,
so how to achieve the checking mechanism? Or a UD QP should just ignore the
unmatched VLAN ID?

I didn't find any info from the IB specification, I'd appreciate it if someone
could help explain it.

Thanks
Weihang
