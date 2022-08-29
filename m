Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2385A437E
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 09:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiH2HCr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 03:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiH2HCr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 03:02:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEC5474C7
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 00:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31826B80CCA
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 07:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CC2C433D6;
        Mon, 29 Aug 2022 07:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661756563;
        bh=RSlUn73BULfL/+paoWL1o9HbOHo1o3wotRpUZQPKkI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMgpCRHkeSJbRosw1fxAINCBeRlAoR46f0clrT96Q64u6FFwxzyxP+ocT+PH/8B/P
         ZKk16StCM1ADNB2Qg4MdTieC7eGkhg8PxYVhpe3tkNiP6031iC7mwkobFrEPfnYwQm
         bSHvx7qhAC3Rtx9sQF07HEsTcZkHFQKW/+w6dRpsnE/kZUqo3RL2maTi56ENZ0EewH
         aY7sgrA6af0UNb5dnWOAT7kF2TVctov44Bth8QWHlwbeXH0JvNYpCUuBE8u8d5hFOu
         IbMFE3QnAUln238yThnshfOpIS7LelVVy1U+tGwSHBn8nKOrrMsGaJfN63gikA8Tp0
         pAyVS9AEVGZsQ==
Date:   Mon, 29 Aug 2022 10:02:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Delete error messages triggered by incoming
 Read requests
Message-ID: <Ywxkj4JqZpFr6w+V@unreal>
References: <Ywi8ZebmZv+bctrC@nvidia.com>
 <20220829054413.1630495-1-matsuda-daisuke@fujitsu.com>
 <CAD=hENf0d_HyPRi2wmWLswULrn9UWHvQvz54-E7=M5DTSB-qGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENf0d_HyPRi2wmWLswULrn9UWHvQvz54-E7=M5DTSB-qGg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 29, 2022 at 02:31:00PM +0800, Zhu Yanjun wrote:
> On Mon, Aug 29, 2022 at 1:45 PM Daisuke Matsuda
> <matsuda-daisuke@fujitsu.com> wrote:
> >
> > An incoming Read request causes multiple Read responses. If a user MR to
> > copy data from is unavailable or responder cannot send a reply, then the
> > error messages can be printed for each response attempt, resulting in
> > message overflow.
> >
> > Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> > ---
> >  drivers/infiniband/sw/rxe/rxe_resp.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> > index b36ec5c4d5e0..4b3e8aec2fb8 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> > @@ -811,8 +811,6 @@ static enum resp_states read_reply(struct rxe_qp *qp,
> >
> >         err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
> >                           payload, RXE_FROM_MR_OBJ);
> > -       if (err)
> > -               pr_err("Failed copying memory\n");
> 
> pr_err_once is better?

Like Jason said, there shouldn't any prints in network triggered flows.

Thanks
