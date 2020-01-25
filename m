Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E200E14974C
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jan 2020 19:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgAYSwU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jan 2020 13:52:20 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44009 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAYSwU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jan 2020 13:52:20 -0500
Received: by mail-yb1-f193.google.com with SMTP id k15so2790567ybd.10
        for <linux-rdma@vger.kernel.org>; Sat, 25 Jan 2020 10:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UTbeiQ/ySpyi4ZP2zQa5gaStGWMwxNAEJcO3synylw4=;
        b=DiG6s+qsxNJlhcB+xEHwHoO8Vh816I/psT+tLIBYMzSYKJNNxIO0rOCmY0ofhSVkUL
         Afad9+62pUKuVgZOjQqddxgynM7ozuwuuc0EU000p6xK4taEdaOwx9toJDW5X3VcMPfU
         8WKfqc04pNHSH31mF7ZPNnIMtEppI4uMzd12kKq09otEtd1TtQRgpcCp9K3xbLxZzfrX
         xI9YQEp/5+IfoGoJWy56VMaVKDgdWgtrFAcU8EryH75Pg183DhEMFU/ARtZmVqABTR9D
         iq6w7INGE94pCcfZZqMbf1rl/M8F23PQDAYR9dm1vK24khFmBSIkekzY9WDLo3VlGUXW
         nAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UTbeiQ/ySpyi4ZP2zQa5gaStGWMwxNAEJcO3synylw4=;
        b=JrgLdYFUKiGqYrHgG8nsS4+J7WLLV+kbg6lOCCnchVLjBdrSTkvCKv88Umge4mh2uz
         8oZPQ9oYUWtA5IFzeXDdHikW1rJJCqugDACEBdjdvVtAFyf/ArdD8hBziCAwpWKAFRpH
         X+gotHFbevXaqPYFTwEin7Ij44weXH3/ugAGUxw3Y0nhBILy3sN/9p/zX43QnXnrl9R+
         L5AnOLE+enERHTs++IijzqwCUnARu3vEkgjtzVcLMD3VCOwFXEd4/n6MwAVOtCOA/k8k
         Q8+GXBXHdYNNAiQq+mhAofpBHL48EVrw96Y7251ndsX7mGaHACYgLlzmg26SZ+Zz5U+s
         qNsQ==
X-Gm-Message-State: APjAAAXPQDa41QjsLH2+dz7JC2LwNeGbLJbziSg22OPOK+OANSZJYyuo
        a/IDbgE/M060b+swoVxoyaz+FA==
X-Google-Smtp-Source: APXvYqxG2mYk1FKXAxH4EqTpywFIoSBIBzbZjIKtHStio+0vojIafihrsvK+8L6g/1K+67uJO0j/kA==
X-Received: by 2002:a25:442:: with SMTP id 63mr7095492ybe.507.1579978339094;
        Sat, 25 Jan 2020 10:52:19 -0800 (PST)
Received: from ziepe.ca ([199.167.24.140])
        by smtp.gmail.com with ESMTPSA id p126sm4175174ywe.12.2020.01.25.10.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Jan 2020 10:52:18 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ivQXW-00041p-NC; Sat, 25 Jan 2020 14:52:14 -0400
Date:   Sat, 25 Jan 2020 14:52:14 -0400
From:   Jason <jgg@ziepe.ca>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Gal Pressman <galpress@amazon.com>
Subject: Re: [PATCH] RDMA/core: Ensure that rdma_user_mmap_entry_remove() is
 a fence
Message-ID: <20200125185214.GA15456@jggl>
References: <20200115202041.GA17199@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200115202041.GA17199@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 15, 2020 at 08:20:44PM +0000, Jason Gunthorpe wrote:
> The set of entry->driver_removed is missing locking, protect it with
> xa_lock() which is held by the only reader.
> 
> Otherwise readers may continue to see driver_removed = false after
> rdma_user_mmap_entry_remove() returns and may continue to try and
> establish new mmaps.
> 
> Fixes: 3411f9f01b76 ("RDMA/core: Create mmap database and cookie helper functions")
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: Gal Pressman <galpress@amazon.com>
> Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
> ---
>  drivers/infiniband/core/ib_core_uverbs.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next

Jason
