Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA36A94965
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfHSQFH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 12:05:07 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38004 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfHSQFE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 12:05:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id x4so2456964qts.5
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qjbUMhoyRlBrB2pmx0yMahiahDUwqPVaQy5IFCKDGeI=;
        b=OIqsSXPXZbviyknbeplJa6FF5mEXzPBpNrHBLvf0OMF8gfvJD8rMtRaqC2i40w60Q6
         0ooems/EWxdnaXQFW36fYWtAjJrDvPcvdsW6YzldSxGpx3VcaW+O5jcOw+TMk3pErFYs
         OZZSqimYb/Z0K/YmjGgnPZ/vzOFpFweKtucZK/WF6MrI+suDDcwVxza8veuThMPLO+w8
         iZcaR2srQpXzJdK9bslrKpXDHhWvtPURyDP47vEQxpRHtAqZyKhlwt3L2C9E3lYyY4zl
         taZGVkxvxGeQwmccmhEEk92+fRCaHGdoUJkldjTeDQ3ZU5qO2nMjLHql3TBAexJxgM+M
         nBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qjbUMhoyRlBrB2pmx0yMahiahDUwqPVaQy5IFCKDGeI=;
        b=DdN6yp8j16nJsA2iotUGamfXXMpZDN/doWeCzj+EONfVTWrHUnLv8m5h8lF4z/j+B3
         675WR/K7eMqtFLg/dD3I0mKCYhBP7Qmi9ybxXXNqMa1LWjWMLESeMvmV2lx15rJBKGO9
         O/zBbWjPPKYiJrEXZw2czxYwT/TiQ8C3efIOgKWUZ+ZHZCGtcmu6TYoIWh1FAx//D/gw
         dXMvwlJheNb84c8mlogCwN1Fv6oMPxH8p3nREjII76aIkwalw++uEedO5zyHhnyRIGHt
         PEy8iIvdZkRULNX8sSBupQMh2acg9yAZw3kPB9J4Vn3jx20+JjT197jNjCF9mZQKLiZZ
         BLwQ==
X-Gm-Message-State: APjAAAWckYJEmM3+oPdTW54fKem0Kt3e0MPePrg+rlPNLeCvexV6/NP/
        Gg1WeESFr780OxZfB4TkONQHEg==
X-Google-Smtp-Source: APXvYqztyQOS4b1pKjCeXKm705+A0GDuP5UsZRh4JOIvQy8A9jr5ymKEfXY9yahhCbkDHmMgSpDEMw==
X-Received: by 2002:aed:3f29:: with SMTP id p38mr21199002qtf.126.1566230703478;
        Mon, 19 Aug 2019 09:05:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p38sm9417040qtc.76.2019.08.19.09.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 09:05:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hzk9W-0007Mr-AA; Mon, 19 Aug 2019 13:05:02 -0300
Date:   Mon, 19 Aug 2019 13:05:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit
 due to u64/pointer abuse
Message-ID: <20190819160502.GI5058@ziepe.ca>
References: <20190819150723.GH5058@ziepe.ca>
 <20190819141856.GG5058@ziepe.ca>
 <20190819135213.GF5058@ziepe.ca>
 <20190819122456.GB5058@ziepe.ca>
 <20190819100526.13788-1-geert@linux-m68k.org>
 <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
 <OFD7D2994B.750F3146-ON0025845B.004D965D-0025845B.004E5577@notes.na.collabserv.com>
 <OFD7C97688.66331960-ON0025845B.005081B6-0025845B.0051AF67@notes.na.collabserv.com>
 <OFB73D0AD1.A2D5DDF4-ON0025845B.00545951-0025845B.00576D84@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFB73D0AD1.A2D5DDF4-ON0025845B.00545951-0025845B.00576D84@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 03:54:56PM +0000, Bernard Metzler wrote:

> Absolutely. But these addresses are conveyed through the
> API as unsigned 64 during post_send(), and land in the siw
> send queue as is. During send queue processing, these addresses
> must be interpreted according to its context and transformed
> (casted) back to the callers intention. I frankly do not
> know what we can do differently... The representation of
> all addresses as unsigned 64 is given. Sorry for the confusion.

send work does not have pointers in it, so I'm confused what this is
about. Does siw allow userspace to stick an ordinary pointer for the
SG list?

The code paths here must be totally different, so there should be
different types and functions for each case.

Jason
