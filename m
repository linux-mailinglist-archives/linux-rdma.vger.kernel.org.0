Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DCD28C891
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Oct 2020 08:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbgJMGQE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 02:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388527AbgJMGQE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Oct 2020 02:16:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA9EC0613D0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 23:16:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so16892768pgl.2
        for <linux-rdma@vger.kernel.org>; Mon, 12 Oct 2020 23:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QuFoeHlzs6JN7uJkla62smSIlXRzAk2KPlNi7C0OYqQ=;
        b=IsU7wJ21DSmAwwWe9ziBChF9Onb+eYMmP1lT+JNngKG5bL0L1McXc9Bx6clkOspWzg
         Q3RgtF4gYSQFpBfaKAeBdG+rvjJAxMHVyVebXBv3bS2FRBnoKaqeN1blj/AHk29AfcKH
         lXLW9AT870HdnRlNlsrx/nBCrSpWYHclLwYZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QuFoeHlzs6JN7uJkla62smSIlXRzAk2KPlNi7C0OYqQ=;
        b=Owla4tam6lRM9C1nTl4SeizfJ7fmu1ucITfji1YjNuh+JguHyfS5T+W58wpxIr3mgg
         7F6VX/c0MwHoXECmS9bwGCMr7O7h86uSN7QFVbLEKVrF+AUHNLf42zFI3uTV03MU8A40
         MGxMv8lvePbBL65m2gJeCroAiBrHGBRIOF7QqYsKcFHs9ggSQugJim6ffXHjLU2zirWt
         wx/+CZS1uP7Da9qGfJdwEbIuLE/i0lsb2f2vpPgiOsP6p1SxgOm3Q2jZJcMha9wvl9OX
         ZvJ+PudvzrdaHT74/rdjR2at2nT1E8qjM2W/9r2pklQ6R/aA28SRs6zsJLpoKajDiVOP
         0HMA==
X-Gm-Message-State: AOAM532l7+LA/Plaw7yOaiQt7YV/wV3uJF6IKAEzZFb0tG/gBWxBsjPc
        iXOA6IiL6Ja5jQe6VszjYoj6kqzPy8zhhtRv
X-Google-Smtp-Source: ABdhPJwnAHnBg/27LjJrjDcsaKPqYsWa3Wzqps+gG9FRkqgu+SSSYvguT/PQQRUmRNKmIKEbrBreFw==
X-Received: by 2002:a63:1709:: with SMTP id x9mr8956817pgl.334.1602569763209;
        Mon, 12 Oct 2020 23:16:03 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a4sm21627333pgl.51.2020.10.12.23.16.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2020 23:16:02 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH] RDMA/bnxt_re: Fix entry size during SRQ create
Date:   Mon, 12 Oct 2020 23:15:52 -0700
Message-Id: <1602569752-12745-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007ea86b05b1875952"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000007ea86b05b1875952

Only static WQE is supported for SRQ. So always
use the max supported SGEs while calculating
SRQ entry size.

Fixes: 2bb3c32c5c5f ("RDMA/bnxt_re: Change wr posting logic to accommodate  variable wqes")
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index cf3db96..b12bf20 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1657,8 +1657,8 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 	srq->qplib_srq.max_wqe = entries;
 
 	srq->qplib_srq.max_sge = srq_init_attr->attr.max_sge;
-	srq->qplib_srq.wqe_size =
-			bnxt_re_get_rwqe_size(srq->qplib_srq.max_sge);
+	 /* 128 byte wqe size for SRQ . So use max sges */
+	srq->qplib_srq.wqe_size = bnxt_re_get_rwqe_size(dev_attr->max_srq_sges);
 	srq->qplib_srq.threshold = srq_init_attr->attr.srq_limit;
 	srq->srq_limit = srq_init_attr->attr.srq_limit;
 	srq->qplib_srq.eventq_hw_ring_id = rdev->nq[0].ring_id;
-- 
2.5.5


--0000000000007ea86b05b1875952
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
CQQxIgQgS9jvq4fVb9RUdq1hmwhaTVPGSd/9lE/bmIiMLeVinuIwGAYJKoZIhvcNAQkDMQsGCSqG
SIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAxMDEzMDYxNjAzWjBpBgkqhkiG9w0BCQ8xXDBaMAsG
CWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3
DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAG7jjnnvlqVi
aBYzd6EoBeYyJrZhrHPPhfMuwXgcxM7kFkuz1f650ss2m1g4/v/BNHvMFP8UgoGUTNKI/lcCl8V3
YmJg8HZzvEvd8s/cyLey/ghFXODsTW2A+h3KPz7Ypfpts2G8midQ5KiY6wGGjKGTom4f0QCuRue0
Wk8JTBbRqG+yyYF8knxN/FGSUdUNf6+MOFIdy1wrUx404F1O6/2KLD10rFqb5LfNA+8vg5zxgFkA
Mztdwjb2+FJbAIDRZh3fE2r7EvL051If3qGih2iphZJx7o5WySmLYc34bHBEWLqHc5yx7ALaFoJm
XBkH+D/UMuidtAdHPyNJnKunw18=
--0000000000007ea86b05b1875952--
