Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8171312FD39
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 20:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgACTqh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 14:46:37 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34192 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgACTqh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 14:46:37 -0500
Received: by mail-qt1-f193.google.com with SMTP id 5so37644172qtz.1
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 11:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QFEQqUuyVkEOkAkzZzWnCG8Pa+5PBz8reji8nYV/KRU=;
        b=l3VT4epFg88GADGyl6jy9uxoGsxo4qy850idjn8z2XmbJjLTEXMcVmtS1ta+7Y9QR2
         IQKcIZLhQwOkym9+qjaT/TI8qqb8jsxlHNnJSzX/W2B6jZSGkJ9XlgtTB4EDSZB5BMs1
         Mk3kivbmcGG2acKZwcObUje/zi53IxrJZRO8pNRkuDQdWbryjzTHAb9ZOy7HxciUvSB9
         Xe85jiI+rTDv5ufMSxVnu++s0oCoVpCy+uIQDWJhRIETKgW2W53C9/rAe8aOTEAfB9Cw
         Um2XHS8Al6rqPg9yaM07A+QtJzM2T+Gkdp0R1bFHpJcvZHoZeDG/hU06WMt7uXk+BCNg
         Hsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QFEQqUuyVkEOkAkzZzWnCG8Pa+5PBz8reji8nYV/KRU=;
        b=ZMqbrlmoWPOGBloh7bWB3ddY2TVVIso43K5Qqv1uyKuioK5KSUM+ww/IVH4g9AJB9E
         WGYvWxtBGw9JXuxmMThoZSKUVbqtlXd9oR83xVUgP6R/6EVLZUNgH8iBceC/KPjjVBk9
         fzdY3c77pGiHrUxeiUTbkGxVgZ7fNz328n9uYRjchCS18tDQv/UCSJ9u0flTxv2RgLSg
         jwN3MWFk2GZY6w1IQLDuY4uiMx2kSGO6QhrlPQ7cXDORCmMk2hQBWCdY0TpTEf7fGhYL
         RqFFpmeBqJdeY6syZcFh3/5XbdCNXp7jy4WjdY+mRdy4KzdeaYR6jMZl0qqDuIf1l4Z+
         zqAg==
X-Gm-Message-State: APjAAAX4Wj5Lr0gG+cGJT4iOrDPtclVkcUr83x2o+JqsZlrPLQ8tDjpK
        domLaHv0Cvc7mOjjvK7yps7VZg==
X-Google-Smtp-Source: APXvYqy2xt1XYPlTd2PT4NbLWF5ZSRWs4fw2Raj+GWHa3xbxz4Xpc/Fxu3G9fyceaZjSbaKS/8JJXQ==
X-Received: by 2002:ac8:614d:: with SMTP id d13mr60143522qtm.212.1578080796399;
        Fri, 03 Jan 2020 11:46:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id u24sm17048272qkm.40.2020.01.03.11.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 11:46:36 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inSu3-0004pY-Kv; Fri, 03 Jan 2020 15:46:35 -0400
Date:   Fri, 3 Jan 2020 15:46:35 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 6/6] RDMA/bnxt_re: Report more number of
 completion vectors
Message-ID: <20200103194635.GA18528@ziepe.ca>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
 <1574671174-5064-7-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574671174-5064-7-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 25, 2019 at 12:39:34AM -0800, Selvin Xavier wrote:
> Report the the data path MSIx vectors allocated by driver as
> number of completion vectors. One interrupt
> vector is used for Control path. So reporting one
> less than the total number of  MSIx vectors allocated
> by the driver.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
