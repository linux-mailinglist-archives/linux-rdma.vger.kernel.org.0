Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B330E755B30
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jul 2023 08:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGQGIL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jul 2023 02:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjGQGHx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jul 2023 02:07:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B2C1BEE
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 23:07:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b9cd6a0051so24970045ad.1
        for <linux-rdma@vger.kernel.org>; Sun, 16 Jul 2023 23:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1689574036; x=1692166036;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q5BvM0TjlfnlDcKjzQaEtFRE4dzBWCgoPSnoidbz/UY=;
        b=ZQvM81wC8No6udwpjOtBxDoHXs77RjLWhhKrqKMcDTs51O8iy5SVPXAwDZuRFa87so
         DcEudIMw0AyEbezdDkdpI7IadZXnnZFoejaAuXkLu0mL+xYpllc/bHk2QMgs9oUeDhlP
         dZNMm5FFASfisGlSHZXkQg6NdVQghBoQSl/7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689574036; x=1692166036;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5BvM0TjlfnlDcKjzQaEtFRE4dzBWCgoPSnoidbz/UY=;
        b=Beoffs9kKyfkjCnkkJVb2pMF/gzsoipVxyCYT/SjEgDD8RmyCZ2Ym1/6WCUGRctxBP
         7y8kBcqD5x/Osug3FmGm4PPC6MNjMJ3lp61r0hoeyuup5x+lj45bDK9CnR9Xb4YlYBUq
         4uLwmSRhwVzbLnA9VLs7Kl7tFGTTAF55uBgNpUX7818Xr7txWvHBgVFLiFxsV9ITnbe4
         B7Qw/T0HYOfzIhPFmKkGRAIJ3IVfbUqwVqQyZAAx7xmpl2SiweJmVgPeLwHKjr4/DBqV
         alR6rJSKznGTChAq66lKFJdaxavJJs4uXIZEM655Jj9BuRaNbdwDHNOParlxTe2YLpFb
         xSjw==
X-Gm-Message-State: ABy/qLY6KQsAo81b5LjDJuF+v/Lbj0dFWgCUUObTYWZjkuqSUwKkdoNh
        740tmtgSXzODGzCOpAtoB8P1Qg==
X-Google-Smtp-Source: APBJJlEfF/fidW1qlURVcX4Srhyc8UO5iTNYUWhXSgHKTfA3CavE4BAp2e5zMTbZX8X0vAcylQLc9A==
X-Received: by 2002:a17:903:2343:b0:1b8:77b3:6bed with SMTP id c3-20020a170903234300b001b877b36bedmr11889870plh.64.1689574036682;
        Sun, 16 Jul 2023 23:07:16 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902789100b001b9da7b6bc3sm11849632pll.184.2023.07.16.23.07.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jul 2023 23:07:15 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        michael.chan@broadcom.com,
        Chandramohan Akula <chandramohan.akula@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 5/7] RDMA/bnxt_re: Update alloc_page uapi for pacing
Date:   Sun, 16 Jul 2023 22:53:12 -0700
Message-Id: <1689573194-27687-6-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1689573194-27687-1-git-send-email-selvin.xavier@broadcom.com>
References: <1689573194-27687-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004b375f0600a89c6d"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_TVD_MIME_NO_HEADERS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000004b375f0600a89c6d

From: Chandramohan Akula <chandramohan.akula@broadcom.com>

Update the alloc_page uapi functionality for handling the
mapping of doorbell pacing shared page and bar address.

Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 34 +++++++++++++++++++++++++++++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  2 ++
 include/uapi/rdma/bnxt_re-abi.h          |  2 ++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 86b71c7..8238c4b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -565,6 +565,8 @@ bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
 		break;
 	case BNXT_RE_MMAP_UC_DB:
 	case BNXT_RE_MMAP_WC_DB:
+	case BNXT_RE_MMAP_DBR_BAR:
+	case BNXT_RE_MMAP_DBR_PAGE:
 		ret = rdma_user_mmap_entry_insert(&uctx->ib_uctx,
 						  &entry->rdma_entry, PAGE_SIZE);
 		break;
@@ -4149,6 +4151,18 @@ int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
 	case BNXT_RE_MMAP_SH_PAGE:
 		ret = vm_insert_page(vma, vma->vm_start, virt_to_page(uctx->shpg));
 		break;
+	case BNXT_RE_MMAP_DBR_BAR:
+		pfn = bnxt_entry->mem_offset >> PAGE_SHIFT;
+		ret = rdma_user_mmap_io(ib_uctx, vma, pfn, PAGE_SIZE,
+					pgprot_noncached(vma->vm_page_prot),
+					rdma_entry);
+		break;
+	case BNXT_RE_MMAP_DBR_PAGE:
+		/* Driver doesn't expect write access for user space */
+		if (vma->vm_flags & VM_WRITE)
+			return -EFAULT;
+		ret = vm_insert_page(vma, vma->vm_start, virt_to_page(bnxt_entry->mem_offset));
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -4180,7 +4194,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *
 	u64 mmap_offset;
 	u32 length;
 	u32 dpi;
-	u64 dbr;
+	u64 addr;
 	int err;
 
 	uctx = container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_re_ucontext, ib_uctx);
@@ -4202,19 +4216,30 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_ALLOC_PAGE)(struct uverbs_attr_bundle *
 				return -ENOMEM;
 			length = PAGE_SIZE;
 			dpi = uctx->wcdpi.dpi;
-			dbr = (u64)uctx->wcdpi.umdbr;
+			addr = (u64)uctx->wcdpi.umdbr;
 			mmap_flag = BNXT_RE_MMAP_WC_DB;
 		} else {
 			return -EINVAL;
 		}
 
 		break;
+	case BNXT_RE_ALLOC_DBR_BAR_PAGE:
+		length = PAGE_SIZE;
+		addr = (u64)rdev->pacing.dbr_bar_addr;
+		mmap_flag = BNXT_RE_MMAP_DBR_BAR;
+		break;
+
+	case BNXT_RE_ALLOC_DBR_PAGE:
+		length = PAGE_SIZE;
+		addr = (u64)rdev->pacing.dbr_page;
+		mmap_flag = BNXT_RE_MMAP_DBR_PAGE;
+		break;
 
 	default:
 		return -EOPNOTSUPP;
 	}
 
-	entry = bnxt_re_mmap_entry_insert(uctx, dbr, mmap_flag, &mmap_offset);
+	entry = bnxt_re_mmap_entry_insert(uctx, addr, mmap_flag, &mmap_offset);
 	if (!entry)
 		return -ENOMEM;
 
@@ -4254,6 +4279,9 @@ static int alloc_page_obj_cleanup(struct ib_uobject *uobject,
 			uctx->wcdpi.dbr = NULL;
 		}
 		break;
+	case BNXT_RE_MMAP_DBR_BAR:
+	case BNXT_RE_MMAP_DBR_PAGE:
+		break;
 	default:
 		goto exit;
 	}
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 32d9e9d..f392a09 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -146,6 +146,8 @@ enum bnxt_re_mmap_flag {
 	BNXT_RE_MMAP_SH_PAGE,
 	BNXT_RE_MMAP_UC_DB,
 	BNXT_RE_MMAP_WC_DB,
+	BNXT_RE_MMAP_DBR_PAGE,
+	BNXT_RE_MMAP_DBR_BAR,
 };
 
 struct bnxt_re_user_mmap_entry {
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 060bf1d..78a324f 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -136,6 +136,8 @@ enum bnxt_re_objects {
 
 enum bnxt_re_alloc_page_type {
 	BNXT_RE_ALLOC_WC_PAGE = 0,
+	BNXT_RE_ALLOC_DBR_BAR_PAGE,
+	BNXT_RE_ALLOC_DBR_PAGE,
 };
 
 enum bnxt_re_var_alloc_page_attrs {
-- 
2.5.5


--0000000000004b375f0600a89c6d
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
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJZWEC17TtXU
ULBFBpnbW/3R0uzWPpfKyOguuM+mgfjDMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDcxNzA2MDcxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBMaoEDv7KQEtCF8gKHTU0LaRGFdjvj
3exVZJcmxGCq/P2KRE5eN+EOBhs4zUYt4Q2YPWT+Ek8cSHv9MnLYEvn2MxwQnYcEcUvW8j8c8QXn
/E8SZWpU1qZQxe2nkGMJyJdCRykWkkul6q6QCJT38+TLMcPXiouhEIBZY5dkfLCvWWafpLLFHnnn
O+l/wACSuUjmXe+nm1HAA2WqVQ/sRvtjBdMEmF567LBa1JOTpubZm4uRbD3Dk9CooK/1Rh58ukB4
ujaXQHm4BNxiTW4Id2tATYAq1hpuKyk5fta9lXAW9FUn8NhnohOy2C+BrU1XysR5BliRqTPG9yXh
tJASzvOg
--0000000000004b375f0600a89c6d--
