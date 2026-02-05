Return-Path: <linux-rdma+bounces-16584-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKWiFqWnhGmI3wMAu9opvQ
	(envelope-from <linux-rdma+bounces-16584-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:22:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF63FF3E68
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F7A0302AD0F
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39453EFD3B;
	Thu,  5 Feb 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dBYGQPPv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3BD3EF0C8
	for <linux-rdma@vger.kernel.org>; Thu,  5 Feb 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301274; cv=none; b=qcK76fNFZ+KBKCPFNPcNmid/+HfnLGPw9yID6jujklSNy3kfbuG7TV6R84VwAbidQ2GGVsLgayurDrCjWVz8LehkMY3zNWPPJEJTCLMWyujkVEiKGxxNk6AhS3mZuiaFHgRQm8YW56f5dpCUSQcV1iwyfCsG3QD365PlvSDc72E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301274; c=relaxed/simple;
	bh=2XDmVAyyw3kHSva2SZjpEPftSjaLFto+qTX6dWpgwkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+S9sbQNCMk4PN2s/KYhWZIAXnjxmg43l9quQczuryFNlRNo8tLldX3Zwuxcll5mbrFbrRW7razE8PlnI+K9Ip3vBIivZHiGfJie8oJOtUwnYfAwtfrs4MYE1CmVfjDQYA2emn1We3hRTBNUMh2bKPZn1aWGjts7Cg5NCMPhZNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dBYGQPPv; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-894770e34afso13634176d6.0
        for <linux-rdma@vger.kernel.org>; Thu, 05 Feb 2026 06:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770301273; x=1770906073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MSUoQMJoCCNydU2DcwMWqdKRWnt0MqAVvIGN6ESmMGo=;
        b=dBYGQPPvUly5VvEqhvl2u7nK0k0qRi4RMkSn5JaxEDU2nUWmV8/KnZlR4swFyjFACU
         4LTMGns51pld42g426iHpFALujuMgFaW6Dmzu1qZzxekH0GxRDte3EoDkhGRtYD0dqwN
         9aResQfBpcjtt7jkIB1l1DJS0yS+k9v17AT4s4+TB5BUpbvADfxAumefJFkmMFluAg/D
         H2yovYYLsqxkNa9DeEp5HRmuiPqDFmfxnIC5He88AYqfjdb7tdBceXzby7SF7J35qG3B
         xpD2/m2gMonD/zuUz99DDpkKhlpEEB8TU5O5FLSbNZ1MWKvdvaByduuDaOgoCLIMRJdH
         nDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770301273; x=1770906073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSUoQMJoCCNydU2DcwMWqdKRWnt0MqAVvIGN6ESmMGo=;
        b=Pj3kYBv6Am5QAB6davhQO8oYulXroatYZRQGuu1aTXyXSYbXLV5LDUnAB1dI0wG40c
         2HMR0UJjTYg/V9nnBsKy91bDf/Ql6ifuvFwVE1xtmqwQmfnnHuy191L61yV+D8yvVdQE
         TsAjiH5IFZDMSCUA8IvBL2zpfLTxdUz7UFRuu1fEyy0NHZF/UtF0YOLRCqAYhRvJpKr7
         3HSm+KOIsUVaf0GEPRaDSj/yqB+2zMT+SwRGzDZgwik/AlZtJiYGQHA/0aR6xvpu6T9o
         ezJSHbqcnm0fSwiPqSj7xqkzVi8mm0ueN/A9ce0F9jQJayBYsxdZobZ2nnhKm3b/1045
         HSew==
X-Forwarded-Encrypted: i=1; AJvYcCWeK6iJENwmfa+YapLXhZUJwtPehKxPIjdkpFxCCfub+Zc7KZKSxZRA2+3I0g3sMaFOW6QZmPknQ4nP@vger.kernel.org
X-Gm-Message-State: AOJu0YxZm5kIu98FTurjmAJmGGuE2U1p4uifVvN3Cj/DFDfofCfz2fro
	+heT8TZwHn1wm9je37AcGHRyZF19t6qOdoSvlfKdEettwm8Upp13btvznP3Awb0hXV4=
X-Gm-Gg: AZuq6aJfrrLSWyNBomdswU24s0q39JX5eNWVznqPdK185eTJGHyZP155+Bf2d39L0Ej
	n7X8ODmL3bUls/RZxeIoApGK45a5phuvePSyIoBm2Peq4NpPR4o46S1hHmCdxmj2REgbzXVWvWC
	x9+B2NWQQS1lb9SEc8TwENaVFj9UzoCPsqKrkDCMMDKYAJNTJuJo1+c7Cx1hZjETABP5ZD8gRq/
	Y/FVmdyiF+eu1AfIeHe5wi2gm3SytGcypvbso93uwSkuFUkqktIukohIxcEJ66FDjDUi3tr1+6W
	yiLnIq/iwoYvDEI/GT4hWpdWzmVSZpzUrEnEAEUR+/KRRKB1Zk8bQQJXDdCSE0iSeuRnbCXtIKc
	AIoZEhokaUudkZatmdROQZm5QtygvzPV/vGl7/p4tlUgWwaCvPPUvOTsIT3ebhiM6Fr8FdXd0I0
	ZwqK83oDEbuPs52xeMa0fMb6miyHwXOIgVRH+khO4yF7YyJ1FlZj57hHbAidLj9/gFnQQ=
X-Received: by 2002:ad4:5cc6:0:b0:88f:ca72:6ae8 with SMTP id 6a1803df08f44-89522189787mr84672066d6.45.1770301272999;
        Thu, 05 Feb 2026 06:21:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521bff53esm42252276d6.8.2026.02.05.06.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:21:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vo0EJ-00000000kPY-3gpa;
	Thu, 05 Feb 2026 10:21:11 -0400
Date: Thu, 5 Feb 2026 10:21:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Williamson <alex@shazbot.org>, Simona Vetter <simona@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
	intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v7 7/8] vfio: Permit VFIO to work with pinned importers
Message-ID: <20260205142111.GK2328995@ziepe.ca>
References: <20260131-dmabuf-revoke-v7-0-463d956bd527@nvidia.com>
 <20260131-dmabuf-revoke-v7-7-463d956bd527@nvidia.com>
 <fb9bf53a-7962-451a-bac2-c61eb52c7a0f@amd.com>
 <20260204095659.5a983af2@shazbot.org>
 <ac33ad1a-330c-4ab5-bb98-4a4dedccf0da@amd.com>
 <20260205121945.GC12824@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205121945.GC12824@unreal>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,shazbot.org,ffwll.ch,intel.com,linaro.org,gmail.com,redhat.com,collabora.com,chromium.org,linux.intel.com,kernel.org,suse.de,8bytes.org,arm.com,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-16584-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anongit.freedesktop.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: CF63FF3E68
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 02:19:45PM +0200, Leon Romanovsky wrote:
> You don't need any backmerge, SHA-1 version of vfio-v6.19-rc8 tag is the
> same as in Linus's tree, so the flow is:

I'm confused what is the problem here?

From https://anongit.freedesktop.org/git/drm/drm-misc
 * branch                          drm-misc-next -> FETCH_HEAD

$ git show FETCH_HEAD
commit 779ec12c85c9e4547519e3903a371a3b26a289de
Author: Alexander Konyukhov <Alexander.Konyukhov@kaspersky.com>
Date:   Tue Feb 3 16:48:46 2026 +0300

    drm/komeda: fix integer overflow in AFBC framebuffer size check

$ git merge-base  FETCH_HEAD 61ceaf236115f20f4fdd7cf60f883ada1063349a
24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
$ git describe --contains 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
v6.19-rc6^0

$ git log --oneline 61ceaf236115f20f4fdd7cf60f883ada1063349a ^FETCH_HEAD
61ceaf236115f2 vfio: Prevent from pinned DMABUF importers to attach to VFIO DMABUF

Just pull Alex's tree, the drm-misc-next tree already has v6.19-rc6,
so all they will see is one extra patch from Alex in your PR.

No need to backmerge, this is normal git stuff and there won't be
conflicts when they merge a later Linus tag.

Jason

