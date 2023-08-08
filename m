Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386CF77431C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 19:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjHHR5Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 13:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjHHR4v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 13:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A6B2AF13;
        Tue,  8 Aug 2023 09:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46A6462531;
        Tue,  8 Aug 2023 12:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B258C433C8;
        Tue,  8 Aug 2023 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691498789;
        bh=bwqg+nZJaOp58U9gLi7+hIbzVoD6HWVrHABj3u2osQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bv6idbcnou7dvWv3pfCSTobSlZ8fXVeIw2yMmJVRggQHuTlgeo+lUsF5L8mUAfrxw
         Fb2BkRhuXr61SboC+ZUEBawjWZCulZnmjCs4zf47NOf4EXTLrZlZdXPLIYTdZ5kBGA
         YdPp9jZSZ0hSZQYFhhy0b4/5OT6RjvfsYvu4qaZ1cKuY54iLY8SbN3WArnkfzPxntX
         PsuYgLY/tsgFrUsjKdyt/eicIpeXIqk1sy66Iw0BblMhZoNn9tCT4MJJr1JexQSgfA
         dd1N2mGvCM08nCLESVFn3n3+mWH9CqCwu/xITCIqguMtve2XtiLfah+dEHIN/rNpJw
         l1P1t+mmv4g1w==
Date:   Tue, 8 Aug 2023 14:46:23 +0200
From:   Simon Horman <horms@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     michael.chan@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        louis.peens@corigine.com, yinjun.zhang@corigine.com,
        huanhuan.wang@corigine.com, tglx@linutronix.de,
        na.wang@corigine.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-rdma@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2] rtnetlink: remove redundant checks for
 nlattr IFLA_BRIDGE_MODE
Message-ID: <ZNI5H4OY1DrFOcq6@vergenet.net>
References: <20230807091347.3804523-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807091347.3804523-1-linma@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 07, 2023 at 05:13:47PM +0800, Lin Ma wrote:
> The commit d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks
> IFLA_BRIDGE_MODE length") added the nla_len check in rtnl_bridge_setlink,
> which is the only caller for ndo_bridge_setlink handlers defined in
> low-level driver codes. Hence, this patch cleanups the redundant checks in
> each ndo_bridge_setlink handler function.
> 
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

