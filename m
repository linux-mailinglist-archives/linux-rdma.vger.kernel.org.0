Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603FA5A964F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 14:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiIAMHD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 08:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIAMHB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 08:07:01 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDA12AE30
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 05:07:00 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id y15so9933617qvn.2
        for <linux-rdma@vger.kernel.org>; Thu, 01 Sep 2022 05:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:from:to:cc:subject:date;
        bh=Wf43ElFo+FS9PKVIVgtE9so4ujMaCrVoIH1Nss6PbFs=;
        b=aaRuozjgwa21wtLWUgyDt3blAVwiHeo+PSv2BdUJJCZaR/R9CT2ujXjfR+Qemn1y+M
         iy2gRdBkbNqWS9Kn7FeeAAgLmzBoZ9twwXBqGNiSbDX0ZFs2wXcArcBcfrfJQf+tUGi3
         1DoP7piaEB13518be7cUPGsiBmqvbZCCBMn8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:thread-index:mime-version:in-reply-to
         :references:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Wf43ElFo+FS9PKVIVgtE9so4ujMaCrVoIH1Nss6PbFs=;
        b=QIogOpEARB0LdqcOimHi7lSpAu13+Lvpu8Xxgf1JOE11a+285neeHMd8efXVXkU4LD
         vdjVwANwmRgKQ+3n5WHMpt+eMPEOtVDX3a9uZs3V800pnyXrdv5OciHKt7P6AYOBqMg/
         FzKXujdIxIuns1DjlRZB1Bcv2yjKyT+TrZkrZACuHAiyNle517YrdnI4mw5fBA54/U+f
         zybJFYsg1YJ7WdJngJczi1WcT65Hn8/2iM6/9T/+QBS/uUs7L5C5i1qBV7+hGYXKzrb1
         gG1pr96j+300Sox6Go/mQoHzWbpIpuMR/Fje0Kx55fDZPOd3SvTUTLyl2LdXCCGRLqrT
         N5ng==
X-Gm-Message-State: ACgBeo3ahzNi9O+R9IfzE4MxWLtTeI/XiSZR90VWf7ZulJ2FzanPGM+G
        Pi0rZkZftOFMFmDvGIGbPSbZlGmyeqpLfyLAL63+5QVLkjMvjw==
X-Google-Smtp-Source: AA6agR6nNAAafc1tcObuhVRhk+GT+ij/QOyauqasFg+HQFG3jo9TUQvy/uDwgqAIKdzkg6M7TTHRQAd9pKtq+JYSn5I=
X-Received: by 2002:a05:6214:2aa2:b0:477:1882:3dc with SMTP id
 js2-20020a0562142aa200b00477188203dcmr23445461qvb.11.1662034019741; Thu, 01
 Sep 2022 05:06:59 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20220816081153.1580612-1-kashyap.desai@broadcom.com>
 <Yv7QvMADD7g3yPWh@nvidia.com> <2b8cd62b4c5c0f9551977909981246d8@mail.gmail.com>
 <Yv94fYp8869XZKFU@nvidia.com> <2651261c642ca672864c2c6c8e7a9774@mail.gmail.com>
 <YwjHSBr3f4o0hXBX@nvidia.com>
In-Reply-To: <YwjHSBr3f4o0hXBX@nvidia.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHrfIfLJ9VN7XzL87A1I1MQ3pmjvwHYSPW6AdeSkpYDPgwgJgHwx5v4Agd0kkWtTcYMEA==
Date:   Thu, 1 Sep 2022 17:36:57 +0530
Message-ID: <85a37f42a08f4163cb5440d8825b7e7a@mail.gmail.com>
Subject: RE: [PATCH rdma-rc v1] RDMA/core: fix sg_to_page mapping for boundary condition
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005e026c05e79c73e6"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000005e026c05e79c73e6
Content-Type: text/plain; charset="UTF-8"

> -----Original Message-----
> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> Sent: Friday, August 26, 2022 6:45 PM
> To: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: linux-rdma@vger.kernel.org; leonro@nvidia.com; Selvin Xavier
> <selvin.xavier@broadcom.com>; Andrew Gospodarek
> <andrew.gospodarek@broadcom.com>
> Subject: Re: [PATCH rdma-rc v1] RDMA/core: fix sg_to_page mapping for
> boundary condition
>
> On Mon, Aug 22, 2022 at 07:51:22PM +0530, Kashyap Desai wrote:
>
> > Now, we will enter into below loop with dma_addr = page_addr =
> > 0xffffffffffffe000 and "end_dma_addr = dma_addr + dma_len" is ZERO.
> > eval 0xffffffffffffe000 + 8192
> > hexadecimal: 0
>
> This is called overflow.

Is this not DMAable for 64bit DMA mask device ? It is DMAable. So not sure
why you call it as overflow. ?
My understanding is -
There is  a roll over (overflow) issue, If we get DMA address =
0xffffffffffffe000 and length = 16K. This is a last page of the possible
DMA range.
Similar discussion I found
@https://marc.info/?l=git-commits-head&m=149437079023021&w=2

We need to handle size vs end_address gracefully.

>
> Anything doing maths on the sgl's is likely to become broken by this -
which is
> why I think it is unnecessarily dangerous for the iommu code to general
dma
> addresses like this. It just shouldn't.
>
> > > It should not create mappings that are so dangerous. There is really
> > > no
> > reason to
> > > use the last page of IOVA space that includes -1.

I agree that such mapping is obviously dangerous, but it is not illegal as
well.
Same sgl mapping works if it is direct attached Storage, so there will be
a logical question why IB stack is not handling this.

> >
> > That is correct, but if API which deals with mapping they handle this
> > kind of request gracefully is needed. Right ?
>
> Ideally, but that is a game of wack a mole across the kernel, and
redoing
> algorithms to avoid overflowing addition is tricky stuff.
>
> > I thought about better approach without creating regression and I
> > found having loop using sg_dma_len can avoid such issues gracefully.
> > How about original patch. ?
>
> It overflows too.
>
> You need to write the code so you never create the situation where
> A+B=0 - don't try to fix things up after that happens.

In proposed patch, A + B = 0 is possible, but it will be considered as end
of the loop.  So let's say it was supposed to setup 8 sgl entries, A + B =
0 will be detected only after 8th entry is setup.
Current code detect A + B = 0 much early and that is what I am trying to
fix in this patch (This patch will not fix any roll over issue).
At least it will serve the purpose of creating correct sgl entries in low
level driver's Memory region through set_page() callback.

I am fine with your call since this is a concern case and it is going to
change core function.

We have two choice -
If function ib_sg_to_pages() can't handle such case, would you like to
detect such mapping error and at least return -EINVAL ?
OR
Just parse whatever mapping is received in sgl to low level driver and
don't really care about overflow case. (May be this patch can help.) ?


Kashyap

>
> Usually that means transforming the algorithm so that it works on a
"last byte"
> so we never need to compute an address that is +1 to the last byte,
which would
> be the overflown 0.
>
> > Above revert is part of my test. In my setup "iommu_dma_forcedac = $2
> > = false".
>
> So you opt into this behavior, OK
>
> Jason

--0000000000005e026c05e79c73e6
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
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIM8YSrmyd4J0tlpZRJtbRIv8PVu+
iXxBQnIL3vEDNJ/NMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDkwMTEyMDcwMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBp2PaeenVlIZdFoXV4n8H2ArsBJuhhEFcW9tvmalhP+oKX
HJqk/GF3+Cvhmv+kWNghpHeVAOBEUIjXVlVYJH7AIPQ/kUbzAD56PxZpqpyP8Nyu8yBREG+Yoj0w
jAqw+C4gg0DXVZRxiRemzookaR7LABSWJ2z65f9JLIOBXwAejELHyHJPNWoPvjQNZXFIxVwdCpb0
lzB4yT2FSN4rLer+2z5HCpMwBEyS49cDMqQ01ahqy8gMlyKeIaPgqtNU4aQY8pp5UZrMFA4E/tLZ
fW5c5NRm3nKimjm5onaEKpWn8Fn81uuxdKUUpHGRxbJFY7MP5KlilpQu8zntSHvnSlYx
--0000000000005e026c05e79c73e6--
