Return-Path: <linux-rdma+bounces-18827-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFBZCHFiy2nCHAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18827-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 07:58:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FC136447E
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 07:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D965F306B192
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 05:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47906371889;
	Tue, 31 Mar 2026 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3BkhowZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB1370D41;
	Tue, 31 Mar 2026 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936611; cv=none; b=RKy+/ASTPHAUnUNw00mJwlmc2b85RK/z4Dy6QDefetTA2e8w5+wikii3/XCFYbGbNqpd51uwzj3XoaAYShsWXd+Slae4iLnj24mt3ctee3DWebTPymtAuPSuqtvxg+12t9W/32OWgWF1Qin6ghleENCRMGyFVF7RPejd3A/kpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936611; c=relaxed/simple;
	bh=TVEuGbcfHGfDo71N8+nkdQbDv4dUqR/rzcqGcfeN0ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5xQ8aUH7QXMy1U2Vbn9jKQr04i8bP6+uN7SlAnQioyXjllFojV/qaeYPWqRwMRG+xtukl37OxH6pf8+ZqPok/NLlj02Ymxq3SAe2OEqGvFEz/ij7hgeFZD/lLhHTsL8TmY+RzWLOMse0zpRrNL8es1LtYaBO2UvK2vY+scx9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3BkhowZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8638C19423;
	Tue, 31 Mar 2026 05:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774936610;
	bh=TVEuGbcfHGfDo71N8+nkdQbDv4dUqR/rzcqGcfeN0ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3BkhowZcNR4BZl7MGNRtnmYLaUXC9NpHSiB8fdoYtWvfaJvCJa2I08aDDVnCgs1g
	 JmSBhKNNR+8lszsK0rvch5LvYps9zl4Jj7i4UY/nqEFgoWdNkJdSlDb+NexTo/YgHJ
	 D9+8sQRlTkXYpGBrjmy+IkxBWTf8f0KUG9gArYHvGIEmRnyQAAUcrEFH/ijwj90CTI
	 bQYG4T6KSBOXmhT79AbGQRNhOj4ttaGtB90PsEKACL8RdAbBcmk7UrnrL5cQdWyMzx
	 RD5Qdl/+EfsVUI7DHJ5Ad4PylKXv39VnBHKRAFNDWi4U1Pws2D4unIRpqh1qOMr1S3
	 97k9yHc+YQLSw==
From: Leon Romanovsky <leon@kernel.org>
To: KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH v2 1/4] bpf: add firmware command validation hook
Date: Tue, 31 Mar 2026 08:56:33 +0300
Message-ID: <20260331-fw-lsm-hook-v2-1-78504703df1f@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18827-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,ziepe.ca,nvidia.com,intel.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98FC136447E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chiara Meiohas <cmeiohas@nvidia.com>

Drivers communicate with device firmware either via register-based
commands (writing parameters into device registers) or by passing
a command buffer using shared-memory mechanisms.

The proposed fw_validate_cmd hook is intended for the command buffer
mechanism, which is commonly used on modern, complex devices.

This hook allows inspecting firmware command buffers before they are
sent to the device.
The hook receives the command buffer, device, command class, and a
class-specific id:
  - class_id (enum fw_cmd_class) allows BPF programs to
    differentiate between classes of firmware commands.
    In this series, class_id distinguishes between commands from the
    RDMA uverbs interface and from fwctl.
  - id is a class-specific device identifier. For uverbs, id is the
    RDMA driver identifier (enum rdma_driver_id). For fwctl, id is the
    device type (enum fwctl_device_type).

The mailbox format varies across vendors and may even differ between
firmware versions, so policy authors must be familiar with the
specific device's mailbox format. BPF programs can be tailored to
inspect the mailbox accordingly, making BPF the natural fit.
Therefore, the hook is defined using the LSM_HOOK macro in bpf_lsm.c
rather than in lsm_hook_defs.h, as it is a BPF-only hook.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/bpf_lsm.h | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/bpf_lsm.c    | 11 +++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 643809cc78c33..7ad7e153f486c 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -12,6 +12,21 @@
 #include <linux/bpf_verifier.h>
 #include <linux/lsm_hooks.h>
 
+struct device;
+
+/**
+ * enum fw_cmd_class - Class of the firmware command passed to
+ * bpf_lsm_fw_validate_cmd.
+ * This allows BPF programs to distinguish between different command classes.
+ *
+ * @FW_CMD_CLASS_UVERBS: Command originated from the RDMA uverbs interface
+ * @FW_CMD_CLASS_FWCTL: Command originated from the fwctl interface
+ */
+enum fw_cmd_class {
+	FW_CMD_CLASS_UVERBS,
+	FW_CMD_CLASS_FWCTL,
+};
+
 #ifdef CONFIG_BPF_LSM
 
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
@@ -53,6 +68,24 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
 int bpf_remove_dentry_xattr_locked(struct dentry *dentry, const char *name__str);
 bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog);
 
+/**
+ * bpf_lsm_fw_validate_cmd() - Validate a firmware command
+ * @in: pointer to the firmware command input buffer
+ * @in_len: length of the firmware command input buffer
+ * @dev: device associated with the command
+ * @class_id: class of the firmware command
+ * @id: device identifier, specific to the command @class_id
+ *
+ * Check permissions before sending a firmware command generated by
+ * userspace to the device.
+ *
+ * Return: Returns 0 if permission is granted, or a negative errno
+ * value to deny the operation.
+ */
+int bpf_lsm_fw_validate_cmd(const void *in, size_t in_len,
+			    const struct device *dev,
+			    enum fw_cmd_class class_id, u32 id);
+
 #else /* !CONFIG_BPF_LSM */
 
 static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
@@ -104,6 +137,14 @@ static inline bool bpf_lsm_has_d_inode_locked(const struct bpf_prog *prog)
 {
 	return false;
 }
+
+static inline int bpf_lsm_fw_validate_cmd(const void *in, size_t in_len,
+					  const struct device *dev,
+					  enum fw_cmd_class class_id, u32 id)
+{
+	return 0;
+}
+
 #endif /* CONFIG_BPF_LSM */
 
 #endif /* _LINUX_BPF_LSM_H */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 0c4a0c8e6f703..fbdc056995fee 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -28,12 +28,23 @@ __weak noinline RET bpf_lsm_##NAME(__VA_ARGS__)	\
 }
 
 #include <linux/lsm_hook_defs.h>
+
+/*
+ * fw_validate_cmd is not in lsm_hook_defs.h because it is a BPF-only
+ * hook — mailbox formats are device-specific, making BPF the natural
+ * fit for inspection.
+ */
+LSM_HOOK(int, 0, fw_validate_cmd, const void *in, size_t in_len,
+	 const struct device *dev, enum fw_cmd_class class_id, u32 id)
+EXPORT_SYMBOL_GPL(bpf_lsm_fw_validate_cmd);
+
 #undef LSM_HOOK
 
 #define LSM_HOOK(RET, DEFAULT, NAME, ...) BTF_ID(func, bpf_lsm_##NAME)
 BTF_SET_START(bpf_lsm_hooks)
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
+BTF_ID(func, bpf_lsm_fw_validate_cmd)
 BTF_SET_END(bpf_lsm_hooks)
 
 BTF_SET_START(bpf_lsm_disabled_hooks)

-- 
2.53.0


