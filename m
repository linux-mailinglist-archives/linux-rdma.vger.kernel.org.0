Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A937272DD61
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbjFMJNn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 05:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239834AbjFMJNl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 05:13:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC8B1B0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 02:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3962262BB1
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 09:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21669C433D2;
        Tue, 13 Jun 2023 09:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686647619;
        bh=C6ZCZgVXHrSl7hQVw44t+NYmReCFKTl3fJ/yUAoDQOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lw45OuLVHQSswwOzcG17BAxzm0tnchKNwqI1aZsWxQiX/Qi7zEJu79MNvqt6mwvxr
         IkiYaNWN7lKOnynhC843zN88Vu6QbENg3qVcz2j9S9KiOj1nbOQ30rXvrNdH3a/kNh
         C+ycnxwOvoRUTw/gzJP6Blj5MWvnJ+hoDpkS2cWqOJUURLJv4+gdeW32Rb4mcQFN6m
         ujq3W6v3/z99IcuHIXQMDKtOyDumH1drQs/j6Phc9KO3AqjEav7uO+Z4S+/eku/yIe
         0gshPONT0hU5qpZeWp91HAi20CK+zzL82SW1ohq7tZb2lyYC0qiqWx3qou7B6wH6ob
         iIGgGPstJbtdQ==
Date:   Tue, 13 Jun 2023 12:13:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Chuck Lever <cel@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cma: Address sparse warnings
Message-ID: <20230613091335.GX12152@unreal>
References: <168625482324.6564.3866640282297592339.stgit@oracle-102.nfsv4bat.org>
 <20230611180748.GI12152@unreal>
 <64058A51-B935-4027-B00B-E83428E25BFB@oracle.com>
 <20230612061032.GL12152@unreal>
 <3E4B9E99-4B2F-40B7-8B14-D0A18FC01B4D@oracle.com>
 <ZIceBDrARRE4sG5P@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIceBDrARRE4sG5P@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 12, 2023 at 10:30:44AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 12, 2023 at 01:27:23PM +0000, Chuck Lever III wrote:
> 
> > > I think this change will solve it.
> > > 
> > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > index 93a1c48d0c32..435ac3c93c1f 100644
> > > --- a/drivers/infiniband/core/cma.c
> > > +++ b/drivers/infiniband/core/cma.c
> > > @@ -2043,7 +2043,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> > >  * handlers can start running concurrently.
> > >  */
> > > static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
> > > - 	__releases(&idprv->handler_mutex)
> > > + 	__releases(&id_prv->handler_mutex)
> > 
> > The argument of __releases() is still mis-spelled: s/id_prv/id_priv/
> > 
> > I can't say I like this solution. It adds clutter but doesn't improve
> > the documentation of the lock ordering.
> > 
> > Instead, I'd pull the mutex_unlock() out of destroy_id_handler_unlock(),
> > and then make each of the call sites do the unlock. For instance:
> > 
> >  void rdma_destroy_id(struct rdma_cm_id *id)
> >  {
> >         struct rdma_id_private *id_priv =
> >                 container_of(id, struct rdma_id_private, id);
> > +       enum rdma_cm_state state;
> > 
> >         mutex_lock(&id_priv->handler_mutex);
> > -       destroy_id_handler_unlock(id_priv);
> > +       state = destroy_id_handler(id_priv);
> > +       mutex_unlock(&id_priv->handler_mutex);
> > +       _destroy_id(id_priv, state);
> >  }
> >  EXPORT_SYMBOL(rdma_destroy_id);
> > 
> > That way, no annotation is necessary, and both a human being and
> > sparse can easily agree that the locking is correct.
> 
> I don't like it, there are a lot of call sites and this is tricky
> stuff.
> 
> I've just been ignoring sparse locking annotations, they don't really
> work IMHO.

And I would like to see sparse/smatch to be fixed. It helps to do not
oversight things.

Thanks

> 
> Jason
