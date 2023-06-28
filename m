Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67026741A89
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jun 2023 23:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjF1VSN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jun 2023 17:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjF1VRz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Jun 2023 17:17:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE549C3;
        Wed, 28 Jun 2023 14:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 873C861493;
        Wed, 28 Jun 2023 21:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441FDC433C8;
        Wed, 28 Jun 2023 21:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687986716;
        bh=koy1OSVClFvab/lF2oDpHJ8TmCs3jlviG8/MsiVo+Go=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rvmuZcGln587JyJuaJDrT+al7I2gKijxRz621UF4LqnsGqSeDrahvWqCqKroQFFhq
         ApOTUfy0a8iGFpGGntTJg1TBl3dd9VVM8kUAudJeLfkoLsujBbbfd4JPiP8Ht87M2m
         pZARl4XrdTylp3oTBYox5IqPadcRQ0OVbZKdqen7tQ25qtu5Em2rNL24xj+t1EhEIk
         p/qPwnfXtf3QwA6x4qizYyRkXUyEoPKUnCGRsvQKH8qIE+aA1FP8WB4m/VFCP3Wwla
         I6YJMAa9btFARFeIQxjsHsoBB9z/pa1AIHRNMGTj4+TSQGkzmtCk9p/+Kq9gov7Yiv
         q5jljPvmNR1nA==
Date:   Wed, 28 Jun 2023 14:11:53 -0700
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
        vadim.fedorenko@linux.dev, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [RFC PATCH v9 01/10] dpll: documentation on DPLL subsystem
 interface
Message-ID: <20230628141153.15709d97@kernel.org>
In-Reply-To: <20230623123820.42850-2-arkadiusz.kubalewski@intel.com>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
        <20230623123820.42850-2-arkadiusz.kubalewski@intel.com>
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

On Fri, 23 Jun 2023 14:38:11 +0200 Arkadiusz Kubalewski wrote:
> +    'pin-parent': [{'pin-id': 2, 'pin-state': 'connected'},
> +                   {'pin-id': 3, 'pin-state': 'disconnected'},
> +                   {'id': 0, 'pin-direction': 'input'},
> +                   {'id': 1, 'pin-direction': 'input'}],

This bit of documentation is out of date now, right?
