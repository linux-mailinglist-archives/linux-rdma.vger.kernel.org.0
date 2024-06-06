Return-Path: <linux-rdma+bounces-2959-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2208FF5D5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 22:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6FD288D87
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 20:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFA7757E7;
	Thu,  6 Jun 2024 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M4XqnpXl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B64BA94;
	Thu,  6 Jun 2024 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705597; cv=none; b=mXhchGyAw9An3BuHYaPVUrv2vmA/kDiEWZXcnfTK4scAj/bNrWXuWO2bsRg0om7DP9HkgpCX1mK/G0w2vbXx7Titjj27cZtoBopwiz+M7NTg8ATm2EC3zCxgMsB9zKE17ntf4GntgkcXljq0GLhYvBAzCDQOv+6xfsEec7ckMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705597; c=relaxed/simple;
	bh=Xj7XTFZkj95fwztiRLT1cEo2Pr1iePDTIMXSz0TlfA4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j/rMcygsILpFZUrPHu2TY+YU7dk8v5dg5JTGk23lL/16VwLZqxLgch10hk0coKJvBpoXUfmr0GY/23p8GbpXV8THog9HjQ9Ia7Cl3ktkams8M9b2sqJdLztis6XaitCCKPkhulcMZX+8tobm98EPA780C4977fNOdjhKdMTk3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M4XqnpXl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456KMZ6W006436;
	Thu, 6 Jun 2024 20:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=Z9snNBCsP4hB759QGyYELO1ciqENqF/ID3ZfpfY1WHs=;
 b=M4XqnpXlgx0r/Li6o9UIc4miRJyLQmJk18+wJCkvHLcBEFIjNs64vfNGncvlhLliEwz5
 cQq8pzC80BcDyp2eFoEVRTnZ3ZsPZpiPvAhSCyMvEZ+rE/GWvB0zdbKeu8DvYkndzk+0
 E4kuwn4v+/jrf17cKU2Deg57N5UPtf+DToCDs8qmGR7pyAKSOeAdS8/QX8z0yDqCiutM
 j65jh13rf4v64Mw7WEJ3NVsi+CAIjiJH3rf8od4oECjuFKEGcSgsWHk5b1jQD1kerx8i
 j/5223NvxvxkVCLORg/EHoKizC7SvTHWb+RG3JP18HJalI54sfh0FoPyIRDjrY1mGBdj rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykm35r0e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 20:26:25 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456KQPJO012325;
	Thu, 6 Jun 2024 20:26:25 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ykm35r0e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 20:26:25 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 456HSsci026549;
	Thu, 6 Jun 2024 20:26:24 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yggp3c39j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 20:26:24 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 456KQKdA22610656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Jun 2024 20:26:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B66B05805C;
	Thu,  6 Jun 2024 20:26:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 458405805B;
	Thu,  6 Jun 2024 20:26:18 +0000 (GMT)
Received: from [9.179.16.56] (unknown [9.179.16.56])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Jun 2024 20:26:18 +0000 (GMT)
Message-ID: <1edb2f86-5b8a-4fad-babe-e5f76bbcbf90@linux.ibm.com>
Date: Thu, 6 Jun 2024 22:26:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/3] Introduce IPPROTO_SMC
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1717592180-66181-1-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1717592180-66181-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bGNA9BUt1i9urafpCAh5sXGQ1iEg1c-j
X-Proofpoint-GUID: 0H60egWUIj0rgX4GD3P_LRnQ7PBMqEjA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406060141



On 05.06.24 14:56, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patch allows to create smc socket via AF_INET,
> similar to the following code,
> 
> /* create v4 smc sock */
> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> 
> /* create v6 smc sock */
> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
> 
> There are several reasons why we believe it is appropriate here:
> 
> 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
> address. There is no AF_SMC address at all.
> 
> 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
> the infrastructure of AF_INET(6) path, such as common ebpf hooks.
> Otherwise, smc have to implement it again in AF_SMC path. Such as:
>    1. Replace IPPROTO_TCP with IPPROTO_SMC in the socket() syscall
>       initiated by the user, without the use of LD-PRELOAD.
>    2. Select whether immediate fallback is required based on peer's port/ip
>       before connect().
> 
> A very significant result is that we can now use eBPF to implement smc_run
> instead of LD_PRELOAD, who is completely ineffective in scenarios of static
> linking.
> 
> Another potential value is that we are attempting to optimize the
> performance of fallback socks, where merging socks is an important part,
> and it relies on the creation of SMC sockets under the AF_INET path.
> (More information :
> https://lore.kernel.org/netdev/1699442703-25015-1-git-send-email-alibuda@linux.alibaba.com/T/)
> 
> v2 -> v1:
> 
> - Code formatting, mainly including alignment and annotation repair.
> - move inet_smc proto ops to inet_smc.c, avoiding af_smc.c becoming too bulky.
> - Fix the issue where refactoring affects the initialization order.
> - Fix compile warning (unused out_inet_prot) while CONFIG_IPV6 was not set.
> 
> v3 -> v2:
> 
> - Add Alibaba's copyright information to the newfile
> 
> v4 -> v3:
> 
> - Fix some spelling errors
> - Align function naming style with smc_sock_init() to smc_sk_init()
> - Reversing the order of the conditional checks on clcsock to make the code more intuitive
> 
> v5 -> v4:
> 
> - Fix some spelling errors
> - Added comment, "/* CONFIG_IPV6 */", after the final #endif directive.
> - Rename smc_inet.h and smc_inet.c to smc_inet.h and smc_inet.c
> - Encapsulate the initialization and destruction of inet_smc in inet_smc.c,
>    rather than implementing it directly in af_smc.c.
> - Remove useless header files in smc_inet.h
> - Make smc_inet_prot_xxx and smc_inet_sock_init() to be static, since it's
>    only used in smc_inet.c
> 
> 
> v6 -> v5:
> 
> - Wrapping lines to not exceed 80 characters
> - Combine initialization and error handling of smc_inet6 into the same #if
>    macro block.
> 
> D. Wythe (3):
>    net/smc: refactoring initialization of smc sock
>    net/smc: expose smc proto operations
>    net/smc: Introduce IPPROTO_SMC
> 
>   include/uapi/linux/in.h |   2 +
>   net/smc/Makefile        |   2 +-
>   net/smc/af_smc.c        | 162 ++++++++++++++++++++++++++--------------------
>   net/smc/smc.h           |  38 +++++++++++
>   net/smc/smc_inet.c      | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
>   net/smc/smc_inet.h      |  22 +++++++
>   6 files changed, 324 insertions(+), 71 deletions(-)
>   create mode 100644 net/smc/smc_inet.c
>   create mode 100644 net/smc/smc_inet.h
> 
Hi D.Wythe,

This version of the code looks good to me!
And I played with it on our platform, and did some basic testing for 
SMCR and SMCD. It works pretty well. I like it. Thank you for your effort!

Please feel free to add my signs for the whole patches series.
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Tested-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks,
Wenjia

