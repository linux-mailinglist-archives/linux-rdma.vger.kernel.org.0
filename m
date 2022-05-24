Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBCA5331AE
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 21:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbiEXTTI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 15:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEXTTH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 15:19:07 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD0764BCA
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 12:19:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n10so37315791ejk.5
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UtJfoxcmxh4p5gn5ZBZR16DlkStePWq+mnG7T2bej/g=;
        b=KjgwRAXgwYxOQkTPWa+kIEYy4ozTQgi0D0yuWaP830hXW2CLl34DdoRyLIFpqXGAKf
         SXaxuSxo+V6Jow5JV/Cg1tmcv3IOqBZfZDelsHFEOLNTER0ztOt+eIBo+xzydbG3Yozn
         oArpYkW8VpSmv4Q0sMmPtwpiQJo/Of5Oxwsx5n7Hj2Aie19p+gbyTNyZp1xDyjNWrPDj
         pZrbhy4ThCra+dJNrplITmDUvafUaj3agGTsWTlp923NjR2fZ1Puu6Wov2YjJ7+WIBGk
         4c/HXqMiD949BXl1bnPQEKngTTL2lqcg2mWs0hoQC11gTLxeFri9RLhdyJTEU2wP3TO8
         wa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtJfoxcmxh4p5gn5ZBZR16DlkStePWq+mnG7T2bej/g=;
        b=TCckn1hK9RGACbr6MnweO1FhPxuCAtLgPlFAPGyJFuWeOdE62Agxe4iPmWWU5ez6zO
         7eHut4HAFcBAkokMsOLg+3RnanjwJOiYrJS6sPcuE+9X4ZKor3gLLMcmBzrHYIt6g8ur
         2146GOTJSIlSpyCBGlQ8Ez1J4XWo9CvdyzFjZuwZZT3uRU03rvAtwp4yQGcD2pvTSMMh
         jLoUmCGXQaR1mSwyJaaJ5TeIpxYVTKQGpZ6SyDZaq16ZVhl5MPnKue1Ts9YAqZDKTXxG
         Spci4mV3y1k/kXXlX7SCsa3LXMuJgARSSZcsn/je1pkNHkakQrbDi0i0Lz9/1uUesm5p
         dpwQ==
X-Gm-Message-State: AOAM531uomTwKeI3/XeKarQrQvZLZbP5SZKTYzF58DvNm5repKMHCoUe
        5Lk39iZ7Uy3wrg0JbDZo7ul1f6KmSnEqALjpDoFubZz6
X-Google-Smtp-Source: ABdhPJwpdBGVQs0lNvyrTNKfvE6J0bz8J3wxJw0kgnYETR7ovUQK39AJO+NoGWZ9qmHHuQLwHr5Q3AAso1NS5NX4jVE=
X-Received: by 2002:a17:906:3958:b0:6fe:90ef:c4b with SMTP id
 g24-20020a170906395800b006fe90ef0c4bmr26269292eje.36.1653419945312; Tue, 24
 May 2022 12:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAFMmRNyHUSg6_+af9W39e36aCx2a=_9WC8MB08W9XfnMKoYXAQ@mail.gmail.com>
 <YoyEPnFpd7/mI1Mm@unreal> <CAFMmRNxS56xWoZ_-Sz4yBrZvK95vdpQR9xrxjDhkAAGi3krK=A@mail.gmail.com>
 <Yo0tJPKOCHkqF5Gl@unreal>
In-Reply-To: <Yo0tJPKOCHkqF5Gl@unreal>
From:   Ryan Stone <rysto32@gmail.com>
Date:   Tue, 24 May 2022 15:18:53 -0400
Message-ID: <CAFMmRNx0wgPQRhMpHz+9h9fXv-bPbzPDRmwtZrHqYSc5WHmfHQ@mail.gmail.com>
Subject: Re: Possible bug in ipoib_reap_dead_ahs in datagram mode
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I believe that if we never enter that if statement, then we will leak
the entries that are supposed to be cleaned up.  That's better than
the use-after-free that I feared but still not good.

On Tue, May 24, 2022 at 3:08 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, May 24, 2022 at 09:33:52AM -0400, Ryan Stone wrote:
> > On Tue, May 24, 2022 at 3:07 AM Leon Romanovsky <leon@kernel.org> wrote:
> > > IPoIB in mlx5 is HW offloaded version of ulp/ipoib one. AFAIK, it doesn't
> > > change "tx_tail" and we won't enter into this if (...).
> > >
> > > Thanks
> >
> > I don't quite follow this response.  Is this the if statement that you
> > mean that we won't fall into?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/infiniband/ulp/ipoib/ipoib_ib.c#n682
>
> Yes, I think so, maybe wrong here.
