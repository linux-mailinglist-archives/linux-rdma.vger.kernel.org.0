Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B56D8FA0D
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2019 06:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfHPEwi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Aug 2019 00:52:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36791 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPEwi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Aug 2019 00:52:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id k18so8590167otr.3
        for <linux-rdma@vger.kernel.org>; Thu, 15 Aug 2019 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTMqI5Eu8u89MKzxAFFRQUjr81lee/eY+Efph4JijUw=;
        b=NjQQ7phprht8KhW3RCNZ5HcS077TyCbumKL3EaK+NawKP+YtPDLYbzZvSZEZ318tTi
         SeuWqDSPP17rCaivwei94iFTaHbfUINTXbYneUoZ613IMGbPnN3va+HU3X5x0zAyvksv
         HMhssga6Hn5OK8Wc27xDung+Qm6ueGCyRRbTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTMqI5Eu8u89MKzxAFFRQUjr81lee/eY+Efph4JijUw=;
        b=h7AMbTDoyUNKXveiuDkWZf6zrJ3BuEal6sP2UbTqbrwJkZfDxelY2Rh9Vs6O1JTA9K
         g15yAN8omN8+sJ9+5JwLrHBZNcbNpXf9WRS+kU46S341A7OU7zAo47bk9/9Rgnlu3ZNx
         MurEVmWFx1VOeQAyLLp4iUgwlvSwLEo6U/BUxDIl0RvOH9XzGtonMjRTX/7ThHRqXcdz
         ijudEAhJm6uVQhqXNY9YtX059O/nrvUPwhBAxtXAXXE99ubN/ZGOsR36OCjZ+ZFhhTUh
         3h0N8JUkLAtRDeHeYrCqAlOZXIHx19jgmBRbuxEw74YpcPL6TeNRavR81m21Plm0fcOf
         43Tg==
X-Gm-Message-State: APjAAAXd1nLJTWHWEwtdoL/kgz1K5bYLFQuKsC/v5orwfpWeaX0vU5At
        gt7HanePkOnUYSCDdLvGBuh/kwiQDdW6VAHdGE9vrg==
X-Google-Smtp-Source: APXvYqxqixczoHigmGL13adiOo7WHEMgVyGd9hS1Ckwku+c8PGQEEdo8EoQGeRDY36zm3y5a+wd+qNmI7l/oL7OWY+U=
X-Received: by 2002:a9d:37c7:: with SMTP id x65mr5574322otb.47.1565931156890;
 Thu, 15 Aug 2019 21:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <1565869477-19306-1-git-send-email-selvin.xavier@broadcom.com> <20190815130740.GE21596@ziepe.ca>
In-Reply-To: <20190815130740.GE21596@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Fri, 16 Aug 2019 10:22:25 +0530
Message-ID: <CA+sbYW3t2=bCpYjkuNQeT3LSFcL9n9=awHYpSrB6VZBna4dWhg@mail.gmail.com>
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix stack-out-of-bounds in bnxt_qplib_rcfw_send_message
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 15, 2019 at 6:37 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Aug 15, 2019 at 04:44:37AM -0700, Selvin Xavier wrote:
> > @@ -583,7 +584,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
> >       req.eventq_id = cpu_to_le16(srq->eventq_hw_ring_id);
> >
> >       rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
> > -                                       (void *)&resp, NULL, 0);
> > +                                       (void *)&resp, sizeof(req), NULL, 0);
>
> I really don't like seeing casts to void * in code. Why can't you
> properly embed the header in the structs??
Is your objection only in casting to void * or you dont like any
casting here? These
structures are directly copied from some auto-generated files.
Embedding struct cmdq_base
to each req structures should be okay, but it involves lot of code
line changes in roce_hsi.h
and we will have to do this activity every time we copy a new req/resp
structure from the
auto generated file. I prefer to change these void * to struct
cmdq_base * and struct creq_base *,
 if that is okay with you.
>
> Jason
