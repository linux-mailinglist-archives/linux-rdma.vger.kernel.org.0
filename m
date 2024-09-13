Return-Path: <linux-rdma+bounces-4939-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C309782B9
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 16:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58EF41F25BEB
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 14:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7A326AD0;
	Fri, 13 Sep 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlQq3Y0b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF215E90
	for <linux-rdma@vger.kernel.org>; Fri, 13 Sep 2024 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238272; cv=none; b=de7phwTMPuNjnBg76fedg1pNZX/kO4kGbbwU6Zwo4AiTmDlywP20VLswEEpPanA2uAoqqQnKUb2tHkTvEd+1pZl+3ig1/fDKz+W2FgsqtkB7j/3lTNp+ozA3Nmy5ECbj6D8dVpFoTunvDWnWjde0kSuu3QC58rl3c38EKiia++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238272; c=relaxed/simple;
	bh=2nNXxwera0yuAh/Tlo/z0PdQBgIG224+4OVL/+wtJEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tp6V9CLkTOpuKyPnS8QVqb8BgoHpGi1rM1ri30+r/VafGgBHJlzBs0h7/HPtWLuQ/L+Pnd8Z/TqHosrG44Ugc/HfOtLIAsGlefLqz6YY2+FKyjGrU3gq4ikpsPae3rItQpVVlabNWlqwy8zfHm97H3XkwwwPV3R9ruXZElyBfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dlQq3Y0b; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d446adf6eso122292466b.2
        for <linux-rdma@vger.kernel.org>; Fri, 13 Sep 2024 07:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726238269; x=1726843069; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SwAgJdygnGePf07lx2VZcTLVPndu8qdxUCgAcmtT1Ek=;
        b=dlQq3Y0bI+tHqfwW17WKVmY5JCwYiHikkTVCNYwix29TzofVtYCizTkrRQxHMX0QIn
         YJbBS7XmXo0eOITcDQqB1FKRDfDNrX5VKrU6kboBP/jOgte+JZR5BfXSSvcqMqgeHLp4
         zJIsa3e/uqJ3DmgCx9f8Kd8v9DfaLDvh+t7/ipZdxUB9nBf+pUgw+jhpMZd6rB0CUu1U
         3ItLjgA5pE1Llv3OflnI78YNeVe+uepfRzHuwatZNKQTIPNsNCYK1hzuBOwdSM5nl6uZ
         GpkoUHtsBCqe9NX4QG3Wl0mfIfblIgRivu/tO545ATUFeO981mdfpzH7NmA+zXpNqGyT
         eykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726238269; x=1726843069;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SwAgJdygnGePf07lx2VZcTLVPndu8qdxUCgAcmtT1Ek=;
        b=xFZ08GNT3dlwHtbGBCKvBmWrteW2oJpl97LrHzpddBRzzusbOELQesPr0rf8CPsdEr
         U1KBRBNETT7PMEvDFNCVlWe4Vy0HcT78eDO37wgxvJ1ZcydnMff6jyPPsMycbVfG9Cx6
         aBbsLfqszkmwLKP2SKw9DIOfIJdVUX40dzJwDQBmvfRgUj+2wMHGsviYg6ZsEG9J38TU
         HPol+JXjHXVR/zxKRBu+PMWitbM4XEWJUIvjnxVCGWJRG4F8dnEwuRoAa/yR2qqUnBNx
         L0sj80C1ngSbLGeyW4O4QvLBM/S0CVZ49gtDLptzKhaZ7u6o2FzT/Ach28oAUQZmAf2N
         vXnQ==
X-Gm-Message-State: AOJu0YyGUkEVva/vjdJsS/h9j7SmaDqjZtHJ46OrHYtsBHPAVWVROISh
	lpQwyz9ZEcRTw4pOmXTUIkow+l//3zegaK8/wj+nkIT98c5nDWZZdj3VSpdbnbXJs6+p8obCSwp
	Q
X-Google-Smtp-Source: AGHT+IFzfb+5bDs2IQZVg4UjKLA2/4kBtVEcNMuzkzZ0PRgsYJnXwAMp3xPZM7XtnTULa2pL5akVIg==
X-Received: by 2002:a17:907:97cf:b0:a8a:906d:b485 with SMTP id a640c23a62f3a-a9047cad53cmr234025966b.26.1726238268388;
        Fri, 13 Sep 2024 07:37:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a43370sm878752666b.96.2024.09.13.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 07:37:47 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:37:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: [bug report] net/mlx5: HWS, added send engine and context handling
Message-ID: <e4ebc227-4b25-49bf-9e4c-14b7ea5c6a07@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Yevgeny Kliteynik,

Commit 2ca62599aa0b ("net/mlx5: HWS, added send engine and context
handling") from Jun 20, 2024 (linux-next), leads to the following
Smatch static checker warning:

drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c:739 hws_send_ring_open_sq() warn: 'sq->dep_wqe' double freed
drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c:739 hws_send_ring_open_sq() warn: 'sq->wq_ctrl.buf.frags' double freed
drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c:739 hws_send_ring_open_sq() warn: 'sq->wr_priv' double freed

drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
    704 static int hws_send_ring_open_sq(struct mlx5hws_context *ctx,
    705                                  int numa_node,
    706                                  struct mlx5hws_send_engine *queue,
    707                                  struct mlx5hws_send_ring_sq *sq,
    708                                  struct mlx5hws_send_ring_cq *cq)
    709 {
    710         size_t buf_sz, sq_log_buf_sz;
    711         void *sqc_data, *wq;
    712         int err;
    713 
    714         sqc_data = kvzalloc(MLX5_ST_SZ_BYTES(sqc), GFP_KERNEL);
    715         if (!sqc_data)
    716                 return -ENOMEM;
    717 
    718         buf_sz = queue->num_entries * MAX_WQES_PER_RULE;
    719         sq_log_buf_sz = ilog2(roundup_pow_of_two(buf_sz));
    720 
    721         wq = MLX5_ADDR_OF(sqc, sqc_data, wq);
    722         MLX5_SET(wq, wq, log_wq_stride, ilog2(MLX5_SEND_WQE_BB));
    723         MLX5_SET(wq, wq, pd, ctx->pd_num);
    724         MLX5_SET(wq, wq, log_wq_sz, sq_log_buf_sz);
    725 
    726         err = hws_send_ring_alloc_sq(ctx->mdev, numa_node, queue, sq, sqc_data);
    727         if (err)
    728                 goto err_free_sqc;
    729 
    730         err = hws_send_ring_create_sq_rdy(ctx->mdev, ctx->pd_num, sqc_data,
    731                                           queue, sq, cq);
    732         if (err)
    733                 goto err_free_sq;

hws_send_ring_create_sq_rdy() calls hws_send_ring_close_sq() on error.

I would say that it's the free in hws_send_ring_create_sq_rdy() which
should be modified.  There isn't an official style guideline for error
handling so do whatever works for you.  But I've written a guide to how
people often do it:
https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

    734 
    735         kvfree(sqc_data);
    736 
    737         return 0;
    738 err_free_sq:
--> 739         hws_send_ring_free_sq(sq);

It results in a double free.

    740 err_free_sqc:
    741         kvfree(sqc_data);
    742         return err;
    743 }

regards,
dan carpenter

