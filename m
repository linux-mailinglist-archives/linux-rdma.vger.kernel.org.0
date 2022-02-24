Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDFF4C2EAB
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 15:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiBXOvx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 09:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiBXOvw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 09:51:52 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72012325CB
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 06:51:21 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 185so1972877qkh.1
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 06:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dvXH9Z3GBBmqBSzqAK6dG6yrd3mmZje7UbRZJL5KiIQ=;
        b=fW/BnN70kerbTBUw4zVM37fJ6aUVO357LTUaDI/ReUAPuM9W6AhuGdSAbrOa9iVksQ
         IoVnL5tadF++ofTTAS+nlIBB50dB2FrLxZlwjJaqofuCCSjyBfcqpkCugttPIAW/9taB
         9QjgsUS+nb5yV7KFbiLieeqsZvjJ26mGXwYAwgi86LOB8MIJ2Vg4WR6dKCOMNGd/Bbuz
         6YK9Xk/9U6+Pzsw/kFVKJqKsHy/M43SxufzkMmqBpwqdMBRchTElVFB4AK2nY8FWHZ9+
         dYil6KFxhM2oqpgX9Gd+54IF1iUN7Y6dDDW3A4ym804LWlu19mNeDTMagirtOm7kdaYp
         gA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dvXH9Z3GBBmqBSzqAK6dG6yrd3mmZje7UbRZJL5KiIQ=;
        b=Ywm46k31z68NJQKXy+V2Nw+KcTUJOEe4lGRhKbVoazJQI68PRgefd2Jg0Eltx9nvVt
         ZSats2WXZ9mADWq/aRty/jgnoPZTTG5TiQLeKiy4/wEpyQ6OHPzoQi6PgcdXbN+MvHYo
         mrGY10ivH1K4B6gBLZO3iVRk/imO/Bd7pNJfcsTrXamyaOZmgIb/sBKzCVCLTqYbKf99
         Xmu+guvcU7SrFoZEWZS2hCdLrTMWDiA4OlMsiMLqH62WQCuJYy5yv/wen5j+Y90edORT
         Y1NJLK3tVjGZpNltweWm3DUyv/LQI1eASsYh33lD1f10XU3jwXh8QKmAhkRPv/6uOZPF
         EvWg==
X-Gm-Message-State: AOAM5305jQBYN+HEckv15yS5CzO3NNzlGavb4cDDdgvZBU6Sm6VC9UMj
        lNTjqUnK5zaAE8X+tVJlLDrrjA==
X-Google-Smtp-Source: ABdhPJzXutZFMGXC6o4DsmTXO3ik/o/uZOM+ckf0+ngNgVwKWzRXY3VDjIxMXH+5gB+KTOny+cXpLQ==
X-Received: by 2002:a37:45d3:0:b0:47a:645e:137f with SMTP id s202-20020a3745d3000000b0047a645e137fmr1787333qka.535.1645714281049;
        Thu, 24 Feb 2022 06:51:21 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 79sm1397808qkf.108.2022.02.24.06.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 06:51:20 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nNFSg-0004KM-HY; Thu, 24 Feb 2022 10:51:18 -0400
Date:   Thu, 24 Feb 2022 10:51:18 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     jhubbard@nvidia.com, Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA: Convert put_page() to put_user_page*()
Message-ID: <20220224145118.GA6468@ziepe.ca>
References: <20220224093758.GA30603@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224093758.GA30603@kili>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 24, 2022 at 12:37:58PM +0300, Dan Carpenter wrote:
> Hi John,
> 
> I'm not really sure who to send this bug report to so you got picked
> a bit at random...
> 
> The patch ea996974589e: "RDMA: Convert put_page() to
> put_user_page*()" from May 24, 2019, leads to the following Smatch
> static checker warning:
> 
> 	./include/linux/pagemap.h:897 folio_lock()
> 	warn: sleeping in atomic context
> 
> ./include/linux/pagemap.h
>     895 static inline void folio_lock(struct folio *folio)
>     896 {
>     898         if (!folio_trylock(folio))
>     899                 __folio_lock(folio);
>     900 }
> 
> The problem is that unpin_user_pages_dirty_lock() calls folio_lock()
> which can sleep.
> 
> Here is the raw Smatch preempt output.  As you can see there are
> several places which seem to call unpin_user_pages_dirty_lock() with
> preempt disabled.
> 
> __usnic_uiom_reg_release() <- disables preempt
> usnic_uiom_reg_get() <- disables preempt
> -> usnic_uiom_put_pages()
> rds_tcp_write_space() <- disables preempt
> -> rds_send_path_drop_acked()
>    -> rds_send_remove_from_sock()
>       -> rds_message_put()
>          -> rds_message_purge()
>             -> rds_rdma_free_op()
> rds_message_purge() <duplicate>
> -> rds_atomic_free_op()
>                -> unpin_user_pages_dirty_lock()
>                   -> folio_lock()
> 
> Let's pull out the first example:
> 
> drivers/infiniband/hw/usnic/usnic_uiom.c
>    228                spin_lock(&pd->lock);
>    229                usnic_uiom_remove_interval(&pd->root, vpn_start,
>    230                                                vpn_last, &rm_intervals);
>    231                usnic_uiom_unmap_sorted_intervals(&rm_intervals, pd);
>    232
>    233                list_for_each_entry_safe(interval, tmp, &rm_intervals, link) {
>    234                        if (interval->flags & IOMMU_WRITE)
>    235                                writable = 1;
>    236                        list_del(&interval->link);
>    237                        kfree(interval);
>    238                }
>    239
>    240                usnic_uiom_put_pages(&uiomr->chunk_list, dirty & writable);
>                       ^^^^^^^^^^^^^^^^^^^^
> We're holding a spin lock, but _put_pages() calls unpin_user_pages_dirty_lock().
> 
>    241                spin_unlock(&pd->lock);
>    242        }


Huh. So yes, these drivers are broken and always have been. They will
crash if userspace feeds them file backed memory or something.

Probably best to send this report to each of the top level driver
maintainers

Jason
