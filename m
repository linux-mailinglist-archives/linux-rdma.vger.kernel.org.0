Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490AF5B2F3
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2019 04:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfGACvm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 30 Jun 2019 22:51:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:2026 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfGACvm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Jun 2019 22:51:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jun 2019 19:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,437,1557212400"; 
   d="scan'208";a="314744371"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2019 19:51:40 -0700
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 30 Jun 2019 19:51:40 -0700
Received: from fmsmsx123.amr.corp.intel.com ([169.254.7.123]) by
 FMSMSX157.amr.corp.intel.com ([169.254.14.152]) with mapi id 14.03.0439.000;
 Sun, 30 Jun 2019 19:51:39 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     wangxi <wangxi11@huawei.com>, oulijun <oulijun@huawei.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [BUGReport for rdma in kernel5.2-rc4]
Thread-Topic: [BUGReport for rdma in kernel5.2-rc4]
Thread-Index: AQHVLcuxTkykfRtkqk2UuoXnRYz1BaaxWaVAgAEqU4CAAoRzQA==
Date:   Mon, 1 Jul 2019 02:51:39 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A683BAF6@fmsmsx123.amr.corp.intel.com>
References: <eaa1f156-c9df-f2f6-3c23-f2c1b23e484c@huawei.com>
 <9DD61F30A802C4429A01CA4200E302A7A6838463@fmsmsx123.amr.corp.intel.com>
 <d57c3f16-6a9a-d0a2-1984-1aba99259cc7@huawei.com>
In-Reply-To: <d57c3f16-6a9a-d0a2-1984-1aba99259cc7@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2IyMDA5NzYtZWQyYy00MjgxLWE1NWEtZjk3OTg0MWJkZjQ0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRmo3aXRsNEtaWHAwblhZak5qZEU2d2FWek43aTR2aTJ3b2JyWFZXUkFsQm8yc2ZmOUNVc2RNdFNNZVA1Yzh2TCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [BUGReport for rdma in kernel5.2-rc4]
> 
> 
> 
> 在 2019/6/29 2:01, Saleem, Shiraz 写道:
> >> Subject: [BUGReport for rdma in kernel5.2-rc4]
> >>
> >>
> >> Hi Shiraz & Jason,
> >>
> >> We have observed a crash when run perftest on a hisilicon arm64
> >> platform in kernel-5.2-rc4.
> >>
> >> We also tested with different kernel version and found it started
> >> from the the following commit:
> >>    d10bcf947a3e ("RDMA/umem: Combine contiguous PAGE_SIZE regions in
> >> SGEs")
> >>
> >> Could you please share any hint how to resolve this kind issue?
> >> Thanks!
> >>
> >
> > Hi Lijun - I am presuming you had this fix too?
> >
> > "RDMA/umem: Handle page combining avoidance correctly in
> ib_umem_add_sg_table()"
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/d
> > rivers/infiniband/core/umem.c?h=v5.2-rc4&id=7872168a839144dbbfb3312526
> > 2dab0673f9ddf5
> >
> > As Jason mentioned, provide the stack backtrace.
> >
> I have confirmed that the kernel version used in our test already contains this
> patch, but the phenomenon still exists on our platform. The previous log is
> recorded under the condition that the interval of the perftest test is long, and the
> system will hang. Calltrace will be available when the test interval is short.
> 
> the kernel version as following:
> commit dc75d8f9bf27647013bbfae1e2f1d114546994c4
> Author: Jason Gunthorpe <jgg@mellanox.com>
> Date:   Wed Jun 5 14:39:26 2019 -0300
> 
>     {fromtree} RDMA: Move owner into struct ib_device_ops
> 
>     This more closely follows how other subsytems work, with owner being a
>     member of the structure containing the function pointers.
> 
>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>     Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> the calltrace log as following:
> root@(none)$ uname -a
> Linux (none) 5.2.0-rc4-gdc75d8f9 #1 SMP PREEMPT Sat Jun 29 11:23:58 HKT
> 2019 aarch64 GNU/Linux root@(none)$ ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1
> & [1] 1143 root@(none)$ ib_read_bw -d hns_2 -n 5 192.168.10.110
> ---------------------------------------------------------------------------------------
> Device not recognized to implement inline feature. Disabling it cqe = 5, less than
> minimum CQE number.
> ---------------------------------------------------------------------------------------
>                     RDMA_Read BW Test
>  Dual-port       : OFF		Device         : hns_2
>  Number of qps   : 1		Transport type : IB
>  Connection type : RC		Using SRQ      : OFF
>  TX depth        : 5
>  CQ Moderation   : 5
>  Mtu             : 1024[B]
>  Link type       : Ethernet
>  GID index       : 2
>  Outstand reads  : 128
>  rdma_cm QPs	 : OFF
>  Data ex. method : Ethernet
> ---------------------------------------------------------------------------------------
>  local address: LID 0000 QPN 0x0009 PSN 0x6340e6 OUT 0x80 RKey 0x000300
> VAddr 0x00ffffa271f000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
>  remote address: LID 0000 QPN 0x0008 PSN 0xbd1845 OUT 0x80 RKey 0x000200
> VAddr 0x00ffff98244000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
> ---------------------------------------------------------------------------------------
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]
> MsgRate[Mpps]
>  65536      5                6469.94            6468.60		   0.103498
> ---------------------------------------------------------------------------------------
> [1]+  Done                    ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1
> root@(none)$ ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1 & [[1] 1145
>    87.412596] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   87.412596] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   87.426751] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> [   87.426751] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> root@(none)$ ib_read_bw -d hns_2 -n 5 192.168.10.110
> ---------------------------------------------------------------------------------------
> Device not recognized to implement inline feature. Disabling it cqe = 5, less than
> minimum CQE number.
> ---------------------------------------------------------------------------------------
>                     RDMA_Read BW Test
>  Dual-port       : OFF		Device         : hns_2
>  Number of qps   : 1		Transport type : IB
>  Connection type : RC		Using SRQ      : OFF
>  TX depth        : 5
>  CQ Moderation   : 5
>  Mtu             : 1024[B]
>  Link type       : Ethernet
>  GID index       : 2
>  Outstand reads  : 128
>  rdma_cm QPs	 : OFF
>  Data ex. method : Ethernet
> ---------------------------------------------------------------------------------------
>  local address: LID 0000 QPN 0x000b PSN 0xef5421 OUT 0x80 RKey 0x000300
> VAddr 0x00ffff9f7b8000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
>  remote address: LID 0000 QPN 0x000a PSN 0xd2b849 OUT 0x80 RKey 0x000200
> VAddr 0x00ffff822e7000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
> ---------------------------------------------------------------------------------------
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]
> MsgRate[Mpps]
>  65536      5                9044.77            9044.77		   0.144716
> ---------------------------------------------------------------------------------------
> [1]+  Done                    ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1
> root@(none)$ ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1 & [1] 1147 root@(none)$
> ib_read_bw -d hns_2 -n 5 192.168.10.110
> [   88.772598] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   88.772598] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   88.785887] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> [   88.785887] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> ---------------------------------------------------------------------------------------
> Device not recognized to implement inline feature. Disabling it cqe = 5, less than
> minimum CQE number.
> ---------------------------------------------------------------------------------------
>                     RDMA_Read BW Test
>  Dual-port       : OFF		Device         : hns_2
>  Number of qps   : 1		Transport type : IB
>  Connection type : RC		Using SRQ      : OFF
>  TX depth        : 5
>  CQ Moderation   : 5
>  Mtu             : 1024[B]
>  Link type       : Ethernet
>  GID index       : 2
>  Outstand reads  : 128
>  rdma_cm QPs	 : OFF
>  Data ex. method : Ethernet
> ---------------------------------------------------------------------------------------
>  local address: LID 0000 QPN 0x000d PSN 0x553436 OUT 0x80 RKey 0x000200
> VAddr 0x00ffffa302c000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
>  remote address: LID 0000 QPN 0x000c PSN 0xc22528 OUT 0x80 RKey 0x000300
> VAddr 0x00ffffa2a0c000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
> ---------------------------------------------------------------------------------------
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]
> MsgRate[Mpps]
>  65536      5                8966.88            8966.88		   0.143470
> ---------------------------------------------------------------------------------------
> [1]+  Done                    ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1
> root@(none)$ ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1 & [1] 1149 root@(none)$
> ib_read_bw -d hns_2 -n 5 192.168.10.110
> [   90.064588] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   90.064588] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   90.077875] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> [   90.077875] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> ---------------------------------------------------------------------------------------
> Device not recognized to implement inline feature. Disabling it cqe = 5, less than
> minimum CQE number.
> ---------------------------------------------------------------------------------------
>                     RDMA_Read BW Test
>  Dual-port       : OFF		Device         : hns_2
>  Number of qps   : 1		Transport type : IB
>  Connection type : RC		Using SRQ      : OFF
>  TX depth        : 5
>  CQ Moderation   : 5
>  Mtu             : 1024[B]
>  Link type       : Ethernet
>  GID index       : 2
>  Outstand reads  : 128
>  rdma_cm QPs	 : OFF
>  Data ex. method : Ethernet
> ---------------------------------------------------------------------------------------
>  local address: LID 0000 QPN 0x000f PSN 0xae6ff8 OUT 0x80 RKey 0x000300
> VAddr 0x00ffffb89e7000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
>  remote address: LID 0000 QPN 0x000e PSN 0x2e7a7d OUT 0x80 RKey 0x000200
> VAddr 0x00ffffbe2e5000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
> ---------------------------------------------------------------------------------------
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]
> MsgRate[Mpps]
>  65536      5                9057.91            9047.42		   0.144759
> ---------------------------------------------------------------------------------------
> [1]+  Done                    ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1
> root@(none)$ ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1 & [[1] 1151
>    91.192578] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   91.192578] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   91.206731] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> [   91.206731] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> root@(none)$ ib_read_bw -d hns_2 -n 5 192.168.10.110
> ---------------------------------------------------------------------------------------
> Device not recognized to implement inline feature. Disabling it cqe = 5, less than
> minimum CQE number.
> ---------------------------------------------------------------------------------------
>                     RDMA_Read BW Test
>  Dual-port       : OFF		Device         : hns_2
>  Number of qps   : 1		Transport type : IB
>  Connection type : RC		Using SRQ      : OFF
>  TX depth        : 5
>  CQ Moderation   : 5
>  Mtu             : 1024[B]
>  Link type       : Ethernet
>  GID index       : 2
>  Outstand reads  : 128
>  rdma_cm QPs	 : OFF
>  Data ex. method : Ethernet
> ---------------------------------------------------------------------------------------
>  local address: LID 0000 QPN 0x0011 PSN 0xb4d02e OUT 0x80 RKey 0x000300
> VAddr 0x00ffffb75c5000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
>  remote address: LID 0000 QPN 0x0010 PSN 0xbe677c OUT 0x80 RKey 0x000200
> VAddr 0x00ffffb82f6000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
> ---------------------------------------------------------------------------------------
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]
> MsgRate[Mpps]
>  65536      5                8815.15            8805.21		   0.140883
> ---------------------------------------------------------------------------------------
> [1]+  Done                    ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1
> root@(none)$ ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1 & [1] 1153 root@(none)$
> ib_read_bw -d hns_2 -n 5 192.168.10.110
> [   92.580588] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-2
> [   92.580588] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-2
> [   92.593874] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:2
> [   92.593874] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:2
> ---------------------------------------------------------------------------------------
> Device not recognized to implement inline feature. Disabling it cqe = 5, less than
> minimum CQE number.
> ---------------------------------------------------------------------------------------
>                     RDMA_Read BW Test
>  Dual-port       : OFF		Device         : hns_2
>  Number of qps   : 1		Transport type : IB
>  Connection type : RC		Using SRQ      : OFF
>  TX depth        : 5
>  CQ Moderation   : 5
>  Mtu             : 1024[B]
>  Link type       : Ethernet
>  GID index       : 2
>  Outstand reads  : 128
>  rdma_cm QPs	 : OFF
>  Data ex. method : Ethernet
> ---------------------------------------------------------------------------------------
>  local address: LID 0000 QPN 0x0013 PSN 0x94fd3e OUT 0x80 RKey 0x000300
> VAddr 0x00ffffb0ec9000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
>  remote address: LID 0000 QPN 0x0012 PSN 0x282156 OUT 0x80 RKey 0x000200
> VAddr 0x00ffff8f99d000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
> ---------------------------------------------------------------------------------------
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]
> MsgRate[Mpps]
>  65536      5                8890.35            8887.82		   0.142205
> ---------------------------------------------------------------------------------------
> [1]+  Done                    ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1
> root@(none)$ ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1 & [1] 1155 root@(none)$
> ib_read_bw -d hns_2 -n 5 192.168.10.110
> ---------------------------------------------------------------------------------------
> Device not recognized to implement inline feature. Disabling it cqe = 5, less than
> minimum CQE number.
> ---------------------------------------------------------------------------------------
>                     RDMA_Read BW Test
>  Dual-port       : OFF		Device         : hns_2
>  Number of qps   : 1		Transport type : IB
>  Connection type : RC		Using SRQ      : OFF
>  TX depth        : 5
>  CQ Moderation   : 5
>  Mtu             : 1024[B]
>  Link type       : Ethernet
>  GID index       : 2
>  Outstand reads  : 128
>  rdma_cm QPs	 : OFF
>  Data ex. method : Ethernet
> ---------------------------------------------------------------------------------------
>  local address: LID 0000 QPN 0x0015 PSN 0x4ef728 OUT 0x80 RKey 0x000300
> VAddr 0x00ffffb46a4000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
>  remote address: LID 0000 QPN 0x0014 PSN 0x6ba809 OUT 0x80 RKey 0x000200
> VAddr 0x00ffff88787000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
> ---------------------------------------------------------------------------------------
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]
> MsgRate[Mpps]
>  65536      5                9204.54            9204.54		   0.147273
> ---------------------------------------------------------------------------------------
> [1]+  Done                    ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1
> root@(none)$ ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1 & [1] 1157 root@(none)$
> ib_read_bw -d hns_2 -n 5 192.168.10.110
> [   95.192596] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   95.192596] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   95.205883] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> [   95.205883] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> ---------------------------------------------------------------------------------------
> Device not recognized to implement inline feature. Disabling it cqe = 5, less than
> minimum CQE number.
> ---------------------------------------------------------------------------------------
>                     RDMA_Read BW Test
>  Dual-port       : OFF		Device         : hns_2
>  Number of qps   : 1		Transport type : IB
>  Connection type : RC		Using SRQ      : OFF
>  TX depth        : 5
>  CQ Moderation   : 5
>  Mtu             : 1024[B]
>  Link type       : Ethernet
>  GID index       : 2
>  Outstand reads  : 128
>  rdma_cm QPs	 : OFF
>  Data ex. method : Ethernet
> ---------------------------------------------------------------------------------------
>  local address: LID 0000 QPN 0x0016 PSN 0xafe673 OUT 0x80 RKey 0x000200
> VAddr 0x00ffffb96fc000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
>  remote address: LID 0000 QPN 0x0017 PSN 0xdfb0e7 OUT 0x80 RKey 0x000300
> VAddr 0x00ffff927a6000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
> ---------------------------------------------------------------------------------------
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]
> MsgRate[Mpps]
>  65536      5                8765.63            8758.26		   0.140132
> ---------------------------------------------------------------------------------------
> [1]+  Done                    ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1
> root@(none)$ ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1 & [[1] 1159
>    96.192577] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   96.192577] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   96.206731] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> [   96.206731] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> root@(none)$ ib_read_bw -d hns_2 -n 5 192.168.10.110
> ---------------------------------------------------------------------------------------
> Device not recognized to implement inline feature. Disabling it cqe = 5, less than
> minimum CQE number.
> ---------------------------------------------------------------------------------------
>                     RDMA_Read BW Test
>  Dual-port       : OFF		Device         : hns_2
>  Number of qps   : 1		Transport type : IB
>  Connection type : RC		Using SRQ      : OFF
>  TX depth        : 5
>  CQ Moderation   : 5
>  Mtu             : 1024[B]
>  Link type       : Ethernet
>  GID index       : 2
>  Outstand reads  : 128
>  rdma_cm QPs	 : OFF
>  Data ex. method : Ethernet
> ---------------------------------------------------------------------------------------
>  local address: LID 0000 QPN 0x0019 PSN 0xa607e OUT 0x80 RKey 0x000300
> VAddr 0x00ffffb6020000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
>  remote address: LID 0000 QPN 0x0018 PSN 0xc3b7bc OUT 0x80 RKey 0x000200
> VAddr 0x00ffffbe95e000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
> ---------------------------------------------------------------------------------------
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]
> MsgRate[Mpps]
>  65536      5                8620.62            8611.12		   0.137778
> ---------------------------------------------------------------------------------------
> [1]+  Done                    ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1
> root@(none)$ ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1 & [1] 1161 root@(none)$
> ib_read_bw -d hns_2 -n 5 192.168.10.110
> [   97.540585] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   97.540585] BUG: Bad rss-counter state mm:(____ptrval____) idx:0 val:-1
> [   97.553871] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> [   97.553871] BUG: Bad rss-counter state mm:(____ptrval____) idx:1 val:1
> ---------------------------------------------------------------------------------------
> Device not recognized to implement inline feature. Disabling it cqe = 5, less than
> minimum CQE number.
> ---------------------------------------------------------------------------------------
>                     RDMA_Read BW Test
>  Dual-port       : OFF		Device         : hns_2
>  Number of qps   : 1		Transport type : IB
>  Connection type : RC		Using SRQ      : OFF
>  TX depth        : 5
>  CQ Moderation   : 5
>  Mtu             : 1024[B]
>  Link type       : Ethernet
>  GID index       : 2
>  Outstand reads  : 128
>  rdma_cm QPs	 : OFF
>  Data ex. method : Ethernet
> ---------------------------------------------------------------------------------------
>  local address: LID 0000 QPN 0x001b PSN 0x3ea763 OUT 0x80 RKey 0x000300
> VAddr 0x00ffffb8bde000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
>  remote address: LID 0000 QPN 0x001a PSN 0x818b6a OUT 0x80 RKey 0x000200
> VAddr 0x00ffffb8df2000
>  GID: 00:00:00:00:00:00:00:00:00:00:255:255:192:168:10:110
> ---------------------------------------------------------------------------------------
>  #bytes     #iterations    BW peak[MB/sec]    BW average[MB/sec]
> MsgRate[Mpps]
>  65536      5                9070.99            9068.36		   0.145094
> ---------------------------------------------------------------------------------------
> [1]+  Done             [       ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1
>    97.812496] BUG: Bad page state in process swapper/99  pfn:203f958e4
> [   97.812496] BUG: Bad page state in process swapper/99  pfn:203f958e4
> [   97.812498] BUG: Bad page state in process swapper/100  pfn:203f9597a
> [   97.812498] BUG: Bad page state in process swapper/100  pfn:203f9597a
> [   97.812502] page:ffff7e80fe565e80 refcount:-1 mapcount:0
> mapping:0000000000000000 index:0x1
> [   97.812502] page:ffff7e80fe565e80 refcount:-1 mapcount:0
> mapping:0000000000000000 index:0x1
> [   97.831388] page:ffff7e80fe563900 reroot@(none)$ fcount:-1 mapcount:0
> mapping:0000000000000000 index:0x1
> [   97.831388] page:ffff7e80fe563900 refcount:-1 mapcount:0
> mapping:0000000000000000 index:0x1
> [   97.844317] flags: 0xdfffe0000000000a(referenced|dirty)
> [   97.844317] flags: 0xdfffe0000000000a(referenced|dirty)
> [   97.861087] flags: 0xdfffe00000000000()
> [   97.861087] flags: 0xdfffe00000000000()
> [   97.861091] raw: dfffe00000000000 dead000000000100 dead000000000200
> 0000000000000000
> [   97.861091] raw: dfffe00000000000 dead000000000100 dead000000000200
> 0000000000000000
> [   97.879857] raw: dfffe0000000000a dead000000000100 dead000000000200
> 0000000000000000
> [   97.879857] raw: dfffe0000000000a dead000000000100 dead000000000200
> 0000000000000000
> [   97.890339] raw: 0000000000000001 0000000000000000 ffffffffffffffff
> 0000000000000000
> [   97.890339] raw: 0000000000000001 0000000000000000 ffffffffffffffff
> 0000000000000000
> [   97.898027] raw: 0000000000000001 0000000000000000 ffffffffffffffff
> 0000000000000000
> [   97.898027] raw: 0000000000000001 0000000000000000 ffffffffffffffff
> 0000000000000000
> [   97.913576] page dumped because: nonzero _refcount
> [   97.913576] page dumped because: nonzero _refcount
> [   97.929124] page dumped because: nonzero _refcount
> [   97.929124] page dumped because: nonzero _refcount
> [   97.929125] Modules linked in: hns_roce_hw_v2 hns_roce hclge hns3 hnae3
> [   97.929125] Modules linked in: hns_roce_hw_v2 hns_roce hclge hns3 hnae3
> [   97.944673] Modules linked in: hns_roce_hw_v2 hns_roce hclge hns3 hnae3
> [   97.944673] Modules linked in: hns_roce_hw_v2 hns_roce hclge hns3 hnae3
> [   97.960225] CPU: 100 PID: 0 Comm: swapper/100 Not tainted 5.2.0-rc4-
> gdc75d8f9 #1
> [   97.960225] CPU: 100 PID: 0 Comm: swapper/100 Not tainted 5.2.0-rc4-
> gdc75d8f9 #1
> [   98.020847] Hardware name: Huawei TaiShan 2280 V2/BC82AMDA, BIOS TA
> BIOS 2280-A CS V2.26.01 06/13/2019
> [   98.020847] Hardware name: Huawei TaiShan 2280 V2/BC82AMDA, BIOS TA
> BIOS 2280-A CS V2.26.01 06/13/2019
> [   98.039542] Call trace:
> [   98.039542] Call trace:
> [   98.044440]  dump_backtrace+0x0/0x140
> [   98.044440]  dump_backtrace+0x0/0x140
> [   98.051779]  show_stack+0x14/0x20
> [   98.051779]  show_stack+0x14/0x20
> [   98.058422]  dump_stack+0xa8/0xcc
> [   98.058422]  dump_stack+0xa8/0xcc
> [   98.065065]  bad_page+0xe8/0x150
> [   98.065065]  bad_page+0xe8/0x150
> [   98.071532]  free_pages_check_bad+0x70/0xa8
> [   98.071532]  free_pages_check_bad+0x70/0xa8
> [   98.079920]  free_pcppages_bulk+0x430/0x6d8
> [   98.079920]  free_pcppages_bulk+0x430/0x6d8
> [   98.088308]  free_unref_page_commit+0xc0/0xf8
> [   98.088308]  free_unref_page_commit+0xc0/0xf8
> [   98.097045]  free_unref_page+0x78/0x98
> [   98.097045]  free_unref_page+0x78/0x98
> [   98.104561]  __put_page+0x44/0x50
> [   98.104561]  __put_page+0x44/0x50
> [   98.111202]  free_page_and_swap_cache+0xac/0x100
> [   98.111202]  free_page_and_swap_cache+0xac/0x100
> [   98.120463]  tlb_remove_table_rcu+0x30/0x58
> [   98.120463]  tlb_remove_table_rcu+0x30/0x58
> [   98.128852]  rcu_core+0x2d8/0x5d8
> [   98.128852]  rcu_core+0x2d8/0x5d8
> [   98.135493]  __do_softirq+0x11c/0x3a0
> [   98.135493]  __do_softirq+0x11c/0x3a0
> [   98.142834]  irq_exit+0xd0/0xd8
> [   98.142834]  irq_exit+0xd0/0xd8
> [   98.149127]  __handle_domain_irq+0x60/0xb0
> [   98.149127]  __handle_domain_irq+0x60/0xb0
> [   98.157339]  gic_handle_irq+0x5c/0x154
> [   98.157339]  gic_handle_irq+0x5c/0x154
> [   98.164853]  el1_irq+0xb8/0x180
> [   98.164853]  el1_irq+0xb8/0x180
> [   98.171144]  arch_cpu_idle+0x30/0x230
> [   98.171144]  arch_cpu_idle+0x30/0x230
> [   98.178484]  default_idle_call+0x1c/0x38
> [   98.178484]  default_idle_call+0x1c/0x38
> [   98.186349]  do_idle+0x1f0/0x2d0
> [   98.186349]  do_idle+0x1f0/0x2d0
> [   98.192815]  cpu_startup_entry+0x24/0x28
> [   98.192815]  cpu_startup_entry+0x24/0x28
> [   98.200679]  secondary_start_kernel+0x18c/0x1d0
> [   98.200679]  secondary_start_kernel+0x18c/0x1d0
> [   98.209765] Disabling lock debugging due to kernel taint
> [   98.209765] Disabling lock debugging due to kernel taint
> [   98.209767] CPU: 99 PID: 0 Comm: swapper/99 Not tainted 5.2.0-rc4-gdc75d8f9
> #1
> [   98.209767] CPU: 99 PID: 0 Comm: swapper/99 Not tainted 5.2.0-rc4-gdc75d8f9
> #1
> [   98.209768] Hardware name: Huawei TaiShan 2280 V2/BC82AMDA, BIOS TA
> BIOS 2280-A CS V2.26.01 06/13/2019
> [   98.209768] Hardware name: Huawei TaiShan 2280 V2/BC82AMDA, BIOS TA
> BIOS 2280-A CS V2.26.01 06/13/2019
> [   98.220425] BUG: Bad page state in process swapper/100  pfn:203f95977
> [   98.220425] BUG: Bad page state in process swapper/100  pfn:203f95977
> [   98.234925] Call trace:
> [   98.234925] Call trace:
> [   98.253619] page:ffff7e80fe565dc0 refcount:-1 mapcount:0
> mapping:0000000000000000 index:0x1
> [   98.253619] page:ffff7e80fe565dc0 refcount:-1 mapcount:0
> mapping:0000000000000000 index:0x1
> [   98.266550]  dump_backtrace+0x0/0x140
> [   98.266550]  dump_backtrace+0x0/0x140
> [   98.271441] flags: 0xdfffe00000000000()
> [   98.271441] flags: 0xdfffe00000000000()
> [   98.271442] raw: dfffe00000000000 dead000000000100 dead000000000200
> 0000000000000000
> [   98.271442] raw: dfffe00000000000 dead000000000100 dead000000000200
> 0000000000000000
> [   98.288214]  show_stack+0x14/0x20
> [   98.288214]  show_stack+0x14/0x20
> [   98.295552] raw: 0000000000000001 0000000000000000 ffffffffffffffff
> 0000000000000000
> [   98.295552] raw: 0000000000000001 0000000000000000 ffffffffffffffff
> 0000000000000000
> [   98.303241]  dump_stack+0xa8/0xcc
> [   98.303241]  dump_stack+0xa8/0xcc
> [   98.318788] page dumped because: nonzero _refcount
> [   98.318788] page dumped because: nonzero _refcount
> [   98.325429]  bad_page+0xe8/0x150
> [   98.325429]  bad_page+0xe8/0x150
> [   98.325431]  free_pages_check_bad+0x70/0xa8
> [   98.325431]  free_pages_check_bad+0x70/0xa8
> [   98.340978] Modules linked in: hns_roce_hw_v2 hns_roce hclge hns3 hnae3
> [   98.340978] Modules linked in: hns_roce_hw_v2 hns_roce hclge hns3 hnae3
> [   98.347620]  free_pcppages_bulk+0x430/0x6d8
> [   98.347620]  free_pcppages_bulk+0x430/0x6d8
> [   98.393743]  free_unref_page_commit+0xc0/0xf8
> [   98.393743]  free_unref_page_commit+0xc0/0xf8
> [   98.402480]  free_unref_page+0x78/0x98
> [   98.402480]  free_unref_page+0x78/0x98
> [   98.409994]  __free_pages+0x44/0x50
> [   98.409994]  __free_pages+0x44/0x50
> [   98.416985]  free_pages.part.5+0x1c/0x28
> [   98.416985]  free_pages.part.5+0x1c/0x28
> [   98.424848]  free_pages+0x14/0x20
> [   98.424848]  free_pages+0x14/0x20
> [   98.431488]  tlb_remove_table_rcu+0x4c/0x58
> [   98.431488]  tlb_remove_table_rcu+0x4c/0x58
> [   98.439876]  rcu_core+0x2d8/0x5d8
> [   98.439876]  rcu_core+0x2d8/0x5d8
> [   98.446517]  __do_softirq+0x11c/0x3a0
> [   98.446517]  __do_softirq+0x11c/0x3a0
> [   98.453858]  irq_exit+0xd0/0xd8
> [   98.453858]  irq_exit+0xd0/0xd8
> [   98.460150]  __handle_domain_irq+0x60/0xb0
> [   98.460150]  __handle_domain_irq+0x60/0xb0
> [   98.468363]  gic_handle_irq+0x5c/0x154
> [   98.468363]  gic_handle_irq+0x5c/0x154
> [   98.475876]  el1_irq+0xb8/0x180
> [   98.475876]  el1_irq+0xb8/0x180
> [   98.482168]  arch_cpu_idle+0x30/0x230
> [   98.482168]  arch_cpu_idle+0x30/0x230
> [   98.489507]  default_idle_call+0x1c/0x38
> [   98.489507]  default_idle_call+0x1c/0x38
> [   98.497371]  do_idle+0x1f0/0x2d0
> [   98.497371]  do_idle+0x1f0/0x2d0
> [   98.503837]  cpu_startup_entry+0x24/0x28
> [   98.503837]  cpu_startup_entry+0x24/0x28
> [   98.511701]  secondary_start_kernel+0x18c/0x1d0
> [   98.511701]  secondary_start_kernel+0x18c/0x1d0
> [   98.520788] CPU: 100 PID: 0 Comm: swapper/100 Tainted: G    B             5.2.0-
> rc4-gdc75d8f9 #1
> [   98.520788] CPU: 100 PID: 0 Comm: swapper/100 Tainted: G    B             5.2.0-
> rc4-gdc75d8f9 #1
> [   98.520789] BUG: Bad page state in process swapper/99  pfn:203f96a5a
> [   98.520789] BUG: Bad page state in process swapper/99  pfn:203f96a5a
> [   98.520791] page:ffff7e80fe5a9680 refcount:-1 mapcount:0
> mapping:0000000000000000 index:0x1
> [   98.520791] page:ffff7e80fe5a9680 refcount:-1 mapcount:0
> mapping:0000000000000000 index:0x1
> [   98.538435] Hardware name: Huawei TaiShan 2280 V2/BC82AMDA, BIOS TA
> BIOS 2280-A CS V2.26.01 06/13/2019
> [   98.538435] Hardware name: Huawei TaiShan 2280 V2/BC82AMDA, BIOS TA
> BIOS 2280-A CS V2.26.01 06/13/2019
> [   98.538436] Call trace:
> [   98.538436] Call trace:
> [   98.551189] flags: 0xdfffe0000000000a(referenced|dirty)
> [   98.551189] flags: 0xdfffe0000000000a(referenced|dirty)
> [   98.551191] raw: dfffe0000000000a dead000000000100 dead000000000200
> 0000000000000000
> [   98.551191] raw: dfffe0000000000a dead000000000100 dead000000000200
> 0000000000000000
> [   98.567962]  dump_backtrace+0x0/0x140
> [   98.567962]  dump_backtrace+0x0/0x140
> [   98.567963]  show_stack+0x14/0x20
> [   98.567963]  show_stack+0x14/0x20
> [   98.586656] raw: 0000000000000001 0000000000000000 ffffffffffffffff
> 0000000000000000
> [   98.586656] raw: 0000000000000001 0000000000000000 ffffffffffffffff
> 0000000000000000
> [   98.591549]  dump_stack+0xa8/0xcc
> [   98.591549]  dump_stack+0xa8/0xcc
> [   98.602031] page dumped because: nonzero _refcount
> [   98.602031] page dumped because: nonzero _refcount
> [   98.617581]  bad_page+0xe8/0x150
> [   98.617581]  bad_page+0xe8/0x150
> [   98.624918] Modules linked in: hns_roce_hw_v2 hns_roce hclge hns3 hnae3
> [   98.624918] Modules linked in: hns_roce_hw_v2 hns_roce hclge hns3 hnae3
> [   98.631559]  free_pages_check_bad+0x70/0xa8
> [   98.631559]  free_pages_check_bad+0x70/0xa8
> [   98.631560]  free_pcppages_bulk+0x430/0x6d8
> [   98.631560]  free_pcppages_bulk+0x430/0x6d8
> [   98.699872]  free_unref_page_commit+0xc0/0xf8
> [   98.699872]  free_unref_page_commit+0xc0/0xf8
> [   98.708610]  free_unref_page+0x78/0x98
> [   98.708610]  free_unref_page+0x78/0x98
> [   98.716123]  __put_page+0x44/0x50
> [   98.716123]  __put_page+0x44/0x50
> [   98.722764]  free_page_and_swap_cache+0xac/0x100
> [   98.722764]  free_page_and_swap_cache+0xac/0x100
> [   98.732025]  tlb_remove_table_rcu+0x30/0x58
> [   98.732025]  tlb_remove_table_rcu+0x30/0x58
> [ib_read_bw -d hns_2 -n 5 > /dev/null 2>&1 &
>    98.740412]  rcu_core+0x2d8/0x5d8
> [   98.740412]  rcu_core+0x2d8/0x5d8
> [   98.750959]  __do_softirq+0x11c/0x3a0
> [   98.750959]  __do_softirq+0x11c/0x3a0
> [   98.758298]  irq_exit+0xd0/0xd8
> [   98.758298]  irq_exit+0xd0/0xd8
> [   98.764589]  __handle_domain_irq+0x60/0xb0
> [   98.764589]  __handle_domain_irq+0x60/0xb0
> [   98.772802]  gic_handle_irq+0x5c/0x154
> [   98.772802]  gic_handle_irq+0x5c/0x154
> [   98.780316]  el1_irq+0xb8/0x180
> [   98.780316]  el1_irq+0xb8/0x180
> [   98.786608]  arch_cp[1] 1163
> u_idle+0x30/0x230
> [   98.786608]  arch_cpu_idle+0x30/0x230
> [   98.794815]  default_idle_call+0x1c/0x38
> [   98.794815]  default_idle_call+0x1c/0x38
> [   98.802678]  do_idle+0x1f0/0x2d0
> [   98.802678]  do_idle+0x1f0/0x2d0
> [   98.809144]  cpu_startup_entry+0x24/0x28
> [   98.809144]  cpu_startup_entry+0x24/0x28
> [   98.817008]  secondary_start_kernel+0x18c/0x1d0
> [   98.817008]  secondary_start_kernel+0x18c/0x1d0
> [   98.826095] CPU: 99 PID: 0 Comm: swapper/99 Tainted: G    B             5.2.0-rc4-
> gdc75d8f9 #1
> [   98.826095] CPU: 99 PID: 0 Comm: swapper/99 Tainted: G    B             5.2.0-rc4-
> gdc75d8f9 #1
> [root@(none)$    98.843392] Hardware name: Huawei TaiShan 2280 V2/BC82AMDA,
> BIOS TA BIOS 2280-A CS V2.26.01 06/13/2019
> [   98.843392] Hardware name: Huawei TaiShan 2280 V2/BC82AMDA, BIOS TA
> BIOS 2280-A CS V2.26.01 06/13/2019
> [   98.864082] Call trace:
> [   98.864082] Call trace:
> [   98.868976]  dump_backtrace+0x0/0x140
> [   98.868976]  dump_backtrace+0x0/0x140
> [   98.876315]  show_stack+0x14/0x20
> [   98.876315]  show_stack+0x14/0x20
> [   98.882955]  dump_stack+0xa8/0xcc
> [   98.882955]  dump_stack+0xa8/0xcc
> [   98.889596]  bad_page+0xe8/0x150
> [   98.889596]  bad_page+0xe8/0x150
> [   98.896062]  free_pages_check_bad+0x70/0xa8
> [   98.896062]  free_pages_check_bad+0x70/0xa8
> [   98.904450]  free_pcppages_bulk+0x430/0x6d8
> [   98.904450]  free_pcppages_bulk+0x430/0x6d8
> [   98.912838]  free_unref_page_commit+0xc0/0xf8
> [   98.912838]  free_unref_page_commit+0xc0/0xf8
> [   98.921575]  free_unref_page+0x78/0x98
> [   98.921575]  free_unref_page+0x78/0x98
> [   98.929089]  __free_pages+0x44/0x50
> [   98.929089]  __free_pages+0x44/0x50
> [   98.936079]  free_pages.part.5+0x1c/0x28
> [   98.936079]  free_pages.part.5+0x1c/0x28
> [   98.943943]  free_pages+0x14/0x20
> [   98.943943]  free_pages+0x14/0x20
> [   98.950583]  tlb_remove_table_rcu+0x4c/0x58
> [   98.950583]  tlb_remove_table_rcu+0x4c/0x58
> [   98.958970]  rcu_core+0x2d8/0x5d8
> [   98.958970]  rcu_core+0x2d8/0x5d8
> [   98.965611]  __do_softirq+0x11c/0x3a0
> [   98.965611]  __do_softirq+0x11c/0x3a0
> [   98.972951]  irq_exit+0xd0/0xd8
> [   98.972951]  irq_exit+0xd0/0xd8
> [   98.979242]  __handle_domain_irq+0x60/0xb0
> [   98.979242]  __handle_domain_irq+0x60/0xb0
> [   98.987455]  gic_handle_irq+0x5c/0x154
> [   98.987455]  gic_handle_irq+0x5c/0x154
> [   98.994968]  el1_irq+0xb8/0x180
> [   98.994968]  el1_irq+0xb8/0x180
> [   99.001260]  arch_cpu_idle+0x30/0x230
> [   99.001260]  arch_cpu_idle+0x30/0x230
> [   99.008599]  default_idle_call+0x1c/0x38
> [   99.008599]  default_idle_call+0x1c/0x38
> [   99.016462]  do_idle+0x1f0/0x2d0
> [   99.016462]  do_idle+0x1f0/0x2d0
> [   99.022927]  cpu_startup_entry+0x24/0x28
> [   99.022927]  cpu_startup_entry+0x24/0x28
> [   99.030791]  secondary_start_kernel+0x18c/0x1d0
> [   99.030791]  secondary_start_kernel+0x18c/0x1d0
> [   99.039878] BUG: Bad page state in process swapper/99  pfn:203f958ec
> [   99.039878] BUG: Bad page state in process swapper/99  pfn:203f958ec

Perhaps we got bad page descriptor when unfolding SGEs in __ib_umem_release()
and doing a put page? But I don’t see dereg MR patch in the trace so that’s
throwing me off a little.

Anyways, since we suspect the page combining algo as a potential culprit,
instrumenting some debug like this could tell us how the page merging and unfolding
took place.

echo -n 'func ib_umem_get +p' >/sys/kernel/debug/dynamic_debug/control
echo -n 'func __ib_umem_release +p' >/sys/kernel/debug/dynamic_debug/control
echo -n 'func ib_umem_add_sg_table +p' >/sys/kernel/debug/dynamic_debug/control

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 08da840..8d4aba1 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -47,6 +47,10 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
 {
 	struct sg_page_iter sg_iter;
 	struct page *page;
+	int i = 0;
+
+	pr_debug("ib_umem_release: START------------------------\n");
+	pr_debug("umem [%px] sg_nents [%u] \n", umem, umem->sg_nents);
 
 	if (umem->nmap > 0)
 		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
@@ -54,12 +58,15 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
 
 	for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->sg_nents, 0) {
 		page = sg_page_iter_page(&sg_iter);
+		pr_debug("sg [0x%px] len [%u] page [0x%px] pfn [0x%lx] refcnt [%d] i [%d]\n",
+			 (&sg_iter)->sg, (&sg_iter)->sg->length, page, page_to_pfn(page),
+			 page_ref_count(page), i);
 		if (umem->writable && dirty)
 			put_user_pages_dirty_lock(&page, 1);
 		else
 			put_user_page(page);
 	}
-
+	pr_debug("ib_umem_release: END------------------------\n");
 	sg_free_table(&umem->sg_head);
 }
 
@@ -103,8 +110,11 @@ static struct scatterlist *ib_umem_add_sg_table(struct scatterlist *sg,
 		for (len = 0; i != npages &&
 			      first_pfn + len == page_to_pfn(page_list[i]) &&
 			      len < (max_seg_sz >> PAGE_SHIFT);
-		     len++)
+		     len++) {
+			pr_debug("page_ptr [0x%px] pfn [0x%lx] i [%lu] len [%lu]\n",
+				 page_list[i], page_to_pfn(page_list[i]), i, len);
 			i++;
+		}
 
 		/* Squash N contiguous pages from page_list into current sge */
 		if (update_cur_sg) {
@@ -112,6 +122,8 @@ static struct scatterlist *ib_umem_add_sg_table(struct scatterlist *sg,
 				sg_set_page(sg, sg_page(sg),
 					    sg->length + (len << PAGE_SHIFT),
 					    0);
+				pr_debug("update_sg: [0x%px] len [%u] page [0x%px] pfn [0x%lx]\n",
+					sg, sg->length, sg_page(sg), page_to_pfn(sg_page(sg)));
 				update_cur_sg = false;
 				continue;
 			}
@@ -125,6 +137,8 @@ static struct scatterlist *ib_umem_add_sg_table(struct scatterlist *sg,
 		(*nents)++;
 		sg_set_page(sg, first_page, len << PAGE_SHIFT, 0);
 		first = false;
+		pr_debug("sg: [0x%px] len [%u] page[0x%px] pfn [0x%lx]\n",
+			 sg, sg->length, first_page, page_to_pfn(first_page));
 	}
 
 	return sg;
@@ -293,6 +307,10 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 
 	sg = umem->sg_head.sgl;
 
+	pr_debug("ib_umem_get: START------------------------\n");
+	pr_debug("umem [%px] max_seg_size [%u] npages [%lu] pgshift [%u] \n",
+		umem, dma_get_max_seg_size(context->device->dma_device),
+		npages, PAGE_SHIFT);
 	while (npages) {
 		down_read(&mm->mmap_sem);
 		ret = get_user_pages(cur_base,
@@ -323,6 +341,9 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 				  DMA_BIDIRECTIONAL,
 				  dma_attrs);
 
+	pr_debug("umem [%px] sg_nents [%u] nmap [%u] \n", umem, umem->sg_nents, umem->nmap);
+	pr_debug("ib_umem_get: END------------------------\n");
+
 	if (!umem->nmap) {
 		ret = -ENOMEM;
 		goto umem_release;
-- 
1.8.3.1


