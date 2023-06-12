Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C97672BED2
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 12:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjFLKXW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 06:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjFLKXD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 06:23:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C4C2D4A
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 03:02:13 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b3c0c476d1so10076605ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686564040; x=1689156040;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoVeWn8h1o4AfPcAzoTfNYb6sSoGsUJgWlVrdROENRs=;
        b=ZEjWkgYxIDoUrqJ175ZwQA2r6KZmT5soPdPPcyYXQsTxVN3U0Rf/HvYxQ1N7nuBejd
         Qkp4ONvocjfUtyWLu7Y6OyAhWmqgrIleQVZRbrQ6Fd7s5upS2JmqgDQQuLXm/nkHWxoH
         rNrxHIwwpwsSj+HHdEhh2K4RKpDtcbTfnV/Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564040; x=1689156040;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoVeWn8h1o4AfPcAzoTfNYb6sSoGsUJgWlVrdROENRs=;
        b=HRhRGSo/mDWgil/YPgJL8TjAnsrI93iLS7wSlNdMdI4dm49Lynl1Z+WtW++OfjiC8I
         3LYjp35ihyz35jnIAAlo0xHXQoAMPZi1zCsnf63g+9OJTw0Vxh3w1/eoZwtQKpxZwPNV
         fzCaHzD0NQqSpWrbFr+HCC5jQm1tO3IWZO3v3jllXuSdo+kOnTG0+WJaf3nNH+6NAGpE
         Q3AehnI8EKDq2Vhhxrc4wrpaoWnWZRGOWWHnF2+3mUThofJdk/zubv6TnnM9Rsg7BYlj
         H98R1oCr8mvPEo3VxppCAKZ4xfxJFPfnVULExBUUc+9AkmUFSm/b7EPAGaXPOtIf9LhY
         bkow==
X-Gm-Message-State: AC+VfDwWuadMDKOXIQXMGLKQqo7K2fXq+pXrDClL796tMwsvSowtRzgw
        ZdvL79NT7lVLbEMaBpe8deDC2A==
X-Google-Smtp-Source: ACHHUZ5vPZWIoDnoflqO2n/kWgl0U9Ke+MUgZaDVD1gxXQVKpi0pWbKNY+c6IQsTQHPvpLc2cZQUzQ==
X-Received: by 2002:a17:902:e811:b0:1ad:f407:37d2 with SMTP id u17-20020a170902e81100b001adf40737d2mr7429872plg.5.1686564040242;
        Mon, 12 Jun 2023 03:00:40 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001ae2b94701fsm7792050plx.21.2023.06.12.03.00.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jun 2023 03:00:39 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v5 for-next 0/7] RDMA/bnxt_re: driver update for supporting low latency push
Date:   Mon, 12 Jun 2023 02:48:55 -0700
Message-Id: <1686563342-15233-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000087048505fdebcad5"
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,MIME_NO_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000087048505fdebcad5

The series aims to add support for Low latency push path in
some of the bnxt devices. The low latency implementation is
supported only for the user applications. Also, the code
is modified to use  common mmap helper functions exported
by IB core. 

User library changes are in the pull request
https://github.com/linux-rdma/rdma-core/pull/1321

Please review and apply

Thanks,
Selvin Xavier

v4 -> v5:
  - Added patch 3 to optimize bnxt_re_init_hwrm_hdr parameters
  - Avoid memset from the callers of bnxt_re_init_hwrm_hdr
  - Rebased the patches to the latest from leon-for-next

v3-> v4:
  - Remove the newly added comp_mask in the alloc_pd resp. This is
    not required after using the new UAPI mechanism.
  - Return -EINVAL if WC page mmap requested for an unsupported
    adapter.

v2-> v3:
  - Rebasing after the merge window
  - Fix the return value check in bnxt_re_hwrm_qcfg

v1 - v2:
  - Fixes the review comments from Leon and Jason
  - As suggested by Jason, implements the new uapi
    driver definitions for allocating pages in the
    driver and return the cookie for mmap


Selvin Xavier (7):
  RDMA/bnxt_re: Use the common mmap helper functions
  RDMA/bnxt_re: Add disassociate ucontext support
  RDMA/bnxt_re: Optimize the bnxt_re_init_hwrm_hdr usage
  RDMA/bnxt_re: Query function capabilities from firmware
  RDMA/bnxt_re: Move the interface version to chip context structure
  RDMA/bnxt_re: Reorg the bar mapping
  RDMA/bnxt_re: Enable low latency push

 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |   3 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 263 ++++++++++++++++++++++++++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h   |  19 +++
 drivers/infiniband/hw/bnxt_re/main.c       | 162 ++++++++++++++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |   4 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |   2 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c  | 177 ++++++++++++-------
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  33 +++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |   3 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.h   |   1 +
 include/uapi/rdma/bnxt_re-abi.h            |  28 +++
 11 files changed, 565 insertions(+), 130 deletions(-)

-- 
2.5.5


--00000000000087048505fdebcad5
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG7WlLd0tvVU
oZX+6K5ShiZSsCsEMC4kmToJjo2X8NDxMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDYxMjEwMDA0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCQYpScOiwb+Bvjf47Bc30BAXWaqjNd
dN5fh/zl+5/Ehw5Zg2muW1RfzITxrBLLDf78SThULUcVH/1lRjWDo8Y8am/u3Q0H/PlW34YrPkvR
ptBBFzUM27qyfWqqiSGFOKjQVIboZsEYkqMYkZZHEHJbB6RoOf9xPUTwrQ6MEVhpL/FuwIsyfotz
k+Yc7WY/yPrZX+F69Zlps0rRzTHpoum4FPfuRWTkLRSJkqeWBRtOq7PmorYJ71phwpryGHFS/gjv
zcpo/jEXnOikjVKOfnBtqTFTPkq+uaay3FLO6nzRxCNAigph9QbTDbsL4hOtgIvsQqrv1QUaBajO
rHm4X5Nl
--00000000000087048505fdebcad5--
