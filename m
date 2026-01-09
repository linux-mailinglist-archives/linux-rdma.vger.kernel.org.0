Return-Path: <linux-rdma+bounces-15386-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6322AD06E33
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 03:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3E483025159
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 02:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9861AF4D5;
	Fri,  9 Jan 2026 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haQ97BPE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6265231A543;
	Fri,  9 Jan 2026 02:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927126; cv=none; b=rqfV+ckT6u2DRQA+OGigKBJMVEBY8qRaFNy6JclJCQ7bqmHp4M50h2kIxk8dzWeA2ZMFppPGuvObeOQ2XXpqJUTiPEhSG6z6gAYBIAtdcTjK/vviVcFxLVbumV7s4HY2Bt/QOC7y1T2Oxp2KCzWvN0mvKmCLfuCtoEMgE2ixTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927126; c=relaxed/simple;
	bh=YsjfDLzKGHNkSwL8U3zYckthzURrz70xD8qtCOBMkwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSDhX7QNPlNXumlglSE/9BJ4Brlye8BEC9PmP15H2Oc4OTNX5IKCd0vOhecR2Uvn+vpr/NaZYuhB2BW71hcerSJs9qQYt5FN+GF87Uo0yVvBZs7LMJA9f1wfyQOilvk8GuFjICoVQ547Y97xsIZC8fB4qhKlkVYrYm1aj9jgxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haQ97BPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EADC19422;
	Fri,  9 Jan 2026 02:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767927125;
	bh=YsjfDLzKGHNkSwL8U3zYckthzURrz70xD8qtCOBMkwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=haQ97BPEyXg2CJ8MdmxEMm2b0E6gn5J9vW++zjsU1EneWY0b0wfySh4/NUvDKrVfu
	 3w9Olo1f5wvyhRHINcPKil5QGYkh2wzEkGoJ/Ut3DDGHJG4mbbDh9jRQs814r37/WH
	 lYlZmfdSTNbDGzm5VNktjTXqe5QcZ9Bb4SygMzKgs1x/iD6XZJG/7EZuUaLzoT1gy7
	 /ca1z1GKNw2vv2MasAGbAAopcGNiXcaGqKKtj8F3oyucjV328PdKUgv9bLRhcGrT7W
	 Uc8MCshyhajAlxuvaEXZei9mlrwyvsGxZAp8JD1P0UgdlJEQ73hHU7eK/UiEH1uxbs
	 LO31kDzv6lADg==
From: Jakub Kicinski <kuba@kernel.org>
To: achender@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	allison.henderson@oracle.com
Subject: Re: [net-next,v4,2/2] net/rds: Give each connection path its own workqueue
Date: Thu,  8 Jan 2026 18:51:52 -0800
Message-ID: <20260109025152.2854640-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105223532.167452-3-achender@kernel.org>
References: <20260105223532.167452-3-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an automated AI-generated review of your patch.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
commit 95959b9817fcb113ceda9dcddc66514d2407af44
Author: Allison Henderson <allison.henderson@oracle.com>

net/rds: Give each connection path its own workqueue

This patch allocates per-connection-path workqueues instead of using
the shared rds_wq. This improves RDS failover performance by allowing
connections to process work independently.

> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index dc7323707f45..3743940423c8 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -269,7 +269,11 @@ static struct rds_connection *__rds_conn_create(struct net *net,
>  		__rds_conn_path_init(conn, &conn->c_path[i],
>  				     is_outgoing);
>  		conn->c_path[i].cp_index = i;
> -		conn->c_path[i].cp_wq = rds_wq;
> +		conn->c_path[i].cp_wq =
> +			alloc_ordered_workqueue("krds_cp_wq#%lu/%d", 0,
> +						rds_conn_count, i);
> +		if (!conn->c_path[i].cp_wq)
> +			conn->c_path[i].cp_wq = rds_wq;
>  	}
>  	rcu_read_lock();
>  	if (rds_destroy_pending(conn))
> @@ -278,6 +282,9 @@ static struct rds_connection *__rds_conn_create(struct net *net,
>  		ret = trans->conn_alloc(conn, GFP_ATOMIC);
>  	if (ret) {
>  		rcu_read_unlock();
> +		for (i = 0; i < npaths; i++)
> +			if (conn->c_path[i].cp_wq != rds_wq)
> +				destroy_workqueue(conn->c_path[i].cp_wq);
>  		kfree(conn->c_path);

The workqueues allocated above are properly destroyed here when
trans->conn_alloc() fails, but what happens in the "race to create"
paths later in this function?

When two threads race to create the same connection, one will win and
the other must discard its connection. Looking at the existing code
after this diff (around the "Creating passive conn" and "Creating
normal conn" comments), those cleanup paths call trans->conn_free(),
kfree(conn->c_path), and kmem_cache_free(), but they do not destroy
the per-path workqueues.

For example, in the "found" path for normal connections:

    if (found) {
        for (i = 0; i < npaths; i++) {
            cp = &conn->c_path[i];
            if (cp->cp_transport_data)
                trans->conn_free(cp->cp_transport_data);
        }
        kfree(conn->c_path);
        kmem_cache_free(rds_conn_slab, conn);
        conn = found;
    }

Could this leak the workqueues allocated earlier in the function?
Similar cleanup appears needed for the passive connection race path.

Note that destroy_workqueue() cannot be called while holding the
rds_conn_lock spinlock since it may sleep, so the fix would require
restructuring the cleanup to destroy workqueues before acquiring
the lock, similar to the trans->conn_alloc() failure path above.

[ ... ]

