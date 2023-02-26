Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FD26A2F81
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Feb 2023 13:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBZMx0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Feb 2023 07:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBZMxZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Feb 2023 07:53:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39307A9B
        for <linux-rdma@vger.kernel.org>; Sun, 26 Feb 2023 04:53:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 860EFB80B7C
        for <linux-rdma@vger.kernel.org>; Sun, 26 Feb 2023 12:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14CCC433EF;
        Sun, 26 Feb 2023 12:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677416002;
        bh=C+BQHsCSez+9QQ6sKV2Bh3pHfPzBnCtDG4hSJpvOYcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Us+rRjBU1K2p8r1mIYfepcB3EJRli+X/QkEOUg7grq5bODjKaeykCcAl3o3yY4ddY
         gg2HefD/jgDvYqRTCkq8ey+BGc33iq8mn3l3MHsxjsQkbLwCBo8I/MlNKKKPZA9134
         8L1xC3barfyW7whfP7r/7Vc89eEjROM+TF22ti5z/VyaJiRXwkuJ71uIIaqVynsaZA
         gp3smWWdeU/s1FxqTMNfb1t9TFO2vey/WkE37AwvXDuEubVDUF5ScR6FTA2oe+aiza
         LnDrOZaVNpqRP7j1vo1PtpVkeSKEbGoYNblHjv8ZcUB4SIYND7RTXhG1pmbuWnpzWv
         ofHDKcddfxUhA==
Date:   Sun, 26 Feb 2023 14:53:18 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "huangjunxian (C)" <huangjunxian6@hisilicon.com>,
        Mark Bloch <markb@nvidia.com>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: A question about FAILOVER event in RoCE LAG
Message-ID: <Y/tWPpJNz3EHtMgB@unreal>
References: <26b0d23202814f60b994ce123830353d@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b0d23202814f60b994ce123830353d@hisilicon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

+Mark

On Fri, Feb 24, 2023 at 11:14:47AM +0000, huangjunxian (C) wrote:
> Hi folks!
> 
> We've been working on LAG in hns RoCE driver, and we notice that when a FAILOVER event
> occurs in active-backup mode, all GIDs of the RDMA bond device are deleted and new GIDs
> are added, triggered by the event handler listed below.
> 
> So, when a FAILOVER event occurs on a RDMA bond device with running traffic, does it make
> sense that the traffic is terminated since its GIDs are deleted?
> 
> The FAILOVER event handler mentioned above:
> static int netdevice_event(struct notifier_block *this, unsigned long event, void *ptr)
> {
>          ......
>          static const struct netdev_event_work_cmd bonding_event_ips_del_cmd = {
>                   .cb = del_netdev_upper_ips, .filter = upper_device_filter};
>          ......
>          switch (event) {
>          ......
>          case NETDEV_BONDING_FAILOVER:
>                   cmds[0] = bonding_event_ips_del_cmd;
>                   /* Add default GIDs of the bond device */
>                   cmds[1] = bonding_default_add_cmd;
>                   /* Add IP based GIDs of the bond device */
>                   cmds[2] = add_cmd_upper_ips;
>                   break;
>          ......
>          }
>          ......
> }
> 
> Thanks,
> Junxian
