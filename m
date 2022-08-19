Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F275998EB
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Aug 2022 11:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348205AbiHSJn7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Aug 2022 05:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348003AbiHSJnv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Aug 2022 05:43:51 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6C83ECCD
        for <linux-rdma@vger.kernel.org>; Fri, 19 Aug 2022 02:43:49 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id w18so2902498qki.8
        for <linux-rdma@vger.kernel.org>; Fri, 19 Aug 2022 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc;
        bh=3aI/cGVh9JIRafTtz01+83t6+h/xTJbppZt4p5HVaQY=;
        b=bdMS3PqlzJo81oysLSCpUWB+ak6fvucYlSe6XfW13FZPLsXMPQ3t2XKWuI0JYOXx1J
         R22wq5vDV551EWt7VnRHeImYn9BSZv/Hk0DJngWtQmTqezfo2cLtZpE2SgURSdVXc2u0
         NKCDXpzIJ+Jldkq4J6ClUNGXZGgB2M3IhOTh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc;
        bh=3aI/cGVh9JIRafTtz01+83t6+h/xTJbppZt4p5HVaQY=;
        b=Z/i6LseLDwHsFxFMf80Lcxsx6E6MifCZ+YK9HeeX97kHDKqgdifqKue8ScRiT5sROG
         HyAU6iVn5GCdLfF5ViQic5HlkL4wJEmte/8AL5vFcaeD5cgS+KgRyYBj621xTHQx8VL7
         7G3Tx693s+bwhxQJYFE7WJujPjnJuITnAcQcaWKCgmB6egUIh0R0e4I8FuMUj9C34ng8
         8qm+pWvc7vSVc4LANN0xvl2SsMWFobCAow4TtWfy7sdV2Ha7sGyOAM83rx+KceAclEMT
         dQZTZJxW6edLmsVl4pCRkx2HRTMOn+VCyAzOJabi46tEzLj+Kf0UdG8XSzYoDkgc9lfo
         biJg==
X-Gm-Message-State: ACgBeo0PU4L6DqgcUfH0w2VVFw6i+7IVzbkwhqN1ijPHDXA9+lxrP7LS
        lkWm8s9jjd+psNj8V+sZ3VckEl8tK0WnPYMEb8K6CA==
X-Google-Smtp-Source: AA6agR5jCD3pIR3cTPWXhYwrJkkOyIzRNAQfkcpFyqABpFAOiUGDN4atjyxFn8y80plTdhYUW8KJZ3Yi4o2BYVYMdrg=
X-Received: by 2002:a37:794:0:b0:6ba:c4c6:5772 with SMTP id
 142-20020a370794000000b006bac4c65772mr4607540qkh.257.1660902228734; Fri, 19
 Aug 2022 02:43:48 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20220816081153.1580612-1-kashyap.desai@broadcom.com> <Yv7QvMADD7g3yPWh@nvidia.com>
In-Reply-To: <Yv7QvMADD7g3yPWh@nvidia.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHrfIfLJ9VN7XzL87A1I1MQ3pmjvwHYSPW6rYGNp1A=
Date:   Fri, 19 Aug 2022 15:13:47 +0530
Message-ID: <2b8cd62b4c5c0f9551977909981246d8@mail.gmail.com>
Subject: RE: [PATCH rdma-rc v1] RDMA/core: fix sg_to_page mapping for boundary condition
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005e533f05e694ef62"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000005e533f05e694ef62
Content-Type: text/plain; charset="UTF-8"

> > All addresses other than 0xfffffffffff00000 are stale entries.
> > Once this kind of incorrect page entries are passed to the RDMA h/w,
> > AMD IOMMU module detects the page fault whenever h/w tries to access
> > addresses which are not actually populated by the ib stack correctly.
> > Below prints are logged whenever this issue hits.
>
> I don't understand this. AFAIK on AMD platforms you can't create an IOVA
> mapping at -1 like you are saying above, so how is
> 0xfffffffffff00000 a valid DMA address?

Hi Jason -

Let me simplify - Consider a case if 1 SGE has 8K dma_len and starting dma
address is <0xffffffffffffe000>.
It is expected to have two page table entry - <0xffffffffffffe000 > and
<0xfffffffffffff000 >.
Both the DMA address not mapped to -1.   Device expose dma_mask_bits = 64,
so above two addresses are valid mapping from IOMMU perspective.

Since end_dma_addr will be zero (in current code) which is actually not
end_dma_addr but potential next_dma_addr, we will only endup set_page() call
one time.

I think this is a valid mapping request and don't see any issue with IOMMU
mapping is incorrect.

>
> Or, if the AMD IOMMU HW can actually do this, then I would say it is a bug
> in
> the IOMM DMA API to allow the aperture used for DMA mapping to get to the
> end of ULONG_MAX, it is just asking for overflow bugs.
>
> And if we have to tolerate these addreses then the code should be designed
> to
> avoid the overflow in the first place ie 'end_dma_addr'
> should be changed to 'last_dma_addr = dma_addr + (dma_len - 1)' which does
> not overflow, and all the logics carefully organized so none of the math
> overflows.

Making 'last_dma_addr = dma_addr + (dma_len - 1)' will have another side
effect. Driver may get call of set_page() more than max_pg_ptrs.
I have not debug how it can happen, but just wanted to share result with
you.  I can check if that is a preferred path.
'end_dma_addr' is used in code for other arithmetic.

How about just doing below ? This was my initial thought of fixing but I am
not sure which approach Is best.

diff --git a/drivers/infiniband/core/verbs.c
b/drivers/infiniband/core/verbs.c
index e54b3f1b730e..56d1f3b20e98 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2709,7 +2709,7 @@ int ib_sg_to_pages(struct ib_mr *mr, struct
scatterlist *sgl, int sg_nents,
                        prev_addr = page_addr;
 next_page:
                        page_addr += mr->page_size;
-               } while (page_addr < end_dma_addr);
+               } while (page_addr < (end_dma_addr - 1));

                mr->length += dma_len;
                last_end_dma_addr = end_dma_addr;

>
> Jason

--0000000000005e533f05e694ef62
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
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIL5nb9jyAAhz7+7vcQ3XSEshf5nq
M58B4oBhWB7REaoEMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDgxOTA5NDM0OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQA9zydsmzU5I+2dTP8t1yaVjl3snC1D6xVuYugCJrmBd4Dw
urfaXk727gStgREIeMKJtkzRLXigYePNs0peJWT+6gk1BOeZVk7nexwgk6ivabyRB/Qgqm83D8fa
MWyHB6KQo2mTg90kJRrBxgsBtnWTP/9I3vcMBuNV991rvDuWELMEZHMjsJHyTKfP8SqTP8unB7Oy
ZXE/qYRcaD6BK33gasHvTb7QarC5LTpquFRjiWMWaUCsxbZn1QQ6kfPhmtR9fuF258QpwIH5pkUj
2MncF8cxP3nCbGJ4bOF4GqRtoq/Jx1FE6PG/Iy+mh/FlMPB0GO3SBQtWKhen7DC3oGBv
--0000000000005e533f05e694ef62--
