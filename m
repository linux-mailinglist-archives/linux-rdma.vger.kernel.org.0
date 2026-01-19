Return-Path: <linux-rdma+bounces-15715-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA40DD3B113
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 17:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C7C9302E1EA
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F033B318BA5;
	Mon, 19 Jan 2026 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="k0MwFnzh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20503126A1
	for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839868; cv=none; b=o5V6H1r4JnIzn1gILtml8+IGYUXqzTGmi2MqY9zdemA+upil69p41eYhx+P3kyj51rGC0zDFcSlz0Am0cmdt5ljqXvd40WiKBWhH18x1B3PwK9WMeATTXZEcmeO2vspUc5uR+SZf7UfQwPwV59+ChY/mGnowjUHzqTM4/4tiOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839868; c=relaxed/simple;
	bh=y4swwYbPI6raB2hvkPRsghll5RR/RHHzFup3OVrjU1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFnL5xfCr7MY4xdRV/xyLsmzxzG0B4nDkdCkwH538LWo7R4Tv6eAgdpfJ56lr6ufjtGkpZ6pk6Qo0BRJMTLWPZXU7/SrgRvpaGQ1rKgKL+0Sd/9ffmJWvBWNVGlXGp42tsDAP9ucn5076nwIONQlasn+8PAkBAnxcecJxWKIJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=k0MwFnzh; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8c52e25e636so671477985a.2
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 08:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768839866; x=1769444666; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zCRrpohPCspJo8o5qWVDG1aTKo63AMTSXJRpwyKl02I=;
        b=k0MwFnzhJYQ0FsSCLpzstcTbAPrdHFDOT6N9tTcMow05R5wGoAlhaAT+qQ/XnhKfVn
         +s7cNsxfcUJSJFOrOQByvL8gkjK2pLC88AE3eofHjhr+p490ONx1UjwTz8XFYQeUpvQI
         vkQvbBBEDeQBKcKJue1qLYssmqPS9RO7UhjbaV5WGJfuQrTdviABGjrt++VXzLkWBDsm
         TKofxL6f/hmoYRC8NXavZreJjPGd8PHi/HePCtBfYNQC6EnFmmPqcsLsK46YRJfxIT6f
         4t2JMXUziCtW/6m/+CukzJZ+lc5/HkrMW6LCcpAqDvA/fG+u0q4RWZK2ri43fEoNnknD
         jtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768839866; x=1769444666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCRrpohPCspJo8o5qWVDG1aTKo63AMTSXJRpwyKl02I=;
        b=j8G5SZ3zJBJyfjPXQZBCjyeQIhyDv/MYC1/F8K2cmwYr/AppHz0AHZx/S/59Hs1tlK
         H3D+G5QNmyxTeB3I2TeBqOPm66/FfD1UuLOvTBv3ZJZfXoIj2sKbN0U+pXmGiai02q3y
         genRCdby7cPZHaX9gcR8P/zl60r7Qgwysaz1/BpQQSlsLLlSwv3F4Vwm9h0QKom79fPn
         a+RtHqaZm4rHG81vUtiO1NJKeWdahk6DtxoW6NTFvIkLgz8hORyv2le6UoD7nVWF9ciE
         3mgMy6Ct4JSaPnP/3HO3j5S7oCu1vtbuAioKJfGTcNXlUIpYMts/EdoJto9o2ELxhzer
         dHuA==
X-Forwarded-Encrypted: i=1; AJvYcCWgqkXNoFsm/bx444C6ZQwKxLdgZj1dpbUfHRO9+iIkodm1t9IFJNEBUsJh/zpUVbOuqf0nwzdr9UtY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Orkg+9GuxtMuv9o5wh/0I4/PotubI3wRe2SauAI35D+NRb85
	99uT3vNvX6Cz1OtGotQGxVdAYh2UxQxPFHpUj4/sCaw8G3ZSVTz0hDkqltqa+ffFiUQ=
X-Gm-Gg: AY/fxX7xkM2ipHe9IdXYJiCyrfwQoWvqy2lCtWDatd5mi852BxgykGGwwzwDnJt7UGw
	T2iAh76Wr2ARJOAdPIQAq6Sf95CKFzWnPmj63+kzCuLJY0kYLP0bXqhz0bwo/5l6BBxlQcAKVhY
	ZwNiMkFhv5HBHgRl4wKj7CkbE6qjOvzca2EsGUEpSsZY1UQ0bkU+2NG11dsSfXuUfuE5ZIZ2uVt
	mi5m3JdxcFc0CKjh1cekNDoSgdbOeppfSggugj4223JT+lvqPJG50ENUolw1bkwVvZvPWrtrAM0
	VFoX9bu7A/bt0ZV58rfKefeSJa9di4xSRvXi3ckPIPrn2MCkl8d616UhLEI18ZfOS7EHVnkNedB
	cvhg83HR0ChWd2Te+XtyQT0Q8xnJ3SKPiYZd5X3m2WBwwpGtJ3RTcxG9mPGfeiWvJArv2tLDjpB
	SjWOvKnkXGK86FLeYolc5nqdlBIVR5xZj+dsPnvLJiUHNbWic1zsoInyfIHn0Wpg+Xy5c=
X-Received: by 2002:a05:620a:2a02:b0:8c5:33bf:5252 with SMTP id af79cd13be357-8c6a6963403mr1445548485a.70.1768839865634;
        Mon, 19 Jan 2026 08:24:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a724a484sm800372485a.33.2026.01.19.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:24:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhs3E-00000005I0S-2Krj;
	Mon, 19 Jan 2026 12:24:24 -0400
Date: Mon, 19 Jan 2026 12:24:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dma-buf: document revoke mechanism to invalidate
 shared buffers
Message-ID: <20260119162424.GE961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <f115c91bbc9c6087d8b32917b9e24e3363a91f33.camel@linux.intel.com>
 <20260119075229.GE13201@unreal>
 <9112a605d2ee382e83b84b50c052dd9e4a79a364.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9112a605d2ee382e83b84b50c052dd9e4a79a364.camel@linux.intel.com>

On Mon, Jan 19, 2026 at 10:27:00AM +0100, Thomas Hellström wrote:
> this sounds like it's not just undocumented but also in some cases
> unimplemented. The xe driver for one doesn't expect move_notify() to be
> called on pinned buffers, so if that is indeed going to be part of the
> dma-buf protocol,  wouldn't support for that need to be advertised by
> the importer?

Can you clarify this?

I don't see xe's importer calling dma_buf_pin() or dma_buf_attach()
outside of tests? It's importer implements a fully functional looking
dynamic attach with move_notify()?

I see the exporer is checking for pinned and then not calling
move_notify - is that what you mean?

When I looked through all the importers only RDMA obviously didn't
support move_notify on pinned buffers.

Jason

