Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC7727CF3
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jun 2023 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbjFHKhK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Jun 2023 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbjFHKhI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Jun 2023 06:37:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AC3E4D
        for <linux-rdma@vger.kernel.org>; Thu,  8 Jun 2023 03:37:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b01bd7093aso1883995ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 08 Jun 2023 03:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686220622; x=1688812622;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gLutcpfZkuIDhI7geDLcW1Kg2azRF+u1Y0FLWhLWpEk=;
        b=TfQm9WTlj0sec30yeVfRQvfC0v0PGUJKyDoyQQ1rIUfFKWdWBN0ydzULrrxJLlVKkz
         jrL3vSyZrKDeNrgLmdBl8xnr/Mn9OrXuQuSlbsMUvir6ldkBmg6i64bGtA83HTKdpq/D
         7l3p1CqR6zwaBJj0LSlLP5lYsE7ESlkYZ0Lc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220622; x=1688812622;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLutcpfZkuIDhI7geDLcW1Kg2azRF+u1Y0FLWhLWpEk=;
        b=AEGKz9VBZ7Lo5lXTTwFqW4x+a261+Kx/qW1FIsMIloOh3kh2ikOxxnAdIcBwi6o4Hp
         MVwX/LcI6knsyoHyocW8eSJG2oGTfmmxGRrPzpFCjB82gtkl3AYeY6KXcLn52b0hB0zU
         OFCwEneC7znaNDKpx17h+Q6slLobNhkvrQvDMx2UCkFikZCOdYzESvxP/OVU2FiJPUfI
         gfkaQ+6ezuWSp9EsZ1aCYGdeTIvYED5b/GibeGELSYuhoj3ItMT3fEzW/Q2aN9XIFe1w
         FJsLyxa/+4CD3PJLEUfbTJWzntnJJzKKvXp3k1aBLpztojeHjDQZK0n2ihYp9OEqW8ok
         soEA==
X-Gm-Message-State: AC+VfDyhES4ELaYDaqovQDFGqHmj9/nTBVBjEwj6G4fMv3OO/Qe1FniH
        vFYDLNP+WSPkT+rX3BgOkHGgBA==
X-Google-Smtp-Source: ACHHUZ6AjQjteJ795O1PfMU5v0UvQSt4kzOicM+8lfDyIBwFHjVAamvvceGk9NYClWP67doLN976oA==
X-Received: by 2002:a17:902:7b96:b0:1ac:451d:34b with SMTP id w22-20020a1709027b9600b001ac451d034bmr4876321pll.9.1686220622048;
        Thu, 08 Jun 2023 03:37:02 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001a980a23802sm1128510plb.111.2023.06.08.03.36.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:37:01 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 02/17] RDMA/bnxt_re: Avoid calling wake_up threads from spin_lock context
Date:   Thu,  8 Jun 2023 03:24:53 -0700
Message-Id: <1686219908-11181-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
References: <1686219908-11181-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000035e62a05fd9bd572"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000035e62a05fd9bd572

From: Kashyap Desai <kashyap.desai@broadcom.com>

bnxt_qplib_service_creq can be called from interrupt or tasklet or
process context. So the function take irq variant  of spin_lock.
But when wake_up is invoked with the lock held, it is putting the
calling context to sleep.

[exception RIP: __wake_up_common+190]
RIP: ffffffffb7539d7e  RSP: ffffa73300207ad8  RFLAGS: 00000083
RAX: 0000000000000001  RBX: ffff91fa295f69b8  RCX: dead000000000200
RDX: ffffa733344af940  RSI: ffffa73336527940  RDI: ffffa73336527940
RBP: 000000000000001c   R8: 0000000000000002   R9: 00000000000299c0
R10: 0000017230de82c5  R11: 0000000000000002  R12: ffffa73300207b28
R13: 0000000000000000  R14: ffffa733341bf928  R15: 0000000000000000
ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018

Call the wakeup after releasing the lock.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index d4ce82b..c11b8e7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -295,7 +295,8 @@ static int bnxt_qplib_process_func_event(struct bnxt_qplib_rcfw *rcfw,
 }
 
 static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
-				       struct creq_qp_event *qp_event)
+				       struct creq_qp_event *qp_event,
+				       u32 *num_wait)
 {
 	struct creq_qp_error_notification *err_event;
 	struct bnxt_qplib_hwq *hwq = &rcfw->cmdq.hwq;
@@ -304,6 +305,7 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	u16 cbit, blocked = 0;
 	struct pci_dev *pdev;
 	unsigned long flags;
+	u32 wait_cmds = 0;
 	__le16  mcookie;
 	u16 cookie;
 	int rc = 0;
@@ -363,9 +365,10 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 		crsqe->req_size = 0;
 
 		if (!blocked)
-			wake_up(&rcfw->cmdq.waitq);
+			wait_cmds++;
 		spin_unlock_irqrestore(&hwq->lock, flags);
 	}
+	*num_wait += wait_cmds;
 	return rc;
 }
 
@@ -379,6 +382,7 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 	struct creq_base *creqe;
 	u32 sw_cons, raw_cons;
 	unsigned long flags;
+	u32 num_wakeup = 0;
 
 	/* Service the CREQ until budget is over */
 	spin_lock_irqsave(&hwq->lock, flags);
@@ -397,7 +401,8 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 		switch (type) {
 		case CREQ_BASE_TYPE_QP_EVENT:
 			bnxt_qplib_process_qp_event
-				(rcfw, (struct creq_qp_event *)creqe);
+				(rcfw, (struct creq_qp_event *)creqe,
+				 &num_wakeup);
 			creq->stats.creq_qp_event_processed++;
 			break;
 		case CREQ_BASE_TYPE_FUNC_EVENT:
@@ -425,6 +430,8 @@ static void bnxt_qplib_service_creq(struct tasklet_struct *t)
 				      rcfw->res->cctx, true);
 	}
 	spin_unlock_irqrestore(&hwq->lock, flags);
+	if (num_wakeup)
+		wake_up_nr(&rcfw->cmdq.waitq, num_wakeup);
 }
 
 static irqreturn_t bnxt_qplib_creq_irq(int irq, void *dev_instance)
-- 
2.5.5


--00000000000035e62a05fd9bd572
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIC77VvAsiPQJ
8kwcKXuK46QYnMptw/Ah87TWrBKoCQDKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYwODEwMzcwMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQANgCh7dora62sNkRonngb1zJsRO4aR
V129DkuXGP36RtHkJ9F9GJJHsFtgsBuyxW4m4jV5ljkO7/ZP6Z9JxpJYlKl3DeW9JXhcJ1Vj9xMN
+Urs2om72mh5/eiVipVdo98Tfj2q8xN4guBDrbPOyLsiMzTERZnQ+4yEA1k7RcR3+GLGsYkx62rx
qhERnsoBF0M5rOXa4iZkk9RINYfQ2y/DNIb8xIZlKPDX6GT1aOghJykt5ePyrWQXUAAIoR6dUmN3
yOh7Luh4ThLBpjVgVcTmnlAVYZrqr5ZSiyQysu5/as60Qx8uYwSTuNpKfD1x/yu0Skz6nB5TSweB
tE4GIfuV
--00000000000035e62a05fd9bd572--
