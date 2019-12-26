Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 366BA12A984
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2019 02:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLZBj4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Dec 2019 20:39:56 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:43618 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfLZBj4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Dec 2019 20:39:56 -0500
Received: by mail-lf1-f47.google.com with SMTP id 9so17528132lfq.10
        for <linux-rdma@vger.kernel.org>; Wed, 25 Dec 2019 17:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=97R3+tSqi2KHoK9WPhadXr0J3GYW/x2tT3kKMHC2URs=;
        b=utU3Co7j+33cDBudU5orVO9zKeI2VxfoEpIzYeH8o14H00np23koxN5OaHXSUX4UQB
         QEf608yFdoPSRmrlTXlcB30g+cAAepNlOFH7yxM5xOWlVKp6as7492XpVwSsjc7PRkZD
         MNMi7sQsO1lDJbfdPay2M/Yb8bMEXZNdqcJWMjkxRwnAsG1CCaQp2Kw0CAWk++Pl4es3
         R9aW4koliyWu2+f+2d98QNQ8vwzecwlgJcU/04gs9toDCJrQoj5jJkkqk2Vb3+WeELSb
         Y3pkSm4SAGpLkBpy4CfZ/ADflUbtr6sCbbs+KBRJABsXXfFBkQ7/YbwB3QarY0wXGcDX
         Ozeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=97R3+tSqi2KHoK9WPhadXr0J3GYW/x2tT3kKMHC2URs=;
        b=HnocXGD9+GKMtn14f5AnCwaAaAlazrC8nNCuEkaMAr91th/L3uSgAPWrTUbQhTOxqv
         SGf2BrG290+pkSz15/8L9+pexqskYaDBleQeCTcbyDpgbKAfCPsPo8J/mlQzte28wm7O
         DSU6r0bEggW2QyH2x6Y0TUgJ7Qzp2gcPjbKEC1tKDGxFNiBxr3orslwj8hbBi4mC0cdf
         XSYd8Z1YYwDkJl8XeCWfs5D4OfZLCnbT3OaJu6penDDwfRL2hMGC3XiUPMfPWAHSVIhw
         1tEzSxi7gyUY4PsDlh9qlzXdbrPS5C/MuimbQtQwJC0DjHrq/1s1KU+7HxYTLwuFtekQ
         3ftA==
X-Gm-Message-State: APjAAAUfzZkptWe0QAm///dV8E8mMT/XffNOa8ftdY0xdh9plKVLLH9d
        BJAdNjLZSOnrmChjxum7lp6eV7yUW49FlNw/vHk=
X-Google-Smtp-Source: APXvYqyfd9QuGLOMTJ65eHKG/7tkoVjat99mG8flwrb4CZBEZf1Yym+cyiE6EAAvT2XWwNljco/tnhOV+FUhXXMeJCA=
X-Received: by 2002:a19:6a06:: with SMTP id u6mr24679189lfu.187.1577324393864;
 Wed, 25 Dec 2019 17:39:53 -0800 (PST)
MIME-Version: 1.0
References: <CAKC_zSs=m_qPs06ZqxB-UJ_nHqhb+V2CBNKj3HsdJX+6eevqCA@mail.gmail.com>
 <20191225063256.GB212002@unreal> <CAKC_zSts5zdbM4LhUaPBWk8=uKGAKWX6vgd85cdKjOrZViiEJg@mail.gmail.com>
 <20191225092341.GC212002@unreal> <CAD=hENe5DVK6TpgOO4g_wtTV0fyCKCmBA=s1X2hxEgTB2reVkA@mail.gmail.com>
In-Reply-To: <CAD=hENe5DVK6TpgOO4g_wtTV0fyCKCmBA=s1X2hxEgTB2reVkA@mail.gmail.com>
From:   Frank Huang <tigerinxm@gmail.com>
Date:   Thu, 26 Dec 2019 09:39:45 +0800
Message-ID: <CAKC_zSs0hi8qUzrBgkeeXb9OkDTTr0V+JEb+XiOg0QQRfA3zRg@mail.gmail.com>
Subject: Re: rxe panic
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, zhu

Can you show some patches about these problems?

On Thu, Dec 26, 2019 at 9:08 AM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> I agree with you, Leon. I have fixed several problems similar to this
> in the Linux upstream. Not sure whether this problem is fixed or not
> in Linux upstream.
>
> Zhu Yanjun
>
> On Wed, Dec 25, 2019 at 5:29 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Dec 25, 2019 at 03:23:53PM +0800, Frank Huang wrote:
> > > hi leon
> > >
> > > I can not get what you means, do you say the rxe_add_ref(qp) is not needed?
> >
> > It is not what I'm saying.
> >
> > The use of rxe_add_ref(qp) assumes that QP can't disappear while it is
> > called. From what I see in the code, rxe_responder() doesn't guarantee
> > that.
> >
> > Thanks
