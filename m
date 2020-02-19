Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2128916503C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 21:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBSUue (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 15:50:34 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45209 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUud (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 15:50:33 -0500
Received: by mail-qt1-f193.google.com with SMTP id d9so1256454qte.12
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 12:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mdJCQhqorFnjIhfyeUmUnFGz5LOaimYfuWdQ/PmdiJw=;
        b=AUYJAKdv/3SO7mMPC+Msc7FU5/AU8uqZ4Q8Z2CNDxwvQXe0F7cHmIa/wj/6jDQ0Yer
         x6NLs5+UNcoPhmQ8qzS2jOEnHU/0C0MXV/y59Pq84FcoBuAkTJpWeLozH0etuIYRFqJZ
         RVGvRMogaV4PFxDexYiX0sATl7hRnPeTbEnJr3GZ8i0ieRgl3a1q0lJPjNvsd4Jqx2CB
         y766uQ3JyLQlKpl/yYl2Mq3SSmke7zq4+DPlhfPs/9alR3C2TvkfcVT9WEJAAAfdpPe/
         SnGlr7NfeHBpl2U4hBglZGHFaNQvXPJbSw8oDnFFvoxOUJTkgN0j51czArwqkBM6a3He
         L0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mdJCQhqorFnjIhfyeUmUnFGz5LOaimYfuWdQ/PmdiJw=;
        b=trGaeNCPCzEPJlqHTXV+xK0FPzSnmRCqoPBkWDaJjaX07N0MWTwoBbs12yL2PxsKLh
         3ydwIOEvL2t1m+ws7USW9H0vC+Am9uuKMybkg7YBtgfKlX2HhzhzA89SSYiN+60Fgc8g
         Sh/6cg4iNQAERqCu2wJtyunU5rIE9K34pJ7FwFrOfX1gZ/WCwQNL/Ad0EAC4xLco9J+9
         dsjyYM1xSO1OSRmquEH/OMiLR4xDmhkFo1uVliMMR49gjnnw21kIKUDY7ySlLKtVm/k6
         u93fN1aB3VSeXRmvAjd63XfuE7zS5dRzWDQClC8l93P6CQZWnAmyw1Oe1kHtLQpkzUav
         JBog==
X-Gm-Message-State: APjAAAV7H1JKJ5ozUXgFPotPmIc6xhFlHzWtuCEs/IFWFlQ0izGNYGPB
        rX6cz16U7AcmHWAEs6cb5euQKQ==
X-Google-Smtp-Source: APXvYqxFHFz/uoeeURgLtCiM+Ra7nYupYxN90ycnbuRiJZizynOilQebQ/zvL+K/QKFzeAN7TFkNrw==
X-Received: by 2002:ac8:7258:: with SMTP id l24mr23262380qtp.154.1582145431691;
        Wed, 19 Feb 2020 12:50:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v24sm464307qkj.33.2020.02.19.12.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 12:50:31 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4WIg-0003eA-Tg; Wed, 19 Feb 2020 16:50:30 -0400
Date:   Wed, 19 Feb 2020 16:50:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4 0/2]  Retrieve HW GID context from ib_gid_attr
Message-ID: <20200219205030.GA13975@ziepe.ca>
References: <1582107594-5180-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582107594-5180-1-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 02:19:52AM -0800, Selvin Xavier wrote:
> Provide an option for vendor drivers to get the HW GID context
> from the ib_gid_attr during modify_qp and create_ah. Required
> for drivers/HW that maintains HW gid index different than the
> host sgid_index.
> 
> Please review and merge
>
> Thanks,
> Selvin Xavier
> 
> v3 -> v4:
>  Addressed Jason's comments. Removed unnecessary validation and locking
>  as the reference to the GID table entry should be taken before invoking
>  the new symbol.
> 
> v2 -> v3:
>  Added a new symbol to retrieve the hw context.
> 
> v1 -> v2:
>  Addressed review comments from Parav
> 
> 
> Selvin Xavier (2):
>   RDMA/core: Add helper function to retrieve driver gid context from gid
>     attr
>   RDMA/bnxt_re: Use rdma_read_gid_hw_context to retrieve HW gid index

Applied to for-next, thanks

Jason
