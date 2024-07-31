Return-Path: <linux-rdma+bounces-4130-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58DA942BC1
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 12:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97026286CC0
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 10:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A35D1AC446;
	Wed, 31 Jul 2024 10:12:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25291AC442;
	Wed, 31 Jul 2024 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420772; cv=none; b=Q/vTV/ms+S3QZi0A5K8P6Qv5f75l+xSeK4Yxu5nIIB+O6m8jcJa9RFuVx+DxwJKIbgWhptHuVvlxRehDEAjuM9pIp5/V9wEP+n9J68Sk7HKfJ3EWJ4YisJKY4hWJH9K0dPh/1z6KoLhBeInm42fsZ+437FwOC3hse5VqUuhCMZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420772; c=relaxed/simple;
	bh=tA7lkcTHf3wF6dZwmNJz7Wr5e26IC3tmiBiju6SpX+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WmA/yLfsLwGkHbEWsKxY/ZhILWAA97+VXLwHGg2Suyex//BkZ/enLeu5O7ncjUzw45SiYQR6NbU0utoUySBZCEdXHFGwCNNN3XunHl6mEbv5CjOqeZ2xI/dP3EN19TFWuhSvo+KcB3SydBAMMzES+nUCkonJDMLlMXVfqmfLq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WYns30DP4z1HFft;
	Wed, 31 Jul 2024 18:09:59 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id EB1AF14037C;
	Wed, 31 Jul 2024 18:12:47 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 31 Jul 2024 18:12:47 +0800
Message-ID: <6dcd5f14-cba8-20af-0319-28ff3f94982a@huawei.com>
Date: Wed, 31 Jul 2024 18:12:37 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH net-next] RDS: IB: Remove unused declarations
Content-Language: en-US
To: <allison.henderson@oracle.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>, Simon Horman
	<horms@kernel.org>
References: <20240731063630.3592046-1-yuehaibing@huawei.com>
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20240731063630.3592046-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

+CC Simon Horman <horms@kernel.org>

On 2024/7/31 14:36, Yue Haibing wrote:
> Commit f4f943c958a2 ("RDS: IB: ack more receive completions to improve performance")
> removed rds_ib_recv_tasklet_fn() implementation but not the declaration.
> And commit ec16227e1414 ("RDS/IB: Infiniband transport") declared but never implemented
> other functions.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  net/rds/ib.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/net/rds/ib.h b/net/rds/ib.h
> index 2ba71102b1f1..8ef3178ed4d6 100644
> --- a/net/rds/ib.h
> +++ b/net/rds/ib.h
> @@ -369,9 +369,6 @@ int rds_ib_conn_alloc(struct rds_connection *conn, gfp_t gfp);
>  void rds_ib_conn_free(void *arg);
>  int rds_ib_conn_path_connect(struct rds_conn_path *cp);
>  void rds_ib_conn_path_shutdown(struct rds_conn_path *cp);
> -void rds_ib_state_change(struct sock *sk);
> -int rds_ib_listen_init(void);
> -void rds_ib_listen_stop(void);
>  __printf(2, 3)
>  void __rds_ib_conn_error(struct rds_connection *conn, const char *, ...);
>  int rds_ib_cm_handle_connect(struct rdma_cm_id *cm_id,
> @@ -402,7 +399,6 @@ void rds_ib_inc_free(struct rds_incoming *inc);
>  int rds_ib_inc_copy_to_user(struct rds_incoming *inc, struct iov_iter *to);
>  void rds_ib_recv_cqe_handler(struct rds_ib_connection *ic, struct ib_wc *wc,
>  			     struct rds_ib_ack_state *state);
> -void rds_ib_recv_tasklet_fn(unsigned long data);
>  void rds_ib_recv_init_ring(struct rds_ib_connection *ic);
>  void rds_ib_recv_clear_ring(struct rds_ib_connection *ic);
>  void rds_ib_recv_init_ack(struct rds_ib_connection *ic);

