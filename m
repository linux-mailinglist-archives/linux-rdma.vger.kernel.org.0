Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B131DA60A
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 02:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgETAEb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 20:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgETAEa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 20:04:30 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EB4C061A0E
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 17:04:29 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f13so1928063qkh.2
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 17:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5sNitz92MrA39uqFZBpKvTrn9RC79GUXxxl52MJeSIc=;
        b=WQqTjno4J4/GrfwBKh8GPl9owqT1w1ul0g7xIoRukgyGCwEZvVCFDPMViCru3Xwvup
         YVYkWg4xtlY87/f+lMt/rlyX9vp8TPpAknyuPTYh+mGcJJm6Z5zgMvW/IZ+5xggBg4d9
         rE5EsVwpm7GPf+cXq6sW79kWQjoBb8NC0GhrXW8dPYPCs2WI9A+smY6U40is9xmhigOz
         K/LJdIF1e/7XzP2wyG8cSkR0gUCRJmLxysts+QnsG2taEsZYilwqGckF+LP2o+YGspOk
         +0GPwCAE5/WVRIe1j7/kMWMs4KhqCHKj/CB95+3FvPcSgOjPxJB85LOjNVdoRpuCa6Ak
         tdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5sNitz92MrA39uqFZBpKvTrn9RC79GUXxxl52MJeSIc=;
        b=B4vrBapXxkg83+3MEPweMgtYA1L38K2CGDk15W5kzBBzfEY86wDvIwLf+uKqB9fcXv
         UCS8SAC4170SkW2oHfrLrGM8PDpzxWxrwK7DM9Mo547NmUHxeb1CAFzUH1gkKmjR8uwM
         M1Oh5KyezQ9meb4Yq5yeZ0NTJaQB/44e0wwwrRrNbpCVDc2p1ifdByK81l0Jb9jnVCgU
         SulUuXcPtbhyGef101z+mDR0jcdV/3vjt9B1z67CpKFY7gXwFf5Aofvrx+DKtydF5STU
         6M/Jth0Za38vQdeqCY7wLS64lzYGPnuhMJKdvmeD16buex2JRkg/87rwXjSetZUYOoyX
         Ssjw==
X-Gm-Message-State: AOAM532qnu7ajgE1BnOFvqL2PmrSCVsjSN155IY8O9eMgw79p6/dfaxC
        SggsBrrM4cuSpCMtQzSpXYY0jA==
X-Google-Smtp-Source: ABdhPJytH7UymnzhVJoc/G7R4GUKrlc5HMoXHtWN+hZtFwzJl1ct46haUgU2qEk3fz78O54hFtNONQ==
X-Received: by 2002:ae9:e416:: with SMTP id q22mr329545qkc.12.1589933069134;
        Tue, 19 May 2020 17:04:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id e26sm831860qka.85.2020.05.19.17.04.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 17:04:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbCDk-0001m8-B1; Tue, 19 May 2020 21:04:28 -0300
Date:   Tue, 19 May 2020 21:04:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next v2 1/2] RDMA/efa: Fix setting of wrong bit in
 get/set_feature commands
Message-ID: <20200520000428.GA6797@ziepe.ca>
References: <20200512152204.93091-1-galpress@amazon.com>
 <20200512152204.93091-2-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512152204.93091-2-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 06:22:03PM +0300, Gal Pressman wrote:
> When using a control buffer the ctrl_data bit should be set in order to
> indicate the control buffer address is valid, not ctrl_data_indirect
> which is used when the control buffer itself is indirect.
> 
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_com_cmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

No fixes line??

Jason
