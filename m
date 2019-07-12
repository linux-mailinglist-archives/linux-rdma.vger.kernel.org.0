Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2604B67473
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfGLRmW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 13:42:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35095 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfGLRmV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 13:42:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so8957262qto.2
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3O32Kyq6oSJ1qa7toJHZZ9UJwAgNuju3KRmfxEHI8bQ=;
        b=LC5r0LDDWh4BCxxQAgMDccQsgHNbKdSIzUaME2cre/oHB3xGOfm5djQo5dU71oDT20
         0kihFyTgPyY1P6nXSAF3hhpaSbHw3cixIdOyJFNDPSTdx/9z6pQgN8KTogdgIxpumS2G
         SL/nu+SYkLsC7Jk2Wsh8ntoveNraL10w9ipdraGe6hnPVGJXczioSrTwBYNV10HfFL8H
         5YAyvHrRVuCfmgMxbuhbyFQbS6keetepHK8XxE/MtdF5kR29KXTtmlNOVMkD/kgxK3VO
         7lotP2jZLki0wZrXVOx77+ww11yFk6BAy7LDmfErx7QsqWFgocmFvvn6JsxytcuyZA/K
         OdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3O32Kyq6oSJ1qa7toJHZZ9UJwAgNuju3KRmfxEHI8bQ=;
        b=j+PF6K/srVkI6Oxc2MT4og66m1ZHIuGqdh0+f77NUPKgFVmPD4v0i9YcmIoKxUYU9Y
         Jsvabc4708ULBD1h72ipTAcIaCMNzzUHUCpxxg+uEliodPWlw6tn5gWtOYvVIzBR/XQA
         SW3FpXLfwBX+sghmvg/Dd8YLAJMl7LVWfRTtPU5D0rAQWGpmCr9XQ5UOOUHXmfou3fqa
         r2jvEAAH+gGrwUVhC2WogjZj9mfjPOxBmgxG/90weWRqVp6ILbiTMt7AtURmQ0GNnmfS
         PC4za18GqZgg9+YtdWonidwpnojBySwfkxoSOVJvL1mb/t7aHhBDDOq2ssxSl4KlOkqe
         qXmw==
X-Gm-Message-State: APjAAAUGFAztIBcucQvzK9FI3eiy8Dow5ccttR0TP5n/ntz1yrAtPMcC
        SB3ANEohxiA0JJIUvMfrGd+p4BbcZYVZ7w==
X-Google-Smtp-Source: APXvYqwsq+dBel5Hn8pHqLq0F0nE+qD0pvdFMR/gu9SpDJgObwHHtFiugfMDsGXPAyVOZ2RX5wfsrw==
X-Received: by 2002:ad4:4a92:: with SMTP id h18mr7877218qvx.235.1562953341056;
        Fri, 12 Jul 2019 10:42:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i27sm3818246qkk.58.2019.07.12.10.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 10:42:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlzYq-0003pT-5V; Fri, 12 Jul 2019 14:42:20 -0300
Date:   Fri, 12 Jul 2019 14:42:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Parav Pandit <parav@mellanox.com>, Yi Zhang <yi.zhang@redhat.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: regression: nvme rdma with bnxt_re0 broken
Message-ID: <20190712174220.GL27512@ziepe.ca>
References: <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com>
 <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ef6a01a1-9163-ef4e-29ac-4f4130c682f1@redhat.com>
 <AM0PR05MB48666463325E1D0E25D63F57D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20190712154044.GJ27512@ziepe.ca>
 <CA+sbYW0F6Vgpa5SQX+9ge4EwWrMkJ4kQ-psEq11S00=-L_mVhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW0F6Vgpa5SQX+9ge4EwWrMkJ4kQ-psEq11S00=-L_mVhg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 09:59:38PM +0530, Selvin Xavier wrote:

> > bnxt guys: please just delete this duplicate detection code from the
> > driver. Every GID provided from the core must be programmed into the
> > given gid table index.
> 
> Jason,
>  This check is required in bnxt_re because the HW need only one entry
> in its table for RoCE V1 and RoCE v2 Gids.

The HW doesn't have a 'GID table' if it has this restriction. It
sounds like it has some 'IP table' or maybe 'IP and VLAN' table?

So the driver must provide a full emulated 'GID Table' with all the
normal semantics.

Which looks sort of like what the add side is doing, other than the
mis-naming it seems reasonable..

But then I see this in re_create_ah:

	/*
	 * If RoCE V2 is enabled, stack will have two entries for
	 * each GID entry. Avoiding this duplicte entry in HW. Dividing
	 * the GID index by 2 for RoCE V2
	 */
	ah->qplib_ah.sgid_index = grh->sgid_index / 2;

Which seems completely wrong - that is making assumptions about the
layout of the gid table that is just not allowed.

Surely it needs to access the per-gid driver context that add_gid set
and use the index into the sgid_table from there?

Jason
