Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D1358D662
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Aug 2022 11:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbiHIJXI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Aug 2022 05:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiHIJXH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Aug 2022 05:23:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41372CE0
        for <linux-rdma@vger.kernel.org>; Tue,  9 Aug 2022 02:23:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f65so10831935pgc.12
        for <linux-rdma@vger.kernel.org>; Tue, 09 Aug 2022 02:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc;
        bh=oUtfXhrTbHdZisj4OF7rsnBvMCv+B2X4eAwZsVWHdgI=;
        b=SOqhsfUYinN9QOerCYHdBdTUwCc8nrpzi7Uh5vXLgrozEWxIyf0gskB7s06WrtcdZ7
         vatoxlQ+Ph99AkcUotINoQRMJL9X27vptwOmUiUujyyd2r2CVBIxFVUUvSLJXu/5f6Zx
         Ii5EYdYc6V4BAjxXgY4eHc0/FA03d4T8j37Ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=oUtfXhrTbHdZisj4OF7rsnBvMCv+B2X4eAwZsVWHdgI=;
        b=3BPCLbqvMwUV3zRdA/uPJkKjZ+oorNl/miPpfwbdXyKYFFngQXDdBuGjFO5oy1mtu/
         uqFbT6eZ1bFcyD3aZyFMqW5lPl4l3l9syqQS/1YIizIC3i1t8RnivKqaqJ1Ray4haT+P
         JkkgmST/gxpzKrO3Q0xAQZWuhp9R/Y9ogDA63QZPzpzo63zjm/T/Vx3JMlr5TM1Vhvt2
         dxxBXl2xTU9dv5wz2SJbfTBc9FQ2POVc878FrcBXbmmVWIUm+g5XTIVKcXXjKLmh4TMw
         96+ORf3HXHP5PaVN0O3/sH2392Ek+MXbrkKzUQzGHF6Uh8UjMQcnOT5WUPxEXbhrOlEl
         Zd9w==
X-Gm-Message-State: ACgBeo0Wl1vteh5UK83S2Ae5rwNODV5jtm0Av6/WBBd96pGw4Y4mRfd5
        VleDycSgEca8eSJFjlNeIiNzmkMqp9HJqqyvo7GIciLm5kCHUR310Ad153izRRfMJCBr6H8/YGW
        DhHr5mUaDht17wJWzL4gQutqj4kB+fZ4YNz2tAmadmLJysrax0Gs96dmqVZySzf4hGE/FOeq6oZ
        F298jR3iyj
X-Google-Smtp-Source: AA6agR7g36dpGdefglY921ppndnCEaheeKtpfpZLdg5WyG3JiYHrHT12qx8yvd9sHRMatyIrhm2qtw==
X-Received: by 2002:a63:2110:0:b0:41d:234f:16aa with SMTP id h16-20020a632110000000b0041d234f16aamr13347664pgh.481.1660036986410;
        Tue, 09 Aug 2022 02:23:06 -0700 (PDT)
Received: from amd_smc.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id n186-20020a6227c3000000b0052d748498edsm10445740pfn.13.2022.08.09.02.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 02:23:05 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, leonro@nvidia.com, selvin.xavier@broadcom.com,
        andrew.gospodarek@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH  rdma-rc]  RDMA/core: fix sg_to_page mapping for boundary condition
Date:   Tue,  9 Aug 2022 14:52:13 +0530
Message-Id: <20220809092213.1063297-1-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ea12d005e5cb7af0"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000ea12d005e5cb7af0
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

Fixes: 4c67e2bfc8b7 ("IB/core: Introduce new fast registration API")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
---
 drivers/infiniband/core/verbs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index e54b3f1b730e..36137735cd04 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2676,15 +2676,19 @@ int ib_sg_to_pages(struct ib_mr *mr, struct scatterlist *sgl, int sg_nents,
 		u64 dma_addr = sg_dma_address(sg) + sg_offset;
 		u64 prev_addr = dma_addr;
 		unsigned int dma_len = sg_dma_len(sg) - sg_offset;
+		unsigned int curr_dma_len = 0;
+		unsigned int page_off = 0;
 		u64 end_dma_addr = dma_addr + dma_len;
 		u64 page_addr = dma_addr & page_mask;
 
+		if (i == 0)
+			page_off = dma_addr - page_addr;
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
@@ -2708,8 +2712,9 @@ int ib_sg_to_pages(struct ib_mr *mr, struct scatterlist *sgl, int sg_nents,
 			}
 			prev_addr = page_addr;
 next_page:
+			curr_dma_len += mr->page_size - page_off;
 			page_addr += mr->page_size;
-		} while (page_addr < end_dma_addr);
+		} while (curr_dma_len < dma_len);
 
 		mr->length += dma_len;
 		last_end_dma_addr = end_dma_addr;
-- 
2.27.0


--000000000000ea12d005e5cb7af0
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
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKdBWltKfEtsLQgdptK9VmhIincV
gB3r5zAMrSTPJZzWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDgwOTA5MjMwNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBGQ1eYU6ACqBSSrKnwa9tLU5KDzhcox49GbY8QHOiU9/uR
QvxqjGuBwF/Vqn4RoQ5t97IvNVf6OhEJc7EHdeh2iH+IOodpZUxT5auVqzVB+IkQqce/nhXcXLVf
HrRDYe51Y3ajjhjf1pt+07S71VZUrckLxmUGIfz21rUP4BeFaTA+0VC2mDtorUKksZKrfjPXve/3
73Y0N/IVqsHhJ9kd3BTrWW2yyPYy/bWY8xGty405J9d5Pw1EKNvt2c7QCbDt/nBI6USAAc5PaTpg
1gzU/mSRpZqRilbDV7GqKalNJLZTkZdV3u3EuscPHWAba2mLsmnL4zy79QoqLhXj2Lvv
--000000000000ea12d005e5cb7af0--
