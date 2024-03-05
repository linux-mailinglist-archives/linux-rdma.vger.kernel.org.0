Return-Path: <linux-rdma+bounces-1209-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E34C87144F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 04:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB761F21203
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Mar 2024 03:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4655A376E6;
	Tue,  5 Mar 2024 03:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mx2kdF1h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972F17C6C;
	Tue,  5 Mar 2024 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609527; cv=none; b=n/14PZZYQp5DzxsjpIfPK1ZuNo5EK24B8A4Rw65dkzFedyTPsaE3QseNKQKs3YfmQ18441wvYnU1pl6jLhCeiaVALF47yelwL82WWxcOt7wPuhRC3duWvBVHuHpDZCqEYk1VbgWl3T16hw7nUux7l8iKX7smgKDAdkvbmZr3zIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609527; c=relaxed/simple;
	bh=CwLa6d9XZ/eXs12HB3ta+FGJmRETNGxPzwdCi3stNe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uy6dURRwZ5t3UkqzhdgbE9L+lPqwPH/Xzp2ZLqwBEv9B1nIa0M3moHMiUa6E+6XapwC9mC3wUKpof8S/moq66PVHL9WOk4TVRlBAw5nMVLrniL4Etqtoddg/NDp+NsCC3s6F5JR8ZF4qSUKxP6jYddOWL/HsMv9g6I4glPDzOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mx2kdF1h; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cf1a0f5d-b628-4b1d-b21b-f40d5bb26771@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709609522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbRJ/BSgopqyuTR8FU1tsSpomzIy9inLr1mA61k79Nk=;
	b=Mx2kdF1hzykk+cRszXYjaTe22ZYYbxHArv1Pg/SWrRMlaoWF7ySo1zHSi4Ccr8DFz9Wdcx
	Ri2ROURwt/gL4mTzx5jqbsYHRABPte6WTEGwKr8wrbuoNlsupyMIcOyS8mDZVitDMZjsuI
	dit3UffGrMgUCE8lQfGPrpjubfPEH54=
Date: Tue, 5 Mar 2024 04:31:53 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in
 rdma_resolve_route
To: xingwei lee <xrivendell7@gmail.com>,
 syzbot+a2e2735f09ebb9d95bd1@syzkaller.appspotmail.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, samsun1006219@gmail.com
References: <CABOYnLxCWaVx=SH8efXxj8d9YPjnw8C9LUTs6gDnxeeOHt68tg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CABOYnLxCWaVx=SH8efXxj8d9YPjnw8C9LUTs6gDnxeeOHt68tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/3/4 5:43, xingwei lee 写道:
> Hello, Yanjun I reproduced this bug and comfired, it may help your to
> test your patch.
> As always, I uploaded it here.

Got it. I will make tests with it.
Thanks a lot.

Zhu Yanjun

> 
> If you fix this issue, please add the following tag to the reporter or
> reproducer:
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: sam sun <samsun1006219@gmail.com>
> 
> I use the same configuation with syzbot dashboard.
> kernel version: linux-next 2c3b09aac00d7835023bbc4473ee06696be64fa8
> kernel config: syzkaller.appspot.com/text?tag=KernelConfig&x=176d2dcbf8ba7017
> <http://syzkaller.appspot.com/text?tag=KernelConfig&x=176d2dcbf8ba7017>
> with KASAN enabled
> compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Likewise, this bug has more than one title, in my environment， these
> titles are also relevant to this bug:
> KASAN: slab-use-after-free Read in cma_netevent_callback
> KASAN: slab-use-after-free Read in _destroy_id
> KASAN: slab-use-after-free in cma_add_id_to_tree
> KASAN: slab-use-after-free in compare_netdev_and_ip
> 
> root@syzkaller:~# ./925-7
> [  364.962016][ T8201] infiniband syz1: set active
> [  364.963857][ T8201] infiniband syz1: added syz_tun
> [  365.004959][ T8201] RDS/IB: syz1: added
> [  365.006131][ T8201] smc: adding ib device syz1 with port count 1
> [  365.007313][ T8201] smc:    ib device syz1 port 1 has pnetid
> [  365.170043][ T8210] syz1: rxe_newlink: already configured on syz_tun
> [  365.190827][ T8211] syz1: rxe_newlink: already configured on syz_tun
> [  365.213461][ T8212] syz1: rxe_newlink: already configured on syz_tun
> [  365.232342][ T8213] syz1: rxe_newlink: already configured on syz_tun
> [  365.243876][ T8214] syz1: rxe_newlink: already configured on syz_tun
> [  365.258450][ T8215] syz1: rxe_newlink: already configured on syz_tun
> [  365.287755][ T8216] syz1: rxe_newlink: already configured on syz_tun
> [  365.307337][ T8217] syz1: rxe_newlink: already configured on syz_tun
> [  365.325342][ T8218] syz1: rxe_newlink: already configured on syz_tun
> [  365.337734][ T8219] syz1: rxe_newlink: already configured on syz_tun
> [  366.230237][ T8278]
> ==================================================================
> [  366.231886][ T8278] BUG: KASAN: slab-use-after-free in
> rdma_resolve_route+0x2524/0x32a0
> [  366.234250][ T8278] Read of size 4 at addr ffff88801ff02184 by task
> 925-7/8278
> [  366.235595][ T8278]
> [  366.236068][ T8278] CPU: 0 PID: 8278 Comm: 925-7 Not tainted
> 6.8.0-rc4-next-20240214 #1
> [  366.237492][ T8278] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  366.239327][ T8278] Call Trace:
> [  366.239941][ T8278]  <TASK>
> [  366.240469][ T8278]  dump_stack_lvl+0x250/0x380
> [  366.242198][ T8278]  ? __pfx_dump_stack_lvl+0x10/0x10
> [  366.243109][ T8278]  ? __pfx__printk+0x10/0x10
> [  366.243934][ T8278]  ? _printk+0xda/0x120
> [  366.244679][ T8278]  ? __virt_addr_valid+0x19b/0x580
> [  366.245583][ T8278]  ? __virt_addr_valid+0x19b/0x580
> [  366.246482][ T8278]  print_report+0x169/0x550
> [  366.247290][ T8278]  ? __virt_addr_valid+0x19b/0x580
> [  366.248202][ T8278]  ? __virt_addr_valid+0x19b/0x580
> [  366.249100][ T8278]  ? __virt_addr_valid+0x4a8/0x580
> [  366.250003][ T8278]  ? __phys_addr+0xc3/0x180
> [  366.250822][ T8278]  ? rdma_resolve_route+0x2524/0x32a0
> [  366.251840][ T8278]  kasan_report+0x143/0x180
> [  366.252635][ T8278]  ? _raw_spin_lock_irqsave+0xe1/0x120
> [  366.253586][ T8278]  ? rdma_resolve_route+0x2524/0x32a0
> [  366.254542][ T8278]  rdma_resolve_route+0x2524/0x32a0
> [  366.255476][ T8278]  ? __mutex_lock+0x2ef/0xd70
> [  366.256304][ T8278]  ? __pfx_rdma_resolve_route+0x10/0x10
> [  366.257284][ T8278]  ? __pfx___mutex_lock+0x10/0x10
> [  366.258168][ T8278]  ? ucma_get_ctx+0x29f/0x3b0
> [  366.259002][ T8278]  ? __pfx_ucma_get_ctx+0x10/0x10
> [  366.259901][ T8278]  ? __might_fault+0xcf/0x130
> [  366.260718][ T8278]  ucma_resolve_route+0x1c3/0x330
> [  366.261581][ T8278]  ? __pfx_ucma_resolve_route+0x10/0x10
> [  366.262524][ T8278]  ? __might_fault+0xcf/0x130
> [  366.263324][ T8278]  ? __pfx_ucma_resolve_route+0x10/0x10
> [  366.264273][ T8278]  ucma_write+0x2f0/0x440
> [  366.264998][ T8278]  ? __pfx_ucma_write+0x10/0x10
> [  366.265802][ T8278]  ? bpf_lsm_file_permission+0xe/0x20
> [  366.266701][ T8278]  ? rw_verify_area+0x1e7/0x5b0
> [  366.267543][ T8278]  ? __pfx_ucma_write+0x10/0x10
> [  366.268341][ T8278]  vfs_write+0x2b3/0xcf0
> [  366.269044][ T8278]  ? kasan_quarantine_put+0xdc/0x230
> [  366.269917][ T8278]  ? lockdep_hardirqs_on+0x99/0x150
> [  366.270784][ T8278]  ? __pfx_vfs_write+0x10/0x10
> [  366.271587][ T8278]  ? do_sys_openat2+0x160/0x1c0
> [  366.272398][ T8278]  ? __pfx_do_sys_openat2+0x10/0x10
> [  366.273264][ T8278]  ? __fdget_pos+0x1ab/0x340
> [  366.274037][ T8278]  ksys_write+0x18e/0x2d0
> [  366.274764][ T8278]  ? __pfx_ksys_write+0x10/0x10
> [  366.275579][ T8278]  ? do_syscall_64+0x10a/0x240
> [  366.276380][ T8278]  ? do_syscall_64+0xb6/0x240
> [  366.277163][ T8278]  do_syscall_64+0xfb/0x240
> [  366.277941][ T8278]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> [  366.278936][ T8278] RIP: 0033:0x437e19
> [  366.279595][ T8278] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19
> 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8
> [  366.282676][ T8278] RSP: 002b:00007fffdedc7398 EFLAGS: 00000207
> ORIG_RAX: 0000000000000001
> [  366.284047][ T8278] RAX: ffffffffffffffda RBX: 00000000200001f8
> RCX: 0000000000437e19
> [  366.285331][ T8278] RDX: 0000000000000010 RSI: 0000000020000440
> RDI: 0000000000000004
> [  366.286615][ T8278] RBP: 00007fffdedc73c0 R08: 0000000000000000
> R09: 0000000000000000
> [  366.287918][ T8278] R10: 0000000000000000 R11: 0000000000000207
> R12: 0000000000000001
> [  366.289206][ T8278] R13: 00007fffdedc75e8 R14: 0000000000000001
> R15: 0000000000000001
> [  366.290513][ T8278]  </TASK>
> 
> 
> =* repro.c =*
> #define _GNU_SOURCE
> 
> #include <arpa/inet.h>
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <net/if.h>
> #include <net/if_arp.h>
> #include <netinet/in.h>
> #include <sched.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/ioctl.h>
> #include <sys/mount.h>
> #include <sys/prctl.h>
> #include <sys/resource.h>
> #include <sys/socket.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/time.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
> 
> #include <linux/capability.h>
> #include <linux/genetlink.h>
> #include <linux/if_addr.h>
> #include <linux/if_ether.h>
> #include <linux/if_link.h>
> #include <linux/if_tun.h>
> #include <linux/in6.h>
> #include <linux/ip.h>
> #include <linux/neighbour.h>
> #include <linux/net.h>
> #include <linux/netlink.h>
> #include <linux/rtnetlink.h>
> #include <linux/tcp.h>
> #include <linux/veth.h>
> 
> static void sleep_ms(uint64_t ms) {
>   usleep(ms * 1000);
> }
> 
> static uint64_t current_time_ms(void) {
>   struct timespec ts;
>   if (clock_gettime(CLOCK_MONOTONIC, &ts))
>     exit(1);
>   return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
> 
> static bool write_file(const char* file, const char* what, ...) {
>   char buf[1024];
>   va_list args;
>   va_start(args, what);
>   vsnprintf(buf, sizeof(buf), what, args);
>   va_end(args);
>   buf[sizeof(buf) - 1] = 0;
>   int len = strlen(buf);
>   int fd = open(file, O_WRONLY | O_CLOEXEC);
>   if (fd == -1)
>     return false;
>   if (write(fd, buf, len) != len) {
>     int err = errno;
>     close(fd);
>     errno = err;
>     return false;
>   }
>   close(fd);
>   return true;
> }
> 
> struct nlmsg {
>   char* pos;
>   int nesting;
>   struct nlattr* nested[8];
>   char buf[4096];
> };
> 
> static void netlink_init(struct nlmsg* nlmsg,
>                          int typ,
>                          int flags,
>                          const void* data,
>                          int size) {
>   memset(nlmsg, 0, sizeof(*nlmsg));
>   struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
>   hdr->nlmsg_type = typ;
>   hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
>   memcpy(hdr + 1, data, size);
>   nlmsg->pos = (char*)(hdr + 1) + NLMSG_ALIGN(size);
> }
> 
> static void netlink_attr(struct nlmsg* nlmsg,
>                          int typ,
>                          const void* data,
>                          int size) {
>   struct nlattr* attr = (struct nlattr*)nlmsg->pos;
>   attr->nla_len = sizeof(*attr) + size;
>   attr->nla_type = typ;
>   if (size > 0)
>     memcpy(attr + 1, data, size);
>   nlmsg->pos += NLMSG_ALIGN(attr->nla_len);
> }
> 
> static int netlink_send_ext(struct nlmsg* nlmsg,
>                             int sock,
>                             uint16_t reply_type,
>                             int* reply_len,
>                             bool dofail) {
>   if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting)
>     exit(1);
>   struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
>   hdr->nlmsg_len = nlmsg->pos - nlmsg->buf;
>   struct sockaddr_nl addr;
>   memset(&addr, 0, sizeof(addr));
>   addr.nl_family = AF_NETLINK;
>   ssize_t n = sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
>                      (struct sockaddr*)&addr, sizeof(addr));
>   if (n != (ssize_t)hdr->nlmsg_len) {
>     if (dofail)
>       exit(1);
>     return -1;
>   }
>   n = recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
>   if (reply_len)
>     *reply_len = 0;
>   if (n < 0) {
>     if (dofail)
>       exit(1);
>     return -1;
>   }
>   if (n < (ssize_t)sizeof(struct nlmsghdr)) {
>     errno = EINVAL;
>     if (dofail)
>       exit(1);
>     return -1;
>   }
>   if (hdr->nlmsg_type == NLMSG_DONE)
>     return 0;
>   if (reply_len && hdr->nlmsg_type == reply_type) {
>     *reply_len = n;
>     return 0;
>   }
>   if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))) {
>     errno = EINVAL;
>     if (dofail)
>       exit(1);
>     return -1;
>   }
>   if (hdr->nlmsg_type != NLMSG_ERROR) {
>     errno = EINVAL;
>     if (dofail)
>       exit(1);
>     return -1;
>   }
>   errno = -((struct nlmsgerr*)(hdr + 1))->error;
>   return -errno;
> }
> 
> static int netlink_send(struct nlmsg* nlmsg, int sock) {
>   return netlink_send_ext(nlmsg, sock, 0, NULL, true);
> }
> 
> static int netlink_query_family_id(struct nlmsg* nlmsg,
>                                    int sock,
>                                    const char* family_name,
>                                    bool dofail) {
>   struct genlmsghdr genlhdr;
>   memset(&genlhdr, 0, sizeof(genlhdr));
>   genlhdr.cmd = CTRL_CMD_GETFAMILY;
>   netlink_init(nlmsg, GENL_ID_CTRL, 0, &genlhdr, sizeof(genlhdr));
>   netlink_attr(nlmsg, CTRL_ATTR_FAMILY_NAME, family_name,
>                strnlen(family_name, GENL_NAMSIZ - 1) + 1);
>   int n = 0;
>   int err = netlink_send_ext(nlmsg, sock, GENL_ID_CTRL, &n, dofail);
>   if (err < 0) {
>     return -1;
>   }
>   uint16_t id = 0;
>   struct nlattr* attr = (struct nlattr*)(nlmsg->buf + NLMSG_HDRLEN +
>                                          NLMSG_ALIGN(sizeof(genlhdr)));
>   for (; (char*)attr < nlmsg->buf + n;
>        attr = (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) {
>     if (attr->nla_type == CTRL_ATTR_FAMILY_ID) {
>       id = *(uint16_t*)(attr + 1);
>       break;
>     }
>   }
>   if (!id) {
>     errno = EINVAL;
>     return -1;
>   }
>   recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
>   return id;
> }
> 
> static void netlink_device_change(struct nlmsg* nlmsg,
>                                   int sock,
>                                   const char* name,
>                                   bool up,
>                                   const char* master,
>                                   const void* mac,
>                                   int macsize,
>                                   const char* new_name) {
>   struct ifinfomsg hdr;
>   memset(&hdr, 0, sizeof(hdr));
>   if (up)
>     hdr.ifi_flags = hdr.ifi_change = IFF_UP;
>   hdr.ifi_index = if_nametoindex(name);
>   netlink_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
>   if (new_name)
>     netlink_attr(nlmsg, IFLA_IFNAME, new_name, strlen(new_name));
>   if (master) {
>     int ifindex = if_nametoindex(master);
>     netlink_attr(nlmsg, IFLA_MASTER, &ifindex, sizeof(ifindex));
>   }
>   if (macsize)
>     netlink_attr(nlmsg, IFLA_ADDRESS, mac, macsize);
>   int err = netlink_send(nlmsg, sock);
>   if (err < 0) {
>   }
> }
> 
> static int netlink_add_addr(struct nlmsg* nlmsg,
>                             int sock,
>                             const char* dev,
>                             const void* addr,
>                             int addrsize) {
>   struct ifaddrmsg hdr;
>   memset(&hdr, 0, sizeof(hdr));
>   hdr.ifa_family = addrsize == 4 ? AF_INET : AF_INET6;
>   hdr.ifa_prefixlen = addrsize == 4 ? 24 : 120;
>   hdr.ifa_scope = RT_SCOPE_UNIVERSE;
>   hdr.ifa_index = if_nametoindex(dev);
>   netlink_init(nlmsg, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr,
>                sizeof(hdr));
>   netlink_attr(nlmsg, IFA_LOCAL, addr, addrsize);
>   netlink_attr(nlmsg, IFA_ADDRESS, addr, addrsize);
>   return netlink_send(nlmsg, sock);
> }
> 
> static void netlink_add_addr4(struct nlmsg* nlmsg,
>                               int sock,
>                               const char* dev,
>                               const char* addr) {
>   struct in_addr in_addr;
>   inet_pton(AF_INET, addr, &in_addr);
>   int err = netlink_add_addr(nlmsg, sock, dev, &in_addr, sizeof(in_addr));
>   if (err < 0) {
>   }
> }
> 
> static void netlink_add_addr6(struct nlmsg* nlmsg,
>                               int sock,
>                               const char* dev,
>                               const char* addr) {
>   struct in6_addr in6_addr;
>   inet_pton(AF_INET6, addr, &in6_addr);
>   int err = netlink_add_addr(nlmsg, sock, dev, &in6_addr, sizeof(in6_addr));
>   if (err < 0) {
>   }
> }
> 
> static void netlink_add_neigh(struct nlmsg* nlmsg,
>                               int sock,
>                               const char* name,
>                               const void* addr,
>                               int addrsize,
>                               const void* mac,
>                               int macsize) {
>   struct ndmsg hdr;
>   memset(&hdr, 0, sizeof(hdr));
>   hdr.ndm_family = addrsize == 4 ? AF_INET : AF_INET6;
>   hdr.ndm_ifindex = if_nametoindex(name);
>   hdr.ndm_state = NUD_PERMANENT;
>   netlink_init(nlmsg, RTM_NEWNEIGH, NLM_F_EXCL | NLM_F_CREATE, &hdr,
>                sizeof(hdr));
>   netlink_attr(nlmsg, NDA_DST, addr, addrsize);
>   netlink_attr(nlmsg, NDA_LLADDR, mac, macsize);
>   int err = netlink_send(nlmsg, sock);
>   if (err < 0) {
>   }
> }
> 
> static struct nlmsg nlmsg;
> 
> static int tunfd = -1;
> 
> #define TUN_IFACE "syz_tun"
> #define LOCAL_MAC 0xaaaaaaaaaaaa
> #define REMOTE_MAC 0xaaaaaaaaaabb
> #define LOCAL_IPV4 "172.20.20.170"
> #define REMOTE_IPV4 "172.20.20.187"
> #define LOCAL_IPV6 "fe80::aa"
> #define REMOTE_IPV6 "fe80::bb"
> 
> #define IFF_NAPI 0x0010
> 
> static void initialize_tun(void) {
>   tunfd = open("/dev/net/tun", O_RDWR | O_NONBLOCK);
>   if (tunfd == -1) {
>     printf("tun: can't open /dev/net/tun: please enable CONFIG_TUN=y\n");
>     printf("otherwise fuzzing or reproducing might not work as intended\n");
>     return;
>   }
>   const int kTunFd = 200;
>   if (dup2(tunfd, kTunFd) < 0)
>     exit(1);
>   close(tunfd);
>   tunfd = kTunFd;
>   struct ifreq ifr;
>   memset(&ifr, 0, sizeof(ifr));
>   strncpy(ifr.ifr_name, TUN_IFACE, IFNAMSIZ);
>   ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
>   if (ioctl(tunfd, TUNSETIFF, (void*)&ifr) < 0) {
>     exit(1);
>   }
>   char sysctl[64];
>   sprintf(sysctl, "/proc/sys/net/ipv6/conf/%s/accept_dad", TUN_IFACE);
>   write_file(sysctl, "0");
>   sprintf(sysctl, "/proc/sys/net/ipv6/conf/%s/router_solicitations", TUN_IFACE);
>   write_file(sysctl, "0");
>   int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
>   if (sock == -1)
>     exit(1);
>   netlink_add_addr4(&nlmsg, sock, TUN_IFACE, LOCAL_IPV4);
>   netlink_add_addr6(&nlmsg, sock, TUN_IFACE, LOCAL_IPV6);
>   uint64_t macaddr = REMOTE_MAC;
>   struct in_addr in_addr;
>   inet_pton(AF_INET, REMOTE_IPV4, &in_addr);
>   netlink_add_neigh(&nlmsg, sock, TUN_IFACE, &in_addr, sizeof(in_addr),
>                     &macaddr, ETH_ALEN);
>   struct in6_addr in6_addr;
>   inet_pton(AF_INET6, REMOTE_IPV6, &in6_addr);
>   netlink_add_neigh(&nlmsg, sock, TUN_IFACE, &in6_addr, sizeof(in6_addr),
>                     &macaddr, ETH_ALEN);
>   macaddr = LOCAL_MAC;
>   netlink_device_change(&nlmsg, sock, TUN_IFACE, true, 0, &macaddr, ETH_ALEN,
>                         NULL);
>   close(sock);
> }
> 
> static int read_tun(char* data, int size) {
>   if (tunfd < 0)
>     return -1;
>   int rv = read(tunfd, data, size);
>   if (rv < 0) {
>     if (errno == EAGAIN || errno == EBADFD)
>       return -1;
>     exit(1);
>   }
>   return rv;
> }
> 
> static void flush_tun() {
>   char data[1000];
>   while (read_tun(&data[0], sizeof(data)) != -1) {
>   }
> }
> 
> #define MAX_FDS 30
> 
> static void setup_common() {
>   if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
>   }
> }
> 
> static void setup_binderfs() {
>   if (mkdir("/dev/binderfs", 0777)) {
>   }
>   if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
>   }
>   if (symlink("/dev/binderfs", "./binderfs")) {
>   }
> }
> 
> static void loop();
> 
> static void sandbox_common() {
>   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>   setsid();
>   struct rlimit rlim;
>   rlim.rlim_cur = rlim.rlim_max = (200 << 20);
>   setrlimit(RLIMIT_AS, &rlim);
>   rlim.rlim_cur = rlim.rlim_max = 32 << 20;
>   setrlimit(RLIMIT_MEMLOCK, &rlim);
>   rlim.rlim_cur = rlim.rlim_max = 136 << 20;
>   setrlimit(RLIMIT_FSIZE, &rlim);
>   rlim.rlim_cur = rlim.rlim_max = 1 << 20;
>   setrlimit(RLIMIT_STACK, &rlim);
>   rlim.rlim_cur = rlim.rlim_max = 128 << 20;
>   setrlimit(RLIMIT_CORE, &rlim);
>   rlim.rlim_cur = rlim.rlim_max = 256;
>   setrlimit(RLIMIT_NOFILE, &rlim);
>   if (unshare(CLONE_NEWNS)) {
>   }
>   if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
>   }
>   if (unshare(CLONE_NEWIPC)) {
>   }
>   if (unshare(0x02000000)) {
>   }
>   if (unshare(CLONE_NEWUTS)) {
>   }
>   if (unshare(CLONE_SYSVSEM)) {
>   }
>   typedef struct {
>     const char* name;
>     const char* value;
>   } sysctl_t;
>   static const sysctl_t sysctls[] = {
>       {"/proc/sys/kernel/shmmax", "16777216"},
>       {"/proc/sys/kernel/shmall", "536870912"},
>       {"/proc/sys/kernel/shmmni", "1024"},
>       {"/proc/sys/kernel/msgmax", "8192"},
>       {"/proc/sys/kernel/msgmni", "1024"},
>       {"/proc/sys/kernel/msgmnb", "1024"},
>       {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
>   };
>   unsigned i;
>   for (i = 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
>     write_file(sysctls[i].name, sysctls[i].value);
> }
> 
> static int wait_for_loop(int pid) {
>   if (pid < 0)
>     exit(1);
>   int status = 0;
>   while (waitpid(-1, &status, __WALL) != pid) {
>   }
>   return WEXITSTATUS(status);
> }
> 
> static void drop_caps(void) {
>   struct __user_cap_header_struct cap_hdr = {};
>   struct __user_cap_data_struct cap_data[2] = {};
>   cap_hdr.version = _LINUX_CAPABILITY_VERSION_3;
>   cap_hdr.pid = getpid();
>   if (syscall(SYS_capget, &cap_hdr, &cap_data))
>     exit(1);
>   const int drop = (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
>   cap_data[0].effective &= ~drop;
>   cap_data[0].permitted &= ~drop;
>   cap_data[0].inheritable &= ~drop;
>   if (syscall(SYS_capset, &cap_hdr, &cap_data))
>     exit(1);
> }
> 
> static int do_sandbox_none(void) {
>   if (unshare(CLONE_NEWPID)) {
>   }
>   int pid = fork();
>   if (pid != 0)
>     return wait_for_loop(pid);
>   setup_common();
>   sandbox_common();
>   drop_caps();
>   if (unshare(CLONE_NEWNET)) {
>   }
>   write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
>   initialize_tun();
>   setup_binderfs();
>   loop();
>   exit(1);
> }
> 
> static void kill_and_wait(int pid, int* status) {
>   kill(-pid, SIGKILL);
>   kill(pid, SIGKILL);
>   for (int i = 0; i < 100; i++) {
>     if (waitpid(-1, status, WNOHANG | __WALL) == pid)
>       return;
>     usleep(1000);
>   }
>   DIR* dir = opendir("/sys/fs/fuse/connections");
>   if (dir) {
>     for (;;) {
>       struct dirent* ent = readdir(dir);
>       if (!ent)
>         break;
>       if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
>         continue;
>       char abort[300];
>       snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>                ent->d_name);
>       int fd = open(abort, O_WRONLY);
>       if (fd == -1) {
>         continue;
>       }
>       if (write(fd, abort, 1) < 0) {
>       }
>       close(fd);
>     }
>     closedir(dir);
>   } else {
>   }
>   while (waitpid(-1, status, __WALL) != pid) {
>   }
> }
> 
> static void setup_test() {
>   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>   setpgrp();
>   write_file("/proc/self/oom_score_adj", "1000");
>   flush_tun();
> }
> 
> static void close_fds() {
>   for (int fd = 3; fd < MAX_FDS; fd++)
>     close(fd);
> }
> 
> static void execute_one(void);
> 
> #define WAIT_FLAGS __WALL
> 
> static void loop(void) {
>   int iter = 0;
>   for (;; iter++) {
>     int pid = fork();
>     if (pid < 0)
>       exit(1);
>     if (pid == 0) {
>       setup_test();
>       execute_one();
>       close_fds();
>       exit(0);
>     }
>     int status = 0;
>     uint64_t start = current_time_ms();
>     for (;;) {
>       if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
>         break;
>       sleep_ms(1);
>       if (current_time_ms() - start < 5000)
>         continue;
>       kill_and_wait(pid, &status);
>       break;
>     }
>   }
> }
> 
> uint64_t r[3] = {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffffff};
> 
> void execute_one(void) {
>   intptr_t res = 0;
>   res = syscall(__NR_socket, /*domain=*/0x10ul, /*type=*/3ul, /*proto=*/0x14);
>   if (res != -1)
>     r[0] = res;
>   *(uint64_t*)0x20000180 = 0;
>   *(uint32_t*)0x20000188 = 0;
>   *(uint64_t*)0x20000190 = 0x20000140;
>   *(uint64_t*)0x20000140 = 0x20000080;
>   *(uint32_t*)0x20000080 = 0x38;
>   *(uint16_t*)0x20000084 = 0x1403;
>   *(uint16_t*)0x20000086 = 1;
>   *(uint32_t*)0x20000088 = 0;
>   *(uint32_t*)0x2000008c = 0;
>   *(uint16_t*)0x20000090 = 9;
>   *(uint16_t*)0x20000092 = 2;
>   memcpy((void*)0x20000094, "syz1\000", 5);
>   *(uint16_t*)0x2000009c = 8;
>   *(uint16_t*)0x2000009e = 0x41;
>   memcpy((void*)0x200000a0, "rxe\000", 4);
>   *(uint16_t*)0x200000a4 = 0x14;
>   *(uint16_t*)0x200000a6 = 0x33;
>   memcpy((void*)0x200000a8, "syz_tun\000\000\000\000\000\000\000\000\000", 16);
>   *(uint64_t*)0x20000148 = 0x38;
>   *(uint64_t*)0x20000198 = 1;
>   *(uint64_t*)0x200001a0 = 0;
>   *(uint64_t*)0x200001a8 = 0;
>   *(uint32_t*)0x200001b0 = 0;
>   syscall(__NR_sendmsg, /*fd=*/r[0], /*msg=*/0x20000180ul, /*f=*/0ul);
>   memcpy((void*)0x20000100, "/dev/infiniband/rdma_cm\000", 24);
>   res = syscall(__NR_openat, /*fd=*/0xffffffffffffff9cul, /*file=*/0x20000100ul,
>                 /*flags=*/2ul, /*mode=*/0ul);
>   if (res != -1)
>     r[1] = res;
>   *(uint32_t*)0x20000080 = 0;
>   *(uint16_t*)0x20000084 = 0x18;
>   *(uint16_t*)0x20000086 = 0xfa00;
>   *(uint64_t*)0x20000088 = 0;
>   *(uint64_t*)0x20000090 = 0x200000c0;
>   *(uint16_t*)0x20000098 = 0x106;
>   *(uint8_t*)0x2000009a = 0;
>   memset((void*)0x2000009b, 0, 5);
>   res = syscall(__NR_write, /*fd=*/r[1], /*data=*/0x20000080ul, /*len=*/0x20ul);
>   if (res != -1)
>     r[2] = *(uint32_t*)0x200000c0;
>   *(uint32_t*)0x200003c0 = 3;
>   *(uint16_t*)0x200003c4 = 0x40;
>   *(uint16_t*)0x200003c6 = 0xfa00;
>   *(uint16_t*)0x200003c8 = 0xa;
>   *(uint16_t*)0x200003ca = htobe16(0x4e24);
>   *(uint32_t*)0x200003cc = htobe32(1);
>   *(uint8_t*)0x200003d0 = -1;
>   *(uint8_t*)0x200003d1 = 2;
>   memset((void*)0x200003d2, 0, 13);
>   *(uint8_t*)0x200003df = 1;
>   *(uint32_t*)0x200003e0 = 9;
>   *(uint16_t*)0x200003e4 = 0xa;
>   *(uint16_t*)0x200003e6 = htobe16(0);
>   *(uint32_t*)0x200003e8 = htobe32(6);
>   *(uint8_t*)0x200003ec = 0xfe;
>   *(uint8_t*)0x200003ed = 0x80;
>   memset((void*)0x200003ee, 0, 13);
>   *(uint8_t*)0x200003fb = 0xbb;
>   *(uint32_t*)0x200003fc = 0xfffff000;
>   *(uint32_t*)0x20000400 = r[2];
>   *(uint32_t*)0x20000404 = 2;
>   syscall(__NR_write, /*fd=*/r[1], /*data=*/0x200003c0ul, /*len=*/0x48ul);
>   *(uint32_t*)0x20000140 = 0x15;
>   *(uint16_t*)0x20000144 = 0x110;
>   *(uint16_t*)0x20000146 = 0xfa00;
>   *(uint32_t*)0x20000148 = r[2];
>   *(uint32_t*)0x2000014c = 0;
>   *(uint16_t*)0x20000150 = 0;
>   *(uint16_t*)0x20000152 = 0x30;
>   *(uint32_t*)0x20000154 = 0;
>   *(uint16_t*)0x20000158 = 0x1b;
>   *(uint16_t*)0x2000015a = htobe16(0);
>   *(uint32_t*)0x2000015c = htobe32(0);
>   memset((void*)0x20000160, 0, 16);
>   *(uint32_t*)0x20000170 = 0;
>   *(uint16_t*)0x200001d8 = 0x1b;
>   *(uint16_t*)0x200001da = htobe16(0);
>   *(uint32_t*)0x200001dc = htobe32(0);
>   memset((void*)0x200001e0, 0, 16);
>   *(uint64_t*)0x200001f0 = htobe64(0);
>   *(uint64_t*)0x200001f8 = htobe64(0);
>   *(uint64_t*)0x20000200 = 0;
>   syscall(__NR_write, /*fd=*/r[1], /*data=*/0x20000140ul, /*len=*/0x118ul);
>   *(uint32_t*)0x20000440 = 4;
>   *(uint16_t*)0x20000444 = 8;
>   *(uint16_t*)0x20000446 = 0xfa00;
>   *(uint32_t*)0x20000448 = r[2];
>   *(uint32_t*)0x2000044c = 0xffff741a;
>   syscall(__NR_write, /*fd=*/r[1], /*data=*/0x20000440ul, /*len=*/0x10ul);
> }
> int main(void) {
>   syscall(__NR_mmap, /*addr=*/0x1ffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>           /*offset=*/0ul);
>   syscall(__NR_mmap, /*addr=*/0x20000000ul, /*len=*/0x1000000ul,
>           /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
>           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>           /*offset=*/0ul);
>   syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
>           /*offset=*/0ul);
>   do_sandbox_none();
>   return 0;
> }
> 
> and also  https://gist.github.com/xrivendell7/080e44fad03c27df3152ff3bcc8a8385
> 
> I hope it helps.
> Best regards.
> xingwei Lee


