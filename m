Return-Path: <linux-rdma+bounces-9138-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1519EA7A233
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 13:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6133D1897A9A
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Apr 2025 11:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE024C066;
	Thu,  3 Apr 2025 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q7GbG2XG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E9B3597B;
	Thu,  3 Apr 2025 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743681328; cv=none; b=qC29Vg3B0RFEsTYgkyisQ7DsiRIx8vHxUS6XT6NSqVsoLv60XRKjU6yUlLufdc3PtqRduQvCdkx0Z2o8ndeuAjlMEVn4gEAcMOybyx4/Ob4vCz3s6b+dmBZ+c0UNz2DGVz5JAQ7DXEhAco5QmUCO3166bOnGp/A7cw+P6f7PeKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743681328; c=relaxed/simple;
	bh=rre0HSsAQEnv2Boy9XYmgpT/d7W3RKx/nI+bYa66Ycs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1hDeZcUTtg7IltnHqy8Chw/Jtq7FpplK4eQF6MnFfJGKTY3vpHSZYrenp9v13z8OnunTQFQOUly0lVdd7ePxyxhyebH6a5Ot2SAtKhF6TPNC0JzLofUITrlo8VYZNgbY+4MueriLH6aS/oXztm7SB7Rvz4E1a2FtzB+eHl6W4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q7GbG2XG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5333BeWX012494;
	Thu, 3 Apr 2025 11:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8VlRcJ
	53dQwztWVhlhgNzsYMMAJSzkWB7UAixthYy4c=; b=Q7GbG2XGOvzsotnxJDzVf2
	ZH8dsCHjiOg9Jyj5n5+7W+iOBvaK8gAMctDIUqE0WpNHUV7zusINJIuG95s10Hix
	86zrAODTVEzJ2/gT2fzGLqJYSNJg6I9hZovUmPDKBOiC67g9++tUlgtwjMIq5BI1
	DQdoHX9xRWRG7u+P6qHnqzVi1bjwAdCQpwKM3pZeoGpLYThF0wQncbgaDebkDKgm
	Im09x0wqfAt7ri7S0Kq2zDkI5CQhw2Fi74gDCCerd8j28gABecCXBGDIiclHjLP/
	FA303zCHV7fqAAhUHEkOUysmllhnzmEIlKBlVCjdGWtGQG5UUKefFfbqNwJIKDpg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45s59fwrcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 11:55:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 533BqcLB023904;
	Thu, 3 Apr 2025 11:55:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45s59fwrcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 11:55:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5339cfPY005210;
	Thu, 3 Apr 2025 11:55:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45puk04sfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 11:55:06 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 533Bt4or20841100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Apr 2025 11:55:05 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A45B258058;
	Thu,  3 Apr 2025 11:55:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E903958057;
	Thu,  3 Apr 2025 11:55:01 +0000 (GMT)
Received: from [9.171.51.2] (unknown [9.171.51.2])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Apr 2025 11:55:01 +0000 (GMT)
Message-ID: <d1771c61-b2bb-4eb4-aaad-0fc01d578848@linux.ibm.com>
Date: Thu, 3 Apr 2025 13:55:00 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix general protection fault in
 __smc_diag_dump
To: Wang Liang <wangliang74@huawei.com>, jaka@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        ubraun@linux.vnet.ibm.com, Sidraya Jayagond <sidraya@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250331081003.1503211-1-wangliang74@huawei.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20250331081003.1503211-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PlLfEEgXVtrdHI3p9XkOQaknniTsrhwG
X-Proofpoint-GUID: yilzgcSZgrSQNqx2GuNBaRLeDKceIdR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_04,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=819
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504030045



On 31.03.25 10:10, Wang Liang wrote:
> Syzbot reported a general protection fault:
> 
>    CPU: 0 UID: 0 PID: 5830 Comm: syz-executor600 Not tainted 6.14.0-rc4-syzkaller-00090-gdd83757f6e68 #0
>    RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
>    RIP: 0010:__smc_diag_dump.constprop.0+0x3de/0x23d0 net/smc/smc_diag.c:89
>    Call Trace:
>     <TASK>
>     smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
>     smc_diag_dump+0x84/0x90 net/smc/smc_diag.c:236
>     netlink_dump+0x53c/0xd00 net/netlink/af_netlink.c:2318
>     __netlink_dump_start+0x6ca/0x970 net/netlink/af_netlink.c:2433
>     netlink_dump_start include/linux/netlink.h:340 [inline]
>     smc_diag_handler_dump+0x1fb/0x240 net/smc/smc_diag.c:251
>     __sock_diag_cmd net/core/sock_diag.c:249 [inline]
>     sock_diag_rcv_msg+0x437/0x790 net/core/sock_diag.c:287
>     netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
>     netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
>     netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1348
>     netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1892
>     sock_sendmsg_nosec net/socket.c:718 [inline]
>     __sock_sendmsg net/socket.c:733 [inline]
>     ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
>     ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
>     __sys_sendmsg+0x16e/0x220 net/socket.c:2659
>     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>     do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     </TASK>
> 
> When create smc socket, smc_inet_init_sock() first add sk to the smc_hash
> by smc_hash_sk(), then create smc->clcsock. it is possible that, after
> smc_diag_dump_proto() traverses the smc_hash, smc->clcsock is not created
> when the function visit it.
> 
> The process like this:
> 
>    (CPU1)                         | (CPU2)
>    inet6_create()                 |
>      smc_inet_init_sock()         |
>        smc_sk_init()              |
>          smc_hash_sk()            |
>            head = &smc_hash->ht;  |
>            sk_add_node(sk, head); |
>                                   | smc_diag_dump_proto
>                                   |   head = &smc_hash->ht;
>                                   |     sk_for_each(sk, head)
>                                   |       __smc_diag_dump()
>                                   |         visit smc->clcsock
>        smc_create_clcsk()         |
>            set smc->clcsock       |
> 
> Fix this by initialize smc->clcsock to NULL before add sk to smc_hash in
> smc_sk_init().
> 
> Reported-by: syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364
> Fixes: f16a7dd5cf27 ("smc: netlink interface for SMC sockets")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>   net/smc/af_smc.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 3e6cb35baf25..454801188514 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -371,6 +371,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
>   	sk->sk_protocol = protocol;
>   	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>   	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
> +	smc->clcsock = NULL;
>   	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>   	INIT_WORK(&smc->connect_work, smc_connect_work);
>   	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);

I have to agree with this workaround, even though I see that is not the 
best solution. Thus, I'd like to give my R-b:

Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Btw. @D. Wythe, would you mind sending me the link of your proposal you 
mentioned please? Let me have a look. It seems like I missed it.

Thanks,
Wenjia




