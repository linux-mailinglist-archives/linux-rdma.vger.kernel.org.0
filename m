Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C009E13CE26
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 21:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgAOUiv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 15:38:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39970 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbgAOUiu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 15:38:50 -0500
Received: by mail-qk1-f195.google.com with SMTP id c17so16997687qkg.7
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 12:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RCZyVnnXf0g1wEeIXMBB2dFBndxKT1SmeglxjnWp/4s=;
        b=l+zgPQvmw9rXWL1ep1tC4ZOOLqWmTdtE7aIzdZ/57e6JMiRS5kc+scYlm+q3rX+3eP
         z3MrK44d2+0sdSwZMhGUcdJGotOnKRVxh0YKHa+XwkgiB5LvDSKoJtoymnWLUx6cPcpV
         n+tn4F4bpaCoVXCtMtYb3/gT+pIO2ZTCBL84dnox4w4wt2Ik6ha0ZMxaAuDhpLgyfKGd
         86CacfVJBnjYsfaFcuJwV7/Vlyy3EtfaXXoyUHULlKPXogXO0nGGz72ZXiVn3Q0FIFQN
         waMn6+fSbdhZzrv0k+J7ULE6nvaCJMud0s63t32LmBD4E57+boAghoNOKDJwC9yFFy3j
         UWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RCZyVnnXf0g1wEeIXMBB2dFBndxKT1SmeglxjnWp/4s=;
        b=BMMA4OC/LbxRTIoTVUioaobgtC64rppQAPJTgaNblmqnc8kJHgW9ZAR6sTR+Ge3DRA
         0aCQyIHA2oJuqR9j6j6D5bJkk5P2AJoxRhnBSXslmgYDApvrcMFdC/zI6/2ERwwUsbRL
         cIMo5xlsAUg+GSaVoz1dPHWn4cX1U9Him/zNHvgR71KqYnbBBPVRp+wugrpFNohXSk/0
         Rlk35msO1dmCWN/CCA18ZEDxbWeVOECT8N/hWAatdjNFNJsD1uNlDhwZc6HDdDwK2V5f
         obATSwtGIOLs4jyd56rXgPHTB7l/9WR+s/VdlarOcVw0rAJuKa8BL3uShF2/gi6DetJK
         LmAg==
X-Gm-Message-State: APjAAAXUitwoKUq1Lv/B8LXGM0WkWbU80MqpS4LO1mROooJnZob+UIbZ
        BDK4Gq5G4/1ZL7NOTY1pZy4N0+bleV8=
X-Google-Smtp-Source: APXvYqznqI8LG+aHhL3IIwC8f8p9Uy3h3l2l8ylqyy+Yd8lwCZel76tHSlZwJJqRueXm3rU5gUsGng==
X-Received: by 2002:a37:63c7:: with SMTP id x190mr29372078qkb.232.1579120729966;
        Wed, 15 Jan 2020 12:38:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i2sm10110233qte.87.2020.01.15.12.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 12:38:49 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1irpRA-0006xz-Ox; Wed, 15 Jan 2020 16:38:48 -0400
Date:   Wed, 15 Jan 2020 16:38:48 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sergey Gorenko <sergeygo@mellanox.com>
Cc:     bvanassche@acm.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/srp: Never use immediate data if it is disabled by a
 user
Message-ID: <20200115203848.GA26741@ziepe.ca>
References: <20200115133055.30232-1-sergeygo@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115133055.30232-1-sergeygo@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 15, 2020 at 01:30:55PM +0000, Sergey Gorenko wrote:
> Some SRP targets that do not support specification SRP-2, put
> the garbage to the reserved bits of the SRP login response.
> The problem was not detected for a long time because the SRP
> initiator ignored those bits. But now one of them is used as
> SRP_LOGIN_RSP_IMMED_SUPP. And it causes a critical error on
> the target when the initiator sends immediate data.
> 
> The ib_srp module has a use_imm_date parameter to enable or
> disable immediate data manually. But it does not help in the above
> case, because use_imm_date is ignored at handling the SRP login
> response. The problem is definitely caused by a bug on the target
> side, but the initiator's behavior also does not look correct.
> The initiator should not use immediate data if use_imm_date is
> disabled by a user.
> 
> This commit adds an additional checking of use_imm_date at
> the handling of SRP login response to avoid unexpected use of
> immediate data.
> 
> Fixes: commit 882981f4a411 ("RDMA/srp: Add support for immediate data")
> Signed-off-by: Sergey Gorenko <sergeygo@mellanox.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srp/ib_srp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
