Return-Path: <linux-rdma+bounces-16650-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN5gKKzyhWk+IgQAu9opvQ
	(envelope-from <linux-rdma+bounces-16650-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 14:54:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D32CBFE7AC
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 14:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 639A130708BE
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C4F3E95B8;
	Fri,  6 Feb 2026 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bU90/jwr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7EC2C1598
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385765; cv=none; b=NIO0rb9jq62AxFr5MXnSJjVLe0jjyan/ICnRi00QJMut2mkXFzCGf6uXHPkYN1CwklHzsl6BqEdqpEvCfg6Sc5s7EDOYI2AOmooXKtEddLJK/cImxN2iIWEbWlZr7mh/6stEQdBIKk5M4cMGF/Zp3VPiMjyCP57YmOXtJrnWe6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385765; c=relaxed/simple;
	bh=8EvsjIlNcsPPA89F9bWDTXYwkpjaPPbLvANe9F4v87w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaMdoEHwiLz+4UmTwZgAjATd0xqbE7f+3QSVxRtPWYfEzO03b1h/KnuoxhyOm+UsY5UooEz+3+NvetnNb0YPKjpuCWH4bBop4rPfT2feHzTmwTmf/ageCOv9tzbgsRZ9D9DBKjJX3rDtkqiSl8E+CEJLUSp/uQsOnQyL3fQqT4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bU90/jwr; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5033a2c4b81so8853171cf.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 05:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770385763; x=1770990563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7spYx+0bKKfu4/pSDxk5Zw3rQamj1ACqqcjHPtGsLXE=;
        b=bU90/jwrEGuKDpspmzi1qrWKqFcehOkNvJJlpIvUtVUsFejiGGHNRghxqDCrXA1anb
         +HHYruti7JKh9LFbTMouAxJBPfstVAZ9d3jjDXm5Ci2roN1p7XJdTlWcbv0jyfLq5qAS
         vzuIpvq/0/7sgU/2CkMewVxB+guS7f7f9AlvADsgy+2yQZeszqZXONq3LvHhpProvmO0
         bvFMjP2XVPEFKDSHpXs3QXXes0uIcXHoRryVbCgTBQK65f3HoEb5fYyR5i78TwB5MBu2
         g81gG7odXCmP7ER6bS2dvq6+szdDPdN16dsfM9JF8PSfTtim9jhE7/T4sr4ram4i8hRu
         HdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385763; x=1770990563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7spYx+0bKKfu4/pSDxk5Zw3rQamj1ACqqcjHPtGsLXE=;
        b=BuoByb6S1bPwN1rci4UlNsr6COB/3X1ssJ9o6wztsKGRLVVffKC6GhBSkULGFRRRVX
         xW1GXH778v+cb5477FsyLhja46TGq3QjSt9PMJjRuvJmI6a+3ZYYmFfHOE3cw6QVPl+t
         E64lE+BsQdZ6seiP6IOuM/W2tegiwv6dnyNN5INTUypxTdtmO5LCGqxyK4HUdj4l+t17
         viBYLtLVkfKRt/e5/ca4+HI4fHeQNE2nUL4ya2N65F2Z0ehUSQYNu316gD7XQHCk8Uxs
         td6yva53DIwOPSU21j6NWBw/H0aUNSpe+yWcn8bhljSjJhM14Mg7sHq2k/LN3lxKrsEp
         5w1w==
X-Forwarded-Encrypted: i=1; AJvYcCWCdUE6Mg6QeryOnj8uHqiekluEbz72BntHku40NBPtUGJ460NUGeSmJWgGwRSScEWIpfpV6Cj/KiIo@vger.kernel.org
X-Gm-Message-State: AOJu0YyuhjD+nuvEjTst+5wip8k2NY+dP6JMvBG/IEYfC9EMtrO6x0SV
	d5LRh5imQsjwDNr/iAVNeRHaUX+n3C0DJPoqskJjWh08M1IwVZYNIH7HoOVYa4fkqZo=
X-Gm-Gg: AZuq6aLRSJqiqQxhotTXUXfsMr/rfdqmBuC/OqOyXCPGo07f7VyI1LKSuCjygJOJFS7
	ihyPbudqsTNjyF9uhIUaHSU5T3I9Kkf4tk12W6lOqPylAWScYufWsoofDuyCyElwKLAEP5VG/3L
	0MR7Mu8NAu9YbWDnKD6ibbvWQKVmffSR+K/ssFLssixii8gsEMQoJ+H1q2HO0rUywJXevfuCT/Q
	73DO/s2cMpWLhrzwg/6sSN562fWHNwfpCfDw4PMaELydOjCmUV8cmcQyUlkk+36maKHNeQ9it9m
	fnyFH5nvqKj+kcKtKN4U5ZShq+K4YB3BlbUbvYSkjnkDHMN3mf4ThSzvDPXdjj4/d38Jo9o9+uh
	Q6SL9UGu+QsCyF762RvEtMNzE5G1wEiw5O+XuYW0MXMaJDos1gvl2iWjzdYWylRerdqKP++CoC4
	kOP3b1FKC2tWeIunxGZyE6vC8QvNEW714Xlc81aqwnPkJy73A8YqxXSZaL5N6L91K28Yg=
X-Received: by 2002:a05:622a:348:b0:501:13d5:a755 with SMTP id d75a77b69052e-5063985e2ffmr30814561cf.7.1770385763606;
        Fri, 06 Feb 2026 05:49:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5063e6fdb02sm9293471cf.14.2026.02.06.05.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:49:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1voMD3-00000008AZQ-48SP;
	Fri, 06 Feb 2026 09:49:21 -0400
Date: Fri, 6 Feb 2026 09:49:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v10 4/6] RDMA/bnxt_re: Direct Verbs: Support
 DBR verbs
Message-ID: <20260206134921.GE943673@ziepe.ca>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-5-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203050049.171026-5-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16650-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: D32CBFE7AC
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:30:47AM +0530, Sriharsha Basavapatna wrote:
> --- a/include/uapi/rdma/bnxt_re-abi.h
> +++ b/include/uapi/rdma/bnxt_re-abi.h
> @@ -162,6 +162,8 @@ enum bnxt_re_objects {
>  	BNXT_RE_OBJECT_ALLOC_PAGE = (1U << UVERBS_ID_NS_SHIFT),
>  	BNXT_RE_OBJECT_NOTIFY_DRV,
>  	BNXT_RE_OBJECT_GET_TOGGLE_MEM,
> +	BNXT_RE_OBJECT_DBR,
> +	BNXT_RE_OBJECT_DEFAULT_DBR,
>  };
>  
>  enum bnxt_re_alloc_page_type {
> @@ -215,4 +217,31 @@ enum bnxt_re_toggle_mem_methods {
>  	BNXT_RE_METHOD_GET_TOGGLE_MEM = (1U << UVERBS_ID_NS_SHIFT),
>  	BNXT_RE_METHOD_RELEASE_TOGGLE_MEM,
>  };
> +
> +struct bnxt_re_dv_db_region {
> +	__u32 dpi;
> +	__u32 reserved;
> +	__aligned_u64 umdbr;
> +};
> +
> +enum bnxt_re_obj_dbr_alloc_attrs {
> +	BNXT_RE_DV_ALLOC_DBR_HANDLE = (1U << UVERBS_ID_NS_SHIFT),
> +	BNXT_RE_DV_ALLOC_DBR_ATTR,
> +	BNXT_RE_DV_ALLOC_DBR_OFFSET,
> +};

I think this patch is OK now, but please remove all the _DV_ from
it and the commit message.

This is just a way to get more doorbells into userspace and userspace
can do whatever it wants with them.

You can explain the commit message some of the motivation for why your
HW needs mutiple doorbells, that would be helpful.

We shouldn't be using the "direct verbs" phrasing at all in the
kernel.

Jason

