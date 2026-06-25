Return-Path: <linux-rdma+bounces-22465-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eeKUGsDnPGq0uAgAu9opvQ
	(envelope-from <linux-rdma+bounces-22465-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 10:33:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C6D6C3D54
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 10:33:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=OiDXltOr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22465-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22465-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16A863019464
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jun 2026 08:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857F937B03E;
	Thu, 25 Jun 2026 08:32:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB735DA5B;
	Thu, 25 Jun 2026 08:32:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376376; cv=none; b=GtQr4ZbJAOxfq5B7VQoUfLKClrfHk5HqvFWklYEyySJ/ezVm4f/yETst7HVv8QeVwwP2beywiU5fCp0Xj/CxBlhEuHk28/AEOuuz04OwwxNphq7HG/jsR7pVVKOJi/PwRQyDAGui9djIdwe2FDFgkX4HtpgVMWQyw8OOf0Y6yDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376376; c=relaxed/simple;
	bh=vxAqKqHaGz7NXLdQ1go42ReEIBp782jSBRm+6F6iGz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dq5SYxT4m/meCxKmGa9c5ZHjvKgUNthDkj6huVxFlV5keZw25VhPnbpJ7kE+VGZqvoGQlC4ACIb794Fc5jT04S0LhijuzfUO5x2j1wJn1ibH3H8eeHxC5OEx3VTRWxMlln5tdQqwj0EVHgUAIMmDyZ1mdIpyAA+n0Zbf/gLQ0U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OiDXltOr; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3mMxb3185507;
	Thu, 25 Jun 2026 08:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mCrR8I
	urneLBowxIgFvA95tQoKFx9He7WISMZo2sX7I=; b=OiDXltOrOyJZpMzpvB4q2y
	gnoXGkfxlfj7vCYnNeTnjzdHlwmaBC8XQhH66pcm6Aa8kUSvftIJ9Gt68SSAmh1Q
	KOkE3g1b+gI2x39uh87Ugh3lTJSyQYVu2PeCvb2Dbbe4BRLd8DmXdLmR9xPI69iO
	zzyL5Q8ayFGj4ODWuMDp5sdeuOhzmx1bt7nE2AIojXq+v1KxMwXmzThMr4tCya7p
	WFaeH2Pt0EYgDgcCYpGZlJhJeFtwXK/x7CG1XFpRm20MHJ4in3ykPF6GnsHmAAYd
	+nBrJbQ0wgbS+acl+Ktq+sMFIAZOn1bdXNoyvwao38jSkUljwFsn3RAJRO5l9rSQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhr0pbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 08:32:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P8JeM8007543;
	Thu, 25 Jun 2026 08:32:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qneng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 08:32:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65P8WUb256230202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 08:32:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60D102004D;
	Thu, 25 Jun 2026 08:32:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A5A920040;
	Thu, 25 Jun 2026 08:32:26 +0000 (GMT)
Received: from [9.123.14.166] (unknown [9.123.14.166])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 08:32:26 +0000 (GMT)
Message-ID: <17c1cbac-de30-4372-8c24-2acd755f503e@linux.ibm.com>
Date: Thu, 25 Jun 2026 14:02:25 +0530
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
        Wenjia Zhang <wenjia@linux.ibm.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Simon Horman <horms@kernel.org>, Karsten Graul <kgraul@linux.ibm.com>,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Sidraya Jayagond <sidraya@linux.ibm.com>
In-Reply-To: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3ce7a3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=51JgxwwAL-zXi2UjDcgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA3MSBTYWx0ZWRfXyEcLcEW349B2
 k8Sc5c6yGobuuxdwMbCKN0pmwLsXMT5k6IraB4ZNqXSVgIzBwDLIZGtrsA0AVmEvaEBKVlB9iQc
 xRQkXGodzOLxqNHaY10jDHl0yPXyZxJOSQIJiIzQO/vva0helg9BPpoGFi69PtyE4zRBHLtjq6/
 ljZsm//hlr6hRAOQcxGfWuDCpfkt3eiAYrS3QZ29ABXJcFX5glHBjVgph+ZzwS95CWCUG1aipMO
 Grf5zBAbRVS5MeqBNHF5aeHrHDel0I9alRLfZcQBZgVUgUvtGe0zPKJNBFz+k1aqvacU+pVb5lf
 Y0l3DV/DjX0cLbgolFxVebdkVcnIC4YSIR54gZHCy5xOe7dBRcRitib2BlrHqGg7gg7V2nq0NjL
 S24JiwDI3gsYnNC+8BDD3QoYmTwn41iRtE67TyfZvRiNVmeC9cOpp2mPBZWyiQAOHjhatOURB+i
 IQNo/1RxlYQGk/nQD8g==
X-Proofpoint-GUID: 5rbcDbwbMeYSIbrFeDOqZ8cZZrPr0N_U
X-Proofpoint-ORIG-GUID: tacv5n88DyUZAzK4jWQzlIHZ0bBwgxVI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA3MSBTYWx0ZWRfXxhI+PZVfK5Yr
 yxi61okkU5RTcO0gnPynvcTGS7uF8D0iSqHmBVxcjz7rgxzRc0SaJUyAGSs6bBPLBSF0ISZrmRD
 ggvggaSdwbMKMe3pdquAUvPrrxHr19w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22465-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:kgraul@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[sidraya@linux.ibm.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sidraya@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3C6D6C3D54



On 17/06/26 8:58 pm, Runyu Xiao wrote:
> smc_listen() installs smc_clcsock_data_ready() as the underlying TCP
> listen socket's sk_data_ready callback.  smc_clcsock_data_ready() then
> immediately takes sk_callback_lock before looking up the SMC listener and
> queuing smc_tcp_listen_work().
> 
> That is unsafe once the TCP listen socket is leaving TCP_LISTEN.  The TCP
> close/flush path can run the installed sk_data_ready callback with
> sk_callback_lock already held, so entering smc_clcsock_data_ready() again
> tries to take the same rwlock recursively in the same thread.  The nvmet
> TCP listener had to make the same state check before taking
> sk_callback_lock for this reason.
> 
> This issue was found by our static analysis tool and then manually
> reviewed against the current tree.
> 
> The grounded PoC kept the SMC listen callback installation path:
> 
>   smc_listen()
>   smc_clcsock_replace_cb()
>   sk_data_ready = smc_clcsock_data_ready()
> 
> It then modeled the close/flush carrier that invokes the installed
> sk_data_ready callback while sk_callback_lock is already held.  Lockdep
> reported the same-thread recursive acquisition:
> 
>   WARNING: possible recursive locking detected
>   smc_clcsock_data_ready+0xa/0x4d [vuln_msv]
>   smc_close_flush_work+0x1f/0x30 [vuln_msv]
>   *** DEADLOCK ***
> 
> Return before taking sk_callback_lock when the underlying TCP socket is no
> longer in TCP_LISTEN.  In that state there is no listen accept work to
> queue for SMC, and avoiding the callback lock mirrors the fix used by the
> TCP nvmet listener.
> 
> Fixes: 0558226cebee ("net/smc: Fix slab-out-of-bounds issue in fallback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  net/smc/af_smc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 6421c2e1c84d..1af4e3c333ff 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2631,6 +2631,9 @@ static void smc_clcsock_data_ready(struct sock *listen_clcsock)
>  {
>  	struct smc_sock *lsmc;
>  
> +	if (READ_ONCE(listen_clcsock->sk_state) != TCP_LISTEN)
> +		return;
> +

In smc_close_active(), the TCP socket remains in TCP_LISTEN state while
holding write_lock_bh(&smc->clcsock->sk->sk_callback_lock);. The patch's
state check would pass during this window, not preventing the recursive
lock scenario.
It's unclear whether it fully prevents the recursive locking scenario
described in the commit message for the specific code path in
smc_close_active().
Could you come up with exact deadlock scenario and how the patch
addresses it?

>  	read_lock_bh(&listen_clcsock->sk_callback_lock);
>  	lsmc = smc_clcsock_user_data(listen_clcsock);
>  	if (!lsmc)


