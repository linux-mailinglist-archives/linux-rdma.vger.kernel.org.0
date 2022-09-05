Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C165AD230
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Sep 2022 14:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbiIEMN5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Sep 2022 08:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiIEMNz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Sep 2022 08:13:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6658D5E579
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 05:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 140F2B8113A
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 12:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C918C433C1;
        Mon,  5 Sep 2022 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662380031;
        bh=qerTmG5JuFN8eW+r96noth2kKQJt4RzhDircqTkWGaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l2X8BVMfh16/5ANgmfekLct6JNNlEIb3o299YexlcGxpKO9dNJRwxgxnrPQwkSjAQ
         Ln71Ag/UFONgVb3Im27uZ/6/kePezhjIG+78f66uJxR6TCHFRyJssWGXTWtMutb8Fo
         ZQ9oFzK1nAtwNdwONj1Z7fkOmKo//VHUYOX5zYTXq/wFfU8to+YoTKj9AwlfyPRMzb
         A24U2U0qLqBI0IhkqJfRBuWPfUwYtE5BlMR5xm7uSdy1jZF0OAKVSDm/JyDI7fb/yi
         /18lpGYPXRSYjJMOT1EkfiQCpocarJxPyey98BlwaflF0J1tMJDj2aGTqsULzHW3Jy
         81b5M9UtEU7nA==
Date:   Mon, 5 Sep 2022 15:13:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core] tests: Pass the specified gid index to
 u.get_global_route()
Message-ID: <YxXn+ylSuwSZXEJp@unreal>
References: <20220901073836.1573-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901073836.1573-1-yangx.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 01, 2022 at 07:38:41AM +0000, yangx.jy@fujitsu.com wrote:
> test_create_ah() or test_destroy_ah() always triggered the following
> error on SoftRoCE because the specified gid index didn't work.
> 
> $ bin/run_tests.py --dev rxe_enp0s5 --gid 1 -v tests.test_addr.AHTest.test_create_ah
> test_create_ah (tests.test_addr.AHTest)
> Test ibv_create_ah. ... ERROR
> 
> ======================================================================
> ERROR: test_create_ah (tests.test_addr.AHTest)
> Test ibv_create_ah.
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "/root/rdma-core/tests/test_addr.py", line 51, in test_create_ah
>     raise ex
>   File "/root/rdma-core/tests/test_addr.py", line 47, in test_create_ah
>     AH(pd, attr=ah_attr)
>   File "addr.pyx", line 410, in pyverbs.addr.AH.__init__
> pyverbs.pyverbs_error.PyverbsRDMAError: Failed to create AH. Errno: 110, Connection timed out
> 
> ----------------------------------------------------------------------
> Ran 1 test in 1.271s
> 
> FAILED (errors=1)
> 
> Try to fix the issue by passing the specified gid index to u.get_global_route().
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  tests/base.py      | 4 ++++
>  tests/test_addr.py | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 

Thanks, applied.
