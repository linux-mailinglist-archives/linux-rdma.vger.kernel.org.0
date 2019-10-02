Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4466BC8AB0
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfJBOQD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 10:16:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37835 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJBOQD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 10:16:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so15146385qkd.4
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2019 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gdaOd7YDxE1Cx3MM7w14SPPortS4uXYEDsnBG+WIPcY=;
        b=I/WjrVVD5UCzP3Pqh2ZlVY/v0VKskkK573WmF9vI4tVV7eUqyLWkx+CVLFSVsBdBBi
         EQq0pGdof//tyU5PNvPlVnsRkgvD0Bx02BoK1r2VfGDjuQ8y0FTb7EnlIIyMEzpsROfK
         a35HXD/hormGTnLijkEiyESQXSa5P8R7A9SMHvARU5GKs0jfymUxdEg7tM6wqvFIRFG4
         oqnYWaDmqnQZok9hLtnsuNKF6y7rwa2fGv7N4Wc5fs9Nk6j7QmJLpUvheb3t8iJPu5/h
         j2GYyHndWT4GQom5JYncXYM2GzOBMZWQkUewb3TVNfH4kEIOoWeKUGG6M1/dXaIPslF7
         IrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gdaOd7YDxE1Cx3MM7w14SPPortS4uXYEDsnBG+WIPcY=;
        b=t9y9R73Fis6b8JV+eXByQq/HSpJyLYxixOY0S4e/n2RmpxXBveUK/7L6vqHs5cYguq
         LWR/qkex/K/4gHkgt1EkbfKyBkDtoyytnAYoyz96+y3Zi4n0nsqFjmQlDurwlWs27otm
         tjPdVXxHNXFqpqQRfyr+zh4uwxZcC0+9ftARynX7EGCQ4aYmOJRMdpxzMCM7SSTqG2xC
         DczuEdWyhVNArlNv/xoRm7qXkwvR5k314wJfNqct5OZ7LWPlj96n14pAj52s81Z1FgaX
         xd0ZhyzhsWxNHD0WTJ2XmqZEmgFQ1D31UThmYcJLEOepkzLK8saiJ4RdWENs6etFWZpi
         7rdg==
X-Gm-Message-State: APjAAAUs2BAginGFQerH9o0ITM0CZiaH9tPzZRATUtL3UtFd6syQ6s+Y
        VcT9yxhYmmLQpZJBUedKNJQRlQ==
X-Google-Smtp-Source: APXvYqyBf8oCmgGOI/W8iM0msACgKdnBztz4LSRGrLq9oX5VmMqHkvcEMQop7olFwGhUMrWSwsdBYQ==
X-Received: by 2002:a37:a9d1:: with SMTP id s200mr3903777qke.251.1570025762020;
        Wed, 02 Oct 2019 07:16:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id z46sm12043472qth.62.2019.10.02.07.16.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 07:16:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFfQ8-0006fh-SN; Wed, 02 Oct 2019 11:16:00 -0300
Date:   Wed, 2 Oct 2019 11:16:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH 10/15] RDMA/srpt: Fix handling of iWARP logins
Message-ID: <20191002141600.GB17152@ziepe.ca>
References: <20190930231707.48259-1-bvanassche@acm.org>
 <20190930231707.48259-11-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930231707.48259-11-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 30, 2019 at 04:17:02PM -0700, Bart Van Assche wrote:
> The path_rec pointer is NULL set for IB and RoCE logins but not for iWARP
> logins. Hence check the path_rec pointer before dereferencing it.

Did you mean it is null set for iWARP logins? I would expect iwarp to
not have a pkey..

Jason
