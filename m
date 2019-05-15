Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5F01E657
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 02:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfEOAfv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 20:35:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44115 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfEOAfu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 20:35:50 -0400
Received: by mail-qk1-f194.google.com with SMTP id w25so433604qkj.11
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 17:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qNHaeoLEAGYAIQIfPO6/7xvviraFGoGGHyW0Hh1rhUM=;
        b=UH6Mt+0hS80TGDtkhdDSlwBqa+e3DeRzzRGEgPSeQmqrIvNdLuPhlX+gX89AKDWSr5
         6aIzXMoSeiA1HEoEStZ7blhdB1BxrLu1x3pFs6DPs/4ewzTrRJn4iLH/sR0XDBCnsgXN
         LwOi/w/+7eTgouSD58XS7S6MJn1TxkBcwkWltDlT6ND5NBPFUR7qbKPkfQA4QPx479Dc
         V5V4Mt3ypLIQlHjJPemTB4JL645W1hZdmUrzwTU6swft2xt2o0Mgf+5MUXa/rQsoywdS
         VEx2aEFvop/5vwGkCJUqSRjlqCmr4Nnvcxlo8QDFK7t7e66PX4w2NxjemQBpqxta8dUo
         TIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qNHaeoLEAGYAIQIfPO6/7xvviraFGoGGHyW0Hh1rhUM=;
        b=PC+OWf9UHILae97BLiw9e+fjlY3kolQtpO4mQK1YU1BvWv24CzkZ8kAJ59llCYrqms
         SRle8WfD1nBNLTg52DJQFgULD6szjqOvV/cNCVfTzErARY8ixsVSUVrRo6hDGr8wi3Jx
         mJzcto7ku/barnsht9cEPSu7oRTPUyQT4UbVPov08397p+ygnCYOO10YeZD5sC/QJQEV
         zrqC/iTsonGI8oN3C3QtiLW0kopj37d2oRL6ibMe3eYSII9yw7Amskhlr9VbL3Au1W0g
         Ym5suYat3XMuQn3QIpDQdf/gfSwgdBtGRpvCG+uPb1qCjhhrltasb18H94pPDPWPc4zB
         lF8Q==
X-Gm-Message-State: APjAAAW2/m2UMHXAF9xjDvWumyeIbI2KOh9bc6Lgltvk5zVQBGzUs30J
        lpRfGLfyRIbwAkskvE443OJcqQ==
X-Google-Smtp-Source: APXvYqwDTNTQgNOynApfakBF5i9F/989+fRdN4H8Teasru7z63xVOGepPmzRjSlUuGsjUE3Y635bHQ==
X-Received: by 2002:a05:620a:3:: with SMTP id j3mr13400449qki.95.1557880550330;
        Tue, 14 May 2019 17:35:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id b11sm299730qtt.6.2019.05.14.17.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:35:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhtd-0001tN-G4; Tue, 14 May 2019 21:35:49 -0300
Date:   Tue, 14 May 2019 21:35:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/core: Change system parameters callback
 from dumpit to doit
Message-ID: <20190515003549.GA7248@ziepe.ca>
References: <20190513052657.31436-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513052657.31436-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 13, 2019 at 08:26:57AM +0300, Leon Romanovsky wrote:
> From: Parav Pandit <parav@mellanox.com>
> 
> .dumpit() callback is used for returning same type of data in the loop,
> e.g. loop over ports, resources, devices.
> 
> However system parameters are general and standalone for whole
> subsystem. It means that getting system parameters should be doit
> callback.
> 
> Fixes: cb7e0e130503 ("RDMA/core: Add interface to read device namespace sharing mode")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> Jason, Doug
> 
> It will send extra complexity with kernel-headers updates
> if this patch goes as part of second PR to Linus in this merge
> window.
> 
> Thanks
> ---
>  drivers/infiniband/core/nldev.c  | 27 +++++++++++++++------------
>  include/uapi/rdma/rdma_netlink.h |  2 +-
>  2 files changed, 16 insertions(+), 13 deletions(-)

Okay, applied to for-next

Jason
