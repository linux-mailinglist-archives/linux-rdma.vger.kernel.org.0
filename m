Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4560659C185
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 16:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiHVOV3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 10:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiHVOV2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 10:21:28 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089FC255B1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 07:21:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c20so7950388qtw.8
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc;
        bh=HBxlzLf8CLLcE2YHyvP3A9uNAZjtwUszaz5yNsQU960=;
        b=D/ctGuiNPImEVBH/nPqNHTibLaE3d+T1vwIpkajBO3fWl1Oozd0O0Bjqx/bBpSXR8b
         JzX0tBO2D+Ln0sWYfKSc4oJ/wPdXWfafhpQbrxUX9NB1OSamQyUq6Ovo5xBpdHmsknky
         syhQi00QsDGUgNdZQV0TpjIzgPVjC5IoeVaBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc;
        bh=HBxlzLf8CLLcE2YHyvP3A9uNAZjtwUszaz5yNsQU960=;
        b=W7uFOyG10ntSYLouFr5D79RKKnH7QamworLZ9OxTPdEP+fgy/SGQUd2Hpia1S852IY
         7LfMbX5b4phOkTfg72KUU+IdYg0u02Up+23XRhL4csta1eMCCH2owj9pFy9CyaAYaJHJ
         loJrawyHjNTS5IVf8YW9HO6fp9B5TOs36C16iPQXJG41PU80xRrbAicf8TlZ7PN+BwcC
         hZgWIu1XWsxF+coC8ahCHqyYf+l2ie9/3jkmAOzPWY9kSTOlGbl4dqFtsnNAN5xayyUD
         6Cky8mNlUtB9FHYg6af/bbGENJ06FHZgU6EoNiolDNkTrl1BDwH4zKAd95xQN6lj9DeL
         nbxA==
X-Gm-Message-State: ACgBeo3224Cmkp+LrVHItvnu+Yonuc1FHARXfYr2/vTuMjmq5P4RvkdH
        lUqLKUd+l7CuxUzghELf6wp2QNeUkqtLkCisMKsBUJ4fQqk=
X-Google-Smtp-Source: AA6agR5pARdHKR75c68m7kPR1+eZDx5rEWDDyPzUHf9nCPSRLyzJVZnwLfOyP5YKkp3SbNZK/pPh/oII0YK5SsVnhTw=
X-Received: by 2002:a05:622a:5c8a:b0:344:ba8f:8892 with SMTP id
 ge10-20020a05622a5c8a00b00344ba8f8892mr4010471qtb.297.1661178084991; Mon, 22
 Aug 2022 07:21:24 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20220816081153.1580612-1-kashyap.desai@broadcom.com>
 <Yv7QvMADD7g3yPWh@nvidia.com> <2b8cd62b4c5c0f9551977909981246d8@mail.gmail.com>
 <Yv94fYp8869XZKFU@nvidia.com>
In-Reply-To: <Yv94fYp8869XZKFU@nvidia.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHrfIfLJ9VN7XzL87A1I1MQ3pmjvwHYSPW6AdeSkpYDPgwgJq1d7LDw
Date:   Mon, 22 Aug 2022 19:51:22 +0530
Message-ID: <2651261c642ca672864c2c6c8e7a9774@mail.gmail.com>
Subject: RE: [PATCH rdma-rc v1] RDMA/core: fix sg_to_page mapping for boundary condition
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b0616505e6d52947"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000b0616505e6d52947
Content-Type: text/plain; charset="UTF-8"

>
> On Fri, Aug 19, 2022 at 03:13:47PM +0530, Kashyap Desai wrote:
> > > > All addresses other than 0xfffffffffff00000 are stale entries.
> > > > Once this kind of incorrect page entries are passed to the RDMA
> > > > h/w, AMD IOMMU module detects the page fault whenever h/w tries to
> > > > access addresses which are not actually populated by the ib stack
correctly.
> > > > Below prints are logged whenever this issue hits.
> > >
> > > I don't understand this. AFAIK on AMD platforms you can't create an
> > > IOVA mapping at -1 like you are saying above, so how is
> > > 0xfffffffffff00000 a valid DMA address?
> >
> > Hi Jason -
> >
> > Let me simplify - Consider a case if 1 SGE has 8K dma_len and starting
> > dma address is <0xffffffffffffe000>.
> > It is expected to have two page table entry - <0xffffffffffffe000 >
> > and
> > <0xfffffffffffff000 >.
> > Both the DMA address not mapped to -1.   Device expose dma_mask_bits =
64,
> > so above two addresses are valid mapping from IOMMU perspective.
>
> That is not my point.
>
> My point is that 0xFFFFFFFFFFFFFFF should never be used as a DMA address
> because it invites overflow on any maths, and we are not careful about
this in
> the kernel in general.

I am not seeing Address overflow case.  It is just that buffer is ending
at "0xffffffffffffffff" and it is a genuine dma buffer.
So, worst case scenario is DMA address = fffffffffffffffe and dma_len = 1
byte.  This must be handled as genuine dma request.

>
> > Since end_dma_addr will be zero (in current code) which is actually
> > not end_dma_addr but potential next_dma_addr, we will only endup
> > set_page() call one time.
>
> Which is the math overflow.
Let's take this case - ib_sg_to_pages(struct ib_mr *mr, struct scatterlist
*sgl, int sg_nents,
                unsigned int *sg_offset_p, int (*set_page)(struct ib_mr *,
u64))

sg_nents = 1
struct scatterlist {
    unsigned long page_link;
    unsigned int offset;		= 0
    unsigned int length;		= 8192
    dma_addr_t dma_address;	= 0xffffffffffffe000
    unsigned int dma_length;	= 8192

Below loop will run only one time.
        for_each_sg(sgl, sg, sg_nents, i) {

Now, we will enter into below loop with dma_addr = page_addr =
0xffffffffffffe000 and "end_dma_addr = dma_addr + dma_len" is ZERO.
eval 0xffffffffffffe000 + 8192
hexadecimal: 0

                do {
                        ret = set_page(mr, page_addr);
<<< - This callback will be called one time with page_addr =
0xffffffffffffe000
                        if (unlikely(ret < 0)) {
                                sg_offset = prev_addr -
sg_dma_address(sg);
                                mr->length += prev_addr - dma_addr;
                                if (sg_offset_p)
                                        *sg_offset_p = sg_offset;
                                return i || sg_offset ? i : ret;
                        }
                        prev_addr = page_addr;
next_page:
                        page_addr += mr->page_size;
<<< - After one iteration  page_addr = 0xfffffffffffff000
                } while (page_addr < end_dma_addr);
<<< - This loop will break because (0xfffffffffffff000 < 0) is not true.
>
> > I think this is a valid mapping request and don't see any issue with
> > IOMMU mapping is incorrect.
>
> It should not create mappings that are so dangerous. There is really no
reason to
> use the last page of IOVA space that includes -1.

That is correct, but if API which deals with mapping they handle this kind
of request gracefully is needed. Right ?

>
> > > And if we have to tolerate these addreses then the code should be
> > > designed to avoid the overflow in the first place ie 'end_dma_addr'
> > > should be changed to 'last_dma_addr = dma_addr + (dma_len - 1)'
> > > which does not overflow, and all the logics carefully organized so
> > > none of the math overflows.
> >
> > Making 'last_dma_addr = dma_addr + (dma_len - 1)' will have another
> > side effect.
>
> Yes, the patch would have to fix everything about the logic to work with
a last
> and avoid overflowing maths

Noted.

>
> > How about just doing below ? This was my initial thought of fixing but
> > I am not sure which approach Is best.
> >
> > diff --git a/drivers/infiniband/core/verbs.c
> > b/drivers/infiniband/core/verbs.c index e54b3f1b730e..56d1f3b20e98
> > 100644
> > --- a/drivers/infiniband/core/verbs.c
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -2709,7 +2709,7 @@ int ib_sg_to_pages(struct ib_mr *mr, struct
> > scatterlist *sgl, int sg_nents,
> >                         prev_addr = page_addr;
> >  next_page:
> >                         page_addr += mr->page_size;
> > -               } while (page_addr < end_dma_addr);
> > +               } while (page_addr < (end_dma_addr - 1));
>
> This is now overflowing twice :(

I thought about better approach without creating regression and I found
having loop using sg_dma_len can avoid such issues gracefully.
How about original patch. ?

>
> Does this bug even still exist? eg does this revert "fix" it?
>
>
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/
?id=a
> f3e9579ecfb

Above revert is part of my test. In my setup "iommu_dma_forcedac = $2 =
false".
Without above revert, it may be possible that I can hit the issue
frequently. Currently I need heavy IO of 1MB to hit this issue. Almost
~8GB is attempted in my test.
Total 64 NVME target of 128 QD is sending 1MB IO. Looks like first DMA
mapping is attempted from <4GB and whenever it exhaust and start mapping >
4GB memory region, this kind of IOV mapping occurs.

Kashyap

>
> It makes me wonder if the use of -1 is why drivers started failing with
this mode.
>
> Jason

--000000000000b0616505e6d52947
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
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDYDFIChHxk15533ub68UOZ5CGi4
RZ+qz8UHu452kLruMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDgyMjE0MjEyNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBxkLHiNFf5FvDWkT+7lllXra+ZEMe6AUyb/4fYKoxOAW/R
XVDF3rNtjhFGSw2oR8mk3eK3fnG6EdVMyK5FLdxkfHgLrvSUih/dC8mdwy916S3yHsNOg/pqitjy
r9f0N7/CL0RfuVLbN6SfPtMYE+I+zAm5Y54uibfofocSwEqyftYwgwWj9Zen0Jp4KEhGC8qXeoLy
GTBDFUjHLd0mUPFGcA4vfYz2/dIPPz53xqBtYOzWDe+a9FO56utkD7WctbbmTxAz0S3v3hxe/q29
i2R0rYKfbnCkDgBHbhULZ4C1FfFe3NpATBmX+9vsS2DiVUU+ki8qb5Jvib/z+OtXsGOQ
--000000000000b0616505e6d52947--
