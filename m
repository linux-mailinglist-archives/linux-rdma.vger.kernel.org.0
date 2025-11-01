Return-Path: <linux-rdma+bounces-14168-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF11C282BE
	for <lists+linux-rdma@lfdr.de>; Sat, 01 Nov 2025 17:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 981134E4423
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Nov 2025 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77A25F7A7;
	Sat,  1 Nov 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gUIKm6rf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3745A21D5AF
	for <linux-rdma@vger.kernel.org>; Sat,  1 Nov 2025 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014704; cv=none; b=brpuixZZUIXA4JuuI8aKlrvdzlB9BDjsP01Y+lcGQtrIV0l19i+vvOhAbh98BJca4RC5m0+YLaJuLu17xfW3XMY/8arW1R4gNQh8uxoRkuK6zB4t2L28CYYY1PU+G96ovbX10W1vOX5rzJvCyHaUKesViO9L2No7+tilc8/S/rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014704; c=relaxed/simple;
	bh=1knJm+gZFW/b1YzTgpyrV+yC1hvpfIP9iwpL7HSjFms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XNe75UCYuRRWvfu/HAP9du67ULEBtgCavaTlkOcRM1zhTELzX9603gvgnfHbrd3NsuugRSo79ZIHA1qnXPWQj5fZpwzQDMW22FZ7Lv0siT6BbbhF3nRKdq40ur8bOXeLr+AXu7YFBop5bjoBadyrJ0a3EgvE55+muKwkSo1UVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gUIKm6rf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471b80b994bso40207735e9.3
        for <linux-rdma@vger.kernel.org>; Sat, 01 Nov 2025 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762014700; x=1762619500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9hsASTuS8SBuaXxtIeQtR0l4ZGx3oezgGYfGVIK0wk8=;
        b=gUIKm6rfWQaWRhlvOU6kw3XZcpwEZenIMfpNITXLLS6dJSOsTBXaLWw6CPCXeL2IuY
         C+huWUkNyzRKaHIoQg1TCAsjYILKSra4OFqT6R50ilGDX0mduRXDi3vcdFBaWQWRtqFW
         sfN3LL94jdupWCBCh6mHAvOrLrCY8wO0R7HdVzsNTrvigevVzBRcL7U4JlHQ/zPaQ53h
         khJxu4xcII8NmNV6t1A9DtEUPtoibZ4gZT6VwDmibzesM5A0cLe8RSfpyv/5y19cM72J
         jNEI00FRzHIZj6TRidxK1WNpkqtWDiEyCoyTeQv6nfdEwQ+kwdSFjmwi9RdRyY33aNx6
         nclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762014700; x=1762619500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hsASTuS8SBuaXxtIeQtR0l4ZGx3oezgGYfGVIK0wk8=;
        b=Xe6+Ng18bPTIh8rzgzlqEVQul314PLhjJX42ITckZd5NTIr9Vk6VdWco9dtODpp/JW
         DvIRNs/Zqrfu4Pd3cX+SHhBcR1HY5/JM6yjptrQZi8omt1Hav1UgJmwlGcTi7URzL8G7
         BSdTpSoUc48TnkvUl6dn3ZRfvMS6zcIlFDuXSFjoaqvRC0T/ntWHyMOzeGMVxKB5KmGH
         v9xUcxNW5vjnhHzRtjQ5XbFg1XOvXLNxkE5uEpheD+VkRa2w5IPElmp1nJfvkpsgp/nm
         sV2/tuuV1ncRcN+GoAMklbzncCKkz4PCCf7i1GeANk/CDhQRZvjL0WvWabBWHNXEKgi9
         9bfg==
X-Forwarded-Encrypted: i=1; AJvYcCWq/Ke7sO5ecEFPpnm9AL3AesYhvV/mcyeHQ6Z3dF+V4uvl2ihFAEF32SFf9E3sf5AMo2hrITri3HtT@vger.kernel.org
X-Gm-Message-State: AOJu0YyLQYYghFQNl8H1Bls7qVQErPdcP7Wj7RWs9EdwzcODS3xKuJDi
	UqyRgpTsojHxgThYb9XAS6z7pec4w/m6IlpMWbD4Ji20/IRku/ztg3aTJDcAObwDjg49qbpdV5r
	v1dPd
X-Gm-Gg: ASbGncvYqwrcoeZtPnRmR2MKpJA7Wh9GpJ984Oka4+84JJtcPLzdyXgdCrmgTuyzVKi
	1U5X9EI1HQiDAdgXw5G94fuwNf+G9WbOyw54IqvVtPdMphh6q9JeWtFcMhC50GpBm3LzeWXzPVM
	78d+K60g76MzCrb2OPAqfI331tSD8nUkLESVfeDZ9M+KbSE1+Zqft25vgMovPx0cyjmEogSCJqc
	68ygc2vqGz7U5SrxeYPylROs18wuyjH+cYMMAobNdTnyxvxujhOhQlJxCebMPmykzYZG2AfpIgV
	xtsvsKIkCzwIp/AOQq2RWLKfu3sSoVnlpyeGaJL0IhdROWnmpuEy4rLbvdH5EDSFIi9oZ3F/lg6
	5kXiRY4PLYjYcezOujoIDGq8t8Xs1N71y45+vF01+fJGy/dmIzygCY9AQQJ3ZIcIWCHCZLCYJOc
	n5avu8gD6mNVGUR3hWQaWombVAO8zrdiqO2kM=
X-Google-Smtp-Source: AGHT+IHIun7MzFAVHGB6qF4KN179+4rTOhPG/e7xXDMwaiYnH56eJs/M0S4ud15gEhUITEEwUOlcng==
X-Received: by 2002:a05:600c:8b24:b0:46e:39da:1195 with SMTP id 5b1f17b1804b1-4773a8e4543mr48931195e9.3.1762014700210;
        Sat, 01 Nov 2025 09:31:40 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c394e33sm56742285e9.13.2025.11.01.09.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:31:39 -0700 (PDT)
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
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH 0/5] replaced system_unbound_wq, added WQ_PERCPU to alloc_workqueue
Date: Sat,  1 Nov 2025 17:31:10 +0100
Message-ID: <20251101163121.78400-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an
isolated CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

=== Recent changes to the WQ API ===

The following, address the recent changes in the Workqueue API:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The old workqueues will be removed in a future release cycle.

=== Introduced Changes by this series ===

1) [P 1]  Replace uses of system_wq and system_unbound_wq

    system_unbound_wq is to be used when locality is not required.

    Because of that, system_unbound_wq has been replaced with
    system_dfl_wq, to make sure it is the default choice when locality
    is not important.

    system_dfl_wq has the same behavior of the old system_unbound_wq.

2) [P 2-5] WQ_PERCPU added to alloc_workqueue()

    This change adds a new WQ_PERCPU flag to explicitly request
    alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.


Thanks!


Marco Crivellari (5):
  RDMA/core: RDMA/mlx5: replace use of system_unbound_wq with
    system_dfl_wq
  RDMA/core: WQ_PERCPU added to alloc_workqueue users
  hfi1: WQ_PERCPU added to alloc_workqueue users
  RDMA/mlx4: WQ_PERCPU added to alloc_workqueue users
  IB/rdmavt: WQ_PERCPU added to alloc_workqueue users

 drivers/infiniband/core/cm.c      | 2 +-
 drivers/infiniband/core/device.c  | 4 ++--
 drivers/infiniband/core/ucma.c    | 2 +-
 drivers/infiniband/hw/hfi1/init.c | 4 ++--
 drivers/infiniband/hw/hfi1/opfn.c | 4 ++--
 drivers/infiniband/hw/mlx4/cm.c   | 2 +-
 drivers/infiniband/hw/mlx5/odp.c  | 4 ++--
 drivers/infiniband/sw/rdmavt/cq.c | 3 ++-
 8 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.51.0


