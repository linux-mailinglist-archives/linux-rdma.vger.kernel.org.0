Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A5A66B045
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 11:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjAOKNY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 05:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjAOKNX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 05:13:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC00CCDE1;
        Sun, 15 Jan 2023 02:13:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CC7960C85;
        Sun, 15 Jan 2023 10:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C3CC433EF;
        Sun, 15 Jan 2023 10:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673777601;
        bh=PF45Ke28dIqcsl7XoD+NZxQPtsTjmtK6BDHKZ+5CuoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EOvLPR2/beXntT0buCCFsjz2uyHmaZGmcW4JqHWy4wjZkAHadstnfLOiEi1+ajNiF
         5CjrPckGNCzJw2+v3gd5r2JSZG0PWUge5UjqDRiFJNH2fe292eU/XaK6WeEzmjMRdW
         Rto1FgRSywQba6SCD9i3jGZIVZU8+TuV7y1BDTvxvAY92a8juMdDGEX5/EVYPDRN6+
         SXXOyKBKbMavYnjCK6w/hFDmq4Qp1Cx7cmRX0ToSE+qPTNxR+x4bByzc95U+/BKiah
         mBbij7KshS5eJr/It9rua+IAU0vPjUbwaSwhUYpfAiAFKSD2P0CQogY2rVmYucST6t
         +5En82xdAuZNA==
Date:   Sun, 15 Jan 2023 12:13:17 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/cxgb4: Replace 0-length arrays with flexible arrays
Message-ID: <Y8PRvay5o3iG22pr@unreal>
References: <20230105223225.never.252-kees@kernel.org>
 <Y7qyVPlNBQaGbInf@unreal>
 <202301131703.D2D667E3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202301131703.D2D667E3@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 13, 2023 at 05:03:48PM -0800, Kees Cook wrote:
> On Sun, Jan 08, 2023 at 02:08:52PM +0200, Leon Romanovsky wrote:
> > On Thu, Jan 05, 2023 at 02:32:32PM -0800, Kees Cook wrote:
> > > Zero-length arrays are deprecated[1]. Replace all remaining
> > > 0-length arrays with flexible arrays. Detected with GCC 13, using
> > > -fstrict-flex-arrays=3:
> > > 
> > > In function 'build_rdma_write',
> > >     inlined from 'c4iw_post_send' at ../drivers/infiniband/hw/cxgb4/qp.c:1173:10:
> > > ../drivers/infiniband/hw/cxgb4/qp.c:597:38: warning: array subscript 0 is outside array bounds of 'struct fw_ri_immd[0]' [-Warray-bounds=]
> > >   597 |                 wqe->write.u.immd_src[0].r2 = 0;
> > >       |                 ~~~~~~~~~~~~~~~~~~~~~^~~
> > > ../drivers/infiniband/hw/cxgb4/t4fw_ri_api.h: In function 'c4iw_post_send':
> > > ../drivers/infiniband/hw/cxgb4/t4fw_ri_api.h:567:35: note: while referencing 'immd_src'
> > >   567 |                 struct fw_ri_immd immd_src[0];
> > >       |                                   ^~~~~~~~
> > > 
> > > Additionally drop the unused C99_NOT_SUPPORTED ifndef lines.
> > > 
> > > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> > > 
> > > Cc: Potnuri Bharat Teja <bharat@chelsio.com>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: Leon Romanovsky <leon@kernel.org>
> > > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > > Cc: linux-rdma@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  drivers/infiniband/hw/cxgb4/t4fw_ri_api.h | 26 ++++++-----------------
> > >  1 file changed, 6 insertions(+), 20 deletions(-)
> > 
> > <...>
> > 
> > >  #define FW_RI_SEND_WR_SENDOP_S		0
> > > @@ -618,12 +606,10 @@ struct fw_ri_rdma_write_cmpl_wr {
> > >  		struct fw_ri_isgl isgl_src;
> > >  	} u_cmpl;
> > >  	__be64 r3;
> > > -#ifndef C99_NOT_SUPPORTED
> > >  	union fw_ri_write {
> > > -		struct fw_ri_immd immd_src[0];
> > > -		struct fw_ri_isgl isgl_src[0];
> > > +		DECLARE_FLEX_ARRAY(struct fw_ri_immd, immd_src);
> > > +		DECLARE_FLEX_ARRAY(struct fw_ri_isgl, isgl_src);
> > 
> > smatch built from commit 40351132df3b ("strlen: add __builtin and
> > __fortify functions") produces the following warning:
> > drivers/infiniband/hw/cxgb4/t4fw_ri_api.h:575:17: warning: array of flexible structures
> > 
> > Is it expected? What will prevent from getting this warning from 0-day
> > build bots?
> 
> Err, I'm not sure I understand? Does smatch define "C99_NOT_SUPPORTED"?

Why should it define? You removed C99_NOT_SUPPORTED.

Just download smatch, build from scratch and run over this patch. It
generates new warning.

➜  kernel git:(wip/leon-for-next) mkt ci --no-sparse --no-extra-warnings
ccdbefcf661e (HEAD -> build) RDMA/cxgb4: Replace 0-length arrays with flexible arrays
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#11:
    inlined from 'c4iw_post_send' at ../drivers/infiniband/hw/cxgb4/qp.c:1173:10:

drivers/infiniband/hw/cxgb4/t4fw_ri_api.h:558:17: warning: array of flexible structures
....



> 
> -- 
> Kees Cook
