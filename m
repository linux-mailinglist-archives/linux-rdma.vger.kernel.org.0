Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A20B05EAB6
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 19:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGCRno (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 13:43:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43531 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCRnn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 13:43:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so1523308qto.10
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2019 10:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3R+cKk5Bmbmyzc5dQ/tTgoBX/k8q0Z5+azXiai77pjc=;
        b=j7C2OoIUgJZa7qnNyv2k/ythC2rLCDPyTyyuMZ7CDUqmdsX6uya0A5WKIiPniaK1rY
         LaehkAlLmDgC+BrBaOr7ae8FFyYYSiyJe3SXxSgCXXtUfJzoOfPly2uNzqhWjmjKiCBY
         AFanQHhW+HlDdjs4oNpawP5AJLVf5TlbUS8N2Pw9pg6UnSX97Ghic/QUX5IzUehfA/Qt
         aBnhgeAu5dnCxTmytLWsm9VFbftOmElIRDXX7niiSc4OzlGT8pp5MoFdJa9TUijmEqKT
         eJYQ4M/oSFEa+Cp5jzbh64MGl+uP3VADUtzOmLhADMoaea0Ge9GBVT0S4laHS7axJLSK
         MhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3R+cKk5Bmbmyzc5dQ/tTgoBX/k8q0Z5+azXiai77pjc=;
        b=i2lre1QOyG5LosReUPRIXEK64pW/xV+wVpJPzwd69hBMTnrRN5e0EFdblO/3/zQyHD
         7txJAAH/sHuB3CJTLFalFIxB9Ll+y/RBoFdmwx8V3huuvbztj6vVZx+t08Z67hrLDtxo
         BsAmAGrkkkkiDUSHdgrvLxEkYd5kQ/bXEJUonkp/56i7i9jenV0njCYjEUr2LXjaZqUv
         qhemGIrPtNQzPDbzqLA74+8KTRJlfduIQv9wSnPFX68SWfUt0jr6mHtM16DcAPIHBD7W
         k/O1TNjaROgLN9EKUrJ5zt1q3kjyhxMT7ABBZf/5FadvgqrZGJDD5YbhzraJWsQ4B2Vd
         Faww==
X-Gm-Message-State: APjAAAWjib5q5uKdzns2h5c+0Hc85/Tpbqf9In4UugduTmhLVnIxsl12
        WXC9HXqvd+XtxmlmvJxVGQ0p2Q==
X-Google-Smtp-Source: APXvYqynKl5gRRZpXN6Qt0luanwwol4WD/SOZhlMZjF1iSxGoH6ma5AkdbLOxCscs3327MF8mOJBZw==
X-Received: by 2002:aed:254c:: with SMTP id w12mr32978990qtc.127.1562175822996;
        Wed, 03 Jul 2019 10:43:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t67sm1206056qkf.34.2019.07.03.10.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 10:43:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hijID-0003sm-RD; Wed, 03 Jul 2019 14:43:41 -0300
Date:   Wed, 3 Jul 2019 14:43:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/35] infiniband: Use kmemdup rather than duplicating
 its implementation
Message-ID: <20190703174341.GA14899@ziepe.ca>
References: <20190703162742.32276-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703162742.32276-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 04, 2019 at 12:27:42AM +0800, Fuqian Huang wrote:
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v2:
>   - Fix a typo in commit message (memset -> memcpy)
> 
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to rdma for-next

Thanks,
Jason
