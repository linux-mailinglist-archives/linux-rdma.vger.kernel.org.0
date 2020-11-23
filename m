Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85642C18AC
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 23:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbgKWWnv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 17:43:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731363AbgKWWnu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Nov 2020 17:43:50 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C33E206D5;
        Mon, 23 Nov 2020 22:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606171430;
        bh=y7ECRIVfKd/wCJxrO8QsTJZZThS8Vsu/7i3K/imXrgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyrDk1VITtc6U7Djg4F6pyDPakWlTE+U7xkrqIMXrJKgHrIVIdmF6J7wl/cBjMIKV
         vvB8h6ZrtlPcacIbKJppx6t9N0Dw3lCP0tFBReHGiFmkHly7pyz06T7EpoY8tEeGH6
         NSDZHdKA2PEYsn1YE/i/gjHR7p8qgMl6qSFirZI0=
Date:   Mon, 23 Nov 2020 16:44:04 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 008/141] IB/hfi1: Fix fall-through warnings for Clang
Message-ID: <20201123224404.GC21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <13cc2fe2cf8a71a778dbb3d996b07f5e5d04fd40.1605896059.git.gustavoars@kernel.org>
 <e9d82266-fcef-336e-df61-22d80491d91f@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9d82266-fcef-336e-df61-22d80491d91f@cornelisnetworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 22, 2020 at 09:30:25AM -0500, Mike Marciniszyn wrote:
> 
> On 11/20/2020 1:25 PM, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> > warnings by explicitly adding multiple break statements instead of just
> > letting the code fall through to the next case.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Looks good and tested with TID rdma to cover the interlock case.
> 
> Mike
> 
> Tested-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

Thanks, Mike.
--
Gustavo
