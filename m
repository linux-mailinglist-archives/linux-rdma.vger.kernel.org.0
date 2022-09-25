Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3925E9375
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Sep 2022 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiIYNkL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Sep 2022 09:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiIYNkL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Sep 2022 09:40:11 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA98B1FCED
        for <linux-rdma@vger.kernel.org>; Sun, 25 Sep 2022 06:40:07 -0700 (PDT)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id cRrYohKCbeT4ccRrYoJ6lU; Sun, 25 Sep 2022 15:40:06 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 Sep 2022 15:40:06 +0200
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH] headers: Remove some left-over license text in include/uapi/rdma/
Date:   Sun, 25 Sep 2022 15:39:58 +0200
Message-Id: <6b2b69c1eb89a37b95d17a1e866c2e8173c6fd15.1664113175.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is already a SPDX-License-Identifier tag, so the corresponding
license text can be removed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in the 2 files under rdma/hfi/ is a bit more than just removing
the license text. There were some Copyright(c) for GPL and BSD licence.
I have simplified it to what look logical to me.
But in case it matters, review with care.

In include/uapi/rdma/qedr-abi.h, an extar line has been added at the top
of the file to improve style.
---
 include/uapi/rdma/bnxt_re-abi.h         | 29 ---------------
 include/uapi/rdma/cxgb4-abi.h           | 28 ---------------
 include/uapi/rdma/hfi/hfi1_ioctl.h      | 46 ------------------------
 include/uapi/rdma/hfi/hfi1_user.h       | 48 -------------------------
 include/uapi/rdma/hns-abi.h             | 28 ---------------
 include/uapi/rdma/ib_user_ioctl_verbs.h | 28 ---------------
 include/uapi/rdma/ib_user_mad.h         | 28 ---------------
 include/uapi/rdma/ib_user_sa.h          | 28 ---------------
 include/uapi/rdma/ib_user_verbs.h       | 28 ---------------
 include/uapi/rdma/mlx4-abi.h            | 28 ---------------
 include/uapi/rdma/mlx5-abi.h            | 28 ---------------
 include/uapi/rdma/mthca-abi.h           | 28 ---------------
 include/uapi/rdma/ocrdma-abi.h          | 28 ---------------
 include/uapi/rdma/qedr-abi.h            | 31 ++--------------
 include/uapi/rdma/rdma_user_cm.h        | 28 ---------------
 include/uapi/rdma/rdma_user_ioctl.h     | 28 ---------------
 include/uapi/rdma/rdma_user_rxe.h       | 28 ---------------
 include/uapi/rdma/vmw_pvrdma-abi.h      | 41 ---------------------
 18 files changed, 2 insertions(+), 557 deletions(-)

diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index b1de99bf56ce..1ef44e80050b 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -5,35 +5,6 @@
  * Copyright (c) 2016 - 2017, Broadcom. All rights reserved.  The term
  * Broadcom refers to Broadcom Limited and/or its subsidiaries.
  *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * BSD license below:
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * 1. Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- * 2. Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS''
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
- * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
- * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS
- * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
- * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
- * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
  * Description: Uverbs ABI header file
  */
 
diff --git a/include/uapi/rdma/cxgb4-abi.h b/include/uapi/rdma/cxgb4-abi.h
index f85ec1a3f727..d560b45c1222 100644
--- a/include/uapi/rdma/cxgb4-abi.h
+++ b/include/uapi/rdma/cxgb4-abi.h
@@ -1,34 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2009-2010 Chelsio, Inc. All rights reserved.
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
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
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
 #ifndef CXGB4_ABI_USER_H
 #define CXGB4_ABI_USER_H
diff --git a/include/uapi/rdma/hfi/hfi1_ioctl.h b/include/uapi/rdma/hfi/hfi1_ioctl.h
index 8f3d9fe7b141..7dda082ac151 100644
--- a/include/uapi/rdma/hfi/hfi1_ioctl.h
+++ b/include/uapi/rdma/hfi/hfi1_ioctl.h
@@ -1,52 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
- * Copyright(c) 2015 Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * BSD LICENSE
- *
  * Copyright(c) 2015 Intel Corporation.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  - Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  - Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  - Neither the name of Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
  */
 
 #ifndef _LINUX__HFI1_IOCTL_H
diff --git a/include/uapi/rdma/hfi/hfi1_user.h b/include/uapi/rdma/hfi/hfi1_user.h
index 1106a7c90b29..fcee53aea132 100644
--- a/include/uapi/rdma/hfi/hfi1_user.h
+++ b/include/uapi/rdma/hfi/hfi1_user.h
@@ -1,55 +1,7 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
- *
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
  * Copyright(c) 2015 - 2020 Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * BSD LICENSE
- *
- * Copyright(c) 2015 Intel Corporation.
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *  - Redistributions of source code must retain the above copyright
- *    notice, this list of conditions and the following disclaimer.
- *  - Redistributions in binary form must reproduce the above copyright
- *    notice, this list of conditions and the following disclaimer in
- *    the documentation and/or other materials provided with the
- *    distribution.
- *  - Neither the name of Intel Corporation nor the names of its
- *    contributors may be used to endorse or promote products derived
- *    from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- */
-
-/*
  * This file contains defines, structures, etc. that are used
  * to communicate between kernel and user code.
  */
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index f6fde06db4b4..838dd4e8a442 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -1,34 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2016 Hisilicon Limited.
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
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
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
 
 #ifndef HNS_ABI_USER_H
diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index e0c25537fd2e..bf96df8027d5 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -1,34 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2017-2018, Mellanox Technologies inc.  All rights reserved.
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
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
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
 
 #ifndef IB_USER_IOCTL_VERBS_H
diff --git a/include/uapi/rdma/ib_user_mad.h b/include/uapi/rdma/ib_user_mad.h
index 10b5f6a4c677..dc3f1baef552 100644
--- a/include/uapi/rdma/ib_user_mad.h
+++ b/include/uapi/rdma/ib_user_mad.h
@@ -2,34 +2,6 @@
 /*
  * Copyright (c) 2004 Topspin Communications.  All rights reserved.
  * Copyright (c) 2005 Voltaire, Inc. All rights reserved.
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
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
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
 
 #ifndef IB_USER_MAD_H
diff --git a/include/uapi/rdma/ib_user_sa.h b/include/uapi/rdma/ib_user_sa.h
index 435155d6e1c6..c9fb4ab58f9a 100644
--- a/include/uapi/rdma/ib_user_sa.h
+++ b/include/uapi/rdma/ib_user_sa.h
@@ -1,34 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2005 Intel Corporation.  All rights reserved.
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
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
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
 
 #ifndef IB_USER_SA_H
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 43672cb1fd57..1d7aef8f7cff 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -4,34 +4,6 @@
  * Copyright (c) 2005, 2006 Cisco Systems.  All rights reserved.
  * Copyright (c) 2005 PathScale, Inc.  All rights reserved.
  * Copyright (c) 2006 Mellanox Technologies.  All rights reserved.
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
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
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
 
 #ifndef IB_USER_VERBS_H
diff --git a/include/uapi/rdma/mlx4-abi.h b/include/uapi/rdma/mlx4-abi.h
index f74557528175..ad63e996ef24 100644
--- a/include/uapi/rdma/mlx4-abi.h
+++ b/include/uapi/rdma/mlx4-abi.h
@@ -2,34 +2,6 @@
 /*
  * Copyright (c) 2007 Cisco Systems, Inc. All rights reserved.
  * Copyright (c) 2007, 2008 Mellanox Technologies. All rights reserved.
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
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
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
 
 #ifndef MLX4_ABI_USER_H
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index a96b7d2770e1..7f32a865b7f5 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -1,34 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2013-2015, Mellanox Technologies. All rights reserved.
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
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
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
 
 #ifndef MLX5_ABI_USER_H
diff --git a/include/uapi/rdma/mthca-abi.h b/include/uapi/rdma/mthca-abi.h
index 91b12e1a6f43..9481b536797b 100644
--- a/include/uapi/rdma/mthca-abi.h
+++ b/include/uapi/rdma/mthca-abi.h
@@ -2,34 +2,6 @@
 /*
  * Copyright (c) 2005 Topspin Communications.  All rights reserved.
  * Copyright (c) 2005, 2006 Cisco Systems.  All rights reserved.
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
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
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
 
 #ifndef MTHCA_ABI_USER_H
diff --git a/include/uapi/rdma/ocrdma-abi.h b/include/uapi/rdma/ocrdma-abi.h
index 284d47b41f6e..59c0fb8b9b34 100644
--- a/include/uapi/rdma/ocrdma-abi.h
+++ b/include/uapi/rdma/ocrdma-abi.h
@@ -5,34 +5,6 @@
  * EMULEX and SLI are trademarks of Emulex.
  * www.emulex.com
  *
- * This software is available to you under a choice of one of two licenses.
- * You may choose to be licensed under the terms of the GNU General Public
- * License (GPL) Version 2, available from the file COPYING in the main
- * directory of this source tree, or the BSD license below:
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- * - Redistributions of source code must retain the above copyright notice,
- *   this list of conditions and the following disclaimer.
- *
- * - Redistributions in binary form must reproduce the above copyright
- *   notice, this list of conditions and the following disclaimer in
- *   the documentation and/or other materials provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
- * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
- * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
- * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
- * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
  * Contact Information:
  * linux-drivers@emulex.com
  *
diff --git a/include/uapi/rdma/qedr-abi.h b/include/uapi/rdma/qedr-abi.h
index bf7333b2b5d7..3c372e523ad6 100644
--- a/include/uapi/rdma/qedr-abi.h
+++ b/include/uapi/rdma/qedr-abi.h
@@ -1,34 +1,7 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
-/* QLogic qedr NIC Driver
+/*
+ * QLogic qedr NIC Driver
  * Copyright (c) 2015-2016  QLogic Corporation
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
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and /or other materials
- *        provided with the distribution.
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
 #ifndef __QEDR_USER_H__
 #define __QEDR_USER_H__
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index 7cea03581f79..d2b07c2653b3 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -1,34 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2005-2006 Intel Corporation.  All rights reserved.
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
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
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
 
 #ifndef RDMA_USER_CM_H
diff --git a/include/uapi/rdma/rdma_user_ioctl.h b/include/uapi/rdma/rdma_user_ioctl.h
index 53c55188dd2a..a83f6e3da4fd 100644
--- a/include/uapi/rdma/rdma_user_ioctl.h
+++ b/include/uapi/rdma/rdma_user_ioctl.h
@@ -1,34 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2016 Mellanox Technologies, LTD. All rights reserved.
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
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
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
 
 #ifndef RDMA_USER_IOCTL_H
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index f09c5c9e3dd5..373530ef5d6e 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -1,34 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
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
 
 #ifndef RDMA_USER_RXE_H
diff --git a/include/uapi/rdma/vmw_pvrdma-abi.h b/include/uapi/rdma/vmw_pvrdma-abi.h
index 901a4fd72c09..135a4bd61d1e 100644
--- a/include/uapi/rdma/vmw_pvrdma-abi.h
+++ b/include/uapi/rdma/vmw_pvrdma-abi.h
@@ -1,47 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
 /*
  * Copyright (c) 2012-2016 VMware, Inc.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of EITHER the GNU General Public License
- * version 2 as published by the Free Software Foundation or the BSD
- * 2-Clause License. This program is distributed in the hope that it
- * will be useful, but WITHOUT ANY WARRANTY; WITHOUT EVEN THE IMPLIED
- * WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.
- * See the GNU General Public License version 2 for more details at
- * http://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program available in the file COPYING in the main
- * directory of this source tree.
- *
- * The BSD 2-Clause License
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
- * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
- * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
- * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
- * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
- * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
- * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
- * OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
 #ifndef __VMW_PVRDMA_ABI_H__
-- 
2.34.1

