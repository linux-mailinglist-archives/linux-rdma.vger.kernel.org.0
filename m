Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28B87297F7
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 13:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjFILPN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbjFILOw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 07:14:52 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741752113
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 04:14:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b24ff03400so5464675ad.3
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jun 2023 04:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686309272; x=1688901272;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ASN40k/yFcJpFOWuJrr5d/NF8jU7yQC3EbzU4pUKJ4=;
        b=UHLUepjbuZrXBz/YLYIGfsNCoRgp3J1tCibnoRyGqRK25eI1kaOyTkdeObrlEi++pq
         tRLo77qtlk67H2MyktoNsj7EqQJHCbdwhztwXK47Vi0jCS3or02mFPYhwA4MZrIbdW6G
         KP/nm0fIaU2ABXnmecoiclmamg38pntkMaOu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686309272; x=1688901272;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ASN40k/yFcJpFOWuJrr5d/NF8jU7yQC3EbzU4pUKJ4=;
        b=gq3F3e2ti4eayFGCRrsHGixbhv80WdHswvt/OWpp88EzTRY6yLQNgpMuFB1N2OUMtC
         BOMP9d/WV3nQTtmZIXVWP69pSrAt6tKNny14nRBScTQWXW48iDmtKi7Mo3ciUjmLDX+r
         pc4tfOTiwTv32QwPAo6xoCc7OMYGe7p7LfQtVsq6EKKQRjjyAW3jxgBOIhAsGJz2fANO
         WEM0ds1LjmlR3JRuQq7MIjqRjAthAWMuJ4NRbESWGkQuCnRSnRc5AsIPRlPLcEjd/NQK
         HpnGooy4nkiqUfgrdc+uR+NACt9xVOFgD9sXHoMz+fm+aBVuZiy8izpT8Cz7WhkGmWjL
         Y7+g==
X-Gm-Message-State: AC+VfDyy8MVQHnMPOjit08jQ8fD/gNFgmOrw6GoeLFd0A1TeomXX+oq6
        IKaT4egBfSU7m4UZE7Lwoqy1uQ==
X-Google-Smtp-Source: ACHHUZ7QrMehRL3z1xe87jPf03y+XwK957BVX67/6vFLBk7E91qKvjGm8luWxZMceuF+BnGxWiYJBA==
X-Received: by 2002:a17:902:b203:b0:1b2:1667:2b9 with SMTP id t3-20020a170902b20300b001b2166702b9mr544018plr.58.1686309272463;
        Fri, 09 Jun 2023 04:14:32 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b001b0142908f7sm2992954plx.291.2023.06.09.04.14.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2023 04:14:31 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        kashyap.desai@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-next 07/17] RDMA/bnxt_re: use shadow qd while posting non blocking rcfw command
Date:   Fri,  9 Jun 2023 04:01:44 -0700
Message-Id: <1686308514-11996-8-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002f857905fdb079a8"
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

--0000000000002f857905fdb079a8

From: Kashyap Desai <kashyap.desai@broadcom.com>

Whenever there is a fast path IO and create/destroy resources from
the slow path is happening in parallel, we may notice high latency
of slow path command completion.

Introduces a shadow queue depth to prevent the outstanding requests
to the FW. Driver will not allow more than #RCFW_CMD_NON_BLOCKING_SHADOW_QD
non-blocking commands to the Firmware.

Shadow queue depth is a soft limit only for non-blocking
commands. Blocking commands will be posted to the firmware
as long as there is a free slot.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 60 +++++++++++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  3 ++
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 3c4f72a..f7d1238 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -281,8 +281,21 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	return 0;
 }
 
-int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
-				 struct bnxt_qplib_cmdqmsg *msg)
+/**
+ * __bnxt_qplib_rcfw_send_message   -	qplib interface to send
+ * and complete rcfw command.
+ * @rcfw      -   rcfw channel instance of rdev
+ * @msg      -    qplib message internal
+ *
+ * This function does not account shadow queue depth. It will send
+ * all the command unconditionally as long as send queue is not full.
+ *
+ * Returns:
+ * 0 if command completed by firmware.
+ * Non zero if the command is not completed by firmware.
+ */
+static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
+					  struct bnxt_qplib_cmdqmsg *msg)
 {
 	struct creq_qp_event *evnt = (struct creq_qp_event *)msg->resp;
 	u16 cookie;
@@ -331,6 +344,48 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 
 	return rc;
 }
+
+/**
+ * bnxt_qplib_rcfw_send_message   -	qplib interface to send
+ * and complete rcfw command.
+ * @rcfw      -   rcfw channel instance of rdev
+ * @msg      -    qplib message internal
+ *
+ * Driver interact with Firmware through rcfw channel/slow path in two ways.
+ * a. Blocking rcfw command send. In this path, driver cannot hold
+ * the context for longer period since it is holding cpu until
+ * command is not completed.
+ * b. Non-blocking rcfw command send. In this path, driver can hold the
+ * context for longer period. There may be many pending command waiting
+ * for completion because of non-blocking nature.
+ *
+ * Driver will use shadow queue depth. Current queue depth of 8K
+ * (due to size of rcfw message there can be actual ~4K rcfw outstanding)
+ * is not optimal for rcfw command processing in firmware.
+ *
+ * Restrict at max #RCFW_CMD_NON_BLOCKING_SHADOW_QD Non-Blocking rcfw commands.
+ * Allow all blocking commands until there is no queue full.
+ *
+ * Returns:
+ * 0 if command completed by firmware.
+ * Non zero if the command is not completed by firmware.
+ */
+int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
+				 struct bnxt_qplib_cmdqmsg *msg)
+{
+	int ret;
+
+	if (!msg->block) {
+		down(&rcfw->rcfw_inflight);
+		ret = __bnxt_qplib_rcfw_send_message(rcfw, msg);
+		up(&rcfw->rcfw_inflight);
+	} else {
+		ret = __bnxt_qplib_rcfw_send_message(rcfw, msg);
+	}
+
+	return ret;
+}
+
 /* Completions */
 static int bnxt_qplib_process_func_event(struct bnxt_qplib_rcfw *rcfw,
 					 struct creq_func_event *func_event)
@@ -932,6 +987,7 @@ int bnxt_qplib_enable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw,
 		return rc;
 	}
 
+	sema_init(&rcfw->rcfw_inflight, RCFW_CMD_NON_BLOCKING_SHADOW_QD);
 	bnxt_qplib_start_rcfw(rcfw);
 
 	return 0;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 32e5b67..862bfbf 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -66,6 +66,8 @@ static inline void bnxt_qplib_rcfw_cmd_prep(struct cmdq_base *req,
 	req->cmd_size = cmd_size;
 }
 
+/* Shadow queue depth for non blocking command */
+#define RCFW_CMD_NON_BLOCKING_SHADOW_QD	64
 #define RCFW_CMD_WAIT_TIME_MS		20000 /* 20 Seconds timeout */
 
 /* CMDQ elements */
@@ -197,6 +199,7 @@ struct bnxt_qplib_rcfw {
 	u64 oos_prev;
 	u32 init_oos_stats;
 	u32 cmdq_depth;
+	struct semaphore rcfw_inflight;
 };
 
 struct bnxt_qplib_cmdqmsg {
-- 
2.5.5


--0000000000002f857905fdb079a8
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFVMwiFgKG+8
Ei4fVN/uoxQkFwC/4fhyGio4f/mKaa8MMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwOTExMTQzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAV695f4dxyLxjMdx2SKBYmgRvik2x6
CXc3NDeSNoKjcWKGmQMbjIOUGikh6igLcp3+DKZz4iFqnTxYNtPU494DveUQdDY5mSziMJvaZ1V/
aIoXoKqlHglkXiSfMIIh8gu73QR8Z6Oe876gBiJDG1q2UBIA2b4WKQCguG4UBu/uTTvq2Cv6bdNS
qQhjZvfMeB3js5xOxmHdYMustwDNcsM2vpQeCC+ZMxrYAwXYwJvTzPIFPNp9OAOXShQ+vkZfE/Cf
EX8o+Q8FxxgkG8wJ3u/OR2RTq+0wp8xUH4SaRechxcoqZYxlsnXFC+vb0sNAhLBasUif0JNqpK1v
Wf3alsmF
--0000000000002f857905fdb079a8--
