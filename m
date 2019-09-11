Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE637AFF04
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 16:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfIKOmz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Sep 2019 10:42:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38201 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfIKOmy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Sep 2019 10:42:54 -0400
Received: by mail-io1-f67.google.com with SMTP id k5so21096848iol.5
        for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2019 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avlim07Xe4XViAboxGhe0VsMMRAsC69MS932vOFlV3o=;
        b=txHZtd1gTrFjZ1TVi1e8H39rMjuACO8zjzXqrkpziXWv0lKsEXT1BleuVBYVKPLaTD
         /Z5ak+wn/JO4JrRfecdQ0VFthTGOLG7ImV5D5UpPL6Vo7B1nQ8gJAveOJa9Vk92GFB0p
         R5EBiUL7Y6ucl60KrFCTrdRjxWclVJ807JQYe+5BLM3/hnNIDmJ/EnEwoxsn8k7niPUt
         VShPOmucPUB/Irr+iyixkbhEb6bxQjLM13NHgMR6FOeEcA/Su5G/FhB/XKfpp6o6DrsL
         +btKsNYJdhs/Em8LnRCMJ418QIcI1fkkB6xK1Ply/P94zGpm7+FAEQTtp5cA9FTuRzCS
         r6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avlim07Xe4XViAboxGhe0VsMMRAsC69MS932vOFlV3o=;
        b=k6pf4Ld7UjzTp6knD80rk0ovfTsODztlLr+ReW8Lwe/iHOhbUQgy67WX4/+uZnoUxC
         KeRwjqvnjQvZTt5rSRyNOubsqs+pDkUZl35BLSp1eM/qAgi/ADLb/xhkXhGbWL/0i+Qr
         +TavyhtrHosHt3CS0jyCkn5CJSr7JyhRvhgHAO2xW0Mv8j6BBm27MTY7e6Os5P/509YL
         rR7aT4qo55qsNYnTKZ5ZMIFxQ0JXVNO6YjifoEJ0Cbl1hUWyNg9CU9884MquHj0hNSpP
         LKBuoTCB+0XziWGSA51tVDwdIYa1cd6G67QuCyFrvqB8tAq3z52CIVSZnTDvp/QamMnj
         mcYw==
X-Gm-Message-State: APjAAAWzyuuM5JQVFpvVvwN2m73mqViOlHtKOlFRPpOIIWxxo1shHM0S
        mnq5d0lK6zRf7ku5HhJ/u/1aPHPtjHXjW4Pcnnnc2A==
X-Google-Smtp-Source: APXvYqz0MvAojngKlOhrkboV9NvJO/mpW6GZWdebUM/Wcj0g16hC/UiVKRQuVIrLMckdiRkMCsuXriNnSP52bgEtiSQ=
X-Received: by 2002:a5d:8919:: with SMTP id b25mr3060280ion.123.1568212973930;
 Wed, 11 Sep 2019 07:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190904212531.6488-1-sagi@grimberg.me> <20190910111759.GA5472@chelsio.com>
 <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me> <20190910192157.GA5954@chelsio.com>
 <OF00E4DFD9.0EEF58A6-ON00258472.0032F9AC-00258472.0034FEAA@notes.na.collabserv.com>
In-Reply-To: <OF00E4DFD9.0EEF58A6-ON00258472.0032F9AC-00258472.0034FEAA@notes.na.collabserv.com>
From:   Steve Wise <larrystevenwise@gmail.com>
Date:   Wed, 11 Sep 2019 09:42:43 -0500
Message-ID: <CADmRdJcCENJx==LaaJQYU_kMv5rSgD69Z6s+ubCKWjprZmPQpA@mail.gmail.com>
Subject: Re: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on iw_rem_ref
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 11, 2019 at 4:38 AM Bernard Metzler <BMT@zurich.ibm.com> wrote:
>
> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
>
> >To: "Sagi Grimberg" <sagi@grimberg.me>, "Steve Wise"
> ><larrystevenwise@gmail.com>, "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> >Date: 09/10/2019 09:22PM
> >Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Jason
> >Gunthorpe" <jgg@ziepe.ca>
> >Subject: [EXTERNAL] Re: [PATCH v3] iwcm: don't hold the irq disabled
> >lock on iw_rem_ref
> >
> >Please review the below patch, I will resubmit this in patch-series
> >after review.
> >- As kput_ref handler(siw_free_qp) uses vfree, iwcm can't call
> >  iw_rem_ref() with spinlocks held. Doing so can cause vfree() to
> >sleep
> >  with irq disabled.
> >  Two possible solutions:
> >  1)With spinlock acquired, take a copy of "cm_id_priv->qp" and
> >update
> >    it to NULL. And after releasing lock use the copied qp pointer
> >for
> >    rem_ref().
> >  2)Replacing issue causing vmalloc()/vfree to kmalloc()/kfree in SIW
> >    driver, may not be a ideal solution.
> >
> >  Solution 2 may not be ideal as allocating huge contigous memory for
> >   SQ & RQ doesn't look appropriate.
> >
> >- The structure "siw_base_qp" is getting freed in siw_destroy_qp(),
> >but
> >  if cm_close_handler() holds the last reference, then siw_free_qp(),
> >  via cm_close_handler(), tries to get already freed "siw_base_qp"
> >from
> >  "ib_qp".
> >   Hence, "siw_base_qp" should be freed at the end of siw_free_qp().
> >
>
> Regarding the siw driver, I am fine with that proposed
> change. Delaying freeing the base_qp is OK. In fact,
> I'd expect the drivers soon are passing that responsibility
> to the rdma core anyway -- like for CQ/SRQ/PD/CTX objects,
> which are already allocated and freed up there.
>
> The iwcm changes look OK to me as well.
>

Hey Krishna,  Since the iwcm struct/state is still correctly being
manipulated under the lock, then I think it this patch correct.  Test
the heck out of it. :)

Steve.
