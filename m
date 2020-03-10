Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86E91802B5
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 17:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCJQCi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 12:02:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40111 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJQCi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Mar 2020 12:02:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id n5so6405026qtv.7
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2020 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CnMm2B93D+mhe3hSvcwEBUN4EabNEvqLf2du/44GW9A=;
        b=Yj1AzMYWnQv9I3x+2C0QMzYCTBzlO22gnk3l23+eURm7ZFUepvKIp/PX4HuavLB1ym
         +Snl3wNLFHZwCnclNMyqR7U2FBfBmz0KoVM9DN+SBUarQLpkEoPcEPzI3ls+QE2fKmxD
         QRklkig2MRDFMO89PB8PblsgV7x6GaXRqAmpqMKRPQXggm9TgIqmVYDBetUGYnZScNoi
         yG95yc/QQJ2EorF7i89DUkmDR/U2hNwOhWrP+W9F13zFGvGtrrT4eA/DPR4xzHCEKAKU
         Hh2kYHRqYUf1VT4MgCQ1IEqe5yuNcwsG9H2ZqDQpU4bLB/E/giA7suM2+kbcDsgEU46l
         zrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CnMm2B93D+mhe3hSvcwEBUN4EabNEvqLf2du/44GW9A=;
        b=UVoiirpAIoyrnJDtsQFcbyt/vqp1COLrxlSRlLqqIM/XMdqpktjAsjq0KamM9GVlj/
         OY54P/znfU9tplU4Idog/sXjNi/wybHjKfd2lZWy164KmauuWqpXrlu+HOdJJ+5qnvCj
         DgzrVD2DH1Gvsp1byycHnh/kWJbXSVUkKy9Ol90OpCzM/iZDg82JwNBInYcANAEt9zVZ
         pSiXqgWOKs+L2oROZk0uB1DSDtDgAZgXdoLkZraPcMpjnAZehqThD4PV1WLv0O65TYn7
         vBVJjXM2rMnTdQMAAsP/XfRexdhfQqZ9TeGkdmB6JwyFLepTZNTc0+cg3f6hJ8X+hXhe
         UQnw==
X-Gm-Message-State: ANhLgQ1XGOLSa2fYFOPzLPTmJ5ia3jk5wn+1NjzfUozNg1oqT5Ar7cr3
        WEixOQDneBTDznyI2iw5t1+7iQ==
X-Google-Smtp-Source: ADFU+vtI2j5Ot8t8+P1dsigedHe+a9Ixi5+wSZEmcnYHV7AYb/GVCOldAnCoxGQopeJ1SNtghFcWNg==
X-Received: by 2002:ac8:5485:: with SMTP id h5mr19262305qtq.56.1583856156766;
        Tue, 10 Mar 2020 09:02:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id z18sm61721qtz.77.2020.03.10.09.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 09:02:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBhL1-0008Qd-Fo; Tue, 10 Mar 2020 13:02:35 -0300
Date:   Tue, 10 Mar 2020 13:02:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, israelr@mellanox.com,
        logang@deltatee.com
Subject: Re: [PATCH v2 2/2] RDMA/rw: map P2P memory correctly for signature
 operations
Message-ID: <20200310160235.GA32335@ziepe.ca>
References: <20200220100819.41860-1-maxg@mellanox.com>
 <20200220100819.41860-2-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220100819.41860-2-maxg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 20, 2020 at 12:08:19PM +0200, Max Gurtovoy wrote:
> Since RDMA rw API support operations with P2P memory sg list, make sure
> to map/unmap the scatter list for signature operation correctly.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/infiniband/core/rw.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied to for-next

Thanks,
Jason
