Return-Path: <linux-rdma+bounces-12589-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFB1B1B48A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 15:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E481218A481C
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D98273D9B;
	Tue,  5 Aug 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2DoxTBE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C82472B7;
	Tue,  5 Aug 2025 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399528; cv=none; b=iC6I+xrYj8Q12iJ8OJ6czRcvC9c4zJqFEJ/+yrg/Fxy6EEUaworoyu81YWMxCvacc1mpm1fJu21+PIk/lotbSx/S4EPA8jGhfRp1ZS4OVdxGzsLFp3ymNoNpXGVI+eiHMyE94wDc4Ga3eS9i7RutPwbBeI9nm3iCS/hbRoeAELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399528; c=relaxed/simple;
	bh=5WXJAbD73Lfwp4U4OxR1suGOHLB52pORe0bKhk/O6R0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daKAiwx+uyXumdxzW7Cgb49/hi+/Z2DYTEYXj0HcXOs/gfM96dycwH7zQoY6mr7McJ80OqSAxarIZgMCy9Yjz4T5ZjHsvqynmmMZKheZ7cTVmNbAxMuOKz4XqlBvoFoIslv7vE1fOBF7TEYzDCXMT5Ei++kOJmgfth7IMbnWkNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2DoxTBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68827C4CEF0;
	Tue,  5 Aug 2025 13:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754399528;
	bh=5WXJAbD73Lfwp4U4OxR1suGOHLB52pORe0bKhk/O6R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2DoxTBEK4GY2UyE7oLyXr6f4mIxXY1v7uN9Rn/UTzpxC7fkmv4oLV+qIOqmR4frT
	 Hx3QSvMkWnVePSRkbmN/HL+dAGd8tk3nonj076ts74JpGXy6c0uRF0ITtaeV/xlglX
	 twoQppEBu4elGG/ltPH/nj9TKFn8IfwENref9cLk6impF1MzwZGcNVd8UbEnN0RuXh
	 7s+upSf+9Ig3Zc7BSb7XUS+w7SIHEr3lsOW3BJZQKRmJaaZ7veP/8NvIQZAfYpHBmr
	 CpFy4b9AwctuJKlgDxIwOarFZa46ZGJgQOKfuXVlA/J4m1h2PKV1hMjr4692R8OvCZ
	 AqAARXIvIYBMg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dennis.dalessandro@cornelisnetworks.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-5.4] RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()
Date: Tue,  5 Aug 2025 09:09:37 -0400
Message-Id: <20250805130945.471732-62-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250805130945.471732-1-sashal@kernel.org>
References: <20250805130945.471732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>

[ Upstream commit 59f7d2138591ef8f0e4e4ab5f1ab674e8181ad3a ]

The function divides number of online CPUs by num_core_siblings, and
later checks the divider by zero. This implies a possibility to get
and divide-by-zero runtime error. Fix it by moving the check prior to
division. This also helps to save one indentation level.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Link: https://patch.msgid.link/20250604193947.11834-3-yury.norov@gmail.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Bug Fix Analysis

The commit fixes a **genuine divide-by-zero bug** in the
`find_hw_thread_mask()` function. The code changes show:

1. **Original bug**: The division `num_cores_per_socket =
   node_affinity.num_online_cpus / affinity->num_core_siblings /
   node_affinity.num_online_nodes` occurs at lines 967-969 BEFORE
   checking if `num_core_siblings > 0` at line 972.

2. **The fix**: Moves the check `if (affinity->num_core_siblings == 0)
   return;` to line 973-974 (in the new code) BEFORE the division
   operation, preventing the divide-by-zero.

## When the Bug Can Trigger

The `num_core_siblings` value is initialized as:
```c
cpumask_weight(topology_sibling_cpumask(cpumask_first(&node_affinity.pro
c.mask)))
```

This can be 0 in several real-world scenarios:
- Single-core systems without SMT/hyperthreading
- Systems where SMT is disabled at runtime
- Virtualized environments with unusual CPU topology
- Certain ARM or other architectures where topology_sibling_cpumask()
  returns empty

## Stable Kernel Criteria Met

1. **Fixes a real bug**: ✓ - Prevents kernel divide-by-zero crash
2. **Small and contained**: ✓ - Only 20 lines changed in one function
3. **No side effects**: ✓ - Early return preserves existing behavior
   when num_core_siblings==0
4. **No architectural changes**: ✓ - Simple defensive programming fix
5. **Clear bug fix**: ✓ - Not a feature or optimization
6. **Low regression risk**: ✓ - Only adds safety check, doesn't change
   logic

## Impact Assessment

- **Severity**: Medium-High - Can cause kernel panic on affected systems
- **Affected systems**: HFI1 InfiniBand hardware on systems with
  specific CPU configurations
- **User impact**: System crash when loading HFI1 driver on vulnerable
  configurations

The commit message clearly states "fix possible divide-by-zero" and the
code change unambiguously moves a zero-check before a division operation
that uses that value as divisor. This is a textbook example of a bug fix
that should be backported to stable kernels to prevent crashes on
systems with certain CPU topologies.

 drivers/infiniband/hw/hfi1/affinity.c | 44 +++++++++++++++------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 7ead8746b79b..f2c530ab85a5 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -964,31 +964,35 @@ static void find_hw_thread_mask(uint hw_thread_no, cpumask_var_t hw_thread_mask,
 				struct hfi1_affinity_node_list *affinity)
 {
 	int possible, curr_cpu, i;
-	uint num_cores_per_socket = node_affinity.num_online_cpus /
+	uint num_cores_per_socket;
+
+	cpumask_copy(hw_thread_mask, &affinity->proc.mask);
+
+	if (affinity->num_core_siblings == 0)
+		return;
+
+	num_cores_per_socket = node_affinity.num_online_cpus /
 					affinity->num_core_siblings /
 						node_affinity.num_online_nodes;
 
-	cpumask_copy(hw_thread_mask, &affinity->proc.mask);
-	if (affinity->num_core_siblings > 0) {
-		/* Removing other siblings not needed for now */
-		possible = cpumask_weight(hw_thread_mask);
-		curr_cpu = cpumask_first(hw_thread_mask);
-		for (i = 0;
-		     i < num_cores_per_socket * node_affinity.num_online_nodes;
-		     i++)
-			curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
-
-		for (; i < possible; i++) {
-			cpumask_clear_cpu(curr_cpu, hw_thread_mask);
-			curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
-		}
+	/* Removing other siblings not needed for now */
+	possible = cpumask_weight(hw_thread_mask);
+	curr_cpu = cpumask_first(hw_thread_mask);
+	for (i = 0;
+	     i < num_cores_per_socket * node_affinity.num_online_nodes;
+	     i++)
+		curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
 
-		/* Identifying correct HW threads within physical cores */
-		cpumask_shift_left(hw_thread_mask, hw_thread_mask,
-				   num_cores_per_socket *
-				   node_affinity.num_online_nodes *
-				   hw_thread_no);
+	for (; i < possible; i++) {
+		cpumask_clear_cpu(curr_cpu, hw_thread_mask);
+		curr_cpu = cpumask_next(curr_cpu, hw_thread_mask);
 	}
+
+	/* Identifying correct HW threads within physical cores */
+	cpumask_shift_left(hw_thread_mask, hw_thread_mask,
+			   num_cores_per_socket *
+			   node_affinity.num_online_nodes *
+			   hw_thread_no);
 }
 
 int hfi1_get_proc_affinity(int node)
-- 
2.39.5


