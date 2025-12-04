Return-Path: <linux-rdma+bounces-14878-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B481CA2CEE
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 09:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DFEE3003983
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 08:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88608331A45;
	Thu,  4 Dec 2025 08:27:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF92331A49
	for <linux-rdma@vger.kernel.org>; Thu,  4 Dec 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836822; cv=none; b=N8DrsbsMtkgUVbVdad5NaxsTf3BiT4Et1LTDEdkqsJW++aTMJ5Z5zycOPn2DXMiBFgRVekrf4Dq3lErOhpfFK7Oo8ExHZX/S7nYNeeVD28LWAQqaWgzO9Nl7mtvb28v34h/HyS6S0fnDXieV7saqVSpBiWwYUHA4UxoDP7iqovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836822; c=relaxed/simple;
	bh=RnHqknAxAF/BJGG0IlvQ4LIYbDlYdumIZFUIfEFva3Y=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=h1dCPtM8TcLzq34HpOXV81hTP9tJYskmewMsWU/KadVPtZmjXz2kfL07lA8gbI93+hrVpkkX49UQXBF1/Qzp3/0h9DKCFn69ODDrziBcTlT166+nvkbor+FMawCQL0HJ/CNYr2CvqG//c5glpJm1rLmVx54lPtV0EqC+7088wC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5B48QoPm045864
	for <linux-rdma@vger.kernel.org>; Thu, 4 Dec 2025 17:26:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5B48QnB1045860
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-rdma@vger.kernel.org>; Thu, 4 Dec 2025 17:26:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Content-Type: multipart/mixed; boundary="------------tFfTF8DD6j0hRR7qe5yDSEzB"
Message-ID: <cc96166a-a469-4bc9-bfbe-de6f40dffe97@I-love.SAKURA.ne.jp>
Date: Thu, 4 Dec 2025 17:26:47 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: OFED mailing list <linux-rdma@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [rdma] "rdma link del" operation hangs at wait_for_completion() when
 a file descriptor is in use.
X-Virus-Status: clean
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp

This is a multi-part message in MIME format.
--------------tFfTF8DD6j0hRR7qe5yDSEzB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I found that running the attached example program causes khungtaskd message. What is wrong?



INFO: task rdma:1387 blocked for more than 122 seconds.
      Not tainted 6.18.0 #231
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:rdma            state:D stack:0     pid:1387  tgid:1387  ppid:1347   task_flags:0x400100 flags:0x00080001
Call Trace:
 <TASK>
 __schedule+0x369/0x8a0
 schedule+0x3a/0xe0
 schedule_timeout+0xca/0x110
 wait_for_completion+0x8a/0x140
 ib_uverbs_remove_one+0x1b0/0x210 [ib_uverbs]
 remove_client_context+0x8d/0xd0 [ib_core]
 disable_device+0x8b/0x170 [ib_core]
 __ib_unregister_device+0x110/0x180 [ib_core]
 ib_unregister_device_and_put+0x37/0x50 [ib_core]
 nldev_dellink+0xa4/0x100 [ib_core]
 rdma_nl_rcv_msg+0x12f/0x2f0 [ib_core]
 ? __lock_acquire+0x55d/0xbf0
 rdma_nl_rcv_skb.constprop.0.isra.0+0xb2/0x100 [ib_core]
 netlink_unicast+0x203/0x2e0
 netlink_sendmsg+0x1f8/0x420
 __sys_sendto+0x1e1/0x1f0
 __x64_sys_sendto+0x24/0x30
 do_syscall_64+0x94/0x320
 ? _copy_to_user+0x22/0x70
 ? move_addr_to_user+0xd6/0x120
 ? __sys_getsockname+0x9a/0xf0
 ? do_syscall_64+0x137/0x320
 ? do_sock_setsockopt+0x85/0x160
 ? do_sock_setsockopt+0x85/0x160
 ? __sys_setsockopt+0x7b/0xc0
 ? do_syscall_64+0x137/0x320
 ? do_syscall_64+0x137/0x320
 ? do_syscall_64+0x137/0x320
 ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x150
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f877077b77e
RSP: 002b:00007ffda335da70 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000056038051c3c0 RCX: 00007f877077b77e
RDX: 0000000000000018 RSI: 000056038051b2a0 RDI: 0000000000000004
RBP: 00007ffda335da80 R08: 00007f877090f9a0 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffda335dce0
R13: 00007ffda335dd38 R14: 00007ffda335dce0 R15: 0000000069314344
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/u512:0/11:
 #0: ffff8c82003d3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x509/0x590
 #1: ffffcea98008fe38 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x1e2/0x590
 #2: ffffffff9807a310 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0x51/0x390
 #3: ffff8c8224164700 (&device->unregistration_lock){+.+.}-{4:4}, at: rdma_dev_change_netns+0x28/0x120 [ib_core]
1 lock held by khungtaskd/99:
 #0: ffffffff97d9f4e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30
2 locks held by kworker/10:1/127:
1 lock held by systemd-journal/662:
2 locks held by rdma/1387:
 #0: ffffffffc0b88c18 (&rdma_nl_types[idx].sem){.+.+}-{4:4}, at: rdma_nl_rcv_msg+0x9e/0x2f0 [ib_core]
 #1: ffff8c8224164700 (&device->unregistration_lock){+.+.}-{4:4}, at: __ib_unregister_device+0xe4/0x180 [ib_core]

=============================================

INFO: task kworker/u512:0:11 blocked for more than 122 seconds.
      Not tainted 6.18.0 #231
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u512:0  state:D stack:0     pid:11    tgid:11    ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __schedule+0x369/0x8a0
 schedule+0x3a/0xe0
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock+0x568/0x1170
 ? rdma_dev_change_netns+0x28/0x120 [ib_core]
 ? rdma_dev_change_netns+0x28/0x120 [ib_core]
 rdma_dev_change_netns+0x28/0x120 [ib_core]
 rdma_dev_exit_net+0x1a4/0x320 [ib_core]
 ops_undo_list+0xea/0x3b0
 cleanup_net+0x20b/0x390
 process_one_work+0x223/0x590
 worker_thread+0x1cb/0x3a0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xff/0x240
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x182/0x1e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
INFO: task kworker/u512:0:11 is blocked on a mutex likely owned by task rdma:1387.
INFO: task rdma:1387 blocked for more than 245 seconds.
      Not tainted 6.18.0 #231
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:rdma            state:D stack:0     pid:1387  tgid:1387  ppid:1347   task_flags:0x400100 flags:0x00080001
Call Trace:
 <TASK>
 __schedule+0x369/0x8a0
 schedule+0x3a/0xe0
 schedule_timeout+0xca/0x110
 wait_for_completion+0x8a/0x140
 ib_uverbs_remove_one+0x1b0/0x210 [ib_uverbs]
 remove_client_context+0x8d/0xd0 [ib_core]
 disable_device+0x8b/0x170 [ib_core]
 __ib_unregister_device+0x110/0x180 [ib_core]
 ib_unregister_device_and_put+0x37/0x50 [ib_core]
 nldev_dellink+0xa4/0x100 [ib_core]
 rdma_nl_rcv_msg+0x12f/0x2f0 [ib_core]
 ? __lock_acquire+0x55d/0xbf0
 rdma_nl_rcv_skb.constprop.0.isra.0+0xb2/0x100 [ib_core]
 netlink_unicast+0x203/0x2e0
 netlink_sendmsg+0x1f8/0x420
 __sys_sendto+0x1e1/0x1f0
 __x64_sys_sendto+0x24/0x30
 do_syscall_64+0x94/0x320
 ? _copy_to_user+0x22/0x70
 ? move_addr_to_user+0xd6/0x120
 ? __sys_getsockname+0x9a/0xf0
 ? do_syscall_64+0x137/0x320
 ? do_sock_setsockopt+0x85/0x160
 ? do_sock_setsockopt+0x85/0x160
 ? __sys_setsockopt+0x7b/0xc0
 ? do_syscall_64+0x137/0x320
 ? do_syscall_64+0x137/0x320
 ? do_syscall_64+0x137/0x320
 ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x150
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f877077b77e
RSP: 002b:00007ffda335da70 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 000056038051c3c0 RCX: 00007f877077b77e
RDX: 0000000000000018 RSI: 000056038051b2a0 RDI: 0000000000000004
RBP: 00007ffda335da80 R08: 00007f877090f9a0 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffda335dce0
R13: 00007ffda335dd38 R14: 00007ffda335dce0 R15: 0000000069314344
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/u512:0/11:
 #0: ffff8c82003d3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x509/0x590
 #1: ffffcea98008fe38 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x1e2/0x590
 #2: ffffffff9807a310 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0x51/0x390
 #3: ffff8c8224164700 (&device->unregistration_lock){+.+.}-{4:4}, at: rdma_dev_change_netns+0x28/0x120 [ib_core]
1 lock held by khungtaskd/99:
 #0: ffffffff97d9f4e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30
2 locks held by rdma/1387:
 #0: ffffffffc0b88c18 (&rdma_nl_types[idx].sem){.+.+}-{4:4}, at: rdma_nl_rcv_msg+0x9e/0x2f0 [ib_core]
 #1: ffff8c8224164700 (&device->unregistration_lock){+.+.}-{4:4}, at: __ib_unregister_device+0xe4/0x180 [ib_core]

=============================================
--------------tFfTF8DD6j0hRR7qe5yDSEzB
Content-Type: text/plain; charset=UTF-8; name="rdma_example.c"
Content-Disposition: attachment; filename="rdma_example.c"
Content-Transfer-Encoding: base64

Ly8gZ2NjIC1XYWxsIC1PMiByZG1hX2V4YW1wbGUuYyAtbHJkbWFjbSAtbGlidmVyYnMKI2Rl
ZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8YXJwYS9pbmV0Lmg+CiNpbmNsdWRlIDxzdHJp
bmcuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8
Z2V0b3B0Lmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5j
bHVkZSA8cmRtYS9yZG1hX2NtYS5oPgoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3Zb
XSkKewoJY29uc3QgY2hhciAqcmVtb3RlX2FkZHIgPSAiMTAuMC4wLjEiOwoJY29uc3QgaW50
IHBvcnQgPSAyMTIzNDsKCXN0cnVjdCByZG1hX2V2ZW50X2NoYW5uZWwgKmV2Y2gxLCAqZXZj
aDI7CglzdHJ1Y3QgcmRtYV9jbV9pZCAqc2VydmVyX2lkOwoJc3RydWN0IHJkbWFfY21faWQg
KmNsaWVudF9pZDsKCXN0cnVjdCByZG1hX2NtX2V2ZW50ICpldmVudCA9IE5VTEw7CglzdHJ1
Y3QgcmRtYV9jb25uX3BhcmFtIGNvbm5fcGFyYW07CglzdHJ1Y3QgaWJ2X3BkICpwZDEsICpw
ZDI7CglzdHJ1Y3QgaWJ2X2NxICpjcTEsICpjcTI7CglzdHJ1Y3QgaWJ2X21yICptcjEsICpt
cjI7CglzdHJ1Y3QgaWJ2X3NlbmRfd3Igc25kX3dyOwoJc3RydWN0IGlidl9yZWN2X3dyIHJj
dl93cjsKCXN0cnVjdCBpYnZfc2VuZF93ciAqYmFkX3dyID0gTlVMTDsKCXN0cnVjdCBpYnZf
c2dlIHNnZTsKCXN0cnVjdCBpYnZfd2Mgd2M7CglzdHJ1Y3QgaWJ2X3FwX2luaXRfYXR0ciBh
dHRyID0gewoJCS5jYXAgPSB7CgkJCS5tYXhfc2VuZF93ciA9IDMyLAoJCQkubWF4X3JlY3Zf
d3IgPSAzMiwKCQkJLm1heF9zZW5kX3NnZSA9IDEsCgkJCS5tYXhfcmVjdl9zZ2UgPSAxLAoJ
CQkubWF4X2lubGluZV9kYXRhID0gNjQKCQl9LAoJCS5xcF90eXBlID0gSUJWX1FQVF9SQwoJ
fTsKCWNoYXIgbXNnWzI1Nl0gPSAiSGVsbG8gV29ybGQiOwoJY29uc3QgaW50IG1zZ19sZW4g
PSBzdHJsZW4obXNnKSArIDE7CglzdHJ1Y3Qgc29ja2FkZHJfaW4gc2luOwoKCWlmICh1bnNo
YXJlKENMT05FX05FV05FVCkpIHsKCQlwZXJyb3IoInVuc2hhcmUiKTsKCQlleGl0KC0xKTsK
CX0KCXN5c3RlbSgiaXAgbGluayBzZXQgbG8gdXAiKTsKCXN5c3RlbSgicmRtYSBsaW5rIGFk
ZCBzaXcwIHR5cGUgc2l3IG5ldGRldiBsbyIpOwoJc3lzdGVtKCJyZG1hIGxpbmsgbGlzdCIp
OwoJc3lzdGVtKCJpcCBsaW5rIGFkZCB2ZXRoMSB0eXBlIHZldGggcGVlciBuYW1lIHZldGgy
Iik7CglzeXN0ZW0oImlwIGFkZHIgYWRkIDEwLjAuMC4xLzI0IGRldiB2ZXRoMSIpOwoJc3lz
dGVtKCJpcCBsaW5rIHNldCB2ZXRoMSB1cCIpOwoJc3lzdGVtKCJpcCBhZGRyIGFkZCAxMC4w
LjAuMi8yNCBkZXYgdmV0aDIiKTsKCXN5c3RlbSgiaXAgbGluayBzZXQgdmV0aDIgdXAiKTsK
CXN5c3RlbSgicGluZyAtYyAxIDEwLjAuMC4xIik7CglzeXN0ZW0oInBpbmcgLWMgMSAxMC4w
LjAuMiIpOwoJc3lzdGVtKCJyZG1hIGxpbmsgc2hvdyIpOwoJc3lzdGVtKCJyZG1hIGxpbmsg
YWRkIHNpd19kZXYxIHR5cGUgc2l3IG5ldGRldiB2ZXRoMSIpOwoJc3lzdGVtKCJyZG1hIGxp
bmsgYWRkIHNpd19kZXYyIHR5cGUgc2l3IG5ldGRldiB2ZXRoMiIpOwoJCQoJaWYgKCEoZXZj
aDEgPSByZG1hX2NyZWF0ZV9ldmVudF9jaGFubmVsKCkpKSB7CgkJcGVycm9yKCJzZXJ2ZXI6
IHJkbWFfY3JlYXRlX2V2ZW50X2NoYW5uZWwiKTsKCQlleGl0KC0xKTsKCX0KCWlmIChyZG1h
X2NyZWF0ZV9pZChldmNoMSwgJnNlcnZlcl9pZCwgTlVMTCwgUkRNQV9QU19UQ1ApKSB7CgkJ
cGVycm9yKCJzZXJ2ZXI6IHJkbWFfY3JlYXRlX2lkIik7CgkJZXhpdCgtMSk7Cgl9CglzaW4u
c2luX2ZhbWlseSA9IEFGX0lORVQ7CglzaW4uc2luX3BvcnQgPSBodG9ucyhwb3J0KTsKCXNp
bi5zaW5fYWRkci5zX2FkZHIgPSBodG9ubChJTkFERFJfQU5ZKTsKCWlmIChyZG1hX2JpbmRf
YWRkcihzZXJ2ZXJfaWQsIChzdHJ1Y3Qgc29ja2FkZHIgKikmc2luKSkgewoJCXBlcnJvcigi
c2VydmVyOiByZG1hX2JpbmRfYWRkciIpOwoJCWV4aXQoLTEpOwoJfQoJaWYgKHJkbWFfbGlz
dGVuKHNlcnZlcl9pZCwgNikpIHsKCQlwZXJyb3IoInNlcnZlcjogcmRtYV9saXN0ZW4iKTsK
CQlleGl0KC0xKTsKCX0KCWlmICghKGV2Y2gyID0gcmRtYV9jcmVhdGVfZXZlbnRfY2hhbm5l
bCgpKSkgewoJCXBlcnJvcigiY2xpZW50OiByZG1hX2NyZWF0ZV9ldmVudF9jaGFubmVsIik7
CgkJZXhpdCgtMSk7Cgl9CglpZiAocmRtYV9jcmVhdGVfaWQoZXZjaDIsICZjbGllbnRfaWQs
IE5VTEwsIFJETUFfUFNfVENQKSkgewoJCXBlcnJvcigiY2xpZW50OiByZG1hX2NyZWF0ZV9p
ZCIpOwoJCWV4aXQoLTEpOwoJfQoJc2luLnNpbl9mYW1pbHkgPSBBRl9JTkVUOwoJc2luLnNp
bl9wb3J0ID0gaHRvbnMocG9ydCk7CglzaW4uc2luX2FkZHIuc19hZGRyID0gaW5ldF9hZGRy
KHJlbW90ZV9hZGRyKTsKCWlmIChyZG1hX3Jlc29sdmVfYWRkcgoJICAgIChjbGllbnRfaWQs
IE5VTEwsIChzdHJ1Y3Qgc29ja2FkZHIgKikmc2luLCAyMDAwKSkgewoJCXBlcnJvcigiY2xp
ZW50OiByZG1hX3Jlc29sdmVfYWRkciIpOwoJCWV4aXQoLTEpOwoJfQoJaWYgKHJkbWFfZ2V0
X2NtX2V2ZW50KGV2Y2gyLCAmZXZlbnQpCgkgICAgfHwgZXZlbnQtPmV2ZW50ICE9IFJETUFf
Q01fRVZFTlRfQUREUl9SRVNPTFZFRCkgewoJCXBlcnJvcigiY2xpZW50OiByZG1hX2dldF9j
bV9ldmVudCIpOwoJCWV4aXQoLTEpOwoJfQoJcmRtYV9hY2tfY21fZXZlbnQoZXZlbnQpOwoJ
aWYgKHJkbWFfcmVzb2x2ZV9yb3V0ZShjbGllbnRfaWQsIDIwMDApKSB7CgkJcGVycm9yKCJj
bGllbnQ6IHJkbWFfcmVzb2x2ZV9yb3V0ZSIpOwoJCWV4aXQoLTEpOwoJfQoJaWYgKHJkbWFf
Z2V0X2NtX2V2ZW50KGV2Y2gyLCAmZXZlbnQpCgkgICAgfHwgZXZlbnQtPmV2ZW50ICE9IFJE
TUFfQ01fRVZFTlRfUk9VVEVfUkVTT0xWRUQpIHsKCQlwZXJyb3IoImNsaWVudDogcmRtYV9n
ZXRfY21fZXZlbnQiKTsKCQlleGl0KC0xKTsKCX0KCXJkbWFfYWNrX2NtX2V2ZW50KGV2ZW50
KTsKCWlmICghKHBkMiA9IGlidl9hbGxvY19wZChjbGllbnRfaWQtPnZlcmJzKSkpIHsKCQlw
ZXJyb3IoImNsaWVudDogaWJ2X2FsbG9jX3BkIik7CgkJZXhpdCgtMSk7Cgl9CglpZiAoISht
cjIgPSBpYnZfcmVnX21yKHBkMiwgbXNnLCAyNTYsCgkJCSAgICAgICBJQlZfQUNDRVNTX1JF
TU9URV9XUklURSB8CgkJCSAgICAgICBJQlZfQUNDRVNTX0xPQ0FMX1dSSVRFIHwKCQkJICAg
ICAgIElCVl9BQ0NFU1NfUkVNT1RFX1JFQUQpKSkgewoJCXBlcnJvcigiY2xpZW50OiBpYnZf
cmVnX21yIik7CgkJZXhpdCgtMSk7Cgl9CQkKCWlmICghKGNxMiA9IGlidl9jcmVhdGVfY3Eo
Y2xpZW50X2lkLT52ZXJicywgMzIsIDAsIDAsIDApKSkgewoJCXBlcnJvcigiY2xpZW50OiBp
YnZfY3JlYXRlX2NxIik7CgkJZXhpdCgtMSk7Cgl9CglhdHRyLnNlbmRfY3EgPSBhdHRyLnJl
Y3ZfY3EgPSBjcTI7CglpZiAocmRtYV9jcmVhdGVfcXAoY2xpZW50X2lkLCBwZDIsICZhdHRy
KSkgewoJCXBlcnJvcigiY2xpZW50OiByZG1hX2NyZWF0ZV9xcCIpOwoJCWV4aXQoLTEpOwoJ
fQoJc2dlLmFkZHIgPSAodWludDY0X3QpbXNnOwoJc2dlLmxlbmd0aCA9IG1zZ19sZW47Cglz
Z2UubGtleSA9IG1yMi0+bGtleTsKCXJjdl93ci5zZ19saXN0ID0gJnNnZTsKCXJjdl93ci5u
dW1fc2dlID0gMTsKCXJjdl93ci5uZXh0ID0gTlVMTDsKCWlmIChpYnZfcG9zdF9yZWN2KGNs
aWVudF9pZC0+cXAsICZyY3Zfd3IsIE5VTEwpKSB7CgkJcGVycm9yKCJjbGllbnQ6IGlidl9w
b3N0X3JlY3YiKTsKCQlleGl0KC0xKTsKCX0KCW1lbXNldCgmY29ubl9wYXJhbSwgMCwgc2l6
ZW9mIGNvbm5fcGFyYW0pOwoJaWYgKHJkbWFfY29ubmVjdChjbGllbnRfaWQsICZjb25uX3Bh
cmFtKSkgewoJCXBlcnJvcigiY2xpZW50OiByZG1hX2Nvbm5lY3QiKTsKCQlleGl0KC0xKTsK
CX0KCWlmIChyZG1hX2dldF9jbV9ldmVudChldmNoMSwgJmV2ZW50KQoJICAgIHx8IGV2ZW50
LT5ldmVudCAhPSBSRE1BX0NNX0VWRU5UX0NPTk5FQ1RfUkVRVUVTVCkgewoJCXBlcnJvcigi
c2VydmVyOiByZG1hX2dldF9jbV9ldmVudCIpOwoJCWV4aXQoLTEpOwoJfQoJY2xpZW50X2lk
ID0gKHN0cnVjdCByZG1hX2NtX2lkICopZXZlbnQtPmlkOwoJaWYgKCEocGQxID0gaWJ2X2Fs
bG9jX3BkKGNsaWVudF9pZC0+dmVyYnMpKSkgewoJCXBlcnJvcigic2VydmVyOiBpYnZfYWxs
b2NfcGQiKTsKCQlleGl0KC0xKTsKCX0KCWlmICghKG1yMSA9IGlidl9yZWdfbXIocGQxLCBt
c2csIDI1NiwKCQkJICAgICAgIElCVl9BQ0NFU1NfUkVNT1RFX1dSSVRFIHwKCQkJICAgICAg
IElCVl9BQ0NFU1NfTE9DQUxfV1JJVEUgfAoJCQkgICAgICAgSUJWX0FDQ0VTU19SRU1PVEVf
UkVBRCkpKSB7CgkJcGVycm9yKCJzZXJ2ZXI6IGlidl9yZWdfbXIiKTsKCQlleGl0KC0xKTsK
CX0KCWlmICghKGNxMSA9IGlidl9jcmVhdGVfY3EoY2xpZW50X2lkLT52ZXJicywgMzIsIDAs
IDAsIDApKSkgewoJCXBlcnJvcigic2VydmVyOiBpYnZfY3JlYXRlX2NxIik7CgkJZXhpdCgt
MSk7Cgl9CglhdHRyLnNlbmRfY3EgPSBhdHRyLnJlY3ZfY3EgPSBjcTE7CglpZiAocmRtYV9j
cmVhdGVfcXAoY2xpZW50X2lkLCBwZDEsICZhdHRyKSkgewoJCXBlcnJvcigic2VydmVyOiBy
ZG1hX2NyZWF0ZV9xcCIpOwoJCWV4aXQoLTEpOwoJfQoJbWVtc2V0KCZjb25uX3BhcmFtLCAw
LCBzaXplb2YgY29ubl9wYXJhbSk7CglpZiAocmRtYV9hY2NlcHQoY2xpZW50X2lkLCAmY29u
bl9wYXJhbSkpIHsKCQlwZXJyb3IoInNlcnZlcjogcmRtYV9hY2NlcHQiKTsKCQlleGl0KC0x
KTsKCX0KCXJkbWFfYWNrX2NtX2V2ZW50KGV2ZW50KTsKCWlmIChyZG1hX2dldF9jbV9ldmVu
dChldmNoMSwgJmV2ZW50KQoJICAgIHx8IGV2ZW50LT5ldmVudCAhPSBSRE1BX0NNX0VWRU5U
X0VTVEFCTElTSEVEKSB7CgkJcGVycm9yKCJzZXJ2ZXI6IHJkbWFfZ2V0X2NtX2V2ZW50Iik7
CgkJZXhpdCgtMSk7Cgl9CglyZG1hX2Fja19jbV9ldmVudChldmVudCk7CglzZ2UuYWRkciA9
ICh1aW50NjRfdCltc2c7CglzZ2UubGVuZ3RoID0gbXNnX2xlbjsKCXNnZS5sa2V5ID0gbXIx
LT5sa2V5OwoJc25kX3dyLnNnX2xpc3QgPSAmc2dlOwoJc25kX3dyLm51bV9zZ2UgPSAxOwoJ
c25kX3dyLm9wY29kZSA9IElCVl9XUl9TRU5EOwoJc25kX3dyLnNlbmRfZmxhZ3MgPSBJQlZf
U0VORF9TSUdOQUxFRDsKCXNuZF93ci5uZXh0ID0gTlVMTDsKCWlmIChpYnZfcG9zdF9zZW5k
KGNsaWVudF9pZC0+cXAsICZzbmRfd3IsICZiYWRfd3IpKSB7CgkJcGVycm9yKCJzZXJ2ZXI6
IGlidl9wb3N0X3NlbmQiKTsKCQlleGl0KC0xKTsKCX0KCXdoaWxlICghaWJ2X3BvbGxfY3Eo
Y3ExLCAxLCAmd2MpKQoJCTsKCWlmICh3Yy5zdGF0dXMgIT0gSUJWX1dDX1NVQ0NFU1MpIHsK
CQlwZXJyb3IoInNlcnZlcjogaWJ2X3BvbGxfY3EiKTsKCQlleGl0KC0xKTsKCX0KCWlmIChy
ZG1hX2dldF9jbV9ldmVudChldmNoMiwgJmV2ZW50KQoJICAgIHx8IGV2ZW50LT5ldmVudCAh
PSBSRE1BX0NNX0VWRU5UX0VTVEFCTElTSEVEKSB7CgkJcGVycm9yKCJjbGllbnQ6IHJkbWFf
Z2V0X2NtX2V2ZW50Iik7CgkJZXhpdCgtMSk7Cgl9CglyZG1hX2Fja19jbV9ldmVudChldmVu
dCk7Cgl3aGlsZSAoIWlidl9wb2xsX2NxKGNxMiwgMSwgJndjKSkKCQk7CglpZiAod2Muc3Rh
dHVzICE9IElCVl9XQ19TVUNDRVNTKSB7CgkJcGVycm9yKCJjbGllbnQ6IGlidl9wb2xsX2Nx
Iik7CgkJZXhpdCgtMSk7Cgl9CglwcmludGYoIlJlY2VpdmVkOiAlc1xuIiwgbXNnKTsKCWZm
bHVzaChzdGRvdXQpOwoJc3lzdGVtKCJyZG1hIGxpbmsgZGVsIHNpd19kZXYxIik7CglzeXN0
ZW0oInJkbWEgbGluayBkZWwgc2l3X2RldjIiKTsKCXN5c3RlbSgiaXAgbGluayBkZWwgdmV0
aDEgdHlwZSB2ZXRoIHBlZXIgbmFtZSB2ZXRoMiIpOwoJcmV0dXJuIHN5c3RlbSgicmRtYSBs
aW5rIGRlbCBzaXcwIik7Cn0K

--------------tFfTF8DD6j0hRR7qe5yDSEzB--

