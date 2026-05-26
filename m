Return-Path: <linux-rdma+bounces-21328-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIFOOFbNFWoTcAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21328-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 18:41:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B05D9E3D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 18:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D380303EB4F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521053C4B93;
	Tue, 26 May 2026 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="im8YdLB8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1D93BE148;
	Tue, 26 May 2026 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813065; cv=none; b=mNHlSdilfMhN8PteGctTwCdneYDlGdQZZcpg6Nshg9LSpFylkV0pE3FhX3HJC6q45AQBpsQTM7NfTXg6lVDu29uesWl+9XDbLfB3AKfn/4b8tdvCoGD7NOZWDEVpCZSeupRtqtaDupH2FXIvuIeYGb2YupKfYwTQWfQx/mo+Amk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813065; c=relaxed/simple;
	bh=7YZG23Q0QJExLFWGYqyYWFw8aKlagL3CAudyZWaiQOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YbmcXMB4/Z6zCqCor27QlPD/FzRL/vXiVgoDV9JTSa/h/wXc6pvtt2SQsqkpAgXyYV6bHXytiuveFH8oK5FvbfAV36M2HoUrafQt+zn0tyfYETrvaoYW/81xM2flynUQ/lXOdAsEfpTJCcJa7+D0OwzyK9otGNzV3wpvWym85eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=im8YdLB8; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:2925:0:640:1f39:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2732EC01E3;
	Tue, 26 May 2026 19:29:37 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6bf:8080:55d::1:17])
	by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA id WTbmR30Zt8c0-XsZCDkwb;
	Tue, 26 May 2026 19:29:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1779812976;
	bh=vMxqjVjH/KMjgLnBSkG2B5yEATGmO4WjmZ/nnAZL9+0=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=im8YdLB8AEfpg2pXbcCtYvzQhiHq5GJYXOK0MMkJ9SPyQy3mON3v+GXWo3AYyBmU6
	 OtGeI/unHnyA3ClNhHKwR+Xyr7iIuDpQrovu5svAu8wr/6Np1lP5QKym9e0xDgS79N
	 asb+pUAjQ6m1bq2q7WhR+mD4tZbkF2zGWrTVpCAU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Akiva Goldberger <agoldberger@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>,
	stable@vger.kernel.org
Subject: [PATCH] net/mlx5: Reorder completion before putting command entry in cmd_work_handler
Date: Tue, 26 May 2026 19:29:32 +0300
Message-Id: <20260526162932.501584-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21328-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kniv@yandex-team.ru,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,yandex-team.ru:email,yandex-team.ru:mid,yandex-team.ru:dkim]
X-Rspamd-Queue-Id: DE2B05D9E3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Assuming callback != NULL && !page_queue, cmd_work_handler takes
command entry with refcnt == 1 from mlx5_cmd_invoke.
If either semaphore timeout or index allocation error happens,
it does final cmd_ent_put(ent). To avoid access to freed memory,
notify slotted completion before cmd_ent_put.

This is theoretical issue found by Svace static analyser.

Cc: stable@vger.kernel.org
Fixes: 485d65e135712 ("net/mlx5: Add a timeout to acquire the command queue semaphore")
Fixes: 0e2909c6bec90 ("net/mlx5: Fix variable not being completed when function returns")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index c89417c1a1f9..e2895972cc82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1002,12 +1002,13 @@ static void cmd_work_handler(struct work_struct *work)
 				ent->callback(-EBUSY, ent->context);
 				mlx5_free_cmd_msg(dev, ent->out);
 				free_msg(dev, ent->in);
+				complete(&ent->slotted);
 				cmd_ent_put(ent);
 			} else {
 				ent->ret = -EBUSY;
 				complete(&ent->done);
+				complete(&ent->slotted);
 			}
-			complete(&ent->slotted);
 			return;
 		}
 		alloc_ret = cmd_alloc_index(cmd, ent);
@@ -1017,13 +1018,14 @@ static void cmd_work_handler(struct work_struct *work)
 				ent->callback(-EAGAIN, ent->context);
 				mlx5_free_cmd_msg(dev, ent->out);
 				free_msg(dev, ent->in);
+				complete(&ent->slotted);
 				cmd_ent_put(ent);
 			} else {
 				ent->ret = -EAGAIN;
 				complete(&ent->done);
+				complete(&ent->slotted);
 			}
 			up(&cmd->vars.sem);
-			complete(&ent->slotted);
 			return;
 		}
 	} else {
-- 
2.34.1


