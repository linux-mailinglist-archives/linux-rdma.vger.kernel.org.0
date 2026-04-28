Return-Path: <linux-rdma+bounces-19688-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A7/LIf38GkpbgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19688-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 20:08:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF9E48A6FC
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 20:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 503DC30DA179
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 18:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF7C45BD4B;
	Tue, 28 Apr 2026 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGw7uSwh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB6453498;
	Tue, 28 Apr 2026 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399457; cv=none; b=mioD+Pvbl+jTeyvsinf+r0s6A0obWqhkr5SXqELO+e+5bh6SXmU5Dzle5Xo0sKrp6cmvGFptzeehBpA+fUNT3GuDrcouxtxEA1+ly1qPxy8qpxelRJCr6lWxjCmTVnlx87HuIWe3ISHuMFazLpJulr0ykxJR7ipcb3AtLBIHEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399457; c=relaxed/simple;
	bh=GWFtmM9Hu2ib2uf29Mr0N4GV7xJ0c7rxZc4+BWOCe/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qqodq5D1pthGb7rxGA03HIMJb4zc6o5OLqXOebdB0Uf1A9mK8BB3/KvlDGM1DaRq3TTvJ/6bN8svd3HwqZfBqfBX9tbLKdPYiYgGVaOND4eJPAZvgLR9MJJTE5y1rz7Ba98V28u0nFtVMpiNgyEXQ0QXk3eXiyHgNoHmx//ABcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGw7uSwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70F0CC2BCAF;
	Tue, 28 Apr 2026 18:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777399457;
	bh=GWFtmM9Hu2ib2uf29Mr0N4GV7xJ0c7rxZc4+BWOCe/o=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=sGw7uSwhihpTRi6QNL+6b0QWmHQ4/GaHfP1v5IUr3yyYuLQR9r+V8RBAy7X2MQRAb
	 i2XzE1Vni4dRhNSpp6OO1lQ4N5kNnpnJTKLmzbxmCIynb2IyHZ25++e/WxRKUIjBSc
	 7N7K18OJqLLsIUOiMs22Ekt72ouH+lIYy0T+4SiIbC1yG+KlJcPaoIZl51SYe+JHND
	 gHL+P9mKPyxkBcE6XcvBvDljd+RfKE8jDrCBbHn6Q/kAPqIEcC5pnkLMhz2C194a1m
	 HNpdQmBzIXPmCF+jGvM4eX3kA5Ol5pImcz3eQFIwK5Rb4N9F4NiWJ8YNNcmSf1CwWG
	 fvKaw6P4DR2bw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D77FF886F;
	Tue, 28 Apr 2026 18:04:17 +0000 (UTC)
From: Max Boone via B4 Relay <devnull+mboone.akamai.com@kernel.org>
Date: Tue, 28 Apr 2026 20:04:14 +0200
Subject: [PATCH RFC] net/mlx5: check whether VFs are assigned before
 disabling SR-IOV
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-mlx5-sriov-in-use-check-v1-1-c7b9e18c99a8@akamai.com>
X-B4-Tracking: v=1; b=H4sIAJ328GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyML3dycClPd4qLM/DLdzDzd0uJU3eSM1ORsXdPkZKNEc0szY4tUUyW
 g7oKi1LTMCrDJ0UpBbs5KsbW1AJ6bm0JuAAAA
X-Change-ID: 20260428-mlx5-sriov-in-use-check-5cc2a79638e5
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Max Boone <mboone@akamai.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777399456; l=2829;
 i=mboone@akamai.com; s=20260317; h=from:subject:message-id;
 bh=mkoemVwnFGeOEz/ltYOEqOoOvjAbOxb3nCL6rP2fq0E=;
 b=qNoCEt363xktAl0UM2/HTfSVD15+he3s20EebK4zJcoEOpu59TRij4kCh+lLpVYSY5atEaNhv
 kWtbH5x890kBoEI1Sh6QFWpveUcp1GkIJIRsvpm7AxTX1Qy5UvVvxTP
X-Developer-Key: i=mboone@akamai.com; a=ed25519;
 pk=jWdC/h5H2KWQCiC2kpr/puMVX0mJmP9W5sM8YTGBXA4=
X-Endpoint-Received: by B4 Relay for mboone@akamai.com/20260317 with
 auth_id=685
X-Original-From: Max Boone <mboone@akamai.com>
Reply-To: mboone@akamai.com
X-Rspamd-Queue-Id: 1EF9E48A6FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19688-lists,linux-rdma=lfdr.de,mboone.akamai.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-rdma@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	HAS_REPLYTO(0.00)[mboone@akamai.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,akamai.com:replyto,akamai.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Max Boone <mboone@akamai.com>

When MLX5 cards are passed through to a VM, disabling SR-IOV by
setting the sriov_numvfs to 0 will render the machine unstable.

Other drivers (such as ixgbe, bnxt and octep) add this check to
see whether the VFs are passed through to a VM.

Signed-off-by: Max Boone <mboone@akamai.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c     | 11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 1507e881d..85fe89c00 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -240,7 +240,7 @@ void mlx5_sriov_cleanup(struct mlx5_core_dev *dev);
 int mlx5_sriov_attach(struct mlx5_core_dev *dev);
 void mlx5_sriov_detach(struct mlx5_core_dev *dev);
 int mlx5_core_sriov_configure(struct pci_dev *dev, int num_vfs);
-void mlx5_sriov_disable(struct pci_dev *pdev, bool num_vf_change);
+int mlx5_sriov_disable(struct pci_dev *pdev, bool num_vf_change);
 int mlx5_core_sriov_set_msix_vec_count(struct pci_dev *vf, int msix_vec_count);
 int mlx5_core_enable_hca(struct mlx5_core_dev *dev, u16 func_id);
 int mlx5_core_disable_hca(struct mlx5_core_dev *dev, u16 func_id);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
index bf6f631cf..07c61a73b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
@@ -200,16 +200,23 @@ static int mlx5_sriov_enable(struct pci_dev *pdev, int num_vfs)
 	return err;
 }
 
-void mlx5_sriov_disable(struct pci_dev *pdev, bool num_vf_change)
+int mlx5_sriov_disable(struct pci_dev *pdev, bool num_vf_change)
 {
 	struct mlx5_core_dev *dev  = pci_get_drvdata(pdev);
 	struct devlink *devlink = priv_to_devlink(dev);
 	int num_vfs = pci_num_vf(dev->pdev);
 
+	if (pci_vfs_assigned(dev->pdev)) {
+		mlx5_core_warn(dev, "can't disable sriov, VFs are assigned\n");
+		return -EPERM;
+	}
+
 	pci_disable_sriov(pdev);
 	devl_lock(devlink);
 	mlx5_device_disable_sriov(dev, num_vfs, true, num_vf_change);
 	devl_unlock(devlink);
+
+	return 0;
 }
 
 int mlx5_core_sriov_configure(struct pci_dev *pdev, int num_vfs)
@@ -223,7 +230,7 @@ int mlx5_core_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	if (num_vfs)
 		err = mlx5_sriov_enable(pdev, num_vfs);
 	else
-		mlx5_sriov_disable(pdev, true);
+		err = mlx5_sriov_disable(pdev, true);
 
 	if (!err)
 		sriov->num_vfs = num_vfs;

---
base-commit: dca922e019dd758b4c1b4bec8f1d509efddeaab4
change-id: 20260428-mlx5-sriov-in-use-check-5cc2a79638e5

Best regards,
-- 
Max Boone <mboone@akamai.com>



