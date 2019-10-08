Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46BB6D016B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 21:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfJHTrB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 15:47:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44944 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbfJHTrA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Oct 2019 15:47:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so27028167qth.11
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IIBo8DPIckcTUYOH/+kQATYd2U2ZzQZkMXqIj7oKgg0=;
        b=IfN70Wu0dnrTJP6Yxec0R5K5fT0T/A7dSepp3x1ISAYvU8830nbwlREt3YPGc8LdZ/
         6UaVYqf6EbZ2ILUWNy5Z8LwrKjV+7H4gHotgei4sBYmsl0Y/eam9ukEd2cx//L5UIhEv
         14T1S0oTOhdNae5KKGyyyfi1GA562W17DISTJxvLkkYd7sTbKa9xfQ+wg+MVox20k4yS
         cZwZEa7imlLlVe6Mt/UHYFQWWlB1/UVK99BYrpL9s0/uXfyEgR+Xd+QdhrjPlm8X6Gvj
         RSBwJcIBcTy9FC1m5LnIkjSWZQcF5F1bR93QQHwlBOpXz5Tusn0xHHycYC2o/qIUpcwz
         kPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IIBo8DPIckcTUYOH/+kQATYd2U2ZzQZkMXqIj7oKgg0=;
        b=LHwVthtvFDm5YwsnFOHwFoQhTFaz9tQJD0LxTqtzKFoqePiDbNbrQGYKI8PxbWGnkB
         twJrsn6vqfbwL2E0PoK5pG+23wCaJa8Br6mOJDTkV2hopbrjmbFtzrW+bpA5jYaX3FCb
         SJlWUOZ3aKWjK1MHqaQMNe+924L8JOiZshl+oaUx+7alUxF2Df/iaRcU0269oWeW3GJ5
         Hb3e6LTVqM6g5xJM5yXNQgdRT6+pnyuBVOhSRRIeiOFz5BOfNxMLm6KI4y7t2uD3LCTo
         ciF+9StzYwKil7k93uDGEVhCrrbj5mdt1yGoXSMRI1bO4NbaHJELiQHqpwLXNkUHG2fs
         5VoA==
X-Gm-Message-State: APjAAAWWYkwolhcYjnLbC7uBAglK3NMUfY+JxbeHQmUi9/wrJVLfbjLK
        KtDKHsqbakEs6kiCFupbnGOELg==
X-Google-Smtp-Source: APXvYqwjRJyD91GcsXZ2oeBUaFusWmj3nNGA9cHoSQcfD17YdlPKz35UwHVz0Ekp/gmBD00bOtY5ww==
X-Received: by 2002:a05:6214:12f1:: with SMTP id w17mr22363678qvv.108.1570564019691;
        Tue, 08 Oct 2019 12:46:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id a36sm10001621qtk.21.2019.10.08.12.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 12:46:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iHvRi-0000pG-OJ; Tue, 08 Oct 2019 16:46:58 -0300
Date:   Tue, 8 Oct 2019 16:46:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Introduce and use mkey context
 setting helper routine
Message-ID: <20191008194658.GA3152@ziepe.ca>
References: <20191006155443.31068-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006155443.31068-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 06, 2019 at 06:54:43PM +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> Introduce and use set_mkc_access_pd_addr_fields() which sets mkey
> context's access rights, PD, address fields.
> Thereby avoid the code duplication.
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 34 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 18 deletions(-)

Applied to for-next, thanks

Jason
