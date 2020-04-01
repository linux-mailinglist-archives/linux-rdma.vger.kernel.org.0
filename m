Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F5719ABA6
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2020 14:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgDAM1F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Apr 2020 08:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbgDAM1E (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Apr 2020 08:27:04 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 471C920776;
        Wed,  1 Apr 2020 12:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585744024;
        bh=eXd3Vs0wNSdsPSapWx3TL2HK2zt58Vodt7QDkASU47g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wXHCAc29m0daGI9FMUQtSjz41unxyUtqY556CihAgR4e1EJjg8LGCNiu/btU8qce1
         rgCyK03XxUUXK5EggqdNqR5DuDkueggfpOcqGM6zW2qF6CnThOtsOJ/3ecYJiNugBi
         jA10D5RAJW3H0vEN1hdt87SBlx3LJFPemEFeSjYI=
Date:   Wed, 1 Apr 2020 15:26:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     George Spelvin <lkml@sdf.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/50] IB/qib: Delete struct qib_ivdev.qp_rnd
Message-ID: <20200401122659.GA80989@unreal>
References: <202003281643.02SGh6eG002694@sdf.org>
 <20200329141710.GE20941@ziepe.ca>
 <20200329160825.GA4675@SDF.ORG>
 <20200330132808.GB20969@lakrids.cambridge.arm.com>
 <20200330164333.GB2459@SDF.ORG>
 <20200330164912.GK20941@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330164912.GK20941@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 30, 2020 at 01:49:12PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 30, 2020 at 04:43:33PM +0000, George Spelvin wrote:
> > On Mon, Mar 30, 2020 at 02:28:08PM +0100, Mark Rutland wrote:
> > > Also, if you do send a series, *please* add a cover-letter explaining
> > > what the overall purpose of the series is, and have all patches chained
> > > in-reply-to that rather than patch 1. Otherwise reviewers have to
> > > reverse-engineer the intent of the author.
> > >
> > > You can generate the cover letter with:
> > >
> > > $ git format-patch --cover $FROM..$TO
> > >
> > > ... and IIRC git send-email does the right thing by default if you hand
> > > it all of the patches at once.
> >
> > Er, I *did* send a cover letter.  Cc:ed to the union of everyone
> > Cc:ed on any of the individual patches.  It's appended.  (I left in
> > the full Cc: list so you can see you're on it.)
> >
> > My problem is I don't have git on my e-mail machine, so I fed them to
> > sendmail manually, and that does some strange things.
>
> The problem is that none of the patches had a in-reply-to header to
> the cover letter so it is very difficult to find it.
>
> Things work best if you can use git send-email :) I've never tried it,
> bu I wonder if you can tell git that the sendmail is 'ssh foo-server
> /usr/bin/sendmail' ?

I don't know if it is possible to do directly, but such feature is
achievable through custom script.

I'm doing it to be able to send emails with git-send-email in offline
mode too.

In my .gitconfig:
 28 [sendemail]
 29         smtpserver = /usr/local/bin/msmtp-enqueue.sh

Thanks

>
> Jason
