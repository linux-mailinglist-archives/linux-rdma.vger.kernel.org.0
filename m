Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75A65F4E
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 20:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfGKSFN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 14:05:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37096 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbfGKSFN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 14:05:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id d15so4350693qkl.4
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2019 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1D45VDmCAbr+E4SZBzLB6VIycjDuXVw9dZK5gxi0EWc=;
        b=D0oxmZqNliGmZXYrGlhIuUh88RZXZ6IhsMAFjAuLmDmNgjdEH+q+K6YnRJrxj7arH8
         ibDZ7U1n+0tp6aNzpggOFouDSSYnHYAgfPUKAbSjef7i4GZxiBjOBtSx6GyLsCG7I8Gs
         3/nzEU52dHNo4HusV+6Qin1Wu1zmfGeiNhJFM51AbW2JxISWIxPoigumd2UMuNYyUbkq
         HQs82H7FdUQfp1nyOXzSwBKVDw2umbdNTDuBDd1Dei8y+sOUVydROMLgz9de2iphEO20
         x8ZsHURXfb0KYVdcJtWqFA4sItPUKHyTuyTeUp9pK4wUGCeP0d7cslj2oo39SjrAqRa+
         aYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1D45VDmCAbr+E4SZBzLB6VIycjDuXVw9dZK5gxi0EWc=;
        b=FvDNFgV2l9YlvyHysyKGd9sD3IU36qANNhP56vxWMQdSo/Ger2hlDi841VXaO5YQ7C
         tNwLIOigmz4RMNsIS96PQR3BLsKO/ivkkVBaZGhCvrr/dYyGKdVCT0Ch9j/XLURlfOE6
         UUtff6NjvuGj1jJbvaeXE6qeSe6wGotJxcJKZ3WFW1W1l6SJlwe75fdzzjUcqCGtCfol
         MIjPMTQKT250L7XDZG8Z4a/dZKHcmqPBYDvWy8ZpmaNf2Joe5FdOyp2QsMjgepe7H3B3
         0eCJ+VMffiKGuQZ4GgBmqUH18lGNEaf6TInZCAXd016rU9VKnhr5judntpkVwgVRqSde
         EV0A==
X-Gm-Message-State: APjAAAUOXeHbuBkNRtBLG0adpy8Neccq8pHJc+WAB1lVXo3ddJwGFPks
        c7quE53NgR38Ne6s4uBYb+ccgw==
X-Google-Smtp-Source: APXvYqy+KfKKXdR19a3uizpOypAq/2/Z4gaxG2jfIxckyfMiRmNY9/ODZSym3MEcVj/1lDRN0YQD1A==
X-Received: by 2002:a05:620a:310:: with SMTP id s16mr2827756qkm.420.1562868312483;
        Thu, 11 Jul 2019 11:05:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z21sm2034477qto.48.2019.07.11.11.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 11:05:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hldRP-0000Da-MZ; Thu, 11 Jul 2019 15:05:11 -0300
Date:   Thu, 11 Jul 2019 15:05:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Mark expected switch fall-throughs
Message-ID: <20190711180511.GA816@ziepe.ca>
References: <20190711161218.GA4989@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190711161218.GA4989@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 11:12:18AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/infiniband/sw/siw/siw_qp_rx.c: In function ‘siw_rdmap_complete’:
> drivers/infiniband/sw/siw/siw_qp_rx.c:1214:18: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    wqe->rqe.flags |= SIW_WQE_SOLICITED;
>    ~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/sw/siw/siw_qp_rx.c:1215:2: note: here
>   case RDMAP_SEND:
>   ^~~~
> 
> drivers/infiniband/sw/siw/siw_qp_tx.c: In function ‘siw_qp_sq_process’:
> drivers/infiniband/sw/siw/siw_qp_tx.c:1044:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     siw_wqe_put_mem(wqe, tx_type);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/sw/siw/siw_qp_tx.c:1045:3: note: here
>    case SIW_OP_INVAL_STAG:
>    ^~~~
> drivers/infiniband/sw/siw/siw_qp_tx.c:1128:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     siw_wqe_put_mem(wqe, tx_type);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/infiniband/sw/siw/siw_qp_tx.c:1129:3: note: here
>    case SIW_OP_INVAL_STAG:
>    ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> NOTE: -Wimplicit-fallthrough will be enabled globally in v5.3. So, I
>       suggest you to take this patch for 5.3-rc1.

Okay, I queued this for the current merge window then

Jason
