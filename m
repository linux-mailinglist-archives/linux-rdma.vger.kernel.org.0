Return-Path: <linux-rdma+bounces-5143-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CFE989275
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2024 03:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117DE285A4D
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Sep 2024 01:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE021B665;
	Sun, 29 Sep 2024 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xz0FMyZD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1525CB8;
	Sun, 29 Sep 2024 01:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727573438; cv=none; b=FKJA2kVs34H33ZIgUGE6Xps8EdgIkSwfhdl0gZs75MhGOTqMkSH9MSxeU9fi4I55DXxAayW2Z+q/oqk4uKfYatLu9gnkBwFt2s/rzs70i7Yyaz7tGK0gfJ57qdD/wSnuZGpV35nom0weBAGhyhhE5yP6cUtYIUG7mi25v+ewxgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727573438; c=relaxed/simple;
	bh=X9DpYzFyZ+HLsY7DUKOBX2i782WYFgCwYhEKFYEJ/XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et1yk7HNvM95l4ohwMZuVqq18ZVLDyD5dViOlBPASCjwYSn9y849g0RbAkKujSd7aqQCDWPTZ6d/pCttOi+V7KHZg4Q+Rmo1hERRwoInqtn+Ch1x4qZ9XGflmAktWlacm7MZDhFSY9M79oLUVwdLmxuNuTCYEOyYHxSLWZ5+YY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xz0FMyZD; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727573427; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5vIw3q4yZsnbjXo6TWEyTvQdsGYhhZ745aM1K7o5WUY=;
	b=Xz0FMyZDPcxA/77I53OUP6zLiqQ+6OB93V+Sn0NM3dvgFrtSONZh5aonYglMe30hQUvahW0QT30XYmao5fdZJB7BW9lp0Xu23yq9P2CO2u3LNSRH5L9kikB8NaG+uC3natVUjVRTd0NeKhejiWF0A26G9iY/k6ogyUfy3oz3zaI=
Received: from 30.221.144.152(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WFuY-il_1727573425)
          by smtp.aliyun-inc.com;
          Sun, 29 Sep 2024 09:30:26 +0800
Message-ID: <af2320a1-86be-4a95-bb9c-6f7f46b357e5@linux.alibaba.com>
Date: Sun, 29 Sep 2024 09:30:25 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 3/3] net/smc: Introduce IPPROTO_SMC
To: Eric Dumazet <edumazet@google.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com
References: <1718301630-63692-1-git-send-email-alibuda@linux.alibaba.com>
 <1718301630-63692-4-git-send-email-alibuda@linux.alibaba.com>
 <CANn89i+cKR+hBpXuKxO=dRX448qA3tzEkiOvC4PshWH0OVAD0w@mail.gmail.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <CANn89i+cKR+hBpXuKxO=dRX448qA3tzEkiOvC4PshWH0OVAD0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/27/24 10:56 PM, Eric Dumazet wrote:
> On Thu, Jun 13, 2024 at 8:00 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
>>
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
>>
>> There are several reasons why we believe it is appropriate here:
>>
>> 1. For smc sockets, it actually use IPv4 (AF-INET) or IPv6 (AF-INET6)
>> address. There is no AF_SMC address at all.
>>
>> 2. Create smc socket in the AF_INET(6) path, which allows us to reuse
>> the infrastructure of AF_INET(6) path, such as common ebpf hooks.
>> Otherwise, smc have to implement it again in AF_SMC path.
>>
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
>> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Tested-by: Wenjia Zhang <wenjia@linux.ibm.com>
>> ---
>>   include/uapi/linux/in.h |   2 +
>>   net/smc/Makefile        |   2 +-
>>   net/smc/af_smc.c        |  16 ++++-
>>   net/smc/smc_inet.c      | 159 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   net/smc/smc_inet.h      |  22 +++++++
>>   5 files changed, 198 insertions(+), 3 deletions(-)
>>   create mode 100644 net/smc/smc_inet.c
>>   create mode 100644 net/smc/smc_inet.h
>>
>> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
>> index e682ab6..d358add 100644
>> --- a/include/uapi/linux/in.h
>> +++ b/include/uapi/linux/in.h
>> @@ -81,6 +81,8 @@ enum {
>>   #define IPPROTO_ETHERNET       IPPROTO_ETHERNET
>>     IPPROTO_RAW = 255,           /* Raw IP packets                       */
>>   #define IPPROTO_RAW            IPPROTO_RAW
>> +  IPPROTO_SMC = 256,           /* Shared Memory Communications         */
>> +#define IPPROTO_SMC            IPPROTO_SMC
>>     IPPROTO_MPTCP = 262,         /* Multipath TCP connection             */
>>   #define IPPROTO_MPTCP          IPPROTO_MPTCP
>>     IPPROTO_MAX
>> diff --git a/net/smc/Makefile b/net/smc/Makefile
>> index 2c510d54..60f1c87 100644
>> --- a/net/smc/Makefile
>> +++ b/net/smc/Makefile
>> @@ -4,6 +4,6 @@ obj-$(CONFIG_SMC)       += smc.o
>>   obj-$(CONFIG_SMC_DIAG) += smc_diag.o
>>   smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
>>   smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
>> -smc-y += smc_tracepoint.o
>> +smc-y += smc_tracepoint.o smc_inet.o
>>   smc-$(CONFIG_SYSCTL) += smc_sysctl.o
>>   smc-$(CONFIG_SMC_LO) += smc_loopback.o
>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>> index 8e3ce76..435f38b 100644
>> --- a/net/smc/af_smc.c
>> +++ b/net/smc/af_smc.c
>> @@ -54,6 +54,7 @@
>>   #include "smc_tracepoint.h"
>>   #include "smc_sysctl.h"
>>   #include "smc_loopback.h"
>> +#include "smc_inet.h"
>>
>>   static DEFINE_MUTEX(smc_server_lgr_pending);   /* serialize link group
>>                                                   * creation on server
>> @@ -3593,10 +3594,15 @@ static int __init smc_init(void)
>>                  pr_err("%s: tcp_ulp_register fails with %d\n", __func__, rc);
>>                  goto out_lo;
>>          }
>> -
>> +       rc = smc_inet_init();
>> +       if (rc) {
>> +               pr_err("%s: smc_inet_init fails with %d\n", __func__, rc);
>> +               goto out_ulp;
>> +       }
>>          static_branch_enable(&tcp_have_smc);
>>          return 0;
>> -
>> +out_ulp:
>> +       tcp_unregister_ulp(&smc_ulp_ops);
>>   out_lo:
>>          smc_loopback_exit();
>>   out_ib:
>> @@ -3633,6 +3639,7 @@ static int __init smc_init(void)
>>   static void __exit smc_exit(void)
>>   {
>>          static_branch_disable(&tcp_have_smc);
>> +       smc_inet_exit();
>>          tcp_unregister_ulp(&smc_ulp_ops);
>>          sock_unregister(PF_SMC);
>>          smc_core_exit();
>> @@ -3660,4 +3667,9 @@ static void __exit smc_exit(void)
>>   MODULE_LICENSE("GPL");
>>   MODULE_ALIAS_NETPROTO(PF_SMC);
>>   MODULE_ALIAS_TCP_ULP("smc");
>> +/* 256 for IPPROTO_SMC and 1 for SOCK_STREAM */
>> +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 256, 1);
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 256, 1);
>> +#endif /* CONFIG_IPV6 */
>>   MODULE_ALIAS_GENL_FAMILY(SMC_GENL_FAMILY_NAME);
>> diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
>> new file mode 100644
>> index 00000000..bece346
>> --- /dev/null
>> +++ b/net/smc/smc_inet.c
>> @@ -0,0 +1,159 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + *  Shared Memory Communications over RDMA (SMC-R) and RoCE
>> + *
>> + *  Definitions for the IPPROTO_SMC (socket related)
>> + *
>> + *  Copyright IBM Corp. 2016, 2018
>> + *  Copyright (c) 2024, Alibaba Inc.
>> + *
>> + *  Author: D. Wythe <alibuda@linux.alibaba.com>
>> + */
>> +
>> +#include <net/protocol.h>
>> +#include <net/sock.h>
>> +
>> +#include "smc_inet.h"
>> +#include "smc.h"
>> +
>> +static int smc_inet_init_sock(struct sock *sk);
>> +
>> +static struct proto smc_inet_prot = {
>> +       .name           = "INET_SMC",
>> +       .owner          = THIS_MODULE,
>> +       .init           = smc_inet_init_sock,
>> +       .hash           = smc_hash_sk,
>> +       .unhash         = smc_unhash_sk,
>> +       .release_cb     = smc_release_cb,
>> +       .obj_size       = sizeof(struct smc_sock),
>> +       .h.smc_hash     = &smc_v4_hashinfo,
>> +       .slab_flags     = SLAB_TYPESAFE_BY_RCU,
>> +};
>> +
>> +static const struct proto_ops smc_inet_stream_ops = {
>> +       .family         = PF_INET,
>> +       .owner          = THIS_MODULE,
>> +       .release        = smc_release,
>> +       .bind           = smc_bind,
>> +       .connect        = smc_connect,
>> +       .socketpair     = sock_no_socketpair,
>> +       .accept         = smc_accept,
>> +       .getname        = smc_getname,
>> +       .poll           = smc_poll,
>> +       .ioctl          = smc_ioctl,
>> +       .listen         = smc_listen,
>> +       .shutdown       = smc_shutdown,
>> +       .setsockopt     = smc_setsockopt,
>> +       .getsockopt     = smc_getsockopt,
>> +       .sendmsg        = smc_sendmsg,
>> +       .recvmsg        = smc_recvmsg,
>> +       .mmap           = sock_no_mmap,
>> +       .splice_read    = smc_splice_read,
>> +};
>> +
>> +static struct inet_protosw smc_inet_protosw = {
>> +       .type           = SOCK_STREAM,
>> +       .protocol       = IPPROTO_SMC,
>> +       .prot           = &smc_inet_prot,
>> +       .ops            = &smc_inet_stream_ops,
>> +       .flags          = INET_PROTOSW_ICSK,
> 
> When this flag is set, icsk->icsk_sync_mss must be set.
> 

Hi Eric,

Thanks for your report. I will fix this issue ASAP.

Best wishes,
D. Wythe


> Unable to handle kernel NULL pointer dereference at virtual address
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

