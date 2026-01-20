Return-Path: <linux-rdma+bounces-15779-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL36HkPLb2mgMQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15779-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 19:36:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 508DC49923
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 19:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65FCB844EFE
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64196334374;
	Tue, 20 Jan 2026 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="enorTZHH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A9320A05
	for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927482; cv=none; b=tnGCEe9EyxR/vsBycgCwwdzXuboxL3/U7vm4s2teHqpxrU/ckgqq96nq+TB1LyGrOyKQYSo8fMqY56Vo2j0P3hzWCwGd956d8HHtkUadfK4an5GIftWuFbRUJkErc15qYVDzSiejB6LBDEsLl8peRpE0vC6Ue3tNW+1n0Sq7EC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927482; c=relaxed/simple;
	bh=aUDhPKL0hM8JEgf53e07so1yz09QTsbUMmEPM++MMC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRC/FdlYBuPwhK5/rmYrKeudxsVkpjSkH+hTctZBQPEQjp2xMTo7snBD08gp5c8Np1MlXsLzQ/Dv4alRCfjMvp3bSFp9dmQUnqecR7nEdRSGuY/H7G/lHqQNdY5iXYjTImPZNGQQG/jksq1iGxntZzzGKFZfgUGaBRoVzRv/cV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=enorTZHH; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c52c1d2a7bso1844085a.0
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jan 2026 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768927479; x=1769532279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=byK9CbCzUXPvYH8hMBYCGjlZe3ysbsipoknrt4q5MYA=;
        b=enorTZHHb2rEovvaqsHlJudTAyqhy1O+b6Wb9hMirBr3bEDZcElB++EhFMTigB6DNN
         g/5LhzI3JIgnahlwdRTRt4XxSlT1UHF7t0P7XiGBm4w296ImJAO3juGTZH1hiWQsVERe
         Hs7hs0ESDrEo3XIH757I+XTnWNoN3QMlMOLXsKa110lwqqOJeojAC+9bzc15VrPQ9Bst
         Nt9II4GuZja6VvAjbE0pNFpsGIXcG9aQJqiii62oK/+nQ9dAMlXfPc5hhvkWEtaGDVXO
         IBiT40k7MZs4mDeMIIWqaqZ9CwpO/sYnK9wG52P5SoSVI89RnqLH2qCxElydmideAxh2
         YGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768927479; x=1769532279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byK9CbCzUXPvYH8hMBYCGjlZe3ysbsipoknrt4q5MYA=;
        b=YlqwavXWvo7eSxydCvbaVJXyS3QxFEraRpms3Sao8asXZ+/62BeVeTDYtYkxbpKaRP
         KS4sTK3IfHJvsKOufz5Azj/NYxsXtcpRHjSSIOvEIMQJrdBjvr+r0q4zyKnpHt6YScS0
         f5nMViGVWI9xeLfNx8J8oLg6z/CsS/yBURGibGuQUZhQYAUYeAcDgSNHLZLmCT/RBZ5w
         Y3qWf+yMJojWs/P14wGocPp3tVhmiLZLfelvhokSWhaA5oAsMu4CBiiNABYaQu5lL449
         evhSQHuWcYQk0rkfnDOwZMmYWvT5ghfs/EmR5u1NkGFOUC1B9aeEw19heRBU7RzgpGDy
         VFrg==
X-Forwarded-Encrypted: i=1; AJvYcCV396wdGXToGQPdiUrn+dgHfBES06EhQNFyHpDEfAWTQ20EskwXYYN38MIrKrzQurhhCMqPBPZJPQS2@vger.kernel.org
X-Gm-Message-State: AOJu0YzTZVV10MfGshMKapQ+orKKtqhQ84Wxv4ao+An6U9sRVR+AeQWE
	WbR6hKGrErIBgypiHNHQIPPif8p8T2RRJ52f0Yp9t5XQzjVqI5j6RfIVZeRJc/B0h1w=
X-Gm-Gg: AY/fxX7WY3q4E3rEndxW5bZxVncuGqwNLR2nHBR3/i+7YQx8GAMxLtz2MhAnYiHP1RG
	9rUYGpUXjI9GEblKwTRkuHbzCx9qtRoIO/EbJjV9cOrMVhEUvC7PkY7xGiQw0eGZlcHXn5M+m2t
	Rj7oSTquODuu2TPba9jvXdhrDPaVlPD5uOJlcU9uBWDOTDdc+jzJ5D77MfXBxobFpWuiApSyQvf
	uFAJODqabwecjFQHSzpVw8SfQmnVzBLKe2OMJXVj7TrAVDiTuQWZsZf08W/lbrmIn4h1tamGuVV
	OpRO/ZYJIAu0KRlPocKzNy8s85wHnPq7ERfVCOLeKgXZdUrt5FPKN0aoNFwXnBZ+XGgT9hQMLaG
	Crj6X0GasG6cMG1jHQNzLJVjBpThlolr0PyU4tfjHwLEz78KjHls9usn+NdQQhBqecFZY7EerRj
	bm4W1dBQWLQP3uZsWA4QueaGNNDcPNc56jiktDlR5UpAlXlUGasNnDIxXa43i89FEN24U=
X-Received: by 2002:a05:620a:4011:b0:89f:cc73:386 with SMTP id af79cd13be357-8c6a6479374mr2212242085a.13.1768927479473;
        Tue, 20 Jan 2026 08:44:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a72507d5sm1084693385a.32.2026.01.20.08.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 08:44:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viEqM-00000005YT2-14LN;
	Tue, 20 Jan 2026 12:44:38 -0400
Date: Tue, 20 Jan 2026 12:44:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Michael Guralnik <michaelgur@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next v2 02/11] IB/core: Introduce FRMR pools
Message-ID: <20260120164438.GR961572@ziepe.ca>
References: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
 <20251222-frmr_pools-v2-2-f06a99caa538@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222-frmr_pools-v2-2-f06a99caa538@nvidia.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15779-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 508DC49923
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Dec 22, 2025 at 02:40:37PM +0200, Edward Srouji wrote:
> +static int compare_keys(struct ib_frmr_key *key1, struct ib_frmr_key *key2)
> +{
> +	int res;
> +
> +	res = key1->ats - key2->ats;
> +	if (res)
> +		return res;
> +
> +	res = key1->access_flags - key2->access_flags;
> +	if (res)
> +		return res;
> +
> +	res = key1->vendor_key - key2->vendor_key;
> +	if (res)
> +		return res;
> +
> +	res = key1->kernel_vendor_key - key2->kernel_vendor_key;
> +	if (res)
> +		return res;

This stuff should be using cmp_int().

> +static struct ib_frmr_pool *ib_frmr_pool_find(struct ib_frmr_pools *pools,
> +					      struct ib_frmr_key *key)
> +{
> +	struct rb_node *node = pools->rb_root.rb_node;
> +	struct ib_frmr_pool *pool;
> +	int cmp;
> +
> +	/* find operation is done under read lock for performance reasons.
> +	 * The case of threads failing to find the same pool and creating it
> +	 * is handled by the create_frmr_pool function.
> +	 */
> +	read_lock(&pools->rb_lock);
> +	while (node) {
> +		pool = rb_entry(node, struct ib_frmr_pool, node);
> +		cmp = compare_keys(&pool->key, key);
> +		if (cmp < 0) {
> +			node = node->rb_right;
> +		} else if (cmp > 0) {
> +			node = node->rb_left;
> +		} else {
> +			read_unlock(&pools->rb_lock);
> +			return pool;
> +		}

Use the rb_find() helper

> +static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
> +					     struct ib_frmr_key *key)
> +{
> +	struct rb_node **new = &device->frmr_pools->rb_root.rb_node,
> +		       *parent = NULL;
> +	struct ib_frmr_pools *pools = device->frmr_pools;
> +	struct ib_frmr_pool *pool;
> +	int cmp;
> +
> +	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
> +	if (!pool)
> +		return ERR_PTR(-ENOMEM);
> +
> +	memcpy(&pool->key, key, sizeof(*key));
> +	INIT_LIST_HEAD(&pool->queue.pages_list);
> +	spin_lock_init(&pool->lock);
> +
> +	write_lock(&pools->rb_lock);
> +	while (*new) {
> +		parent = *new;
> +		cmp = compare_keys(
> +			&rb_entry(parent, struct ib_frmr_pool, node)->key, key);
> +		if (cmp < 0)
> +			new = &((*new)->rb_left);
> +		else
> +			new = &((*new)->rb_right);
> +		/* If a different thread has already created the pool, return
> +		 * it. The insert operation is done under the write lock so we
> +		 * are sure that the pool is not inserted twice.
> +		 */
> +		if (cmp == 0) {
> +			write_unlock(&pools->rb_lock);
> +			kfree(pool);
> +			return rb_entry(parent, struct ib_frmr_pool, node);
> +		}
> +	}
> +
> +	rb_link_node(&pool->node, parent, new);

I think this is rb_find_add() ?

Jason

