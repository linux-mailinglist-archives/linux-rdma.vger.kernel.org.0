Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDEA6C61A9
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 09:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjCWI3d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 04:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjCWI3Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 04:29:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8460F15C98
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 01:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 398A0B81FBE
        for <linux-rdma@vger.kernel.org>; Thu, 23 Mar 2023 08:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644A7C4339B;
        Thu, 23 Mar 2023 08:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679560156;
        bh=Lu00AYrFE4WsLr52WEKICqKdI5TmfN0MeYMVMzGK6zM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Fwv7M4nw30EjpINi2CAmXtfuTw3PZvCU7v2eYpmA9QiFJ6u68Uy/wKDHTcLEB1EJQ
         ludSdDq0DUTxHvzNv0zsZK6MBYlc/NdVoEoCvta1/oQKJX7NJ2JFb/dBhAnkMpYfca
         NIFSBm73TXFQ6gJ9wU9tLH8+xfNlh3tvm45mNeb1woWBin7BVpMmGsvcgA529C2Y08
         wC+AiulKYmmuMEPdREEUd0gaGNSw+GdhnuI5pUT72oXTcccVKOvzr3LePtO2/Y/FhR
         9bPiXOgVbyWX8657XHmraZCVTXkqZqz+OcXwWbmYeHE3aSH/aWGmlkYq98KvwweEnq
         +SYrmNRHb0PBA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org,
        syzbot+8fcbb77276d43cc8b693@syzkaller.appspotmail.com
In-Reply-To: <58a4a98323b5e6b1282e83f6b76960d06e43b9fa.1679309909.git.leon@kernel.org>
References: <58a4a98323b5e6b1282e83f6b76960d06e43b9fa.1679309909.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc v1] RDMA/cma: Allow UD qp_type to join multicast only
Message-Id: <167956015290.1726332.163852531252633854.b4-ty@kernel.org>
Date:   Thu, 23 Mar 2023 10:29:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 20 Mar 2023 12:59:55 +0200, Leon Romanovsky wrote:
> As for multicast:
> - The SIDR is the only mode that makes sense;
> - Besides PS_UDP, other port spaces like PS_IB is also allowed, as it is
>   UD compatible. In this case qkey also needs to be set [1].
> 
> This patch allows only UD qp_type to join multicast, and set qkey to
> default if it's not set, to fix an uninit-value error: the ib->rec.qkey
> field is accessed without being initialized.
> 
> [...]

Applied, thanks!

[1/1] RDMA/cma: Allow UD qp_type to join multicast only
      https://git.kernel.org/rdma/rdma/c/58e84f6b3e84e4

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
