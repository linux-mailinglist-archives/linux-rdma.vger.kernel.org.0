Return-Path: <linux-rdma+bounces-13034-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B40B3F7FE
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 10:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3EA3A61FD
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 08:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A022E92AB;
	Tue,  2 Sep 2025 08:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="imRNT2fp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6072E8B86;
	Tue,  2 Sep 2025 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800807; cv=none; b=MiccgGy+wMr7mEU3T2/LhVqduA5hk/cqavXaHwXLtz7XspqnKHmlEmtlVv9xtetKJ5CmkCtzxmVW8gtYWqFDDpDUXwshv9lFObgAwAhHf7Obu2XKqKp5Qn+pXYkMEDBwobmUneP2n05LwlnK0clna5HxjAu3pbaeXt02tUivNH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800807; c=relaxed/simple;
	bh=GGtE6q+nP9Ik0rFB89I38FIlhk6EoKwCHJhu0FHTfJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMhMk3besbOBTa4KtGAlffpXzGkzZTOOPgW1pKgWmEIa1O++UbIiZXDliN5V/uF57ag47AYu9WJKyahR+CN/veGphWsRhf+d2+FZ4Pa6mKLZQfOp3l1hwNO+dYzF+VZtVcTBUzFvOT2Cl5U2Sp0ztMwVI4a9AQJ1o3em5eG9hgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=imRNT2fp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5826kK8p023033;
	Tue, 2 Sep 2025 08:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OWhkJT
	GEI1Cz+kXAgoNhGujH4Ol85tWGW+TRw5LjORU=; b=imRNT2fp4R0HUJCdxUdNF+
	2eGXDvb75FP6OLsU3tOJK4ljfFit+TXKmLrsH/zPi67dTBbqAJgN76++MBzULHPf
	TnKH3AcuMWZf4Gg9GauMRr3oSY65keVn1qylFmdMI4bkhlLHzuQPzQdE2mXkETJd
	r8/ZeLxpXqP3YyO8/fyT9itpstMPk812Pf1Ndp8YT1bIqj+3i5tcOYE0IuY9c4+9
	nxkUNvh/qRRP+MFrqfmc2gIowaoNCT+aFlijhbJaAqB8bxYgrHURjNxRVPz7WbJF
	v8D8EbUVxmMegio7t8vGfPC4StJTrwKkXbE0nG2tAmak93yVZ8N3W8hXxWX5DB+g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv2w33c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 08:13:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58287osY026169;
	Tue, 2 Sep 2025 08:13:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv2w339-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 08:13:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5824tsvE019316;
	Tue, 2 Sep 2025 08:13:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4msg4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 08:13:09 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5828D8S825494178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 08:13:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F97558059;
	Tue,  2 Sep 2025 08:13:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A41C5805D;
	Tue,  2 Sep 2025 08:13:02 +0000 (GMT)
Received: from [9.109.249.226] (unknown [9.109.249.226])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Sep 2025 08:13:01 +0000 (GMT)
Message-ID: <02c901f9-ce69-46cd-9a4c-6fe7ce9c6618@linux.ibm.com>
Date: Tue, 2 Sep 2025 13:43:00 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: Remove validation of reserved bits in CLC
 Decline message
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
        pasic@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-rdma@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>
References: <20250829102626.3271637-1-mjambigi@linux.ibm.com>
 <20250902070831.GA168966@horms.kernel.org>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20250902070831.GA168966@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZIZGEzsukigZ0TNhXusGvQzXhi44ccue
X-Authority-Analysis: v=2.4 cv=FPMbx/os c=1 sm=1 tr=0 ts=68b6a717 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=KUUty9fwfFscJP1E-eQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1uD8OOH7sFTh0I6IjSvV3lhx1ua1_8I2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX1JxRFvQy5/Cs
 AILPxgiM7sbesn3lO1Mq7naL9LVLIkEnQx3fEfDTahilFAjjRweKuiPlXrpc9Sz4eRV1h/caLSD
 PtAXH426vKf4t5oaYbBxDYxofsDSar1cwIld2lvGHs5ZoQZOTTEtQbyRtQNjM1L8VEq3rIj5VN+
 ivEXJzmX8A8dXqas/w06pHQDUJexZuySmWRXqys+8jfLYAso1MInlDL7EbeWdun2VJ1C/zDAepk
 Kake3Gl8uapUaP1qYUNqo7HVQByxFyJCXMni/2qEMVeyqYPxcqJgoJTu9YQkobaeMkYxj118HdV
 2QksgDPVj/+3IR9L8JVUDnmAVEL7mfTWEmG2yp04biWwvwSStL31l9z4n296WF4I3b5zsU7eIcs
 6a0h3L4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034



On 02/09/25 12:38 pm, Simon Horman wrote:
> 
> Hi Mahanta,
> 
> Sorry to nit-pick, but there should not be a blank line here.
> And the correct format for the Fixes tag, whith at least
> 12 characters of hash, is:
> 
> Fixes: 8ade200c269f ("net/smc: add v2 format of CLC decline message")

Sure, will fix this in v2.>> Signed-off-by: Mahanta Jambigi
<mjambigi@linux.ibm.com>
>> Reference-ID: LTC214332
> 
> Please drop this non-standard tag.
> And please only include references (by any means) to public information.

Yeah, will fix this in v2. Dust Li also mentioned the same.

