Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478F1768DF8
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjGaHTa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 03:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjGaHSZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 03:18:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918431FFA;
        Mon, 31 Jul 2023 00:17:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D22060F07;
        Mon, 31 Jul 2023 07:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38C0C433C7;
        Mon, 31 Jul 2023 07:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690787797;
        bh=Kbl3vl8F9PAkSdvmheeUSu12turbgGYFzXBz/7n21cE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=me8WSfKgL7EuiAQCQk2k/wnTmUfKNmqXGsSpWG+gwMjoqU2XRNroqffRh+zTdKxd8
         oirX0a+WPlMLaE2hG+crYRWK7ZFqJ52ztSd0t97QlHdVZ7WTr1BUOTKOsFav4gJqV7
         tAOuDZgo3GGo40lrlp9cTc30WF0OFHYIyEhjeSi0lXjNzRfV11TbmVBQmD8Ear9yXT
         X5bKETveI6O1oBCq2xOvNQFld4CHQ6XqneB/PuhrMmpIooWTEHshbQSZw/aymC+Q91
         mImzaPZbGlu9cvWP9D1Xo2cAdfCP09ucDLlx+5UIlq8aXkgUFqSBR26PMv1uEobcwg
         H+wx/shfBal6Q==
Date:   Mon, 31 Jul 2023 09:16:30 +0200
From:   Simon Horman <horms@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     michael.chan@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        simon.horman@corigine.com, louis.peens@corigine.com,
        yinjun.zhang@corigine.com, huanhuan.wang@corigine.com,
        tglx@linutronix.de, bigeasy@linutronix.de, na.wang@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@corigine.com
Subject: Re: [PATCH net-next v1] rtnetlink: remove redundant checks for
 nlattr IFLA_BRIDGE_MODE
Message-ID: <ZMdfznpH44i34QNw@kernel.org>
References: <20230726080522.1064569-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726080522.1064569-1-linma@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 26, 2023 at 04:05:22PM +0800, Lin Ma wrote:
> The previous patch added the nla_len check in rtnl_bridge_setlink, which
> is the only caller for ndo_bridge_setlink handlers defined in low-level
> driver codes. Hence, this patch cleanups the redundant checks in each
> ndo_bridge_setlink handler function.
> 
> Please apply the fix discussed at the link:
> https://lore.kernel.org/all/20230726075314.1059224-1-linma@zju.edu.cn/
> first before this one.

FWIIW, the patch at the link above seems to be in net-next now.

> 
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

