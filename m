Return-Path: <linux-rdma+bounces-14171-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C6C282D3
	for <lists+linux-rdma@lfdr.de>; Sat, 01 Nov 2025 17:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F2E44E6AE9
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Nov 2025 16:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6275F269CE6;
	Sat,  1 Nov 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UcYYUJpy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19625EF9C
	for <linux-rdma@vger.kernel.org>; Sat,  1 Nov 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014707; cv=none; b=RJR/sPPqfEF1RXvRR5qQ/wq2K3eqB9483fS+ggyO3e5MgVM4pP46VqnswIheblq+ACsm5OA0AOydw0JBFxJljf+N1EH9kEZnjl/ErXxT9AUP9UUxfXZkKG0JZ6Mm7BlhvJDmwm6ijrVQU0gsfoijBrDfKWEYRr1oqUOzmJi9BH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014707; c=relaxed/simple;
	bh=/fJWXrgv/OmTyZRl62UO7f1B2tt8SS+io9NaSSSihmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNOrVJdHfQqLZ+gIWxqEzFu7EUJ6shBgiWsvdZ3K7jFjJmvFQMOc7zWDE1fzaMiTM7WJCPQkffnBMgETrlEfCyKpRHYnFRn8gOWpTvJQmpJgDTdE2xXCMf3O/0OlVMze1gk0NPOoQBBWB3A4TFdEhR9BF1DH/klEyyoAZGHDbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UcYYUJpy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47114a40161so36378515e9.3
        for <linux-rdma@vger.kernel.org>; Sat, 01 Nov 2025 09:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762014703; x=1762619503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiF6O5TboqTQJwgMv2bEVEic5NcjvvE8AbRu81SIfqU=;
        b=UcYYUJpysslvXn3Tz0p9AD4H55NNmm8nzd/HYevTVjwTQfzO9mKaJ196w2mts5QLMh
         mqxRcV3V3dXzjRwBWYQaK5jcQyos1En8hm29LpfThjIIiBv4PbwMz+ahBvGpPrf4uQl/
         04I60OWyxmUCZ9fkHH0ve8iUx+TfZj2EK4wL+c67enH8kzZIcj9VNK1TtvXXTostljP3
         sfMDREBRiSU3Cdb86WsWCqlGqQFClYLqy45u54Cl3O/pC1FlVx8kJsN4pi4L25nWEUyd
         m5zeDC9msQycuxRwY1MQ80lGilbtfc0S7txluQxFxKRNqQr2EevT/LOk8QoHvnXgzi32
         udRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762014703; x=1762619503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiF6O5TboqTQJwgMv2bEVEic5NcjvvE8AbRu81SIfqU=;
        b=Reodx6kZM9J31bj/Q0MRAwytJAhc+vScVrBGm0VXnOSoD82aUYpz1TA/R5O6uV185C
         E4rwhxKyYkoFeCUdIhLHlKWbeisEtYmdBwbNuRJUEXnyddUP2qSp/m0zXvSt2p6bUivg
         aelq1Pa69FE5p0vgF+kzVnuCQlZrcXoN1phQw5RlMZpoIBD+/2t952hSu3rsW3qj+2qn
         c2uy6tk80oKMiCcAM4uIorYaC6M7UQC9T+yvTQ7YPnHx4baIV1au93I80KBYf7qkRMqY
         w2TzZsJpWTWA/7eUxoOs1lgWKmqZ9Gll8rRXa7aW0RQBG31+PUHxb2A54oxUwRQz4Lcz
         w1Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVqMyaZ99sF+K7KxFstkvnlC3XOLgPDPpwMuylKScnwZpGLgR0CyTg5rS+icZFT9AdMJqQ3ynhXTyxF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4baAaN5/G5AJkMsQfM2etLRtpB6XUZwxm54BRnGJHB6F49AJ9
	V93p3xD2dXX+LohDG91Adyll9pmjnlLSj5AkHIfGShjZGVms3QBUhtTDWTD7zUCX9z8=
X-Gm-Gg: ASbGncsyLI23rp/eZo1gzircbASePs6zcu5gNF5OsH+SMBlb5dRiXk3qbLfleebeZ8+
	mCHfw4dlDNd+MGIUt5pX0Bef8JzwB/0HQfhoCssf+rwF5WDLPhU/Kvod8V2lKGmeaCD5mcf1EpK
	wlTMd+sNSTSrJeqaYx8lIpRfnOromPMPoAo8diKW+2Kzgm76XlPoTaqeiLjPSHcZaSqdlsni7SQ
	vBuHZMTNTFaucP5AwWvtmJejSaPFYyvRNJYomBpWraETrsVLR8qI6umZfuB9q4YAEbcSiuYtQxW
	K8MfdM0nuwIp8z/OdWm2je03fPQrlm77K4iHolZSiL5j01HkVxnktX9/+mXmnWJX0UROdZqAVzv
	+eEMSo6Y4SOEI+8Af5C6rW+/nlD6JIKCr4cVAWNxHpFee5fMf7JzScPK84YGNz0WM9Lv9clyRuE
	PLltJ4HDBrLWCaL43hbBh8NO6M
X-Google-Smtp-Source: AGHT+IG5VsZ0I9qX4nQcvqF1Dy4VWh3f2+M5kkzIn3zTq7wV9N3+7gooZ1qGGJuV0B5fn4K9tBOhGA==
X-Received: by 2002:a05:600c:870e:b0:46e:46c7:b79a with SMTP id 5b1f17b1804b1-477307c2233mr79040245e9.2.1762014702972;
        Sat, 01 Nov 2025 09:31:42 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm56742285e9.13.2025.11.01.09.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:31:42 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Subject: [PATCH 3/5] hfi1: WQ_PERCPU added to alloc_workqueue users
Date: Sat,  1 Nov 2025 17:31:13 +0100
Message-ID: <20251101163121.78400-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101163121.78400-1-marco.crivellari@suse.com>
References: <20251101163121.78400-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

CC: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/infiniband/hw/hfi1/init.c | 4 ++--
 drivers/infiniband/hw/hfi1/opfn.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index b35f92e7d865..e4aef102dac0 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -745,8 +745,8 @@ static int create_workqueues(struct hfi1_devdata *dd)
 			ppd->hfi1_wq =
 				alloc_workqueue(
 				    "hfi%d_%d",
-				    WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE |
-				    WQ_MEM_RECLAIM,
+				    WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM |
+				    WQ_PERCPU,
 				    HFI1_MAX_ACTIVE_WORKQUEUE_ENTRIES,
 				    dd->unit, pidx);
 			if (!ppd->hfi1_wq)
diff --git a/drivers/infiniband/hw/hfi1/opfn.c b/drivers/infiniband/hw/hfi1/opfn.c
index 370a5a8eaa71..6e0e3458d202 100644
--- a/drivers/infiniband/hw/hfi1/opfn.c
+++ b/drivers/infiniband/hw/hfi1/opfn.c
@@ -305,8 +305,8 @@ void opfn_trigger_conn_request(struct rvt_qp *qp, u32 bth1)
 int opfn_init(void)
 {
 	opfn_wq = alloc_workqueue("hfi_opfn",
-				  WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE |
-				  WQ_MEM_RECLAIM,
+				  WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM |
+				  WQ_PERCPU,
 				  HFI1_MAX_ACTIVE_WORKQUEUE_ENTRIES);
 	if (!opfn_wq)
 		return -ENOMEM;
-- 
2.51.0


