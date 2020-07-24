Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A38822C526
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGXM2k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 08:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXM2k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jul 2020 08:28:40 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92CEC0619D3
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 05:28:39 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i4so9570741iov.11
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=du/BYAW28pBdeWaStSwp60K/C3aT5OK1nW91G7unHfM=;
        b=eEieiC/MzOXVBsS3ig5HFUkyHpdqFwm7Jj3Zn0fby5UWNv96qUNYCY007Mmmwbqlml
         HGtN8lj0F+P7fQ0iYLe3WdBwnoX4Kic7GPPbxlj9xwsQc1ZTnluZILlhrbQYDkt76xsG
         aF8cMjnSwsrACrb1PDl66NgqUoTR2oM+V4ewn20beb25TffeoVHvgGL7/CWOcurTsDK9
         j5oOYFkBYHOw1kDc/pxTm/yndVeyDe9e7lVzrLZlt75IlbVnk/swC6jCCkmDN4d1uiv8
         jnya2uWyuKikB1jSN4U+FGI+HsJoq2dqiWwEkPTf/dRCi2PYQ0Z9511tTb6aNxzSvYhU
         dCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=du/BYAW28pBdeWaStSwp60K/C3aT5OK1nW91G7unHfM=;
        b=jM6iAyTx6uyyXIsc904itOmjAitEzq9BXV+BGhtywSq55PkM7Whmj0StGHfio3YgIj
         nKbAm02oY7Tx38PoZbrQDOCJHN91cwc7Yjehz3IFncFbTXe9qqgae2dnhNrmfYA0UZks
         M20+7aeX5qqC20e/1fHIKoqvUWho9w5BhpBoyW5rF4P71xG7Hpd4Ms2KBPndvRc9n06s
         6E6CsAwtbyLskLO1I7B94EJRNRjImRRSvyFd3VXVzkSRutrqi8MnOGXCNdqeaUfiDXep
         GLzzN8xt7PsA8E5LH7Y0atqpacoRzFaYYNO9ooXqBbVtgydvwt+GetIdS5bl7FtKyVZH
         v5Vg==
X-Gm-Message-State: AOAM533VkbKwoo4itDdZ8KTdWMlA5J4WYigXfvwDmxldI8cWjFFA3/Hv
        BoyDEho9hnVwOB+cRP3AgwWyZA==
X-Google-Smtp-Source: ABdhPJxJDNJp31AEgtWFASJ56vlCs8hHyxQFk0iGWP0RLvHf59EaBgGOgLlcWSK9m5jT5Q01uy2pYg==
X-Received: by 2002:a05:6638:1696:: with SMTP id f22mr10388110jat.60.1595593719224;
        Fri, 24 Jul 2020 05:28:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a24sm2988114ioe.46.2020.07.24.05.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 05:28:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1jywoX-00Epxi-89; Fri, 24 Jul 2020 09:28:37 -0300
Date:   Fri, 24 Jul 2020 09:28:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        bvanassche@acm.org
Subject: Re: [PATCH 2/3] RDMA/rtrs-srv: only call put_device when it's in
 sysfs
Message-ID: <20200724122837.GN25301@ziepe.ca>
References: <20200724111508.15734-1-haris.iqbal@cloud.ionos.com>
 <20200724111508.15734-3-haris.iqbal@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724111508.15734-3-haris.iqbal@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 24, 2020 at 04:45:07PM +0530, Md Haris Iqbal wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
> 
> There are error case we will call free_srv before device kobject
> initialized, in such case we shouldn't call put_device, otherwise
> a Warning will be generated, eg:
> 
> kobject: '(null)' (000000009f5445ed): is not initialized, yet kobject_put() is being called.
> 
> So add check before call into put_device.
> 
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 0d9241f5d9e6..8a55bc559466 100644
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1373,7 +1373,10 @@ static void free_srv(struct rtrs_srv *srv)
>  	mutex_destroy(&srv->paths_mutex);
>  	mutex_destroy(&srv->paths_ev_mutex);
>  	/* last put to release the srv structure */
> -	put_device(&srv->dev);
> +	if(srv->dev.kobj.state_in_sysfs)
> +		put_device(&srv->dev);
> +	else
> +		kfree(srv);
>  }

Not like this, call device_initialize() sooner.

Jason
