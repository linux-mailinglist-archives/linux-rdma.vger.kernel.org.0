Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDB37C5D37
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbjJKS41 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 14:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjJKS4Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 14:56:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EB2123;
        Wed, 11 Oct 2023 11:56:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D25EC433C8;
        Wed, 11 Oct 2023 18:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697050566;
        bh=p5Aqye/cIt07/FsEkeTy4ySuRidXLXrlLwhsHjfE6s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ig89jjbS+S/Y6rn7rilEv05EonKQ7QJVCBTnsmEEOd7KF50WQrJX/EqqLg0EEFD33
         Q1Vc/EkXLs8+j7JhixfAG9Id5XBPsvgxzxElbJbn43ToUMcibkSl1HlhwZb2N+hrwY
         NNQZesN3ux5oYyQyIZ6pdd7kEbs4Eu0yNP0ZmQHwX9Q7KpWN37IyAMcqvEqc+NwE9Q
         N7S7T30w1DDWI9TSFFSEO13RR5WHL5KhuZr2tFah2IZM8sssuNL1XbgEqMTQ6lpV7E
         hcALxsrieoUdmLTjKbXeLxTO2HaDe58/NmhvWcSwNnSx7iLVL1wnJwadfUIQ5NRZu0
         doYihVvW1stuQ==
Date:   Wed, 11 Oct 2023 11:56:05 -0700
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
Message-ID: <ZSbvxeLKS8zHltdg@x130>
References: <20231011-mlx5_init_fix-v3-1-787ffb9183c6@linux.ibm.com>
 <ZSbnUlJT1u3xUIqY@x130>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZSbnUlJT1u3xUIqY@x130>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11 Oct 11:20, Saeed Mahameed wrote:
>On 11 Oct 09:57, Niklas Schnelle wrote:
>>Since commit 06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and
>>reload routines") mlx5_cmd_init() is called in mlx5_mdev_init() which is
>>called in probe_one() before mlx5_pci_init(). This is a problem because
>>mlx5_pci_init() is where the DMA and coherent mask is set but
>>mlx5_cmd_init() already does a dma_alloc_coherent(). Thus a DMA
>>allocation is done during probe before the correct mask is set. This
>>causes probe to fail initialization of the cmdif SW structs on s390x
>>after that is converted to the common dma-iommu code. This is because on
>>s390x DMA addresses below 4 GiB are reserved on current machines and
>>unlike the old s390x specific DMA API implementation common code
>>enforces DMA masks.
>>
>>Fix this by moving set_dma_caps() out of mlx5_pci_init() and into
>>probe_one() before mlx5_mdev_init(). To match the overall naming scheme
>>rename it to mlx5_dma_init().
>
>How about we just call mlx5_pci_init() before mlx5_mdev_init(), instead of
>breaking it apart ?

I just posted this RFC patch [1]:

I am working in very limited conditions these days, and I don't have strong
opinion on which approach to take, Leon, Niklas, please advise.

The three possible solutions:

1) mlx5_pci_init() before mlx5_mdev_init(), I don't think enabling pci
before initializing cmd dma would be a problem.

2) This patch.

3) Shay's patch from the link below:
[1] https://patchwork.kernel.org/project/netdevbpf/patch/20231011184511.19818-1-saeed@kernel.org/

Thanks,
Saeed.
