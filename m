Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99B7A44AE
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 10:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbjIRI3Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 04:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240833AbjIRI3O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 04:29:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563E78F;
        Mon, 18 Sep 2023 01:29:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EB4C433C8;
        Mon, 18 Sep 2023 08:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695025748;
        bh=I4MBU/4uH3DIkiejuLa8YlBMQjERBUrRdAlU1AeqGEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E/BdUyywT4oXbhnP4Pt69tq8iGu+MHVIfEB2TfBw8MoKJ9w5m/z+GFZQ4LtD+Y1/p
         xElf+AccnC111qLUNjBssJzsqyhNBIZ3JClvyeN42N66G06S2HJgtSrm5u4wUIN8/Y
         RYx4Ru/cLPWTf+LgDVaOv2ynqVQqerjzsQ0NApGqDlFVp6hCsZQLxfhH5XidaIMC1r
         ZKYKo96v4NhKVEPEdMAtdhOUyDuJUAEzEQs9JDZnT47wU1XuaLHR9UwMCYwKsmY+6j
         cybXr0eSYf9/iXbDo0M1YdZVoS8Gd/K7oRy/PTL4WiEhErglJuDvm1HPKrDw5m1yUB
         98GiQ3BmWU3qg==
Date:   Mon, 18 Sep 2023 11:29:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ajay Sharma <sharmaajay@microsoft.com>
Cc:     "sharmaajay@linuxonhyperv.com" <sharmaajay@linuxonhyperv.com>,
        Long Li <longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
Message-ID: <20230918082903.GC13757@unreal>
References: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <20230911123231.GB19469@unreal>
 <BY5PR21MB1394F62601FEFE734181FFF7D6F2A@BY5PR21MB1394.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR21MB1394F62601FEFE734181FFF7D6F2A@BY5PR21MB1394.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 11, 2023 at 06:57:21PM +0000, Ajay Sharma wrote:
> I have updated the last patch to use xarray, will post the update patch. We currently use aux bus for ib device. Gd_register_device is firmware specific. All the patches use RDMA/mana_ib format which is aligned with drivers/infiniband/hw/mana/ .

➜  kernel git:(wip/leon-for-rc) git l --no-merges drivers/infiniband/hw/mana/
2145328515c8 RDMA/mana_ib: Use v2 version of cfg_rx_steer_req to enable RX coalescing
89d42b8c85b4 RDMA/mana_ib: Fix a bug when the PF indicates more entries for registering memory on first packet
563ca0e9eab8 RDMA/mana_ib: Prevent array underflow in mana_ib_create_qp_raw()
3574cfdca285 RDMA/mana: Remove redefinition of basic u64 type
0266a177631d RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter

It is different format from presented here. You added extra space before ":"
and there is double space in one of the titles.

Regarding aux, I see it, but what confuses me is proliferation of terms
and various calls: device, client, adapter. My expectation is to see
more uniform methodology where IB is represented as device.

Thanks

> 
> Thanks
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Monday, September 11, 2023 7:33 AM
> > To: sharmaajay@linuxonhyperv.com
> > Cc: Long Li <longli@microsoft.com>; Jason Gunthorpe <jgg@ziepe.ca>; Dexuan
> > Cui <decui@microsoft.com>; Wei Liu <wei.liu@kernel.org>; David S. Miller
> > <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; linux-
> > rdma@vger.kernel.org; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Ajay Sharma <sharmaajay@microsoft.com>
> > Subject: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
> > 
> > On Thu, Sep 07, 2023 at 09:52:34AM -0700, sharmaajay@linuxonhyperv.com
> > wrote:
> > > From: Ajay Sharma <sharmaajay@microsoft.com>
> > >
> > > Change from v4:
> > > Send qp fatal error event to the context that created the qp. Add
> > > lookup table for qp.
> > >
> > > Ajay Sharma (5):
> > >   RDMA/mana_ib : Rename all mana_ib_dev type variables to mib_dev
> > >   RDMA/mana_ib : Register Mana IB  device with Management SW
> > >   RDMA/mana_ib : Create adapter and Add error eq
> > >   RDMA/mana_ib : Query adapter capabilities
> > >   RDMA/mana_ib : Send event to qp
> > 
> > I didn't look very deep into the series and has three very initial comments.
> > 1. Please do git log drivers/infiniband/hw/mana/ and use same format for
> > commit messages.
> > 2. Don't invent your own index-to-qp query mechanism in last patch and use
> > xarray.
> > 3. Once you decided to export mana_gd_register_device, it hinted me that it is
> > time to move to auxbus infrastructure.
> > 
> > Thanks
> > 
> > >
> > >  drivers/infiniband/hw/mana/cq.c               |  12 +-
> > >  drivers/infiniband/hw/mana/device.c           |  81 +++--
> > >  drivers/infiniband/hw/mana/main.c             | 288 +++++++++++++-----
> > >  drivers/infiniband/hw/mana/mana_ib.h          | 102 ++++++-
> > >  drivers/infiniband/hw/mana/mr.c               |  42 ++-
> > >  drivers/infiniband/hw/mana/qp.c               |  86 +++---
> > >  drivers/infiniband/hw/mana/wq.c               |  21 +-
> > >  .../net/ethernet/microsoft/mana/gdma_main.c   | 152 +++++----
> > >  drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
> > >  include/net/mana/gdma.h                       |  16 +-
> > >  10 files changed, 545 insertions(+), 258 deletions(-)
> > >
> > > --
> > > 2.25.1
> > >
