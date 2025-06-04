Return-Path: <linux-rdma+bounces-11004-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07940ACE533
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 21:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C0416B684
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 19:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1277B23372E;
	Wed,  4 Jun 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP2BuS9e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B292309B9;
	Wed,  4 Jun 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749066001; cv=none; b=pPI3ZGVH4OVd9QG8NyXEIYM5jscUtwmu5NIrdyDm5rMGFhUqJdnIW5c6oBkSeD6b0xBo5R6OXa8twbSGqdsBpRPsZXQ2vOHs0wzNwinZ2lleBHaGcmbQzXpY0JAeNPGLDP7mTqPJ+nzH068txmL7NtQUPpzDhiKYX9FVnNUiXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749066001; c=relaxed/simple;
	bh=s/QY1Po14ZBHkphoj9O06O6cWcEVoAzPu+iI0zwgk68=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkvJWl9LyQWG9YtLng7AkqBKw47tEtbpuFalpYX9o/ExW6R+zBGgAWYrkCwoiq42AMe1xcRXgSz2S2QYnybVHntSPo2+gEnknafsTviohvCSfuidCeb6P5G3/e3ViRe9cSWS94CTVkrjuGWiAFmpy872XZIqfSZc5VE0hPGyGcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP2BuS9e; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e740a09eae0so253017276.1;
        Wed, 04 Jun 2025 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749065999; x=1749670799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xy03+0qgXoOuGkAi7VZcxw14vCcZM8u7fP3a/MZQfrA=;
        b=nP2BuS9e2V5f+0lMekXh0NvGzOZ84DaqB/vRvab05364crBwMvKP3dJF65/ma1/FZk
         T2Msof7XuBliaeyZbMyRSXnTB0RdVERdDXjmGl5fzMNGkn7D0urwX+nozC4xWNg9hDA5
         NoRoCjkFGtOpf6i6azxufmlRXQrAt8XtCrOiIH40Q4jb7faGXzaZF+oZXlL/KtpPbqDV
         toqvSUfqSKHuu6D3LULykbcbK4GtZnXwPYtTK90lS8Pv+MrKGkGXmTyGPVQM6QrI6Lrr
         dpQS90kxw4RC1arjTQmkIeo/zVwgZz/KzMBfrt+QxBMdlvYDa3A1FPhiY5cLBqEO/iSP
         NVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749065999; x=1749670799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xy03+0qgXoOuGkAi7VZcxw14vCcZM8u7fP3a/MZQfrA=;
        b=aYzKYlHF8jRcAds5LxbPhpvCg14+gR7LXU9YxujYaCe+GmpDSfL92qm5xWFsr4OXZc
         wS+TAx/wHcv3ExbvUPWRXcHfI8DITXnkzfr0yIT1V4LoLXNjeUGbByPlgZhnXhPDzpaK
         KKkN8i2l7ISIVwIOntm6zmTQzvfl7GS/EdcFTMejIZeGEQXj3MYsQn3BYXevdVVzg6hu
         t4OqrAvgF6yYtU3zYl+13NAHazThopQc+qZtHwpwpqVZQ5lLhA6KJ1khzYXczUBSGZW/
         a8t7SG5VS4o0oEKv0quRBZ6zDWaDctyuG/MxSgStcl4NabaYARbzr1gqU1fv6A0Nr0mI
         2eAg==
X-Forwarded-Encrypted: i=1; AJvYcCVBLBdDkrpvpa+qsfvoSNCUY1P54iDGxIF8yJ6Nk+z7O3LAfLPEZ6q/8w75w6qRdB0nGeS2q1bbTXwo5x8=@vger.kernel.org, AJvYcCW5yv0O/ylAv+EGyNDX3MCmMgVaiqEh/z61jd8K0ylT0+ChdksdjQCqPIjyYeXOBMmL4KYaoL4QiPvF1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ8DfLl+582WmpIFGCw6SZlHOZmc8AaVUxHV14Q6vIUrLFx+gi
	rBBuNUJpdEPQ9Z06PoezKByPQWekeJklMIT6fFs2o5+1NejFKWfe8k81
X-Gm-Gg: ASbGncvPK1tnCpeTMvWN+gYANLm7CkkxGdxGIF2BIc/832Eo1hyfWjQ0dVE/IHusJZr
	M4cxzqUOSbR1Ywxkdp+1hrPUjc0WV+4EnGT0eXgaEV7LOZhsGBa/oEQ9eufeEpWkrg+RTfxykmK
	FoECgx9anA3huPqf5/KkXRqre7zmQRssLs1uFjYzhJ79NR6lkQbTgOUwAYPTcoXx0NePM37Lu3G
	z++3LD88YZKyky6F7zLash5UrXAnOZka0lAYh5vjQt7hPwwVwTL3KyOpjOKuw6HNRjGGlKBPGrp
	zDnE/CcMT3zoBKUbunjuuHIeMSuFzB8PIEO4mGtUXBoy/AMmnm9xIZE7710X8t5qUr6b8WDAuGw
	5Fsn9kDepiu1m8QiAjQgJew==
X-Google-Smtp-Source: AGHT+IEgvSDC4r8ZjyVtKq87tEo+4ymzPJnysSG8drZl8IKClKNZ9U2jvuLNhJU6uUsAy6V0VhXkWw==
X-Received: by 2002:a05:690c:6d12:b0:70d:fe09:9b18 with SMTP id 00721157ae682-710d9d5f295mr61705857b3.2.1749065999029;
        Wed, 04 Jun 2025 12:39:59 -0700 (PDT)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8abce663sm31506727b3.2.2025.06.04.12.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 12:39:58 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] RDMA: hfi1: use rounddown in find_hw_thread_mask()
Date: Wed,  4 Jun 2025 15:39:41 -0400
Message-ID: <20250604193947.11834-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193947.11834-1-yury.norov@gmail.com>
References: <20250604193947.11834-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>

num_cores_per_socket is calculated by dividing by
node_affinity.num_online_nodes, but all users of this variable multiply
it by node_affinity.num_online_nodes again. This effectively is the same
as rounding it down by node_affinity.num_online_nodes.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 drivers/infiniband/hw/hfi1/affinity.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index b2884226827a..7fa894c23fea 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -955,27 +955,22 @@ static void find_hw_thread_mask(uint hw_thread_no, cpumask_var_t hw_thread_mask,
 				struct hfi1_affinity_node_list *affinity)
 {
 	int curr_cpu;
-	uint num_cores_per_socket;
+	uint num_cores;
 
 	cpumask_copy(hw_thread_mask, &affinity->proc.mask);
 
 	if (affinity->num_core_siblings == 0)
 		return;
 
-	num_cores_per_socket = node_affinity.num_online_cpus /
-					affinity->num_core_siblings /
-						node_affinity.num_online_nodes;
+	num_cores = rounddown(node_affinity.num_online_cpus / affinity->num_core_siblings,
+				node_affinity.num_online_nodes);
 
 	/* Removing other siblings not needed for now */
-	curr_cpu = cpumask_cpumask_nth(num_cores_per_socket *
-			node_affinity.num_online_nodes, hw_thread_mask) + 1;
+	curr_cpu = cpumask_nth(num_cores * node_affinity.num_online_nodes, hw_thread_mask) + 1;
 	cpumask_clear_cpus(hw_thread_mask, curr_cpu, nr_cpu_ids - curr_cpu);
 
 	/* Identifying correct HW threads within physical cores */
-	cpumask_shift_left(hw_thread_mask, hw_thread_mask,
-			   num_cores_per_socket *
-			   node_affinity.num_online_nodes *
-			   hw_thread_no);
+	cpumask_shift_left(hw_thread_mask, hw_thread_mask, num_cores * hw_thread_no);
 }
 
 int hfi1_get_proc_affinity(int node)
-- 
2.43.0


