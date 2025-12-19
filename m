Return-Path: <linux-rdma+bounces-15109-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5926ACD0760
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 16:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E19B303E3E2
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Dec 2025 15:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82546326931;
	Fri, 19 Dec 2025 15:11:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0228C21CC7B
	for <linux-rdma@vger.kernel.org>; Fri, 19 Dec 2025 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157094; cv=none; b=Xgl85r4Mh6Eb4SdaE9MoH2LGKyCmpJ73JP+wwuntxCy7nbDlpx0FlMw+puU30w7OP4mkGFaqzWdYs8QVGxKjUXhcW6qOaUCXYaqXxVx8/2NukmGLQJJhzbFBLsdI/57V1q7I+xZLTqa/F52s0Fj1WN+2cueucICWJ2cIySHeXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157094; c=relaxed/simple;
	bh=glz/goSD/JqqyyelJt8nNtbz5MIx7yNHc7ssEEffOjw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=RXzXEOUk56w67U1po4ly8Cn0IbEOx6pZyEy8FUcac6mlGhBUflUqdGRERch9zM8YmJ5Gxo2QEUEQTYntHrQ4nMclRYmuqLBw8LM/WpVxkvC2EhSFXon7ltuykB4Ueoh5oYSjAkGXLMpPDeWTjmtrnnYha1ALpHT5t2xKEo1romc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BJF9BFe014069;
	Sat, 20 Dec 2025 00:09:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BJF991T014056
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Dec 2025 00:09:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Content-Type: multipart/mixed; boundary="------------G9Dj8jKaJaOpUdvdA9B5snnh"
Message-ID: <98907ad9-2f85-49ff-9baf-cff7fcbc3cbf@I-love.SAKURA.ne.jp>
Date: Sat, 20 Dec 2025 00:09:06 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/core: flush gid_cache_wq WQ from disable_device()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Majd Dibbiny <majd@mellanox.com>, Doug Ledford <dledford@redhat.com>,
        Yuval Shaia <yshaia@marvell.com>,
        Bernard Metzler <bernard.metzler@linux.dev>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
 <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
 <1722eff3-14c1-408b-999b-1be3e8fbfe5a@I-love.SAKURA.ne.jp>
 <9b4ce0df-1fbf-4052-9eb9-1f3d6ad6a685@I-love.SAKURA.ne.jp>
 <13f54775-7a36-48f2-b9cd-62ab9f15a82b@I-love.SAKURA.ne.jp>
 <ace1ebe4-4fdb-49f4-a3fa-bbf11e1b40ed@I-love.SAKURA.ne.jp>
 <20251216140512.GC6079@nvidia.com>
 <10caea5b-9ad1-44ce-9eaf-a0f4023f2017@I-love.SAKURA.ne.jp>
 <b4457da3-be2e-4de3-ae16-5580e1fb625c@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <b4457da3-be2e-4de3-ae16-5580e1fb625c@I-love.SAKURA.ne.jp>
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp
X-Virus-Status: clean

This is a multi-part message in MIME format.
--------------G9Dj8jKaJaOpUdvdA9B5snnh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot finally found a reproducer for this bug.
When this reproducer is executed, disable_device() cannot return.
Can you find what is happening?


Showing all locks held in the system:
3 locks held by kworker/u512:1/13:
 #0: ffff88dc003d9d48 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x4dd/0x560
 #1: ffffcc00c009fe40 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x1e2/0x560
 #2: ffffffffa027de70 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0x51/0x3f0
3 locks held by kworker/u513:0/88:
 #0: ffff88dc2c853d48 ((wq_completion)ib-unreg-wq){+.+.}-{0:0}, at: process_one_work+0x4dd/0x560
 #1: ffffcc00c0f1fe40 ((work_completion)(&device->unregistration_work)){+.+.}-{0:0}, at: process_one_work+0x1e2/0x560
 #2: ffff88dc2bc56700 (&device->unregistration_lock){+.+.}-{4:4}, at: __ib_unregister_device+0xe4/0x180 [ib_core]
3 locks held by bash/1175:
 #0: ffff88dc02734420 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x79/0xf0
 #1: ffffffff9ff9f220 (rcu_read_lock){....}-{1:3}, at: __handle_sysrq+0x44/0x120
 #2: ffffffff9ff9f220 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire.constprop.0+0x7/0x30

=============================================

[root@localhost ~]# cat /proc/13/stack
[<0>] msleep+0x1b/0x30
[<0>] netdev_wait_allrefs_any+0x15a/0x220
[<0>] netdev_run_todo+0x188/0x3c0
[<0>] default_device_exit_batch+0x170/0x1c0
[<0>] ops_undo_list+0x10d/0x3b0
[<0>] cleanup_net+0x20b/0x3f0
[<0>] process_one_work+0x223/0x560
[<0>] worker_thread+0x1cb/0x3a0
[<0>] kthread+0xff/0x240
[<0>] ret_from_fork+0x23b/0x280
[<0>] ret_from_fork_asm+0x1a/0x30
[root@localhost ~]# cat /proc/88/stack
[<0>] disable_device+0xb4/0x170 [ib_core]
[<0>] __ib_unregister_device+0x110/0x180 [ib_core]
[<0>] ib_unregister_work+0x19/0x30 [ib_core]
[<0>] process_one_work+0x223/0x560
[<0>] worker_thread+0x1cb/0x3a0
[<0>] kthread+0xff/0x240
[<0>] ret_from_fork+0x23b/0x280
[<0>] ret_from_fork_asm+0x1a/0x30

--------------G9Dj8jKaJaOpUdvdA9B5snnh
Content-Type: text/plain; charset=UTF-8; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c2NoZWQuaD4KI2luY2x1ZGUgPHN0ZGlu
dC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgojaW5j
bHVkZSA8dW5pc3RkLmg+CgpzdGF0aWMgdm9pZCBleGVjdXRlMShjb25zdCBpbnQgZmQpCnsK
CS8vICBzZW5kbXNnJFJETUFfTkxERVZfQ01EX1NFVCBhcmd1bWVudHM6IFsKCS8vICAgIGZk
OiBzb2NrX25sX3JkbWEgKHJlc291cmNlKQoJLy8gICAgbXNnOiBwdHJbaW4sIG1zZ2hkcl9u
ZXRsaW5rW25ldGxpbmtfbXNnW1JETUFfTkxERVZfU0VULCB2b2lkLAoJLy8gICAgbmxkZXZf
cG9saWN5JFNFVF1dXSB7CgkvLyAgICAgIG1zZ2hkcl9uZXRsaW5rW25ldGxpbmtfbXNnW1JE
TUFfTkxERVZfU0VULCB2b2lkLCBubGRldl9wb2xpY3kkU0VUXV0gewoJLy8gICAgICAgIGFk
ZHI6IG5pbAoJLy8gICAgICAgIGFkZHJsZW46IGxlbiA9IDB4MCAoNCBieXRlcykKCS8vICAg
ICAgICBwYWQgPSAweDAgKDQgYnl0ZXMpCgkvLyAgICAgICAgdmVjOiBwdHJbaW4sIGlvdmVj
W2luLCBuZXRsaW5rX21zZ1tSRE1BX05MREVWX1NFVCwgdm9pZCwKCS8vICAgICAgICBubGRl
dl9wb2xpY3kkU0VUXV1dIHsKCS8vICAgICAgICAgIGlvdmVjW2luLCBuZXRsaW5rX21zZ1tS
RE1BX05MREVWX1NFVCwgdm9pZCwgbmxkZXZfcG9saWN5JFNFVF1dIHsKCS8vICAgICAgICAg
ICAgYWRkcjogcHRyW2lub3V0LCBhcnJheVtBTllVTklPTl1dIHsKCS8vICAgICAgICAgICAg
ICBhcnJheVtBTllVTklPTl0gewoJLy8gICAgICAgICAgICAgICAgdW5pb24gQU5ZVU5JT04g
ewoJLy8gICAgICAgICAgICAgICAgICBBTllCTE9COiBidWZmZXI6IHsyNCAwMCAwMCAwMCAx
YiAxNCAwMSAwMCAyYSBiZCBkNCA0NCBkNAoJLy8gICAgICAgICAgICAgICAgICA0NiBkZiAy
NSAwOCAwMCAwMSAwMCAwMCAwMCAwMCAwMCAwOSAwMCAwMn0gKGxlbmd0aCAweDFiKQoJLy8g
ICAgICAgICAgICAgICAgfQoJLy8gICAgICAgICAgICAgIH0KCS8vICAgICAgICAgICAgfQoJ
Ly8gICAgICAgICAgICBsZW46IGxlbiA9IDB4MjQgKDggYnl0ZXMpCgkvLyAgICAgICAgICB9
CgkvLyAgICAgICAgfQoJLy8gICAgICAgIHZsZW46IGNvbnN0ID0gMHgxICg4IGJ5dGVzKQoJ
Ly8gICAgICAgIGN0cmw6IGNvbnN0ID0gMHgwICg4IGJ5dGVzKQoJLy8gICAgICAgIGN0cmxs
ZW46IGNvbnN0ID0gMHgwICg4IGJ5dGVzKQoJLy8gICAgICAgIGY6IHNlbmRfZmxhZ3MgPSAw
eDQwNDA4OTEgKDQgYnl0ZXMpCgkvLyAgICAgICAgcGFkID0gMHgwICg0IGJ5dGVzKQoJLy8g
ICAgICB9CgkvLyAgICB9CgkvLyAgICBmOiBzZW5kX2ZsYWdzID0gMHg0MTgwICg4IGJ5dGVz
KQoJLy8gIF0KCSoodWludDY0X3QqKTB4MjAwMDAwMDAwMTQwID0gMDsKCSoodWludDMyX3Qq
KTB4MjAwMDAwMDAwMTQ4ID0gMDsKCSoodWludDY0X3QqKTB4MjAwMDAwMDAwMTUwID0gMHgy
MDAwMDAwMDAyMDA7CgkqKHVpbnQ2NF90KikweDIwMDAwMDAwMDIwMCA9IDB4MjAwMDAwMDAw
MWMwOwoJbWVtY3B5KCh2b2lkKikweDIwMDAwMDAwMDFjMCwKCSAgICAgICAiXHgyNFx4MDBc
eDAwXHgwMFx4MWJceDE0XHgwMVx4MDBceDJhXHhiZFx4ZDRceDQ0XHhkNFx4NDZceGRmXHgy
NVx4MDgiCgkgICAgICAgIlx4MDBceDAxXHgwMFx4MDBceDAwXHgwMFx4MDBceDA5XHgwMFx4
MDIiLAoJICAgICAgIDI3KTsKCSoodWludDY0X3QqKTB4MjAwMDAwMDAwMjA4ID0gMHgyNDsK
CSoodWludDY0X3QqKTB4MjAwMDAwMDAwMTU4ID0gMTsKCSoodWludDY0X3QqKTB4MjAwMDAw
MDAwMTYwID0gMDsKCSoodWludDY0X3QqKTB4MjAwMDAwMDAwMTY4ID0gMDsKCSoodWludDMy
X3QqKTB4MjAwMDAwMDAwMTcwID0gMHg0MDQwODkxOwoJc3lzY2FsbChfX05SX3NlbmRtc2cs
IC8qZmQ9Ki9mZCwgLyptc2c9Ki8weDIwMDAwMDAwMDE0MHVsLAoJCS8qZj1NU0dfTk9TSUdO
QUx8TVNHX0VPUnwweDEwMCovIDB4NDE4MHVsKTsKfQoKc3RhdGljIHZvaWQgZXhlY3V0ZTIo
Y29uc3QgaW50IGZkKQp7CgkvLyAgc2VuZG1zZyRSRE1BX05MREVWX0NNRF9ORVdMSU5LIGFy
Z3VtZW50czogWwoJLy8gICAgZmQ6IHNvY2tfbmxfcmRtYSAocmVzb3VyY2UpCgkvLyAgICBt
c2c6IHB0cltpbiwgbXNnaGRyX25ldGxpbmtbbmV0bGlua19tc2dbUkRNQV9OTERFVl9ORVdM
SU5LLCB2b2lkLAoJLy8gICAgbmxkZXZfcG9saWN5JE5FV0xJTktdXV0gewoJLy8gICAgICBt
c2doZHJfbmV0bGlua1tuZXRsaW5rX21zZ1tSRE1BX05MREVWX05FV0xJTkssIHZvaWQsCgkv
LyAgICAgIG5sZGV2X3BvbGljeSRORVdMSU5LXV0gewoJLy8gICAgICAgIGFkZHI6IG5pbAoJ
Ly8gICAgICAgIGFkZHJsZW46IGxlbiA9IDB4MCAoNCBieXRlcykKCS8vICAgICAgICBwYWQg
PSAweDAgKDQgYnl0ZXMpCgkvLyAgICAgICAgdmVjOiBwdHJbaW4sIGlvdmVjW2luLCBuZXRs
aW5rX21zZ1tSRE1BX05MREVWX05FV0xJTkssIHZvaWQsCgkvLyAgICAgICAgbmxkZXZfcG9s
aWN5JE5FV0xJTktdXV0gewoJLy8gICAgICAgICAgaW92ZWNbaW4sIG5ldGxpbmtfbXNnW1JE
TUFfTkxERVZfTkVXTElOSywgdm9pZCwKCS8vICAgICAgICAgIG5sZGV2X3BvbGljeSRORVdM
SU5LXV0gewoJLy8gICAgICAgICAgICBhZGRyOiBwdHJbaW4sIG5ldGxpbmtfbXNnX3RbY29u
c3RbUkRNQV9OTERFVl9ORVdMSU5LLCBpbnQxNl0sCgkvLyAgICAgICAgICAgIHZvaWQsIG5s
ZGV2X3BvbGljeSRORVdMSU5LXV0gewoJLy8gICAgICAgICAgICAgIG5ldGxpbmtfbXNnX3Rb
Y29uc3RbUkRNQV9OTERFVl9ORVdMSU5LLCBpbnQxNl0sIHZvaWQsCgkvLyAgICAgICAgICAg
ICAgbmxkZXZfcG9saWN5JE5FV0xJTktdIHsKCS8vICAgICAgICAgICAgICAgIGxlbjogbGVu
ID0gMHgzOCAoNCBieXRlcykKCS8vICAgICAgICAgICAgICAgIHR5cGU6IGNvbnN0ID0gMHgx
NDAzICgyIGJ5dGVzKQoJLy8gICAgICAgICAgICAgICAgZmxhZ3M6IG5ldGxpbmtfbXNnX2Zs
YWdzID0gMHgxICgyIGJ5dGVzKQoJLy8gICAgICAgICAgICAgICAgc2VxOiBpbnQzMiA9IDB4
NzBiZDJkICg0IGJ5dGVzKQoJLy8gICAgICAgICAgICAgICAgcGlkOiBpbnQzMiA9IDB4MjVk
ZmZiZmIgKDQgYnl0ZXMpCgkvLyAgICAgICAgICAgICAgICBwYXlsb2FkOiBidWZmZXI6IHt9
IChsZW5ndGggMHgwKQoJLy8gICAgICAgICAgICAgICAgYXR0cnM6IGFycmF5W25sZGV2X3Bv
bGljeSRORVdMSU5LXSB7CgkvLyAgICAgICAgICAgICAgICAgIG5sZGV2X3BvbGljeSRORVdM
SU5LIHsKCS8vICAgICAgICAgICAgICAgICAgICBSRE1BX05MREVWX0FUVFJfREVWX05BTUU6
CgkvLyAgICAgICAgICAgICAgICAgICAgbmxhdHRyX3RbY29uc3RbUkRNQV9OTERFVl9BVFRS
X0RFVl9OQU1FLCBpbnQxNl0sCgkvLyAgICAgICAgICAgICAgICAgICAgc3RyaW5nW25sZGV2
X25hbWVdXSB7CgkvLyAgICAgICAgICAgICAgICAgICAgICBubGFfbGVuOiBvZmZzZXRvZiA9
IDB4OSAoMiBieXRlcykKCS8vICAgICAgICAgICAgICAgICAgICAgIG5sYV90eXBlOiBjb25z
dCA9IDB4MiAoMiBieXRlcykKCS8vICAgICAgICAgICAgICAgICAgICAgIHBheWxvYWQ6IGJ1
ZmZlcjogezczIDc5IDdhIDMxIDAwfSAobGVuZ3RoIDB4NSkKCS8vICAgICAgICAgICAgICAg
ICAgICAgIHNpemU6IGJ1ZmZlcjoge30gKGxlbmd0aCAweDApCgkvLyAgICAgICAgICAgICAg
ICAgICAgICBwYWQgPSAweDAgKDMgYnl0ZXMpCgkvLyAgICAgICAgICAgICAgICAgICAgfQoJ
Ly8gICAgICAgICAgICAgICAgICAgIFJETUFfTkxERVZfQVRUUl9MSU5LX1RZUEU6CgkvLyAg
ICAgICAgICAgICAgICAgICAgbmxhdHRyX3RbY29uc3RbUkRNQV9OTERFVl9BVFRSX0xJTktf
VFlQRSwgaW50MTZdLAoJLy8gICAgICAgICAgICAgICAgICAgIHN0cmluZ1tubGRldl90eXBl
XV0gewoJLy8gICAgICAgICAgICAgICAgICAgICAgbmxhX2xlbjogb2Zmc2V0b2YgPSAweDgg
KDIgYnl0ZXMpCgkvLyAgICAgICAgICAgICAgICAgICAgICBubGFfdHlwZTogY29uc3QgPSAw
eDQxICgyIGJ5dGVzKQoJLy8gICAgICAgICAgICAgICAgICAgICAgcGF5bG9hZDogYnVmZmVy
OiB7NzIgNzggNjUgMDB9IChsZW5ndGggMHg0KQoJLy8gICAgICAgICAgICAgICAgICAgICAg
c2l6ZTogYnVmZmVyOiB7fSAobGVuZ3RoIDB4MCkKCS8vICAgICAgICAgICAgICAgICAgICB9
CgkvLyAgICAgICAgICAgICAgICAgICAgUkRNQV9OTERFVl9BVFRSX05ERVZfTkFNRToKCS8v
ICAgICAgICAgICAgICAgICAgICBubGF0dHJfdFtjb25zdFtSRE1BX05MREVWX0FUVFJfTkRF
Vl9OQU1FLCBpbnQxNl0sCgkvLyAgICAgICAgICAgICAgICAgICAgZGV2bmFtZV0gewoJLy8g
ICAgICAgICAgICAgICAgICAgICAgbmxhX2xlbjogb2Zmc2V0b2YgPSAweDE0ICgyIGJ5dGVz
KQoJLy8gICAgICAgICAgICAgICAgICAgICAgbmxhX3R5cGU6IGNvbnN0ID0gMHgzMyAoMiBi
eXRlcykKCS8vICAgICAgICAgICAgICAgICAgICAgIHBheWxvYWQ6IGJ1ZmZlcjogezZjIDZm
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwCgkvLyAgICAgICAgICAgICAgICAgICAg
ICAwMCAwMCAwMCAwMH0gKGxlbmd0aCAweDEwKSBzaXplOiBidWZmZXI6IHt9IChsZW5ndGgK
CS8vICAgICAgICAgICAgICAgICAgICAgIDB4MCkKCS8vICAgICAgICAgICAgICAgICAgICB9
CgkvLyAgICAgICAgICAgICAgICAgIH0KCS8vICAgICAgICAgICAgICAgIH0KCS8vICAgICAg
ICAgICAgICB9CgkvLyAgICAgICAgICAgIH0KCS8vICAgICAgICAgICAgbGVuOiBsZW4gPSAw
eDM4ICg4IGJ5dGVzKQoJLy8gICAgICAgICAgfQoJLy8gICAgICAgIH0KCS8vICAgICAgICB2
bGVuOiBjb25zdCA9IDB4MSAoOCBieXRlcykKCS8vICAgICAgICBjdHJsOiBjb25zdCA9IDB4
MCAoOCBieXRlcykKCS8vICAgICAgICBjdHJsbGVuOiBjb25zdCA9IDB4MCAoOCBieXRlcykK
CS8vICAgICAgICBmOiBzZW5kX2ZsYWdzID0gMHg0MDAwODQwICg0IGJ5dGVzKQoJLy8gICAg
ICAgIHBhZCA9IDB4MCAoNCBieXRlcykKCS8vICAgICAgfQoJLy8gICAgfQoJLy8gICAgZjog
c2VuZF9mbGFncyA9IDB4NDAwMCAoOCBieXRlcykKCS8vICBdCgkqKHVpbnQ2NF90KikweDIw
MDAwMDAwMDAwMCA9IDA7CgkqKHVpbnQzMl90KikweDIwMDAwMDAwMDAwOCA9IDA7CgkqKHVp
bnQ2NF90KikweDIwMDAwMDAwMDAxMCA9IDB4MjAwMDAwMDAwMTQwOwoJKih1aW50NjRfdCop
MHgyMDAwMDAwMDAxNDAgPSAweDIwMDAwMDAwMDE4MDsKCSoodWludDMyX3QqKTB4MjAwMDAw
MDAwMTgwID0gMHgzODsKCSoodWludDE2X3QqKTB4MjAwMDAwMDAwMTg0ID0gMHgxNDAzOwoJ
Kih1aW50MTZfdCopMHgyMDAwMDAwMDAxODYgPSAxOwoJKih1aW50MzJfdCopMHgyMDAwMDAw
MDAxODggPSAweDcwYmQyZDsKCSoodWludDMyX3QqKTB4MjAwMDAwMDAwMThjID0gMHgyNWRm
ZmJmYjsKCSoodWludDE2X3QqKTB4MjAwMDAwMDAwMTkwID0gOTsKCSoodWludDE2X3QqKTB4
MjAwMDAwMDAwMTkyID0gMjsKCW1lbWNweSgodm9pZCopMHgyMDAwMDAwMDAxOTQsICJzeXox
XDAwMCIsIDUpOwoJKih1aW50MTZfdCopMHgyMDAwMDAwMDAxOWMgPSA4OwoJKih1aW50MTZf
dCopMHgyMDAwMDAwMDAxOWUgPSAweDQxOwoJbWVtY3B5KCh2b2lkKikweDIwMDAwMDAwMDFh
MCwgInJ4ZVwwMDAiLCA0KTsKCSoodWludDE2X3QqKTB4MjAwMDAwMDAwMWE0ID0gMHgxNDsK
CSoodWludDE2X3QqKTB4MjAwMDAwMDAwMWE2ID0gMHgzMzsKCW1lbWNweSgodm9pZCopMHgy
MDAwMDAwMDAxYTgsCgkgICAgICAgImxvXDAwMFwwMDBcMDAwXDAwMFwwMDBcMDAwXDAwMFww
MDBcMDAwXDAwMFwwMDBcMDAwXDAwMFwwMDAiLCAxNik7CgkqKHVpbnQ2NF90KikweDIwMDAw
MDAwMDE0OCA9IDB4Mzg7CgkqKHVpbnQ2NF90KikweDIwMDAwMDAwMDAxOCA9IDE7CgkqKHVp
bnQ2NF90KikweDIwMDAwMDAwMDAyMCA9IDA7CgkqKHVpbnQ2NF90KikweDIwMDAwMDAwMDAy
OCA9IDA7CgkqKHVpbnQzMl90KikweDIwMDAwMDAwMDAzMCA9IDB4NDAwMDg0MDsKCXN5c2Nh
bGwoX19OUl9zZW5kbXNnLCAvKmZkPSovZmQsIC8qbXNnPSovMHgyMDAwMDAwMDAwMDB1bCwK
CQkvKmY9TVNHX05PU0lHTkFMKi8gMHg0MDAwdWwpOwp9CgppbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqYXJndltdKQp7CglzeXNjYWxsKF9fTlJfbW1hcCwgLyphZGRyPSovMHgyMDAwMDAw
MDAwMDB1bCwgLypsZW49Ki8weDEwMDAwMDB1bCwKCQkvKnByb3Q9UFJPVF9XUklURXxQUk9U
X1JFQUR8UFJPVF9FWEVDKi8gN3VsLAoJCS8qZmxhZ3M9TUFQX0ZJWEVEfE1BUF9BTk9OWU1P
VVN8TUFQX1BSSVZBVEUqLyAweDMydWwsCgkJLypmZD0qLyhpbnRwdHJfdCktMSwgLypvZmZz
ZXQ9Ki8wdWwpOwoJaWYgKHVuc2hhcmUoQ0xPTkVfTkVXTkVUKSkKCQlyZXR1cm4gMTsKCWlu
dCBmZCA9IHN5c2NhbGwoX19OUl9zb2NrZXQsIC8qZG9tYWluPSovMHgxMHVsLCAvKnR5cGU9
Ki8zdWwsIC8qcHJvdG89Ki8weDE0KTsKCWlmIChmZCA9PSAtMSkKCQlyZXR1cm4gMTsKCWV4
ZWN1dGUxKGZkKTsKCWV4ZWN1dGUyKGZkKTsKCWV4ZWN1dGUxKGZkKTsKCXJldHVybiAwOwp9
Cg==

--------------G9Dj8jKaJaOpUdvdA9B5snnh--

