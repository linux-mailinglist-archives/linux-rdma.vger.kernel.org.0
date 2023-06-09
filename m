Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AA072A6B8
	for <lists+linux-rdma@lfdr.de>; Sat, 10 Jun 2023 01:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjFIX2j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 19:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjFIX1t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 19:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954DE3ABF;
        Fri,  9 Jun 2023 16:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2250565CD2;
        Fri,  9 Jun 2023 23:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABABC433D2;
        Fri,  9 Jun 2023 23:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686353262;
        bh=LhcK1dVS/ODURx+/PKNTsLc8985DDWmW1YmahU/XwI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oe+mJXeo6zzuE2GSIILaWA014EJ0/y1TG6erjhnN7raTZqCGevhGZBjVONwYd565u
         LaIlt5Da9w3UC2npEHEhdbpajaiMq/BT7IUZb88vq7nVNODU9P3kfw6KRCJpmCSaqi
         L8yC0LVf9b10zxZiFcQt0czKjDNS0z43jMTp3npICWRs9hdsh+8maPXv0pJt400qlv
         dUXvUk/lc4raRvB2SnN6cJ3ifJqFMe3tQATshe4JaxB3EkJFUdoektHcksejFzHiVv
         zAaDW+7TKjtn0y6kKOSoW8QCABYxGwaeg9DiYAo3JXufGmDfESe2CuglPmIN2KEqrO
         HoxeBwhXY0BcA==
Date:   Fri, 9 Jun 2023 16:27:39 -0700
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
Subject: Re: [RFC PATCH v8 00/10] Create common DPLL configuration API
Message-ID: <20230609162739.0d94a704@kernel.org>
In-Reply-To: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri,  9 Jun 2023 14:18:43 +0200 Arkadiusz Kubalewski wrote:
> Implement common API for clock/DPLL configuration and status reporting.
> The API utilises netlink interface as transport for commands and event
> notifications. This API aim to extend current pin configuration and
> make it flexible and easy to cover special configurations.
> 
> Netlink interface is based on ynl spec, it allows use of in-kernel
> tools/net/ynl/cli.py application to control the interface with properly
> formated command and json attribute strings. Here are few command
> examples of how it works with `ice` driver on supported NIC:

Now I see why you sent the ynl-gen patch you sent :) It's the
combination of nest and multi-attr which doesn't populate the right
policy. Also the enums are not policed right by ynl-gen.

I pushed two fixes to my local tree:
https://github.com/kuba-moo/linux/commits/ynl-c
in case you need them. I'll submit them on Monday.

I also tried to run the user space C code gen (for generating C
API/lib as described in [1]). It seems to work just fine, FWIW, so
just LMK if C bindings would be useful, I can give more instructions.

[1] https://docs.kernel.org/next/userspace-api/netlink/intro-specs.html#ynl-lib
