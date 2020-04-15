Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8BA1A8FCA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 02:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407876AbgDOAl5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 20:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733064AbgDOAlz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 20:41:55 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2029C061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 17:41:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x66so15508075qkd.9
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 17:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eo385VfZcGAz7coUgjGWNzMa0vEHywn06GjdqDem0NY=;
        b=YGLvHs8pYWq8xOGZpyM0F/OH7orZNDtMeXefo+v908z8GZXUl9dNS4lKl7OFo8zXT6
         56UQaKdOOLmPU1+bEqyUUwXvt2I8QZmkBxTxjCiADlGQiexX1PhXEXmznGHWpAcBYBzn
         eJTbupadIfCG6uO1W4gwhw+cFI4E+GkhKuy1hX2YPzWiE1yT5LvCmAxmEDB/c6fMRe5c
         X7qhcNqHtrvMqGrszYAVba23f3CmjLK1bXbK59NJWUiVl9xKOn+5pPXCjh+z43zwSzCh
         egHZEDvxawIXzZ8kF5KJ3PudFm1XdnyG9vh2rEHV2QduEO2moRoMRoyUlo0qj5xt6baZ
         +LEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eo385VfZcGAz7coUgjGWNzMa0vEHywn06GjdqDem0NY=;
        b=UKnf8376UvU6nL9Dtlp2GhrhQvoAnEr5S/hMJSYIPWl1ZEbDdBFKG9ogjccbxH1LIU
         vBwY6keYCQvf+nWHgCBIqp6wI7cWbasOexiieIoP90HziZ142jRXtMK/nSPzJHRo7C8c
         zlTvlfOc3dFkb0Rm9TaWgNETOmXsVl90Cfgct6OWGNkGK7586ZqY7fcYejnEhvRcBbqU
         OZX9hhsg51wCCAqC19Fr+1Jwdz5YigXlbXy6xGruNPL5yrikSUvWLRNY3CPq+fIVBZty
         fQpS6bN79lrSczaXbb70myKlm+wAx8Zmugjjp0GLiKI5B2kqiWShwdPQeKxQZ5uVQS4f
         TrEQ==
X-Gm-Message-State: AGi0PuaHfQmaMVuJyJCC9XhIHRCwaKb/+FAitT0f6ZxOa0+bfHD4vE47
        ttONkMQeCQb8Q/xVSecaGQEPAw==
X-Google-Smtp-Source: APiQypLglDzqCDqMLVb5A1TB1kZOz4RvLejsXTssywOz6b9TW05QtDw6BdZK2lmpxbPssI8Holb0uA==
X-Received: by 2002:a05:620a:1259:: with SMTP id a25mr12781217qkl.323.1586911314698;
        Tue, 14 Apr 2020 17:41:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p22sm2068507qte.2.2020.04.14.17.41.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 17:41:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOW7l-0006br-Lu; Tue, 14 Apr 2020 21:41:53 -0300
Date:   Tue, 14 Apr 2020 21:41:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Alaa Hleihel <alaa@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Roland Dreier <roland@purestorage.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx4: Initialize ib_spec on the stack
Message-ID: <20200415004153.GA25366@ziepe.ca>
References: <20200413132235.930642-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413132235.930642-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 04:22:35PM +0300, Leon Romanovsky wrote:
> From: Alaa Hleihel <alaa@mellanox.com>
> 
> Initialize ib_spec on the stack before using it, otherwise we will
> have garbage values that will break creating default rules with
> invalid parsing error.
> 
> Fixes: a37a1a428431 ("IB/mlx4: Add mechanism to support flow steering over IB links")
> Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx4/main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
