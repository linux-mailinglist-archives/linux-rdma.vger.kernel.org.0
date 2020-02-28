Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D01B173CA3
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 17:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgB1QPS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 11:15:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45966 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1QPR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Feb 2020 11:15:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id z12so3403119qkg.12
        for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2020 08:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nJBUftED9YY3y1F7NV3WE2EwRb6J3cG9/jaIXIBEHuE=;
        b=AXsaBIPEhGrFLGfrcrmoxBsnPE9R9xmWGKCgl1YoEVvQlsbuR5OdupU/nrKVTmCdKH
         FUU3LtZqbc+QSlXAzE/KV2Cf90M/IabADFaBD9s2BfzFefwtd6cEosZT+iDqlXn5Ro9v
         +l5ju0Lo+Ky290jiZaMfv7KVITcRrwFpqCdUr0PM9rsk/SK6fJrQGA07Nrr2c1o6ccT9
         5J6FkUF8VfFWCGN7OxOY1lulJ6noVLYz/tNrxJVerEDuAtJBTZB05kAXq6Gn4clgCu12
         3Yi3VE7Nwkpy1pYFpgxWZHgV9/jVYf3tB1s1SKrCeb4pLsIMKQ17Fz9d8lBxVKZKd6GM
         ZmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nJBUftED9YY3y1F7NV3WE2EwRb6J3cG9/jaIXIBEHuE=;
        b=YPU/2adrDBjMh3COY0bemAa/EnSmBeRgEVMaGIR5FYZprxSUD4lllWx74jOomGoXPf
         a0gMBGH6klNWtOdOVYuA6dP/knvM0MKfijUyR6EPoWjd5rvSXHW6E9Qk3/xBMOyBBSiO
         395wnnlUua04X3vWTm0GSl47qgqG5PQfubUv16aiQiQfseeIs/LGKO/tOe6Xc3R7TZrR
         aImKTh104FNYmRaCvdzZ76qXnVr+NunguXO1wBif7FHKg1PjG6Sy3GnU+A6kNOwlJ2hH
         eQ6iKl1koPj4vbRZcYOwKoiir8NXSFqHOfBDF4s1NTXBJfr831AufVPE5SWT6dbzEToS
         j9Uw==
X-Gm-Message-State: APjAAAWKZAKMiGgexwZD71DY2RWpoMga5U3Hx8RVhe+no06Ifi1kecp/
        6b/QHvkvpmGHKEvAWTNUz2XWtDZaFIIYTg==
X-Google-Smtp-Source: APXvYqzGmdgF12pxqW6IVwoMI8B4dzLU0oIs6F6rpdoec5Ub0C29jw31jw97HDYwEeHGud3zyQI5jQ==
X-Received: by 2002:a05:620a:4e1:: with SMTP id b1mr5182531qkh.222.1582906516928;
        Fri, 28 Feb 2020 08:15:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v10sm5132433qtp.22.2020.02.28.08.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 08:15:16 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7iIG-0006uc-2c; Fri, 28 Feb 2020 12:15:16 -0400
Date:   Fri, 28 Feb 2020 12:15:16 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH for-rc] IB/hfi1, qib: Ensure RCU is locked when accessing
 list
Message-ID: <20200228161516.GA26535@ziepe.ca>
References: <20200225195445.140896.41873.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225195445.140896.41873.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 25, 2020 at 02:54:45PM -0500, Dennis Dalessandro wrote:
> The packet handling function, specifically the iteration of the qp list
> for mad packet processing misses locking RCU before running through the
> list. Not only is this incorrect, but the list_for_each_entry_rcu() call
> can not be called with a conditional check for lock dependency. Remedy
> this by invoking the rcu lock and unlock around the critical section.
> 
> This brings MAD packet processing in line with what is done for non-MAD
> packets.
> 
> Cc: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/verbs.c    |    4 +++-
>  drivers/infiniband/hw/qib/qib_verbs.c |    2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
