Return-Path: <linux-rdma+bounces-8423-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B73A54A13
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 12:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9091697AA
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE45B20AF67;
	Thu,  6 Mar 2025 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhPHyyFO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61620A5D3;
	Thu,  6 Mar 2025 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261955; cv=none; b=UjOXYaI9nZo2zIxmbvUCDC554Wt3L+f4EsyOJxzR+S5pPljk5IXnC3Ag9K8UXQrBEUlbyDXnflJQ8N21irgImUEg5Q/eGryiP+wLQyPyuHoGSEEcvZHvwbAhSR5t7U18vp368WYy4IcF2AZxzQU744jMehyU7mp+OSTVhF7R2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261955; c=relaxed/simple;
	bh=4TNlmV4WiESdLqnmWqz+l+1OpeFDoosOidqN+VhVqhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8lKRtpgQBrJmu+TRmwt0xP0+xNA7WgQjBtUR08oi7m/T1zc16941TDx/sEyTZVniQJ9bZa1MV+Gu/K413H4dzHSzF+wgBsskkECCB+l+v3EJ2oVN5rsc9JDVR8VZ4AtePQB4ykDILi/wbPGtlo1/bxvwF/1+zjwKMmiNAjX8wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhPHyyFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD98DC4CEE2;
	Thu,  6 Mar 2025 11:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741261955;
	bh=4TNlmV4WiESdLqnmWqz+l+1OpeFDoosOidqN+VhVqhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhPHyyFOOUq7L6/K6qma/qyfwVkJEprJznkDVFbFA8GCF7REisdF6IubHSc+bLeQB
	 Rah43IqTRnC+bW/Zc6AF04UsiUk5qEOSFrpZEVJb6wCOSwYj6tjQwphLIkYxHWgsz6
	 oeZvf+WUFRcw5d0AkuJSM6RjXIKAF511BNSNjUwrU+ikTAhhLN3TwYSG7lvAlJR0ef
	 qfwwFp0Gq7H6YscUNkI42Z9UmOGksA1TVL40oZm1p5WTvcDnwq+SaaQciirl+vpyRS
	 +ELPGyFIi8SJSrJduRTm3aLsg62KlRTvsEl9VI0K7Ic84f7cIUIh3RisUoY08zdjz1
	 Ca9qCrKzlW2Rg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v1 6/6] docs: infiniband: document the UCAP API
Date: Thu,  6 Mar 2025 13:51:31 +0200
Message-ID: <d0e095f9a7601437acc2d2fdf8705136d1edf1c5.1741261611.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741261611.git.leon@kernel.org>
References: <cover.1741261611.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Add an explanation on the newly added UCAP API.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 Documentation/infiniband/index.rst |  1 +
 Documentation/infiniband/ucaps.rst | 71 ++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/infiniband/ucaps.rst

diff --git a/Documentation/infiniband/index.rst b/Documentation/infiniband/index.rst
index 9cd7615438b9..5b4c24125f66 100644
--- a/Documentation/infiniband/index.rst
+++ b/Documentation/infiniband/index.rst
@@ -12,6 +12,7 @@ InfiniBand
    opa_vnic
    sysfs
    tag_matching
+   ucaps
    user_mad
    user_verbs
 
diff --git a/Documentation/infiniband/ucaps.rst b/Documentation/infiniband/ucaps.rst
new file mode 100644
index 000000000000..b8b6927742f4
--- /dev/null
+++ b/Documentation/infiniband/ucaps.rst
@@ -0,0 +1,71 @@
+=================================
+Infiniband Userspace Capabilities
+=================================
+
+   User CAPabilities (UCAPs) provide fine-grained control over specific
+   firmware features in Infiniband (IB) devices. This approach offers
+   more granular capabilities than the existing Linux capabilities,
+   which may be too generic for certain FW features.
+
+   Each user capability is represented as a character device with root
+   read-write access. Root processes can grant users special privileges
+   by allowing access to these character devices (e.g., using chown).
+
+Usage
+=====
+
+   UCAPs allow control over specific features of an IB device using file
+   descriptors of UCAP character devices. Here is how a user enables
+   specific features of an IB device:
+
+      * A root process grants the user access to the UCAP files that
+        represents the capabilities (e.g., using chown).
+      * The user opens the UCAP files, obtaining file descriptors.
+      * When opening an IB device, include an array of the UCAP file
+        descriptors as an attribute.
+      * The ib_uverbs driver recognizes the UCAP file descriptors and enables
+        the corresponding capabilities for the IB device.
+
+Creating UCAPs
+==============
+
+   To create a new UCAP, drivers must first define a type in the
+   rdma_user_cap enum in rdma/ib_ucaps.h. The name of the UCAP character
+   device should be added to the ucap_names array in
+   drivers/infiniband/core/ucaps.c. Then, the driver can create the UCAP
+   character device by calling the ib_create_ucap API with the UCAP
+   type.
+
+   A reference count is stored for each UCAP to track creations and
+   removals of the UCAP device. If multiple creation calls are made with
+   the same type (e.g., for two IB devices), the UCAP character device
+   is created during the first call and subsequent calls increment the
+   reference count.
+
+   The UCAP character device is created under /dev/infiniband, and its
+   permissions are set to allow root read and write access only.
+
+Removing UCAPs
+==============
+
+   Each removal decrements the reference count of the UCAP. The UCAP
+   character device is removed from the filesystem only when the
+   reference count is decreased to 0.
+
+/dev and /sys/class files
+=========================
+
+   The class::
+
+      /sys/class/infiniband_ucaps
+
+   is created when the first UCAP character device is created.
+
+   The UCAP character device is created under /dev/infiniband.
+
+   For example, if mlx5_ib adds the rdma_user_cap
+   RDMA_UCAP_MLX5_CTRL_LOCAL with name "mlx5_perm_ctrl_local", this will
+   create the device node::
+
+      /dev/infiniband/mlx5_perm_ctrl_local
+
-- 
2.48.1


