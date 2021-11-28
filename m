Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483414606EF
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Nov 2021 15:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357848AbhK1Oen (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Nov 2021 09:34:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45732 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358035AbhK1Ocn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Nov 2021 09:32:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D962161012;
        Sun, 28 Nov 2021 14:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673A1C004E1;
        Sun, 28 Nov 2021 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638109766;
        bh=5CIWnX4jEum1UXPdmPD036y813Y+usP22f2Ah132sPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlIdML7W1m/jo/cdz79UYbWa58tgd07DOfUgcE3tXd2kr8pggyxRkNTInwVo/O2m1
         SQE463wvwCjhvXpNMGmH5b0mf7pDunK4SM48+wFEobLW7iQKknQ/aSHGHoaoyRceGT
         aBEzvK6Gb+OVilSBzwoFaetmQJSVDGBGP7l/7sDk=
Date:   Sun, 28 Nov 2021 15:29:22 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "arnd@arndb.de" <arnd@arndb.de>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] mei: Remove some dead code
Message-ID: <YaOSQrGqogbFGAqJ@kroah.com>
References: <3f904c291f3eed06223dd8d494028e0d49df6f10.1636711522.git.christophe.jaillet@wanadoo.fr>
 <80B25490-FE92-420E-A506-C92A996EF174@oracle.com>
 <17d6896a6abf49138556e34cb426d575@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d6896a6abf49138556e34cb426d575@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 28, 2021 at 11:12:33AM +0000, Winkler, Tomas wrote:
> 
> > 
> > 
> > > On 12 Nov 2021, at 11:06, Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> > >
> > > 'generated' is known to be true here, so "true || whatever" will still
> > > be true.
> > >
> > > So, remove some dead code.
> > >
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > ---
> > > This is also likely that a bug is lurking here.
> > >
> > > Maybe, the following was expected:
> > > -	generated = generated ||
> > > +	generated =
> > > 		(hisr & HISR_INT_STS_MSK) ||
> > > 		(ipc_isr & SEC_IPC_HOST_INT_STATUS_PENDING);
> > >
> > > ?
> > 
> > I concur about your analysis, but I do not know the intent here.
> Your fix  is okay, I can ack that patch. 

Is that an ack of this patch?  If so, please provide that...

thanks,

greg k-h
