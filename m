Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5963D081A
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 07:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhGUEbL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 00:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232512AbhGUEaw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 00:30:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5348A60FE7;
        Wed, 21 Jul 2021 05:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626844290;
        bh=pHR2j/1bWtegDLobNbANc0THMPZSOJdmsO6JZSbVrvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6vKnKOXleULywJpU2/cJo1wUEgINlSqz+X3/vhpRUHMVbyrFw8cAF3eniYRXbIcX
         ooVQAQ55DDXEUPMEKxCHncH47HJpZo3LpJQpF0TrM5Sb141gYAaF/+QFDahjfp0mZz
         xWTweK9B+tqUcrVYS8qC7qpXQJtWaQfl6jlh0Jr0O+YmBUtCAWchWXaJANZYtP2QEI
         F5jIJgjo4+c46dT4gm4LwFuF7d2WGx8Zh0SLzrlvLwAG7uIaWs2PcxGNg+ZwhnOY1V
         ie0CclnW/SbXKuPyrN9hX5r3ohW2zh1bYuw69p7Uv6iwduEMdA/VS59vT/E89YVMUA
         4oRawwzvbkmHQ==
Date:   Wed, 21 Jul 2021 08:11:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Improve the way 'cqp_request' structures are
 cleaned when they are recycled
Message-ID: <YPesftdeBpzJUhMZ@unreal>
References: <7f93f2a2c2fd18ddfeb99339d175b85ffd1c6398.1626713915.git.christophe.jaillet@wanadoo.fr>
 <YPbALA/P5+NsC7MO@unreal>
 <629bc34e-ef41-9af6-9ed7-71865251a62c@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <629bc34e-ef41-9af6-9ed7-71865251a62c@wanadoo.fr>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 20, 2021 at 03:05:55PM +0200, Christophe JAILLET wrote:
> Le 20/07/2021 à 14:23, Leon Romanovsky a écrit :
> > On Mon, Jul 19, 2021 at 07:02:15PM +0200, Christophe JAILLET wrote:
> > > A set of IRDMA_CQP_SW_SQSIZE_2048 (i.e. 2048) 'cqp_request' are
> > > pre-allocated and zeroed in 'irdma_create_cqp()' (hw.c).  These
> > > structures are managed with the 'cqp->cqp_avail_reqs' list which keeps
> > > track of available entries.
> > > 
> > > In 'irdma_free_cqp_request()' (utils.c), when an entry is recycled and goes
> > > back to the 'cqp_avail_reqs' list, some fields are reseted.
> > > 
> > > However, one of these fields, 'compl_info', is initialized within
> > > 'irdma_alloc_and_get_cqp_request()'.
> > > 
> > > Move the corresponding memset to 'irdma_free_cqp_request()' so that the
> > > clean-up is done in only one place. This makes the logic more easy to
> > > understand.
> > 
> > I'm not so sure. The function irdma_alloc_and_get_cqp_request() returns
> > prepared cqp_request and all users expect that it will returned cleaned
> > one. The reliance on some other place to clear part of the structure is
> > prone to errors.
> 
> Ok, so maybe, moving:
> 	cqp_request->request_done = false;
> 	cqp_request->callback_fcn = NULL;
> 	cqp_request->waiting = false;
> from 'irdma_free_cqp_request()' to 'irdma_alloc_and_get_cqp_request()' to
> make explicit what is reseted makes more sense?

I think so, but it requires double check that these cleared values are
not used after irdma_free_cqp_request().

This is another reason why clearing fields after _free_ routine is
mostly wrong. It hides errors when data is accessed after release.

Thanks
