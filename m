Return-Path: <linux-rdma+bounces-15385-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A955ED06E24
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 03:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFC11301B2ED
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 02:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ABD316904;
	Fri,  9 Jan 2026 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQmEjGT0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB61AF4D5;
	Fri,  9 Jan 2026 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767927112; cv=none; b=KpQy1jsENxMqv6ArjOgX9MclXQ20Y8W+UHXzDqWvmTxRIP9KoXGCvoZKHUuB+rDd6Q8KpXRx/Atki9gS4Iu8D/viXHEym9Tax227Vg/uVIk/mR1jhjat1H+jAzAPK00TpAbaxWUr1jyEcXtJ5yGNd+4NKN+QUm67ywYGPiU1/2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767927112; c=relaxed/simple;
	bh=BoUxRLW8fOKgcDo9sjE3LK2iX88FOP0BZDIaHBWU2wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njQs2tbcRJkFrUdFjEtmfTHWox+8jp+qNT2zJVsSlaSbyEX/E74AFVDM1E5Fm2fF19CuABgazUdlAtvo1+0vBFKg3OPmRV2bQfwu1PtqJ0huQtqaQhyPJ9qKfAexPOj9gBAyqE7dAHlSrVOWraLUtnotKSG8vZhJkekqdRPPWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQmEjGT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC7BC116C6;
	Fri,  9 Jan 2026 02:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767927112;
	bh=BoUxRLW8fOKgcDo9sjE3LK2iX88FOP0BZDIaHBWU2wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQmEjGT0iVqZQDdywKI2pZrMtRzX/7v9kMyJt2PWOGlGpFi5ZUMpwa7l2Vh6SoyOT
	 a9XzaxZ+D44U2cInuwdM8/EIp6QqlxjWeKqC/OojgNnJdxWS7M/AHv+N65ZnXLfBaB
	 9bziqJeNdS2MA4UEyg3x3Z/9FhWTJ9u3Yd/SPb7Qrs/DHpQEWSeo/ayX1DBjz5Y1NM
	 3p1SB8GIntug9sKcgPtNYX82Uz/RY+8FEJqcDfMHTXWNbkX5TsGPheCDv6r5c3XlgW
	 RGdQFF8/PHKkngfOJdqRKn3Mv92TOwSkeB67t7yHPN+zi5c2zy+Qi18S+gkTrClhP/
	 E5K83GzZYP2qw==
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
Subject: Re: [net-next,v4,1/2] net/rds: Add per cp work queue
Date: Thu,  8 Jan 2026 18:51:43 -0800
Message-ID: <20260109025143.2854604-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105223532.167452-2-achender@kernel.org>
References: <20260105223532.167452-2-achender@kernel.org>
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
commit 0d0b74852d11c82ac7d91c72b33c5dccb75934c5
Author: Allison Henderson <allison.henderson@oracle.com>

    net/rds: Add per cp work queue

This patch adds cp_wq to struct rds_conn_path and substitutes rds_wq with
cp->cp_wq throughout the RDS codebase to enable per-connection workqueue
management.

> diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
> index 4190b90ff3b1..e35bbb6ffb68 100644
> --- a/net/rds/ib_send.c
> +++ b/net/rds/ib_send.c
> @@ -419,7 +419,7 @@ void rds_ib_send_add_credits(struct rds_connection *conn, unsigned int credits)
>
>  	atomic_add(IB_SET_SEND_CREDITS(credits), &ic->i_credits);
>  	if (test_and_clear_bit(RDS_LL_SEND_FULL, &conn->c_flags))
> -		queue_delayed_work(rds_wq, &conn->c_send_w, 0);
> +		queue_delayed_work(conn->c_path->cp_wq, &conn->c_send_w, 0);
>
>  	WARN_ON(IB_GET_SEND_CREDITS(credits) >= 16384);

This substitution in rds_ib_send_add_credits() looks correct, but was the
similar call site in rds_ib_send_cqe_handler() in the same file
intentionally left unchanged? That function still uses:

    queue_delayed_work(rds_wq, &conn->c_send_w, 0);

Both functions have access to conn->c_path->cp_wq, so the inconsistency
seems unintentional. If some call sites should remain on the global rds_wq
while others use the per-connection workqueue, it would help to understand
the reasoning.

Similarly, rds_cong_queue_updates() in net/rds/cong.c still uses:

    queue_delayed_work(rds_wq, &cp->cp_send_w, 0);

even though it already has cp available. Should this also be updated to
use cp->cp_wq for consistency with the other substitutions?

