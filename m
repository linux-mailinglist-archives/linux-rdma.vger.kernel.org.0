Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786114EC507
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Mar 2022 14:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbiC3M6e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Mar 2022 08:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345425AbiC3M6c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Mar 2022 08:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC381E95F0;
        Wed, 30 Mar 2022 05:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F849609EE;
        Wed, 30 Mar 2022 12:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BA3C340EC;
        Wed, 30 Mar 2022 12:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648645005;
        bh=VHo/+AAAdD7AcNL5Os1HfUvU8wmL18pGNJzsepY5ZFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pV4+Vhu8H9npYiN+2MpM5l1p20Q7roif82TTS4Z8raPdLnd1jZjmE+Hsdr6x4P+Sm
         JkGQTIypsui3dk71t772m8jtP2whIjcMzKwfv7QIN9SNEYpaUSPpykAby50Rlc3+hu
         SoS9eysq7f9cbjp7t57/Gg08jpp1sCGhg/+sLSAYX+RyEMDWxsbwK2WHQ/4pMNak8Z
         jJBsJnQCUL9dpodaRxeQUG1ckZmRAcpKu6SEu/ZrDv6WTWT0+gtiGbr3WWsQFPnWgQ
         Xom+ogFkXPTY+f11UeZczBkm4zNPLXM6xmXm57cEdH5p188zas8gMWP+yXQH2PG9QJ
         z5DtDrj4/oduA==
Date:   Wed, 30 Mar 2022 15:56:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Guo Zhengkui <guozhengkui@vivo.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "zhengkui_guo@outlook.com" <zhengkui_guo@outlook.com>
Subject: Re: [PATCH linux-next] RDMA: simplify if-if to if-else
Message-ID: <YkRTidagKVgSUGld@unreal>
References: <20220328130900.8539-1-guozhengkui@vivo.com>
 <YkQ43f9pFnU+BnC7@unreal>
 <76AE36BF-01F9-420B-B7BF-A7C9F523A45C@oracle.com>
 <YkQ/092IYsQxU9bi@unreal>
 <93D39EC2-6C71-45D8-883A-F8DAA6ECFEDF@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93D39EC2-6C71-45D8-883A-F8DAA6ECFEDF@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 30, 2022 at 12:26:51PM +0000, Haakon Bugge wrote:
> 
> 
> > On 30 Mar 2022, at 13:32, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Wed, Mar 30, 2022 at 11:06:03AM +0000, Haakon Bugge wrote:
> >> 
> >> 
> >>> On 30 Mar 2022, at 13:02, Leon Romanovsky <leon@kernel.org> wrote:
> >>> 
> >>> On Mon, Mar 28, 2022 at 09:08:59PM +0800, Guo Zhengkui wrote:
> >>>> `if (!ret)` can be replaced with `else` for simplification.
> >>>> 
> >>>> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> >>>> ---
> >>>> drivers/infiniband/hw/irdma/puda.c | 4 ++--
> >>>> drivers/infiniband/hw/mlx4/mcg.c   | 3 +--
> >>>> 2 files changed, 3 insertions(+), 4 deletions(-)
> >>>> 
> >>> 
> >>> Thanks,
> >>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> >> 
> >> Fix the unbalanced curly brackets at the same time?
> > 
> > I think that it is ok to have if () ... else { ... } code.
> 
> 
> Hmm, doesn't the kernel coding style say:
> 
> "Do not unnecessarily use braces where a single statement will do."
> 
> [snip]
> 
> "This does not apply if only one branch of a conditional statement is a single statement; in the latter case use braces in both branches"

ok, if it is written in documentation, let's follow it.

Thanks for pointing that out.

> 
> 
> Thxs, Håkon
> 
> 
> > 
> > There is one place that needs an indentation fix, in mlx4, but it is
> > faster to fix when applying the patch instead of asking to resubmit.
> > 
> > thanks
> > 
> >> 
> >> 
> >> Thxs, Håkon
> 
