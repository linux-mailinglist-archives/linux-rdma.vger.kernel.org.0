Return-Path: <linux-rdma+bounces-5755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC55C9BC995
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 10:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEB01C22724
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 09:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1556E1D172A;
	Tue,  5 Nov 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S3sYCvXU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF6163;
	Tue,  5 Nov 2024 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800259; cv=none; b=HrC6EG0+vJl8QDTOPyTaTuZBtnobo+w7VY7hcw7pO+ZADCp6p4w7UpGWwRvT5VrxKDYFkIW69aVjKZyRbwuVkz0yp2M9b5Pj1jQVEt+ZwHiXLir4VptbSCyNDwE2HeFhg+IMEpQdNULryauvop5HI1ae9a/VbJJ86ud60YgkG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800259; c=relaxed/simple;
	bh=vMqJn3LIO8ynjc5nIbPp+GYEWMReEyHxTENEDq18gK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEl1sXN6XoBysPlgW24IWiRAvHiM2x4RdKx1/BOXIe1t9uNVVpXaBmmvJEShJJ8kJRUW5RkRh/ufo3YC7GqAHb0JLAEABPxHApgByyc4pVTGhkrdUEoqd5CLQ1sG5xM2jRJykEh34Jh1CkqqHCeHFqGYC47OpPk65jS+wPhpaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S3sYCvXU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A59eMWk003268;
	Tue, 5 Nov 2024 09:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VYIFae
	SthkHPV5g2knlHMhPmFXVciGu5V8c06srw6S0=; b=S3sYCvXUl2TBvFjpvEwlGz
	aR/HiPzWsaZoEOOzoANEJSdUxShveYakNl0y25CrZ2XGDUYrwigxS3pQeGkPkVGl
	t58DmmO/kqNKBQUnI8D212KGFmLLonBUKXmic7OiPIkTnG741p0lvIR2arL9bQpb
	QHWgy6kF5EhELAjXpjhVbQeL6VCgxhsT5sPuNUy+jaXBmQMQ4zw9WZ9lz8/Pe5XN
	RI37MpNConP8nQ8xkqnFxqbPr1tvkuVErWXOasZDDK6jagxXpoDm5okihcsyCPhN
	Ui1Yy0a0o0Ml6lCNssU9RbGqNmabZJIKdYbvqOtcoo6a7Jn14VHlariB7HrpEwUw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qgx6r1ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 09:50:52 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A59opOE031661;
	Tue, 5 Nov 2024 09:50:51 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qgx6r1r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 09:50:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A59P7pW023983;
	Tue, 5 Nov 2024 09:50:51 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsy71bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 09:50:51 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A59oo4p49545710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Nov 2024 09:50:50 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEBE858059;
	Tue,  5 Nov 2024 09:50:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BF0358058;
	Tue,  5 Nov 2024 09:50:46 +0000 (GMT)
Received: from [9.152.224.138] (unknown [9.152.224.138])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Nov 2024 09:50:46 +0000 (GMT)
Message-ID: <8d17b403-aefa-4f36-a913-7ace41cf2551@linux.ibm.com>
Date: Tue, 5 Nov 2024 10:50:45 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
To: Leon Romanovsky <leon@kernel.org>
Cc: Wen Gu <guwen@linux.alibaba.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Nils Hoppmann <niho@linux.ibm.com>,
        Niklas Schnell <schnelle@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
 <20241027201857.GA1615717@unreal>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241027201857.GA1615717@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: an7cTprGdqKQmVMebW909_n9iSmceV-B
X-Proofpoint-GUID: fOR5dMNMMurYWr33APtl7L9tL0IqforV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 impostorscore=0 mlxlogscore=916
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050071



On 27.10.24 21:18, Leon Romanovsky wrote:
> On Fri, Oct 25, 2024 at 09:23:55AM +0200, Wenjia Zhang wrote:
>> Commit c2261dd76b54 ("RDMA/device: Add ib_device_set_netdev() as an
>> alternative to get_netdev") introduced an API ib_device_get_netdev.
>> The SMC-R variant of the SMC protocol continued to use the old API
>> ib_device_ops.get_netdev() to lookup netdev.
> 
> I would say that calls to ibdev ops from ULPs was never been right
> thing to do. The ib_device_set_netdev() was introduced for the drivers.
> 
> So the whole commit message is not accurate and better to be rewritten.
> 
>> As this commit 8d159eb2117b
>> ("RDMA/mlx5: Use IB set_netdev and get_netdev functions") removed the
>> get_netdev callback from mlx5_ib_dev_common_roce_ops, calling
>> ib_device_ops.get_netdev didn't work any more at least by using a mlx5
>> device driver.
> 
> It is not a correct statement too. All modern drivers (for last 5 years)
> don't have that .get_netdev() ops, so it is not mlx5 specific, but another
> justification to say that SMC-R was doing it wrong.
> 
>> Thus, using ib_device_set_netdev() now became mandatory.
> 
> ib_device_set_netdev() is mandatory for the drivers, it is nothing to do
> with ULPs.
> 
>>
>> Replace ib_device_ops.get_netdev() with ib_device_get_netdev().
> 
> It is too late for me to do proper review for today, but I would say
> that it is worth to pay attention to multiple dev_put() calls in the
> functions around the ib_device_get_netdev().
> 
>>
>> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
>> Fixes: 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev functions")
> 
> It is not related to this change Fixes line.
> 

Hi Leon,

Thank you for the review! I agree that SMC could do better. However, we 
should fix it and give enough information and reference on the changes, 
since the code has already existed and didn't work with the old way. I 
can rewrite the commit message.

What about:
"
The SMC-R variant of the SMC protocol still called 
ib_device_ops.get_netdev() to lookup netdev. As we used mlx5 device 
driver to run SMC-R, it failed to find a device, because in mlx5_ib the 
internal net device management for retrieving net devices was replaced 
by a common interface ib_device_get_netdev() in commit 8d159eb2117b 
("RDMA/mlx5: Use IB set_netdev and get_netdev functions"). Thus, replace 
ib_device_ops.get_netdev() with ib_device_get_netdev() in SMC.
"

Thanks,
Wenjia

