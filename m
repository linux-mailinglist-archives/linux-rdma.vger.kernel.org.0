Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB32F4CD0
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 15:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbhAMOL5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 09:11:57 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47266 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbhAMOL5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Jan 2021 09:11:57 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DE3sds027905;
        Wed, 13 Jan 2021 14:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=A1ViBcuAE7rNLlE5khF4PRKBNmn+alH7qCPrRj+YvsQ=;
 b=s18ryd99wsKb/B53Ll6ngYUPsilFuM53WmpCRy8KBMWBq2JJAJxZZtihpPilHen8jSZe
 9Z9Q7UjvuXos6EU/Mg3cPIqi07byPITYBcJy1GY++3DjMuz32nbz0uF2VZaoeLM+e2/q
 nN2u/EUPWJBQcf1EPGf1XDkyEb/meqxLJGoleATcyMQpcd6poOWzfL5QSONu222wV1xQ
 2TUi46RGhgAwdBUmEnPNUENppBRivNnmqNS2GLG7inrdR7DQ8jhvNuQ36yAnYGM4Epbx
 YkjKXS1ToyFfaILIohE7ye7wUS5xlww9be3b5SVoBlReOQw9FjgR6kh6IoiEMYaPHI0x dA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kcyujxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 14:09:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DE5fj9107959;
        Wed, 13 Jan 2021 14:07:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 360ke8e53r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 14:07:51 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10DE7mtB002393;
        Wed, 13 Jan 2021 14:07:48 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jan 2021 06:07:47 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <dfd84bd8-37b3-0f7c-6f38-68f68e8f5b0f@linux.intel.com>
Date:   Wed, 13 Jan 2021 09:07:44 -0500
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>, logang@deltatee.com,
        hch@lst.de, murphyt7@tcd.ie, robin.murphy@arm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <440CA3AE-BD76-449D-9C66-4A063C8726B2@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <dfd84bd8-37b3-0f7c-6f38-68f68e8f5b0f@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=948 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=958 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130087
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jan 12, 2021, at 9:25 PM, Lu Baolu <baolu.lu@linux.intel.com> =
wrote:
>=20
> Hi,
>=20
> On 1/12/21 10:38 PM, Will Deacon wrote:
>> [Expanding cc list to include DMA-IOMMU and intel IOMMU folks]
>> On Fri, Jan 08, 2021 at 04:18:36PM -0500, Chuck Lever wrote:
>>> Hi-
>>>=20
>>> [ Please cc: me on replies, I'm not currently subscribed to
>>> iommu@lists ].
>>>=20
>>> I'm running NFS performance tests on InfiniBand using CX-3 Pro cards
>>> at 56Gb/s. The test is iozone on an NFSv3/RDMA mount:
>>>=20
>>> /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
>>>=20
>>> For those not familiar with the way storage protocols use RDMA, The
>>> initiator/client sets up memory regions and the target/server uses
>>> RDMA Read and Write to move data out of and into those regions. The
>>> initiator/client uses only RDMA memory registration and invalidation
>>> operations, and the target/server uses RDMA Read and Write.
>>>=20
>>> My NFS client is a two-socket 12-core x86_64 system with its I/O MMU
>>> enabled using the kernel command line options "intel_iommu=3Don
>>> iommu=3Dstrict".
>>>=20
>>> Recently I've noticed a significant (25-30%) loss in NFS throughput.
>>> I was able to bisect on my client to the following commits.
>>>=20
>>> Here's 65f746e8285f ("iommu: Add quirk for Intel graphic devices in
>>> map_sg"). This is about normal for this test.
>>>=20
>>> 	Children see throughput for 12 initial writers 	=3D 4732581.09 =
kB/sec
>>>  	Parent sees throughput for 12 initial writers 	=3D 4646810.21 =
kB/sec
>>>  	Min throughput per process 			=3D  387764.34 =
kB/sec
>>>  	Max throughput per process 			=3D  399655.47 =
kB/sec
>>>  	Avg throughput per process 			=3D  394381.76 =
kB/sec
>>>  	Min xfer 					=3D 1017344.00 =
kB
>>>  	CPU Utilization: Wall time    2.671    CPU time    1.974    CPU =
utilization  73.89 %
>>>  	Children see throughput for 12 rewriters 	=3D 4837741.94 =
kB/sec
>>>  	Parent sees throughput for 12 rewriters 	=3D 4833509.35 =
kB/sec
>>>  	Min throughput per process 			=3D  398983.72 =
kB/sec
>>>  	Max throughput per process 			=3D  406199.66 =
kB/sec
>>>  	Avg throughput per process 			=3D  403145.16 =
kB/sec
>>>  	Min xfer 					=3D 1030656.00 =
kB
>>>  	CPU utilization: Wall time    2.584    CPU time    1.959    CPU =
utilization  75.82 %
>>>  	Children see throughput for 12 readers 		=3D 5921370.94 =
kB/sec
>>>  	Parent sees throughput for 12 readers 		=3D 5914106.69 =
kB/sec
>>>  	Min throughput per process 			=3D  491812.38 =
kB/sec
>>>  	Max throughput per process 			=3D  494777.28 =
kB/sec
>>>  	Avg throughput per process 			=3D  493447.58 =
kB/sec
>>>  	Min xfer 					=3D 1042688.00 =
kB
>>>  	CPU utilization: Wall time    2.122    CPU time    1.968    CPU =
utilization  92.75 %
>>>  	Children see throughput for 12 re-readers 	=3D 5947985.69 =
kB/sec
>>>  	Parent sees throughput for 12 re-readers 	=3D 5941348.51 =
kB/sec
>>>  	Min throughput per process 			=3D  492805.81 =
kB/sec
>>>  	Max throughput per process 			=3D  497280.19 =
kB/sec
>>>  	Avg throughput per process 			=3D  495665.47 =
kB/sec
>>>  	Min xfer 					=3D 1039360.00 =
kB
>>>  	CPU utilization: Wall time    2.111    CPU time    1.968    CPU =
utilization  93.22 %
>>>=20
>>> Here's c062db039f40 ("iommu/vt-d: Update domain geometry in
>>> iommu_ops.at(de)tach_dev"). It's losing some steam here.
>>>=20
>>> 	Children see throughput for 12 initial writers 	=3D 4342419.12 =
kB/sec
>>>  	Parent sees throughput for 12 initial writers 	=3D 4310612.79 =
kB/sec
>>>  	Min throughput per process 			=3D  359299.06 =
kB/sec
>>>  	Max throughput per process 			=3D  363866.16 =
kB/sec
>>>  	Avg throughput per process 			=3D  361868.26 =
kB/sec
>>>  	Min xfer 					=3D 1035520.00 =
kB
>>>  	CPU Utilization: Wall time    2.902    CPU time    1.951    CPU =
utilization  67.22 %
>>>  	Children see throughput for 12 rewriters 	=3D 4408576.66 =
kB/sec
>>>  	Parent sees throughput for 12 rewriters 	=3D 4404280.87 =
kB/sec
>>>  	Min throughput per process 			=3D  364553.88 =
kB/sec
>>>  	Max throughput per process 			=3D  370029.28 =
kB/sec
>>>  	Avg throughput per process 			=3D  367381.39 =
kB/sec
>>>  	Min xfer 					=3D 1033216.00 =
kB
>>>  	CPU utilization: Wall time    2.836    CPU time    1.956    CPU =
utilization  68.97 %
>>>  	Children see throughput for 12 readers 		=3D 5406879.47 =
kB/sec
>>>  	Parent sees throughput for 12 readers 		=3D 5401862.78 =
kB/sec
>>>  	Min throughput per process 			=3D  449583.03 =
kB/sec
>>>  	Max throughput per process 			=3D  451761.69 =
kB/sec
>>>  	Avg throughput per process 			=3D  450573.29 =
kB/sec
>>>  	Min xfer 					=3D 1044224.00 =
kB
>>>  	CPU utilization: Wall time    2.323    CPU time    1.977    CPU =
utilization  85.12 %
>>>  	Children see throughput for 12 re-readers 	=3D 5410601.12 =
kB/sec
>>>  	Parent sees throughput for 12 re-readers 	=3D 5403504.40 =
kB/sec
>>>  	Min throughput per process 			=3D  449918.12 =
kB/sec
>>>  	Max throughput per process 			=3D  452489.28 =
kB/sec
>>>  	Avg throughput per process 			=3D  450883.43 =
kB/sec
>>>  	Min xfer 					=3D 1043456.00 =
kB
>>>  	CPU utilization: Wall time    2.321    CPU time    1.978    CPU =
utilization  85.21 %
>>>=20
>>> And here's c588072bba6b ("iommu/vt-d: Convert intel iommu driver to
>>> the iommu ops"). Significant throughput loss.
>>>=20
>>> 	Children see throughput for 12 initial writers 	=3D 3812036.91 =
kB/sec
>>>  	Parent sees throughput for 12 initial writers 	=3D 3753683.40 =
kB/sec
>>>  	Min throughput per process 			=3D  313672.25 =
kB/sec
>>>  	Max throughput per process 			=3D  321719.44 =
kB/sec
>>>  	Avg throughput per process 			=3D  317669.74 =
kB/sec
>>>  	Min xfer 					=3D 1022464.00 =
kB
>>>  	CPU Utilization: Wall time    3.309    CPU time    1.986    CPU =
utilization  60.02 %
>>>  	Children see throughput for 12 rewriters 	=3D 3786831.94 =
kB/sec
>>>  	Parent sees throughput for 12 rewriters 	=3D 3783205.58 =
kB/sec
>>>  	Min throughput per process 			=3D  313654.44 =
kB/sec
>>>  	Max throughput per process 			=3D  317844.50 =
kB/sec
>>>  	Avg throughput per process 			=3D  315569.33 =
kB/sec
>>>  	Min xfer 					=3D 1035520.00 =
kB
>>>  	CPU utilization: Wall time    3.302    CPU time    1.945    CPU =
utilization  58.90 %
>>>  	Children see throughput for 12 readers 		=3D 4265828.28 =
kB/sec
>>>  	Parent sees throughput for 12 readers 		=3D 4261844.88 =
kB/sec
>>>  	Min throughput per process 			=3D  352305.00 =
kB/sec
>>>  	Max throughput per process 			=3D  357726.22 =
kB/sec
>>>  	Avg throughput per process 			=3D  355485.69 =
kB/sec
>>>  	Min xfer 					=3D 1032960.00 =
kB
>>>  	CPU utilization: Wall time    2.934    CPU time    1.942    CPU =
utilization  66.20 %
>>>  	Children see throughput for 12 re-readers 	=3D 4220651.19 =
kB/sec
>>>  	Parent sees throughput for 12 re-readers 	=3D 4216096.04 =
kB/sec
>>>  	Min throughput per process 			=3D  348677.16 =
kB/sec
>>>  	Max throughput per process 			=3D  353467.44 =
kB/sec
>>>  	Avg throughput per process 			=3D  351720.93 =
kB/sec
>>>  	Min xfer 					=3D 1035264.00 =
kB
>>>  	CPU utilization: Wall time    2.969    CPU time    1.952    CPU =
utilization  65.74 %
>>>=20
>>> The regression appears to be 100% reproducible.
>=20
> The commit 65f746e8285f ("iommu: Add quirk for Intel graphic devices =
in
> map_sg") is a temporary workaround. We have reverted it recently =
(5.11-
> rc3). Can you please try the a kernel version after -rc3?

I don't see a change in write results with v5.11-rc3, but read =
throughput
appears to improve a little.


	Children see throughput for 12 initial writers 	=3D 3854295.72 =
kB/sec
	Parent sees throughput for 12 initial writers 	=3D 3744064.85 =
kB/sec
	Min throughput per process 			=3D  313499.41 =
kB/sec=20
	Max throughput per process 			=3D  328151.44 =
kB/sec
	Avg throughput per process 			=3D  321191.31 =
kB/sec
	Min xfer 					=3D 1001728.00 =
kB
	CPU Utilization: Wall time    3.289    CPU time    2.075    CPU =
utilization  63.10 %


	Children see throughput for 12 rewriters 	=3D 3692675.22 =
kB/sec
	Parent sees throughput for 12 rewriters 	=3D 3688975.23 =
kB/sec
	Min throughput per process 			=3D  304863.84 =
kB/sec=20
	Max throughput per process 			=3D  311000.16 =
kB/sec
	Avg throughput per process 			=3D  307722.93 =
kB/sec
	Min xfer 					=3D 1028096.00 =
kB
	CPU utilization: Wall time    3.375    CPU time    2.051    CPU =
utilization  60.76 %


	Children see throughput for 12 readers 		=3D 4521975.69 =
kB/sec
	Parent sees throughput for 12 readers 		=3D 4516965.08 =
kB/sec
	Min throughput per process 			=3D  372762.16 =
kB/sec=20
	Max throughput per process 			=3D  382233.84 =
kB/sec
	Avg throughput per process 			=3D  376831.31 =
kB/sec
	Min xfer 					=3D 1022720.00 =
kB
	CPU utilization: Wall time    2.747    CPU time    1.961    CPU =
utilization  71.39 %


	Children see throughput for 12 re-readers 	=3D 4684127.06 =
kB/sec
	Parent sees throughput for 12 re-readers 	=3D 4678990.23 =
kB/sec
	Min throughput per process 			=3D  385586.34 =
kB/sec=20
	Max throughput per process 			=3D  395542.47 =
kB/sec
	Avg throughput per process 			=3D  390343.92 =
kB/sec
	Min xfer 					=3D 1022208.00 =
kB
	CPU utilization: Wall time    2.653    CPU time    1.941    CPU =
utilization  73.16 %



--
Chuck Lever



