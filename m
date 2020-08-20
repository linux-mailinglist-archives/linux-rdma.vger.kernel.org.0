Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A7624C7F4
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgHTWrm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgHTWrY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:24 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA51BC061344
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:22 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id z11so793083oon.5
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkxMsfDZGJsXIlJ7xVy08vjZgHeu868xr615zQAOTkM=;
        b=U0qJmD1W3S1hInTAqT1D1a2Tn3aYbv8Xm3cqtwLBO97h9QYEibMIpFhNnMsviZvlnT
         zClNQna7rjmB/QS8oV9/cviA//WxbVg5iA3vVYPvdYpCxFMpmh1Hn2B9JK8iMW1O4tOx
         9nQEXf5aoFM+26KmFMlcfZ3/BWLawkK5HCTFINZx9ClLhvK5qSBRZOSVeom4vYt4Ej8E
         V6ndcwI2eB0Muyt6eduNvV7EhQxzemL1T4s+eA8hmGWLeDKBF44NFoRemM/1o9ZWzgN5
         ffnxpg9bDHq050uZ52iPziDGYZAG+midux2UDY1yb0lu1SBcjSSwynGfE972s6QHOaz6
         7tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkxMsfDZGJsXIlJ7xVy08vjZgHeu868xr615zQAOTkM=;
        b=sEtyrIjK6qJ1/iKrQE2y/1GW0knc2HTZrlbKnVLK04I/JwauF0rCc8Hr7xxQe2epn/
         4MxWWKh/tHXSnc3mkvhUcA9FAXzx6R6RX80xVG+n/729xUPzsVSSyc68+N9b9y7WEMG0
         Q/ztgWffsdt35i5HipbzBnpu3ZnZkK6wsXQPZXzJ2AnsZ1j+z0k3v2JQqKsKvE4troKH
         ajY66g2XOSZI1hztBkszff9h/G/cRsT3wXqkc6JY1FdSD/q7AQQ1XnSKn6509f9HqyXL
         NHnVf9UpffGcGQikRG7RjOi+hfv/xgCtExtndoo6ndWGmSLhjSoLUAw/heXFaadKhPWH
         hLIQ==
X-Gm-Message-State: AOAM530dp1BcbokR3cMyJ4HdjiC3z0Zmcb7enLpQQ3oKFI3mVefESsEQ
        InBm6OdwZjw28yjtvA5ScRJBB7ydm/U3cg==
X-Google-Smtp-Source: ABdhPJwuIbGLeBhJFrgHOwhtfPSv3BBBcIQhafeFTIX58nPdOTxKoyX8pc8TdHe7PW4Yrc1IgxzBvA==
X-Received: by 2002:a4a:9441:: with SMTP id j1mr22308ooi.46.1597963633909;
        Thu, 20 Aug 2020 15:47:13 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id h11sm352otj.42.2020.08.20.15.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 01/17] rdma_rxe: Added SPDX headers to rxe source files
Date:   Thu, 20 Aug 2020 17:46:22 -0500
Message-Id: <20200820224638.3212-2-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820224638.3212-1-rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Added SPDX header to all tracked .c and .h files.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe.c             | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe.h             | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_av.c          | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_comp.c        | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_cq.c          | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_hdr.h         | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_hw_counters.c | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_hw_counters.h | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_icrc.c        | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_loc.h         | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_mcast.c       | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_mmap.c        | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_mr.c          | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_net.c         | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_net.h         | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_opcode.c      | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_opcode.h      | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_param.h       | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_pool.c        | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_pool.h        | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_qp.c          | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_queue.c       | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_queue.h       | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_recv.c        | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_req.c         | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_resp.c        | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_srq.c         | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_sysfs.c       | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_task.c        | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_task.h        | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_verbs.c       | 31 ++-------------------
 drivers/infiniband/sw/rxe/rxe_verbs.h       | 31 ++-------------------
 32 files changed, 96 insertions(+), 896 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 907203afbd99..6c2100c71874 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <rdma/rdma_netlink.h>
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index fb07eed9e402..c5a2ee265fa7 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_H
diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 81ee756c19b8..de9445d7210d 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_av.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *		- Redistributions of source code must retain the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer.
- *
- *		- Redistributions in binary form must reproduce the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer in the documentation and/or other materials
- *		  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 4bc88708b355..ab1e61ca98d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_comp.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/skbuff.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index ad3090131126..4e5c325f74f4 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_cq.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 #include <linux/vmalloc.h>
 #include "rxe.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index ce003666b800..9a1913db86f0 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_hdr.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_HDR_H
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
index 636edb5f4cf4..1cbf4887d7b2 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
@@ -1,33 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
- * Copyright (c) 2017 Mellanox Technologies Ltd. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
+ * linux/drivers/infiniband/sw/rxe/rxe_hw_counters.c
  *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
+ * Copyright (c) 2017 Mellanox Technologies Ltd. All rights reserved.
  */
 
 #include "rxe.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
index 72c0d63c79e0..9718ecc10130 100644
--- a/drivers/infiniband/sw/rxe/rxe_hw_counters.h
+++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
@@ -1,33 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
- * Copyright (c) 2017 Mellanox Technologies Ltd. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
+ * linux/drivers/infiniband/sw/rxe/rxe_hw_counters.h
  *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
+ * Copyright (c) 2017 Mellanox Technologies Ltd. All rights reserved.
  */
 
 #ifndef RXE_HW_COUNTERS_H
diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 39e0be31aab1..398f632d8958 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_icrc.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 39dc3bfa5d5d..47d1730f43dd 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_loc.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_LOC_H
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 522a7942c56c..4c7304a6259a 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_mcast.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *		- Redistributions of source code must retain the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer.
- *
- *		- Redistributions in binary form must reproduce the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer in the documentation and/or other materials
- *		  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index 7887f623f62c..a6179dc65ca4 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_mmap.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/module.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index cdd811a45120..6e802abc4257 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_mr.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 0c3808611f95..8c390da4897b 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_net.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/skbuff.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
index 2ca71d3d245c..e899f588fc2f 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.h
+++ b/drivers/infiniband/sw/rxe/rxe_net.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_net.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_NET_H
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.c b/drivers/infiniband/sw/rxe/rxe_opcode.c
index 4cf11063e0b5..ddfc08c14893 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.c
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_opcode.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <rdma/ib_pack.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index 307604e9c78d..59e8b3875826 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_opcode.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_OPCODE_H
diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 2f381aeafcb5..96516e251bc1 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_param.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_PARAM_H
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index fbcbac52290b..31fb0be7cdf3 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_pool.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *		- Redistributions of source code must retain the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer.
- *
- *		- Redistributions in binary form must reproduce the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer in the documentation and/or other materials
- *		  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index 2f2cff1cbe43..c5a7721c8fde 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_pool.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *		- Redistributions of source code must retain the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer.
- *
- *		- Redistributions in binary form must reproduce the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer in the documentation and/or other materials
- *		  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_POOL_H
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 6c11c3aeeca6..b6bf74b2fe06 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_qp.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *		- Redistributions of source code must retain the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer.
- *
- *		- Redistributions in binary form must reproduce the above
- *		  copyright notice, this list of conditions and the following
- *		  disclaimer in the documentation and/or other materials
- *		  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/skbuff.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index 245040c3a35d..6aa4b5dac8fc 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_queue.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must retailuce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/vmalloc.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
index 8ef17d617022..799adfef6ba8 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.h
+++ b/drivers/infiniband/sw/rxe/rxe_queue.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_queue.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_QUEUE_H
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 7e123d3c4d09..5cbf0eedf616 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_recv.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/skbuff.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 34df2b55e650..dcf6ab0bcd51 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_req.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/skbuff.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index c4a8195bf670..aefc9a27ece5 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_resp.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/skbuff.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
index d8459431534e..a0744d6a13c2 100644
--- a/drivers/infiniband/sw/rxe/rxe_srq.c
+++ b/drivers/infiniband/sw/rxe/rxe_srq.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_srq.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/vmalloc.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
index ccda5f5a3bc0..83ff077b81d0 100644
--- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
+++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_sysfs.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include "rxe.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 08f05ac5f5d5..c53c639e6e40 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_task.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 08ff42d451c6..1b5bc405cafe 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_task.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_TASK_H
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index bb61e534e468..9aaf3a9fed7c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1,34 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_verbs.c
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #include <linux/dma-mapping.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index c664c7f36ab5..431551bb5d66 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -1,34 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
 /*
+ * linux/drivers/infiniband/sw/rxe/rxe_verbs.h
+ *
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *	   Redistribution and use in source and binary forms, with or
- *	   without modification, are permitted provided that the following
- *	   conditions are met:
- *
- *	- Redistributions of source code must retain the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer.
- *
- *	- Redistributions in binary form must reproduce the above
- *	  copyright notice, this list of conditions and the following
- *	  disclaimer in the documentation and/or other materials
- *	  provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
  */
 
 #ifndef RXE_VERBS_H
-- 
2.25.1

