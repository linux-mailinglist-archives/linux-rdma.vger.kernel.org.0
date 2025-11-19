Return-Path: <linux-rdma+bounces-14610-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6084C6C719
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 03:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09F3A354216
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 02:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60902D4805;
	Wed, 19 Nov 2025 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1XMW+uv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7229289378
	for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520644; cv=none; b=j0dyWPoQmdBxZqdSTHpq0LmaftASnoz2xnUTrLTxfZGBWq8dbqf/Cd8YCVx5fAENUZX2SCcW5dU70n5LUIcLqevzAeo/g+LrhKSV1AOM9DV5k+/ZGGBzuSNMhIoLydD3Wq6+mUQwRzmuWvCY5PGs1v87+mwgp6J/ZG710H3iR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520644; c=relaxed/simple;
	bh=o6v2JKWyjkrAtYmCDkh0nuKQ5STejAwJQGsyUH0clnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oX2Rlo8jM29I5ryfLqYY3FStLCCNQ4f5jLQ0lRqkDsDZrQPlVXirZNRTyeJqZwdBhp5b0xZJnXMPNx/HTSPgNzjFB0zZi8LLrpPEctb5kfD0ibKFYdpBfWRa9sGNtTdS+RIJlqpyaGX3seor/+Fhy5+MePt5r8j1XJH6qqjMCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1XMW+uv; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-786572c14e3so63740787b3.2
        for <linux-rdma@vger.kernel.org>; Tue, 18 Nov 2025 18:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763520641; x=1764125441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kO5OuF3RV5PKUipEzR3VCrOX6yVyXJYnnHvDL/rtuE=;
        b=U1XMW+uviECysTS3QfnGDrVnAlGOSBV1gCmbogC0zY2d+xlNzWzlYzFeyzTtiXHxa/
         Jx+9dFy0AOJOYlTHQ/7zCm1h3bru/q/YjOrJ7AT2JcTHztTntnpFW0bKdrzUExKkjqR3
         I/rAh3x7MG2BFdkQf853C6Gn+ggbiR+uSGXMqyl5OojJ9iDEDEA0qN13hmQurGTA8FwV
         15XHKOzKIVzDYG63tEUSGe8VLvh06NL8Su18mvG1gyDgawMH6Ov84+aowCdfKRtm/NR4
         /STx/XdGeO/yx6Xz9wRT2s304ST/y9mB5MdPXAkHSq5iJV5mQHJz0arn4YmEkxKH2Mf0
         viiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520641; x=1764125441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3kO5OuF3RV5PKUipEzR3VCrOX6yVyXJYnnHvDL/rtuE=;
        b=tIW9Xa+QzRvSp+WPS+D+mSQs3tk1Pnp6l2V52+pK+J/K0v8DsbDPNSqN2T5jkcwkDs
         tgM5HKUBSUA0cYbIbeZcAJoFX/ZLqemDWAnc3B5BR2pBGd+A0kNCC1ysnkv7DQyZL9b6
         Ew0opM4D4jZ7ens3GgG4q+mAwtE6qfnyR5BTZNXu3nnZ66vOeM2GqCpAly5Vt0Mr0llE
         4YjjV1Pw3A9s7xH4GjAuoWa6sl5HFcfWAKudFul2oRlQpbzpp71MWCx1L3/C1NTisbnG
         gMSBl0ovpeNJT+e5491/eM8Bsbr0ds3Iw4NywSzMTcJeuuZSL2kR9y7fCzOgxp3c8kVV
         V9gg==
X-Forwarded-Encrypted: i=1; AJvYcCV3vhQ1hcuNbxR2IzSOvsd/lPLXZ3iBlQ4p/10u4OPzru3t8JEujbqFh+3Wra41Eo0DbliyaURvMjnv@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOOw+AMigGP+6elwpSuV9yj75ZsAZ8DMnhAJeAqNniEC0pAZ8
	CVgNeLROBhT9H+j/fL9VgygCJaFkTDVUsiJ3IMZ6Ple80WDSjynrl+Bn
X-Gm-Gg: ASbGncvm2uxE38LWweYjb3VILdDQTDXz3zsf86Ywm5kEDTEttwUv44wHlmUZvLSBlff
	eO7tkngkGIVdK5lpOd7D1THklJxdC9U7c7mZVmxPdbc3BH9QLgf6P0I46xJBnToLmjbuNv3gITv
	UsL4aGLMy6id6/TQhXT52JUwe3llxV7Y71Afu58YYZyoC3zYhumHaSA874l6YgFXawuvQekRRvg
	V4lTX35kxqBdpe3cA8pVXXaEFTN9eYqhkas4yL2OSSSLmPy0AWC1OAicKjZncUiFJ54C8xhZwa1
	V3FKZ+N3CAwYieD9rMj7BmyR/qQZokTZttNijE924GW1V/8wwvbwRGNuyxnXw7n379PANhdbn63
	J2uWfmH7AftUqxWIHbAbYFHmqRUSngdYZLiUnAVqSqFt1oVaXtet1f8yV+ZsVmm0+dwjKFGpybZ
	x/cetyKufpQdFPwEa9NaNOPFl3o905Pw==
X-Google-Smtp-Source: AGHT+IGr/8wKl7Lo/BrEcNLpaPPTDQw0nLz5UoJMQFXU/T6aZxEsUYbFfOfP2gb+PEyrMqibi8VdVA==
X-Received: by 2002:a05:690c:888:b0:789:4f19:7fb3 with SMTP id 00721157ae682-7894f19b967mr85852177b3.68.1763520640368;
        Tue, 18 Nov 2025 18:50:40 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822151d43sm58505057b3.46.2025.11.18.18.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:50:39 -0800 (PST)
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
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v5 1/6] devlink: pass extack through to devlink_param::get()
Date: Tue, 18 Nov 2025 18:50:31 -0800
Message-ID: <20251119025038.651131-2-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119025038.651131-1-daniel.zahka@gmail.com>
References: <20251119025038.651131-1-daniel.zahka@gmail.com>
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

Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v3:
    - fix warnings about undocumented param in intel ice driver

 .../marvell/octeontx2/otx2_cpt_devlink.c      |  6 ++++--
 drivers/net/ethernet/amd/pds_core/core.h      |  3 ++-
 drivers/net/ethernet/amd/pds_core/devlink.c   |  3 ++-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  6 ++++--
 .../net/ethernet/intel/i40e/i40e_devlink.c    |  3 ++-
 .../net/ethernet/intel/ice/devlink/devlink.c  | 14 ++++++++++----
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
 25 files changed, 89 insertions(+), 46 deletions(-)

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
index 67ca02d84c97..15de802bbac4 100644
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
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index bc205e3077c7..229179ccc131 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -24,7 +24,8 @@ static int i40e_max_mac_per_vf_set(struct devlink *devlink,
 
 static int i40e_max_mac_per_vf_get(struct devlink *devlink,
 				   u32 id,
-				   struct devlink_param_gset_ctx *ctx)
+				   struct devlink_param_gset_ctx *ctx,
+				   struct netlink_ext_ack *extack)
 {
 	struct i40e_pf *pf = devlink_priv(devlink);
 
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 938914abbe06..d88b7f3fd1f9 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -610,11 +610,13 @@ static int ice_update_tx_topo_user_sel(struct ice_pf *pf, int layers)
  * @devlink: pointer to the devlink instance
  * @id: the parameter ID to set
  * @ctx: context to store the parameter value
+ * @extack: netlink extended ACK structure
  *
  * Return: zero on success and negative value on failure.
  */
 static int ice_devlink_tx_sched_layers_get(struct devlink *devlink, u32 id,
-					   struct devlink_param_gset_ctx *ctx)
+					   struct devlink_param_gset_ctx *ctx,
+					   struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	int err;
@@ -1349,7 +1351,8 @@ static const struct devlink_ops ice_sf_devlink_ops;
 
 static int
 ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
-			    struct devlink_param_gset_ctx *ctx)
+			    struct devlink_param_gset_ctx *ctx,
+			    struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	struct iidc_rdma_core_dev_info *cdev;
@@ -1415,7 +1418,8 @@ ice_devlink_enable_roce_validate(struct devlink *devlink, u32 id,
 
 static int
 ice_devlink_enable_iw_get(struct devlink *devlink, u32 id,
-			  struct devlink_param_gset_ctx *ctx)
+			  struct devlink_param_gset_ctx *ctx,
+			  struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	struct iidc_rdma_core_dev_info *cdev;
@@ -1522,11 +1526,13 @@ static int ice_devlink_local_fwd_str_to_mode(const char *mode_str)
  * @devlink: Pointer to the devlink instance.
  * @id: The parameter ID to set.
  * @ctx: Context to store the parameter value.
+ * @extack: netlink extended ACK structure
  *
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
index 25af8bd7f077..90643ddae099 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1969,7 +1969,8 @@ static int mlx5_devlink_esw_multiport_set(struct devlink *devlink, u32 id,
 }
 
 static int mlx5_devlink_esw_multiport_get(struct devlink *devlink, u32 id,
-					  struct devlink_param_gset_ctx *ctx)
+					  struct devlink_param_gset_ctx *ctx,
+					  struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 8ebca0d17f65..8de6c7f6c294 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2618,7 +2618,8 @@ static int esw_port_metadata_set(struct devlink *devlink, u32 id,
 }
 
 static int esw_port_metadata_get(struct devlink *devlink, u32 id,
-				 struct devlink_param_gset_ctx *ctx)
+				 struct devlink_param_gset_ctx *ctx,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2b755a0035ce..0a6031a64c6f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3833,7 +3833,8 @@ static int mlx5_fs_mode_set(struct devlink *devlink, u32 id,
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
index a862d5f91fce..07769547dc42 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7493,7 +7493,8 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
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
index d01046ef0577..5f479227144d 100644
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
index 97d5f401cfcf..e40cdc12f7f3 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1251,7 +1251,8 @@ struct dsa_switch_ops {
 			     dsa_devlink_param_get, dsa_devlink_param_set, NULL)
 
 int dsa_devlink_param_get(struct devlink *dl, u32 id,
-			  struct devlink_param_gset_ctx *ctx);
+			  struct devlink_param_gset_ctx *ctx,
+			  struct netlink_ext_ack *extack);
 int dsa_devlink_param_set(struct devlink *dl, u32 id,
 			  struct devlink_param_gset_ctx *ctx,
 			  struct netlink_ext_ack *extack);
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 6b233b13b69a..3dbd023e4c36 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -174,11 +174,12 @@ devlink_param_cmode_is_supported(const struct devlink_param *param,
 
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
@@ -250,7 +251,8 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				 unsigned int port_index,
 				 struct devlink_param_item *param_item,
 				 enum devlink_command cmd,
-				 u32 portid, u32 seq, int flags)
+				 u32 portid, u32 seq, int flags,
+				 struct netlink_ext_ack *extack)
 {
 	union devlink_param_value param_value[DEVLINK_PARAM_CMODE_MAX + 1];
 	bool param_value_set[DEVLINK_PARAM_CMODE_MAX + 1] = {};
@@ -275,7 +277,7 @@ static int devlink_nl_param_fill(struct sk_buff *msg, struct devlink *devlink,
 				return -EOPNOTSUPP;
 		} else {
 			ctx.cmode = i;
-			err = devlink_param_get(devlink, param, &ctx);
+			err = devlink_param_get(devlink, param, &ctx, extack);
 			if (err)
 				return err;
 			param_value[i] = ctx.val;
@@ -357,7 +359,7 @@ static void devlink_param_notify(struct devlink *devlink,
 	if (!msg)
 		return;
 	err = devlink_nl_param_fill(msg, devlink, port_index, param_item, cmd,
-				    0, 0, 0);
+				    0, 0, 0, NULL);
 	if (err) {
 		nlmsg_free(msg);
 		return;
@@ -400,7 +402,8 @@ static int devlink_nl_param_get_dump_one(struct sk_buff *msg,
 		err = devlink_nl_param_fill(msg, devlink, 0, param_item,
 					    DEVLINK_CMD_PARAM_GET,
 					    NETLINK_CB(cb->skb).portid,
-					    cb->nlh->nlmsg_seq, flags);
+					    cb->nlh->nlmsg_seq, flags,
+					    cb->extack);
 		if (err == -EOPNOTSUPP) {
 			err = 0;
 		} else if (err) {
@@ -509,8 +512,8 @@ int devlink_nl_param_get_doit(struct sk_buff *skb,
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


