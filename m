Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5346D1F66E1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2020 13:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgFKLfn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jun 2020 07:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgFKLfl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jun 2020 07:35:41 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E58C08C5C1
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 04:35:41 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id u17so4281219qtq.1
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cSx2PUdWm9riC1h1X0m0wX/vdkCK4+4yDtNpgdh1AqY=;
        b=Xhx+99tdPVGS87APpvrMmNiTxtQREam7Yfj9VC8wnxKecERbSiZWRHekoG1bLhdy/M
         TQtmRfEF2XWrg4SncXoFRGKVY+2Fc4x6K69AMab/HFWFbgsG3eEV0AxzTW25mVbNTkuy
         Gx+VJRPKFWvr+1uS55TRPQGip5scWrxaMzbkbYtmeZbF8/2WRvl1qoPcTXxMAbebC/Kn
         utAdwKnBRN3uHgaaKk/qn0gUf7xzupQuGmjcUJcPhXeOHPb1byibfhSD7A9fhS4DIYdt
         lSo120p9VwIlETFLSzhG0to54xjVhwOzAzLPOKQ5c/G1yCArHE0NymVgHat1LvsJM7dW
         yYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cSx2PUdWm9riC1h1X0m0wX/vdkCK4+4yDtNpgdh1AqY=;
        b=RdbiAKJmhv0I2LfpYjyh3TQo5xtAYZhechpmx9M8TZTwaXkHDIbkABuM1v4UxjsRC5
         YKAVg52q29H1Qo+WJh1CWbdiZjrXpgWl4oKNsvg+QEy/znaeM4mwlKvpbCLZdhqI2VAU
         mKLkkmW7sS5UPsxz+wkC5YBOwLjodO8oiVuGOGBAFgt5MXA3WDKDfCYt+6gPQxyogRV8
         2Y7P3flTj2KpClS3QvYujOOkBwb5k4rvIqg/yle9SImDN7MG+SApFjWhuMoUmqpTCIBa
         mn84GdymkEfJ0Ld4hrit1j5N7YFgLSoB/QgrVRq0yhJU47bV6y0nc1kuge5hE12OlBdC
         j+Ig==
X-Gm-Message-State: AOAM531K8qQ4gTgpk8rI/u8P21oGPjTR55UVoytdoK1bU/x0JgculM2Y
        W6I7h51rDE9AnX+s4IHHvOGMLQ==
X-Google-Smtp-Source: ABdhPJwpXH1GCWC+J9OGzFpps9AviEedQuB5y2McH0yp3cb9tx/bshHKDq+lWFSA/Y1KchmF07qu7w==
X-Received: by 2002:ac8:4518:: with SMTP id q24mr7879584qtn.201.1591875340444;
        Thu, 11 Jun 2020 04:35:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k34sm385429qtf.35.2020.06.11.04.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 04:35:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jjLUh-005t7h-77; Thu, 11 Jun 2020 08:35:39 -0300
Date:   Thu, 11 Jun 2020 08:35:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Tom Seewald <tseewald@gmail.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: Re: [PATCH next] siw: Fix pointer-to-int-cast warning in
 siw_rx_pbl()
Message-ID: <20200611113539.GV6578@ziepe.ca>
References: <20200610175008.GU6578@ziepe.ca>
 <20200610174717.15932-1-tseewald@gmail.com>
 <OF2F6FD798.5AF6086F-ON00258584.00329A25-00258584.0038EE32@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2F6FD798.5AF6086F-ON00258584.00329A25-00258584.0038EE32@notes.na.collabserv.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 11, 2020 at 10:21:49AM +0000, Bernard Metzler wrote:
> 
> >To: "Tom Seewald" <tseewald@gmail.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 06/10/2020 07:50PM
> >Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
> ><bmt@zurich.ibm.com>, "Doug Ledford" <dledford@redhat.com>
> >Subject: [EXTERNAL] Re: [PATCH next] siw: Fix pointer-to-int-cast
> >warning in siw_rx_pbl()
> >
> >On Wed, Jun 10, 2020 at 12:47:17PM -0500, Tom Seewald wrote:
> >> The variable buf_addr is type dma_addr_t, which may not be the same
> >size
> >> as a pointer.  To ensure it is the correct size, cast to a
> >uintptr_t.
> >> 
> >> Signed-off-by: Tom Seewald <tseewald@gmail.com>
> >>  drivers/infiniband/sw/siw/siw_qp_rx.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c
> >b/drivers/infiniband/sw/siw/siw_qp_rx.c
> >> index 650520244ed0..7271d705f4b0 100644
> >> +++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
> >> @@ -139,7 +139,8 @@ static int siw_rx_pbl(struct siw_rx_stream
> >*srx, int *pbl_idx,
> >>  			break;
> >>  
> >>  		bytes = min(bytes, len);
> >> -		if (siw_rx_kva(srx, (void *)buf_addr, bytes) == bytes) {
> >> +		if (siw_rx_kva(srx, (void *)(uintptr_t)buf_addr, bytes) ==
> >> +		    bytes) {
> >
> >How is a dma_addr_t being cast to a void *? That can't be right?
> >Bernard??
> >
> >Jason
> >
> Hi Tom, Hi Jason,
> 
> Thanks for looking into that.
> 
> siw_rx_kva() calls skb_copy_bits() to move data to its
> kernel clients destination.  It expects a void * target
> address. This is why I chose it for siw_rx_kva() as well.
> One could say siw_rx_kva() should better get an uintptr_t
> as target argument, which would probably make it look
> more clean. And we rename it to siw_rx_kbuf(), and we
> cast from uintptr_t to (void *) just for
>  skb_copy_bits(skb *, off, (void *)dest, len)
> 
> This would avoid all those nasty (void *) casting at all (!)
> the places we are calling siw_rx_kva().

But where did the dma_addr_t come from?

Jason
