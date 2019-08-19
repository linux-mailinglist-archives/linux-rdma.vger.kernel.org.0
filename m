Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6339D94C3E
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 20:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfHSSAG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 14:00:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36944 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfHSSAG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 14:00:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so2887135qto.4
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YX9dWce67vABwLMPVlFdUwPq+txr/vXIbVaKy0jpq6Q=;
        b=EC8zTSsoLTEkyxFiGqCqQniAasskdCwOw6qGr7oEZwlQiV1c3o7hTiG1KwFODgvHX/
         f2LEiPVb3/j9t+236x+EKD0dnUG/rrD5K4qSLgnKScUVlcFcOnphBXGgx7ug+3K6uaxs
         5UxfOhpR/EoaMvfFDDwLhwIU2KjVu2ZaG2UOOTrFSUvpm5Wkxxolxf5EJYXO3xP0tMiu
         kAfQ4CGL+ahsm1UGf4cm6GjyTADd7vKfP/0uIFeFB0Tax7D9K3JO/e+xgW8zaJEnWVGB
         fzM3+W3i+SUtj/zK1hbwQPwQESFtUmKBob6Np+kKBP7V3KOT+mJ6NEEIkXbFPnrFWzAY
         ETkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YX9dWce67vABwLMPVlFdUwPq+txr/vXIbVaKy0jpq6Q=;
        b=WGoqs6uKUSpiQw5BfmHcCeSldp9Wcx2QprzfyRAJ5QK16ydMYoMqt1ZxGnOqPN//Ad
         mmLndrBfcr50yM5idCd+dnODD6cCMWDthfoEbqA+m8Dj8W5347kBeS5VSzb6RhjueQoX
         +nim4AeSsTRctpN9dHzzlr4XnYk2oGwZSvGxL1pOEIhMccFB4TXR6orYc+nzKzES1yO0
         yO5XSuJwkcv2A5LjWTspDuCRdf6fysXHAafmg/gwNzpkD1DLjVArjUz+laiGVJZ0H9GF
         9ZElXM125mZNG/0sbaUr8ggwj+gT0ZBIOqx6de5+tg8t/K/qxDyqla61WbBtzQCXpBRX
         fAaA==
X-Gm-Message-State: APjAAAVsEnmT64pD3Js9/POO4Ar2U7Q0WgUZAbJlFBhtzSvyQjFlqC8R
        0WC7QxsLron5bCxbMtKX9FyVODmemzI=
X-Google-Smtp-Source: APXvYqznlNLxHHXfRwGlFmLxuiJuOs1bxhmbApAX2y4MKv4X/Di/E8nhPKHn+fczODmk+kDQSxrIpQ==
X-Received: by 2002:ac8:41ce:: with SMTP id o14mr21121803qtm.92.1566237604991;
        Mon, 19 Aug 2019 11:00:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z18sm5045751qtn.87.2019.08.19.11.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 11:00:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hzlwq-0000QV-1y; Mon, 19 Aug 2019 15:00:04 -0300
Date:   Mon, 19 Aug 2019 15:00:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler warnings on
 32-bit due to u64/pointer abuse
Message-ID: <20190819180004.GL5058@ziepe.ca>
References: <20190819141856.GG5058@ziepe.ca>
 <20190819135213.GF5058@ziepe.ca>
 <20190819122456.GB5058@ziepe.ca>
 <20190819100526.13788-1-geert@linux-m68k.org>
 <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
 <OFD7D2994B.750F3146-ON0025845B.004D965D-0025845B.004E5577@notes.na.collabserv.com>
 <OFD7C97688.66331960-ON0025845B.005081B6-0025845B.0051AF67@notes.na.collabserv.com>
 <OFB73D0AD1.A2D5DDF4-ON0025845B.00545951-0025845B.00576D84@notes.na.collabserv.com>
 <OFFE3BC87B.CF197FD5-ON0025845B.0059957B-0025845B.005A903D@notes.na.collabserv.com>
 <OF0F37B635.09509188-ON0025845B.005BF4A4-0025845B.0060F5F0@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0F37B635.09509188-ON0025845B.005BF4A4-0025845B.0060F5F0@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 05:39:04PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 08/19/2019 06:35PM
> >Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
> ><dledford@redhat.com>, linux-rdma@vger.kernel.org,
> >linux-kernel@vger.kernel.org
> >Subject: [EXTERNAL] Re: Re: Re: Re: Re: [PATCH] RDMA/siw: Fix
> >compiler warnings on 32-bit due to u64/pointer abuse
> >
> >On Mon, Aug 19, 2019 at 04:29:11PM +0000, Bernard Metzler wrote:
> >> 
> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >> >Date: 08/19/2019 06:05PM
> >> >Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
> >> ><dledford@redhat.com>, linux-rdma@vger.kernel.org,
> >> >linux-kernel@vger.kernel.org
> >> >Subject: [EXTERNAL] Re: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler
> >> >warnings on 32-bit due to u64/pointer abuse
> >> >
> >> >On Mon, Aug 19, 2019 at 03:54:56PM +0000, Bernard Metzler wrote:
> >> >
> >> >> Absolutely. But these addresses are conveyed through the
> >> >> API as unsigned 64 during post_send(), and land in the siw
> >> >> send queue as is. During send queue processing, these addresses
> >> >> must be interpreted according to its context and transformed
> >> >> (casted) back to the callers intention. I frankly do not
> >> >> know what we can do differently... The representation of
> >> >> all addresses as unsigned 64 is given. Sorry for the confusion.
> >> >
> >> >send work does not have pointers in it, so I'm confused what this
> >is
> >> >about. Does siw allow userspace to stick an ordinary pointer for
> >the
> >> >SG list?
> >> 
> >> Right a user references a buffer by address and local key it
> >> got during reservation of that buffer. The user can provide any
> >> VA between start of that buffer and registered length. 
> >
> >Oh gross, it overloads the IOVA in the WR with a kernel void * ??
> 
> Oh no. The user library writes the buffer address into
> the 64bit address field of the WR. This is nothing siw
> has invented.

No HW provider sticks pointers into the WR ring.

It is either an iova & lkey pair, or SGE information is inlined into
the WR ring.

Never, ever, a user or kernel pointer.

The closest we get to a kernel pointer is with the local dma lkey &
iova == physical memory address.

> >Why does siw_pbl_get_buffer not return a void *??
>
> 
> I think, in fact, it should be dma_addr_t, since this is
> what PBL's are described with. Makes sense?

You mean because siw uses dma_virt_ops and can translate a dma_addr_t
back to a pfn? Yes, that would make alot more sense.

If all conversions went explicitly from a iova & lkey -> dma_addr_t -> void * in
the kmap then I'd be a lot happier

Jason
