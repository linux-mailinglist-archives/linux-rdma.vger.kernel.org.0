Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A17012A977
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Dec 2019 02:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfLZBIW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Dec 2019 20:08:22 -0500
Received: from mail-ua1-f53.google.com ([209.85.222.53]:45077 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfLZBIV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Dec 2019 20:08:21 -0500
Received: by mail-ua1-f53.google.com with SMTP id 59so7712147uap.12
        for <linux-rdma@vger.kernel.org>; Wed, 25 Dec 2019 17:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DgJ1SyMlpdoqcYEz1sy2tlpBAhRBnkoNZ3GdwRE8WHI=;
        b=AzPo7/F99KHZnknI/etEdU/NticXxm7FXsJSIOyg40uUbrJvH3Hu4pjnG9nEm8UIQ8
         /tUpbHIos6UY8a79sYwR4oq4+5VGzQwRDXR3QHfjp/qRx4mc0d9DJQuxjSSqMNny2QI0
         RKaHD1v3/jKyUMY6et6DhsrsBmtUrojbQnkSkxbdBVukkh5mWKofoLJ+y8zgIdJWsBPs
         jXFrQ1Tz+Elnbhg7pVFgRehRAEyCzFy+t05n2iwTZo5IKALpBIoj2jSqlhVhO2tYUCii
         uGJ4eKUQmVetnAxSguPczAsp3PakjmJVBKGeET+H9psh/YFAySGh6R2WTGAW9KQvsoKR
         k1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgJ1SyMlpdoqcYEz1sy2tlpBAhRBnkoNZ3GdwRE8WHI=;
        b=F+rxpXKnzcpjtPbIziQ8C9jvK5vtxzvnooRy75+p6XLGy5Ouw3/b9HBK88NK7JquiW
         YTGZ/qqwL/MkM2DCFblEiqp99qPnmV+NPQ7lhC031HleO/gSO8ul/Pq1TBWXEpYqrK1r
         OcO5mlGtQl+WasheW1QuRrOMLsqi6zKFVWEmIkjvsJ8YkXIBZP07A96aW3CnXeMK7AQD
         Z1xpNcdk31h/7VWPIzVFObdJAfFf1KCmujAljMLxnxNJPSToeFxA1pgbmdgJbMl0O2Yi
         ccNVLSRN2q2URj4Frp01Xv28OFy8/npt7G3HhXZVI0WkwByL9TGkD8YN6/PzOUqMJKf8
         VZ6A==
X-Gm-Message-State: APjAAAWvUOdhJsJK1LaQnW6SDH7F5cG1Xqm9mSyVrv9HnFVpFsjHXquk
        D4pU3w+lVpOKqP/02TzV6ooklsecfLrZzlHYmyQ=
X-Google-Smtp-Source: APXvYqz8vcstZbTuDFRQhFdUrZk+OYJkCdKSavdyOvekHU+wzMAi5qMWy3Oz9qOf3KE/wc/pJVr4UGS3Q2txhcWzeDI=
X-Received: by 2002:ab0:471a:: with SMTP id h26mr27216042uac.34.1577322500801;
 Wed, 25 Dec 2019 17:08:20 -0800 (PST)
MIME-Version: 1.0
References: <CAKC_zSs=m_qPs06ZqxB-UJ_nHqhb+V2CBNKj3HsdJX+6eevqCA@mail.gmail.com>
 <20191225063256.GB212002@unreal> <CAKC_zSts5zdbM4LhUaPBWk8=uKGAKWX6vgd85cdKjOrZViiEJg@mail.gmail.com>
 <20191225092341.GC212002@unreal>
In-Reply-To: <20191225092341.GC212002@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 26 Dec 2019 09:08:09 +0800
Message-ID: <CAD=hENe5DVK6TpgOO4g_wtTV0fyCKCmBA=s1X2hxEgTB2reVkA@mail.gmail.com>
Subject: Re: rxe panic
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Frank Huang <tigerinxm@gmail.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I agree with you, Leon. I have fixed several problems similar to this
in the Linux upstream. Not sure whether this problem is fixed or not
in Linux upstream.

Zhu Yanjun

On Wed, Dec 25, 2019 at 5:29 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Dec 25, 2019 at 03:23:53PM +0800, Frank Huang wrote:
> > hi leon
> >
> > I can not get what you means, do you say the rxe_add_ref(qp) is not needed?
>
> It is not what I'm saying.
>
> The use of rxe_add_ref(qp) assumes that QP can't disappear while it is
> called. From what I see in the code, rxe_responder() doesn't guarantee
> that.
>
> Thanks
