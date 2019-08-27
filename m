Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25DF9EBE5
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2019 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfH0PIf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 11:08:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43541 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfH0PIf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Aug 2019 11:08:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3717B308123B;
        Tue, 27 Aug 2019 15:08:35 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B8ED560BFB;
        Tue, 27 Aug 2019 15:08:32 +0000 (UTC)
Date:   Tue, 27 Aug 2019 10:08:30 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
Message-ID: <20190827150830.brsvsoopxut2od66@treble>
References: <OFE93E0F86.E35CE856-ON00258434.002A83CE-00258434.002A83DF@notes.na.collabserv.com>
 <20190711081434.GA86557@archlinux-threadripper>
 <20190711133915.GA25807@ziepe.ca>
 <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
 <20190711171808.GF25807@ziepe.ca>
 <20190711173030.GA844@archlinux-threadripper>
 <20190823142427.GD12968@ziepe.ca>
 <20190826153800.GA4752@archlinux-threadripper>
 <20190826154228.GE27349@ziepe.ca>
 <20190826233829.GA36284@archlinux-threadripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826233829.GA36284@archlinux-threadripper>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 27 Aug 2019 15:08:35 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 04:38:29PM -0700, Nathan Chancellor wrote:
> Looks like that comes from tune_qsfp, which gets inlined into
> tune_serdes but I am far from an objtool expert so I am not
> really sure what kind of issues I am looking for. Adding Josh
> and Peter for a little more visibility.
> 
> Here is the original .o file as well:
> 
> https://github.com/nathanchance/creduce-files/raw/4e252c0ca19742c90be1445e6c722a43ae561144/rdma-objtool/platform.o.orig

     574:       0f 87 00 0c 00 00       ja     117a <tune_serdes+0xdfa>

It's jumping to la-la-land past the end of the function.

-- 
Josh
