Return-Path: <linux-rdma+bounces-15920-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNDIHsM4c2l/tQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15920-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 10:00:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EF172E31
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 10:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63E15304AAC6
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5DE354AD4;
	Fri, 23 Jan 2026 08:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UH0AJJLf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752543370FE;
	Fri, 23 Jan 2026 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158734; cv=none; b=XRRky47t7CKdUPfI7r/WiuGfuIeIs1XKUZSRcwASt819pJlRarha4PUgvmfc5HRn2B44A/YvmhJT8qHuJSQffUeuu+lcJOIPhhIz72A+rA58f4vHLJITIeQ/HGv/wXhkAJjTk76qYVJtIfE2foOKf6VbgHSFKoCw8Z46CeVZX0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158734; c=relaxed/simple;
	bh=FQk32BMzHESc1g+auuhE1AY09RGLD+GUzhW85HGfTDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GQepOXbA7O+U9j+wF7zvxk6nyPSkv04H2D4Sop1w+G1jeQO17S9QtS4HTdqAtfJRZXZEEqsM9O4xkYYFSMnhNS65deI0tQ9aR2G5D39kRto64zKj6tFHenrjsuv+mF/uYqeQD0YTk/v+2c56IOHrNueKcc+scMI0r4ubk4EyDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UH0AJJLf; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3Q
	9PIHHsmNzz5nXOAMH+AINGqxXgNMHvUZUnjZZ5X0U=; b=UH0AJJLfVGfqLO9OXM
	kIZL8rLVIE7y3AHZ1vq1F//w3rHvdY7xsGmOyBfUpHa7dk8GGIF8Pfi1f3/zs4hv
	z7XK3DcoVQDML3Bap2i41z4Qq7H6xU0QSO+5qKroQBnMlQ++EEZ/bzc84QB3mUeA
	W+dBHDxm7teiOqOZtrHLmhuqI=
Received: from zengchi (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBHsLcOOHNpG8j6HQ--.35229S2;
	Fri, 23 Jan 2026 16:57:51 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	feliu@nvidia.com,
	parav@nvidia.com,
	witu@nvidia.com,
	ajayachandra@nvidia.com
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zeng Chi <zengchi@kylinos.cn>
Subject: [PATCH v3 net] net/mlx5: Fix return type mismatch in mlx5_esw_vport_vhca_id()
Date: Fri, 23 Jan 2026 16:57:49 +0800
Message-Id: <20260123085749.1401969-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHsLcOOHNpG8j6HQ--.35229S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr43JrWDCrW5uFWfury5twb_yoW8XF4xp3
	yUGryxZFyktFWUXw4UWayrX3yrCayUK3y29F4Sk3WSqr1ktFWUtrn5KFZruF1DCrWUGr98
	trs7Z3s5Zas8Aa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaHq7UUUUU=
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbC6A9IBGlzOA-wWwAA3t
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15920-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zeng_chi911@163.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,nvidia.com:email]
X-Rspamd-Queue-Id: 24EF172E31
X-Rspamd-Action: no action

From: Zeng Chi <zengchi@kylinos.cn>

The function mlx5_esw_vport_vhca_id() is declared to return bool,
but returns -EOPNOTSUPP (-45), which is an int error code. This
causes a signedness bug as reported by smatch.

This patch fixes this smatch report:
drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:981 mlx5_esw_vport_vhca_id()
warn: signedness bug returning '(-45)'

Fixes: 1baf30426553 ("net/mlx5: E-Switch, Set/Query hca cap via vhca id")
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
v2 -> v3:
- Shortened the commit ID in the `Fixes:` tag to 12 characters as suggested.
- Added a `Reviewed-by:` tag from Parav Pandit <parav@nvidia.com>.

v2:Added the required Fixes tag and specified target branch net in subject prefix
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index ad1073f7b79f..e7fe43799b23 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -1009,7 +1009,7 @@ mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev)
 static inline bool
 mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
 {
-	return -EOPNOTSUPP;
+	return false;
 }
 
 #endif /* CONFIG_MLX5_ESWITCH */
-- 
2.25.1


