Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C29927F7
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 17:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfHSPHZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 11:07:25 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42967 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfHSPHZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 11:07:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so1662306qkm.9
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 08:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pYG07FQXinRxulmKHOMsg40sZWME3PdnJpDYcJpltkI=;
        b=mwjGdyFnrfMnbo4xepP5VDv4cV810K0v/nwltdU9hB6YmpGhEZ56PUqqfO8z88Oda0
         yvgi0mfqOc1Sq+XUKoBBmEmsB709wKk/MrINiAPdg90ZHjACST9Gw2Tm1av+57lv2+d0
         CDOJncwdS+/KNy5SS4ejwTHRo/z2YWyKnx75ihJuc1ezRt9sA2F1t0Row2IkgQM+VZ0V
         Srdg+irL0vWbrzbquTSmaQcCy//SxScfUTrmogfcI40bZc/qPoQ/IJPbCO+5Vg+9v0LK
         n9ocKDUniz0Drq46+nzenO/SaBGtODwwI/ShaHa5CmBjhYPZRn8h1UGJ3NE3ms9xBCwQ
         ZjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pYG07FQXinRxulmKHOMsg40sZWME3PdnJpDYcJpltkI=;
        b=qlRuemODZDu8RKec++Pu6L/Rmo6c7SP7m1SNbqVG2ObdZWE9gN0F/6ZbIybsz6QpR+
         bGCG+/tivUMupjYj3RhZ2UTnM+4MjH+HqlDerGx7ML9wGFmBRHhBaBd6cP9pAvzg/J8f
         EbcWBXW41rpume8cuHmApwFt/a5KqG2fYUJzzq+h3kMjxa6qGZ7o9bLMU1+khB+VyRm9
         rgzXfHT4UztoZrc0OVC0rzPJKc9b/NEDVfKTBfZCtpqh+trfGkGZ6qFsKZAAGMsqrH/N
         iChKDbCVo3cmRS9wTf0Zh88f2bJbVHcwq672i7xsjOj5gH/nkmonXjpVSqWllvbjllRy
         Q2dA==
X-Gm-Message-State: APjAAAXjNOXkjZ1oP5qTs+QxvYzHyRTmhPwIbizXxxz0C75HkPiDGy76
        KiXR/yGMJefcS8laYFu2EZ2YXg==
X-Google-Smtp-Source: APXvYqw1y3jYMmvxJOlP9VxdzBIRPZnY3jaTAKfEBX5WHmI1u1LjD3CAWBGFEEgq5D2r4VA9EhPXQw==
X-Received: by 2002:a37:9f07:: with SMTP id i7mr18332057qke.485.1566227244160;
        Mon, 19 Aug 2019 08:07:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id b127sm7103473qkc.22.2019.08.19.08.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 08:07:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hzjFj-0004zq-Cl; Mon, 19 Aug 2019 12:07:23 -0300
Date:   Mon, 19 Aug 2019 12:07:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
Message-ID: <20190819150723.GH5058@ziepe.ca>
References: <20190819141856.GG5058@ziepe.ca>
 <20190819135213.GF5058@ziepe.ca>
 <20190819122456.GB5058@ziepe.ca>
 <20190819100526.13788-1-geert@linux-m68k.org>
 <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
 <OFD7D2994B.750F3146-ON0025845B.004D965D-0025845B.004E5577@notes.na.collabserv.com>
 <OFD7C97688.66331960-ON0025845B.005081B6-0025845B.0051AF67@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD7C97688.66331960-ON0025845B.005081B6-0025845B.0051AF67@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 02:52:13PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 08/19/2019 04:19PM
> >Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
> ><dledford@redhat.com>, linux-rdma@vger.kernel.org,
> >linux-kernel@vger.kernel.org
> >Subject: [EXTERNAL] Re: Re: Re: [PATCH] RDMA/siw: Fix compiler
> >warnings on 32-bit due to u64/pointer abuse
> >
> >On Mon, Aug 19, 2019 at 02:15:36PM +0000, Bernard Metzler wrote:
> >> 
> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >> >Date: 08/19/2019 03:52PM
> >> >Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
> >> ><dledford@redhat.com>, linux-rdma@vger.kernel.org,
> >> >linux-kernel@vger.kernel.org
> >> >Subject: [EXTERNAL] Re: Re: [PATCH] RDMA/siw: Fix compiler
> >warnings
> >> >on 32-bit due to u64/pointer abuse
> >> >
> >> >On Mon, Aug 19, 2019 at 01:36:11PM +0000, Bernard Metzler wrote:
> >> >> >If the value is really a kernel pointer, then it ought to be
> >> >printed
> >> >> >with %p. We have been getting demanding on this point lately in
> >> >RDMA
> >> >> >to enforce the ability to keep kernel pointers secret.
> >> >> >
> >> >> >> -			wqe->sqe.sge[0].laddr = (u64)&wqe->sqe.sge[1];
> >> >> >> +			wqe->sqe.sge[0].laddr = (uintptr_t)&wqe->sqe.sge[1];
> >> >> >
> >> >> >[..]
> >> >> >
> >> >> >>  			rv = siw_rx_kva(srx,
> >> >> >> -					(void *)(sge->laddr + frx->sge_off),
> >> >> >> +					(void *)(uintptr_t)(sge->laddr + frx->sge_off),
> >> >> >>  					sge_bytes);
> >> >> >
> >> >> >Bernard, this is nonsense, what is going on here with
> >sge->laddr
> >> >that
> >> >> >it can't be a void *?
> >> >> >
> >> >> siw_sge is defined in siw-abi.h. We make the address u64 to keep
> >> >the ABI
> >> >> arch independent.
> >> >
> >> >Eh? How does the siw-abi.h store a kernel pointer? Sounds like
> >kernel
> >> >and user types are being mixed.
> >> >
> >> 
> >> siw-abi.h defines the work queue elements of a siw send queue.
> >> For user land, the send queue is mmapped. Kernel or user land
> >> clients write to its send queue when posting work
> >> (SGE: buffer address, length, local key). 
> >
> >Should have different types.. Don't want to accidently mix a laddr
> >under user control with one under kernel control.
> >
> Well we have an unsigned 64bit for both user and kernel
> application buffer addresses throughout the rdma stack, 

We do not. Kernel addresses are consistenyly void * or dma_addr_t

Most places that consume a data address are using lkeys anyhow, which
does have a lkey & u64, but that u64 is not a application buffer
address, but the IOVA of the lkey, which is very different.

I really have no idea why siw needs to mix kernel VAs with user
pointers, particularly in wqes...

Jason
