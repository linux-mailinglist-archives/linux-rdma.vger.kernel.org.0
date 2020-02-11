Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44DA315987B
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 19:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgBKSZQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 13:25:16 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33354 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729966AbgBKSZQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 13:25:16 -0500
Received: by mail-qv1-f66.google.com with SMTP id z3so5465289qvn.0
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 10:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q0+h6bbIHGd719KwRO6byGl9Pnprw/PXjjKQ1TNx3hg=;
        b=Ebesb8AG7vlg8CV/VtMarisv0SAGTq2HXEe6RUjC268i1YPfvsDW9REYQj51V0ou6n
         K2gVg6Y0+r7iULFoo4g6Sp9Vv22+tL6YPxGfugCK8Jl8zkoUsj7J6OTSavozSkdDQb4p
         zcmjYNRDtAKB6Fzp6gkifho4PhWlSu2RDqd1erhvOUxOzuJyaBeBQet9yLZhHQG8unk4
         c5kl3ChQhrJsR7X9Boxpuc8mZPbUGVqbCSttNMLC7xsOMSR7pVhDgSqyKV7y6I2eE2oH
         QAhxYwP2qojkNFl0D3P/1wrJNWCA8g1fb8uHuzI1Pfv6ZxGTbcJwlMBze94ba0iTmjD8
         sycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q0+h6bbIHGd719KwRO6byGl9Pnprw/PXjjKQ1TNx3hg=;
        b=iYhhap5924NQN/QIKqOHwmSjbwQWdcY82A+++KkCD2DmQlTISvMIEeh5d6/x/IAHqc
         s5DWcP5Tbp6v5hq7671EDz1T1ABCYlkA0kaxLqnOLL2vOgkuPIQX5vUUayoJUSaQuU0j
         Bz59AYPecQYNyEjRbeFwHjoqSrOD2pT+DUurK+Wqj4RP5x1Ah59PcsjreS04pQgY4/6E
         oZ2X3cT+pTuyyPlMYDz0B2vcb1BoBisW57U0SxUbq7EpK9hFhzrDbcxo6NiKa8g+6vaL
         y/Owlyv99XEDjfa/TTm3lWs26EnPkBbxAoW7nWlIGMP+k+0PnkUK5Usmxp1WOxL1+Wbz
         q2Dw==
X-Gm-Message-State: APjAAAUF5TXCEI2avCfasUEBY/ceQihFMlN1DwLOyK8qasEYCwT1UQgp
        11pM8vEdQ5M0BX6qpgzQEySg9g==
X-Google-Smtp-Source: APXvYqxxSgG/2qclpVe9JTGqwaiRdGiHV6k1n2GfA1llO8E6Vna1kLgMpamaCcrMMMj/OOj8wO3ivQ==
X-Received: by 2002:a0c:f6c8:: with SMTP id d8mr4177965qvo.234.1581445515553;
        Tue, 11 Feb 2020 10:25:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w9sm835640qkf.126.2020.02.11.10.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 10:25:15 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1aDi-0000xP-KA; Tue, 11 Feb 2020 14:25:14 -0400
Date:   Tue, 11 Feb 2020 14:25:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-next] IB/mlx5: Return failure when
 rts2rts_qp_counters_set_id is not supported
Message-ID: <20200211182514.GB3583@ziepe.ca>
References: <20200126171708.5167-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126171708.5167-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 26, 2020 at 07:17:08PM +0200, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> When bind a QP with a counter and the QP state is not RESET, return
> failure if the rts2rts_qp_counters_set_id is not supported. This is
> to prevent cases like manual bind for Connect-IB devices from returning
> success when the feature is not supported.
> 
> Fixes: d14133dd4161 ("IB/mlx5: Support set qp counter")
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to for-rc, thanks

Jason
