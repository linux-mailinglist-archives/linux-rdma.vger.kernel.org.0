Return-Path: <linux-rdma+bounces-711-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B4838C2A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 11:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402781F2631B
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4C65C619;
	Tue, 23 Jan 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgcvnLkn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD2E5C610
	for <linux-rdma@vger.kernel.org>; Tue, 23 Jan 2024 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006143; cv=none; b=ck8pi1+lQimoOfCyRP1YCc2h+UpjGBkb7lWetFet0CB9Wd3U7rAOE4V8ur5Teo4szNur0EXxgmwobnBnwFz0XAJGeFxJ1WKEVbWHNFcHTCPiwdcMBLrk9VY2BVvKX6reykwoc1D6Aexh17YvxWsPadWEub8kYRQHmmkJ72Aqr9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006143; c=relaxed/simple;
	bh=sCbhuQaFe9ERulAFJsFHSxgFqFnSfKfHxQgWH9/XO9M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k1E95iqN3kjnm1TxhsJIWyvTshJW2R8eevFv+/2noWz7DwGnEw8pKr2I5c7gjnOPK12Ij3W2m/yDMHy1OvCQDJ8+d8IiWeumWEhtWY5A9WOx/5d/CQjp6Xs70phvZ1AVulPVAWcFGY50UZuY1+bKmn9sBryucagA4H7DN0LXIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgcvnLkn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so45805585e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jan 2024 02:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706006140; x=1706610940; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+K8ykXNGzCyqdN2O3hxbBqf7n+ehziJgzDtq5dMy7W0=;
        b=GgcvnLkngY2fBfb1bw0C24O33YS77EeKr36dD8a6LMHOEhfsuBhHMMzNV7G3EKUSYm
         G0r02rTe8Btnq5U+0ZEi/+9IeerV45VSGLqvpAhoIO4YtlSWYlAG7IFEMTexlQr4g5x9
         C3ZLIJzzIrjTdkKABijhbSJCtagNIPMHA1KEDMpqGunDZLHcpBmEWvTSMPZXLy3UPxgX
         Oat/JN/bbMm2vawrMmDEQ5bAEVfMZE2yexcvhQc61lwwKawm5SbN+4qllo0W/JF+8N+k
         RVKbQKsp3j/fJtWj5Yq6uguTNX73W0v+46IonObnSAArn2qv8rf6S80CkpAjxyu6lU+N
         VD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706006140; x=1706610940;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+K8ykXNGzCyqdN2O3hxbBqf7n+ehziJgzDtq5dMy7W0=;
        b=m2N1d+IHzO/YIr+uzHuUSGfyABibRuGNGvW9a9V/R31dtvqgizPb4oiQWhizqx4CnU
         BXVPvbv+oJIJ8kV/o1QCJm0ERing+TRjoK7d/xSPvLfrnTYRu7xFWGfv6MFEbnMJZtwF
         jPMpuY4EzxA94pVGInH6IZUaIYP19ICF+NOhmCZrROolFw9pYV+IPu9npipgFngtBb2o
         5OdbPoyKNnle8LyBBLghu7WUbCdhpDn0BPwuVoLnEvghWVOA/M5CycJWthmtcrL12p56
         VsqsG7+bTvPiR3QyorGhlcIMhWw6HTkLtyiVP3wkxJocheKC+aSHMG+ghJ3qTIoi/ugL
         v5Ew==
X-Gm-Message-State: AOJu0YzPdleu76CHwX3KPL68aeftUcj0ON7RpXxvrz4KW55fKUqnj0ha
	Rf4KQmaORD5Rr5G4ijZuoHktxRnuqNLddyV53yyoN4VqyekZ9Go=
X-Google-Smtp-Source: AGHT+IFJgwBuJgm+8fJX8ur+9tab1QjOOQx45I1q5m769rWURolqKotCmKnzrY9tvIIjIkDVusgWfg==
X-Received: by 2002:a05:600c:1ca5:b0:40e:6b49:25cd with SMTP id k37-20020a05600c1ca500b0040e6b4925cdmr403991wms.102.1706006139932;
        Tue, 23 Jan 2024 02:35:39 -0800 (PST)
Received: from p183 ([46.53.248.133])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b0040e86fbd772sm23577054wmb.38.2024.01.23.02.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 02:35:39 -0800 (PST)
Date: Tue, 23 Jan 2024 13:35:38 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: [PATCH] mlx5: delete unused prototype
Message-ID: <a2cb861e-d11e-4567-8a73-73763d1dc199@p183>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

mlx5_ib_copy_pas() doesn't exist anymore (and g++ doesn't like it
because "new" is reserved keyword in C++).

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/infiniband/hw/mlx5/mlx5_ib.h |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1377,7 +1377,6 @@ int mlx5_ib_query_port(struct ib_device *ibdev, u32 port,
 		       struct ib_port_attr *props);
 void mlx5_ib_populate_pas(struct ib_umem *umem, size_t page_size, __be64 *pas,
 			  u64 access_flags);
-void mlx5_ib_copy_pas(u64 *old, u64 *new, int step, int num);
 int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
 void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);

