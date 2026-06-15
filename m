Return-Path: <linux-rdma+bounces-22221-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WnMFG1ZVL2pr+gQAu9opvQ
	(envelope-from <linux-rdma+bounces-22221-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 03:28:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2051682BF4
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 03:28:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=BFc7757V;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22221-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22221-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74A563005780
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 01:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BBA21A447;
	Mon, 15 Jun 2026 01:28:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFB9155757
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 01:28:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486915; cv=none; b=sTIeSqmduWReysukXSEsVr5okl9pixKPIZ+rmm/y898ZkWloRxBnIXTUH/UYN4Mlg7tMSNAX5PrCdM3zOUib6JtJMrMR8Tp18OILJpIJA3yGlXCuVQaMmTKO8CizCuMG2BIvdRECH1a+m3765jvtedQUxiXuRlSXLYlYZfaXZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486915; c=relaxed/simple;
	bh=59k4LptdcnP2B3/2SKGb9aAohuCDpnTk3Ox0XdIaEJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmI6cIqREXuVBBGRQQ96HXgMIGpXcLO2yfqaLo7+eEYrzXonG1aneKe9j48UZhsYXq+3xXEXZVg9mh4fTTtitzx/oMMw2qrYyXBj6eSzd+NOCHauR4CS0Z+UJkN0okMY1eIytxiQaBP3v+9yMoJfO1XkPBt60G5IJRwuN23gRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BFc7757V; arc=none smtp.client-ip=91.218.175.185
Message-ID: <1158f1de-4469-463c-91de-c5e24d2add4f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781486901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSVS4LbhE8jKTOaDve6Nbpr9kztmgSLO4YHYFC8VRyQ=;
	b=BFc7757VQco+74tyToV3dOfsRp1dWr1S40I7wEP274wNUgCxkaLAFXxSrprh29riui/FfT
	iamv/l0rV6ze7eKJEAkWTid8xr5Os+x1bSdNugTX6T5m+PqbT9p2oVqUnuhL/eykKJV2Q9
	tTd2iOpzqby/gDFwFiTxVrRSJ14NZT8=
Date: Sun, 14 Jun 2026 18:28:11 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: destroy the mcg when rxe_mcast_add() fails in
 rxe_get_mcg()
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260614130443.2517578-1-michael.bommarito@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260614130443.2517578-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22221-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:yanjun.zhu@linux.dev,m:rpearsonhpe@gmail.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2051682BF4

在 2026/6/14 6:04, Michael Bommarito 写道:
> rxe_get_mcg() inserts the new mcg into rxe->mcg_tree and takes the tree
> reference before calling rxe_mcast_add() outside mcg_lock. On failure
> the error path frees the mcg with a bare kfree() without erasing the
> tree node or dropping the tree reference, so the freed mcg stays linked
> in mcg_tree and the next __rxe_lookup_mcg() on the same mgid uses it
> after free. rxe_mcast_add() fails reachably from an unprivileged caller:
> -ENODEV when the backing netdev is removed, or a propagated dev_mc_add()
> error.
> 
> Tear the mcg down with __rxe_destroy_mcg() on the failure path, as
> rxe_attach_mcast() already does.
> 
> Reproduced under KASAN on QEMU by forcing the rxe_mcast_add() failure;
> the use-after-free in __rxe_lookup_mcg() is gone after this change.
> 
> Fixes: a926a903b7dc ("RDMA/rxe: Do not call  dev_mc_add/del() under a spinlock")
> Cc: stable@vger.kernel.org # v5.18+
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Reproduction (v7.1-rc4, x86_64 QEMU/KVM, KASAN, Soft-RoCE):
> 
> Forcing rxe_mcast_add() to return -ENODEV, an unprivileged ATTACH_MCAST
> on a UD QP leaves the freed mcg linked in mcg_tree. On the stock kernel
> the next lookup reports
> 
>    BUG: KASAN: slab-use-after-free in __rxe_lookup_mcg
> 
> and the subsequent rb_erase() panics. Patched, the forced failure
> returns cleanly. Control: with injection disabled, re-attach and detach
> of the same MGID and a two-QP join/leave are KASAN-clean on both trees.
> 
> tools/testing/selftests/rdma has no rxe_mcast coverage; harness off-list
> on request.
> 
>   drivers/infiniband/sw/rxe/rxe_mcast.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index 5cad720..7f148d4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -196,6 +196,8 @@ static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
>   	__rxe_insert_mcg(mcg);
>   }
>   
> +static void __rxe_destroy_mcg(struct rxe_mcg *mcg);
> +
>   /**
>    * rxe_get_mcg - lookup or allocate a mcg
>    * @rxe: rxe device object
> @@ -247,7 +249,13 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>   	if (!err)
>   		return mcg;
>   
> -	kfree(mcg);
> +	/* mcg was made visible in mcg_tree; unwind the insert before freeing. */
> +	spin_lock_bh(&rxe->mcg_lock);
> +	__rxe_destroy_mcg(mcg);
> +	spin_unlock_bh(&rxe->mcg_lock);
> +	kref_put(&mcg->ref_cnt, rxe_cleanup_mcg);
> +	return ERR_PTR(err);
> +

Thanks for fixing the UAF. While this patch resolves the single-threaded 
issue, it introduces a severe race condition in concurrent environments.

Because rxe_mcast_add() runs outside the mcg_lock, a concurrent thread 
can find this mcg in the tree and successfully attach its own QPs during 
this window.

If the creator thread unconditionally erases the mcg from the tree on 
failure, those concurrent QPs become "orphaned." Future 
rxe_detach_mcast() calls will fail to find the erased mcg, causing these 
QPs and the mcg memory to leak permanently.

Attempting to simplify the rollback by unconditionally destroying the 
node or merging unlock paths can easily lead to executing kfree or a 
nested lock acquisition while still holding the mcg_lock spinlock, 
triggering a kernel deadlock or a double rb_erase panic.

The error path must conditionally destroy the mcg. After re-acquiring 
rxe->mcg_lock, check if mcg->qp_list is empty:

If empty: Safe to dismantle. Call __rxe_destroy_mcg(), drop the lock, 
and put the final reference.

If NOT empty: Concurrent threads have adopted it. Do not erase the tree 
node; simply release the lock and drop the creator's reference.

Please consider submitting a v2 addressing this concurrency gap.

Zhu Yanjun

>   err_dec:
>   	atomic_dec(&rxe->mcg_num);
>   	return ERR_PTR(err);
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8


