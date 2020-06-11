Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD21F69D6
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2020 16:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgFKOX6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jun 2020 10:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgFKOX5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jun 2020 10:23:57 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6629FC08C5C1
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 07:23:57 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b27so5695344qka.4
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xXL2ZnFRylOGOx7NzFIjayD6XsbUd6M+ahDMW+stYHw=;
        b=UTVtfFMR1+I6CVxhOytqXlPScDgGCbz/FJOLRIHpo2pgj7M7y2QYfLz8obwoJZPKdJ
         zIbm3NDuuhERuUZGoX2FISxyaRJf88fQDpBBDr/JUG0/lLLe3h4OBNhT2SQR44ODhR1z
         MKNK4izbbFm9D7p4vKfELJjD9zvZrzoNekwA4s/Fhb7PSa6tB29ttC5BsCbyL7I0N/tF
         ESjD35a3WvDKV99Cf4dnbhSQ8MFabGaRz2s7vBYkg4jiWFoijsxXQUziByXso/E2GmMs
         eCfIk3QfzGuH+jNas4LScgV2r7caf9gB3TxD/3937I/52V3EH5IntnsVhRBQLnsfacR1
         CIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xXL2ZnFRylOGOx7NzFIjayD6XsbUd6M+ahDMW+stYHw=;
        b=CTeBYx2Pa0srOGSUY+LWLBv7Q66pbumhizrchHwoEcUpbUUxDi3/rddaXgdqt7mR7N
         zpOBoRIJVUgYrjclGncrKD09JPFr20/3y6iUiHHpcuAXBdkyogBLghWiezTpW24UOgb8
         5yIVb9rXK9tVla5HKN/rWXJ1Pdtz1qKiBnOc3ozcAOLI/wyaqaj0INvJor4jVx4Fj4X7
         zFq8BgQNk1dM/sUlbkbdGptLgnQqq1pgtSB1PaqvbAalnUzMqZto9zQFkjmTH81X7xIc
         o+DAuFgol4x02HvXlqVtfIZzNQMMy9NUt0MCeLGYsF8Ew4xli2dbNMSwO/Xj4r9xTMkq
         0eLQ==
X-Gm-Message-State: AOAM532mSQSdWduhQEbPjYCopwfcnMJDE30ynBG5/tl3cw3XibWWRN38
        Kp+/hnaiZqJqK3sQMplUngc4Jw==
X-Google-Smtp-Source: ABdhPJxWTBdd0vFhQNrK6UhfnO+GtiEnVQQQ1VnCxp39MPQdgV5GIzMghewLNmJN0I9od2nM7ssBoA==
X-Received: by 2002:a05:620a:21cc:: with SMTP id h12mr8496525qka.194.1591885436638;
        Thu, 11 Jun 2020 07:23:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d78sm2282846qkg.106.2020.06.11.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 07:23:55 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jjO7X-005xDV-BR; Thu, 11 Jun 2020 11:23:55 -0300
Date:   Thu, 11 Jun 2020 11:23:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Tom Seewald <tseewald@gmail.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: Re: [PATCH next] siw: Fix pointer-to-int-cast warning in
 siw_rx_pbl()
Message-ID: <20200611142355.GX6578@ziepe.ca>
References: <20200611113539.GV6578@ziepe.ca>
 <20200610175008.GU6578@ziepe.ca>
 <20200610174717.15932-1-tseewald@gmail.com>
 <OF2F6FD798.5AF6086F-ON00258584.00329A25-00258584.0038EE32@notes.na.collabserv.com>
 <OFE9B278DF.7F90B863-ON00258584.004CDA7A-00258584.004DFD42@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFE9B278DF.7F90B863-ON00258584.004CDA7A-00258584.004DFD42@notes.na.collabserv.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 11, 2020 at 02:11:51PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >Date: 06/11/2020 01:35PM
> >Cc: "Tom Seewald" <tseewald@gmail.com>, linux-rdma@vger.kernel.org,
> >"Doug Ledford" <dledford@redhat.com>
> >Subject: [EXTERNAL] Re: Re: [PATCH next] siw: Fix pointer-to-int-cast
> >warning in siw_rx_pbl()
> >
> >On Thu, Jun 11, 2020 at 10:21:49AM +0000, Bernard Metzler wrote:
> >> 
> >> >To: "Tom Seewald" <tseewald@gmail.com>
> >> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
> >> >Date: 06/10/2020 07:50PM
> >> >Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
> >> ><bmt@zurich.ibm.com>, "Doug Ledford" <dledford@redhat.com>
> >> >Subject: [EXTERNAL] Re: [PATCH next] siw: Fix pointer-to-int-cast
> >> >warning in siw_rx_pbl()
> >> >
> >> >On Wed, Jun 10, 2020 at 12:47:17PM -0500, Tom Seewald wrote:
> >> >> The variable buf_addr is type dma_addr_t, which may not be the
> >same
> >> >size
> >> >> as a pointer.  To ensure it is the correct size, cast to a
> >> >uintptr_t.
> >> >> 
> >> >> Signed-off-by: Tom Seewald <tseewald@gmail.com>
> >> >>  drivers/infiniband/sw/siw/siw_qp_rx.c | 3 ++-
> >> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> >> 
> >> >> diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c
> >> >b/drivers/infiniband/sw/siw/siw_qp_rx.c
> >> >> index 650520244ed0..7271d705f4b0 100644
> >> >> +++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
> >> >> @@ -139,7 +139,8 @@ static int siw_rx_pbl(struct siw_rx_stream
> >> >*srx, int *pbl_idx,
> >> >>  			break;
> >> >>  
> >> >>  		bytes = min(bytes, len);
> >> >> -		if (siw_rx_kva(srx, (void *)buf_addr, bytes) == bytes) {
> >> >> +		if (siw_rx_kva(srx, (void *)(uintptr_t)buf_addr, bytes) ==
> >> >> +		    bytes) {
> >> >
> >> >How is a dma_addr_t being cast to a void *? That can't be right?
> >> >Bernard??
> >> >
> >> >Jason
> >> >
> >> Hi Tom, Hi Jason,
> >> 
> >> Thanks for looking into that.
> >> 
> >> siw_rx_kva() calls skb_copy_bits() to move data to its
> >> kernel clients destination.  It expects a void * target
> >> address. This is why I chose it for siw_rx_kva() as well.
> >> One could say siw_rx_kva() should better get an uintptr_t
> >> as target argument, which would probably make it look
> >> more clean. And we rename it to siw_rx_kbuf(), and we
> >> cast from uintptr_t to (void *) just for
> >>  skb_copy_bits(skb *, off, (void *)dest, len)
> >> 
> >> This would avoid all those nasty (void *) casting at all (!)
> >> the places we are calling siw_rx_kva().
> >
> >But where did the dma_addr_t come from?
> >
> It initially comes from the scatterlist provided by the
> kernel user via drivers .map_mr_sg() method. There we get a
> dma_addr_t describing the users buffer.

For the SW dma maps you have to convert the dma_addr_t to a kva using
kmap, it cannot just be casted.

Jason
