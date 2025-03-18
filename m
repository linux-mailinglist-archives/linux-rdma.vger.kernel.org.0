Return-Path: <linux-rdma+bounces-8766-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50480A66EB4
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 09:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBCE57A5896
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 08:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2132054F1;
	Tue, 18 Mar 2025 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Li/Ge4J9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBB85260;
	Tue, 18 Mar 2025 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287417; cv=none; b=p49Vl4NDtmcIsIhgB+rqhlEutuVKvJftrnUw7CyegVgpDmxyP//8Sh9K8H/fuEfFbOeph1O1026nmN4SqXZyojbN8L9FyUgkTjOKmDZOl8U+EWI6lB3Nd1g8r6RWvtqjO2qg6YD8UtYxAi1gD40OuG/VNMUh87CAkLX7yCyJcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287417; c=relaxed/simple;
	bh=KH754ku6E2dn6riHuLG2Tl/CUGkkOyZz5Be4t9cHSi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtPfHLEfZ0bZsISs/mIrSQwpGmLCsWIrMfhPKx3Z4bTnpyeMK3VOdh2/c7gWFmaTt8rIYgAV8TzbGHj1VTsRPNeS9hx2QRzr2d6Ocmw60LrTMiEExIlbYS1uena/2CZLus7l2NHaT+wRMaFfK2k8k6IVylbnC/QHpbn6PTWc6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Li/Ge4J9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52I3jxJm006543;
	Tue, 18 Mar 2025 08:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rWO/e3
	fCk+9WriEZd6j2HIUXVlJLb6hQdjB+4CAAO+E=; b=Li/Ge4J93IAOs4DIhqOPrP
	IUCoKIuogHZTxhMi1ELpgtkcy5NKgGAh778ASNF0WqA+gZBTCf+etyBVUqjUwf9a
	WcNZqYw5xK5YGQSDJR8V7f61pcXhoy5I/nyXFwmNzHXmcHFzcW1LW3hCDVb+H3db
	/9y/E6/RTIl1Y6/N9ZIKzWqplpQ6xmzkqommDskquod6+pqx5JwsRqohtou+YW4E
	XHmoUXm2Dq07q+nP2wsFT2k7iBIG2PL01863v2stE5R/UrDggprj2A2co7KR9WM3
	tu1kVW7PNX6Od15WK+m4Xthbh9T8zzFZvI6G9gh+of6u+xwC5wi9BMnIWVp/o8sw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45f179h6tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 08:43:15 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52I8WehP022315;
	Tue, 18 Mar 2025 08:43:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45f179h6t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 08:43:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52I6Wm7A009577;
	Tue, 18 Mar 2025 08:43:13 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm8yu0q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 08:43:13 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52I8hBlt46006760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 08:43:11 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 775DB58065;
	Tue, 18 Mar 2025 08:43:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A13858063;
	Tue, 18 Mar 2025 08:43:08 +0000 (GMT)
Received: from [9.152.224.242] (unknown [9.152.224.242])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 08:43:07 +0000 (GMT)
Message-ID: <6191739c-93db-4a7d-8e83-3168909315cd@linux.ibm.com>
Date: Tue, 18 Mar 2025 09:43:07 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/smc: Reduce size of smc_wr_tx_tasklet_fn
To: Heiko Carstens <hca@linux.ibm.com>
Cc: I Hsin Cheng <richard120310@gmail.com>, alibuda@linux.alibaba.com,
        jaka@linux.ibm.com, mjambigi@linux.ibm.com, sidraya@linux.ibm.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        jserv@ccns.ncku.edu.tw, linux-kernel-mentees@lists.linux.dev
References: <20250315062516.788528-1-richard120310@gmail.com>
 <66ce34a0-b79d-4ef0-bdd5-982e139571f1@linux.ibm.com>
 <20250317135631.21754E85-hca@linux.ibm.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20250317135631.21754E85-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6v44pa0KgLoAqOmGx7XJlyCOBFAx5lat
X-Proofpoint-ORIG-GUID: Wy0gCRpsD4n60juCJWtHWE-2t6HXUAuq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_04,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180060



On 17.03.25 14:56, Heiko Carstens wrote:
> On Mon, Mar 17, 2025 at 12:22:46PM +0100, Wenjia Zhang wrote:
>>
>>
>> On 15.03.25 07:25, I Hsin Cheng wrote:
>>> The variable "polled" in smc_wr_tx_tasklet_fn is a counter to determine
>>> whether the loop has been executed for the first time. Refactor the type
>>> of "polled" from "int" to "bool" can reduce the size of generated code
>>> size by 12 bytes shown with the test below
>>>
>>> $ ./scripts/bloat-o-meter vmlinux_old vmlinux_new
>>> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-12 (-12)
>>> Function                                     old     new   delta
>>> smc_wr_tx_tasklet_fn                        1076    1064     -12
>>> Total: Before=24795091, After=24795079, chg -0.00%
>>>
>>> In some configuration, the compiler will complain this function for
>>> exceeding 1024 bytes for function stack, this change can at least reduce
>>> the size by 12 bytes within manner.
>>>
>> The code itself looks good. However, I’m curious about the specific
>> situation where the compiler complained. Also, compared to exceeding the
>> function stack limit by 1024 bytes, I don’t see how saving 12 bytes would
>> bring any significant benefit.
> 
> The patch description doesn't make sense: bloat-a-meter prints the _text
> size_ difference of two kernels, which really has nothing to do with
> potential stack size savings.
> 
> If there are any changes in stack size with this patch is unknown; at least
> if you rely only on the patch description.
> 
> You may want to have a look at scripts/stackusage and scripts/stackdelta.

@Heiko, thank you for pointing it out!

Even if the potential stack size saving of 12 bytes were true, I still 
don’t see how it would benefit our code, let alone justify the incorrect 
argument.


