Return-Path: <linux-rdma+bounces-13112-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1EBB45A29
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9061B1894003
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968AC369993;
	Fri,  5 Sep 2025 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o+iRD4GE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A907A3629AA;
	Fri,  5 Sep 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081555; cv=none; b=lj/0lzpOixCA1qP7i0Rgq5Hq2857WU+ihcOhiHNAUmIg55Thh4W5S86nVWPCopV7mxTzvpMtjXZBoHVjJ2nrALvv+HxQ5oxgeBACfBNcd8nY2YFuV2BFx8/XzMIS4gS1HL7KkbGAjAwuuqxPvzOz1KuC0xFpotxr05q7fJDv5E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081555; c=relaxed/simple;
	bh=VMDdS7EuAR2lHiKsozVaJG52WZNsXNMUBHTuf32Jo5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2pswmXM4Z60Tizz5su2MWVihCe2Q0kEWka7Cqcy2zGxD1VnKm735lpD2f4PqTJiAitqj0F/FexiPHIRjWmOxgtdIvWS4QmkdOhC+nF7ZN+PyUcrMHFB5Xoro4Xwghj1BCPMo1rBKpm5Nrnvj+3I0GQMzIxEaOIpEsGUJAZbuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o+iRD4GE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5853Xc4n031771;
	Fri, 5 Sep 2025 14:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R/zV1C
	NqF6sG2MnNzBPnk+rjDE4p/E/wNM0jQvtc5CQ=; b=o+iRD4GEAo+/UdOYhHCUNj
	rBLodqxoB+dFHBw0qYn4urRhmp9+Ld7YsVXNUKTzXuw1aGH8NcZTtEcx00JgaxoT
	Z5rZNeOUmYBS89SGYgnvTJLctymPqP1OfhFgP1cl+TBq/E/+Kl8bj58HNgBjzkCF
	FaUZkXn+IliFRjw4GnC0H3fKhj0RcjDWYBaqqAoDuSboehn6X9hNmJZjZxZQxanD
	5WcAdQJAbFt9jiUNPr50hlpttN+yceQZMvy+1nGk+cSOqkcebPsp4wJDbDSTketz
	d4r6qDVPdbbTcFuDnMdfo4lPm2r/NEm+e9jK2xwTNc54lsldYXTDHCzyN4PhN/lw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurgysc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:12:29 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585E7BMX016479;
	Fri, 5 Sep 2025 14:12:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurgys7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:12:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585C4rJT017612;
	Fri, 5 Sep 2025 14:12:27 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vc111x4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:12:27 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585ECQeC27525676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 14:12:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 276725805D;
	Fri,  5 Sep 2025 14:12:26 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DE825805E;
	Fri,  5 Sep 2025 14:12:21 +0000 (GMT)
Received: from [9.39.29.162] (unknown [9.39.29.162])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Sep 2025 14:12:21 +0000 (GMT)
Message-ID: <4c5347ff-779b-48d7-8234-2aac9992f487@linux.ibm.com>
Date: Fri, 5 Sep 2025 19:42:19 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/smc: make wr buffer count configurable
To: Halil Pasic <pasic@linux.ibm.com>, Dust Li <dust.li@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20250904211254.1057445-1-pasic@linux.ibm.com>
 <20250904211254.1057445-2-pasic@linux.ibm.com>
 <aLpc4H_rHkHRu0nQ@linux.alibaba.com>
 <20250905110059.450da664.pasic@linux.ibm.com>
 <20250905140135.2487a99f.pasic@linux.ibm.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20250905140135.2487a99f.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX7KKUgk6iFVmQ
 yML+Za9UEJaK+LkX6q9Y6sXC/mI7Qe4Usq+3LxkrCCU7P3OfRz/gLft5ur6v/6xTXnpCxVyJNI3
 yA1dDepUxB+GeT27a6naSMMsb7DTt5k1W40+FhOOibr5R0NCizHWmXkCK8bwk8vrpn+U7korLx3
 i5TX4qRaFT2O/RAcU9ssN38Mmy9AMSfV5S5fkb/imS6Hzta7HVsk6AjQLQCbUfynpx47E2k+l4z
 hN0j6uVGGLzHTtBzvC6yzZnZMQBfaKXrB5kLD5w1SnlaxyZZekj2JyvXmahj9LV6HF4nXF6y8DY
 lyDCDgDuqK4CysgQyY4qXkUV5UikTXgCY9GMQYBXshDzgk3LHvC5MQvU65nbYKEpY5MlgiS8W0B
 R7SLhU1q
X-Proofpoint-GUID: KpI3tt6SOYpnA3FHAmwT_cdd2oR219cy
X-Proofpoint-ORIG-GUID: u9qEwTRx78snNTiQBN9ej4uJ3a6I2XJF
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68baefcd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=B3rph_lr8uwRdQD9BfQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030



On 05/09/25 5:31 pm, Halil Pasic wrote:
> On Fri, 5 Sep 2025 11:00:59 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>>> 1. What if the two sides have different max_send_wr/max_recv_wr configurations?
>>> IIUC, For example, if the client sets max_send_wr to 64, but the server sets
>>> max_recv_wr to 16, the client might overflow the server's QP receive
>>> queue, potentially causing an RNR (Receiver Not Ready) error.  
>>
>> I don't think the 16 is spec-ed anywhere and if the client and the server
>> need to agree on the same value it should either be speced, or a
>> protocol mechanism for negotiating it needs to exist. So what is your
>> take on this as an SMC maintainer?
>>
>> I think, we have tested heterogeneous setups and didn't see any grave
>> issues. But let me please do a follow up on this. Maybe the other
>> maintainers can chime in as well.
> 
> Did some research and some thinking. Are you concerned about a
> performance regression for e.g. 64 -> 16 compared to 16 -> 16? According
> to my current understanding the RNR must not lead to a catastrophic
> failure, but the RDMA/IB stack is supposed to handle that.
> 

Hi Dust,

I configured a client-server setup & did some SMC-R testing by setting
the values you proposed. Ran iperf3(using smc_run) with max parallel
connections of 128 & it looks good. No tcp fallback. No obvious errors.
As Halil mentioned I don't see any catastrophic failure here. Let me
know if I need to stress the system by some more tests or any specific
test that you can think may cause RNR errors. The setup is ready & I can
try it.

*Client* side logs:
[root@client ~]$ sysctl net.smc.smcr_max_send_wr
net.smc.smcr_max_send_wr = 64
[root@client ~]$

[root@client ~]$ smc_run iperf3  -P 128 -t 120 -c 10.25.0.72
Connecting to host 10.25.0.72, port 5201
[  5] local 10.25.0.73 port 52544 connected to 10.25.0.72 port 5201
[  7] local 10.25.0.73 port 52558 connected to 10.25.0.72 port 5201

*Server* side logs:
[root@server ~]$ sysctl net.smc.smcr_max_recv_wr
net.smc.smcr_max_recv_wr = 16
[root@client ~]$

[root@server~]$ smc_run iperf3 -s

-----------------------------------------------------------
Server listening on 5201 (test #1)
-----------------------------------------------------------

