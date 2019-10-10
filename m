Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15169D1F46
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfJJEJj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:09:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42966 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJJEJj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 00:09:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so2784244pgp.9;
        Wed, 09 Oct 2019 21:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:user-agent:date:from:to:cc:cc:subject:references
         :mime-version:content-disposition;
        bh=9XR5r6M6ZpEwAsYdDHjQ5vf0SeychjUyebV9Shb4Nvo=;
        b=Mg/kbGMnWguEkYNALQFr/LlFXWbLzVMr++8lIocJ/7XVyZbO9U4Qojwy3SVw7hxRUQ
         juX4C2VmGA+fJIhciKtyLE1fAYNyNUYAO1PCSuB5e3gsW51Al1YVBZMpwiFYdnigHBbm
         ZxulgmFhkVblnLKKYjnf0Qn9s9WWwgkn/cWO3gAAaRnr9tMXFFNxc3Mtu3xUWqcEY8tQ
         dngxJkanFWWRyI1s+PlcWdhEdSaXJPFjYlD4pLkw9zkWpKs8peNpdeP+X1VxeyFnIZe8
         Dte8ZrrlBNfmLX7KVOklXGwMKeb/6o5IIacYIHv3KV0yOki0Tb5fjhcYdcQEHpsVEcAH
         swGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:user-agent:date:from:to:cc:cc:subject
         :references:mime-version:content-disposition;
        bh=9XR5r6M6ZpEwAsYdDHjQ5vf0SeychjUyebV9Shb4Nvo=;
        b=YA5oi/Z6aOFKi1Fhew9xV2PMPrf0TMdQLLCQj+4V55XWGE8ZONtA3tX9Xz+Sx0u33y
         7L28R8px88eFFMFRo2RvM2DAmpiZ6Nn+MY6NZ20aoRGwoskyJE7QLAYVuS8j7I9dmFxI
         KZswCEgYf+EulIliuY8NHYFaCSbme8jZ8fi3rEEOfr2mzwFN6Eqva47ZZM/PYGogC+/y
         tb5Oww3vQpPih4lCoX0W0+rcZF/r6B7bWFztxfTkfcPdHwZZbiMRPw6F7qW4sw223mZ2
         dxIOW8Djr+1yFxuFCCMkQHWG0tRNG9QAliIjwrPXTt7Rv8su31+AnbvRd5NC8TvuY/nq
         JcRg==
X-Gm-Message-State: APjAAAXSInMsujBWK4KkdqBwljki3vmIJMs9IcNtZEI8nM0TLOxB6chI
        kEAIwSFahw0prc4uoSTNffgl1fXz
X-Google-Smtp-Source: APXvYqxxvzwLlfBGudEee1pvcxjZz9MNZl7aCUcvySorcaZI/D4wJQrXPLy0Xya8n3sa63vuvTmnVw==
X-Received: by 2002:a17:90a:1b28:: with SMTP id q37mr8665154pjq.91.1570680577887;
        Wed, 09 Oct 2019 21:09:37 -0700 (PDT)
Received: from localhost ([2601:1c0:6280:3f0::9ef4])
        by smtp.gmail.com with ESMTPSA id z13sm3842668pfg.172.2019.10.09.21.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:09:36 -0700 (PDT)
Message-Id: <20191010035240.251184229@gmail.com>
User-Agent: quilt/0.65
Date:   Wed, 09 Oct 2019 20:52:50 -0700
From:   rd.dunlab@gmail.com
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 11/12] infiniband: fix sw/rdmavt/ kernel-doc notation
References: <20191010035239.532908118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=016-iband-rdmavt-fixes.patch
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add kernel-doc for missing function parameters.
Remove excess kernel-doc descriptions.
Fix expected kernel-doc formatting (use ':' instead of '-' after @funcarg).

../drivers/infiniband/sw/rdmavt/ah.c:138: warning: Excess function parameter 'udata' description in 'rvt_destroy_ah'
../drivers/infiniband/sw/rdmavt/vt.c:698: warning: Function parameter or member 'pkey_table' not described in 'rvt_init_port'
../drivers/infiniband/sw/rdmavt/cq.c:561: warning: Excess function parameter 'rdi' description in 'rvt_driver_cq_init'
../drivers/infiniband/sw/rdmavt/cq.c:575: warning: Excess function parameter 'rdi' description in 'rvt_cq_exit'
../drivers/infiniband/sw/rdmavt/qp.c:2573: warning: Function parameter or member 'qp' not described in 'rvt_add_rnr_timer'
../drivers/infiniband/sw/rdmavt/qp.c:2573: warning: Function parameter or member 'aeth' not described in 'rvt_add_rnr_timer'
../drivers/infiniband/sw/rdmavt/qp.c:2591: warning: Function parameter or member 'qp' not described in 'rvt_stop_rc_timers'
../drivers/infiniband/sw/rdmavt/qp.c:2624: warning: Function parameter or member 'qp' not described in 'rvt_del_timers_sync'
../drivers/infiniband/sw/rdmavt/qp.c:2697: warning: Function parameter or member 'cb' not described in 'rvt_qp_iter_init'
../drivers/infiniband/sw/rdmavt/qp.c:2728: warning: Function parameter or member 'iter' not described in 'rvt_qp_iter_next'
../drivers/infiniband/sw/rdmavt/qp.c:2796: warning: Function parameter or member 'rdi' not described in 'rvt_qp_iter'
../drivers/infiniband/sw/rdmavt/qp.c:2796: warning: Function parameter or member 'v' not described in 'rvt_qp_iter'
../drivers/infiniband/sw/rdmavt/qp.c:2796: warning: Function parameter or member 'cb' not described in 'rvt_qp_iter'

Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-doc@vger.kernel.org
---
 drivers/infiniband/sw/rdmavt/ah.c |    1 
 drivers/infiniband/sw/rdmavt/cq.c |    2 -
 drivers/infiniband/sw/rdmavt/qp.c |   30 ++++++++++++++--------------
 drivers/infiniband/sw/rdmavt/vt.c |    3 +-
 4 files changed, 17 insertions(+), 19 deletions(-)

--- linux-next-20191009.orig/drivers/infiniband/sw/rdmavt/ah.c
+++ linux-next-20191009/drivers/infiniband/sw/rdmavt/ah.c
@@ -129,7 +129,6 @@ int rvt_create_ah(struct ib_ah *ibah, st
  * rvt_destory_ah - Destory an address handle
  * @ibah: address handle
  * @destroy_flags: destroy address handle flags (see enum rdma_destroy_ah_flags)
- * @udata: user data or NULL for kernel object
  *
  * Return: 0 on success
  */
--- linux-next-20191009.orig/drivers/infiniband/sw/rdmavt/vt.c
+++ linux-next-20191009/drivers/infiniband/sw/rdmavt/vt.c
@@ -683,9 +683,10 @@ EXPORT_SYMBOL(rvt_unregister_device);
 
 /**
  * rvt_init_port - init internal data for driver port
- * @rdi: rvt dev strut
+ * @rdi: rvt_dev_info struct
  * @port: rvt port
  * @port_index: 0 based index of ports, different from IB core port num
+ * @pkey_table: pkey_table for @port
  *
  * Keep track of a list of ports. No need to have a detach port.
  * They persist until the driver goes away.
--- linux-next-20191009.orig/drivers/infiniband/sw/rdmavt/cq.c
+++ linux-next-20191009/drivers/infiniband/sw/rdmavt/cq.c
@@ -552,7 +552,6 @@ int rvt_poll_cq(struct ib_cq *ibcq, int
 
 /**
  * rvt_driver_cq_init - Init cq resources on behalf of driver
- * @rdi: rvt dev structure
  *
  * Return: 0 on success
  */
@@ -568,7 +567,6 @@ int rvt_driver_cq_init(void)
 
 /**
  * rvt_cq_exit - tear down cq reources
- * @rdi: rvt dev structure
  */
 void rvt_cq_exit(void)
 {
--- linux-next-20191009.orig/drivers/infiniband/sw/rdmavt/qp.c
+++ linux-next-20191009/drivers/infiniband/sw/rdmavt/qp.c
@@ -2563,10 +2563,9 @@ void rvt_add_retry_timer_ext(struct rvt_
 EXPORT_SYMBOL(rvt_add_retry_timer_ext);
 
 /**
- * rvt_add_rnr_timer - add/start an rnr timer
- * @qp - the QP
- * @aeth - aeth of RNR timeout, simulated aeth for loopback
- * add an rnr timer on the QP
+ * rvt_add_rnr_timer - add/start an rnr timer on the QP
+ * @qp: the QP
+ * @aeth: aeth of RNR timeout, simulated aeth for loopback
  */
 void rvt_add_rnr_timer(struct rvt_qp *qp, u32 aeth)
 {
@@ -2583,7 +2582,7 @@ EXPORT_SYMBOL(rvt_add_rnr_timer);
 
 /**
  * rvt_stop_rc_timers - stop all timers
- * @qp - the QP
+ * @qp: the QP
  * stop any pending timers
  */
 void rvt_stop_rc_timers(struct rvt_qp *qp)
@@ -2617,7 +2616,7 @@ static void rvt_stop_rnr_timer(struct rv
 
 /**
  * rvt_del_timers_sync - wait for any timeout routines to exit
- * @qp - the QP
+ * @qp: the QP
  */
 void rvt_del_timers_sync(struct rvt_qp *qp)
 {
@@ -2626,7 +2625,7 @@ void rvt_del_timers_sync(struct rvt_qp *
 }
 EXPORT_SYMBOL(rvt_del_timers_sync);
 
-/**
+/*
  * This is called from s_timer for missing responses.
  */
 static void rvt_rc_timeout(struct timer_list *t)
@@ -2676,12 +2675,13 @@ EXPORT_SYMBOL(rvt_rc_rnr_retry);
  * rvt_qp_iter_init - initial for QP iteration
  * @rdi: rvt devinfo
  * @v: u64 value
+ * @cb: user-defined callback
  *
  * This returns an iterator suitable for iterating QPs
  * in the system.
  *
- * The @cb is a user defined callback and @v is a 64
- * bit value passed to and relevant for processing in the
+ * The @cb is a user-defined callback and @v is a 64-bit
+ * value passed to and relevant for processing in the
  * @cb.  An example use case would be to alter QP processing
  * based on criteria not part of the rvt_qp.
  *
@@ -2712,7 +2712,7 @@ EXPORT_SYMBOL(rvt_qp_iter_init);
 
 /**
  * rvt_qp_iter_next - return the next QP in iter
- * @iter - the iterator
+ * @iter: the iterator
  *
  * Fine grained QP iterator suitable for use
  * with debugfs seq_file mechanisms.
@@ -2775,14 +2775,14 @@ EXPORT_SYMBOL(rvt_qp_iter_next);
 
 /**
  * rvt_qp_iter - iterate all QPs
- * @rdi - rvt devinfo
- * @v - a 64 bit value
- * @cb - a callback
+ * @rdi: rvt devinfo
+ * @v: a 64-bit value
+ * @cb: a callback
  *
  * This provides a way for iterating all QPs.
  *
- * The @cb is a user defined callback and @v is a 64
- * bit value passed to and relevant for processing in the
+ * The @cb is a user-defined callback and @v is a 64-bit
+ * value passed to and relevant for processing in the
  * cb.  An example use case would be to alter QP processing
  * based on criteria not part of the rvt_qp.
  *


