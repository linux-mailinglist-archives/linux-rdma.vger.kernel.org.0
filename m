Return-Path: <linux-rdma+bounces-1199-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B200786F950
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 05:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3871F2179F
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 04:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC174A3C;
	Mon,  4 Mar 2024 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEcGUdC1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD19566D;
	Mon,  4 Mar 2024 04:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527452; cv=none; b=Qdl1W0TSTVbXoODEoM+5aTVk/phiZ7+dbCXbnGdey43l5RI68MSi2/FqeUkC8zsota3UZmF+6FIYI58b8xxwkSVP3ZVb4eM8Pp0M+/7IBpxBrrEPxLAubDatIHY8InTvR5xJpZot+xMywptHm0N8I5uvpMR7UDjzZvR6jwZ6d/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527452; c=relaxed/simple;
	bh=wV7RT+FK9uBOSHAYGjM9FGsOZ3sQfmFnU+aNgreeIkQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Cl/Fy3WZR3Z4Yd8uM4pQxArWaXZpu+LQqXovgWsSgqfTBnS2js0ir2o/G5vQySkR6zcjaxE0tNw/pXrFC0b0iCMtGYcCJnKSy0PvDFBCjF+kDAR5TP89JikzjfjNSVf0IUZ5uGEy/cFDfjE6X6VIiEy0LI7zkKOkzQDGs9pRTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEcGUdC1; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1ed6abf85so413386b6e.1;
        Sun, 03 Mar 2024 20:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709527450; x=1710132250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T5Lmcl+5DR4eHBBiK5KvVb5NsPNpkMmW2puIOIszKFY=;
        b=XEcGUdC1kksWcpLpr/BCz4yOHaDwTvrg+YEM4pjUGiPMEOwFMUEsLWCfSMXSX7kQ7S
         uhOBR+sSJlgMmoRc1yWShaeHiTYUEEGrwl2GNld9vefgE/tanzCL5eL7FHIS9v8dy4WG
         V4FFdOxFccyvTCleR6HcqQYjtZgEQTBJNOhZJ+DJwePmFKGIOoeEkTwttHzrVfFcj5TS
         fQotHu5nLeXmd/3MPtKvhNBrLyfoarCng1KWtW1596XDizeUHeF0c75NMWKJqwIYaL9O
         d0wyN7zEQn3jgRMhOLW2czQTd8jhRrGTAXt/B7JSHo80ixdB6jiS/eDtwhC/bnfl10Ed
         PoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709527450; x=1710132250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5Lmcl+5DR4eHBBiK5KvVb5NsPNpkMmW2puIOIszKFY=;
        b=bqkv7eHFREK07X9WrmWOCbjcm26iVEBNAivPgopBt3juYBKPg3cQ6Pe/wwI0cKRfKY
         FD/JOLd3PtTpqqDUbm/t3IOnshn9bh/5/GGAx6aDZdXmA69d7MNwg+jGwtZfUlr+IF8d
         ZY7V1l3rSgAjVl3KNRq3C2Uu8F5riTXBVrXgGDXElkaDgdVDLSSqQVutfMxKMDTzeOdK
         M2eq9xPJQEglTVn+++tek7X+cATBD6xK4M2ahVuaUJVYMTh1sJ59GFxnUnF9twY/pm08
         GvwZp5KI3VUJNr9/dg/mbn3UsTyuIK9U8zmyf4bYNmFEC9gwuLsfFHqyl2hW04pnMXNr
         pf7g==
X-Forwarded-Encrypted: i=1; AJvYcCVNiEP2Pz/cN08OyLTe6/F1gv4pXOW63SMytWuTnb9JC0L9BhTMCekHOigymJYrPsbFB5XDKoYVlYBYKRVkRPoqvNcPGzbEZzSE8PpXldZ2KAsB2ZSchY8nsf5+GNWvYtk9pd9CC9LrfsKYCy5P5H9w3ISHpJnUVSwdS5GrD18ntQ==
X-Gm-Message-State: AOJu0Yy3cwimvI6Ch1/kZowSN/+23738qazhgP3dj1XCqG9bOrYCzZoS
	Om05tCzm/s2HWG/rISxzgvWXRdOHDtJJQbhbQgiAsiIo4XsRoS04qnC4+uWL7BR40P6ag8kCg+e
	C+EXf4JL5zt1MsYCPHQsFJxP84c4IVWQkvn7hGQ==
X-Google-Smtp-Source: AGHT+IFJQaAbKlH/CGtPjMIeAFmqFB3UyUqUyqGjcq/yXrLooyiMp7+UuRDRFRRS7AV/RfEdlYc9uVx2/1iihobCIo4=
X-Received: by 2002:a05:6808:220c:b0:3c1:9fde:8ee4 with SMTP id
 bd12-20020a056808220c00b003c19fde8ee4mr10883376oib.29.1709527449503; Sun, 03
 Mar 2024 20:44:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: xingwei lee <xrivendell7@gmail.com>
Date: Mon, 4 Mar 2024 12:43:57 +0800
Message-ID: <CABOYnLxCWaVx=SH8efXxj8d9YPjnw8C9LUTs6gDnxeeOHt68tg@mail.gmail.com>
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in rdma_resolve_route
To: syzbot+a2e2735f09ebb9d95bd1@syzkaller.appspotmail.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, samsun1006219@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Yanjun I reproduced this bug and comfired, it may help your to
test your patch.
As always, I uploaded it here.

If you fix this issue, please add the following tag to the reporter or
reproducer:
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: sam sun <samsun1006219@gmail.com>

I use the same configuation with syzbot dashboard.
kernel version: linux-next 2c3b09aac00d7835023bbc4473ee06696be64fa8
kernel config: syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D176d2dcbf8=
ba7017
<http://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D176d2dcbf8ba7017>
with KASAN enabled
compiler: Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.4=
0

Likewise, this bug has more than one title, in my environment=EF=BC=8C thes=
e
titles are also relevant to this bug:
KASAN: slab-use-after-free Read in cma_netevent_callback
KASAN: slab-use-after-free Read in _destroy_id
KASAN: slab-use-after-free in cma_add_id_to_tree
KASAN: slab-use-after-free in compare_netdev_and_ip

root@syzkaller:~# ./925-7
[  364.962016][ T8201] infiniband syz1: set active
[  364.963857][ T8201] infiniband syz1: added syz_tun
[  365.004959][ T8201] RDS/IB: syz1: added
[  365.006131][ T8201] smc: adding ib device syz1 with port count 1
[  365.007313][ T8201] smc:    ib device syz1 port 1 has pnetid
[  365.170043][ T8210] syz1: rxe_newlink: already configured on syz_tun
[  365.190827][ T8211] syz1: rxe_newlink: already configured on syz_tun
[  365.213461][ T8212] syz1: rxe_newlink: already configured on syz_tun
[  365.232342][ T8213] syz1: rxe_newlink: already configured on syz_tun
[  365.243876][ T8214] syz1: rxe_newlink: already configured on syz_tun
[  365.258450][ T8215] syz1: rxe_newlink: already configured on syz_tun
[  365.287755][ T8216] syz1: rxe_newlink: already configured on syz_tun
[  365.307337][ T8217] syz1: rxe_newlink: already configured on syz_tun
[  365.325342][ T8218] syz1: rxe_newlink: already configured on syz_tun
[  365.337734][ T8219] syz1: rxe_newlink: already configured on syz_tun
[  366.230237][ T8278]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  366.231886][ T8278] BUG: KASAN: slab-use-after-free in
rdma_resolve_route+0x2524/0x32a0
[  366.234250][ T8278] Read of size 4 at addr ffff88801ff02184 by task
925-7/8278
[  366.235595][ T8278]
[  366.236068][ T8278] CPU: 0 PID: 8278 Comm: 925-7 Not tainted
6.8.0-rc4-next-20240214 #1
[  366.237492][ T8278] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  366.239327][ T8278] Call Trace:
[  366.239941][ T8278]  <TASK>
[  366.240469][ T8278]  dump_stack_lvl+0x250/0x380
[  366.242198][ T8278]  ? __pfx_dump_stack_lvl+0x10/0x10
[  366.243109][ T8278]  ? __pfx__printk+0x10/0x10
[  366.243934][ T8278]  ? _printk+0xda/0x120
[  366.244679][ T8278]  ? __virt_addr_valid+0x19b/0x580
[  366.245583][ T8278]  ? __virt_addr_valid+0x19b/0x580
[  366.246482][ T8278]  print_report+0x169/0x550
[  366.247290][ T8278]  ? __virt_addr_valid+0x19b/0x580
[  366.248202][ T8278]  ? __virt_addr_valid+0x19b/0x580
[  366.249100][ T8278]  ? __virt_addr_valid+0x4a8/0x580
[  366.250003][ T8278]  ? __phys_addr+0xc3/0x180
[  366.250822][ T8278]  ? rdma_resolve_route+0x2524/0x32a0
[  366.251840][ T8278]  kasan_report+0x143/0x180
[  366.252635][ T8278]  ? _raw_spin_lock_irqsave+0xe1/0x120
[  366.253586][ T8278]  ? rdma_resolve_route+0x2524/0x32a0
[  366.254542][ T8278]  rdma_resolve_route+0x2524/0x32a0
[  366.255476][ T8278]  ? __mutex_lock+0x2ef/0xd70
[  366.256304][ T8278]  ? __pfx_rdma_resolve_route+0x10/0x10
[  366.257284][ T8278]  ? __pfx___mutex_lock+0x10/0x10
[  366.258168][ T8278]  ? ucma_get_ctx+0x29f/0x3b0
[  366.259002][ T8278]  ? __pfx_ucma_get_ctx+0x10/0x10
[  366.259901][ T8278]  ? __might_fault+0xcf/0x130
[  366.260718][ T8278]  ucma_resolve_route+0x1c3/0x330
[  366.261581][ T8278]  ? __pfx_ucma_resolve_route+0x10/0x10
[  366.262524][ T8278]  ? __might_fault+0xcf/0x130
[  366.263324][ T8278]  ? __pfx_ucma_resolve_route+0x10/0x10
[  366.264273][ T8278]  ucma_write+0x2f0/0x440
[  366.264998][ T8278]  ? __pfx_ucma_write+0x10/0x10
[  366.265802][ T8278]  ? bpf_lsm_file_permission+0xe/0x20
[  366.266701][ T8278]  ? rw_verify_area+0x1e7/0x5b0
[  366.267543][ T8278]  ? __pfx_ucma_write+0x10/0x10
[  366.268341][ T8278]  vfs_write+0x2b3/0xcf0
[  366.269044][ T8278]  ? kasan_quarantine_put+0xdc/0x230
[  366.269917][ T8278]  ? lockdep_hardirqs_on+0x99/0x150
[  366.270784][ T8278]  ? __pfx_vfs_write+0x10/0x10
[  366.271587][ T8278]  ? do_sys_openat2+0x160/0x1c0
[  366.272398][ T8278]  ? __pfx_do_sys_openat2+0x10/0x10
[  366.273264][ T8278]  ? __fdget_pos+0x1ab/0x340
[  366.274037][ T8278]  ksys_write+0x18e/0x2d0
[  366.274764][ T8278]  ? __pfx_ksys_write+0x10/0x10
[  366.275579][ T8278]  ? do_syscall_64+0x10a/0x240
[  366.276380][ T8278]  ? do_syscall_64+0xb6/0x240
[  366.277163][ T8278]  do_syscall_64+0xfb/0x240
[  366.277941][ T8278]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
[  366.278936][ T8278] RIP: 0033:0x437e19
[  366.279595][ T8278] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19
00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8
[  366.282676][ T8278] RSP: 002b:00007fffdedc7398 EFLAGS: 00000207
ORIG_RAX: 0000000000000001
[  366.284047][ T8278] RAX: ffffffffffffffda RBX: 00000000200001f8
RCX: 0000000000437e19
[  366.285331][ T8278] RDX: 0000000000000010 RSI: 0000000020000440
RDI: 0000000000000004
[  366.286615][ T8278] RBP: 00007fffdedc73c0 R08: 0000000000000000
R09: 0000000000000000
[  366.287918][ T8278] R10: 0000000000000000 R11: 0000000000000207
R12: 0000000000000001
[  366.289206][ T8278] R13: 00007fffdedc75e8 R14: 0000000000000001
R15: 0000000000000001
[  366.290513][ T8278]  </TASK>


=3D* repro.c =3D*
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <netinet/in.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/capability.h>
#include <linux/genetlink.h>
#include <linux/if_addr.h>
#include <linux/if_ether.h>
#include <linux/if_link.h>
#include <linux/if_tun.h>
#include <linux/in6.h>
#include <linux/ip.h>
#include <linux/neighbour.h>
#include <linux/net.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/tcp.h>
#include <linux/veth.h>

static void sleep_ms(uint64_t ms) {
 usleep(ms * 1000);
}

static uint64_t current_time_ms(void) {
 struct timespec ts;
 if (clock_gettime(CLOCK_MONOTONIC, &ts))
   exit(1);
 return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...) {
 char buf[1024];
 va_list args;
 va_start(args, what);
 vsnprintf(buf, sizeof(buf), what, args);
 va_end(args);
 buf[sizeof(buf) - 1] =3D 0;
 int len =3D strlen(buf);
 int fd =3D open(file, O_WRONLY | O_CLOEXEC);
 if (fd =3D=3D -1)
   return false;
 if (write(fd, buf, len) !=3D len) {
   int err =3D errno;
   close(fd);
   errno =3D err;
   return false;
 }
 close(fd);
 return true;
}

struct nlmsg {
 char* pos;
 int nesting;
 struct nlattr* nested[8];
 char buf[4096];
};

static void netlink_init(struct nlmsg* nlmsg,
                        int typ,
                        int flags,
                        const void* data,
                        int size) {
 memset(nlmsg, 0, sizeof(*nlmsg));
 struct nlmsghdr* hdr =3D (struct nlmsghdr*)nlmsg->buf;
 hdr->nlmsg_type =3D typ;
 hdr->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | flags;
 memcpy(hdr + 1, data, size);
 nlmsg->pos =3D (char*)(hdr + 1) + NLMSG_ALIGN(size);
}

static void netlink_attr(struct nlmsg* nlmsg,
                        int typ,
                        const void* data,
                        int size) {
 struct nlattr* attr =3D (struct nlattr*)nlmsg->pos;
 attr->nla_len =3D sizeof(*attr) + size;
 attr->nla_type =3D typ;
 if (size > 0)
   memcpy(attr + 1, data, size);
 nlmsg->pos +=3D NLMSG_ALIGN(attr->nla_len);
}

static int netlink_send_ext(struct nlmsg* nlmsg,
                           int sock,
                           uint16_t reply_type,
                           int* reply_len,
                           bool dofail) {
 if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting)
   exit(1);
 struct nlmsghdr* hdr =3D (struct nlmsghdr*)nlmsg->buf;
 hdr->nlmsg_len =3D nlmsg->pos - nlmsg->buf;
 struct sockaddr_nl addr;
 memset(&addr, 0, sizeof(addr));
 addr.nl_family =3D AF_NETLINK;
 ssize_t n =3D sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
                    (struct sockaddr*)&addr, sizeof(addr));
 if (n !=3D (ssize_t)hdr->nlmsg_len) {
   if (dofail)
     exit(1);
   return -1;
 }
 n =3D recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
 if (reply_len)
   *reply_len =3D 0;
 if (n < 0) {
   if (dofail)
     exit(1);
   return -1;
 }
 if (n < (ssize_t)sizeof(struct nlmsghdr)) {
   errno =3D EINVAL;
   if (dofail)
     exit(1);
   return -1;
 }
 if (hdr->nlmsg_type =3D=3D NLMSG_DONE)
   return 0;
 if (reply_len && hdr->nlmsg_type =3D=3D reply_type) {
   *reply_len =3D n;
   return 0;
 }
 if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))) {
   errno =3D EINVAL;
   if (dofail)
     exit(1);
   return -1;
 }
 if (hdr->nlmsg_type !=3D NLMSG_ERROR) {
   errno =3D EINVAL;
   if (dofail)
     exit(1);
   return -1;
 }
 errno =3D -((struct nlmsgerr*)(hdr + 1))->error;
 return -errno;
}

static int netlink_send(struct nlmsg* nlmsg, int sock) {
 return netlink_send_ext(nlmsg, sock, 0, NULL, true);
}

static int netlink_query_family_id(struct nlmsg* nlmsg,
                                  int sock,
                                  const char* family_name,
                                  bool dofail) {
 struct genlmsghdr genlhdr;
 memset(&genlhdr, 0, sizeof(genlhdr));
 genlhdr.cmd =3D CTRL_CMD_GETFAMILY;
 netlink_init(nlmsg, GENL_ID_CTRL, 0, &genlhdr, sizeof(genlhdr));
 netlink_attr(nlmsg, CTRL_ATTR_FAMILY_NAME, family_name,
              strnlen(family_name, GENL_NAMSIZ - 1) + 1);
 int n =3D 0;
 int err =3D netlink_send_ext(nlmsg, sock, GENL_ID_CTRL, &n, dofail);
 if (err < 0) {
   return -1;
 }
 uint16_t id =3D 0;
 struct nlattr* attr =3D (struct nlattr*)(nlmsg->buf + NLMSG_HDRLEN +
                                        NLMSG_ALIGN(sizeof(genlhdr)));
 for (; (char*)attr < nlmsg->buf + n;
      attr =3D (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) =
{
   if (attr->nla_type =3D=3D CTRL_ATTR_FAMILY_ID) {
     id =3D *(uint16_t*)(attr + 1);
     break;
   }
 }
 if (!id) {
   errno =3D EINVAL;
   return -1;
 }
 recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
 return id;
}

static void netlink_device_change(struct nlmsg* nlmsg,
                                 int sock,
                                 const char* name,
                                 bool up,
                                 const char* master,
                                 const void* mac,
                                 int macsize,
                                 const char* new_name) {
 struct ifinfomsg hdr;
 memset(&hdr, 0, sizeof(hdr));
 if (up)
   hdr.ifi_flags =3D hdr.ifi_change =3D IFF_UP;
 hdr.ifi_index =3D if_nametoindex(name);
 netlink_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
 if (new_name)
   netlink_attr(nlmsg, IFLA_IFNAME, new_name, strlen(new_name));
 if (master) {
   int ifindex =3D if_nametoindex(master);
   netlink_attr(nlmsg, IFLA_MASTER, &ifindex, sizeof(ifindex));
 }
 if (macsize)
   netlink_attr(nlmsg, IFLA_ADDRESS, mac, macsize);
 int err =3D netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static int netlink_add_addr(struct nlmsg* nlmsg,
                           int sock,
                           const char* dev,
                           const void* addr,
                           int addrsize) {
 struct ifaddrmsg hdr;
 memset(&hdr, 0, sizeof(hdr));
 hdr.ifa_family =3D addrsize =3D=3D 4 ? AF_INET : AF_INET6;
 hdr.ifa_prefixlen =3D addrsize =3D=3D 4 ? 24 : 120;
 hdr.ifa_scope =3D RT_SCOPE_UNIVERSE;
 hdr.ifa_index =3D if_nametoindex(dev);
 netlink_init(nlmsg, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr,
              sizeof(hdr));
 netlink_attr(nlmsg, IFA_LOCAL, addr, addrsize);
 netlink_attr(nlmsg, IFA_ADDRESS, addr, addrsize);
 return netlink_send(nlmsg, sock);
}

static void netlink_add_addr4(struct nlmsg* nlmsg,
                             int sock,
                             const char* dev,
                             const char* addr) {
 struct in_addr in_addr;
 inet_pton(AF_INET, addr, &in_addr);
 int err =3D netlink_add_addr(nlmsg, sock, dev, &in_addr, sizeof(in_addr));
 if (err < 0) {
 }
}

static void netlink_add_addr6(struct nlmsg* nlmsg,
                             int sock,
                             const char* dev,
                             const char* addr) {
 struct in6_addr in6_addr;
 inet_pton(AF_INET6, addr, &in6_addr);
 int err =3D netlink_add_addr(nlmsg, sock, dev, &in6_addr, sizeof(in6_addr)=
);
 if (err < 0) {
 }
}

static void netlink_add_neigh(struct nlmsg* nlmsg,
                             int sock,
                             const char* name,
                             const void* addr,
                             int addrsize,
                             const void* mac,
                             int macsize) {
 struct ndmsg hdr;
 memset(&hdr, 0, sizeof(hdr));
 hdr.ndm_family =3D addrsize =3D=3D 4 ? AF_INET : AF_INET6;
 hdr.ndm_ifindex =3D if_nametoindex(name);
 hdr.ndm_state =3D NUD_PERMANENT;
 netlink_init(nlmsg, RTM_NEWNEIGH, NLM_F_EXCL | NLM_F_CREATE, &hdr,
              sizeof(hdr));
 netlink_attr(nlmsg, NDA_DST, addr, addrsize);
 netlink_attr(nlmsg, NDA_LLADDR, mac, macsize);
 int err =3D netlink_send(nlmsg, sock);
 if (err < 0) {
 }
}

static struct nlmsg nlmsg;

static int tunfd =3D -1;

#define TUN_IFACE "syz_tun"
#define LOCAL_MAC 0xaaaaaaaaaaaa
#define REMOTE_MAC 0xaaaaaaaaaabb
#define LOCAL_IPV4 "172.20.20.170"
#define REMOTE_IPV4 "172.20.20.187"
#define LOCAL_IPV6 "fe80::aa"
#define REMOTE_IPV6 "fe80::bb"

#define IFF_NAPI 0x0010

static void initialize_tun(void) {
 tunfd =3D open("/dev/net/tun", O_RDWR | O_NONBLOCK);
 if (tunfd =3D=3D -1) {
   printf("tun: can't open /dev/net/tun: please enable CONFIG_TUN=3Dy\n");
   printf("otherwise fuzzing or reproducing might not work as intended\n");
   return;
 }
 const int kTunFd =3D 200;
 if (dup2(tunfd, kTunFd) < 0)
   exit(1);
 close(tunfd);
 tunfd =3D kTunFd;
 struct ifreq ifr;
 memset(&ifr, 0, sizeof(ifr));
 strncpy(ifr.ifr_name, TUN_IFACE, IFNAMSIZ);
 ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI;
 if (ioctl(tunfd, TUNSETIFF, (void*)&ifr) < 0) {
   exit(1);
 }
 char sysctl[64];
 sprintf(sysctl, "/proc/sys/net/ipv6/conf/%s/accept_dad", TUN_IFACE);
 write_file(sysctl, "0");
 sprintf(sysctl, "/proc/sys/net/ipv6/conf/%s/router_solicitations", TUN_IFA=
CE);
 write_file(sysctl, "0");
 int sock =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
 if (sock =3D=3D -1)
   exit(1);
 netlink_add_addr4(&nlmsg, sock, TUN_IFACE, LOCAL_IPV4);
 netlink_add_addr6(&nlmsg, sock, TUN_IFACE, LOCAL_IPV6);
 uint64_t macaddr =3D REMOTE_MAC;
 struct in_addr in_addr;
 inet_pton(AF_INET, REMOTE_IPV4, &in_addr);
 netlink_add_neigh(&nlmsg, sock, TUN_IFACE, &in_addr, sizeof(in_addr),
                   &macaddr, ETH_ALEN);
 struct in6_addr in6_addr;
 inet_pton(AF_INET6, REMOTE_IPV6, &in6_addr);
 netlink_add_neigh(&nlmsg, sock, TUN_IFACE, &in6_addr, sizeof(in6_addr),
                   &macaddr, ETH_ALEN);
 macaddr =3D LOCAL_MAC;
 netlink_device_change(&nlmsg, sock, TUN_IFACE, true, 0, &macaddr, ETH_ALEN=
,
                       NULL);
 close(sock);
}

static int read_tun(char* data, int size) {
 if (tunfd < 0)
   return -1;
 int rv =3D read(tunfd, data, size);
 if (rv < 0) {
   if (errno =3D=3D EAGAIN || errno =3D=3D EBADFD)
     return -1;
   exit(1);
 }
 return rv;
}

static void flush_tun() {
 char data[1000];
 while (read_tun(&data[0], sizeof(data)) !=3D -1) {
 }
}

#define MAX_FDS 30

static void setup_common() {
 if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
 }
}

static void setup_binderfs() {
 if (mkdir("/dev/binderfs", 0777)) {
 }
 if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
 }
 if (symlink("/dev/binderfs", "./binderfs")) {
 }
}

static void loop();

static void sandbox_common() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setsid();
 struct rlimit rlim;
 rlim.rlim_cur =3D rlim.rlim_max =3D (200 << 20);
 setrlimit(RLIMIT_AS, &rlim);
 rlim.rlim_cur =3D rlim.rlim_max =3D 32 << 20;
 setrlimit(RLIMIT_MEMLOCK, &rlim);
 rlim.rlim_cur =3D rlim.rlim_max =3D 136 << 20;
 setrlimit(RLIMIT_FSIZE, &rlim);
 rlim.rlim_cur =3D rlim.rlim_max =3D 1 << 20;
 setrlimit(RLIMIT_STACK, &rlim);
 rlim.rlim_cur =3D rlim.rlim_max =3D 128 << 20;
 setrlimit(RLIMIT_CORE, &rlim);
 rlim.rlim_cur =3D rlim.rlim_max =3D 256;
 setrlimit(RLIMIT_NOFILE, &rlim);
 if (unshare(CLONE_NEWNS)) {
 }
 if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
 }
 if (unshare(CLONE_NEWIPC)) {
 }
 if (unshare(0x02000000)) {
 }
 if (unshare(CLONE_NEWUTS)) {
 }
 if (unshare(CLONE_SYSVSEM)) {
 }
 typedef struct {
   const char* name;
   const char* value;
 } sysctl_t;
 static const sysctl_t sysctls[] =3D {
     {"/proc/sys/kernel/shmmax", "16777216"},
     {"/proc/sys/kernel/shmall", "536870912"},
     {"/proc/sys/kernel/shmmni", "1024"},
     {"/proc/sys/kernel/msgmax", "8192"},
     {"/proc/sys/kernel/msgmni", "1024"},
     {"/proc/sys/kernel/msgmnb", "1024"},
     {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
 };
 unsigned i;
 for (i =3D 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
   write_file(sysctls[i].name, sysctls[i].value);
}

static int wait_for_loop(int pid) {
 if (pid < 0)
   exit(1);
 int status =3D 0;
 while (waitpid(-1, &status, __WALL) !=3D pid) {
 }
 return WEXITSTATUS(status);
}

static void drop_caps(void) {
 struct __user_cap_header_struct cap_hdr =3D {};
 struct __user_cap_data_struct cap_data[2] =3D {};
 cap_hdr.version =3D _LINUX_CAPABILITY_VERSION_3;
 cap_hdr.pid =3D getpid();
 if (syscall(SYS_capget, &cap_hdr, &cap_data))
   exit(1);
 const int drop =3D (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
 cap_data[0].effective &=3D ~drop;
 cap_data[0].permitted &=3D ~drop;
 cap_data[0].inheritable &=3D ~drop;
 if (syscall(SYS_capset, &cap_hdr, &cap_data))
   exit(1);
}

static int do_sandbox_none(void) {
 if (unshare(CLONE_NEWPID)) {
 }
 int pid =3D fork();
 if (pid !=3D 0)
   return wait_for_loop(pid);
 setup_common();
 sandbox_common();
 drop_caps();
 if (unshare(CLONE_NEWNET)) {
 }
 write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
 initialize_tun();
 setup_binderfs();
 loop();
 exit(1);
}

static void kill_and_wait(int pid, int* status) {
 kill(-pid, SIGKILL);
 kill(pid, SIGKILL);
 for (int i =3D 0; i < 100; i++) {
   if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
     return;
   usleep(1000);
 }
 DIR* dir =3D opendir("/sys/fs/fuse/connections");
 if (dir) {
   for (;;) {
     struct dirent* ent =3D readdir(dir);
     if (!ent)
       break;
     if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =3D=
=3D 0)
       continue;
     char abort[300];
     snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
              ent->d_name);
     int fd =3D open(abort, O_WRONLY);
     if (fd =3D=3D -1) {
       continue;
     }
     if (write(fd, abort, 1) < 0) {
     }
     close(fd);
   }
   closedir(dir);
 } else {
 }
 while (waitpid(-1, status, __WALL) !=3D pid) {
 }
}

static void setup_test() {
 prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
 setpgrp();
 write_file("/proc/self/oom_score_adj", "1000");
 flush_tun();
}

static void close_fds() {
 for (int fd =3D 3; fd < MAX_FDS; fd++)
   close(fd);
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void) {
 int iter =3D 0;
 for (;; iter++) {
   int pid =3D fork();
   if (pid < 0)
     exit(1);
   if (pid =3D=3D 0) {
     setup_test();
     execute_one();
     close_fds();
     exit(0);
   }
   int status =3D 0;
   uint64_t start =3D current_time_ms();
   for (;;) {
     if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
       break;
     sleep_ms(1);
     if (current_time_ms() - start < 5000)
       continue;
     kill_and_wait(pid, &status);
     break;
   }
 }
}

uint64_t r[3] =3D {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffffff=
ff};

void execute_one(void) {
 intptr_t res =3D 0;
 res =3D syscall(__NR_socket, /*domain=3D*/0x10ul, /*type=3D*/3ul, /*proto=
=3D*/0x14);
 if (res !=3D -1)
   r[0] =3D res;
 *(uint64_t*)0x20000180 =3D 0;
 *(uint32_t*)0x20000188 =3D 0;
 *(uint64_t*)0x20000190 =3D 0x20000140;
 *(uint64_t*)0x20000140 =3D 0x20000080;
 *(uint32_t*)0x20000080 =3D 0x38;
 *(uint16_t*)0x20000084 =3D 0x1403;
 *(uint16_t*)0x20000086 =3D 1;
 *(uint32_t*)0x20000088 =3D 0;
 *(uint32_t*)0x2000008c =3D 0;
 *(uint16_t*)0x20000090 =3D 9;
 *(uint16_t*)0x20000092 =3D 2;
 memcpy((void*)0x20000094, "syz1\000", 5);
 *(uint16_t*)0x2000009c =3D 8;
 *(uint16_t*)0x2000009e =3D 0x41;
 memcpy((void*)0x200000a0, "rxe\000", 4);
 *(uint16_t*)0x200000a4 =3D 0x14;
 *(uint16_t*)0x200000a6 =3D 0x33;
 memcpy((void*)0x200000a8, "syz_tun\000\000\000\000\000\000\000\000\000", 1=
6);
 *(uint64_t*)0x20000148 =3D 0x38;
 *(uint64_t*)0x20000198 =3D 1;
 *(uint64_t*)0x200001a0 =3D 0;
 *(uint64_t*)0x200001a8 =3D 0;
 *(uint32_t*)0x200001b0 =3D 0;
 syscall(__NR_sendmsg, /*fd=3D*/r[0], /*msg=3D*/0x20000180ul, /*f=3D*/0ul);
 memcpy((void*)0x20000100, "/dev/infiniband/rdma_cm\000", 24);
 res =3D syscall(__NR_openat, /*fd=3D*/0xffffffffffffff9cul, /*file=3D*/0x2=
0000100ul,
               /*flags=3D*/2ul, /*mode=3D*/0ul);
 if (res !=3D -1)
   r[1] =3D res;
 *(uint32_t*)0x20000080 =3D 0;
 *(uint16_t*)0x20000084 =3D 0x18;
 *(uint16_t*)0x20000086 =3D 0xfa00;
 *(uint64_t*)0x20000088 =3D 0;
 *(uint64_t*)0x20000090 =3D 0x200000c0;
 *(uint16_t*)0x20000098 =3D 0x106;
 *(uint8_t*)0x2000009a =3D 0;
 memset((void*)0x2000009b, 0, 5);
 res =3D syscall(__NR_write, /*fd=3D*/r[1], /*data=3D*/0x20000080ul, /*len=
=3D*/0x20ul);
 if (res !=3D -1)
   r[2] =3D *(uint32_t*)0x200000c0;
 *(uint32_t*)0x200003c0 =3D 3;
 *(uint16_t*)0x200003c4 =3D 0x40;
 *(uint16_t*)0x200003c6 =3D 0xfa00;
 *(uint16_t*)0x200003c8 =3D 0xa;
 *(uint16_t*)0x200003ca =3D htobe16(0x4e24);
 *(uint32_t*)0x200003cc =3D htobe32(1);
 *(uint8_t*)0x200003d0 =3D -1;
 *(uint8_t*)0x200003d1 =3D 2;
 memset((void*)0x200003d2, 0, 13);
 *(uint8_t*)0x200003df =3D 1;
 *(uint32_t*)0x200003e0 =3D 9;
 *(uint16_t*)0x200003e4 =3D 0xa;
 *(uint16_t*)0x200003e6 =3D htobe16(0);
 *(uint32_t*)0x200003e8 =3D htobe32(6);
 *(uint8_t*)0x200003ec =3D 0xfe;
 *(uint8_t*)0x200003ed =3D 0x80;
 memset((void*)0x200003ee, 0, 13);
 *(uint8_t*)0x200003fb =3D 0xbb;
 *(uint32_t*)0x200003fc =3D 0xfffff000;
 *(uint32_t*)0x20000400 =3D r[2];
 *(uint32_t*)0x20000404 =3D 2;
 syscall(__NR_write, /*fd=3D*/r[1], /*data=3D*/0x200003c0ul, /*len=3D*/0x48=
ul);
 *(uint32_t*)0x20000140 =3D 0x15;
 *(uint16_t*)0x20000144 =3D 0x110;
 *(uint16_t*)0x20000146 =3D 0xfa00;
 *(uint32_t*)0x20000148 =3D r[2];
 *(uint32_t*)0x2000014c =3D 0;
 *(uint16_t*)0x20000150 =3D 0;
 *(uint16_t*)0x20000152 =3D 0x30;
 *(uint32_t*)0x20000154 =3D 0;
 *(uint16_t*)0x20000158 =3D 0x1b;
 *(uint16_t*)0x2000015a =3D htobe16(0);
 *(uint32_t*)0x2000015c =3D htobe32(0);
 memset((void*)0x20000160, 0, 16);
 *(uint32_t*)0x20000170 =3D 0;
 *(uint16_t*)0x200001d8 =3D 0x1b;
 *(uint16_t*)0x200001da =3D htobe16(0);
 *(uint32_t*)0x200001dc =3D htobe32(0);
 memset((void*)0x200001e0, 0, 16);
 *(uint64_t*)0x200001f0 =3D htobe64(0);
 *(uint64_t*)0x200001f8 =3D htobe64(0);
 *(uint64_t*)0x20000200 =3D 0;
 syscall(__NR_write, /*fd=3D*/r[1], /*data=3D*/0x20000140ul, /*len=3D*/0x11=
8ul);
 *(uint32_t*)0x20000440 =3D 4;
 *(uint16_t*)0x20000444 =3D 8;
 *(uint16_t*)0x20000446 =3D 0xfa00;
 *(uint32_t*)0x20000448 =3D r[2];
 *(uint32_t*)0x2000044c =3D 0xffff741a;
 syscall(__NR_write, /*fd=3D*/r[1], /*data=3D*/0x20000440ul, /*len=3D*/0x10=
ul);
}
int main(void) {
 syscall(__NR_mmap, /*addr=3D*/0x1ffff000ul, /*len=3D*/0x1000ul, /*prot=3D*=
/0ul,
         /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*/-=
1,
         /*offset=3D*/0ul);
 syscall(__NR_mmap, /*addr=3D*/0x20000000ul, /*len=3D*/0x1000000ul,
         /*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
         /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*/-=
1,
         /*offset=3D*/0ul);
 syscall(__NR_mmap, /*addr=3D*/0x21000000ul, /*len=3D*/0x1000ul, /*prot=3D*=
/0ul,
         /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=3D*/-=
1,
         /*offset=3D*/0ul);
 do_sandbox_none();
 return 0;
}

and also  https://gist.github.com/xrivendell7/080e44fad03c27df3152ff3bcc8a8=
385

I hope it helps.
Best regards.
xingwei Lee

