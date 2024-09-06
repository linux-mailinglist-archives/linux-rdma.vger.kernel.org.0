Return-Path: <linux-rdma+bounces-4787-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6595E96E95F
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 07:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847451C22DA1
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 05:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3412EBDB;
	Fri,  6 Sep 2024 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VlptsF3J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866CA2628C;
	Fri,  6 Sep 2024 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601246; cv=none; b=aUgffcdqYMtDA946gIMPORXFiSU2Ze/H2TCScV/5jPHhes7/vmXq/kTHhDY32O5a6e4EkisHkUDo1DXvX2ynW2dq37tOYVEDEU16/vtKjm0NJtyOKmMXDDCcDCKwdEJ9heaA0KZS2X/qT1UwEBjPSCmW2sVbibUYg7GV07LMntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601246; c=relaxed/simple;
	bh=Cniav45urdpVNzapqVqrBdTz6uLrtoPLIOl7/GG06PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdNQcELLMjAVD+HOf2FTOvGhOkyKgkngZYlPE9GFaLfolbB8nG5cNt0ZWn9ZM1fUEx/8GN6Q3w3PM2fE580h4MULDwEC4UZP8LANsB4Hd0F73R1xvv2ztcdW/L8LDmdGyM/P7rCv6UM/x8su/BU0yT9x8WqYe9zqknS2yCV41i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VlptsF3J; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725601229;
	bh=Um2fielNufiPq2gPF+cakRDGheYfuE60dnAlgqaba+4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VlptsF3JjbCh+zw7R23THL+asQr2yCm8+ot2y6+ZS41sf0P2y5MoAz8AjOwZzI33p
	 Oes0w1cLqgls+dqB5AXMEEpxyQlxswec2/MrgknftN1iYKq04QdMcDUEgWGEq5G3TV
	 5ev8/Um/EpQiThubn8bN15U11J6jygRMafgdv2k0=
X-QQ-mid: bizesmtp89t1725601217t86fmi1u
X-QQ-Originating-IP: pp2HEb8VFRV3OyePs+K/oTB0T0vJNpih3CUIsTHdOR4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Sep 2024 13:40:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3399184416924761505
From: WangYuli <wangyuli@uniontech.com>
To: aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	linux@armlinux.org.uk,
	jgg@ziepe.ca,
	leon@kernel.org,
	wangyuli@uniontech.com,
	gustavoars@kernel.org,
	mitr@volny.cz,
	dmitry.torokhov@gmail.com,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	anil.gurumurthy@qlogic.com,
	sudarsana.kalluru@qlogic.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	obdclark@gmail.com,
	quic_abhinavk@quicinc.com,
	dmitry.baryshkov@linaro.org,
	sean@poorly.run,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	abhinavk@codeaurora.org,
	architt@codeaurora.org,
	chandanu@codeaurora.org,
	jsanka@codeaurora.org,
	jcrouse@codeaurora.org,
	ryadav@codeaurora.org,
	skolluku@codeaurora.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	anil_ravindranath@pmc-sierra.com,
	standby24x7@gmail.com,
	jkosina@suse.cz,
	don.hiatt@intel.com,
	ira.weiny@intel.com,
	dasaratharaman.chandramouli@intel.com,
	dledford@redhat.com,
	eric.piel@tremplin-utc.net,
	akpm@linux-foundation.org,
	dtor@mail.ru,
	vijaykumar@bravegnu.org,
	dwmw2@infradead.org,
	kgudipat@brocade.com,
	James.Bottomley@suse.de,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com
Subject: [PATCH] treewide: Correct the typo 'retun'
Date: Fri,  6 Sep 2024 13:40:08 +0800
Message-ID: <63D0F870EE8E87A0+20240906054008.390188-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

There are some spelling mistakes of 'retun' in comments which
should be instead of 'return'.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h  | 2 +-
 drivers/infiniband/core/sa_query.c        | 2 +-
 drivers/input/misc/wistron_btns.c         | 2 +-
 drivers/mtd/nand/raw/nandsim.c            | 2 +-
 drivers/scsi/bfa/bfa_fcs.c                | 2 +-
 drivers/scsi/pmcraid.c                    | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 7ad74db951f6..f18ef45e2fe1 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -333,7 +333,7 @@ int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 	omap_pm_ops.scu_prepare(cpu, power_state);
 
 	/*
-	 * CPU never retuns back if targeted power state is OFF mode.
+	 * CPU never returns back if targeted power state is OFF mode.
 	 * CPU ONLINE follows normal CPU ONLINE ptah via
 	 * omap4_secondary_startup().
 	 */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
index b26d5fe40c72..febc3e764a63 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
@@ -231,7 +231,7 @@ struct dpu_crtc_state {
 	container_of(x, struct dpu_crtc_state, base)
 
 /**
- * dpu_crtc_frame_pending - retun the number of pending frames
+ * dpu_crtc_frame_pending - return the number of pending frames
  * @crtc: Pointer to drm crtc object
  */
 static inline int dpu_crtc_frame_pending(struct drm_crtc *crtc)
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 8175dde60b0a..53571e6b3162 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1420,7 +1420,7 @@ enum opa_pr_supported {
 /*
  * opa_pr_query_possible - Check if current PR query can be an OPA query.
  *
- * Retuns PR_NOT_SUPPORTED if a path record query is not
+ * Returns PR_NOT_SUPPORTED if a path record query is not
  * possible, PR_OPA_SUPPORTED if an OPA path record query
  * is possible and PR_IB_SUPPORTED if an IB path record
  * query is possible.
diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index 5c4956678cd0..39d6f642cd19 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -1075,7 +1075,7 @@ static void wistron_led_init(struct device *parent)
 	}
 
 	if (leds_present & FE_MAIL_LED) {
-		/* bios_get_default_setting(MAIL) always retuns 0, so just turn the led off */
+		/* bios_get_default_setting(MAIL) always returns 0, so just turn the led off */
 		wistron_mail_led.brightness = LED_OFF;
 		if (led_classdev_register(parent, &wistron_mail_led))
 			leds_present &= ~FE_MAIL_LED;
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 179b28459b4b..df48b7d01d16 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -1381,7 +1381,7 @@ static inline union ns_mem *NS_GET_PAGE(struct nandsim *ns)
 }
 
 /*
- * Retuns a pointer to the current byte, within the current page.
+ * Returns a pointer to the current byte, within the current page.
  */
 static inline u_char *NS_PAGE_BYTE_OFF(struct nandsim *ns)
 {
diff --git a/drivers/scsi/bfa/bfa_fcs.c b/drivers/scsi/bfa/bfa_fcs.c
index 5023c0ab4277..e52ce9b01f49 100644
--- a/drivers/scsi/bfa/bfa_fcs.c
+++ b/drivers/scsi/bfa/bfa_fcs.c
@@ -1431,7 +1431,7 @@ bfa_cb_lps_flogo_comp(void *bfad, void *uarg)
  *	param[in]	vf_id - VF_ID
  *
  *	return
- *	If lookup succeeds, retuns fcs vf object, otherwise returns NULL
+ *	If lookup succeeds, returns fcs vf object, otherwise returns NULL
  */
 bfa_fcs_vf_t   *
 bfa_fcs_vf_lookup(struct bfa_fcs_s *fcs, u16 vf_id)
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index a2a084c8075e..72a4c6e3d0c8 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4009,7 +4009,7 @@ static void pmcraid_tasklet_function(unsigned long instance)
  * This routine un-registers registered interrupt handler and
  * also frees irqs/vectors.
  *
- * Retun Value
+ * Return Value
  *	None
  */
 static
-- 
2.43.4


