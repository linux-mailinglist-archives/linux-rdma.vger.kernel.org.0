Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25941E761D
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 17:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbfJ1Q30 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 12:29:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46732 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732565AbfJ1Q3Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 12:29:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id u22so15372232qtq.13
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 09:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ywm++Z87RINsH4azWOF+cv9u1AUiAjG+Xeq+gmj+tY=;
        b=NL0iVirGaY5bt9tNVjmCBo+bMCci1HgDaiuOI5rSi1psRZumMi1lU9cvaZ8bQmYYGv
         tGAsZqT7c2WIV44hJjVGDiqBlGD4ni4vlUDi9w2KqwLMgfBeiYi0FoYhNY7IIgF/oJze
         DcIAyVmBSLSA09buPvGrkRXicVasIaykpNkO4xUml11KlBD5fJ199O0KS1Nq+QCOJtDu
         TPce3ahVQYcO/I6CvQqT33RA6GC2dbJ/dll6Vsml8vD2xd6pNmu0RkAFuyBXJbJaLFjp
         tuRzd4LhcCB3+Zl/JRpq95+IPgohwz62F1y9Kh+Liz/nJUDbY8a/WTaq8Ak/9xqewcb5
         3m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ywm++Z87RINsH4azWOF+cv9u1AUiAjG+Xeq+gmj+tY=;
        b=iEYyZprzaDsN4Flh0A3TgEYYWnW8hQxMa3jJpLFsoOBem/RKDx3TxkItLJwIW6c+b/
         eqeIIPDDuUp4yjhvgEkcCIVwm2spZ/AeKVtOEspPYPTe2DU9LTFGhH93TBpf5aM9iIVp
         isbyjo+ROTDU6ACeTd0RFO1tjciNuW2GOvy1wgSBUB2yJhtJh9CZRzW2vWks+Jdt1vwQ
         GHSKorzwR0qbQpnsIgyt3GfV24h/WNpuUAApoVDVAyFQtZ4GCVdeWUcCOHkgKYCzTFSs
         jco5+wFqyIG+E864N9SFnzToDYXEAOn8gjHbBN3UoaEZYcp7KYCVFAjTJmaF0UEAJey8
         0Z7g==
X-Gm-Message-State: APjAAAWsOMM9Kl2bsao1eXT6TmVxCIPaa/znf8B1DdrhYYLNyntjdUd9
        k/i9bTaX1uiRiJQRcCyNebKx9g==
X-Google-Smtp-Source: APXvYqxawCRZhac2ttiTxGbp/cRkz1CqGKRwsmlZK1FRvvnPd8bOMhGQcV+0Y2xkthoIlSypPjiIDg==
X-Received: by 2002:ac8:3f5d:: with SMTP id w29mr16863473qtk.3.1572280164899;
        Mon, 28 Oct 2019 09:29:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h185sm2233472qkc.7.2019.10.28.09.29.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 09:29:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP7tT-00063L-Tq; Mon, 28 Oct 2019 13:29:23 -0300
Date:   Mon, 28 Oct 2019 13:29:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/hns: Delete BITS_PER_BYTE redefinition
Message-ID: <20191028162923.GA23235@ziepe.ca>
References: <20191023054239.31648-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023054239.31648-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 08:42:39AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> HNS redefined available in bits.h define and didn't use it,
> we can safely delete it.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next, thanks

Jason
