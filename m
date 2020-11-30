Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A802C84D8
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgK3NO3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 08:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgK3NO3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Nov 2020 08:14:29 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE54AC0613CF
        for <linux-rdma@vger.kernel.org>; Mon, 30 Nov 2020 05:13:48 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id x24so10368318pfn.6
        for <linux-rdma@vger.kernel.org>; Mon, 30 Nov 2020 05:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Fe63wMSZpfDRjhYy5co8snhmZ0wn7pAobd/fYnUiTjA=;
        b=gq6rfuxkpp3XYADRD6Sr0fl/9PChhZOQh9qjzNZ1uwQ9UYeZimWOzOfA5MbdoFboPv
         DxK5g8TivuArvvNLoaiXAnvmWSQ1qBS9gKXsTdGav+RfIUbgXyrEQPL0MQGNexrXcDvk
         XBJCZe+N/ZMwlvzigQPl2VZZZEDj+vSIyg614=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Fe63wMSZpfDRjhYy5co8snhmZ0wn7pAobd/fYnUiTjA=;
        b=iq7JGqV8cMzAmkO5qiTk+rDRd203BZbDG6nP9uGfzd/ueneLysShI7ON8PfFlWLmNa
         jc3awoZAQQxFIA/RwM+VMrtaEDIWZDZnnfP/yE1y9lej60LeP0CRpzJstzbwuG/ha09+
         1gEnkYG++RJ2js2/UU84VlDrFwG3rzp2lVp0o861JKkPmNmi427eLUa774KNSXXIZHbS
         KGMhUYNPtk0bGsip9q77fWhT84cQ0CjJ+LRpYBonnuH38Eq5xy9Pzm31Nb3ttOQQ3ECV
         Ltp3ueYjXTZs/Y8gOSTtcoNyJJYjV2isP9ODFTANbFNrOWrASD9xA6eDxVt7xclnaA/6
         Yqsg==
X-Gm-Message-State: AOAM530To0w4Yr+a1A3mGec0KG9CrA8uz+nWWze6Vm+B17A2hArMr6gq
        miXpFem25382BTDokTyvEsHcGsgCTPPzN6UriIviiU8bXGzbwrW0VYN3KYmFu38AmmdA6oF78u6
        FGOlKxkGcDAfIVvOU1Bo5uTgqUip+BnI0ihO1u4FnOs95A0RypGg7sa00CQzq9hsqssrYGt+AP+
        UedP83ErLz
X-Google-Smtp-Source: ABdhPJzsJc/26880a2O1IBaGrT3s+BD3pkF1IE4Z1ogs/ZtO5CVzn90AH2uY+T1nT0GgJLH780Xlxg==
X-Received: by 2002:a63:4912:: with SMTP id w18mr17877793pga.9.1606742027326;
        Mon, 30 Nov 2020 05:13:47 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u7sm3611829pfh.115.2020.11.30.05.13.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 05:13:46 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, dledford@redhat.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH] RDMA/bnxt_re: Fix max_qp_wrs reported
Date:   Mon, 30 Nov 2020 05:13:06 -0800
Message-Id: <1606741986-16477-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d35af205b552c7ce"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000d35af205b552c7ce

While creating qps, driver adds one extra entry to the sq size
passed by the ULPs in order to avoid queue full condition.
When ULPs creates QPs with max_qp_wr reported, driver creates
QP with 1 more than the max_wqes supported by HW. Create QP fails
in this case. To avoid this error, reduce 1 entry in max_qp_wqes
and report it to the stack.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index e865690..6c6a9d2 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -118,7 +118,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 	 * 128 WQEs needs to be reserved for the HW (8916). Prevent
 	 * reporting the max number
 	 */
-	attr->max_qp_wqes -= BNXT_QPLIB_RESERVED_QP_WRS;
+	attr->max_qp_wqes -= (BNXT_QPLIB_RESERVED_QP_WRS + 1);
 	attr->max_qp_sges = bnxt_qplib_is_chip_gen_p5(rcfw->res->cctx) ?
 			    6 : sb->max_sge;
 	attr->max_cq = le32_to_cpu(sb->max_cq);
-- 
2.5.5


--000000000000d35af205b552c7ce
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
E57pwqmNNXKez5LsgWg0MCcM26jqs8SBTJIA/6zJgjW8nK8WLLIPfCZO1NGVxIkHTjVy2Du2fAKX
qPfnml4GF/qROS0CAwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEw
gY4wTQYIKwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVy
c29uYWxzaWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFs
c2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0
MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNV
HRMEAjAAMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJz
b25hbHNpZ24yc2hhMmczLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAd
BgNVHQ4EFgQUKr67/GLyV/C27HDAeg3i3tW9facwDQYJKoZIhvcNAQELBQADggEBABQEPPwx33W2
mW8bSM5/AERxpztkHy4343YTHPsNXO/WrC+SuEQTYhV1eMrJbh1tZduP2rKgvZskl65mPF3qkRWi
J4J0DABOqmcJmyNoeIeXxcZx9bJqjiQWTT2iV+cCTYuiDrA+JUVKoMnmGwh2aSz6BH9Jsv2PFCNS
A6WyTEkC5z+3rM1f91ynuoPZCsYw/V1Hm5Nb+8lCB+0vqbUNUU3vlsiCuyym/XpDULrdf+qAGK+z
fntrEGyEOXbwpxyp5YGNdslhesuWawlpJUy3JSzRI9vx1SS2UaXG1+tsbKMkc1OyML6gl7W2AGPy
KN/Okg/+FqXwVaCbzR83sc69+FYxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENB
IC0gU0hBMjU2IC0gRzMCDCokiEUX3rGKhbywTjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0B
CQQxIgQg9JVgvmfHeI5wbY8Y+IOVFvpn369Kn4cY41DNZkq7GaowGAYJKoZIhvcNAQkDMQsGCSqG
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAxMTMwMTMxMzQ4WjBpBgkqhkiG9w0BCQ8xXDBaMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3
DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAChC4kwHjaQI
+KYjL62XBN0jy9TT2OwhbiV8KZzfPF6WS+ysEDRbxL1IisNnuIpsN7/BACgsDg8Ofsx8oY/nYffs
6j5rWLHe0u2h9jkEUyuWh35cV2XFTYaR6ET5jCebZuI897Xzx904DqT4Zev4UT0prcVd1XpZYX+C
rFjvOPBnrybxyhJtFITSPu90NSIJGOrl4vN+goyIncaRl8dq3A2xRYisG4SuREJpNWW4s87WfYpy
EqcE+/s0lM41SPxSSq55OuE2mVC9iBJcnfB8pgpHdB6Li2lgMUYbuutPUU5WLhAaG9TIKJZA6fFy
URO6nwIQXDh5X9+eyz/c0PgcB7s=
--000000000000d35af205b552c7ce--
