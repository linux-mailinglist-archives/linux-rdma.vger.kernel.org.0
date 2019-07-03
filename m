Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C545EADE
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfGCRvZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Jul 2019 13:51:25 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37795 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfGCRvZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Jul 2019 13:51:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so3504292qkl.4
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jul 2019 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gdhOt/hIrSLfmgAWXsyVbi19Sw1Xas9BuEFXrWM9gIY=;
        b=jWbviFEFHUHAnME0DWz7euS0Ubke5GqqRD2Zf+xes8zaNmciEGOfu9MnDY5GLFJLbV
         a1142dF2FQ1dLrmPFzh9z8Hyz3ymgzIJraQhQ2b9lI3dKSylWOC3DSY7jVWydv0UdW10
         h6iRPzh3WIToLWDHf3G8BsphacJVGjebiMKElgO8I/DrnmqgtRPuxfpyBXR6D+hRaXb8
         LpHvvz3s2Lix3LeImCoytF07Rgxo3zRGuCWfwKhEi6JqBA/34r4Da9ivaLXoD5h+xdwl
         DUUDakKGa44TXXNEu5NVAfWQb2yECwAyL7hLwYlY8srJkT1NK1QqwkAJwSvT0aoLrkQY
         3IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gdhOt/hIrSLfmgAWXsyVbi19Sw1Xas9BuEFXrWM9gIY=;
        b=rqZXNj8jCsOKEDFqkyVlKPyzvpiTWUvCyEsiEJoqdxneG6oO5mZMGXHyPNDcY/yya3
         FuJ1Bk0oQka6xLDkVmVir1xtJqjFUhBEV7k7AD8tPwsemJTzYBo/2gyj6z5S99YXyf8o
         nW8eSYfc0Gd+7E/FmVV2BClNEWxZ6rnlbN6evcuCy7aoQKE0B0Wn2OKyXDSoavkkvNlY
         gYEqwzBzuEJtazpB4jm3OXbwAVOr1Pr1Wulk+DDTT1EE9rwWGwaZoIYe9NP8xxj2Pe/s
         YBca1t3KqCrtChwxSbyvSW9XhRBPJSPD5Fdci3jG1RroL1SnR49CYyvldaOh3G4RYrFS
         eCtQ==
X-Gm-Message-State: APjAAAX5OC1b6Ijku8FKiAd2R8/XnK4xmju3Jf9P4CKjriqFkJ1TR0ew
        N6DajzscBOxbMiAAD9pWuUljVQ==
X-Google-Smtp-Source: APXvYqxSKGXFMaAmfS+6KeFHSjZUQgKurTa4hZyT3TCghwzVdE6oI0KH3iNa0bybuWE92qp1y/grjw==
X-Received: by 2002:a37:490c:: with SMTP id w12mr31696472qka.327.1562176284316;
        Wed, 03 Jul 2019 10:51:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u18sm1162143qkj.98.2019.07.03.10.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 10:51:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hijPf-0005lI-D0; Wed, 03 Jul 2019 14:51:23 -0300
Date:   Wed, 3 Jul 2019 14:51:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Liu, Changcheng" <changcheng.liu@intel.com>
Cc:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/i40iw: set queue pair state when being queried
Message-ID: <20190703175123.GA22089@ziepe.ca>
References: <20190628061613.GA17802@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628061613.GA17802@jerryopenix>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 28, 2019 at 02:16:13PM +0800, Liu, Changcheng wrote:
> 1. queue pair state should be clear when querying RDMA/i40iw state.
> attr is allocated from kmalloc with unclear value. resp.qp_state
> isn't clear if attr->qp_state isn't set.
> 2. attr->qp_state should be set to be iwqp->ibqp_state.
> 3. attr->cur_qp_state should be set to be attr->qp_state when querying
> queue pair state.
> 
> Signed-off-by: Changcheng Liu <changcheng.liu@aliyun.com>

Applied to for-next, with a reworded commit message:

    RDMA/i40iw: Set queue pair state when being queried
    
    The API for ib_query_qp requires the driver to set qp_state and
    cur_qp_state on return, add the missing sets.
    
    Fixes: d37498417947 ("i40iw: add files for iwarp interface")
    Signed-off-by: Changcheng Liu <changcheng.liu@aliyun.com>
    Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Thanks,
Jason
