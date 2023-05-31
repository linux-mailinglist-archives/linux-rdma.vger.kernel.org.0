Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38150718E0F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 00:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjEaWHh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 18:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjEaWHg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 18:07:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA455137;
        Wed, 31 May 2023 15:07:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 512F963F95;
        Wed, 31 May 2023 22:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954DEC433EF;
        Wed, 31 May 2023 22:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685570852;
        bh=7EjhTSxh5SY7b9ApyiBAysKr7233N2ER+oIwSKBbgSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iR/61cTw30Cwu+x71pfuEibL3AEEXR6oFsNAPnDrkiINUX8ZTeswXV5a+GDRRbO76
         84ofQouyFlKQ+ZVfpvDUpMjq9RWosAkaZtbm6o0sPjGzJjPbBXEQQTaRrw9L63CrmY
         Xbo3hicgWRpKzJMMC3qyTTTzXLbzYdF6pxqVya+2nOYPidTqS5P2DQ0rxC3h/12AAC
         Yu++UCsY9MLNShSQw6HXXKyqVFG30qiXIpO5YwUUTNP5X+BY2ifxwJBDafsEtR7wkf
         Qme3wtRNHZzT/lEGhR/rDHXIHac++DNhggG+cqRpZ7WQ309WUFjniIiNF1jfNHzw+t
         pcnKsu5YqXI/w==
Date:   Wed, 31 May 2023 15:07:31 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5e: Remove a useless function call
Message-ID: <ZHfFI8Gby5HKgIkr@x130>
References: <fc535be629990acef5e2a3dfecd64a5f9661fd25.1685349266.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fc535be629990acef5e2a3dfecd64a5f9661fd25.1685349266.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 29 May 10:34, Christophe JAILLET wrote:
>'handle' is known to be NULL here. There is no need to kfree() it.
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Applied to net-next-mlx5.

Thanks
