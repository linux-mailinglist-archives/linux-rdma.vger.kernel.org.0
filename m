Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2411C13FA60
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 21:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbgAPUOm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 15:14:42 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43722 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAPUOl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 15:14:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id t129so20441696qke.10
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 12:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7iEFBthVA3fKjVUxkDoEnHPOEJvk8pQvsaOOdubD4VE=;
        b=Cc5cGVSCPXkRvmiJp4mHZPS8lFzP5r7d5Ss2RYtQl1usNhJo6sPAw3pGbQCVqY+ywZ
         h9mzXgPXrXAsM3rku4frXAn2HcFJGxVXCKGDA3Ri+82CkRRl5NpFqHTceMmV0TUOjXaF
         5cfAnybdjpYy8l2qraC+qaxByI5N6lt1zt12t+5Bvtt1msX5X1azd+Ep/2rvzy8qnpaR
         TZgUxHbWUqtRGgTbzNoZ4XE0TOwHea5jbIrnwqSjkCORd6JlaCGzB8yY9AQPkiL9P0qZ
         OS1NcFY6GV1yNJjiKRqDbuIuX5VcGRKllE0+1sCQ9QtETulIek+zyL2GrDW3fX7nCv5U
         TngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7iEFBthVA3fKjVUxkDoEnHPOEJvk8pQvsaOOdubD4VE=;
        b=g41/h9E8m3W0Mt6iwJFOnOMZJEaOIS+RD09LWdIM3/JzpsLSOnsjbzJbPdrXr3co8z
         7mDFHX77/i/SalgqSoesIVlGdlOjEbELBDSRKhpj/CIYIADU8O/Ge00fU2y8Vxs2BCIN
         n1LFIWHgMGUxCZEy7/rH4pxnrqTt+SG33CSZOxtP38ejGhJJaXnEWKho3nap1vyINb5w
         VEZWbXMLz8VgsVCPS5Gt8TusIrLWL5m1HY7+PSLza4I+RN6GdQiL6XTCefjnPLFpxL0B
         mznQS/m+lQEgaxUfjz5OJizwxh2c+tqVqlkHahWT+TDraXpcm8/6yXE2ha5Kjmh/RMSG
         x6dg==
X-Gm-Message-State: APjAAAUtF3i7jtSTSJBLUmTKnzk3nQdbfD1xjms1YlmhPfTfA3IWpkol
        etRT3o45rfOGL6aVsa7SX3AVqg==
X-Google-Smtp-Source: APXvYqzVbVcJLT2gMfsveijR3Thc/B0ecRD27kcxkTpUzj7fOmjX7cv9yLeJqdn0G7VkGFCjjjxftQ==
X-Received: by 2002:a37:6cc1:: with SMTP id h184mr34429154qkc.96.1579205680936;
        Thu, 16 Jan 2020 12:14:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k22sm10749875qkg.80.2020.01.16.12.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 12:14:40 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1isBXL-00018X-Ju; Thu, 16 Jan 2020 16:14:39 -0400
Date:   Thu, 16 Jan 2020 16:14:39 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-rc] IB/mlx4: Fix memory leak in add_gid error flow
Message-ID: <20200116201439.GA4343@ziepe.ca>
References: <20200115085050.73746-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115085050.73746-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 15, 2020 at 10:50:50AM +0200, Leon Romanovsky wrote:
> From: Jack Morgenstein <jackm@dev.mellanox.co.il>
> 
> In procedure mlx4_ib_add_gid(), if the driver is unable to
> update the FW gid table, there is a memory leak in the driver's
> copy of the gid table: the gid entry's context buffer is not freed.
> 
> If such an error occurs, free the entry's context buffer, and mark the
> entry as available (by setting its context pointer to NULL).
> 
> Fixes: e26be1bfef81 ("IB/mlx4: Implement ib_device callbacks")
> Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx4/main.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
