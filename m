Return-Path: <linux-rdma+bounces-12631-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACA1B1EE6C
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Aug 2025 20:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306651C24D02
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Aug 2025 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0431FFC46;
	Fri,  8 Aug 2025 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YkrsW4bi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4E1DA3D;
	Fri,  8 Aug 2025 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754678192; cv=none; b=MuSxPIG7+Ea6FCYoBoGFK8+8pVxgB5mPGLfw5jab6qkcv+kJBaCMusPL+Yg7rsiPJs/lVKFCimxFywy08sScJad3z1sD1VjBKIG9JfcRYt6swAqlmW0ou7BAYbOaw+OnrsIa0t/CKfouNlNUJSOPgrIPqGAZKZ6YoKeIuUvX6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754678192; c=relaxed/simple;
	bh=0GF2ljKEjQ491gKMnoqBJKgzgyQa8GhapbLk9wLShKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jx8qg0ktmE/QM49rTu4Vk0Ceu7j8NNIudB/0cQ1ZmRM/uhth5ZOM6nclEkvHnwGMVMvh4CKkQ9aLNw2EgbjIAkA4jV4DOjfkGF32vqdeyQyebzDnbrCgDqYBSKKO0bG74EUcDBWjpvh0tWKQk+3UNBBL6t9c3/A+09Pmi5qYIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YkrsW4bi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578HWTbF014430;
	Fri, 8 Aug 2025 18:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ElguPr
	EmC2Gv+xO8Bcq14qmS927rjAXW2jcbrSh3788=; b=YkrsW4bi5jeMVvk81EUOtU
	a4i9yTA/giM7SaHYSNeGwt7YggPuSefwEVjqH6qqQKMbax8byiZ24MkvSSJslejN
	2lGH5/HVyfcQyuo5LVHl+h/aqs97Tk0a9p7pFUaoM3RI42jG8JIs8r5kfXQ88WkE
	Md5sfSdVlYN9YcF8CrGjz2kyl5MUaGU1yM3WvNwyLvCPylbxx04lAudgcEFBWaho
	Hy21SCkHpFEnfRnOXwI7mF739jTxVmPX0MOtldMxCuU8by1sdxDuYuWiZMNeb31H
	uINedH5DIL273cPmuHnjCrq7wdQSSrIrVqATtsg4aiRomwuV2FMfOgCgJL+LPMiQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq61a8jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 18:36:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578IUbTp028937;
	Fri, 8 Aug 2025 18:36:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq61a8jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 18:36:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578F0qSq020616;
	Fri, 8 Aug 2025 18:36:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwn6vx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 18:36:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 578IaH9u52822286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 18:36:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46F8D20043;
	Fri,  8 Aug 2025 18:36:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C34C220040;
	Fri,  8 Aug 2025 18:36:16 +0000 (GMT)
Received: from [9.111.169.241] (unknown [9.111.169.241])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Aug 2025 18:36:16 +0000 (GMT)
Message-ID: <39c63e1d-0fec-47f8-8847-4b9402b97325@linux.ibm.com>
Date: Fri, 8 Aug 2025 20:36:16 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 08/17] net/dibs: Register ism as dibs device
To: Simon Horman <horms@kernel.org>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond
 <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-9-wintera@linux.ibm.com>
 <20250807163700.GL61519@horms.kernel.org>
 <20250807181934.GM61519@horms.kernel.org>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20250807181934.GM61519@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dwHmZjXJqnRup2aKOS8uBmHkomFu7yYU
X-Proofpoint-ORIG-GUID: N4FKWOqUFgF6SWT92P9yPcMolbKrBbyz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE0OSBTYWx0ZWRfX45Zz20vBYnqw
 WduIZM4xZk6ohI6d5vOqG2f49Id/cGY9PTwZB88VL5zUOpDCIEfE4rLTQk4eObuh6Lab6B828bL
 8aJVaaZObH2piuT9NRpJr5JBEvQwSA61YAOcDFoOreblK2/rlIhHsSfLA5iOtyXwEaTPGzu7rhs
 1o13FAKZfCUlDlRzq5p4sK3eSxk99PuGwQTB8zvt7uxQTlWuZ6pSDy2LEieHbDdCHDZMrDj9oZl
 CIsICUnC6yfZrhl/mmqGlW5jYHT9wpHTESeRnGgo/04CnGcDH1HINq6LiogooRwdvr13dEfOMuU
 paV40cw6fmtJbWaF2aNjhUK9tKZusy8A7xPS7VcKoboNJPUmhu5vZL2ZoCy50TBijnXK2lZi+hn
 KWtW6FO/B6oHueDjjh4ZtFD6taFHQ+WEm8DoTZ+MlhEh6j9ebB0L6HrAq+Jatoj0X7qL3ljP
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=689643a7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8
 a=VwzbkYuV4N9bOHfolB0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=719 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508080149



On 07.08.25 20:19, Simon Horman wrote:
> On Thu, Aug 07, 2025 at 05:37:00PM +0100, Simon Horman wrote:
>> On Wed, Aug 06, 2025 at 05:41:13PM +0200, Alexandra Winter wrote:
>>> Register ism devices with the dibs layer. Follow-on patches will move
>>> functionality to the dibs layer.
>>>
>>> As DIBS is only a shim layer without any dependencies, we can depend ISM
>>> on DIBS without adding indirect dependencies. A follow-on patch will
>>> remove implication of SMC by ISM.
>>>
>>> Define struct dibs_dev. Follow-on patches will move more content into
>>> dibs_dev.  The goal of follow-on patches is that ism_dev will only
>>> contain fields that are special for this device driver. The same concept
>>> will apply to other dibs device drivers.
>>>
>>> Define dibs_dev_alloc(), dibs_dev_add() and dibs_dev_del() to be called
>>> by dibs device drivers and call them from ism_drv.c
>>> Use ism_dev.dibs for a pointer to dibs_dev.
>>>
>>> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
>>
>> ...
>>
>>> diff --git a/net/dibs/dibs_main.c b/net/dibs/dibs_main.c
>>
>> ...
>>
>>> @@ -56,6 +65,33 @@ int dibs_unregister_client(struct dibs_client *client)
>>>  }
>>>  EXPORT_SYMBOL_GPL(dibs_unregister_client);
>>>  
>>> +struct dibs_dev *dibs_dev_alloc(void)
>>> +{
>>> +	struct dibs_dev *dibs;
>>> +
>>> +	dibs = kzalloc(sizeof(*dibs), GFP_KERNEL);
>>
>> Hi Alexandra,
>>
>> It is not the case for x86_64, arm64, or s390 (at least).
>> But for x86_32 and arm (at least) it seems that linux/slab.h should
>> be included in order for kzalloc to be available for compilation.
> 
> Similarly for dibs_loopback.c in the following patch.


Thank you Simon. It will be included in next version.
(I also got notified by kernel test robot <lkp@intel.com> about this).

