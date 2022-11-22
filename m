Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B943634B0B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Nov 2022 00:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiKVXYc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 18:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbiKVXYb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 18:24:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D35C67E1;
        Tue, 22 Nov 2022 15:24:30 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s5so9891732wru.1;
        Tue, 22 Nov 2022 15:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaAzqk69C6gq7fKs0lav/HfgVNkVJnM/0yYRb2OIFJ0=;
        b=kdDxBIO8wpDJmMs/OKuJdTcQ3pdOLiHeXC1vdEcDcwbwZWDCXDFxo16hUjiN621FpK
         mdw9rdp9yZcYlR/c2eabQAbb4nYd9qsEz72vqyUkL8O5Nm32mvpyBhQ/8O/1UsGmKYGc
         Eocr6de3Ay1yzjqYL36ed8tpYIYXm9ASkdkTw8GuhsBqN2yvBCvmHMsODOmGQhN+85HR
         SbiTdNtEel/ukFW8QwDXpI5BOTBePj5TZ00US1LCN3hNdnFfCRVkQEKtkuwLB8FU3zDU
         6lG2hTPs1Wm5oU7A3kbs+25UCafJJ11vUFLs0b5mHur23cDux0ckqEQ3EBUAO/sydo4a
         MayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UaAzqk69C6gq7fKs0lav/HfgVNkVJnM/0yYRb2OIFJ0=;
        b=EYlcdWFChpjj5OwkzGFuOAhTEfzeTQcnQWdzqAHxwlF0DOrBKvCaKs3bORwVP+FZlk
         PUi93Qye2UeGGiVh8W7h949HKSLhUxl16uC7pzvuk2fa2/jaPMTPeaoWA4fwYmkaoVq5
         UexiMXDwABvVt4PwXAgRtnkHwN8XVBN5DdnyJM+AXSxmjLNiS6PTXVKvJR57FDLVXalK
         x/KjqBlZn0qUV/91vAC1dUXXlFWeHS/nQjo2/yeBJ+NXnbmimgzvLUTBlBdplxNBMg6v
         98CARdCkHoz4Mf+rPXIH5S7s7gZIkE4xHYD8x/6qJJOrGZUp8goq+ev4OFlVSTzS3fh8
         0hOg==
X-Gm-Message-State: ANoB5pmlvpX0sajKGBAwuH9+eo5p2eAa3wt1IStv9RQIKI+xUPd6W+Dk
        aRaAdruEOkWqZvxFXdwZO+w=
X-Google-Smtp-Source: AA0mqf6+yw6mpKB9xa9NFJqFdhKc7fZOl1RYacOQ4qNCdTBBQoBuOMlesncowctYPrGws8BnLmyaZA==
X-Received: by 2002:adf:a546:0:b0:234:d3ce:6b32 with SMTP id j6-20020adfa546000000b00234d3ce6b32mr15476340wrb.718.1669159468425;
        Tue, 22 Nov 2022 15:24:28 -0800 (PST)
Received: from suse.localnet (host-79-56-6-38.retail.telecomitalia.it. [79.56.6.38])
        by smtp.gmail.com with ESMTPSA id p16-20020adfce10000000b00241e7007905sm2031421wrn.75.2022.11.22.15.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 15:24:27 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Li Zhijian <lizhijian@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [for-next PATCH 4/5] RDMA/rxe: refactor iova_to_vaddr
Date:   Wed, 23 Nov 2022 00:24:26 +0100
Message-ID: <2158152.NgBsaNRSFp@suse>
In-Reply-To: <Y3vJQkc40o5zfM5v@ziepe.ca>
References: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com> <CAPj211to20yHUy8o-Lg6TMjB5rpwrfPCUtQqxfeDFHUDR4+wJw@mail.gmail.com> <Y3vJQkc40o5zfM5v@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On luned=EC 21 novembre 2022 19:53:54 CET Jason Gunthorpe wrote:
> On Wed, Nov 16, 2022 at 01:37:14PM +0100, Fabio M. De Francesco wrote:
> > > -     return (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
> > > +     if (mr->ibmr.type =3D=3D IB_MR_TYPE_USER) {
> > > +             char *paddr;
> > > +             struct page *pg =3D mr->map[m]->buf[n].page;
> > > +
> > > +             paddr =3D kmap_local_page(pg);
> > > +             if (paddr =3D=3D NULL) {
> > > +                     pr_warn("Failed to map page");
> > > +                     return NULL;
> > > +             }
> >=20
> > I know nothing about this code but I am here as a result of regular che=
cks
> > for changes to HIGHMEM mappings across the entire kernel. So please=20
forgive
> > me if I'm objecting to the correct changes.
> >=20
> > 1) It looks like this code had a call to page_address() and you convert=
ed=20
it
> > to mapping with kmap_local_page().
>=20
> It only worked properly because the kconfig is blocking CONFIG_HIGHMEM
> so ZONE_HIGHMEM doesn't exist. These pages are obtained from GUP and
> could be anything.
>=20
> This is done indirectly through
>=20
> config INFINIBAND_VIRT_DMA
>         def_bool !HIGHMEM
> But this patch is undoing parts of what are causing that restriction
> by using the proper APIs. Though I'm not sure if we can eventually get
> to remove it for RXE completely.
> Jason

Ah, OK. This code was for !HIGHMEM kernels...

I understand but, FWIW I doubt that the use of page_address(), instead of=20
kmapping, should ever be made on the bases that kconfig is blocking HIGHMEM=
=2E =20

However, if I understand correctly, that restriction (!HIGHMEM) is going to=
 be=20
removed. Therefore, page_address() will break on HIGHMEM and Jason is=20
correctly converting to kmap_local_page().

There is only one thing left... I think that he missed another mail from me=
=2E=20
The one you responded to was missing the final paragraph, so I sent another=
=20
message few minutes later.

kmap_local_page() returns always valid pointers to kernel virtual addresses=
=2E I=20
can't see any ways for kmap_local_page() to return NULL. Therefore, I was=20
asking for the reason to check for NULL.

Thanks,

=46abio



