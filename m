Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94C3220D6F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 14:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgGOMxu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 08:53:50 -0400
Received: from foss.arm.com ([217.140.110.172]:55216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGOMxt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jul 2020 08:53:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1501531B;
        Wed, 15 Jul 2020 05:53:49 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99DB3F66E;
        Wed, 15 Jul 2020 05:53:48 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id AB540682E6E; Wed, 15 Jul 2020 13:53:47 +0100 (BST)
Date:   Wed, 15 Jul 2020 13:53:47 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>
Subject: Re: [PATCH 08/25] drm/malidp: Annotate dma-fence critical section in
 commit path
Message-ID: <20200715125347.GT159988@e110455-lin.cambridge.arm.com>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-9-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707201229.472834-9-daniel.vetter@ffwll.ch>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 10:12:12PM +0200, Daniel Vetter wrote:
> Again needs to be put right after the call to
> drm_atomic_helper_commit_hw_done(), since that's the last thing which
> can hold up a subsequent atomic commit.
> 
> No surprises here.

I was (still am) hoping to do a testing for this patch but when I dug out the series
from the ML it looked like it has extra dependencies, so I was waiting for the dust
to settle.

Otherwise, LGTM.

Best regards,
Liviu

> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: "James (Qian) Wang" <james.qian.wang@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Mihail Atanassov <mihail.atanassov@arm.com>
> ---
>  drivers/gpu/drm/arm/malidp_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 69fee05c256c..26e60401a8e1 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -234,6 +234,7 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
>  	struct drm_crtc *crtc;
>  	struct drm_crtc_state *old_crtc_state;
>  	int i;
> +	bool fence_cookie = dma_fence_begin_signalling();
>  
>  	pm_runtime_get_sync(drm->dev);
>  
> @@ -260,6 +261,8 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
>  
>  	malidp_atomic_commit_hw_done(state);
>  
> +	dma_fence_end_signalling(fence_cookie);
> +
>  	pm_runtime_put(drm->dev);
>  
>  	drm_atomic_helper_cleanup_planes(drm, state);
> -- 
> 2.27.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
