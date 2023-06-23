Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A393473BC04
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 17:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjFWPu3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 11:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjFWPu2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 11:50:28 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08292117
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 08:50:27 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-39ecf336d85so589139b6e.2
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1687535427; x=1690127427;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yzTyPBfCwKm2/YGMG6fSXFi4PRfRAAsh4lvvUwim2aY=;
        b=CQfLYNB0cqVJl74+VuSrGyh9qeffPG4kM+g6QUR+eA4ZLqmUiRZGeWKi476TJ/vqFL
         B6UHbiw12+75Lax2dYgrg3qS23JJ/zRg1t3RMm6knjILH+Fq/NMS9m1hfG6d0MiQTuQI
         B/nIdOtNbey0hoQkpTaH0JKOv9OVuHwQ974aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687535427; x=1690127427;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzTyPBfCwKm2/YGMG6fSXFi4PRfRAAsh4lvvUwim2aY=;
        b=AsdAkxVzpg/TNkNnMSy2N0VO0J+z/RKFXnN+6qYEJo5kHeVCw2ZEszNWz7TB26VBec
         vH4cAHjBhBEkCSGKC1TeDqTxUUjUkpRkfjPg/AN+xJjp91trZWiis6hmb80wtSqjTpOM
         S596Y7nHyku9d8cao4mf3O0AM51VazU9gu92qdEXyZnYfCw6foY+aJKkLgNDpUJbCSze
         1UYzA3LvU8WSl6nBvKhMO5g3H20Sfh6XKCjRsl/ZJCUZRHhGjph0amRXOT7erG21kc8W
         Q0yqqZ7ZD71u8AiwdgqyeU++6uxFTjTE45Vr0MbGjD9HwKCr+JKvl8pviURFJovYC4Ws
         HT4g==
X-Gm-Message-State: AC+VfDynsyn1DIjM2logPiW1BuYleNmCrTZ+Q/tFW9LsGiQ66upb5fGl
        JzR3g9+BPzRrwM54tUc481E8rg==
X-Google-Smtp-Source: ACHHUZ4KABoEt57Gzwjgeb3wG3N+6Xoggx4OXQSHAmrHUCsQ/PCK2mBCXjiT96GDYAWMM2tm/l/R3A==
X-Received: by 2002:a05:6808:21a8:b0:39a:bda7:adc1 with SMTP id be40-20020a05680821a800b0039abda7adc1mr15568620oib.2.1687535426949;
        Fri, 23 Jun 2023 08:50:26 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z124-20020a636582000000b00553d96d7feesm6637100pgb.35.2023.06.23.08.50.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2023 08:50:26 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        michael.chan@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/7] bnxt_en: Update HW interface headers
Date:   Fri, 23 Jun 2023 08:38:31 -0700
Message-Id: <1687534717-17968-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1687534717-17968-1-git-send-email-selvin.xavier@broadcom.com>
References: <1687534717-17968-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000af75ea05fecdf55a"
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

--000000000000af75ea05fecdf55a

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Updating the HW structures for the doorbell pacing related
information. Newly added interface structures will be used in
the followup patches.

CC: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index b31de4c..a2d3a80 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -3721,6 +3721,60 @@ struct hwrm_func_backing_store_qcaps_v2_output {
 	u8	valid;
 };
 
+/* hwrm_func_dbr_pacing_qcfg_input (size:128b/16B) */
+struct hwrm_func_dbr_pacing_qcfg_input {
+	__le16  req_type;
+	__le16  cmpl_ring;
+	__le16  seq_id;
+	__le16  target_id;
+	__le64  resp_addr;
+};
+
+/* hwrm_func_dbr_pacing_qcfg_output (size:512b/64B) */
+struct hwrm_func_dbr_pacing_qcfg_output {
+	__le16  error_code;
+	__le16  req_type;
+	__le16  seq_id;
+	__le16  resp_len;
+	u8      flags;
+#define FUNC_DBR_PACING_QCFG_RESP_FLAGS_DBR_NQ_EVENT_ENABLED     0x1UL
+	u8      unused_0[7];
+	__le32  dbr_stat_db_fifo_reg;
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_MASK    0x3UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_SFT     0
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_GRC       0x1UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR0      0x2UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR1      0x3UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_LAST     \
+		FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SPACE_BAR1
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_MASK          0xfffffffcUL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_STAT_DB_FIFO_REG_ADDR_SFT           2
+	__le32  dbr_stat_db_fifo_reg_watermark_mask;
+	u8      dbr_stat_db_fifo_reg_watermark_shift;
+	u8      unused_1[3];
+	__le32  dbr_stat_db_fifo_reg_fifo_room_mask;
+	u8      dbr_stat_db_fifo_reg_fifo_room_shift;
+	u8      unused_2[3];
+	__le32  dbr_throttling_aeq_arm_reg;
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_MASK    0x3UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_SFT     0
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_PCIE_CFG  0x0UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_GRC       0x1UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR0      0x2UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR1      0x3UL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_LAST	\
+		FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SPACE_BAR1
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_MASK          0xfffffffcUL
+#define FUNC_DBR_PACING_QCFG_RESP_DBR_THROTTLING_AEQ_ARM_REG_ADDR_SFT           2
+	u8      dbr_throttling_aeq_arm_reg_val;
+	u8      unused_3[7];
+	__le32  primary_nq_id;
+	__le32  pacing_threshold;
+	u8      unused_4[7];
+	u8      valid;
+};
+
 /* hwrm_func_drv_if_change_input (size:192b/24B) */
 struct hwrm_func_drv_if_change_input {
 	__le16	req_type;
-- 
2.5.5


--000000000000af75ea05fecdf55a
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJASa5/+fp5M
02soXEbf9Nt3RVykn2/8TlmsNJ70WQM8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYyMzE1NTAyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAGC40gFxIE3IR5iBqJCHqVMQULBYGW
O93KEjrpj6Y3rBAzR5cd/lsi7+jJ6qIHiJ8z//1Wrpcq26qIO0bIKv0AmSbtlHvyhHTumezxm+m/
tNfeWUgtVrklPxF48aqUOMi+QOI/1ilWA4El9ND0IPuY2hEYTsD4PhZQWgRlh+gfTZ4jhEm1uRkj
nPoAdB3obdC1f0WGvP2s7ZulDvX/figER+IePCd7aL+jUp3IDYUz7BDykrZY7O3Wr8HFy3canA4y
3FB3YNY8lJ3//BuxajVvdTRYx9IqcVNUOHo/lSxAlzTa92Cmnf66ZT+RjKdv+V/jof4fhDv3L3Js
DIHeRoDM
--000000000000af75ea05fecdf55a--
