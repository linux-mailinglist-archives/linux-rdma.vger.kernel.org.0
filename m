Return-Path: <linux-rdma+bounces-19957-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHQnJr0Y+Wlc5gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19957-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:07:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F40224C44AA
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C7F330247CA
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 22:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574F937BE7F;
	Mon,  4 May 2026 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mR+z0bc0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185837B402
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932466; cv=none; b=KJRWbL1zkCBATr3TOPvhoCXFXyrPCoBsTAul/dSaBrolZ0v0QiYsNsxlKR3hjCr3Sm/cVs7jKG0r68kDTlnQZ1KKBVuH4T4C2ydFdTO/GsFOkO+rpMPpMuQL29C0hcvL0yzD8hjUtofWGoI8GPzRvvtV4KcDiKoH1sy6lVu8sxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932466; c=relaxed/simple;
	bh=QMnG8lNMPjiWCPP9V8fm1Uvfmgn4efv6jtSMg58pV+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Frhs3r1AyayqPhRnR4Wg+GHfxQMUafH+IaJGjFSPkIrQH2OXF5CoqdsaclOyyCft6jRpeVLaifJOkYkciOWa7jrsYzFuIsvKGXIqfb+s5O7Uqn1uOY0UsX8I1/Mq18bC6zSDAKXwnumoO88tetZpSOE1uug6SCdnWWIU2GbRZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mR+z0bc0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43fe608cb92so2685367f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 15:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777932462; x=1778537262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2EAcQpFApLkE9tQqBTkW5v5GHoiaZ1e/P1wsvwgU1U=;
        b=mR+z0bc0KGVZu/d2HU46TVlE8dsyJn+vwLG3e2eeotorCHZZmJw+QDpY/Dd5DuQO5g
         D/vM8+I7yQLq3Rzx6K9xuIVimsVOyvWfujHtJaK215b0HBgv2R1Y3yDNsvTazs6w72Qz
         kxlKgsuKEHj0fl98wmTMwghNH90vkVRqkihaLoCfeKHiJ6g06OkD5HkyCDpqOjTbhZlg
         tYzRVLlUjy986KzHi5HVM67e42Fin5uBXO7mU1bwJ1HjfY8irmum9lUdWk/IO6+0LhW3
         sckAHxQv0Ven5hWIs1ErV/jQSFDlRfZpwIOsg5b08CmWux9JZzISdtTgzZoh3JXkARhH
         HfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777932462; x=1778537262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2EAcQpFApLkE9tQqBTkW5v5GHoiaZ1e/P1wsvwgU1U=;
        b=VAAzwJJ5zmwW7s2AdjILjJI8wkMPwA6zZbeJyJ8O8gILO2jf7XbdtiC626d0to7PoL
         aDbZZLLNglvj6/RGkeTt8RtIowmjSqi+aUzM2EgiUZzRhn86skPk/15bZ4eUbsD1UMRB
         c6gJSJswfDO9H7UT9tM/6R+q+Gptz4v1IpVuaNF/ocL4kySKCWxztlh/5+fAWoByUy/8
         hfVa8pbnb2SpJ7bjVD/ogem1kiqQ4/hU/BQ7F7aSoROCbYZLvCA1fwBgr69/fJNAMHSW
         7fJb6rwmP4cmnPKugM+iwAc2lRNR9i+NZIJinj4yYVoRCBkeftP/B4KKPEt03rgdFHQJ
         Ew3g==
X-Forwarded-Encrypted: i=1; AFNElJ9b12PsOVo4RkAkPlVZPc3GlfPDB07yowJr3fuEq4zIRwsRWjKHhnSHLZR/DXMF+0F6uCdztZomaCVe@vger.kernel.org
X-Gm-Message-State: AOJu0YwpBhHcuKVujx61Nq0xqWpznEd5qCCMNWpjLw6cFqR7H5Oqf/Wd
	xaUk9T2Zs+vISFFruG5cYf4H3vn4cKCPMYMBwIA3QDIJ/3U1KAbWpYgz
X-Gm-Gg: AeBDiesDcjhH6Di0MsPRtwxZ1kjIpyLYv+N7mnBRj7oICK7v9Ij+b18CFK40ZeJsT4z
	R+PGyOPYUoAjr87iLu41OfgCSlSsMnB0JCclwRNPdG0dONn0HR0ZmuIX3rriw0U7AM+C1GbrrmB
	nsBXwRusRxl5bPvZAIGiy6lMoD1pwQsteMV6XiAD0fulivbFYOxoNdz+S5+aysz6vWzTnQah5mg
	UYai7DOCCEO05IrYpQauNYiv7v+R1izUblS/xT4ndL07xU5dso+tFddzNjt+K0UQBGl1QTmqSf1
	plc25AU942V+hcUg8zB9ir+3+905+ViSVoLUCYFHWJfP6ZH+DjC7BDxkodsgMeSBrHY5cZ+qf+J
	1KRGOBRIt9/osCid3A6DLhviW+WzvhPpwe8+6ZY1Djxkue15j4pnx9yFtwUZAZ7V3lcd8vHg6QE
	Uvign8uLw8oYCmcuDWP8zy5mivOc+o7pejK9LCMM/ISbQDai1HlzsMBhJCqfkTK7FGhRasIxrJ1
	g3hil+UNqfGun3JflptE31ErDakqbqNe+k4D7UEvA==
X-Received: by 2002:a05:6000:18a5:b0:44b:ad5a:cd33 with SMTP id ffacd0b85a97d-44bb66d6302mr18061645f8f.40.1777932462036;
        Mon, 04 May 2026 15:07:42 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4502c011043sm329503f8f.32.2026.05.04.15.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:07:41 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: Moshe Shemesh <moshe@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH net v1] net/mlx5: Fix HWS action unwind NULL dereference
Date: Mon,  4 May 2026 23:06:46 +0100
Message-ID: <20260504220725.46686-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F40224C44AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19957-lists,linux-rdma=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

mlx5_fs_fte_get_hws_actions() stores some destination actions in
fs_actions[] before checking whether action creation succeeded.

If creating a table-number or range destination action fails, or if
fetching a sampler destination action fails, dest_action is NULL but
num_fs_actions has already been incremented. The shared error path then
calls mlx5_fs_destroy_fs_action(), which dereferences fs_action->action
to get the HWS action type, causing a NULL pointer dereference while
unwinding the original failure.

Track whether the current destination action needs fs_actions[] cleanup,
but append it only after dest_action has been validated.

Fixes: 2ec6786ad0a6b ("net/mlx5: fs, add HWS fte API functions")
Fixes: 32e658c84b6d ("net/mlx5: fs, add support for dest flow sampler HWS action")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 .../mellanox/mlx5/core/steering/hws/fs_hws.c     | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index aca77853abb8..fb12513dd83d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -950,6 +950,7 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 			struct mlx5_flow_destination *attr = &dst->dest_attr;
 			bool type_uplink =
 				attr->type == MLX5_FLOW_DESTINATION_TYPE_UPLINK;
+			bool record_fs_action = false;
 
 			if (num_fs_actions == MLX5_FLOW_CONTEXT_ACTION_MAX ||
 			    num_dest_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
@@ -973,11 +974,11 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 					break;
 				dest_action = mlx5_fs_create_dest_action_table_num(fs_ctx,
 										   dst);
-				fs_actions[num_fs_actions++].action = dest_action;
+				record_fs_action = true;
 				break;
 			case MLX5_FLOW_DESTINATION_TYPE_RANGE:
 				dest_action = mlx5_fs_create_dest_action_range(ctx, dst);
-				fs_actions[num_fs_actions++].action = dest_action;
+				record_fs_action = true;
 				break;
 			case MLX5_FLOW_DESTINATION_TYPE_UPLINK:
 			case MLX5_FLOW_DESTINATION_TYPE_VPORT:
@@ -988,9 +989,7 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 				dest_action =
 					mlx5_fs_get_dest_action_sampler(fs_ctx,
 									dst);
-				fs_actions[num_fs_actions].action = dest_action;
-				fs_actions[num_fs_actions++].sampler_id =
-							dst->dest_attr.sampler_id;
+				record_fs_action = true;
 				break;
 			default:
 				err = -EOPNOTSUPP;
@@ -1000,6 +999,13 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 				err = -ENOMEM;
 				goto free_actions;
 			}
+			if (record_fs_action) {
+				fs_actions[num_fs_actions].action = dest_action;
+				if (attr->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_SAMPLER)
+					fs_actions[num_fs_actions].sampler_id =
+								dst->dest_attr.sampler_id;
+				num_fs_actions++;
+			}
 			dest_actions[num_dest_actions++].dest = dest_action;
 		}
 	}
-- 
2.43.0


