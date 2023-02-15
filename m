Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1426697A97
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Feb 2023 12:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjBOLWP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Feb 2023 06:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjBOLWO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Feb 2023 06:22:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32F135268
        for <linux-rdma@vger.kernel.org>; Wed, 15 Feb 2023 03:22:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5771CB8212C
        for <linux-rdma@vger.kernel.org>; Wed, 15 Feb 2023 11:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3691AC433D2;
        Wed, 15 Feb 2023 11:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676460131;
        bh=BkDTuRDTSF6TE6AFeTWt7xT6udNt9/yuwnP9lSJc9SY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Q5rDXZE4KEnk3+DC6CHgSYF8+VS01KllcEerRMu5j45YNtebKcr7Ndq0ZWBWzZ6X/
         XwVUyguPrDFB8/MJDUA3GsZdm4XI0yrcQctNZDaAlVfBGSOZIoFgWXdbakNABJG1Dk
         PyRb38YtpCMCn1vfRaNi88aG/hSBJcmRFFg2cM5LzUZljTNMJx6Yll5VdS7iEuCeM4
         bAmqs2FCsLXZmnL1IHGToL80LG9UwOHoNgc83VC1xaQUtZ94AWv1hO+UBXHEeRM0iL
         YQa3WPNZC14eFb+SGGrme5yXLdVs0MUGt63+p7JJnKpq6dl/yNk8OPbceuWJfYrF01
         eLMgtmgjoU9ZQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Aharon Landau <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
In-Reply-To: <0-v1-c13a5b88359b+556d0-mlx5_umem_block_jgg@nvidia.com>
References: <0-v1-c13a5b88359b+556d0-mlx5_umem_block_jgg@nvidia.com>
Subject: Re: [PATCH] RDMA/mlx5: Use rdma_umem_for_each_dma_block()
Message-Id: <167646012658.1501930.15520190331485621100.b4-ty@kernel.org>
Date:   Wed, 15 Feb 2023 13:22:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Mon, 13 Feb 2023 14:14:11 -0400, Jason Gunthorpe wrote:
> Replace an open coding of rdma_umem_for_each_dma_block() with the proper
> function.
> 
> 

Applied, thanks!

[1/1] RDMA/mlx5: Use rdma_umem_for_each_dma_block()
      https://git.kernel.org/rdma/rdma/c/50a542a8accc12

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
