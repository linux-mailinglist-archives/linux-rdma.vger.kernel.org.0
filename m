Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F208573BC06
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjFWPul (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 11:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjFWPuf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 11:50:35 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE9C2130
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 08:50:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6687466137bso460915b3a.0
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 08:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1687535433; x=1690127433;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SsQuonmlfJKYhgGxlcpqG9j3QP7xZgocZ55Rul/UNns=;
        b=Mo4Fh92S3lyNhyVJaIL/rB1rtt8vH08JnfsqYhh6i2Rp8k5xpThe+NSjd8GbotOouC
         VDVq4eME6b6pc/gfiHocaZtNnfBWjLMQNK0HsLJ4MMTYAsz1XnhgBQTYUdxtO9XchpqK
         mODOqYusHPIbMTWM+gKFAM0lsT70HnxCQfPhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687535433; x=1690127433;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsQuonmlfJKYhgGxlcpqG9j3QP7xZgocZ55Rul/UNns=;
        b=UekgCGwNCxexmRAPp4wCaSkWwCwXjc27wDP8iIY9L00ZsSJvp9tn7yz+ID1r5/chpI
         dJ8yAMh7XNqAJvwAs8Z03DLGv1U/ofjyN+D2lqY5O7N0Sv/9f/yfnirzhiUzzELCUwIK
         9G717SL7pFQJ8+ZLjw09TXqtlxUOdf/m73NG+BZRVEmmdXdilfF+HfUUjso3iL3c+4NR
         5lkR3g1YtvFvQteA3smSg7e7fUAKV5YMt0Ysk4eyql1/vzusPS30NBJrIqRxg2cM5csx
         /txAUzhzv8PBIMpvccNolh1CYlWSU5/v5So2+MugGq8gazrbBDV9jAcXR6pQCT5njTdW
         vVlA==
X-Gm-Message-State: AC+VfDxYmSk2pwspxRQ2x14GbykpffrHoZNljG4xhkdS9vJC2p4mqIgT
        x1hMi7FR0JWiD0PHm7E9sVvJSw==
X-Google-Smtp-Source: ACHHUZ6u3lpSZcWa63qNAtiJH4L61zkYDDWgkRHj+5cC/LhL7rwgZLDoT7PJLDTA4oQ5A7adFR8Cpg==
X-Received: by 2002:a05:6a20:938a:b0:11f:6391:3add with SMTP id x10-20020a056a20938a00b0011f63913addmr15264355pzh.15.1687535433034;
        Fri, 23 Jun 2023 08:50:33 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z124-20020a636582000000b00553d96d7feesm6637100pgb.35.2023.06.23.08.50.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2023 08:50:32 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        michael.chan@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 3/7] RDMA/bnxt_re: Initialize Doorbell pacing feature
Date:   Fri, 23 Jun 2023 08:38:33 -0700
Message-Id: <1687534717-17968-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1687534717-17968-1-git-send-email-selvin.xavier@broadcom.com>
References: <1687534717-17968-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000010230f05fecdf64f"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000010230f05fecdf64f

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Checks for pacing feature capability and get the doorbell pacing
configuration using FW commands. Allocate a page and initialize
the pacing parameters for the applications. Cleanup the page and
de-initialize the pacing during device removal.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   | 22 +++++++
 drivers/infiniband/hw/bnxt_re/main.c      | 96 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h | 19 ++++++
 3 files changed, 137 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 9e278d2..dfc9c0f 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -112,6 +112,27 @@ struct bnxt_re_gsi_context {
 #define BNXT_RE_NQ_IDX			1
 #define BNXT_RE_GEN_P5_MAX_VF		64
 
+struct bnxt_re_pacing {
+	u64 dbr_db_fifo_reg_off;
+	void *dbr_page;
+	u64 dbr_bar_addr;
+	u32 pacing_algo_th;
+	u32 do_pacing_save;
+	u32 dbq_pacing_time; /* ms */
+	u32 dbr_def_do_pacing;
+	bool dbr_pacing;
+};
+
+#define BNXT_RE_DBR_PACING_TIME 5 /* ms */
+#define BNXT_RE_PACING_ALGO_THRESHOLD 250 /* Entries in DB FIFO */
+#define BNXT_RE_PACING_ALARM_TH_MULTIPLE 2 /* Multiple of pacing algo threshold */
+/* Default do_pacing value when there is no congestion */
+#define BNXT_RE_DBR_DO_PACING_NO_CONGESTION 0x7F /* 1 in 512 probability */
+#define BNXT_RE_DB_FIFO_ROOM_MASK 0x1FFF8000
+#define BNXT_RE_MAX_FIFO_DEPTH 0x2c00
+#define BNXT_RE_DB_FIFO_ROOM_SHIFT 15
+#define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
+
 struct bnxt_re_dev {
 	struct ib_device		ibdev;
 	struct list_head		list;
@@ -173,6 +194,7 @@ struct bnxt_re_dev {
 	atomic_t nq_alloc_cnt;
 	u32 is_virtfn;
 	u32 num_vfs;
+	struct bnxt_re_pacing pacing;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 0816cf2..46e4b2b 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -433,9 +433,92 @@ int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
 		return rc;
 	cctx->modes.db_push = le32_to_cpu(resp.flags) & FUNC_QCAPS_RESP_FLAGS_WCB_PUSH_MODE;
 
+	cctx->modes.dbr_pacing =
+		le32_to_cpu(resp.flags_ext2) & FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_EXT_SUPPORTED ?
+		true : false;
 	return 0;
 }
 
+static int bnxt_re_hwrm_dbr_pacing_qcfg(struct bnxt_re_dev *rdev)
+{
+	struct hwrm_func_dbr_pacing_qcfg_output resp = {};
+	struct hwrm_func_dbr_pacing_qcfg_input req = {};
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
+	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_fw_msg fw_msg = {};
+	int rc;
+
+	cctx = rdev->chip_ctx;
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_FUNC_DBR_PACING_QCFG);
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
+			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (rc)
+		return rc;
+
+	if ((le32_to_cpu(resp.dbr_stat_db_fifo_reg) &
+	    FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_MASK) ==
+		FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_GRC)
+		cctx->dbr_stat_db_fifo =
+			le32_to_cpu(resp.dbr_stat_db_fifo_reg) &
+			~FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_MASK;
+	return 0;
+}
+
+/* Update the pacing tunable parameters to the default values */
+static void bnxt_re_set_default_pacing_data(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_db_pacing_data *pacing_data = rdev->qplib_res.pacing_data;
+
+	pacing_data->do_pacing = rdev->pacing.dbr_def_do_pacing;
+	pacing_data->pacing_th = rdev->pacing.pacing_algo_th;
+	pacing_data->alarm_th =
+		pacing_data->pacing_th * BNXT_RE_PACING_ALARM_TH_MULTIPLE;
+}
+
+static int bnxt_re_initialize_dbr_pacing(struct bnxt_re_dev *rdev)
+{
+	if (bnxt_re_hwrm_dbr_pacing_qcfg(rdev))
+		return -EIO;
+
+	/* Allocate a page for app use */
+	rdev->pacing.dbr_page = (void *)__get_free_page(GFP_KERNEL);
+	if (!rdev->pacing.dbr_page)
+		return -ENOMEM;
+
+	memset((u8 *)rdev->pacing.dbr_page, 0, PAGE_SIZE);
+	rdev->qplib_res.pacing_data = (struct bnxt_qplib_db_pacing_data *)rdev->pacing.dbr_page;
+
+	/* MAP HW window 2 for reading db fifo depth */
+	writel(rdev->chip_ctx->dbr_stat_db_fifo & BNXT_GRC_BASE_MASK,
+	       rdev->en_dev->bar0 + BNXT_GRCPF_REG_WINDOW_BASE_OUT + 4);
+	rdev->pacing.dbr_db_fifo_reg_off =
+		(rdev->chip_ctx->dbr_stat_db_fifo & BNXT_GRC_OFFSET_MASK) +
+		 BNXT_RE_GRC_FIFO_REG_BASE;
+	rdev->pacing.dbr_bar_addr =
+		pci_resource_start(rdev->qplib_res.pdev, 0) + rdev->pacing.dbr_db_fifo_reg_off;
+
+	rdev->pacing.pacing_algo_th = BNXT_RE_PACING_ALGO_THRESHOLD;
+	rdev->pacing.dbq_pacing_time = BNXT_RE_DBR_PACING_TIME;
+	rdev->pacing.dbr_def_do_pacing = BNXT_RE_DBR_DO_PACING_NO_CONGESTION;
+	rdev->pacing.do_pacing_save = rdev->pacing.dbr_def_do_pacing;
+	rdev->qplib_res.pacing_data->fifo_max_depth = BNXT_RE_MAX_FIFO_DEPTH;
+	rdev->qplib_res.pacing_data->fifo_room_mask = BNXT_RE_DB_FIFO_ROOM_MASK;
+	rdev->qplib_res.pacing_data->fifo_room_shift = BNXT_RE_DB_FIFO_ROOM_SHIFT;
+	rdev->qplib_res.pacing_data->grc_reg_offset = rdev->pacing.dbr_db_fifo_reg_off;
+	bnxt_re_set_default_pacing_data(rdev);
+	return 0;
+}
+
+static void bnxt_re_deinitialize_dbr_pacing(struct bnxt_re_dev *rdev)
+{
+	if (rdev->pacing.dbr_page)
+		free_page((u64)rdev->pacing.dbr_page);
+
+	rdev->pacing.dbr_page = NULL;
+	rdev->pacing.dbr_pacing = false;
+}
+
 static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
 				 u16 fw_ring_id, int type)
 {
@@ -1220,6 +1303,9 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev)
 	if (test_and_clear_bit(BNXT_RE_FLAG_GOT_MSIX, &rdev->flags))
 		rdev->num_msix = 0;
 
+	if (rdev->pacing.dbr_pacing)
+		bnxt_re_deinitialize_dbr_pacing(rdev);
+
 	bnxt_re_destroy_chip_ctx(rdev);
 	if (test_and_clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
 		bnxt_unregister_dev(rdev->en_dev);
@@ -1312,6 +1398,16 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 		goto free_ring;
 	}
 
+	if (bnxt_qplib_dbr_pacing_en(rdev->chip_ctx)) {
+		rc = bnxt_re_initialize_dbr_pacing(rdev);
+		if (!rc) {
+			rdev->pacing.dbr_pacing = true;
+		} else {
+			ibdev_err(&rdev->ibdev,
+				  "DBR pacing disabled with error : %d\n", rc);
+			rdev->pacing.dbr_pacing = false;
+		}
+	}
 	rc = bnxt_qplib_get_dev_attr(&rdev->rcfw, &rdev->dev_attr,
 				     rdev->is_virtfn);
 	if (rc)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index d850a55..57161d3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -48,6 +48,7 @@ extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 struct bnxt_qplib_drv_modes {
 	u8	wqe_mode;
 	bool db_push;
+	bool dbr_pacing;
 };
 
 struct bnxt_qplib_chip_ctx {
@@ -58,6 +59,17 @@ struct bnxt_qplib_chip_ctx {
 	u16	hwrm_cmd_max_timeout;
 	struct bnxt_qplib_drv_modes modes;
 	u64	hwrm_intf_ver;
+	u32     dbr_stat_db_fifo;
+};
+
+struct bnxt_qplib_db_pacing_data {
+	u32 do_pacing;
+	u32 pacing_th;
+	u32 alarm_th;
+	u32 fifo_max_depth;
+	u32 fifo_room_mask;
+	u32 fifo_room_shift;
+	u32 grc_reg_offset;
 };
 
 #define BNXT_QPLIB_DBR_PF_DB_OFFSET     0x10000
@@ -271,6 +283,7 @@ struct bnxt_qplib_res {
 	struct mutex                    dpi_tbl_lock;
 	bool				prio;
 	bool                            is_vf;
+	struct bnxt_qplib_db_pacing_data *pacing_data;
 };
 
 static inline bool bnxt_qplib_is_chip_gen_p5(struct bnxt_qplib_chip_ctx *cctx)
@@ -467,4 +480,10 @@ static inline bool _is_ext_stats_supported(u16 dev_cap_flags)
 	return dev_cap_flags &
 		CREQ_QUERY_FUNC_RESP_SB_EXT_STATS;
 }
+
+static inline u8 bnxt_qplib_dbr_pacing_en(struct bnxt_qplib_chip_ctx *cctx)
+{
+	return cctx->modes.dbr_pacing;
+}
+
 #endif /* __BNXT_QPLIB_RES_H__ */
-- 
2.5.5


--00000000000010230f05fecdf64f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPBSE2TI+LJj
K8n/GrZera1RmampJGPh2W1B1gF8YCADMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYyMzE1NTAzM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAinIDdIpCPN4JjJNuzbv9Eq62AWIHi
TVoZmV6RBmumXulQOIazo1IzYoOe1YpuEySrdRIGw47RjU7nB6zTeYS0a+RHJKk851P0t9NLE4lF
X767tnrxuwchYmCRH3h52dz5XA4NguXeaCOs5MTAHnJKzL3E9zQqpzPDYu5Gtw2xk0GFOS7piXX6
+71kV4vDWhGNRDB/R53vGzBs+4YoJCAYGyqjBxN0sCZCtCGCYdYDXda8Z0Lg5LkgyCA43vBBHfGL
r8yJqeqyHEQPp44Lh0CrGjWB2tOGHCjOyIYxFj1YKRk/zDmZyJBgjeKSY395Nzact9z9x3VBnhik
i0mHLR5k
--00000000000010230f05fecdf64f--
