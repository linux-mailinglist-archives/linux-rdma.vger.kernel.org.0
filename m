Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F061D9060
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2020 08:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgESGzs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 02:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgESGzr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 02:55:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EBBC061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2020 23:55:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 50so14488160wrc.11
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2020 23:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TANWEOqfTxV9xotVFJrbgUmpK/BcquydUVLVqIzATJw=;
        b=DFu/enkffHVSAltF3ls3sxCDN6A5lKhqggJ1s6HCTXKZzdgcaVMnYYGgQvoe0Lzr1I
         upnnHFOWshBVZDYO/h+mYUAcigT40QMb0+mZqiquUwyY1bJny81btQxlN6YaTgzQi85c
         mBDv4uwqoDBBQDkY1nMvsuvsZ9aQyBTi/piaHdxTUkEotPsdwiXHHn0Bzs166wYgB+vs
         dRqBpkFHa4q0dxXFCO8AR6glcmEAaAT23BWQ1P0yrvD7sfxrdMUEkfGsNMNUK4cmfnMe
         o/12cLMZIuUVsYBjuZEHBUubwSAcYBlmuCAjrfPzJ2PBbdb7InSnw2IhRFAJxFIINlmQ
         e2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TANWEOqfTxV9xotVFJrbgUmpK/BcquydUVLVqIzATJw=;
        b=S5+BXWB6vI/uPT421TCqGXRTYFeVVkCwLqD5Skg3ooLw9UL2xkyv5GhIBNGtvX/lFQ
         CoZ8TyhSmJ6V39+on3V0lc1XAJG4QGqUy/KEsRd0m1EMEb3Vqo0K5+crNwUYMiB+1fus
         Wcf8Q1SpiGZLxY6/vR5GfV610PLd/DUDXkfsHfbCiktTyG0mCO2cKwyuqVad8hz4EzoQ
         4UOuHG4Atn0xaoFfpbGtIwNn15EkHVsh+EFRxG+peFMpMBU1BePdb1O4sQ8LC7YyrW5O
         pP5KaS3WjLbA42Glt68Zi5cO9cjR56vNB+hJhsA1rLjp1fKDFab/fvO55CV/nzJZ5xpX
         YuDA==
X-Gm-Message-State: AOAM530IlaCYvIl1YjL4HXwg1uFtmNjodAutC75ekVYl41BgZI2Hpem0
        N62tSQna4eAfmeYLe2fH0OSvHMuwpELqJZOZp4OL
X-Google-Smtp-Source: ABdhPJyQWt5z4SzG/sMVYcC8+mS4N1nabJfc9BlW0x7OsKiZAW/PYP3ibpa34gAe3DBDIbC+UDNWbjyHXXLOPaYNCE0=
X-Received: by 2002:adf:82c3:: with SMTP id 61mr25175979wrc.326.1589871346192;
 Mon, 18 May 2020 23:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200518205725.72eb3148@canb.auug.org.au> <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
In-Reply-To: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Tue, 19 May 2020 08:55:35 +0200
Message-ID: <CAHg0Huy7JKttHs9aEJEaRgwZAM3jcZH-Wb0p8Vy6KBVv9bW0Zg@mail.gmail.com>
Subject: Re: linux-next: Tree for May 18 (drivers/infiniband/ulp/rtrs/rtrs-clt.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Randy,

On Mon, May 18, 2020 at 5:01 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/18/20 3:57 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20200515:
> >
>
> on i386:
>
> ../drivers/infiniband/ulp/rtrs/rtrs-clt.c: In function =E2=80=98alloc_ses=
s=E2=80=99:
> ../drivers/infiniband/ulp/rtrs/rtrs-clt.c:1447:42: error: =E2=80=98BLK_MA=
X_SEGMENT_SIZE=E2=80=99 undeclared (first use in this function); did you me=
an =E2=80=98UDP_MAX_SEGMENTS=E2=80=99?
>   sess->max_pages_per_mr =3D max_segments * BLK_MAX_SEGMENT_SIZE >> 12;
>                                           ^~~~~~~~~~~~~~~~~~~~
>                                           UDP_MAX_SEGMENTS
>
>
> Full randconfig file is attached.
Thanks a lot for the mail. Didn't try to compile this with block layer
disabled :/ Will send a fix for this today.
Best,
Danil

>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
