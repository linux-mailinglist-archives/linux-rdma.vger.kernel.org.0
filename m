Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A871F7297FB
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbjFILPS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 07:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239926AbjFILPC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 07:15:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE74A2115
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 04:14:43 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b038064d97so5592835ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jun 2023 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686309283; x=1688901283;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DSJFJVP9qNUfQOXdly2r4DfHO/Ic/jAMYLwSd/nsOX8=;
        b=UdSgTgitImBSph55s1STsbseiDXMd8M3pbkpbbFaUguy8D12ZbIu6V7VhEI7gC7t99
         g+JXv+MIsZgo9DPG4OyMFU23cKl6SsDmXImnQwgvmRLue4+j5VGMKtK0iZMNGDQ+ZIrL
         Cl02qtLiuHjeugBEkTe3pcfJn+a6Gak1g87Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686309283; x=1688901283;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSJFJVP9qNUfQOXdly2r4DfHO/Ic/jAMYLwSd/nsOX8=;
        b=lrRwzAKhXKUg+FqYvkaJkf/sBObL0FxE5ajJRTm8RnuDF1q8Qhim1pMqxFDuvwKG4R
         yKBlfGx20jkfoX9S2AZesqwrAPiFgoKBvaa3IxkchgiyvSLRDnlgJXiEe/7kWYhZYhwS
         2lpEu+FLjByIjYzgd17CIh85rx71VAdS/txEAFFpPdq7u/XCRcO5gESoBticb2bqv+BJ
         KOOPNVqgaFhXRVJDAl0BN8BPgt6z99jRoCJVWrhTCUIgK3rJnpmnKRfzwkZHP0xHYAo+
         KVuQvhFoO8Z3loXSCH7Bk9oljEEHdNELAKIE2eE3Rk+OMb0jiA41UVAI8BftRO7gq25b
         VclA==
X-Gm-Message-State: AC+VfDzQIt770luGAxP+HdKwrwb6UwIPL4yeXDCeTqF1E15haNkLmhQe
        2OSHpUgjJsbLpsA0VXu0O3XwTQ==
X-Google-Smtp-Source: ACHHUZ5PbTmiPbmR1nsDrdYiUz8fUZEcogYKb9FKLWsTaMemCMWtrQvFH39YlYNXhZRLEEwr6+gAiw==
X-Received: by 2002:a17:903:32cd:b0:1af:e302:123 with SMTP id i13-20020a17090332cd00b001afe3020123mr1958343plr.3.1686309283242;
        Fri, 09 Jun 2023 04:14:43 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b001b0142908f7sm2992954plx.291.2023.06.09.04.14.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2023 04:14:42 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        kashyap.desai@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-next 11/17] RDMA/bnxt_re: Add firmware stall check detection
Date:   Fri,  9 Jun 2023 04:01:48 -0700
Message-Id: <1686308514-11996-12-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686308514-11996-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d4e6a005fdb07956"
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

--000000000000d4e6a005fdb07956

From: Kashyap Desai <kashyap.desai@broadcom.com>

Every completion will update last_seen value in the unit of jiffies.
last_seen field will be used to know if firmware is alive and
is useful to detect firmware stall.

Non blocking interface __wait_for_resp will have logic to detect
firmware stall. After every 10 second interval if __wait_for_resp
has not received completion for a given command it will check for
firmware stall condition.

If current jiffies is greater than last_seen
jiffies + RCFW_FW_STALL_TIMEOUT_SEC * HZ, it is a firmware stall.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 44 ++++++++++++++++++++++++------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  5 ++--
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 4e5f66e..349fbed 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -112,11 +112,13 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 	do {
 		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
 			return bnxt_qplib_map_rc(opcode);
+		if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
+			return -ETIMEDOUT;
 
-		/* Non zero means command completed */
 		wait_event_timeout(cmdq->waitq,
 				   !test_bit(cbit, cmdq->cmdq_bitmap),
-				   msecs_to_jiffies(10000));
+				   msecs_to_jiffies(RCFW_FW_STALL_TIMEOUT_SEC
+						    * 1000));
 
 		if (!test_bit(cbit, cmdq->cmdq_bitmap))
 			return 0;
@@ -126,6 +128,11 @@ static int __wait_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 		if (!test_bit(cbit, cmdq->cmdq_bitmap))
 			return 0;
 
+		/* Firmware stall is detected */
+		if (time_after(jiffies, cmdq->last_seen +
+			      (RCFW_FW_STALL_TIMEOUT_SEC * HZ)))
+			return -ENODEV;
+
 	} while (true);
 };
 
@@ -154,6 +161,8 @@ static int __block_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie, u8 opcode)
 	do {
 		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
 			return bnxt_qplib_map_rc(opcode);
+		if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
+			return -ETIMEDOUT;
 
 		udelay(1);
 
@@ -184,9 +193,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw,
 	hwq = &cmdq->hwq;
 	pdev = rcfw->pdev;
 
-	if (test_bit(FIRMWARE_TIMED_OUT, &cmdq->flags))
-		return -ETIMEDOUT;
-
 	/* Cmdq are in 16-byte units, each request can consume 1 or more
 	 * cmdqe
 	 */
@@ -285,14 +291,21 @@ static int __poll_for_resp(struct bnxt_qplib_rcfw *rcfw, u16 cookie,
 	do {
 		if (test_bit(ERR_DEVICE_DETACHED, &cmdq->flags))
 			return bnxt_qplib_map_rc(opcode);
+		if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
+			return -ETIMEDOUT;
 
 		usleep_range(1000, 1001);
 
 		bnxt_qplib_service_creq(&rcfw->creq.creq_tasklet);
 		if (!test_bit(cbit, cmdq->cmdq_bitmap))
 			return 0;
-		if (jiffies_to_msecs(jiffies - issue_time) > 10000)
-			return -ETIMEDOUT;
+		if (jiffies_to_msecs(jiffies - issue_time) >
+		    (RCFW_FW_STALL_TIMEOUT_SEC * 1000)) {
+			/* Firmware stall is detected */
+			if (time_after(jiffies, cmdq->last_seen +
+				      (RCFW_FW_STALL_TIMEOUT_SEC * HZ)))
+				return -ENODEV;
+		}
 	} while (true);
 };
 
@@ -308,6 +321,8 @@ static int __send_message_basic_sanity(struct bnxt_qplib_rcfw *rcfw,
 	/* Prevent posting if f/w is not in a state to process */
 	if (test_bit(ERR_DEVICE_DETACHED, &rcfw->cmdq.flags))
 		return -ENXIO;
+	if (test_bit(FIRMWARE_STALL_DETECTED, &cmdq->flags))
+		return -ETIMEDOUT;
 
 	if (test_bit(FIRMWARE_INITIALIZED_FLAG, &cmdq->flags) &&
 	    opcode == CMDQ_BASE_OPCODE_INITIALIZE_FW) {
@@ -375,7 +390,6 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		/* timed out */
 		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x timedout (%d)msec\n",
 			cookie, opcode, RCFW_CMD_WAIT_TIME_MS);
-		set_bit(FIRMWARE_TIMED_OUT, &rcfw->cmdq.flags);
 		return rc;
 	}
 
@@ -383,6 +397,8 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		spin_lock_irqsave(&rcfw->cmdq.hwq.lock, flags);
 		crsqe = &rcfw->crsqe_tbl[cbit];
 		crsqe->is_waiter_alive = false;
+		if (rc == -ENODEV)
+			set_bit(FIRMWARE_STALL_DETECTED, &rcfw->cmdq.flags);
 		spin_unlock_irqrestore(&rcfw->cmdq.hwq.lock, flags);
 		return -ETIMEDOUT;
 	}
@@ -533,6 +549,17 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 		cookie &= RCFW_MAX_COOKIE_VALUE;
 		cbit = cookie % rcfw->cmdq_depth;
 		crsqe = &rcfw->crsqe_tbl[cbit];
+
+		if (WARN_ONCE(test_bit(FIRMWARE_STALL_DETECTED,
+				       &rcfw->cmdq.flags),
+		    "QPLIB: Unreponsive rcfw channel detected.!!")) {
+			dev_info(&pdev->dev,
+				 "rcfw timedout: cookie = %#x, free_slots = %d",
+				 cookie, crsqe->free_slots);
+			spin_unlock_irqrestore(&hwq->lock, flags);
+			return rc;
+		}
+
 		if (!test_and_clear_bit(cbit, rcfw->cmdq.cmdq_bitmap))
 			dev_warn(&pdev->dev,
 				 "CMD bit %d was not requested\n", cbit);
@@ -582,6 +609,7 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 		 * reading any further.
 		 */
 		dma_rmb();
+		rcfw->cmdq.last_seen = jiffies;
 
 		type = creqe->type & CREQ_BASE_TYPE_MASK;
 		switch (type) {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 6ed81c1..54576f1 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -51,6 +51,7 @@
 
 #define RCFW_DBR_PCI_BAR_REGION		2
 #define RCFW_DBR_BASE_PAGE_SHIFT	12
+#define RCFW_FW_STALL_TIMEOUT_SEC	40
 
 /* Cmdq contains a fix number of a 16-Byte slots */
 struct bnxt_qplib_cmdqe {
@@ -128,7 +129,6 @@ static inline u32 bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
 
 #define RCFW_MAX_COOKIE_VALUE		(BNXT_QPLIB_CMDQE_MAX_CNT - 1)
 #define RCFW_CMD_IS_BLOCKING		0x8000
-#define RCFW_BLOCKED_CMD_WAIT_COUNT	20000000UL /* 20 sec */
 
 /* Crsq buf is 1024-Byte */
 struct bnxt_qplib_crsbe {
@@ -170,7 +170,7 @@ struct bnxt_qplib_qp_node {
 
 #define FIRMWARE_INITIALIZED_FLAG	(0)
 #define FIRMWARE_FIRST_FLAG		(31)
-#define FIRMWARE_TIMED_OUT		(3)
+#define FIRMWARE_STALL_DETECTED		(3)
 #define ERR_DEVICE_DETACHED             (4)
 
 struct bnxt_qplib_cmdq_mbox {
@@ -185,6 +185,7 @@ struct bnxt_qplib_cmdq_ctx {
 	wait_queue_head_t		waitq;
 	unsigned long			flags;
 	unsigned long			*cmdq_bitmap;
+	unsigned long			last_seen;
 	u32				seq_num;
 };
 
-- 
2.5.5


--000000000000d4e6a005fdb07956
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINBlNhF/pyuK
i/Wlpui4HH86b4Rt3ZM9mUaQOhC5zhTCMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwOTExMTQ0M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCA9Mf6iAEy47LGMPdXd4iallyps5UY
qGe7TQ2rO99mg61NGsAF4ybzBeS66kyhobQ2aMwkOOAN7x2i1Ly6au2HfnCtg8zr6AX8VKmZt5wl
Ljys1W+c2LoawbJhmdWhn3d7SYsrA3QLJ2ubyv/niRv9IlOW/TJcQBqDAUd6N8rzyde1G7mBA6tD
JrmlXELkfe4a0NokbY/mfJXBNCgGhmFPigPt9vJYJKw7uP0exgvHysfE5pROBHE9nmN4RClQvDjl
47itGhqTOWfJwNZqTu0FrIjUEazREjR5iq3KguLb8lGKK0doAgJyHS7PDz9iBnXvWDuAzvNTtxP8
4c/MGBjq
--000000000000d4e6a005fdb07956--
