Return-Path: <linux-rdma+bounces-12099-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B96B03485
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 04:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B81837A2019
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 02:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D881D6DA9;
	Mon, 14 Jul 2025 02:34:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA237E0E8;
	Mon, 14 Jul 2025 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460447; cv=none; b=itVPScMB5gwNsGpmDxZQd3CY0W5Io1ERAqBdKpVUKq/tpbNxYvkX/Yg7d3+5lolD8O/NPz+mJeuVZ69nFl1Y2I6TDvbKp1AfuGjltuOT2ecJBVcoA4TXdZTE5qIzI85zHyFnxuTl6NeDMHlou497Mn2qid93HhFZZQX0cHdqr50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460447; c=relaxed/simple;
	bh=KC6Nm9Dh/gTGaq3+hmh6YiKDaalS+ZCO6zbEbRMlgd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I4GZUwP6cVGBow74XNSaxcRkol1ymlCU8/KUiLGKMczCqo6zfpUzVPBZom4MYQfHtxL4S2qU6zc4zHs21F+TGIZNocbfjZAFuEDNYHw/0t02YNU5ZYrb0SJeJveewZ6GthCdjTJrd+lqlNvAsaRGiwVXMmoHdgWxD3slbJdZBgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bgR9S2cGMz2CfmS;
	Mon, 14 Jul 2025 10:29:48 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 55E6D140113;
	Mon, 14 Jul 2025 10:33:54 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Jul 2025 10:33:52 +0800
Message-ID: <830deee4-073c-44bc-8b94-a050792eeda4@huawei.com>
Date: Mon, 14 Jul 2025 10:33:50 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net] smc: Fix various oops due to inet_sock type
 confusion.
To: Kuniyuki Iwashima <kuniyu@google.com>, "D. Wythe"
	<alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, Sidraya
 Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
	<tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Simon Horman
	<horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-s390@vger.kernel.org>,
	<syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>,
	<syzbot+f22031fad6cbe52c70e7@syzkaller.appspotmail.com>,
	<syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com>
References: <20250711060808.2977529-1-kuniyu@google.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20250711060808.2977529-1-kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/7/11 14:07, Kuniyuki Iwashima 写道:
> syzbot reported weird splats [0][1] in cipso_v4_sock_setattr() while
> freeing inet_sk(sk)->inet_opt.
>
> The address was freed multiple times even though it was read-only memory.
>
> cipso_v4_sock_setattr() did nothing wrong, and the root cause was type
> confusion.
>
> The cited commit made it possible to create smc_sock as an INET socket.
>
> The issue is that struct smc_sock does not have struct inet_sock as the
> first member but hijacks AF_INET and AF_INET6 sk_family, which confuses
> various places.
>
> In this case, inet_sock.inet_opt was actually smc_sock.clcsk_data_ready(),
> which is an address of a function in the text segment.
>
>    $ pahole -C inet_sock vmlinux
>    struct inet_sock {
>    ...
>            struct ip_options_rcu *    inet_opt;             /*   784     8 */
>
>    $ pahole -C smc_sock vmlinux
>    struct smc_sock {
>    ...
>            void                       (*clcsk_data_ready)(struct sock *); /*   784     8 */
>
> The same issue for another field was reported before. [2][3]
>
> At that time, an ugly hack was suggested [4], but it makes both INET
> and SMC code error-prone and hard to change.
>
> Also, yet another variant was fixed by a hacky commit 98d4435efcbf3
> ("net/smc: prevent NULL pointer dereference in txopt_get").
>
> Instead of papering over the root cause by such hacks, we should not
> allow non-INET socket to reuse the INET infra.
>
> Let's add inet_sock as the first member of smc_sock.
>
> [0]:
> kvfree_call_rcu(): Double-freed call. rcu_head 000000006921da73
> WARNING: CPU: 0 PID: 6718 at mm/slab_common.c:1956 kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
> Modules linked in:
> CPU: 0 UID: 0 PID: 6718 Comm: syz.0.17 Tainted: G        W           6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
> lr : kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955
> sp : ffff8000a03a7730
> x29: ffff8000a03a7730 x28: 00000000fffffff5 x27: 1fffe000184823d3
> x26: dfff800000000000 x25: ffff0000c2411e9e x24: ffff0000dd88da00
> x23: ffff8000891ac9a0 x22: 00000000ffffffea x21: ffff8000891ac9a0
> x20: ffff8000891ac9a0 x19: ffff80008afc2480 x18: 00000000ffffffff
> x17: 0000000000000000 x16: ffff80008ae642c8 x15: ffff700011ede14c
> x14: 1ffff00011ede14c x13: 0000000000000004 x12: ffffffffffffffff
> x11: ffff700011ede14c x10: 0000000000ff0100 x9 : 5fa3c1ffaf0ff000
> x8 : 5fa3c1ffaf0ff000 x7 : 0000000000000001 x6 : 0000000000000001
> x5 : ffff8000a03a7078 x4 : ffff80008f766c20 x3 : ffff80008054d360
> x2 : 0000000000000000 x1 : 0000000000000201 x0 : 0000000000000000
> Call trace:
>   kvfree_call_rcu+0x94/0x3f0 mm/slab_common.c:1955 (P)
>   cipso_v4_sock_setattr+0x2f0/0x3f4 net/ipv4/cipso_ipv4.c:1914
>   netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
>   smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
>   smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
>   security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
>   __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
>   __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
>   vfs_setxattr+0x158/0x2ac fs/xattr.c:321
>   do_setxattr fs/xattr.c:636 [inline]
>   file_setxattr+0x1b8/0x294 fs/xattr.c:646
>   path_setxattrat+0x2ac/0x320 fs/xattr.c:711
>   __do_sys_fsetxattr fs/xattr.c:761 [inline]
>   __se_sys_fsetxattr fs/xattr.c:758 [inline]
>   __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
>   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>   invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>   el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>   do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>   el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
>   el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
>   el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
>
> [1]:
> Unable to handle kernel write to read-only memory at virtual address ffff8000891ac9a8
> KASAN: probably user-memory-access in range [0x0000000448d64d40-0x0000000448d64d47]
> Mem abort info:
>    ESR = 0x000000009600004e
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
>    FSC = 0x0e: level 2 permission fault
> Data abort info:
>    ISV = 0, ISS = 0x0000004e, ISS2 = 0x00000000
>    CM = 0, WnR = 1, TnD = 0, TagAccess = 0
>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000207144000
> [ffff8000891ac9a8] pgd=0000000000000000, p4d=100000020f950003, pud=100000020f951003, pmd=0040000201000781
> Internal error: Oops: 000000009600004e [#1]  SMP
> Modules linked in:
> CPU: 0 UID: 0 PID: 6946 Comm: syz.0.69 Not tainted 6.16.0-rc4-syzkaller-g7482bb149b9f #0 PREEMPT
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : kvfree_call_rcu+0x31c/0x3f0 mm/slab_common.c:1971
> lr : add_ptr_to_bulk_krc_lock mm/slab_common.c:1838 [inline]
> lr : kvfree_call_rcu+0xfc/0x3f0 mm/slab_common.c:1963
> sp : ffff8000a28a7730
> x29: ffff8000a28a7730 x28: 00000000fffffff5 x27: 1fffe00018b09bb3
> x26: 0000000000000001 x25: ffff80008f66e000 x24: ffff00019beaf498
> x23: ffff00019beaf4c0 x22: 0000000000000000 x21: ffff8000891ac9a0
> x20: ffff8000891ac9a0 x19: 0000000000000000 x18: 00000000ffffffff
> x17: ffff800093363000 x16: ffff80008052c6e4 x15: ffff700014514ecc
> x14: 1ffff00014514ecc x13: 0000000000000004 x12: ffffffffffffffff
> x11: ffff700014514ecc x10: 0000000000000001 x9 : 0000000000000001
> x8 : ffff00019beaf7b4 x7 : ffff800080a94154 x6 : 0000000000000000
> x5 : ffff8000935efa60 x4 : 0000000000000008 x3 : ffff80008052c7fc
> x2 : 0000000000000001 x1 : ffff8000891ac9a0 x0 : 0000000000000001
> Call trace:
>   kvfree_call_rcu+0x31c/0x3f0 mm/slab_common.c:1967 (P)
>   cipso_v4_sock_setattr+0x2f0/0x3f4 net/ipv4/cipso_ipv4.c:1914
>   netlbl_sock_setattr+0x240/0x334 net/netlabel/netlabel_kapi.c:1000
>   smack_netlbl_add+0xa8/0x158 security/smack/smack_lsm.c:2581
>   smack_inode_setsecurity+0x378/0x430 security/smack/smack_lsm.c:2912
>   security_inode_setsecurity+0x118/0x3c0 security/security.c:2706
>   __vfs_setxattr_noperm+0x174/0x5c4 fs/xattr.c:251
>   __vfs_setxattr_locked+0x1ec/0x218 fs/xattr.c:295
>   vfs_setxattr+0x158/0x2ac fs/xattr.c:321
>   do_setxattr fs/xattr.c:636 [inline]
>   file_setxattr+0x1b8/0x294 fs/xattr.c:646
>   path_setxattrat+0x2ac/0x320 fs/xattr.c:711
>   __do_sys_fsetxattr fs/xattr.c:761 [inline]
>   __se_sys_fsetxattr fs/xattr.c:758 [inline]
>   __arm64_sys_fsetxattr+0xc0/0xdc fs/xattr.c:758
>   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>   invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>   el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>   do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>   el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
>   el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
>   el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> Code: aa1f03e2 52800023 97ee1e8d b4000195 (f90006b4)
>
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/686d9b50.050a0220.1ffab7.0020.GAE@google.com/
> Tested-by: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com
> Reported-by: syzbot+f22031fad6cbe52c70e7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/686da0f3.050a0220.1ffab7.0022.GAE@google.com/
> Reported-by: syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364 # [2]
> Link: https://lore.kernel.org/netdev/99f284be-bf1d-4bc4-a629-77b268522fff@huawei.com/ # [3]
> Link: https://lore.kernel.org/netdev/20250331081003.1503211-1-wangliang74@huawei.com/ # [4]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>   net/smc/af_smc.c | 14 ++++++++++++++
>   net/smc/smc.h    |  8 ++++----
>   2 files changed, 18 insertions(+), 4 deletions(-)
Reviewed-by: Wang Liang <wangliang74@huawei.com>

