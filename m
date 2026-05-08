Return-Path: <linux-rdma+bounces-20250-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOhJMLv7/WkdlgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20250-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 17:05:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C53BA4F8498
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 17:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3452230322B8
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C1B3FB7E9;
	Fri,  8 May 2026 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtvgRmfN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E65E3FB077
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252515; cv=none; b=XGq815XlqibH8rrF+IuU3aG4TCRtWyMZojU1Oou54wo8+xFCIUTRRceXB5pNWAvLGJgTJw+6JlcAceUfuPKVjyGhnEye0vnwO9nVnfk0WGexU51jnM6v+AubXAezqMeDWYGuFYHoQI8GbLYlspsifKTFPwPy+K3Bmnj/DIEw0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252515; c=relaxed/simple;
	bh=d9whpuIEMfnGfHXELXi5THs3ikD/M+a2M1VvwY0qAIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYxVMWZbjAvvmOrqvFlGOAWyhjQmDS4a+lmW8uekNYuOWhby3QA0lHYmP/eScRW00YTbwE2H2U7ASs1a9u76/d5LU2c0GXntNI2BSPbfmfxssaOS+PPXoh6yi4qd4p1bsZWrRHzF7oc7Dww8sx8ZPUvy7pJhZJeB8SkE1ta+uCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtvgRmfN; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso1056528b3a.0
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 08:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252514; x=1778857314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4IgYMYGpVzi0WUd6069NetUOnbBf7yLrDGRB7C9U8+o=;
        b=WtvgRmfNtVaJWb1dPvdW9jp6oi3NamOj4+9P48ymK+bqqRyouUpdPTrba/wLO+tjNO
         4AhSo5jbYrbhQdyezHA4o0U+hMRAK+XfltKwW4LUQcQZNnWyWlRQO6Dz+Jl0e6mdY+q8
         izDrvlHHi3/hccRHk2waSpaSd25Q3m0d5aoSrwPzuqwmaZXK79xy8tkbQ0Gzkr6cAN5C
         HPRLW/VWqnPyLBLwEleEWC4aQ+pVuZgq39QtNNHoLVUK5VlxT3m4dH4wOl17sFPHicnl
         Hl07PCo9kN5Ir1Rp7QNaR9RlTj8cbmEnXTC8D/+U2eNawBuCdA7gziEWV45+c0zOBbC1
         HW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252514; x=1778857314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IgYMYGpVzi0WUd6069NetUOnbBf7yLrDGRB7C9U8+o=;
        b=cboJdOOcyVijMzpC83Tfx+F6UrqBCZNZeGt7zF9AEV910GlJHmxOfr6R7BVx9FqdOY
         Fh9d1+Wn5wO0Y4WXvKSJjlp1hol7ytRxX1DZiGAII1mK5he36B/QRw8bWR8TNoX3s/Vv
         2dBhlNS8lGa52SgSL/eHaYZwOul7woXylSokXCyhH8kyBFxUGiUG22/NpRoXp5vkbP2g
         fwZFbUmU5d/LZ1k+T3ZdKvQhTZNJWQZCpXSsXHx7jAPM5mIuDE6JUngqwiwG1EuDVZ6p
         Q2uGK3EMY9jewuIogLDyhXHghkZ1KY7BsJ7ajdV2baye8DxsIydyIoqzWaX+jCbY+Zn5
         FMSg==
X-Forwarded-Encrypted: i=1; AFNElJ+TeKQySXEZdfH6d3lYx+c7DXXw6WGTr7RI3lX8/wefoTPqHgHfOReGwKA707++kZ285MBO4TecrWIA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6o8OfSB/2YU9917WUSrJLeAYMdEFwF/d3RulfzgSRcKL2VtNW
	GVkCEQ0hcIMskAuaccAmSPqobb9gkDRw6SJ1upp4ktwSbxTHdmZEBnvB
X-Gm-Gg: Acq92OFMPvgdGclmwuAoOc3K84Aa5dD2EiZqmfi+exILQSUhHU/04DZxN+783dr5MR3
	09F5jv5RuOx8fdziReRtdsLVlY+Qup4EAE67VPgvs7O6Xfg0PwVejeIvx43KGDCPhsJdlM05Y/j
	o5p1LFqvXC5NDEO74FCTS5tkK/+yMmr5j+p2mC1fpCiR7gKcgypnN1oD28/ckOTxJ4bErmpMrRW
	AwjZMwgh+KyY3ImUwQZQkqHrWEyS7p2oxZipda7MV8UVFhPIdPR9oxVyEx9RN5a7QEHvdrdPFJ5
	3RzTDttXGTpU5SmT+9Kz5okXn+JN7bP6QgCMIoOlkOKzHUItTYboZuBCX+Pqq4yYzmiz7CfxJBg
	50typg6VjCCRj2uqueRA0cDMOaQe+YFqBKRyxaE9vAghNfleI3nTRQaQLGAHHCIi3r8JqzEVAw0
	m8c86lmOGDWvtbCjYM
X-Received: by 2002:a05:6a00:4b54:b0:835:51fd:b7ea with SMTP id d2e1a72fcca58-83bb7cb6c8emr5917960b3a.19.1778252513119;
        Fri, 08 May 2026 08:01:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c1bsm15730006b3a.34.2026.05.08.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:01:52 -0700 (PDT)
Date: Fri, 8 May 2026 08:01:51 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 5/8] selftests: drv-net: make attr
 _nk_guest_ifname public
Message-ID: <af362BZdBFooC4mH@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-5-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-5-52821445867c@meta.com>
X-Rspamd-Queue-Id: C53BA4F8498
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20250-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fomichev.me:email,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Action: no action

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Subsequent patches will use the _nk_guest_ifname as a public attr for
> setting up devmem. Rename to nk_guest_ifname to avoid angering the
> linter about the '_' prefix being used for a non-private attr.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

