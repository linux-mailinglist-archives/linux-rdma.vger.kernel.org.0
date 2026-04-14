Return-Path: <linux-rdma+bounces-19343-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAXGOh5c3mlfCQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19343-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 17:24:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7343B3FBBC5
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 17:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9304D3059318
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8C3E958A;
	Tue, 14 Apr 2026 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LOR05mK+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEDE3E9580
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179489; cv=none; b=QHxWNIctt16ZZZs7FyLcgz0N27buvE3kWbzyjq56ymwV6WBRGf3UXEh2GC9+2BUqUjoIVizb+3VV6Cndl//ZNl3fMcOv5z9AZjsEAJMkL3Y2lYdOwJMHj727o7UgL5UfiJg65guUgkr2XNQb7pXMt1B4I6MNjBriQnLHGcG//Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179489; c=relaxed/simple;
	bh=wtmKouu1J13QOKEWpC/Rhgp+PUitDlJyO7jIdqkEIVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsTfZhP5UNsnsSLpRj6TpzYZmvy5ZE5lyn5Y5w4HFZdFGxfM591T9NU0kFJ+FYjn99J4nlOG3Ts1PX5AfNBHNA2HOVpDzUgMa7GQF017CvO7NltKBMTV2mwwtnAUxSmsSck2dJ6xVqviwI3LCTeU2B76MvFZtnzSSEfmcMrAGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LOR05mK+; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso26922226d6.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 08:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776179487; x=1776784287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYWxsN8NcBk0hkmTwyrJ9dFetqgCC/fPQOeOuZaqCQI=;
        b=LOR05mK+HpHUZy18w4Dk7mDIMTVt2CqGJv6K1mBA55KO1uywBz8h8IBKBzhn4aHAO9
         vH0NS+fuTcuiKi0VoxchkLiUtLN6rj7dqxajvrCuQyW0IdXx5NElXiYa4YWn5DDd/BtR
         WFgWMEErubR+eerVtOWit7waU1BfplQlQbeI0ukBBX1Hfp8klPZxXlCJOs/B4824tYD6
         vOMiryVGnE37XdbdYE5g3wxBwhLNymPEJbmA6ALYM/d6B+I5HUMss6Fc9WF0N1a3VH7u
         OcXMJI2BDU4/8aMgg7lU7yp0PYDLaJwX/fP8wrU46jXXqbpXimJy41RSnyg/4SlBtXPv
         9LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179487; x=1776784287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYWxsN8NcBk0hkmTwyrJ9dFetqgCC/fPQOeOuZaqCQI=;
        b=GquMixKFrZ9ZHymafsRqr2sHEPE0iDALcn1Pp3qMGGx+3vKHG5VT3099DKW/PTI45B
         7Ktm4RLb/6KrIoxxvhSKtwZ8os1+auG4m1iOxe2uhJw/bynWoa5NSo7wToQvLq27N4Wx
         /9Lzpktc4L6dRxUUAk1E24GUV+QCsFmUejVCKCdi9Zqo7CERSB/ITbx30+TTCiEjYpwA
         EpPXs2PtvL5n2GCMwzA+56efHK1P4pMA68cgh4tRqDUJWeYjL56zlBcVgFArg7crRQA9
         wSmcGP801YlSkcXSHtkQudVh6fo1goQnUR0FRH2EZ5hYQJihuCDVbvfPoAXZK/3ETNCq
         w6VQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NcamPfq9knORIPyUAHv6WDNEGFdKGgpB/p9TxAiDyaydgcy8RQ4NVByOfOLAlo/hGAF8O6gbxCK39@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IHegQNFOMtvix9cDlF+APGXzYSK+H74Lgr576jLvPDc3r1/b
	Cq/LGtPbQWLXesGIO7E9eCoxsNE7QLR7yfYYdCJ2yFXZ/UvT9f534DiW1dInjxRtg2k=
X-Gm-Gg: AeBDieujcRI4zMHDpGw6GItMb7Ploo/3ANSIcSmhno1rXmjhHErtcYe0nprnTBtcS1l
	T/W79m5ZsGXYP+L4135bvAa9L3IJfGUteNRGXXip8EF3Uq+WMCqEpGdYCYAfkdlxNZRseWS78I0
	GsxljkZc/M2WadPgVSRmtAYnK6iyBOOTRcOWgEGWttc4et29OgKByELZblGbG+u5wjbXS1OXZ3f
	hgML89YQmH217rhuF3DBoYCjXWqGf36uCVjuy7QjyHO1bSSd8gKLhmKkYhR3TOjMy6fJ6ZoHxuu
	BfyT33/kW/dN51Fd7B8Ou/CL3eIMrBvLVAPpatHC4IOsTqSvKMWkstySMTK2LQh4aP0H6D1bDZX
	zt+6715fk886+CG9SdGDCIwUx4nVmttNcrzhEfJtBGdtmfqxHOrQPFCJ7GlOrOnWGMk00eN0tRQ
	HEASCVS9OGrHpTaTze3Jm/lZ23T9xfAz0O0UFvAyoNUMP7f45cmSKVePCsOHZMHuMKHrPtU/yUK
	1oXkA==
X-Received: by 2002:a05:6214:4a01:b0:89c:8709:d238 with SMTP id 6a1803df08f44-8ac862b51e2mr284214856d6.40.1776179487026;
        Tue, 14 Apr 2026 08:11:27 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849e35afsm159006516d6.3.2026.04.14.08.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:11:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCfQD-0000000BNfx-2aVf;
	Tue, 14 Apr 2026 12:11:25 -0300
Date: Tue, 14 Apr 2026 12:11:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhiping Zhang <zhipingz@meta.com>
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
Message-ID: <20260414151125.GF2577880@ziepe.ca>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
 <20260413100152.GG21470@unreal>
 <c3a6c6ca-3b71-476c-947a-5f2393d046bd@huawei.com>
 <20260413191930.GP21470@unreal>
 <b95ced54-339f-4859-b3eb-8bf261393ffc@huawei.com>
 <20260414085723.GR21470@unreal>
 <84bf119e-fa8c-4c97-9197-3377b7e2b250@huawei.com>
 <20260414103547.GA361495@unreal>
 <11eaea26-ec10-264a-db1e-951f6b46078d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11eaea26-ec10-264a-db1e-951f6b46078d@huawei.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-19343-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: 7343B3FBBC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 10:46:00PM +0800, fengchengwen wrote:
>    We have a real platform requirement:
> 
>      * 1. Devices in TPH Device-Specific Mode with no standard ST table
>      * 2. Steering Tags must be obtained from ACPI _DSM (kernel-only)
>      * 3. Devices are fully managed by userspace drivers (VFIO/UIO)
>      * 4. Userspace must program STs into vendor-specific registers

No, this is nonsenscial too.

If you want to control the steering tags for MMIO BAR memory exposed
by VFIO then the DMABUF mechanism Keith & co has been working on is
the correct approach.

If the VFIO user needs to control steering tags for the device it is
directly controling then it must do that through VFIO ioctls.

Nobody messes around with other devices under the covers of the
operating kernel driver. Stop proposing that.

Jason

