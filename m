Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3174AE795C
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfJ1Trn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 15:47:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33230 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbfJ1Trn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 15:47:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id 71so9724026qkl.0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Ke4qhm3sheIrZ8NVXjiaAd51fo7HCrBbjCWSyQdh18=;
        b=e0f46LARZV8FoXXwt3gr4PoxFT/FqLU/mrIg4JYt1hwLkkM6jh1aCFvFP7zS+UHDed
         nZ20GLzUBU0cRk7l7DbFBjx5KuF3rI9QNEDT/9BZpmsPsjeAdVRp2k6e5f0q68Ja5Fdw
         fPAJ0mZ+JqjVE+OSxV+Dx9IzuEA3NEFvlfBI1VLPTa42qx+Wl1DOJJb/mlJp691Q1FPW
         6KMfBECc7mzXDBWp3isGW4xs0MuQ0LL/bwOdEf90qQp9B85wah4mPF2whqYqVbS1FejT
         9lxVpEWKx0paCsPka7Fd4cl1MindrAdxfhmIYsgpED9hukrWfwUfszgdblAp6v80Sdoc
         ajUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Ke4qhm3sheIrZ8NVXjiaAd51fo7HCrBbjCWSyQdh18=;
        b=Z2HHTxbNe55L6+oUMsplxGnxvEtrh13fLfNTNfe3+LRRB8sCCmnvYED0RpqM820zwu
         SFLgO4wffKguz9XDoN2AD8wPefKUgWC1+4NzzsKTlsGmr4l1xcpP22SQYI0nxK6trA2i
         TX33+Qk0nqtY1iXdRzr2cLMf3+VXTBuzjdMzXruwoVPUL35QBexeMfylUHzlEwUH4hSE
         q2Gug8c5Zb9o1C7agV+uEV0NCimd84OWgnicNeOtqHFDMbqygGs4LNT758xymZH+TSYV
         A/DB+RFQgClAqJ+Z26NANCbeHHMZ7Zom6QTQRSgW+zdBXVx4SskXqF7FXDiQ7zv5wRJn
         V7iQ==
X-Gm-Message-State: APjAAAVx/e0lGSlswF0vg0Xjhm5A2ADr+C3OSPNlI6zA/BjNp39jpfOu
        aAtrpaWv3Snh4UjeDKpTHWcR5KUlqwE=
X-Google-Smtp-Source: APXvYqxnVuiGzgaEZqsfVyM8E6ZQ2n+qbCap8r14b+80+qQy4VRGUHAbKXcma9Gqtmh9XPjOhOrGZA==
X-Received: by 2002:a37:e10e:: with SMTP id c14mr18294077qkm.408.1572292062182;
        Mon, 28 Oct 2019 12:47:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id i5sm5965275qtb.94.2019.10.28.12.47.41
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 12:47:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iPAzM-00014q-SZ
        for linux-rdma@vger.kernel.org; Mon, 28 Oct 2019 16:47:40 -0300
Date:   Mon, 28 Oct 2019 16:47:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH 00/15] Rework the locking and datastructures for mlx5
 implicit ODP
Message-ID: <20191028194740.GA4107@ziepe.ca>
References: <20191009160934.3143-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009160934.3143-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 09, 2019 at 01:09:20PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> In order to hoist the interval tree code out of the drivers and into the
> mmu_notifiers it is necessary for the drivers to not use the interval tree
> for other things.
> 
> This series replaces the interval tree with an xarray and along the way
> re-aligns all the locking to use a sensible SRCU model where the 'update'
> step is done by modifying an xarray.
> 
> The result is overall much simpler and with less locking in the critical
> path. Many functions were reworked for clarity and small details like
> using 'imr' to refer to the implicit MR make the entire code flow here
> more readable.
> 
> This also squashes at least two race bugs on its own, and quite possibily
> more that haven't been identified.
> 
> Jason Gunthorpe (15):
>   RDMA/mlx5: Use SRCU properly in ODP prefetch
>   RDMA/mlx5: Split sig_err MR data into its own xarray
>   RDMA/mlx5: Use a dedicated mkey xarray for ODP
>   RDMA/mlx5: Delete struct mlx5_priv->mkey_table
>   RDMA/mlx5: Rework implicit_mr_get_data
>   RDMA/mlx5: Lift implicit_mr_alloc() into the two routines that call it
>   RDMA/mlx5: Set the HW IOVA of the child MRs to their place in the tree
>   RDMA/mlx5: Split implicit handling from pagefault_mr
>   RDMA/mlx5: Use an xarray for the children of an implicit ODP
>   RDMA/mlx5: Reduce locking in implicit_mr_get_data()
>   RDMA/mlx5: Avoid double lookups on the pagefault path
>   RDMA/mlx5: Rework implicit ODP destroy
>   RDMA/mlx5: Do not store implicit children in the odp_mkeys xarray
>   RDMA/mlx5: Do not race with mlx5_ib_invalidate_range during create and
>     destroy
>   RDMA/odp: Remove broken debugging call to invalidate_range

Applied to for-next with the two noted fixes

Jason
