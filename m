Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9691DA5FD
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 02:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgETADD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 20:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgETADD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 20:03:03 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C68C061A0E
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 17:03:01 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id n22so1176476qtv.12
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 17:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JnB/Jzibg3J0flyobD7NIwe+ilnsh/LiW6CRAVrGRiI=;
        b=RDiFuqTyM2kRpouCX5Wjbs+JEWRcj/IjtLClanfEjqIy4QzlXyJSzZJfGBoQSeiGq1
         UrGsW5EooMJhSZJYMKoq8Iz89n12weryrT3wO2XGPveyNeuHu4s44Ph1vxemsqTkjExU
         6q/upDINTfjRL8PIgk5MtI9DRyOitEU17wKn1whpAe1oKpQhH50PczzgyUTwCDNs09Tk
         OTWNmRatqoip7fvfD6rrSjLKcswxzD5hTvPZ5/E7FyyYCg/Bo3OmXFRi3IzeFQ/sFCcr
         L6aKLkwAFrmSvboGPC+Zqju5nDZtm8lWd3oHe0q2NdzAZEELVpX0Q9r0KxXHMkYgwivw
         9hGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JnB/Jzibg3J0flyobD7NIwe+ilnsh/LiW6CRAVrGRiI=;
        b=De2ZpvCu7y6eh4pHybc79IfbmD7oSbI3gHyxbioRxMy+tousA2xwb0Bzq6xugFfYaO
         qfrP4AVIEYSGTdjVL9B0jVpEsBapw2c+kpok4EdrUj6oed0SLEETkhNB4j93xloSC95A
         dSqGgHXYtjhfrq8c4x5KHywp8xAp3IuEcRsF3geNk94NX6q8nbsieQTfKwyqQh9x+EMs
         T3TtQPLcGuC2HjMCc7EEAmHT8560D1AZYHEgNW/6qGiFgtNcxaLDHuXR8oMrJ4LDsPLn
         DUpQOk0ljngIXO9/fgkN07Rj0hyAOmrzeFU1HMZQHKOmG27WwCydNLv7/ahD5gG6KT1H
         fB6A==
X-Gm-Message-State: AOAM5321HpwUHLP5OC7VoAgFXuP75/Mv4ArkNkadjj5bmg3xuaaoC7j7
        xKki6qxUmOiaaXfCml7ghytikg==
X-Google-Smtp-Source: ABdhPJzhywVhwjl41/EkNjQk+cL32sV/9FYfKRQa/SNOFSJcM3U5XSweZRP84FJ8Bqtr/EzfRa6bDg==
X-Received: by 2002:ac8:1967:: with SMTP id g36mr2634837qtk.332.1589932980936;
        Tue, 19 May 2020 17:03:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o3sm1067166qtt.56.2020.05.19.17.03.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 17:03:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbCCK-0001jo-1z; Tue, 19 May 2020 21:03:00 -0300
Date:   Tue, 19 May 2020 21:03:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@mellanox.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add init2init as a modify command
Message-ID: <20200520000300.GA6639@ziepe.ca>
References: <20200513095550.211345-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095550.211345-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 12:55:50PM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@mellanox.com>
> 
> Missing INIT2INIT entry in the list of modify commands caused that
> DEVX applications can't modify QP for this transition state. Add
> the MLX5_CMD_OP_INIT2INIT_QP opcode to the list of allowed DEVX
> opcodes.
> 
> Fixes: e662e14d801b ("IB/mlx5: Add DEVX support for modify and query commands")
> Signed-off-by: Aharon Landau <aharonl@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
