Return-Path: <linux-rdma+bounces-7186-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32FDA19BA7
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 01:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161AE16BD54
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 00:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61640258A;
	Thu, 23 Jan 2025 00:04:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCC629;
	Thu, 23 Jan 2025 00:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737590651; cv=none; b=p2AW0ndzf4weZLUk66pA4ZxQbljXkAL4QrRVFCvQuz2QSPF/Y29jY8D53s6diOHGsRbzKwYFNFeR37JyR1i18B+w/sQ7kH0JqUXrVg9l1zHG/e1qoGKZQ8hulqaGI8gOVJwf7Sj9A/+2PgvZkQ7g1ohLepw+uztyeqy3o+SgVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737590651; c=relaxed/simple;
	bh=PH8LxbIrb2Kq9AS8sl24KAaDNIbUwoOmj7D4FMfbdgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeUbaR69rBItmrn02lsdgksKlgqSDf5NOLyHRvSs9T84d8ZlREsDPzuV5kzVtrTslnDZkhnA0ng2Y6b4HC/1dRcDH9gnuN3WFZfaIxjEqAjAv1XaiVHgFESS91majjli8KM9m2cqRs07/H+QMbEoHqyg1RiE5FO0nWBtR9TEgmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21670dce0a7so5119845ad.1;
        Wed, 22 Jan 2025 16:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737590648; x=1738195448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bY8ZVk2Uf7HppO8+gzzWHK3AIfhiQMvTEXF+Lh4vqR4=;
        b=Hs++o+zTWe10BDFbnKU8eWLiu/WIYViWNtIAfdTnJfK7jc0TgCe4n2a8GQMCNdZisx
         J//cIq7l6Jc/VkZapLZ2vS8rxGGw77SGMlXIGtSRQtq9IVhNgwiH4iWnHAlaGW+iquqa
         3IvUUMKq/WfgVJLgS4jthVly/XHHO7l8wN3OCg1tg6B+dh+XzdOku40I3Xos9RymnpFd
         Kl/dUJaJUZL7UOQ3I1lG/fCkqvQJ/vsLWsoVdCM/POsUqKZUnwVKplh/dK70Y0WvdVjF
         hoh61JblSQYojS1wuve9xGAN/Bwd5XYW4THxr9unGSHdBRr91AGOk8/Hriik2UzwjVeA
         TClQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdbDp3WORmtsT9WVOY9Zbs8+WuqMZxkqr3F0g2PsqhAt6dZMz9qagGqIXgLZCR+QuvJ6wsRn/Ymz9i/OQ=@vger.kernel.org, AJvYcCWZjGW3+oTspOpp8LpVXNEmgvWM7W/3pDJ/nkZ8W1K5Tqcg0OK5g9YhSib967+fX6BrJdP9QzSrjzBU4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YykV0OI1AYQiTRiVLCqJ7v9ji6M4y2RnNhT6esXaaiRO1EK4jwH
	5DKGMINoPXch042Pc1TCFrQEkpbMYKfXsxSfG4pgikgEGp0TIi3pDDkg
X-Gm-Gg: ASbGncuPtrPkMG2mTmH7jBgRikBSpilMknZUnalV/gOD4RTJLAzefXxDRq6uVbNRmoy
	jA6/a7TuWBZ6qk14EAzFl0Ue/h+XZCYhnL2lGpBiRhlNuCq9Gxkx1VkdEu8xXp6m1pAYhwzAf7c
	ra9v8qnzwl8WfsKxejEoNFQTEPWamw74pVpBo5Cj6f8MjVR0t7gDXiL0KvVzCmm7GtPtxHJvvTW
	3I9KrgKD3bkocjhEpTjJs4+e1MmhreZTo3DnAwFkp4hT0QO88RSXBnk0VTjU1KWbd65Yg==
X-Google-Smtp-Source: AGHT+IE7dxxpYn3JHZUsJEN8kIdACZ5n8A0bzXRZzD93uctIb4hINpZXVpaiSir5eGOs1NpJU+HmYg==
X-Received: by 2002:a05:6a20:9144:b0:1e1:a9dd:5a58 with SMTP id adf61e73a8af0-1eb215ec11cmr43812181637.30.1737590648353;
        Wed, 22 Jan 2025 16:04:08 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f510a2e24sm5293718b3a.47.2025.01.22.16.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 16:04:07 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	andrew+netdev@lunn.ch,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	witu@nvidia.com,
	parav@nvidia.com
Subject: [PATCH net] net/mlx5e: add missing cpu_to_node to kvzalloc_node in mlx5e_open_xdpredirect_sq
Date: Wed, 22 Jan 2025 16:04:07 -0800
Message-ID: <20250123000407.3464715-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvzalloc_node is not doing a runtime check on the node argument
(__alloc_pages_node_noprof does have a VM_BUG_ON, but it expands to
nothing on !CONFIG_DEBUG_VM builds), so doing any ethtool/netlink
operation that calls mlx5e_open on a CPU that's larger that MAX_NUMNODES
triggers OOB access and panic (see the trace below).

Add missing cpu_to_node call to convert cpu id to node id.

[  165.427394] mlx5_core 0000:5c:00.0 beth1: Link up
[  166.479327] BUG: unable to handle page fault for address: 0000000800000010
[  166.494592] #PF: supervisor read access in kernel mode
[  166.505995] #PF: error_code(0x0000) - not-present page
...
[  166.816958] Call Trace:
[  166.822380]  <TASK>
[  166.827034]  ? __die_body+0x64/0xb0
[  166.834774]  ? page_fault_oops+0x2cd/0x3f0
[  166.843862]  ? exc_page_fault+0x63/0x130
[  166.852564]  ? asm_exc_page_fault+0x22/0x30
[  166.861843]  ? __kvmalloc_node_noprof+0x43/0xd0
[  166.871897]  ? get_partial_node+0x1c/0x320
[  166.880983]  ? deactivate_slab+0x269/0x2b0
[  166.890069]  ___slab_alloc+0x521/0xa90
[  166.898389]  ? __kvmalloc_node_noprof+0x43/0xd0
[  166.908442]  __kmalloc_node_noprof+0x216/0x3f0
[  166.918302]  ? __kvmalloc_node_noprof+0x43/0xd0
[  166.928354]  __kvmalloc_node_noprof+0x43/0xd0
[  166.938021]  mlx5e_open_channels+0x5e2/0xc00
[  166.947496]  mlx5e_open_locked+0x3e/0xf0
[  166.956201]  mlx5e_open+0x23/0x50
[  166.963551]  __dev_open+0x114/0x1c0
[  166.971292]  __dev_change_flags+0xa2/0x1b0
[  166.980378]  dev_change_flags+0x21/0x60
[  166.988887]  do_setlink+0x38d/0xf20
[  166.996628]  ? ep_poll_callback+0x1b9/0x240
[  167.005910]  ? __nla_validate_parse.llvm.10713395753544950386+0x80/0xd70
[  167.020782]  ? __wake_up_sync_key+0x52/0x80
[  167.030066]  ? __mutex_lock+0xff/0x550
[  167.038382]  ? security_capable+0x50/0x90
[  167.047279]  rtnl_setlink+0x1c9/0x210
[  167.055403]  ? ep_poll_callback+0x1b9/0x240
[  167.064684]  ? security_capable+0x50/0x90
[  167.073579]  rtnetlink_rcv_msg+0x2f9/0x310
[  167.082667]  ? rtnetlink_bind+0x30/0x30
[  167.091173]  netlink_rcv_skb+0xb1/0xe0
[  167.099492]  netlink_unicast+0x20f/0x2e0
[  167.108191]  netlink_sendmsg+0x389/0x420
[  167.116896]  __sys_sendto+0x158/0x1c0
[  167.125024]  __x64_sys_sendto+0x22/0x30
[  167.133534]  do_syscall_64+0x63/0x130
[  167.141657]  ? __irq_exit_rcu.llvm.17843942359718260576+0x52/0xd0
[  167.155181]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: bb135e40129d ("net/mlx5e: move XDP_REDIRECT sq to dynamic allocation")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index bd41b75d246e..a814b63ed97e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2087,7 +2087,7 @@ static struct mlx5e_xdpsq *mlx5e_open_xdpredirect_sq(struct mlx5e_channel *c,
 	struct mlx5e_xdpsq *xdpsq;
 	int err;
 
-	xdpsq = kvzalloc_node(sizeof(*xdpsq), GFP_KERNEL, c->cpu);
+	xdpsq = kvzalloc_node(sizeof(*xdpsq), GFP_KERNEL, cpu_to_node(c->cpu));
 	if (!xdpsq)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.48.0


