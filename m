Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D860A1F5AC7
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2020 19:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgFJRuM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jun 2020 13:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgFJRuM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jun 2020 13:50:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D6BC03E96B
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2020 10:50:12 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v79so2883081qkb.10
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2020 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Km9HdfZMurW41FGpeWNZP01DwbkwGWz84T8E/je4TAU=;
        b=D16OQ1c7D6Ji60/6n1n6xQpYasaeB1VbJOacmHzNRRaPRHuYYpYV8xYAsBLJvqQqoe
         YiOxDJztgoMGhnm55jeK0iR8xOCxFJBm9Ep661lCksq0eM3PaI8jh3eDwTwe44dnzv1Y
         ApXFHzDm252tG2K8O6JPhzQEHrcO1/0mso3tBbAJhxjnjTpSuB69p8Fokuvj3rFA8J+d
         AAVHP2Ist3vUqoZOrAC6xkipRXIS8N2zHPuKOrgZgNRIqR+g+w0gPprhD5+yA24RFAm7
         K2BklNcMX74QYnKFKJBQZnfnNxGZKILWKMp7EhTM0KlvhH3PiXiGg01r2r/XbLLCxefn
         X2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Km9HdfZMurW41FGpeWNZP01DwbkwGWz84T8E/je4TAU=;
        b=j5lr1aYoQWlnIyNCNllKD57VY2owQ/tsJEC3A0l8yVK6V4pIGhCMqBOQOqKyFPxIDj
         OK4o1BUqZauyd6b9hfTysLte2EFFm0cAjO3aL8dCbquYQCcXMa3IsnBJN+ERVNUDkHNP
         PkemmneuOrhLpvU1xY+cUuROIF9bPB9fROYfy49SnpOm+c1X0YcUhL+4vW7iCO4KTJ7D
         csnSYVoI2pJ/bFrJCYtyod1GUIUGHONZsfvlUh7qKaKL8fWzZlRHN4XMej4SeouOEUru
         ET5ytO42z1QWD3EVLjVciJnh+SRPTYmfYdn0T3GoSA0kHAn6NEIg6FJihhTcdr7L/crV
         j+mw==
X-Gm-Message-State: AOAM531saT0lijyZS3E6MlnXT85BM+uhJ/jbaZQno/o/k/uP52J74kOh
        TaVC8X8dyvlXGW1H7KdkLRTFvRCgvkE=
X-Google-Smtp-Source: ABdhPJxY2/oJ7Y2fCapwptNgSLaRiDBvuHKxdQd3ZNu4wTO2lwAEAnbV/mDjquColnhUm6jrxgMXVQ==
X-Received: by 2002:ae9:e118:: with SMTP id g24mr4010247qkm.116.1591811411348;
        Wed, 10 Jun 2020 10:50:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x54sm524912qta.42.2020.06.10.10.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 10:50:09 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jj4rY-005XXr-L8; Wed, 10 Jun 2020 14:50:08 -0300
Date:   Wed, 10 Jun 2020 14:50:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Seewald <tseewald@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH next] siw: Fix pointer-to-int-cast warning in siw_rx_pbl()
Message-ID: <20200610175008.GU6578@ziepe.ca>
References: <20200610174717.15932-1-tseewald@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610174717.15932-1-tseewald@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 10, 2020 at 12:47:17PM -0500, Tom Seewald wrote:
> The variable buf_addr is type dma_addr_t, which may not be the same size
> as a pointer.  To ensure it is the correct size, cast to a uintptr_t.
> 
> Signed-off-by: Tom Seewald <tseewald@gmail.com>
>  drivers/infiniband/sw/siw/siw_qp_rx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
> index 650520244ed0..7271d705f4b0 100644
> +++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
> @@ -139,7 +139,8 @@ static int siw_rx_pbl(struct siw_rx_stream *srx, int *pbl_idx,
>  			break;
>  
>  		bytes = min(bytes, len);
> -		if (siw_rx_kva(srx, (void *)buf_addr, bytes) == bytes) {
> +		if (siw_rx_kva(srx, (void *)(uintptr_t)buf_addr, bytes) ==
> +		    bytes) {

How is a dma_addr_t being cast to a void *? That can't be right?
Bernard??

Jason
