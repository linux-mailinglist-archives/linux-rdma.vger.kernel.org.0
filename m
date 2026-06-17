Return-Path: <linux-rdma+bounces-22324-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GeL0I4rGMmqA5QUAu9opvQ
	(envelope-from <linux-rdma+bounces-22324-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 18:08:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A50569B44A
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 18:08:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=DTCUo7BV;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22324-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22324-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D45F3338BC2
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2026 15:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BDB4A33EC;
	Wed, 17 Jun 2026 15:51:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB22EEE80
	for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 15:51:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711485; cv=none; b=kpFqxu+aEmdKH2EmGjAvEeM3GEhusfqH6Polq3Hu0K7VvWywW5sHEr47S/E7WgPcLssvExvVbUyBkJm8G3CLjDZXenZRLBo+O3e5YLq2FCEWb5UUcv5rp8eSsFq7Yhtt/7MyfCXJ2k4Rng0lUGkYrvhkkragcCSyA2GzLtFeyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711485; c=relaxed/simple;
	bh=yRfDRQhokj4zw5duX5AE+w4CAiT3UJzAZY7nYvs8oBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hM3ahNVn9TdoXkex6Y3NUrPf3uUm4rXiXcxDBP1BxYIagz4TnRqqkvdXG1rI1IIArwQDg3FmtHujfGv79D/QQ5Pjtcr6ERdYXX89NDCcWzx70AJUgU0Hl8zah8S573rcFMMi+5AckKm6l/EPdn+yCmid3UqLwD+qBPoOzlvNO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DTCUo7BV; arc=none smtp.client-ip=91.218.175.184
Message-ID: <9c715d03-bf0d-40cb-a88b-a5e0c51cbd27@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781711460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdMEVye5ewPNNEBf7gRM+jI6Ri8/TTYrh+i2u/zWK8Y=;
	b=DTCUo7BVc+t7A9X+VbxG0PoT0NY9t1cxjrzSQTy+6128uGZO+qfLiatxl+DiXLereIgeH7
	RnjhmRfX2xBmp0+Ufc25w9GcB60FbwtDuATvUssaV3Mav+79JL00EX3XrGQvphtDJhZoSj
	LAmsLNEwRcKh3FqB8abLvyFvpjM8zz8=
Date: Wed, 17 Jun 2026 08:50:52 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/rxe: insert mcg into mcg_tree only after
 rxe_mcast_add() succeeds
To: Michael Bommarito <michael.bommarito@gmail.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1158f1de-4469-463c-91de-c5e24d2add4f@linux.dev>
 <20260617022728.2770116-1-michael.bommarito@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260617022728.2770116-1-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22324-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A50569B44A

在 2026/6/16 19:27, Michael Bommarito 写道:
> 
> rxe_get_mcg() publishes a newly allocated multicast group in
> rxe->mcg_tree before programming the backing Ethernet multicast address
> with rxe_mcast_add(), which runs outside mcg_lock. A local userspace
> RDMA client reaches this path with ATTACH_MCAST on a UD QP; if
> rxe_mcast_add() then returns an error (for example -ENODEV when the
> backing netdev has been removed, or a propagated dev_mc_add() error),
> the unwind frees the published group without removing it from the tree.
> A later lookup of the same MGID dereferences the freed struct rxe_mcg
> from __rxe_lookup_mcg().
> 
> Fix this by keeping the new mcg private until rxe_mcast_add() succeeds.
> Split the tree publication into __rxe_publish_mcg(), call rxe_mcast_add()
> before taking the tree reference, and free the still-private mcg on
> failure. Because the group is never visible in mcg_tree until the
> multicast address is programmed, no concurrent caller can look it up or
> attach a QP to a group that is about to be torn down, so the error path
> needs no conditional unwind. If another caller publishes the same MGID
> while the address is being programmed, the post-add re-check under
> mcg_lock finds the winner; this caller then drops its private object and
> balances its own rxe_mcast_add() with rxe_mcast_del() before returning
> the winner.
> 
> Reproduced by forcing the rxe_mcast_add() error return under KASAN:
> without the change the next attach to the same MGID reports a
> slab-use-after-free in __rxe_lookup_mcg(); with it the forced failure
> returns cleanly. A no-injection attach/detach regression, including a
> two-QP shared join/leave and re-attach, stays KASAN- and leak-clean.
> 
> Fixes: a926a903b7dc ("RDMA/rxe: Do not call  dev_mc_add/del() under a spinlock")
> Cc: stable@vger.kernel.org # v5.18+
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v2: switch approach in response to Zhu Yanjun's review of v1
>      (https://lore.kernel.org/all/1158f1de-4469-463c-91de-c5e24d2add4f@linux.dev/). v1 unwound the
>      already-published mcg on the failure path; Zhu noted that because
>      rxe_mcast_add() runs outside mcg_lock, a concurrent caller can find
>      the published mcg and attach a QP in that window, so an unconditional
>      teardown would orphan those QPs and leak the mcg. Rather than make the
>      teardown conditional, v2 does not publish the mcg into mcg_tree until
>      after rxe_mcast_add() has succeeded, which removes the window entirely
>      (the safety of the two-CPU same-MGID race and the loser-side
>      rxe_mcast_del() balance is analysed in the commit log above). No
>      Fixes/stable change; this is still the same UAF.
>      v1: https://lore.kernel.org/all/20260614130443.2517578-1-michael.bommarito@gmail.com/
> 
> Reproduction
> ============
> 
> Tested on v7.1-rc4 (5200f5f493f7) on x86_64 QEMU/KVM with KASAN,
> rxe, rdma_rxe, and userspace verbs against a Soft-RoCE device.
> 
> Conditions: the caller needs access to the rxe uverbs device and a UD
> QP. The demonstrated error path requires rxe_mcast_add() to fail after
> the mcg allocation; natural failures include netdev removal returning
> -ENODEV and dev_mc_add() errors such as -ENOMEM. The test made that
> return deterministic by forcing rxe_mcast_add() to return -ENODEV.
> 
> The private harness creates a UD QP, attaches an MGID, forces the
> rxe_mcast_add() failure, and repeats attach on the same MGID so the
> lookup walks the stale rb-node.
> 
> Stock: KASAN reports a slab-use-after-free in __rxe_lookup_mcg() while
> comparing mcg->mgid on the next attach.
> Patched: the forced-failure path returns without a KASAN report.
> Regression: no-injection attach/detach, two-QP shared join/leave, and
> re-attach complete without KASAN, WARN, or leak reports.
> 
> Mitigations: restrict access to the rxe uverbs device or avoid loading
> the rxe driver where untrusted local users can create RDMA objects.
> 
> The harness is available off-list on request. The RDMA selftest gate was
> checked; tools/testing/selftests/rdma does not contain a matching
> rxe_mcast or ATTACH_MCAST coverage test.

The transition from V1 conditional rollbacks to V2 ensure 'underlying 
resource readiness before object publication' architecture is an elegant 
and robust design choice.

By keeping the newly allocated mcg private until rxe_mcast_add() 
successfully completes outside the lock, this commit completely closes 
the race window where a concurrent caller could look up a half-baked or 
failing multicast group.

Thanks a lot. I am fine with this commit. Please Jason and Leon comment 
on this commit.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> 
>   drivers/infiniband/sw/rxe/rxe_mcast.c | 50 +++++++++++++++++++--------
>   1 file changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index 5cad72073eca1..eaa259cc39ea9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -175,7 +175,9 @@ struct rxe_mcg *rxe_lookup_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>    * @mgid: multicast address as a gid
>    * @mcg: new mcg object
>    *
> - * Context: caller should hold rxe->mcg lock
> + * Initializes the mcg fields. The mcg is private and not yet visible in
> + * mcg_tree, so this may run without rxe->mcg_lock; __rxe_publish_mcg()
> + * makes it visible under the lock once it is ready.
>    */
>   static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
>   			   struct rxe_mcg *mcg)
> @@ -184,13 +186,22 @@ static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
>   	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
>   	INIT_LIST_HEAD(&mcg->qp_list);
>   	mcg->rxe = rxe;
> +}
>   
> -	/* caller holds a ref on mcg but that will be
> -	 * dropped when mcg goes out of scope. We need to take a ref
> -	 * on the pointer that will be saved in the red-black tree
> -	 * by __rxe_insert_mcg and used to lookup mcg from mgid later.
> -	 * Inserting mcg makes it visible to outside so this should
> -	 * be done last after the object is ready.
> +/**
> + * __rxe_publish_mcg - make a fully initialized mcg visible in mcg_tree
> + * @mcg: the mcg object
> + *
> + * Context: caller must hold rxe->mcg_lock and a reference on mcg
> + */
> +static void __rxe_publish_mcg(struct rxe_mcg *mcg)
> +{
> +	/* caller holds a ref on mcg but that will be dropped when mcg goes
> +	 * out of scope. We need to take a ref on the pointer that will be
> +	 * saved in the red-black tree by __rxe_insert_mcg and used to lookup
> +	 * mcg from mgid later. Inserting mcg makes it visible to outside so
> +	 * this is done last after the object is ready and the multicast
> +	 * address has been programmed.
>   	 */
>   	kref_get(&mcg->ref_cnt);
>   	__rxe_insert_mcg(mcg);
> @@ -228,26 +239,37 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
>   		err = -ENOMEM;
>   		goto err_dec;
>   	}
> +	__rxe_init_mcg(rxe, mgid, mcg);
> +
> +	/* program the multicast address while mcg is still private, before
> +	 * it is inserted into mcg_tree. dev_mc_add() may sleep so this must
> +	 * run outside mcg_lock. On failure mcg was never published, so a
> +	 * plain free is correct and the tree is untouched.
> +	 */
> +	err = rxe_mcast_add(rxe, mgid);
> +	if (err) {
> +		kfree(mcg);
> +		goto err_dec;
> +	}
>   
>   	spin_lock_bh(&rxe->mcg_lock);
> -	/* re-check to see if someone else just added it */
> +	/* re-check to see if someone else just added it while we were adding
> +	 * the multicast address; if so use theirs and drop ours
> +	 */
>   	tmp = __rxe_lookup_mcg(rxe, mgid);
>   	if (tmp) {
>   		spin_unlock_bh(&rxe->mcg_lock);
> +		rxe_mcast_del(rxe, mgid);
>   		atomic_dec(&rxe->mcg_num);
>   		kfree(mcg);
>   		return tmp;
>   	}
>   
> -	__rxe_init_mcg(rxe, mgid, mcg);
> +	__rxe_publish_mcg(mcg);
>   	spin_unlock_bh(&rxe->mcg_lock);
>   
> -	/* add mcast address outside of lock */
> -	err = rxe_mcast_add(rxe, mgid);
> -	if (!err)
> -		return mcg;
> +	return mcg;
>   
> -	kfree(mcg);
>   err_dec:
>   	atomic_dec(&rxe->mcg_num);
>   	return ERR_PTR(err);
> 
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8


