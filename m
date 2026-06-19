Return-Path: <linux-rdma+bounces-22372-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GcMKLW7VNGp1iAYAu9opvQ
	(envelope-from <linux-rdma+bounces-22372-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 07:36:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516146A3F69
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 07:36:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=b1IyDOAG;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22372-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22372-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E080F304E419
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2026 05:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427B4292B2E;
	Fri, 19 Jun 2026 05:36:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823BB2F8EAF;
	Fri, 19 Jun 2026 05:36:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781847399; cv=none; b=a3FHvPc/QRSpzyvj2VBFFMhrioMGbDM0yNdUV9KSCwVP/RGslKuAV7rJxVX2ztrkVj12hE1Qrbcmdep8Q4T+UO1OTDtQXJ3wx53CWHV0EQWOcuTLHJO6ZNhDJxtG9I5B7t9eD3Pxo9DUAKRI4sOFUNXaS4kXOh4kVYcu55iJyOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781847399; c=relaxed/simple;
	bh=dCJcqAmKX7l6iyM+HnSqlTwV/ZtRKvVJxjugkfK5utU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXrEdCjykYThXrexnlbKcBLq3Bkq1Ts7e6v3FIkgyiQ6QDSlrOMoAPGkrm79ljJGR5vmrTtipoxQKbLvyJds820yUTTmc3ExEsey8W6j11HbOlQptAlldH7XXWJnZkEQxlUr4BtjzbJJnL4XU/7Nkj6AQUS88yMMO/hsdDJLVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b1IyDOAG; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J3J8Fs1284694;
	Fri, 19 Jun 2026 05:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vOvIfF
	d9KMiDbk53cM7RiXs4Q+ExMtxcOHk+7CTxlyU=; b=b1IyDOAG1A579NenLYZjvG
	QXJOEVoKvOrpDJBYHpvHtDUxlt+FP71Ra3Q2CJN315P0j82Mj1HRVP6nOnLsB9Ji
	H/4tnzxZK57JR3ZVY3umwghjwZks5jzUrg5vpKRqyj3Xx/SBoeH0HUSO8xBucfiB
	oKAjWfm87w9c7k3xbfw7c/tbawF2cWZwwj8OFPLTon+L4hEDVXBNXB/U85kNRFwj
	s4dLDDgjVmZNEHgPMItQMrlNZ1r7kUjA1DiViAlZi1yZex03ZtrLODxxUm9Lx5DF
	aHdYNHuoS9+VhrcsX2O/r32PzDf2loG6uv5m0qEpzqKNnSJOte35tl7cO7zh0T8Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequbvxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 05:36:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J5YbKH018574;
	Fri, 19 Jun 2026 05:36:27 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172faj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 05:36:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J5aQ8664618970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 05:36:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FC5158054;
	Fri, 19 Jun 2026 05:36:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B4145805D;
	Fri, 19 Jun 2026 05:36:19 +0000 (GMT)
Received: from [9.39.17.175] (unknown [9.39.17.175])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 05:36:19 +0000 (GMT)
Message-ID: <5f0b47ee-547e-4ba6-8032-2adb0686d019@linux.ibm.com>
Date: Fri, 19 Jun 2026 11:06:17 +0530
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: avoid recursive sk_callback_lock in listen
 data_ready
To: Runyu Xiao <runyu.xiao@seu.edu.cn>,
        "D. Wythe"
 <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang
 <wenjia@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Simon Horman <horms@kernel.org>, Karsten Graul <kgraul@linux.ibm.com>,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianhao.xu@seu.edu.cn
References: <f7e36176-d00a-4471-94ed-d385e579b43d@linux.ibm.com>
 <20260618141629.2904071-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <20260618141629.2904071-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA0NiBTYWx0ZWRfX40iRtXs7il4p
 fdGewDk1QGjDEWQmehhe9DgPWhkdLwkCQw8SufhTo59VBAcpVCYvDL06Tjp5gcjaehnW1pBvKQx
 wxbYc4RnUd7I1Ur6qYc5L5/+RzMSHkM=
X-Proofpoint-ORIG-GUID: W6YAka2TzTO5Ud8k8xWYYv1Kzt0y0SU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA0NiBTYWx0ZWRfX69ZA+GauPgvR
 RIRgqAGTv5lbt0u3z1/P3EHvWbJoRj3wTu+VF4CBkEJ9wTIuKQQD+X3OQzx+pxYDaV9n7POSTb/
 z9r65o6ClvBKoEs+cj0zD53Ivf9Hu7gFnI7/hhwhs5ritFCqEUqt8PfPICassVqnZpG1mEN3H5Q
 D2pGa/L56A98jtWA84KHEu4FDrVudquI7e7qEjC5y4I2eF8nx8iwNxd/9vg608mR1zzTUKkb0Lw
 SQ3s9SbDDOnHq8aEjtc6k+QNNsO2E2Ip69jvtEyTtzyaklpHkZEW0bnE/MbnLqg1k4Gp6f0Gvgc
 OZnyPTJkD1yI87hKYzlApO0FK/tOgM5h5slIpPTSumubPW6gb44KWIbB48Mf/QM4TO+CnXA/KFV
 J/pGUdrsLOn9olHGRAfgkPw3w/CW4sBpa350jBatWIH7RuwdQloAlMfuAXb82U+8txSRsg9Hw2F
 /WuGeFNX5jsKS3uVpbQ==
X-Proofpoint-GUID: iZt7UvV7DdBSh4TMNeAVAFyxzIUOMY7m
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a34d55d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=UJ9qbeZmKaF5buNRxREA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22372-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:kgraul@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[mjambigi@linux.ibm.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjambigi@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 516146A3F69



On 18/06/26 7:46 pm, Runyu Xiao wrote:
> Hi,
> 
> Thanks for taking a look.
> 
> The exact Lockdep stack I have is from the grounded reproducer, not from
> a production SMC setup.  The reproducer keeps the same callback shape:
> the close/flush side holds sk_callback_lock and invokes the installed
> sk_data_ready callback, which re-enters smc_clcsock_data_ready() and tries
> to take sk_callback_lock again.
> 
> The relevant Lockdep report is:
> 
>   WARNING: possible recursive locking detected
>   kworker/u4:3/39 is trying to acquire lock:
>     (sk_callback_lock) at smc_clcsock_data_ready+0xa/0x4d
> 
>   but task is already holding lock:
>     (sk_callback_lock) at smc_close_flush_work+0xc/0x30
> 
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>         lock(sk_callback_lock);
>         lock(sk_callback_lock);
> 
>   *** DEADLOCK ***
> 
>   Workqueue: smc_close_wq smc_close_flush_work
> 
>   Call Trace:
>     dump_stack_lvl
>     __lock_acquire
>     lock_acquire
>     _raw_read_lock_bh
>     smc_clcsock_data_ready+0xa/0x4d
>     smc_close_flush_work+0x1f/0x30
>     process_one_work
>     worker_thread
>     kthread
>     ret_from_fork

Thank you for addressing the feedback. My suggestion would be to reply
to the original email thread where the review comments were given, so
that the maintainers can follow the conversation.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#respond-to-review-comments

Please include above call stack in your next version.

> 
> The nvmet change I referred to is:
> 
>   2fa8961d3a6a ("nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()")

Please include this info in your next version.

> 
> The stable/backport patch I originally used as the reference is:
> 
>   1c90f930e7b4 ("nvmet-tcp: fixup hang in nvmet_tcp_listen_data_ready()")
> 
> Its commit message says that when the socket is closed while in
> TCP_LISTEN, the flush callback can call nvmet_tcp_listen_data_ready()
> with sk_callback_lock already held, so nvmet moved the TCP_LISTEN check
> before taking sk_callback_lock.
> 
> For the TCP_LISTEN check: my reasoning was that smc_clcsock_data_ready()
> is installed by smc_listen() on the underlying TCP listen socket and only
> queues smc_tcp_listen_work() for the SMC listen/accept path.  Once that
> underlying socket is no longer in TCP_LISTEN, there should be no SMC
> listen accept work to queue from this callback.  TCP_SYN_RECV and
> TCP_ESTABLISHED are not listen-socket states for this callback path, so I
> did not intend the callback to queue listen work for those states.

I understand. Please include this info in your next version.

> 
> That said, if SMC expects smc_clcsock_data_ready() to handle a non-LISTEN
> state during fallback or another transition, then the proposed check is
> too strict and I should rework the fix.
> 
> Thanks,
> Runyu


