Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E91591E9F
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfHSINE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 04:13:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42472 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfHSINE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 04:13:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id j7so880210ota.9
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 01:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DU3RxACcI8hk+/K/y9D86bMVCOO4Iy26DmZ3mRfWOTo=;
        b=BYir0+mhwsuGrw/YYSjoLYzSB+vyyjbJk71Ku+O11jHR4Uz9j1CLPrz2AELP1snmRS
         tNqDDYTn2Vi/qTE0FrKoVCC86qPJ357JtepFzNOKhjqrHGDWs6EQ6b0RGXyBSK44v+QT
         0fFxmCnNKuR4mIlXK9iHJ1ix9Cb25EUIjmiWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DU3RxACcI8hk+/K/y9D86bMVCOO4Iy26DmZ3mRfWOTo=;
        b=RwnOXYiRE5mqKeZq3aHLn/EwNBzVgOfKC75mvsRkT6a18QoIVoS7n2Q8tlxA2dVvha
         zAOXFMtSiYo2lebVppKeG8Bi7yD3hNX2cCiGeDPQI1e7gqmX6Jfz/uSPNG/vZZ6J6kay
         Di64QTx/xa5tRkBYc3IHdP87FEbmcxQmroFHPlXiFZT95mL0waPyfFaA/zYtJXeXmQrq
         osceo8jL+APNIV+p8eaxV7YdBu7pzjoOc64xKhO9WqS8a9pvSltF1tlkg1pPspoMgeTC
         V1FqobCz4yUErfST6LUcdhL90tDFfi81ilV69aG323EMfxA0CaDD053L+Wfd50AABlD4
         BsRA==
X-Gm-Message-State: APjAAAXfMfkWdH1tau3g9bUqhzPZiYM/imblSDG/0HTO3AleYl2ot+tx
        P5WFRjB/CYV0Jz5R2jIsc1lZyOsz5o2+fP+P03gd6w==
X-Google-Smtp-Source: APXvYqxH7aE/bMuNVWOphQ5dZ2OKuDbSk8tEXgnLSdfrJITCqD+18XlsjFoTUqKV/S58cazbbKgvRkCFuh/ckbFj2AY=
X-Received: by 2002:a9d:57c8:: with SMTP id q8mr17729316oti.216.1566202382995;
 Mon, 19 Aug 2019 01:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <1565869477-19306-1-git-send-email-selvin.xavier@broadcom.com>
 <20190815130740.GE21596@ziepe.ca> <CA+sbYW3t2=bCpYjkuNQeT3LSFcL9n9=awHYpSrB6VZBna4dWhg@mail.gmail.com>
 <20190816120023.GA5398@ziepe.ca>
In-Reply-To: <20190816120023.GA5398@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Mon, 19 Aug 2019 13:42:51 +0530
Message-ID: <CA+sbYW01BgPXyK3mOi_yCNj4=6Z8AuH89-0A_RB5E-AXX+L2cg@mail.gmail.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix stack-out-of-bounds in bnxt_qplib_rcfw_send_message
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 16, 2019 at 5:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Aug 16, 2019 at 10:22:25AM +0530, Selvin Xavier wrote:
> > On Thu, Aug 15, 2019 at 6:37 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Thu, Aug 15, 2019 at 04:44:37AM -0700, Selvin Xavier wrote:
> > > > @@ -583,7 +584,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
> > > >       req.eventq_id = cpu_to_le16(srq->eventq_hw_ring_id);
> > > >
> > > >       rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
> > > > -                                       (void *)&resp, NULL, 0);
> > > > +                                       (void *)&resp, sizeof(req), NULL, 0);
> > >
> > > I really don't like seeing casts to void * in code. Why can't you
> > > properly embed the header in the structs??
> > Is your objection only in casting to void * or you dont like any
> > casting here?
>
> Explicit cast to void to erase the type is a particularly bad habit
> that I don't like to see.
>
> You'd be better to make the send_message accept void * and the cast
> inside to the header.
>
Ok. Will make this change. But this looks like a for-next item.. right?
If so, can you take this patch as is for RC? I will post the change
mentioned for for-next separately.

> > These structures are directly copied from some auto-generated files.
>
> Fix the auto generator? With a proper header struct is the best way to
> code this pattern.
>
Will check internally and see if it is possible.
> Jason
