Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4296D094E
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjC3PU0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 11:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjC3PU0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 11:20:26 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE2D33E
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 08:19:14 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5456249756bso360311597b3.5
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680189552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGQJH74nTRlnAg4AF/8HsKmhlYq9deKtLhrx7EGEP3s=;
        b=jFdtcIeyP3IBvISQERHCRmzQdbjwT/y7OqQzuqfAlPXG1GQkQRc0yUgDlQhnXS+bDi
         GV/EO+XEauHbUxS+oGOi78N5vfnGV4zCgzKOMKjab7H1/NBFbHgV8jAI0cfQ6/u+vWcV
         B+t7R4GAJBn1XmQ2xUF3tNy8+sMw6MPJDVo30+/Br4HneINVqje88iVbmwawdB6TNF+O
         frzIXofcMum/znrB550G3TXdP5eSXYB77PTC4mMcxahhkKpwfnHbwJXLHoeeVxH67zUS
         kq53jwVtWrBBZvuI87xJPFqNa9olfp5uz5FV7sZXqoyw9oxn+P86hGmvl/mq4RhssehY
         Z2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGQJH74nTRlnAg4AF/8HsKmhlYq9deKtLhrx7EGEP3s=;
        b=uFbjRtiT5m6zv0vFHNLPDtXYu2CZCD82OY+rZuKtIfS1Cl2XEpoHSXUDkkszzKT6FU
         Bft9x4z4ZEiuYrFCQCc3hncObA7YM18eUlzOL/U7/gta54WT3jKu2H8Vi8ienxJzx0mk
         s9lNE2IRme6jlxQ6fVJxrywlSTWaP1037vM0Sk5K333jcVXzUdj6HvnvFITiswcLW/A9
         BMUnOuAJypPqcrKfSuvHAJRG/T7/xHyDmO+TbxL+iekHAyv+jqnNCKPPGOy19y3IXXa3
         man44TATNz+msDIjPuu1pMM13/PUKBO0wENZm/Poz3NLauSnzDldzQDlW2yvJr5SEkrv
         jC2A==
X-Gm-Message-State: AAQBX9ekoIgMjLxo9QJyWz0f+5CnpdYurHALj6bbrs3TPPsNAgDo6d+x
        V6VUL32v9Z223ZAdK2VK36MtnZsgojFeHCUuhqzKtw==
X-Google-Smtp-Source: AKy350Z7svxmPWEcdwZkaZPQXKEnZlQM1EqfPqjgQtnJPMq4vuDvejU0w5CdXFIFwKD+223wXZoyK2IF2E+70c6kLn8=
X-Received: by 2002:a81:eb02:0:b0:545:883a:544d with SMTP id
 n2-20020a81eb02000000b00545883a544dmr12014137ywm.9.1680189552512; Thu, 30 Mar
 2023 08:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230324103252.712107-1-linus.walleij@linaro.org>
 <ZB2s3GeaN/FBpR5K@nvidia.com> <CACRpkdYTynQS3XwW8j_vamb7wcRwu0Ji1ZZ-HDDs0wQQy4SRzA@mail.gmail.com>
 <ZCTGw3+9rYQAmlJS@nvidia.com> <66639a8e-e8b8-64b4-5b04-dec357db86a8@gmail.com>
 <ZCV7PwYwLVXGS202@nvidia.com>
In-Reply-To: <ZCV7PwYwLVXGS202@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Mar 2023 17:19:01 +0200
Message-ID: <CACRpkdYyRjLyCjftqu3HwP4zBWpoGQgcBnxhosV_YFen-39Nwg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Pass a pointer to virt_to_page()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 30, 2023 at 2:06=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
> On Wed, Mar 29, 2023 at 09:45:45PM -0500, Bob Pearson wrote:
> > On 3/29/23 18:16, Jason Gunthorpe wrote:
> > > On Wed, Mar 29, 2023 at 04:28:08PM +0200, Linus Walleij wrote:
> > >
> > >> I'm a bit puzzled: could the above code (which exist in
> > >> three instances in the driver) even work as it is? Or is it not used=
?
> > >> Or is there some failover from DMA to something else that is constan=
tly
> > >> happening?
> > >
> > > The physical address dma type IB_MR_TYPE_DMA is rarely used and maybe
> > > nobody ever tested it, at least in a configuration where kva !=3D pa
> > >
> > > Then again, maybe I got it wrong and it is still a kva in this case
> > > because it is still ultimately DMA mapped when using IB_MR_TYPE_DMA?
> > >
> > > Bob?
> > >
> > > Jason
> >
> > In the amd64 environment I use to dev and test there is no difference A=
FAIK.
> > I have to go on faith that other platforms work but have very little ex=
perience.
>
> Honestly, I would be much happier if the virtual wrappers used
> physical not kva :\ But that is too much to ask
>
> So I suspsect I got it wrong and it is a kva still

OK I'll respin the first version of the patch but with the quirks making it=
 work
on parisc.

Yours,
Linus Walleij
