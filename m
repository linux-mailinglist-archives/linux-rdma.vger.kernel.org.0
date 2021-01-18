Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96242FAB11
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 21:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394200AbhARUKd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 15:10:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47088 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394199AbhARUKY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 15:10:24 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10IK68Kh062015;
        Mon, 18 Jan 2021 20:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=tQWutOTFsHtF+2kIIjf9PifkBBNjJfcMEorlAwE9r1Y=;
 b=w2jbMElXh2VIM6cuHzUHRAXgwO6l5pGZeoz+KTA8masG0KSHVhlIh392pnWN2i3w6aLX
 DZCNJth/OPIDf/Xyw3nyJNrH9uqAzzwCpfWAkR6H/qJe4avvhUjUv20yWdIIYX61ZYEn
 dsKn5/v+RZZPGgs3giSpTmzfvyQll2B+21nwtaTLVYsJ9DpNsHo7CXux2qTQ/DUnEBZ3
 uS5Z92XNgMBVbuBkfHtuPzgq4+a52Z6yvCBX8f58IC6r/njE1SFIPG74zomOmqnduDkE
 Oqvkc2oAd6PyB7MifbhA9xeydvvtd850y3ab+NyTHmZxz/oJew2bN5SY8OkNxDbN2sbY qg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 363nnaepm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jan 2021 20:09:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10IK0W3k002335;
        Mon, 18 Jan 2021 20:09:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 364a1ws8ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jan 2021 20:09:24 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10IK9JAZ023190;
        Mon, 18 Jan 2021 20:09:19 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jan 2021 12:09:19 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: performance regression noted in v5.11-rc after c062db039f40
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
Date:   Mon, 18 Jan 2021 15:09:18 -0500
Cc:     iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>, logang@deltatee.com,
        Christoph Hellwig <hch@lst.de>, murphyt7@tcd.ie
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6B45F88-08B7-41B5-AAD2-BFB374A42874@oracle.com>
References: <D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com>
 <20210112143819.GA9689@willie-the-truck>
 <607648D8-BF0C-40D6-9B43-2359F45EE74C@oracle.com>
 <e83eed0d-82cd-c9be-cef1-5fe771de975f@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=802 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101180120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9868 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 mlxlogscore=814 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101180120
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Jan 18, 2021, at 1:00 PM, Robin Murphy <robin.murphy@arm.com> =
wrote:
>=20
> On 2021-01-18 16:18, Chuck Lever wrote:
>>> On Jan 12, 2021, at 9:38 AM, Will Deacon <will@kernel.org> wrote:
>>>=20
>>> [Expanding cc list to include DMA-IOMMU and intel IOMMU folks]
>>>=20
>>> On Fri, Jan 08, 2021 at 04:18:36PM -0500, Chuck Lever wrote:
>>>> Hi-
>>>>=20
>>>> [ Please cc: me on replies, I'm not currently subscribed to
>>>> iommu@lists ].
>>>>=20
>>>> I'm running NFS performance tests on InfiniBand using CX-3 Pro =
cards
>>>> at 56Gb/s. The test is iozone on an NFSv3/RDMA mount:
>>>>=20
>>>> /home/cel/bin/iozone -M -+u -i0 -i1 -s1g -r256k -t12 -I
>>>>=20
>>>> For those not familiar with the way storage protocols use RDMA, The
>>>> initiator/client sets up memory regions and the target/server uses
>>>> RDMA Read and Write to move data out of and into those regions. The
>>>> initiator/client uses only RDMA memory registration and =
invalidation
>>>> operations, and the target/server uses RDMA Read and Write.
>>>>=20
>>>> My NFS client is a two-socket 12-core x86_64 system with its I/O =
MMU
>>>> enabled using the kernel command line options "intel_iommu=3Don
>>>> iommu=3Dstrict".
>>>>=20
>>>> Recently I've noticed a significant (25-30%) loss in NFS =
throughput.
>>>> I was able to bisect on my client to the following commits.
>>>>=20
>>>> Here's 65f746e8285f ("iommu: Add quirk for Intel graphic devices in
>>>> map_sg"). This is about normal for this test.
>>>>=20
>>>> 	Children see throughput for 12 initial writers 	=3D 4732581.09 =
kB/sec
>>>> 	Parent sees throughput for 12 initial writers 	=3D 4646810.21 =
kB/sec
>>>> 	Min throughput per process 			=3D  387764.34 =
kB/sec
>>>> 	Max throughput per process 			=3D  399655.47 =
kB/sec
>>>> 	Avg throughput per process 			=3D  394381.76 =
kB/sec
>>>> 	Min xfer 					=3D 1017344.00 =
kB
>>>> 	CPU Utilization: Wall time    2.671    CPU time    1.974    CPU =
utilization  73.89 %
>>>> 	Children see throughput for 12 rewriters 	=3D 4837741.94 =
kB/sec
>>>> 	Parent sees throughput for 12 rewriters 	=3D 4833509.35 =
kB/sec
>>>> 	Min throughput per process 			=3D  398983.72 =
kB/sec
>>>> 	Max throughput per process 			=3D  406199.66 =
kB/sec
>>>> 	Avg throughput per process 			=3D  403145.16 =
kB/sec
>>>> 	Min xfer 					=3D 1030656.00 =
kB
>>>> 	CPU utilization: Wall time    2.584    CPU time    1.959    CPU =
utilization  75.82 %
>>>> 	Children see throughput for 12 readers 		=3D 5921370.94 =
kB/sec
>>>> 	Parent sees throughput for 12 readers 		=3D 5914106.69 =
kB/sec
>>>> 	Min throughput per process 			=3D  491812.38 =
kB/sec
>>>> 	Max throughput per process 			=3D  494777.28 =
kB/sec
>>>> 	Avg throughput per process 			=3D  493447.58 =
kB/sec
>>>> 	Min xfer 					=3D 1042688.00 =
kB
>>>> 	CPU utilization: Wall time    2.122    CPU time    1.968    CPU =
utilization  92.75 %
>>>> 	Children see throughput for 12 re-readers 	=3D 5947985.69 =
kB/sec
>>>> 	Parent sees throughput for 12 re-readers 	=3D 5941348.51 =
kB/sec
>>>> 	Min throughput per process 			=3D  492805.81 =
kB/sec
>>>> 	Max throughput per process 			=3D  497280.19 =
kB/sec
>>>> 	Avg throughput per process 			=3D  495665.47 =
kB/sec
>>>> 	Min xfer 					=3D 1039360.00 =
kB
>>>> 	CPU utilization: Wall time    2.111    CPU time    1.968    CPU =
utilization  93.22 %
>>>>=20
>>>> Here's c062db039f40 ("iommu/vt-d: Update domain geometry in
>>>> iommu_ops.at(de)tach_dev"). It's losing some steam here.
>>>>=20
>>>> 	Children see throughput for 12 initial writers 	=3D 4342419.12 =
kB/sec
>>>> 	Parent sees throughput for 12 initial writers 	=3D 4310612.79 =
kB/sec
>>>> 	Min throughput per process 			=3D  359299.06 =
kB/sec
>>>> 	Max throughput per process 			=3D  363866.16 =
kB/sec
>>>> 	Avg throughput per process 			=3D  361868.26 =
kB/sec
>>>> 	Min xfer 					=3D 1035520.00 =
kB
>>>> 	CPU Utilization: Wall time    2.902    CPU time    1.951    CPU =
utilization  67.22 %
>>>> 	Children see throughput for 12 rewriters 	=3D 4408576.66 =
kB/sec
>>>> 	Parent sees throughput for 12 rewriters 	=3D 4404280.87 =
kB/sec
>>>> 	Min throughput per process 			=3D  364553.88 =
kB/sec
>>>> 	Max throughput per process 			=3D  370029.28 =
kB/sec
>>>> 	Avg throughput per process 			=3D  367381.39 =
kB/sec
>>>> 	Min xfer 					=3D 1033216.00 =
kB
>>>> 	CPU utilization: Wall time    2.836    CPU time    1.956    CPU =
utilization  68.97 %
>>>> 	Children see throughput for 12 readers 		=3D 5406879.47 =
kB/sec
>>>> 	Parent sees throughput for 12 readers 		=3D 5401862.78 =
kB/sec
>>>> 	Min throughput per process 			=3D  449583.03 =
kB/sec
>>>> 	Max throughput per process 			=3D  451761.69 =
kB/sec
>>>> 	Avg throughput per process 			=3D  450573.29 =
kB/sec
>>>> 	Min xfer 					=3D 1044224.00 =
kB
>>>> 	CPU utilization: Wall time    2.323    CPU time    1.977    CPU =
utilization  85.12 %
>>>> 	Children see throughput for 12 re-readers 	=3D 5410601.12 =
kB/sec
>>>> 	Parent sees throughput for 12 re-readers 	=3D 5403504.40 =
kB/sec
>>>> 	Min throughput per process 			=3D  449918.12 =
kB/sec
>>>> 	Max throughput per process 			=3D  452489.28 =
kB/sec
>>>> 	Avg throughput per process 			=3D  450883.43 =
kB/sec
>>>> 	Min xfer 					=3D 1043456.00 =
kB
>>>> 	CPU utilization: Wall time    2.321    CPU time    1.978    CPU =
utilization  85.21 %
>>>>=20
>>>> And here's c588072bba6b ("iommu/vt-d: Convert intel iommu driver to
>>>> the iommu ops"). Significant throughput loss.
>>>>=20
>>>> 	Children see throughput for 12 initial writers 	=3D 3812036.91 =
kB/sec
>>>> 	Parent sees throughput for 12 initial writers 	=3D 3753683.40 =
kB/sec
>>>> 	Min throughput per process 			=3D  313672.25 =
kB/sec
>>>> 	Max throughput per process 			=3D  321719.44 =
kB/sec
>>>> 	Avg throughput per process 			=3D  317669.74 =
kB/sec
>>>> 	Min xfer 					=3D 1022464.00 =
kB
>>>> 	CPU Utilization: Wall time    3.309    CPU time    1.986    CPU =
utilization  60.02 %
>>>> 	Children see throughput for 12 rewriters 	=3D 3786831.94 =
kB/sec
>>>> 	Parent sees throughput for 12 rewriters 	=3D 3783205.58 =
kB/sec
>>>> 	Min throughput per process 			=3D  313654.44 =
kB/sec
>>>> 	Max throughput per process 			=3D  317844.50 =
kB/sec
>>>> 	Avg throughput per process 			=3D  315569.33 =
kB/sec
>>>> 	Min xfer 					=3D 1035520.00 =
kB
>>>> 	CPU utilization: Wall time    3.302    CPU time    1.945    CPU =
utilization  58.90 %
>>>> 	Children see throughput for 12 readers 		=3D 4265828.28 =
kB/sec
>>>> 	Parent sees throughput for 12 readers 		=3D 4261844.88 =
kB/sec
>>>> 	Min throughput per process 			=3D  352305.00 =
kB/sec
>>>> 	Max throughput per process 			=3D  357726.22 =
kB/sec
>>>> 	Avg throughput per process 			=3D  355485.69 =
kB/sec
>>>> 	Min xfer 					=3D 1032960.00 =
kB
>>>> 	CPU utilization: Wall time    2.934    CPU time    1.942    CPU =
utilization  66.20 %
>>>> 	Children see throughput for 12 re-readers 	=3D 4220651.19 =
kB/sec
>>>> 	Parent sees throughput for 12 re-readers 	=3D 4216096.04 =
kB/sec
>>>> 	Min throughput per process 			=3D  348677.16 =
kB/sec
>>>> 	Max throughput per process 			=3D  353467.44 =
kB/sec
>>>> 	Avg throughput per process 			=3D  351720.93 =
kB/sec
>>>> 	Min xfer 					=3D 1035264.00 =
kB
>>>> 	CPU utilization: Wall time    2.969    CPU time    1.952    CPU =
utilization  65.74 %
>>>>=20
>>>> The regression appears to be 100% reproducible.
>> Any thoughts?
>> How about some tools to try or debugging advice? I don't know where =
to start.
>=20
> I'm not familiar enough with VT-D internals or Infiniband to have a =
clue why the middle commit makes any difference (the calculation itself =
is not on a fast path, so AFAICS the worst it could do is change your =
maximum DMA address size from 48/57 bits to 47/56, and that seems =
relatively benign).

Thanks for your response. Understood that you are not responding
about the middle commit (c062db039f40).

However, that's a pretty small and straightforward change, so I've
experimented a bit with that. Commenting out the new code there, I
get some relief:

	Children see throughput for 12 initial writers 	=3D 4266621.62 =
kB/sec
	Parent sees throughput for 12 initial writers 	=3D 4254756.31 =
kB/sec
	Min throughput per process 			=3D  354847.75 =
kB/sec=20
	Max throughput per process 			=3D  356167.59 =
kB/sec
	Avg throughput per process 			=3D  355551.80 =
kB/sec
	Min xfer 					=3D 1044736.00 =
kB
	CPU Utilization: Wall time    2.951    CPU time    1.981    CPU =
utilization  67.11 %


	Children see throughput for 12 rewriters 	=3D 4314827.34 =
kB/sec
	Parent sees throughput for 12 rewriters 	=3D 4310347.32 =
kB/sec
	Min throughput per process 			=3D  358599.72 =
kB/sec=20
	Max throughput per process 			=3D  360319.06 =
kB/sec
	Avg throughput per process 			=3D  359568.95 =
kB/sec
	Min xfer 					=3D 1043968.00 =
kB
	CPU utilization: Wall time    2.912    CPU time    2.057    CPU =
utilization  70.62 %


	Children see throughput for 12 readers 		=3D 4614004.47 =
kB/sec
	Parent sees throughput for 12 readers 		=3D 4609014.68 =
kB/sec
	Min throughput per process 			=3D  382414.81 =
kB/sec=20
	Max throughput per process 			=3D  388519.50 =
kB/sec
	Avg throughput per process 			=3D  384500.37 =
kB/sec
	Min xfer 					=3D 1032192.00 =
kB
	CPU utilization: Wall time    2.701    CPU time    1.900    CPU =
utilization  70.35 %


	Children see throughput for 12 re-readers 	=3D 4653743.81 =
kB/sec
	Parent sees throughput for 12 re-readers 	=3D 4647155.31 =
kB/sec
	Min throughput per process 			=3D  384995.69 =
kB/sec=20
	Max throughput per process 			=3D  390874.09 =
kB/sec
	Avg throughput per process 			=3D  387811.98 =
kB/sec
	Min xfer 					=3D 1032960.00 =
kB
	CPU utilization: Wall time    2.684    CPU time    1.907    CPU =
utilization  71.06 %

I instrumented the code to show the "before" and "after" values.

The value of domain->domain.geometry.aperture_end on my system
before this commit (and before the c062db039f40 code) is:

144,115,188,075,855,871 =3D 2^57

The c062db039f40 code sets domain->domain.geometry.aperture_end to:

281,474,976,710,655 =3D 2^48

Fwiw, this system uses the Intel C612 chipset with Intel(R) Xeon(R)
E5-2603 v3 @ 1.60GHz CPUs.


My sense is that "CPU time" remains about the same because the problem
isn't manifesting as an increase in instruction path length. Wall time
goes up, CPU time stays the same, the ratio of those (ie, utilization)
drops.


--
Chuck Lever



