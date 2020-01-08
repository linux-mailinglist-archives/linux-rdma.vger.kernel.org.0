Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDE313380E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2020 01:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgAHAfF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 19:35:05 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41855 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgAHAfE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 19:35:04 -0500
Received: by mail-qt1-f195.google.com with SMTP id k40so1372959qtk.8
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 16:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xQaPi4A3wm29hX6Q30ix8OE36wKM4FNKGrBCFPvIo9E=;
        b=RmX45NrwGmlpi4PtmS3KGouL70C87HrFXeQ6IWrxcKDY+WC11YqljqSmoY7Y3GHBZS
         wH6b+ebDoQXjKucGhpBe7SnH/z7qBk095DUkb1kG6LHdNG9mFdnlNuJS0DlrA2x3H69z
         5wsCEGc4lmqk1JDQ2pGwgDM2ObURwcdgm8SGsT7CkYvpiZGhWTmIPqcv7eBU/b0ubmNg
         caPJ6o9m2mFxA/bTJY4P2NTXucFgxPphEugFZqzuM5VXYavNpHtKARGGXxyoiZrshlbS
         51Df+4CE18gHJVPP6WevNM6d/hxOWV9fGU4wOgs094ihV51cBOL23xd+a8ndRfNNTN4H
         6CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQaPi4A3wm29hX6Q30ix8OE36wKM4FNKGrBCFPvIo9E=;
        b=rYTzTLX4w3EWEuIWy1V+SXEJ0rf2DOEkM9bDvvuql561DF2J/9d1EhqmgvIecV+XVw
         Vj/U2fqIjhqmoCoaWVU7WkScJvPFCoXlIPw7DyTpagmDnEz21QsvzkIsjuHmLbpinWVn
         5/bU6l1BIS3eHK0qmzpCn9rGWXo1Y3FwpJtqb/5YGJ2qTCrWajDk7H3yoHHMoRuHChI8
         75OUPEHlqk0vqTHuJdDwRSVCtZQv2XxQ7HLWOuo/41KwjqTXS5LpNGXDF1cFWhPH7kmL
         JXwBPD8iakT72euTLb3mkHMGrX/1H0TISNhhbP4maw9tjG1s/QkGa75FpBY6xQDy+Dc+
         CHjg==
X-Gm-Message-State: APjAAAVeWzdFfu835gNKj0cCqb/FIE504ad67Dr0oL+u1lNyFlaYCvmB
        lFhFa0TVkXV4GIoGTUnPiDzG/1C8cUA=
X-Google-Smtp-Source: APXvYqz6ScqxqaMLi0BFyqu5Lp9x7DR0+PCLWGURU3HOhj11FY0nXaweAq45sAQtObkz2VjFp8RHWw==
X-Received: by 2002:a37:354:: with SMTP id 81mr1967661qkd.276.1578443296133;
        Tue, 07 Jan 2020 16:28:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id a185sm628991qkg.68.2020.01.07.16.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 16:28:15 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iozCo-0000YR-Py; Tue, 07 Jan 2020 20:28:14 -0400
Date:   Tue, 7 Jan 2020 20:28:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-next v1 0/4] Let IB core distribute cache update
 events
Message-ID: <20200108002814.GA1937@ziepe.ca>
References: <20191212113024.336702-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212113024.336702-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 01:30:20PM +0200, Leon Romanovsky wrote:

> Parav Pandit (4):
>   IB/mlx5: Do reverse sequence during device removal
>   IB/core: Let IB core distribute cache update events
>   IB/core: Cut down single member ib_cache structure
>   IB/core: Prefix qp to event_handler_lock

I used qp_open_list_lock in the last patch, and I'm still interested
if/why globally serializing the qp handlers is required, or if that
could be rw spinlock too.

Otherwise applied to for-next

Thanks,
Jason
