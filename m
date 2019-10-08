Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1019BD00A6
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 20:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfJHSWw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 14:22:52 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44707 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfJHSWv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Oct 2019 14:22:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so17690223qkk.11
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 11:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZMKH+zj1TTHofS4ShipCYeEXRg1gvghrPdjPitGBxk=;
        b=HqF5dtRDer8TCQZy0fa1AcAtomzJt3P83kFEdPsGNGLevId/i8/cM7AYB0+f5058A9
         DyoAPLuqAfpZ3PBPA8cQXun3Xx77WE/HNX36g8iGQDL67jO0hNHYr65PQMvfdIogINt+
         fHAZwHRQcdJ0ybzId4Ay9mX+ojhiURpgFeIN1oQ8X7hNC83DNphu3LMaLAhjjc9UTrWm
         GNzdaXBcp1BR0Vinu6Er96SDrENt55OJ90ahySTMLosHcej++T4AQr9nj6+PDsm/A96x
         BvJShSY3rYfvsq8rG5nC5P9VhRdDVT3g3kvmlFPb1698AMZreYBtuLUQkFNjfU0wpL2f
         vpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZMKH+zj1TTHofS4ShipCYeEXRg1gvghrPdjPitGBxk=;
        b=FH08rVmo/ogRR7aJ2BFYBraEd5Hj4HXAsgOVok31AClOLjwTADKThIaMCfXc7RghyG
         At9CoZXyngQfovwTkKl8IZhL/RffvXTt7mWH1NV4xVEzDEG5wjZp+gyk5MkyBTjNj2Xr
         dTntE2DcOAWUCcHstJDAdKWr+mP2pana28Ix1dc3bZnSHbL08TLTGX9w+HatXRYYEYt1
         2Y7HyuZ8UCBAMznMpitKAssr+p6oEybxlSFPB8KG2m/u0VQQV0jhkm9ple6+z1oyFRuB
         SShIadwv5amMCJpUdwUP6J9L/3Q/qDBvuLttAqeWRIGrGvyD7J8ShMUL/86H6wnuygat
         jLzw==
X-Gm-Message-State: APjAAAULucZNPifhgqr2d1B/zjKYk6Z+j3kcNd2/aTC4MBQigPa5kMA6
        9V8QuWxsz/5xkW5+8G/fkUevExBcQP0=
X-Google-Smtp-Source: APXvYqxbzL6h3ysYH/aCW71TBxRzrcnO2Sq5XszSVs7H6Gg5GcIvs/hqB616NyyUQ/dK9fdq2Z8u4Q==
X-Received: by 2002:a37:7d01:: with SMTP id y1mr17156708qkc.482.1570558970938;
        Tue, 08 Oct 2019 11:22:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id e13sm8306708qkm.110.2019.10.08.11.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 11:22:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iHu8H-0002uo-1H; Tue, 08 Oct 2019 15:22:49 -0300
Date:   Tue, 8 Oct 2019 15:22:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Honggang LI <honli@redhat.com>
Cc:     bvanassche@acm.org, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [patch v5 1/2] RDMA/srp: Add parse function for maximum
 initiator to target IU size
Message-ID: <20191008182249.GA11170@ziepe.ca>
References: <20190927174352.7800-1-honli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927174352.7800-1-honli@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 28, 2019 at 01:43:51AM +0800, Honggang LI wrote:
> From: Honggang Li <honli@redhat.com>
> 
> According to SRP specifications 'srp-r16a' and 'srp2r06',
> IOControllerProfile attributes for SRP target port include
> the maximum initiator to target IU size.
> 
> SRP connection daemons, such as srp_daemon, can get the value
> from subnet manager. The SRP connection daemon can pass this
> value to kernel.
> 
> This patch add parse function for it.
> 
> Upstream commit [1] enables the kernel parameter, 'use_imm_data',
> by default. [1] also use (8 * 1024) as the default value for
> kernel parameter 'max_imm_data'. With those default values, the
> maximum initiator to target IU size will be 8260.
> 
> In case the SRPT modules, which include the in-tree 'ib_srpt.ko'
> module, do not support SRP-2 'immediate data' feature, the default
> maximum initiator to target IU size is significantly smaller than
> 8260. For 'ib_srpt.ko' module, which built from source before
> [2], the default maximum initiator to target IU is 2116.
> 
> [1] introduces a regression issue for old srp target with default
> kernel parameters, as the connection will be reject because of
> too large maximum initiator to target IU size.
> 
> [1] commit 882981f4a411 ("RDMA/srp: Add support for immediate data")
> [2] commit 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Honggang Li <honli@redhat.com>
> ---
>  Documentation/ABI/stable/sysfs-driver-ib_srp |  2 ++
>  drivers/infiniband/ulp/srp/ib_srp.c          | 10 ++++++++++
>  drivers/infiniband/ulp/srp/ib_srp.h          |  1 +
>  3 files changed, 13 insertions(+)

Applied to for-next, thanks

Jason
