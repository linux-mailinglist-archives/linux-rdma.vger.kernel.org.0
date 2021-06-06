Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5C39CCFA
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Jun 2021 06:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhFFEgV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Jun 2021 00:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhFFEgV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Jun 2021 00:36:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9B6D61220;
        Sun,  6 Jun 2021 04:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622954072;
        bh=ovH0uvOc8A7OShK4CAmfQBydt+PjCpSAY6U0HlMJB8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgGXhZ0PoN8EYSPfgNAl/pHqnf8CMnoqRBkypmHVlKiH3G/6vC7crgDk548YI1WZA
         285GXp6NB58iQBIEEkMBQwRS08LPlDLyjORqlvWcYETm9B7r6beeFx1VmoFAVy9gTR
         fk5cvaweB/lEIK1ntIBPyuqZXVEMV/h0PnPoqjdvRmoDiMUUgJAlx9HJEsEwM6xzg5
         bTA0d7JLkJ1zMBV7t7I+G4Cdc0p5HteeSd0VE7WP/c4cQ78PEs4UYnstCKHo2IEf76
         nksXIYojrFkuimjThATVezlZ8FZ7VDCwiGH6wNUWDKDVjopBCaFxtW/4d51ZFNVVQo
         FMKi/Nvx7+r1Q==
Date:   Sun, 6 Jun 2021 07:34:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org,
        "Pearson, Robert B" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH rdma-core] docs: Add a contributing.md
Message-ID: <YLxQVL5iQIZJymar@unreal>
References: <0-v1-b00db5591f60+96-contributing_jgg@nvidia.com>
 <YLpI6e/62HFuZl31@unreal>
 <20210604174532.GW1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604174532.GW1002214@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 04, 2021 at 02:45:32PM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 04, 2021 at 06:38:17PM +0300, Leon Romanovsky wrote:
> > On Fri, Jun 04, 2021 at 11:13:02AM -0300, Jason Gunthorpe wrote:
> > > Discuss how to use GitHub properly and document the special kernel-headers
> > > process.
> > > 
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > >  Documentation/contributing.md | 164 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 164 insertions(+)
> > >  create mode 100644 Documentation/contributing.md
> > 
> > Please update README.md, it has "Reporting bugs" and "Submitting
> > patches" sections.
> 
> Done

Thanks, applied to rdma-core.

> 
> Jason
