Return-Path: <linux-rdma+bounces-22134-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HA/2NdL/Kmq60wMAu9opvQ
	(envelope-from <linux-rdma+bounces-22134-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 20:34:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7680D67474E
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 20:34:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b="J8/4dVMJ";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22134-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22134-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8DE1301F2E6
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1E3FCB1F;
	Thu, 11 Jun 2026 18:34:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1E4A13BA
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 18:34:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202894; cv=none; b=SkwvWmSphB8ERL5f4U3Lnwi+09C9hCAXva7zRjxN4tRBJfFRiv05k7aHl1BUX6zXJ80j3Im6UixPljlKJ5W8XwOhEUsWrBiAgRgJnIQbQqcpv2CTvS72ZYN1Kdnwa7cc68JOd4GfCPm0p69FBb9AcKBzIjNn2sUc7689Tu4xAK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202894; c=relaxed/simple;
	bh=I7nKHejdDue2acZKZys4LfnQEyFLVRI/XfxUy4Hd7OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/Dlf0PblrqTbkxFhhvcWyzuUBIXjCfZBGw0gBk2KK+ETCwCiMWEwgjzciVzAsDIRUayczVEukGOh0KuBoBFErGTMYEx7Xg5E88abeTGoGbq/IVge1BvWIi+sWxw3t3IUecEZ8/gRvbUacPzOZV0hyjxp7zEWS0F/0qx+MrIEiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=J8/4dVMJ; arc=none smtp.client-ip=209.85.222.178
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-915d17e2721so22379585a.3
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781202892; x=1781807692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzbKVYkD2taudFdcJosofP1/X39YXQKpW9J7XG1Isfg=;
        b=J8/4dVMJKXrJZU62Hs6DvafvKLTXNF3w10pwYZG+QJvPHxwdfyyjSuEI4d43RpwzYn
         5qORd2a7WOHgqSv56fPdaiQb0NfFICj+Zz3NnhUc/pKbwIvxTtvB8SzM0Qjwi6gENMNj
         +BinbNRn/dA6ON4yMhU9hD6R9IRckMDXrlaPKpKjR+oEa2a/Y6SdaSNBevUC+OLEqUNm
         eIIKmibmDiljVQl79D6KMEhaCcSBJLYZCGYpi7UKA8SViD4V90scd5D3Xw6nUdMjBbB2
         BI9QB6uxeRUTGo5drAEO085MSvei8/qSDThutUZ5YLyVafeWUVWLKh73T9QRHXUGdmlk
         Kgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781202892; x=1781807692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzbKVYkD2taudFdcJosofP1/X39YXQKpW9J7XG1Isfg=;
        b=RWpEQb/iHfeWhZFoR4ae8eKXxjjGZyF4McNCIyTbDTV8tLN8/F5b6IMrkxGH5nR0VF
         7m78dmQINxo5xCUvjxaDOYCfnXiGRcTGhheuQNCXJOLio1ZTZ4jRTJmVBuf25SfFkGcd
         ebrKNqoKihglSOUnOnVbkPJUbzMccGfiH3o941Z8sxlbHFzwHkUXMLBuWAIY83IO6QqZ
         DvGN+WZCIGnj3MTNcw81uop5pIW7k4TShxSENNkBCrDyr6KKHw1N08LChiuHlTov43M8
         nxAVEc4jZ93654MVYDPB5YOWaRl+6Irqx6aw1Qsldco+pUFP48TaJlqGkaPB2MLyQ0k3
         ZKkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1tWZNWWruV20SoU7YKDJoVi5OD9Wje7imevF0WO/BHWZnOHCN6LJ04PrjThrozGZ/j7IAh9BiLLrZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAkEcap2gdpkyJEoGLvlyZDpqe3t09OHaxoC50v655m5deh6X
	/yMk8LBIf4fxsB/ILE6ligF6ejuNwx62Nfcqdc+37Q5Fju/5OzESyYAVKET9M5wctxY=
X-Gm-Gg: Acq92OEZbszNrlBcCfHk66QoNoivm5IXVOaXjc7pbDPur6raC79KGY8yqpSTXIg4bcR
	pqZ5Y/2n6m4ltjV6Lm7P7aeN6WfoRLAIqlLS7Bqc9M0KyTuvxBxgbPTMKfLAu++AScjZ89RdiZr
	hvXgZZqXnr3uToh0yFWAdoNSzvF4uUhiWSDgrnPDY7FJNNZqedAW/J8JKyJC/5OTJOIrOFOpM8R
	jxkgWLs7JXGqaKPcPpUpqjmv1KWCfNRKbaj3BFcgl2o36ajQY0olpfOW74iq57oRV0yiJrdUqd0
	IlfYlURwiLsHQh9obSOY2URQw492Mu+HmknM31MgM/v/6+00QOSbTWwZ16Ibxq7/xvxKgN93lXZ
	9WjVA9CSMHCsPOfQGgeI9eqyQO6Xyk8k2n0ezyp1PKRUg69/HjwEhOsyY/CZJ/nH6KbuuGs4F0g
	8p8mJgeMVEhWtNK3ENnMF7f/J2qu0icLGitBVn+aa2KUOH7ZT8Oj0xFhzElvFq78nL9RcESGds/
	NSTPg==
X-Received: by 2002:a05:620a:7001:b0:915:89d4:df1e with SMTP id af79cd13be357-9160ade1865mr653579285a.27.1781202891862;
        Thu, 11 Jun 2026 11:34:51 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160aca325csm257905685a.11.2026.06.11.11.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:34:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXkEr-00000006GIL-3m5L;
	Thu, 11 Jun 2026 15:34:49 -0300
Date: Thu, 11 Jun 2026 15:34:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: leon@kernel.org, brett.creeley@amd.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [for-next v2 2/2] RDMA/ionic: Add RCQ userspace support
Message-ID: <20260611183449.GG1066031@ziepe.ca>
References: <20260611092544.783731-1-abhijit.gangurde@amd.com>
 <20260611092544.783731-3-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611092544.783731-3-abhijit.gangurde@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22134-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:abhijit.gangurde@amd.com,m:leon@kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:allen.hubbe@amd.com,m:nikhil.agarwal@amd.com,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7680D67474E

On Thu, Jun 11, 2026 at 02:55:43PM +0530, Abhijit Gangurde wrote:
> @@ -2154,7 +2157,7 @@ int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
>  	int rc;
>  
>  	if (udata) {
> -		rc = ib_copy_validate_udata_in(udata, req, rsvd);
> +		rc = ib_copy_validate_udata_in(udata, req, ionic_flags);
                                                            ^^^^^^^^^

>  struct ionic_qdesc {
> @@ -84,6 +85,7 @@ struct ionic_qp_req {
>  	__u8 rq_cmb;
>  	__u8 udma_mask;
>  	__u8 rsvd[3];
> +	__u32 ionic_flags;
>  };

That is not the right way to use these APIs, this will fail old
rdma-cores that used the smaller struct.

Please check everything you did here.

Please support IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA before changing
anything, and your userspace needs to check it before using extended
functions.

Jason

