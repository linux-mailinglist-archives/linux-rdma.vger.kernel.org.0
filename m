Return-Path: <linux-rdma+bounces-2726-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749FC8D5CC9
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 10:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009521F22140
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D85814F9F9;
	Fri, 31 May 2024 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cw4xuoEw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E214F9EE;
	Fri, 31 May 2024 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144530; cv=none; b=bu6JTXXA+s86mQ2uQinmlWG628n3CLnD+3PMIkGwPnkqw6Su06TQ9GPOt4JvJCQF9J2GJVtoMAB3PwitoJfxUGLO1oYxNixOad8c0czl0yhDXYJeGSHcQmPsYBa4PaL7nEhdGQb6SE+DptI66cZHkTfit7EOVR1tB7rYETqR4C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144530; c=relaxed/simple;
	bh=HQvoDqK60c0HziAFW58bTtlxbgZFzYALbQqMlQCXe34=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HXPKtneyF00VtjICWs74pBWdVh5PH0eBEMpcAwYqlI3AXNVIJYB1zw39QmcYxHbEPjKy8JuFEbFRRr87kpHBbtkUY63a5OlzRV+Aia2j7cT7m1+QE0g9KT9L4yXd4T/5TxwGkIaieKS35WVu5bc57XxFsBXPigtWh4D1bkWz0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cw4xuoEw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V87KPv031165;
	Fri, 31 May 2024 08:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=1y6y1eXrv6sruReBVh9hGh2wEZ2WHcWE1MoRbCvgWQo=;
 b=Cw4xuoEwtmNtZUYbm/VKLDZwx6lhKZdcMNWv+DGntOlaMuFXLd3iLjW/PBHFDMLEmZpe
 gDKuDl/9ahfu074EN5Y6DxmC5EWcZA1AB6+VVIE34tdu7TVKZ/fq82/ospRpFC8O/Hgq
 /DgrcZC4SXzUiykRnK1AcQ1ENJkSq48CYjOchWbgetAgr12E2GQ6dBmTd0wIAJaUaS96
 FMK2K4QymrgUb2hZijjEfxn6rJIjVpiT5/8Q7lMd/RXISUiPE/ojSLLaMasSHtPoC/ef
 bYdVSRok5TazeZFSbP9wwR8j1+8CsIaPeZ81G4iT08nrPFUA2e4kj5LLAdezIAatl3+C iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yfarr02bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 08:35:24 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44V8ZNRv012833;
	Fri, 31 May 2024 08:35:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yfarr02ba-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 08:35:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44V56l9Q006890;
	Fri, 31 May 2024 08:06:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydpebprgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 08:06:50 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44V86lE412845622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 08:06:49 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6C635806D;
	Fri, 31 May 2024 08:06:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C6755805B;
	Fri, 31 May 2024 08:06:44 +0000 (GMT)
Received: from [9.171.25.186] (unknown [9.171.25.186])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 May 2024 08:06:44 +0000 (GMT)
Message-ID: <882713c2-02bd-4396-83be-c527b9d24eef@linux.ibm.com>
Date: Fri, 31 May 2024 10:06:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/3] Introduce IPPROTO_SMC
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1717061440-59937-1-git-send-email-alibuda@linux.alibaba.com>
 <bd80b8f9-9c86-4a9b-a7ba-07471dcd5a7c@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <bd80b8f9-9c86-4a9b-a7ba-07471dcd5a7c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _BZ4CaLMBLezEpodBiGmWMvgj76_bl20
X-Proofpoint-GUID: 0bX0-E3mnhLzEtiWJDaFgvmShrW_jIq9
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_04,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405310064



On 30.05.24 12:14, D. Wythe wrote:
> 
> 
> On 5/30/24 5:30 PM, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> This patch allows to create smc socket via AF_INET,
>> similar to the following code,
>>
>> /* create v4 smc sock */
>> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>>
>> /* create v6 smc sock */
>> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
> 
> Welcome everyone to try out the eBPF based version of smc_run during 
> testing, I have added a separate command called smc_run.bpf,
> it was equivalent to normal smc_run but with IPPROTO_SMC via eBPF.
> 
> You can obtain the code and more info from: 
> https://github.com/D-Wythe/smc-tools
> 
> Usage:
> 
> smc_run.bpf
> An eBPF implemented smc_run based on IPPROTO_SMC:
> 
> 1. Support to transparent replacement based on command (Just like smc_run).
> 2. Supprot to transparent replacement based on pid configuration. And 
> supports the inheritance of this capability between parent and child 
> processes.
> 3. Support to transparent replacement based on per netns configuration.
> 
> smc_run.bpf COMMAND
> 
> 1. Equivalent to smc_run but with IPPROTO_SMC via eBPF
> 
> smc_run.bpf -p pid
> 
>   1. Add the process with target pid to the map. Afterward, all socket() 
> calls of the process and its descendant processes will be replaced from 
> IPPROTO_TCP to IPPROTO_SMC.
>   2. Mapping will be automatically deleted when process exits.
>   3. Specifically, COMMAND mode is actually works like following:
> 
>      smc_run.bpf -p $$
>      COMMAND
>      exit
> 
> smc_run.bpf -n 1
> 
>   1. Make all socket() calls of the current netns to be replaced from 
> IPPROTO_TCP to IPPROTO_SMC.
>   2. Turn off it by smc_run.bpf -n 0
> 
> 
Hi D. Wythe,

Thank you for the info and description! The code generally looks good to 
me, just still some details I need to check again. And I'd like to give 
smc_run.bpf a try, and maybe let you know if it works for me next week.

Thanks,
Wenjia

