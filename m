Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977724143E9
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 10:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhIVIlo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 04:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233349AbhIVIlo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Sep 2021 04:41:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD12B61131;
        Wed, 22 Sep 2021 08:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632300014;
        bh=5NafAYWaQU8DJoPwZwm1id2KJxCKXJ3usP5bW2jRimM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juwh4hNRqa84g2C2W+rxt23wYumFwpZjUbjKgQ6TcZME13nkna1U36iNYFlQiAUQM
         w93dJ0VnqRhsf2YyX7heEbbkdyNT7FBd+QyzZwnvGrkepFSMqqbtItCMY/mPtwyQ6e
         M+Vk4SiRa6X/U7z9MeyXWn4ms2vcFUrAuvrEH502/+6+zswAHVPakISA6FMjT2LEep
         1bQoc0wniD9UzmslvaByyT6r7NYxEYHWDomhD/KjGKDI7EW89wwy5ruO1tWBrBBfBt
         CnpxZM2Gb8pnXZSJMIcAtYeqjgkbyd9vD0YGOS65UyyW3hcQvr91HqnYfMUCjsuvF9
         Lgyu3XxAkjqhg==
Date:   Wed, 22 Sep 2021 11:40:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     jgg@nvidia.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core] irdma: Remove optimization algorithm for QP
 doorbell
Message-ID: <YUrr6Vjm/YID9CQv@unreal>
References: <20210920213723.1279-1-tatyana.e.nikolova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920213723.1279-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 20, 2021 at 04:37:23PM -0500, Tatyana Nikolova wrote:
> Remove optimization algorithm for QP doorbell, because
> without an mfence the algorithm incorrectly skips ringing
> the doorbell. This causes applicaitons like OpenMPI with
> high number of connections to stall waiting for completion.
> 
> Enforcing the order of the write of the WQE valid bit
> and the read of the SQ tail is required by the algorithm,
> but furher investigation is necessary because this does not
> appear sufficient for the algorithm to work. In the meantime,
> remove the doorbell optimization and fix the MPI failures.
> 
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
>  providers/irdma/uk.c | 29 ++---------------------------
>  1 file changed, 2 insertions(+), 27 deletions(-)
> 

Thanks, applied.
