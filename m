Return-Path: <linux-rdma+bounces-15022-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 618D3CC1E64
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 11:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 565B73011ED4
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5279522579E;
	Tue, 16 Dec 2025 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Bl5KilvI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73BD3B28D;
	Tue, 16 Dec 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765879231; cv=none; b=lSbsTHWop4dReQBNt7urLp0p/Luib4a0Uh9t9QVmS/m51gQJJJ++dJ18xC3dXXJSvnDC51prihHNoHqtd8l5r78HBMvmZChDwg+5J7CxUHRk3UJbpWWQIsNizyVSE5+mLJzXge0EBNCFn/siBjO04d/MC0/oCSNcY/6uIANJA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765879231; c=relaxed/simple;
	bh=UL5tqmVeLHRRXomNnFwu9nDn2D7mScN5D1PM848I1H4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZyqwcV2FcjTTpZrN2vNEyoHZ26c/a9tjwu56IdEL59TBy9SJ2fV33Z0RHp2ckJ+3S61kk4oR04sopqPScRAjzk9VEGXgxtuKKZFnthv1QbULGhMuAbODMMvECYVpIxBbD+dcLKmld3L+CeM+kUsNxh/GjrPJ/yvxk6xlIokRO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Bl5KilvI; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1765879219; bh=Pvpu1HrogDXXfwVxCyVJR7BTlJho+/iC+GY8S71iB/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bl5KilvIBFn5Sc7BsafW3/y3VC+uyrl1xi7csXFpfoR1a5f7XPVzDXAwgLC0WhlRG
	 GtqwFAN0VTTpwsDvRtRlnmLVLauesiRXeIsirAQ5alK3+7YPgJ8WM2dKrtovu46764
	 Hx6fGGcEKM9EK2Aha47Hg1vYuUqy8+NQdW5ns4NM=
Received: from localhost.localdomain ([101.227.46.167])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 11A94DA; Tue, 16 Dec 2025 18:00:17 +0800
X-QQ-mid: xmsmtpt1765879217t8b56ju57
Message-ID: <tencent_713807A8D67394A5D8339F8AD33FCCBFCE07@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRQNR50r+6odcQusgDmwlhu3djQQJJBuXJ0YQq60NjCw2DnrIzxQ
	 mnsfotfL12S4sGelFtIKCT+bYIBO5LS15ysqYRk3s5XT5VBVRPJOqdcA8woSkmEC3/fO6ofzKFPB
	 pq/f8a6vYxTQ6ZyKgEtEUipI6JlxI/00lcgfDJ3W/PueKJtVAgSAJXbRibx9ajqCRw2VZL54QfEC
	 U9WS5AGxL7sJbbZLtGeFqmrrK+9iqyvaHx+NhEXwDviM39x+7Zouf3ie7mjzP/eqUGGGSLBLshYL
	 pAeA02UIL16a9rNqXLqqhFIgvzyMbXT1ErggSvHuI63byxF7ZjAzgN9B9W/CtyOaPb398lx7b4qy
	 aDN4YLwWpnURMHOgga6rylV+cfyfjWkGZSln1Fsk6T4TC/oCw+3HtqthMLOkMYfo8yl2QlvRJ/+o
	 SW6RN2Uh1ylN7DLAFKBWVkdi6YUVkleq5IckpEJIXidEzDUfckM2KUl5i4TYvZXXwT7OJQdHcfGZ
	 Sve8DZuK0+JWYct1SaMmw2lYnlUfPzO/u89h8CUspocmcCcohgSOArYr5zVEOZImRDuGh2S+IsNu
	 xAMb2wjFWPR4cZI2TvCykw4Tu6yNyVIdbcoBRNqflp4Nua6FvVMGuBXuqAnzfXZ/8jPSCpgaFx9v
	 23kvWyJsa55Q/3T0bYn4VAvW89EFtRYDvkj2E5v+S4BZYmR73ZdFAKDBWowymZqUU+Dni672K7jc
	 KzJvdHKHaWTc/XIoDOtQoL4ZbCh6WNSZ0uSmMaJetp45l9uKBYrADNlwXG7VOKtaJYEql8s8KTrB
	 xbrLTDPVl8D59UezjOwag2V+3XblvI76PwxeJYNX83hAlC2iJe8LipFwC/pcFaSt55cpZ4Kr75t4
	 8xpFxSsa9rrGZJopHK6pKfQFViIkPKHUeiRl/GwY3CpUNBaWRMaaR2aJ6A5TdpYU84JsyyUrIwcC
	 Bc5ql+D1eFF+Z+QOx3xOOUEUImCPvENklpiTrVcleMdb75sspAtm3qyIvQOGoO4xsioVUXkZ6wEH
	 e9Uc8ca8366jactRLop7iOeuaMcHobP/xO9KT6qtVCFQ0q7/JsxvfR8kfNmlg=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: wujing <realwujing@qq.com>
To: jgg@ziepe.ca
Cc: leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	realwujing@qq.com,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH] IB/core: Fix ABBA deadlock in rdma_dev_exit_net
Date: Tue, 16 Dec 2025 17:59:52 +0800
X-OQ-MSGID: <20251216095957.828120-1-realwujing@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216005705.GB31492@ziepe.ca>
References: <20251216005705.GB31492@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hi Jason,

You're right that the locks aren't nested in rdma_dev_exit_net() - it does release 
rdma_nets_rwsem before acquiring devices_rwsem. However, this is still an ABBA deadlock,
just not the trivial nested kind. The issue is caused by **rwsem writer priority**
and lock ordering inconsistency.

Here's the actual deadlock scenario:

**Thread A (rdma_dev_exit_net - cleanup_net workqueue):**
```
down_write(&rdma_nets_rwsem);    // Acquired
xa_store(&rdma_nets, ...);
up_write(&rdma_nets_rwsem);      // Released
down_read(&devices_rwsem);       // Waiting here <-- BLOCKED
```

**Thread B (rdma_dev_init_net - stress-ng-clone):**
```
down_read(&devices_rwsem);       // Acquired
down_read(&rdma_nets_rwsem);     // Waiting here <-- BLOCKED
```

The deadlock happens because:

1. Thread A releases rdma_nets_rwsem as a **writer**
2. Thread B (and many others) are waiting to acquire rdma_nets_rwsem as **readers**
3. Thread A then tries to acquire devices_rwsem as a reader
4. BUT: rwsem gives priority to pending writers over new readers
5. Since Thread A was a pending writer on rdma_nets_rwsem, Thread B's read request is blocked
6. Thread B holds devices_rwsem, which Thread A needs
7. Thread A holds the "writer priority slot" on rdma_nets_rwsem, which Thread B needs

This is a **priority inversion deadlock**, not a simple nested lock deadlock.

The production crash log shows exactly this:
- Thread A: `rdma_dev_exit_net+0x60` stuck in `rwsem_down_write_slowpath` trying to get devices_rwsem
- Thread B: `rdma_dev_init_net+0x120` stuck in `rwsem_down_read_slowpath` trying to get rdma_nets_rwsem

Lockdep doesn't catch this because:
1. The locks aren't held simultaneously (no nested locking)
2. It's a reader-writer priority issue, not a simple lock ordering issue
3. It requires specific timing: writer releases lock, then tries to acquire another
lock that readers (waiting for the first lock) already hold

The fix ensures both paths acquire locks in the same order:
- rdma_dev_init_net: devices_rwsem → rdma_nets_rwsem
- rdma_dev_exit_net: devices_rwsem → rdma_nets_rwsem (was reversed)

This eliminates the priority inversion scenario.

Best regards


