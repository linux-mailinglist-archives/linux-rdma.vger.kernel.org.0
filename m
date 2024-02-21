Return-Path: <linux-rdma+bounces-1091-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E76985E4E6
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 18:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D612856B2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 17:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917284A31;
	Wed, 21 Feb 2024 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mGcA/PMF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C12984052
	for <linux-rdma@vger.kernel.org>; Wed, 21 Feb 2024 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537774; cv=none; b=bbHLa3+EsXWCKYx9ex7V5KcTTbTrXExu4sITXPE+hgPZpxEH4e3n5lQdMr76iAJDhp9v/kYhiGjMoh2SfiesMOn6Ijl+WaoktqKHgAUkWmS9sVHL0b50CvsXYOXb0Gs7QztSNRj6J1WYM4MboDshZVIdtYXjCV09aMazBjSCMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537774; c=relaxed/simple;
	bh=KQoMuU1dvefNeleeWBIm6wpRfUoOOi3/4vzojzj2KWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bouj/HdzSsZmf7hyemfYIUJV8TKKvp5MNpbeP593gPbZtkI4r6kSsrmtz9+voC6EivXllzJ19pJcZIid0mGPNAIOuXb9+r6p6kDOEWF/vLkzY8iP2sxU4WsAGRCk0BsdhoIJLeswxHj4hwhgIW251vLnBvvswJxGiagDAlWAl/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mGcA/PMF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-785d57056b0so389169885a.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Feb 2024 09:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1708537771; x=1709142571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EA8cf2yDI8ps402vONEh4eN8mg2XcKNJwopEt2wzvo=;
        b=mGcA/PMFITU/YtAdN7ADh5yQL705F1RRARAjRuqdKuiW9l4AF3PDF4M0ncPgtNtmTW
         CgGEpuRUQkR10r4rYPz6VCcfz8cqnk0H7uEmaxDUxRVk5rkQwXYvW9ScB0SsBvaakDGr
         4wadF9zykK3kPHUyL5DirA3+Yj8xyLhNtnje5tqp9nGIui2M79r10ZJ4jl6Eq6sNtiIz
         7PfEWKM+tl9kiEB0/4UEC7knOCgP2JRbJC2Py0EXuaQEcIvmzao2pnOfilg9yUuaYFFR
         lgvxh0EpzJaqMRdnmbcoG9tMYRDV7i/5fHHe+YOgwq+fzqYPHBcAs2AtzD44PmDrzNXi
         f2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537771; x=1709142571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EA8cf2yDI8ps402vONEh4eN8mg2XcKNJwopEt2wzvo=;
        b=Caw5E4uO7qoATyiC+Y3ZD5Kow0VwMJuxAXWouQKUDLb6U9BPzZFu50zXZnKcx9SuHM
         dd9hb3IHdwgbfQ+vYjpdPNCueI6MrFsK8KcsqvuXZ9U51jUBjgdPoQDBZ3qNPYrTfJK1
         hu+ywooGvwH9llRjUjelHuDZhcttbl+D5170NQlGeXlGvSDdApABnkNe59F+kCBj7CvV
         Skj7+lv6hFBSUKmTTG/ZcR5QV8TzTrhkprJ3/OGpUibdcmXfjpoHqWn80YnfLH/W08/d
         JSG7+yD6wk09SEPtpQusnAIaRm9vw3HjCwhPf1yDTrd4zgG+WfkqwVmSSoY2sYYhM7M+
         +1pg==
X-Forwarded-Encrypted: i=1; AJvYcCWcjjVLjDwoJo/bkhsC+nFzkuZ+ygRo8rxKUb0dp/aL961gC9mMy4lz//55+TagzJ0rf6HBpVjvsW1afJdVLdLXzRzMmM0pb9kECA==
X-Gm-Message-State: AOJu0YxdLyxi9hzkDqq26BOa9/jFJYLPysv1D2h216FK2lZPgkSVSEZm
	CVNXAGQuGEkUgXz72wLIvL9QtEF38TLvLRAOtjMDrnLzYJ44F0RyXCUpSGoUiXMxwHGYa0zqIgI
	9
X-Google-Smtp-Source: AGHT+IGZoGA7n7eCfimDJ/ips2D3ir5jrWAPbQVAC3bWxC/pS1Fb+XCKAPN5rul+kokP5AVMOOLtmQ==
X-Received: by 2002:a05:620a:8325:b0:787:8168:87f5 with SMTP id pa37-20020a05620a832500b00787816887f5mr3237298qkn.58.1708537771450;
        Wed, 21 Feb 2024 09:49:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id l9-20020a37f509000000b00787236a4ba7sm4527367qkk.40.2024.02.21.09.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:49:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rcqio-00Bx8M-6S;
	Wed, 21 Feb 2024 13:49:30 -0400
Date: Wed, 21 Feb 2024 13:49:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Erick Archer <erick.archer@gmx.com>
Cc: Leon Romanovsky <leon@kernel.org>, Edward Srouji <edwards@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/uverbs: Remove flexible arrays from struct
 *_filter
Message-ID: <20240221174930.GF13491@ziepe.ca>
References: <20240217142913.4285-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217142913.4285-1-erick.archer@gmx.com>

On Sat, Feb 17, 2024 at 03:29:13PM +0100, Erick Archer wrote:
> When a struct containing a flexible array is included in another struct,
> and there is a member after the struct-with-flex-array, there is a
> possibility of memory overlap. These cases must be audited [1]. See:
> 
> struct inner {
> 	...
> 	int flex[];
> };
> 
> struct outer {
> 	...
> 	struct inner header;
> 	int overlap;
> 	...
> };
> 
> This is the scenario for all the "struct *_filter" structures that are
> included in the following "struct ib_flow_spec_*" structures:
> 
> struct ib_flow_spec_eth
> struct ib_flow_spec_ib
> struct ib_flow_spec_ipv4
> struct ib_flow_spec_ipv6
> struct ib_flow_spec_tcp_udp
> struct ib_flow_spec_tunnel
> struct ib_flow_spec_esp
> struct ib_flow_spec_gre
> struct ib_flow_spec_mpls
> 
> The pattern is like the one shown below:
> 
> struct *_filter {
> 	...
> 	u8 real_sz[];
> };
> 
> struct ib_flow_spec_* {
> 	...
> 	struct *_filter val;
> 	struct *_filter mask;
> };
> 
> In this case, the trailing flexible array "real_sz" is never allocated
> and is only used to calculate the size of the structures. Here the use
> of the "offsetof" helper can be changed by the "sizeof" operator because
> the goal is to get the size of these structures. Therefore, the trailing
> flexible arrays can also be removed.
> 
> However, due to the trailing padding that can be induced in structs it
> is possible that the:
> 
> offsetof(struct *_filter, real_sz) != sizeof(struct *_filter)
> 
> This situation happens with the "struct ib_flow_ipv6_filter" and to
> avoid it the "__packed" macro is used in this structure. But now, the
> "sizeof(struct ib_flow_ipv6_filter)" has changed. This is not a problem
> since this size is not used in the code.
> 
> The situation now is that "sizeof(struct ib_flow_spec_ipv6)" has also
> changed (this struct contains the struct ib_flow_ipv6_filter). This is
> also not a problem since it is only used to set the size of the "union
> ib_flow_spec", which can store all the "ib_flow_spec_*" structures.
> 
> Link: https://github.com/KSPP/linux/issues/202 [1]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
> Changes in v2:
> - Add the "__packed" macro to the "struct ib_flow_ipv6_filter".
> - Update the commit message to explain why the "__packed" macro is used.

Applied to for-next, thanks

Jason

