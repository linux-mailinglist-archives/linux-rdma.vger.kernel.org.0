Return-Path: <linux-rdma+bounces-4186-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFFB945DC1
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 14:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A7E1F23296
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DA71C2322;
	Fri,  2 Aug 2024 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WbN0ni5j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE18417995;
	Fri,  2 Aug 2024 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722601033; cv=none; b=H2RQBTKNbyepFl2J9vM6sy4A/DReuFoSKOYrUWsYC0DveVvlLHR/+x+KaUhZynYqvNJTPx8bLhL4obhpKbuO4E7iwJYqHb56KBf4zMel8ZBwl/F7SwUcN/HnsjCXgfwexbbe3AI5558xBp7sb35ABw9we1xW6FrAKzvKzXr1GGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722601033; c=relaxed/simple;
	bh=pntlmoLOjjYedygTE9gtLKLKcSeyqC/Hz99kbii3rjc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=THttospwtQ6vU5jMlqsIu5dh9rv+CoW/lEJ/aGh8ttXWlr51tFVgyiedp0d7gDzU/O+5bC8iNWSmnvYrvSDbNV5Jhjgz8+wVJjHu9tVJB5vDvfbOgmdDyj4NdRCLSd/iZKyX0uhVhwIppZ9mrZKj/vf2I4BX+dboi/YKWIeikWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WbN0ni5j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472AuAU3022965;
	Fri, 2 Aug 2024 12:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	gfrQUcaV+s7Gq+mfEJj2TyZrzhoHEQtKSiBupzjJV6w=; b=WbN0ni5jlWG+TLVK
	tjVqme9RTMj8HccdsCMCd+LnwFdp+l1FboMEB6tD/JrW0MK/x0qAN3VF+6xyikKJ
	YV/DXHoPzp/rXirQmwroXXop/oNkC3UuE5NoFx+lvPnXAH69/X26WIGpB+m1K6Gg
	rctsAE2V7NOQxxvrImmEk5W3H8P+oO2fQclFWJlu9UHR0IJO0gIrqQpIold1o6d4
	YwjyR/VdYAfBvxhLd2wKUynfQ+fbAzUwrksUno3aV8qy/8NkB0/KbEEr3lN1Fw5b
	3uaxtZzJ6fk/tyBLZPPVQLWdDYn/G+DYE1WblYRjU5HDj14Ly5uGNJ2Pjp8nd2Sn
	LnzDMA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ru3grjp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 12:16:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472A02Gl007682;
	Fri, 2 Aug 2024 12:16:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7uqd6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 12:16:53 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472CGpuZ25625122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 12:16:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 379225805D;
	Fri,  2 Aug 2024 12:16:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11C6758052;
	Fri,  2 Aug 2024 12:16:49 +0000 (GMT)
Received: from [9.109.198.216] (unknown [9.109.198.216])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 12:16:48 +0000 (GMT)
Message-ID: <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com>
Date: Fri, 2 Aug 2024 17:46:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.11-rc1 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bGpNXLnrJPuFn3RsWliBR8kq6B5Dy3Py
X-Proofpoint-ORIG-GUID: bGpNXLnrJPuFn3RsWliBR8kq6B5Dy3Py
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
 definitions=2024-08-02_08,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1011 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020081



On 8/2/24 14:39, Shinichiro Kawasaki wrote:
> 
> #3: nvme/052 (CKI failure)
> 
>    The CKI project reported that nvme/052 fails occasionally [4].
>    This needs further debug effort.
> 
>   nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
>       runtime    ...  22.209s
>       --- tests/nvme/052.out	2024-07-30 18:38:29.041716566 -0400
>       +++ /mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/archive/production/kernel-tests-production.zip/storage/blktests/nvme/nvme-loop/blktests/results/nodev_tr_loop/nvme/052.out.bad	2024-07-30 18:45:35.438067452 -0400
>       @@ -1,2 +1,4 @@
>        Running nvme/052
>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
>        Test complete
> 
>    [4] https://datawarehouse.cki-project.org/kcidb/tests/13669275

I just checked the console logs of the nvme/052 and from the logs it's 
apparent that all namespaces were created successfully and so it's strange
to see that the test couldn't access "/sys/block/nvme1n2/uuid". Do you know
if there's any chance of simultaneous blktests running on this machine?
 
On my test machine, I couldn't reproduce this issue on 6.11-rc1 kernel.

Thanks,
--Nilay
 

