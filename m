Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045E4649BD5
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Dec 2022 11:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiLLKQb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Dec 2022 05:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiLLKQY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Dec 2022 05:16:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC63EC7C
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 02:16:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53FADB80CA7
        for <linux-rdma@vger.kernel.org>; Mon, 12 Dec 2022 10:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FC7C433D2;
        Mon, 12 Dec 2022 10:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670840180;
        bh=0m1zdfFo5fERQkGL6Uj8cy3oZmEm+OWW6EX3IXHA3K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLV3dE3BjUkAoDvwpWLOj8qszwz6ID7lROqBKIGBGAlF9yAcOrAbIdmOvhS7hmbHb
         St1hlO6POSrCBDa3wbICLKJar4JWEAaYmQWg07SwgjBfBqAIWwo10WH1IRpCRfL0ny
         K7TSKLniLPB0cWDF1GLAUy3gsef0o3JbE5iiwEeYjm5jIC8yuDaErL+b0F9Yh+1H11
         whQlLQPwBO7LbIP3mTRErxaQE1Z030tvLphXBvokjWkBl3UuBTbOZX1n6fKq6wImwv
         +cZeGs0RMAmA+ry4Qucx4x50yR1dIXU9XqCIV2wuasMnwUw9dlpEtCgrcAGdblwcRq
         NCqHfEXhou5fg==
Date:   Mon, 12 Dec 2022 12:16:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kheib@redhat.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [for-rc] RDMA/core: Make sure the netdev is not already
 associated
Message-ID: <Y5b/b/JCYg3E9qy1@unreal>
References: <20221212092240.21694-1-kheib@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212092240.21694-1-kheib@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 12, 2022 at 11:22:40AM +0200, Kamal Heib wrote:
> Make sure that the requested net_device is not already associated with
> an ib_device before trying to create a new ib_device that will be
> associated with the same net_device, this is needed to avoid creating
> siw and rxe devices that will be associated with the same net_device.
> 
> Fixes: 3856ec4b93c9 ("RDMA/core: Add RDMA_NLDEV_CMD_NEWLINK/DELLINK support")
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> ---
>  drivers/infiniband/core/nldev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
