Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16CB49233D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jan 2022 10:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiARJxP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 04:53:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57726 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiARJw5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jan 2022 04:52:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 742F76121D
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jan 2022 09:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED8EC00446;
        Tue, 18 Jan 2022 09:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642499576;
        bh=JO3v+ae49BsePlJbEJJSif4FhyKQfeWj3gQx82SjkIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uoKyuXF8SjXiixTcjhjbFb8cNvtc8FXkpcHHS5+/ZWkMqmRdpYPW9hWNrgXj/A/2o
         z52Rt827be4xm8MYH2uRUTGVLhFppNFw0lLhLeVYtOpC16Qrhs6wamo53DO7/QBiHi
         WVcn82vSEm5zFPGbvdntDWKExuEWDQJIqq5b7h38GCQu2ntY/m8/H4cOa4y99l0yJL
         7RSO4vt579G+5dUd19ZOBZDXrA39MF2k9ndt3SYkgSQs+ZQwGIYTozqfLBbpratVvh
         o5h/QyUZlNUFAinsG6sXUG0rKeQE+Rm6I2fFMCsC8fLcEqoeDujYi48F7cGuZys2b6
         Nr6wpuo8P8srQ==
Date:   Tue, 18 Jan 2022 11:52:52 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     markzhang@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [bug report] IB/cm: Improve the calling of cm_init_av_for_lap
 and cm_init_av_by_path
Message-ID: <YeaN9Cy390HaVrYt@unreal>
References: <20220118091643.GA12356@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118091643.GA12356@kili>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 18, 2022 at 12:16:43PM +0300, Dan Carpenter wrote:
> Hello Mark Zhang,
> 
> The patch 7345201c3963: "IB/cm: Improve the calling of
> cm_init_av_for_lap and cm_init_av_by_path" from Jun 2, 2021, leads to
> the following Smatch static checker warning:
> 
> drivers/infiniband/core/cm.c:3373 cm_lap_handler() warn: inconsistent refcounting 'cm_id_priv->refcount.refs.counter':
>   inc on: 3325
>   dec on: 3373
> 
> drivers/infiniband/core/cm.c
>     3278 static int cm_lap_handler(struct cm_work *work)
>     3279 {
>     3280         struct cm_id_private *cm_id_priv;
>     3281         struct cm_lap_msg *lap_msg;
>     3282         struct ib_cm_lap_event_param *param;
>     3283         struct ib_mad_send_buf *msg = NULL;
>     3284         struct rdma_ah_attr ah_attr;
>     3285         struct cm_av alt_av = {};
>     3286         int ret;
>     3287 
>     3288         /* Currently Alternate path messages are not supported for
>     3289          * RoCE link layer.
>     3290          */
>     3291         if (rdma_protocol_roce(work->port->cm_dev->ib_device,
>     3292                                work->port->port_num))
>     3293                 return -EINVAL;
>     3294 
>     3295         /* todo: verify LAP request and send reject APR if invalid. */
>     3296         lap_msg = (struct cm_lap_msg *)work->mad_recv_wc->recv_buf.mad;
>     3297         cm_id_priv = cm_acquire_id(
>     3298                 cpu_to_be32(IBA_GET(CM_LAP_REMOTE_COMM_ID, lap_msg)),
>     3299                 cpu_to_be32(IBA_GET(CM_LAP_LOCAL_COMM_ID, lap_msg)));
> 
> cm_acquire_id() bumps the refcount.
> 
>     3300         if (!cm_id_priv)
>     3301                 return -EINVAL;
>     3302 
>     3303         param = &work->cm_event.param.lap_rcvd;
>     3304         memset(&work->path[0], 0, sizeof(work->path[1]));
>     3305         cm_path_set_rec_type(work->port->cm_dev->ib_device,
>     3306                              work->port->port_num, &work->path[0],
>     3307                              IBA_GET_MEM_PTR(CM_LAP_ALTERNATE_LOCAL_PORT_GID,
>     3308                                              lap_msg));
>     3309         param->alternate_path = &work->path[0];
>     3310         cm_format_path_from_lap(cm_id_priv, param->alternate_path, lap_msg);
>     3311         work->cm_event.private_data =
>     3312                 IBA_GET_MEM_PTR(CM_LAP_PRIVATE_DATA, lap_msg);
>     3313 
>     3314         ret = ib_init_ah_attr_from_wc(work->port->cm_dev->ib_device,
>     3315                                       work->port->port_num,
>     3316                                       work->mad_recv_wc->wc,
>     3317                                       work->mad_recv_wc->recv_buf.grh,
>     3318                                       &ah_attr);
>     3319         if (ret)
>     3320                 goto deref;
>                          ^^^^^^^^^^^
> 
>     3321 
>     3322         ret = cm_init_av_by_path(param->alternate_path, NULL, &alt_av);
>     3323         if (ret) {
>     3324                 rdma_destroy_ah_attr(&ah_attr);
>     3325                 return -EINVAL;
> 
> Should this be goto deref as well?

Yes, it should.

Thanks
