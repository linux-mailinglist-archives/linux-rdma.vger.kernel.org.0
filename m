Return-Path: <linux-rdma+bounces-18940-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGs6EA4vzmnIlQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18940-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 10:55:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCB83865B1
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 10:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A4E2300D9C4
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 08:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA063C5DD6;
	Thu,  2 Apr 2026 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlmJEIv8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC4A3C5DB6
	for <linux-rdma@vger.kernel.org>; Thu,  2 Apr 2026 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119751; cv=none; b=S10IZ9psspm5b6MtjoBMADvksAmOKzqZXdb3R+T0M6VGHSZOLZU/EjI900vc2eEXvfqYBLPKHo9C7B3bW6tIu1HUt/WLzaJ8MuPm48s3sh3gT1rWf3sTS2IhM+PlMmCEUB1Z2T99fMaKJfgFg+EcxYeQtIhcjoq/69UoCODbR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119751; c=relaxed/simple;
	bh=qdiNykKpwczeQMUwnypd2rrY+HNlXX0BL7X6y8yUxT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMcpcawuAZuh47bfAyS/I3SjCK5q+WSwrushmJPQY40xnlR09S3iFbUU2Bsy/o+POKljdEQoEXZ7AvBgDyuLRacxuObwlpp8dUrsVofIvDFAjx8kPR116hF39KiUh1aSK7pjSy3/lUnOF8x3qUYhjOLtCpEgJLnqdA0o9TKmlq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlmJEIv8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775119749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5ouUt8tmgR98iV2s3/o0x+cLo/+6OojSrpAJEklpa8=;
	b=XlmJEIv8cvEru2PUBloKah38DKrGfqzK7enAid4/eF9rDrSNwseckN7JSZNWdwVOTKwDks
	W7IQ9AS2DOkxs/Sk39+0mZOckbTKMjcmTMFnsboIMBOg0LxQhVjk1PGskxGYgaJzVw8VvA
	ziDNiK4/IMgq2pgrog5y4+/jy02K0W8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-vgYmaqtkPt6Etqe38KbaXg-1; Thu,
 02 Apr 2026 04:49:06 -0400
X-MC-Unique: vgYmaqtkPt6Etqe38KbaXg-1
X-Mimecast-MFC-AGG-ID: vgYmaqtkPt6Etqe38KbaXg_1775119743
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49A731956053;
	Thu,  2 Apr 2026 08:49:03 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.195])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB66E30002D2;
	Thu,  2 Apr 2026 08:48:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: rkannoth@marvell.com
Cc: jiri@resnulli.us,
	cjubran@nvidia.com,
	edumazet@google.com,
	mbloch@nvidia.com,
	kuba@kernel.org,
	horms@kernel.org,
	sgoutham@marvell.com,
	dtatulea@nvidia.com,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	tariqt@nvidia.com,
	linux-rdma@vger.kernel.org,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	netdev@vger.kernel.org,
	leon@kernel.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org
Subject: Re: [v9,net-next,5/6] octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM entries
Date: Thu,  2 Apr 2026 10:48:40 +0200
Message-ID: <20260402084840.128387-1-pabeni@redhat.com>
In-Reply-To: <20260330053105.2722453-6-rkannoth@marvell.com>
References: <20260330053105.2722453-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18940-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[resnulli.us,nvidia.com,google.com,kernel.org,marvell.com,redhat.com,oracle.com,vger.kernel.org,lunn.ch,gmail.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9FCB83865B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
octeontx2-af: npc: cn20k: dynamically allocate and free default MCAM entries

Improve MCAM utilization by tying default (broadcast, multicast,
promisc, ucast) entry lifetime to NIX LF usage. On NIX LF alloc,
allocate default MCAM entries if missing; on NIX LF free, release
them so they return to the pool.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index ef5b081162eb..1f2128c61ade 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c

[ ... ]

> @@ -1566,8 +1567,8 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>
>  	/* Alloc NIX RQ HW context memory and config the base */
>  	hwctx_size = 1UL << ((ctx_cfg >> 4) & 0xF);
> -	err = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
> -	if (err)
> +	rc = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
> +	if (rc)
>  		goto free_mem;
>
>  	pfvf->rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
> @@ -1583,8 +1584,8 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>
>  	/* Alloc NIX SQ HW context memory and config the base */
>  	hwctx_size = 1UL << (ctx_cfg & 0xF);
> -	err = qmem_alloc(rvu->dev, &pfvf->sq_ctx, req->sq_cnt, hwctx_size);
> -	if (err)
> +	rc = qmem_alloc(rvu->dev, &pfvf->sq_ctx, req->sq_cnt, hwctx_size);
> +	if (rc)
>  		goto free_mem;
>
>  	pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
> @@ -1599,8 +1600,8 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>
>  	/* Alloc NIX CQ HW context memory and config the base */
>  	hwctx_size = 1UL << ((ctx_cfg >> 8) & 0xF);
> -	err = qmem_alloc(rvu->dev, &pfvf->cq_ctx, req->cq_cnt, hwctx_size);
> -	if (err)
> +	rc = qmem_alloc(rvu->dev, &pfvf->cq_ctx, req->cq_cnt, hwctx_size);
> +	if (rc)
>  		goto free_mem;
>
>  	pfvf->cq_bmap = kcalloc(req->cq_cnt, sizeof(long), GFP_KERNEL);

[ ... ]

> @@ -1699,9 +1706,12 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>
>  	goto exit;
>
> +free_dft:
> +	if (is_cn20k(rvu->pdev))
> +		npc_cn20k_dft_rules_free(rvu, pcifunc);
> +
>  free_mem:
>  	nix_ctx_free(rvu, pfvf);
> -	rc = -ENOMEM;
>
>  exit:
>  	/* Set macaddr of this PF/VF */

Does the removal of `rc = -ENOMEM;` cause the function to return success
when kcalloc() fails?

Looking at the kcalloc calls for rq_bmap, sq_bmap, and cq_bmap:

drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c:rvu_mbox_handler_nix_lf_alloc() {
	...
	rc = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
	if (rc)
		goto free_mem;

	pfvf->rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
	if (!pfvf->rq_bmap)
		goto free_mem;
	...
}

These three kcalloc failure paths reach free_mem with rc == 0 because the
preceding qmem_alloc() succeeded and set rc = 0. Previously, the code set
rc = -ENOMEM at the free_mem label, ensuring that any path reaching it
would return an error.

With the removal of this assignment, don't these paths now fall through
to exit: and return rc == 0, falsely indicating success?

The caller would believe NIX LF allocation succeeded with a partially
torn-down pfvf structure (NULL bitmaps, freed contexts), potentially
leading to NULL pointer dereferences on subsequent NIX LF operations.

Should the kcalloc failure paths set rc = -ENOMEM before jumping to
free_mem?


