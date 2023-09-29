Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BCA7B2BFD
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 07:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjI2FsH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 01:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjI2FsG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 01:48:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7181A8;
        Thu, 28 Sep 2023 22:48:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459E7C433C7;
        Fri, 29 Sep 2023 05:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695966483;
        bh=7ZC2EUS1+5alu8Xvvo5x8YyaDXlFVLmwBFCPCg7iIKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxhUB415GBUxZOL+xZHYtDTurxK5nBb0W0aJMJpxj5PCUSDRPUTF0nn3N584sqa7p
         HTMP0xK4e93SxutPiWMu4AoeW/ir8EKCm/H8v8YLINu3OiXnYfxVli01fBE5/9ozEE
         9RuuLWrVrV+ahXUb3xSEJoSBNJy4u9xgP0ua1rdO6qSjRg5Navb3DFz4E9wSvopkkv
         leorErorjrd7GVcdU/LBSLpbkK3YPavj8rFTVkRBkcZuWCQgzfz8ABqwtyKI/4V8E6
         4jYuzUrrKT991vlxRgHrR8rLEC7CaCbROn5/XuTmkIdrUlUcv+GzECH3RQhQ3FBiWM
         GKTBzpFmVxIpg==
Date:   Fri, 29 Sep 2023 07:47:57 +0200
From:   Simon Horman <horms@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
        olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
        wei.liu@kernel.org, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
        ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
        daniel@iogearbox.net, john.fastabend@gmail.com,
        bpf@vger.kernel.org, ast@kernel.org, sharmaajay@microsoft.com,
        hawk@kernel.org, tglx@linutronix.de,
        shradhagupta@linux.microsoft.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net, 1/3] net: mana: Fix TX CQE error handling
Message-ID: <20230929054757.GQ24230@kernel.org>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
 <1695519107-24139-2-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695519107-24139-2-git-send-email-haiyangz@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 23, 2023 at 06:31:45PM -0700, Haiyang Zhang wrote:
> For an unknown TX CQE error type (probably from a newer hardware),
> still free the SKB, update the queue tail, etc., otherwise the
> accounting will be wrong.
> 
> Also, TX errors can be triggered by injecting corrupted packets, so
> replace the WARN_ONCE to ratelimited error logging, because we don't
> need stack trace here.
> 
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>

