Return-Path: <linux-rdma+bounces-18829-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOb6DlRiy2nCHAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18829-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 07:57:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E5364468
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 07:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 348C33061231
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 05:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE62371D0F;
	Tue, 31 Mar 2026 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQB++NZ7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26307371888;
	Tue, 31 Mar 2026 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936618; cv=none; b=f+P9b2hsVmMA/nfCdjp43vNPwczC7UpV9piATV+k55sDV6Gnmg37YnVV14YqLR0XQCfTIQAryKzVxBHCy0wntrW0HHVnpqzK9BV9xv3Nk6vYye8otd5rbGKLMdM5+h4scyNWMzksBuGv5foG8R0B/82aHHJFDUxwVtgCPwCLSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936618; c=relaxed/simple;
	bh=5k4T59VFMXQz4OG6JuaoBzpu2XM/Crd28cH9bMwomqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KofVrVJ3RmeAAKDdBXqT7/bdgyaEXvQzpOz3ZA5oZ7VByaSPj5ocJRYs8Lla3gCNIkyFlwRukV/5eagX7VxLF9btmGnW3uP2wQhoB9vieBMSgdRnw99bNoruE3tTkUF0aAFANFMk2ujro9n0YMVPwtfNlEj9+ZoAbqvf3UrDBi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQB++NZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09719C19423;
	Tue, 31 Mar 2026 05:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774936617;
	bh=5k4T59VFMXQz4OG6JuaoBzpu2XM/Crd28cH9bMwomqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQB++NZ7favTt7zBJAmAee27yfICYaVMXGS3znVvRwI+zSm4HOdxscrw/IoIqHWfR
	 PjkZXfY2urp0+wtffL5e8OgaHdqH+we7dT73ogipnwzkUs4im9hG/8gEDDX5T7fcoC
	 Tq9F8lVpgMJlwW5LuUatq1ZPi7MBY9XUOU5UGklFGMogahi61m1X4XLlq7w1BuA/eo
	 cc0xKcYlHgzMOS/8c25bHpjhDqu2wHNOZQbHYcVqsEQkeqZpbzOBrJ+7ZYdAu87opO
	 vadPPXXxliFaLMBwqwVDrSbkT78BbcKtL+NrpaojzcxTucsctkZtzTdQf48jOK8WDZ
	 ffBnqz9lggytQ==
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
	Maher Sanalla <msanalla@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 4/4] fwctl/mlx5: Externally validate FW commands supplied in fwctl
Date: Tue, 31 Mar 2026 08:56:36 +0300
Message-ID: <20260331-fw-lsm-hook-v2-4-78504703df1f@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18829-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,ziepe.ca,nvidia.com,intel.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,huawei.com:email]
X-Rspamd-Queue-Id: B23E5364468
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chiara Meiohas <cmeiohas@nvidia.com>

fwctl is subsystem which exposes a firmware interface directly to
userspace: it allows userspace to send device specific command
buffers to firmware. fwctl is focused on debugging, configuration
and provisioning of the device.

Call bpf_lsm_fw_validate_cmd() before dispatching the user-provided
firmware command.

This allows BPF programs to implement custom policies and enforce
per-command security policy on user-triggered firmware commands.
For example, a BPF program could filter firmware commands based on
their opcode.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/fwctl/mlx5/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
index e86ab703c767a..c49dfa1d172d9 100644
--- a/drivers/fwctl/mlx5/main.c
+++ b/drivers/fwctl/mlx5/main.c
@@ -7,6 +7,7 @@
 #include <linux/mlx5/device.h>
 #include <linux/mlx5/driver.h>
 #include <uapi/fwctl/mlx5.h>
+#include <linux/bpf_lsm.h>
 
 #define mlx5ctl_err(mcdev, format, ...) \
 	dev_err(&mcdev->fwctl.dev, format, ##__VA_ARGS__)
@@ -324,6 +325,15 @@ static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 	if (!mlx5ctl_validate_rpc(rpc_in, scope))
 		return ERR_PTR(-EBADMSG);
 
+	/* Enforce the user context for the command */
+	MLX5_SET(mbox_in_hdr, rpc_in, uid, mfd->uctx_uid);
+
+	ret = bpf_lsm_fw_validate_cmd(rpc_in, in_len, &mcdev->fwctl.dev,
+				      FW_CMD_CLASS_FWCTL,
+				      FWCTL_DEVICE_TYPE_MLX5);
+	if (ret)
+		return ERR_PTR(ret);
+
 	/*
 	 * mlx5_cmd_do() copies the input message to its own buffer before
 	 * executing it, so we can reuse the allocation for the output.
@@ -336,8 +346,6 @@ static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 			return ERR_PTR(-ENOMEM);
 	}
 
-	/* Enforce the user context for the command */
-	MLX5_SET(mbox_in_hdr, rpc_in, uid, mfd->uctx_uid);
 	ret = mlx5_cmd_do(mcdev->mdev, rpc_in, in_len, rpc_out, *out_len);
 
 	mlx5ctl_dbg(mcdev,

-- 
2.53.0


