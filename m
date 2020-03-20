Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57C018C464
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 01:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCTAtf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 20:49:35 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:40045 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCTAtf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 20:49:35 -0400
Received: by mail-pj1-f74.google.com with SMTP id d2so2806329pjz.5
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 17:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6XSIWZSfT7R2ZOldWxPdhoNf46UCTZYXjLRaAA5FSXM=;
        b=ckGFSUc9Xz3wH3gwbW3G6O1aUsb4KC328w0jk8RKqCK3nfTKrmFV91YsM/0awOPkwz
         KYm+e8wY46hqTw8d75BZfgY522NY8azTmcHhHHMZIHqk2onyis5Cs0cVrBYLXpMVLeB9
         rYZZKwpeM7UClomQzOtEnbXCEEBkJAMWeXCvD+A/Aws6i1fo6/PSgdwZYEPwErTenoOr
         dsi27cg/k1ua4CdcW4XyoXHueVBbqM1QzHoLdgg5b/BOSPrDtJM5UfL8Jg9E1Puy0n+3
         WfzOByzuIu8Ec6B0gsmWdC4RUa4e2XtO5Jm/X23BetE45bXS9XPFE337YyROKlAJctTN
         t5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6XSIWZSfT7R2ZOldWxPdhoNf46UCTZYXjLRaAA5FSXM=;
        b=I/ZwmrY3ictWvYi22ic/lqWXg0ZKBvHApY5ZSbIQTbK3baMDvF+j6un02aLCtDN/nw
         wBEEBuqDhjCfAA67EQN+lrDfedoNnNyztMVnzjyLmOyzeFWVQiccnDvML27OJo52XcRL
         olk0agdSkH/XKdonzYC7pJmPDKUPjvnCngTnxYN06C2kYNwS3luQ9T/DOXC3SZDCUXus
         Yn4Dga+kD2WXeTB0atKgcgUQbZJnLQzK5XcvrS7ST7dkVC+10ySzIXZcpIVv2kiZprpW
         nhvF3Z91xSgqL95l/JFUXmkomNFO8XiA+ev7cRCi2v7ECPtqtRsjuvWXxW+FVW5co3SK
         7vvg==
X-Gm-Message-State: ANhLgQ1tyhSEmqVebR3pZQrHpnaqnSHGdbSo8AoeDfDLx0OkaWGhWgK8
        2ssMwv1hNsf0K7VjzcrKU0+O4ns=
X-Google-Smtp-Source: ADFU+vsPF+rjSx8XAW8GOnpJ2gg60yMlYvzrbbr6aiethIVryl3mBF97SbNlmVFzL+WsNKLp/D9aR9g=
X-Received: by 2002:a17:90b:307:: with SMTP id ay7mr6715109pjb.123.1584665374353;
 Thu, 19 Mar 2020 17:49:34 -0700 (PDT)
Date:   Thu, 19 Mar 2020 17:48:36 -0700
Message-Id: <20200320004836.49844-1-enh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] uapi/rdma/: add SPDX for remaining OpenIB headers.
From:   Elliott Hughes <enh@google.com>
To:     tglx@linutronix.de, gregkh@linuxfoundation.org
Cc:     linux-spdx@vger.kernel.org, linux-rdma@vger.kernel.org,
        Elliott Hughes <enh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These header files have the same copyright as others in this directory
that have this SPDX line.
---
 include/uapi/rdma/i40iw-abi.h             | 1 +
 include/uapi/rdma/ib_user_ioctl_cmds.h    | 1 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h  | 1 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h | 1 +
 include/uapi/rdma/rdma_user_ioctl_cmds.h  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/include/uapi/rdma/i40iw-abi.h b/include/uapi/rdma/i40iw-abi.h
index 79890baa6fdb..81bdbceb70f4 100644
--- a/include/uapi/rdma/i40iw-abi.h
+++ b/include/uapi/rdma/i40iw-abi.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2006 - 2016 Intel Corporation.  All rights reserved.
  * Copyright (c) 2005 Topspin Communications.  All rights reserved.
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index d4ddbe4e696c..e21aff578905 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
  *
diff --git a/include/uapi/rdma/mlx5_user_ioctl_cmds.h b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
index afe7da6f2b8e..060976cbf72f 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_cmds.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_cmds.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
  *
diff --git a/include/uapi/rdma/mlx5_user_ioctl_verbs.h b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
index 88b6ca70c2fe..506e63d0add4 100644
--- a/include/uapi/rdma/mlx5_user_ioctl_verbs.h
+++ b/include/uapi/rdma/mlx5_user_ioctl_verbs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
  *
diff --git a/include/uapi/rdma/rdma_user_ioctl_cmds.h b/include/uapi/rdma/rdma_user_ioctl_cmds.h
index 7b1ec806f8f9..f994916ae84e 100644
--- a/include/uapi/rdma/rdma_user_ioctl_cmds.h
+++ b/include/uapi/rdma/rdma_user_ioctl_cmds.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR Linux-OpenIB) */
 /*
  * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
  *
-- 
2.25.1.696.g5e7596f4ac-goog

