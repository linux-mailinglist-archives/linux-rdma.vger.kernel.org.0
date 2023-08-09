Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4748776CAB
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Aug 2023 01:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjHIXK7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 19:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHIXK7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 19:10:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB44AE72
        for <linux-rdma@vger.kernel.org>; Wed,  9 Aug 2023 16:10:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6903E64C08
        for <linux-rdma@vger.kernel.org>; Wed,  9 Aug 2023 23:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A34C433C8;
        Wed,  9 Aug 2023 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691622657;
        bh=dMDWpdL0ZCg2WLUrLyO7+quIjAR6ms193ZxTDziO33w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E2Ufq/wIg16ulxjG2Zi132Tt7yVtE+OBxxi3FnDYidC0Gq+lLDVYR1+4mJ+Fs+qyv
         aBjBp/QWQZk5vuhUm+ER42YBMFK6o0QMNYF48mTqWsifjkhthun7hl3/ScBlLMyqDj
         AnL4uKGAfZsF/4jsIAR5FikgpDdAHYYm71qnrUIAxyQLgwtOa8w3k+N8J/clhHmTrU
         P6co5sn5EXeQzCcgPsvB70jbZygG9+nzTbjVBxXWTNua/ZvmMfjvaVrXGzd+MT0vS4
         ko4HxPyI/z4ATekzgN8D83G17Wj7I2O2GIZT+mzAlmhN1vG72TBI7Ye00eoydC7bKT
         yNVRrn1E7/KDA==
Date:   Wed, 9 Aug 2023 16:10:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Simon Horman <horms@kernel.org>
Subject: Re: [PATCH mlx5-next v1 00/14] mlx5 MACsec RoCEv2 support
Message-ID: <20230809161056.790861d3@kernel.org>
In-Reply-To: <20230809160945.386168f9@kernel.org>
References: <cover.1691569414.git.leon@kernel.org>
        <20230809160945.386168f9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 9 Aug 2023 16:09:45 -0700 Jakub Kicinski wrote:
> On Wed,  9 Aug 2023 11:29:12 +0300 Leon Romanovsky wrote:
> > This series extends previously added MACsec offload support
> > to cover RoCE traffic either.
> > 
> > In order to achieve that, we need configure MACsec with offload between
> > the two endpoints, like below:
> > 
> > REMOTE_MAC=10:70:fd:43:71:c0
> > 
> > * ip addr add 1.1.1.1/16 dev eth2
> > * ip link set dev eth2 up
> > * ip link add link eth2 macsec0 type macsec encrypt on
> > * ip macsec offload macsec0 mac
> > * ip macsec add macsec0 tx sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
> > * ip macsec add macsec0 rx port 1 address $REMOTE_MAC
> > * ip macsec add macsec0 rx port 1 address $REMOTE_MAC sa 0 pn 1 on key 01 ead3664f508eb06c40ac7104cdae4ce5
> > * ip addr add 10.1.0.1/16 dev macsec0
> > * ip link set dev macsec0 up
> > 
> > And in a similar manner on the other machine, while noting the keys order
> > would be reversed and the MAC address of the other machine.
> > 
> > RDMA traffic is separated through relevant GID entries and in case of IP ambiguity
> > issue - meaning we have a physical GIDs and a MACsec GIDs with the same IP/GID, we
> > disable our physical GID in order to force the user to only use the MACsec GID.  
> 
> Can you explain why you need special code to handle this?
> MACsec is L2, RDMA is L4.

Ah, because you need to support "offload" on device that's not yours.
