Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446EA3DD3DF
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Aug 2021 12:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhHBKgW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Aug 2021 06:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233273AbhHBKgW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Aug 2021 06:36:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CACAC6023F;
        Mon,  2 Aug 2021 10:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627900573;
        bh=tLXb/qkyHEeH4mv5rUQSVTzPmBdLKTnwExu3Yv7pm8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcGYuYuItwRvBR1CPBzHWH3aGIZNDpuiC2Ao+DfRtkto300TLi53ZyVt/1OnDqRBN
         I+QSVvGd3GXQkaht2tCfNaSVSwhJL+7ihA68/IEFLxj2WuFTjIcxlC7R8W2NjyfCvP
         Whqp4ljEpGCMOTe5llY9L42vD0HlP3jRKli0vYyMpi6lrXKpD5pNOmif3W7vWFfmxt
         TKqhjFy3MadXtTJ6dRpSMb5revJzhC1QM6iaopoXj5lvUt2iJZSe2d1+HyzLYvzaba
         eS8LM5sQTmj7fMQwb/mS02r+uUejoNGRBUUwgriXEz0EU0lirj4nhckLfOU4yZiSS7
         f3toR8YKkpcVQ==
Date:   Mon, 2 Aug 2021 13:36:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Sindhu Devale <sindhu.devale@intel.com>
Cc:     jgg@nvidia.com, dledford@redhat.com, tatyana.e.nikolova@intel.com,
        linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com
Subject: Re: [PATCH rdma-core 0/2] iwpmd fixes
Message-ID: <YQfKmlAV9hbY7644@unreal>
References: <20210730211004.1946-1-sindhu.devale@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730211004.1946-1-sindhu.devale@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 30, 2021 at 04:10:02PM -0500, Sindhu Devale wrote:
> This is a series of Portmapper fixes.
> 
> Tatyana Nikolova (2):
>   iwpmd: Start the service if IPv4 or IPv6 is available
>   iwpmd: Remove IP address checking per mapping
> 
>  iwpmd/iwarp_pm_common.c |  2 +-
>  iwpmd/iwarp_pm_helper.c | 89 +----------------------------------------
>  iwpmd/iwarp_pm_server.c | 82 +++++++++++++++++++++----------------
>  3 files changed, 50 insertions(+), 123 deletions(-)

Thanks, applied.
https://github.com/linux-rdma/rdma-core/pull/1037

> 
> -- 
> 2.32.0
> 
