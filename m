Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE06C902A
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Mar 2023 19:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCYSow (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Mar 2023 14:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjCYSos (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Mar 2023 14:44:48 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A700DEC7D
        for <linux-rdma@vger.kernel.org>; Sat, 25 Mar 2023 11:44:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so8043853pjt.2
        for <linux-rdma@vger.kernel.org>; Sat, 25 Mar 2023 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1679769884;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6d8sueP4jR73Mvbnpr8cpJ82Dxh5XY0PYqgverh9YFo=;
        b=VTHczSlpHRbWu/Fp8rQcniswkrE86AphZ9+LfbUSjknGulE0jAnglRWCN0nrqlG4+J
         H4yXvLS5Ybrm9PN78xk2WKQIRDEvC6hQlx6GZKckH9zx/RCXk35eAOGWUXcavhxsTFV6
         EbCWK5Z4dtoVLnoUsbsmWF6KsZd2MlB+q4Ke4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679769884;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6d8sueP4jR73Mvbnpr8cpJ82Dxh5XY0PYqgverh9YFo=;
        b=tG/VANgKHgUF3mwnsJOaom0RDjt3w7nYXZZuPsy3sILGhitbktzGKGUsHZf/mpIJUK
         QBXo7v2Qmbh+U0BvhQPLZCh8q66e5Jq4ZJEBc3xaMGukSEJKbuneY/dfJ2BN7O9GiFvr
         XhA4MQmydxCLMC1XLiHobAIF8UfbGlmNBpFwk8uISgg7WkBfK6YbJR7lB1MToatIZx1k
         Ud0D7vL2VD19jVCw8X8fbaXzXGEbYDI+OJdglMF5PphVzzyV3jXKZv1XhwAmhPa8kAWc
         foJ2paeYCViA4/nMhPJe0A3LmhUf0eHGe6C7uD1BbtDMbriUDtnKi8eGWZnuD7AT7YSA
         ZRAQ==
X-Gm-Message-State: AAQBX9eatA3fkVQkEqWTTeQhU0Mvt+mQRxVxOQ+tYhRSvcFdLGayZaao
        vDtHwXVhzyy7DVKIGhYrp1ixFg==
X-Google-Smtp-Source: AKy350b/bMQ/22BiNfSjcVFLR8wM/kad38QUBq3L2D9INLtaiPAEi5/ID0x3TYrwF/7WDBdz2mqJYg==
X-Received: by 2002:a17:902:daca:b0:1a1:a5d9:146d with SMTP id q10-20020a170902daca00b001a1a5d9146dmr8221875plx.65.1679769883883;
        Sat, 25 Mar 2023 11:44:43 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902b10c00b0019a70a42b0asm16283031plr.169.2023.03.25.11.44.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Mar 2023 11:44:42 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 5/7] RDMA/bnxt_re: RoCE slow path TLV support
Date:   Sat, 25 Mar 2023 11:44:12 -0700
Message-Id: <1679769854-30605-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1679769854-30605-1-git-send-email-selvin.xavier@broadcom.com>
References: <1679769854-30605-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004069d805f7bde75e"
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_HEADER_CTYPE_ONLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_TVD_MIME_NO_HEADERS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000004069d805f7bde75e

Header file to support  TLV encapsulated commands. These
functions will be used by the driver in the follow up patches.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_tlv.h | 162 ++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 drivers/infiniband/hw/bnxt_re/qplib_tlv.h

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_tlv.h b/drivers/infiniband/hw/bnxt_re/qplib_tlv.h
new file mode 100644
index 0000000..6daa97a
--- /dev/null
+++ b/drivers/infiniband/hw/bnxt_re/qplib_tlv.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+
+#ifndef __QPLIB_TLV_H__
+#define __QPLIB_TLV_H__
+
+struct roce_tlv {
+	struct tlv tlv;
+	u8 total_size; // in units of 16 byte chunks
+	u8 unused[7];  // for 16 byte alignment
+};
+
+#define CHUNK_SIZE 16
+#define CHUNKS(x) (((x) + CHUNK_SIZE - 1) / CHUNK_SIZE)
+
+static inline  void __roce_1st_tlv_prep(struct roce_tlv *rtlv, u8 tot_chunks,
+					u16 content_bytes, u8 flags)
+{
+	rtlv->tlv.cmd_discr = CMD_DISCR_TLV_ENCAP;
+	rtlv->tlv.tlv_type = TLV_TYPE_ROCE_SP_COMMAND;
+	rtlv->tlv.length = content_bytes;
+	rtlv->tlv.flags = TLV_FLAGS_REQUIRED;
+	rtlv->tlv.flags |= flags ? TLV_FLAGS_MORE : 0;
+	rtlv->total_size = (tot_chunks);
+}
+
+static inline void __roce_ext_tlv_prep(struct roce_tlv *rtlv, u16 tlv_type,
+				       u16 content_bytes, u8 more, u8 flags)
+{
+	rtlv->tlv.cmd_discr = CMD_DISCR_TLV_ENCAP;
+	rtlv->tlv.tlv_type = tlv_type;
+	rtlv->tlv.length = content_bytes;
+	rtlv->tlv.flags |= more ? TLV_FLAGS_MORE : 0;
+	rtlv->tlv.flags |= flags ? TLV_FLAGS_REQUIRED : 0;
+}
+
+/*
+ * TLV size in units of 16 byte chunks
+ */
+#define TLV_SIZE ((sizeof(struct roce_tlv) + 15) / 16)
+/*
+ * TLV length in bytes
+ */
+#define TLV_BYTES (TLV_SIZE * 16)
+
+#define HAS_TLV_HEADER(msg) (((struct tlv *)(msg))->cmd_discr == CMD_DISCR_TLV_ENCAP)
+#define GET_TLV_DATA(tlv)   ((void *)&((uint8_t *)(tlv))[TLV_BYTES])
+
+static inline u8 __get_cmdq_base_opcode(struct cmdq_base *req, u32 size)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		return ((struct cmdq_base *)GET_TLV_DATA(req))->opcode;
+	else
+		return req->opcode;
+}
+
+static inline void __set_cmdq_base_opcode(struct cmdq_base *req,
+					  u32 size, u8 val)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		((struct cmdq_base *)GET_TLV_DATA(req))->opcode = val;
+	else
+		req->opcode = val;
+}
+
+static inline __le16 __get_cmdq_base_cookie(struct cmdq_base *req, u32 size)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		return ((struct cmdq_base *)GET_TLV_DATA(req))->cookie;
+	else
+		return req->cookie;
+}
+
+static inline void __set_cmdq_base_cookie(struct cmdq_base *req,
+					  u32 size, __le16 val)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		((struct cmdq_base *)GET_TLV_DATA(req))->cookie = val;
+	else
+		req->cookie = val;
+}
+
+static inline __le64 __get_cmdq_base_resp_addr(struct cmdq_base *req, u32 size)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		return ((struct cmdq_base *)GET_TLV_DATA(req))->resp_addr;
+	else
+		return req->resp_addr;
+}
+
+static inline void __set_cmdq_base_resp_addr(struct cmdq_base *req,
+					     u32 size, __le64 val)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		((struct cmdq_base *)GET_TLV_DATA(req))->resp_addr = val;
+	else
+		req->resp_addr = val;
+}
+
+static inline u8 __get_cmdq_base_resp_size(struct cmdq_base *req, u32 size)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		return ((struct cmdq_base *)GET_TLV_DATA(req))->resp_size;
+	else
+		return req->resp_size;
+}
+
+static inline void __set_cmdq_base_resp_size(struct cmdq_base *req,
+					     u32 size, u8 val)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		((struct cmdq_base *)GET_TLV_DATA(req))->resp_size = val;
+	else
+		req->resp_size = val;
+}
+
+static inline u8 __get_cmdq_base_cmd_size(struct cmdq_base *req, u32 size)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		return ((struct roce_tlv *)(req))->total_size;
+	else
+		return req->cmd_size;
+}
+
+static inline void __set_cmdq_base_cmd_size(struct cmdq_base *req,
+					    u32 size, u8 val)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		((struct cmdq_base *)GET_TLV_DATA(req))->cmd_size = val;
+	else
+		req->cmd_size = val;
+}
+
+static inline __le16 __get_cmdq_base_flags(struct cmdq_base *req, u32 size)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		return ((struct cmdq_base *)GET_TLV_DATA(req))->flags;
+	else
+		return req->flags;
+}
+
+static inline void __set_cmdq_base_flags(struct cmdq_base *req,
+					 u32 size, __le16 val)
+{
+	if (HAS_TLV_HEADER(req) && size > TLV_BYTES)
+		((struct cmdq_base *)GET_TLV_DATA(req))->flags = val;
+	else
+		req->flags = val;
+}
+
+struct bnxt_qplib_tlv_modify_cc_req {
+	struct roce_tlv				tlv_hdr;
+	struct cmdq_modify_roce_cc		base_req;
+	__le64					tlvpad;
+	struct cmdq_modify_roce_cc_gen1_tlv	ext_req;
+};
+
+struct bnxt_qplib_tlv_query_rcc_sb {
+	struct roce_tlv					tlv_hdr;
+	struct creq_query_roce_cc_resp_sb		base_sb;
+	struct creq_query_roce_cc_gen1_resp_sb_tlv	gen1_sb;
+};
+#endif /* __QPLIB_TLV_H__ */
-- 
2.5.5


--0000000000004069d805f7bde75e
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGfANedj86j4
yjHyRN7DRcqi/stVm2eka5EfF+RMoS0PMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDMyNTE4NDQ0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDGpEXp/BAimO4jm6IPyn4zUDsXgfaW
KyFor8eIRCmsyNIIKO7yIkvDqgHzd4MdVOYMB5bgsT3ewG7RMICuKcRoAvjUtKaGXWSPLX8MqcAF
j79wnx3hvp8LyK+FXiXOl62QPRGz9rlqK7jcjebYs0Y4DAlV79ByCsbgW2PnotxEDCuOI5cB5msA
3lY9h1I6JNz+x0LanN85L7Q9wLTOqak3cXpCNH2ISyISkWZf1hi1SbzFFgeW5aezTzmBL+zUa91P
sRogH5bVc+FjkJHdVLto4PwFzz9sXrPlETxIZWwTgqL+WQm8oxtbOWQ96avCGBdO5FqPu1XHNY2t
B6FEESrP
--0000000000004069d805f7bde75e--
