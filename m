Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DCB393E8
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 20:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfFGSFK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 14:05:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32779 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbfFGSFK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 14:05:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id x2so2419556qtr.0
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 11:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1u8QA5gDOKeNLVCd2bIEH+QLN4jvjcMRS9RX5LydFVo=;
        b=EZ20ECrHM9ckS09YSKff5zWQ4PQXOp2h3ff9oZ8Yz1H0GRPOYbX/p4Q/p6elbds5Ho
         Dervbbi1ZXm+hC1mme6oG/EF2SslLChrdLL9aaOJTlo04u1OWPPiCRq2t96ZDZQb3dGQ
         nrkDFXm5UKgGSbnkKT80uvxIl+g505IYmvsBgVR7C0R1ntFng+00hvy4Husorjg91trl
         X7Kp3pvDUZNzzG4k3gGGDYPirrVpqz05FrFBoaAsDisDVZXnGMON86CRHcoK/pMy2BHe
         i8paEjz3b+IwtyYXPrQ+g2usQYJgNu2cTPuDsaYgOlbvjU84YljcMISrvLTjp1BfSWeH
         V/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1u8QA5gDOKeNLVCd2bIEH+QLN4jvjcMRS9RX5LydFVo=;
        b=JRTZcwJNSSjVsVflgf4PcSta/HUANpinlO1qLdAMRFzTVeCEz7B20FqNHo3h4cAH0W
         dNN/kRq+zZchJIyA2sea9e0xIuNNNrRpaaBK80aBJ9K5GTH6aGNhO8SjchsKqvoo4L/7
         cjEIqFk3A8kW2nnFNCRjR2JUY6fPTLtuPYC0tCskHQvqL1qS7dNierqcW4FuK2ehsBKM
         c3PoyHq0pHPcBxZQuGuAIAYocJbgivbfj+oZeq+/UG+JKzrJfg51d5M4a0YuweIPuFRR
         1usgLUule0Xv10rJ0GytA25MDlm02y2j+Zs/YdmzllVpMGib1Dj+CdmUog/UVsk0u2LI
         ShAQ==
X-Gm-Message-State: APjAAAWQnnfpgnIRmgI94qamzU/t0+Cck03zhOqG+P1UvFILVkLkiwDv
        XzQ881NCo/0T9S86Hw4OHsWJJmNOrhzIQA==
X-Google-Smtp-Source: APXvYqwY1xXf3g4oZc2oTXnuhHygmo24ORh16m5jKK1MJW0iJrr9WhUZgH8WbbTfQR24AG1VLpdySA==
X-Received: by 2002:aed:2961:: with SMTP id s88mr46611186qtd.120.1559930709358;
        Fri, 07 Jun 2019 11:05:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id k7sm1167641qth.88.2019.06.07.11.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 11:05:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZJEi-0007ai-Gq; Fri, 07 Jun 2019 15:05:08 -0300
Date:   Fri, 7 Jun 2019 15:05:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ucma: Use struct_size() helper
Message-ID: <20190607180508.GA29136@ziepe.ca>
References: <20190604154222.GA8938@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604154222.GA8938@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 04, 2019 at 10:42:22AM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace the following form:
> 
> sizeof(*resp) + (i * sizeof(struct ib_path_rec_data))
> 
> with:
> 
> struct_size(resp, path_data, i)
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/core/ucma.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
