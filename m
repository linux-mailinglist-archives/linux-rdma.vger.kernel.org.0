Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9963DFB2E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 07:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhHDFlg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Aug 2021 01:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231611AbhHDFlg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Aug 2021 01:41:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9AAF06056C;
        Wed,  4 Aug 2021 05:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628055684;
        bh=ZsD47Kq6V/0A+S4f1/7NhubdVZcF/Jwct/NA68kgk10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hd1xytRYJJaGjvBDuaUf+/y8XcKTf19jluUXY76wJK7GpcmVMiSq3wZQvfyo+CzTY
         Dzvug1DoKKGKjstylSLNQ9LrKFlx4hnEfueBpV/F9lhIMcOB1EB8sj7cJXBzh+6N33
         wGVD9NW8XZTArAyq5WtuoJOMl45RSLmP7B2M/QYxcUe5WCcPkFngF8rl0kIjpmJ8tV
         PWohpcobQhUnUyuL5Z6kNaiROE4Q+wdZcvi9wR7esOz16JmhbPzuVNfDB0fzJyjN20
         I85ONQY6FK72QSV+esdn7qPa6/m6f0KIi2nKnqeI4nfeUfYMBEv+0+faQJaAYRThVm
         CA6omgnUDa51Q==
Date:   Wed, 4 Aug 2021 08:41:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: RXE status in the upstream rping using rxe
Message-ID: <YQoogK7uWCLHUzcs@unreal>
References: <YQmF9506lsmeaOBZ@unreal>
 <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
 <CAD=hENfua2UXH6rVuhMPXYsNSavqG==T3h=z4f=huf+Fj+xiHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENfua2UXH6rVuhMPXYsNSavqG==T3h=z4f=huf+Fj+xiHA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 04, 2021 at 09:09:41AM +0800, Zhu Yanjun wrote:
> On Wed, Aug 4, 2021 at 9:01 AM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
> >
> > On Wed, Aug 4, 2021 at 2:07 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > Can you please help me to understand the RXE status in the upstream?
> > >
> > > Does we still have crashes/interop issues/e.t.c?
> >
> > I made some developments with the RXE in the upstream, from my usage
> > with latest RXE,
> > I found the following:
> >
> > 1. rdma-core can not work well with latest RDMA git;
> 
> The latest RDMA git is
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git

"Latest" is a relative term, what SHA did you test?
Let's focus on fixing RXE before we will continue with new features.

Thanks
