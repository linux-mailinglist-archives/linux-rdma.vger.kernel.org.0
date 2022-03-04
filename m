Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDB54CCEF0
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 08:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiCDHQl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Mar 2022 02:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238733AbiCDHQF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Mar 2022 02:16:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3A71AAA4A
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 23:11:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 884A261D93
        for <linux-rdma@vger.kernel.org>; Fri,  4 Mar 2022 07:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C35C340E9;
        Fri,  4 Mar 2022 07:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646377859;
        bh=NlHSWL/QEUGDcyaiSluT5QhdFPUhGnmptNu6HjX1NLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQasGGFE9jrk9fBMGfKHFFp4Iz0WXKYdp/cIqAOPo//DtvIhTzpyBbaQNmYXvej50
         JUcAuDnOU5lvQjIVpmD4OmgiSEiO8RM9MVr5o+qCaXdCgNvO2J4rq/qfMLfslq+M5R
         sZDR7ltUcNex6yCChmxCUWNybfz9wXlXJtufbLQkg2aCdI7msZP+rJNVOHelMLLoXY
         JAbYtCUY8UvzcDsSLcECJkogPBxb2cSMZyUsqcREpjF+cTSbgM5TVM//o+Ratin/WG
         rlSP9QBSXga6tZzHLj2foOeyc4haEfS32nQnpSjkY4cOgWmsMY/ga7VCVTddfRVkUE
         MqihDlcMAndcw==
Date:   Fri, 4 Mar 2022 09:10:55 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: change payload type to u32 from int
Message-ID: <YiG7f16SZolUhks3@unreal>
References: <20220302141054.2078616-1-cgxu519@mykernel.net>
 <YiEDNPT/T69Y0Vmu@unreal>
 <fbb14096-c8fa-80f2-3692-ee4f828e452f@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbb14096-c8fa-80f2-3692-ee4f828e452f@mykernel.net>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 04, 2022 at 10:08:29AM +0800, Chengguang Xu wrote:
> 在 2022/3/4 2:04, Leon Romanovsky 写道:
> > On Wed, Mar 02, 2022 at 10:10:54PM +0800, Chengguang Xu wrote:
> > > The type of wqe length is u32 so change variable payload
> > > to type u32 to avoid overflow on large wqe length.
> > > 
> > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> > > ---
> > >   drivers/infiniband/sw/rxe/rxe_req.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> > > index 5eb89052dd66..e989ee3a2033 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_req.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> > > @@ -612,7 +612,7 @@ int rxe_requester(void *arg)
> > >   	struct sk_buff *skb;
> > >   	struct rxe_send_wqe *wqe;
> > >   	enum rxe_hdr_mask mask;
> > > -	int payload;
> > > +	u32 payload;
> > This change is not complete, functions in rxe_requester() that receive
> > payload as an input should be changed too.
> 
> IIUC, when calling those functions payload has been cut off to mtu size
> and I think mtu will be much smaller than 2GB, so there is no rish of
> overflow.

It is not because of overflow, but desire to have proper types for whole
call stack without shadow casting and ambiguity.

Thanks

> 
> Thanks,
> Chengguang
> 
> > 
> > >   	int mtu;
> > >   	int opcode;
> > >   	int ret;
> > > -- 
> > > 2.27.0
> > > 
> > > 
> 
> 
