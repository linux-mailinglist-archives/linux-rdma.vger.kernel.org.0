Return-Path: <linux-rdma+bounces-6386-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7819EB135
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 13:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8AF16AB21
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 12:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491171A705C;
	Tue, 10 Dec 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R7KhVdOL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9060F1CA9C;
	Tue, 10 Dec 2024 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835039; cv=none; b=C3JtSswD/e8HQy/ffiAoHtcogaiN7twbIfABHX+8sqyoNjTrzDl5TcPMTLc2QGIX84PfEIsd76RUbN0PbHSP8RqWZrhDCy9CVhEf5knutp1snO4c+Wyso3xrG+zRxUOlHeTe5rFyphZ8STraUt6Q67WNp+An2fUQ0aVHpotvpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835039; c=relaxed/simple;
	bh=GYQLcEAhQ6W6pV9m+GhI27liQEwXI1x+OSXD1/nKZoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVclKJRJuU4RMXVyUbYDm5+yjlN7TFufhOpWxHGY31SmlBX+Ed3DQicQB8EvXp3W5wUeljc1ElywaJdPU6/nyTx2cpXa1DfWrBUxW1ut788+6ZvUiATRx7jZQP3Jvvs9wxOuk8e/rWX7u1ZUXBp2alp3NOlI59gOuZzxWtdWEe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R7KhVdOL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA0RhFK008981;
	Tue, 10 Dec 2024 12:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wjcrpr
	ZDrqBfXtTyMxM47VP4wyT64eQ6ce6zHS7eT5c=; b=R7KhVdOLwaxkVLCz3rizN1
	ju4U8UW1SEVyu1W1oNX31ivG2VKRS86ZX3G/ntxnlGljk7/0qTahrexjySD0lKW/
	e86FvCQ5+6j+nU3yaEVc3qh15h1TNWzM5YM+mDrT+MwNs2y0c/yrqWNXsHNxAB5L
	KOxIwP4YRBQnhC/arEKcMzNghwzr6nNL1skZNlKparpgrByfZv4Pg7LRUxHsWkCl
	JrjB+426uNCmrHn4Rh9IYaIrG3q+swCRiWs0b7dBoOn+DmsdsjSedzBgsqo5Yon+
	FbLEqKXSH2T2jHV3PYNsLJfB6XUwmdBDT0FcYlikI+BUMgtd7nTOM6/dunIwROFg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xdyp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 12:50:31 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BACWDAt027827;
	Tue, 10 Dec 2024 12:50:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xdynw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 12:50:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BABXEVV018618;
	Tue, 10 Dec 2024 12:50:30 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26kbjc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 12:50:30 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BACoTqi33686042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 12:50:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F1E458045;
	Tue, 10 Dec 2024 12:50:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A72458050;
	Tue, 10 Dec 2024 12:50:26 +0000 (GMT)
Received: from [9.152.224.33] (unknown [9.152.224.33])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 12:50:26 +0000 (GMT)
Message-ID: <5cd2fe0b-81ad-4aa8-b2ca-e127bfe098db@linux.ibm.com>
Date: Tue, 10 Dec 2024 13:50:25 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net/smc: support ipv4 mapped ipv6 addr
 client for smc-r v2
To: Jakub Kicinski <kuba@kernel.org>,
        Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: pasic@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dust Li <dust.li@linux.alibaba.com>
References: <20241209130649.34591-1-guangguan.wang@linux.alibaba.com>
 <20241209130649.34591-3-guangguan.wang@linux.alibaba.com>
 <1fc33d2e-83c1-4651-b761-27188d22fba0@linux.ibm.com>
 <20241209154310.49a092da@kernel.org>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20241209154310.49a092da@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X1_fLldX8R8i6v0CAFoftRAH9vgwd26M
X-Proofpoint-ORIG-GUID: Tp3BdHn5bh8vC20r0cNiJLd5uZTOpZE5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100093



On 10.12.24 00:43, Jakub Kicinski wrote:
> On Mon, 9 Dec 2024 15:10:56 +0100 Wenjia Zhang wrote:
>> @Jakub, could you please give us some more time to verify the issue
>> mentioned above?
> 
> No problem. I'll marked it as Awaiting upstream, please repost when
> ready. This is our usual process when maintainers of a subsystem need
> more time or need to do validation before we merge.
@Guanguan, I saw your answer and the tests result, thank you for the 
effort! It is totally fine to me now to let it go upstream.

@Jakub, thank you for giving us more time! It's verified now. I think 
they can be applied:-)

Thanks,
Wenjia

