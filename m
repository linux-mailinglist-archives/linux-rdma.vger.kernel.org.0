Return-Path: <linux-rdma+bounces-15829-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FpWAxPUcGkOaAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15829-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 14:26:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE2F57820
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 14:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA74C60CFA1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 13:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36A3D668A;
	Wed, 21 Jan 2026 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="auPHecAk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE69270552
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001537; cv=none; b=ABwBmhW6rds3S6NdioE73NjD3WfYk0T+lsnTQupLUCmAFuTaSlbvazCXHUrDSB2NXOF/d/aC5XLYrWxRE0drYKsYE2RIk9ZZKTnE8pLtKXWLi8n1EFSuWjfoO7guw32yqjz0NBJr/3bI9LN+q/xcbJ27CGG4AgIfyDMA2oQxd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001537; c=relaxed/simple;
	bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppPIsvIdHi7Hw0yqXuS5jL9BVejDIMrLdczJzluUXMYK8CzOJhDn4vknkGMKq6evkgjK8uQhg52Yl8WAX6AxztDkdscDfvGq6znmO5LCQ+iW31nC+IULk57vLTYntQvEA/tVJ9Mg4MA9O93GicNc1947bDtau7rPnNLBf/5NV1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=auPHecAk; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c6a822068eso680330885a.3
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 05:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769001534; x=1769606334; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
        b=auPHecAk2iN7ZabTIQ+tkLxDrluU4dCEBlYYIhuQln6eF1Bfx+8IsONn1dD3HP+pHo
         kiQR9I91Kuww1yFWj/b0sWSrQM/cMs+blizM0NWisDQRXI35HMLsNrpnQCOrCyVfikCe
         vtv9530cVL0Vy6XHmSQ+tPLww/3r5qwJOlToD/xpraBS24TriW5VROoubZgfTjSQRAzZ
         HFsaGYZ98Y19cSGkjjghhtYs4sRPm+TZkcQlwRwb8NXzyuUBw1jY450cHKzizuLt8uvP
         gpEw2V3dp6/9VWMVd7WI8vOGqrUW48hHbYOZvkGvapFeCU43rqCSgClWfcYHPf9PznOv
         KKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769001534; x=1769606334;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNQCHIWEBRMpiFqsZYjt880FRkRpyp1yzlc3O4lUKsM=;
        b=ahftiibV0UwZNlGu5LrMMrPk0nsBnXaOFVyPV2IOGqZt8yX2P2rSrQgfnWlQvz3T2A
         7URwCn/lymwfEf2Ze9z0NZcexFenpxFCjJ+Ly/eHeNzYBaG8xqsXlk82W0Un/Mx/BWFf
         Of+lMzR73osxhaxNDLfh7IbVuBxLA4lrws7FVX6X5eTN5Z12g8yxYjcYPieXqmVnQdtE
         fcDZuOFNVm78KUCh467wBEHnQpzCvOjmJeAzxgDK1xVCwH2DdMR/Rm+3J7RV7vbnCHtL
         wLZM0sHtGGirl84s7K9OM+PtEwOaYlmp/VA8fOefja2fQeff+t7E1y8esE06svl5eWyY
         6CSA==
X-Forwarded-Encrypted: i=1; AJvYcCVL10ycInkUE3ZhejPjF9JP9D8V4BpDsDacZnV5NGJgATHEA+UMy6TaMjcqTosqhvNc2GhzQ3+cr8F1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6OFs3+glOdXoYWCEKbG/Qea6sgURkOIUQxcbAkpyjVOb92rN
	RpJro5QhNqE0ziiFae92Er1Os//oOBjTQxiauAXLvfXpg9TZLwQZYvr7j4fk5kdAVHI83iw/y8F
	TgOWcU14=
X-Gm-Gg: AZuq6aLUXKszusSTkFJBiyR9UVqzrsQFyIT9uhARB6xqDt8IKpRICWa/5vDI+6G54rF
	hQxbz23SkM5icp7VQ75y1VLbEaHl/XFcFk2Lp9l8B+mEu9FgyGUaWFAF8fcDcB95SDakikB6oj/
	WegHRDsPt3Oi2ui3ibizYK9ZyD8EN9Ct/Kx+zMJDe/4dEZDfLh8YDuFNg97AzFDyfJ65RcdXnGD
	hScc9n+0fRffw7sPk+lJ6JTTtvV80GUA/y2/BEQEcxk+vTFsQ7mHFpW/cGBmWFxt1HCiEm5VrnP
	9o0SqfpcXCdZv9vzur9SGwqglqK558G9oSwQU3B+ukhRzE7xoxq5uWwTzLbtF91+1+mktUlReb9
	IgXMmhgAe1RpXfQ5EDCKOP1+tlCLA/rRhFn01fyS0RxlFFqQSbgrJdSwhPYrXgRwPuklvJufj+Y
	mgjNyybOFGJXEtuUuUJSunUe1w/8cjyKDNnls/qLpu7A15gdoM/pkofxQJZx52syLd+WM=
X-Received: by 2002:a05:620a:a819:b0:8c6:aaf3:cb44 with SMTP id af79cd13be357-8c6aaf3cd9bmr2247463385a.4.1769001534382;
        Wed, 21 Jan 2026 05:18:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ad820sm1209794385a.10.2026.01.21.05.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:18:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viY6m-00000006DUF-3lkE;
	Wed, 21 Jan 2026 09:18:52 -0400
Date: Wed, 21 Jan 2026 09:18:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v3 3/7] dma-buf: Document RDMA non-ODP
 invalidate_mapping() special case
Message-ID: <20260121131852.GX961572@ziepe.ca>
References: <20260120-dmabuf-revoke-v3-0-b7e0b07b8214@nvidia.com>
 <20260120-dmabuf-revoke-v3-3-b7e0b07b8214@nvidia.com>
 <4fe42e7e-846c-4aae-8274-3e9a5e7f9a6d@amd.com>
 <20260121091423.GY13201@unreal>
 <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7cfe0495-f654-4f9d-8194-fa5717eeafff@amd.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15829-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCPT_COUNT_TWELVE(0.00)[34];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6FE2F57820
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 10:17:16AM +0100, Christian König wrote:
> The whole idea is to make invalidate_mappings truly optional.

But it's not really optional! It's absence means we are ignoring UAF
security issues when the exporters do their move_notify() and nothing
happens.

Given this I don't want to loose the warning log either, the situation
needs to be reported..

Jason

