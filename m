Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8039F265F1B
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Sep 2020 13:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgIKL6Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Sep 2020 07:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgIKL5x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Sep 2020 07:57:53 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A92C061573
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 04:57:53 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y11so7565672qtn.9
        for <linux-rdma@vger.kernel.org>; Fri, 11 Sep 2020 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fVxL2Y50MVOO4knYF5mqQ6ef6UPNQDX5s7q5Jl6nhJo=;
        b=KbFmmhJ6RCzAdEoHpDtOso5YYL9i7QnUvcwQ9u5sx140O0Xuh1oroDgXwXueRBEvyp
         lXNt3o78Lrbo9HZPm+S8aFORSeMO5ytEgLuF40cYw6+99T9WCWTuUTN695dHmGV0571B
         FRxse8+/5MQ1gG2xVHQYE0rjmlfz1yK+iaPGYK6WMjIfVwa4RlISn5/+UIqVqhrZuLia
         kiLmCoV8su62eA93USPIcsocm41az14H/Mf1I3vAXLcB7pXDzHaAu5z9NYLDBOqLZtXN
         cMdQY3L7p6+227ebo8KlM/Od7L2SMbvZ2IbRdgCXHvutrYJc04jg3nY312pno8cAMxjd
         mfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fVxL2Y50MVOO4knYF5mqQ6ef6UPNQDX5s7q5Jl6nhJo=;
        b=exqkLZpQPU2gzAmHku/IOq/55kt7ePg1Y/WpxFEdG/l892OZAebQOrhVPSWXH+WvPE
         fK9Gw1ZEdfQYXmY/yBjtJgfzJLuCyiKRWlZU5vyl9y/dOLYdKg8Mc1h6hDwwmGdsHDQ5
         HM4UG6exPUFr4tq0v44mQ4QUiptt9bnwogDsp0mkcrWCQtXawNcvfv2g2R0mgtwM72Sy
         fGswYq0EABIYqHojeZq1IerQpnWD9FuvL/Fc7jxnmylJZ/DBNvoQj66UPPyaekl1hjmB
         Du5FOwNZDFwPMGY/KfNS6WMip6X8xQsm6vGNU2UmD18OcogdtoqzDursmTdgxtJSm5ln
         kuEA==
X-Gm-Message-State: AOAM530Ugb26/1wiEiZgGA2qayPQnbX8GUt76LhnIj5z94zfKqBbWsa4
        su11l1PdRGT/5a5fCmfSFhWKZw==
X-Google-Smtp-Source: ABdhPJx+Y8ANg5LRJ4dJPAqarA+pYSzoOrh1bfASUIo86ILsr/Gx+4AHcDdZ0DEQ4x7p1bSVqN4CEA==
X-Received: by 2002:aed:3584:: with SMTP id c4mr1413234qte.84.1599825472485;
        Fri, 11 Sep 2020 04:57:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d5sm2405622qtm.36.2020.09.11.04.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 04:57:51 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGhgc-004m3a-JY; Fri, 11 Sep 2020 08:57:50 -0300
Date:   Fri, 11 Sep 2020 08:57:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+cc6fc752b3819e082d0c@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in ucma_close (2)
Message-ID: <20200911115750.GA1137957@ziepe.ca>
References: <0000000000008e7c8f05aef61d8d@google.com>
 <20200911041640.20652-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911041640.20652-1-hdanton@sina.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 11, 2020 at 12:16:40PM +0800, Hillf Danton wrote:
> Detect race destroying ctx in order to avoid UAF.
> 
> +++ b/drivers/infiniband/core/ucma.c
> @@ -625,6 +625,10 @@ static ssize_t ucma_destroy_id(struct uc
>  		return PTR_ERR(ctx);
>  
>  	mutex_lock(&ctx->file->mut);
> +	if (ctx->destroying == 1) {
> +		mutex_unlock(&ctx->file->mut);
> +		return -ENXIO;
> +	}
>  	ctx->destroying = 1;
>  	mutex_unlock(&ctx->file->mut);
>  
> @@ -1826,6 +1830,8 @@ static int ucma_close(struct inode *inod
>  
>  	mutex_lock(&file->mut);
>  	list_for_each_entry_safe(ctx, tmp, &file->ctx_list, list) {
> +		if (ctx->destroying == 1)
> +			continue;
>  		ctx->destroying = 1;
>  		mutex_unlock(&file->mut);
>  

ucma_destroy_id() is called from write() and ucma_close is release(),
so there is no way these can race?

Jason
