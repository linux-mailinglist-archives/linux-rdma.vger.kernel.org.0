Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCA1F16502A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 21:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBSUl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 15:41:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43533 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUl1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 15:41:27 -0500
Received: by mail-qt1-f194.google.com with SMTP id g21so1240681qtq.10
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 12:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7PR3CZcR40EIwyNhkCww8yoMHc6wOHHAl4FQrQjcDTA=;
        b=QRmEyBtvbzaY5oBenNnI7w4HIEu1krkLR4SBJ+Ug8dV89fjtLcCsbVSc3M+1DcIhSd
         y/owXeEh6NN/37Dcz1LDd2q19dsvvudBDG4ayOoUbbAGu5FaVVsfDR7d7USw01tb+vY3
         1ximcX/uXsdnbeHpTijrm84dZ5JYo2m7GUcEJsGlSycfh6GSKZ/+0/91LLziCYDrFgm3
         d+QV9dh2rQ68zXJM4sDbO6uBEeSTxZqe3ecf3XzmMOVRbHTARG+po3xWM0Zqeq592+JN
         lWSlUCfmwGt+XUzKEdNAkaaxivzAOb39lwX6xHZRiQKh9mfM7XQfu+PnzMIyj12nuerE
         NK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7PR3CZcR40EIwyNhkCww8yoMHc6wOHHAl4FQrQjcDTA=;
        b=aGOtNfkVxyK7JTYe0cE/yHjFEnddkainTKF5YXjxjwuCrnsvnhHCZWVZjxgt29KNqv
         YLiTCBd0K2NJ0FOv/j09SbdXC/jVKiSWnRDL0SnqG7hXpnGzrWxUkaksmP9S0EfKhPjA
         /ZmgX0e9ABgkgZ2to/t1H9xLwxk88bsrblgVIMHCEOEM9z5VQgnPSZYk0z9lyRJZXO5h
         aFJETGxEDTsKlD9v9J/Lcq9lbYh4WYxrezXcwH69uviSA3fXshJrBQm5yJHqVPWp+6iD
         nRL24UHXEMo9rploqpaT/r7Q72gM7x2IDeDSYLHFucMJsF1B379qpQ2RXJMlJ92YPwWY
         YZmw==
X-Gm-Message-State: APjAAAVyhJJTrXQww572bvOCzT1Kc9TlEHS/uDz+2KCVtLjvH2Di51jb
        007/DKCLy+FzV3POBbgrimw2bIA1EPGbkQ==
X-Google-Smtp-Source: APXvYqzUN9gZ8993+ckjOp11EYd83Kz+9dsRfxVnDuvQmRdkok4FK+kVmokY58CEFM/Nie0VUMEGDQ==
X-Received: by 2002:ac8:3735:: with SMTP id o50mr23123332qtb.252.1582144886856;
        Wed, 19 Feb 2020 12:41:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p126sm448728qkd.108.2020.02.19.12.41.26
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 12:41:26 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4W9u-0001ug-0w
        for linux-rdma@vger.kernel.org; Wed, 19 Feb 2020 16:41:26 -0400
Date:   Wed, 19 Feb 2020 16:41:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/ucma: Use refcount_t for the ctx->ref
Message-ID: <20200219204126.GA7330@ziepe.ca>
References: <20200218191657.GA29724@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218191657.GA29724@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 07:17:00PM +0000, Jason Gunthorpe wrote:
> Don't use an atomic as a refcount.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/ucma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied

Jason
