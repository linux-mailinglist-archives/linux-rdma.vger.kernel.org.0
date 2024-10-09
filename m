Return-Path: <linux-rdma+bounces-5339-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D3996EF1
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 16:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40502283DAC
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 14:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E913F1E0B7E;
	Wed,  9 Oct 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N/EUX8Ws"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCA1E0495;
	Wed,  9 Oct 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485838; cv=none; b=DYR4AW4klzvxROkQhq7OcGHWBbkZHR07USJJdWc9ANJtSoRqwGZTiPBTnXdujMK7u3XBX4Tz2hQcVVrvZCC8yeqWfoN91ifwjzgiVxmj5EyS++jYvbikcuxDc3cMUw3NLeUiZC+N4zoitPedOmXcTKqPJaHgnpoNqPNZfxjQRTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485838; c=relaxed/simple;
	bh=E9Ijv/VMn9Tn6GfM7t1yDOEWzyqBC9e5AruCh4uiyb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWVX/CCpYyGc0I+VFowomrwbvVFLJ7waugc/TyQrYmrGljC+Dty5V4JTAjrcEKxeC/jnUEx+jtJ00g2NIbpohvTHd1H5GTJHTJZibyxbT0IUv8XlcYfsZE+2CLCpoc5//WUMu0136qBEC+xeONSM7MbEsvUsCf+ZtG9KH0qMfbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N/EUX8Ws; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499DonZh018417;
	Wed, 9 Oct 2024 14:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=j
	MLReBukVza5hB8Yh/CVvOiUOvn/KG0df0MHRPUwkA0=; b=N/EUX8Ws8mzNIYFT2
	NOvEbyuAcbUSzt5+YaH9MIHNl9J+etP3O8ThUOYq3+UoPewh/7XTPbfll7H3gVAz
	HX4DukTh7PIDa6GNvCC3a5NHCeVSnU6r+CyhnsWlgjdYbFu8SZ/43P+Ky0wke/PE
	db6uLxvsjo8gcnRMP3JLdHH+WjUUkmScWK2AYrqq6W5oRLQ/X+lQ1CUXamZLnyPz
	mIIDKPf3BssP1OdjVcvmH6TJ7Gx+UkhnuKsN8dqlkTCmKePz3+rFkAK9pWtctrtw
	FmyoXnckvQXaouMq6s17L+RpmEc9vTLs6+HeKG2E2NiJSeG01F12KTXVK4S0U4wg
	I3c6w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 425rx910ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 14:57:10 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 499EuHgs008874;
	Wed, 9 Oct 2024 14:57:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 425rx910ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 14:57:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 499DlSJg022835;
	Wed, 9 Oct 2024 14:57:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg11v50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 14:57:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 499Ev8Gt44368204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Oct 2024 14:57:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 152C75805D;
	Wed,  9 Oct 2024 14:57:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4ADF58058;
	Wed,  9 Oct 2024 14:57:05 +0000 (GMT)
Received: from [9.179.10.188] (unknown [9.179.10.188])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Oct 2024 14:57:05 +0000 (GMT)
Message-ID: <0687fd39-7fa9-416c-be91-d33a2432c71a@linux.ibm.com>
Date: Wed, 9 Oct 2024 16:57:04 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1728456916-67035-1-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1728456916-67035-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JOLH-4LijV3JWkGSHrHIg75oeWELVck-
X-Proofpoint-GUID: Txq62pBFDFvyIQoLePdxXgjScDS0v0dp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_12,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=458
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410090089



On 09.10.24 08:55, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> Eric report a panic on IPPROTO_SMC, and give the facts
> that when INET_PROTOSW_ICSK was set, icsk->icsk_sync_mss must be set too.
> 
> Bug: Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000000
> Mem abort info:
> ESR = 0x0000000086000005
> EC = 0x21: IABT (current EL), IL = 32 bits
> SET = 0, FnV = 0
> EA = 0, S1PTW = 0
> FSC = 0x05: level 1 translation fault
> user pgtable: 4k pages, 48-bit VAs, pgdp=00000001195d1000
> [0000000000000000] pgd=0800000109c46003, p4d=0800000109c46003,
> pud=0000000000000000
> Internal error: Oops: 0000000086000005 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 UID: 0 PID: 8037 Comm: syz.3.265 Not tainted
> 6.11.0-rc7-syzkaller-g5f5673607153 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 08/06/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : 0x0
> lr : cipso_v4_sock_setattr+0x2a8/0x3c0 net/ipv4/cipso_ipv4.c:1910
> sp : ffff80009b887a90
> x29: ffff80009b887aa0 x28: ffff80008db94050 x27: 0000000000000000
> x26: 1fffe0001aa6f5b3 x25: dfff800000000000 x24: ffff0000db75da00
> x23: 0000000000000000 x22: ffff0000d8b78518 x21: 0000000000000000
> x20: ffff0000d537ad80 x19: ffff0000d8b78000 x18: 1fffe000366d79ee
> x17: ffff8000800614a8 x16: ffff800080569b84 x15: 0000000000000001
> x14: 000000008b336894 x13: 00000000cd96feaa x12: 0000000000000003
> x11: 0000000000040000 x10: 00000000000020a3 x9 : 1fffe0001b16f0f1
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000002 x1 : 0000000000000000 x0 : ffff0000d8b78000
> Call trace:
> 0x0
> netlbl_sock_setattr+0x2e4/0x338 net/netlabel/netlabel_kapi.c:1000
> smack_netlbl_add+0xa4/0x154 security/smack/smack_lsm.c:2593
> smack_socket_post_create+0xa8/0x14c security/smack/smack_lsm.c:2973
> security_socket_post_create+0x94/0xd4 security/security.c:4425
> __sock_create+0x4c8/0x884 net/socket.c:1587
> sock_create net/socket.c:1622 [inline]
> __sys_socket_create net/socket.c:1659 [inline]
> __sys_socket+0x134/0x340 net/socket.c:1706
> __do_sys_socket net/socket.c:1720 [inline]
> __se_sys_socket net/socket.c:1718 [inline]
> __arm64_sys_socket+0x7c/0x94 net/socket.c:1718
> __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
> invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
> el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
> do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
> el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
> el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
> el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> Code: ???????? ???????? ???????? ???????? (????????)
> ---[ end trace 0000000000000000 ]---
> 
> This patch add a toy implementation that performs a simple return to
> prevent such panic. This is because MSS can be set in sock_create_kern
> or smc_setsockopt, similar to how it's done in AF_SMC. However, for
> AF_SMC, there is currently no way to synchronize MSS within
> __sys_connect_file. This toy implementation lays the groundwork for us
> to support such feature for IPPROTO_SMC in the future.
> 
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---

It looks good to me! Thank you for fixing it!

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks,
Wenjia

