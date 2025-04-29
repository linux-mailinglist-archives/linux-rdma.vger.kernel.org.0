Return-Path: <linux-rdma+bounces-9930-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499CCAA1573
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Apr 2025 19:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0CD16785B
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Apr 2025 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89489251790;
	Tue, 29 Apr 2025 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/Xj1jAW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6C2512C6
	for <linux-rdma@vger.kernel.org>; Tue, 29 Apr 2025 17:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947373; cv=none; b=khbq8iLhmMZRZkkptVolEIZEz0sBqSnwOigPSzqVgK9J+C+5dLs08B3MqQJVRkIsWmiESK4FJKke5EJYIHj7+87l6TXL/Z5JBu5z88GofKKY11sjjfuBctnBESuzNtzGgyure46CLRtVZWai6PBi40ckYqeuPEwgkBaICm4UlvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947373; c=relaxed/simple;
	bh=e8XvRItoWQhfTmvb9boac0IOcfLENHparmcaz31B2FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAcNvrfEKntVsLDvxWMvfKzoIHTrWwRwixe0TeK0UmglHZjKdsATxkuYHndj+F8Oz9p1R+jDeCC840/v2DxnwjlRnkXzEV91g9ZZ8oWxH37ILEirNUte7S6LeXqGBJ+WUd61BzPAM7y6nTqdZrK9/xUO0zzhzRrcpkDKWo+TMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/Xj1jAW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745947370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xC9WujVyKXi4RcXNvA45rCyg+WHI06NVm7w+fH3lihk=;
	b=G/Xj1jAWKT4lmd67HhBdNNMSiz3Kc0WNpJ/Zxxzknydgb9D3op2thodDtbBFuvonmfAEeZ
	XqFTtTJp7W+wfUR0SGGtF/y1zGM2cQS0/Km8e3MiRZ1PqW3xcf63+XtSjwIuIsN9PZXOUv
	cEZjkmAjFxKwAYCtw4uzrKe0HtrNmr0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-AQgitORCN5CopBmV0rTExQ-1; Tue, 29 Apr 2025 13:22:49 -0400
X-MC-Unique: AQgitORCN5CopBmV0rTExQ-1
X-Mimecast-MFC-AGG-ID: AQgitORCN5CopBmV0rTExQ_1745947368
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4766e03b92bso114752421cf.2
        for <linux-rdma@vger.kernel.org>; Tue, 29 Apr 2025 10:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745947368; x=1746552168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xC9WujVyKXi4RcXNvA45rCyg+WHI06NVm7w+fH3lihk=;
        b=gt+RCtLpBiHP19eVzQRmasQN6ZpuwzOSJk5TRsmape/pWmMk7jIwp8uxI3HBYXZsX/
         57nbUAXDI3ZXCPoeD6fkleMey3Q5tPZ4EJllVWmNyZk2XqKBjvv8n7tA7Rvr6ew84PpM
         Ks0sfytkuiCQPNA3wtIun7PApW3rGdXPaVzFTMs/Xj5xFKKQ795izhC39dGQlwnk0CwA
         3lP5wpma9OaquQK5aF1MHg5AYoQ1imn6sgZh0w59ybxtbHDCt380h/ra+ZcvuBwNd+ZT
         NpLMfEt3VtQXgK4tiEuCwzxc+G/OeRKbXjXYsq4n3nE4VXLlQQk7sx4KixuTy4CAK94d
         /Amw==
X-Gm-Message-State: AOJu0YyQ7FkdAdfqFOPd7levMrYJE0RshNhs07Zz38HizCefsqV1bmdr
	KJF6TCb3CVQGauQijd25ubITDooE36rSKMVBAeoPbFFsvha3uE5yC8UsYwuaOwIr/ImiCL2beIx
	bQgBbXYU2SRDwgmr0GYfDgUiukI1x7xlQoy2RrDlYHGzCIHnKtrjEg3BiLEA=
X-Gm-Gg: ASbGncuYfSUK+burnQz1Kz51mOu4sS9TolJycmgC1xX8Z/DAw7Yp20q2D9mUZrz3oet
	I+2M/hlQf6/VP9rELhxbH/AStk14VtY/un9yVxNLSr6zBcv2C6GSOJx9qgxkzwfcorJzcUXT/Xp
	qPg3U/5UKxEtw9VTWOjw/pkGTUQ/6H3NxzU4ERwyis7UMOpwSuYakBIueg+yF3ggKqBPwwsAtF1
	tHN5AcM7Q6rsQLK4nA0Tb4G6547lys7HYGlP5uCADChKUw5eoD1N1MZASNWHiLlFpRtDRSJTrtw
	Qc0=
X-Received: by 2002:ac8:6f13:0:b0:478:f736:f545 with SMTP id d75a77b69052e-48874946e93mr53349221cf.51.1745947368507;
        Tue, 29 Apr 2025 10:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY/GnQdbrrqwbffV9zOEWX0Cqlm6CVs9IIRCy8F7Jpj2I/HECCVZ1PrK0wdgJvBcx2M2Ct4A==
X-Received: by 2002:ac8:6f13:0:b0:478:f736:f545 with SMTP id d75a77b69052e-48874946e93mr53348971cf.51.1745947368232;
        Tue, 29 Apr 2025 10:22:48 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9eaf4cfbsm82532071cf.13.2025.04.29.10.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:22:47 -0700 (PDT)
Date: Tue, 29 Apr 2025 13:22:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: linux-rdma@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>,
	Yu Zhang <yu.zhang@ionos.com>, qemu-devel@nongnu.org,
	michael@flatgalaxy.com, Michael Galaxy <mrgalaxy@nvidia.com>
Subject: Re: [PATCHv2] migration/rdma: Remove qemu_rdma_broken_ipv6_kernel
Message-ID: <aBEK5bVzuJn3QR9U@x1.local>
References: <20250402051306.6509-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402051306.6509-1-jinpu.wang@ionos.com>

On Wed, Apr 02, 2025 at 07:13:06AM +0200, Jack Wang wrote:
> I hit following error which testing migration in pure RoCE env:
> "-incoming rdma:[::]:8089: RDMA ERROR: You only have RoCE / iWARP devices in your
> systems and your management software has specified '[::]', but IPv6 over RoCE /
> iWARP is not supported in Linux.#012'."
> 
> In our setup, we use rdma bind on ipv6 on target host, while connect from source
> with ipv4, remove the qemu_rdma_broken_ipv6_kernel, migration just work
> fine.
> 
> Checking the git history, the function was added since introducing of
> rdma migration, which is more than 10 years ago. linux-rdma has
> improved support on RoCE/iWARP for ipv6 over past years. There are a few fixes
> back in 2016 seems related to the issue, eg:
> aeb76df46d11 ("IB/core: Set routable RoCE gid type for ipv4/ipv6 networks")
> 
> other fixes back in 2018, eg:
> 052eac6eeb56 RDMA/cma: Update RoCE multicast routines to use net namespace
> 8d20a1f0ecd5 RDMA/cma: Fix rdma_cm raw IB path setting for RoCE
> 9327c7afdce3 RDMA/cma: Provide a function to set RoCE path record L2 parameters
> 5c181bda77f4 RDMA/cma: Set default GID type as RoCE when resolving RoCE route
> 3c7f67d1880d IB/cma: Fix default RoCE type setting
> be1d325a3358 IB/core: Set RoCEv2 MGID according to spec
> 63a5f483af0e IB/cma: Set default gid type to RoCEv2
> 
> So remove the outdated function and it's usage.
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Yu Zhang <yu.zhang@ionos.com>
> Cc: Fabiano Rosas <farosas@suse.de
> Cc: qemu-devel@nongnu.org
> Cc: linux-rdma@vger.kernel.org
> Cc: michael@flatgalaxy.com
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Tested-by: Li zhijian <lizhijian@fujitsu.com>
> Reviewed-by: Michael Galaxy <mrgalaxy@nvidia.com>
> ---
> v2: cleanup unused err, update comment (Fabiano)
> v1: drop RFC, fix build error (zhijian), collect Reviewed-by and Tested-by

Queued with some cosmetic changes:

diff --git a/migration/rdma.c b/migration/rdma.c
index 28def620d9..2d839fce6c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2502,7 +2502,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
         goto err_dest_init_bind_addr;
     }
 
-    /* Try all addresses*/
+    /* Try all addresses */
     for (e = res; e != NULL; e = e->ai_next) {
 
         inet_ntop(e->ai_family,
@@ -2517,7 +2517,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     rdma_freeaddrinfo(res);
     if (!e) {
-            error_setg(errp, "RDMA ERROR: Error: could not rdma_bind_addr!");
+        error_setg(errp, "RDMA ERROR: Error: could not rdma_bind_addr!");
         goto err_dest_init_bind_addr;
     }
 
Thanks,

-- 
Peter Xu


