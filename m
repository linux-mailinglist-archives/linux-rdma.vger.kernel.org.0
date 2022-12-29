Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ADC6589D1
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Dec 2022 08:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiL2HCx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Dec 2022 02:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiL2HCw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Dec 2022 02:02:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5919C12604;
        Wed, 28 Dec 2022 23:02:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DA46615FC;
        Thu, 29 Dec 2022 07:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0DCC433D2;
        Thu, 29 Dec 2022 07:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672297369;
        bh=ZuXJhWxTiKK7rNV5+l64eAbjpD7WZx3v0R5AYbUoqOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=msZEjdMQFLp6RpIcuVr6Z/h76NOyUxXFChn2R69b9AQdizE2lkG5d+sozkDgu8Ngo
         CmuMZ1CP0rWTOxLhijuvMv+mao7wspAlchrjQyCV5JpnJzhw5tZT7RpFKZNmanK39l
         Ze1vflbh2xldEE1sjXV5mv9+Mn3ljI6ii7W5vNcALSb1x+BBJuS8StH/IK1SSPrlb7
         cDM9Ak9AWGQwoIucVJsVU/j1IymNIAfXfTnsWy1tl+5j33q2PjtTX/l1wVttrm2Wtg
         z/76m+thVJWXiKN8riGAHG61W7o4Q9nrtdvi9F+qSb9XoX6EM7SCws3tUiWmXg+Oyv
         z0n9v0hc5AS9w==
Date:   Thu, 29 Dec 2022 09:02:45 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [PATCH for-next v3 1/7] RDMA/rxe: Convert triple tasklets to use
 workqueue
Message-ID: <Y607lVbzs9PTd0m+@unreal>
References: <cover.1671772917.git.matsuda-daisuke@fujitsu.com>
 <d2f6b3aca61fe1858a97cda94691eece6b0e60bd.1671772917.git.matsuda-daisuke@fujitsu.com>
 <53a2fca7-d98a-acef-8b18-d36a5a16d176@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a2fca7-d98a-acef-8b18-d36a5a16d176@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 28, 2022 at 10:56:11AM -0600, Bob Pearson wrote:
> On 12/23/22 00:51, Daisuke Matsuda wrote:
> > In order to implement On-Demand Paging on the rxe driver, triple tasklets
> > (requester, responder, and completer) must be allowed to sleep so that they
> > can trigger page fault when pages being accessed are not present.
> > 
> > This patch replaces the tasklets with a workqueue, but still allows direct-
> > call of works from softirq context if it is obvious that MRs are not going
> > to be accessed and there is no work being processed in the workqueue.
> 
> There are already at least two patch sets that do this waiting to get upstream

I don't see any unhandled RXE series, except of this one patch [1],
which is one out larger series.

[1] https://patchwork.kernel.org/project/linux-rdma/patch/20221029031331.64518-1-rpearsonhpe@gmail.com/

> Bob
