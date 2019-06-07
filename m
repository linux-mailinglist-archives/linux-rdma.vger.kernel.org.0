Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E71339611
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 21:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfFGTms (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 15:42:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43987 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbfFGTms (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 15:42:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id z24so3646538qtj.10
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 12:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zz59RPGX+iC5zxoolzCkkNfTjthC5JIy19KosFGWAYA=;
        b=lHUzzHduCHUtHrRrYIqL9RioEFr1pMHnf0pQ8x5cigCWzQWGLU1yLqo81VDmmnxa7G
         RD7mgbk+czQz3dPvCP7In7qav3HxzS4FtBn3BVJvTXV+RoJ3InGhlP9WV9iQk5n8PSdl
         6x4hGbcoTYG8PCf6OgltCwXjLhWJT9z0+bj5Jb158YQmBGMHweCoBEjddckMdtVJvFng
         xvb5lsrOUaERkcgMS2gJBmG2kz3aA8p4vheJssY8BsZTUagDAzhPksPCWGHGD38ax6EB
         Ghw9H3kEwVmGD+h4OnbVgffTwFgHZyx4674Xg1w5V76WcgacojYUvSGgDE1yCsQq1X03
         5Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zz59RPGX+iC5zxoolzCkkNfTjthC5JIy19KosFGWAYA=;
        b=oSPslGTwDiQeHoHiWoVVpLOlr2GWHs1Z4Xf/bl0JfHg+MCE9tHDi1AfTkkUFo7oALB
         THZmK8Y7dwVjd7kHBmEpi0uN787NgyBoUU6JCbLhDTILgWHtWOw3nzROGxFByxphVLk0
         4vcLEXIXQgBtb1c9wRzmIvZ2vRItk6D15ZXCXwb7iDdTgEGpVh5lwEpPYNUhLM8iTgd7
         wai6e6FCn/Q5h9rl/tIScLPOJSvMxt8JZuRudX/Hwh5GDbAvYcnFF8XAO9AHxbnmIJ3u
         w5Y1ZWfFxl27EdnQDfGCJ10fY6oZE0j7cNeAoN+vjm5JelAFRai6pi0YMp66Va0VrSa5
         H+tQ==
X-Gm-Message-State: APjAAAVKc6C0pUBxSDauUFsNgPT+c7V4vQ3OsCDxV/A5HZi+o1d7t1lW
        qKLKBa6fy66R6RazxQA8puOo8pPoaxhVZg==
X-Google-Smtp-Source: APXvYqyGFpV1dTHrmQ2Y7gjQknxrvpXYnT9DeR3klPYI6+o8RSnl/dW8xSfW9z0m1+2O3lKpE4k/OA==
X-Received: by 2002:ac8:38cc:: with SMTP id g12mr47204847qtc.68.1559936567299;
        Fri, 07 Jun 2019 12:42:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f34sm1727201qta.19.2019.06.07.12.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 12:42:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZKlC-0006LD-B0; Fri, 07 Jun 2019 16:42:46 -0300
Date:   Fri, 7 Jun 2019 16:42:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH 30/32] ucma: Convert ctx_idr to XArray
Message-ID: <20190607194246.GB24288@ziepe.ca>
References: <20190221002107.22625-1-willy@infradead.org>
 <20190221002107.22625-31-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221002107.22625-31-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 20, 2019 at 04:21:05PM -0800, Matthew Wilcox wrote:
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  drivers/infiniband/core/ucma.c | 56 ++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 33 deletions(-)

Applied to for-next, but I added this hunk:

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -81,7 +81,7 @@ struct ucma_file {
 };
 
 struct ucma_context {
-       int                     id;
+       u32                     id;
        struct completion       comp;
        atomic_t                ref;
        int                     events_reported;

Thanks,
Jason
