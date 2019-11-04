Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29287EDFE8
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2019 13:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfKDMWK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Nov 2019 07:22:10 -0500
Received: from stargate.chelsio.com ([12.32.117.8]:51607 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbfKDMWK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Nov 2019 07:22:10 -0500
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id xA4CLuYi032264;
        Mon, 4 Nov 2019 04:22:02 -0800
Date:   Mon, 4 Nov 2019 17:51:50 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: [PATCH rdma-core] cxgb4: free appropriate pointer in error case
Message-ID: <20191104122149.GA8473@chelsio.com>
References: <1572866050-29952-1-git-send-email-bharat@chelsio.com>
 <20191104114548.GA100753@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104114548.GA100753@unreal>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Monday, November 11/04/19, 2019 at 17:15:48 +0530, Leon Romanovsky wrote:
> On Mon, Nov 04, 2019 at 04:44:10PM +0530, Potnuri Bharat Teja wrote:
> > Fixes: 9b2d3af5735e ("Query device to get the max supported stags, qps, and cqs")
> > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > ---
> 
> We are not super-excited to see patches with empty commit message.
My bad sent an older one instead. Shall resend the right one.
> Care to send PR to rdma-core? It will be easier for us to merge it.
This is how i do for rdma-core patches. first sent to mailing list and then
send a PR. Is it the other way?
> 
> Thanks
> 
> >  providers/cxgb4/dev.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/providers/cxgb4/dev.c b/providers/cxgb4/dev.c
> > index 7f5955449ca1..4d02c7a91892 100644
> > --- a/providers/cxgb4/dev.c
> > +++ b/providers/cxgb4/dev.c
> > @@ -203,9 +203,9 @@ err_free:
> >  	if (rhp->cqid2ptr)
> >  		free(rhp->cqid2ptr);
> >  	if (rhp->qpid2ptr)
> > -		free(rhp->cqid2ptr);
> > +		free(rhp->qpid2ptr);
> >  	if (rhp->mmid2ptr)
> > -		free(rhp->cqid2ptr);
> > +		free(rhp->mmid2ptr);
> >  	verbs_uninit_context(&context->ibv_ctx);
> >  	free(context);
> >  	return NULL;
> > --
> > 2.3.9
> >
