Return-Path: <linux-rdma+bounces-13766-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC11BB4DDA
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Oct 2025 20:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72044189C546
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Oct 2025 18:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451C5272E63;
	Thu,  2 Oct 2025 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r1POFekh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBB2367AE
	for <linux-rdma@vger.kernel.org>; Thu,  2 Oct 2025 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759429031; cv=none; b=OY91pEFTS95LDh98uxPXwVJWwysXAsUUJYruIo0PWB0aJWouqk1rHx4oRUtV/mYQBlMQNSEU0diDyrLavCQ91u74wqYjZ9SYFzEofpgLY3MMkRlTFjVjZVqYzVEFh5qW9phPyp4zgR8+a7om6FZJW/2YHNx+TArLe5LLf/kZEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759429031; c=relaxed/simple;
	bh=Wht0o9CCcSP7J2CHJnnd9pobEA65I8xsfjserKHvUF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgcShpLwKuiQ/UBzX1OvGO3fO7WByojdPeR9iyRGmzGuFaQvbBx/S6I0YJIvY256H/x80B86/RY4UaoAZioS6H3WQngH4/oSCcDlK19iNoRuUdHA8xJWNSRbKInxBmocCnRpxK9iPTOxAsMxEqABUlpK8OFG2mI5ZKAqWiQcHtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r1POFekh; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <16f3a168-cf4d-4ef6-8e7f-28589e8ee582@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759429013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJDToZdtYu/zoToHdUoIFuasmkWt2cwsePgfCqCHbAQ=;
	b=r1POFekhUTG+Hj+adMR5W+WFk0U9XUF8XiR836ckwkN2EoJi026To8BJF7iHlgQoDgiaOK
	s2/Vle5009ICvspyfBjJpIntrvs7jQQPizIZ59E2tBie9AXNpJ21ysFspCDnwW1ZT6Pi3X
	Xp1e/2Ipy5H73/fdu8ZX4yG/+Pl8s0g=
Date: Thu, 2 Oct 2025 11:16:46 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] KMSAN: uninit-value in ib_nl_handle_ip_res_resp
To: Kohei Enju <enjuk@amazon.com>,
 syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <68dc3dac.a00a0220.102ee.004f.GAE@google.com>
 <20251001030227.84476-1-enjuk@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20251001030227.84476-1-enjuk@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/30/25 8:02 PM, Kohei Enju wrote:
> On Tue, 30 Sep 2025 13:29:32 -0700, syzbot wrote:
> 
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    1896ce8eb6c6 Merge tag 'fsverity-for-linus' of git://git.k..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=153d0092580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=6eca10e0cdef44f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>> userspace arch: i386
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/d0fbab3c0b62/disk-1896ce8e.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/71c7b444e106/vmlinux-1896ce8e.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/96a4aa63999d/bzImage-1896ce8e.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
>>
>> netlink: 8 bytes leftover after parsing attributes in process `syz.8.3246'.
>> =====================================================
>> BUG: KMSAN: uninit-value in hex_byte_pack include/linux/hex.h:13 [inline]
>> BUG: KMSAN: uninit-value in ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
>> hex_byte_pack include/linux/hex.h:13 [inline]
>> ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
>> ip6_addr_string+0x18a/0x3e0 lib/vsprintf.c:1509
>> ip_addr_string+0x245/0xee0 lib/vsprintf.c:1633
>> pointer+0xc09/0x1bd0 lib/vsprintf.c:2542
>> vsnprintf+0xf8a/0x1bd0 lib/vsprintf.c:2930
>> vprintk_store+0x3ae/0x1530 kernel/printk/printk.c:2279
>> vprintk_emit+0x307/0xcd0 kernel/printk/printk.c:2426
>> vprintk_default+0x3f/0x50 kernel/printk/printk.c:2465
>> vprintk+0x36/0x50 kernel/printk/printk_safe.c:82
>> _printk+0x17e/0x1b0 kernel/printk/printk.c:2475
>> ib_nl_process_good_ip_rsep drivers/infiniband/core/addr.c:128 [inline]
> 
> I see when gid is not initialized in nla_for_each_attr loop, this should
> return early.

GID is a globally unique 128-bit identifier for an RDMA port, used for 
addressing and routing in InfiniBand or RoCE networks. It’s crucial for 
establishing RDMA connections across subnets or Ethernet networks. IMO, 
we do not just return when gid is not found. We should find out why the 
GID does not exist if I get you correctly.

Then we can fix this problem where the GID can not be added into GID table.

It is just my 2 cent advice.

Yanjun.Zhu

> 
> I think the splat occurrs when gid is not found, so a simple fix might
> be like:
> 
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index be0743dac3ff..c03a308bcda5 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -103,15 +103,21 @@ static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
>          struct addr_req *req;
>          int len, rem;
>          int found = 0;
> +       bool gid_found = false;
> 
>          head = (const struct nlattr *)nlmsg_data(nlh);
>          len = nlmsg_len(nlh);
> 
>          nla_for_each_attr(curr, head, len, rem) {
> -               if (curr->nla_type == LS_NLA_TYPE_DGID)
> +               if (curr->nla_type == LS_NLA_TYPE_DGID) {
>                          memcpy(&gid, nla_data(curr), nla_len(curr));
> +                       gid_found = true;
> +               }
>          }
> 
> +       if (!gid_found)
> +               return;
> +
>          spin_lock_bh(&lock);
>          list_for_each_entry(req, &req_list, list) {
>                  if (nlh->nlmsg_seq != req->seq)
> 
>> ib_nl_handle_ip_res_resp+0x963/0x9d0 drivers/infiniband/core/addr.c:141
>> rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
>> rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>> rdma_nl_rcv+0xefa/0x11c0 drivers/infiniband/core/netlink.c:259
>> netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>> netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1346
>> netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1896
>> sock_sendmsg_nosec net/socket.c:714 [inline]
>> __sock_sendmsg+0x333/0x3d0 net/socket.c:729
>> ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2617
>> ___sys_sendmsg+0x271/0x3b0 net/socket.c:2671
>> __sys_sendmsg+0x1aa/0x300 net/socket.c:2703
>> __compat_sys_sendmsg net/compat.c:346 [inline]
>> __do_compat_sys_sendmsg net/compat.c:353 [inline]
>> __se_compat_sys_sendmsg net/compat.c:350 [inline]
>> __ia32_compat_sys_sendmsg+0xa4/0x100 net/compat.c:350
>> ia32_sys_call+0x3f6c/0x4310 arch/x86/include/generated/asm/syscalls_32.h:371
>> do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
>> __do_fast_syscall_32+0xb0/0x150 arch/x86/entry/syscall_32.c:306
>> do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
>> do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
>> entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>>
>> Local variable gid.i created at:
>> ib_nl_process_good_ip_rsep drivers/infiniband/core/addr.c:102 [inline]
>> ib_nl_handle_ip_res_resp+0x254/0x9d0 drivers/infiniband/core/addr.c:141
>> rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
>> rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>> rdma_nl_rcv+0xefa/0x11c0 drivers/infiniband/core/netlink.c:259
>>
>> CPU: 0 UID: 0 PID: 17455 Comm: syz.8.3246 Not tainted syzkaller #0 PREEMPT(none)
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>> =====================================================
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
>>


