Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2581243DC8B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 09:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhJ1H7V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 03:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhJ1H7U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Oct 2021 03:59:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AA1C061570;
        Thu, 28 Oct 2021 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qKlylDLpDE3QgMru+kvYBL/G5aQPseOGH8zJft5q3eo=; b=iUiVE2xrhEzhLWL4t9ckY88PGX
        Pwe0+6OjwB+ISsCO+w8nwjBr7IBTPTERMuTQcl7Rl6f8azs3PuFoRpq1nRqQBgsIK0XCZSER0InAC
        5nk8i3dHKYVXj6awRY0tLGzbSuUO5y7AaXKJuCTzyo9H9e0LW8ennaD7t15jwvSiPdGxHhP4slREO
        Nk5WPZ/OQuJomnrwZinwIjDtw5b6IA+Bn2Qm6UkQXs5RdpsKIGFtRTiGyos23sqV0Nj2y/1GaW3tr
        zKl/aDowR4HCPY1M007lZDldP7VDfBBHOIqiJ48RiZxm2QF3hAvpM9P7Ny57KHI5tKcXWN9bURTwa
        goKyefcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mg0HH-007CEy-1I; Thu, 28 Oct 2021 07:56:47 +0000
Date:   Thu, 28 Oct 2021 00:56:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Rely on vendors to set right IOVA
Message-ID: <YXpXvh0sxP8r9r7R@infradead.org>
References: <4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 28, 2021 at 08:55:22AM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> The vendors set the IOVA of newly created MRs in rereg_user_mr, so don't
> overwrite it. That ensures that this field is set only if IB_MR_REREG_TRANS
> flag is provided.

How is a "vendor" involved with this?  This should all be upstream code.
