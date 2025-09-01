Return-Path: <linux-rdma+bounces-13018-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBF4B3E39D
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 14:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A72189150D
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BBA1A9F98;
	Mon,  1 Sep 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l2VfeCc3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5F248867;
	Mon,  1 Sep 2025 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730780; cv=none; b=klmvXB5itTR7T1Zo54a9Zpz+wOpIY19T487uAZVs9cyDLIPouB4FwTW6LF4OdtUJ6Z2GvC8n9bJcUMqweEQCeZYEP5HCHavSK5Q7d4FLpef1RHSM52Zv7DSuUc/2qneQ6RCCBBPRbp3FmLy5AjBxFeoSNS3XOTwq3s7e+wapuEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730780; c=relaxed/simple;
	bh=Cbv0gWoqwae7AeVK7MiNN7u+xqTrocmXivSmGnvSU20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuRUj5YhIwnV1gs5fZ3oxGcqo9rAu/hu/Jk7UPqVYwIMpWdSsFCdkWPJT4Gryjtp69glCsd0mo22iqeHhVOdcbLGOtO4xpZG2qiTPG8mjdIxHKRcgR6tZSIRe86OvWm5efoV9Cc5f/jUqa/P6sFZvsdPU/pztxFdEovnNke/+F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l2VfeCc3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 581AGVBC032220;
	Mon, 1 Sep 2025 12:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DzzKRY
	y7a9wvXW1j5JMLDA/gFArO43hoLpaB/3UwABM=; b=l2VfeCc3SfHHBxrJ+NsM4c
	qFgqBjFKyqEcpgrVfrK6A+UlpDZJdwqSs8RcqGM2EBV0Mk33iYSaEa/H9Jd16CZ+
	WexA56UkWGCeWbd9jetEpl2fxeaV+LccwmKRPF3g26mmonWwkNQi3pdmo9Vr/3ua
	k1qoRGCprPKpJKy2KqSe3GuCUflMiZ8zHgmN6PPXNaN9t+KawayPD43WIO52QIpd
	HuCCXEqE8HzYpWnG+NoxFYh3q6CRYbFPwNxunZfhVBjmif7QYAS0/LuOQqQ8SZdZ
	FlfkyapKBGjmobUYeJEs7OmxIyHJjwbWaVZtNOT6FKL7tjSHrLMJWXRc9TvkKvzA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswd109a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 12:46:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 581CF9Pq004621;
	Mon, 1 Sep 2025 12:46:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswd1095-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 12:46:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 581APQf0009444;
	Mon, 1 Sep 2025 12:46:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdum5r4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 12:46:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 581Ck26Z52953498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Sep 2025 12:46:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 821752004B;
	Mon,  1 Sep 2025 12:46:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DF4120040;
	Mon,  1 Sep 2025 12:46:02 +0000 (GMT)
Received: from [9.152.224.94] (unknown [9.152.224.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Sep 2025 12:46:02 +0000 (GMT)
Message-ID: <5dc3e8b1-c3c0-4939-86ca-578496a6efff@linux.ibm.com>
Date: Mon, 1 Sep 2025 14:46:01 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 11/17] net/dibs: Move struct device to dibs_dev
To: dust.li@linux.alibaba.com, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-12-wintera@linux.ibm.com>
 <369a292c-c8c5-4002-a116-f9e1b4a436ba@linux.ibm.com>
 <aJ6TsutbywkTLWxO@linux.alibaba.com>
 <88d261d1-b1fe-447f-a928-02dec6141b0b@linux.ibm.com>
 <aJ9P0WpHU30zpLLt@linux.alibaba.com>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aJ9P0WpHU30zpLLt@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68b59590 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HSMQ4e0wTt4aXWmFOsEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfXw7BQs49XKj7T
 BcHs/fkepYYlyYCgabqIZumr3M+jIplRzHuszwsR9jwJih/3dED+K06t4YTQEzq2Ph3q96478No
 UNTSVkrYjhR+IID049c4r8LAVkvqdj/H1ruA+x+JGxa/sw92cXW69ZaydWm95AzyQkVibozRFHg
 5+c0O+cp+GR4ot2o0beWV6zBbfceACtVZB6DnKy8P5tKPyDA8dSQQvqJK33vRDtIeGU+puJTOMf
 jUmzXEOlRnmgQkbX64IUfZFx3HFd8qtZFB21pmmkUpwjqKeib9FpYv4d9CvpwcCDqlL80uyMX4Z
 DWrSAfZD97D4UpjPTtAPcSmhDfpo57OqQXhd4ATfe8wovHVf2kM+AvAKIJHmQeSvSIZKfw9Rx4c
 mAag78DR
X-Proofpoint-GUID: y8f1VQx9ScBsh_jmnjvwbBi-hojRWDEK
X-Proofpoint-ORIG-GUID: hRgSveRnr_gUBnwVJqSxveJQNrkTnq5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034



On 15.08.25 17:18, Dust Li wrote:
> On 2025-08-15 13:59:49, Alexandra Winter wrote:
>>
>> On 15.08.25 03:56, Dust Li wrote:
>>> On 2025-08-14 10:51:27, Alexandra Winter wrote:
>>>> On 06.08.25 17:41, Alexandra Winter wrote:
>>>> [...]
>>>>> Replace smcd->ops->get_dev(smcd) by dibs_get_dev().
>>>>>
>>>> Looking at the resulting code, I don't really like this concept of a *_get_dev() function,
>>>> that does not call get_device().
>>>> I plan to replace that by using dibs->dev directly in the next version.
>>> May I ask why? Because of the function name ? If so, maybe we can change the name.
>> Yes the name. Especially, as it is often used as argument for get_device() or put_device().
>> Eventually I would like to provide dibs_get_dev()/dibs_put_dev() that actually
>> do refcounting.
>> And then I thought defining dibs_read_dev() is not helping readability.
> I see. I don't like dibs_get_dev() either.
> What about dibs_device_to_dev() or dibs_to_dev() ?
> 
> If we can't agree on a name we’re all happy with, I agree we can
> leave it as is for now.
> 

I'd rather leave it as it is and leave it to future patches to provide
dibs_get_dev()/dibs_put_dev() and maybe also dibs_devname() service functions.

