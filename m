Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB33BB68
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 19:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbfFJRxj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 13:53:39 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40540 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388696AbfFJRxi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jun 2019 13:53:38 -0400
Received: by mail-vk1-f195.google.com with SMTP id s16so1877203vke.7
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2019 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/K/pbG0WKfovPiU2wZCdqgLjo3N1V9fnm8d36ZgRiKk=;
        b=g9u6sX9jO7O2o/TwVC3GlwSUvDkben+6YA26f/5SbH0R2LovpzB95WNNcBhbWvvQn8
         vbeWCpeHBYT6T1n6l7Gp8+yA2Wk8Jk9yaoAWjJoCAiv0qAXdcjgTYQY/l4UCk6jruRXm
         xkfq69xXABzdSZ7MZkZmfgpALtHEDt4LMQu0w8y7haljcj1U/3QBh3gmk+sRZSFpQRmu
         /8voeN2G1NyfWs3uuCwqisrRT2ImlQ40UYx6PY+l4C2x7M97v0YOz5jvnXWNRJs+zoIx
         Ib21x8eN8ppogVVddIHA24Cxr1CVvLVKZh1+jKIgd3QaIHAq+UzEngEUd0aTwI/XIyh1
         Cvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/K/pbG0WKfovPiU2wZCdqgLjo3N1V9fnm8d36ZgRiKk=;
        b=cXLb7KwdEhJdZjwKqBlyi5DTHMbWI4Or2skFakIhdBsspMmoSYp25KLlGrQGGOnwlR
         Sq7sQdifAwFqSauX2/uFTSjMCas/P6OLADSABMf8U0D46F/flEEZ2XTjNHPAvcDZ1/tJ
         baZjrQQITzijmIGWEHcTPEv1AF0ZHYMeKIaMer2Bn4BQRIdsGJe7m4vFlkDgITZrF+v+
         YcAgYkRqgcPZutf2sNxZh+fAAkKQT3UQuYH1Em4PyAhPzfcWkVwsmchC77Q5DeirLANx
         9+GvC9iU1YqBgueAUf779nkIyvk0pT/duBCbeUOjcacOn/udddZm3LM8G1T66Ronpcp2
         gVgg==
X-Gm-Message-State: APjAAAV25Up+urr0ryXKRjco/X2ecae/1LAZBrsU9Xne7KOQjaoFAsaG
        uFGxIVb/Oow0RBPSJIW+TRKnR2xCn6jxZw==
X-Google-Smtp-Source: APXvYqxwFX+x3n2IN026chD7MaM4+cO9vsse96Z+EjeNgkesX5LczZQiQcqqX0DphJaB/D/lARNfqw==
X-Received: by 2002:a1f:d204:: with SMTP id j4mr7266870vkg.9.1560189217547;
        Mon, 10 Jun 2019 10:53:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 203sm826495vks.6.2019.06.10.10.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 10:53:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1haOUC-0001Iq-J0; Mon, 10 Jun 2019 14:53:36 -0300
Date:   Mon, 10 Jun 2019 14:53:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, jackm@dev.mellanox.co.il,
        majd@mellanox.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: Spread completion vectors for proxy CQs
Message-ID: <20190610175336.GA4890@ziepe.ca>
References: <20190218183302.1242676-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190218183302.1242676-1-haakon.bugge@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 18, 2019 at 07:33:02PM +0100, Håkon Bugge wrote:
> MAD packet sending/receiving is not properly virtualized in
> CX-3. Hence, these are proxied through the PF driver. The proxying
> uses UD QPs. The associated CQs are created with completion vector
> zero.
> 
> This leads to great imbalance in CPU processing, in particular during
> heavy RDMA CM traffic.
> 
> Solved by selecting the completion vector on a round-robin base.
> 
> The imbalance can be demonstrated in a bare-metal environment, where
> two nodes have instantiated 8 VFs each. This using dual ported HCAs,
> so we have 16 vPorts per physical server.
> 
> 64 processes are associated with each vPort and creates and destroys
> one QP for each of the remote 64 processes. That is, 1024 QPs per
> vPort, all in all 16K QPs. The QPs are created/destroyed using the
> CM.
> 
> Before this commit, we have (excluding all completion IRQs with zero
> interrupts):
> 
> 396: mlx4-1@0000:94:00.0 199126
> 397: mlx4-2@0000:94:00.0 1
> 
> With this commit:
> 
> 396: mlx4-1@0000:94:00.0 12568
> 397: mlx4-2@0000:94:00.0 50772
> 398: mlx4-3@0000:94:00.0 10063
> 399: mlx4-4@0000:94:00.0 50753
> 400: mlx4-5@0000:94:00.0 6127
> 401: mlx4-6@0000:94:00.0 6114
> []
> 414: mlx4-19@0000:94:00.0 6122
> 415: mlx4-20@0000:94:00.0 6117
> 
> The added pr_info shows:
> 
> create_pv_resources: slave:0 port:1, vector:0, num_comp_vectors:62
> create_pv_resources: slave:0 port:1, vector:1, num_comp_vectors:62
> create_pv_resources: slave:0 port:2, vector:2, num_comp_vectors:62
> create_pv_resources: slave:0 port:2, vector:3, num_comp_vectors:62
> create_pv_resources: slave:1 port:1, vector:4, num_comp_vectors:62
> create_pv_resources: slave:1 port:2, vector:5, num_comp_vectors:62
> []
> create_pv_resources: slave:8 port:2, vector:18, num_comp_vectors:62
> create_pv_resources: slave:8 port:1, vector:19, num_comp_vectors:62
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/hw/mlx4/mad.c | 4 ++++
>  1 file changed, 4 insertions(+)

This has been on patchworks for too long. Is it still relevant, or
were you going to respin this with Chuck's 'least loaded' idea?

Thanks,
Jason
