Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018A7697ACA
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Feb 2023 12:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjBOLbi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Feb 2023 06:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjBOLbh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Feb 2023 06:31:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9064910F0;
        Wed, 15 Feb 2023 03:31:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE33F61B23;
        Wed, 15 Feb 2023 11:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51ECC433D2;
        Wed, 15 Feb 2023 11:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676460695;
        bh=5TAYEJH09LJv4kHX38MSdb0hT+72Ljn17p1+0e1ea7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ich2KCPrUUpQAyMk65Nj7qAwATF7dKnYYsw4vHmHlfxSW9pKLSKJCQvNQU7pMygtO
         R4mgSTSfc8wbxBvNONrY3h0w3QYMbf2MPD6QGouCZ3woAkg+Bwhz/G/MLB8LK6XMFJ
         mLUznTRf5wcokRkStbl9eOxpMU7AiZrTyW2bz+xdxjWML/CJ0bb8+h+wYvT2DHcuWp
         KJBrJOlO4V1aW/6UXLBiodti1OWrwxuakDiABaBa6zfDYYLjAp1TNp/Yw/Fw/boSed
         rdLlRFZfuAbPKQznxEytRuEUWQgV8Z0cajPafNZiisjgP+gdR01A0bwY+7iUnaOJlV
         S6LqJpumZhdGA==
Date:   Wed, 15 Feb 2023 13:31:31 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/restrack: Reorder fields in 'struct
 rdma_restrack_entry'
Message-ID: <Y+zCkwTgevj0zDFK@unreal>
References: <d47800d9fd5ac7c33d01af04b12b6d43ad23c96e.1676379187.git.christophe.jaillet@wanadoo.fr>
 <Y+uH0k0OBzPip1P8@ziepe.ca>
 <75480cf9-8d06-7a7d-4624-6ddbb7d6053a@wanadoo.fr>
 <Y+uiLCB7H2xVvQZW@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+uiLCB7H2xVvQZW@ziepe.ca>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 14, 2023 at 11:01:00AM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 14, 2023 at 03:34:21PM +0100, Christophe JAILLET wrote:
> > Le 14/02/2023 à 14:08, Jason Gunthorpe a écrit :
> > > On Tue, Feb 14, 2023 at 01:53:52PM +0100, Christophe JAILLET wrote:
> > > > diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
> > > > index 8b7c46daeb07..da53fefe6f9e 100644
> > > > --- a/include/rdma/restrack.h
> > > > +++ b/include/rdma/restrack.h
> > > > @@ -80,6 +80,10 @@ struct rdma_restrack_entry {
> > > >   	 * query stage.
> > > >   	 */
> > > >   	u8			no_track : 1;
> > > > +	/**
> > > > +	 * @user: user resource
> > > > +	 */
> > > > +	bool			user;
> > > 
> > > Can we combine this into the bitfield above?
> > > 
> > > Jason
> > > 
> > Hi,
> > 
> > and even above, we have
> > 	bool	valid;
> > 
> > I wanted to keep the changes as minimal as possible, but I can change them
> > all in a single bitfield.
> 
> IIRC it needs to be checked, I vaugely remember valid can't be a
> bitfield because it is an atomic

I don't remember anything like this.

Thanks
