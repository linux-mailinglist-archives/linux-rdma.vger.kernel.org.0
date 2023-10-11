Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798257C5B24
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 20:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjJKSUG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 14:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjJKSUF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 14:20:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACF193;
        Wed, 11 Oct 2023 11:20:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CA8C433C9;
        Wed, 11 Oct 2023 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697048403;
        bh=YIm0FW45BPKvF+X1OFYkrHMeewnDQo6DSIeSnbcXoY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gz/caJMS9XpLYzznkn7hbGtO6iBp5YQBwlWeXaVO2aeovc1X8OVQhZQ7jlcUIW7o+
         ghCN+1bWAdy0HcDAyLR8SRpK7fumfmCZfanA/BiLwPgDo7ZH/LuzcYFGzxWET9HfLv
         i0+LbdnW8MGuGS/1sxtaXjNoZIRsAMHfSdJICxy7HM4cd5pM3HLStAi+sujH1YzqTm
         DgFgNbm57sUo9HuWgnWs8WhQsA59oXfgINZeLmcvjc2D4IeCxLI2Cd6tu8gHppiFbm
         08tttYidJWmRwXBdRo+KbhJFrtevCU7wleE/0NkNQkL9cGp87SZOiOFA4vzEXrImMm
         +YnnjvkNJ4r4w==
Date:   Wed, 11 Oct 2023 11:20:02 -0700
From:   Saeed Mahameed <saeed@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shay Drory <shayd@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net v3] net/mlx5: fix calling mlx5_cmd_init() before DMA
 mask is set
Message-ID: <ZSbnUlJT1u3xUIqY@x130>
References: <20231011-mlx5_init_fix-v3-1-787ffb9183c6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231011-mlx5_init_fix-v3-1-787ffb9183c6@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11 Oct 09:57, Niklas Schnelle wrote:
>Since commit 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and
>reload routines") mlx5_cmd_init() is called in mlx5_mdev_init() which is
>called in probe_one() before mlx5_pci_init(). This is a problem because
>mlx5_pci_init() is where the DMA and coherent mask is set but
>mlx5_cmd_init() already does a dma_alloc_coherent(). Thus a DMA
>allocation is done during probe before the correct mask is set. This
>causes probe to fail initialization of the cmdif SW structs on s390x
>after that is converted to the common dma-iommu code. This is because on
>s390x DMA addresses below 4 GiB are reserved on current machines and
>unlike the old s390x specific DMA API implementation common code
>enforces DMA masks.
>
>Fix this by moving set_dma_caps() out of mlx5_pci_init() and into
>probe_one() before mlx5_mdev_init(). To match the overall naming scheme
>rename it to mlx5_dma_init().

How about we just call mlx5_pci_init() before mlx5_mdev_init(), instead of
breaking it apart ? 
>
