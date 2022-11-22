Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465CF634B65
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Nov 2022 00:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbiKVXzW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 18:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiKVXzV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 18:55:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D00BEB55;
        Tue, 22 Nov 2022 15:55:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so231827wmg.2;
        Tue, 22 Nov 2022 15:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cE01NZR3G4lAhA6w2A66fH8scEPgyQnlLBvPvIVhEzI=;
        b=cQt9/vvnU+jXKUAUPnVYegPKe9zVuR5zqZo5Zb0dEsh2OFB+GHlNlp5d7lzhQYbkQr
         q0V88J5X0Q01QC+k8o/Vg3iyG7AVvODWG+GS5ik64TtpDI9VxOX68+2Kehn6iXhXBCmv
         gWC+W9s23lHn9h8EwsQokksCz0isUYqB2q03J7FxOoUZCM77ZjhjvX0W0WnG8MJrWGpC
         xltNW5Y2MSbbfnF/97cpqoAY7Dt+sJDRwBMbniP/S3WiUAnlNPmw0RSA3+MvgbiRnpgu
         o2JPtNlf3xk/ZIc+x4tTlSLOszUWx5bN25QBXMdmkvGnnv8kK47lC8bkjTwA3KMW7TDU
         eygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cE01NZR3G4lAhA6w2A66fH8scEPgyQnlLBvPvIVhEzI=;
        b=vy0O5f20CnWKX9vObyABNa8wZIvQV8NwvNu5ZorT10QLDpbcXMK7jcHaR2ZFh17avB
         UfcPkNKmZzla96YzjL1vex3GFtGgHc5EkwMiQIroKlUkC1SfroFH2fhmezb3K3ZHzUiP
         2mEn9yM77CcHz/YUlSztFb3dFM7IOI6rAJ6nZboqDLourqAI2wEF5mmFoyCC++9bBa8M
         BS7drLbKdTMdsgnJddmeWC1X7C127Er77O7JUQzO+BHJ+dD1CCeHid/9xReLE6DQVLas
         MJ8y5o7GfFWaS1lzbV8RoIC3FwZEYihgapawotUnK+MZ1gx1pvhirH2BMA9WidBLj9Y1
         1s7g==
X-Gm-Message-State: ANoB5pl/vF/rY0w0jtZzlyA0tns6X8beEehRyTiSOMumF9s8vcgAPx5x
        AeOTL5lEL+Q8Bp8m7jKCAs0=
X-Google-Smtp-Source: AA0mqf6wsxuOaxIwfaHXlYB0OENMBi1wFlw0dJZRE9wBZgb4TljCLKVT95ywgLOe2zo7K6Txb3RARw==
X-Received: by 2002:a7b:c385:0:b0:3cf:87a8:ef00 with SMTP id s5-20020a7bc385000000b003cf87a8ef00mr9339006wmj.55.1669161318306;
        Tue, 22 Nov 2022 15:55:18 -0800 (PST)
Received: from suse.localnet (host-79-56-6-38.retail.telecomitalia.it. [79.56.6.38])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003cf7292c553sm299884wmq.13.2022.11.22.15.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 15:55:17 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Li Zhijian <lizhijian@fujitsu.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [for-next PATCH 4/5] RDMA/rxe: refactor iova_to_vaddr
Date:   Wed, 23 Nov 2022 00:55:16 +0100
Message-ID: <4786191.31r3eYUQgx@suse>
In-Reply-To: <2158152.NgBsaNRSFp@suse>
References: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com> <Y3vJQkc40o5zfM5v@ziepe.ca> <2158152.NgBsaNRSFp@suse>
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

On mercoled=EC 23 novembre 2022 00:24:26 CET Fabio M. De Francesco wrote:
> On luned=EC 21 novembre 2022 19:53:54 CET Jason Gunthorpe wrote:
> > On Wed, Nov 16, 2022 at 01:37:14PM +0100, Fabio M. De Francesco wrote:
> > > > -     return (void *)(uintptr_t)mr->map[m]->buf[n].addr + offset;
> > > > +     if (mr->ibmr.type =3D=3D IB_MR_TYPE_USER) {
> > > > +             char *paddr;
> > > > +             struct page *pg =3D mr->map[m]->buf[n].page;
> > > > +
> > > > +             paddr =3D kmap_local_page(pg);
> > > > +             if (paddr =3D=3D NULL) {
> > > > +                     pr_warn("Failed to map page");
> > > > +                     return NULL;
> > > > +             }
> > >=20
> > > I know nothing about this code but I am here as a result of regular=20
checks
> > > for changes to HIGHMEM mappings across the entire kernel. So please
>=20
> forgive
>=20
> > > me if I'm objecting to the correct changes.
> > >=20
> > > 1) It looks like this code had a call to page_address() and you=20
converted
>=20
> it
>=20
> > > to mapping with kmap_local_page().
> >=20
> > It only worked properly because the kconfig is blocking CONFIG_HIGHMEM
> > so ZONE_HIGHMEM doesn't exist. These pages are obtained from GUP and
> > could be anything.
> >=20
> > This is done indirectly through
> >=20
> > config INFINIBAND_VIRT_DMA
> >=20
> >         def_bool !HIGHMEM
> >=20
> > But this patch is undoing parts of what are causing that restriction
> > by using the proper APIs. Though I'm not sure if we can eventually get
> > to remove it for RXE completely.
> > Jason
>=20
> Ah, OK. This code was for !HIGHMEM kernels...
>=20
> I understand but, FWIW I doubt that the use of page_address(), instead of
> kmapping, should ever be made on the bases that kconfig is blocking HIGHM=
EM.
>=20
> However, if I understand correctly, that restriction (!HIGHMEM) is going =
to=20
be
> removed. Therefore, page_address() will break on HIGHMEM and Jason is
> correctly converting to kmap_local_page().

Jason, I'm sorry for the erroneous attribution :-(

=46abio
=20
> There is only one thing left... I think that he missed another mail from =
me.
> The one you responded to was missing the final paragraph, so I sent anoth=
er
> message few minutes later.
>=20
> kmap_local_page() returns always valid pointers to kernel virtual address=
es.=20
I
> can't see any ways for kmap_local_page() to return NULL. Therefore, I was
> asking for the reason to check for NULL.
>=20
> Thanks,
>=20
> Fabio




