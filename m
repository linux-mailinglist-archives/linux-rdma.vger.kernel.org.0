Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F034462C4A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2019 01:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfGHXF0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 19:05:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34879 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbfGHXF0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 19:05:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so14366695qke.2
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jul 2019 16:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vUmFyAFJP6D1L/Z0W6cwED3cSN9zX28O4rJsev7br/g=;
        b=bRb1UyQhhgptjB7bucYZcRSjz7loj+ef0exzrWdJceIFhJpq/ZGrTeJsuiTUbRjroa
         aJayTI1PkJi8ioYjoL/VHfat/F5mvH41SZ7dbFxzqTtvvrNgvV47jI76ojZiwJGR2L+/
         ahWrBvONpF7I/fr8NfFXBSxdriirqw50fa72LoU93WaVIddjpip6lYsQMcx15Qdv5zOP
         8cV3tOvz5SIL4f09W7ylbhvTtKx9hNbN3T7HkP5SZOrX/7toWC/L9MYyZG+I/VJChfSv
         sUxeQ69hhBNm5XuOCaUWpyfRRBTcSyS0cqiXTBOWnomJoqK3JbnlulECHr3ikn1pR7Ci
         B+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vUmFyAFJP6D1L/Z0W6cwED3cSN9zX28O4rJsev7br/g=;
        b=a3nCyWCtgMa490vU6z+cPU+HxUIMDL9+TyG710jlP8syBQZ2N3tAnaou2l8h+6kkK+
         wO89klSqMvzIeKRLwMh41CtcPhrTozOzBLg+/ey6vsMuWs6nSttbiTxNTJ3E7grpHyle
         vZyesd/LLuk7Jr9i5TqWi9JZ+IfXd30FW4HMmDpIYVp/5XQiqRmzpKkiyIzSln+I9WgW
         6LM9o2kRGfvWSTImvhfSNZwkwNhDRd/iex7Bv+OaXKwLFKCFinoOeaQYteC/SivHCOXn
         B1UCky4Sm7aFtTHYmUnlyric9UAcyAvqZP0RRBRKXuIT7n7CpuEk+nI/WrKTD9sc2nN0
         YbwQ==
X-Gm-Message-State: APjAAAUQhuY/ZeY7SQpVKNfGjA+t1R4HpJEWo3YgVPq2YriUElyMOCwX
        Cl5/NYl/WjnVqGUD+ASVWkX4Fw==
X-Google-Smtp-Source: APXvYqwLoFmuIZf3Y1cOYKbP3Y7Nc/PproY3j/svvX58aWICZwmpGOOrnNk/oYk8mcSqMwAwgwvs8w==
X-Received: by 2002:a37:a744:: with SMTP id q65mr16071533qke.151.1562627125887;
        Mon, 08 Jul 2019 16:05:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t29sm9359131qtt.42.2019.07.08.16.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 16:05:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkchJ-0003CJ-2J; Mon, 08 Jul 2019 20:05:25 -0300
Date:   Mon, 8 Jul 2019 20:05:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dag Moxnes <dag.moxnes@oracle.com>
Cc:     Mark Bloch <markb@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] RDMA/core: Fix race when resolving IP address
Message-ID: <20190708230525.GI23996@ziepe.ca>
References: <1562584584-13132-1-git-send-email-dag.moxnes@oracle.com>
 <20190708175025.GA6976@ziepe.ca>
 <4b9ae7b8-310c-e0b6-7a8e-33e6d5bef83d@oracle.com>
 <63b9d2cb-f69c-d77c-7803-f08e2a6f755d@mellanox.com>
 <20190708193814.GF23996@ziepe.ca>
 <424b75d7-90ea-8d07-42b9-de9d507b0f85@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <424b75d7-90ea-8d07-42b9-de9d507b0f85@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 08, 2019 at 10:11:29PM +0200, Dag Moxnes wrote:
> 
> 
> Den 08.07.2019 21:38, skrev Jason Gunthorpe:
> > On Mon, Jul 08, 2019 at 07:22:45PM +0000, Mark Bloch wrote:
> > > 
> > > On 7/8/19 11:47 AM, Dag Moxnes wrote:
> > > > Thanks Jason,
> > > > 
> > > > Regards,
> > > > Dag
> > > > 
> > > > Den 08.07.2019 19:50, skrev Jason Gunthorpe:
> > > > > On Mon, Jul 08, 2019 at 01:16:24PM +0200, Dag Moxnes wrote:
> > > > > > Use neighbour lock when copying MAC address from neighbour data struct
> > > > > > in dst_fetch_ha.
> > > > > > 
> > > > > > When not using the lock, it is possible for the function to race with
> > > > > > neigh_update, causing it to copy an invalid MAC address.
> > > > > > 
> > > > > > It is possible to provoke this error by calling rdma_resolve_addr in a
> > > > > > tight loop, while deleting the corresponding ARP entry in another tight
> > > > > > loop.
> > > > > > 
> > > > > > This will cause the race shown it the following sample trace:
> > > > > > 
> > > > > > rdma_resolve_addr()
> > > > > >     rdma_resolve_ip()
> > > > > >       addr_resolve()
> > > > > >         addr_resolve_neigh()
> > > > > >           fetch_ha()
> > > > > >             dst_fetch_ha()
> > > > > >               n->nud_state == NUD_VALID
> > > > > It isn't nud_state that is the problem here, it is the parallel
> > > > > memcpy's onto ha. I fixed the commit message
> > > > > 
> > > > > This could also have been solved by using the ha_lock, but I don't
> > > > > think we have a reason to particularly over-optimize this.
> > > Sorry I'm late to the party, but why not just use: neigh_ha_snapshot()?
> > Yes, that is much better, please respin this
> OK, will do!
> Can I still post it as a v4? Or should I do it differently as you already
> applied it?

post a v4

Jason
