Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CEB6C98A3
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Mar 2023 01:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCZXQ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Mar 2023 19:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCZXQ2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Mar 2023 19:16:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF0B449F;
        Sun, 26 Mar 2023 16:16:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D33CE68B05; Mon, 27 Mar 2023 01:16:22 +0200 (CEST)
Date:   Mon, 27 Mar 2023 01:16:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma
 devices
Message-ID: <20230326231622.GA19436@lst.de>
References: <20230322123703.485544-1-sagi@grimberg.me> <ZBr6kNVoa5RbNzSa@ziepe.ca> <c51d3d99-5bc9-cb47-6efa-5371ef3cc0f4@grimberg.me> <ZBsHnq6FlpO0p10A@ziepe.ca> <20230323120515.GE36557@unreal> <ZBxOHZwre3x8DkWN@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBxOHZwre3x8DkWN@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 23, 2023 at 10:03:25AM -0300, Jason Gunthorpe wrote:
> > > > Given that nvme-rdma was the only consumer, do you prefer this goes from
> > > > the nvme tree?
> > > 
> > > Sure, it is probably fine
> > 
> > I tried to do it two+ years ago:
> > https://lore.kernel.org/all/20200929091358.421086-1-leon@kernel.org
> 
> Christoph's points make sense, but I think we should still purge this
> code.

Given that we don't keep dead code around in the kernel as policy
we should probably remove it.  That being said, I'm really sad about
this, as I think what the RDMA code does here right now is pretty
broken.

> If we want to do proper managed affinity the right RDMA API is to
> directly ask for the desired CPU binding when creating the CQ, and
> optionally a way to change the CPU binding of the CQ at runtime.

Chanigng the bindings causes a lot of nasty interactions with CPU
hotplug.  The managed affinity and the way blk-mq interacts with it
is designed around the hotunplug notifier quiescing the queues,
and I'm not sure we can get everything right without a strict
binding to a set of CPUs.

> This obfuscated 'comp vector number' thing is nonsensical for a kAPI -
> creating a CQ on a random CPU then trying to backwards figure out what
> CPU it was created on is silly.

Yes.
