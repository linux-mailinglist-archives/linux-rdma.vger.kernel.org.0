Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3891DD1F48
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJJEJr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:09:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44379 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfJJEJq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 00:09:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id u12so2771233pgb.11;
        Wed, 09 Oct 2019 21:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:user-agent:date:from:to:cc:cc:subject:references
         :mime-version:content-disposition;
        bh=AZ1YJbAshlu7K6Rn/NZRdHk7w5gMMC8tvShAhe/DdQg=;
        b=Yc2t6Q/vQiuD9OSlyvh/aZuum7DHHJwIM6yPmjBJdYBNjC0nuDzSjqQaRWUwR95bFd
         2aXQdAFroep2a/dqnRNySk5Wunh3+HQIJ3MALGZei1gzOEDPuhyNcE5MOSuoPNVXOB7/
         bVcLFNX2wFutZ3FmUMD5OiCmFD1mD15vsGw1tIgk1TcnwcC0pWdCP5tmBYUiGY9VZBzO
         YOO5t0YIyiLR/6X3mStppngiurKxrX++5cOV11fEK+w5VxtwvjBVZXDWFEK39gah0S2B
         eJRvwP8AFffHXRH5nK6UqnZZKQDepK+2AU0WiOYxky0qv8A9nMVNHW7LO/SCif9JMHNU
         bt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:user-agent:date:from:to:cc:cc:subject
         :references:mime-version:content-disposition;
        bh=AZ1YJbAshlu7K6Rn/NZRdHk7w5gMMC8tvShAhe/DdQg=;
        b=uiGrMiDKhYVZ8Fs0gr1SY4gqmEH6bINi96gwlU9UjSPnJxffyAz66dI/lpzNdmMYeC
         V3dxAdE3pR8x4vGaZdsszf3eRoHhvHI79dw8bKTpUoX4HS/feXRgJunKZm70HCSulpgi
         EXzSHeA9wZq2Kd5ZvO77MPnySeGfjFqHLDoGOrd8THChflcjkSWeIOXgvyrhQHVijr6S
         hotE3vkN/Q6qcMRPe3iRqYiElf3bjCt7V+wfCF0yXukECeOB7kxkgddyH0GrjPnLTR5J
         kpSsGY8JlipLUe6mf8hsZFmlzj9N8FOxFcMB+7W7djTlBCs8Fu9276HDtwvm1O3PsnXj
         KORA==
X-Gm-Message-State: APjAAAXhW9n3hwi53ye19uuqhWNQyr7kqwajBzYz7Oh7yyu8AAUkhYIS
        2UUvuhLuZ4ixKVdmHU2EfDcSXDXP
X-Google-Smtp-Source: APXvYqzfZz9Z2lHQEh3822KFnrgLUGFs2jJBHFyzHy8FTsYMQILG6Sou0WtDsu1aCKGt2K6qPzoyaw==
X-Received: by 2002:a63:5f52:: with SMTP id t79mr8511425pgb.311.1570680583058;
        Wed, 09 Oct 2019 21:09:43 -0700 (PDT)
Received: from localhost ([2601:1c0:6280:3f0::9ef4])
        by smtp.gmail.com with ESMTPSA id p1sm5836192pfb.112.2019.10.09.21.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:09:42 -0700 (PDT)
Message-Id: <20191010035240.310347906@gmail.com>
User-Agent: quilt/0.65
Date:   Wed, 09 Oct 2019 20:52:51 -0700
From:   rd.dunlab@gmail.com
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 12/12] infiniband: add a Documentation driver-api chapter for Infiniband
References: <20191010035239.532908118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=017-docum-iband-chapter.patch
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a driver-api chapter for InfiniBand interfaces.

Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/driver-api/index.rst      |    1 
 Documentation/driver-api/infiniband.rst |  127 ++++++++++++++++++++++
 2 files changed, 128 insertions(+)

--- linux-next-20191009.orig/Documentation/driver-api/index.rst
+++ linux-next-20191009/Documentation/driver-api/index.rst
@@ -26,6 +26,7 @@ available subsections can be seen below.
    device_link
    component
    message-based
+   infiniband
    sound
    frame-buffer
    regulator
--- /dev/null
+++ linux-next-20191009/Documentation/driver-api/infiniband.rst
@@ -0,0 +1,127 @@
+===========================================
+InfiniBand and Remote DMA (RDMA) Interfaces
+===========================================
+
+Introduction and Overview
+=========================
+
+TBD
+
+InfiniBand core interfaces
+==========================
+
+.. kernel-doc:: drivers/infiniband/core/iwpm_util.h
+    :internal:
+
+.. kernel-doc:: drivers/infiniband/core/cq.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/core/cm.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/core/rw.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/core/device.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/core/verbs.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/core/packer.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/core/sa_query.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/core/ud_header.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/core/fmr_pool.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/core/umem.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/core/umem_odp.c
+    :export:
+
+RDMA Verbs transport library
+============================
+
+.. kernel-doc:: drivers/infiniband/sw/rdmavt/mr.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/sw/rdmavt/rc.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/sw/rdmavt/ah.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/sw/rdmavt/vt.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/sw/rdmavt/cq.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/sw/rdmavt/qp.c
+    :export:
+
+.. kernel-doc:: drivers/infiniband/sw/rdmavt/mcast.c
+    :export:
+
+Upper Layer Protocols
+=====================
+
+iSCSI Extensions for RDMA (iSER)
+--------------------------------
+
+.. kernel-doc:: drivers/infiniband/ulp/iser/iscsi_iser.h
+   :internal:
+
+.. kernel-doc:: drivers/infiniband/ulp/iser/iscsi_iser.c
+   :functions: iscsi_iser_pdu_alloc iser_initialize_task_headers \
+	iscsi_iser_task_init iscsi_iser_mtask_xmit iscsi_iser_task_xmit \
+	iscsi_iser_cleanup_task iscsi_iser_check_protection \
+	iscsi_iser_conn_create iscsi_iser_conn_bind \
+	iscsi_iser_conn_start iscsi_iser_conn_stop \
+	iscsi_iser_session_destroy iscsi_iser_session_create \
+	iscsi_iser_set_param iscsi_iser_ep_connect iscsi_iser_ep_poll \
+	iscsi_iser_ep_disconnect
+
+.. kernel-doc:: drivers/infiniband/ulp/iser/iser_initiator.c
+   :internal:
+
+.. kernel-doc:: drivers/infiniband/ulp/iser/iser_verbs.c
+   :internal:
+
+Omni-Path (OPA) Virtual NIC support
+-----------------------------------
+
+.. kernel-doc:: drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
+   :internal:
+
+.. kernel-doc:: drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
+   :internal:
+
+.. kernel-doc:: drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
+   :internal:
+
+.. kernel-doc:: drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
+   :internal:
+
+InfiniBand SCSI RDMA protocol target support
+--------------------------------------------
+
+.. kernel-doc:: drivers/infiniband/ulp/srpt/ib_srpt.h
+   :internal:
+
+.. kernel-doc:: drivers/infiniband/ulp/srpt/ib_srpt.c
+   :internal:
+
+iSCSI Extensions for RDMA (iSER) target support
+-----------------------------------------------
+
+.. kernel-doc:: drivers/infiniband/ulp/isert/ib_isert.c
+   :internal:
+


