Return-Path: <linux-rdma+bounces-20082-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEIJD39H+2lPYgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20082-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:51:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3743B4DB59B
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4052D301A08C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62AB3FB060;
	Wed,  6 May 2026 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RqTaMz4A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80B831A06C
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075504; cv=none; b=sfj4vRqWy/cxhsSr8440b7R3wykgoQGgds/hfSj8Zul6mZtNogZhs0yZ4MZmbg5dukYvQqWj6UTHc2BnCC6EjJbpbuK9Gx9QOFSaqqUqYayz/6+Y23D4JXo8LA7x8naYuNs/GxPty8dyqQ2r25P3Bu6AAJ5uYDzGBYFxQ31C16E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075504; c=relaxed/simple;
	bh=XL1uglHldtdxIps2O+U2fRKgc+LBR/5WFlMqOd5ljEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWPw/WBt1u8QwmWgKsV2fJa9JlcS0o1LB8N9DbvdZMSNa7EhXNTtxoPJGng8TMcc7lPlHisSQOfluDTlmmGQRvfwxnmhxwlQyV9ftMQ5Nk3fq9m76RnYQ2FIhqY4TsgiVqggc4GFlnxItjWVZDt4lLqrzuPoHd5GkuW3VgLH/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RqTaMz4A; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-441209fb77eso665623f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778075501; x=1778680301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d7qtWF50+co5ZjERp12L3F+UwdgxdSbe7OJfDtlRteE=;
        b=RqTaMz4AdsTeD9BQkpcZcnYqTBvzjJ+VazxwCwJE/S1ytgNWJAxUfSt+OxH2/SOa70
         akJbDR3bfNPiHNwVkUIojMMjw/c55jiYtl8BpkXMeIQLgapJ7/ypkvy36uvbzdZFj/Qh
         LS9Fr4YxOCxNySn2MxCIcxgalQLJ4JgpKmRPp6eZ61Pe5nIrBvF+oTzcP0ViI830XczC
         TE5sASMlWapfOJP8QABbhsuTlVa+rrT7b8SkMuH8H1TsPTyEafAJc42Jg8ggXRr+nXuT
         OiucYnwzLbL/6tN8cH6E/m2BFTvJLqP5/8xKw2yunraFIcRVU8bdOmy77UhQMzRllVpA
         C0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075501; x=1778680301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7qtWF50+co5ZjERp12L3F+UwdgxdSbe7OJfDtlRteE=;
        b=rTCCIvUmIZdN4EOSI3VZNiFpigsT4eSDP3lhW2p+U7nqJfnUvYLPdQm4IudreYybW3
         q5EOtM6cENed+EaD5MQsKBXWk9kdj2zCSlAMyXMUDHw+4RlGLF1SwehTjM8rsoCfBOi/
         nljvOZ7qKjepnG2GazyLcDth2lFQfi3N4PzdBOJbltF/AfGgU7eXHnPr+TETlLJzCd8U
         Uine7tisfI9fncIE7teE0vvySpIq9ILvm1xsuBCul4d1uBDIsHN62x87rYQCprFgMZr5
         wC30bsu7u4NVHPJo2+Gzq7MU88LJJG/dJmapS2vgYesR1R5Tmk39KpGSQcBjWxzmPH2V
         t08g==
X-Gm-Message-State: AOJu0YzPT9brvQ/Y2NOegrOQ6RJaI3JH6L91iYhbsW8Pu1O0nMeKNcTA
	X4wKlmGIXaX0x3EicHbpRuRENKjC7tWl3qNrUbIRnz+52A0ftfMwSrAPHebMDggavQQ=
X-Gm-Gg: AeBDievYwvla16z28/Hsr8gN1i4VE+BXqTuhvwouOXJrNZ8HgmE2X2vv6UZQA8NcQvl
	tCkFWhrm3KmVp54eOITmTRLRU5Q94FPCCn4RsJDN5FO/903NoqsZUnH2lWCKdVkEa/s/vTqzrEN
	P3fLzg9eLuZQSsCJ0PJ1HY+Qh1ADyvhT4FtUcySqTRBL/YBoQjCag8uMcp+kbDlm7L74zJzDjei
	CGQnjdhEPKvWPNtb8R0tqIBZe2vYiqxnPeDOqgK1bP1CB2GZxunwwueWObPO8vmp+qCDNLdUvly
	AxfN9bVgXsNI4VuOpoe0kNRtra/VLWlHCXUFR2DIzf0qBSZLP3+6GG8BUpMQfzOiWkm7FF8o06M
	KxL9PYPXiVgZ8QCNtz2Kow2K4iDKX/h7Bgfe64/Cnmlh+bnYHfmUWU1D7gJ8equMnERaj0tSLIN
	kJmVzZq9s=
X-Received: by 2002:a05:6000:430a:b0:449:31ca:5e53 with SMTP id ffacd0b85a97d-45163b89473mr5649215f8f.8.1778075500730;
        Wed, 06 May 2026 06:51:40 -0700 (PDT)
Received: from ziepe.ca ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960811sm13410643f8f.27.2026.05.06.06.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:51:40 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wKcf5-0001nX-BZ;
	Wed, 06 May 2026 10:51:39 -0300
Date: Wed, 6 May 2026 10:51:39 -0300
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
Subject: Re: [PATCH rdma-next v3 08/17] RDMA/efa: Use ib_umem_get_cq_buf()
 for user CQ buffer
Message-ID: <aftHa2trKKlO2c3v@ziepe.ca>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-9-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504135731.2345383-9-jiri@resnulli.us>
X-Rspamd-Queue-Id: 3743B4DB59B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-20082-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Mon, May 04, 2026 at 03:57:22PM +0200, Jiri Pirko wrote:

> @@ -1172,26 +1174,29 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  	cq->ucontext = ucontext;
>  	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
>  
> -	if (ibcq->umem) {
> -		if (ibcq->umem->length < cq->size) {
> -			ibdev_dbg(&dev->ibdev, "External memory too small\n");
> -			err = -EINVAL;
> -			goto err_out;
> -		}
> +	umem = ib_umem_get_cq_buf(ibcq->device, udata, cq->size,
> +				  IB_ACCESS_LOCAL_WRITE);
> +	if (IS_ERR(umem)) {
> +		err = PTR_ERR(umem);
> +		goto err_out;
> +	}
> +
> +	cq->umem = umem;
>  
> -		if (!ib_umem_is_contiguous(ibcq->umem)) {
> +	if (umem) {
> +		if (!ib_umem_is_contiguous(umem)) {

This is a little funny, I think umem should not be NULL?

I'd rather the ib_umem_get() not be called if the op is in kernel mode
(this is user_cq so it is never in kernel mode so it should never be
null)

Meaning return a valid umem or return ERR_PTR, never null?

The case that is now NULL should be EINVAL (bad system call arguments)

Jason

