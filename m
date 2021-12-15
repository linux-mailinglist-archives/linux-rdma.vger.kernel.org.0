Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18795476211
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 20:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhLOTrq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 14:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLOTrp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Dec 2021 14:47:45 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20D8C061574;
        Wed, 15 Dec 2021 11:47:44 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id k2so34939107lji.4;
        Wed, 15 Dec 2021 11:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RRSQSGmz5MJxAtNoy5ku4p9949druM4EYIQTCnH78cc=;
        b=VEWYMaFSoQanfogFrfV1Sox5WevQcbz1puJC4H20f6rs2zUtn1HMChBUyFRtXJVcci
         ro44bFWIuk160YU+k5y7FTmzhlA0VeJZsAVb6QiMNa2DZCRI/WtKFOxQ3tj2Ye4pbFX7
         HINYl4TSsVveY7DAREgE62cCcT6tLqIkELe7GgaDZoKj8dotTaXIRf5SRSw8a1A+pmdS
         9/LXndzj0al+C2h5wPpqS2T7IY1jR9+uzdVl44diIIWrP7gxdZeh0VtTn0UTbk0CYLqT
         RiW+hKkNellVCe6rkPeGdUFBxTH3czA/UzL2dFlpGRjmf3FlY3V2NtT+u/jt2xNdBrcx
         0Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RRSQSGmz5MJxAtNoy5ku4p9949druM4EYIQTCnH78cc=;
        b=NdV+H5lvX3Gb8mwUBPNiFB7grOhTSnp3RdodHRg1q8aHYwi1TYp7O7htqxdtjKKeym
         J0iRetQqgbBKpg4/gUEZhgWSgEuEYm04SdYXrlzavjYeQVuWH8lR0xsKK+dhhrd4i5xy
         Uu1saDQVnrRHPuPA+rcxfIx3XlS+LPd+o4I73RXxZzvF8kJhIm4e3akx+TF5U4tnujrJ
         fQPtbqg/8IRCbK54etrqagecKjo1LrmMJP3d2OlO37kZcIzQq3K2cEm25Y4956Fwb6Mh
         E0xNFTRoqnqtL925nRdQsQBeYQb4RC1E2+lnetHuxe+OU8pHEr5pALC5rN+GLJXzCiy0
         IrVw==
X-Gm-Message-State: AOAM532J1rWXc4DLb5ElZj0r1G56cL/wA1YGU6ksRKKytb5xPr2JlKqY
        BWNms/tf8FDtmGKAa/I92st2aZytEbu4++24
X-Google-Smtp-Source: ABdhPJxRx3uiDAtfNWWcFQQYd+QCnbIIUQirl5hmvjbB5YywCsblhUH/DuLep2quNsg5jX9jGh5VpA==
X-Received: by 2002:a05:651c:550:: with SMTP id q16mr11997300ljp.371.1639597663311;
        Wed, 15 Dec 2021 11:47:43 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id d11sm464618lfq.303.2021.12.15.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:47:40 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 15 Dec 2021 20:47:38 +0100
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH] RDMA/hfi1: Switch to kvfree_rcu() API
Message-ID: <YbpGWpskiByQNcJO@pc638.lan>
References: <20211215111845.2514-1-urezki@gmail.com>
 <20211215111845.2514-8-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215111845.2514-8-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 15, 2021 at 12:18:44PM +0100, Uladzislau Rezki (Sony) wrote:
> Instead of invoking a synchronize_rcu() to free a pointer
> after a grace period we can directly make use of new API
> that does the same but in more efficient way.
> 
> TO: linux-rdma@vger.kernel.org
> TO: Jason Gunthorpe <jgg@nvidia.com>
> TO: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  drivers/infiniband/hw/hfi1/sdma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
> index f07d328689d3..7264a35e8f4c 100644
> --- a/drivers/infiniband/hw/hfi1/sdma.c
> +++ b/drivers/infiniband/hw/hfi1/sdma.c
> @@ -1292,8 +1292,7 @@ void sdma_clean(struct hfi1_devdata *dd, size_t num_engines)
>  	sdma_map_free(rcu_access_pointer(dd->sdma_map));
>  	RCU_INIT_POINTER(dd->sdma_map, NULL);
>  	spin_unlock_irq(&dd->sde_map_lock);
> -	synchronize_rcu();
> -	kfree(dd->per_sdma);
> +	kvfree_rcu(dd->per_sdma);
>  	dd->per_sdma = NULL;
>  
>  	if (dd->sdma_rht) {
> -- 
> 2.30.2
> 
+ linux-rdma@vger.kernel.org
+ Jason Gunthorpe <jgg@nvidia.com>
+ Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

--
Vlad Rezki
