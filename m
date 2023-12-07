Return-Path: <linux-rdma+bounces-305-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33965808655
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 12:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E8B1C21F4C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECED35299;
	Thu,  7 Dec 2023 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XQHOkoGE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6384FD1
	for <linux-rdma@vger.kernel.org>; Thu,  7 Dec 2023 03:04:38 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2865742e256so663331a91.0
        for <linux-rdma@vger.kernel.org>; Thu, 07 Dec 2023 03:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701947078; x=1702551878; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6hloazeFIBBTLjbVcky69qKJPQLVODn5hmZGYfWnCzI=;
        b=XQHOkoGEhNRvwPR0vXOddDKzgAX9+yFYuPINmpX4f8snakYFPDuPxSKq09+Wjoh/v8
         vFjpTNMv602F1fLDKuijx2+5ANlzwdKjiVl9xHRRfvysZNaMSsCIW8koeyNiKr+G1Rcs
         cWxHxil7PP+e6cQ42EL6hbKimt3t8m5tN8bgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701947078; x=1702551878;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hloazeFIBBTLjbVcky69qKJPQLVODn5hmZGYfWnCzI=;
        b=HjrJM22NVlpPJeBYklj0t95rgwr52jmriSAdSGA8rv2n0cjzEI9MAtwlC6GO47IE0V
         kfvqvlSAQQ/gVF/D1pLlShaelUFk4vBvlL/fH1Y3TnGN1tS/bBDjLcUh9GeqAo3p3Rnt
         DaGSSLllHuUi/KgXAW5B7X+Om0Q3zHyN6xnGzfaxNNF/cjTJmFAR61Pi99iucQeey9cy
         d7bka/SG6anGdAmtzmBZA5kG/pd2sSS+5IhHe5CX/iksG5JU+lEXjX/NuLxMpKRBtakC
         aqv6/9shbR6cM51mT5QAgM2gu0VZh4MllB75DZHR6YCzF/k/btUyxbYYLcOHrPrx8nGr
         3TKQ==
X-Gm-Message-State: AOJu0YyDAHs0X8tnSOgWe1bGcsmkQYzUdmEFOlKV5ECi/Rvz3JnP4L9b
	GoB2g4NWV5MYEQtRxAzjODmuhg==
X-Google-Smtp-Source: AGHT+IF6D0vJjfsX/woVF5fxZd4fOWGYVjWqAckHu/W97SCKu4DmkIVE9q08Htf12cKDyKXBZlu9zg==
X-Received: by 2002:a17:90a:7064:b0:286:ec45:d397 with SMTP id f91-20020a17090a706400b00286ec45d397mr1847588pjk.26.1701947077714;
        Thu, 07 Dec 2023 03:04:37 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id pm2-20020a17090b3c4200b00285db538b17sm1034254pjb.41.2023.12.07.03.04.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 03:04:37 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 5/6] RDMA/bnxt_re: Doorbell changes
Date: Thu,  7 Dec 2023 02:47:39 -0800
Message-Id: <1701946060-13931-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1701946060-13931-1-git-send-email-selvin.xavier@broadcom.com>
References: <1701946060-13931-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000054d72060be96fc8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

--000000000000054d72060be96fc8

Update the Doorbell routines to support the latest HW
definitions. Use common routine to prepare the Doorbell
key.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.h | 46 +++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 7e6d907..c228870 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -47,6 +47,9 @@ extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 #define CHIP_NUM_58818          0xd818
 #define CHIP_NUM_57608          0x1760
 
+#define BNXT_QPLIB_DBR_VALID		(0x1UL << 26)
+#define BNXT_QPLIB_DBR_EPOCH_SHIFT	24
+#define BNXT_QPLIB_DBR_TOGGLE_SHIFT	25
 
 struct bnxt_qplib_drv_modes {
 	u8	wqe_mode;
@@ -200,6 +203,11 @@ enum bnxt_qplib_db_info_flags_mask {
 	BNXT_QPLIB_FLAG_EPOCH_PROD_MASK         = 0x2UL,
 };
 
+enum bnxt_qplib_db_epoch_flag_shift {
+	BNXT_QPLIB_DB_EPOCH_CONS_SHIFT  = BNXT_QPLIB_DBR_EPOCH_SHIFT,
+	BNXT_QPLIB_DB_EPOCH_PROD_SHIFT  = (BNXT_QPLIB_DBR_EPOCH_SHIFT - 1),
+};
+
 /* Tables */
 struct bnxt_qplib_pd_tbl {
 	unsigned long			*tbl;
@@ -453,14 +461,27 @@ static inline void bnxt_qplib_ring_db32(struct bnxt_qplib_db_info *info,
 	writel(key, info->db);
 }
 
+#define BNXT_QPLIB_INIT_DBHDR(xid, type, indx, toggle) \
+	(((u64)(((xid) & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE |  \
+		(type) | BNXT_QPLIB_DBR_VALID) << 32) | (indx) |  \
+	 (((u32)(toggle)) << (BNXT_QPLIB_DBR_TOGGLE_SHIFT)))
+
 static inline void bnxt_qplib_ring_db(struct bnxt_qplib_db_info *info,
 				      u32 type)
 {
 	u64 key = 0;
+	u32 indx;
+	u8 toggle = 0;
+
+	if (type == DBC_DBC_TYPE_CQ_ARMALL ||
+	    type == DBC_DBC_TYPE_CQ_ARMSE)
+		toggle = info->toggle;
+
+	indx = (info->hwq->cons & DBC_DBC_INDEX_MASK) |
+	       ((info->flags & BNXT_QPLIB_FLAG_EPOCH_CONS_MASK) <<
+		 BNXT_QPLIB_DB_EPOCH_CONS_SHIFT);
 
-	key = (info->xid & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE | type;
-	key <<= 32;
-	key |= (info->hwq->cons & DBC_DBC_INDEX_MASK);
+	key =  BNXT_QPLIB_INIT_DBHDR(info->xid, type, indx, toggle);
 	writeq(key, info->db);
 }
 
@@ -468,10 +489,12 @@ static inline void bnxt_qplib_ring_prod_db(struct bnxt_qplib_db_info *info,
 					   u32 type)
 {
 	u64 key = 0;
+	u32 indx;
 
-	key = (info->xid & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE | type;
-	key <<= 32;
-	key |= ((info->hwq->prod / info->max_slot)) & DBC_DBC_INDEX_MASK;
+	indx = (((info->hwq->prod / info->max_slot) & DBC_DBC_INDEX_MASK) |
+		((info->flags & BNXT_QPLIB_FLAG_EPOCH_PROD_MASK) <<
+		 BNXT_QPLIB_DB_EPOCH_PROD_SHIFT));
+	key = BNXT_QPLIB_INIT_DBHDR(info->xid, type, indx, 0);
 	writeq(key, info->db);
 }
 
@@ -479,9 +502,12 @@ static inline void bnxt_qplib_armen_db(struct bnxt_qplib_db_info *info,
 				       u32 type)
 {
 	u64 key = 0;
+	u8 toggle = 0;
 
-	key = (info->xid & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE | type;
-	key <<= 32;
+	if (type == DBC_DBC_TYPE_CQ_ARMENA || type == DBC_DBC_TYPE_SRQ_ARMENA)
+		toggle = info->toggle;
+	/* Index always at 0 */
+	key = BNXT_QPLIB_INIT_DBHDR(info->xid, type, 0, toggle);
 	writeq(key, info->priv_db);
 }
 
@@ -490,9 +516,7 @@ static inline void bnxt_qplib_srq_arm_db(struct bnxt_qplib_db_info *info,
 {
 	u64 key = 0;
 
-	key = (info->xid & DBC_DBC_XID_MASK) | DBC_DBC_PATH_ROCE | th;
-	key <<= 32;
-	key |=  th & DBC_DBC_INDEX_MASK;
+	key = BNXT_QPLIB_INIT_DBHDR(info->xid, DBC_DBC_TYPE_SRQ_ARM, th, info->toggle);
 	writeq(key, info->priv_db);
 }
 
-- 
2.5.5


--000000000000054d72060be96fc8
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINaqy20f4cG8
Z7sRh7YuOdqFY0nwZhMcu48hQGOzHXkGMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMTIwNzExMDQzOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCyyzWk88za3rIEfGY4HmzUBnWZfcqq
Qmd+yvXBxdQ78sk1EU1s9WkZ14ZwdUzYCrnI16IXvp7uT5HRfL8Efm0/Mp/qT1uk2BYTRCfxIRy6
TGE2cJjBuJP9FlVyPJRPYvfZn7dmLS6ST8jPAVK6fFsh0F1Mnt/uDOFqzkB96bVPI16AxunAn630
CHhNjvDMypFWtodBibZ/NVgg6P/p9Nlu0jwfNW0i1SrxZm6wG2ckv+lQosCnwY0g3+k5BQ7WJh61
dmmAJiRkE7HbOjlK8suc054paQhuxggKeVwzYrlUKfNdnyFffyUV9wSQjCuUxKhbJf6rtl/3IAR9
aHiCDd9J
--000000000000054d72060be96fc8--

