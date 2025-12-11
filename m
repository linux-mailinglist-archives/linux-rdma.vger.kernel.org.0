Return-Path: <linux-rdma+bounces-14958-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFBECB5156
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 09:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDF403015ECC
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Dec 2025 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB022D94A8;
	Thu, 11 Dec 2025 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qIQXPiMQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF61946A;
	Thu, 11 Dec 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765440730; cv=none; b=hHSskycmLIIRIHIS0Va//r+VcglgS+WVIwuFDTNvxScP4p4iVBrwO6hAqNYVkwyT3FqbsorvC4Lqc9DeDlsQuSwhcTgZ4DILTb/TPEoFZJx7BXXMq4GGJok117WQV2ZilbaBMXdqGrCfKORyg0PTQLyoF3beHtafS6On829RolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765440730; c=relaxed/simple;
	bh=N6OppQr/z1dfTrkTPaQ8isa/Mn6p+jfhvd/S3awJahI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=XcmPbx0pyzezPuug6040nTIFDWTkqTQgNVLacv7Xt8Gc3kwVm2EXXsdjwuHIUO9ync6zZ0EuKuqhNFnxOa/WYeqC+moM4Xv/otUHn/VSbFjq+WnDOLJEk9TdMKnMSbC/PEVjPS5ov5HbU+p+3BOW73VxGKYT2VW/reaS/Bt1Svw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qIQXPiMQ; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1765440716; bh=aiRpgRmig8ChD1/EE2ECsd4nI7v03dUHkSeqvJbM/do=;
	h=From:To:Cc:Subject:Date;
	b=qIQXPiMQ6vvqEG9/yqe7JSZAuF1bZeCFITXr5w1TQc9BaekIa3upjnKLI+qYtVJ7P
	 3O9mtlMqfvYsHLcWUnaxA14+hbwz4U86Ac0CRHJ7gsZeW8Jw9GGF8f2BCUBPHvPkEy
	 LOxvA5bW+TOSgOPWb43HY7EKeEk8W33pYblLhNLQ=
Received: from localhost.localdomain ([101.227.46.167])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 2230E8D0; Thu, 11 Dec 2025 16:08:35 +0800
X-QQ-mid: xmsmtpt1765440515t6g0j7hks
Message-ID: <tencent_96252FF6CE27E9F41F13AC73CCC1BE350905@qq.com>
X-QQ-XMAILINFO: NnIX2CK8LSsJNPM6sjkYY1lcFiPtZ3+XFK7qRUftHjh6An+psjCVdaMqUrJ0JF
	 jVD0dFunq1CMjwqW1F/Bz3Vhoz0kSmQZSfc8SEA8jw7VnN+CsfONzLjOZa0weFsj3azyKyk5Q3t9
	 4dfjGGLTueBG4KI/ImVM+2mqyEoT9AsU2d4xXpk3yon/EOQHjiLbo2VT5zH9SmYqWxVsHJ+8tuzf
	 o3Z9LfcYMOVvXj4/fcX8M9cvC0fQeNCuUr4SyrK37oWYshZqjOgdP4uQe+CAQ/j7IBfncVX+xop9
	 8+Gu4G/rpOnA4FnFX7anJ4ql1rZralRyiGSp1zghRKFf5ZeX2q/qzwvTZzDyfN1pV/EuVy8MIisC
	 5rkAN9Wat0MDywP219OMzlrWudn0gCBX9EDguEviQfBJue9T+Zimi/+C9hMyMo0eKiBL4Qe4HZFY
	 mt1zz2ZBRgOqEUC4CpNxCvU0KeYCrbO12exveoHLBxwGbn3g671BHYIczSMi4096nfCRM7iEsPrH
	 hDQnV4bUA1+uK7RAviuTdVzZno/OHF1jBwF9RsR2M5TRODjxUAsKzTSAf+O4IrYS/xktVUU/muio
	 oEM+q34g6Z/RTeTHn30yqwIP3E2WQuZSYKYChnCIhXouEBrL7caJ9LMxxDBHTnML6c13pKTR1gSG
	 k4+10TxcxUCZn57r58MqfUdgLusHwZ1zHbiXcTX1IDFU8rESQyIRl7LlVqi0UvWmAct1YVEYoofj
	 QJld4W7fPKn5ctoHAPMDxTUt07xqgVu73drICsGldXWxKUdeG9z8/Ciy4Tt6ORm4/nlDYm7IbuTX
	 2Viuqmk8gplDpoLGimF3zD1pDuURT5Zgytur2mPfS6iOyfABAPT5L5rcVG0cOd8ZYFmzFlIgRgCA
	 ySIlUED6ASWBUfSmWNn3lavd+CXgppjRIupX5tSUw9pJ8iM6YpDnp+6rqNvN7FDKGDqagfRqiUFy
	 hoImanb71p5sj4yHk11ksb7ibvQpPFMBVOXdic9kRBTExhYP/xDvKaJ4OAUae2uRlg5ef6D0o2I1
	 As2Nhl7cJwC7v4PDxKLzoWN5SiisKxP5ZJ3KvKGOFnecOpzqkg
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: wujing <realwujing@qq.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wujing <realwujing@qq.com>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH] IB/core: Fix ABBA deadlock in rdma_dev_exit_net
Date: Thu, 11 Dec 2025 16:08:13 +0800
X-OQ-MSGID: <20251211080813.113792-1-realwujing@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an ABBA deadlock between rdma_dev_exit_net() and rdma_dev_init_net()
that causes massive processes stuck in D state and triggers soft lockup.

The problem was discovered in production environment running stress-ng
with network namespace operations. After 120+ seconds, multiple processes
got stuck and eventually triggered a soft lockup on CPU, leading to system
panic.

Full kernel log trace from the production crash:

[32754.001139] INFO: task kworker/u256:1:1700886 blocked for more than 120 seconds.
[32754.008609]       Tainted: G        W  O       6.6.0-0006.ctl4.aarch64 #1
[32754.016498] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[32754.024972] task:kworker/u256:1  state:D stack:0     pid:1700886 ppid:2      flags:0x00000208
[32754.034077] Workqueue: netns cleanup_net
[32754.043234] Call trace:
[32754.052459]  __switch_to+0x170/0x238
[32754.062013]  __schedule+0x428/0xa08
[32754.071633]  schedule+0x58/0x130
[32754.081301]  schedule_preempt_disabled+0x18/0x30
[32754.091252]  rwsem_down_write_slowpath+0x2a4/0x880
[32754.101419]  down_write+0x60/0x78
[32754.111732]  rdma_dev_exit_net+0x60/0x1d8 [ib_core]
[32754.122500]  ops_exit_list+0x4c/0x90
[32754.133311]  cleanup_net+0x2ac/0x580
[32754.144266]  process_one_work+0x170/0x3c0
[32754.155451]  worker_thread+0x22c/0x4d0
[32754.166775]  kthread+0xf8/0x128
[32754.178219]  ret_from_fork+0x10/0x20
[32754.229887] INFO: task stress-ng-clone:1848460 blocked for more than 121 seconds.
[32754.242302]       Tainted: G        W  O       6.6.0-0006.ctl4.aarch64 #1
[32754.255156] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[32754.268609] task:stress-ng-clone state:D stack:0     pid:1848460 ppid:1705870 flags:0x0000020c
[32754.282744] Call trace:
[32754.296845]  __switch_to+0x170/0x238
[32754.311182]  __schedule+0x428/0xa08
[32754.325699]  schedule+0x58/0x130
[32754.340345]  schedule_preempt_disabled+0x18/0x30
[32754.355259]  rwsem_down_read_slowpath+0x188/0x670
[32754.370341]  down_read+0x38/0xd8
[32754.385557]  rdma_dev_init_net+0x120/0x210 [ib_core]
[32754.401216]  ops_init+0x80/0x160
[32754.416952]  setup_net+0x114/0x338
[32754.432814]  copy_net_ns+0x144/0x310
[32754.448829]  create_new_namespaces+0x108/0x360
[32754.465123]  unshare_nsproxy_namespaces+0x68/0xb8
[32754.481661]  ksys_unshare+0x124/0x3f8
[32754.498367]  __arm64_sys_unshare+0x1c/0x38
[32754.515280]  invoke_syscall+0x50/0x128
[32754.532337]  el0_svc_common.constprop.0+0xc8/0xf0
[32754.549706]  do_el0_svc+0x24/0x38
[32754.567213]  el0_svc+0x50/0x1e0
[32754.584822]  el0t_64_sync_handler+0x100/0x130
[32754.602699]  el0t_64_sync+0x1a4/0x1a8
[32754.622898] INFO: task stress-ng-clone:1855770 blocked for more than 121 seconds.
[32754.641630]       Tainted: G        W  O       6.6.0-0006.ctl4.aarch64 #1
[32754.660796] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[32754.680588] task:stress-ng-clone state:D stack:0     pid:1855770 ppid:1703005 flags:0x0000020c
[32754.701003] Call trace:
[32754.721401]  __switch_to+0x170/0x238
[32754.742070]  __schedule+0x428/0xa08
[32754.762820]  schedule+0x58/0x130
[32754.783656]  schedule_preempt_disabled+0x18/0x30
[32754.804827]  rwsem_down_read_slowpath+0x188/0x670
[32754.826210]  down_read+0x38/0xd8
[32754.847677]  rdma_dev_init_net+0x120/0x210 [ib_core]
[32754.869601]  ops_init+0x80/0x160
[32754.890747]  setup_net+0x114/0x338
[32754.912072]  copy_net_ns+0x144/0x310
[32754.933567]  create_new_namespaces+0x108/0x360
[32754.955403]  unshare_nsproxy_namespaces+0x68/0xb8
[32754.977480]  ksys_unshare+0x124/0x3f8
[32754.999696]  __arm64_sys_unshare+0x1c/0x38
[32755.022211]  invoke_syscall+0x50/0x128
[32755.044865]  el0_svc_common.constprop.0+0xc8/0xf0
[32755.067857]  do_el0_svc+0x24/0x38
[32755.091009]  el0_svc+0x50/0x1e0
[32755.113669]  el0t_64_sync_handler+0x100/0x130
[32755.136195]  el0t_64_sync+0x1a4/0x1a8
[32755.158514] INFO: task stress-ng-clone:1856643 blocked for more than 121 seconds.
[32755.180811]       Tainted: G        W  O       6.6.0-0006.ctl4.aarch64 #1
[32755.203035] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[32755.225684] task:stress-ng-clone state:D stack:0     pid:1856643 ppid:1703079 flags:0x0000020c
[32755.248867] Call trace:
[32755.271902]  __switch_to+0x170/0x238
[32755.295058]  __schedule+0x428/0xa08
[32755.318173]  schedule+0x58/0x130
[32755.341211]  schedule_preempt_disabled+0x18/0x30
[32755.364281]  rwsem_down_read_slowpath+0x188/0x670
[32755.387320]  down_read+0x38/0xd8
[32755.410218]  rdma_dev_init_net+0x120/0x210 [ib_core]
[32755.433439]  ops_init+0x80/0x160
[32755.456537]  setup_net+0x114/0x338
[32755.479597]  copy_net_ns+0x144/0x310
[32755.502674]  create_new_namespaces+0x108/0x360
[32755.525888]  unshare_nsproxy_namespaces+0x68/0xb8
[32755.548885]  ksys_unshare+0x124/0x3f8
[32755.571533]  __arm64_sys_unshare+0x1c/0x38
[32755.593903]  invoke_syscall+0x50/0x128
[32755.615804]  el0_svc_common.constprop.0+0xc8/0xf0
[32755.637511]  do_el0_svc+0x24/0x38
[32755.659193]  el0_svc+0x50/0x1e0
[32755.680845]  el0t_64_sync_handler+0x100/0x130
[32755.702648]  el0t_64_sync+0x1a4/0x1a8
[32755.724966] INFO: task stress-ng-clone:1857557 blocked for more than 122 seconds.
[32755.747272]       Tainted: G        W  O       6.6.0-0006.ctl4.aarch64 #1
[32755.769740] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[32755.792562] task:stress-ng-clone state:D stack:0     pid:1857557 ppid:1704397 flags:0x0000020c
[32755.815790] Call trace:
[32755.838868]  __switch_to+0x170/0x238
[32755.862070]  __schedule+0x428/0xa08
[32755.885171]  schedule+0x58/0x130
[32755.908174]  schedule_preempt_disabled+0x18/0x30
[32755.931239]  rwsem_down_read_slowpath+0x188/0x670
[32755.954317]  down_read+0x38/0xd8
[32755.977330]  rdma_dev_init_net+0x120/0x210 [ib_core]
[32756.000549]  ops_init+0x80/0x160
[32756.023585]  setup_net+0x114/0x338
[32756.046639]  copy_net_ns+0x144/0x310
[32756.069664]  create_new_namespaces+0x108/0x360
[32756.092850]  unshare_nsproxy_namespaces+0x68/0xb8
[32756.115819]  ksys_unshare+0x124/0x3f8
[32756.138451]  __arm64_sys_unshare+0x1c/0x38
[32756.160814]  invoke_syscall+0x50/0x128
[32756.182721]  el0_svc_common.constprop.0+0xc8/0xf0
[32756.204411]  do_el0_svc+0x24/0x38
[32756.226090]  el0_svc+0x50/0x1e0
[32756.247750]  el0t_64_sync_handler+0x100/0x130
[32756.269569]  el0t_64_sync+0x1a4/0x1a8
[32756.291600] INFO: task stress-ng-clone:1858428 blocked for more than 123 seconds.
[32756.313908]       Tainted: G        W  O       6.6.0-0006.ctl4.aarch64 #1
[32756.336373] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[32756.359199] task:stress-ng-clone state:D stack:0     pid:1858428 ppid:1705594 flags:0x0000020c
[32756.382466] Call trace:
[32756.405568]  __switch_to+0x170/0x238
[32756.428780]  __schedule+0x428/0xa08
[32756.451891]  schedule+0x58/0x130
[32756.474900]  schedule_preempt_disabled+0x18/0x30
[32756.497974]  rwsem_down_read_slowpath+0x188/0x670
[32756.521035]  down_read+0x38/0xd8
[32756.544056]  rdma_dev_init_net+0x120/0x210 [ib_core]
[32756.567272]  ops_init+0x80/0x160
[32756.590318]  setup_net+0x114/0x338
[32756.613377]  copy_net_ns+0x144/0x310
[32756.636399]  create_new_namespaces+0x108/0x360
[32756.659576]  unshare_nsproxy_namespaces+0x68/0xb8
[32756.682534]  ksys_unshare+0x124/0x3f8
[32756.705186]  __arm64_sys_unshare+0x1c/0x38
[32756.727548]  invoke_syscall+0x50/0x128
[32756.749445]  el0_svc_common.constprop.0+0xc8/0xf0
[32756.771143]  do_el0_svc+0x24/0x38
[32756.792793]  el0_svc+0x50/0x1e0
[32756.814425]  el0t_64_sync_handler+0x100/0x130
[32756.836214]  el0t_64_sync+0x1a4/0x1a8
[32756.858417] INFO: task stress-ng-clone:1859786 blocked for more than 123 seconds.
[32756.880761]       Tainted: G        W  O       6.6.0-0006.ctl4.aarch64 #1
[32756.903208] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[32756.926018] task:stress-ng-clone state:D stack:0     pid:1859786 ppid:1703833 flags:0x0000020c
[32756.949236] Call trace:
[32756.972318]  __switch_to+0x170/0x238
[32756.995526]  __schedule+0x428/0xa08
[32757.018612]  schedule+0x58/0x130
[32757.041608]  schedule_preempt_disabled+0x18/0x30
[32757.064675]  rwsem_down_read_slowpath+0x188/0x670
[32757.087750]  down_read+0x38/0xd8
[32757.110779]  rdma_dev_init_net+0x120/0x210 [ib_core]
[32757.134014]  ops_init+0x80/0x160
[32757.157037]  setup_net+0x114/0x338
[32757.180100]  copy_net_ns+0x144/0x310
[32757.203140]  create_new_namespaces+0x108/0x360
[32757.226329]  unshare_nsproxy_namespaces+0x68/0xb8
[32757.249304]  ksys_unshare+0x124/0x3f8
[32757.271940]  __arm64_sys_unshare+0x1c/0x38
[32757.294288]  invoke_syscall+0x50/0x128
[32757.316214]  el0_svc_common.constprop.0+0xc8/0xf0
[32757.337905]  do_el0_svc+0x24/0x38
[32757.359561]  el0_svc+0x50/0x1e0
[32757.381189]  el0t_64_sync_handler+0x100/0x130
[32757.402989]  el0t_64_sync+0x1a4/0x1a8
[32757.425586] INFO: task stress-ng-clone:1862292 blocked for more than 124 seconds.
[32757.447864]       Tainted: G        W  O       6.6.0-0006.ctl4.aarch64 #1
[32757.470299] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[32757.493106] task:stress-ng-clone state:D stack:0     pid:1862292 ppid:1707297 flags:0x0000020c
[32757.516329] Call trace:
[32757.539411]  __switch_to+0x170/0x238
[32757.562597]  __schedule+0x428/0xa08
[32757.585708]  schedule+0x58/0x130
[32757.608704]  schedule_preempt_disabled+0x18/0x30
[32757.631753]  rwsem_down_read_slowpath+0x188/0x670
[32757.654791]  down_read+0x38/0xd8
[32757.677767]  rdma_dev_init_net+0x120/0x210 [ib_core]
[32757.700941]  ops_init+0x80/0x160
[32757.723941]  setup_net+0x114/0x338
[32757.746951]  copy_net_ns+0x144/0x310
[32757.769933]  create_new_namespaces+0x108/0x360
[32757.793053]  unshare_nsproxy_namespaces+0x68/0xb8
[32757.815941]  ksys_unshare+0x124/0x3f8
[32757.838533]  __arm64_sys_unshare+0x1c/0x38
[32757.860831]  invoke_syscall+0x50/0x128
[32757.882673]  el0_svc_common.constprop.0+0xc8/0xf0
[32757.904313]  do_el0_svc+0x24/0x38
[32757.925917]  el0_svc+0x50/0x1e0
[32757.947487]  el0t_64_sync_handler+0x100/0x130
[32757.969220]  el0t_64_sync+0x1a4/0x1a8
[32757.991241] INFO: task stress-ng-clone:1862471 blocked for more than 124 seconds.
[32758.013463]       Tainted: G        W  O       6.6.0-0006.ctl4.aarch64 #1
[32758.035857] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[32758.058617] task:stress-ng-clone state:D stack:0     pid:1862471 ppid:1705665 flags:0x0000020c
[32758.081778] Call trace:
[32758.104771]  __switch_to+0x170/0x238
[32758.127885]  __schedule+0x428/0xa08
[32758.150892]  schedule+0x58/0x130
[32758.173799]  schedule_preempt_disabled+0x18/0x30
[32758.196773]  rwsem_down_read_slowpath+0x188/0x670
[32758.219734]  down_read+0x38/0xd8
[32758.242653]  rdma_dev_init_net+0x120/0x210 [ib_core]
[32758.265798]  ops_init+0x80/0x160
[32758.288731]  setup_net+0x114/0x338
[32758.311709]  copy_net_ns+0x144/0x310
[32758.334641]  create_new_namespaces+0x108/0x360
[32758.357750]  unshare_nsproxy_namespaces+0x68/0xb8
[32758.380629]  ksys_unshare+0x124/0x3f8
[32758.403188]  __arm64_sys_unshare+0x1c/0x38
[32758.425459]  invoke_syscall+0x50/0x128
[32758.447288]  el0_svc_common.constprop.0+0xc8/0xf0
[32758.468920]  do_el0_svc+0x24/0x38
[32758.490517]  el0_svc+0x50/0x1e0
[32758.512085]  el0t_64_sync_handler+0x100/0x130
[32758.533800]  el0t_64_sync+0x1a4/0x1a8
[32758.556548] INFO: task stress-ng-clone:1866684 blocked for more than 125 seconds.
[32758.578796]       Tainted: G        W  O       6.6.0-0006.ctl4.aarch64 #1
[32758.601184] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[32758.623945] task:stress-ng-clone state:D stack:0     pid:1866684 ppid:1704388 flags:0x0000020c
[32758.647123] Call trace:
[32758.670159]  __switch_to+0x170/0x238
[32758.693295]  __schedule+0x428/0xa08
[32758.716341]  schedule+0x58/0x130
[32758.739291]  schedule_preempt_disabled+0x18/0x30
[32758.762297]  rwsem_down_read_slowpath+0x188/0x670
[32758.785305]  down_read+0x38/0xd8
[32758.808267]  rdma_dev_init_net+0x120/0x210 [ib_core]
[32758.831428]  ops_init+0x80/0x160
[32758.854385]  setup_net+0x114/0x338
[32758.877386]  copy_net_ns+0x144/0x310
[32758.900337]  create_new_namespaces+0x108/0x360
[32758.923472]  unshare_nsproxy_namespaces+0x68/0xb8
[32758.946378]  ksys_unshare+0x124/0x3f8
[32758.968961]  __arm64_sys_unshare+0x1c/0x38
[32758.991256]  invoke_syscall+0x50/0x128
[32759.013080]  el0_svc_common.constprop.0+0xc8/0xf0
[32759.034750]  do_el0_svc+0x24/0x38
[32759.056358]  el0_svc+0x50/0x1e0
[32759.077935]  el0t_64_sync_handler+0x100/0x130
[32759.099678]  el0t_64_sync+0x1a4/0x1a8
[32759.121308] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
[33047.476663] hrtimer: interrupt took 41202 ns
[33077.887371] sched: DL replenish lagged too much
[33315.344633] sched: RT throttling activated
[33341.279179] watchdog: BUG: soft lockup - CPU#108 stuck for 22s! [stress-ng-cpu-s:396764]
[33341.413642] Modules linked in: binfmt_misc xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c bridge stp llc bonding rfkill sunrpc vfat fat ipmi_si phytium_dc_drm ipmi_devintf drm_display_helper ipmi_msghandler ses cec enclosure drm_kms_helper cppc_cpufreq sg drm i2c_core fuse nfnetlink ext4 jbd2 dm_multipath mpt3sas(O) raid_class scsi_transport_sas mlx5_ib(O) macsec ib_uverbs(O) ib_core(O) sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 crct10dif_ce ghash_ce sm4_ce_gcm sm4_ce_ccm sm4_ce sm4_ce_cipher sm4 sm3_ce sha3_ce sha512_ce ahci sha512_arm64 sha2_ce libahci sha256_arm64 sha1_ce sbsa_gwdt megaraid_sas(O) libata mlx5_core(O) dm_mirror dm_region_hash dm_log dm_mod mlxfw(O) psample mlxdevm(O) mlx_compat(O) tls pci_hyperv_intf ngbe(O) aes_neon_bs aes_neon_blk aes_ce_blk aes_ce_cipher
[33342.020187] CPU: 108 PID: 396764 Comm: stress-ng-cpu-s Kdump: loaded Tainted: G        W  O       6.6.0-0006.ctl4.aarch64 #1
[33342.204035] Hardware name: SuperCloud R2227/FT5000C, BIOS KL4.2A.CY.S.029.240626.R 06/26/2024 16:26:27
[33342.389751] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[33342.574945] pc : print_cpu+0x2d4/0x6d8
[33342.749605] lr : print_cpu+0x2ec/0x6d8
[33342.909203] sp : ffff80010240bba0
[33343.072975] x29: ffff80010240bba0 x28: 0000000000200000 x27: 0000000000000000
[33343.249328] x26: ffff80008136e630 x25: ffff80008136eaa8 x24: 0000000000000000
[33343.424992] x23: ffff800082045980 x22: ffff800084098540 x21: ffff61071ae86380
[33343.586300] x20: ffff510509cb0000 x19: ffff510509cb0000 x18: ffffffffffffffff
[33343.749402] x17: 2d2d2d2d2d2d2d2d x16: 2d2d2d2d2d2d2d2d x15: ffff80010240b8d0
[33343.920636] x14: 0000000000000000 x13: ffff6107415d0491 x12: 2d2d2d2d2d2d2d2d
[33344.071637] x11: 0000000000000000 x10: 000000000000000a x9 : ffff80010240ba80
[33344.205707] x8 : 000000000000000a x7 : 00000000ffffffd0 x6 : 000000000000000a
[33344.335930] x5 : ffff6107415d0495 x4 : 00000000001d0495 x3 : ffff6101a03acc10
[33344.471238] x2 : 000000000000005e x1 : ffff510509cb0a30 x0 : ffff51060473e890
[33344.596109] Call trace:
[33344.719296]  print_cpu+0x2d4/0x6d8
[33344.842759]  sched_debug_show+0x28/0x58
[33344.956976]  seq_read_iter+0x168/0x478
[33345.062917]  seq_read+0xa4/0xe8
[33345.154201]  full_proxy_read+0x68/0xc8
[33345.276436]  vfs_read+0xb8/0x1f8
[33345.405545]  ksys_read+0x7c/0x120
[33345.542316]  __arm64_sys_read+0x24/0x38
[33345.705965]  invoke_syscall+0x50/0x128
[33345.887140]  el0_svc_common.constprop.0+0xc8/0xf0
[33346.061783]  do_el0_svc+0x24/0x38
[33346.208799]  el0_svc+0x50/0x1e0
[33346.333700]  el0t_64_sync_handler+0x100/0x130
[33346.480876]  el0t_64_sync+0x1a4/0x1a8
[33346.626028] Kernel panic - not syncing: softlockup: hung tasks
[33346.762219] CPU: 108 PID: 396764 Comm: stress-ng-cpu-s Kdump: loaded Tainted: G        W  O L     6.6.0-0006.ctl4.aarch64 #1
[33346.909029] Hardware name: SuperCloud R2227/FT5000C, BIOS KL4.2A.CY.S.029.240626.R 06/26/2024 16:26:27
[33347.052070] Call trace:
[33347.222863]  dump_backtrace+0xa0/0x128
[33347.373365]  show_stack+0x20/0x38
[33347.494054]  dump_stack_lvl+0x78/0xc8
[33347.619071]  dump_stack+0x18/0x28
[33347.743973]  panic+0x35c/0x3f8
[33347.874043]  watchdog_timer_fn+0x21c/0x2a8
[33348.014973]  __hrtimer_run_queues+0x15c/0x378
[33348.150149]  hrtimer_interrupt+0x10c/0x348
[33348.276630]  arch_timer_handler_phys+0x34/0x58
[33348.388360]  handle_percpu_devid_irq+0x90/0x1c8
[33348.492041]  handle_irq_desc+0x48/0x68
[33348.593527]  generic_handle_domain_irq+0x24/0x38
[33348.696771]  gic_handle_irq+0x1c0/0x380
[33348.791382]  call_on_irq_stack+0x24/0x30
[33348.878987]  do_interrupt_handler+0x88/0x98
[33348.960444]  el1_interrupt+0x54/0x120
[33349.023389]  el1h_64_irq_handler+0x24/0x30
[33349.083663]  el1h_64_irq+0x78/0x80
[33349.146750]  print_cpu+0x2d4/0x6d8
[33349.209473]  sched_debug_show+0x28/0x58
[33349.266322]  seq_read_iter+0x168/0x478
[33349.328919]  seq_read+0xa4/0xe8
[33349.392488]  full_proxy_read+0x68/0xc8
[33349.460141]  vfs_read+0xb8/0x1f8
[33349.528925]  ksys_read+0x7c/0x120
[33349.595094]  __arm64_sys_read+0x24/0x38
[33349.685944]  invoke_syscall+0x50/0x128
[33349.782633]  el0_svc_common.constprop.0+0xc8/0xf0
[33349.900634]  do_el0_svc+0x24/0x38
[33350.010436]  el0_svc+0x50/0x1e0
[33350.123291]  el0t_64_sync_handler+0x100/0x130
[33350.242707]  el0t_64_sync+0x1a4/0x1a8
[33350.356508] SMP: stopping secondary CPUs
[33351.100301] Starting crashdump kernel...
[33351.120225] Bye!

Root cause analysis:

Classic ABBA deadlock due to inconsistent lock ordering between
rdma_dev_exit_net() and rdma_dev_init_net():

Thread A (cleanup_net workqueue -> kworker/u256:1):
  rdma_dev_exit_net():
    down_write(&rdma_nets_rwsem)  <- held at line rdma_dev_exit_net+0x60
    down_read(&devices_rwsem)      <- waiting (shown in rwsem_down_write_slowpath)

Thread B (stress-ng-clone processes):
  rdma_dev_init_net():
    down_read(&devices_rwsem)      <- held at line rdma_dev_init_net+0x120
    down_read(&rdma_nets_rwsem)    <- waiting (blocked by pending writer from Thread A)

The soft lockup in print_cpu() is a cascading effect: when /proc/sched_debug
is read, print_cpu() iterates over all processes under rcu_read_lock(). With
thousands of processes stuck in D state due to the RDMA deadlock, this
iteration takes 22+ seconds, exceeding the soft lockup threshold and
triggering kernel panic.

Solution:

Reorder lock acquisition in rdma_dev_exit_net() to match rdma_dev_init_net().
Both functions now acquire locks in the same order:
  1. down_read(&devices_rwsem)
  2. down_write/read(&rdma_nets_rwsem)

This prevents the deadlock as both code paths now follow consistent lock
ordering, which is a fundamental requirement for deadlock-free execution.

Tested with:
  stress-ng --clone 100 --timeout 300s

No hung tasks or soft lockups observed after the fix.

Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: wujing <realwujing@qq.com>
---
 drivers/infiniband/core/device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d4263385850a..9ef2c966df8c 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1119,6 +1119,13 @@ static void rdma_dev_exit_net(struct net *net)
 	unsigned long index;
 	int ret;
 
+	/*
+	 * Fix ABBA deadlock: acquire locks in same order as rdma_dev_init_net
+	 * to prevent deadlock with concurrent namespace operations.
+	 * rdma_dev_init_net: devices_rwsem -> rdma_nets_rwsem
+	 * rdma_dev_exit_net: devices_rwsem -> rdma_nets_rwsem (was reversed)
+	 */
+	down_read(&devices_rwsem);
 	down_write(&rdma_nets_rwsem);
 	/*
 	 * Prevent the ID from being re-used and hide the id from xa_for_each.
@@ -1126,8 +1133,6 @@ static void rdma_dev_exit_net(struct net *net)
 	ret = xa_err(xa_store(&rdma_nets, rnet->id, NULL, GFP_KERNEL));
 	WARN_ON(ret);
 	up_write(&rdma_nets_rwsem);
-
-	down_read(&devices_rwsem);
 	xa_for_each (&devices, index, dev) {
 		get_device(&dev->dev);
 		/*
-- 
2.43.0


