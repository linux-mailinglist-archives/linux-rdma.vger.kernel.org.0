Return-Path: <linux-rdma+bounces-13965-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00972BF7BF3
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 18:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F3E423834
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51932347BA9;
	Tue, 21 Oct 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="GZdXIYEl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F2C33FE0B;
	Tue, 21 Oct 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064894; cv=pass; b=lkGOo5IR65TGgla2U2LhTMXwLaji6wiH+mGeB4Fsc83qRWuw9CtF6AWSAU7S6TcPTAEkNyrQspi/FqzXbWSuupqKf4Jsx+M5AHHoadAmKBq367KWAECM2srmrzvTFmSFhfIl1JK1VxDEMXbr9Z3xc1L6lyr5A3JZG906hZlua/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064894; c=relaxed/simple;
	bh=0uItpz1pLX8HIG5XI6mC7zJLAzblcS+XDRjNSKGIIeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fOR4qbICKElhSN6ziZRNWSylvSzD6mrXeCSbMDfgBbyeGYOFORlYvHp9BiWkmQn8tqu+7io8l03tPpojl0YGT58qGdL24Sr14LVkcpe/1vDvrzojzY5q6Mx5vwGuUa5bVcIO18YkRiFUB2LMpW//CkhlibYb1OnEk25BfSKIwz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=GZdXIYEl; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from chcpu18 (191host009.mobilenet.cse.ust.hk [143.89.191.9])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 59LGf3N6777008
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 00:41:09 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1761064870; cv=none;
	b=tw6kC97ubPTKPFK2Pi5DArsAPF4hw5oAL6et4x63jm4bIfk/f0mlsUVZnkggTbSFLymG3YzxDmxSn55xRM3PB6WGiRzwfBj18uqUR9nptRv1S3jFz6KaF8iRIwUP3wk5I968tx9Kd83KKw98CXqhTndm17j3/aCbMmHS0a6G7jU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1761064870; c=relaxed/relaxed;
	bh=TZPyizmzA/60DtRKWuQLfOf8db5VKmyvKCbeOKOykwY=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=McEqUAR1gtH7znjYt4LiwHMMjl6hqkKsCjwfJFFlx6AIKGwVuITjbToPvUCWfpptsmuNEf4dske1hL5euEPbSr2bTkJVG6UiNsqyEDTxPi92BPdcvvyEMwxCqYx2c3pwkFOiXTOJL7/qyp1bb5XAaEivVW6upX+6KvDj2h/VfaI=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1761064870;
	bh=TZPyizmzA/60DtRKWuQLfOf8db5VKmyvKCbeOKOykwY=;
	h=Date:From:To:Cc:Subject:From;
	b=GZdXIYElwWe4ladj1aTMvqSogzjE8GNwGhfKLkBed8R9Ukv/1+vqHK+KNE9Y0LlDZ
	 G2tavRL1LU826ntGGTkph2DY5p8O2xEgxYlY3W4P+Yxj5MO0Idzrk3DzRn/tIIBdND
	 pXwUtgXmLUJa18eFQz5JZyP2iRheVrD9lPyQzirU=
Date: Tue, 21 Oct 2025 16:40:58 +0000
From: Shuhao Fu <sfual@cse.ust.hk>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: Fix refcount inconsistency in mlx5_netdev_event
Message-ID: <aPe3mnFjQeXaILyR@chcpu18>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Env-From: sfual

Fix refcount inconsistency related to `mlx5_ib_get_native_port_mdev`.

Function `mlx5_ib_get_native_port_mdev` could increase the counter of 
`mpi->mdev_refcnt` if mpi is not master. To ensure refcount consistency,
each call to `mlx5_ib_get_native_port_mdev` should have a corresponding
call to `mlx5_ib_put_native_port_mdev`. In `mlx5_netdev_event`, two
branches fail to do so, leading to a possible bug when unbinding.

Fixes: 379013776222 ("RDMA/mlx5: Handle link status event only for LAG device")
Fixes: 35b0aa67b298 ("RDMA/mlx5: Refactor netdev affinity code")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
---
 drivers/infiniband/hw/mlx5/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index fc1e86f6c..0c4aa7c50 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -247,7 +247,7 @@ static int mlx5_netdev_event(struct notifier_block *this,
 
 		if (!netif_is_lag_master(ndev) && !netif_is_lag_port(ndev) &&
 		    !mlx5_core_mp_enabled(mdev))
-			return NOTIFY_DONE;
+			goto done;
 
 		if (mlx5_lag_is_roce(mdev) || mlx5_lag_is_sriov(mdev)) {
 			struct net_device *lag_ndev;
@@ -268,7 +268,7 @@ static int mlx5_netdev_event(struct notifier_block *this,
 		if (ibdev->is_rep)
 			roce = mlx5_get_rep_roce(ibdev, ndev, upper, &port_num);
 		if (!roce)
-			return NOTIFY_DONE;
+			goto done;
 
 		ib_ndev = ib_device_get_netdev(&ibdev->ib_dev, port_num);
 
-- 
2.39.5 (Apple Git-154)


