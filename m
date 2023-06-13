Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92A172E89D
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 18:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjFMQiG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 12:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFMQiG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 12:38:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275C11989;
        Tue, 13 Jun 2023 09:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACE9963860;
        Tue, 13 Jun 2023 16:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04ABDC433D9;
        Tue, 13 Jun 2023 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686674284;
        bh=bma3arsPpRb//8pgoNM3rtYZA2qY8vvDp0ehgi/2gxk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m02aDZlxwJWg1TkGHhSEydUAGQyDn4VxaaFu+EAhFrOxQMpNTldfJGa9j8xIBoG3+
         dxsatRKFdTMSBGr5VzPwoFEcxZ3BSi6jf5hud+okZsVHlU4ppKQrtlHqhW01LP4Fsm
         EPXKjnT/ftGpTf2OYAolq6OVhZY/CIgv7+xZ1W3PofzoctoQR+xbCs7QTaodX8F2Zr
         We9aC2q6rKEWOG3svpB2gaZmG3164+4RsciO/5PyySG+bDzw/oJJsB/wZrCEb+5K8n
         hKOX0x1y0Gy9452eBu2wfBOD3Eu3zkyv9YESl18ZnxR2IgRY/PH6xC2TOsfSb6tm1D
         X9ZdgJgd/PDyw==
Date:   Tue, 13 Jun 2023 09:38:01 -0700
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
Message-ID: <20230613093801.735cd341@kernel.org>
In-Reply-To: <ZIg8/0UJB9Lbyx2D@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
        <20230609121853.3607724-2-arkadiusz.kubalewski@intel.com>
        <20230612154329.7bd2d52f@kernel.org>
        <ZIg8/0UJB9Lbyx2D@nanopsycho>
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

On Tue, 13 Jun 2023 11:55:11 +0200 Jiri Pirko wrote:
> >> +``'pin': [{
> >> + {'clock-id': 282574471561216,
> >> +  'module-name': 'ice',
> >> +  'pin-dpll-caps': 4,
> >> +  'pin-id': 13,
> >> +  'pin-parent': [{'pin-id': 2, 'pin-state': 'connected'},
> >> +                 {'pin-id': 3, 'pin-state': 'disconnected'},
> >> +                 {'id': 0, 'pin-direction': 'input'},
> >> +                 {'id': 1, 'pin-direction': 'input'}],
> >> +  'pin-type': 'synce-eth-port'}
> >> +}]``  
> >
> >It seems like pin-parent is overloaded, can we split it into two
> >different nests?  
> 
> Yeah, we had it as two and converged to this one. The thing is, the rest
> of the attrs are the same for both parent pin and parent device. I link
> it this way a bit better. No strong feeling.

Do you mean the same attribute enum / "space" / "set"?
In the example above the attributes present don't seem to overlap.
For user space its an extra if to sift thru the objects under
pin-parent.

> >Also sounds like setting pin attrs and pin-parent attrs should be
> >different commands.  
> 
> Could be, but what't the benefit? Also, you are not configuring
> pin-parent. You are configuring pin:pin-parent tuple. Basically the pin
> configuration as a child. So this is mainly config of the pin itsest
> Therefore does not really make sense to me to split to two comments.

Clarity of the API. If muxing everything thru few calls was the goal
we should also have very few members in struct dpll_pin_ops, and we
don't.
