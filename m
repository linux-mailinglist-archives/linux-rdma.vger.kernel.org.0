Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828B3754E9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390569AbfGYRAQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 13:00:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34900 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391022AbfGYRAN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 13:00:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so37013120qke.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vf94HoGhpajN1EYEIVVm2v5oG4gn+NoHkmDlLC8w/gU=;
        b=cl/sgoM8XiejK4anCTzZIZ5ASXCQMv1Sy2+A3MMbyulsO2ObfDr5UbyeShwodRg5MQ
         DdTmIGUnCQj34AvvJnZ8gcMWobJFkdOOYdzSDm8/HNYB+qBzhK9iZ/HDHFZMTGfKIVih
         Vue4Qm9bTDbMT9I0ZH1y8icz3GJx4Yx6RJkeQtI9jGRu47nA69f8u1kGh1hgvUVL1iyu
         Anw8F/NJK11djKA6M7JoUrqt9Fut2cCd+v8KDXvSQhC1AJOSZtjFtsJ4u2m8salkxuNF
         GRe/Vlw2IvCYpWp/iQ7dq9RAuK+P8Y/8yXhJecnMiq9W1HJrQnspK56ImzyQXWpND852
         E3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vf94HoGhpajN1EYEIVVm2v5oG4gn+NoHkmDlLC8w/gU=;
        b=reiNsi+XOys4gYj/cJmVlGy8r/ZEG95f1S4k3Lv7c1/OXrbZz04v3kvdvBhAjZpwvP
         npcrLy2vqAXfrbZMjzNoBaQxJqxam8S4YjVM1p8uBTBg4SHlLSjWdR1rTcjBTH2sqPt0
         UQTjE3H0zw+Ppuu9pV5d6EOgrkU59/0p/X2Pb4RwSRsZ/AtWJXjFQDTzUexc2cfQJFtx
         9fHvRqLa02zNG/ThwTm++gMA1vA0nU7VyC5WHrAV5vbWXIBPJ8FPbOCnhr+NPyzFkGVA
         mejRH+0lsj8jzG2zI+pfmPDJHsRHn6kgD8jSDUXtTSYuEnQptgt72d7YcoPW4X65rsun
         6V6w==
X-Gm-Message-State: APjAAAUUbt/2kpLBqnnqvOV1qxoIsrDc9nibUbHpCNA/zZEm54Q7Q695
        dhm4MfzKqbhcjt10bZESyJ8QlP8oQ+DFWw==
X-Google-Smtp-Source: APXvYqzB80n5fdE5RPeW+yspabS0I+k121YI6H9zp8Nt/rMlzWP73KYb/r/Kj62EpGaCAZC76C3d1g==
X-Received: by 2002:a37:9ac9:: with SMTP id c192mr59969700qke.30.1564074012077;
        Thu, 25 Jul 2019 10:00:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e125sm21018153qkd.120.2019.07.25.10.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 10:00:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqh6B-0002UG-8i; Thu, 25 Jul 2019 14:00:11 -0300
Date:   Thu, 25 Jul 2019 14:00:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH] RDMA: Make most headers compile stand alone
Message-ID: <20190725170011.GA9534@ziepe.ca>
References: <20190722170126.GA16453@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722170126.GA16453@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 22, 2019 at 05:01:30PM +0000, Jason Gunthorpe wrote:
> So that rdma can work with CONFIG_KERNEL_HEADER_TEST and
> CONFIG_HEADERS_CHECK.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  include/Kbuild               | 6 ------
>  include/rdma/ib.h            | 2 ++
>  include/rdma/iw_portmap.h    | 3 +++
>  include/rdma/opa_port_info.h | 2 ++
>  include/rdma/rdmavt_cq.h     | 1 +
>  include/rdma/signature.h     | 2 ++
>  6 files changed, 10 insertions(+), 6 deletions(-)
> 
> HFI guys: you need to fix the problems around tid_rdma_defs.h

Applied to for-next

Jason
