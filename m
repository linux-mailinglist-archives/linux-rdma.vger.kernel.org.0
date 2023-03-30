Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E756D0017
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 11:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjC3JrR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 05:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjC3Jqx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 05:46:53 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03F776BE
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 02:46:16 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q206so10941794pgq.9
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 02:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1680169573;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oB1EzrGOSJgPE5yr+g6Qr5guT0BLsqbr18I6TA/1JNA=;
        b=e/zw/kfYgXh85OtGU8AOuvPe4z5m7Axo9n/EEdP5H+mmHDkSw/HJY11aN16FFh462W
         nUkVRIQMRmEMAVTtamCmvrcxs249bvZ/s1FUZH/vye60FVrTkVB+mjsutOhKBtI6BsYI
         d3HtLM1Y16zxMdksCbxGvKAsnsmTcoAW2M4Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680169573;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oB1EzrGOSJgPE5yr+g6Qr5guT0BLsqbr18I6TA/1JNA=;
        b=6ZquJZGaJFNNI3hVQ1rDqw9SbmZ+9ZLEqOhL/iafUizlXRONA7MJFZHsm6vO3Q98oC
         UYvpf+p4klwizEzs2/chBit3cCMy7rKjIIJUfJlKLNc0dv0dnbb0soE/zt0rDnb9WP3l
         CGrfS+gx5Us7iKs0P1/Iqzt7D5GZDl47eF6qyilWEdXjhiDw/76DwOj011iQ7Mo0F3Jb
         V7v72ZO9vP/zY6kcOk3/+GOKZGkI1KH9G3sllDRG+lJGsLeDqacBM0SJmueu3XM7bcBp
         SPy/e2Pt9n0m6DesMfFyjWiiokqqB0EPeN37iUSguCXll1c+SjT/1iwLJK5O0EuAjoGw
         CWpg==
X-Gm-Message-State: AAQBX9f4SwccEulAgD51Ru0jot/3xBJ8nttSr1fOdQLYMxxFwN9U7kuP
        6GvY4LOFd4f4eQWYnLFq0mvxrg==
X-Google-Smtp-Source: AKy350aN3X+ozqqYs9h8mO7PuVamJOBsjWAiGKsiaTMWIa26lP+aWxy1HHKPweg0hT7hbM9/tUmHAg==
X-Received: by 2002:a62:7b10:0:b0:5e2:da34:4aaf with SMTP id w16-20020a627b10000000b005e2da344aafmr21619470pfc.4.1680169573181;
        Thu, 30 Mar 2023 02:46:13 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c26-20020aa78e1a000000b00625616f59a1sm24468857pfr.73.2023.03.30.02.46.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Mar 2023 02:46:11 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 2/7] RDMA/bnxt_re: Remove HW queue mapping from RoCE Driver
Date:   Thu, 30 Mar 2023 02:45:35 -0700
Message-Id: <1680169540-10029-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1680169540-10029-1-git-send-email-selvin.xavier@broadcom.com>
References: <1680169540-10029-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000979f3e05f81af635"
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_HEADER_CTYPE_ONLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_TVD_MIME_NO_HEADERS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000979f3e05f81af635

bnxt_en driver does the queue mapping for RoCE traffic. Removing the
queue mapping from RoCE driver.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c     | 77 --------------------------------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 15 -------
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |  1 -
 3 files changed, 93 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 48bbba7..4aa3442 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -921,49 +921,6 @@ static void bnxt_re_dispatch_event(struct ib_device *ibdev, struct ib_qp *qp,
 	}
 }
 
-#define HWRM_QUEUE_PRI2COS_QCFG_INPUT_FLAGS_IVLAN      0x02
-static int bnxt_re_query_hwrm_pri2cos(struct bnxt_re_dev *rdev, u8 dir,
-				      u64 *cid_map)
-{
-	struct hwrm_queue_pri2cos_qcfg_input req = {0};
-	struct hwrm_queue_pri2cos_qcfg_output resp;
-	struct bnxt_en_dev *en_dev = rdev->en_dev;
-	struct bnxt_fw_msg fw_msg;
-	u32 flags = 0;
-	u8 *qcfgmap, *tmp_map;
-	int rc = 0, i;
-
-	if (!cid_map)
-		return -EINVAL;
-
-	memset(&fw_msg, 0, sizeof(fw_msg));
-	bnxt_re_init_hwrm_hdr(rdev, (void *)&req,
-			      HWRM_QUEUE_PRI2COS_QCFG, -1, -1);
-	flags |= (dir & 0x01);
-	flags |= HWRM_QUEUE_PRI2COS_QCFG_INPUT_FLAGS_IVLAN;
-	req.flags = cpu_to_le32(flags);
-	req.port_id = en_dev->pf_port_id;
-
-	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
-			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
-	rc = bnxt_send_msg(en_dev, &fw_msg);
-	if (rc)
-		return rc;
-
-	if (resp.queue_cfg_info) {
-		ibdev_warn(&rdev->ibdev,
-			   "Asymmetric cos queue configuration detected");
-		ibdev_warn(&rdev->ibdev,
-			   " on device, QoS may not be fully functional\n");
-	}
-	qcfgmap = &resp.pri0_cos_queue_id;
-	tmp_map = (u8 *)cid_map;
-	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++)
-		tmp_map[i] = qcfgmap[i];
-
-	return rc;
-}
-
 static bool bnxt_re_is_qp1_or_shadow_qp(struct bnxt_re_dev *rdev,
 					struct bnxt_re_qp *qp)
 {
@@ -1056,26 +1013,9 @@ static u32 bnxt_re_get_priority_mask(struct bnxt_re_dev *rdev)
 	return prio_map;
 }
 
-static void bnxt_re_parse_cid_map(u8 prio_map, u8 *cid_map, u16 *cosq)
-{
-	u16 prio;
-	u8 id;
-
-	for (prio = 0, id = 0; prio < 8; prio++) {
-		if (prio_map & (1 << prio)) {
-			cosq[id] = cid_map[prio];
-			id++;
-			if (id == 2) /* Max 2 tcs supported */
-				break;
-		}
-	}
-}
-
 static int bnxt_re_setup_qos(struct bnxt_re_dev *rdev)
 {
 	u8 prio_map = 0;
-	u64 cid_map;
-	int rc;
 
 	/* Get priority for roce */
 	prio_map = bnxt_re_get_priority_mask(rdev);
@@ -1083,23 +1023,6 @@ static int bnxt_re_setup_qos(struct bnxt_re_dev *rdev)
 	if (prio_map == rdev->cur_prio_map)
 		return 0;
 	rdev->cur_prio_map = prio_map;
-	/* Get cosq id for this priority */
-	rc = bnxt_re_query_hwrm_pri2cos(rdev, 0, &cid_map);
-	if (rc) {
-		ibdev_warn(&rdev->ibdev, "no cos for p_mask %x\n", prio_map);
-		return rc;
-	}
-	/* Parse CoS IDs for app priority */
-	bnxt_re_parse_cid_map(prio_map, (u8 *)&cid_map, rdev->cosq);
-
-	/* Config BONO. */
-	rc = bnxt_qplib_map_tc2cos(&rdev->qplib_res, rdev->cosq);
-	if (rc) {
-		ibdev_warn(&rdev->ibdev, "no tc for cos{%x, %x}\n",
-			   rdev->cosq[0], rdev->cosq[1]);
-		return rc;
-	}
-
 	/* Actual priorities are not programmed as they are already
 	 * done by L2 driver; just enable or disable priority vlan tagging
 	 */
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index b802981..3f4998a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -679,21 +679,6 @@ int bnxt_qplib_free_fast_reg_page_list(struct bnxt_qplib_res *res,
 	return 0;
 }
 
-int bnxt_qplib_map_tc2cos(struct bnxt_qplib_res *res, u16 *cids)
-{
-	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
-	struct cmdq_map_tc_to_cos req;
-	struct creq_map_tc_to_cos_resp resp;
-	u16 cmd_flags = 0;
-
-	RCFW_CMD_PREP(req, MAP_TC_TO_COS, cmd_flags);
-	req.cos0 = cpu_to_le16(cids[0]);
-	req.cos1 = cpu_to_le16(cids[1]);
-
-	return bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
-						NULL, 0);
-}
-
 int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
 			      struct bnxt_qplib_roce_stats *stats)
 {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index 5939e8f..96e61db 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -277,7 +277,6 @@ int bnxt_qplib_alloc_fast_reg_page_list(struct bnxt_qplib_res *res,
 					struct bnxt_qplib_frpl *frpl, int max);
 int bnxt_qplib_free_fast_reg_page_list(struct bnxt_qplib_res *res,
 				       struct bnxt_qplib_frpl *frpl);
-int bnxt_qplib_map_tc2cos(struct bnxt_qplib_res *res, u16 *cids);
 int bnxt_qplib_get_roce_stats(struct bnxt_qplib_rcfw *rcfw,
 			      struct bnxt_qplib_roce_stats *stats);
 int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
-- 
2.5.5


--000000000000979f3e05f81af635
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILku1zXM3ss3
9eLr1SGSB3NfyK0Q6HYfGdSeGZjvm+9JMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDMzMDA5NDYxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAXKVcexAVa3hC8W2GgnSfF4mLBJOl4
T55eysYjH1/fIFl3gHG5DasM/EfNI+rsIoeU4BzxMd4Gw4nM0H/RlVsvR2qMvneE//B9Ggx88oy3
ZlR9ON/2U4uMJFGRtcgVqLc60yIWwt9u1NMAzYsVOHC669Oxz/ALpYph1y8CoZ3Q8gDCggHLJEzO
XdHYg3uOhc9myMtO5XHkOsvvR3WI4wXxAQBHnZMJ7wxrDY/Mv3/x5ycGfi0PicwSaDWXUegeh/+K
bgFNeSZVa4J7lbJQbllV0a1nh/eb5gyavcMWCjJEAqyJBGmbLYzgI6HLWwDo9JZRjVg+rZbLbsWh
vEmGblTu
--000000000000979f3e05f81af635--
