Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D654599F98
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 21:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbfHVTN4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 15:13:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39635 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbfHVTN4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Aug 2019 15:13:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id 125so6143494qkl.6
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2019 12:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hTcbphL3iGM/IuVKlnR/JC32HaXe9oC5KzefsdnSU9w=;
        b=dgka0EWTMZdXf6CrDWqDDbaEr5hSxTFK8Fdfi0MrWM8TSSB6foDSavtlRNetANge1Z
         XLtlzkhFlzin2MFayPT7+vDzo6Pnext6eldofaWqbV5ptfcTC1bhEPGizPPkVKv4mtqC
         kkpxhhH5NsZlu9Aqm0JeR5DxYwI1wgICxLg0EsoG+AIn6HaoPvFKH3gAUeUSvH63DOc5
         bm73qRBeto3pVG5Y07I/pQQhMGSWdxR7Dw54pndbVvvbbJB8h7gbNLizaD8TzdZO3xGE
         DCdu3eu17Z4z0LVdvxwJm/ar6TcbZfv9vON6l+8pl2xAgxB9a/8sKjL/IzKgjSygiseD
         AxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hTcbphL3iGM/IuVKlnR/JC32HaXe9oC5KzefsdnSU9w=;
        b=kHe+SG63ocmwU8y8c/v15BuAJxEt0n9rTLJyyTk3sS5xlFSYHaJ43beLgzECkPwexx
         kF7GQSRIKKX+t0WWpI8De1X0+lMXhMhN/6Hr59/bhGVk8+utt50hGCOyTJfugggSeXkB
         5tIjLRn+EZskVwA5K/VaghbhEgYIM+L+8A5Zet/ylYfSxKalAX2b8QKEgjvPMH8mwHOE
         rUUTXeCHqlXGIywFB1Kafjf7OT+6ksH6P0uyH3YmkYwuID9q5masvHqK3I4D3yRjjw46
         3FVlbyTwD0KViskAth/fNWQimAe39946qtuvtSelgbJbBZwrHL4yzgzTLznyvjiZI7O7
         nTrA==
X-Gm-Message-State: APjAAAWGfwUYSofNTfHmWrSIv0cGSe4QNvm7hXxq3LfSUOSPUb7B88ZG
        Y8dXk8Ri2qmBpAQLAZIBmyNBew==
X-Google-Smtp-Source: APXvYqxyrLgPhd1iDtp1LmBdsOmMTFiuDn6vQ+hFyVWo2sglhNfbwEO3yS+rYjab9R1d6pa9m2//MQ==
X-Received: by 2002:a37:9b92:: with SMTP id d140mr499557qke.443.1566501235717;
        Thu, 22 Aug 2019 12:13:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id l80sm339746qke.24.2019.08.22.12.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Aug 2019 12:13:55 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0sWw-0002MK-KO; Thu, 22 Aug 2019 16:13:54 -0300
Date:   Thu, 22 Aug 2019 16:13:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Marcin Mielniczuk <marcin@golem.network>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>,
        linux-rdma@vger.kernel.org
Subject: Re: Setting up siw devices
Message-ID: <20190822191354.GC8339@ziepe.ca>
References: <421f6635-e69c-623d-746a-df541c27f428@golem.network>
 <20190822154323.GA19899@chelsio.com>
 <20190822155228.GH29433@mtr-leonro.mtl.com>
 <bf42725d-d441-0237-9df5-bd39cb981dcc@golem.network>
 <20190822172155.GL29433@mtr-leonro.mtl.com>
 <b46f158f-61c9-b949-9174-ec110dc92f9a@golem.network>
 <20190822183807.GN29433@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822183807.GN29433@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 22, 2019 at 09:38:07PM +0300, Leon Romanovsky wrote:
> On Thu, Aug 22, 2019 at 07:58:56PM +0200, Marcin Mielniczuk wrote:
> > On 22.08.2019 19:21, Leon Romanovsky wrote:
> > > On Thu, Aug 22, 2019 at 07:05:12PM +0200, Marcin Mielniczuk wrote:
> > >> Thanks a lot, this did the trick. I think this is worth documenting
> > >> somewhere that this step is needed.
> > >> I'll make a PR, would README.md in the rdma-core repo be a good place?
> > > I'm not so sure, but it is better to have in some place instead of not having at all.
> > I think it's the first place one would look for some information. I'll
> > make a PR today or tomorrow.
> > >> Does <NAME> have any significance? I did:
> > >>
> > >>      sudo rdma link add siw0 type siw netdev enpXsYYfZ
> > >>
> > >> but the resulting device is called iwpXsYYfZ. I couldn't find a trace of
> > >> `siw0` anywhere.
> > > I would say that it is a bug in kernel part of SIW, because kernel rename
> > > (the thing which change your siw0 to be iw* name) is looking for absence
> > > of mentioning PCI inside of /sys/class/infiniband/siw0/*
> > > https://github.com/linux-rdma/rdma-core/blob/master/kernel-boot/rdma_rename.c#L378
> > I don't have /sys/class/infiniband/siw0 on my system, only
> > /sys/class/infiniband/iwpXsYYfZ.
> > iwp probably comes from iWARP.
> 
> Your iwpXsYYfZ was siw0 before rdma_rename was executed.
> 
> I can't test the patch now, but hope that this change below will fix your problem.

I think we should directly blacklist rxe and siw from
renaming. They can only be created with a user-given name so they
should never ever be renamed.

netlink now returns the driver_id and we can use that to trigger it.

Jason
