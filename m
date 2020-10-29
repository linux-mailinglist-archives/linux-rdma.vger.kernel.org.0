Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8B829EAF4
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 12:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgJ2Ltd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 07:49:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgJ2Ltc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Oct 2020 07:49:32 -0400
Received: from localhost (host-213-179-129-39.customer.m-online.net [213.179.129.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E2620796;
        Thu, 29 Oct 2020 11:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603972172;
        bh=+jlfRSXyYBGZ9lQgc+rPeQX6hrXiy5hfZFzjw/GPP1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8KOTCOaVCjvKdzh1Wph4Z2PzyafNLK3egTMHzvPSt3ykol9cMri0kG0g9l0HWj1Z
         lq+CbsHKgKjW+fPl2AVR72VCDAew+j/mW+vVUKAfMz+66uIyLVS7qAxhA6iZRWIzff
         vSvTyEB7vuJq33u408YGZs0DlphySkUWw4XRcTKQ=
Date:   Thu, 29 Oct 2020 13:49:28 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc 1/3] RDMA/core: Postpone uobject cleanup on
 failure till FD close
Message-ID: <20201029114928.GF114054@unreal>
References: <20201012045600.418271-1-leon@kernel.org>
 <20201012045600.418271-2-leon@kernel.org>
 <20201027165508.GA2267703@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027165508.GA2267703@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 27, 2020 at 01:55:08PM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 12, 2020 at 07:55:58AM +0300, Leon Romanovsky wrote:
> > @@ -543,17 +537,9 @@ static int __must_check destroy_hw_idr_uobject(struct ib_uobject *uobj,
> >  			     struct uverbs_obj_idr_type, type);
> >  	int ret = idr_type->destroy_object(uobj, why, attrs);
> >
> > -	/*
> > -	 * We can only fail gracefully if the user requested to destroy the
> > -	 * object or when a retry may be called upon an error.
> > -	 * In the rest of the cases, just remove whatever you can.
> > -	 */
> > -	if (ib_is_destroy_retryable(ret, why, uobj))
> > +	if (ret)
> >  		return ret;
> >
> > -	if (why == RDMA_REMOVE_ABORT)
> > -		return 0;
>
> This shouldn't be deleted..

Yes, this is what we noticed too.

I'll add your version for a couple of days to our regression.

Thanks
