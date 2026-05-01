Return-Path: <linux-rdma+bounces-19817-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKE8J+D882nK9QEAu9opvQ
	(envelope-from <linux-rdma+bounces-19817-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 03:07:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E45E94A9765
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 03:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4D87301BF56
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 01:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEF2299923;
	Fri,  1 May 2026 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJOX65wu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD917285C9D
	for <linux-rdma@vger.kernel.org>; Fri,  1 May 2026 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597657; cv=none; b=qICL/CzybV1bQaXY618hR8GzCxKY9EzFCXZbyR4vGmjlZv7PsUYQJzWYz0ArcK9wqL769Kr5i+VGruh5pdghDcw29+HKOlsbXbiIDdqN3R1Jdj7hAamiWuxBC/1FWaXd1CPPQwPElkm4cBM+K4Ng7xSIL6+b7MuTgUITIlvJFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597657; c=relaxed/simple;
	bh=bzjWLrIg2CCN3/hGH9Hbm2IFgPMgmGCzp/tnDAxT9M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr/b9gn7727imzX8EudIkyceh0djZZRAEhxN4kFOEb+ZETCJWTzqcG4nC+MUlAhqJjxveFaJ3LeYJ/wwTmlZP6tcbIcqpEJHHLmdLrvG/+h02QBxyszty66VJ0FoBNT8HS9cKyMXB/2jVOrpgf6xp1chvkmOyJ6/vNIN2ObAKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJOX65wu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8d65f4073bfso192619485a.3
        for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 18:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777597655; x=1778202455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=luFHJPJpmJJ6ifj+D224jn0aiIzHHo2nBsB+na/dGdA=;
        b=MJOX65wufmDQeqKx+vwHw03RyQT9lsJPsjLW7k/6ZLPq7CxaUZ7dTyBDlybRSduKLt
         dFq1nfTiOJgS9d1B7nARYKb0jiG4jV38iFuIwRB7CGF+f25SuuUGfbEVBAvyuHokZUsU
         iONNlx8TjiehBmGif707jRp0OG3Ty5PjBQI9A8zvsUzVleaBlXNGgUdi/8xS5e52RVsQ
         zIcREcDAbNqGZr2LFax8rYh0SK+CyFwQzavB//8J+pEvYkkRKpdW0ARUFubew0zHL6K9
         Cp7RvW9yO+Mzz/qLvFRktTAPrzBGY+X6tFN7yj743axJJ5szrzSkaNkOLQvoIDIppYcj
         xxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777597655; x=1778202455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luFHJPJpmJJ6ifj+D224jn0aiIzHHo2nBsB+na/dGdA=;
        b=BJdlg1K98XU1dvpEVmg+a0iDAKTxombxvz+mpX1z/DhELQ0QvBcYMjT0o7x9A0m2xn
         DGtR8pJ2KEU8C3e6A36hwDo5DsXSRau0/541BAsvOyA6KplFuZepkeFMLPBBg3Awp6r0
         1vvcEA+F63jiPEJY65vEtA9hfLAiF9BUPeqA5g4k6c7fM2/PCxL67QJ5UOifjV0JH9JI
         /auUqlmDoMYuE3H4VpzpDcd4JRlA8wHRzzitWpbFe0/UFDUaY2YoigvIvee5kGDlmyza
         hRwLuaQ3waT/I4yY9HLKMhrr4MEOJva/voLtgd/DkJPLwOF36DTRdDLqy17g3Ku7T5vE
         HveQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bqToNpPnGYBpEDz5rPv0q790ItNBhOHkg6PiDoqpnbKgJZBp0AoaQ7EADCvxEsXViPL99cfMx4nwa@vger.kernel.org
X-Gm-Message-State: AOJu0YxLq62oM43xYwYwChMeErcieWXLLvxu/qzNjpRX1Wyv6tee9/63
	+1tBul6DGvdB4NtTmeULcTT1AuC9FS4ezIu2wR8fEqrVV4Sm3SztYDWG
X-Gm-Gg: AeBDiesBkKKUYXWOMjH3gv6piSQ7a5KlbsLKMvOUCnzc7a1BFxY49N4CuNThVZdl51q
	EzYgbNj0u0Km4cp+szvwSFlncYswUnqbyQ+ieGdlmlKUo4FxRsxcNT+mZKNfUiDaXaQpFWt3gxc
	brohTsUX6i11tRs+s5CGGftni2fWMpiKi/TpZ5SAGo7wywYlyMkGBo9eAiH/ifin4M4g53luQ67
	j8xMPde4saAsuNsdSTF8QbWm3o6hNGfa8R1J9fazEBF7qo3m7Om7UekAevY/kAJr2rxCoz/Fbao
	vIQKt0BP43YfcodnG9EWVjNhHAML/7HTQabcxQMncY5Vj/UiX92VboCA+cHRU/xGDgNV3Zd4yQK
	OinT4sDpSrzHMs50HSIlhXbEojYwZ/1eeJGzUurbiJQF/6JemY24qwKWIxOwJxjGMtEfEWeEJvD
	2AHTsF5P/4HZTP2jJ9M8Dk3Z7x4BC3jgC8Yk25P0pSv7+e+pctM731vzVNCP+OcpHIIVIP
X-Received: by 2002:a05:620a:469f:b0:8ee:e011:a77a with SMTP id af79cd13be357-8fa863df021mr885936585a.13.1777597654699;
        Thu, 30 Apr 2026 18:07:34 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f814:17::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c253264sm18485785a.22.2026.04.30.18.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:07:34 -0700 (PDT)
Date: Thu, 30 Apr 2026 18:07:28 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 07/11] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <afP80MVBJSYJQTx/@devvm29614.prn0.facebook.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
 <20260428-tcp-dm-netkit-v1-7-719280eba4d2@meta.com>
 <20260430175724.0c134a0d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430175724.0c134a0d@kernel.org>
X-Rspamd-Queue-Id: E45E94A9765
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19817-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm29614.prn0.facebook.com:mid]

On Thu, Apr 30, 2026 at 05:57:24PM -0700, Jakub Kicinski wrote:
> On Tue, 28 Apr 2026 15:42:04 -0700 Bobby Eshleman wrote:
> >  	shinfo = skb_shinfo(skb);
> > +	if (shinfo->nr_frags == 0)
> > +		goto out;
> 
> Feels tempting to cover the NETMEM_TX_NO_DMA / NETMEM_TX_NONE
> cases here before we even look at the frags?

That sounds good to me (had considered it, but opted out cause I felt it
might look odd with the switch-case that follows). And I'll address the
bug(s) the model called out here/elsewhere too.

Thanks,
Bobby

> 
> > -	if (shinfo->nr_frags > 0) {
> > -		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
> > -		if (net_is_devmem_iov(niov) &&
> > -		    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
> > +	niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
> > +	if (!net_is_devmem_iov(niov))
> > +		goto out;
> > +
> > +	binding = net_devmem_iov_binding(niov);
> > +
> > +	switch (dev->netmem_tx) {
> > +	case NETMEM_TX_DMA:
> > +		if (READ_ONCE(binding->dev) != dev)
> >  			goto out_free;
> > +		break;
> > +	case NETMEM_TX_NO_DMA:
> > +		break;
> > +	default: /* NETMEM_TX_NONE */
> > +		goto out_free;
> >  	}

