Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C50BD1F40
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfJJEJT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:09:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37584 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfJJEJT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 00:09:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so3021875pfo.4;
        Wed, 09 Oct 2019 21:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:user-agent:date:from:to:cc:cc:subject:references
         :mime-version:content-disposition;
        bh=gQ3+EkcDDalqL/1rgyaQ7ifLh4aHcukdchGKbaGgu18=;
        b=UTx5GZXPOY7TXWD+FuXZew7Ojxgt89eoBLKKqXvh4TFSLG5NGYUZpcSOiVevF9IbxD
         naCkJuoypbun215GC8joBc+oIvPa+7mTA++MP0hlXcKuQho/O2/BZeoKSk4eoNLkGkjd
         ilhYe3Ne3DSn+hXNkY6RiLhNd0d9Z26E+o6eQiOvxl1rhri11QU9JveQ6Wi9ACshkU3A
         5EWJze7xaVUxAdAvEF1paJVkRLXEpA7PKWiIyGkSk7JdINqAQkFtJFBczudjO7Uz6fYa
         HZpmcf3zhInKTcLO3kmfcNI2oyGDMzOlB4OYGS7oL8tHOYh+wG6ABxCukLZnggag+Uez
         fCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:user-agent:date:from:to:cc:cc:subject
         :references:mime-version:content-disposition;
        bh=gQ3+EkcDDalqL/1rgyaQ7ifLh4aHcukdchGKbaGgu18=;
        b=Qb6pGQpzMy5NZ3mn/75GZHtQ+48HFTUplAYNglU/IEOfGHLCcGhYPl/dnZpLQgc8pK
         b7Wif1roI1mhTwO8LQvMGrMDkxsHQSm2COTsNwTXBBXAwdcE++sIFgQKfcmavWh9kJa0
         +P+YfhUuoUv/qdzN+eHxqa3ofuPNYdAEG+nBO6NiFz9UcmI78A1b7Me52Lsbg5a5QlZd
         pxAbfPob6WbRJDRhTzPD+eN3QSmKkf9M7HJj7OzqnedwMDbp9OsHkAkDhIG+yrh5yuY2
         8kVbr3eZaDy79k4/sl1EqCZP3KMhQ3l7ZlYj7+v0CM7JdCPGloG38ySoZq1nlLIUEQYE
         8KXg==
X-Gm-Message-State: APjAAAVMV5O0VGRWRX3ZmUKFDyODClPv32JOgdwV8dG9+5U88ssT90fT
        nBrWSpxVi/SMtWbv12OuRjg8T+mg
X-Google-Smtp-Source: APXvYqy+lgYsW3nsQbZ0sxj2GAgx0xuTMOgxQIE9ps+Liffr1F8DQNiO7bxuag0dwHD8DTIrFiZowQ==
X-Received: by 2002:a17:90a:24ae:: with SMTP id i43mr8611749pje.117.1570680558449;
        Wed, 09 Oct 2019 21:09:18 -0700 (PDT)
Received: from localhost ([2601:1c0:6280:3f0::9ef4])
        by smtp.gmail.com with ESMTPSA id w134sm3613921pfd.4.2019.10.09.21.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:09:17 -0700 (PDT)
Message-Id: <20191010035240.070520193@gmail.com>
User-Agent: quilt/0.65
Date:   Wed, 09 Oct 2019 20:52:47 -0700
From:   rd.dunlab@gmail.com
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 08/12] infiniband: fix ulp/iser/iser_verbs.c kernel-doc notation
References: <20191010035239.532908118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=013-iband-iser-verbs.patch
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Various kernel-doc fixes:

- fix typos
- don't use /** for internal structs or functions
- fix Return: kernel-doc formatting
- add kernel-doc notation for missing function parameters

../drivers/infiniband/ulp/iser/iser_verbs.c:159: warning: Function parameter or member 'ib_conn' not described in 'iser_alloc_fmr_pool'
../drivers/infiniband/ulp/iser/iser_verbs.c:159: warning: Function parameter or member 'cmds_max' not described in 'iser_alloc_fmr_pool'
../drivers/infiniband/ulp/iser/iser_verbs.c:159: warning: Function parameter or member 'size' not described in 'iser_alloc_fmr_pool'
../drivers/infiniband/ulp/iser/iser_verbs.c:221: warning: Function parameter or member 'ib_conn' not described in 'iser_free_fmr_pool'
../drivers/infiniband/ulp/iser/iser_verbs.c:304: warning: Function parameter or member 'ib_conn' not described in 'iser_alloc_fastreg_pool'
../drivers/infiniband/ulp/iser/iser_verbs.c:304: warning: Function parameter or member 'cmds_max' not described in 'iser_alloc_fastreg_pool'
../drivers/infiniband/ulp/iser/iser_verbs.c:304: warning: Function parameter or member 'size' not described in 'iser_alloc_fastreg_pool'
../drivers/infiniband/ulp/iser/iser_verbs.c:338: warning: Function parameter or member 'ib_conn' not described in 'iser_free_fastreg_pool'
../drivers/infiniband/ulp/iser/iser_verbs.c:568: warning: Function parameter or member 'iser_conn' not described in 'iser_conn_release'
../drivers/infiniband/ulp/iser/iser_verbs.c:603: warning: Function parameter or member 'iser_conn' not described in 'iser_conn_terminate'
../drivers/infiniband/ulp/iser/iser_verbs.c:1040: warning: Function parameter or member 'signal' not described in 'iser_post_send'
../drivers/infiniband/ulp/iser/iser_verbs.c:1040: warning: Function parameter or member 'ib_conn' not described in 'iser_post_send'
../drivers/infiniband/ulp/iser/iser_verbs.c:1040: warning: Function parameter or member 'tx_desc' not described in 'iser_post_send'

Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-doc@vger.kernel.org
---
 drivers/infiniband/ulp/iser/iser_verbs.c |   60 +++++++++++++--------
 1 file changed, 38 insertions(+), 22 deletions(-)

--- linux-next-20191009.orig/drivers/infiniband/ulp/iser/iser_verbs.c
+++ linux-next-20191009/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -58,12 +58,12 @@ static void iser_event_handler(struct ib
 		dev_name(&event->device->dev), event->element.port_num);
 }
 
-/**
+/*
  * iser_create_device_ib_res - creates Protection Domain (PD), Completion
  * Queue (CQ), DMA Memory Region (DMA MR) with the device associated with
- * the adapator.
+ * the adaptor.
  *
- * returns 0 on success, -1 on failure
+ * Return: 0 on success, -1 on failure
  */
 static int iser_create_device_ib_res(struct iser_device *device)
 {
@@ -124,9 +124,9 @@ comps_err:
 	return -1;
 }
 
-/**
+/*
  * iser_free_device_ib_res - destroy/dealloc/dereg the DMA MR,
- * CQ and PD created with the device associated with the adapator.
+ * CQ and PD created with the device associated with the adaptor.
  */
 static void iser_free_device_ib_res(struct iser_device *device)
 {
@@ -149,8 +149,11 @@ static void iser_free_device_ib_res(stru
 
 /**
  * iser_alloc_fmr_pool - Creates FMR pool and page_vector
+ * @ib_conn: connection RDMA resources
+ * @cmds_max: max number of SCSI commands for this connection
+ * @size: max number of pages per map request
  *
- * returns 0 on success, or errno code on failure
+ * Return: 0 on success, or errno code on failure
  */
 int iser_alloc_fmr_pool(struct ib_conn *ib_conn,
 			unsigned cmds_max,
@@ -215,6 +218,7 @@ err_frpl:
 
 /**
  * iser_free_fmr_pool - releases the FMR pool and page vec
+ * @ib_conn: connection RDMA resources
  */
 void iser_free_fmr_pool(struct ib_conn *ib_conn)
 {
@@ -295,7 +299,11 @@ static void iser_destroy_fastreg_desc(st
 /**
  * iser_alloc_fastreg_pool - Creates pool of fast_reg descriptors
  * for fast registration work requests.
- * returns 0 on success, or errno code on failure
+ * @ib_conn: connection RDMA resources
+ * @cmds_max: max number of SCSI commands for this connection
+ * @size: max number of pages per map request
+ *
+ * Return: 0 on success, or errno code on failure
  */
 int iser_alloc_fastreg_pool(struct ib_conn *ib_conn,
 			    unsigned cmds_max,
@@ -332,6 +340,7 @@ err:
 
 /**
  * iser_free_fastreg_pool - releases the pool of fast_reg descriptors
+ * @ib_conn: connection RDMA resources
  */
 void iser_free_fastreg_pool(struct ib_conn *ib_conn)
 {
@@ -355,10 +364,10 @@ void iser_free_fastreg_pool(struct ib_co
 			  fr_pool->size - i);
 }
 
-/**
+/*
  * iser_create_ib_conn_res - Queue-Pair (QP)
  *
- * returns 0 on success, -1 on failure
+ * Return: 0 on success, -1 on failure
  */
 static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
 {
@@ -436,7 +445,7 @@ out_err:
 	return ret;
 }
 
-/**
+/*
  * based on the resolved device node GUID see if there already allocated
  * device for this device. If there's no such, create one.
  */
@@ -487,9 +496,9 @@ static void iser_device_try_release(stru
 	mutex_unlock(&ig.device_list_mutex);
 }
 
-/**
+/*
  * Called with state mutex held
- **/
+ */
 static int iser_conn_state_comp_exch(struct iser_conn *iser_conn,
 				     enum iser_conn_state comp,
 				     enum iser_conn_state exch)
@@ -561,7 +570,8 @@ static void iser_free_ib_conn_res(struct
 }
 
 /**
- * Frees all conn objects and deallocs conn descriptor
+ * iser_conn_release - Frees all conn objects and deallocs conn descriptor
+ * @iser_conn: iSER connection context
  */
 void iser_conn_release(struct iser_conn *iser_conn)
 {
@@ -595,7 +605,10 @@ void iser_conn_release(struct iser_conn
 }
 
 /**
- * triggers start of the disconnect procedures and wait for them to be done
+ * iser_conn_terminate - triggers start of the disconnect procedures and
+ * waits for them to be done
+ * @iser_conn: iSER connection context
+ *
  * Called with state mutex held
  */
 int iser_conn_terminate(struct iser_conn *iser_conn)
@@ -632,9 +645,9 @@ int iser_conn_terminate(struct iser_conn
 	return 1;
 }
 
-/**
+/*
  * Called with state mutex held
- **/
+ */
 static void iser_connect_error(struct rdma_cm_id *cma_id)
 {
 	struct iser_conn *iser_conn;
@@ -684,9 +697,9 @@ iser_calc_scsi_params(struct iser_conn *
 		iser_conn->scsi_sg_tablesize + reserved_mr_pages;
 }
 
-/**
+/*
  * Called with state mutex held
- **/
+ */
 static void iser_addr_handler(struct rdma_cm_id *cma_id)
 {
 	struct iser_device *device;
@@ -732,9 +745,9 @@ static void iser_addr_handler(struct rdm
 	}
 }
 
-/**
+/*
  * Called with state mutex held
- **/
+ */
 static void iser_route_handler(struct rdma_cm_id *cma_id)
 {
 	struct rdma_conn_param conn_param;
@@ -1030,9 +1043,12 @@ int iser_post_recvm(struct iser_conn *is
 
 
 /**
- * iser_start_send - Initiate a Send DTO operation
+ * iser_post_send - Initiate a Send DTO operation
+ * @ib_conn: connection RDMA resources
+ * @tx_desc: iSER TX descriptor
+ * @signal: true to send work request as SIGNALED
  *
- * returns 0 on success, -1 on failure
+ * Return: 0 on success, -1 on failure
  */
 int iser_post_send(struct ib_conn *ib_conn, struct iser_tx_desc *tx_desc,
 		   bool signal)


