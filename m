Return-Path: <linux-rdma+bounces-22018-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LyJUDhMbKGob+AIAu9opvQ
	(envelope-from <linux-rdma+bounces-22018-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 15:54:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FED8660BFE
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 15:54:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=VFtR0dli;
	dkim=pass header.d=redhat.com header.s=google header.b=jK9aVJGT;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22018-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22018-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 730EC30799F2
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE95B426D19;
	Tue,  9 Jun 2026 13:49:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F44C4183C0
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 13:49:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012980; cv=none; b=oZm1aHG58DUMitHk+lz/Q6r6fRNXsdYNS1WTlubEsGorXuJNQA3RBRUynNK193wf/beU41Q8Yd5Wp8ZZhfBjHlXRo9oJ8Wl/hnFQStvji0xZWth7jCy/0h6JmUPjU6HmaQQqDhhGsampEPnez0NFLrnGuoTWLeUtfHh/AKa+1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012980; c=relaxed/simple;
	bh=52hnpEEgmB0qWOhFXmQimr5kmQmV0hK1rKA90td2mpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnNWQjKpPerVnlkF1vhLk5CE+KBZav1X2l9W8JYtS9QuBO5qd7bsB0t2j9KW7piyz6jWLYLb1bCz4Pe1vM6t6fR3/0iMAhVKhM6HQ3b6vJSvr9kbWjwWpUL7nNSHX4QVDAuk8g815AArWtnNA9ge5c0wr9MJRv1hqPb0YDE5GFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VFtR0dli; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jK9aVJGT; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781012978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6ZyLSFW2ZGo0KhUw8PJ3xCFPCwEjsrRdGcTeemtK0Q=;
	b=VFtR0dliCz+c59c55x5i/HYrDikj2rpYUvHXYQMmXCuVDmErCL8y2fh+oV6ucfeLWnaezm
	Q7EU+s5cTwzClpKumnmKd55WLR9FdAPrf/KJHUZDe8qnij7xNK5Yujm8dPZM2KQS7EerSE
	G8pjPDQ8IZgpJkJht7X8AmaoHvZufvw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-CXmjRNJuOPWPywapeB1dLw-1; Tue, 09 Jun 2026 09:49:30 -0400
X-MC-Unique: CXmjRNJuOPWPywapeB1dLw-1
X-Mimecast-MFC-AGG-ID: CXmjRNJuOPWPywapeB1dLw_1781012969
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490ae3bcf4cso27029845e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Jun 2026 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781012969; x=1781617769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6ZyLSFW2ZGo0KhUw8PJ3xCFPCwEjsrRdGcTeemtK0Q=;
        b=jK9aVJGTxv8be1+tKzicU7/AOu5CStC3IF11kDiUoOs5TCuXNHt70oGKCJ/NXnuWnq
         Qrp0SI4A9Q1W/D0+Y/KagkERSITlruDORdL/XEBHrCeg9HyhO+QK2X3MLgPjbQj8neef
         m5520zjbb7S8hL7CgC3V8K8UgsZF57KOPiD6ysud22c2m7BgoR7nhPfTh4RV43a7DLfL
         o004DPFsvYEnrgUY6xylZUuulPdq8fffA9QEExifr/5GemmYWurs5vb3WXvtC21jdOJ7
         9wxDHoLMLYfNCuIqrXPLClxM3AeJHcZQ2NoUMp2I8YtnweyQtcdCdyciOa2/sJ/6R+NR
         X3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012969; x=1781617769;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6ZyLSFW2ZGo0KhUw8PJ3xCFPCwEjsrRdGcTeemtK0Q=;
        b=KSH5m7gk7C+SevQtPqBnZ6V11htSWoWl3J3V1/+2T0f5MSjefmmGy0ly5FgRvyf27t
         zfymK5DpNz7+xa0YNKdUx6LQr6qKyGH1EIKGjWaxbQ5rvywbSTKDgiFHbUFkuReDosZU
         oL//NMWvU0AM4j2oiQ8ak3mTPBA7npF1jlsO9rXnr959S3QjmlBf0CohcpgyOp1hv5OI
         nAIhbAhUwPvN5PqbQ2L3K+xP28tIoUXWEUEJjEBQsG3it9O1wzm87pN+gFWJstZtUlP6
         VkskzR/9DoV1WGUyHhyQM9UOe3Cmwi/jmjeyuXRHDpr/gLwtn3b3JpV6CoEEoy7YPhRE
         ap2A==
X-Forwarded-Encrypted: i=1; AFNElJ9nuZKBC27P+Ahpw0yYTGypfgJjnXXWilq5ph89fx7vsUJd9gfe3hrSsRgynrK1gAF7F9/RmOp8jGFI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2orIuoHXzTNgl72nhjSK7VfwbwufLj/VpUpuVEeLqAv0QWjgc
	Qr2uMNc/uHeDcoWzWfChuGRY9G96CXroQ8jN+tGKP9moslne2V6ZWu+zpbjD1aEnK/JMSqVKOKs
	YXuog093sIZ+Adh1f/d0xcYmh8e/0wrK0mN5hQbZu7zCdcvPgPGGunCe8fUMk6hM=
X-Gm-Gg: Acq92OG3HT+kUUfHKZy5PAvSR8xSqJ7+E/pxsIzG0MRmTV18Kkp9NqL5oM/p/trtWFG
	Gq6VFTa/+8L0V5Lnkhi0Weqzn6roaS8XsUF84xqqyIbJctofUfWRRe0anhQMwx7Bel48ZH5NcIa
	CErVFlCtApCEvJgxqfo1uWvveQfpbj6eWd+/jpWjYK8x/ShvRuNmP/fplBWuvw0CbOt4ubsKyaH
	1McL07qdIxFz35BpyJ88ZOdQtWPJCGwAWxhLviGyUumQvFszqzdiKxAJpI7F/l2f4Ganl9ltHTB
	C7qVRqnLvLZdDqu7bSn86i59+Hv10Tg3mlW5wVl/P2xM1+j4Gzer7HYIUGDolpL1QG5XrDmwGlh
	hdXkHHdgcTg7t3V48QPDQpzWKgFT98un68K1tsISoMR3JmMztQa1zSbw1KNjVS6Rkvw==
X-Received: by 2002:a05:600c:198d:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-490c25baa0bmr347625775e9.14.1781012969042;
        Tue, 09 Jun 2026 06:49:29 -0700 (PDT)
X-Received: by 2002:a05:600c:198d:b0:490:9d1b:f086 with SMTP id 5b1f17b1804b1-490c25baa0bmr347625035e9.14.1781012968602;
        Tue, 09 Jun 2026 06:49:28 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc23394asm480555685e9.0.2026.06.09.06.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:49:28 -0700 (PDT)
Message-ID: <dcd35c42-3aae-4ba2-bd84-4af08467b2fc@redhat.com>
Date: Tue, 9 Jun 2026 15:49:25 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: mana: Add Interrupt Moderation support
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, Simon Horman
 <horms@kernel.org>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Aditya Garg <gargaditya@linux.microsoft.com>, Kees Cook <kees@kernel.org>,
 Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: paulros@microsoft.com
References: <20260604234211.2056341-1-haiyangz@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260604234211.2056341-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22018-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kotaranov@microsoft.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:kees@kernel.org,m:leitao@debian.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FED8660BFE

On 6/5/26 1:41 AM, Haiyang Zhang wrote:
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index db14357d3732..b1e0c444f414 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1551,6 +1551,9 @@ int mana_create_wq_obj(struct mana_port_context *apc,
>  
>  	mana_gd_init_req_hdr(&req.hdr, MANA_CREATE_WQ_OBJ,
>  			     sizeof(req), sizeof(resp));
> +
> +	req.hdr.req.msg_version = GDMA_MESSAGE_V3;
> +	req.hdr.resp.msg_version = GDMA_MESSAGE_V2;

Sashiko noted the above cold break initialization on older firmware:

https://sashiko.dev/#/patchset/20260604234211.2056341-1-haiyangz%40linux.microsoft.com

[...]
> +static void mana_update_rx_dim(struct mana_cq *cq)
> +{
> +	struct mana_port_context *apc = netdev_priv(cq->rxq->ndev);
> +	struct mana_rxq *rxq = cq->rxq;
> +	struct dim_sample dim_sample = {};

Minor nit: please fix the variable declaration order above. Other
occurrences below.

[...]
> @@ -440,17 +474,94 @@ static int mana_set_coalesce(struct net_device *ndev,
>  		return -EINVAL;
>  	}
>  
> -	saved_cqe_coalescing_enable = apc->cqe_coalescing_enable;
> +	if (ec->rx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX ||
> +	    ec->tx_coalesce_usecs > MANA_INTR_MODR_USEC_MAX) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "coalesce usecs must be <= %lu",
> +				   MANA_INTR_MODR_USEC_MAX);
> +		return -EINVAL;
> +	}
> +
> +	if (ec->rx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX ||
> +	    ec->tx_max_coalesced_frames > MANA_INTR_MODR_COMP_MAX) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "coalesce frames must be <= %lu",
> +				   MANA_INTR_MODR_COMP_MAX);
> +		return -EINVAL;
> +	}
> +
> +	if (ec->rx_coalesce_usecs != apc->intr_modr_rx_usec ||
> +	    ec->rx_max_coalesced_frames != apc->intr_modr_rx_comp ||
> +	    ec->tx_coalesce_usecs != apc->intr_modr_tx_usec ||
> +	    ec->tx_max_coalesced_frames != apc->intr_modr_tx_comp)
> +		modr_changed = true;
> +
> +	saved.intr_modr_rx_usec = apc->intr_modr_rx_usec;
> +	saved.intr_modr_rx_comp = apc->intr_modr_rx_comp;
> +	saved.intr_modr_tx_usec = apc->intr_modr_tx_usec;
> +	saved.intr_modr_tx_comp = apc->intr_modr_tx_comp;
> +
> +	apc->intr_modr_rx_usec = ec->rx_coalesce_usecs;
> +	apc->intr_modr_rx_comp = ec->rx_max_coalesced_frames;
> +	apc->intr_modr_tx_usec = ec->tx_coalesce_usecs;
> +	apc->intr_modr_tx_comp = ec->tx_max_coalesced_frames;
> +
> +	if (!!ec->use_adaptive_rx_coalesce != apc->rx_dim_enabled ||
> +	    !!ec->use_adaptive_tx_coalesce != apc->tx_dim_enabled)
> +		dim_changed = true;
> +
> +	saved.rx_dim_enabled = apc->rx_dim_enabled;
> +	saved.tx_dim_enabled = apc->tx_dim_enabled;
> +	apc->rx_dim_enabled = !!ec->use_adaptive_rx_coalesce;
> +	apc->tx_dim_enabled = !!ec->use_adaptive_tx_coalesce;
> +
> +	saved.cqe_coalescing_enable = apc->cqe_coalescing_enable;
>  	apc->cqe_coalescing_enable =
>  		kernel_coal->rx_cqe_frames == MANA_RXCOMP_OOB_NUM_PPI;
>  
>  	if (!apc->port_is_up)
>  		return 0;
>  
> -	err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
> -	if (err)
> -		apc->cqe_coalescing_enable = saved_cqe_coalescing_enable;
> +	if (apc->cqe_coalescing_enable != saved.cqe_coalescing_enable &&
> +	    !modr_changed && !dim_changed) {
> +		/* If only CQE coalescing setting is changed, we can just update
> +		 * RSS configuration.
> +		 */
> +		err = mana_config_rss(apc, TRI_STATE_TRUE, false, false);
> +		if (err) {
> +			netdev_err(ndev, "Change CQE coalescing failed: %d\n",
> +				   err);
> +			apc->cqe_coalescing_enable =
> +				saved.cqe_coalescing_enable;
> +			return err;
> +		}
> +		return 0;
> +	}
> +
> +	if (modr_changed || dim_changed) {
> +		err = mana_detach(ndev, false);
> +		if (err) {
> +			netdev_err(ndev, "mana_detach failed: %d\n", err);
> +			goto restore_modr;
> +		}
> +
> +		err = mana_attach(ndev);
> +		if (err) {
> +			netdev_err(ndev, "mana_attach failed: %d\n", err);
> +			goto restore_modr;
> +		}

You should try hard to avoid this sequence: if mana_attach fails,
mana_set_coalesce() will leave the NIC unexpectedly down.

/P


