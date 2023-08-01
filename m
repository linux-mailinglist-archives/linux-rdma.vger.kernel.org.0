Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5152776BBCA
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Aug 2023 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjHAR5i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Aug 2023 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjHAR5c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Aug 2023 13:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634CF1BF9;
        Tue,  1 Aug 2023 10:57:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 957DD61662;
        Tue,  1 Aug 2023 17:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF40FC433C8;
        Tue,  1 Aug 2023 17:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690912649;
        bh=tw2ZYxvTVSxFPFx5zqO5kWykO1CaGqAJdfqNsvzpC+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G6oM5htN3cIsRrR7bpzcSTjQdPLgnDezapGDV1KSaZ4doJvlYGdyNKxk6q4YXSUbI
         CxMUuFUEoS2Bj5we6fpnM/RPrLAeoHz/wkHPOy+mml1eKJ3soiEiTHEPzOWIN4MciY
         9h5CkO9IqjmtiyzvZFgdtSHCVXkCNVX5AkZ7cmQcodS3+8161DRbKZ2mC/uFs0+wan
         4rLtLaXq1YH5bnDfc9PBtmv/SNpoyfvDwAXCcKV5efn2vuR7fRl11q1ZgpXBjxlPI6
         nV+NJbyITbiSU4IEURk/MkiIBXLXPlC1EERcGTUN1U5oEf7gw/PENFu2rV5kSVqK8I
         d+Cv4VduRME9g==
Date:   Tue, 1 Aug 2023 10:57:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Lin Ma <linma@zju.edu.cn>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, fw@strlen.de,
        yang.lee@linux.alibaba.com, jgg@ziepe.ca, markzhang@nvidia.com,
        phaddad@nvidia.com, yuancan@huawei.com, ohartoov@nvidia.com,
        chenzhongjin@huawei.com, aharonl@nvidia.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
Message-ID: <20230801105726.1af6a7e1@kernel.org>
In-Reply-To: <20230801081117.GA53714@unreal>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
        <20230731120326.6bdd5bf9@kernel.org>
        <20230801081117.GA53714@unreal>
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

On Tue, 1 Aug 2023 11:11:17 +0300 Leon Romanovsky wrote:
> IMHO, you are lowering too much the separation line between simple vs.
> advanced use cases. 
> 
> I had no idea that my use-case of passing nested netlink array is counted
> as advanced usage.

Agreed, that's a fair point. I'm guessing it was inspired by the
ethtool stats? (Which in hindsight were a mistake on my part.)

For the longest time there was no docs or best practices for netlink.
We have the documentation and more infrastructure in place now.
I hope if you wrote the code today the distinction would have been
clearer.

If we start adding APIs for various one-(two?)-offs from the past
we'll never dig ourselves out of the "no idea what's the normal use
of these APIs" hole..
