Return-Path: <linux-rdma+bounces-7793-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9471FA3835D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 13:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7AF1893B49
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB4421ADB9;
	Mon, 17 Feb 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oERNcDvs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31B219A66
	for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796566; cv=none; b=UxtAR/QRxTjuGeCMYgrVZhLN0Gtyk+eQ2b+WflNmDCOK/2iXLHUBA2OqFUl0L2mZEsT7lr2vEicJfd+jeJUJL5NLJxXETxABfeInfW59wouhXX+nkftBCmGBKrPYlublhlvq7hacQsToxqzQ6pciWNxIkUcFGy2xoWU32dHmRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796566; c=relaxed/simple;
	bh=bHiqDRvc1mhDBHiIQVyYyfXBxjcUKSSG8qBQZ4+CDoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAmsahHIH/rq9SPWuD4SaRiKS9EYUxmFr+h0ZmGs/NKd87UjRme6S0LP5Pc8oFV9ZG/dumX0uU1nkHYpWoFTH4W1oweQQ4AykKMrargKmcyiJzXpe7u9J8IZaHK6TamWzTWiJAnFDryOLM3Vay3t0F7vj8Pt/LH5Xy4ynai+48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oERNcDvs; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f325dd90eso1353956f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 04:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739796563; x=1740401363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wmKKVjUehtS4u8tMOfG7kOlQSPuERUC0wbaOm58IPWU=;
        b=oERNcDvslrcUvl8V2WHrDCfUBqoX690LCOwbQBjG4v3luwTFtpeeagSm2FTUCAEFAX
         xYsz0BpSGZ9NBflYPKZInpMkPQxofgZ1mqSd1wyWsfzqQNojeB2ZNR/zelfrUZjQRQuo
         lNp4j2yAiYmKn3jY173rJJlm2JE9avXzeDrsm3DIELPsr0+9Ii3dDd7/OxNHhJIp6Vnh
         eN8pMIS/3HAIyGADUyr0THwdQ20XvptpPkRnSoVynl58Xs7j5bomSCS2GYY2ah4dibBB
         V8mH5GBJkX+MHnT8RUO/z/MHRT1BeKpq10Z7yhyItGaanpnGlblZZi3mExdVe6c4uWRJ
         MnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796563; x=1740401363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmKKVjUehtS4u8tMOfG7kOlQSPuERUC0wbaOm58IPWU=;
        b=BePSOhCQnzfHIXzShY2gS8TIH75tjs8Im9Wk3Fh5Stuf1Oq08AQYtm9sx5GqFbtJz7
         S6UgF1UXq/fhSmKey4CiPHaSOuZbUwTuSvpe6pr9fj89RTaG2CJay7fYShEc6Mms1rFr
         nedXyL3I8AGClmhoar1eEa7Q2qwNkvcZkbQMS7n9C/uO6Z4PtkxLMp9ROwy2kpuorAqY
         1ZwCv+j8CmGv7kFhXJ0dfF6Gv/FvPUOUfFx5eRwgEXdbk6yytsa/wq4ofrEK5BLPUsRp
         77a0NicqANSg1cZ+53RQpZ5N2ptsYHZ0KxVsXn+b660vcxBlKXXFJdwN4lsxk1E2M5AS
         79Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWiGfN05I9Bhf/KUlhCFpPUDlasrd9JVitZeqgxBpTJ8WvFwMNM6fvCJut+lCOUg2ydtQEt5LUbtySg@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLzSZnmhCS6xajsTX8BTriOVPhsSkFOR7xCuVe9GLFM0M+J1b
	7pfYNcevMrunA41N3sWavNe5dBtzG2uPHJS8i9V2Jl7i4OS9yv0O8tyiWCL597s=
X-Gm-Gg: ASbGncudsHSIkinerNTF/KiQSumTPxYWarz5YpSX8ufBKkAflD0TC5VGel32IKh5OCD
	f7bs0HYkJ/LM5xj43rnfYc6HnA5n8+hecL+We/sUD9t7T/XFGSg6K4h/UCfkia75osVV5/z1AGP
	KwVgyr23iDe2Wd3z+8tOHHto3Xag+bBukCs6T3qlFhNdLaQPA4ixtCjyX2yVD4f2+eXidDiOwD7
	/ZSWUaAAzcggnzGisTcXDyqUJdfBaMrS9dpcbIroywsEzuVsx/WVJ4JpkVWXuVpV5PbTrDuA4Pf
	KiuGHCTHsaTN63mr9w==
X-Google-Smtp-Source: AGHT+IG+t23B0+CZfK+bvk75oBr8zrz/PAsau7x36xGrXz0Kh9HYWs46MPNjv6SioOyW10077oLjnQ==
X-Received: by 2002:a5d:530a:0:b0:38f:2b59:3f78 with SMTP id ffacd0b85a97d-38f33f54f2bmr7539978f8f.45.1739796562469;
        Mon, 17 Feb 2025 04:49:22 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd46sm12190378f8f.21.2025.02.17.04.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:49:21 -0800 (PST)
Date: Mon, 17 Feb 2025 13:49:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, 
	"Nelson, Shannon" <shannon.nelson@amd.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, 
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>, 
	Andy Gospodarek <gospo@broadcom.com>, Christoph Hellwig <hch@infradead.org>, 
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Message-ID: <ccdz4sq2dzclxhevnj4ecfbehgtbiiw4pxtwctvknjzlvp72fl@lvfpjzfekm6z>
References: <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org>
 <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org>
 <20250208011647.GH3660748@nvidia.com>
 <20250210170423.62a2f746@kernel.org>
 <20250211075553.GF17863@unreal>
 <b0395452-dc56-414d-950c-9d0c68cf0f4a@amd.com>
 <20250212132229.GG17863@unreal>
 <Z66WfMwNpVBeWLLq@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z66WfMwNpVBeWLLq@x130>

Fri, Feb 14, 2025 at 02:03:56AM +0100, saeed@kernel.org wrote:
>On 12 Feb 15:22, Leon Romanovsky wrote:
>> On Tue, Feb 11, 2025 at 10:36:37AM -0800, Nelson, Shannon wrote:
>> > On 2/10/2025 11:55 PM, Leon Romanovsky wrote:
>> > >
>> > > On Mon, Feb 10, 2025 at 05:04:23PM -0800, Jakub Kicinski wrote:
>> > > > On Fri, 7 Feb 2025 21:16:47 -0400 Jason Gunthorpe wrote:
>> > > > > On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:
>> > > > >
>> > > > > > But if you agree the netdev doesn't need it seems like a fairly
>> > > > > > straightforward way to unblock your progress.
>> > > > >
>> > > > > I'm trying to understand what you are suggesting here.
>> > > > >
>> > > > > We have many scenarios where mlx5_core spawns all kinds of different
>> > > > > devices, including recovery cases where there is no networking at all
>> > > > > and only fwctl. So we can't just discard the aux dev or mlx5_core
>> > > > > triggered setup without breaking scenarios.
>> > > > >
>> > > > > However, you seem to be suggesting that netdev-only configurations (ie
>> > > > > netdev loaded but no rdma loaded) should disable fwctl. Is that the
>> > > > > case? All else would remain the same. It is very ugly but I could see
>> > > > > a technical path to do it, and would consider it if that brings peace.
>> > > >
>> > > > Yes, when RDMA driver is not loaded there should be no access to fwctl.
>> > >
>> > > There are users mentioned in cover letter, which need FWCTL without RDMA.
>> > > https://lore.kernel.org/all/0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com/
>> > >
>> > > I want to suggest something different. What about to move all XXX_core
>> > > logic (mlx5_core, bnxt_core, e.t.c.) from netdev to some other dedicated
>> > > place?
>> > >
>> > > There is no technical need to have PCI/FW logic inside networking stack.
>> > >
>> > > Thanks
>> > 
>> > Our pds_core device fits this description as well: it is not an ethernet PCI
>> > device, but helps manage the FW/HW for Eth and other things that are
>> > separate PCI functions.  We ended up in the netdev arena because we first
>> > went in as a support for vDPA VFs.
>> > 
>> > Should these 'core' devices live in linux-pci land?  Is it possible that
>> > some 'core' things might be platform devices rather than PCI?
>> 
>> IMHO, linux-pci was right place before FWCTL and auxbus arrived, but now
>> these core drivers can be placed in drivers/fwctl instead. It will be natural
>+1
>
>Fwctl subsystem is perfect for shared modules that need to initialize the
>pci device to a minimal state where fwctl uAPIs are enabled for debug and
>bare metal device configs while aux sunsystem can carry out the
>spawning of other subsystems.

Wouldn't it be better to call it drivers/core/ and have corectl or
corefwctl ?


>
>> place for them as they will be located near the UAPI which provides an access
>> to them.
>> 
>> All other components will be auxbus devices in their respective
>> subsystems (eth, RDMA ...).
>> 
>> Thanks
>> 
>> > 
>> > sln
>> > 
>> > 
>> 
>

