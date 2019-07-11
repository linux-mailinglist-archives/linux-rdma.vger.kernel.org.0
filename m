Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0ADD65055
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 05:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfGKDCk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 23:02:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55901 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfGKDCk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 23:02:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so4118316wmj.5;
        Wed, 10 Jul 2019 20:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QmmkRcrRHhvKDL3E6Ed88MV7KQW+R+f2hke0bRgH+sM=;
        b=HeCsIwr79uKlTQ4IXQ2ZXeHGgfBduGZUp6NhDFkb7iSyJyT2kYg4d22BhIvU83sXFK
         DrTL3ufbkBtaWFyhD4dQusuNLER1rle54jeMzwJytaQGyDkGkNuTwDktVDdeTVtG/INO
         ojkygY+Sdcvd6UdFPVf5zmeF3CB68IzVZtXtS0Yl8dColS4YwXtHGC2rlNnbi2hxvEIe
         UHzxXWg3gGkJaVVFa2ip1yfkb+Et7Q1pLQNIS3PuMSy/KHDAbAWvgsWzPByGLVrZKh0E
         AEYuiT+ZLz8nVUfT1Ma/2QY2ZnlhZhUubvC0zutDMAJbXn3xxVPLEtvS66VCIlKYO4Uu
         ZlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QmmkRcrRHhvKDL3E6Ed88MV7KQW+R+f2hke0bRgH+sM=;
        b=d3uXc2msP6CgbQzRFvmj8N5LoX2iAwAOmdEY4mhvoqlqkAqNPQ+FNYqUJ8lekWLj6J
         lLhMzbLs+G0vxwB1x7Be9dkA/svX0KvyFTtFIR16BkMarJTTu4HwpqfAgRDS0xIxyOq8
         sw7N2Dm4mqIqFnh+7phGiJuk2dJAqz6JnZEkSuQhFgpNNH4G/tIRj9pqK394L8Zglrqz
         YV2narz/Z5FWAQ3VIf3fkOC8dTT4NvbD1oYRyiGdN9YkKnVXvCAUJaJiGaBGjRgsZfjN
         X6ZO5CorNI58sdAgiREXbt8S/r1fv1kmYW1aRZtaykqCo2EDEUcC4Q+WZ10SRTZpA0e8
         hIxg==
X-Gm-Message-State: APjAAAUo+Bx1G7sWkChHyVlUVsplmFmy+85D1I1+QmIFKBABrP25+TSX
        hIeYZELq4XG3msNHdUeL4kc=
X-Google-Smtp-Source: APXvYqzoQoA1pDhCxOLwzbyiQ0J/ctBrxUXsA6CqoPWinuJIkt5Upu2sIpM+D7TuvrM+iFferPT7Sw==
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr868171wmd.87.1562814158394;
        Wed, 10 Jul 2019 20:02:38 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id r11sm5213340wre.14.2019.07.10.20.02.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 20:02:37 -0700 (PDT)
Date:   Wed, 10 Jul 2019 20:02:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190711030235.GA12012@archlinux-threadripper>
References: <20190710174800.34451-1-natechancellor@gmail.com>
 <20190710182624.GG4051@ziepe.ca>
 <CAKwvOd=yJQgzjQBKW7=en_YnF6OCAg0MXy5c6c9tBLSjGgorPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=yJQgzjQBKW7=en_YnF6OCAg0MXy5c6c9tBLSjGgorPA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 10, 2019 at 04:53:50PM -0700, Nick Desaulniers wrote:
> On Wed, Jul 10, 2019 at 11:26 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Jul 10, 2019 at 10:48:00AM -0700, Nathan Chancellor wrote:
> > > clang warns several times:
> > >
> > > drivers/infiniband/sw/siw/siw_cq.c:31:4: warning: implicit conversion
> > > from enumeration type 'enum siw_wc_status' to different enumeration type
> > > 'enum siw_opcode' [-Wenum-conversion]
> > Weird that gcc doesn't warn on this by default..
> 
> Based on the sheer number of -Wenum-conversion that Nathan has fixed,
> I don't think gcc has -Wenum-conversion (or it's somehow disabled just
> for gcc).
> -- 
> Thanks,
> ~Nick Desaulniers

Yes, as far as I am aware, GCC does not warn on implicit enum
conversions (which I think defeats the purpose of enumerated types
*shrugs*).

Cheers,
Nathan
