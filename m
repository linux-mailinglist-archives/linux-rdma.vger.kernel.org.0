Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F7A1371E5
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 16:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgAJPzN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 10:55:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36355 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgAJPzN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jan 2020 10:55:13 -0500
Received: by mail-qk1-f193.google.com with SMTP id a203so2268524qkc.3
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2020 07:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bBpSgUDf6SCLgpVJUSQKMgX9USRLi1nkJrP/79ip1H0=;
        b=oH+7OBe3wW6C6uVcOLyUkPM/roa7vVS5rvHcoTKYZGfsFrJJh3qnudozMid4V6TQ6n
         2ZM3HBMd3ExkEiRzDseSXlEthSjSQXxjIoHxEHCgziH7SLyx9Um/bXBGaCjfzGIGyhOs
         YLvCbGuQtGh0UJXosJQQBWQe64dwQ0VHLiOtO1RyvmmSDWCqUL5rsNxIbFX/p6foZcrY
         HqFwW2hHwopPOy6ihJFZmYqNjPCaSwnvN58Bt4JEAtg9VH5+GOCzK6tQs66gzSt/82Q5
         7Me4lxWfWtE9eFRU4il1X3L4yA32/P9c/NKmJmKWXxwGn2NCc2lzNYdx2X2sLLtd6XKY
         9wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bBpSgUDf6SCLgpVJUSQKMgX9USRLi1nkJrP/79ip1H0=;
        b=rdyQfFDA+hwHMTEW5VAtfFaXIm+eA6Hj4yvOOVqDJWAFXzqGVJTKb/iem62ujSQOHX
         FakPbBDI1oyJ/jnVpGXVDmhJGBcdg2nSH9Z6aQTNdUdXy7t1R2i8kT1+JexrRr49OJp1
         0DX4pht4cC1cV0m3Loi5iuaI8ehStd4H3M7WdxMnIe/zWjAqVYyBWAOpjoeOW0LvCqfk
         aC818X2TLm9qlUi5Ugeoud9eSeekeLp0owTx5PCRVGtEucJHHp+AnSRvGjmq45vIGhV1
         uFclRiE+2iamqZ7AnKAlzoVLS48uwVcqW8DLi61Vphj1hC0qFyQ4oVvPuwyjEW9+V8dI
         Vc7A==
X-Gm-Message-State: APjAAAWPt+IDSWnOtMt3hVCnlZTyZ5tesBStDeCOClMRtRtrRAGbhvc9
        aHXpJHFGETdD22LSPH+VbjLQpg==
X-Google-Smtp-Source: APXvYqwLI2CrZp1hV9cMgl99Yr603jSoRfZY02X9/NLwcTCjNRGLltcrrOibdmoHUVsihdKkHKeNkQ==
X-Received: by 2002:a37:496:: with SMTP id 144mr3816438qke.338.1578671712434;
        Fri, 10 Jan 2020 07:55:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k62sm1018309qkc.95.2020.01.10.07.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 07:55:11 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ipwcx-0004m7-G2; Fri, 10 Jan 2020 11:55:11 -0400
Date:   Fri, 10 Jan 2020 11:55:11 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     jgq516@gmail.com, dledford@redhat.com,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH] RDMA/core: avoid potential memory leak in
 add_one_compat_dev
Message-ID: <20200110155511.GD8765@ziepe.ca>
References: <20200110153250.11898-1-guoqing.jiang@cloud.ionos.com>
 <0c67a2ec-9291-85c1-ba37-2b90849df314@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c67a2ec-9291-85c1-ba37-2b90849df314@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 10, 2020 at 04:34:08PM +0100, Guoqing Jiang wrote:
> Forget to cc list, sorry.
> 
> On 1/10/20 4:32 PM, jgq516@gmail.com wrote:
> > From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > 
> > In add_one_compat_dev, if failure happens after cdev is allocated,
> > so we need to free the memory accordingly.
> > 
> > Fixes: 4e0f7b9070726 ("RDMA/core: Implement compat device/sysfs tree in net namespace")
> > Cc: Parav Pandit <parav@mellanox.com>
> > Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > Hi,
> > 
> > When reading the code, it looks no place to free cdev under those err condition.
> > And I guess remove_one_compat_dev needs to free cdev as well, something like:
> > 
> > @@ -937,6 +937,8 @@ static void remove_one_compat_dev(struct ib_device *device, u32 id)
> >                  ib_free_port_attrs(cdev);
> >                  device_del(&cdev->dev);
> >                  put_device(&cdev->dev);
> > +               kfree(cdev);
> > +               cdev = NULL;
> >          }
> >   }
> > 
> > But since I am not know well about the code, so this is RFC.

put_device triggers compatdev_release which does the free

Jason
