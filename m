Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C95D6D1F32
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfJJEIk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:08:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37533 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfJJEIj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 00:08:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so3020955pfo.4;
        Wed, 09 Oct 2019 21:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:user-agent:date:from:to:cc:cc:subject:references
         :mime-version:content-disposition;
        bh=CtySa3C0r/r7Y1yNXVY40iaMbt05tEfFkrybRRsjy4g=;
        b=qrjn20zKX+93lls5Dvw1BbUlwtZ02SCP7mIP/0l9UlWQKVvMheDcJ8q6xT29oEnC1J
         Aa42Bcnz8onHnthxb6fHLEj7Q6YOMuojCfG+JYQdScSTCFO3dv4XvlRRqcdbiIXYcURu
         0tfNs0bjtKcdGxTqD+U68roYbilmSvUoAvVmStVsZwJnRx0wEc4rnYZFCnfzHbTaioZR
         z8MFjh1l+HRQylEFYCDcSfMzcGdQ4j2aVkwDgL52A/7JXFsTWw+qaDv0dET2i4jJCBMY
         PRoVL+vK4ecUtzFkvdLQEPz3g1Ej83fNmAN3vySE0/AI2PX72v3ihFLZhJQMy7zzbf9B
         8qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:user-agent:date:from:to:cc:cc:subject
         :references:mime-version:content-disposition;
        bh=CtySa3C0r/r7Y1yNXVY40iaMbt05tEfFkrybRRsjy4g=;
        b=Z3u9rptcJecLQl4d7Zh5bDOFA55vR1dPUIZo7dZ3gu7vf0yPjaRMoBHuhSCLHgIb30
         DkGToRqqEs/ej5eTnbdcEQa1DplZ422Il0gfV0voc7Yb9hwnJ9mm4MerEzNpubkxVg01
         +YWIcQM7A0GLCA5HvFMyWGRo35szz4GBA8plQjZ+tdabgYiQoi2LBA11F6BsRp99M9IV
         460Nj4CdDrAimbvo4TAsfOaehLHIcLGEjqp0x3TE2Dw46/KAQums74RkeZC0kjhXIhKG
         ITP7U9MFsMaUcuz185RqMAGn2j8TEfJO7Xn7TYQUd3Tcl+xJyTe1L97S2RLHgYQwxMDm
         pZdQ==
X-Gm-Message-State: APjAAAX0Rcjb2NHA3DmkJoJhKFNY26XEAQJL5KCxJu1BBKW/kJC/qlt1
        4YNHwHuRAFv6XHpA3AX5qslfin6y
X-Google-Smtp-Source: APXvYqwepCB+83pXbusSca9rB40m0k3cSixFwn8KmnRpg7Gv9laiLRV0WUdXq1aQUM7mKoThHKoVRA==
X-Received: by 2002:aa7:8691:: with SMTP id d17mr7831464pfo.218.1570680518638;
        Wed, 09 Oct 2019 21:08:38 -0700 (PDT)
Received: from localhost ([2601:1c0:6280:3f0::9ef4])
        by smtp.gmail.com with ESMTPSA id h14sm3624970pfo.15.2019.10.09.21.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:08:37 -0700 (PDT)
Message-Id: <20191010035239.623888112@gmail.com>
User-Agent: quilt/0.65
Date:   Wed, 09 Oct 2019 20:52:40 -0700
From:   rd.dunlab@gmail.com
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 01/12] infiniband: fix ulp/iser/iscsi_iser.[hc] kernel-doc notation
References: <20191010035239.532908118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=006-iband-iser-iscsi-iser-kerndoc.patch
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix struct name in kernel-doc notation to match the struct name below it.
Fix one typo (spello).
Fix formatting as expected for kernel-doc notation.
Fix parameter name to match the function's parameter name to eliminate a
kernel-doc warning.

../drivers/infiniband/ulp/iser/iscsi_iser.c:815: warning: Function parameter or member 'non_blocking' not described in 'iscsi_iser_ep_connect'

Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-doc@vger.kernel.org
---
 drivers/infiniband/ulp/iser/iscsi_iser.c |    2 +-
 drivers/infiniband/ulp/iser/iscsi_iser.h |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20191009.orig/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ linux-next-20191009/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -311,7 +311,7 @@ struct iser_comp {
 };
 
 /**
- * struct iser_device - Memory registration operations
+ * struct iser_reg_ops - Memory registration operations
  *     per-device registration schemes
  *
  * @alloc_reg_res:     Allocate registration resources
@@ -365,7 +365,7 @@ struct iser_device {
 };
 
 /**
- * struct iser_reg_resources - Fast registration recources
+ * struct iser_reg_resources - Fast registration resources
  *
  * @mr:         memory region
  * @fmr_pool:   pool of fmrs
@@ -398,7 +398,7 @@ struct iser_fr_desc {
 };
 
 /**
- * struct iser_fr_pool: connection fast registration pool
+ * struct iser_fr_pool - connection fast registration pool
  *
  * @list:                list of fastreg descriptors
  * @lock:                protects fmr/fastreg pool
@@ -521,7 +521,7 @@ struct iser_page_vec {
 };
 
 /**
- * struct iser_global: iSER global context
+ * struct iser_global - iSER global context
  *
  * @device_list_mutex:    protects device_list
  * @device_list:          iser devices global list
--- linux-next-20191009.orig/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ linux-next-20191009/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -786,7 +786,7 @@ static int iscsi_iser_get_ep_param(struc
  * iscsi_iser_ep_connect() - Initiate iSER connection establishment
  * @shost:          scsi_host
  * @dst_addr:       destination address
- * @non-blocking:   indicate if routine can block
+ * @non_blocking:   indicate if routine can block
  *
  * Allocate an iscsi endpoint, an iser_conn structure and bind them.
  * After that start RDMA connection establishment via rdma_cm. We


