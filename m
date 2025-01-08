Return-Path: <linux-rdma+bounces-6917-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BBCA060FD
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA5D1676CD
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08EC1FE455;
	Wed,  8 Jan 2025 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oL01pJSj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F214A82;
	Wed,  8 Jan 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352039; cv=none; b=UeBRFhaG1aHCNV6y0Zv8vR9du7AhmPd3JcNkizCJ7xgoT1iGZFW/SSUf5ycUJFZkZBb1u335yV1JOVDaAVafDqbO0xin7QJGwj8W0pFQT3bKM08VgKhy5RWh9XChFjoQfhA0dyXivUcJIRcw2cdl6MBnfGAmW33v0/0sSFJkPQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352039; c=relaxed/simple;
	bh=/vW9BFyCeBf/E0x1GnYLI/bGQHqhw/HNPM8FoJ0rfWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YOoOtRhjySfaWzdtjZX8j6s8K3v5aIzt/gXjXBbYGpmOq/mUKSICUh9kkJ+lcUofivMlPnNp9vX8fvaR26ntXo04ZE1JZnVbXNy0h6woGMHrm+Ni/YDdAEAocWtbNQLZ8yQK539Xk8JnAfAc/swdVP3Eq35szOa7miw4EPQHnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oL01pJSj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508CbkYX023713;
	Wed, 8 Jan 2025 16:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g9Fr1g
	ZmerZJuGXf+hkfDSb8Fzuz3WFhasG8eMIdHkI=; b=oL01pJSjrgH6A6r4NhvE2M
	8lO1tjTGSHDKZxSXpNg5cald4RO+ySov+mosmozZ56jH16Dgevbu5Zbf/+R29pJN
	4rjGwTdZMhilKBdKtFLhh6TBws3LH1T0nx8Q7a05RnNonYkZ15jvTh2mueDfrf5z
	pjn3NfWagddTfGWXORThPGtE0euY9F9uG++9jrG77/1f8DezEwDhoyW9KcxWN1en
	cngSC+ZrXLC9buJ9F4Htd5nolk4T6gqnRO7XqvOCzsCgcxajiHZ9J87pmFf/E46p
	hi1MKLALNLxk9nMUxXZgiK3tDfXTeNiMIRTdw990fww/q5AaXFATOr6g6/TJYusw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441edj3w25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:00:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508Fss1h008409;
	Wed, 8 Jan 2025 16:00:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441edj3w1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:00:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508DcBFc015805;
	Wed, 8 Jan 2025 16:00:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtm0c56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:00:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508G0Pgq51642750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 16:00:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48FA020040;
	Wed,  8 Jan 2025 16:00:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00F7D20043;
	Wed,  8 Jan 2025 16:00:25 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 16:00:24 +0000 (GMT)
Message-ID: <3ff078e0-150d-41ba-b705-a8e0365f0370@linux.ibm.com>
Date: Wed, 8 Jan 2025 17:00:24 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
Content-Language: en-US
To: Halil Pasic <pasic@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, PASIC@de.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
 <1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
 <20250107203218.5787acb4.pasic@linux.ibm.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250107203218.5787acb4.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -x3hI8enyqFPFYlWh1vcXcVOdaARsJgP
X-Proofpoint-ORIG-GUID: TECXFht49hh3LsFWIDEL0j2OJWE0IQ2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080133



On 07.01.25 20:32, Halil Pasic wrote:
> On Tue, 7 Jan 2025 09:44:30 +0100
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
>> On 12/27/24 5:04 AM, Guangguan Wang wrote:
...
>>> The command 'smc_pnet -a -I <ethx> <pnetid>' will add <pnetid>
>>> to the pnetid table and will attach the <pnetid> to net device
>>> whose name is <ethx>. But When do SMCR by <ethx>, in function
>>> smc_pnet_find_roce_by_pnetid, it will use <ethx>'s base ndev's
>>> pnetid to match rdma device, not <ethx>'s pnetid. The asymmetric
>>> use of the pnetid seems weird. Sometimes it is difficult to know
>>> the hierarchy of net device what may make it difficult to configure
>>> the pnetid and to use the pnetid. Looking into the history of
>>> commit, it was the commit 890a2cb4a966 ("net/smc: rework pnet table")
>>> that changes the ndev from the <ethx> to the <ethx>'s base ndev
>>> when finding pnetid by pnetid table. It seems a mistake.
>>>
>>> This patch changes the ndev back to the <ethx> when finding pnetid
>>> by pnetid table.
>>>
>>> Fixes: 890a2cb4a966 ("net/smc: rework pnet table")
>>> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>  
>>
>> If I read correctly, this will break existing applications using the
>> lookup schema introduced by the blamed commit - which is not very
>> recent.


I agree that this patch may break existing applications or existing
configuration automation scripts.

...
> PNETID stands for "Physical Network Identifier" and the idea is that iff
> two ports are connected to the same physical network then they should
> have the same PNETID. And on s390 PNETID can come and often is comming
> "from the hardware". 
...


HW pnetids (smc_pnetid_by_dev_port()) are only visible at the base netdevice.
It seems that the pnetid table, managed by the smc_pnet tool, tries to mimick
that behaviour, and the concept (recommendation?) would be to set the 
user-defined pnetid also for the base netdevice and then use the upper
level netdevices for the tcp connection. Which makes some sense, 
all upper level devices have the same connectivity as the base device.

So this patch would break a setup that follows this concept and only sets the 
pnetid at the base netdevice.


Optionally you can set a user-defined pnetid on upper level devices (maybe for
usability??), but as Guangguan noticed, that has no practical impact.
In the documentation I see examples where the same pnetid is set for upper
and base device. 
You cannot set a user-defined pnetid on a upper level device, if the base
device has a HW pnetid (smc_pnet_add_eth()) which makes some sense,
not even the same pnetid (makes less sense IMO).
However you can set different user-defined pnetids on the upper netdevices
and the base device, which makes no sense to me.

>>
>> Perhaps for a net patch would be better to support both lookup schemas
>> i.e.
>>
>> 	(smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid) ||
>> 	 smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid))
>>
>> ?

This may yield undesirable results, if base pnetid and upper pnetid differ..
But then maybe GIGO?


... 
> BTW to implement the logic proposed by you Paolo, as understood by me,
> we would have to use "&&" instead of "||". 
+1


Another idea may be to change the setting of a user-defined pnetid
on an upper level netdevice to
- fail if the base netdevice has a different pnetid
- set the pnetid of the base device , if it is currently unset.











