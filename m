Return-Path: <linux-rdma+bounces-21983-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r7KdLkAOJ2qvqwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21983-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 20:47:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51815659DA4
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 20:47:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=GNTEuR02;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21983-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21983-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D642330A3BE5
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F83E0C7E;
	Mon,  8 Jun 2026 18:32:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1733E0C70
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 18:32:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780943561; cv=none; b=f8PoQbVt+tdprf9epaQiMkTSuqLDtjCDWlg68fIoIHkOwlPyU4o6b4YXl9YdXYLmlwrH0DDxqQYd3adIFRWJFwdSWph5bwHC/I0VwE7/2zo2aVUU4dsC26agHBHvNxjM2JgcKb3Sk2cZdx+8EJ+msbLkddcsbueu0rU+Z254sao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780943561; c=relaxed/simple;
	bh=NRYtjtKesHNdqf0BZGqy8B6mOcPPpM3Bi2aqmD/VBIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T44CNaogCNAaYfFVTna6Rug6Dg1C4qTAXVW5AzATvmdUwdwEosVew73lOSZKZjQHph7WtSyGcqCzB7ZGSyAQdwIDdhKXC70OkrjUW2AtEpTyUvuZN/mQKGyPb+9j9W5fT5v35mAy/nvTHR22LCZkKtO2VHhwdJVvwjHowQyyVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GNTEuR02; arc=none smtp.client-ip=209.85.222.169
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-915b5ce94c7so320053585a.2
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jun 2026 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780943559; x=1781548359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1h0HrgEcGa6iFv+6HC94ID46NRoLdOidAgcn+xUH6Q=;
        b=GNTEuR02mj6R6ks9LqyfrJ9aOGwEceAtrqbOCZi7E/RxCWlafBNrpAfmUhUtC4CGhJ
         COidNsd5EcKwtYt7nPHdy2Lwjae21tTsPBu6S3URL3Z7bHjLwxcLyz7WLECfa7rqKaO9
         1qadf3afnQAsvZmdA/rCuNJmHGHdfR/+Drhot0HsvW2caI9LnuwVtDsdfViILBtAAGey
         uAFMFVmUSPzfWCmF0SnpMZf3lRYUOT1FjpdwuNJAV53JXeIKONLDyJhZUJVV12mRXJbl
         Q/BrO0b/mNoL+G+dLIUJdt8Kv5Si5H7QijHOOTgQ7pkWx0dO1ORLiTDTQXKsa0Q9Dulz
         v6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780943559; x=1781548359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1h0HrgEcGa6iFv+6HC94ID46NRoLdOidAgcn+xUH6Q=;
        b=bGechmOcZ08Xps6M4PI/cd23jhmGBSkeSLT9kA22A3vxhvIAbkDeqQNxd+mmHzLV42
         ZuuBqNprjoa2e95THpQTajthJzwYxDfEu+pKDSOfxwEbmlU+4ELvx4SmlgSE+MONAQ5E
         JV9/Be1ljLuRLJUNCcxxHIg8iyZhJ2ff04mbFwse0T2kJTEazwdWgAThHL9QlzMxeFQp
         ntqfVlAU4oSvGmulvujJgAwKRA76i/kLqG3bGwJtt3artU2++hPPQmRZed55PznMbJvD
         utmzG5sczvOFuF5H4C2v/bDAJM3dyOOYJgGGZ8kKLAA54a1E808qSoO1VTeSdulDfN6+
         eiKA==
X-Forwarded-Encrypted: i=1; AFNElJ+NaMWXIwJShS14yu10W4IwiKpqg4rg5Y6CmT1UKI1CXQjC7OmDyTtCD1xn6Y3jxFzO2Hh05BkqRf/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzCOMwFLt/8Fr+dWqywlB0vlZ6uqFKwnMJbAH38PjWWki8ch1j9
	Ifg5joQtnWUS6uo6X52s2uDi9FNr/3VMU8gR+QrDQFYr+JEcqnSOkgYtLLmrSpn6zVQ=
X-Gm-Gg: Acq92OGeKk0PC7d5OwAj7M7EjFDdbpqyKegn1V/k5FmqoBMq6jQuoTgN3Q9/r0sbtjN
	ZnnvJwwCrwl+bxaEyHZBpWIV3A1UlwizFVsDQ0xZTEluDFW5MKvJPRDjF5lUYPaQWs5ut6VuvpP
	tDrn2L7ZkQc7TJR+cxgtnoCDAeWBMQieLpVkvC3a3lZFILB/4xt0MLvzM2RmOgUkG8zfEOcbVbE
	9TmXeAWwGHPz8rNGG5mum4qq6t0oY1XLNT8VkJdPx6Fh85RpomXTQ7ulJ+GOfBVCoLDK+plp079
	FLUdW1lqvW73hD5WMau8J3WUS7mb+wSI/S9JQVep21MJ3uixbdaho7eYUgD5EDP5inaWqtudUDI
	nHDGPB8RtOQF1+ww92LJIXTcB97xNvQ7twLHUoize90WvAegEwgOFy28IPPtDdJ2PWrG1lAJKvQ
	BVmWvruI9uxy/BIZhazZnFN+jBzTT+itX0fUAP2nZeEPFQefYaphK2JOZZ70A+QSAi5YC8UGZm0
	WAhiaLmGMh4mDpEzvZtrONNwyY=
X-Received: by 2002:a05:620a:454b:b0:915:9a39:1d68 with SMTP id af79cd13be357-915a9c36a24mr2824742485a.5.1780943558746;
        Mon, 08 Jun 2026 11:32:38 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a238f8esm1834109985a.15.2026.06.08.11.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:32:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWem5-00000000Odd-3Loc;
	Mon, 08 Jun 2026 15:32:37 -0300
Date: Mon, 8 Jun 2026 15:32:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: fix refcount leak in __ib_alloc_pd()
Message-ID: <20260608183237.GF2764304@ziepe.ca>
References: <20260608085625.138331-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608085625.138331-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21983-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ziepe.ca:dkim,ziepe.ca:mid,ziepe.ca:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51815659DA4

On Mon, Jun 08, 2026 at 08:56:25AM +0000, Wentao Liang wrote:
> The error handling in __ib_alloc_pd() has a refcount leak.

No it doesn't, the error handling is as designed.

> When get_dma_mr() fails it calls ib_dealloc_pd() which invokes
> ib_dealloc_pd_user().  If the driver's dealloc_pd operation returns
> an error, ib_dealloc_pd_user() returns early and skips both
> rdma_restrack_del() and kfree(pd).  This leaves the resource
> tracking kref held and the pd memory unfreed.  Because
> ib_dealloc_pd() has a void return, __ib_alloc_pd() cannot detect the
> failure, so the leak persists.

Yes, we can't handle failures on this path, the kernel verb
ib_dealloc_pd() could gain a WARN_ON to make these clearer, but the
correct thing for the user facing API is to just leave it as is
untouched.

If you mess with this you break the uverbs stuff pretty badly.

Jason

