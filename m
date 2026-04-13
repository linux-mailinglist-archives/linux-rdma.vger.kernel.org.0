Return-Path: <linux-rdma+bounces-19288-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBxBF+Xo3GmUYAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19288-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 15:00:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A89CA3EC4D6
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 15:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C3CC301B71F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 12:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033573C9EF1;
	Mon, 13 Apr 2026 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKFTYdC1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyhR4wmh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677963C3BF3
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776084968; cv=none; b=FUejST1rC+We9b1eJISFlJ9Dn/sgvPOZVu2a0bPsrQYfX4k77mCjP+8qNEMgY/2EWrhhazwzdOeNX981JTW3uaBG4F+V9LtfmkGUNuMPsXsfH4RrEpiZAaK882VzdN6X7J826YGBrZKsJeutGM11A/lxIqmxpfF1HWQBxt3fI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776084968; c=relaxed/simple;
	bh=pKdlBBc/Zo/O/9zta+3GqZOpzw/wF/xhfIybxfLv6Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8cJtthbqDh9Bwk+jkrZG8OeUWK4Ke9j0LTrA2djjH9PMTm66zwT3Fu+X56F0WwPwuyuAoqFVFmMyLmpvG+2MwqYtoOzYBVcmmBMudqmNqBUAa6IwF5B+GYMjP6+RB6aHhNVU2Q2ChogfIo5ozkLt4iTHeFzPKqzMkwgTRzGEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKFTYdC1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyhR4wmh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776084966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bQHnab1AqDhEpIxV325QbEK6nu+RxguHD8R3QEZxdfM=;
	b=DKFTYdC14g9e+7MxwmwxYdBkhkwJ3yaHjcM2xoAJtxO298hfj1kPW6lK7A4AekGR1/CMr+
	sKtWl/rAO8pWcR8IpD/7G4iapc2jQm+EQTtoCcT0BwngyRNuQo1LQaTqZpx3MJj/aiqNOc
	B5hN0lVbI+QQmNUr3AoxlTu0klNvt1w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-XWfip7OUMbGJVblFkQR13Q-1; Mon, 13 Apr 2026 08:56:05 -0400
X-MC-Unique: XWfip7OUMbGJVblFkQR13Q-1
X-Mimecast-MFC-AGG-ID: XWfip7OUMbGJVblFkQR13Q_1776084964
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488e1757205so8043945e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776084964; x=1776689764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bQHnab1AqDhEpIxV325QbEK6nu+RxguHD8R3QEZxdfM=;
        b=DyhR4wmhQlHNvgnEzZCOrlpIEnw28H5pg9Ycp5nejHRcbQ1rcN3fnGBLX/MFV6qI4q
         W181vXZ+Lf+U9OC6MLTOBCFlhuueP0iBaO7pJOVz7XfiYeLC/JYcQJuuFlqP9RWhdHTS
         YLoStWLEaKmcIWWNXAQ6Rnl3Pq5E870j4GvFL1ZJCzDkXEkJvCznX4EXAGIq9r3KbRdI
         qSWbJUa3XyQQBKv1+T1MLXOAJhAYOjCLIU5G+aoaoJUnTy1Uiiyq6KbgKZXJX8xVyuka
         dugT9DhBqug8xaZgzhdR6B7JZqR5EIZb+ChallcjNNr53auUDaGa9curCy2+M8tRVd0g
         4Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776084964; x=1776689764;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQHnab1AqDhEpIxV325QbEK6nu+RxguHD8R3QEZxdfM=;
        b=NSMs94mAIImIXuC4V9FWbRNSaR+ZBHKm6RWPHFKBS5aFmqzv7JvFSFKFIdDMLCJ2Jg
         tsRpip2U8xoj/KSQSbZw/sfwSx/c0D11rXjlHhkZqVWek4+8Y8Tq8BY4RqjmVUco9wvy
         QOUAyujBoFA55rlCh1YXZbR1TJ9TJbgdQM+3KgJiLfYzhpRNZSo5ay3U1Tp++f2oG2fR
         s7u2Mw0rEXRKGVcpbvWVzKSjUnlGARkmAv4QFH7tn7vIgqT5a/U64ilEuAp98Mj3+wS3
         ocONZdvIay5sGnWgVxmDVusFA0m87q5WsAqHrEF9i2ckEJnPAbCqxSNwL+bWHFOL78sn
         28EQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LyMiT10WRmkwtoQbMAYxFbymoAVjg/Qlhk3oLl1EsHKxvyfr0MHUZNK5vdIinHdtCufBXxsGujqpc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuwwjocw3KA44p/Kz1yJMU51llEO3xaWBhZMMjnFJp/n/BWnH0
	19ZUSOXDGYnMcryIqovsNCZe1NuAzzkPfCm2WvFtBKpFlhl3R4IrRffm0cDblBoAl+2d+U0djW1
	95Kka6A4WhokcbDexD4fz2xXVdsNb0oee+Q3RJxj5i/Vm5e0OvJHF8o5hr+H0ptc=
X-Gm-Gg: AeBDievy3n73N9nGEjOIyz3T6rsCvvQlNxiNRX1ngvUVoD9b1peXoxfn3IiLHjRlPdz
	CIWhPl3oShAee9BxulPpPRy9c6cPjx/YUhCW4TzpPlMWhqw3vVbQH7hlBtjP/znwjmXaeRsepZm
	KPixuPmmy2d5oZwa8DufVUTclEXyDekVhj4JQW/tB8xY3xhHkBngEIZ4NDx/CJEDFus9kY1ylJz
	EWdlqAbB0Ri/95WMEXppHqjUedU+/ObgfOoe2/3UsKg1kQZU2Np6WbDnAgN4zlR2p9HqnCrIyX4
	zqRtLAELnUpDq7ZwgBTrh61yoHAFikybfl8eEQW7I7TTU8zwbF1ZdqqPmE6lkEEFd+3vIRqUR3R
	9bSVvuydJqWaGFWzd6oT/ZGHolz2nQyEjQnzpUpuUZ0gja+mnm+ZOwNX8
X-Received: by 2002:a05:600d:d:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-488d67b8db8mr139359715e9.2.1776084963876;
        Mon, 13 Apr 2026 05:56:03 -0700 (PDT)
X-Received: by 2002:a05:600d:d:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-488d67b8db8mr139359395e9.2.1776084963420;
        Mon, 13 Apr 2026 05:56:03 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b3d4dbsm293834175e9.14.2026.04.13.05.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 05:56:02 -0700 (PDT)
Message-ID: <b9ffa72d-ebe2-4fd1-b668-93620f206179@redhat.com>
Date: Mon, 13 Apr 2026 14:56:00 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 5/7] octeontx2-af: npc: cn20k: add subbank
 search order control
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, donald.hunter@gmail.com,
 horms@kernel.org, jiri@resnulli.us, chuck.lever@oracle.com,
 matttbe@kernel.org, cjubran@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com, mbloch@nvidia.com, dtatulea@nvidia.com
References: <20260409025055.1664053-1-rkannoth@marvell.com>
 <20260409025055.1664053-6-rkannoth@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260409025055.1664053-6-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,resnulli.us,oracle.com,nvidia.com];
	TAGGED_FROM(0.00)[bounces-19288-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: A89CA3EC4D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 4:50 AM, Ratheesh Kannoth wrote:
> CN20K NPC MCAM is split into 32 subbanks that are searched in a
> predefined order during allocation. Lower-numbered subbanks have
> higher priority than higher-numbered ones.
> 
> Add a runtime devlink parameter "srch_order" (
> DEVLINK_PARAM_TYPE_U32_ARRAY) to control the order in which
> subbanks are searched during MCAM allocation.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.c | 91 +++++++++++++++++-
>  .../ethernet/marvell/octeontx2/af/cn20k/npc.h |  2 +
>  .../marvell/octeontx2/af/rvu_devlink.c        | 92 +++++++++++++++++--
>  3 files changed, 173 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index e854b85ced9e..153765b3e504 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> @@ -3317,7 +3317,7 @@ rvu_mbox_handler_npc_cn20k_get_kex_cfg(struct rvu *rvu,
>  	return 0;
>  }
>  
> -static int *subbank_srch_order;
> +static u32 *subbank_srch_order;
>  
>  static void npc_populate_restricted_idxs(int num_subbanks)
>  {
> @@ -3329,7 +3329,7 @@ static int npc_create_srch_order(int cnt)
>  {
>  	int val = 0;
>  
> -	subbank_srch_order = kcalloc(cnt, sizeof(int),
> +	subbank_srch_order = kcalloc(cnt, sizeof(u32),
>  				     GFP_KERNEL);
>  	if (!subbank_srch_order)
>  		return -ENOMEM;
> @@ -3809,6 +3809,93 @@ static void npc_unlock_all_subbank(void)
>  		mutex_unlock(&npc_priv.sb[i].lock);
>  }
>  
> +int npc_cn20k_search_order_set(struct rvu *rvu,
> +			       u64 arr[MAX_NUM_SUB_BANKS], int cnt)
> +{
> +	struct npc_mcam *mcam = &rvu->hw->mcam;
> +	u32 fslots[MAX_NUM_SUB_BANKS][2];
> +	u32 uslots[MAX_NUM_SUB_BANKS][2];
> +	int fcnt = 0, ucnt = 0;
> +	struct npc_subbank *sb;
> +	int idx, val, rc = 0;
> +
> +	unsigned long index;
> +	void *v;
> +
> +	if (cnt != npc_priv.num_subbanks) {
> +		dev_err(rvu->dev, "Number of entries(%u) != %u\n",
> +			cnt, npc_priv.num_subbanks);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&mcam->lock);
> +	npc_lock_all_subbank();
> +	restrict_valid = false;
> +
> +	for (int i = 0; i < cnt; i++)
> +		subbank_srch_order[i] = (u32)arr[i];
> +
> +	xa_for_each(&npc_priv.xa_sb_used, index, v) {
> +		val = xa_to_value(v);
> +		uslots[ucnt][0] = index;
> +		uslots[ucnt][1] = val;
> +		xa_erase(&npc_priv.xa_sb_used, index);
> +		ucnt++;
> +	}
> +
> +	xa_for_each(&npc_priv.xa_sb_free, index, v) {
> +		val = xa_to_value(v);
> +		fslots[fcnt][0] = index;
> +		fslots[fcnt][1] = val;
> +		xa_erase(&npc_priv.xa_sb_free, index);
> +		fcnt++;
> +	}
> +
> +	/* xa_store() is done under lock. If xa_store fails
> +	 * ,no rollback is planned as it might also fail.

Why do you need to go throuh erase and add loop? Why can't you directly
xa_store() the new value? Note that xa_store() can fail due to memory
pressure.

Avoiding the previous erase will prevent deallocation and re allocation
and will avoid any reasonable xa_store() failure.

AFAICS there are a few more items reported by sashiko, please have a look:

https://sashiko.dev/#/patchset/20260409025055.1664053-1-rkannoth%40marvell.com

/P


