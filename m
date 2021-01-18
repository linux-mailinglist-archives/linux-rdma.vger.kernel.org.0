Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851782FAD76
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbhARWnE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389243AbhARWld (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:41:33 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24142C0617BB
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j18so3910019wmi.3
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0odIIb71gLysc99o7hSpWqiBOOlJNCvIqwb7Jz29Fk=;
        b=YQ2AW4xEy4MNM5rPTpDcxqXyWqKpzl+i2h2Z67NlcYo+dqSuFOTLA4bFPD17vqDvBS
         InV2nJ3KffUAEDP7S6VM7U4zijlY0I5on8AAI+TZJyBIWrMbQyRzhuM529LOVE0MB0/7
         oDRC7/1XDPurVhUP+y2Zivi3NeIdsVFnZmk/XtWd7t9KEfmPLvJ8r64up5B5Zpzpjzfr
         s/v0hVLn5OH5UefDh0iasBAbfbGtRpYSXcyb7loIm/4em9mtQdJl1pmQKEzpDFaaH568
         7ADX7UNXiO3IczlS/Q5f3CVf+c4OjML3pX6AgAviadUfZjHMPhQoUgcoGohxD4fCZREa
         ZaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0odIIb71gLysc99o7hSpWqiBOOlJNCvIqwb7Jz29Fk=;
        b=pdPadZm9N9BUxyd3ftvHGnA3NYUeudqhHHn8azooAV7lwjqnxr5zv4rRsDbU2zF8Xa
         eu7NaIb9HV9NP+4Inc1rgd7hyJyHlYU1uB9Jy0U+nAPuV1gfxPwDZTUIqlCqh/lI3TUF
         sA6a4xCjVwFvlqa+/H8vS8l4eFVdlVriURJm5CftbHKQbC4mzuLKbNz0QUBrtt8CErNj
         K9L8mwk4UfFVArC3LnJaQSnP1tptddqK/TXEznA5oNU0hB7QwCOJ1zqCTNsm+zyGd7/a
         0fOVWUP1NO5rg8s/6c5wSxfgooK06vpMC1eYW41+NZHYf6FzUctigqQ4mII4zH1iYsOB
         UCVg==
X-Gm-Message-State: AOAM532711pqn7IU9zwxb1vgBn/8zi6Qa4FkscCIokGZ4Bgw+nsFIR3R
        smUBrR9+Q90eUtfS7nOFOV5ikA==
X-Google-Smtp-Source: ABdhPJwlccrl67+t7ZABG9yzzNJxErT0+ReKmjMjNX0Xju+TMw1+ojmx1rv6NjxMXe84gxBospve+w==
X-Received: by 2002:a05:600c:4417:: with SMTP id u23mr1333403wmn.100.1611009592883;
        Mon, 18 Jan 2021 14:39:52 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH 18/20] RDMA/core/counters: Demote non-conformant kernel-doc headers
Date:   Mon, 18 Jan 2021 22:39:27 +0000
Message-Id: <20210118223929.512175-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
References: <20210118223929.512175-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/core/counters.c:36: warning: Function parameter or member 'dev' not described in 'rdma_counter_set_auto_mode'
 drivers/infiniband/core/counters.c:36: warning: Function parameter or member 'port' not described in 'rdma_counter_set_auto_mode'
 drivers/infiniband/core/counters.c:36: warning: Function parameter or member 'on' not described in 'rdma_counter_set_auto_mode'
 drivers/infiniband/core/counters.c:36: warning: Function parameter or member 'mask' not described in 'rdma_counter_set_auto_mode'
 drivers/infiniband/core/counters.c:238: warning: Function parameter or member 'qp' not described in 'rdma_get_counter_auto_mode'
 drivers/infiniband/core/counters.c:238: warning: Function parameter or member 'port' not described in 'rdma_get_counter_auto_mode'
 drivers/infiniband/core/counters.c:282: warning: Function parameter or member 'qp' not described in 'rdma_counter_bind_qp_auto'
 drivers/infiniband/core/counters.c:282: warning: Function parameter or member 'port' not described in 'rdma_counter_bind_qp_auto'
 drivers/infiniband/core/counters.c:320: warning: Function parameter or member 'qp' not described in 'rdma_counter_unbind_qp'
 drivers/infiniband/core/counters.c:388: warning: Function parameter or member 'dev' not described in 'rdma_counter_get_hwstat_value'
 drivers/infiniband/core/counters.c:388: warning: Function parameter or member 'port' not described in 'rdma_counter_get_hwstat_value'
 drivers/infiniband/core/counters.c:388: warning: Function parameter or member 'index' not described in 'rdma_counter_get_hwstat_value'
 drivers/infiniband/core/counters.c:444: warning: Function parameter or member 'dev' not described in 'rdma_counter_bind_qpn'
 drivers/infiniband/core/counters.c:444: warning: Function parameter or member 'port' not described in 'rdma_counter_bind_qpn'
 drivers/infiniband/core/counters.c:444: warning: Function parameter or member 'qp_num' not described in 'rdma_counter_bind_qpn'
 drivers/infiniband/core/counters.c:444: warning: Function parameter or member 'counter_id' not described in 'rdma_counter_bind_qpn'
 drivers/infiniband/core/counters.c:494: warning: Function parameter or member 'dev' not described in 'rdma_counter_bind_qpn_alloc'
 drivers/infiniband/core/counters.c:494: warning: Function parameter or member 'port' not described in 'rdma_counter_bind_qpn_alloc'
 drivers/infiniband/core/counters.c:494: warning: Function parameter or member 'qp_num' not described in 'rdma_counter_bind_qpn_alloc'
 drivers/infiniband/core/counters.c:494: warning: Function parameter or member 'counter_id' not described in 'rdma_counter_bind_qpn_alloc'
 drivers/infiniband/core/counters.c:541: warning: Function parameter or member 'dev' not described in 'rdma_counter_unbind_qpn'
 drivers/infiniband/core/counters.c:541: warning: Function parameter or member 'port' not described in 'rdma_counter_unbind_qpn'
 drivers/infiniband/core/counters.c:541: warning: Function parameter or member 'qp_num' not described in 'rdma_counter_unbind_qpn'
 drivers/infiniband/core/counters.c:541: warning: Function parameter or member 'counter_id' not described in 'rdma_counter_unbind_qpn'

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/core/counters.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 92745522250e4..e9ab193465fa2 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -24,7 +24,7 @@ static int __counter_set_mode(struct rdma_counter_mode *curr,
 	return 0;
 }
 
-/**
+/*
  * rdma_counter_set_auto_mode() - Turn on/off per-port auto mode
  *
  * When @on is true, the @mask must be set; When @on is false, it goes
@@ -227,7 +227,7 @@ static void counter_history_stat_update(struct rdma_counter *counter)
 		port_counter->hstats->value[i] += counter->stats->value[i];
 }
 
-/**
+/*
  * rdma_get_counter_auto_mode - Find the counter that @qp should be bound
  *     with in auto mode
  *
@@ -274,7 +274,7 @@ static void counter_release(struct kref *kref)
 	rdma_counter_free(counter);
 }
 
-/**
+/*
  * rdma_counter_bind_qp_auto - Check and bind the QP to a counter base on
  *   the auto-mode rule
  */
@@ -311,7 +311,7 @@ int rdma_counter_bind_qp_auto(struct ib_qp *qp, u8 port)
 	return 0;
 }
 
-/**
+/*
  * rdma_counter_unbind_qp - Unbind a qp from a counter
  * @force:
  *   true - Decrease the counter ref-count anyway (e.g., qp destroy)
@@ -380,7 +380,7 @@ static u64 get_running_counters_hwstat_sum(struct ib_device *dev,
 	return sum;
 }
 
-/**
+/*
  * rdma_counter_get_hwstat_value() - Get the sum value of all counters on a
  *   specific port, including the running ones and history data
  */
@@ -436,7 +436,7 @@ static struct rdma_counter *rdma_get_counter_by_id(struct ib_device *dev,
 	return counter;
 }
 
-/**
+/*
  * rdma_counter_bind_qpn() - Bind QP @qp_num to counter @counter_id
  */
 int rdma_counter_bind_qpn(struct ib_device *dev, u8 port,
@@ -485,7 +485,7 @@ int rdma_counter_bind_qpn(struct ib_device *dev, u8 port,
 	return ret;
 }
 
-/**
+/*
  * rdma_counter_bind_qpn_alloc() - Alloc a counter and bind QP @qp_num to it
  *   The id of new counter is returned in @counter_id
  */
@@ -533,7 +533,7 @@ int rdma_counter_bind_qpn_alloc(struct ib_device *dev, u8 port,
 	return ret;
 }
 
-/**
+/*
  * rdma_counter_unbind_qpn() - Unbind QP @qp_num from a counter
  */
 int rdma_counter_unbind_qpn(struct ib_device *dev, u8 port,
-- 
2.25.1

