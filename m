Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E55B58F0
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Sep 2022 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiILLCR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Sep 2022 07:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiILLCQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Sep 2022 07:02:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808B321E04
        for <linux-rdma@vger.kernel.org>; Mon, 12 Sep 2022 04:02:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lz22so19274079ejb.3
        for <linux-rdma@vger.kernel.org>; Mon, 12 Sep 2022 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date;
        bh=D3U1AM/Int/NP3wiczFtQcZQ1hc6/5onoeTOiH5DrgI=;
        b=U9Dg3ZhydavfHpoCAK1lbwrXcmknZbqQUUO/xa2tvbIvfPi13BMSgi5tmQxFvp8XSQ
         HtI+AzxC7pvJdFuUw7igoJdIWW/Azcle80dIHQjckHxxjEI6tUqdSgvNoKKAOZm5kSS4
         yZsW9jsNTbk0wF9w7da7zIJ9HH/0VZjUC2EF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc:subject:date;
        bh=D3U1AM/Int/NP3wiczFtQcZQ1hc6/5onoeTOiH5DrgI=;
        b=ii4InCurPvrUZRRjFlvk85Bzw3gGlXzZozB/WSuewHsqIaig/dQr/q43zDycyKJo6s
         o/EDs0phu0UBkbpE8clTJ1Jjz5JmsJvIwvLk+dU9XGP5W+w3cIdWiUU85vZzV83owEkH
         pHu7PCg1B1Y58BC3tC+H9taIm1wnLxKha6/fV2tNibMfldQXSBu2fS02QX5vR9vsTFmy
         GsN803ZgKUQ2mjcZEReJilanjOaYrZ2kvsg2SRmY+De9zOSyzxn5v/fpXLEza9/6LfMF
         1k+axQ+ageLb4JidIve21BylRee3ZuDwKN8JBl9ZYImjUnP6LWwq7Zz26dRHz+CpE9of
         cegw==
X-Gm-Message-State: ACgBeo2Fko7eBYvIas1Ro1fKdt2eJb6/sWU9ME8u72IgBVMOV3IcRgav
        HgmXR1ITGiv7XRisKay1/LlPizv6wTnBxCVzjf2oBQ==
X-Google-Smtp-Source: AA6agR4bZZicX7L/PPeFEIsPRmSNonzAP2JV1KyR3TNqrRpi4TJr+762+bjOvg9FMu9uW+DqKgosNxmj7wzjUD3O1aY=
X-Received: by 2002:a17:907:7da3:b0:776:a0ae:5147 with SMTP id
 oz35-20020a1709077da300b00776a0ae5147mr13514865ejc.662.1662980533928; Mon, 12
 Sep 2022 04:02:13 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20220816081153.1580612-1-kashyap.desai@broadcom.com>
 <Yv7QvMADD7g3yPWh@nvidia.com> <2b8cd62b4c5c0f9551977909981246d8@mail.gmail.com>
 <Yv94fYp8869XZKFU@nvidia.com> <2651261c642ca672864c2c6c8e7a9774@mail.gmail.com>
 <YwjHSBr3f4o0hXBX@nvidia.com> <85a37f42a08f4163cb5440d8825b7e7a@mail.gmail.com>
 <YxeEX7XcwYpnbP3M@nvidia.com>
In-Reply-To: <YxeEX7XcwYpnbP3M@nvidia.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHrfIfLJ9VN7XzL87A1I1MQ3pmjvwHYSPW6AdeSkpYDPgwgJgHwx5v4Agd0kkUBl0nyQAG3eiRMrUSJ5PA=
Date:   Mon, 12 Sep 2022 16:32:09 +0530
Message-ID: <fc18b231b93a47b8ca1314f3778bfe1a@mail.gmail.com>
Subject: RE: [PATCH rdma-rc v1] RDMA/core: fix sg_to_page mapping for boundary condition
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000003894705e878d438"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--00000000000003894705e878d438
Content-Type: text/plain; charset="UTF-8"

>
> On Thu, Sep 01, 2022 at 05:36:57PM +0530, Kashyap Desai wrote:
> > > -----Original Message-----
> > > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > > Sent: Friday, August 26, 2022 6:45 PM
> > > To: Kashyap Desai <kashyap.desai@broadcom.com>
> > > Cc: linux-rdma@vger.kernel.org; leonro@nvidia.com; Selvin Xavier
> > > <selvin.xavier@broadcom.com>; Andrew Gospodarek
> > > <andrew.gospodarek@broadcom.com>
> > > Subject: Re: [PATCH rdma-rc v1] RDMA/core: fix sg_to_page mapping
> > > for boundary condition
> > >
> > > On Mon, Aug 22, 2022 at 07:51:22PM +0530, Kashyap Desai wrote:
> > >
> > > > Now, we will enter into below loop with dma_addr = page_addr =
> > > > 0xffffffffffffe000 and "end_dma_addr = dma_addr + dma_len" is
ZERO.
> > > > eval 0xffffffffffffe000 + 8192
> > > > hexadecimal: 0
> > >
> > > This is called overflow.
> >
> > Is this not DMAable for 64bit DMA mask device ? It is DMAable. So not
> > sure why you call it as overflow. ?
>
> Beacuse the normal math overflowed.
>
> Should it work? Yes. Is it a special edge case that might have bugs?
> Certainly.
>
> So the IOMMU layer shouldn't be stressing this edge case at all. It is
crazy, there
> is no reason to do this.
>
> > I agree that such mapping is obviously dangerous, but it is not
> > illegal as well.
> > Same sgl mapping works if it is direct attached Storage, so there will
> > be a logical question why IB stack is not handling this.
>
> Oh that is probably very driver dependent.
>
> > > You need to write the code so you never create the situation where
> > > A+B=0 - don't try to fix things up after that happens.
> >
> > In proposed patch, A + B = 0 is possible, but it will be considered as
> > end of the loop.
>
> Like I said, don't do that. End of the loop is -1 which requires a
different loop
> logic design, so send a patch like that.
>
> But I would still send a patch for iommu to not create this in the first
place.


Jason -
I noted your response.  Issue is possible to any RDMA h/w and issue is not
completely Rejected. It is just that you need another way to fix it
(preferred to handle it in iommu)
We can reopen discussion if we see another instance from other vendors.
Quick workaround is - use  63 bit DMA mask in rdma low level driver if
someone really wants to work around this issue until something more robust
fix committed in upstream kernel (either ib stack or iommu stack).

We can close this thread.

Kashyap
>
> Jason

--00000000000003894705e878d438
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
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIIfBm0509F/TPHHfjjvzFTN1Med0
ZxafEh6nYcN3jpMdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDkxMjExMDIxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCkaiaFbwZy20ZBDbd0vZhXf+i0axSkoDR9K/prrwEMn290
ppdVxrzpttg7MeP8FAH/F726UmYQIdg+aB+DwW9spLQQ5+phjYovbt+BuGT3/iyHXUx+KChyN8mO
CYVM+8K2X7c8lFaY7wFO0nkVWj/J0CmcTXAA4uk0BsImQReUhIaLMOJ12b2wSpNkdp+kqoUumVPN
QlBGbE8Nd2PsF/5dWfilKyJQYtmOfT0stoc25SOsHDS+yWA6HSBF/4PA0L2I8Mg61qN7wt86o65G
fkQjEOwaZpDCo4I7UGFmmgbuIkw+fMXJd/6++73iIe2+KtOhRN8tApSdCZJ9WL+blVmB
--00000000000003894705e878d438--
