Return-Path: <linux-rdma+bounces-13767-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B97BB4E02
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Oct 2025 20:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7F22A29CB
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Oct 2025 18:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0545A277C9E;
	Thu,  2 Oct 2025 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iwjlrRhU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1633272E7A;
	Thu,  2 Oct 2025 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759429909; cv=none; b=j8GVlxf+YkRo/Sxh02sUggvK2ZPl4Ttefx6aF9jBbZMiw9f6nI5Rkf97hPrRc4dDNg0d1XQ0hQ1rmf/qYUFyPOcFos5G2IdvVXmLfmb9AF2pnE6ZPfqvCbddDAGC2LTxEfLixtBAIlvJxZPlZqJVhxKrTBSru/HWfL1y2J6YZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759429909; c=relaxed/simple;
	bh=S5X+ln9suPNYfPKmNJwkNFs8cq+CTVZh9dbxgcluX0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g3/jfD/JAuP8H0qJwPcjoWrw5IqIVEQOM8PFiUrISKO7kR/GxVAjlwr8tfdcuRCSIyhzITA3Oan0UmFTiH/t4aqXg+1qFsckCVA4cqNj/sC+nbnoPBUXLoN5hF21j1kJaBxlqs2i5sZXVi6+YRjhlb6Imn/QwiKrc7fAWj1hZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iwjlrRhU; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759429907; x=1790965907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hNR2+g/mC2XgaJosKn9yziY9qtPJN0Jq67aKkpU0X/4=;
  b=iwjlrRhUm+hrocCKnYrzq+VnkHJ7V+gIhfBY0EI345JWe7PjyJeUTWX3
   Vn4FDgv5bZ5pRN0DtxmfAgEY4TgWXV2SUp1cfV0NFbZysnQOERpT3hZXv
   /SOpJI4JStdghRKes63GObPfEgNu1eP4p26WPhGBIGAGZpvOZetsmJKko
   f2peeRnORFodfX139JSJmbDxNdJJMbBnDJFmNJPrl81h7LWi8PO/MFJ4f
   FjH3nD1UJnJG3DvYMkC7/kc0z2hQrJJ/q/+MJGeTwoZ9Y3wf1aW+RBpc6
   LFFRVn8bDiKm5KmP+eYmaJE2ZUBphFs1Qf19OmyPjnMdHEjKxOe1D/Yuc
   g==;
X-CSE-ConnectionGUID: TH2hmQuyRHq/4LiJ3yHihA==
X-CSE-MsgGUID: wxOVIfXNRhm+jMHsjitrLQ==
X-IronPort-AV: E=Sophos;i="6.18,310,1751241600"; 
   d="scan'208";a="4054719"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 18:31:44 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:30569]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.171:2525] with esmtp (Farcaster)
 id c02af0b7-9b0d-420c-912e-0adfda417d11; Thu, 2 Oct 2025 18:31:44 +0000 (UTC)
X-Farcaster-Flow-ID: c02af0b7-9b0d-420c-912e-0adfda417d11
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 2 Oct 2025 18:31:43 +0000
Received: from b0be8375a521.amazon.com (10.37.245.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 2 Oct 2025 18:31:42 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <yanjun.zhu@linux.dev>
CC: <enjuk@amazon.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [rdma?] KMSAN: uninit-value in ib_nl_handle_ip_res_resp
Date: Fri, 3 Oct 2025 03:31:19 +0900
Message-ID: <20251002183134.87314-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <16f3a168-cf4d-4ef6-8e7f-28589e8ee582@linux.dev>
References: <16f3a168-cf4d-4ef6-8e7f-28589e8ee582@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, 2 Oct 2025 11:16:46 -0700, yanjun.zhu wrote:

>On 9/30/25 8:02 PM, Kohei Enju wrote:
>> On Tue, 30 Sep 2025 13:29:32 -0700, syzbot wrote:
>> 
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    1896ce8eb6c6 Merge tag 'fsverity-for-linus' of git://git.k..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=153d0092580000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=6eca10e0cdef44f
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
>>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>>> userspace arch: i386
>>>
>>> Unfortunately, I don't have any reproducer for this issue yet.
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/d0fbab3c0b62/disk-1896ce8e.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/71c7b444e106/vmlinux-1896ce8e.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/96a4aa63999d/bzImage-1896ce8e.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
>>>
>>> netlink: 8 bytes leftover after parsing attributes in process `syz.8.3246'.
>>> =====================================================
>>> BUG: KMSAN: uninit-value in hex_byte_pack include/linux/hex.h:13 [inline]
>>> BUG: KMSAN: uninit-value in ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
>>> hex_byte_pack include/linux/hex.h:13 [inline]
>>> ip6_string+0xef4/0x13a0 lib/vsprintf.c:1490
>>> ip6_addr_string+0x18a/0x3e0 lib/vsprintf.c:1509
>>> ip_addr_string+0x245/0xee0 lib/vsprintf.c:1633
>>> pointer+0xc09/0x1bd0 lib/vsprintf.c:2542
>>> vsnprintf+0xf8a/0x1bd0 lib/vsprintf.c:2930
>>> vprintk_store+0x3ae/0x1530 kernel/printk/printk.c:2279
>>> vprintk_emit+0x307/0xcd0 kernel/printk/printk.c:2426
>>> vprintk_default+0x3f/0x50 kernel/printk/printk.c:2465
>>> vprintk+0x36/0x50 kernel/printk/printk_safe.c:82
>>> _printk+0x17e/0x1b0 kernel/printk/printk.c:2475
>>> ib_nl_process_good_ip_rsep drivers/infiniband/core/addr.c:128 [inline]
>> 
>> I see when gid is not initialized in nla_for_each_attr loop, this should
>> return early.
>
>GID is a globally unique 128-bit identifier for an RDMA port, used for 
>addressing and routing in InfiniBand or RoCE networks. It\u2019s crucial for 
>establishing RDMA connections across subnets or Ethernet networks. IMO, 
>we do not just return when gid is not found. We should find out why the 
>GID does not exist if I get you correctly.

Indeed, I think you're right.
Considering that ib_nl_is_good_ip_resp() returns true, the fact that GID
doesn't exist seems weird and we should investigate the cause.

>
>Then we can fix this problem where the GID can not be added into GID table.
>
>It is just my 2 cent advice.
>
>Yanjun.Zhu
>
>> 
>> I think the splat occurrs when gid is not found, so a simple fix might
>> be like:
>> 
>> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
>> index be0743dac3ff..c03a308bcda5 100644
>> --- a/drivers/infiniband/core/addr.c
>> +++ b/drivers/infiniband/core/addr.c
>> @@ -103,15 +103,21 @@ static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
>>          struct addr_req *req;
>>          int len, rem;
>>          int found = 0;
>> +       bool gid_found = false;
>> 
>>          head = (const struct nlattr *)nlmsg_data(nlh);
>>          len = nlmsg_len(nlh);
>> 
>>          nla_for_each_attr(curr, head, len, rem) {
>> -               if (curr->nla_type == LS_NLA_TYPE_DGID)
>> +               if (curr->nla_type == LS_NLA_TYPE_DGID) {
>>                          memcpy(&gid, nla_data(curr), nla_len(curr));
>> +                       gid_found = true;
>> +               }
>>          }
>> 
>> +       if (!gid_found)
>> +               return;
>> +
>>          spin_lock_bh(&lock);
>>          list_for_each_entry(req, &req_list, list) {
>>                  if (nlh->nlmsg_seq != req->seq)
>> 
>>> ib_nl_handle_ip_res_resp+0x963/0x9d0 drivers/infiniband/core/addr.c:141
>>> rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
>>> rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>>> rdma_nl_rcv+0xefa/0x11c0 drivers/infiniband/core/netlink.c:259
>>> netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>>> netlink_unicast+0xf04/0x12b0 net/netlink/af_netlink.c:1346
>>> netlink_sendmsg+0x10b3/0x1250 net/netlink/af_netlink.c:1896
>>> sock_sendmsg_nosec net/socket.c:714 [inline]
>>> __sock_sendmsg+0x333/0x3d0 net/socket.c:729
>>> ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2617
>>> ___sys_sendmsg+0x271/0x3b0 net/socket.c:2671
>>> __sys_sendmsg+0x1aa/0x300 net/socket.c:2703
>>> __compat_sys_sendmsg net/compat.c:346 [inline]
>>> __do_compat_sys_sendmsg net/compat.c:353 [inline]
>>> __se_compat_sys_sendmsg net/compat.c:350 [inline]
>>> __ia32_compat_sys_sendmsg+0xa4/0x100 net/compat.c:350
>>> ia32_sys_call+0x3f6c/0x4310 arch/x86/include/generated/asm/syscalls_32.h:371
>>> do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
>>> __do_fast_syscall_32+0xb0/0x150 arch/x86/entry/syscall_32.c:306
>>> do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
>>> do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
>>> entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>>>
>>> Local variable gid.i created at:
>>> ib_nl_process_good_ip_rsep drivers/infiniband/core/addr.c:102 [inline]
>>> ib_nl_handle_ip_res_resp+0x254/0x9d0 drivers/infiniband/core/addr.c:141
>>> rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
>>> rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>>> rdma_nl_rcv+0xefa/0x11c0 drivers/infiniband/core/netlink.c:259
>>>
>>> CPU: 0 UID: 0 PID: 17455 Comm: syz.8.3246 Not tainted syzkaller #0 PREEMPT(none)
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
>>> =====================================================
>>>
>>>
>>> ---
>>> This report is generated by a bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this issue. See:
>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>>
>>> If the report is already addressed, let syzbot know by replying with:
>>> #syz fix: exact-commit-title
>>>
>>> If you want to overwrite report's subsystems, reply with:
>>> #syz set subsystems: new-subsystem
>>> (See the list of subsystem names on the web dashboard)
>>>
>>> If the report is a duplicate of another one, reply with:
>>> #syz dup: exact-subject-of-another-report
>>>
>>> If you want to undo deduplication, reply with:
>>> #syz undup
>>>
>
>

