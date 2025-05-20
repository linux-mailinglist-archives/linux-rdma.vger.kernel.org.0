Return-Path: <linux-rdma+bounces-10455-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AFEABE4E0
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 22:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9881BA36B3
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 20:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C0228DF1B;
	Tue, 20 May 2025 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4OgE11w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5932A28D8CA;
	Tue, 20 May 2025 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773382; cv=none; b=scaKQQq27aQiaoNlgqSBx8dWa7IYjbS90/BFk7RLp/785aOrtUO3GksBAUVD+wzU33GWvr4nKDA2QUu6Y2UwcT4t2jwYAK1a4zNWev44dmu/6fdoU5W3GANlEWw1BQYYdT8AL4NgHts+fTFwymkjYmiTHC0Pfna0UhszYi092W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773382; c=relaxed/simple;
	bh=BpT/h0vYVM/F7Qu3OnVojwEelU9Q3/KKLsVzvM8EYjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0HLNqxyofNbaLTvQUZsXu1dihMVSHyEXDM3QkyvO9i0eHZFuNnpYniq1bgbLmjyaMauTRtxeauWiGym38CPcC5g8i1Kc+wc5KMJTwMmr4FxRSivEmNRR1pMjpwGOFRSxQbbOWaR4x05nVAMv+ifZrNsARkmW6TVc6kJMCIspLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4OgE11w; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e033a3a07so62200235ad.0;
        Tue, 20 May 2025 13:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747773380; x=1748378180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCeM+ec5B4gH6tk0fEnypFNTVZat6T1JxRuML0u4Z8U=;
        b=X4OgE11wIVAJ3sMCkW/jiN7DY51oFZi+t4XvJ4JTcuazjOXy/k2sfa17vg4Y4YM/wf
         NwGZydMJ9c5RleXwnteuNrfi0bj0IsPNHK6ZkHIcGUmWLDedwCfSqhuGW3t5lt9x3qmk
         gM1OpYngj5X7gFPV8njPAa2Xhk5rNIvgjd1Vms4WoZ0gZXPDe4YmRA/TN780iwbZ2dV8
         4Ml51vGAcInVtTHV+eag8YsEUT2Rmi4GDeSMSXe/tqFpQUtsWZ+pEuFL9XZikJ/Xd0ja
         ZdOr+S3HxqOmQmWOR6+nJ9jPYrBLFTkqLuYgUSpYn1gZ/UijlcscpGjqFp/xeFwTBupV
         ZTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747773380; x=1748378180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCeM+ec5B4gH6tk0fEnypFNTVZat6T1JxRuML0u4Z8U=;
        b=GJk0q+8f81cqVVUtEu1PXN150y4/qqVIFjBFJVd9uVxvXaGQNalbxUh2/ryMOSHgmu
         Fe7AT6Av6Zv9tNIhh5L5y9I+YBalA+JgmHGLQBEa81qHnGyGVm/eiufhlSsMd1pMvd4k
         kgg/nb+S/uFsSuoG3NmeC3BYsNKQsnEF07/KzCLeP7K2D7ujJifsMiOrK6JnZTp7+HLA
         bj7btpBxIZ1yqSmQeNIenxlzbwUvUngBWCkHsZnb8Ss1dEy8ME47IH61tfeBGesxkiSM
         4QtosZRxw9UTx62ds7nPoXT3KikajFmvUPL2DY1PsTmgNSfZ0njbeWHiu6+c//b/nGNX
         rpaw==
X-Forwarded-Encrypted: i=1; AJvYcCWuyPAEqLEP6WkK19t2clgTac8MMkoHs8DkP0l5mGOKM++F38IORGD1dFZhQbx7xEVIPfx9tnMWXtchpdA=@vger.kernel.org, AJvYcCX3Yp2WikiilciWobUi6uWXI1uEPE4FndNOPoX/NSc0xziYWdzUOSHaKZwxWiwJdtxSRVI9CRxrwaJMbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlnKCOmCsMqtL8ZMQevvErugsqimccRudQ33zzB3wiD4huB6B4
	t+npbYJD7oUwPMUkl4MUgcOcl1X3wOvtRvB2mxRtxSmgFngMDT5HGBWAAJmW
X-Gm-Gg: ASbGnctnEjs4fk8neLD/kwIUkj14na7jrLEVXjwtrSXYccp65lOqIhELydDimm2SJAA
	kVicJK372o1NQDJspsowxvO0CEuLgcRRnEVMeR+8ixpPOOLGwMOsyecpMQi+ABV7w4zcGeu/N4t
	104cRmksGYJ6NK3q7aofSVEjAYShAK6ZjdWK7iG3l+Da6oPUB2JZeEU7d46u0W17NtTaYXF0pzN
	ItgIVq0Q1TWenwvmZ+MWNmicnAYqk6dv0bOt2Kxkx5zdvdx+j30LUm6ulEobxvAH4DMFEfBZ3bP
	6KK5Vv18xgjHA8HxY4xWEiJ+xXFrK91LQqM7lP+Z2cOCHH5l7U4nD8E0kemv21FRtDuyHHClJ+L
	mdnQ6I+c6skiz
X-Google-Smtp-Source: AGHT+IHZAUIjrGWx7MHglWxuwcEk9khRmWgUQFYbF5wFZSXKA6EsR94YaJWuTX/WLyK6xZKL0cxykw==
X-Received: by 2002:a17:902:d483:b0:232:17d8:486 with SMTP id d9443c01a7336-23217d81153mr195813465ad.22.1747773380107;
        Tue, 20 May 2025 13:36:20 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ebba01sm80212605ad.208.2025.05.20.13.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 13:36:19 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	louis.peens@corigine.com,
	shshaikh@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	ecree.xilinx@gmail.com,
	horms@kernel.org,
	dsahern@kernel.org,
	ruanjinjie@huawei.com,
	mheib@redhat.com,
	stfomichev@gmail.com,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	leon@kernel.org
Subject: [PATCH net-next 3/3] Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"
Date: Tue, 20 May 2025 13:36:14 -0700
Message-ID: <20250520203614.2693870-4-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520203614.2693870-1-stfomichev@gmail.com>
References: <20250520203614.2693870-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 325eb217e41fa14f307c7cc702bd18d0bb38fe84.

udp_tunnel infra doesn't need RTNL, should be safe to get back
to only netdev instance lock.

Cc: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 +++++------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a3dadde65b8d..1da208c36572 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14055,28 +14055,13 @@ static void bnxt_unlock_sp(struct bnxt *bp)
 	netdev_unlock(bp->dev);
 }
 
-/* Same as bnxt_lock_sp() with additional rtnl_lock */
-static void bnxt_rtnl_lock_sp(struct bnxt *bp)
-{
-	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
-	rtnl_lock();
-	netdev_lock(bp->dev);
-}
-
-static void bnxt_rtnl_unlock_sp(struct bnxt *bp)
-{
-	set_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
-	netdev_unlock(bp->dev);
-	rtnl_unlock();
-}
-
 /* Only called from bnxt_sp_task() */
 static void bnxt_reset(struct bnxt *bp, bool silent)
 {
-	bnxt_rtnl_lock_sp(bp);
+	bnxt_lock_sp(bp);
 	if (test_bit(BNXT_STATE_OPEN, &bp->state))
 		bnxt_reset_task(bp, silent);
-	bnxt_rtnl_unlock_sp(bp);
+	bnxt_unlock_sp(bp);
 }
 
 /* Only called from bnxt_sp_task() */
@@ -14084,9 +14069,9 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 {
 	int i;
 
-	bnxt_rtnl_lock_sp(bp);
+	bnxt_lock_sp(bp);
 	if (!test_bit(BNXT_STATE_OPEN, &bp->state)) {
-		bnxt_rtnl_unlock_sp(bp);
+		bnxt_unlock_sp(bp);
 		return;
 	}
 	/* Disable and flush TPA before resetting the RX ring */
@@ -14125,7 +14110,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 	}
 	if (bp->flags & BNXT_FLAG_TPA)
 		bnxt_set_tpa(bp, true);
-	bnxt_rtnl_unlock_sp(bp);
+	bnxt_unlock_sp(bp);
 }
 
 static void bnxt_fw_fatal_close(struct bnxt *bp)
@@ -15017,17 +15002,15 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 		bp->fw_reset_state = BNXT_FW_RESET_STATE_OPENING;
 		fallthrough;
 	case BNXT_FW_RESET_STATE_OPENING:
-		while (!rtnl_trylock()) {
+		while (!netdev_trylock(bp->dev)) {
 			bnxt_queue_fw_reset_work(bp, HZ / 10);
 			return;
 		}
-		netdev_lock(bp->dev);
 		rc = bnxt_open(bp->dev);
 		if (rc) {
 			netdev_err(bp->dev, "bnxt_open() failed during FW reset\n");
 			bnxt_fw_reset_abort(bp, rc);
 			netdev_unlock(bp->dev);
-			rtnl_unlock();
 			goto ulp_start;
 		}
 
@@ -15047,7 +15030,6 @@ static void bnxt_fw_reset_task(struct work_struct *work)
 			bnxt_dl_health_fw_status_update(bp, true);
 		}
 		netdev_unlock(bp->dev);
-		rtnl_unlock();
 		bnxt_ulp_start(bp, 0);
 		bnxt_reenable_sriov(bp);
 		netdev_lock(bp->dev);
@@ -15996,7 +15978,7 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 		   rc);
 	napi_enable_locked(&bnapi->napi);
 	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
-	netif_close(dev);
+	bnxt_reset_task(bp, true);
 	return rc;
 }
 
@@ -16812,7 +16794,6 @@ static int bnxt_resume(struct device *device)
 	struct bnxt *bp = netdev_priv(dev);
 	int rc = 0;
 
-	rtnl_lock();
 	netdev_lock(dev);
 	rc = pci_enable_device(bp->pdev);
 	if (rc) {
@@ -16857,7 +16838,6 @@ static int bnxt_resume(struct device *device)
 
 resume_exit:
 	netdev_unlock(bp->dev);
-	rtnl_unlock();
 	bnxt_ulp_start(bp, rc);
 	if (!rc)
 		bnxt_reenable_sriov(bp);
@@ -17023,7 +17003,6 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 	int err;
 
 	netdev_info(bp->dev, "PCI Slot Resume\n");
-	rtnl_lock();
 	netdev_lock(netdev);
 
 	err = bnxt_hwrm_func_qcaps(bp);
@@ -17041,7 +17020,6 @@ static void bnxt_io_resume(struct pci_dev *pdev)
 		netif_device_attach(netdev);
 
 	netdev_unlock(netdev);
-	rtnl_unlock();
 	bnxt_ulp_start(bp, err);
 	if (!err)
 		bnxt_reenable_sriov(bp);
-- 
2.49.0


