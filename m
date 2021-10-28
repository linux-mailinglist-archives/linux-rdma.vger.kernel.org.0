Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6344843DE40
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 11:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJ1KBY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 06:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhJ1KBY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Oct 2021 06:01:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 691F160FF2;
        Thu, 28 Oct 2021 09:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635415137;
        bh=ef1ZUJfU8Dcxh5Emlp74dkMopRuVux57gjG4Op+dv5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuP06FaFhFBLJEDFSBRbuAvZD2Qn5hUACNzDFBeH89K66n5BHsfjsUpdlJpFk+i7j
         quysWLCH/KPWrS9ZwMWQHBKTck4OU9w/5GZ4qJ0yOJOAiUsqLmeqJ7vYISnHwJjOsG
         lzddaRwuUInvnyne1LdaWF7ruBUToRoyTVD9r858dMI/st7rpH1y2cnSm7Q6+crVGN
         /omG6Hcg+r/6cOJmIg9kHM7v4d07mjOlvZBq93eggVGIO8uiU1BZy8mbUEjLKyu1OB
         i7cOK3W2wEnxjN95Rv++7ij+7ry953F6VOiB4g5C5h6bPWZJ7wY7ICL+6ye1hozq+8
         icQhkxrfV/JQg==
Date:   Thu, 28 Oct 2021 12:58:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Rely on vendors to set right IOVA
Message-ID: <YXp0XSpXsarxrGqS@unreal>
References: <4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com>
 <YXpXvh0sxP8r9r7R@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXpXvh0sxP8r9r7R@infradead.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 28, 2021 at 12:56:46AM -0700, Christoph Hellwig wrote:
> On Thu, Oct 28, 2021 at 08:55:22AM +0300, Leon Romanovsky wrote:
> > From: Aharon Landau <aharonl@nvidia.com>
> > 
> > The vendors set the IOVA of newly created MRs in rereg_user_mr, so don't
> > overwrite it. That ensures that this field is set only if IB_MR_REREG_TRANS
> > flag is provided.
> 
> How is a "vendor" involved with this?  This should all be upstream code.

"vendor" is wrong word here.

I wanted to say that all drivers which support ".rereg_user_mr()"
callback and return new_mr should set everything. In case of IB_MR_REREG_TRANS
flow, it is IOVA which is not cmd.hca_va, but mr->iova.

Thanks
