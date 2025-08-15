Return-Path: <linux-rdma+bounces-12771-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F34B27FAA
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561AD189F67A
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BD23009EE;
	Fri, 15 Aug 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eoKdn4S/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD605B640;
	Fri, 15 Aug 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259205; cv=none; b=r38uPL3YN/XSOJoKCXeLPZGbYN9GDeuL5b9wWi+uqMd83xSYe4d3fUuzziDD5CZ0Z//aIwIhpWM1s6G9ArMVSZI5m907p/f55CwfAxHwT/QmQHaPseGlcU5tkNvR+jLuFn3FurKWmz1VQxb5nxr9oRHKlfb9ab82syKI9k6evJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259205; c=relaxed/simple;
	bh=IKdYg2KJS4elXGPTvScy73lA6uhQM7HbLz3SmXwdXBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CohaDhnghbEtotP7XxKwBmUwXzT2TFZraVv5yI/WvKa3m75+fBbaOvKhH+qn88MiSjZAdqe7ECltvRDG8GPLM1Fu0/4Gd5pAGYvZD5eVEXJcY7XU3gvN9bDpgsbkUBvsjkGm5EiXEjzQnl9nbP1sHoY/lrTI1/IFhyEcrE8vPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eoKdn4S/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ENUjjc018664;
	Fri, 15 Aug 2025 11:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mXU5Pp
	VW86ZARpgiSzQjclIjpoFMLOlVM4kwtmyxvmc=; b=eoKdn4S/iz7DD3Ke82WyHC
	X4VcfiSqSUesQi3MgTrXLe+lQZieVfwG4tr5nPRWdjM2zeL18M/I3ItXsbkr984p
	jj7VuPIj4Xe/mC6H/CjoJUXt6YxewaszIdRokjNuVb9FvrYkMO6rLR9ZgNr5NNx8
	jg2iH5043208adsstiloXIR35CJ59++O4qx9G2qXq9AsN3kERIOiNbzQcOTVA8OK
	fdQwdORFpsFdgJJsPMxYsDTN+oahX/QQI9HcpWkfmcsOhI7VxHjxgoPkAGZzzUYp
	aWOI7iRM5d3tsdy/kO14VMcpxWRpS/BZkND9p/hgulOPzlKn8CyOq1DyeCku8Uyg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48gypeh55s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 11:59:56 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57FBvFin025425;
	Fri, 15 Aug 2025 11:59:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48gypeh55q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 11:59:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57FALIM2010657;
	Fri, 15 Aug 2025 11:59:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnv0xe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 11:59:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57FBxo5554264134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 11:59:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A434920043;
	Fri, 15 Aug 2025 11:59:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25A1020040;
	Fri, 15 Aug 2025 11:59:50 +0000 (GMT)
Received: from [9.111.139.98] (unknown [9.111.139.98])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Aug 2025 11:59:50 +0000 (GMT)
Message-ID: <88d261d1-b1fe-447f-a928-02dec6141b0b@linux.ibm.com>
Date: Fri, 15 Aug 2025 13:59:49 +0200
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
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <aJ6TsutbywkTLWxO@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eaU9f6EH c=1 sm=1 tr=0 ts=689f213c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=UXmhFyH_Ja1RVgvJcCoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EbyEFtNgKaNCmSSOl4KfF5ONZ25AU6Qj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE2NyBTYWx0ZWRfX1f6RgSeChbgE
 Y6Qp8E09PNTzQFjbOcw3OyVS/Kimv3oQvL6th2fBZKJLCpj32rJ+t2HuWsSMKfci5Ez2AcdcIyI
 T+AKGmeuPLKrwiqOUYo5pFWfAs6Ga9PGOYevV3hp8ik8Zj8wbDJyCUnbdm4Ft9Y8caVN8LxcWQD
 xBpWW4zvNak/Jf7+LQbsMyvAqDjDvj82anVbiqM7XjOYKO3+GjGsUyrsxJfWOCUvpmhC/KUWCu+
 C5xnGFH0Lz//gKjtRc/MgGgMfesB74G5grmMiwI8Op14OQhHXb/ddIB4gYgoaDtBbbq47jZNJpH
 fZMTJZ1CadALYEDG+bg9DqWD4Yad+Vk/2bMfW5rLtBkbyr4UJd8vtD97lOqT5SZ0OTIXUN0X0OH
 PZAljSjU
X-Proofpoint-ORIG-GUID: Bx52oVEf8BV3iVwfcr_JMs9aZmnd9cKf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508130167



On 15.08.25 03:56, Dust Li wrote:
> On 2025-08-14 10:51:27, Alexandra Winter wrote:
>>
>> On 06.08.25 17:41, Alexandra Winter wrote:
>> [...]
>>> Replace smcd->ops->get_dev(smcd) by dibs_get_dev().
>>>
>> Looking at the resulting code, I don't really like this concept of a *_get_dev() function,
>> that does not call get_device().
>> I plan to replace that by using dibs->dev directly in the next version.
> May I ask why? Because of the function name ? If so, maybe we can change the name.

Yes the name. Especially, as it is often used as argument for get_device() or put_device().
Eventually I would like to provide dibs_get_dev()/dibs_put_dev() that actually
do refcounting.
And then I thought defining dibs_read_dev() is not helping readability.

> 
> While I don't have a strong preference either way, I personally favor
> hiding the members of the dibs_dev structure from the upper layer. In my
> opinion, it would be better to avoid direct access to dibs members from
> upper layers and instead provide dedicated interface functions.
> 
> For example, I even think we should not expose dibs->ops->xxx directly
> to the SMC layer. Encapsulating such details would improve modularity
> and maintainability. Just like what IB subsystem has done before :)
> 
> For example:
> # git grep dibs net/smc
> [...]
> net/smc/smc_ism.c:      return dibs->ops->query_remote_gid(dibs, &ism_rgid, vlan_id ? 1 : 0,
> net/smc/smc_ism.c:      return smcd->dibs->ops->get_fabric_id(smcd->dibs);
> net/smc/smc_ism.c:      if (!smcd->dibs->ops->add_vlan_id)
> net/smc/smc_ism.c:      if (smcd->dibs->ops->add_vlan_id(smcd->dibs, vlanid)) {
> net/smc/smc_ism.c:      if (!smcd->dibs->ops->del_vlan_id)
> net/smc/smc_ism.c:      if (smcd->dibs->ops->del_vlan_id(smcd->dibs, vlanid))
> [...]
> 
> Best regards,
> Dust


I see your point and I remember you brought that up in your review of
[RFC net-next 0/7] Provide an ism layer
already.

I tried to keep this series to a meaningful minimum, which is a tradeoff.
If possible, I just wanted to move code around and add the dibs layer
in-between. There are several areas where I would like to see even more
de-coupling. eg.:
- handle_irq(): Clients should not run in interrupt context,
  a receive_data() callback function would be better.
- The device drivers should not loop through the client array
- dibs_dev_op.*_dmb() functions reveal unnecessary details of the
  internal dmb struct to the clients
- ...

So instead of adding a set of 1:1 caller functions / interface functions
for dibs_dev_ops and dibs_client_ops now, I would like to propose to work
on further decoupling devices and clients by adding more abstractions that
bring benefit. And then replace the remaining calls to ops by 1:1 caller
functions. Does that make sense? Or does anybody feel strongly that I need
to provide interface functions now?

BTW, there are some client-only functions and some device-driver-only functions
in dibs.h already. So that is the direction.






