Return-Path: <linux-rdma+bounces-13366-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A50B57514
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 11:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D6F188B927
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43932FA0F1;
	Mon, 15 Sep 2025 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S5pwPs6j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A32FA0C6;
	Mon, 15 Sep 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929470; cv=none; b=KpqrrAmImNGreczFx7lXeqaK6mB1RQXOpjtzkzMW8fxtcXpxgjXNN30k5fnmPnb9jwG78xgWbg6GbhNywjeP5dIm+bBwt7C4kCj62iGSskuEXqCUCntWmAk35MUMqsO26vpLvMifF63ebw+/WDAjdtBc42Qf7MnV/bjvQcAa9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929470; c=relaxed/simple;
	bh=11q686ArBfmEY572VgZq1ghiEqqgs5Vx8NlQeFXzoxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNaevfDHJ7/bTzbKc/t3eHk7cpa5JV+OeJxZEF3KWdc6BRiqxrAfYhs8gdN4bm+swS+25QDoh/9jm0pupZwq2IJnwmzJsddJhEwTpFkuObQ4ElsxT38TXYqDoMpbXPyP+QnqQVcbuwvoPIjTVaIHQMtFDqoWYRilmLaK1EOHS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S5pwPs6j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F9P9cr020641;
	Mon, 15 Sep 2025 09:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Gg1b5L
	SWKiN/P4t7UpthEMIHa8kpFI9w0gNmlYDQvPI=; b=S5pwPs6jJGg8N/dheNKnAP
	yY2L+VmQ4LisaPEWiq7M+8t8gEjryrb0EEZXV07NAyCtRyhW5E1R/k9K0gIAWCMh
	5o5S9ZxBumoEvdv604plTFDrtlcnXgd8mNb1Y4kvc33MlxwFn8ik2yV0uhoBJ6UM
	z/DMGtSWKX3hQzN01tIlkUE8ZoYoFGeJ2gxzF+DdobSpN7jzk0biL4ZyqwtpRpND
	/NVDm+Nmx4nEhHpx9RbaPcWwc6TryDRUaijuasipm/Rko+WKZWz3oICsiaSkXuWv
	kO1NdmTzAZ/iN94qxt4jd53uM62NYEXcSA7fQDBbdTUomRkzO5Z9aZOwRPg+6xMw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g53054y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 09:44:20 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58F9iKsZ001757;
	Mon, 15 Sep 2025 09:44:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496g53054w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 09:44:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58F7pLrS027349;
	Mon, 15 Sep 2025 09:44:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495memwpbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 09:44:19 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58F9iHDb43974968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 09:44:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A96175805D;
	Mon, 15 Sep 2025 09:44:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0240C58043;
	Mon, 15 Sep 2025 09:44:12 +0000 (GMT)
Received: from [9.109.249.37] (unknown [9.109.249.37])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Sep 2025 09:44:11 +0000 (GMT)
Message-ID: <90577486-5f7f-4c62-ae65-07e7808837f4@linux.ibm.com>
Date: Mon, 15 Sep 2025 15:14:10 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/smc: replace strncpy with strscpy for ib_name
To: Leon Romanovsky <leon@kernel.org>
Cc: Kriish Sharma <kriish.sharma2006@gmail.com>, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20250908180913.356632-1-kriish.sharma2006@gmail.com>
 <20250910100100.GM341237@unreal>
 <24ced585-1b7f-4577-9cb5-8d6e60ecb363@linux.ibm.com>
 <20250912090713.GV341237@unreal>
 <947756ad-f9aa-479f-b463-4c97ff23a936@linux.ibm.com>
 <20250915080232.GA9353@unreal>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20250915080232.GA9353@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fp8sVIjxyIBzqqlhMshEetRYZfmsYHih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NiBTYWx0ZWRfX1Te3tzYw/N0R
 AAu1xJ9wnYuigwdMO46568JoUXuypv44BukB0gegLHvcdEH0ww9WOx2J8YGUfoE/hdZPANq4ULk
 r/Cj6jObBglS6wwjrIQpGcl+nOtJ5IieYqu0JR/RFJ1bD2g/Paj/Msit7lG2Y8dACvj4DWK6RKR
 Hkdu+2RtYqb6H1S65Wwe8I1gH2T7gubM/wpZUzJDM4if14lYhJw34PkNi2YfZLrgeUYtgyapezY
 DZAniw8gGMFUYcadSWr1TTqRZjhfZjsoftQSYe15cTXqke+gPCYWb1WIulkCquzeSqoHF5HcZlR
 JuLqLX+9/vQz1ifr5r9d9hUk6AME2YM4F0FM5/R4Y+f8jDqNoYlHR5cgxVS2IRutYtKIxlIUaXm
 ERLmV0bc
X-Proofpoint-ORIG-GUID: JyeIXTmNek62LEYT6cwJl9pVoWOyp8K7
X-Authority-Analysis: v=2.4 cv=UJ7dHDfy c=1 sm=1 tr=0 ts=68c7dff4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=aOSnVeyxNWsu44SIBWkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150086



On 15/09/25 1:32 pm, Leon Romanovsky wrote:
> On Mon, Sep 15, 2025 at 12:24:16PM +0530, Mahanta Jambigi wrote:
>> On 12/09/25 2:37 pm, Leon Romanovsky wrote:
>>> On Fri, Sep 12, 2025 at 01:18:52PM +0530, Mahanta Jambigi wrote:
>>>> On 10/09/25 3:31 pm, Leon Romanovsky wrote:
>>>>>> --- a/net/smc/smc_pnet.c
>>>>>> +++ b/net/smc/smc_pnet.c
>>>>>> @@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
>>>>>>  		return -ENOMEM;
>>>>>>  	new_pe->type = SMC_PNET_IB;
>>>>>>  	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
>>>>>> -	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
>>>>>> +	strscpy(new_pe->ib_name, ib_name);
>>>>>
>>>>> It is worth to mention that caching ib_name is wrong as IB/core provides
>>>>> IB device rename functionality.
>>>>
>>>> In our case we hit this code path where we pass *PCI_ID*
>>>> as the *ib_name* using *smc_pnet* tool(smc_pnet -a <pnet_name> -D
>>>> <PCI_ID>). I believe PCI_ID will not change, so caching it here is fine.
>>>
>>> If I remember, you are reporting that cached ib_name through netlink much later.
>>>
>>> The caching itself is not an issue, but incorrect reported name can be seen as
>>> a wrong thing to do.
>>
>> In what case we can see this incorrect reported name, could you please
>> elaborate.
> 
> Did you open net/smc/smc_pnet.c?

Yes, I have gone through it focusing on *ib_name* usage.

> 
> Everything that uses ib_name in that file is incorrect.
> 
> From glance look:
> 1. smc_pnet_find_ib() returns completely random results if device is
> renamed in parallel.

I agree. Currently we are *not* handling the change of IB device names &
when that happens the cached *ib_name* doesn't match anymore with the
changed ib_name. We are looking into this internally.

