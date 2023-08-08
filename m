Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0672377487F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Aug 2023 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjHHTdw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Aug 2023 15:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbjHHTd2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Aug 2023 15:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2E61DCA7;
        Tue,  8 Aug 2023 11:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE4F162A90;
        Tue,  8 Aug 2023 18:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719F8C433C7;
        Tue,  8 Aug 2023 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691521116;
        bh=3eJT8c5liB8+ruQaGOmsFlAOd7SD1h25ExJ3H0VtLl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MlDo7JyuuWgVE9WVNT4mQCslSwD/WDfZDU3fIPK7DL88e9XBS+s77ctY4PeuRvfQM
         bqvo4Q8y5HmhDUHkPQgSM3Q2kdhz3zruTXViyCcGMTvD9659sbG4xk+mJJMJzlQD6z
         w6z8rlqTlQywytE747gJpV/dvC9bTrdoQfo5618sk+8kDKmUkP7pnCk0/gyIwUawE5
         t4J3WdSbsFDiBT7m5GHVwWuE7rnOGr5ikjTF/scWZPLSLqh/UFFjYQDhZj/KDs5rua
         xjeSA52c1XiUCZi/C6eDAmSzTN39oOHMzqou9xveq39FMJll79e5MlR6u8t8OZpl1D
         u/4Zk/kG2GBWQ==
Date:   Tue, 8 Aug 2023 21:58:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tariqt@nvidia.com, yishaih@nvidia.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jgg@ziepe.ca, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/10] mlx4: Delete custom device management
 logic
Message-ID: <20230808185828.GO94631@unreal>
References: <20230804150527.6117-1-petr.pavlu@suse.com>
 <20230804150527.6117-11-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804150527.6117-11-petr.pavlu@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 04, 2023 at 05:05:27PM +0200, Petr Pavlu wrote:
> After the conversion to use the auxiliary bus, the custom device
> management is not needed anymore and can be deleted.
> 
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> Tested-by: Leon Romanovsky <leon@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/intf.c | 125 ----------------------
>  drivers/net/ethernet/mellanox/mlx4/main.c |  28 -----
>  drivers/net/ethernet/mellanox/mlx4/mlx4.h |   3 -
>  include/linux/mlx4/driver.h               |  10 --
>  4 files changed, 166 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
