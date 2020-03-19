Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F8118A98F
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 01:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCSAIX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 20:08:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43959 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSAIX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 20:08:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id l13so314078qtv.10
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 17:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PslStRvh/gwdX+fLXeuyKLv6Tn2yNwGOFXZhuX6lfcE=;
        b=GtFH+bxZWQQzGdgetUwKfxPM2f2iTqG1CihTmFqkxHLjdNw3jLwaxKmDVtgkrpFOCF
         1Rfr56T5YF3RaAUoov952PMWiyGEoARTGab2L+VNtSo2fpROyDQ8z5fIY7H69pxEWmhs
         ZsvMlcV6Qh607iPbJqdJLjiQ3OzYcvDGd2VTDcU3N7wdjDTFZl2JKGYNiwXm0WO4Po7c
         54alyfZ5SgdrKegM5sA9A+rI0ACFy7ucHY0EIyoNNvEAeaQt13TYYETcVEG+0YhIMGgm
         BD93w2e2Hz17RQADDtnBfTx09tLM15YYiw+f+okbaI+qF+P6bR6bmqGkjgf+zJTXR5s/
         NHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PslStRvh/gwdX+fLXeuyKLv6Tn2yNwGOFXZhuX6lfcE=;
        b=mShHEfkPTcCF6xAWvBdhOh4hukycbLEMHO18J21kpSdz2536H2zhU74sCJDbcju5xa
         bcYv8U7UFxKzEzZKcNsv6acJe2fhWi9DZzWjeiz5Sqg3wYQ6NU36v5nnAEEXVoSjK5xj
         jXpQkhJ6nub03T+6K32Q8QLlY0+0qGQ5ffHO6gchxiAorLeSkfv22+i3rgV3LsnkaMRL
         6PCfswwA/mzdt4CFapXYyRoZ/xSr5DWIfuQNgc8MXwR/Oggr0bs1SpQAyjN+TCsU9qmN
         zdOvsLnF4+0wYvRI5hRuRHQuoqn/uZ9TVkmQU0KpNUyEZfHhYgzbTAFo4KDJFq0vrimU
         Gw8w==
X-Gm-Message-State: ANhLgQ0AAj2ERyN7HUD4fsx9G6mNquGe+lpMO5fRhhETAVhdE3u6YOZt
        g0mnBAu1Vu8Z54+gVdPhBjdgCQ==
X-Google-Smtp-Source: ADFU+vtHRFX82JB81DTdLOZxA2wHXgmmvXNiRk/fYXRj+nqr/8DYoAKBO7GIKRhEYqYhlwAFv4DwlA==
X-Received: by 2002:ac8:4787:: with SMTP id k7mr293473qtq.267.1584576502550;
        Wed, 18 Mar 2020 17:08:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l6sm289348qti.10.2020.03.18.17.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 17:08:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEijV-0007IP-AM; Wed, 18 Mar 2020 21:08:21 -0300
Date:   Wed, 18 Mar 2020 21:08:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 03/11] RDMA/efa: Use in-kernel offsetofend()
 to check field availability
Message-ID: <20200319000821.GA27970@ziepe.ca>
References: <20200310091438.248429-1-leon@kernel.org>
 <20200310091438.248429-4-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091438.248429-4-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 11:14:30AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Remove custom and duplicated variant of offsetofend().
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied to for-next

Thanks,
Jason
