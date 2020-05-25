Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29B1E10B6
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390994AbgEYOlk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390978AbgEYOlj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 10:41:39 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614C1C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 07:41:38 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h9so3689842qtj.7
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ilz/WbLF3AgcdjXyjWROM8TlGwncvqueuh9Yt4A7O7c=;
        b=bbF5zJDLAbROXQOmJoNoXv7sHkRmJMEEwTl5qdoC4wk+VpXCE9J4ROM83Po2y93TQ+
         UXQpQOC7dY1N0rpfhmMTJ/pHUhXtlY3cLgx5aWuW/G78ah3auaYjIU9xYUHpldlKlqVx
         CSBG/SCfcPWD6IYI6WF9hiQFxxTdAaGiq5PEIjivjAt4rYf/vL9YhMq0kLoV1kFxcASs
         RUzjb1xRgVnvUT4fY1u27j3OJbUnnE+Lpo6rWPSUtjYGCRqFvzdbV0r+g+n++2bPrBYW
         NBzKX6wjedvdjFFyYbSDaq5+hDAlSnTOBhm8ler1U6K3J/Yb1I9us0tJ1fJrJxw912By
         ge9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ilz/WbLF3AgcdjXyjWROM8TlGwncvqueuh9Yt4A7O7c=;
        b=OORFezYrlAHw2XL5vWqYf6amJxFn8lA6uWyQ+FcuYXrpD2ubAT9qhTj69xdB/2eRar
         il5TBTsK5oaSN09qYiEVVmeaoVd6egXinplDdevnZ7Jjt79QUulIgEcKXJalq59f7iXV
         ZSalllT0o6STMVR79GpdbwnWbOWOJwXvPYX7EaVm9OASisGQi5MAs4vHgN9XUxdd25kq
         ZdeqjG1CyuzoC3rB+L7Hx4JOx6gLEh0SlRRcAX2rMA+Z94a8/ATlWA/PHuhtUZqZ0AKZ
         zIT+qbeQdADADmdubXgUfDbNPEekdwHctgpzJPM3EaKIchRacgW2nBJZgzf62RCX2G8H
         IvHQ==
X-Gm-Message-State: AOAM5331TC/vdDM7LI1yb+rWKaGsPPqlYxHE4LMNgbwpqUgfQYF/oquH
        wPr/h8FhrASXv1marWO9OeuoHg==
X-Google-Smtp-Source: ABdhPJyIsti8VVgCof660l098qRxMVNVYhlB9ZpP70PrYo3KWpTEe6l4BpDw7iDLJPrvc82/yuuemg==
X-Received: by 2002:ac8:7c8e:: with SMTP id y14mr2114279qtv.112.1590417697664;
        Mon, 25 May 2020 07:41:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p38sm16115097qtp.60.2020.05.25.07.41.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 07:41:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdEIK-0005kR-MW; Mon, 25 May 2020 11:41:36 -0300
Date:   Mon, 25 May 2020 11:41:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>
Subject: Re: [PATCH rdma-next 11/14] RDMA: Add support to dump resource
 tracker in RAW format
Message-ID: <20200525144136.GA21858@ziepe.ca>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-12-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095034.208385-12-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 12:50:31PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> Add support to get resource dump in raw format. It enable vendors
> to return the entire QP/CQ/MR context without a need from the vendor
> to set each field separately.
> When user request to get the data in RAW, we return as key value
> the generic fields which not require to query the vendor and in addition
> we return the rest of the data as binary.
> 
> Example:
> 
> $rdma res show mr dev mlx5_1 mrn 2 -r -j
> [{"ifindex":7,"ifname":"mlx5_1","mrn":2,"mrlen":4096,"pdn":5,
> pid":24336, "comm":"ibv_rc_pingpong",
> "data":[0,4,255,254,0,0,0,0,0,0,0,0,16,28,0,216,...]}]

That is pretty gross, why not bas64 encode it or something?

>  static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
> -			     struct rdma_restrack_entry *res, uint32_t port)
> +			     struct rdma_restrack_entry *res, uint32_t port,
> +			     bool raw)
>  {

Should it be a flag not a bool?

Jason
