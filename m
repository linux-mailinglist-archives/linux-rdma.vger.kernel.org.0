Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E44C220F34
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 21:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfEPTZl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 15:25:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfEPTZl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 15:25:41 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA10A206A3;
        Thu, 16 May 2019 19:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558034740;
        bh=GDpMfwuGQrLsN3Sub79u1VtuIE3+65a6qVjJQwaU2I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/ChbAecKvxC5eTbUjKtoqBrwdO6xXwlNbn/VIvEw60b/G+zxvuhVllA9z+v+F2+f
         F3fwu+I+kic1CqiEmA77M6B6kclQ1VlLzAfvLHDMNsZUX5yrt0SpWIpWXoQLcVgBRG
         7La7yWG4HlkyqUF1pzq23+ids7+s1P/K+sd0bDkA=
Date:   Thu, 16 May 2019 22:25:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core 06/20] build: Support rst as a man page option
Message-ID: <20190516192529.GD6026@mtr-leonro.mtl.com>
References: <20190514234936.5175-1-jgg@ziepe.ca>
 <20190514234936.5175-7-jgg@ziepe.ca>
 <20190516164734.GC6026@mtr-leonro.mtl.com>
 <20190516165149.GG22587@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516165149.GG22587@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 16, 2019 at 01:51:49PM -0300, Jason Gunthorpe wrote:
> On Thu, May 16, 2019 at 07:47:34PM +0300, Leon Romanovsky wrote:
> > On Tue, May 14, 2019 at 08:49:22PM -0300, Jason Gunthorpe wrote:
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > >
> > > infiniband-diags uses rst as a man page preprocessor, so add it along side
> > > pandoc in the build system.
> >
> > Why don't we convert RST to MD prior to integrating infiniband-diags
> > into rdma-core, instead of introducing extra dependency and complexity?
>
> The ibdiags stuff uses RST's #include feature extensively and
> unwinding all of that is simply too hard. Maybe someday we can do it.

Doesn't pandoc handle such conversion? Anyway you are introducing some
tooling to do some conversion on the flight.

Thanks

>
> Jason
