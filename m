Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACF83B1342
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 07:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWFfU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 01:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhFWFfU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 01:35:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86A1D60041;
        Wed, 23 Jun 2021 05:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624426383;
        bh=tfuhNYEf3C7+3nTOoAgQvLfYzSjwGFutfYQAceT1k2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fSPTTjtRH8KOELTA0uwTuQXS7kAZpdqnIs1UBcA13ZrmsVFwrGr4khBHF7aAqCEh6
         shrLI4W1ZHZshvz1q0O00O5HeqKZvunO1ZEzKhVvidJHBHKpyB9eAAddF6zlrdd6ti
         oLz5MDhvN0B/IoVq4LNgDxT1w6e4J0MWKEyFdU9YvpG2vJOe0jy+8kk0cf5VvSvAYB
         p1toCzp2SRZt71xm+6q/dQ2xQT5i91Qy8pIyLLTu7fKYUlD/FTAx7RaXYlpxKbffMq
         YAPXPLclYK5nV8ApCkXykDCQWV//akTRJ84MqIDQGyLQFfMK3cjlH8y3vbgV08HRcR
         GWfSFDmXsWSwQ==
Date:   Wed, 23 Jun 2021 08:32:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2] RDMA/cma: Remove unnecessary INIT->INIT
 transition
Message-ID: <YNLHixlGokuQOjmW@unreal>
References: <1623996475-23986-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1623996475-23986-1-git-send-email-haakon.bugge@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 18, 2021 at 08:07:55AM +0200, Håkon Bugge wrote:
> In rdma_create_qp(), a connected QP will be transitioned to the INIT
> state.
> 
> Afterwards, the QP will be transitioned to the RTR state by the
> cma_modify_qp_rtr() function. But this function starts by performing
> an ib_modify_qp() to the INIT state again, before another
> ib_modify_qp() is performed to transition the QP to the RTR state.
> 
> Hence, there is no need to transition the QP to the INIT state in
> rdma_create_qp().
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> 
> ---
> 
> 	v1 -> v2:
> 	   * Fixed uninitialized ret variable as:
> 	     Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/infiniband/core/cma.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 

I reviewed v1, let's add this tag to v2 too.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
