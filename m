Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18617221A7
	for <lists+linux-rdma@lfdr.de>; Sat, 18 May 2019 06:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfEREyU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 May 2019 00:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfEREyT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 18 May 2019 00:54:19 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D24206BF;
        Sat, 18 May 2019 04:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558155259;
        bh=jnXkOIDwUYW32wfx02+0c69PM7vJt0IOrcU0gDJa4WA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L36Za1Q9IOikSGa63ujG+/APkQxxNuAshjHHhyN0VfW7TDuHS09ZQXruitJZH+d7l
         mQkTF/5/sgY+1UH0f/wcw5HG4nXg3v7WU7HBc8PYOFXGr7AR7lSo6s9MvEPIDianHj
         jITf2BkA85hCBMrEeCOnSExn0jeP3Bu/fdvqzja8=
Date:   Sat, 18 May 2019 07:54:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanjun Zhu <yanjun.zhu@oracle.com>
Cc:     Steve Wise <larrystevenwise@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: rdma-core debian packages
Message-ID: <20190518045402.GB5822@mtr-leonro.mtl.com>
References: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com>
 <20190517182129.GA5822@mtr-leonro.mtl.com>
 <49901cc5-6fbc-c540-dbb3-1b3f23f1d689@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49901cc5-6fbc-c540-dbb3-1b3f23f1d689@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 18, 2019 at 09:32:48AM +0800, Yanjun Zhu wrote:
>
> On 2019/5/18 2:21, Leon Romanovsky wrote:
> > On Fri, May 17, 2019 at 09:14:13AM -0500, Steve Wise wrote:
> > > Hey,
> > >
> > > Is there a how-to somewhere on building the Debian rdma-core packages?
> > There buildlib/cbuild script exactly for that.
> >
> > 0. Install docker.
> > 1. Commit your changes which you want to package.
> > 2. ./buildlib/cbuild build-images supported_os_from_the_list
> > 3. ./buildlib/cbuild make supported_os_from_the_list
> > 4. ./buildlib/cbuild pkg supported_os_from_the_list
> > 5. See RPMs or DEBs in ../
> >
> > Repeat 3 and 4 till you will be satisfied with result.
>
> 1. git clone git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git

We are talking about https://github.com/linux-rdma/rdma-core/
and not about kernel.

Thanks
