Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C254692672
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 16:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfHSOS6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 10:18:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36534 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfHSOS5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 10:18:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id d23so1522030qko.3
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7GnVEGIzBU9NHNZIjLTWNk1Cm8cjRlXWPZxE9r7WSQU=;
        b=TDyDjGXMRj3QN5l/0UvPeSmzi4oopdOyT18N30d2AW90XmnDyMBGbvgQLzfS1CxiyK
         HkbH1WrXeBE34BVdID1ARHn+BLWJf/UMqos9yatspCXJ01azUw5jrNTSL/lMpqlT5F7U
         D51LrkZZeGATefeU8KXNIxwXLDU5pwDFdjJaaCkyQPLPPdZQ9zaYyL1M1w7umW4rLAM1
         sJXjs0QJAtS8krCMndXMZMA3IRufBm17UIjQ1QBEKYuzKJjnVDR7DAYSHMhGq4jt2INg
         WpIJi9xg72tcB1BxwygjccXKuDOAkYvHPKqePwsD6docF733RQaqer8BxfitpdGacL8k
         xLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7GnVEGIzBU9NHNZIjLTWNk1Cm8cjRlXWPZxE9r7WSQU=;
        b=fwGuGjyPH8gfoj0T9pKvvc2uFwTGARQGDZ4sVDkaUGAsq/7jksPBwETiGb2jXTggt8
         n1ZsXVtLbaWsJ3Ni5ZFGQgYekIAf7ZnDefDKTfaSOFP0c3LeEE7uxkVT8dKv0K1V/9x+
         MlrHAW1TOgCB9+ETccCjWG4nWTOQ9JVpiAc9uEKCS7D/Cc7WpMFs69u2KaluuakExXaP
         nUIu0ntPrv2WC3Pp0pJM5HiBN2GzL/pLF581bPX3Dc20X6oc40UB+06IsOOnP2AhJzgq
         KW+DOXLdvnNuDrNbxKXkeETg7XiyweZnIy9TYAs/2xsc5ZtQ1lBgZ7+tEeRd45o+J9bR
         aEyg==
X-Gm-Message-State: APjAAAUs1yYRKlvlzzBq92QzQueVouOuz0gpbP2THP3SKWKwSRd7rAbU
        lqjweVyhigwW3zJYUNtoFzfHhOJm19U=
X-Google-Smtp-Source: APXvYqzXZgnkuqjOIko+h2VxvD+TylVtLez9TPIJp4cgLk74ZekCBZCwgjBbBgXYiJcQruIdhAATCA==
X-Received: by 2002:a05:620a:112b:: with SMTP id p11mr21793317qkk.146.1566224337033;
        Mon, 19 Aug 2019 07:18:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l19sm7781335qtb.6.2019.08.19.07.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 07:18:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hziUq-00037U-2n; Mon, 19 Aug 2019 11:18:56 -0300
Date:   Mon, 19 Aug 2019 11:18:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
Message-ID: <20190819141856.GG5058@ziepe.ca>
References: <20190819135213.GF5058@ziepe.ca>
 <20190819122456.GB5058@ziepe.ca>
 <20190819100526.13788-1-geert@linux-m68k.org>
 <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
 <OFD7D2994B.750F3146-ON0025845B.004D965D-0025845B.004E5577@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD7D2994B.750F3146-ON0025845B.004D965D-0025845B.004E5577@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 02:15:36PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 08/19/2019 03:52PM
> >Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
> ><dledford@redhat.com>, linux-rdma@vger.kernel.org,
> >linux-kernel@vger.kernel.org
> >Subject: [EXTERNAL] Re: Re: [PATCH] RDMA/siw: Fix compiler warnings
> >on 32-bit due to u64/pointer abuse
> >
> >On Mon, Aug 19, 2019 at 01:36:11PM +0000, Bernard Metzler wrote:
> >> >If the value is really a kernel pointer, then it ought to be
> >printed
> >> >with %p. We have been getting demanding on this point lately in
> >RDMA
> >> >to enforce the ability to keep kernel pointers secret.
> >> >
> >> >> -			wqe->sqe.sge[0].laddr = (u64)&wqe->sqe.sge[1];
> >> >> +			wqe->sqe.sge[0].laddr = (uintptr_t)&wqe->sqe.sge[1];
> >> >
> >> >[..]
> >> >
> >> >>  			rv = siw_rx_kva(srx,
> >> >> -					(void *)(sge->laddr + frx->sge_off),
> >> >> +					(void *)(uintptr_t)(sge->laddr + frx->sge_off),
> >> >>  					sge_bytes);
> >> >
> >> >Bernard, this is nonsense, what is going on here with sge->laddr
> >that
> >> >it can't be a void *?
> >> >
> >> siw_sge is defined in siw-abi.h. We make the address u64 to keep
> >the ABI
> >> arch independent.
> >
> >Eh? How does the siw-abi.h store a kernel pointer? Sounds like kernel
> >and user types are being mixed.
> >
> 
> siw-abi.h defines the work queue elements of a siw send queue.
> For user land, the send queue is mmapped. Kernel or user land
> clients write to its send queue when posting work
> (SGE: buffer address, length, local key). 

Should have different types.. Don't want to accidently mix a laddr
under user control with one under kernel control.

Jason
