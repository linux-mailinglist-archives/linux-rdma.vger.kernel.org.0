Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DA52C12D8
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 19:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390695AbgKWSCB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 13:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731340AbgKWSCB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Nov 2020 13:02:01 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD7C0613CF
        for <linux-rdma@vger.kernel.org>; Mon, 23 Nov 2020 10:02:00 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u184so3226497qkf.3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Nov 2020 10:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7+lSYUi+lYvreoUQbQeklZ4cRIMv/oTw7seJhFROrZ8=;
        b=BkTjg7eOzOEGq3pVj6UyISuMoQUhg8+ZOG9QgsbJuwsFycaebbXZuf2rCN5PP26DXc
         OA7g8KmqVRR4PhjlGutP9XIraLdFgBeN0aoWfEAljXN2JwKB3KTemdHEj5Ak96V3glx1
         Od5jJq6tFeSDLRAtXYCaV+dOe2dcqJlIGt+Xs/U7VRTvh3rlam50pfW14c/UJsygTNBt
         eH0r17lmgdxTAG/gAfI0mW4YSW4eHN0/ULr2NF2fkiONvzfz5ueiM/P/Mb6YRupGp/4q
         Wm9pqHt2bVUjbhYZaEv/Lbt+ZmvByolqs+yCIc+iOol8C3P0ilCBIsXWnLgeyJU9i9V7
         X+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7+lSYUi+lYvreoUQbQeklZ4cRIMv/oTw7seJhFROrZ8=;
        b=DzvMzzi+uFU0xi01BqyoJEdwGAY7Oi4IBbiiVj1nLgpBHrVyxps2R8PNI1c3Y00EFZ
         8Ni4FlCTAIA3qrTDZ//m8dl1T9KfrxbWulwZFW7wLo295/vxf1Mvji0n+eHqKI/OSy71
         1A1kDE1qnpxx5/Qn18dc5QiMwfXgLxJTIF/fVU6twAC3m0IvMPpU2okLEHxsFhYVXTtE
         HlXAV4YaHKyi38qZzzrSrUlDyuV5EbiFDBph4AmgdwQpBWDRlZR7DyRIxXh3N7h3W1ZK
         lM+as2kJGyX6v8fYQ9BtKvfovaHrbioYhGh8a//lEc1fxhm4MH/EoPDiTraX8ud9Rwyp
         V65A==
X-Gm-Message-State: AOAM532mHHoJwDasvgRJfUg0spA8LNknxXVJVMk9jCMrVJUWIlc8Pcwx
        eyqo94AgSX9MzVF/l96ug3eUAg==
X-Google-Smtp-Source: ABdhPJwFkRrCXup4ypaFSlMFJADjuBv1Ideil3Uminq6+V0Q/qol9nWL7qaeLeNPSR4LzpVE5Yiexg==
X-Received: by 2002:a37:64d4:: with SMTP id y203mr693429qkb.150.1606154520246;
        Mon, 23 Nov 2020 10:02:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b33sm9695443qta.62.2020.11.23.10.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 10:01:59 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1khGA2-00AETC-SE; Mon, 23 Nov 2020 14:01:58 -0400
Date:   Mon, 23 Nov 2020 14:01:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH rdma-core 2/5] mlx5: Support dma-buf based memory region
Message-ID: <20201123180158.GZ244516@ziepe.ca>
References: <1606153984-104583-1-git-send-email-jianxin.xiong@intel.com>
 <1606153984-104583-3-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606153984-104583-3-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 23, 2020 at 09:53:01AM -0800, Jianxin Xiong wrote:

> +struct ibv_mr *mlx5_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, size_t length,
> +				  uint64_t iova, int fd, int acc)
> +{
> +	struct mlx5_mr *mr;
> +	int ret;
> +	enum ibv_access_flags access = (enum ibv_access_flags)acc;

Why?

Jason
