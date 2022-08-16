Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948AB5956B7
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Aug 2022 11:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiHPJje (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Aug 2022 05:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiHPJjZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Aug 2022 05:39:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C91107F23
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 01:12:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso16698546pjq.4
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 01:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc;
        bh=xx1zkA2r1xi3+YPIzvJ2o9zvIaEFUSzDO45ltbS67yU=;
        b=FbI0HWxLtqyCR8tXtP474I678uFAIrpDPheP7FoANecs/YaHa8c34F2VG2pRGQnWbL
         O77u8yVVHggtebT5otis8z3KZMrdDsH+cIDgB0Ko+1gHgAAikJfqxs8CJ7RNXcixONue
         Oei1kxIx/1rphY6574p2DlQyF5cJy3BtnFcOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=xx1zkA2r1xi3+YPIzvJ2o9zvIaEFUSzDO45ltbS67yU=;
        b=K4qg3jv9PLyGKi8EEO9tVRMiSfXJxXCY3ncXkVuRUzkq/2ktzow8mAZK2p7HoqipUl
         +msZ9jzXjmnzwWK7sByO5FwA/VlKy6Zu8lvhMHImg0aK/9I9qpcl6O4MFV728rR9YH71
         yhF8rrXCb9Ssa51fnAya9gK8xs8xeQMYCbMJYnzVSM/F8MbMNpX9ARMhadT1epBBvMKO
         Pi0MEiDzMrjqyWdgtiQMlSTB0zsIHFmP54IWParC/ZgCtGCvwpnxJ2J4G3nzojgRJd01
         MyZlVrLnurgp1PpE+8Xwo+kOrHBn+qbUNfPu9evw8fxk8dFgDB2NEUhKEn29hLhP9A42
         jgXQ==
X-Gm-Message-State: ACgBeo1/jO6iOgmb+Ew/TdHN4Ro9xrxGg//RlcT/X7CYtzqrL3dGoENR
        8+cdMorAqiL43ZsxfyddepOLfva3Lj4G4qZrTg+KiNt9H2elygaltbvPuA0buFd7Zjoibjchoe4
        MgChBFyY2egYVsCmCouySAI2t0F4C+UKFxlc0qQ+PWX+CCsThqUFgAJ0eUhfQD3qM//A6w4yNZn
        39Rb7ie/mp
X-Google-Smtp-Source: AA6agR6jYUFXEB9AaLeSTya0RD4JYtmCCwI3eqCyrwD3XSmzwAKBOhEBZgyZPk9b4nVqFmifDWHLQw==
X-Received: by 2002:a17:902:e548:b0:16f:8df8:90d3 with SMTP id n8-20020a170902e54800b0016f8df890d3mr21001304plf.90.1660637568690;
        Tue, 16 Aug 2022 01:12:48 -0700 (PDT)
Received: from amd_smc.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b0016db7f49cc2sm8379611plg.115.2022.08.16.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 01:12:47 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, leonro@nvidia.com, selvin.xavier@broadcom.com,
        andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH  rdma-rc v1] RDMA/core: fix sg_to_page mapping for boundary condition
Date:   Tue, 16 Aug 2022 13:41:53 +0530
Message-Id: <20220816081153.1580612-1-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000699a0605e65750a1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000699a0605e65750a1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This issue frequently hits if AMD IOMMU is enabled.

In case of 1MB data transfer, ib core is supposed to set 256 entries of
4K page size in MR page table. Because of the defect in ib_sg_to_pages,
it breaks just after setting one entry.
Memory region page table entries may find stale entries (or NULL if
address is memset). Something like this -

crash> x/32a 0xffff9cd9f7f84000
<<< -This looks like stale entries. Only first entry is valid ->>>
0xffff9cd9f7f84000:     0xfffffffffff00000      0x68d31000
0xffff9cd9f7f84010:     0x68d32000      0x68d33000
0xffff9cd9f7f84020:     0x68d34000      0x975c5000
0xffff9cd9f7f84030:     0x975c6000      0x975c7000
0xffff9cd9f7f84040:     0x975c8000      0x975c9000
0xffff9cd9f7f84050:     0x975ca000      0x975cb000
0xffff9cd9f7f84060:     0x975cc000      0x975cd000
0xffff9cd9f7f84070:     0x975ce000      0x975cf000
0xffff9cd9f7f84080:     0x0     0x0
0xffff9cd9f7f84090:     0x0     0x0
0xffff9cd9f7f840a0:     0x0     0x0
0xffff9cd9f7f840b0:     0x0     0x0
0xffff9cd9f7f840c0:     0x0     0x0
0xffff9cd9f7f840d0:     0x0     0x0
0xffff9cd9f7f840e0:     0x0     0x0
0xffff9cd9f7f840f0:     0x0     0x0

All addresses other than 0xfffffffffff00000 are stale entries.
Once this kind of incorrect page entries are passed to the RDMA h/w,
AMD IOMMU module detects the page fault whenever h/w tries to access
addresses which are not actually populated by the ib stack correctly.
Below prints are logged whenever this issue hits.

bnxt_en 0000:21:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x001e address=0x68d31000 flags=0x0050]

ib_sg_to_pages function populates the correct page address in most of the cases,
but there is one boundary condition which is not handled correctly.

Boundary condition explained -
Page addresses are not populated correctly if the dma buffer is mapped to the
very last region of address space.

One of the example -
Whenever page_add is  0xfffffffffff00000  (Last 1MB section of the address space)
and dma length is 1MB, end of the dma address = 0
(Derived from 0xfffffffffff00000 + 0x100000).

use dma buffer length instead of end_dma_addr to fill page addresses.

v0->v1 : Use first_page_off instead of page_off for readability
	 Fix functional issue of not reseting first_page_off

Fixes: 4c67e2bfc8b7 ("IB/core: Introduce new fast registration API")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
---
 drivers/infiniband/core/verbs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e54b3f1b730e..5e72c44bac3a 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2676,15 +2676,19 @@ int ib_sg_to_pages(struct ib_mr *mr, struct scatterlist *sgl, int sg_nents,
 		u64 dma_addr = sg_dma_address(sg) + sg_offset;
 		u64 prev_addr = dma_addr;
 		unsigned int dma_len = sg_dma_len(sg) - sg_offset;
+		unsigned int curr_dma_len = 0;
+		unsigned int first_page_off = 0;
 		u64 end_dma_addr = dma_addr + dma_len;
 		u64 page_addr = dma_addr & page_mask;
 
+		if (i == 0)
+			first_page_off = dma_addr - page_addr;
 		/*
 		 * For the second and later elements, check whether either the
 		 * end of element i-1 or the start of element i is not aligned
 		 * on a page boundary.
 		 */
-		if (i && (last_page_off != 0 || page_addr != dma_addr)) {
+		else if (last_page_off != 0 || page_addr != dma_addr) {
 			/* Stop mapping if there is a gap. */
 			if (last_end_dma_addr != dma_addr)
 				break;
@@ -2708,8 +2712,10 @@ int ib_sg_to_pages(struct ib_mr *mr, struct scatterlist *sgl, int sg_nents,
 			}
 			prev_addr = page_addr;
 next_page:
+			curr_dma_len += mr->page_size - first_page_off;
 			page_addr += mr->page_size;
-		} while (page_addr < end_dma_addr);
+			first_page_off = 0;
+		} while (curr_dma_len < dma_len);
 
 		mr->length += dma_len;
 		last_end_dma_addr = end_dma_addr;
-- 
2.27.0


--000000000000699a0605e65750a1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDWd9ylpECTnYacc2AP/vp8RIYNd
gCtGJK3//xSBo8/JMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDgxNjA4MTI0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAnwOun6OgEOneZ4PaXNxIKTsbkbqjJdObsSGI5IJHXuNC8
r8guTJ4BIeN8Dfm4MDTi2K/5XVg9rR44i8IP7H5aeerqJvI/I/KJplIjuc91Taiv4bVPe3UJXfT6
RDTldJTzU7rNdzwe1CY9HODCPHQH5C3xQoS6dwp/z2d/xy7PqhZGANi83ga1opIQq5yrJNkns5Ca
AS4DHKWoN/3Or0qu/ow5EwsB3M57pzk8K29Pt6DTpHTyk3IY1TDQ4hsBjUcyzbbptd7sQVXz92ti
c6I8MxNynYRCGsN1FiVkwhK0/ZVqA4yZTMWBP4/kt10Lm0vEEQMhBa96NmEStteVK1qL
--000000000000699a0605e65750a1--
