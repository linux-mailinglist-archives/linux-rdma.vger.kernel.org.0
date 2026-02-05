Return-Path: <linux-rdma+bounces-16585-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMuzCReohGmI3wMAu9opvQ
	(envelope-from <linux-rdma+bounces-16585-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:24:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7484EF3E9C
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 166F43020A64
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671943EFD15;
	Thu,  5 Feb 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F0EMdcT9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0562325A2BB
	for <linux-rdma@vger.kernel.org>; Thu,  5 Feb 2026 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301335; cv=none; b=GzN0kcK8cM79gN+VOtY/LE2Cdto0uRKBnPyj19az5ivoRT3LLJKM8IaKVZjUW/b0w2bxBVq8DTiOTarUlXuIgpuvsf4Tx3hU6pW5/GTYUnhf37sPB4ivIUuXyif3mU8I3ObZ0uR8DGpUtHaHf+B2tUY5zg8RxW93hdTlSCqN+RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301335; c=relaxed/simple;
	bh=Pt0HnRjXryXL1tgfiiYOKLvcZricOm1mjLhkQk72DXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMTMXwY8sg4oL2q6edTjwf8lA9S+PZn4FZBrtj4alX+wXPjg9MgJMAnpU3GDgXvf9GU6R1E+ZclH8kwqFIlkX5V2wtPxztClqqYV9wzlaAwKLrgMoc/U+63vkxxjGsnzRsV2KCHZqEZqRp0SS0qglfQXdWt6EWBU+3gNWznb6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=F0EMdcT9; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88a2ad13c24so9197176d6.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Feb 2026 06:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770301334; x=1770906134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9C5WZLQJbhatdNIYEIlpQdPFQ3viKpX3J9SgpPa5Kg=;
        b=F0EMdcT9c3WNJRMJHT1UMCn4ltdTVPEO9JIL4Pi1Xt1SEC8hOtw1EpT9vrsikq+Ejm
         C1wAX4yQPCCA1fAQDJGk9O6M+Qwgn93VCpqU7x1bnL6op+Cxap9HNRNsBL14S0x8Tv1s
         oVBWdFuk4uz39S3E95IlPOfdZVd6MIbsJeX1TbjuY+djrPr09edNeLgoB2hcrV1e0KIL
         MbSQKCvhocsPBtUjkNruaf8PuU/TWei3tfo227HxCgPEadkar6LmnVJeq/shkMBH3h1d
         ZNmoHs0sEOfb4nQuE4UB0XBjvEk5Q3p8/rfvDbe3VuLpR+RDVUkLV0Cij1JawqS0Ib0e
         yrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770301334; x=1770906134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9C5WZLQJbhatdNIYEIlpQdPFQ3viKpX3J9SgpPa5Kg=;
        b=aW87i7khSfwbNhXNaEIqLUxHw1RjphCSs9fe3OzytQWnRDPLa8sdYToEknECLivX/L
         terYDMJjrnTU0WQ/g+Q+aFynJhQAW3O+vyUR1a1prBooAfsoc1wLP/XQmLkUOJNy59XZ
         KwajU+2SoB8+Wvww9+sYte/J/93ZYX2R4KeF02YjSE3MNbpJuG14Yg2dMO0KcXQxlwl7
         Zxnoao4zRh0mO4Q/LK4DY6VfbNEva6KTekLaO7dh6fwzg9PlRD/84QuUtsP1A6+7oTox
         U6JrqPDradHnLVLw8BcFgWTyHkVTwqSyrk7Yn5Ef9JobGsjOTQlgmm7Ry+xAIQMqASz8
         c0tA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ72LOHgl/ygAPEHS1jkIooRs1hcV5WzpPtm/hxmzZGSdyvSahb90L217Um4RKaitd1xZFo4iN/jbV@vger.kernel.org
X-Gm-Message-State: AOJu0YxDbXXRO6r9EzrtkAfPV+2nYkTx3HtTrxbq65t66BhA1YdjGhXY
	LZ+g6WkLYRth6AHMoxu8ZXfSVqs3yBI6KEZBzs2cOxt6VZHbAMBAH3uQGIjUI7MNh/8=
X-Gm-Gg: AZuq6aLCxR8D7fZvnNdczn5X0aA7mhkIFt4Xalqu7vZK40PrWG5Hnzg1EV+fBa1/W4d
	+a5j4k9DDB0cZEhuXrZOIMrkVTzb4U3cqG7/9kVmwx+XWlIUa7G//F6Zw/puQhWmBlqa5wFM/fq
	pUH8i/huM/CSd7J4Q6f3wlF2qbl+wXlUJm0teEdBCG99a+1FBdgrg60DzB+MmOmG77kFOA8ang+
	wlJx2GCWmGBk5fYVuyvcnLVVfqlyDneKjZERsXxfe5ISumTCHMeqBCrsYY+XXcUhTnnxC+WJ6Vm
	3u6fri0p2j+Y8njdV+25nmhBkM27snplHiyt1eunt2lNHP2eysKrhYxuizbIr2eQBFaxma/Wq7N
	AuQP/cRStPvjZexqVdyD5G5yzmnD57DWNwCwXWyr3wC2wcJpymWKGEA8bkpxQI5865oBwHgWG3Y
	FfDal1CbEfIPzUoa1bcTBdirm88Jo+xfj6RiejwfKpk+66ysverzY6GHwlp0ts6Hj+Tdg=
X-Received: by 2002:a05:6214:2524:b0:88f:fcac:e9c7 with SMTP id 6a1803df08f44-895220f372fmr90739346d6.9.1770301333791;
        Thu, 05 Feb 2026 06:22:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521d2788asm41905166d6.47.2026.02.05.06.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:22:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vo0FI-00000000kjr-38oY;
	Thu, 05 Feb 2026 10:22:12 -0400
Date: Thu, 5 Feb 2026 10:22:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: return PD number to the
 user
Message-ID: <20260205142212.GL2328995@ziepe.ca>
References: <20260205121354.925515-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205121354.925515-1-kotaranov@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16585-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 7484EF3E9C
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 04:13:54AM -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Implement returning to userspace applications PDNs of created PDs.
> The PDN is used by applications that build work requests outside of the
> rdma-core code base. The PDN is used to build work requests that require
> additional PD isolation checks. The requests can fit only 16 bit PDNs.
> Allow users to request short PDNs which are 16 bits.

What?

PDN is protected information it should never be given to the HW
directly from userspace.

How can this possibly be secure?

Jason

