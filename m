Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B0F35E442
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhDMQlf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 12:41:35 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]:35816 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhDMQld (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Apr 2021 12:41:33 -0400
Received: by mail-qv1-f50.google.com with SMTP id x27so8382256qvd.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Apr 2021 09:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R04QdJmcMMrb0xBlnVhBYmU40i6Jod3DFuMm78tJNUY=;
        b=WmuuUFI7FdelhD8wugMf/3FfKYzBIHuyfVE9mYEecbKZELoauBrBuogvletFJ7RJWs
         izbw8wxxsjG0l/n7B2tjwb3NnWuPLmgcf5Pf3poQAIROLce3EEweReeXEmAQBMILjcde
         Sy1wdL4EI4auYrmXujRU5gxY2o5tFTVHkjQ0fr0gdyixGYCAV9lPNaPGDBAeUKH8Aq1G
         5TWdaYsnJDHgTOpBULuMOmkZPEDK/FEWYy1Qq+VN+uTLK/+nVtWZtD88bWCDJbjiS+Fa
         QlSUSBI+EfmCFCalJ14TFiJJlIifbFwRWvj/PB8tQCkDWhr5O7ODFt8b50xeygl2l8Xk
         KnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R04QdJmcMMrb0xBlnVhBYmU40i6Jod3DFuMm78tJNUY=;
        b=BWgL+i87ortgsx+4Cjh5sMZD6AgCXBAj+l1XJMvVFV3tU2sfSS9c0DCbSd+SQ52+kd
         NpFPFZN4x+DHFErBD2a289G0if+Hl/lyhdCK+UJR96TO8vqyk4w5aZ+KvZwzyao+/2Na
         Zt4+bBu53KXOgiffkOgfZUilO4BEBnKhfhvbjluQpKI7cDF53rd682c99Fj74O9Nxwau
         dDE2vktCUFIw/eklAfdpV0FzO6UZU9jCLQcFdu/MCbNpoiutWmtRhMCTADkHY7AXCgZV
         44/aoMDCtcXs6v89ExJU0VqXll3YXWzUrPHHQ/IA2Q7R4Bq8ki4+oZMeuQUFA2WS5tlm
         pzHw==
X-Gm-Message-State: AOAM532gME9j+7zCJZlq6oWW+nFaff//s+fUyexR1GYx4GiEqO7K83JH
        a3xaPLRPE9cwIk6k/t+nNoKiNOngtCXB0+qE
X-Google-Smtp-Source: ABdhPJzYUhMbXwU06bJdVQVowUgAJ0n9T5s3av5D7eZjfuEQxSnxzhbkq1NtpcjYvRhAl5ujKFsHLA==
X-Received: by 2002:ad4:4844:: with SMTP id t4mr10396639qvy.38.1618332013825;
        Tue, 13 Apr 2021 09:40:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id s2sm3493506qke.5.2021.04.13.09.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:40:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lWM5E-005XJN-Qu; Tue, 13 Apr 2021 13:40:12 -0300
Date:   Tue, 13 Apr 2021 13:40:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Benjamin Drung <benjamin.drung@ionos.com>,
        linux-rdma@vger.kernel.org
Subject: Re: rdma-core: Minimum supported Debian & Ubuntu releases
Message-ID: <20210413164012.GJ227011@ziepe.ca>
References: <8d930476e5daf34147a178420596230dfecf2038.camel@cloud.ionos.com>
 <YHQttR48FsDJkuWd@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHQttR48FsDJkuWd@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 12, 2021 at 02:23:33PM +0300, Leon Romanovsky wrote:
> On Mon, Apr 12, 2021 at 12:31:26PM +0200, Benjamin Drung wrote:
> > Hi,
> > 
> > which Debian & Ubuntu releases should rdma-core support? Do we have a
> > policy for that like all LTS versions?
> 
> I don't think that we have a policy for that.

I understand there are still active users on the prior LTS, so I would
prefer to keep that working.

Jason
