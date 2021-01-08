Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4312E2EFA39
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jan 2021 22:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbhAHVTW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jan 2021 16:19:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59342 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbhAHVTW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jan 2021 16:19:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108L995c159078;
        Fri, 8 Jan 2021 21:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : subject : message-id : date :
 cc : to; s=corp-2020-01-29;
 bh=qcVc7j69pMjMHtrDHWO2DiugcvzhhI16TiVzxrc2NMY=;
 b=u9Kl02imFObGZB/nsLaqhfpssUOZ6vIzYtrnGBrUnMslG2tIUKa9meebZF6BySdLrwMT
 vhuPbAh35yPAmbOnaFLyKFnkiO3CeXdOsJVfB4OYwJI3ybwiXi5OUz89iNoPAoe5itnl
 zs3GdsbbeB+TfE7Y5ScIgQ2SrliiPoJz0wzB3zhe6WGn+zCMGUpZqs/5809nwkD0Aqwq
 A/RU/3IhLkofbjjovPmJyNqXCJPLGsMY/UiEHXUtjZdv2XhgttPcYCqIPjdSX6GzbeO7
 8R1J9mexqjzm7o2Ep+HFA7S660VnsZ9+/CYw/AXFk0QJwQiN3ewOCR3P8FQZ70XaYfUs Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35wcuy3bgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 Jan 2021 21:18:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108LAdou191950;
        Fri, 8 Jan 2021 21:18:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35v4rfqx4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 21:18:37 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 108LIbpp024172;
        Fri, 8 Jan 2021 21:18:37 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jan 2021 13:18:36 -0800
From:   Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: performance regression noted in v5.11-rc after c062db039f40
Message-Id: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
Date:   Fri, 8 Jan 2021 16:18:36 -0500
Cc:     iommu@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>
To:     Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=742 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1011 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=753 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi-

[ Please cc: me on replies, I'm not currently subscribed to
iommu@lists ].

I'm running NFS performance tests on InfiniBand using CX-3 Pro cards
at 56Gb/s. The test is iozone on an NFSv3/RDMA mount:

/home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I

For those not familiar with the way storage protocols use RDMA, The
initiator/client sets up memory regions and the target/server uses
RDMA Read and Write to move data out of and into those regions. The
initiator/client uses only RDMA memory registration and invalidation
operations, and the target/server uses RDMA Read and Write.

My NFS client is a two-socket 12-core x86_64 system with its I/O MMU
enabled using the kernel command line options "intel_iommu=3Don
iommu=3Dstrict".

Recently I've noticed a significant (25-30%) loss in NFS throughput.
I was able to bisect on my client to the following commits.

Here's 65f746e8285f ("iommu: Add quirk for Intel graphic devices in
map_sg"). This is about normal for this test.

	Children see throughput for 12 initial writers 	=3D 4732581.09 =
kB/sec
 	Parent sees throughput for 12 initial writers 	=3D 4646810.21 =
kB/sec
 	Min throughput per process 			=3D  387764.34 =
kB/sec
 	Max throughput per process 			=3D  399655.47 =
kB/sec
 	Avg throughput per process 			=3D  394381.76 =
kB/sec
 	Min xfer 					=3D 1017344.00 =
kB
 	CPU Utilization: Wall time    2.671    CPU time    1.974    CPU =
utilization  73.89 %
 	Children see throughput for 12 rewriters 	=3D 4837741.94 =
kB/sec
 	Parent sees throughput for 12 rewriters 	=3D 4833509.35 =
kB/sec
 	Min throughput per process 			=3D  398983.72 =
kB/sec
 	Max throughput per process 			=3D  406199.66 =
kB/sec
 	Avg throughput per process 			=3D  403145.16 =
kB/sec
 	Min xfer 					=3D 1030656.00 =
kB
 	CPU utilization: Wall time    2.584    CPU time    1.959    CPU =
utilization  75.82 %
 	Children see throughput for 12 readers 		=3D 5921370.94 =
kB/sec
 	Parent sees throughput for 12 readers 		=3D 5914106.69 =
kB/sec
 	Min throughput per process 			=3D  491812.38 =
kB/sec
 	Max throughput per process 			=3D  494777.28 =
kB/sec
 	Avg throughput per process 			=3D  493447.58 =
kB/sec
 	Min xfer 					=3D 1042688.00 =
kB
 	CPU utilization: Wall time    2.122    CPU time    1.968    CPU =
utilization  92.75 %
 	Children see throughput for 12 re-readers 	=3D 5947985.69 =
kB/sec
 	Parent sees throughput for 12 re-readers 	=3D 5941348.51 =
kB/sec
 	Min throughput per process 			=3D  492805.81 =
kB/sec
 	Max throughput per process 			=3D  497280.19 =
kB/sec
 	Avg throughput per process 			=3D  495665.47 =
kB/sec
 	Min xfer 					=3D 1039360.00 =
kB
 	CPU utilization: Wall time    2.111    CPU time    1.968    CPU =
utilization  93.22 %

Here's c062db039f40 ("iommu/vt-d: Update domain geometry in
iommu_ops.at(de)tach_dev"). It's losing some steam here.

	Children see throughput for 12 initial writers 	=3D 4342419.12 =
kB/sec
 	Parent sees throughput for 12 initial writers 	=3D 4310612.79 =
kB/sec
 	Min throughput per process 			=3D  359299.06 =
kB/sec
 	Max throughput per process 			=3D  363866.16 =
kB/sec
 	Avg throughput per process 			=3D  361868.26 =
kB/sec
 	Min xfer 					=3D 1035520.00 =
kB
 	CPU Utilization: Wall time    2.902    CPU time    1.951    CPU =
utilization  67.22 %
 	Children see throughput for 12 rewriters 	=3D 4408576.66 =
kB/sec
 	Parent sees throughput for 12 rewriters 	=3D 4404280.87 =
kB/sec
 	Min throughput per process 			=3D  364553.88 =
kB/sec
 	Max throughput per process 			=3D  370029.28 =
kB/sec
 	Avg throughput per process 			=3D  367381.39 =
kB/sec
 	Min xfer 					=3D 1033216.00 =
kB
 	CPU utilization: Wall time    2.836    CPU time    1.956    CPU =
utilization  68.97 %
 	Children see throughput for 12 readers 		=3D 5406879.47 =
kB/sec
 	Parent sees throughput for 12 readers 		=3D 5401862.78 =
kB/sec
 	Min throughput per process 			=3D  449583.03 =
kB/sec
 	Max throughput per process 			=3D  451761.69 =
kB/sec
 	Avg throughput per process 			=3D  450573.29 =
kB/sec
 	Min xfer 					=3D 1044224.00 =
kB
 	CPU utilization: Wall time    2.323    CPU time    1.977    CPU =
utilization  85.12 %
 	Children see throughput for 12 re-readers 	=3D 5410601.12 =
kB/sec
 	Parent sees throughput for 12 re-readers 	=3D 5403504.40 =
kB/sec
 	Min throughput per process 			=3D  449918.12 =
kB/sec
 	Max throughput per process 			=3D  452489.28 =
kB/sec
 	Avg throughput per process 			=3D  450883.43 =
kB/sec
 	Min xfer 					=3D 1043456.00 =
kB
 	CPU utilization: Wall time    2.321    CPU time    1.978    CPU =
utilization  85.21 %

And here's c588072bba6b ("iommu/vt-d: Convert intel iommu driver to
the iommu ops"). Significant throughput loss.

	Children see throughput for 12 initial writers 	=3D 3812036.91 =
kB/sec
 	Parent sees throughput for 12 initial writers 	=3D 3753683.40 =
kB/sec
 	Min throughput per process 			=3D  313672.25 =
kB/sec
 	Max throughput per process 			=3D  321719.44 =
kB/sec
 	Avg throughput per process 			=3D  317669.74 =
kB/sec
 	Min xfer 					=3D 1022464.00 =
kB
 	CPU Utilization: Wall time    3.309    CPU time    1.986    CPU =
utilization  60.02 %
 	Children see throughput for 12 rewriters 	=3D 3786831.94 =
kB/sec
 	Parent sees throughput for 12 rewriters 	=3D 3783205.58 =
kB/sec
 	Min throughput per process 			=3D  313654.44 =
kB/sec
 	Max throughput per process 			=3D  317844.50 =
kB/sec
 	Avg throughput per process 			=3D  315569.33 =
kB/sec
 	Min xfer 					=3D 1035520.00 =
kB
 	CPU utilization: Wall time    3.302    CPU time    1.945    CPU =
utilization  58.90 %
 	Children see throughput for 12 readers 		=3D 4265828.28 =
kB/sec
 	Parent sees throughput for 12 readers 		=3D 4261844.88 =
kB/sec
 	Min throughput per process 			=3D  352305.00 =
kB/sec
 	Max throughput per process 			=3D  357726.22 =
kB/sec
 	Avg throughput per process 			=3D  355485.69 =
kB/sec
 	Min xfer 					=3D 1032960.00 =
kB
 	CPU utilization: Wall time    2.934    CPU time    1.942    CPU =
utilization  66.20 %
 	Children see throughput for 12 re-readers 	=3D 4220651.19 =
kB/sec
 	Parent sees throughput for 12 re-readers 	=3D 4216096.04 =
kB/sec
 	Min throughput per process 			=3D  348677.16 =
kB/sec
 	Max throughput per process 			=3D  353467.44 =
kB/sec
 	Avg throughput per process 			=3D  351720.93 =
kB/sec
 	Min xfer 					=3D 1035264.00 =
kB
 	CPU utilization: Wall time    2.969    CPU time    1.952    CPU =
utilization  65.74 %

The regression appears to be 100% reproducible.=20


--
Chuck Lever



