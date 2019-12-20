Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11876127BC8
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 14:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfLTNft (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 08:35:49 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34157 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfLTNfs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 08:35:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id 5so8209101qtz.1
        for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2019 05:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QVNOXiGKgcBgMmMlzoR4ooNZNWnMDq3Y/3uiKqkZYh4=;
        b=m31Z6t8jW/qPB1XwBqMlpizQ+VyLn0eBiWzB9UmFZ4jNdDvRQCk4dLRUULpc8nH6oc
         AXvZQHt2a+g73UH5dn0smiWaf2zHjs86dstQAJnCn57AHxU9MtPzuV1NBo2ThHJqGtW8
         g6kR/N2FkmTf6tMPZxWFQm+uBZ4oVZPttL4zBPS6d8SKcLllzxlk3xksrEAP2LgVWOZP
         HtIoO68TTiFqkC5TMRd5DnvTCVYyeC8QxZ/UiQ4byeVis7rY8eIRy04FImdSiKJs0OYV
         y1kH2qQcdNm2D7hNEgTVjkGgim2mL3ks5bvFdjZf8t3DrV4H+Ugy3ngerZcuw7U6ZprK
         M16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QVNOXiGKgcBgMmMlzoR4ooNZNWnMDq3Y/3uiKqkZYh4=;
        b=UP+N/MGc1VRnvvJjKzBM1N70ULhCPvmNK/CNjU89g0UKnfxjk87JgVJKBq5z7x7ZB2
         z46UPBqFX9UkF8EHDeUAVFsddhI1JsyiZk5CPVnkAmj3z2Mx3uQy+nYXSd09dQWN0Ys2
         2u73utY+Kkp3duLmIKkWPkBrcL5C5t8PKzcE0D8Je4UvH1vqiN6wkjepSd1XEJyf/Wd8
         JymVwainCoR7mlt5LC9UVb57xl2D2j53OnuL7e+jbUJp2SbZOLsMnWhE5YyCJBBVwrIE
         NHDqKklrUz3T5sfxoZr4RzTxgJxvvqOw8sqbdps6xNwlkrrix3MlycG31AP7jxA41CBk
         hhkA==
X-Gm-Message-State: APjAAAXUM7mO7wWmCPeA1Fzxf5hWtUHslz//Rx/lMXVAmBVgSL5bY1Dr
        7ECo9/SNZIw31PHCxM58jsmfYw==
X-Google-Smtp-Source: APXvYqxVyzei+4muXN8DBkGlKCzKr8IXxLgr8bgWhHB93i2sPzX1gq1wdmZs2n7Nvrm/s6WIxwP8hg==
X-Received: by 2002:aed:2202:: with SMTP id n2mr11973492qtc.4.1576848948070;
        Fri, 20 Dec 2019 05:35:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l17sm2828951qkk.22.2019.12.20.05.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Dec 2019 05:35:47 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iiIRX-0003eb-1p; Fri, 20 Dec 2019 09:35:47 -0400
Date:   Fri, 20 Dec 2019 09:35:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Artemy Kovalyov <artemyko@mellanox.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc 3/3] IB/core: Fix ODP with IB_ACCESS_HUGETLB
 handling
Message-ID: <20191220133547.GB13506@ziepe.ca>
References: <20191219134646.413164-1-leon@kernel.org>
 <20191219134646.413164-4-leon@kernel.org>
 <20191219183237.GJ17227@ziepe.ca>
 <AM6PR0502MB3638228D4DD3E713A5AE8951B72D0@AM6PR0502MB3638.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR0502MB3638228D4DD3E713A5AE8951B72D0@AM6PR0502MB3638.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 20, 2019 at 04:51:00AM +0000, Artemy Kovalyov wrote:

> AK: checking for linear contiguity may be not enough, page may be
> transparent huge page, so in addition we also ensure its indeed
> persistent.

??

I don't understand how it makes a difference. If the physical is
linear we don't care if it is THP or just a lucky list of 4k pages?

Jason
