Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7D37854DA
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Aug 2023 12:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjHWKFk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Aug 2023 06:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbjHWJiG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Aug 2023 05:38:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B545592
        for <linux-rdma@vger.kernel.org>; Wed, 23 Aug 2023 02:29:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9a18a4136a9so464510666b.2
        for <linux-rdma@vger.kernel.org>; Wed, 23 Aug 2023 02:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692782998; x=1693387798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b0TqwkN/hcaqdFUQSznWkdfLoYgj/U2wC90bZeCYooY=;
        b=HYamoQY56UT2UrIbXl5Ik9uVEW5tNQAVzanB9Ro5n1j4vPZ92SGmtPqttDYhUFg0MQ
         rDBp8SkxEZQ8xOWvo8IixPUOpNnx2iiFKLsJGRDqmdpaC7P95NSUxfcOZLgk4PlE89L+
         /rrnYkJt/HVitOKn/zdH5dWVKP9Z0b+InNkqw5vRb7gF7moopZvRo3lfVi+Ywv7wlzkx
         mM3chrXiJgue63QMFlsYWmVMzYwLYWKZph4pK4V0fZ+rzovzd8kYo5zUDtvn5vRoKjVh
         fSwCji1FXNOTrQvrw0ZpXph0J9+4+Yu5VhbQF9Szea/9Ab0GwZpl6GXxRbl+qeDYeR6i
         He6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692782998; x=1693387798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0TqwkN/hcaqdFUQSznWkdfLoYgj/U2wC90bZeCYooY=;
        b=MTLr0ehbLJkFcC7nV/rsDRt8yz3GuTYnmc5cKQcAZOIjieTr9lTojU5TAX6o7Zkf1r
         4x5Tju1xsoCnZj4inCQqmNQCufdNWqpwAcPP4nAC+72MY11AjG7oT6B32Jd46dd6TUpf
         gIqPnjTljC1ZAU3IRLOTJe6/78LCwx2TKtd9aLBzL1Vw7DEh3uXIXu6kwNYJymnva0sP
         B/gePXhuM0Bt9rejaE9lcVEp0jWauwijvut6163Q9F0Fi9pDRU95WFltIiNoXsmS0B4I
         t6JUTJodmN1NCWnloo3P6OftUQV9mx025PYTOKkINANNvTRkpQDOA7tbChRaz9IsHqW/
         7tvA==
X-Gm-Message-State: AOJu0YxhmSdOuCA9ZIyKaSids8WVK7JNCsb2f3bHL9T/Jq9UQTt4npyp
        w/rjL3qSxbYpXbNXuNqAcDHGhQ==
X-Google-Smtp-Source: AGHT+IFbmjVq9DcHOhZKuutJC370BPE/o1tKJGZXFNjGq8jHngXuhBJVOBfAJrMn1ZZpKkP/Utm9Mw==
X-Received: by 2002:a17:906:31d2:b0:99c:6c29:7871 with SMTP id f18-20020a17090631d200b0099c6c297871mr9871838ejf.65.1692782997413;
        Wed, 23 Aug 2023 02:29:57 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id gq6-20020a170906e24600b0099c53c44083sm9520766ejb.79.2023.08.23.02.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 02:29:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] IB: use capital "OR" for multiple licenses in SPDX
Date:   Wed, 23 Aug 2023 11:29:12 +0200
Message-Id: <20230823092912.122674-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Documentation/process/license-rules.rst and checkpatch expect the SPDX
identifier syntax for multiple licenses to use capital "OR".  Correct it
to keep consistent format and avoid copy-paste issues.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_tlv.h   | 2 +-
 drivers/infiniband/hw/hfi1/affinity.c       | 2 +-
 drivers/infiniband/hw/hfi1/affinity.h       | 2 +-
 drivers/infiniband/hw/hfi1/aspm.h           | 2 +-
 drivers/infiniband/hw/hfi1/chip.c           | 2 +-
 drivers/infiniband/hw/hfi1/chip.h           | 2 +-
 drivers/infiniband/hw/hfi1/chip_registers.h | 2 +-
 drivers/infiniband/hw/hfi1/common.h         | 2 +-
 drivers/infiniband/hw/hfi1/debugfs.c        | 2 +-
 drivers/infiniband/hw/hfi1/debugfs.h        | 2 +-
 drivers/infiniband/hw/hfi1/device.c         | 2 +-
 drivers/infiniband/hw/hfi1/device.h         | 2 +-
 drivers/infiniband/hw/hfi1/driver.c         | 2 +-
 drivers/infiniband/hw/hfi1/efivar.c         | 2 +-
 drivers/infiniband/hw/hfi1/efivar.h         | 2 +-
 drivers/infiniband/hw/hfi1/eprom.c          | 2 +-
 drivers/infiniband/hw/hfi1/eprom.h          | 2 +-
 drivers/infiniband/hw/hfi1/exp_rcv.c        | 2 +-
 drivers/infiniband/hw/hfi1/exp_rcv.h        | 2 +-
 drivers/infiniband/hw/hfi1/fault.c          | 2 +-
 drivers/infiniband/hw/hfi1/fault.h          | 2 +-
 drivers/infiniband/hw/hfi1/file_ops.c       | 2 +-
 drivers/infiniband/hw/hfi1/firmware.c       | 2 +-
 drivers/infiniband/hw/hfi1/hfi.h            | 2 +-
 drivers/infiniband/hw/hfi1/init.c           | 2 +-
 drivers/infiniband/hw/hfi1/intr.c           | 2 +-
 drivers/infiniband/hw/hfi1/iowait.h         | 2 +-
 drivers/infiniband/hw/hfi1/mad.c            | 2 +-
 drivers/infiniband/hw/hfi1/mad.h            | 2 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c         | 2 +-
 drivers/infiniband/hw/hfi1/mmu_rb.h         | 2 +-
 drivers/infiniband/hw/hfi1/opa_compat.h     | 2 +-
 drivers/infiniband/hw/hfi1/pcie.c           | 2 +-
 drivers/infiniband/hw/hfi1/pio.c            | 2 +-
 drivers/infiniband/hw/hfi1/pio.h            | 2 +-
 drivers/infiniband/hw/hfi1/pio_copy.c       | 2 +-
 drivers/infiniband/hw/hfi1/platform.c       | 2 +-
 drivers/infiniband/hw/hfi1/platform.h       | 2 +-
 drivers/infiniband/hw/hfi1/qp.c             | 2 +-
 drivers/infiniband/hw/hfi1/qp.h             | 2 +-
 drivers/infiniband/hw/hfi1/qsfp.c           | 2 +-
 drivers/infiniband/hw/hfi1/qsfp.h           | 2 +-
 drivers/infiniband/hw/hfi1/rc.c             | 2 +-
 drivers/infiniband/hw/hfi1/ruc.c            | 2 +-
 drivers/infiniband/hw/hfi1/sdma.c           | 2 +-
 drivers/infiniband/hw/hfi1/sdma.h           | 2 +-
 drivers/infiniband/hw/hfi1/sdma_txreq.h     | 2 +-
 drivers/infiniband/hw/hfi1/sysfs.c          | 2 +-
 drivers/infiniband/hw/hfi1/trace.c          | 2 +-
 drivers/infiniband/hw/hfi1/trace.h          | 2 +-
 drivers/infiniband/hw/hfi1/trace_ctxts.h    | 2 +-
 drivers/infiniband/hw/hfi1/trace_dbg.h      | 2 +-
 drivers/infiniband/hw/hfi1/trace_ibhdrs.h   | 2 +-
 drivers/infiniband/hw/hfi1/trace_misc.h     | 2 +-
 drivers/infiniband/hw/hfi1/trace_mmu.h      | 2 +-
 drivers/infiniband/hw/hfi1/trace_rc.h       | 2 +-
 drivers/infiniband/hw/hfi1/trace_rx.h       | 2 +-
 drivers/infiniband/hw/hfi1/trace_tx.h       | 2 +-
 drivers/infiniband/hw/hfi1/uc.c             | 2 +-
 drivers/infiniband/hw/hfi1/ud.c             | 2 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.c   | 2 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.h   | 2 +-
 drivers/infiniband/hw/hfi1/user_pages.c     | 2 +-
 drivers/infiniband/hw/hfi1/user_sdma.c      | 2 +-
 drivers/infiniband/hw/hfi1/user_sdma.h      | 2 +-
 drivers/infiniband/hw/hfi1/verbs.c          | 2 +-
 drivers/infiniband/hw/hfi1/verbs.h          | 2 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.c    | 2 +-
 drivers/infiniband/hw/hfi1/verbs_txreq.h    | 2 +-
 drivers/infiniband/hw/hfi1/vnic.h           | 2 +-
 drivers/infiniband/hw/hfi1/vnic_main.c      | 2 +-
 drivers/infiniband/hw/hfi1/vnic_sdma.c      | 2 +-
 drivers/infiniband/hw/irdma/cm.c            | 2 +-
 drivers/infiniband/hw/irdma/cm.h            | 2 +-
 drivers/infiniband/hw/irdma/ctrl.c          | 2 +-
 drivers/infiniband/hw/irdma/defs.h          | 2 +-
 drivers/infiniband/hw/irdma/hmc.c           | 2 +-
 drivers/infiniband/hw/irdma/hmc.h           | 2 +-
 drivers/infiniband/hw/irdma/hw.c            | 2 +-
 drivers/infiniband/hw/irdma/i40iw_hw.c      | 2 +-
 drivers/infiniband/hw/irdma/i40iw_hw.h      | 2 +-
 drivers/infiniband/hw/irdma/i40iw_if.c      | 2 +-
 drivers/infiniband/hw/irdma/icrdma_hw.c     | 2 +-
 drivers/infiniband/hw/irdma/icrdma_hw.h     | 2 +-
 drivers/infiniband/hw/irdma/irdma.h         | 2 +-
 drivers/infiniband/hw/irdma/main.c          | 2 +-
 drivers/infiniband/hw/irdma/main.h          | 2 +-
 drivers/infiniband/hw/irdma/osdep.h         | 2 +-
 drivers/infiniband/hw/irdma/pble.c          | 2 +-
 drivers/infiniband/hw/irdma/pble.h          | 2 +-
 drivers/infiniband/hw/irdma/protos.h        | 2 +-
 drivers/infiniband/hw/irdma/puda.c          | 2 +-
 drivers/infiniband/hw/irdma/puda.h          | 2 +-
 drivers/infiniband/hw/irdma/trace.c         | 2 +-
 drivers/infiniband/hw/irdma/trace.h         | 2 +-
 drivers/infiniband/hw/irdma/trace_cm.h      | 2 +-
 drivers/infiniband/hw/irdma/type.h          | 2 +-
 drivers/infiniband/hw/irdma/uda.c           | 2 +-
 drivers/infiniband/hw/irdma/uda.h           | 2 +-
 drivers/infiniband/hw/irdma/uda_d.h         | 2 +-
 drivers/infiniband/hw/irdma/uk.c            | 2 +-
 drivers/infiniband/hw/irdma/user.h          | 2 +-
 drivers/infiniband/hw/irdma/utils.c         | 2 +-
 drivers/infiniband/hw/irdma/verbs.c         | 2 +-
 drivers/infiniband/hw/irdma/verbs.h         | 2 +-
 drivers/infiniband/hw/irdma/ws.c            | 2 +-
 drivers/infiniband/hw/irdma/ws.h            | 2 +-
 drivers/infiniband/sw/rdmavt/ah.c           | 2 +-
 drivers/infiniband/sw/rdmavt/ah.h           | 2 +-
 drivers/infiniband/sw/rdmavt/cq.c           | 2 +-
 drivers/infiniband/sw/rdmavt/cq.h           | 2 +-
 drivers/infiniband/sw/rdmavt/mad.c          | 2 +-
 drivers/infiniband/sw/rdmavt/mad.h          | 2 +-
 drivers/infiniband/sw/rdmavt/mcast.c        | 2 +-
 drivers/infiniband/sw/rdmavt/mcast.h        | 2 +-
 drivers/infiniband/sw/rdmavt/mmap.c         | 2 +-
 drivers/infiniband/sw/rdmavt/mmap.h         | 2 +-
 drivers/infiniband/sw/rdmavt/mr.c           | 2 +-
 drivers/infiniband/sw/rdmavt/mr.h           | 2 +-
 drivers/infiniband/sw/rdmavt/pd.c           | 2 +-
 drivers/infiniband/sw/rdmavt/pd.h           | 2 +-
 drivers/infiniband/sw/rdmavt/qp.c           | 2 +-
 drivers/infiniband/sw/rdmavt/qp.h           | 2 +-
 drivers/infiniband/sw/rdmavt/rc.c           | 2 +-
 drivers/infiniband/sw/rdmavt/srq.c          | 2 +-
 drivers/infiniband/sw/rdmavt/srq.h          | 2 +-
 drivers/infiniband/sw/rdmavt/trace.c        | 2 +-
 drivers/infiniband/sw/rdmavt/trace.h        | 2 +-
 drivers/infiniband/sw/rdmavt/trace_cq.h     | 2 +-
 drivers/infiniband/sw/rdmavt/trace_mr.h     | 2 +-
 drivers/infiniband/sw/rdmavt/trace_qp.h     | 2 +-
 drivers/infiniband/sw/rdmavt/trace_rc.h     | 2 +-
 drivers/infiniband/sw/rdmavt/trace_rvt.h    | 2 +-
 drivers/infiniband/sw/rdmavt/trace_tx.h     | 2 +-
 drivers/infiniband/sw/rdmavt/vt.c           | 2 +-
 drivers/infiniband/sw/rdmavt/vt.h           | 2 +-
 drivers/infiniband/sw/siw/iwarp.h           | 2 +-
 drivers/infiniband/sw/siw/siw.h             | 2 +-
 drivers/infiniband/sw/siw/siw_cm.c          | 2 +-
 drivers/infiniband/sw/siw/siw_cm.h          | 2 +-
 drivers/infiniband/sw/siw/siw_cq.c          | 2 +-
 drivers/infiniband/sw/siw/siw_main.c        | 2 +-
 drivers/infiniband/sw/siw/siw_mem.c         | 2 +-
 drivers/infiniband/sw/siw/siw_mem.h         | 2 +-
 drivers/infiniband/sw/siw/siw_qp.c          | 2 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c       | 2 +-
 drivers/infiniband/sw/siw/siw_qp_tx.c       | 2 +-
 drivers/infiniband/sw/siw/siw_verbs.c       | 2 +-
 drivers/infiniband/sw/siw/siw_verbs.h       | 2 +-
 include/uapi/rdma/siw-abi.h                 | 2 +-
 150 files changed, 150 insertions(+), 150 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_tlv.h b/drivers/infiniband/hw/bnxt_re/qplib_tlv.h
index 402c220734f6..ae96a75d7f31 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_tlv.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_tlv.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 
 #ifndef __QPLIB_TLV_H__
 #define __QPLIB_TLV_H__
diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 77ee77d4000f..a8b0852cc4da 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2020 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/affinity.h b/drivers/infiniband/hw/hfi1/affinity.h
index 00854f21787f..ffdd0d571c7a 100644
--- a/drivers/infiniband/hw/hfi1/affinity.h
+++ b/drivers/infiniband/hw/hfi1/affinity.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015 - 2020 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/aspm.h b/drivers/infiniband/hw/hfi1/aspm.h
index df295f47b315..c8d92dc13daa 100644
--- a/drivers/infiniband/hw/hfi1/aspm.h
+++ b/drivers/infiniband/hw/hfi1/aspm.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015-2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index baaa4406d5e6..4aa91ac8ae42 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2020 Intel Corporation.
  * Copyright(c) 2021 Cornelis Networks.
diff --git a/drivers/infiniband/hw/hfi1/chip.h b/drivers/infiniband/hw/hfi1/chip.h
index b2d53713da58..d861aa8fc640 100644
--- a/drivers/infiniband/hw/hfi1/chip.h
+++ b/drivers/infiniband/hw/hfi1/chip.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015 - 2020 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/chip_registers.h b/drivers/infiniband/hw/hfi1/chip_registers.h
index 95a8d530d554..d79e25d20fb8 100644
--- a/drivers/infiniband/hw/hfi1/chip_registers.h
+++ b/drivers/infiniband/hw/hfi1/chip_registers.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/common.h b/drivers/infiniband/hw/hfi1/common.h
index 166ad6b828dc..8abc902b96f3 100644
--- a/drivers/infiniband/hw/hfi1/common.h
+++ b/drivers/infiniband/hw/hfi1/common.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015 - 2020 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/debugfs.c b/drivers/infiniband/hw/hfi1/debugfs.c
index 80ba1e53c068..a1e01b447265 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.c
+++ b/drivers/infiniband/hw/hfi1/debugfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015-2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/debugfs.h b/drivers/infiniband/hw/hfi1/debugfs.h
index 29a5a8de2c41..54d952a4016c 100644
--- a/drivers/infiniband/hw/hfi1/debugfs.h
+++ b/drivers/infiniband/hw/hfi1/debugfs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015, 2016, 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/device.c b/drivers/infiniband/hw/hfi1/device.c
index b0a00b7aaec5..4250d077b06f 100644
--- a/drivers/infiniband/hw/hfi1/device.c
+++ b/drivers/infiniband/hw/hfi1/device.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/device.h b/drivers/infiniband/hw/hfi1/device.h
index c371b5612b6b..a91bea426ba5 100644
--- a/drivers/infiniband/hw/hfi1/device.h
+++ b/drivers/infiniband/hw/hfi1/device.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index f4492fa407e0..37a6794885d3 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015-2020 Intel Corporation.
  * Copyright(c) 2021 Cornelis Networks.
diff --git a/drivers/infiniband/hw/hfi1/efivar.c b/drivers/infiniband/hw/hfi1/efivar.c
index 7741a1d69097..fb06e86da608 100644
--- a/drivers/infiniband/hw/hfi1/efivar.c
+++ b/drivers/infiniband/hw/hfi1/efivar.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/efivar.h b/drivers/infiniband/hw/hfi1/efivar.h
index 5ebc2f07bbef..882240929a4b 100644
--- a/drivers/infiniband/hw/hfi1/efivar.h
+++ b/drivers/infiniband/hw/hfi1/efivar.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/eprom.c b/drivers/infiniband/hw/hfi1/eprom.c
index fbe958107457..f93a160d8d05 100644
--- a/drivers/infiniband/hw/hfi1/eprom.c
+++ b/drivers/infiniband/hw/hfi1/eprom.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/eprom.h b/drivers/infiniband/hw/hfi1/eprom.h
index 772c516366ce..51648d1afcf1 100644
--- a/drivers/infiniband/hw/hfi1/eprom.h
+++ b/drivers/infiniband/hw/hfi1/eprom.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/exp_rcv.c b/drivers/infiniband/hw/hfi1/exp_rcv.c
index b86f697c7956..879a66edbded 100644
--- a/drivers/infiniband/hw/hfi1/exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/exp_rcv.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/exp_rcv.h b/drivers/infiniband/hw/hfi1/exp_rcv.h
index 41f7fe5d1839..141413d9fbc7 100644
--- a/drivers/infiniband/hw/hfi1/exp_rcv.h
+++ b/drivers/infiniband/hw/hfi1/exp_rcv.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index 3af77a0840ab..35d2382ee618 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/fault.h b/drivers/infiniband/hw/hfi1/fault.h
index 7fe7f47219db..51adafe240d7 100644
--- a/drivers/infiniband/hw/hfi1/fault.h
+++ b/drivers/infiniband/hw/hfi1/fault.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index a5ab22cedd41..65c48aa02e3c 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2020 Cornelis Networks, Inc.
  * Copyright(c) 2015-2020 Intel Corporation.
diff --git a/drivers/infiniband/hw/hfi1/firmware.c b/drivers/infiniband/hw/hfi1/firmware.c
index 0c0cef5b1e0e..3c228aeaaf81 100644
--- a/drivers/infiniband/hw/hfi1/firmware.c
+++ b/drivers/infiniband/hw/hfi1/firmware.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 7fa9cd39254f..d9597483123e 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2020 Cornelis Networks, Inc.
  * Copyright(c) 2015-2020 Intel Corporation.
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 6de37c5d7d27..5ce2215e09c2 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2020 Intel Corporation.
  * Copyright(c) 2021 Cornelis Networks.
diff --git a/drivers/infiniband/hw/hfi1/intr.c b/drivers/infiniband/hw/hfi1/intr.c
index 70376e6dba33..3737f632d62a 100644
--- a/drivers/infiniband/hw/hfi1/intr.c
+++ b/drivers/infiniband/hw/hfi1/intr.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/iowait.h b/drivers/infiniband/hw/hfi1/iowait.h
index 4df0700cbaba..49805a24bb0a 100644
--- a/drivers/infiniband/hw/hfi1/iowait.h
+++ b/drivers/infiniband/hw/hfi1/iowait.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index e5e783c45810..a9883295f4af 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015-2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/mad.h b/drivers/infiniband/hw/hfi1/mad.h
index 1d45a008fa7f..b6e3141253c4 100644
--- a/drivers/infiniband/hw/hfi1/mad.h
+++ b/drivers/infiniband/hw/hfi1/mad.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015 - 2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index 7a51f7d73b61..d4a6acad0e65 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2020 Cornelis Networks, Inc.
  * Copyright(c) 2016 - 2017 Intel Corporation.
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.h b/drivers/infiniband/hw/hfi1/mmu_rb.h
index 751dc3fe1e02..8e5d05454d70 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.h
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2020 Cornelis Networks, Inc.
  * Copyright(c) 2016 Intel Corporation.
diff --git a/drivers/infiniband/hw/hfi1/opa_compat.h b/drivers/infiniband/hw/hfi1/opa_compat.h
index 31570b0cfd18..49f2da677b03 100644
--- a/drivers/infiniband/hw/hfi1/opa_compat.h
+++ b/drivers/infiniband/hw/hfi1/opa_compat.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 08732e1ac966..c79cc49c6708 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2019 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
index dfea53e0fdeb..68c621ff59d0 100644
--- a/drivers/infiniband/hw/hfi1/pio.c
+++ b/drivers/infiniband/hw/hfi1/pio.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015-2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/pio.h b/drivers/infiniband/hw/hfi1/pio.h
index ea714008f261..d07cc6ea7c63 100644
--- a/drivers/infiniband/hw/hfi1/pio.h
+++ b/drivers/infiniband/hw/hfi1/pio.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015-2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/pio_copy.c b/drivers/infiniband/hw/hfi1/pio_copy.c
index 7690f996d5e3..80fee812a930 100644
--- a/drivers/infiniband/hw/hfi1/pio_copy.c
+++ b/drivers/infiniband/hw/hfi1/pio_copy.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/platform.c b/drivers/infiniband/hw/hfi1/platform.c
index 54cbd8f1a6c1..7bd0e9b6cb50 100644
--- a/drivers/infiniband/hw/hfi1/platform.c
+++ b/drivers/infiniband/hw/hfi1/platform.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/platform.h b/drivers/infiniband/hw/hfi1/platform.h
index 1d51dca1bc30..0631f9bf3a89 100644
--- a/drivers/infiniband/hw/hfi1/platform.h
+++ b/drivers/infiniband/hw/hfi1/platform.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index 6193d48b2c1f..f3d8c0c193ac 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2020 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/qp.h b/drivers/infiniband/hw/hfi1/qp.h
index cdf87bc6ad94..870ff1a6e5c4 100644
--- a/drivers/infiniband/hw/hfi1/qp.h
+++ b/drivers/infiniband/hw/hfi1/qp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/qsfp.c b/drivers/infiniband/hw/hfi1/qsfp.c
index 19d7887a4f10..52cce1c8b76a 100644
--- a/drivers/infiniband/hw/hfi1/qsfp.c
+++ b/drivers/infiniband/hw/hfi1/qsfp.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/qsfp.h b/drivers/infiniband/hw/hfi1/qsfp.h
index 8f14111eaa47..df1389bad86b 100644
--- a/drivers/infiniband/hw/hfi1/qsfp.h
+++ b/drivers/infiniband/hw/hfi1/qsfp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015, 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index acd2b273ea7d..b36242c9d42c 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/ruc.c b/drivers/infiniband/hw/hfi1/ruc.c
index b0151b7293f5..aafa4e03b179 100644
--- a/drivers/infiniband/hw/hfi1/ruc.c
+++ b/drivers/infiniband/hw/hfi1/ruc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 26c62162759b..6e5ac2023328 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index 7fdebab202c4..d77246b48434 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/sdma_txreq.h b/drivers/infiniband/hw/hfi1/sdma_txreq.h
index 85ae7293c274..5782166d984c 100644
--- a/drivers/infiniband/hw/hfi1/sdma_txreq.h
+++ b/drivers/infiniband/hw/hfi1/sdma_txreq.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/sysfs.c b/drivers/infiniband/hw/hfi1/sysfs.c
index 3b3407dc7c21..d62ba5fdd80c 100644
--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015-2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/trace.c b/drivers/infiniband/hw/hfi1/trace.c
index 8302469582c6..10290ebf76b2 100644
--- a/drivers/infiniband/hw/hfi1/trace.c
+++ b/drivers/infiniband/hw/hfi1/trace.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2020 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/trace.h b/drivers/infiniband/hw/hfi1/trace.h
index 31e027c5a0c0..bb3cc006bacd 100644
--- a/drivers/infiniband/hw/hfi1/trace.h
+++ b/drivers/infiniband/hw/hfi1/trace.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/trace_ctxts.h b/drivers/infiniband/hw/hfi1/trace_ctxts.h
index 1858eaf33b18..76c41bd79071 100644
--- a/drivers/infiniband/hw/hfi1/trace_ctxts.h
+++ b/drivers/infiniband/hw/hfi1/trace_ctxts.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
 * Copyright(c) 2015 - 2020 Intel Corporation.
 */
diff --git a/drivers/infiniband/hw/hfi1/trace_dbg.h b/drivers/infiniband/hw/hfi1/trace_dbg.h
index 489395bfb5b3..75599d5168db 100644
--- a/drivers/infiniband/hw/hfi1/trace_dbg.h
+++ b/drivers/infiniband/hw/hfi1/trace_dbg.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
 * Copyright(c) 2015 - 2018 Intel Corporation.
 */
diff --git a/drivers/infiniband/hw/hfi1/trace_ibhdrs.h b/drivers/infiniband/hw/hfi1/trace_ibhdrs.h
index b33f8f575f8a..b21356abc9ec 100644
--- a/drivers/infiniband/hw/hfi1/trace_ibhdrs.h
+++ b/drivers/infiniband/hw/hfi1/trace_ibhdrs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015 - 2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/trace_misc.h b/drivers/infiniband/hw/hfi1/trace_misc.h
index 742675fa7576..8dc46b6891df 100644
--- a/drivers/infiniband/hw/hfi1/trace_misc.h
+++ b/drivers/infiniband/hw/hfi1/trace_misc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
 * Copyright(c) 2015, 2016 Intel Corporation.
 */
diff --git a/drivers/infiniband/hw/hfi1/trace_mmu.h b/drivers/infiniband/hw/hfi1/trace_mmu.h
index 82cc12aa3fb8..5a9dfd85e7f5 100644
--- a/drivers/infiniband/hw/hfi1/trace_mmu.h
+++ b/drivers/infiniband/hw/hfi1/trace_mmu.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/trace_rc.h b/drivers/infiniband/hw/hfi1/trace_rc.h
index 7c3a1c77536d..fa254f9b9c42 100644
--- a/drivers/infiniband/hw/hfi1/trace_rc.h
+++ b/drivers/infiniband/hw/hfi1/trace_rc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
 * Copyright(c) 2015, 2016, 2017 Intel Corporation.
 */
diff --git a/drivers/infiniband/hw/hfi1/trace_rx.h b/drivers/infiniband/hw/hfi1/trace_rx.h
index 0da22f9bc75e..e6904aa80c00 100644
--- a/drivers/infiniband/hw/hfi1/trace_rx.h
+++ b/drivers/infiniband/hw/hfi1/trace_rx.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/trace_tx.h b/drivers/infiniband/hw/hfi1/trace_tx.h
index ed1b9e1e4b17..c79856d4fdfb 100644
--- a/drivers/infiniband/hw/hfi1/trace_tx.h
+++ b/drivers/infiniband/hw/hfi1/trace_tx.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015 - 2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/uc.c b/drivers/infiniband/hw/hfi1/uc.c
index 4e9d6aa39305..33d2c2a218e2 100644
--- a/drivers/infiniband/hw/hfi1/uc.c
+++ b/drivers/infiniband/hw/hfi1/uc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/ud.c b/drivers/infiniband/hw/hfi1/ud.c
index b64b9d7e08f0..89d1bae8f824 100644
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2019 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index 96058baf36ed..6419872f95cf 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2020 Cornelis Networks, Inc.
  * Copyright(c) 2015-2018 Intel Corporation.
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.h b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
index f8ee997d0050..b85de9070aee 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.h
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2020 - Cornelis Networks, Inc.
  * Copyright(c) 2015 - 2017 Intel Corporation.
diff --git a/drivers/infiniband/hw/hfi1/user_pages.c b/drivers/infiniband/hw/hfi1/user_pages.c
index 36aaedc65145..c77913a7920f 100644
--- a/drivers/infiniband/hw/hfi1/user_pages.c
+++ b/drivers/infiniband/hw/hfi1/user_pages.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015-2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 02bd62b857b7..8391bbfa90e4 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2020 - Cornelis Networks, Inc.
  * Copyright(c) 2015 - 2018 Intel Corporation.
diff --git a/drivers/infiniband/hw/hfi1/user_sdma.h b/drivers/infiniband/hw/hfi1/user_sdma.h
index 548347d4c5bc..57e66ae86112 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.h
+++ b/drivers/infiniband/hw/hfi1/user_sdma.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2020 - Cornelis Networks, Inc.
  * Copyright(c) 2015 - 2018 Intel Corporation.
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index fbdcfecb1768..33af2196ef31 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2020 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/verbs.h b/drivers/infiniband/hw/hfi1/verbs.h
index 7f30f32b34dc..070e4f0babe8 100644
--- a/drivers/infiniband/hw/hfi1/verbs.h
+++ b/drivers/infiniband/hw/hfi1/verbs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/verbs_txreq.c b/drivers/infiniband/hw/hfi1/verbs_txreq.c
index cfecc81a27c7..822f0d05bac8 100644
--- a/drivers/infiniband/hw/hfi1/verbs_txreq.c
+++ b/drivers/infiniband/hw/hfi1/verbs_txreq.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/verbs_txreq.h b/drivers/infiniband/hw/hfi1/verbs_txreq.h
index 2a7e0ae892e9..56353c7676d0 100644
--- a/drivers/infiniband/hw/hfi1/verbs_txreq.h
+++ b/drivers/infiniband/hw/hfi1/verbs_txreq.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/vnic.h b/drivers/infiniband/hw/hfi1/vnic.h
index 34f03e7770be..bbafeb5fc0ec 100644
--- a/drivers/infiniband/hw/hfi1/vnic.h
+++ b/drivers/infiniband/hw/hfi1/vnic.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2017 - 2020 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c b/drivers/infiniband/hw/hfi1/vnic_main.c
index 3650fababf25..16a4c297a897 100644
--- a/drivers/infiniband/hw/hfi1/vnic_main.c
+++ b/drivers/infiniband/hw/hfi1/vnic_main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2017 - 2020 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/hfi1/vnic_sdma.c b/drivers/infiniband/hw/hfi1/vnic_sdma.c
index cc6324d2d1dd..6caf01ba0bca 100644
--- a/drivers/infiniband/hw/hfi1/vnic_sdma.c
+++ b/drivers/infiniband/hw/hfi1/vnic_sdma.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2017 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/irdma/cm.c
index 42d1e9771066..1ee7a4e0d8d8 100644
--- a/drivers/infiniband/hw/irdma/cm.c
+++ b/drivers/infiniband/hw/irdma/cm.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
 #include "trace.h"
diff --git a/drivers/infiniband/hw/irdma/cm.h b/drivers/infiniband/hw/irdma/cm.h
index 7feadb3e1eda..48ee285cf745 100644
--- a/drivers/infiniband/hw/irdma/cm.h
+++ b/drivers/infiniband/hw/irdma/cm.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #ifndef IRDMA_CM_H
 #define IRDMA_CM_H
diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/irdma/ctrl.c
index 8a6200e55c54..6aed6169c07d 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include <linux/etherdevice.h>
 
diff --git a/drivers/infiniband/hw/irdma/defs.h b/drivers/infiniband/hw/irdma/defs.h
index d06e45d2c23f..8fb752f2eda2 100644
--- a/drivers/infiniband/hw/irdma/defs.h
+++ b/drivers/infiniband/hw/irdma/defs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #ifndef IRDMA_DEFS_H
 #define IRDMA_DEFS_H
diff --git a/drivers/infiniband/hw/irdma/hmc.c b/drivers/infiniband/hw/irdma/hmc.c
index 49307ce8c4da..ac58088a8e41 100644
--- a/drivers/infiniband/hw/irdma/hmc.c
+++ b/drivers/infiniband/hw/irdma/hmc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "osdep.h"
 #include "hmc.h"
diff --git a/drivers/infiniband/hw/irdma/hmc.h b/drivers/infiniband/hw/irdma/hmc.h
index f5c5dacc7021..415f9e23bbf6 100644
--- a/drivers/infiniband/hw/irdma/hmc.h
+++ b/drivers/infiniband/hw/irdma/hmc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2015 - 2020 Intel Corporation */
 #ifndef IRDMA_HMC_H
 #define IRDMA_HMC_H
diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 7cbdd5433dba..8fa7e4a18e73 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
 
diff --git a/drivers/infiniband/hw/irdma/i40iw_hw.c b/drivers/infiniband/hw/irdma/i40iw_hw.c
index 638d127fb3e0..ce61a27cb1f6 100644
--- a/drivers/infiniband/hw/irdma/i40iw_hw.c
+++ b/drivers/infiniband/hw/irdma/i40iw_hw.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "osdep.h"
 #include "type.h"
diff --git a/drivers/infiniband/hw/irdma/i40iw_hw.h b/drivers/infiniband/hw/irdma/i40iw_hw.h
index 10afc165f5ea..e1db84d8a62c 100644
--- a/drivers/infiniband/hw/irdma/i40iw_hw.h
+++ b/drivers/infiniband/hw/irdma/i40iw_hw.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #ifndef I40IW_HW_H
 #define I40IW_HW_H
diff --git a/drivers/infiniband/hw/irdma/i40iw_if.c b/drivers/infiniband/hw/irdma/i40iw_if.c
index 4053ead32416..91dc4e994eee 100644
--- a/drivers/infiniband/hw/irdma/i40iw_if.c
+++ b/drivers/infiniband/hw/irdma/i40iw_if.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
 #include "i40iw_hw.h"
diff --git a/drivers/infiniband/hw/irdma/icrdma_hw.c b/drivers/infiniband/hw/irdma/icrdma_hw.c
index 10ccf4bc3f2d..941d3edffadb 100644
--- a/drivers/infiniband/hw/irdma/icrdma_hw.c
+++ b/drivers/infiniband/hw/irdma/icrdma_hw.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2017 - 2021 Intel Corporation */
 #include "osdep.h"
 #include "type.h"
diff --git a/drivers/infiniband/hw/irdma/icrdma_hw.h b/drivers/infiniband/hw/irdma/icrdma_hw.h
index 54035a08cc93..697b9572b5c6 100644
--- a/drivers/infiniband/hw/irdma/icrdma_hw.h
+++ b/drivers/infiniband/hw/irdma/icrdma_hw.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2017 - 2021 Intel Corporation */
 #ifndef ICRDMA_HW_H
 #define ICRDMA_HW_H
diff --git a/drivers/infiniband/hw/irdma/irdma.h b/drivers/infiniband/hw/irdma/irdma.h
index 3237fa64bc8f..20d2e7393e3d 100644
--- a/drivers/infiniband/hw/irdma/irdma.h
+++ b/drivers/infiniband/hw/irdma/irdma.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2017 - 2021 Intel Corporation */
 #ifndef IRDMA_H
 #define IRDMA_H
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 514453777e07..9ac48b4dab41 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
 #include "../../../net/ethernet/intel/ice/ice.h"
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index 82fc5f5b002c..d66d87bb8bc4 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #ifndef IRDMA_MAIN_H
 #define IRDMA_MAIN_H
diff --git a/drivers/infiniband/hw/irdma/osdep.h b/drivers/infiniband/hw/irdma/osdep.h
index fc1ba2a3e6fb..e1e3d3ae72b7 100644
--- a/drivers/infiniband/hw/irdma/osdep.h
+++ b/drivers/infiniband/hw/irdma/osdep.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #ifndef IRDMA_OSDEP_H
 #define IRDMA_OSDEP_H
diff --git a/drivers/infiniband/hw/irdma/pble.c b/drivers/infiniband/hw/irdma/pble.c
index c0bef11436b9..e7ce6840755f 100644
--- a/drivers/infiniband/hw/irdma/pble.c
+++ b/drivers/infiniband/hw/irdma/pble.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "osdep.h"
 #include "hmc.h"
diff --git a/drivers/infiniband/hw/irdma/pble.h b/drivers/infiniband/hw/irdma/pble.h
index b31b7c5d66fe..160ad728e9fb 100644
--- a/drivers/infiniband/hw/irdma/pble.h
+++ b/drivers/infiniband/hw/irdma/pble.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2015 - 2019 Intel Corporation */
 #ifndef IRDMA_PBLE_H
 #define IRDMA_PBLE_H
diff --git a/drivers/infiniband/hw/irdma/protos.h b/drivers/infiniband/hw/irdma/protos.h
index 113096b60323..d7c8ea948bcd 100644
--- a/drivers/infiniband/hw/irdma/protos.h
+++ b/drivers/infiniband/hw/irdma/protos.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2016 - 2021 Intel Corporation */
 #ifndef IRDMA_PROTOS_H
 #define IRDMA_PROTOS_H
diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 562531712ea4..7e3f9bca2c23 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "osdep.h"
 #include "hmc.h"
diff --git a/drivers/infiniband/hw/irdma/puda.h b/drivers/infiniband/hw/irdma/puda.h
index 5f5124db6ddf..bc6d9514c9c1 100644
--- a/drivers/infiniband/hw/irdma/puda.h
+++ b/drivers/infiniband/hw/irdma/puda.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2015 - 2020 Intel Corporation */
 #ifndef IRDMA_PUDA_H
 #define IRDMA_PUDA_H
diff --git a/drivers/infiniband/hw/irdma/trace.c b/drivers/infiniband/hw/irdma/trace.c
index b5133f4137e0..fc2f56697741 100644
--- a/drivers/infiniband/hw/irdma/trace.c
+++ b/drivers/infiniband/hw/irdma/trace.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2019 Intel Corporation */
 #define CREATE_TRACE_POINTS
 #include "trace.h"
diff --git a/drivers/infiniband/hw/irdma/trace.h b/drivers/infiniband/hw/irdma/trace.h
index 702e4efb018d..b8085a66b9f8 100644
--- a/drivers/infiniband/hw/irdma/trace.h
+++ b/drivers/infiniband/hw/irdma/trace.h
@@ -1,3 +1,3 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2019 Intel Corporation */
 #include "trace_cm.h"
diff --git a/drivers/infiniband/hw/irdma/trace_cm.h b/drivers/infiniband/hw/irdma/trace_cm.h
index f633fb343328..0d1699b55241 100644
--- a/drivers/infiniband/hw/irdma/trace_cm.h
+++ b/drivers/infiniband/hw/irdma/trace_cm.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2019 - 2021 Intel Corporation */
 #if !defined(__TRACE_CM_H) || defined(TRACE_HEADER_MULTI_READ)
 #define __TRACE_CM_H
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/irdma/type.h
index c84ec4dd8536..59b34afa867b 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #ifndef IRDMA_TYPE_H
 #define IRDMA_TYPE_H
diff --git a/drivers/infiniband/hw/irdma/uda.c b/drivers/infiniband/hw/irdma/uda.c
index 284cec2a74de..84051266d948 100644
--- a/drivers/infiniband/hw/irdma/uda.c
+++ b/drivers/infiniband/hw/irdma/uda.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2016 - 2021 Intel Corporation */
 #include <linux/etherdevice.h>
 
diff --git a/drivers/infiniband/hw/irdma/uda.h b/drivers/infiniband/hw/irdma/uda.h
index fe4820ff0cca..27b8701cf21b 100644
--- a/drivers/infiniband/hw/irdma/uda.h
+++ b/drivers/infiniband/hw/irdma/uda.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2016 - 2021 Intel Corporation */
 #ifndef IRDMA_UDA_H
 #define IRDMA_UDA_H
diff --git a/drivers/infiniband/hw/irdma/uda_d.h b/drivers/infiniband/hw/irdma/uda_d.h
index bfc81cac2c51..5a9e6eabf032 100644
--- a/drivers/infiniband/hw/irdma/uda_d.h
+++ b/drivers/infiniband/hw/irdma/uda_d.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2016 - 2021 Intel Corporation */
 #ifndef IRDMA_UDA_D_H
 #define IRDMA_UDA_D_H
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
index d8285ca16293..38c54e59cc2e 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "osdep.h"
 #include "defs.h"
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/irdma/user.h
index 36feca57b274..380e4a47aede 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2015 - 2020 Intel Corporation */
 #ifndef IRDMA_USER_H
 #define IRDMA_USER_H
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 6cd5cb85dafe..916bfe2a91eb 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
 
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 3eb7a7a3a975..15ea2f3d48f2 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #include "main.h"
 
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index 5d7b983f47a2..2789bc973210 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2015 - 2021 Intel Corporation */
 #ifndef IRDMA_VERBS_H
 #define IRDMA_VERBS_H
diff --git a/drivers/infiniband/hw/irdma/ws.c b/drivers/infiniband/hw/irdma/ws.c
index 20bc8d0d7f1f..542bc0b1bb03 100644
--- a/drivers/infiniband/hw/irdma/ws.c
+++ b/drivers/infiniband/hw/irdma/ws.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2017 - 2021 Intel Corporation */
 #include "osdep.h"
 #include "hmc.h"
diff --git a/drivers/infiniband/hw/irdma/ws.h b/drivers/infiniband/hw/irdma/ws.h
index d431e3327d26..45490031a389 100644
--- a/drivers/infiniband/hw/irdma/ws.h
+++ b/drivers/infiniband/hw/irdma/ws.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or Linux-OpenIB */
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /* Copyright (c) 2015 - 2020 Intel Corporation */
 #ifndef IRDMA_WS_H
 #define IRDMA_WS_H
diff --git a/drivers/infiniband/sw/rdmavt/ah.c b/drivers/infiniband/sw/rdmavt/ah.c
index 63999239ed9e..56926617b064 100644
--- a/drivers/infiniband/sw/rdmavt/ah.c
+++ b/drivers/infiniband/sw/rdmavt/ah.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 - 2019 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/ah.h b/drivers/infiniband/sw/rdmavt/ah.h
index c11fdf637d64..50ddf802bdcc 100644
--- a/drivers/infiniband/sw/rdmavt/ah.h
+++ b/drivers/infiniband/sw/rdmavt/ah.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 9fe4dcaa049a..82c3f5932249 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/cq.h b/drivers/infiniband/sw/rdmavt/cq.h
index b0a948ec760b..d49b6d1a26cb 100644
--- a/drivers/infiniband/sw/rdmavt/cq.h
+++ b/drivers/infiniband/sw/rdmavt/cq.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/mad.c b/drivers/infiniband/sw/rdmavt/mad.c
index 98a8fe3b04ef..846e014ecc55 100644
--- a/drivers/infiniband/sw/rdmavt/mad.c
+++ b/drivers/infiniband/sw/rdmavt/mad.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/mad.h b/drivers/infiniband/sw/rdmavt/mad.h
index 368be29eab37..705a94537b55 100644
--- a/drivers/infiniband/sw/rdmavt/mad.h
+++ b/drivers/infiniband/sw/rdmavt/mad.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/mcast.c b/drivers/infiniband/sw/rdmavt/mcast.c
index a123874e1ca7..59045bdce2a9 100644
--- a/drivers/infiniband/sw/rdmavt/mcast.c
+++ b/drivers/infiniband/sw/rdmavt/mcast.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/mcast.h b/drivers/infiniband/sw/rdmavt/mcast.h
index b96d86f9625b..7627e0d49d09 100644
--- a/drivers/infiniband/sw/rdmavt/mcast.h
+++ b/drivers/infiniband/sw/rdmavt/mcast.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/mmap.c b/drivers/infiniband/sw/rdmavt/mmap.c
index 4d2238f3f3c8..46e3b3e0643a 100644
--- a/drivers/infiniband/sw/rdmavt/mmap.c
+++ b/drivers/infiniband/sw/rdmavt/mmap.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/mmap.h b/drivers/infiniband/sw/rdmavt/mmap.h
index 7e92cf28e071..29aaca3e8b83 100644
--- a/drivers/infiniband/sw/rdmavt/mmap.h
+++ b/drivers/infiniband/sw/rdmavt/mmap.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 8a1f2e285180..7a9afd5231d5 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/mr.h b/drivers/infiniband/sw/rdmavt/mr.h
index d17f1400b5f6..44afe2731741 100644
--- a/drivers/infiniband/sw/rdmavt/mr.h
+++ b/drivers/infiniband/sw/rdmavt/mr.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/pd.c b/drivers/infiniband/sw/rdmavt/pd.c
index ae62071969fa..3af8081dc6c7 100644
--- a/drivers/infiniband/sw/rdmavt/pd.c
+++ b/drivers/infiniband/sw/rdmavt/pd.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/pd.h b/drivers/infiniband/sw/rdmavt/pd.h
index 42a0ef3b7da3..552adaeb371f 100644
--- a/drivers/infiniband/sw/rdmavt/pd.h
+++ b/drivers/infiniband/sw/rdmavt/pd.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index dc83d0ac6a38..e6203e26cc06 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 - 2020 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/qp.h b/drivers/infiniband/sw/rdmavt/qp.h
index bd04be80723c..1a201d2bedd6 100644
--- a/drivers/infiniband/sw/rdmavt/qp.h
+++ b/drivers/infiniband/sw/rdmavt/qp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/rc.c b/drivers/infiniband/sw/rdmavt/rc.c
index 4e5d4a27633c..7cd473302576 100644
--- a/drivers/infiniband/sw/rdmavt/rc.c
+++ b/drivers/infiniband/sw/rdmavt/rc.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/srq.c b/drivers/infiniband/sw/rdmavt/srq.c
index 14d196bde2a1..fe125bf85b27 100644
--- a/drivers/infiniband/sw/rdmavt/srq.c
+++ b/drivers/infiniband/sw/rdmavt/srq.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/srq.h b/drivers/infiniband/sw/rdmavt/srq.h
index 7d17372cd269..e654a9fa2989 100644
--- a/drivers/infiniband/sw/rdmavt/srq.h
+++ b/drivers/infiniband/sw/rdmavt/srq.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/trace.c b/drivers/infiniband/sw/rdmavt/trace.c
index 01704b8dd683..e31b9f3e752d 100644
--- a/drivers/infiniband/sw/rdmavt/trace.c
+++ b/drivers/infiniband/sw/rdmavt/trace.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/trace.h b/drivers/infiniband/sw/rdmavt/trace.h
index 30eb4a72ea7d..4341965a5ea7 100644
--- a/drivers/infiniband/sw/rdmavt/trace.h
+++ b/drivers/infiniband/sw/rdmavt/trace.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016, 2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/trace_cq.h b/drivers/infiniband/sw/rdmavt/trace_cq.h
index 30dd1d9bae26..54ce06e10b7f 100644
--- a/drivers/infiniband/sw/rdmavt/trace_cq.h
+++ b/drivers/infiniband/sw/rdmavt/trace_cq.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/trace_mr.h b/drivers/infiniband/sw/rdmavt/trace_mr.h
index 1de7012000cb..0cb8e0a0565e 100644
--- a/drivers/infiniband/sw/rdmavt/trace_mr.h
+++ b/drivers/infiniband/sw/rdmavt/trace_mr.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/trace_qp.h b/drivers/infiniband/sw/rdmavt/trace_qp.h
index c28c81fcb32a..fa128f16ca3f 100644
--- a/drivers/infiniband/sw/rdmavt/trace_qp.h
+++ b/drivers/infiniband/sw/rdmavt/trace_qp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/trace_rc.h b/drivers/infiniband/sw/rdmavt/trace_rc.h
index 833bf778b05d..9919d66c17c3 100644
--- a/drivers/infiniband/sw/rdmavt/trace_rc.h
+++ b/drivers/infiniband/sw/rdmavt/trace_rc.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2017 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/trace_rvt.h b/drivers/infiniband/sw/rdmavt/trace_rvt.h
index 9df6b0b8263b..df33c2ca9710 100644
--- a/drivers/infiniband/sw/rdmavt/trace_rvt.h
+++ b/drivers/infiniband/sw/rdmavt/trace_rvt.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/trace_tx.h b/drivers/infiniband/sw/rdmavt/trace_tx.h
index ff7d39a30768..dff18baa2765 100644
--- a/drivers/infiniband/sw/rdmavt/trace_tx.h
+++ b/drivers/infiniband/sw/rdmavt/trace_tx.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
index d61f8de7f21c..5499025e8a0a 100644
--- a/drivers/infiniband/sw/rdmavt/vt.c
+++ b/drivers/infiniband/sw/rdmavt/vt.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright(c) 2016 - 2018 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/rdmavt/vt.h b/drivers/infiniband/sw/rdmavt/vt.h
index 461574e3f6a5..4d17333fa90e 100644
--- a/drivers/infiniband/sw/rdmavt/vt.h
+++ b/drivers/infiniband/sw/rdmavt/vt.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright(c) 2016 Intel Corporation.
  */
diff --git a/drivers/infiniband/sw/siw/iwarp.h b/drivers/infiniband/sw/siw/iwarp.h
index 3f1dedb50a0d..8cf69309827d 100644
--- a/drivers/infiniband/sw/siw/iwarp.h
+++ b/drivers/infiniband/sw/siw/iwarp.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 58dddb143b9f..1c78c1ca7d7a 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index da530c0404da..0137e1758692 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /*          Fredy Neeser */
diff --git a/drivers/infiniband/sw/siw/siw_cm.h b/drivers/infiniband/sw/siw/siw_cm.h
index 8c59cb3e2868..7011c8a8ee7b 100644
--- a/drivers/infiniband/sw/siw/siw_cm.h
+++ b/drivers/infiniband/sw/siw/siw_cm.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /*          Greg Joyce <greg@opengridcomputing.com> */
diff --git a/drivers/infiniband/sw/siw/siw_cq.c b/drivers/infiniband/sw/siw/siw_cq.c
index 403029de6b92..f3c2226aff94 100644
--- a/drivers/infiniband/sw/siw/siw_cq.c
+++ b/drivers/infiniband/sw/siw/siw_cq.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index d4b6e0106851..1ab62982df74 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index e6e25f15567d..c5f7f1669d09 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
diff --git a/drivers/infiniband/sw/siw/siw_mem.h b/drivers/infiniband/sw/siw/siw_mem.h
index f911287576d1..a2835284fe5b 100644
--- a/drivers/infiniband/sw/siw/siw_mem.h
+++ b/drivers/infiniband/sw/siw/siw_mem.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 47d0197db9a1..26e3904d2f41 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 58bbf738e4e5..33e0fdb362ff 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index 3ff339eceec3..b893bb70f191 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index fadfa70853f3..f73e4d4918ee 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
diff --git a/drivers/infiniband/sw/siw/siw_verbs.h b/drivers/infiniband/sw/siw/siw_verbs.h
index 09964234f8d3..4b57a4fb7237 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.h
+++ b/drivers/infiniband/sw/siw/siw_verbs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
diff --git a/include/uapi/rdma/siw-abi.h b/include/uapi/rdma/siw-abi.h
index af735f55b291..6df49724954f 100644
--- a/include/uapi/rdma/siw-abi.h
+++ b/include/uapi/rdma/siw-abi.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) or BSD-3-Clause */
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause */
 
 /* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
 /* Copyright (c) 2008-2019, IBM Corporation */
-- 
2.34.1

