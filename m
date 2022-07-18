Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A626D5781FC
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 14:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiGRMQX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 08:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiGRMQW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 08:16:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5891A055
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 05:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93E61614AF
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 12:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083E4C341C0;
        Mon, 18 Jul 2022 12:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658146580;
        bh=3b5+BhdxjgfGazKFDPIOBu1w9wnzPJ9VuK4XU3Y1ULs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQVUsnE8Jj871zl5kNq+F+Sr62VLo49Jn59K3/knvl/cyZCJ4Mox0kPI+CPCWPuSu
         vhGWYikkCrUWjJwDB5wBCL00HkUfo/OSCetVPGUbaRyJLgrYcfbpWgz4VJP9Oe+qIm
         b5rgQj2ozcdjIv32iqdYdZmGRu2uNGmdCcVyyVU4WiX2KepnFA3Kbpky6zdHoxhB3R
         EOwMjOmr7LqjIFHtSWpLZiCUhrPjJaKLvrYBiro70ZgnS2vx75iJTx7pjv/mdg+TxI
         x8QVME2U16XH90OY5NAKEYQBVU6YJJkgcPH7ZURFchUZfZ/cSAvm2X8eRg+kpyROy4
         QOYO6wDY28vtA==
Date:   Mon, 18 Jul 2022 15:16:16 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RESEND PATCH] RDMA/rxe: Remove unused qp parameter
Message-ID: <YtVPEFHs5VaLe+mY@unreal>
References: <20220708035547.6592-1-yangx.jy@fujitsu.com>
 <YtUZNruUx4jjrNhW@unreal>
 <4bca5022-2db6-b788-9a88-0615d6ea9e97@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bca5022-2db6-b788-9a88-0615d6ea9e97@fujitsu.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 18, 2022 at 08:58:32AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/7/18 16:26, Leon Romanovsky wrote:
> > On Fri, Jul 08, 2022 at 03:55:50AM +0000, yangx.jy@fujitsu.com wrote:
> >> The qp parameter in free_rd_atomic_resource() has become
> >> unused so remove it directly.
> >>
> >> Fixes: 15ae1375ea91 ("RDMA/rxe: Fix qp reference counting for atomic ops")
> >> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> >> ---
> >>   drivers/infiniband/sw/rxe/rxe_loc.h  | 2 +-
> >>   drivers/infiniband/sw/rxe/rxe_qp.c   | 6 +++---
> >>   drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
> >>   3 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > The patch doesn't apply.
> > 
> > Thanks
> 
> Hi Leon,
> 
> Could you tell me why it doesn't apply?

Please, try to apply the patch to wip/leon-for-next branch.

Thanks

> 
> Best Regards,
> Xiao Yang
