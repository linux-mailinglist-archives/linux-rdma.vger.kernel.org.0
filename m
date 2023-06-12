Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4948C72D52A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 01:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFLXtI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 19:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjFLXtH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 19:49:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92EF101;
        Mon, 12 Jun 2023 16:49:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B574618F6;
        Mon, 12 Jun 2023 23:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBE1C433EF;
        Mon, 12 Jun 2023 23:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686613745;
        bh=yIRi0WXE4Net4p4k+Jwnbq1wiuvuUouDv0057sNyh8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pATI2xnVISuzMZb0xj8Z0Dh8wi/xUu264Dagb7GZ18oJGWd0UDTfUnpFyrkKxTn49
         KnH5MJO1+0YIs8eeunryQEtM3/Lr/oI7DWX8tWHda1pmlG2nOr8St15FcWk/p4OZ4t
         HCt5lsQYkPCIZjdFOD8Fhgt8+2qGu13uXTiB663Ti3QiHFr3VPcNcdfC16dOQHt783
         E1EjRnwQzQ5ZwrEVGKXkTK5RSe9V/3IE3SDMqCoedd4mXEM+IxjIOzw7mrg27+s+/i
         qrBeNUPnL1ved78C/i8rKikra3VLoUpLIthzyRVEDsEIX0OkHLGwtXev5H3gk+yB16
         mJ86IHEFRAgDg==
Date:   Mon, 12 Jun 2023 16:49:02 -0700
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
Message-ID: <20230612164902.073544e2@kernel.org>
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
> +Every other operation handler is checked for existence and
> +``-ENOTSUPP`` is returned in case of absence of specific handler.

EOPNOTSUPP
