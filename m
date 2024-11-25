Return-Path: <linux-rdma+bounces-6089-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F069D85C9
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 14:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54955289ED7
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 13:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299D1A01C3;
	Mon, 25 Nov 2024 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qLziXjxK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B44376E0;
	Mon, 25 Nov 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539749; cv=none; b=MVdmm7EuwGw4rQM4QuKUv8uaj5bDe2QsW/aE9qul69Zq7xHwHNJbeasTDuh7DY8HZZ/ZYS+F456v1Ru6vqDtbMVVB94VLzyRkgEzIPcBTyPePLK3j+VPOSt/CFtJUARRueGqFexDebwMWfkjeQXdl0ZC9liDkHnHAGUuYSnOe64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539749; c=relaxed/simple;
	bh=IKAUGzVhMRG7sbxxdIaa5SSnMTsRvrH8Jq+dGv7hW0k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BAu4FdV7okN4QRqmEgxpxEMe5U5Kv+zyQ71t5uBFzNcxU2AvhpTWz1H+RpBLtfOepDIEDbrdRilwquSLaPwymRdIUkbNUFzL1BduF9mWcZWeIioGS2ITyAeMXrNfRzd8hwX5D+sld3ppXhsuSmwIvZa1x4ModPFkMaH8TR7bYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qLziXjxK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APAliSM020640;
	Mon, 25 Nov 2024 13:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qwkzqT
	DFIdx35D0n4bqjo1ZFG+3dBMMzXca1LgnNCn4=; b=qLziXjxK913V6Q/Rsmzxq5
	qyGCiy53MQ3r4f2KAHOoFMFqHEQ8QUHJJ96zDiyrMa2DqumqJMi5sylgTxhvycOr
	a08Xq8SLp0NHh5TRuzjsKkfIhI6vYCN7PUKH2bCqgQIgA8uHx0HfmohDQzPOdrf2
	kZU1zHy5ZprLrwqHO5w5i44fzmHsG6PWZpvMIcFHq7cjfWeEZQkj5gYikJ96NRwv
	IeDNJ1gRokSAo/+nAn92RVOH5XwAutYsLcCPovE9cil4nWfzEi/RNJg5GmyvFPsu
	wjVfze9WudAXrJpTSmh6p7So5I9auoCR1tfxecxtcrL2SsufX0iiOcHyY7ZX8WeA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4338a787pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 13:02:16 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4APD2GSv031328;
	Mon, 25 Nov 2024 13:02:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4338a787pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 13:02:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP60LjA026326;
	Mon, 25 Nov 2024 13:02:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30tcyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 13:02:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4APD2Bb658458554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 13:02:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D7F820043;
	Mon, 25 Nov 2024 13:02:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E1C120040;
	Mon, 25 Nov 2024 13:02:10 +0000 (GMT)
Received: from [9.152.224.73] (unknown [9.152.224.73])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Nov 2024 13:02:09 +0000 (GMT)
Message-ID: <0d62917a-f64e-4be1-95c9-649f1a24d676@linux.ibm.com>
Date: Mon, 25 Nov 2024 14:02:09 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net 2/2] net/smc: fix LGR and link use-after-free issue
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241122071630.63707-1-guwen@linux.alibaba.com>
 <20241122071630.63707-3-guwen@linux.alibaba.com>
 <5688fe46-dda0-4050-ba24-eb5ef573f120@linux.ibm.com>
 <f4eb6ddf-0b44-4fb1-95d3-a8f01be19d8d@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <f4eb6ddf-0b44-4fb1-95d3-a8f01be19d8d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ilNbmAKVXYtkvWq5wRdB1_2H6L7_F7-z
X-Proofpoint-ORIG-GUID: NVYLN0h0O_zFI6ac97d4fJXrIj2PpSZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 mlxlogscore=621 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250111



On 25.11.24 11:00, Wen Gu wrote:
>> I wonder if this can deadlock, when you take lock_sock so far down in the callchain.
>> example:
>>   smc_connect will first take lock_sock(sk) and then mutex_lock(&smc_server_lgr_pending);  (e.g. in smc_connect_ism())
>> wheras
>> smc_listen_work() will take mutex_lock(&smc_server_lgr_pending); and then lock_sock(sk) (in your __smc_conn_abort(,,false))
>>
>> I am not sure whether this can be called on the same socket, but it looks suspicious to me.
>>
> 
> IMHO this two paths can not occur on the same sk.
> 
>>
>> All callers of smc_conn_abort() without socklock seem to originate from smc_listen_work().
>> That makes me think whether smc_listen_work() should do lock_sock(sk) on a higher level.
>>
> 
> Yes, I also think about this question, I guess it is because the new smc sock will be
> accepted by userspace only after smc_listen_work() is completed. Before that, no userspace
> operation occurs synchronously with it, so it is not protected by sock lock. But I am not
> sure if there are other reasons, so I did not aggressively protect the entire smc_listen_work
> with sock lock, but chose a conservative approach.
> 
>> Do you have an example which function could collide with smc_listen_work()?
>> i.e. have you found a way to reproduce this?
>>
> 
> We discovered this during our fault injection testing where the rdma driver was rmmod/insmod
> sporadically during the nginx/wrk 1K connections test.
> 
> e.g.
> 
>    __smc_lgr_terminate            | smc_listen_decline
>    (caused by rmmod mlx5_ib)      | (caused by e.g. reg mr fail)
>    --------------------------------------------------------------
>    lock_sock                      |
>    smc_conn_kill                  | smc_conn_abort
>     \- smc_conn_free              |  \- smc_conn_free
>    release_sock                   |


Thank you for the explanations. So the most suspicious scenario is
smc_listen_work() colliding with 
 __smc_lgr_terminate() -> smc_conn_kill() of the conn and smc socket that is just under 
construction by smc_listen_work() (without socklock).

I am wondering, if other parts of smc_listen_work() are allowed to run in parallel
with smc_conn_kill() of this smc socket??

My impression would be that the whole smc_listen_work() should be protected against
smc_conn_kill(), not only smc_conn_free.






