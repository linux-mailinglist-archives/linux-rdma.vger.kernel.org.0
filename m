Return-Path: <linux-rdma+bounces-15849-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKL0Eab4cGmgbAAAu9opvQ
	(envelope-from <linux-rdma+bounces-15849-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 17:02:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EE70D599E3
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 17:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30CBE54BAAB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133F03E9F9F;
	Wed, 21 Jan 2026 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d8ipf+KU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B902041C300
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769010101; cv=none; b=aCN2Yer6Ps23jMZqxdPDlT7pv07u27JkbCcq27lMGlsCCzrPHZMHdx4S9k36C10TFcpdVQO1o5FYm1ixg8kXQs5JT8o/eV1M5xlsXIeN8VrET3BgI1fWyJF4uP8hr4NDKWEoVyrjnXN8JuzkKFsV0zLxxpGebwgJeutJJXrMO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769010101; c=relaxed/simple;
	bh=MtzfM60Cs9mbb/vDYLGt1i8sN5P/nhUKDazT3BzO028=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcVJKQTUj2uoPyRKMGnC/71gvwybpvYRelHxCSQ3UXKHFY8tqW6CWLMVZGwp4fXHbAavP5BKs1UisYodZpD7CqyS9mTD64rovg3dKio9G8tZhYsI3Zp8W+LvDitoDridUmfynBY8jxxx26U7AnjQ+H8dzJViRRsD4A7ZXgiqROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d8ipf+KU; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a37cb5afdso14960646d6.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 07:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769010099; x=1769614899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ou8wYJVgke38aZatOGIOXXNbnvyF2AuO4MiXOCQfuAM=;
        b=d8ipf+KU++d9oWZgIR6lkxHBb8zf4MCRmoRwF7J76jVX9G5OiIyG0n6WJtb9AzNyCW
         jOjZq8LRWOOMO+Er2zSfMqVdcWQ5lDt4hZIILiz99LspfnYKq6Vm96pR1HOSOWuJs1ZG
         32i4aWr/fTBs/O3a8mldRbft0k6Baj9NWL2EeQdEiMYBskC4B9Yc5557kORXLi+3GJG7
         Pb8f/UNhY3khb4fQObQ8ddLiXbUAdCup/sKMLFCrWUMLzi9q2BqKM2Vaqyonmzp/1hPw
         25xyxonm5frcsDVntEjX1kH31oHyKXlWqJew8afiw3qggmbb8YPqg0OOTeGFqoKjzyCd
         pF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769010099; x=1769614899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou8wYJVgke38aZatOGIOXXNbnvyF2AuO4MiXOCQfuAM=;
        b=pSp3HUGjranQq53NMocEPfGS2wSWbJZExz2ujyOuP5W0ru9epzBlCiUmasq5jH4Jc3
         82pZIu4z65jS1bOQISzUiwSDIQAkaT/bHgAEyDd98KSTa/uNfaxDdI96vUusZGNXZa29
         mCEh1S2z48uKnebSoY24HlLY5saj0HxOnDx5k++nwsN1ibwaPmO7PJhXbfPFPn3DkhRy
         RLhJ6HZZJlRS4qWPKjACTSnSVe2XW6n0wkVXEDuj8nafVCQYuJZlfHGmDH+4X0gTruL6
         W7rJIwymQxpn5eyBa8jRDSHEbUuPLBkPDVxeu92Gai4h9BU5DHYotdVMYXOYb4+Dd6Vj
         SYdg==
X-Forwarded-Encrypted: i=1; AJvYcCU8pATgtygSXV2RIDRLD2q6q0rZQnIjwcsV9AyvdPkA+ojCMnwFIznAbLOKK55J3U32vQ8sBe9ka5iH@vger.kernel.org
X-Gm-Message-State: AOJu0YwQLj44RxhXTnLlrcTu4FowNCkTKoG4kx88XLcpW4bfF2vcKSZz
	uaeQaG9A2hMgW9NrBfh7JEa2ly0eDPjixcIvPERp0PpHCuZ/zuXaB5FKV9e+vk0I63E=
X-Gm-Gg: AZuq6aJjtIFKqMj0Ea1Pi5+BxOVVlIpSvOERqjdkRcWc/c7ITECBKDgjr60JF6TZD1g
	6hLetmDmOD9esAQviENqj4/fa0XsN3cuG3v4EVQeFpf0Lf+du1D7QThvxuyu1qwNjKwP75xo/MJ
	1lD4GGDBlObflwWXXGu91TzMSRCE0rJaiLpq3sl1sgs7rXZaO6xCiqXWT6Vf40iHco0en94iCx/
	t4CBeVw9faOMMW+UqWcno1ySxHvqIOyMDpWGd6YJnGHYUvk4fz919UxvYY/MfVZvhquVKCcQga+
	LirRlSs64akNBEM/rKWgijD4yYZ9aoDU6t/n4cS652KnKtOy3BURJxQJbRVnDZChefneoNeEg4D
	lbrwymjZ17PKn2dm64JdCwjT3qO1AKynwAZlLQYLwDuFaabcCjMrM3oIBmny40InbPijpbsCMtc
	8Mpt3N9AuhhLYS6UxebVdr54dvIPKFLNoQz7ulTvOxCgaqhaJbbZjb3WhSu/g4EC+V9uGzTMint
	Xfy/A==
X-Received: by 2002:a05:6214:212b:b0:888:6fde:7b72 with SMTP id 6a1803df08f44-8942d7e0460mr262093776d6.32.1769010098574;
        Wed, 21 Jan 2026 07:41:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8946a1e3d28sm30951806d6.7.2026.01.21.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:41:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1viaKv-00000006EjK-1pDz;
	Wed, 21 Jan 2026 11:41:37 -0400
Date: Wed, 21 Jan 2026 11:41:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <20260121154137.GD961572@ziepe.ca>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca>
 <20260121144701.GF13201@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121144701.GF13201@unreal>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,kernel.org,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15849-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCPT_COUNT_TWELVE(0.00)[34];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: EE70D599E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 04:47:01PM +0200, Leon Romanovsky wrote:
> > We need to push an urgent -rc fix to implement a pin function here
> > that always fails. That was missed and it means things like rdma can
> > import vfio when the intention was to block that. It would be bad for
> > that uAPI mistake to reach a released kernel.
> 
> I don't see any urgency here. In the current kernel, the RDMA importer
> prints a warning to indicate it was attached to the wrong exporter.
> VFIO also invokes dma_buf_move_notify().

The design of vfio was always that it must not work with RDMA because
we cannot tolerate the errors that happen due to ignoring the
move_notify.

The entire purpose of this series could be stated as continuing to
block RDMA while opening up other pining users.

So it must be addressed urgently before someone builds an application
relying on this connection.

Jason

