Return-Path: <linux-rdma+bounces-1009-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6D5851D7F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 20:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6804287781
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7E345BEF;
	Mon, 12 Feb 2024 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lLDikqb7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A941D4D9E4
	for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764400; cv=none; b=Yw9ZZYGYwvtmBCsV/CmXNb44FwzH9hLbRbFrmf2kWucvyoIPLxQlIVwjdwpQrgWyz7cF3cUDe0CTahLBb9PYlfFB2f0qEO6MfYFbEf5xhH/F4fJx0cmRTtqypeNicfuWKUFdtVMpfOZC+pEiyv4cqDPiFkSops6vtXQAU5MX8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764400; c=relaxed/simple;
	bh=YK+sGsUdZfCKVzahxbXULih6swELSJdE1qlLN7uwVGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0oPCResF8Ds2mAN+QZzC9v8QizZzpQM87rkpawCSUnqC4Jr+r5/T1JGWPdknOydM9riEbqKsfiBAAl/+xp3sWcwiHDPyAmJEtsfQr/LxraeJhGC2R3yEl6whlivrTy3gAUfCbr4Zdroj6bC/jFOMRzB/tlHq6l8ulHw89XcTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lLDikqb7; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e2f12059f4so185939a34.0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707764397; x=1708369197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YK+sGsUdZfCKVzahxbXULih6swELSJdE1qlLN7uwVGM=;
        b=lLDikqb72XIUGYz8SWG1QhVietJSjvsR776R3/MhrMoAXfxyxUD4dW17GppSzFyMGE
         ysDeDpVMMmH8LY08LPAD6uj5t5/Xh2wS6Rg/oOjOvRsdYZ0cFiliJvGUIE5rGuw2O/im
         CeBzdilEpDjIH0WMl6YFOOXvyxV+mJtIy3xsIdzTWc/2NSH8yx+35Gq2scOiQbqsZXy5
         2ggF1Emtos9yYlYtB5uhCQ+WAQCagQLf8vo6sLOiiCzLx4fA8meZAKKmiBauuD68F2bY
         nwxvq2sv385+i7Mdn+vTpvgdKxbepDJYzL7KCMVm59J/ynP6pS+LezbfTumOVeHnGor7
         PbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764397; x=1708369197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK+sGsUdZfCKVzahxbXULih6swELSJdE1qlLN7uwVGM=;
        b=Fq4M7lF3I92D4vv4aktH/hp4n3uzSMaq2xWSU/A8M/792CZRTQ/qKJ/w3x0IWYPTKl
         ULAZjaXjft8P3D2YXyMQl5XHav/jjWpCU+GCTSHcgdK4hp+GMex4caSj6/JRN2BTRWcv
         nz2u0fHoxKCPCGZ8/8jVGQH4oghGkpEJpmXIE5aIFbMSXA+8/UWswpHZIYyCJZfg4+z6
         GxGrJ0QWhzl8cvxSggGBHOjfMUgzg8+8/0jQHZvsiOq/iIpPhj8ikTHheBHUFDFCvZU1
         n/ZKhvKojpANjaNS9Mw/9plHcBsBzA0N1sZkgRzt1esBpWzkrpi15A/s2/17tc6w9bxb
         DwFA==
X-Gm-Message-State: AOJu0YwgEdlDrLXbUuJZlHf+NnBHHIqdopThnqYhvBF308oEop9I1+Fu
	Mz7O75fgN4/x33cROV0OA1HGI4Fdgxpv3tjOiZOyE1lEKUnc+pxEniIPDOLedhE=
X-Google-Smtp-Source: AGHT+IGLv5eFYNCU4+HomPY1o0vKj1PlmGaiQycPq0Q1ss6ZrPJnmX6ZnjQQphQqx/jfdKCsd3BQ/w==
X-Received: by 2002:a9d:64cf:0:b0:6e1:14dd:78e6 with SMTP id n15-20020a9d64cf000000b006e114dd78e6mr6802246otl.33.1707764397591;
        Mon, 12 Feb 2024 10:59:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTi+7tX5r64ygyx5TKwbl71bUWtl+XXnoD12XhAm2ZTKI+tKjP9/Q+kSfXRykeBt1y1/qJDFKjW41BWdvMRWadJQsGA+H+OvzcLrrJS0oMZWcNuoVY6hqPr5LoBm1qTNkd+RGX+Xefs2CMbVUoC8DZIF/Bb75R7wyzPUr1FiT8SJ2FaU1pLazOtUaRZI5vAlLL/nf5KwssfpgLmISjJsqfFo0CalOoRraAQ8qQzkdEDqjAsAFZNRY6UymT+lUFLYEEu1rGkzuphk0+M95yacyHsHfyMf874fiO
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id o10-20020a9d6d0a000000b006e2e3fcc23dsm173805otp.58.2024.02.12.10.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:59:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rZbX2-000Sw4-0l;
	Mon, 12 Feb 2024 14:59:56 -0400
Date: Mon, 12 Feb 2024 14:59:56 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@gmx.com>, Leon Romanovsky <leon@kernel.org>,
	Edward Srouji <edwards@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: Remove flexible arrays from struct *_filter
Message-ID: <20240212185956.GH765010@ziepe.ca>
References: <20240211115856.9788-1-erick.archer@gmx.com>
 <202402121026.0AF90DBA@keescook>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402121026.0AF90DBA@keescook>

On Mon, Feb 12, 2024 at 10:30:17AM -0800, Kees Cook wrote:
> I might suggest doing a binary difference comparison[1], as it's possible
> that "real_sz" is being used to try to avoid trailing padding on
> structs. I wasn't able to trivially construct an example, so maybe I'm
> not understanding its purpose correctly.

Hmm.. No need for binary comparison:

+static_assert(offsetof(struct ib_flow_eth_filter, real_sz) == sizeof(struct ib_flow_eth_filter));
+static_assert(offsetof(struct ib_flow_ib_filter, real_sz) == sizeof(struct ib_flow_ib_filter));
+static_assert(offsetof(struct ib_flow_tunnel_filter, real_sz) == sizeof(struct ib_flow_tunnel_filter));
+static_assert(offsetof(struct ib_flow_esp_filter, real_sz) == sizeof(struct ib_flow_esp_filter));
+static_assert(offsetof(struct ib_flow_gre_filter, real_sz) == sizeof(struct ib_flow_gre_filter));
+static_assert(offsetof(struct ib_flow_mpls_filter, real_sz) == sizeof(struct ib_flow_mpls_filter));

But yep, it is doing something:

In file included from ../include/linux/mlx5/device.h:37:
../include/rdma/ib_verbs.h:1931:15: error: static assertion failed due to requirement '__builtin_offsetof(struct ib_flow_ib_filter, real_sz) == sizeof(struct ib_flow_ib_filter)': offsetof(struct ib_flow_ib_filter, real_sz) == sizeof(struct ib_flow_ib_filter)
 1931 | static_assert(offsetof(struct ib_flow_ib_filter, real_sz) == sizeof(struct ib_flow_ib_filter));

__packed on that struct would probably be be OK.

Jason

