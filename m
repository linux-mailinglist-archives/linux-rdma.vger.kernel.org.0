Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2B184C2D
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 14:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbfHGM7o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 08:59:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41930 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbfHGM7o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 08:59:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id d10so922712qko.8
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dzgoky5Zev+Q1N9hll80WSgidandNp3vygGJN2vBaUE=;
        b=JhpZY+WuGa3wWaHH0RtDzN/ip6wkXi2gCQ2mpvwrESrkORN4zJAS0nakwH28P0HAsK
         dDj7BUjTEeYs57mAHx7tSGQm1rNDjbVcA8PFT4m4Lk46fTPmIoMBrenWuyhuQEsnH0VO
         wFkjsmbXTRmaJucYnHx72Hl5JptaUNz9osm6va92tuNEt3Rmom5GfDlNm5C/Ppuixb0H
         U+Os9WNPd2As7jwaxjRY597+EDFCzWvuJCUMWdyPbSXfts1MyLh1MNyTbW2t38SqAsWz
         OAAFUqZQnn9DJ6j8fMiNLhGsdeytM0wKyizvSj4XYwaUTSpQQKST5XeTIDJdzkDHKSXY
         +emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dzgoky5Zev+Q1N9hll80WSgidandNp3vygGJN2vBaUE=;
        b=t8zCY69TwLwSItyeqOLs2XCgJBu0Rx1b6t9JDMLCjLt41gKBp2xNsP7eLslAdAdEFS
         RP3MOMJKXGltoiB+m14+2I5lSZXY/OxaNtHx1wKkpX4r9TBTOwXBELpoGaKRLCvTnBFf
         l1U1G8c5rC6eJhvnShvJ634TMQQTBhAJ6L5c4q6pgEMzXE6eE3MF+2mDLEHew0VJjfAB
         kSHjHIx7wrE4ERZjA4DX0gevOPJ5PAwpnQmRlQjd3///WlyfmSs3C/aQcxJZTbzEdUPR
         yg/2GopPcBHbi9K2H92pgwR/UxzQpCpzSYn7iF+BN7X0YKMfZXs7qio6OwxXXOA8JufR
         h7fg==
X-Gm-Message-State: APjAAAWBS8S0kni6dYEXJO6IhBUReG2gzZNEliZ4Vru385ySQzg5Z8BM
        H32pbIlBRLGAYCEyF4dp8xVQMg==
X-Google-Smtp-Source: APXvYqzx3k2qpoh40GOiJgkiPQgaLElvmesHihMQ/UQlq0C4mF3WmC0mtH2oEO2cfGA/7jDHW+zhaw==
X-Received: by 2002:a37:c408:: with SMTP id d8mr8047328qki.18.1565182783633;
        Wed, 07 Aug 2019 05:59:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u11sm37216444qkk.76.2019.08.07.05.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2019 05:59:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hvLXa-0001ck-Nc; Wed, 07 Aug 2019 09:59:42 -0300
Date:   Wed, 7 Aug 2019 09:59:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: Check the correct variable in error handling
 code
Message-ID: <20190807125942.GG1557@ziepe.ca>
References: <20190807123236.GA11452@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807123236.GA11452@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 07, 2019 at 03:32:36PM +0300, Dan Carpenter wrote:
> The code accidentally checks "event_sub" instead of "event_sub->eventfd".
> 
> Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
