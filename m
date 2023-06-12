Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CADF72D4A2
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbjFLWnn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 18:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjFLWnf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 18:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE869F0;
        Mon, 12 Jun 2023 15:43:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888D961F2D;
        Mon, 12 Jun 2023 22:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8A3C433D2;
        Mon, 12 Jun 2023 22:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686609812;
        bh=JBnyaSL01ZIaD9BxSHKCygGU9ZOWddzqcQnjN+ViNR8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y+dhwf2/ZroIxTkGwW0S2KpBpLyAmhnEDkWq8yrVJBaUmeNTM8chFq3gJGGAI9AJP
         hgMI//H1pDJ47odAmSs2mBJR2CpDMQqiviylWQF8wWxOJvSni8Y4Mbh8LAXR20OxcU
         6Xhm7nJrbOoj0l2hV0O/MUopYZQ1jj1VgkAFYT0F1CwVg2T3QOmJFlDXbUzMR92E5X
         HVXSZcqxVSq0xilwvIoplXESzJcetA9CXlCXMguI3cKCaAJndPxDEi39UqHgpoH0EV
         /yv/QVyVJVoJr2TdG4igeCfEZUJjvTah3/P2T8uGRxR2wSkfztSfGPM1HFOARQ6xzL
         L/1Gs8PyRFmiw==
Date:   Mon, 12 Jun 2023 15:43:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     jiri@resnulli.us, vadfed@meta.com, jonathan.lemon@gmail.com,
        pabeni@redhat.com, corbet@lwn.net, davem@davemloft.net,
        edumazet@google.com, vadfed@fb.com, jesse.brandeburg@intel.com,
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
Message-ID: <20230612154329.7bd2d52f@kernel.org>
In-Reply-To: <20230609121853.3607724-2-arkadiusz.kubalewski@intel.com>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
        <20230609121853.3607724-2-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri,  9 Jun 2023 14:18:44 +0200 Arkadiusz Kubalewski wrote:
> From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> Add documentation explaining common netlink interface to configure DPLL
> devices and monitoring events. Common way to implement DPLL device in
> a driver is also covered.

> +``'pin': [{
> + {'clock-id': 282574471561216,
> +  'module-name': 'ice',
> +  'pin-dpll-caps': 4,
> +  'pin-id': 13,
> +  'pin-parent': [{'pin-id': 2, 'pin-state': 'connected'},
> +                 {'pin-id': 3, 'pin-state': 'disconnected'},
> +                 {'id': 0, 'pin-direction': 'input'},
> +                 {'id': 1, 'pin-direction': 'input'}],
> +  'pin-type': 'synce-eth-port'}
> +}]``

It seems like pin-parent is overloaded, can we split it into two
different nests?

> +SET commands format
> +===================
> +
> +``DPLL_CMD_DEVICE_SET`` - to target a dpll device, the user provides
> +``DPLL_A_ID``, which is unique identifier of dpll device in the system,
> +as well as parameter being configured (``DPLL_A_MODE``).
> +
> +``DPLL_CMD_PIN_SET`` - to target a pin user has to provide a
> +``DPLL_A_PIN_ID``, which is unique identifier of a pin in the system.
> +Also configured pin parameters must be added.
> +If ``DPLL_A_PIN_DIRECTION`` or ``DPLL_A_PIN_FREQUENCY`` are configured,
> +this affects all the dpll device they are connected, that is why those
> +attributes shall not be enclosed in ``DPLL_A_PIN_PARENT``.
> +Other attributes:
> +``DPLL_A_PIN_PRIO`` or ``DPLL_A_PIN_STATE`` must be enclosed in
> +``DPLL_A_PIN_PARENT`` as their configuration relates to only one
> +parent dpll or parent pin.

Also sounds like setting pin attrs and pin-parent attrs should be
different commands.
