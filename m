Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A48696786
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 16:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjBNPBQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Feb 2023 10:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjBNPBM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Feb 2023 10:01:12 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DC2A9B4
        for <linux-rdma@vger.kernel.org>; Tue, 14 Feb 2023 07:01:03 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id ch10so16571431qtb.11
        for <linux-rdma@vger.kernel.org>; Tue, 14 Feb 2023 07:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IWClI4gmqGN4DlU8lND230mPm2ROhEH1JY/mvbe9IGY=;
        b=ef6d2jKYU3nPPxyVbosZ51CBYb7roCJPlQ4NryeZdFF13Tr3ltLwWFXTWmtAfy28GR
         aYXpVWl3dUDp8fe0SpOb3qwZ375nxS9u6ugpwY8FBLDtS7rUKDm/4Pn8QIpAcziR7ezW
         2Cc/1QSN5NFq2iYp/zMY2AZvdk4VP3kxJ3kSmp8w9X3RXDj4+kQFK6wwFcN1H8z9+0MB
         uvPww2oce5T06kjF/x9cD3weEOOs/5dOR/lMPdaeDnYsLWH0d59D++bu+Vylfx0vdRZb
         0M6xtSMqfk3NP3p3mCsmbYfl1O2nxDxd2FIc0NvxAyrlBLJJwAT2VsKdK1jN4dpa7BoV
         Jv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWClI4gmqGN4DlU8lND230mPm2ROhEH1JY/mvbe9IGY=;
        b=gFKP2OduNNsPL4cQ2PAv3Vcfy/aGN4huOfcKhTG4belRmsAO8iCOogGA09YPhXdsG7
         YKJTKU5dLDJ1I++02D7QxCKgodmuV5saFa26WnzbAvLmv1Uk04zKAkN0XwOippSNuH6M
         h79oJrGAeLFalSrIb4DAXYbgDxQZBdgUCEI43QE5LWaM1pZIs0tzDTGvO2n45ngawbe0
         DFMGlRqAuej3dTVa4B40PvsbOo2EMk9pBfLb0g54MRjbFSil9dkoPR5ZsEPkutqouuke
         svc71GnGzndqnraV7JKyNKZeXsK1TOBFj5nSvHGHHdRkHUlvwQIUXFWtpo1IoDLK55QB
         JyLA==
X-Gm-Message-State: AO0yUKUdf5rbhyjQOy8L7Qn2AuVbr93lUW5FdFhSJPL6OlmspxZ3qmQj
        Yh5iq7V1jCf7A0pBYPjKzBggBw==
X-Google-Smtp-Source: AK7set8/INvNdj6TDxgd7rqMzcASY2jtFBOsamVV51VAlU7OICrs7+stQvx8HLmwXKP0SYGLlqLFRA==
X-Received: by 2002:ac8:4e45:0:b0:3b8:2e36:efd with SMTP id e5-20020ac84e45000000b003b82e360efdmr4837930qtw.55.1676386862310;
        Tue, 14 Feb 2023 07:01:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-167-59-176.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.59.176])
        by smtp.gmail.com with ESMTPSA id p19-20020ac84093000000b003b6325dfc4esm11200235qtl.67.2023.02.14.07.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:01:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pRwnk-000RYJ-T3;
        Tue, 14 Feb 2023 11:01:00 -0400
Date:   Tue, 14 Feb 2023 11:01:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/restrack: Reorder fields in 'struct
 rdma_restrack_entry'
Message-ID: <Y+uiLCB7H2xVvQZW@ziepe.ca>
References: <d47800d9fd5ac7c33d01af04b12b6d43ad23c96e.1676379187.git.christophe.jaillet@wanadoo.fr>
 <Y+uH0k0OBzPip1P8@ziepe.ca>
 <75480cf9-8d06-7a7d-4624-6ddbb7d6053a@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75480cf9-8d06-7a7d-4624-6ddbb7d6053a@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 14, 2023 at 03:34:21PM +0100, Christophe JAILLET wrote:
> Le 14/02/2023 à 14:08, Jason Gunthorpe a écrit :
> > On Tue, Feb 14, 2023 at 01:53:52PM +0100, Christophe JAILLET wrote:
> > > diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
> > > index 8b7c46daeb07..da53fefe6f9e 100644
> > > --- a/include/rdma/restrack.h
> > > +++ b/include/rdma/restrack.h
> > > @@ -80,6 +80,10 @@ struct rdma_restrack_entry {
> > >   	 * query stage.
> > >   	 */
> > >   	u8			no_track : 1;
> > > +	/**
> > > +	 * @user: user resource
> > > +	 */
> > > +	bool			user;
> > 
> > Can we combine this into the bitfield above?
> > 
> > Jason
> > 
> Hi,
> 
> and even above, we have
> 	bool	valid;
> 
> I wanted to keep the changes as minimal as possible, but I can change them
> all in a single bitfield.

IIRC it needs to be checked, I vaugely remember valid can't be a
bitfield because it is an atomic
> Do you want code such as:
> static void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
> 				      struct task_struct *task)
> {
> 	if (WARN_ON_ONCE(!task))
> 		return;
> 
> 	if (res->task)
> 		put_task_struct(res->task);
> 	get_task_struct(task);
> 	res->task = task;
> 	res->user = true;			<--------
> }
>
> to be changed with 0/1 instead of false/true?

I'd keep with true/false

Ideally the bitfield itself would be bool type too

> Apparently gcc 11.3 is fine with using true with u8:1, but I don't find it
> really logical.

Bool types can be casted to integers in defined ways, it is pretty
normal.

Jason
