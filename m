Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE87551F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbfGYRJa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 13:09:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43410 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388559AbfGYRJa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 13:09:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so5483260qto.10
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 10:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WgqPpNQlh9DwWaeS6VusT0aAgnAWXgO/OW3gMjY/Imc=;
        b=M+pM/xWNoP8gfLTJVVTCJTCKfPbqY6iNn98e7QV8XWD8hpW6/Hoo2P0VTqZJCXe/Hc
         kdDwWEr9odDSSXZ6KsMnJpjuwDg3/FPpOLxMu7cZ69AZ/IB1LfmMv5y7hIw/o+ri0a5J
         leG1slKT7kVPVrEaPMUQkFfhCHe2UEXvedwjHYD2koOH1qwWuxqWSEj5qE64vGYr1deZ
         lLw4UjejhqAEr3TaWAiTmEQZD2c9Ruabi5iyqkQ4584tH6IYj57uaVfAtYUwhDgUczyW
         tEUYASM2VJLWbLYOEyh+Eqaz+GjVuXRqBuzGvX79CkKtf6t+UAGnXnOWNBQWLb9vaGM4
         UUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WgqPpNQlh9DwWaeS6VusT0aAgnAWXgO/OW3gMjY/Imc=;
        b=AKGWUFV62K6UaNT0ElHOnNqiJh8iEMRVe68u6ZBAbF9UD9QGegpUS5IwTFn7QU1tnl
         hhV2RQHRBmvj/U8KwHFROjFT1cKo2GCWAqaUU/w1S0U/GAfVRrkrLgYEHbFfQzL1GYqw
         4ItD3HEQ3s7S2psAo0YwtbYAD3zf3Dd2E39c+QnjdPH0rILRhxDhx8iLwWUoY/aItsu3
         GZ9SmDZXAGVslWw1tXVfPKij/Du5f7NQNcpgm0Ft+RS/t281o6dlsdNquncyOoZmVdKQ
         /RamzaqlqlVZWL4PBj54/d2UfV1RgQ1HpunihlI20v7Kraxw6lM/H2Pdi+H9X20bacP1
         zZsw==
X-Gm-Message-State: APjAAAWa9bvNb1YU+/n6my62AmrsY6dRvtSv2zrDbZIIKdcvkR0339i9
        R322qTRMar/Ual38V2djY3eI9b44CowxQQ==
X-Google-Smtp-Source: APXvYqxh8ftp147mxv5cB+Q2MLh0u3K/rf4Vrg+QmL7AjM4UkrzBln5ZIin4tGRdYakR/pgs2NgHUQ==
X-Received: by 2002:ac8:4412:: with SMTP id j18mr64263002qtn.165.1564074569703;
        Thu, 25 Jul 2019 10:09:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h26sm30213095qta.58.2019.07.25.10.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 10:09:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hqhFA-0004Sa-No; Thu, 25 Jul 2019 14:09:28 -0300
Date:   Thu, 25 Jul 2019 14:09:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 0/2] Initial code to cleanup RWQ
Message-ID: <20190725170928.GA17121@ziepe.ca>
References: <20190704130936.8705-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704130936.8705-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 04, 2019 at 04:09:34PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Inside mlx4 RWQ is integrated into QP, this complicates my deallocation
> patches. This is small set of patches which I carried for whole cycle.
> 
> Thanks
> 
> Leon Romanovsky (2):
>   RDMA/mlx4: Separate creation of RWQ and QP
>   RDMA/mlx4: Annotate boolean arguments as bool and not int

Applied to for-next, thanks

Jason
