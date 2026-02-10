Return-Path: <linux-rdma+bounces-16738-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNSrCb2Di2l4VAAAu9opvQ
	(envelope-from <linux-rdma+bounces-16738-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 20:15:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E18F11E8F7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 20:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B8D23012CBF
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467BB38B7B5;
	Tue, 10 Feb 2026 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eID+FymD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87693859C4
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750893; cv=none; b=d96InDquWha1o4kkcyaX4ME2gNhb82Agg9dfgzJ4aox/KiAAWj5O2eT9VGjQFoL1b0BAHFuMew/yD7vModJ9JHAg4NfTqosuYa6LJGp/L474T0uEkwW0yIJHEEEMeDbx5pkdVNhk0VHBhVtXA26v+W4Tmr0u3xZyepF5ljSruIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750893; c=relaxed/simple;
	bh=9xqNAYpqagS+Yo/2Arld+UxBGO/HfrO3BQ9uwD1a4Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVpfOOBGwRdaQHnA8Ehvhzse7VuZYL56YnZsN7tBsPLdmtVWS40RDPqWl6wv+oaeC7HyPBndUjHPVMTXtmhRg5iXKt72L//PsC/Os3lPa0A0eaQMTqSbOZy5NB0bHEZy+0nGWI9x9CbYip2TBe19Xp6Cl8lexSl2qvp8JSy2XOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eID+FymD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-502b0aa36feso1437081cf.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 11:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770750891; x=1771355691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=femI4WrttQvTTkHcuguP8B65f0lyKniJDpfqrFYB7wI=;
        b=eID+FymD8KXsFwWGtnrtdJIivFaki1gcELhq2IL1WF2302YXaU+V85VOr7/aHZJ5Za
         IwdqKhLtOh4KH+fBNlOmJMzvSh1CCUTD2nVHpPldH+neQQeCN3FLY263mXjdtSsAd/oE
         nMM9pqmYt04lcqeH3aJbING4NL8kKUdAaEU5eUuc+LEDFcmV//z43I1xW0h6JGR/XGgp
         izHuX7vLglWYjHXgfeesxxzZBtfuHMSirwD3SMo6BNwmz2pmMulsC03POCMNxBR0O6pv
         TDqZr3qyYiGtONrsC9ufM1lumuU8qZpHkzSMcevnaeYSwCdfpob/B47Ym3QVXukV2zju
         //BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770750891; x=1771355691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=femI4WrttQvTTkHcuguP8B65f0lyKniJDpfqrFYB7wI=;
        b=LiYrtKCXdqcYKv5djjG5C+VK7vWMnSYtvlyTgyL8FHEfnn2e42AwTx++/gsgiAtu7Z
         7hq0XBVMeot3ZBgAf3KWQxGmHh+Hoi3ObVbLwFnikUrrFsIkpMKAVuRNNEcCto2JxRp3
         nFq8+ruDRrZ62ERm4pknFEdUGt4+2WS02KxuAXc3gauKhBzBcxyPGPQJ4ceXob90JYi1
         dVh1SfusFUEcQ7xye/a9BmuoPPm/P/X2g0Eso46HJa3GJyqbv0n07vynDWnn5BJJvS9Z
         iibabqz8ncsjy7wQMcrbjDKxctMpJ4mRan1jshXy9V6gDdctrHpnlX+66mQ57luMcvLP
         Jsdg==
X-Forwarded-Encrypted: i=1; AJvYcCVAiHPTc9RpuN0DQxIMsSuOY/jjtNi2MJFUSUPTtol2r+vigWX3GGA3upwkVSt4P+jCBaS9pzsdTJvB@vger.kernel.org
X-Gm-Message-State: AOJu0YxpqWMHaafqL2xVQsIU1/Popy0cqVs+8nFJrNN06jlRh1zNsney
	FDM4ULgjGVpKSZmImcLTwXl1StAeJnaeSaS5k/oiom7QMs1C9JPjjFynKHptL3swd7A=
X-Gm-Gg: AZuq6aLwqPS2uFYvIwOBfOHQFmNVefi+eh+r+GHp/8ogb4z98Elm0coyP4XhXk9/dUr
	HAn7dKPMTTfrWjdJnyFFTQZRIdlD634R6UVKIdLlrLiOF0NGK+E3DkAMfDR0AeSnXmYDALcRYpm
	dC70Y9isdK15EdBnatxyjTBYqFw84odj+HvRs4csTN2sCAa6ZWDM4oeTgi11ZCqRJRXMswTu3jP
	NOF8xIs+H8i1H7CrVDaI61VTCOR9qeAk2czv8r1zNzv0nliSsYTIcq22/BiyjAy1wPOZs75yj+c
	SoCoDm4l3bHTZxZhHYVOUiousioLpvgbfChjKJqNyLv/gBWmtq3zUJyoJ+lrwquQrpjhgfQimho
	nqw9UViZVrsVcfjkVz6UHZRpXGK2RRYaBA8GNimOo94qQAl5armSmceogW03znWNI/AvUCTpOED
	pDmJgFG361cprscItwR5i3sgWt6RTnxs26ELpq++T5f8BgTJmEpHkzDenTz8KQYQGCdA6NDlkjk
	ipgjig=
X-Received: by 2002:a05:622a:254:b0:505:e529:11e9 with SMTP id d75a77b69052e-50672c73556mr54505251cf.36.1770750890616;
        Tue, 10 Feb 2026 11:14:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf9a1654dsm1108808785a.31.2026.02.10.11.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 11:14:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vptCD-00000005Eol-2Dul;
	Tue, 10 Feb 2026 15:14:49 -0400
Date: Tue, 10 Feb 2026 15:14:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v11 6/6] RDMA/bnxt_re: Support application
 specific CQs
Message-ID: <20260210191449.GE750753@ziepe.ca>
References: <20260210165939.41625-1-sriharsha.basavapatna@broadcom.com>
 <20260210165939.41625-7-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210165939.41625-7-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16738-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 8E18F11E8F7
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:29:39PM +0530, Sriharsha Basavapatna wrote:
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index dc73f0072528..04588b4f79c0 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -3372,6 +3372,9 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
>  	return 0;
>  }
>  
> +static u64 bnxt_re_cq_cmask_supported = (BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT |
> +					 BNXT_RE_CQ_APP_ALLOC_ENABLE);

Don't mix req and resp flags together!!!

Also don't make a global static variable, just pass the flags directly
to the helper.

>  int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
>  {
> @@ -3382,6 +3385,7 @@ int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
>  		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
>  	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
>  	struct bnxt_qplib_chip_ctx *cctx;
> +	struct bnxt_re_cq_req req = {};

No need to zero memory being passed to ib_copy_validate_udata_in_cm(),
it always writes to the whole struct.

> diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
> index 1f7685665db1..26eeb78193fa 100644
> --- a/include/uapi/rdma/bnxt_re-abi.h
> +++ b/include/uapi/rdma/bnxt_re-abi.h
> @@ -103,10 +103,12 @@ struct bnxt_re_pd_resp {
>  struct bnxt_re_cq_req {
>  	__aligned_u64 cq_va;
>  	__aligned_u64 cq_handle;
> +	__aligned_u64 comp_mask;
>  };
>  
>  enum bnxt_re_cq_mask {
>  	BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT = 0x1,
> +	BNXT_RE_CQ_APP_ALLOC_ENABLE = 0x2,
>  };

The req/resp comp masks should be kept separate.

The name should be much more specific "BNXT_RE_CQ_EXACT_CQE" or something.

This is all alot better now, thanks

Jhason

