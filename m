Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4DDF18BCFE
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 17:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCSQrE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 12:47:04 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34966 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgCSQrE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Mar 2020 12:47:04 -0400
Received: by mail-ed1-f42.google.com with SMTP id a20so3559607edj.2
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvrjSD/tcT6JWhdgPt3c7EKE8GemhzT/enqjRh1s/Fg=;
        b=WoiSHjUEGVGWRMHW2Pgd1J3ox23JofyF7ubaXXWkKXwePeollPHj6/qrxx05BzA9se
         N3FIggqO+ZAB3XO9tU7neoc7PhVZg9sYiEotz2Stnlcz7ouR7BQ++O602Z2Zcf88w/hf
         TcZpalRRkvF/kAVmRJPjBFlGMx9qCUceBTrsQDVjZES+k6LNVfHYAjlepUk4H/MFaCAD
         Qjvhw6kw1XXHEwBwurysfUXFoJybhEWTfoTT6laCcYu0zUeBO7L11VxVCvbnZI7C0pfb
         +pu5CktahdoQSXHFvIFDQG6WivConJjjLi+nrRopbOz3tRJYVuVYg+cpES5AfS7Hsuub
         cMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvrjSD/tcT6JWhdgPt3c7EKE8GemhzT/enqjRh1s/Fg=;
        b=OUNz9H860PckzZ41hK/JJMuLjlDkb16ilpr46o1Xb3jzHArJWH2wzbGjLGabVbY1so
         7Kf/8NCp2knRSBnhqOj37gqplamH0ZvxyPahCjtpHuSJ6NpEFcNOxYqPQU3UqWRAxks2
         Bc9Pkm0QsfcjNFrmdLrdFqrFK/HADafMAfQfZZc4638k627l71RYpJ7zPgX6halvsCJo
         N10f00v3o1W5+0onJZ0oIdFIs/W9a1hA+GNxElzi+j0ajrC+KUe+Bp67Zy/oaaIktgHU
         b9hETmc4PtjhCarZhmFMrU6kt6C0AbiY+eGtuPCdklsZZdbcUESavf4fyhn/Xyb1en2c
         z6Gw==
X-Gm-Message-State: ANhLgQ1fit23BhuHeqx5l4d8jxtqjR6Gap3YTXdep/RUmUIJWJH3JxLX
        sKMFQjUQQ718/HjCFbVqzCVux4HbE8wmL4tHUktoghrwJWQ=
X-Google-Smtp-Source: ADFU+vv7Nx6ptqNKo6B/oenAGU9RiALzIuaweheKcdZSc9mkjmzxPrhYQ2y9Uw7XtjyrElEF5yhyOXetBitkXcguDhU=
X-Received: by 2002:a17:906:78a:: with SMTP id l10mr4146439ejc.263.1584636422398;
 Thu, 19 Mar 2020 09:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOc41xF2xRfSpZDn-XRA=R+SegMJTPU6GJe6_6q=0j4=a-Bw9w@mail.gmail.com>
 <20200319065528.GL126814@unreal>
In-Reply-To: <20200319065528.GL126814@unreal>
From:   Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Thu, 19 Mar 2020 09:46:50 -0700
Message-ID: <CAOc41xHEcSHOFEJB3x=nWnt85ZnmuBRO46gzpDgu2SFytR=W+g@mail.gmail.com>
Subject: Re: RoCE v2 packet size
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Most helpful. Thank you.

Dimitris

On Wed, Mar 18, 2020 at 11:55 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Mar 18, 2020 at 03:57:33PM -0700, Dimitris Dimitropoulos wrote:
> > Hi,
> >
> > In RoCE v2 there various options for the protocol packet size: 4096,
> > 2048, etc. To what does this number refer to exactly. Is it the
> > payload that ends up in the QP buffers, or does it include headers
> > some of the headers as well ?
>
> If I'm looking on the correct RoCE spec section (A17.3.1.2.3 PAYLOAD LENGTH).
> It doesn't include headers but does include ICRC.
>
> The section "5.2.13 PAYLOAD" in the IBTA spec says that:
> "C5-8: All packets of an IBA message that contain a payload shall fill the
> payload to the full path MTU except the last (or only) packet of the message."
>
> This is why headers aren't included.
>
> Thanks
>
> >
> > Thank you.
> >
> > Dimitris
