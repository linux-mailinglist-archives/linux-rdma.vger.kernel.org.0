Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5FB94A72
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 18:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfHSQfX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 12:35:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41658 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbfHSQfX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 12:35:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id g17so1932158qkk.8
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wWW+WA46mKEi0z1RGGxPVBr8fzCCdL8vAuG/5cMy1F4=;
        b=hiwyuvmSJGL4axK+y4nb7wwhApXBrItaLKtFiHb+0wCYjsLtFYZuCEFAzyksTNfRXd
         aQgPbRUSU1Em9wYmdmpdvDR5iltt9Ue4rBVxAwXjtVgM8lWHP+vxut3ux1GMtw9nPXYk
         k9GtyqhNbDP3aZA5l9uUOkH12eWqTHGTrviM/6+RhcinX/7DcF96D0VsgGPvioSmqxoX
         hTsrLuObX/XO5/qaczj4qvU1EzbJyfzJL1phCIeYPnELZz3P/F77q1V+DyW5SI2y9fmg
         H3tV3DhL3EaYJfE488xGQcDNQHV7rsUnH+HSDA5UhYsXux7Qy8U8k9puCto8pcIlC9XF
         PqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wWW+WA46mKEi0z1RGGxPVBr8fzCCdL8vAuG/5cMy1F4=;
        b=NbmKqIYyvnxSGHTFT5NR9XP1b+DgYimNF1M9y7OOoDiQqqQZBC2NbJxmbkglWZRMXV
         QoI4lP87QtWsJBQmJyH3WGPS/pMT3uKxDFJzoFAIIPMHt1rttD8EPAV+j3JYfPdpBFTD
         mLaZhOvWmpgSORFaofWEMs+zK1uvsTAGB8W10KkExXaQSj+bhm4hsW2/C3mm124m8rmJ
         fashOYWS1MgntrLL6xAt425r4FJGrkm/e7wkprJ5t0tR0KEyCAfyZ87EB/+Eb1xrHZPX
         fburjTWy1y8wTybZwOnlT072sTUIx+PmUv7e2NPLkcKDOURyZc5MZ2LJBBhTxleMNWaB
         nCZQ==
X-Gm-Message-State: APjAAAWKHWdNlwKN5c6Ej3Ps0+S+PMhQv0caGZ/cRl4fu8cVwg91TGfT
        t3W9zPdqrfBpvArOOpl92Cx5wlno7mk=
X-Google-Smtp-Source: APXvYqzJgbElB7yz0+C1ekqDDN/YsYJmh53ysWANOEsnqgE9IoWoDgpB8m4UJssvhwOb0BgOwG52vA==
X-Received: by 2002:ae9:f203:: with SMTP id m3mr21355477qkg.264.1566232522239;
        Mon, 19 Aug 2019 09:35:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a21sm7296970qka.113.2019.08.19.09.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 09:35:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hzkcr-0007hN-Ej; Mon, 19 Aug 2019 13:35:21 -0300
Date:   Mon, 19 Aug 2019 13:35:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler warnings on
 32-bit due to u64/pointer abuse
Message-ID: <20190819163521.GK5058@ziepe.ca>
References: <20190819150723.GH5058@ziepe.ca>
 <20190819141856.GG5058@ziepe.ca>
 <20190819135213.GF5058@ziepe.ca>
 <20190819122456.GB5058@ziepe.ca>
 <20190819100526.13788-1-geert@linux-m68k.org>
 <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
 <OFD7D2994B.750F3146-ON0025845B.004D965D-0025845B.004E5577@notes.na.collabserv.com>
 <OFD7C97688.66331960-ON0025845B.005081B6-0025845B.0051AF67@notes.na.collabserv.com>
 <OFB73D0AD1.A2D5DDF4-ON0025845B.00545951-0025845B.00576D84@notes.na.collabserv.com>
 <OFFE3BC87B.CF197FD5-ON0025845B.0059957B-0025845B.005A903D@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFFE3BC87B.CF197FD5-ON0025845B.0059957B-0025845B.005A903D@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 04:29:11PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 08/19/2019 06:05PM
> >Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
> ><dledford@redhat.com>, linux-rdma@vger.kernel.org,
> >linux-kernel@vger.kernel.org
> >Subject: [EXTERNAL] Re: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler
> >warnings on 32-bit due to u64/pointer abuse
> >
> >On Mon, Aug 19, 2019 at 03:54:56PM +0000, Bernard Metzler wrote:
> >
> >> Absolutely. But these addresses are conveyed through the
> >> API as unsigned 64 during post_send(), and land in the siw
> >> send queue as is. During send queue processing, these addresses
> >> must be interpreted according to its context and transformed
> >> (casted) back to the callers intention. I frankly do not
> >> know what we can do differently... The representation of
> >> all addresses as unsigned 64 is given. Sorry for the confusion.
> >
> >send work does not have pointers in it, so I'm confused what this is
> >about. Does siw allow userspace to stick an ordinary pointer for the
> >SG list?
> 
> Right a user references a buffer by address and local key it
> got during reservation of that buffer. The user can provide any
> VA between start of that buffer and registered length. 

Oh gross, it overloads the IOVA in the WR with a kernel void * ??

> >The code paths here must be totally different, so there should be
> >different types and functions for each case.
> 
> Yes, there is a function to process application memory (siw_rx_umem),
> to process a kernel PBL (siw_rx_pbl), and one to process kernel
> addresses (siw_rx_kva). Before running that function, the API
> representation of the current SGE gets translated into target
> buffer representation.

Why does siw_pbl_get_buffer not return a void *??

Still looks like two types have been crammed together.

The kernel can't ever store anything into the user WQE buffer, so I
would think it would copy the buffer to kernel space, transform it
properly and then refer to it as a kernel buffer. Kernel sourced
buffers just skip the transofmration.

JAson
