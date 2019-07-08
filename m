Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74F0D62A48
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 22:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfGHUVW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 16:21:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39363 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfGHUVW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 16:21:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9so11098490qtu.6
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jul 2019 13:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uGUexmg19BQ5o3cTUt7gbXT8NPNcF9rjZU3MKCTYQ2A=;
        b=HFH2TTnznzffVtbpD8eyHpB6LLrz4fbzX04lz/Y69ZIbQx1rKC5T6vH4NxG/z01d66
         f5tZUJEMlFOb+nWPsLsS0uSAJA3W14kkhbNU//kAgN7Geoc/G90kc13gx542mmxvjAGN
         QhBNnlNk5UHQQOUWCkxnFNFnCoMb9yN98mvzonIosAk56CXFaDpxkxXSJMbJWNGmO3pz
         L6U60vWJfzRPdS2WYmZgN9qOWAaDZMYD/GB2r1+/nURNlziNg7rlLebsi83CsBuWDSG6
         T0EFMoX0XBuHdT3ydL0X2b2i9F9KMq3VAyqwDDMJ8sKofyADpY8jMabJjtg/0sk3Pqfi
         gBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uGUexmg19BQ5o3cTUt7gbXT8NPNcF9rjZU3MKCTYQ2A=;
        b=ncuySwOF9c1qcNrKnjyzF6s5hgB2ECG2zwU+b8rTRulqEpKY3sFWHRfmBVa/aWhYq2
         +iCbWGW+bYaJBmN5/rU3RGADDkz1erzmQOk1f5CdAmbVGOXbzAKgVQWJNjt0xwpXo0/n
         reqKrEmWrRdMHihTUs9Yyrz/qHzZ7NK/R26IIOBlsTOuEVugEXtvGja1tcqsODwVPgIe
         CdEfWcFpInpCd/OuZgJ7ZzEd6te17nU1+qrJJ51x0qKu9HYo9VjTt+qJvFUxCiEFbMzx
         DcEeAso6D6UDmDGuIVetVSPnPaCgFjHnVw8fb8InybJ1uqpqz7aTcNuetK9tXzYqkspy
         JSew==
X-Gm-Message-State: APjAAAVZJuBW5Efjqt54ADJwkRRLZzyMvTW8FKthVkPAjaTPIhLAx+v5
        BFmFwNogwWi8FQWB/F8M2tVvaA==
X-Google-Smtp-Source: APXvYqwUHO+QnIV/KQ4nySaWO4i9/IEuq/CjVAseR/T9GsRqJ/rHQDVuguHDBuM/RGKMvmdnoNlWjA==
X-Received: by 2002:ac8:264f:: with SMTP id v15mr15496098qtv.51.1562617281497;
        Mon, 08 Jul 2019 13:21:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o18sm5486978qtb.53.2019.07.08.13.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 13:21:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hka8W-0002FY-E8; Mon, 08 Jul 2019 17:21:20 -0300
Date:   Mon, 8 Jul 2019 17:21:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH rdma-next 0/2] Allow netlink commands in non init_net net
 namespace
Message-ID: <20190708202120.GA8200@ziepe.ca>
References: <20190704130402.8431-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704130402.8431-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 04, 2019 at 04:04:00PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Now that RDMA devices can be attached to specific net namespace,
> allow netlink commands in non init_net namespace.
> 
> Parav Pandit (2):
>   IB/core: Work on the caller socket net namespace in
>   nldev_newlink()

I applied the first one to for-next

>   IB: Support netlink commands in non init_net net namespaces

The second needs a resend

Thanks,
Jason
