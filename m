Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919496C67A2
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Mar 2023 13:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCWMGj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Mar 2023 08:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCWMGO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Mar 2023 08:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71041423B;
        Thu, 23 Mar 2023 05:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47C9F625F1;
        Thu, 23 Mar 2023 12:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3E9C4339E;
        Thu, 23 Mar 2023 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679573120;
        bh=hDVoes+3Nxq5mxqz64too+hxUOeCVS9hFtLez3uCHxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAJMXilDfadj1RlD3NeU+idfEC406wQ3cLZnWB//0y97n3NpgQccxRW/bRVnr3zLb
         3JJOSvPC+1M2rt87CB6laKOF6Ker+4WIt8fmBAoGfLRY8FEpuBzKi4uiTtRKKcrhUf
         TJ/EhJcUA6mOETSE8GlmSV/sRmE5Te1nZ8mNhjJ6t7vDU+Hd6UoAx5N9XFAVmXZbDh
         xKyZVLQ6mUUZDtGw/ThCuZrNVBV1NITU9AgitNCaH9SHtxIhP0SZB9LrB4fCtUE9uS
         eBGuaJbiDZZ6VVGdG0uL7Q+aeHc7cKlnq8eqeI7QozMZcaoxt5lzZ1ajii4ZeSwRB+
         +oN/1gwC1sQXg==
Date:   Thu, 23 Mar 2023 14:05:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Sagi Grimberg <sagi@grimberg.me>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <20230323120515.GE36557@unreal>
References: <20230322123703.485544-1-sagi@grimberg.me>
 <ZBr6kNVoa5RbNzSa@ziepe.ca>
 <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me>
 <ZBsHnq6FlpO0p10A@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsHnq6FlpO0p10A@ziepe.ca>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 22, 2023 at 10:50:22AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 22, 2023 at 03:00:08PM +0200, Sagi Grimberg wrote:
> > 
> > > > No rdma device exposes its irq vectors affinity today. So the only
> > > > mapping that we have left, is the default blk_mq_map_queues, which
> > > > we fallback to anyways. Also fixup the only consumer of this helper
> > > > (nvme-rdma).
> > > 
> > > This was the only caller of ib_get_vector_affinity() so please delete
> > > op get_vector_affinity and ib_get_vector_affinity() from verbs as well
> > 
> > Yep, no problem.
> > 
> > Given that nvme-rdma was the only consumer, do you prefer this goes from
> > the nvme tree?
> 
> Sure, it is probably fine

I tried to do it two+ years ago:
https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org

> 
> Jason
