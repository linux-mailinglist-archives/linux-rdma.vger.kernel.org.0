Return-Path: <linux-rdma+bounces-16521-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBKpNrZLg2n4kwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16521-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 14:37:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A89E687E
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 14:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D16D300DA48
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B693F075C;
	Wed,  4 Feb 2026 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Uv0WIWUc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DCD27055D
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212126; cv=none; b=HFqWtSa2hnS/fG08lS1CpzNPWvCPEs8TAvNZxtr9Cow1zWh0IfQpEFMIPMke3ua3dIfYWUY5KaEWsD//NAfn+jF7UCnTXRaGo7q5WOWeT1DG7ccA6vzLxopQnFkneJaLZ4ezrFUc5AdcWG4dUC0whbCzESSl9il1t72P5DF9eZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212126; c=relaxed/simple;
	bh=H/kTkGZP8AkvmyFzU3sXO08Z5L27cMenr5LlCq/UphI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHuVhLamyBBqpyiLArvhq1By+3fKHTA0pR4rKN02J3kvZw+0GgWk4iSiBpQsVnO2sMiq8amxDCPdf2AJ4dmwjj9Vcebs8V50ixX/hcC4ZJ0ChYPXGEzbPZSAMmohWWx6bOeg0fXKn4hi51ACrezCvobLQnaObp4kG9zIkqd9PvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Uv0WIWUc; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c9f6b78ca4so721831385a.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 05:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770212125; x=1770816925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cy8s41Ej9e437sslVRAHtURD2nYFlOPaZF56zUYznoI=;
        b=Uv0WIWUcqJtPXKa/5Y7ubmiDv0M8T+sBw1uP2dAfNaKLquu1fLoQKAHmC/IPmVrWqC
         5tWvyrmfii+V58Isx8AjekbvEEXTun3IiyFlip6GExElerbAkxZP4NI3Hd0F3oriQ+CO
         huxr/QhQ2zEgauiFRlsDaxzXkEQwWbqkmlxNAazL2vfE+Rrydjoj2jCuzWZut7u/trmJ
         JZURS7iHKu6X9E5OtW2VnFzp4SID4WKhMRBz0+mx9vj7TjxtkGVvptuDo0MUaH+4N62Q
         dSkX82jwu3reH9HUOItc1utLRRMj9Ds+/4kG0qtsIdGyVJfF8KeZQ6Y96Lqv55UIV4An
         TwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770212125; x=1770816925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cy8s41Ej9e437sslVRAHtURD2nYFlOPaZF56zUYznoI=;
        b=s3ZS/UN39AdXv490A2c9z063jIGCffxp/gDd2iOC50AAyE1xWyMker4/gLFYCrVsro
         7oiLHVCgwcB9NtBFLVUpKX5Ueb/ivKGiaL+AeH4/+Hf76e5RiJSF08LNOxFJepaNJo+h
         tgo8IZXy/t3dEyoBIgwICoUvgpndIV028A4oHxIeVrN6RE8ZUbuUDhzTbqLovVZUfPP1
         yccM2Mj7ApA7FENMSZV9tgc97epPGuFAWl4UDpxCSCK2uTjuntNU3OOZWjcuzk6eTtuh
         dXshiq+fLQFvJ9D+8Dvqj6XSfWT+kQ46aZD9sT9gozmdMaakAGXo/YO9sQhxEGHEFYdc
         tIzA==
X-Forwarded-Encrypted: i=1; AJvYcCXqrrm1aGVGUNIQJNcTL0hYBXbbKhNYvENMCXRiBZrY/FRz7RUPYEBfsCnNedPitm9/8dgYxfdL6Bru@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdWoW6SbrkVpbGCceuztJUMAFe98vb6yDJW8bOCn5ITeSctQU
	OCEEf2frlN+3RS0XpEAdNr4JMd7jy+5NDy+I7Cm6fn9tLJqERj9dsjbxXCHm9hIISek=
X-Gm-Gg: AZuq6aK1fPfLyW25S17McTG0wM//L2yrl8h6PfxEiRKGgWE8jcsnj5dh7EiW/ZXzYXi
	mwz+MfNCAsyHMh20n129nXa4ixlbQocvyKV4ZfF3vqg60yU3QmO8DKUYyCpcpVeJWn2YIC7uQUm
	HxQ/H9Uz3cUMwmpdbl6QXiuxxRQ8IaM41ZFJoJtGZwp+FklzxY3awiRAOq52M+F2MxD0MWDZCEI
	w0++QyE5aWJdqudohgwRbDj9OuZN0/3o07CC9WIIdddilgpicbCZePSrKKlhCp30tSjLYI0toUE
	OoAGqDXi8owZxk6Ui5T+mzEMTyFd3HJvmTKAtyCqI93QX54a9ej6+wqR57BD+3a6Ui1ViiMVQdb
	d9vBGsirgRC4dgFA3YZ5CIq61xZTLc4tZgPfqjIb4sn09DZQnsJ9Xt3LwAQ3M0cYT/V29oNdOUE
	oNBOT4T6DODvzlpScJlHJKXnv1+DeGcZ1SmYuAaWWaP9/PHEJeSfgD7JpAi2IhXwN5jAM=
X-Received: by 2002:a05:622a:1aaa:b0:4f4:d29a:40e7 with SMTP id d75a77b69052e-5061c1c1dc5mr32950871cf.74.1770212124739;
        Wed, 04 Feb 2026 05:35:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c17babbsm16346801cf.15.2026.02.04.05.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 05:35:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vnd2R-0000000H0ml-1uPP;
	Wed, 04 Feb 2026 09:35:23 -0400
Date: Wed, 4 Feb 2026 09:35:23 -0400
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
Subject: Re: [PATCH v7 0/8] dma-buf: Use revoke mechanism to invalidate
 shared buffers
Message-ID: <20260204133523.GD2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260202160425.GO34749@unreal>
 <20260204081630.GA6771@unreal>
 <6d5c392b-596b-4341-9992-aa4b26001804@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d5c392b-596b-4341-9992-aa4b26001804@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,amd.com,gmail.com,ffwll.ch,redhat.com,collabora.com,chromium.org,linux.intel.com,suse.de,intel.com,8bytes.org,arm.com,shazbot.org,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-16521-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 59A89E687E
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 09:54:13AM +0100, Christian König wrote:
> 
> Mhm, sounds like AMDs mail servers never send my last mail out.

Oh :(
 
> As far as I can see all patches have an reviewed-by, I also gave an
> rb on patch #6 (should that mail never got out as well). The
> discussion on patch v5 is just orthogonal I think, the handling was
> there even completely before this patch set.

Leon I guess grab the reviewed-by from this email and we have a full
package if it needs a v8

> For upstreaming as long as the VFIO and infiniband folks don't
> object I would like to take that through the drm-misc branch (like
> every other DMA-buf change).

No issue here, both subsystems are waiting for this..

> So as long as nobody objects I can push that today, but I can't
> promise that Dave/Linus will take it for the 6.20 window.

Sure, thanks, and if it doesn't happen for whatever reason lets just
consider it pending for the next cycle.

Next is to work on the dma mapping type, I should be able to post a
rfc next week for people to look at.

Thanks,
Jason

