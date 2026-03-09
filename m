Return-Path: <linux-rdma+bounces-17773-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN0CNAGtrmntHQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17773-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 12:20:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B9D237CBB
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 12:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46684306145B
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 11:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4E393DCC;
	Mon,  9 Mar 2026 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOPvBKEx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7D3939D2;
	Mon,  9 Mar 2026 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054931; cv=none; b=M1S7ZHUX/nT3EjJIroqGft/V/YhcecxfSzzH3Huq7sQO0oUmyy2qp2fzRz1V4S+9C4CfMKujPZkcvQQhx3TSUw6u/7G1Jpud8uaaG69QlUqbMJZxGlss1JwNM6fCByxv3/nObk6ZMkAsSbodmboAMPBKUEkIt560rkhaEEQQRoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054931; c=relaxed/simple;
	bh=PoqZDprkyG97xhHd0xAhB5NUCone+g6NoPGHHatVjlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=li5SRQR9t8JVP3uFic/HGsaxG8qmS13r0P6taZd/gh1kR2rQoc1gOgclENHyLlqxL8309i/Ue4NCkEIq5AKiyCBOXcbKqM0EAUUGgTcy3LccmfuXWtKBQSAfwIby9L3gpleG4MWy3l9RE5ok+0dwa3yr5JtefghisaY3aH65EPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOPvBKEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C44C2BC9E;
	Mon,  9 Mar 2026 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773054931;
	bh=PoqZDprkyG97xhHd0xAhB5NUCone+g6NoPGHHatVjlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOPvBKExj/tOZiQXJCY0WqA337vztYbTXpIv6XkFbKvDgxbn3Us5XcAgKPmIZdzgO
	 PQXKGbwhe3nT0ymhLQZWEvbdghOrMl2myltS2Slk43BMSODmqJgYWlDe3Spb/wuLkH
	 yVVJpauYglzEXR8yoB49+w4VeNeLQQT/FYXOz4yRPTc43alOlGW42TYXTKJYWJ2I7L
	 jkf4C+v35lYIxitbZpdo1tgMlO/ILy4i5xZylCLVilBds71Bb5rxGsFfYgiO5hSL51
	 X7tNwqHwUeXa4r2G8UIYq+bAAwWr/kSIKHAlEzGEZ2vjGLGB69DGt/8LvpgyydrJkg
	 aKIFdJqk8fxbA==
From: Leon Romanovsky <leon@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: [PATCH 1/3] lsm: add hook for firmware command validation
Date: Mon,  9 Mar 2026 13:15:18 +0200
Message-ID: <20260309-fw-lsm-hook-v1-1-4a6422e63725@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 62B9D237CBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17773-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.927];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Chiara Meiohas <cmeiohas@nvidia.com>=0D
=0D
Drivers typically communicate with device firmware either via=0D
register-based commands (writing parameters into device registers)=0D
or by passing a command buffer using shared-memory mechanisms.=0D
=0D
This hook targets the command buffer mechanism, which is commonly=0D
used on modern, complex devices.=0D
=0D
Add the LSM hook fw_validate_cmd. This hook allows inspecting=0D
firmware command buffers before they are sent to the device.=0D
The hook receives the command buffer, device, command class, and a=0D
class-specific id:=0D
  - class_id (enum fw_cmd_class) allows security modules to=0D
    differentiate between classes of firmware commands.=0D
    In this series, class_id distinguishes between commands from the=0D
    RDMA uverbs interface and from fwctl.=0D
  - id is a class-specific device identifier. For uverbs, id is the=0D
    RDMA driver identifier (enum rdma_driver_id). For fwctl, id is the=0D
    device type (enum fwctl_device_type).=0D
=0D
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>=0D
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>=0D
Signed-off-by: Edward Srouji <edwards@nvidia.com>=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 include/linux/lsm_hook_defs.h |  2 ++=0D
 include/linux/security.h      | 25 +++++++++++++++++++++++++=0D
 security/security.c           | 26 ++++++++++++++++++++++++++=0D
 3 files changed, 53 insertions(+)=0D
=0D
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h=
=0D
index 8c42b4bde09c0..93da090384ea1 100644=0D
--- a/include/linux/lsm_hook_defs.h=0D
+++ b/include/linux/lsm_hook_defs.h=0D
@@ -445,6 +445,8 @@ LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_to=
ken *token, int cap)=0D
 #endif /* CONFIG_BPF_SYSCALL */=0D
 =0D
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)=0D
+LSM_HOOK(int, 0, fw_validate_cmd, const void *in, size_t in_len,=0D
+	 const struct device *dev, enum fw_cmd_class class_id, u32 id)=0D
 =0D
 #ifdef CONFIG_PERF_EVENTS=0D
 LSM_HOOK(int, 0, perf_event_open, int type)=0D
diff --git a/include/linux/security.h b/include/linux/security.h=0D
index 83a646d72f6f8..64786d013207a 100644=0D
--- a/include/linux/security.h=0D
+++ b/include/linux/security.h=0D
@@ -67,6 +67,7 @@ enum fs_value_type;=0D
 struct watch;=0D
 struct watch_notification;=0D
 struct lsm_ctx;=0D
+struct device;=0D
 =0D
 /* Default (no) options for the capable function */=0D
 #define CAP_OPT_NONE 0x0=0D
@@ -157,6 +158,21 @@ enum lockdown_reason {=0D
 	LOCKDOWN_CONFIDENTIALITY_MAX,=0D
 };=0D
 =0D
+/*=0D
+ * enum fw_cmd_class - Class of the firmware command passed to=0D
+ * security_fw_validate_cmd.=0D
+ * This allows security modules to distinguish between different command=0D
+ * classes.=0D
+ *=0D
+ * @FW_CMD_CLASS_UVERBS: Command originated from the RDMA uverbs interface=
=0D
+ * @FW_CMD_CLASS_FWCTL: Command originated from the fwctl interface=0D
+ */=0D
+enum fw_cmd_class {=0D
+	FW_CMD_CLASS_UVERBS,=0D
+	FW_CMD_CLASS_FWCTL,=0D
+	FW_CMD_CLASS_MAX,=0D
+};=0D
+=0D
 /*=0D
  * Data exported by the security modules=0D
  */=0D
@@ -575,6 +591,9 @@ int security_inode_notifysecctx(struct inode *inode, vo=
id *ctx, u32 ctxlen);=0D
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)=
;=0D
 int security_inode_getsecctx(struct inode *inode, struct lsm_context *cp);=
=0D
 int security_locked_down(enum lockdown_reason what);=0D
+int security_fw_validate_cmd(const void *in, size_t in_len,=0D
+			     const struct device *dev,=0D
+			     enum fw_cmd_class class_id, u32 id);=0D
 int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,=0D
 		      void *val, size_t val_len, u64 id, u64 flags);=0D
 int security_bdev_alloc(struct block_device *bdev);=0D
@@ -1589,6 +1608,12 @@ static inline int security_locked_down(enum lockdown=
_reason what)=0D
 {=0D
 	return 0;=0D
 }=0D
+static inline int security_fw_validate_cmd(const void *in, size_t in_len,=
=0D
+					   const struct device *dev,=0D
+					   enum fw_cmd_class class_id, u32 id)=0D
+{=0D
+	return 0;=0D
+}=0D
 static inline int lsm_fill_user_ctx(struct lsm_ctx __user *uctx,=0D
 				    u32 *uctx_len, void *val, size_t val_len,=0D
 				    u64 id, u64 flags)=0D
diff --git a/security/security.c b/security/security.c=0D
index 67af9228c4e94..d05941fe89a48 100644=0D
--- a/security/security.c=0D
+++ b/security/security.c=0D
@@ -5373,6 +5373,32 @@ int security_locked_down(enum lockdown_reason what)=
=0D
 }=0D
 EXPORT_SYMBOL(security_locked_down);=0D
 =0D
+/**=0D
+ * security_fw_validate_cmd() - Validate a firmware command=0D
+ * @in: pointer to the firmware command input buffer=0D
+ * @in_len: length of the firmware command input buffer=0D
+ * @dev: device associated with the command=0D
+ * @class_id: class of the firmware command=0D
+ * @id: device identifier, specific to the command @class_id=0D
+ *=0D
+ * Check permissions before sending a firmware command generated by=0D
+ * userspace to the device.=0D
+ *=0D
+ * Return: Returns 0 if permission is granted.=0D
+ */=0D
+int security_fw_validate_cmd(const void *in, size_t in_len,=0D
+			     const struct device *dev,=0D
+			     enum fw_cmd_class class_id,=0D
+			     u32 id)=0D
+{=0D
+	if (class_id >=3D FW_CMD_CLASS_MAX)=0D
+		return -EINVAL;=0D
+=0D
+	return call_int_hook(fw_validate_cmd, in, in_len,=0D
+			     dev, class_id, id);=0D
+}=0D
+EXPORT_SYMBOL_GPL(security_fw_validate_cmd);=0D
+=0D
 /**=0D
  * security_bdev_alloc() - Allocate a block device LSM blob=0D
  * @bdev: block device=0D
=0D
-- =0D
2.53.0=0D
=0D

