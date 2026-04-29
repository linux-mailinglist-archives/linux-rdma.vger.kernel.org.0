Return-Path: <linux-rdma+bounces-19739-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M9OJZkj8mmOoQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19739-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 17:28:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B543D496E27
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 17:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9EB43051C4A
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 15:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D3C3783CC;
	Wed, 29 Apr 2026 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7iJCGba"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D437756A
	for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475916; cv=none; b=ZGtK+4mc12dvNVkZCIA1GDFXBS8MXAP60MjX5Te2++9MUmQd1ggkPqDma6N84S/XAXOJIZ0fXaRfC367G9Wq1be+9lYV7eFK2zpOrp5hbShjxdUwH+31yKyTGjO3pcQiVwov/f6i2CRaHEtCEldETanbjHA6UEcX49xSXsZugrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475916; c=relaxed/simple;
	bh=/BimwSCUsuashVXwD+dzxd+4t5G8fzzhA6oBT4Cnlr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo5iaWcoTesBvzHuiMNDQjPCJd/qgw5YHjxHi9easbt9hkMSdCTLjHaLLnx/iLVydPcdqggO+zPCqAWzuBhKoQDR8dXJmp/ia+mI35FJt7c5n66uHk9dCTgQm+2YRZsPE1kvuecWlnK8Iv23XC/EqUNl+xeNjgha/rzOTsQKq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7iJCGba; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7dbd23bc684so7133166a34.2
        for <linux-rdma@vger.kernel.org>; Wed, 29 Apr 2026 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777475913; x=1778080713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hCAZnYdZvdp+ak79vsUFUwhsK90OGnLnVC3WYq76N8=;
        b=b7iJCGbaNlXtp4X0g6/WayFeLAL1bJl7AXsejxs7Gg1yd3+tXxfLCqVRJ6zgl+87Ty
         AzkjBbmGxQXA5dPHLvzunpTs8WxAQ7r7BYtmSYzNn8xmKooUmrYgvDByEfrGR9oMNHST
         6CYlQCxvgSVqcxF4KUQH1q7M9m7OjIWYp2+HxRh/LoRPURMvrEgXRK9WNLNlB7BsykRX
         Pmu2UsOH9F8ek8o5h+A7RETSgO/zEg5diwBo2XSltxub7IYnetVfLLiar8QOKiuubRSR
         mVR2pcvukrXZxLDMZLKOgq8uo+utneT0SkFkFgAMAA8W5wNs+4wTTLLdIaYkjcrXUpMc
         ExWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475913; x=1778080713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hCAZnYdZvdp+ak79vsUFUwhsK90OGnLnVC3WYq76N8=;
        b=hmdqpYCpWwf8sNqK3zwBHfzBYoNuHvTJGLNDTXCz0+OoDjYjHV0IF3+FZ8wzgg6fdX
         6M6yudZjwn6Fl7JVqY/TYeXY2HxKP1E+ZRSRZrXC0PQU0I9RWuarDbZfdT+nahjVdzhY
         syy7t9yOkuyeieQIpHdwBvdvbZ4O8QkaSK0zSsl5oDjevIGqizRdaD4qsAs/kVSmylQ5
         kZIawa8nlfproTB6cmNSZjc8D+WeH/hM8/RO5kbf7Vcfy0gWP2V1KLmBGgF89RsjlFUD
         X9HwDyIGXyPcXst4etgTEanXSSY8SsBQUbkAZWObp5/Kmke8Si/ZxiDRk+HdftzLdAEN
         qC9Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Hb30zG+rwiQQQGknH3Uwd/S03+McrrBE/8JyoY/SbqXZRy0C3oDqyPBjPazO6ZdfsPzLCgu6ZDQ45@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/wiPAKN0KXT4PM/ehFxm0O4pZsr5H5FLzFmsuWTlOrhOJJKzh
	+hLtzi0jUe/F19S9aF3uEnrv/LBKpw+HajmM6BQVKa21duExnBoktd2T
X-Gm-Gg: AeBDiesnnoPuFd7vOMWc+j78zWyx22A3GxNBVay+UvXE3qUyf3xvwfrayKKxxiX8MRM
	QRAUwBmiAjqb8zooT5pqlsU29dYFhTJDH9KHkeUIY1NLA4otLnxHdehBoxGCzRCHzwtEYkDqOgS
	4vv02CpjftcESX+DC8GtVIWx3fsHVPQYaH8oo6EbX8XuT26kRrdOh/tMXVOvn1B87kmOWLZd4Wl
	N/ryh81pfLkfocxiCK5h8fAfcWm2bqcJopguzLvSm++HJ1YpQYV/OLPocg/wmCmwBQPo3NIFAsv
	WBCs7gCx8kLDFQM7Qcxd/2ctbx0A49SpZ6PPhP0MZdCpx/J/3FjaklpSVVGCiu/C9w54Ov2wc+H
	qXHdfRPAtHXiyyhHrwfmyCjoQmlk1ZAk6ujJjGgDZasDqzhH94e0jsnDCv9iTkBaeTjTwgK8HDu
	GjIcjGuG048buFK3Rx/SPW4MJDcis55J+WyUH6eLrb9Y4c1lgcG1Ik+zcNBw==
X-Received: by 2002:a05:6830:25d1:b0:7dc:da80:42b4 with SMTP id 46e09a7af769-7de9a1002c7mr4284996a34.24.1777475913099;
        Wed, 29 Apr 2026 08:18:33 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f812:6a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deab99036asm1469135a34.17.2026.04.29.08.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:18:32 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:18:23 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, David Wei <dw@davidwei.uk>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 00/11] net: devmem: support devmem with netkit
 devices
Message-ID: <afIhP5dtlzCtzn1T@devvm29614.prn0.facebook.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
 <f954a636-4d21-47c0-8afa-cc4b24adb0fb@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f954a636-4d21-47c0-8afa-cc4b24adb0fb@iogearbox.net>
X-Rspamd-Queue-Id: B543D496E27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19739-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devvm29614.prn0.facebook.com:mid]

On Wed, Apr 29, 2026 at 02:08:31PM +0200, Daniel Borkmann wrote:
> Hi Bobby,
> 
> On 4/29/26 12:41 AM, Bobby Eshleman wrote:
> > This series enables TCP devmem TX through netkit devices.
> > 
> > Netkit now supports queue leasing. A physical NIC's RX queue can be
> > leased to a netkit guest interface inside a container namespace. This
> > gives the container a devmem-capable data path on the RX side (bind-rx,
> > etc...). On the TX side, the container process binds to its netkit guest
> > interface and sends traffic that netkit redirects (via BPF or ip
> > forwarding) to the physical NIC for DMA.
> [...]
> Thanks for working on this, after the RX queue leasing got merged, I've
> been looking into the same actually. :)
> 
> I think the NETMEM_TX_* enum approach seems reasonable.
> 
> What I have a PoC on is to build out TX queue leasing as first-class
> symmetric infrastructure to complement the RX queue leasing - basically
> I implemented an equivalent to the latter in netdev_nl_queue_create_doit
> et al, so you can have independent RX and TX leases and per-queue
> accountability, such that ynl queue-get op shows the full picture, and
> lastly we could also enable AF_XDP TX-only support through this infra.
> 
> Would you be open to collab on integrating both and migrating the devmem
> code to work off an TX queue object? Next week is LSF/MM/BPF, are you
> there by any chance to catch up in person?
> 

Hey Daniel,

Definitely am open to that. I will unfortunately not be at LSF/MM/BPF,
but maybe we can schedule a meeting offline to sync up?

On the approach, explicit TX queue leasing sounds like a better way to
permit devmem's tx binding than implicitly via RX lease.

Best,
Bobby

