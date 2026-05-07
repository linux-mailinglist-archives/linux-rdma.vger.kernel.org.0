Return-Path: <linux-rdma+bounces-20171-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGkoHp6y/GnlSgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20171-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:41:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1997C4EB3DE
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 17:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77D1F303A119
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BB239098C;
	Thu,  7 May 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lELMVwd2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAE3EE1C4
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168347; cv=none; b=QI4Ooy/BBQfKlS4U9lbz8N6uU4s1gapnEuu6mGdJy4dclM/c0KX5UDToEFAdAF5iq5TGh4EPvbOgjbG4FUq8pbkwIEcruYKCoxC5pU0xDl1qvovBW6iRe8pB62o7wCkGDbCnRGf3yOI5fjAWZlOdAzReC2fNgYMDGoa/lkKAoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168347; c=relaxed/simple;
	bh=I7bHVcUPCbFavnPQE9NIAPWTbSlQISkdMWu7R9FX+Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZvYyCAF6QpVe6qR97mZIJ/ddFWd584bJbFN/tyoXrEemgOCH7JIQ4cO1Mi5TnbZFojbRCDQjMhbzyVNsiHWvGwiWjOr4zcc0sKRTsqAGNfvMJCozqmIE5fJZ28bQxn6k1v/HcfBMc0V8JBjwEa3L3NBMP/IGDZIvdgdXB234uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lELMVwd2; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ee62a19730so112790285a.3
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778168344; x=1778773144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQASz0K9bAEWsvTANOg3uGMuZOgruzesi2JgdTAVAkE=;
        b=lELMVwd2v+v3Y2UjmN0rjzuYIZkTeRK8VqQUHf+rI68gGfgcG8NCRLWnzDSU7Ejg3a
         Fkw6my+S6bAF/4E4hCUawNWJPvhr1TNcPhPRWjqkvLDfn3aOBNptDGyNH86WSvyJo283
         sWtpk53zfbttBN4gwE+xdhjPtewc4RWBahS89D/lN22YvuzFwhbBxwkjAQV+wl+AgeCk
         lXNzb4qXqs00gTDv0uytVS0ClClxoEGzxVnEniq0d3y4Gw9GHs0fmfn66iThHtOpR7TJ
         l3wCy1J1YODPtn2r0c+N3ZstW4mN3WeMU4SFG3zlY2trp4eE2dESUXTSK8mMG8ZRqvme
         3PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168344; x=1778773144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQASz0K9bAEWsvTANOg3uGMuZOgruzesi2JgdTAVAkE=;
        b=cRIKb5/Bv/zy84sWgKAqL65CicIwTrFcTnNr0FX5kqEoETklW7cjjIUO/LW/tBhDgM
         wPRP2KghHI+9smmJfpoNuzwjS6NfSAI+cwowzU0zyWPbejFw7i4P5EIYnGTiCXxmWUgm
         owd2x4I9/A2Pu+OKNuU+NszU0+xXMXy/mBpq1CIQevTR6QENh6YCWqqTvIZSWdpNaX4O
         8Dr2WWo6jOKP8H8uxC1jNgog9IAl9ID7wkmeQ8Kz3v3rLPQUd08FLjN36RTzhBcadwCc
         /fZp6D8ekkjWDOUpZD8ZgQ2fBHI0camc9RpERum8oVQzC0V+Ry4bdM/sgEvSuljkStcW
         gbNQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ZRVCl3NCvZ1YlkTEKlptjVYqmccErB8GOIHwGvbTGREJh67M3bGX5WsLUu8InZYMqtXzgPwbPyxCr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzao2vjWnJGt8Af2mo8nOAqgsCBpuxLEUfeHF/YE0KWCx3zZSLZ
	Q1s2hjra+rniuXLTS/g26b0GrQY0eFfBATtsBTBbLCx74rVqlsiQi5k3
X-Gm-Gg: AeBDies6BWNF4216kd0CLY1ePD7cqVq+fiYLN+AuE9JA8Q6B9CX+JYtaVkiQ936iJy7
	Iw+EdIJWlicIRhcLE95dSRvGNQSb4SgXixIqSgZv8Q+QwkCPF1ZJkrcTOy5bBQ6NZPgNO0BazwZ
	V1bmTKG/IWxbXM8LjZfvmQiEZdicQEoghS4AGRAeBT0b728TdRnBEFa7A5rwaKAXhUWOgXkIOOc
	zxiIQ/28rT0lU2lYBHeKw+HSf1IXXm4ET95/2EHfdeeAjMegpBuqOf7+kCgiTg6MvAHBqKl1jqQ
	w6fDfZldZCrJSlJ2MJxiQn9YijJg0bCna7JeQ5T5Z1zIcZjsqQUdEooAR5Ajf1mxKd0tpXI4EkI
	lwn2ttvKOiETmHKnbovLtpMi5I2CgbifSD6z0KuOzrYO1uL9YU4nbHmqIip/43A1yPPamkjhY9W
	AUDkeARFS8WlebrL8z+iUdMqeND46vaRKrgaxyRzzSF69Zcdm2WMWETqwJpA==
X-Received: by 2002:a05:620a:440f:b0:8ed:11b9:1ecb with SMTP id af79cd13be357-904d4b58929mr1205520185a.20.1778168344205;
        Thu, 07 May 2026 08:39:04 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:13::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc293837b5sm2153539785a.10.2026.05.07.08.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:39:02 -0700 (PDT)
Date: Thu, 7 May 2026 08:38:56 -0700
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
Subject: Re: [PATCH net-next v2 2/6] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <afyyEJNbrBem8igi@devvm29614.prn0.facebook.com>
References: <20260504-tcp-dm-netkit-v2-0-56d52ac72fd4@meta.com>
 <20260504-tcp-dm-netkit-v2-2-56d52ac72fd4@meta.com>
 <20260506193420.575e1806@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506193420.575e1806@kernel.org>
X-Rspamd-Queue-Id: 1997C4EB3DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-20171-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm29614.prn0.facebook.com:mid]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 07:34:20PM -0700, Jakub Kicinski wrote:
> On Mon, 04 May 2026 17:27:49 -0700 Bobby Eshleman wrote:
> > +	if (bind_dev != netdev)
> > +		netdev_lock(bind_dev);
> > +	dma_dev = netdev_queue_get_dma_dev(bind_dev, 0, NETDEV_QUEUE_TYPE_TX);
> > +	if (bind_dev != netdev)
> > +		netdev_unlock(bind_dev);
> > +	binding = net_devmem_bind_dmabuf(bind_dev,
> > +					 bind_dev != netdev ? netdev : NULL,
> > +					 dma_dev, DMA_TO_DEVICE, dmabuf_fd,
> > +					 priv, info->extack);
> 
> Not sure if it matters but are we intentionally releasing the bind_dev
> lock before calling net_devmem_bind_dmabuf() ? Previously more code here
> was covered by the physical netdev's lock.

True, lock needs to be held at least until after binding. I have this
fixed in the next rev.

Best,
Bobby

