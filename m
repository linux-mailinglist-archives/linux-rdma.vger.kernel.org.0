Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FF81BE1E7
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2020 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgD2PBq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Apr 2020 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgD2PBq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Apr 2020 11:01:46 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DABC03C1AE
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 08:01:45 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id h124so2222234qke.11
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2020 08:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f920QRE5gz957Dg6YScbJ4EIs4w7vSsipmkT/Y9gXGA=;
        b=LtnbleUL4kSUA3p5MEvvVKhLUh99ANiJxPrS6XRcQnot7zoHneHOxg+M5RHBkzDO2a
         pk4SUPoT8OIwvNkskgV5mlOABJZpCqc2TTocIbaIiDbdQ8iIwSx/GJyjiySH5eb5fUJP
         iJDfIhBfuXkpTOvFoZrnC93FOAidogi+HxWCSGm4i6pJMHfX6zsjYouiZKSCbAO4xHkU
         95HHX349fwRUjhepmz/qwkTM1qHDpBWNhj/rHnoUCNKGJ/tADpKi4vfFwx8mAXH9kaJp
         +/7D2OCM5HVQ5iFNobMMesXZjQmLHdYcIvXGGsiSyKol+Lu/nsMcsAj/kSlw6Pw2t22C
         RZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f920QRE5gz957Dg6YScbJ4EIs4w7vSsipmkT/Y9gXGA=;
        b=B09EtoLs/xdHNR3nTERj4OzMEBjyErx/J+9QX/kX951tfU3/VXIFFrpZjkaXeNIY1x
         o3g7/INEWWCUBmkNdahmdjuOZaHL8ZEdX1USgIpCjEBYIytsj5YPphXVl+odf6bxfnl1
         zIAaq9hWcvkYiHxsMf+46mqgaJwcXm+WRPW6SVw4ZKM6N4MMw01uT2PgIpKgWsMY6/cr
         cInSDsHaCDKumKIsZSbSw8c3tEdshwSzcF/UbjOe/5MptJvn6dbSqW7tln6F+/alA+ko
         OwCtQ3DlkCViQeqSf0LMoVZVNehanboim2xMybnt/gut988nh6lE8nv0pBT5DMFbMASm
         +s3w==
X-Gm-Message-State: AGi0PubZCkFu8X+J1ft6SDrHd4p3Xr2MMY2aGqJknQPyA7+FyWfsfueZ
        2Tcnz9UCI6/2uutC8ZVqQLnh6w==
X-Google-Smtp-Source: APiQypKsU22FpXMqa+sWplMBvTTaL6Gl45tUrzqJXZDBiIcc4C2tOom+pXU6c8GBc5tErGio/YcfBg==
X-Received: by 2002:ae9:ef85:: with SMTP id d127mr16079284qkg.385.1588172505162;
        Wed, 29 Apr 2020 08:01:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t13sm15678201qkt.62.2020.04.29.08.01.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 08:01:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jToDX-0005uE-Ja; Wed, 29 Apr 2020 12:01:43 -0300
Date:   Wed, 29 Apr 2020 12:01:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Maor Gottlieb <maorg@mellanox.com>
Cc:     davem@davemloft.net, dledford@redhat.com, j.vosburgh@gmail.com,
        vfalico@gmail.com, andy@greyhouse.net, kuba@kernel.org,
        jiri@mellanox.com, dsahern@kernel.org, leonro@mellanox.com,
        saeedm@mellanox.com, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, alexr@mellanox.com
Subject: Re: [PATCH V6 mlx5-next 11/16] RDMA/core: Add LAG functionality
Message-ID: <20200429150143.GC26002@ziepe.ca>
References: <20200426071717.17088-1-maorg@mellanox.com>
 <20200426071717.17088-12-maorg@mellanox.com>
 <20200428231525.GY13640@mellanox.com>
 <20200428233009.GA31451@mellanox.com>
 <a7503b0d-68e7-3589-33fc-cf9b516d71b7@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7503b0d-68e7-3589-33fc-cf9b516d71b7@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 29, 2020 at 12:01:07PM +0300, Maor Gottlieb wrote:
> 
> On 4/29/2020 2:30 AM, Jason Gunthorpe wrote:
> > On Tue, Apr 28, 2020 at 08:15:25PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Apr 26, 2020 at 10:17:12AM +0300, Maor Gottlieb wrote:
> > > > +int rdma_lag_get_ah_roce_slave(struct ib_device *device,
> > > > +			       struct rdma_ah_attr *ah_attr,
> > > > +			       struct net_device **xmit_slave)
> > > Please do not use ** and also return int. The function should return
> > > net_device directly and use ERR_PTR()
> 
> How about return NULL in failure as well (will add debug print)? Not fail
> the flow if we didn't succeed to get the slave, let the lower driver to do
> it if it would like to.

A NULL return indicating success but 'not found' is fine.

Jason
