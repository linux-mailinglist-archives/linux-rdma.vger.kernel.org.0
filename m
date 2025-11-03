Return-Path: <linux-rdma+bounces-14216-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B77ACC2DEEA
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 20:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55941889E1D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B5A29DB88;
	Mon,  3 Nov 2025 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMROGmba"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A02264B1
	for <linux-rdma@vger.kernel.org>; Mon,  3 Nov 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199162; cv=none; b=T3J2TN1fvRqiC4R0zCic2xlvb9v0zY88tunbN8QBa737n022dibK0vrjGhZ7VuUt3nTQZpCI3J0NC4tO/6glQrpbPhFRLlEOV1kjKCNkhAhxGapiEZ/DWXDyi+cqB0tsBeRJ7pfdA/qgA9VU2eqcHwO7HmvbWyyjRmbprd4z6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199162; c=relaxed/simple;
	bh=PhtHuSLQY4eeDDoAZPvCAEZQtSI38nKeXvZQVvmftxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdjcaksQXsuFt7V3naWsnsnHj2WOpYWlBbZGPigIlcEaudlQiTT1YNi/47ig455kHFb1SyfBnf8+Sy2CzV4tXkmNOmgwxqQoAFESzfv4l/Yy5rQ8A0vwqSKVB7Jt6HwZjkQfcPBeLncMhDVZZD1AczZEpPvFz0ME6tQbW3/qdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMROGmba; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63f9beb2730so2553398d50.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762199158; x=1762803958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOEZDcUJnFE5ak0enlixJJvpiltDH3v0DHiQVdmrneA=;
        b=aMROGmbaXuL3HzIIn/yVeaN13HdGC45VJuj3+DfvBXsgjB9fEB4mY4qt33HdIdLXwu
         t2eEIg46z6+2Ge4g08VXY/MbO/4wh1seFdwLzk1wx/wRrY73uH1wPwE6CK+q6pWyFCua
         sY8tzybE25S4TpLS8mcjvcMz9H0RGFDQjkBa6i5c/elfp365wCbO4Nxtj0G1P1w/UvFh
         ShJ/WNCggSEwPGJiytaQX2njE30tQnL1NpTkpSYJWqtpRVm8QcEtRKIwgII7/rT9aB+H
         ZzHMzVafDnA2YeIjiInmp/IZtGqP655k7umQvjyiI9QoTfjzPRJ9yyHsBo703vZf6/qj
         Tfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762199158; x=1762803958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOEZDcUJnFE5ak0enlixJJvpiltDH3v0DHiQVdmrneA=;
        b=J9rTJ20SfSBHCnRgl88pZqZQ6ubuIEQv6hVTHdvO/1qTAEvN9a2dMQVDtDE7/z2wbp
         UzV7cSpe9U0zMasoRiZP1NYsgQgQnpj7B22+lgcF3FbEWcTwqEOexZ5fYixqLpMnl0RI
         cH0R6VLDGHlYo7rsSg0kPYo9od7PfQ6tXsXvs14hFCZaphXf3lV86Ik7x9SLsuN9XbI3
         yfLUVyiTAjjgR03uhY400fSH4DS+ejKCDjRxCYaRa9SERtvl5STrP8Lxlil4WEmUrrL7
         lbwQYQKByKNr2wUzHaGmbmfhk2/lcA2pE1+80/9XT1hrqMWBvc/mXz2zT2mkoSquE1MP
         MMiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz2REf0DGbfmCfp4H4C0/q51BgHvTT4XLdb/loa5BQrRyZHSW3ps0QUOyet9NyEBf3AqJrM8ax55TS@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3CnMLvuUZqzcowX6ovdyGKHLeUM4K3cUKV3CLP2UP3XqrQex
	JRVJ5qI1Iun4ef6SQw1DkKDNwUpzXRnJiJtrPLxFFul8UspSNn0p4Ixf
X-Gm-Gg: ASbGncsoBD3e+MXbURmbk/yeV/NwPUg987iR+Jl/LmCF6E35w2dcrj2yvgq20DWHPSC
	VJDkNz9HJ866trDoPYg/0wyp2z21lqq5sUyQvhM4QFGMhH4tPUZGoMY//i1dC3IciQlH4c8YYmT
	KxnFMacQkuTmcJShwS9jOHmHRDXue49y1ZAp5w5qihG9Ql96Umb/IhYO6bTHLAjq1q9Dvav/d1N
	COD/I7n092X02/rR8Xvn/sMWn9vDY0R5tcyMg3nJGbtZgRxKz6iTgLddv8I6l5XNoDLlKbUkm4y
	GcIHXT/pzrbIAFhgAyWqhV8mYJz6BMYl1r98uiCa9MPMQL4cTnwnlCWDH2jyxb+E9TGoUNezvVy
	rHuXlv9u95jN2o2GPHWlrBL7VPENa7UbqoxzYoWu9HwMHdj/ddpZXVxDCBcsPupCybvzMRREYfj
	eEHu3jEGCN3vOMPyPLmBww
X-Google-Smtp-Source: AGHT+IGCyLX6AExAqqtLCGXQ645/it/LCD+36//Fnv+G2ObqEba2jQiwVaVKXQzSmt2qFy0n/s6UgQ==
X-Received: by 2002:a53:b118:0:b0:63f:c4f4:e180 with SMTP id 956f58d0204a3-63fc4f4e756mr1254877d50.0.1762199157651;
        Mon, 03 Nov 2025 11:45:57 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:47::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63fb173e1e7sm1720765d50.22.2025.11.03.11.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:45:56 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Manish Chopra <manishc@marvell.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Subject: [PATCH net-next v2 1/2] devlink: pass extack through to devlink_param::get()
Date: Mon,  3 Nov 2025 11:45:52 -0800
Message-ID: <20251103194554.3203178-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103194554.3203178-1-daniel.zahka@gmail.com>
References: <20251103194554.3203178-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow devlink_param::get() handlers to report error messages via
extack. This function is called in a few different contexts, but not
all of them will have an valid extack to use.

When devlink_param::get() is called from param_get_doit or
param_get_dumpit contexts, pass the extack through so that drivers can
report errors when retrieving param values. devlink_param::get() is
called from the context of devlink_param_notify(), pass NULL in for
the extack.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 .../marvell/octeontx2/otx2_cpt_devlink.c      |  6 ++++--
 drivers/net/ethernet/amd/pds_core/core.h      |  3 ++-
 drivers/net/ethernet/amd/pds_core/devlink.c   |  3 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  6 ++++--
 .../net/ethernet/intel/ice/devlink/devlink.c  | 12 ++++++++----
 .../marvell/octeontx2/af/rvu_devlink.c        | 15 ++++++++++-----
 .../marvell/octeontx2/nic/otx2_devlink.c      |  6 ++++--
 drivers/net/ethernet/mellanox/mlx4/main.c     |  6 ++++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  3 ++-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  3 ++-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  3 ++-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  3 ++-
 .../mellanox/mlx5/core/lib/nv_param.c         |  9 ++++++---
 .../mellanox/mlxsw/spectrum_acl_tcam.c        |  3 ++-
 .../ethernet/netronome/nfp/devlink_param.c    |  3 ++-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |  3 ++-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  3 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  3 ++-
 drivers/net/ethernet/ti/cpsw_new.c            |  6 ++++--
 drivers/net/wwan/iosm/iosm_ipc_devlink.c      |  3 ++-
 include/net/devlink.h                         |  3 ++-
 include/net/dsa.h                             |  3 ++-
 net/devlink/param.c                           | 19 +++++++++++--------
 net/dsa/devlink.c                             |  3 ++-
 24 files changed, 85 insertions(+), 45 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c b/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
index 215a1a8ba7e9..07a74f702c3a 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
@@ -24,7 +24,8 @@ static int otx2_cpt_dl_egrp_delete(struct devlink *dl, u32 id,
 }
 
 static int otx2_cpt_dl_uc_info(struct devlink *dl, u32 id,
-			       struct devlink_param_gset_ctx *ctx)
+			       struct devlink_param_gset_ctx *ctx,
+			       struct netlink_ext_ack *extack)
 {
 	ctx->val.vstr[0] = '\0';
 
@@ -32,7 +33,8 @@ static int otx2_cpt_dl_uc_info(struct devlink *dl, u32 id,
 }
 
 static int otx2_cpt_dl_t106_mode_get(struct devlink *dl, u32 id,
-				     struct devlink_param_gset_ctx *ctx)
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
 {
 	struct otx2_cpt_devlink *cpt_dl = devlink_priv(dl);
 	struct otx2_cptpf_dev *cptpf = cpt_dl->cptpf;
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 0b53a1fab46d..4a6b35c84dab 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -255,7 +255,8 @@ int pdsc_dl_flash_update(struct devlink *dl,
 			 struct devlink_flash_update_params *params,
 			 struct netlink_ext_ack *extack);
 int pdsc_dl_enable_get(struct devlink *dl, u32 id,
-		       struct devlink_param_gset_ctx *ctx);
+		       struct devlink_param_gset_ctx *ctx,
+		       struct netlink_ext_ack *extack);
 int pdsc_dl_enable_set(struct devlink *dl, u32 id,
 		       struct devlink_param_gset_ctx *ctx,
 		       struct netlink_ext_ack *extack);
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index d8dc39da4161..b576be626a29 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -22,7 +22,8 @@ pdsc_viftype *pdsc_dl_find_viftype_by_id(struct pdsc *pdsc,
 }
 
 int pdsc_dl_enable_get(struct devlink *dl, u32 id,
-		       struct devlink_param_gset_ctx *ctx)
+		       struct devlink_param_gset_ctx *ctx,
+		       struct netlink_ext_ack *extack)
 {
 	struct pdsc *pdsc = devlink_priv(dl);
 	struct pdsc_viftype *vt_entry;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 02961d93ed35..1ea98643a488 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -1086,7 +1086,8 @@ static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
 }
 
 static int bnxt_dl_nvm_param_get(struct devlink *dl, u32 id,
-				 struct devlink_param_gset_ctx *ctx)
+				 struct devlink_param_gset_ctx *ctx,
+				 struct netlink_ext_ack *extack)
 {
 	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
 	struct hwrm_nvm_get_variable_input *req;
@@ -1168,7 +1169,8 @@ static int bnxt_dl_msix_validate(struct devlink *dl, u32 id,
 }
 
 static int bnxt_remote_dev_reset_get(struct devlink *dl, u32 id,
-				     struct devlink_param_gset_ctx *ctx)
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
 {
 	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
 
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 938914abbe06..d6d1c5b34497 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -614,7 +614,8 @@ static int ice_update_tx_topo_user_sel(struct ice_pf *pf, int layers)
  * Return: zero on success and negative value on failure.
  */
 static int ice_devlink_tx_sched_layers_get(struct devlink *devlink, u32 id,
-					   struct devlink_param_gset_ctx *ctx)
+					   struct devlink_param_gset_ctx *ctx,
+					   struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	int err;
@@ -1349,7 +1350,8 @@ static const struct devlink_ops ice_sf_devlink_ops;
 
 static int
 ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
-			    struct devlink_param_gset_ctx *ctx)
+			    struct devlink_param_gset_ctx *ctx,
+			    struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	struct iidc_rdma_core_dev_info *cdev;
@@ -1415,7 +1417,8 @@ ice_devlink_enable_roce_validate(struct devlink *devlink, u32 id,
 
 static int
 ice_devlink_enable_iw_get(struct devlink *devlink, u32 id,
-			  struct devlink_param_gset_ctx *ctx)
+			  struct devlink_param_gset_ctx *ctx,
+			  struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	struct iidc_rdma_core_dev_info *cdev;
@@ -1526,7 +1529,8 @@ static int ice_devlink_local_fwd_str_to_mode(const char *mode_str)
  * Return: Zero.
  */
 static int ice_devlink_local_fwd_get(struct devlink *devlink, u32 id,
-				     struct devlink_param_gset_ctx *ctx)
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	struct ice_port_info *pi;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 3735372539bd..0f9953eaf1b0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1233,7 +1233,8 @@ static int rvu_af_dl_dwrr_mtu_set(struct devlink *devlink, u32 id,
 }
 
 static int rvu_af_dl_dwrr_mtu_get(struct devlink *devlink, u32 id,
-				  struct devlink_param_gset_ctx *ctx)
+				  struct devlink_param_gset_ctx *ctx,
+				  struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
@@ -1259,7 +1260,8 @@ enum rvu_af_dl_param_id {
 };
 
 static int rvu_af_npc_exact_feature_get(struct devlink *devlink, u32 id,
-					struct devlink_param_gset_ctx *ctx)
+					struct devlink_param_gset_ctx *ctx,
+					struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
@@ -1314,7 +1316,8 @@ static int rvu_af_npc_exact_feature_validate(struct devlink *devlink, u32 id,
 }
 
 static int rvu_af_dl_npc_mcam_high_zone_percent_get(struct devlink *devlink, u32 id,
-						    struct devlink_param_gset_ctx *ctx)
+						    struct devlink_param_gset_ctx *ctx,
+						    struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
@@ -1376,7 +1379,8 @@ static int rvu_af_dl_npc_mcam_high_zone_percent_validate(struct devlink *devlink
 }
 
 static int rvu_af_dl_npc_def_rule_cntr_get(struct devlink *devlink, u32 id,
-					   struct devlink_param_gset_ctx *ctx)
+					   struct devlink_param_gset_ctx *ctx,
+					   struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
@@ -1402,7 +1406,8 @@ static int rvu_af_dl_npc_def_rule_cntr_set(struct devlink *devlink, u32 id,
 }
 
 static int rvu_af_dl_nix_maxlf_get(struct devlink *devlink, u32 id,
-				   struct devlink_param_gset_ctx *ctx)
+				   struct devlink_param_gset_ctx *ctx,
+				   struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index e13ae5484c19..a72694219df4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -48,7 +48,8 @@ static int otx2_dl_mcam_count_set(struct devlink *devlink, u32 id,
 }
 
 static int otx2_dl_mcam_count_get(struct devlink *devlink, u32 id,
-				  struct devlink_param_gset_ctx *ctx)
+				  struct devlink_param_gset_ctx *ctx,
+				  struct netlink_ext_ack *extack)
 {
 	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
 	struct otx2_nic *pfvf = otx2_dl->pfvf;
@@ -84,7 +85,8 @@ static int otx2_dl_ucast_flt_cnt_set(struct devlink *devlink, u32 id,
 }
 
 static int otx2_dl_ucast_flt_cnt_get(struct devlink *devlink, u32 id,
-				     struct devlink_param_gset_ctx *ctx)
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
 {
 	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
 	struct otx2_nic *pfvf = otx2_dl->pfvf;
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 03d2fc7d9b09..2de226951e19 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -174,7 +174,8 @@ MODULE_PARM_DESC(port_type_array, "Array of port types: HW_DEFAULT (0) is defaul
 static atomic_t pf_loading = ATOMIC_INIT(0);
 
 static int mlx4_devlink_ierr_reset_get(struct devlink *devlink, u32 id,
-				       struct devlink_param_gset_ctx *ctx)
+				       struct devlink_param_gset_ctx *ctx,
+				       struct netlink_ext_ack *extack)
 {
 	ctx->val.vbool = !!mlx4_internal_err_reset;
 	return 0;
@@ -189,7 +190,8 @@ static int mlx4_devlink_ierr_reset_set(struct devlink *devlink, u32 id,
 }
 
 static int mlx4_devlink_crdump_snapshot_get(struct devlink *devlink, u32 id,
-					    struct devlink_param_gset_ctx *ctx)
+					    struct devlink_param_gset_ctx *ctx,
+					    struct netlink_ext_ack *extack)
 {
 	struct mlx4_priv *priv = devlink_priv(devlink);
 	struct mlx4_dev *dev = &priv->dev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index e2ffb87b94cb..308429175bb2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1978,7 +1978,8 @@ static int mlx5_devlink_esw_multiport_set(struct devlink *devlink, u32 id,
 }
 
 static int mlx5_devlink_esw_multiport_get(struct devlink *devlink, u32 id,
-					  struct devlink_param_gset_ctx *ctx)
+					  struct devlink_param_gset_ctx *ctx,
+					  struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 4092ea29c630..a4dd1239514f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2492,7 +2492,8 @@ static int esw_port_metadata_set(struct devlink *devlink, u32 id,
 }
 
 static int esw_port_metadata_get(struct devlink *devlink, u32 id,
-				 struct devlink_param_gset_ctx *ctx)
+				 struct devlink_param_gset_ctx *ctx,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2db3ffb0a2b2..88dc2023fca5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3774,7 +3774,8 @@ static int mlx5_fs_mode_set(struct devlink *devlink, u32 id,
 }
 
 static int mlx5_fs_mode_get(struct devlink *devlink, u32 id,
-			    struct devlink_param_gset_ctx *ctx)
+			    struct devlink_param_gset_ctx *ctx,
+			    struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 89e399606877..2bceb42c98cc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -73,7 +73,8 @@ static int mlx5_fw_reset_enable_remote_dev_reset_set(struct devlink *devlink, u3
 }
 
 static int mlx5_fw_reset_enable_remote_dev_reset_get(struct devlink *devlink, u32 id,
-						     struct devlink_param_gset_ctx *ctx)
+						     struct devlink_param_gset_ctx *ctx,
+						     struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	struct mlx5_fw_reset *fw_reset;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
index f0ab5ef95fc2..3d2195338d39 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
@@ -200,7 +200,8 @@ static const char *const
 
 static int
 mlx5_nv_param_devlink_cqe_compress_get(struct devlink *devlink, u32 id,
-				       struct devlink_param_gset_ctx *ctx)
+				       struct devlink_param_gset_ctx *ctx,
+				       struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
@@ -302,7 +303,8 @@ static int mlx5_nv_param_read_per_host_pf_conf(struct mlx5_core_dev *dev,
 }
 
 static int mlx5_devlink_enable_sriov_get(struct devlink *devlink, u32 id,
-					 struct devlink_param_gset_ctx *ctx)
+					 struct devlink_param_gset_ctx *ctx,
+					 struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
@@ -413,7 +415,8 @@ static int mlx5_devlink_enable_sriov_set(struct devlink *devlink, u32 id,
 }
 
 static int mlx5_devlink_total_vfs_get(struct devlink *devlink, u32 id,
-				      struct devlink_param_gset_ctx *ctx)
+				      struct devlink_param_gset_ctx *ctx,
+				      struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	u32 mnvda[MLX5_ST_SZ_DW(mnvda_reg)] = {};
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index b1d08e958bf9..69f9da9fb305 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -1489,7 +1489,8 @@ mlxsw_sp_acl_tcam_vregion_rehash(struct mlxsw_sp *mlxsw_sp,
 
 static int
 mlxsw_sp_acl_tcam_region_rehash_intrvl_get(struct devlink *devlink, u32 id,
-					   struct devlink_param_gset_ctx *ctx)
+					   struct devlink_param_gset_ctx *ctx,
+					   struct netlink_ext_ack *extack)
 {
 	struct mlxsw_core *mlxsw_core = devlink_priv(devlink);
 	struct mlxsw_sp_acl_tcam *tcam;
diff --git a/drivers/net/ethernet/netronome/nfp/devlink_param.c b/drivers/net/ethernet/netronome/nfp/devlink_param.c
index 0e1a3800f371..85e3b19e6165 100644
--- a/drivers/net/ethernet/netronome/nfp/devlink_param.c
+++ b/drivers/net/ethernet/netronome/nfp/devlink_param.c
@@ -81,7 +81,8 @@ static const struct nfp_devlink_param_u8_arg nfp_devlink_u8_args[] = {
 
 static int
 nfp_devlink_param_u8_get(struct devlink *devlink, u32 id,
-			 struct devlink_param_gset_ctx *ctx)
+			 struct devlink_param_gset_ctx *ctx,
+			 struct netlink_ext_ack *extack)
 {
 	const struct nfp_devlink_param_u8_arg *arg;
 	struct nfp_pf *pf = devlink_priv(devlink);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_devlink.c b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
index 94c5689b5abd..0c5278c0598c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_devlink.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
@@ -121,7 +121,8 @@ void qed_fw_reporters_destroy(struct devlink *devlink)
 }
 
 static int qed_dl_param_get(struct devlink *dl, u32 id,
-			    struct devlink_param_gset_ctx *ctx)
+			    struct devlink_param_gset_ctx *ctx,
+			    struct netlink_ext_ack *extack)
 {
 	struct qed_devlink *qed_dl = devlink_priv(dl);
 	struct qed_dev *cdev;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1e69c1a7dc6c..4abfbb5b664d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7434,7 +7434,8 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
 }
 
 static int stmmac_dl_ts_coarse_get(struct devlink *dl, u32 id,
-				   struct devlink_param_gset_ctx *ctx)
+				   struct devlink_param_gset_ctx *ctx,
+				   struct netlink_ext_ack *extack)
 {
 	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
 	struct stmmac_priv *priv = dl_priv->stmmac_priv;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index d5f358ec9820..5924db6be3fe 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3068,7 +3068,8 @@ static void am65_cpsw_init_host_port_emac(struct am65_cpsw_common *common)
 }
 
 static int am65_cpsw_dl_switch_mode_get(struct devlink *dl, u32 id,
-					struct devlink_param_gset_ctx *ctx)
+					struct devlink_param_gset_ctx *ctx,
+					struct netlink_ext_ack *extack)
 {
 	struct am65_cpsw_devlink *dl_priv = devlink_priv(dl);
 	struct am65_cpsw_common *common = dl_priv->common;
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 8b9e2078c602..ab88d4c02cbd 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1618,7 +1618,8 @@ static const struct devlink_ops cpsw_devlink_ops = {
 };
 
 static int cpsw_dl_switch_mode_get(struct devlink *dl, u32 id,
-				   struct devlink_param_gset_ctx *ctx)
+				   struct devlink_param_gset_ctx *ctx,
+				   struct netlink_ext_ack *extack)
 {
 	struct cpsw_devlink *dl_priv = devlink_priv(dl);
 	struct cpsw_common *cpsw = dl_priv->cpsw;
@@ -1753,7 +1754,8 @@ static int cpsw_dl_switch_mode_set(struct devlink *dl, u32 id,
 }
 
 static int cpsw_dl_ale_ctrl_get(struct devlink *dl, u32 id,
-				struct devlink_param_gset_ctx *ctx)
+				struct devlink_param_gset_ctx *ctx,
+				struct netlink_ext_ack *extack)
 {
 	struct cpsw_devlink *dl_priv = devlink_priv(dl);
 	struct cpsw_common *cpsw = dl_priv->cpsw;
diff --git a/drivers/net/wwan/iosm/iosm_ipc_devlink.c b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
index 33d6342124bc..301a9d294d30 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_devlink.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
@@ -21,7 +21,8 @@ static struct iosm_coredump_file_info list[IOSM_NOF_CD_REGION] = {
 
 /* Get the param values for the specific param ID's */
 static int ipc_devlink_get_param(struct devlink *dl, u32 id,
-				 struct devlink_param_gset_ctx *ctx)
+				 struct devlink_param_gset_ctx *ctx,
+				 struct netlink_ext_ack *extack)
 {
 	struct iosm_devlink *ipc_devlink = devlink_priv(dl);
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9e824f61e40f..6d942597d07d 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -490,7 +490,8 @@ struct devlink_param {
 	enum devlink_param_type type;
 	unsigned long supported_cmodes;
 	int (*get)(struct devlink *devlink, u32 id,
-		   struct devlink_param_gset_ctx *ctx);
+		   struct devlink_param_gset_ctx *ctx,
+		   struct netlink_ext_ack *extack);
 	int (*set)(struct devlink *devlink, u32 id,
 		   struct devlink_param_gset_ctx *ctx,
 		   struct netlink_ext_ack *extack);
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 67762fdaf3c7..a0b9962f7764 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1249,7 +1249,8 @@ struct dsa_switch_ops {
 			     dsa_devlink_param_get, dsa_devlink_param_set, NULL)
 
 int dsa_devlink_param_get(struct devlink *dl, u32 id,
-			  struct devlink_param_gset_ctx *ctx);
+			  struct devlink_param_gset_ctx *ctx,
+			  struct netlink_ext_ack *extack);
 int dsa_devlink_param_set(struct devlink *dl, u32 id,
 			  struct devlink_param_gset_ctx *ctx,
 			  struct netlink_ext_ack *extack);
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 70e69523412c..8bae3f733bde 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -169,11 +169,12 @@ devlink_param_cmode_is_supported(const struct devlink_param *param,
 
 static int devlink_param_get(struct devlink *devlink,
 			     const struct devlink_param *param,
-			     struct devlink_param_gset_ctx *ctx)
+			     struct devlink_param_gset_ctx *ctx,
+			     struct netlink_ext_ack *extack)
 {
 	if (!param->get)
 		return -EOPNOTSUPP;
-	return param->get(devlink, param->id, ctx);
+	return param->get(devlink, param->id, ctx, extack);
 }
 
 static int devlink_param_set(struct devlink *devlink,
@@ -245,7 +246,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				 unsigned int port_index,
 				 struct devlink_param_item *param_item,
 				 enum devlink_command cmd,
-				 u32 portid, u32 seq, int flags)
+				 u32 portid, u32 seq, int flags,
+				 struct netlink_ext_ack *extack)
 {
 	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
 	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
@@ -270,7 +272,7 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				return -EOPNOTSUPP;
 		} else {
 			ctx.cmode = i;
-			err = devlink_param_get(devlink, param, &ctx);
+			err = devlink_param_get(devlink, param, &ctx, extack);
 			if (err)
 				return err;
 			param_value[i] = ctx.val;
@@ -352,7 +354,7 @@ static void devlink_param_notify(struct devlink *devlink,
 	if (!msg)
 		return;
 	err = devlink_nl_param_fill(msg, devlink, port_index, param_item, cmd,
-				    0, 0, 0);
+				    0, 0, 0, NULL);
 	if (err) {
 		nlmsg_free(msg);
 		return;
@@ -395,7 +397,8 @@ static int devlink_nl_param_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_param_fill(msg, devlink, 0, param_item,
 					    DEVLINK_CMD_PARAM_GET,
 					    NETLINK_CB(cb->skb).portid,
-					    cb->nlh->nlmsg_seq, flags);
+					    cb->nlh->nlmsg_seq, flags,
+					    cb->extack);
 		if (err == -EOPNOTSUPP) {
 			err = 0;
 		} else if (err) {
@@ -504,8 +507,8 @@ int devlink_nl_param_get_doit(struct sk_buff *skb,
 		return -ENOMEM;
 
 	err = devlink_nl_param_fill(msg, devlink, 0, param_item,
-				    DEVLINK_CMD_PARAM_GET,
-				    info->snd_portid, info->snd_seq, 0);
+				    DEVLINK_CMD_PARAM_GET, info->snd_portid,
+				    info->snd_seq, 0, info->extack);
 	if (err) {
 		nlmsg_free(msg);
 		return err;
diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
index f41f9fc2194e..ed342f345692 100644
--- a/net/dsa/devlink.c
+++ b/net/dsa/devlink.c
@@ -182,7 +182,8 @@ static const struct devlink_ops dsa_devlink_ops = {
 };
 
 int dsa_devlink_param_get(struct devlink *dl, u32 id,
-			  struct devlink_param_gset_ctx *ctx)
+			  struct devlink_param_gset_ctx *ctx,
+			  struct netlink_ext_ack *extack)
 {
 	struct dsa_switch *ds = dsa_devlink_to_ds(dl);
 
-- 
2.47.3


