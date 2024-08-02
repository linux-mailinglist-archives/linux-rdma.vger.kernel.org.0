Return-Path: <linux-rdma+bounces-4192-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C1E946209
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 18:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1A32829D9
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D12413635E;
	Fri,  2 Aug 2024 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nbwlj3xP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47C16BE3D;
	Fri,  2 Aug 2024 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722617391; cv=none; b=EBUE7atETARbOPXX7EHV5uUFvu1oiA8uHfL7eqFn9zledKn3cFOMKegqLgmlsGlYu+7ZEThLAV7hfYVTwIbXvV0hb3ubOrE40LnGUPtRKOBdLEACiqicCrDst85W1epZFhBgHZL2HM+k1EIxYWaU1/bGPtcY5Fxqrhzdgyzsqsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722617391; c=relaxed/simple;
	bh=cSNgKJAuE43cxsIbzCafaUQZQjln2GGWeW9rtMq+TCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPpC/bhqRZNAmTEP76MEZR7RIirrJpwZgZD4rRxPVpGaYfLnGugwxYQGLBwtTr2chfulkjPZfLklCD1vy7pqEohSYsTgEfAQnTXIKuc1o/W2llfgwrk5KV9wUs25KKT/wRIK0hvj1rvq3BvXUhZqKeZRvkPqzw6CrGKii64PzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nbwlj3xP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472FTBA7011799;
	Fri, 2 Aug 2024 16:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	cg/bndupk50rnRSsxm4uXdUIHZrNSZ5AzvafipUGmz8=; b=nbwlj3xPgqLjq4hn
	BiMRfwpOq2AnIqP8YUvW+A7E9apEy/G92t3teOEmJ7tok9sCwLwRLaEY8mxlknSA
	PeWIEjCoKgyx8L2LizMomvysWqlDZbIyz2Cb7nXIYIdeoCJLJJfT/3lqnMQmu1fh
	4KGUTtA71ymfWwgSFLExdrDtrQJbxcpBLptN/JIkHUt4Mft0NqwGZkDZfVTQCJJS
	nWbR1nuBIGYB27uucrrRlap9wiHjgs/pP66WoJYUBuZOg/eanxLxijXrUpItt7nK
	/dtdR1GBDuUx4zXimMChvduXm42l5AyGY3rTrd/Auaqtjq19uDIxOK2fl6t+kxEo
	8gZN/g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s1pf07d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 16:49:37 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472Gnbuk018859;
	Fri, 2 Aug 2024 16:49:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s1pf07d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 16:49:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472DmSUY029103;
	Fri, 2 Aug 2024 16:49:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm18a24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 16:49:36 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472GnYmA16974424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 16:49:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 255C758043;
	Fri,  2 Aug 2024 16:49:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D97758053;
	Fri,  2 Aug 2024 16:49:31 +0000 (GMT)
Received: from [9.171.33.192] (unknown [9.171.33.192])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 16:49:31 +0000 (GMT)
Message-ID: <79a7ec0d-c22d-44cf-a832-13da05a1fcbd@linux.ibm.com>
Date: Fri, 2 Aug 2024 22:19:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.11-rc1 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
 <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com>
 <ljqlgkvhkojsmehqddmeo4dng6l3yaav6le2uslsumfxivluwu@m7lkx3j4mkkw>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ljqlgkvhkojsmehqddmeo4dng6l3yaav6le2uslsumfxivluwu@m7lkx3j4mkkw>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tkuW1usVc4_L-ZsXnVMafpq53k4_2E6j
X-Proofpoint-GUID: a115jAe8d2xS4aK9ey4Ffkuh_ApZccBy
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_12,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020114



On 8/2/24 18:04, Shinichiro Kawasaki wrote:
> CC+: Yi Zhang,
> 
> On Aug 02, 2024 / 17:46, Nilay Shroff wrote:
>>
>>
>> On 8/2/24 14:39, Shinichiro Kawasaki wrote:
>>>
>>> #3: nvme/052 (CKI failure)
>>>
>>>    The CKI project reported that nvme/052 fails occasionally [4].
>>>    This needs further debug effort.
>>>
>>>   nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
>>>       runtime    ...  22.209s
>>>       --- tests/nvme/052.out	2024-07-30 18:38:29.041716566 -0400
>>>       +++ /mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/archive/production/kernel-tests-production.zip/storage/blktests/nvme/nvme-loop/blktests/results/nodev_tr_loop/nvme/052.out.bad	2024-07-30 18:45:35.438067452 -0400
>>>       @@ -1,2 +1,4 @@
>>>        Running nvme/052
>>>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
>>>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
>>>        Test complete
>>>
>>>    [4] https://datawarehouse.cki-project.org/kcidb/tests/13669275
>>
>> I just checked the console logs of the nvme/052 and from the logs it's 
>> apparent that all namespaces were created successfully and so it's strange
>> to see that the test couldn't access "/sys/block/nvme1n2/uuid".
> 
> I agree that it's strange. I think the "No such file or directory" error
> happened in _find_nvme_ns(), and it checks existence of the uuid file before
> the cat command. I have no idea why the error happens.
> 
Yes exactly, and these two operations (checking the existence of uuid
and cat command) are not atomic. So the only plausible theory I have at this 
time is "if namespace is deleted after checking the existence of uuid but 
before cat command is executed" then this issue may potentially manifests. 
Furthermore, as you mentioned, this issue is seen on the test machine 
occasionally, so I asked if there's a possibility of simultaneous blktest 
or some other tests running on this system.

Thanks,
--Nilay

