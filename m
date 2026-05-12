Return-Path: <linux-rdma+bounces-20510-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC/TJAlzA2q55wEAu9opvQ
	(envelope-from <linux-rdma+bounces-20510-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:35:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6083527D2D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A66AA3075CE9
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9229839A06B;
	Tue, 12 May 2026 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NHhXD1Rn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC4D3955C2
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610571; cv=none; b=JtstVyrDwCYrDkQdTANyJqOaBEyEgLDe8CwyjaF5sBNikcZg94eYgFxRaAbmCH9IFTQN6YDGI2PZp+2RaTInJNkjOZPa+2G5JxaKX/gFnaTQfeGCp/1K1XLhYUnAiqih4mcerGE+NEw4R9Tz9D8QmpjTQKIMLZuRb5d9MUjz7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610571; c=relaxed/simple;
	bh=w9Hc1EPyFzj+XH6DKzDbE43/sYxsUqh9fF0K2TqZ2V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9/GaLzB4NM4WaLAFFjnf+IOyUzaOjE4c4rNyaghs5oXOWEgyUpxX2FBySbTj/hK3FkyeftjI3R34iqDi00ucrr/Hf0pUqqQg/Hu4eDnCfNlpUruWh8xh0RpgfLxLkioXXVAUBbbYZsns2ZZta/PGOLS4IqtW5kG3cx+yl9rMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NHhXD1Rn; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-90ca6f20872so147164185a.0
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778610569; x=1779215369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7BCpgMofwSJ5yvQQ6LPUDAgir8kZPfmU3ooJEW6RrM=;
        b=NHhXD1Rnp42C081Ci8xkluEYIp2mZsCaD4yawBQO0nxSobpMj2FRqFTijwy01kppL8
         SLyC4ThcSu8a3lpOq7jzMC1TXBQZbxCILh+HlSiZiQi0PiepBgPjxJTcShmr8M+jZ/ot
         /3iy8WEBuyyIWWkRQ6kFTVusglziQV4AL5e6zDmEid0h7sDTJ5kUKKBRoxvtQPhvBwEO
         YgffE5eODe+pws/Ug/cvPObl1i30JSzlNNRL3Vt8u3aGI5x6D/9A72Mr1hzd96CJZEwZ
         4a2ZkgDBUpecRONhvCXK1lR9ZFjez6sXiwl4/S21RE4bAoePr4lG+Y2n8/zBXL2NBAlz
         4oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610569; x=1779215369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7BCpgMofwSJ5yvQQ6LPUDAgir8kZPfmU3ooJEW6RrM=;
        b=MHYM4/87FkobtadGYmm3s52JLV8FIl69fwH0hYnz453jUliB+8Agv0hUXPE900zpuk
         maTPEoYUijK6dDziGTkg1hHYhktgH/fwk+imxVQYucZNLxV0RZ2EGf81/MSYYksWVXWJ
         z2CQhDSqMuJ32mh8OgNz0Q4G+MPF8q7Vuca9h2iF0mvwN5ff70GMtw0sUPemn98ephHK
         8jd7h0t3jCeIjxrznBYZvLaMulbN6v+qcj9O+nv6rnX3uZJg1ewHcVglQ6MBNgnuWhiJ
         62Wlh2sLawUaGXqYMwj+gFcNtSZ5XRrzYgWPpg4cscywJLImAjhYw7y9GbclZzehBq28
         Emww==
X-Gm-Message-State: AOJu0YwZ3fv5YtKMoeXBQblpOIZ+8yyS3hTlwDN9QL4IZUBdarai2dpU
	hjHIz4nLt+7mH7fJxutMx01TC+q3aofAY2lvJmm7TwGAoJoK5hNQclFPyhIxdjGcdOo=
X-Gm-Gg: Acq92OFb9BgZ/eFHSD5fci9mt0AcKZ3APA1l3NQz4Xx7FNkmhwDPNWMqYAUkiuWiGkS
	ksRUJ7m9F/fHo1mgpUfvvm5C76q8QXOyQ/TWqTmUWgE64m0LzKcO3ac67dBAz+HlUeRZlusPiXh
	HoyPXkHx6eflryI3xK94JounlP8chRt8fxGyhNCTlB9cKaHYYmBIbTrYlMTUBK508HwNkz+OEB5
	V3p2l2xCCdL0z5+vO6+G2cOrRUkwL0RpEV95Zd4fNUdtg+oq/ms8RdbPjxbmuK7lN3Sn0XcFm1L
	gG9evbDYSKRuobMfE0baXcZGFTgsZhTuBt8TjAKihPkli2ZQvG/2m2CTpY8M4h99Gbzo4SnY7fJ
	mwFEzBK+IyfCxMg14f7w/PGK26um2HMnUihkDTuZz1mcbkrzHIeO3mexjdbSzT89habDyNYsprd
	RMUouRt+teQNpPMiSE6kIqRjYlTopghB8NH15B+ANmed9UBhoNUXj57McJcqVcnuJyiryXIMeyT
	mQcow==
X-Received: by 2002:a05:620a:3948:b0:8cd:8e8a:3584 with SMTP id af79cd13be357-90f7ff0db37mr35729585a.11.1778610568646;
        Tue, 12 May 2026 11:29:28 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b986c371sm1397312985a.2.2026.05.12.11.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:29:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMrrD-00000000n2G-2UXw;
	Tue, 12 May 2026 15:29:27 -0300
Date: Tue, 12 May 2026 15:29:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 11/16] RDMA/mlx4: Use ib_umem_get_cq_buf()
 for user CQ buffer
Message-ID: <20260512182927.GJ7702@ziepe.ca>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-12-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507125231.2950751-12-jiri@resnulli.us>
X-Rspamd-Queue-Id: A6083527D2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20510-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 02:52:26PM +0200, Jiri Pirko wrote:
> +	cq->umem = ib_umem_get_cq_buf(&dev->ib_dev, udata, entries * cqe_size,
> +				      IB_ACCESS_LOCAL_WRITE);
> +	if (IS_ERR(cq->umem)) {
> +		err = PTR_ERR(cq->umem);
>  		goto err_cq;
>  	}
> +	if (cq->umem) {
> +		if (dev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_SW_CQ_INIT) {
> +			err = -EOPNOTSUPP;
> +			goto err_umem;

Huh. this is getting pretty hacky.. The driver wants to memset the
user buf to 0xcc for some reason, and it already has a nice flow that
if that fails it tells the FW it fails and presumably is Ok.

The issue is it passes buf_addr around insead of having made an
ib_umem_memset() (which can reject dmabuf).

Looks easy enough, change sg_zero_buffer() to sg_fill_buffer() to
accept the 0xcc, ib_umem_memset() trivially calls it, remove the
buf_addr from the call chain, directly use the umem in the
mlx4_init_user_cqes(), remove the if above, use the
ib_umem_get_cq_buf_or_va() in the driver..

Leaving it like this just means the driver won't work with the new
uAPI with normal VA which is not desirable..

Jason

