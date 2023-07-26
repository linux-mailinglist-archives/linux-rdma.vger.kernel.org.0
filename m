Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03917639F4
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jul 2023 17:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjGZPD3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jul 2023 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbjGZPDW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Jul 2023 11:03:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD47B268B
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 08:03:12 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6689430d803so4268534b3a.0
        for <linux-rdma@vger.kernel.org>; Wed, 26 Jul 2023 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690383792; x=1690988592;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m9mKs7uY/0Ne3DjWAsDg60QAQdbixw6cAo+bC7Y1VdU=;
        b=DhHjexB4g10XALDPq3DlZrza/ImoWJvTXJRdLWLVXOeqGJ3osnxtT6yPIg5T0QQUxz
         a5Tc1mKRwKsIwfnOWPxRfYi8O2WnVJ6Mm0jXOJ+RS3qB8ulYerccUmhgiecJAs1vXJYT
         LsRns7F8VW9A2JumSA+6AgQ+UugF35oI+FInY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383792; x=1690988592;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9mKs7uY/0Ne3DjWAsDg60QAQdbixw6cAo+bC7Y1VdU=;
        b=L+mcI92VURgzt/qdNMEeLrzKoO+klXx+in67UBANmV/kqI0Tx1eLuZE4ckdxu1Cjro
         I0KXhW3acjnNNl/T6tddInCMiyQAy/zSALUgM5NGnjdxzxY9/AkxgAYKHink5WnXuafd
         Fl6jQkK94RMspbbkeEPRHISZj2dmrvKYy7d0711muGCA7vj7dXCfTP2NNsbtcQxvencN
         He1b++VgdTAMWSI8kB9dGY05AAsZpM2Ki2thjMXl1uOe2M0Cs+V8teP5bltGXH7tGx7B
         183VebMoCBhboXGdrq9rZRNwuxGfah5/DSYby5Mr82401c/cktqcEyrcC8Kie3LU2b0f
         jXXg==
X-Gm-Message-State: ABy/qLbBSLuARB0qRVljp2mtm3UofxjMgqmNjWleiqQPIxsCCKc9hvb2
        +dCxApm2JmpfvCXiWHRMMxRyNw==
X-Google-Smtp-Source: APBJJlFaNtCGhoMkWz5rWTCnP7PQk04Ce/FIbPnpldvEOGoaJ6CezI7a7N77ap3JMWmI1KMM0HQUIw==
X-Received: by 2002:a05:6a20:4425:b0:131:4a64:9977 with SMTP id ce37-20020a056a20442500b001314a649977mr2573701pzb.50.1690383790584;
        Wed, 26 Jul 2023 08:03:10 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id y4-20020a63ad44000000b0055fd10306a2sm12772846pgo.75.2023.07.26.08.03.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jul 2023 08:03:09 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 3/4] bnxt_re: Expose the missing hw counters
Date:   Wed, 26 Jul 2023 07:51:20 -0700
Message-Id: <1690383081-15033-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1690383081-15033-1-git-send-email-selvin.xavier@broadcom.com>
References: <1690383081-15033-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007def2f06016525cf"
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

--0000000000007def2f06016525cf

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Add code to expose some of the HW counters related
to tx/rx data and Congestion control.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 25 +++++++++++++++++++++++--
 drivers/infiniband/hw/bnxt_re/hw_counters.h |  9 +++++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  7 +++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 8598af5..e50a1cb 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -82,6 +82,8 @@ static const struct rdma_stat_desc bnxt_re_stat_descs[] = {
 	[BNXT_RE_TX_PKTS].name		=  "tx_pkts",
 	[BNXT_RE_TX_BYTES].name		=  "tx_bytes",
 	[BNXT_RE_RECOVERABLE_ERRORS].name	=  "recoverable_errors",
+	[BNXT_RE_TX_ERRORS].name                =  "tx_roce_errors",
+	[BNXT_RE_TX_DISCARDS].name              =  "tx_roce_discards",
 	[BNXT_RE_RX_ERRORS].name		=  "rx_roce_errors",
 	[BNXT_RE_RX_DISCARDS].name		=  "rx_roce_discards",
 	[BNXT_RE_TO_RETRANSMITS].name        = "to_retransmits",
@@ -129,14 +131,21 @@ static const struct rdma_stat_desc bnxt_re_stat_descs[] = {
 	[BNXT_RE_TX_READ_RES].name	     = "tx_read_resp",
 	[BNXT_RE_TX_WRITE_REQ].name	     = "tx_write_req",
 	[BNXT_RE_TX_SEND_REQ].name	     = "tx_send_req",
+	[BNXT_RE_TX_ROCE_PKTS].name          = "tx_roce_only_pkts",
+	[BNXT_RE_TX_ROCE_BYTES].name         = "tx_roce_only_bytes",
 	[BNXT_RE_RX_ATOMIC_REQ].name	     = "rx_atomic_req",
 	[BNXT_RE_RX_READ_REQ].name	     = "rx_read_req",
 	[BNXT_RE_RX_READ_RESP].name	     = "rx_read_resp",
 	[BNXT_RE_RX_WRITE_REQ].name	     = "rx_write_req",
 	[BNXT_RE_RX_SEND_REQ].name	     = "rx_send_req",
+	[BNXT_RE_RX_ROCE_PKTS].name          = "rx_roce_only_pkts",
+	[BNXT_RE_RX_ROCE_BYTES].name         = "rx_roce_only_bytes",
 	[BNXT_RE_RX_ROCE_GOOD_PKTS].name     = "rx_roce_good_pkts",
 	[BNXT_RE_RX_ROCE_GOOD_BYTES].name    = "rx_roce_good_bytes",
-	[BNXT_RE_OOB].name		     = "rx_out_of_buffer"
+	[BNXT_RE_OOB].name		     = "rx_out_of_buffer",
+	[BNXT_RE_TX_CNP].name                = "tx_cnp_pkts",
+	[BNXT_RE_RX_CNP].name                = "rx_cnp_pkts",
+	[BNXT_RE_RX_ECN].name                = "rx_ecn_marked_pkts",
 };
 
 static void bnxt_re_copy_ext_stats(struct bnxt_re_dev *rdev,
@@ -148,14 +157,22 @@ static void bnxt_re_copy_ext_stats(struct bnxt_re_dev *rdev,
 	stats->value[BNXT_RE_TX_READ_RES]   = s->tx_read_res;
 	stats->value[BNXT_RE_TX_WRITE_REQ]  = s->tx_write_req;
 	stats->value[BNXT_RE_TX_SEND_REQ]   = s->tx_send_req;
+	stats->value[BNXT_RE_TX_ROCE_PKTS]  = s->tx_roce_pkts;
+	stats->value[BNXT_RE_TX_ROCE_BYTES] = s->tx_roce_bytes;
 	stats->value[BNXT_RE_RX_ATOMIC_REQ] = s->rx_atomic_req;
 	stats->value[BNXT_RE_RX_READ_REQ]   = s->rx_read_req;
 	stats->value[BNXT_RE_RX_READ_RESP]  = s->rx_read_res;
 	stats->value[BNXT_RE_RX_WRITE_REQ]  = s->rx_write_req;
 	stats->value[BNXT_RE_RX_SEND_REQ]   = s->rx_send_req;
+	stats->value[BNXT_RE_RX_ROCE_PKTS]  = s->rx_roce_pkts;
+	stats->value[BNXT_RE_RX_ROCE_BYTES] = s->rx_roce_bytes;
 	stats->value[BNXT_RE_RX_ROCE_GOOD_PKTS] = s->rx_roce_good_pkts;
 	stats->value[BNXT_RE_RX_ROCE_GOOD_BYTES] = s->rx_roce_good_bytes;
 	stats->value[BNXT_RE_OOB] = s->rx_out_of_buffer;
+	stats->value[BNXT_RE_TX_CNP] = s->tx_cnp;
+	stats->value[BNXT_RE_RX_CNP] = s->rx_cnp;
+	stats->value[BNXT_RE_RX_ECN] = s->rx_ecn_marked;
+	stats->value[BNXT_RE_OUT_OF_SEQ_ERR] = s->rx_out_of_sequence;
 }
 
 static int bnxt_re_get_ext_stat(struct bnxt_re_dev *rdev,
@@ -298,6 +315,10 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 	if (hw_stats) {
 		stats->value[BNXT_RE_RECOVERABLE_ERRORS] =
 			le64_to_cpu(hw_stats->tx_bcast_pkts);
+		stats->value[BNXT_RE_TX_DISCARDS] =
+			le64_to_cpu(hw_stats->tx_discard_pkts);
+		stats->value[BNXT_RE_TX_ERRORS] =
+			le64_to_cpu(hw_stats->tx_error_pkts);
 		stats->value[BNXT_RE_RX_ERRORS] =
 			le64_to_cpu(hw_stats->rx_error_pkts);
 		stats->value[BNXT_RE_RX_DISCARDS] =
@@ -319,6 +340,7 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 				  &rdev->flags);
 			goto done;
 		}
+		bnxt_re_copy_err_stats(rdev, stats, err_s);
 		if (_is_ext_stats_supported(rdev->dev_attr.dev_cap_flags) &&
 		    !rdev->is_virtfn) {
 			rc = bnxt_re_get_ext_stat(rdev, stats);
@@ -328,7 +350,6 @@ int bnxt_re_ib_get_hw_stats(struct ib_device *ibdev,
 				goto done;
 			}
 		}
-		bnxt_re_copy_err_stats(rdev, stats, err_s);
 	}
 
 done:
diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.h b/drivers/infiniband/hw/bnxt_re/hw_counters.h
index 7231a2b..f3c4e35 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.h
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.h
@@ -65,6 +65,8 @@ enum bnxt_re_hw_stats {
 	BNXT_RE_TX_PKTS,
 	BNXT_RE_TX_BYTES,
 	BNXT_RE_RECOVERABLE_ERRORS,
+	BNXT_RE_TX_ERRORS,
+	BNXT_RE_TX_DISCARDS,
 	BNXT_RE_RX_ERRORS,
 	BNXT_RE_RX_DISCARDS,
 	BNXT_RE_TO_RETRANSMITS,
@@ -112,14 +114,21 @@ enum bnxt_re_hw_stats {
 	BNXT_RE_TX_READ_RES,
 	BNXT_RE_TX_WRITE_REQ,
 	BNXT_RE_TX_SEND_REQ,
+	BNXT_RE_TX_ROCE_PKTS,
+	BNXT_RE_TX_ROCE_BYTES,
 	BNXT_RE_RX_ATOMIC_REQ,
 	BNXT_RE_RX_READ_REQ,
 	BNXT_RE_RX_READ_RESP,
 	BNXT_RE_RX_WRITE_REQ,
 	BNXT_RE_RX_SEND_REQ,
+	BNXT_RE_RX_ROCE_PKTS,
+	BNXT_RE_RX_ROCE_BYTES,
 	BNXT_RE_RX_ROCE_GOOD_PKTS,
 	BNXT_RE_RX_ROCE_GOOD_BYTES,
 	BNXT_RE_OOB,
+	BNXT_RE_TX_CNP,
+	BNXT_RE_RX_CNP,
+	BNXT_RE_RX_ECN,
 	BNXT_RE_NUM_EXT_COUNTERS
 };
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index ab45f9d..7e57faa 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -832,15 +832,22 @@ int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 	estat->tx_read_res = le64_to_cpu(sb->tx_read_res_pkts);
 	estat->tx_write_req = le64_to_cpu(sb->tx_write_req_pkts);
 	estat->tx_send_req = le64_to_cpu(sb->tx_send_req_pkts);
+	estat->tx_roce_pkts = le64_to_cpu(sb->tx_roce_pkts);
+	estat->tx_roce_bytes = le64_to_cpu(sb->tx_roce_bytes);
 	estat->rx_atomic_req = le64_to_cpu(sb->rx_atomic_req_pkts);
 	estat->rx_read_req = le64_to_cpu(sb->rx_read_req_pkts);
 	estat->rx_read_res = le64_to_cpu(sb->rx_read_res_pkts);
 	estat->rx_write_req = le64_to_cpu(sb->rx_write_req_pkts);
 	estat->rx_send_req = le64_to_cpu(sb->rx_send_req_pkts);
+	estat->rx_roce_pkts = le64_to_cpu(sb->rx_roce_pkts);
+	estat->rx_roce_bytes = le64_to_cpu(sb->rx_roce_bytes);
 	estat->rx_roce_good_pkts = le64_to_cpu(sb->rx_roce_good_pkts);
 	estat->rx_roce_good_bytes = le64_to_cpu(sb->rx_roce_good_bytes);
 	estat->rx_out_of_buffer = le64_to_cpu(sb->rx_out_of_buffer_pkts);
 	estat->rx_out_of_sequence = le64_to_cpu(sb->rx_out_of_sequence_pkts);
+	estat->tx_cnp = le64_to_cpu(sb->tx_cnp_pkts);
+	estat->rx_cnp = le64_to_cpu(sb->rx_cnp_pkts);
+	estat->rx_ecn_marked = le64_to_cpu(sb->rx_ecn_marked_pkts);
 
 bail:
 	bnxt_qplib_rcfw_free_sbuf(rcfw, sbuf);
-- 
2.5.5


--0000000000007def2f06016525cf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQfAYJKoZIhvcNAQcCoIIQbTCCEGkCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3TMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVswggRDoAMCAQICDHL4K7jH/uUzTPFjtzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE4NDdaFw0yNTA5MTAwODE4NDdaMIGc
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xIjAgBgNVBAMTGVNlbHZpbiBUaHlwYXJhbXBpbCBYYXZpZXIx
KTAnBgkqhkiG9w0BCQEWGnNlbHZpbi54YXZpZXJAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEA4/0O+hycwcsNi4j4tTBav8CvSVzv5i1Zk0tYtK7mzA3r8Ij35v5j
L2NsFikHjmHCDfvkP6XrWLSnobeEI4CV0PyrqRVpjZ3XhMPi2M2abxd8BWSGDhd0d8/j8VcjRTuT
fqtDSVGh1z3bqKegUA5r3mbucVWPoIMnjjCLCCim0sJQFblBP+3wkgAWdBcRr/apKCrKhnk0FjpC
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKQHa/rGp8E5
QNa9SVOuSTx0i/xkf3LOn3Iw41GHhY76MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDcyNjE1MDMxMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCKsR1jfroFUdeqEcsHr+kYW2jyTkWW
bXQtr7CCSL75RAnik8JoHiPKmYBBuelAdExZ2lH8ypCZWcBVAhKPTPxuyru3Tmn92oyS/POeGfbg
iMFUMhJ0SCitz4hegRsmxNk3RDQDtCwwo6rh/Yey78GG6BAYKHfh2at9PB20lhNizl5HwxtLc9ye
qcrGq58fvP88Z6Z4w64mNJD2CCAXscQOYwncnQ2X+6EQMyz3pexI6XOPkFT+NhULabn91JrgGn4Y
LqpQyMcBzR2jK+Ml/ZbQp/0UqtYsPorYgebpfFiR1vFViw6Ur0dbqfqzkqgtLtiiijtlTfKWqaM9
lv4TQ9Pn
--0000000000007def2f06016525cf--
