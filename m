Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4E99629C0
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 21:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbfGHTiQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 15:38:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45717 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfGHTiQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 15:38:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so14219352qkj.12
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jul 2019 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TylGuspNeCUoW8nua4Sr0QWN1QxRHrGILCPTzFyGjF4=;
        b=PcWw+/z2WHLQiOeNrbXf/1WeVVGWBkKKh4TOwzFaP3xI1R52FemdlSxUyfeSEGKHRG
         BR4TQ+KjWlm1+fndB0979LrQAHfyEKQDrp4GPMXvH4+ezBUZaPcFsSWdlsOz7QLU+drT
         2rh3GD3k+eXKyfnpI44JzhUYTULeEtssA011xCfOkqx4OECoy4VbWXbvlRFcCvdLeMMD
         G5nDmtJ1HlcXNgweqYcWf+akG7KG3x/lPOSu71NqC0AOD7a9mbf4hCmW4Tca+fiFhVqF
         KNF8tWiHmTz2C6af/yTHJY3M5fsUKArdwpE8YScZKt8zEFhsFMircsg2A2XYFAIKGAtJ
         HnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TylGuspNeCUoW8nua4Sr0QWN1QxRHrGILCPTzFyGjF4=;
        b=lgq88e/EJ/Sa1kkm9n1xnre37sBKs9C70hmskyT3qbJjQwjvE2g/9c+JYzqKetbvRS
         U3GemDcYv/v5DrfgbLjCsXP9kugi+FQo0L8p8q7FgCVFHQ6DBp7BobXh0QGkCg8bF5WZ
         3mbBs8fB/5zfai2Xn+A2/4PNjWuzroRK//ZFy4J5d87825rb/fUIfRa8wnRNJuThhUmZ
         OBOD5LVJOFV+nQJtfcig16HsB3w02IJfhG8Lw5Tt8Z/IAWus5WJVgG1Fgt+RkK88C90B
         9hyTyNQ3k62sYkYjcjuGpg5Hd9GRhY89Ng6aI7iyuGo3wpjmvFtEQ+gXG4ST7AtgddN/
         MwOA==
X-Gm-Message-State: APjAAAUd0yPgEjjnhnOWXmiW/S4PrWrLHo/krOlEvTdqiJ1YDE3iLC/x
        kvbhuiIYYEiFGNfRYQ/CtNYagA==
X-Google-Smtp-Source: APXvYqzoODXNa9c/vhGSXNm25Zh7L06C3wnVFa/2fmDj+Mm+Xr6Elcl1puBJDlDWMb4tqDNAH6pPlQ==
X-Received: by 2002:a37:62ca:: with SMTP id w193mr14360785qkb.363.1562614695570;
        Mon, 08 Jul 2019 12:38:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t2sm10048103qth.33.2019.07.08.12.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 12:38:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkZSo-0006yC-Dz; Mon, 08 Jul 2019 16:38:14 -0300
Date:   Mon, 8 Jul 2019 16:38:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mark Bloch <markb@mellanox.com>
Cc:     Dag Moxnes <dag.moxnes@oracle.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] RDMA/core: Fix race when resolving IP address
Message-ID: <20190708193814.GF23996@ziepe.ca>
References: <1562584584-13132-1-git-send-email-dag.moxnes@oracle.com>
 <20190708175025.GA6976@ziepe.ca>
 <4b9ae7b8-310c-e0b6-7a8e-33e6d5bef83d@oracle.com>
 <63b9d2cb-f69c-d77c-7803-f08e2a6f755d@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63b9d2cb-f69c-d77c-7803-f08e2a6f755d@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 08, 2019 at 07:22:45PM +0000, Mark Bloch wrote:
> 
> 
> On 7/8/19 11:47 AM, Dag Moxnes wrote:
> > Thanks Jason,
> > 
> > Regards,
> > Dag
> > 
> > Den 08.07.2019 19:50, skrev Jason Gunthorpe:
> >> On Mon, Jul 08, 2019 at 01:16:24PM +0200, Dag Moxnes wrote:
> >>> Use neighbour lock when copying MAC address from neighbour data struct
> >>> in dst_fetch_ha.
> >>>
> >>> When not using the lock, it is possible for the function to race with
> >>> neigh_update, causing it to copy an invalid MAC address.
> >>>
> >>> It is possible to provoke this error by calling rdma_resolve_addr in a
> >>> tight loop, while deleting the corresponding ARP entry in another tight
> >>> loop.
> >>>
> >>> This will cause the race shown it the following sample trace:
> >>>
> >>> rdma_resolve_addr()
> >>>    rdma_resolve_ip()
> >>>      addr_resolve()
> >>>        addr_resolve_neigh()
> >>>          fetch_ha()
> >>>            dst_fetch_ha()
> >>>              n->nud_state == NUD_VALID
> >> It isn't nud_state that is the problem here, it is the parallel
> >> memcpy's onto ha. I fixed the commit message
> >>
> >> This could also have been solved by using the ha_lock, but I don't
> >> think we have a reason to particularly over-optimize this.
> 
> Sorry I'm late to the party, but why not just use: neigh_ha_snapshot()?

Yes, that is much better, please respin this

Thanks,
Jason
