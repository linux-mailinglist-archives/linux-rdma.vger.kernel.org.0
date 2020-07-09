Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4820B21A1BE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2020 16:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGIOFh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jul 2020 10:05:37 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:47608 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGIOFh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jul 2020 10:05:37 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E9788804B9;
        Thu,  9 Jul 2020 16:05:32 +0200 (CEST)
Date:   Thu, 9 Jul 2020 16:05:31 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/2] drm/virtio: Remove open-coded commit-tail function
Message-ID: <20200709140531.GA220817@ravnborg.org>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <20200709123339.547390-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709123339.547390-2-daniel.vetter@ffwll.ch>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8
        a=7gkXJVJtAAAA:8 a=e5mUnYsNAAAA:8 a=7qquH0MEfeve11GKqesA:9
        a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 09, 2020 at 02:33:39PM +0200, Daniel Vetter wrote:
> Exactly matches the one in the helpers.
> 
> This avoids me having to roll out dma-fence critical section
> annotations to this copy.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 20 --------------------
>  1 file changed, 20 deletions(-)
Very nice catch:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index f3ce49c5a34c..af55b334be2f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -314,25 +314,6 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
>  	return &virtio_gpu_fb->base;
>  }
>  
> -static void vgdev_atomic_commit_tail(struct drm_atomic_state *state)
> -{
> -	struct drm_device *dev = state->dev;
> -
> -	drm_atomic_helper_commit_modeset_disables(dev, state);
> -	drm_atomic_helper_commit_modeset_enables(dev, state);
> -	drm_atomic_helper_commit_planes(dev, state, 0);
> -
> -	drm_atomic_helper_fake_vblank(state);
> -	drm_atomic_helper_commit_hw_done(state);
> -
> -	drm_atomic_helper_wait_for_vblanks(dev, state);
> -	drm_atomic_helper_cleanup_planes(dev, state);
> -}
> -
> -static const struct drm_mode_config_helper_funcs virtio_mode_config_helpers = {
> -	.atomic_commit_tail = vgdev_atomic_commit_tail,
> -};
> -
>  static const struct drm_mode_config_funcs virtio_gpu_mode_funcs = {
>  	.fb_create = virtio_gpu_user_framebuffer_create,
>  	.atomic_check = drm_atomic_helper_check,
> @@ -346,7 +327,6 @@ void virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
>  	drm_mode_config_init(vgdev->ddev);
>  	vgdev->ddev->mode_config.quirk_addfb_prefer_host_byte_order = true;
>  	vgdev->ddev->mode_config.funcs = &virtio_gpu_mode_funcs;
> -	vgdev->ddev->mode_config.helper_private = &virtio_mode_config_helpers;
>  
>  	/* modes will be validated against the framebuffer size */
>  	vgdev->ddev->mode_config.min_width = XRES_MIN;
> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
