Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8448157B128
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 08:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiGTGdm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 02:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbiGTGdl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 02:33:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0875925E
        for <linux-rdma@vger.kernel.org>; Tue, 19 Jul 2022 23:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB104B81D5C
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 06:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20388C3411E;
        Wed, 20 Jul 2022 06:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658298814;
        bh=39oZdu+K0quf0QE+0o7BPycVsWNv+Dtz6IySVyE9CQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMYEPeB+PfKYexDaeZdK8BlSjPycmiOgCw8dhZGAEd5VRxYn682kR9LxZTeZTkPbJ
         cJiN23zIKBAiNujD+ICAQJZjCBSxZGeGKxS8ZswapJWoFEnm1DNXmRcY8/dsVh82nu
         VCyyyt0zQdUkWpP+8XUi/k/mt1DvMqyb7hO4lvCoaQPbRQ4RpbJ1tJD3nqI2JUrEdo
         pyljitHHJN9avcKX/WQr1zJ87WON9UKkzI2QlCTgn3bx5KnkXhjfEjtxvYxMdaQ3we
         jZMk2H4V7QRfpmRz/9HR76pdPv6SotSOH5Xq/YtTYaAxcBUBPQR4v0C42hJbpyQqAG
         1QQcVpSACFQbQ==
Date:   Wed, 20 Jul 2022 09:33:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Cheng Xu <chengyou@linux.alibaba.com>
Subject: Re: [PATCH v5 0/4] RDMA/rxe: Fix no completion event issue
Message-ID: <YtehusQijNRTv0Jr@unreal>
References: <20220704060806.1622849-1-lizhijian@fujitsu.com>
 <YteUvNhKF/VH+OFW@unreal>
 <a19c2627-22d9-4362-66ee-bf66903d120a@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a19c2627-22d9-4362-66ee-bf66903d120a@fujitsu.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 20, 2022 at 06:21:29AM +0000, lizhijian@fujitsu.com wrote:
> Hi Leon
> 
> 
> On 20/07/2022 13:38, Leon Romanovsky wrote:
> > On Mon, Jul 04, 2022 at 06:00:54AM +0000, lizhijian@fujitsu.com wrote:
> >
> > Please fix your gitconfig to have same From/author fields as in Signed-off-by.
> 
> I'm sorry about that, tay I know which patch has something wrong? I have not updated these fields recently.
> Do you mean "[PATCH v5 3/4] RDMA/rxe: Split qp state for requester and completer" which is from Bob. So
> I keep his author and SOB.

No, I'm talking about something else. Almost all your patches are sent
with wrong "From:" field.

Let's take your first patch as an example:
https://lore.kernel.org/linux-rdma/20220704060806.1622849-2-lizhijian@fujitsu.com/
From: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
...
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

and if i try to apply it, the checkpatch will throw the following error:
➜  kernel git:(rdma-next) ✗ git am --continue
Applying: RDMA/rxe: Update wqe_index for each wqe error completion
➜  kernel git:(rdma-next) git checkpatch
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#9:
qp->req.wqe_index==queue.index in next round, req_next_wqe() will treat queue

WARNING: From:/Signed-off-by: email name mismatch: 'From: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>' != 'Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>'

0001-RDMA-rxe-Update-wqe_index-for-each-wqe-error-complet.patch total: 0 errors, 2 warnings, 8 lines checked


> 
> Thanks
> Zhijian
> 
> 
> >
> > Thanks
