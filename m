Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4B75323A2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 09:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiEXHHy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 03:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiEXHHv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 03:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF945DBCB
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 00:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC86761515
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 07:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC3FC34116;
        Tue, 24 May 2022 07:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653376067;
        bh=7BYlPcGFWt4SskIlZpshpY71VgS9cbMLLzr19w1Dxm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwRg0/lu5qT5DxEBsOah44vMZD962AzuIfDh3OGJkrViU73d5XWhEwhezfIXFbGs9
         w60TizM7LbpP2OvDhSU7OLQpUuLbF1mipECf67lv4XeU5BnOEFBvBpH2WHIF1ar2or
         g1poSnBsqpFnQjCniNn/g0zTSRNHB3kTe7q/wIWWccBfEcSO2TcytOVYfusbIiZdXp
         ihbTpftNiCbfILBjwcV7mrdtoQiybWGoMQRsfOeMx0I0jTtWXh1cGn0jdBkS1Hk0IF
         8BeIbwLAS1L6dCi6N6LvNv+Za6Lcs+zGNPt/Uh3S5l7LIpoXwa21jmN8OWGTOvlYK1
         jgekHppmiIpmw==
Date:   Tue, 24 May 2022 10:07:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ryan Stone <rysto32@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Possible bug in ipoib_reap_dead_ahs in datagram mode
Message-ID: <YoyEPnFpd7/mI1Mm@unreal>
References: <CAFMmRNyHUSg6_+af9W39e36aCx2a=_9WC8MB08W9XfnMKoYXAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFMmRNyHUSg6_+af9W39e36aCx2a=_9WC8MB08W9XfnMKoYXAQ@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 04, 2022 at 03:15:13PM -0400, Ryan Stone wrote:
> I was reading through the IPoIB code and I think that I see a bug that
> affects ipoib_reap_dead_ahs() when using datagram mode.
> 
> When sending a packet, if we aren't using the CM (which I assume means
> that we are using datagram mode), we fall into the following case:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/infiniband/ulp/ipoib/ipoib_main.c#n1163
> 
> The AH for our neighbour has its last_send field set to the return
> value from the RDMA driver's send function
> 
> If I look at how this is used in ipoib_reap_dead_ahs(), it compares
> last_send to the current tail of the completion(?) queue.  I believe
> that this is intended to check that the last outstanding WQ entry that
> references the AH has completed.
> 
> However, if I look at the actual implementation in mlx5, the send
> function always returns NETDEV_TX_OK:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c#n635
> 
> If my understanding of all of this is correct, this could lead to a
> premature freeing of an AH and a use-after-free bug

IPoIB in mlx5 is HW offloaded version of ulp/ipoib one. AFAIK, it doesn't
change "tx_tail" and we won't enter into this if (...).

Thanks
