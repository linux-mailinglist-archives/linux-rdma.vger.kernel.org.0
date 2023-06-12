Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3193472D464
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 00:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbjFLWaP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 18:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFLWaO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 18:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E211711;
        Mon, 12 Jun 2023 15:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 266C4623BE;
        Mon, 12 Jun 2023 22:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67924C433EF;
        Mon, 12 Jun 2023 22:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686609012;
        bh=HQnlbzZUfjB/XyMKV/Pff7qFeZo/3cJ/CnEb78gnOaI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XdqxVWlWiOFaY6qpOuYHwuuvlHM7zcg9rPKu6KiAAbevMNUUwAkWzrcwoYHW+SFkv
         0RdDRP3wO61kOe0UW2J+/BrtdqG4g2fOeKhNHfBEz/+TCNiefXbP6Zx9j6DYf+zrMr
         dGcLnonh+gR+8dxCzB1uy9tuV1HwRV9fmHWw6/igiKha4+8Aott1Py/0SKOID4euYM
         r+Eg2k9yWFcNhD/dCzWY/qRAFvTnFayS2eiewgFXsACrsgqzEKQ2ar2qs0UT6a+CMr
         VW1KtJupKoofTY0S32gugPFWpcjvMeaRCVZHIVB5BpgsZ/LYbjF2lGBjJSeG+YnXep
         AhXnBtLNjesdQ==
Date:   Mon, 12 Jun 2023 15:30:09 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        vadfed@meta.com, jonathan.lemon@gmail.com, pabeni@redhat.com,
        corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
        vadfed@fb.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
        ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
        michal.michalik@intel.com, gregkh@linuxfoundation.org,
        jacek.lawrynowicz@linux.intel.com, airlied@redhat.com,
        ogabbay@kernel.org, arnd@arndb.de, nipun.gupta@amd.com,
        axboe@kernel.dk, linux@zary.sk, masahiroy@kernel.org,
        benjamin.tissoires@redhat.com, geert+renesas@glider.be,
        milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com,
        hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org,
        idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com,
        phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, poros@redhat.com,
        mschmidt@redhat.com, linux-clk@vger.kernel.org,
        vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH v8 01/10] dpll: documentation on DPLL subsystem
 interface
Message-ID: <20230612153009.5f0e1b4a@kernel.org>
In-Reply-To: <ZISkvTWw5k74RO5s@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
        <20230609121853.3607724-2-arkadiusz.kubalewski@intel.com>
        <ZISkvTWw5k74RO5s@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, 10 Jun 2023 18:28:45 +0200 Jiri Pirko wrote:
> Fri, Jun 09, 2023 at 02:18:44PM CEST, arkadiusz.kubalewski@intel.com wrote:
> >From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> >
> >Add documentation explaining common netlink interface to configure DPLL
> >devices and monitoring events. Common way to implement DPLL device in
> >a driver is also covered.
> >
> >Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> >Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> >---
> > Documentation/driver-api/dpll.rst  | 458 +++++++++++++++++++++++++++++
> > Documentation/driver-api/index.rst |   1 +
> > 2 files changed, 459 insertions(+)
> > create mode 100644 Documentation/driver-api/dpll.rst  
> 
> Looks fine to me. I just wonder if the info redundancy of this file and
> the netlink yaml could be somehow reduce. IDK.

Certainly possible, I even talked to Peter of the pyroute2 fame about
this. Should be fairly easy to generate a .rst file, and/or Sphinx
plugin to go directly from the YAML. Is it on my TODO list? Nope :)
