Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 271E315299E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 12:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgBELFw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 06:05:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40192 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgBELFw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Feb 2020 06:05:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so2155353wru.7
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 03:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJBqmObf6zZRMdPPBMUV9CdmAX+PaRNyXqxY71pV8LM=;
        b=InlLNHQ4hSE6m5p6dhafsjkl0GQfuPks5JSZU0lcxZkD3Lh19JOP9aOKcBRx4tT5t4
         hBFjSQGEITXPin8031luHdYR+1YGLylCLngGJ3MHTZp7m2wFiziicJkgB53+Z5/lhQX8
         6QKOohDfcaCIuHslKFPL/H82gldjlfeyYehwbdceGREZreFx+YeaYXLVL9FxJfi5fc6c
         7A5s/pJAafhhyWDIBRbd8DfPHNmfmkO/bM0L4y9cmA0uPrpDWUTQKLxGqzXEHD5pqt2o
         JVnmgSNJOeaZFk7a0UzSdMuMQhphdjbAqGas99vOJq9OXWofxRuLQFPUiUmiP3FbxrV6
         EH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJBqmObf6zZRMdPPBMUV9CdmAX+PaRNyXqxY71pV8LM=;
        b=S6VaimxecDrMz6xUXcMbbWXHuh/vhHcOwVGb2YkpJKhfsOC1NGutnzoDuLS3nnqCBU
         ub4jTOIClyNvwf9OKWUhR3s+qLyT2h2ifyOh1FdqOYNjyuyMo25jfsX6B93BNfbWrSEK
         mzNrAlkVFHMGQNRHel5Az6aqxWKhe/NhIw/edyk+oNlRa+kjyoLNRQiIJ9L4xfuS0UST
         SD0aw43i23XE4e2ePT3/jsJmiVHurcPndzpbED38+orCPeyR6T4itONlXYZMv+Glb4kU
         6I6jfP6tEnVbhibbh/K8hD9B9yWRsXWVxkq/KSBjz+w13rBG6MyIA6aPEeN8RcUx1PVi
         wxvQ==
X-Gm-Message-State: APjAAAVIsEfRV3/uF1H9WJ69tJukBfIYRhAm+aTBd6BjeGgA7P2zvy7Y
        bNDIt+i9Q9B7O9pMx7swwBA8Mo01xxM=
X-Google-Smtp-Source: APXvYqwxMDNqnpxNwLNKQKVJwW4xzrRL2APu71v5RP67MD9pmAIC4L6BBOFuUR58cjlSnlOieY63rw==
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr29331400wrs.326.1580900750312;
        Wed, 05 Feb 2020 03:05:50 -0800 (PST)
Received: from kheib-workstation.redhat.com (bzq-79-178-7-104.red.bezeqint.net. [79.178.7.104])
        by smtp.gmail.com with ESMTPSA id o4sm34491707wrx.25.2020.02.05.03.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 03:05:49 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/hfi1: Fix memory leak in _dev_comp_vect_mappings_create
Date:   Wed,  5 Feb 2020 13:05:30 +0200
Message-Id: <20200205110530.12129-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure to free the allocated cpumask_var_t's to avoid the following
reported memory leak by kmemleak:

$ cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff8897f812d6a8 (size 8):
  comm "kworker/1:1", pid 347, jiffies 4294751400 (age 101.703s)
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<00000000bff49664>] alloc_cpumask_var_node+0x4c/0xb0
    [<0000000075d3ca81>] hfi1_comp_vectors_set_up+0x20f/0x800 [hfi1]
    [<0000000098d420df>] hfi1_init_dd+0x3311/0x4960 [hfi1]
    [<0000000071be7e52>] init_one+0x25e/0xf10 [hfi1]
    [<000000005483d4c2>] local_pci_probe+0xd4/0x180
    [<000000007c3cbc6e>] work_for_cpu_fn+0x51/0xa0
    [<000000001d626905>] process_one_work+0x8f0/0x17b0
    [<000000007e569e7e>] worker_thread+0x536/0xb50
    [<00000000fd39a4a5>] kthread+0x30c/0x3d0
    [<0000000056f2edb3>] ret_from_fork+0x3a/0x50

Fixes: 5d18ee67d4c1 ("IB/{hfi1, rdmavt, qib}: Implement CQ completion vector support")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/hfi1/affinity.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index c142b23bb401..1aeea5d65c01 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -479,6 +479,8 @@ static int _dev_comp_vect_mappings_create(struct hfi1_devdata *dd,
 			  rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), i, cpu);
 	}
 
+	free_cpumask_var(available_cpus);
+	free_cpumask_var(non_intr_cpus);
 	return 0;
 
 fail:
-- 
2.21.1

