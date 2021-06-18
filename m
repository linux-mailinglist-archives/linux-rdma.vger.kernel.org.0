Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3D73ACEEE
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 17:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhFRPbA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbhFRPaX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 11:30:23 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8D8C0604C7
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 08:22:56 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id a6so7472327ioe.0
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jun 2021 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YWh/OHeCl7xD5QZq9ykmKKl8j5/j5pX9oWEVMg4FX7c=;
        b=TjVBiFWktesrNt2fEKh8DDDiEPIgbCay7Rop7TtOJ1O49yDUFvW29R+89Mn81IbRCe
         579wMlnb+ASUpMU6tov6Lm2nZ5YdI/dNHsCxlFMsoWRRC/Nx3gPNrSw6aEXqPkPQpPQo
         EZ9vdMY8MMb5Tg3Ge7LDSrZvSd7t0AcYYa3MyQW6KfrPS3LPIf1zGUelpMEYve/UIuys
         ssHn5dwnM3IuFLACdTRjrkcZoEqz8ZL+Nyw2QQnMLUwdGtO8lYAys8qnoGPQcFQYVpfD
         OSbeK3m2pY5s/qPXJcZRYYEnHy++peYd9Ylu8VIKlHdKbkjYSsZVC77Uct6XeIF2TXXE
         Z9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YWh/OHeCl7xD5QZq9ykmKKl8j5/j5pX9oWEVMg4FX7c=;
        b=VHsdW8LrBa8yvrVcaNrMDAG3biZqcI2OmLXeXp+qzKljPcSzZINz/8XEArlndKJDCV
         PEWbeTfZ5I5yZrMzjQ5D/23WFmZ7lRTCwpJLubZJO0gDDHFF64lMcokyC9p+WtrcyFOU
         JS/joBAUYVMCa1SFr80S0pw9uxdXOrBpjxxcTIv7DGCeEZbQv1IKYv9XORVvos4/LWG4
         5TsBDUspf1wsHEVjHeUFVH82iETz75LvY4ef4XCth61vu+5pdOY3vo9ZmxKz3NQMPNMJ
         0m3yyRH6+H8TbuvwFUeVgn4KZM3TZFe7NjLwcesJ57Bg+fkA6nlzxmIkRbN4DnRY4k/t
         KCeQ==
X-Gm-Message-State: AOAM533hfMHqGE/nDRRHKyCNJpI+dfoxiX+Y+ffL3pFjRvfqsVXtNyIH
        FAIh4FoNY+UQcK1HMO2fMm5VVb7nqmi7iDbve5I=
X-Google-Smtp-Source: ABdhPJzj/WnOWqI4eBpCioGLMc40QalIETmftNKZq2zNyrv4h6xu1p6cg55uPXjHWtZ9Ec0FoQNTjUG8zxTyCceFBXU=
X-Received: by 2002:a02:1c06:: with SMTP id c6mr3872504jac.121.1624029775124;
 Fri, 18 Jun 2021 08:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <1624010765-1029-1-git-send-email-liweihang@huawei.com>
 <1624010765-1029-2-git-send-email-liweihang@huawei.com> <20210618120159.GC1002214@nvidia.com>
In-Reply-To: <20210618120159.GC1002214@nvidia.com>
From:   hhh ching <chenglang7@gmail.com>
Date:   Fri, 18 Jun 2021 23:22:46 +0800
Message-ID: <CAEc5TmJTfaSqPgk7CWgD1R9Oqddkg7XEJSHJF0A=8EFJtXcYLQ@mail.gmail.com>
Subject: Re: [PATCH v4 for-next 1/8] RDMA/hns: Fix sparse warnings about hr_reg_write()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Weihang Li <liweihang@huawei.com>, dledford@redhat.com,
        leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason Gunthorpe <jgg@nvidia.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=8818=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=888:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jun 18, 2021 at 06:05:58PM +0800, Weihang Li wrote:
> > Fix complains from sparse about "dubious: x & !y" when calling
> > hr_reg_write(ctx, field, !!val) by using "val ? 1 : 0" instead of "!!va=
l".
> >
> > Fixes: dc504774408b ("RDMA/hns: Use new interface to set MPT related fi=
elds")
> > Fixes: 495c24808ce7 ("RDMA/hns: Add XRC subtype in QPC and XRC type in =
SRQC")
> > Fixes: 782832f25404 ("RDMA/hns: Simplify the function config_eqc()")
> > Signed-off-by: Weihang Li <liweihang@huawei.com>
> > ---
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infin=
iband/hw/hns/hns_roce_hw_v2.c
> > index fbc45b9..6452ccc 100644
> > --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > @@ -3013,15 +3013,15 @@ static int hns_roce_v2_write_mtpt(struct hns_ro=
ce_dev *hr_dev,
> >       hr_reg_enable(mpt_entry, MPT_L_INV_EN);
> >
> >       hr_reg_write(mpt_entry, MPT_BIND_EN,
> > -                  !!(mr->access & IB_ACCESS_MW_BIND));
> > +                  mr->access & IB_ACCESS_MW_BIND ? 1 : 0);
>
> Err, I'm still confused where the sparse warning is coming from

Hi, Jason, i found some code in sparse/evaluate.c:
const unsigned left_not =3D expr->left->type =3D=3D EXPR_PREOP &&
expr->left->op =3D=3D '!';
const unsigned right_not =3D expr->right->type =3D=3D EXPR_PREOP &&
expr->right->op =3D=3D '!';
if ((op =3D=3D '&' || op =3D=3D '|') && (left_not || right_not))
        warning(expr->pos, "dubious: %sx %c %sy",

I guess the "dubious" is,  if somebody use "&" or "|",  maybe he want
to bitwise operate a number instead of a bool.

Someone think  sparse wants to remind whether he want to use a logical
"&&" instead of a bitwise "&". Maybe it is a typo.

>
> A hr_reg_write_bool() would be cleaner?
>
> Jason
