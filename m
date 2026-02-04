Return-Path: <linux-rdma+bounces-16492-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDirEoGcgmlgWwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16492-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 02:10:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2CEE053B
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 02:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47B6C30531F7
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 01:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E642A23D2B2;
	Wed,  4 Feb 2026 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QFaNOY0U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE621576E
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770167423; cv=none; b=iOrBXn0p8RsdEeAuEdrSZlcSwUkf45oWKUXgi58dxigLALJRJ1MvEFWuHS8mNTG0QpKjLQ6MKQNu+4gMVRjo5R1y4blOuTZyizXeQFLKCBv9/sv8ieZa35x2g5781mNVLnRRNyeV9uFwTzC3PWBMecxV9SdLwBghGxLLPzfuODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770167423; c=relaxed/simple;
	bh=688Xnwj+nvsTxHTxtu9ZWE8D08NIgDhUlPKBrXWKuZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gslc8/0CHcqJjv2ThJxtmC4VGOaSk+drzHIExEV6VXrpjPx1qyrBGRtU64wQqSqyAumOS6mwQOtvu2pwyLYj1z7qNC1w6iAaSvIWfhn8kYi4mxX1ukX6p+rGXH4wgMsKWrSgGMCmZbMrNfej2NhkQfcj9wKRRMVYbDfxeK5f3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=QFaNOY0U; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8947e6ffd30so74782636d6.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 17:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770167421; x=1770772221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8jr2Nl3tG4nZMa7rRCwDlf6WLWGxE36Di0j4a1LrU0g=;
        b=QFaNOY0UXGpPok5NCYW3nHCa3wuIakhE6XWxmN7f2xO8MVOtSnSNXaqbObTZi5BYER
         KKijU7fuNfIFa5vp+SBWcRvMw7h5/pu1Li266U4c077oe54AaIQaosHV+tPr0AkErhvz
         uIP+3QyLlHoBijBfwUNhZ0XXyseZGhs6BgC7Kj1wGKHMBqbXhOigxsOCyd3mV6oekneS
         6wkYyVgYh9YFz7oZNfVVBFi1Lk5t0qb/7aNPqDnpGUz6wI6PDhTavFBFYfce6P1+PRog
         5Cj0urrVWV8VhFLMxfxAtOI+CU9pt298WBp0iYoGWRmMdF7CXUObK/AsIjfd+COEiHx5
         8NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770167421; x=1770772221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jr2Nl3tG4nZMa7rRCwDlf6WLWGxE36Di0j4a1LrU0g=;
        b=PEx0BLUkuR32CVIGUexV93vvdu4XMRUToY2sGKQVOs0JSyO8AoZY7+gnNtIjWY4CmV
         TFWEnJBVYdv9FL8ke3Fa0TEGvM6dzrVedSkfigNyY7KIGDRJoJKy6xerJfN0VOJwWkh+
         pFbiuvN6oAzXfbiCb9Uj+HB0c5lxQVZ1DnLt2fKt2TR/IWHLF4WrNT6JHEaZcKOdsZFy
         9qkUpLOcRn6aWjKO/uLC8K7Inaq4GXH/G4JQdvBntkJVgNudruvuZhDVNhFFF4hIqtjK
         nhh+VCY/vDg0HKZ3k2NURhge6zWclrp7LOUnCJM7F6dWSBTRw0KiKHhpWI+0qrqD68gu
         /oJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXqrPjYxdpyqWPra8VNwjwESuuKFTcAbyQZD8d6mQMUOqjMAvITVIUPjsrOz8qPVIjGfXnO7nScbTL@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWG385+GhfkQbeeqc1hIViKriXNDgayImoH6tiHUjwVljV03H
	byYyjgTq946lGcSng1c/ci7zhpqKVgPyMSnLU4EMRAARx0IY9YFe6pmQmmCZAQzqzPo=
X-Gm-Gg: AZuq6aJ+v3nHwRXpNFF59S9tB6vhCJCQg8xa83evle7wQ54qt074sz4pn3PNzqU+a0A
	iVPR8aQN7nrYg6TCuZOKpNrneVA/usXXqb10ATWRvZAAnf78+2CnxenFcTJgBwpjpEkmur1l9KW
	rlp5Bj57dkSppSovcEd3kBBlea1gjTPxRmW8RJfyklKGZb0vKDtpmxmAJ9jSOoBfsvQXBaXCSZw
	8QM4vChQjZimyjqmR5TLE52AMSfLOn5U7ZQqud0G4EUWnq/Wu2wtTsTB4f5a6QHNvXFSHfWmUjJ
	oDc0r2jMFWnd4mjBVwfeQsQ52HKHhjZHAVtYPReLQCQfSr724qJewmWcxe6WHNsVtObC41UFjIM
	GUgDXujLWz1eRLFRDU43jfJ6v7SdomgZ4dFnWVAlmLNlfBymE2NiZb78txdIt/E1Lf30mhJbkip
	TlrPydMIYJNMuiLg03zHSo8lkCh6DB4EFQcuHnjuoLITs9XGFliGoxmL3elbtHtjSfpTU=
X-Received: by 2002:ad4:5beb:0:b0:882:4987:367 with SMTP id 6a1803df08f44-895221d848emr19194156d6.65.1770167420831;
        Tue, 03 Feb 2026 17:10:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd41f0asm84420585a.45.2026.02.03.17.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 17:10:20 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vnRPP-0000000Goea-188k;
	Tue, 03 Feb 2026 21:10:19 -0400
Date: Tue, 3 Feb 2026 21:10:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v10 5/6] RDMA/bnxt_re: Direct Verbs: Support CQ
 verbs
Message-ID: <20260204011019.GZ2328995@ziepe.ca>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-6-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203050049.171026-6-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16492-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC2CEE053B
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:30:48AM +0530, Sriharsha Basavapatna wrote:

> diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
> index 51f8614a7c4f..4c079d60b43d 100644
> --- a/include/uapi/rdma/bnxt_re-abi.h
> +++ b/include/uapi/rdma/bnxt_re-abi.h
> @@ -56,6 +56,7 @@ enum {
>  	BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED = 0x08ULL,
>  	BNXT_RE_UCNTX_CMASK_POW2_DISABLED = 0x10ULL,
>  	BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED = 0x40,
> +	BNXT_RE_UCNTX_CMASK_DV_CQ_SUPPORTED = 0x80,
>  };

This is not what I outlined before.. You should have a patch that
makes the driver implement the uapi compatability protocol across the
board.

Then add a UCNTX flag that says 'compatibility works'. I don't want to
fix these problems peicemeal forever.

This is done by
1) checking all existing comp_mask for valid values and returning
   failure
2) Checking that structs have trailing zeros only by calling
   ib_is_udata_cleared()

Here, I made you a branch that takes care of it all:

https://github.com/jgunthorpe/linux/commits/for-sriharsha/

And makes the required whole flow a lot clearer since it has evolved
into something that is far too open coded..

Let me know what you think.

Jason

