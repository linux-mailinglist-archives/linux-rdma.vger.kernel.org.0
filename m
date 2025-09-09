Return-Path: <linux-rdma+bounces-13202-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DACB7B4FA84
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 14:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5224422C9
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 12:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5603B32C31B;
	Tue,  9 Sep 2025 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lkAdWZpM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B14321F40;
	Tue,  9 Sep 2025 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420336; cv=none; b=aOKjwv0iDAKWmcTOkV4x1jjtZWtxoZ95m7YXBshxQIxXIHKIhmI10TtMq2XVeAqDi1huS3m30MeGJ1ZXyKjbWnTQC7R6RCFPA1AoomST380DCk7MrVDm1qeY9V/pOCa3JD5IpXpWNXdPNVV77RdWjJ1aGUK2yGbHE6yIe1Up+5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420336; c=relaxed/simple;
	bh=wyk8vcKq8SkKk0WU9NXoJpFQbnSbaxYmpIXLtMSefJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBQE7GQWHawRrVqww+lkGXtUCZa3fVP6v/bNRCM/Fe3nsQGhJvxTE5eC5lOsLai9QnfvfDc+jYccBoiFz/20Tp8hSK0B6N3tezED5qtzs/xpqkLlwE4r3BQ75NG2dl4FcprfaPiFpm9iELw0KsfLsR6+ksDv1GmokfgAbOXgw8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lkAdWZpM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58977BEV030854;
	Tue, 9 Sep 2025 12:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1kYWlR
	K6XrnW2KOZCDNXOBfM2bJ+9fL/yDboVZ1h7FU=; b=lkAdWZpMnc9ytktUx4CLth
	PEB8elzMDWUEn/hoU4f9BrWyuhclTSeaMTL5LlcbT9AqwoqakLBQmTC3RYD6sr2/
	io8e5srxPJ01gIGGuyPOKPmQpZuz/g0wyX6uUj4/snzccx8CreDPNCsvgtShGKeb
	E8uKOR3AsGaBM1u7XspEuVYLKGvs/XRYT+T1xHeTZUGiSY7VtuKRVQQ1LnatDVDd
	aTUooZblJCLLM0TmZnqyyTc3QZx2iDLtIyWkxFTNtaED2VOO4Fjydd0YFKkbaKVX
	x6PTLOFpLFXRe1pFEzlRqNqjaGuDkwe/bcBkh1/CTs0RGnR4L3JMHLU64cyr7Cjg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycvh9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:18:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 589CFDva008861;
	Tue, 9 Sep 2025 12:18:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycvh9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:18:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5899v8fX007982;
	Tue, 9 Sep 2025 12:18:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pk2fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 12:18:45 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589CIimd27066954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 12:18:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 107215805C;
	Tue,  9 Sep 2025 12:18:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0E4B58051;
	Tue,  9 Sep 2025 12:18:38 +0000 (GMT)
Received: from [9.124.223.138] (unknown [9.124.223.138])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 12:18:38 +0000 (GMT)
Message-ID: <5c122f38-1ff4-4e24-a123-3a4766206f5c@linux.ibm.com>
Date: Tue, 9 Sep 2025 17:48:37 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Remove unused argument from 2 SMC functions
To: dust.li@linux.alibaba.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alibuda@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250909071145.2440407-1-mjambigi@linux.ibm.com>
 <aMAR8q4mc3Lhkovw@linux.alibaba.com>
 <8bc987c9-a79d-42ec-8279-da8b407cfd2c@linux.ibm.com>
 <aMAaH7oQz-FM96sv@linux.alibaba.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <aMAaH7oQz-FM96sv@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2QunrHo6fOiqIvkJpjKGaaus590-ONzL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfXxPKqro4e7pnI
 035Ii7XVxgYV12/CfywoZPtXtg9Jt/GI0WB/rESf7KJspiw4aM3ypZ3QrZjqWXhQyvuCFGv2Wvm
 0aZIOhZb8ugbDjk0ZVuow+H28ILjj34V02jfDuVslJyrSRZoIYpclvW/LLw97w6O2DcfkMTdpU3
 tUkRlPwYPre7kXFywpik1Hp8y1RimbtsEoSMJNidvnNO0wKE72HM/N3D85dHHcJdXKr5QsprP6T
 melfnQiQKLvj05sSN0xGOu6q6kmTDD6ooXv2GcCSMZyKRsF9eIYWVvNraRgwrMtFfOJ0pJogoLf
 HoJ3aX20B1ge+vmETaVXt7UJZ70NoBU9CpFwdcN+Md0zq1tuOVlgMDl2G7nyhqN9tPdOLAl7QMu
 AQzB1Df0
X-Proofpoint-GUID: IQX5mC8J3qj-_PtKFewESur_33UrrxDM
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c01b27 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=_qYudFDEZN9pNWPccbYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

On 09/09/25 5:44 pm, Dust Li wrote:
> 
> Yes, I think it should remove the Fixes tag and go to net-next.

Sure. I'll do it in v2!

> 
> Best regards,
> Dust
> 


