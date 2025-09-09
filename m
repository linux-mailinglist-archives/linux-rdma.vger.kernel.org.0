Return-Path: <linux-rdma+bounces-13196-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A157AB4AC94
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 13:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9654E6BFC
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA68B322DA3;
	Tue,  9 Sep 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XyTwht4j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E49321F5F;
	Tue,  9 Sep 2025 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418235; cv=none; b=aokqRtx/tsDnjo7o4Y7W2TUGxnUAG+DIUZaebYfVXmRr2dGlSGnQiUlVRygUbwkYTY8cF/UNqXVlN+79ZSJ1enddTyzF7AuWr0XT4wDT8Wo0pg4GhlgZO8pOd497Gd2h7pfmDvRfhiGftM3MihkEBIR82AUFMxSrJ4Ly9wQhVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418235; c=relaxed/simple;
	bh=QNLvONbgW7trZwwSydjiOMR0HSL3JfRtasB3XPqBLKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6gcvhb+sk8pvj1X1xr4FxasDR+1P5JVpHpqXZum0fWe0X7CtKJnXUsHEzmyvh/orYiwgNjjr+MW+5XiX6Oh3vGFJWMBnCigsXI5bIlc+ZVl9UQJYHjZZzZYuaR7MvAtQD+j7DlLPjU/N5ZMFvq4jjvRKGR2oqo1Kv/UmLw8bEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XyTwht4j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58979YqT006469;
	Tue, 9 Sep 2025 11:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lml3iW
	12NF2VgpHkjOdCj8kMU3oLxxqSLyu+0o8gqms=; b=XyTwht4jnc043GWcPdeIYy
	Vh705GWKPgW9ySUvtA8oQVqOV12PKmpb7cLjzhysgpnuDA82XnEbIdxkiJ2EInoU
	J2tz0dGRki95ynnlq8Y3N9QHg+zaTfIgyVBi+qz6xrR1/K33o4o9QLpHJr3Sxylw
	zzTEK5+Ygq8be4A7zbV0liK0BgqC7ysz2plZyIET9Gs2WOMej4Y6Ni83K5cPbDSp
	NuZ+Ikt2GaDxp8kDM8emo6T+hP+C2Z1C48Sywk4ioeCuloEdbnDR0MJvlr+m6BfH
	4pDOhDO9f6HNea5+RJpbDlUZHcjh0aPYu7MKoYUhkH/EMLjvg0Z1KWrT9OzkD9VA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwqe5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:43:46 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 589BdcD0011485;
	Tue, 9 Sep 2025 11:43:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwqe58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:43:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 589AGevm010671;
	Tue, 9 Sep 2025 11:43:44 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smttyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:43:44 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589BhhnU32244272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 11:43:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EE7658062;
	Tue,  9 Sep 2025 11:43:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92E8D5805F;
	Tue,  9 Sep 2025 11:43:37 +0000 (GMT)
Received: from [9.124.223.138] (unknown [9.124.223.138])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 11:43:37 +0000 (GMT)
Message-ID: <8bc987c9-a79d-42ec-8279-da8b407cfd2c@linux.ibm.com>
Date: Tue, 9 Sep 2025 17:13:35 +0530
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
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <aMAR8q4mc3Lhkovw@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hfDtMNXjC-T2ES5I-R_ZBNUNwm_cHNJk
X-Proofpoint-ORIG-GUID: AC5zxmqGdM_n3FSj-CHGFsemWrCJsj6W
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c012f2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8
 a=_RSJUljnWL9c-VqT1lEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXy78r1bCWJJ8y
 v2lG8Zri2tkMKjM0oV6iZ16dV+SADJTa/ZfH5nYKe7lTx8WtWVAk2teaUqZImn4SsYFJJCZ0Zhk
 s6Hgvv4SXRaw8yBIz7Ba1hEE54OVqt+KaM/cZVezjDV5GwbiBF6gFdyzrSQ2b4iSixMPWHEOISq
 pRyQzEXlskqzew8Oikt8HF3WtLtjIBQcPbDNzWASmsfuRFSb990VaRtVtvMcw+cqm6kkOgt/I7v
 ZHIZoeX/BZd6TdVhl0hS9UBTN3WS47CxxM8xUgJ+yX3aC4yAD8NAFMDMsQ8+934SS89GKe3ZUs/
 vKqX0WCc4exvBesnqgMkDPosKfzclK9ZqmslwNJtsXQkAKBSJJjpRUcnNa5tT+2af44rdVd1m1B
 2qR6EeML
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On 09/09/25 5:09 pm, Dust Li wrote:
> On 2025-09-09 09:11:45, Mahanta Jambigi wrote:
>> The smc argument is not used in both smc_connect_ism_vlan_setup() &
>> smc_connect_ism_vlan_cleanup(). Hence removing it.
>>
>> Fixes: 413498440e30 net/smc: add SMC-D support in af_smc
> 
> The standard format for the Fixes tag requires the title to be enclosed
> in parentheses.

I missed this. Let me fix it in next version.

> 
> But I don't think this is a bugfix.

Yeah, its more of a clean up code. Should I use net-next? How should I
got about this.

> 
> 
>> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
> 
> Besides,
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> 
> Best regards,
> Dust


