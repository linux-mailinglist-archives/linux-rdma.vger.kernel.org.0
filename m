Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2188712A9D7
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2019 03:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfLZCf3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Dec 2019 21:35:29 -0500
Received: from mail-vk1-f169.google.com ([209.85.221.169]:40314 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfLZCf3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Dec 2019 21:35:29 -0500
Received: by mail-vk1-f169.google.com with SMTP id c129so5868352vkh.7
        for <linux-rdma@vger.kernel.org>; Wed, 25 Dec 2019 18:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kx7Jc0XLVfMjnnT6aL20Qz1/PUvFgxDXv5msbY4XSnE=;
        b=j/1BoGlWjOkobNsgjnW95h/vBxRK7SvJ5dWi4Tl7mGPs4y4YygvMs3KVwAISJoJjmE
         VUZUK7Z0+ZlBBGZjxIvjYZ//iZrjviejS4EyJMgc1gXzyqos2pn/I5RS1UD6g5CyTA0c
         PLrGlf8eR+cCx0NGnhnawHPW2hHO856nYemE+hm3WcaYs6m8wrHzV24rBE2mfX4F9QEr
         rvJe4NRgoQpkeG8+oC1dLlETQtYWv8lF+UfbI7zzgkKf9GxFUYqSSMDY7lF/WSNdP4+O
         XhhS+1T+TBktXSrIpj83L4mPRNOlMy2EcqScKaR9Hc4+lix8f9DpMWWh7MoKBKRcWFVx
         38jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kx7Jc0XLVfMjnnT6aL20Qz1/PUvFgxDXv5msbY4XSnE=;
        b=imSxKXWtOeNyDP60R2R+wamHbZ88GboC8yELDqopNFUAUALA5BLe3TrIVOVMvL6FJn
         SYLt6BGEq19WtUoU8RvmBtVANEc8/n1Vj9giWX1Git7+3HknfPVvnlYlmDIm4RSL/pIh
         M4H6o/VBBXLWoP/PxV98G6SIgJWLxhZwdortTSbYBlAgpyErZNGLQEKH3j4rP2WeMlS9
         In3dQE12/1HSzocsTRLftJjo+IDaFqRHTFCj+qBZNmnZIhwusyHYIUd4RXUV2MSo6VUV
         nHPE2jq7e26ppu9DsrV9gpYOCkVGqP+dWvcnARvPk8JnKmjfZx+i/1thTEyhYD+y2JbB
         LJog==
X-Gm-Message-State: APjAAAWsv179D1aB7iEsbLCRM8QZN8iyd38/gNPpZf1IY1q1xt1gNg+u
        YPO4Wfjbf+a2NMpv2USqb5tUYTwf7AkvwKrSDOQ0tA==
X-Google-Smtp-Source: APXvYqwWjWW0avacIqSP3dSIrv+fV/ZK2ZE5as5VWS5WYhHFhierNZ9gWtAfjeVnrmRv5405lnTYkq9gKm/7lnTCwj8=
X-Received: by 2002:a1f:18cf:: with SMTP id 198mr25402112vky.61.1577327728431;
 Wed, 25 Dec 2019 18:35:28 -0800 (PST)
MIME-Version: 1.0
References: <CAKC_zSs=m_qPs06ZqxB-UJ_nHqhb+V2CBNKj3HsdJX+6eevqCA@mail.gmail.com>
 <20191225063256.GB212002@unreal> <CAKC_zSts5zdbM4LhUaPBWk8=uKGAKWX6vgd85cdKjOrZViiEJg@mail.gmail.com>
 <20191225092341.GC212002@unreal> <CAD=hENe5DVK6TpgOO4g_wtTV0fyCKCmBA=s1X2hxEgTB2reVkA@mail.gmail.com>
 <CAKC_zSs0hi8qUzrBgkeeXb9OkDTTr0V+JEb+XiOg0QQRfA3zRg@mail.gmail.com>
In-Reply-To: <CAKC_zSs0hi8qUzrBgkeeXb9OkDTTr0V+JEb+XiOg0QQRfA3zRg@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 26 Dec 2019 10:35:17 +0800
Message-ID: <CAD=hENf7qQN4H-=CoSS+_0ymS5n-XUb=ds9Skz6O4ByD4TyZpg@mail.gmail.com>
Subject: Re: rxe panic
To:     Frank Huang <tigerinxm@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please make tests with Linux upstream.
Thanks.

Zhu Yanjun

On Thu, Dec 26, 2019 at 9:39 AM Frank Huang <tigerinxm@gmail.com> wrote:
>
> Hi, zhu
>
> Can you show some patches about these problems?
>
> On Thu, Dec 26, 2019 at 9:08 AM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> >
> > I agree with you, Leon. I have fixed several problems similar to this
> > in the Linux upstream. Not sure whether this problem is fixed or not
> > in Linux upstream.
> >
> > Zhu Yanjun
> >
> > On Wed, Dec 25, 2019 at 5:29 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Wed, Dec 25, 2019 at 03:23:53PM +0800, Frank Huang wrote:
> > > > hi leon
> > > >
> > > > I can not get what you means, do you say the rxe_add_ref(qp) is not needed?
> > >
> > > It is not what I'm saying.
> > >
> > > The use of rxe_add_ref(qp) assumes that QP can't disappear while it is
> > > called. From what I see in the code, rxe_responder() doesn't guarantee
> > > that.
> > >
> > > Thanks
