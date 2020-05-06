Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550441C7B76
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 22:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgEFUpZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 16:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726815AbgEFUpY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 May 2020 16:45:24 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E97C061A10
        for <linux-rdma@vger.kernel.org>; Wed,  6 May 2020 13:45:24 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ep1so1549299qvb.0
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2020 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aHxTxZj2V10CYTN2kUwnmpZBD3bfvTybMV2RCScDzKk=;
        b=Q94hSym/StzAYIsmRY7AV05+GlrLhat2sDG+37NspNREnoEotc5H7SoEseU6xttxhQ
         wCU4cubH4y7HbqPsF53poV+R783FXhtkM0kgcL4LlIBjxZBRtM0g7HKOYtwVQOL3CBhD
         ZPTOxmzEP0Sq0EDhhuwidGfP7FaKE1JZ3n6Yfhm/9DskhZz63DYYsF+lDqP60I0jMEcm
         Nysh9NIYW5WL2F7tSBScVql58cUM5ovicEv+gDVtyyyblD+FTFEQ+PPwFECy/zshkNi2
         k+VUWPplZEg75rGLKIw57uCyBnQgo0Z8MHglrSedOgVJ/tKEM3Nrq81rWU3XRhuKtyKI
         lo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aHxTxZj2V10CYTN2kUwnmpZBD3bfvTybMV2RCScDzKk=;
        b=bdbG+bmznHvBhDNd/lhQuvT7kxk5y6mafHY8cCbkP3n8rafQ5IPT8DNxPdI/cr1sGL
         r3DkrTYKBBenqX5GkshbLsF8NrlozRMQT6ryxehi1mPJtEILjAZEFRqxgLly0P6IOpEN
         F75P+G+o+Bw1IRTXRiaTsRViZ3oQy+FNM+9C2RuNt802XB0xjsmW7pbcgWYFA8z4+ddL
         oWDBhlnAJc0RUJYjSDO1oD/pvSwSFPjvqHQ4AN4VKz0f4y9yA3XIeXjOs/cBSaZ8BSNO
         4nf6jxyjuUEQWcIQJKrabERGwyMah3mcJLbDOapMwtUv8QCCC/h/kzardsVc4L0fRQgy
         5+KQ==
X-Gm-Message-State: AGi0PuaNo2NprSV9TbBM3y4ZCMGoNv789oo0HQuu+F2Ax8dAZh8+XGXP
        KkriVbzfToZ4jmKSxpW9637GmQ==
X-Google-Smtp-Source: APiQypJ5LGJkyHBFw+rWSyejvNoKZcvipIydJSphLQNmfLcXVLYtaYU81pNTxIxvb5SLLw+DSGcdPA==
X-Received: by 2002:a0c:aa51:: with SMTP id e17mr9869407qvb.95.1588797924002;
        Wed, 06 May 2020 13:45:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p10sm2449265qtu.14.2020.05.06.13.45.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 May 2020 13:45:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWQuw-0005Zw-VE; Wed, 06 May 2020 17:45:22 -0300
Date:   Wed, 6 May 2020 17:45:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH rdma-next 0/3] mlx5 QP cleanup (cont.)
Message-ID: <20200506204522.GA21400@ziepe.ca>
References: <20200506065513.4668-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506065513.4668-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 09:55:10AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Hi,
> 
> This short series continue to cleanup qp.c file, which grew
> to be completely unmaintainable.
> 
> Thanks
> 
> Leon Romanovsky (2):
>   RDMA/mlx5: Update mlx5_ib to use new cmd interface
>   RDMA/mlx5: Move all WR logic from qp.c to separate file
> 
> Max Gurtovoy (1):
>   RDMA/mlx5: Refactor mlx5_post_send() to improve readability

Applied to for-next, thanks

Jason
