Return-Path: <linux-rdma+bounces-20999-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDOrGCjpDGqapwUAu9opvQ
	(envelope-from <linux-rdma+bounces-20999-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 00:50:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1B6585D37
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 00:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55A683021EAB
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 22:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0711537104F;
	Tue, 19 May 2026 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="X9JhlBVD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F92DF68
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230956; cv=none; b=Ny0/y/0gVSjyF5uUWgiI4oWpTX4rB0MO8RfbWL2wxY1aWSYQg0mrLduj3A5aFTZdzx3RUNq6dc9/Sl+cFvqBwrX4N8WWvj90Epn0LLMS4ylVLGcGEsfXakVwLOj1Pj9rYprKjKYrx/5BmpdmyAwb304eBGZMW2vddLwZdIiO7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230956; c=relaxed/simple;
	bh=FuXHOd5yaQ4LzfOdN1/Nq5sh02lDV3Ri+GcBtPpIqtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBESV3spm5tKDM5cG10OQyKuACJj2fohT2+CX/tX/9xE/2ofRUuarEYf1M7d0m7Ueux1xMz7/GV45OYq7yS0FTGzTNsCsxURAWXqSKGXzuOnKLw9PVftmyPRj1Au0noGRnCauW46F9IPrVLPIC/ZaEfzOb0a+OQkqw+4W/MCjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=X9JhlBVD; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e5c7eb565so48092071cf.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779230953; x=1779835753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4xuNk5HeOGj7oVkz9btczqrM4Oe3yykQcOEW7pJDCE=;
        b=X9JhlBVD5fNonRpSjDIDhydgVyUJYLp5miKWUxmPAehYQvy6iCj81r9jC5A9cJB5Iy
         0jxekcK7qr60+3YLySwflQltpmqeXdA53MUyiq5VDQor3tM0TqQx5mrK07biCoZwNSi1
         ppRqqK+E+YYFz7TwemLeNZjdf90YKK4BLHD4io+XVgvbra7WT7RuWywco9Zv4UIZddZ6
         v67A+46AlPEmsrcKDZhywc2+eJ8G+mBvTzVbPrE2dXPHYT55Exzs7/3/RoLnaCcvKxVK
         yHmakwbhi7nALrXOaz5nRjMjKu1w4Nbmc3fstgVE8gzGdToOgESim3yed7t4UwDJnOTC
         WPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779230953; x=1779835753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4xuNk5HeOGj7oVkz9btczqrM4Oe3yykQcOEW7pJDCE=;
        b=Jy42cOhAD9a7xZL6fpnSQ7w5EAfNQ5oj0Jt+zvxlhSXXchOJh9BuUA27MtesLi1+7B
         ENeKHRFc5TdqnbxZrJpt6PxKb4UcurLG2u14GyuKXGhTiPmXsEweJUM925KEFf/eLryi
         Td+3KbLxCLST5+2ppcNZBi9LO0z+DmfUk2xtKJOBgFncXE9vbWshX7QRvWvnwCgAKJ+Z
         x/G0WlvySSS0ECr/ruoGGZQnvuWmhSN9q9LAVBqIARiK7Urt1wLoWGsBSL0XOw4qchSd
         LQ6nl4dx6tdXnZk/EgUvBew+FLny5/snTIW9Sqs1E2StEkWFenuVh//4m1eyDvQDwCpC
         8mfw==
X-Forwarded-Encrypted: i=1; AFNElJ9wH5ccoc674lzAX/fP//Sphfbjsqq2fne4XM3DiBrGTzZOu7+8g67O6jB7vZ9PDpnA9G7NOE+rrbbY@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxU4K26LxHcdqYHg/NpYgnQMeCaNnsHsBaxM1Sq1JJoYiPMwP
	FACu4m810JA/rRY/UTqsUw1KFmPPC43DquODBRqiH2M4bTUMwrHmG6SA+H6hi34v8CY=
X-Gm-Gg: Acq92OHFjWMDJXUZi/d2wISY8k3EHjh3+8dTpgE30Ne8jpGpGPJQ4vmicB+r+cEw6hW
	NW+ch+ve88K01TwbWu/Nc23xCtWvVjn2i5mI9u2nHT/ON47d6qBkHMoowEjspSkDLiXqEe67CVg
	0GZ13oGf2Cg3hSCF2qKms5EcoLjiRkdOse/6eVImH98HKt8E5THv7bzUxKqRF9/xjXqqFvxGV22
	4TarETqHKCwffHPVOyvrq8lKw+mh1VBAhmeKG9kq8zhEOSTMkmPjYkHGYBSVH6404khJiKY+m7k
	ULAlycZCI5yMnoJCmyxDL8lO5RdC8dWGcYgLtV4y7YvtnTYaUIQ/JEIhbnBJZ+k5wudzf2kA6un
	xmpRBt5gf0DrIXbVDEC+NvmXLtjLbrTQNO6NqaBlgOKj7bHtNOEAlPsaYKM3XX9t+V1iHuiapE2
	+34ft+5K5iPHI3wurJiBpjWE778xrbVvKfwr4QXuikqTzSKQdzAhdYV9VFNhOZ9TxR9z3JqaHI6
	pxiwA==
X-Received: by 2002:a05:622a:a911:b0:510:138e:b83c with SMTP id d75a77b69052e-5165a2760e9mr244413901cf.33.1779230952853;
        Tue, 19 May 2026 15:49:12 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm187957931cf.3.2026.05.19.15.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:49:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPTFP-0000000FyO6-0aaG;
	Tue, 19 May 2026 19:49:11 -0300
Date: Tue, 19 May 2026 19:49:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Remove _ib_copy_validate_udata_in() and
 _ib_respond_udata() stubs
Message-ID: <20260519224911.GP7702@ziepe.ca>
References: <20260519-rdma-core-fix-ib_udata-redef-errors-v1-1-671bf2697fa5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-rdma-core-fix-ib_udata-redef-errors-v1-1-671bf2697fa5@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20999-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BF1B6585D37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 11:24:36AM -0700, Nathan Chancellor wrote:
> After commit 65b044cee9fb ("RDMA/core: Move the _ib_copy_validate_udata*
> functions to ib_core_uverbs"), builds without INFINIBAND_USER_ACCESS
> enabled fail with:
> 
>   drivers/infiniband/core/ib_core_uverbs.c:433:5: error: redefinition of '_ib_copy_validate_udata_in'
>     433 | int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
>         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   In file included from include/rdma/uverbs_std_types.h:10,
>                    from drivers/infiniband/core/uverbs.h:49,
>                    from drivers/infiniband/core/ib_core_uverbs.c:10:
>   include/rdma/uverbs_ioctl.h:961:19: note: previous definition of '_ib_copy_validate_udata_in' with type 'int(struct ib_udata *, void *, size_t,  size_t)' {aka 'int(struct ib_udata *, void *, long unsigned int,  long unsigned int)'}
>     961 | static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
>         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/infiniband/core/ib_core_uverbs.c:483:5: error: redefinition of '_ib_respond_udata'
>     483 | int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len)
>         |     ^~~~~~~~~~~~~~~~~
>   include/rdma/uverbs_ioctl.h:968:19: note: previous definition of '_ib_respond_udata' with type 'int(struct ib_udata *, const void *, size_t)' {aka 'int(struct ib_udata *, const void *, long unsigned int)'}
>     968 | static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
>         |                   ^~~~~~~~~~~~~~~~~
> 
> Remove the stubs and adjust the prototypes for _ib_respond_udata() and
> _ib_copy_validate_udata_in(), as they will always be available when
> INFINIBAND is enabled.

Ugh, we should get rid of this option these days..

The right thing is to #ifdef away the moved C code since it doesn't
get removed by the makefile and keep the static inlines.

Possibly even all of drivers/infiniband/core/ib_core_uverbs.c should
be put under a conditional, I'll look at that later

--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -417,6 +417,7 @@ struct ib_device *rdma_udata_to_dev(struct ib_udata *udata)
 }
 EXPORT_SYMBOL(rdma_udata_to_dev);
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata)
 {
        struct uverbs_attr_bundle *bundle =
@@ -501,3 +502,4 @@ int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len)
        return -EFAULT;
 }
 EXPORT_SYMBOL(_ib_respond_udata);
+#endif

I guess I'll squash it in, unlucky that 0-day didn't notice this, or
maybe it isn't working anymore...

Thanks,
Jason

