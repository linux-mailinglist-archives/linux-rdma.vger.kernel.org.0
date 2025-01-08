Return-Path: <linux-rdma+bounces-6919-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DEDA06290
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 17:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F70D3A48E8
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jan 2025 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6132594BC;
	Wed,  8 Jan 2025 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="P+dMSXpw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090DB1FECC1
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jan 2025 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354917; cv=none; b=c7xaFh62GeUwpiFKvt3E210n6oSupZ6kWg1OedfaopAIxhdJo805UDNvkkkAOgNQom6rI44iCPTm+8zYZqwsUH6hlZsn42SHZdffcziCLSRgKcUGZc62OS9zNK0t3NpEA95evuNmZCGxSdUchz6po42Gv+2NkcOh0orZNUWHhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354917; c=relaxed/simple;
	bh=gffYnheyHmQirnOLrLWnuXR/bCkBh259lAiuaWxaIbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAVjRPwIkbZAsRBQmQ7SX/SOcLbutcP6DZwSyRTJiZ0FSeSmPcLm5y7vdx2bpRwCSMzNBbU+BLYFdARS7+BUi9CEZVcBAnHz2XYG3EH9jJ13NkoyWjoUaZmjrjEWNvj2wcxOGsNbzXY7/H+fGtnGu0LVQrChd4dnIAwykeubkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=P+dMSXpw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43624b2d453so348765e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 08 Jan 2025 08:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1736354914; x=1736959714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0UT5umqpvXzX+OHEo2z2rTpWOE07qIe9i0VrPSb4y5A=;
        b=P+dMSXpwUa4kqEohgFGZ1o55U5BQIhDc1U41dSLrjRAMb0zcJok2n+wX7N8Joenb9m
         MEo9h4u0N17hQiz1qbtDGg6HmfdpV5/9xSET7TXtOULJh5Ix18nHoyueVNSuXteEHKVF
         XtYm9wRgTvgVtx94jPVzBxR6pNBbzKQrPmSeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736354914; x=1736959714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0UT5umqpvXzX+OHEo2z2rTpWOE07qIe9i0VrPSb4y5A=;
        b=ACQ9Vv3ggrBUJBC6YBmBqDnnb4gVT12aguzWrZa5OC8RmzPT26uL35m5BPcuNLFvMe
         2uc9FmIvVWhFrc00ZdEZdOruW9iD0LkvAISIL5ICs/dTxp9xdd2Hqzii6o8Kpr8mrq6E
         fNBFInFTM16C0pcrTQa/yxbWLsnjvY9JRVebJ2FazKpcLo6pKFF++jrlDimWIBnYcJlL
         YhTrOAsmdHCryOsCIP5RwV1fB7BQ+Ez1tLepIHmPWH8TQDypVbORvvcfrNatjG8RYsAM
         9zJxf3VIpXSdFTouFu7eWp69r9cwlPHeuPgA8+nkGNUCvENMCjvxarXwGAgONIfJYA1L
         KYew==
X-Forwarded-Encrypted: i=1; AJvYcCVN4KtqQuEDw9VvcEDtd0ikVoSFIgn/vlS6KHVG14JbpEExJ+736DaOBjBBsOHa10KEU6E8BTFSpdRQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5AHWAPS654MU6xvoshohdSLCCEAST4WjK2OI8O4FUwQILRFY
	JAKTY68BBlp8BUqIildc1HinDoDQanqvtl0GiKuvoMQiMfjJcftECwV0rU8F+D8=
X-Gm-Gg: ASbGncuomxv5T1RG9aEZKW48og8aLifnTL54zzVKSHx8YzDvqD86gy2siPQ50QP5V0c
	TKPkinoGtRh6f29kcsl0biZe+rrZLFahQ/a3H1ne9mvgxHP3ZrKpnsbxDorWww509suvQJQlUKR
	FGyOZ2hlYVarQJRRqQfzKgFF3IXGeVk05UlgMOr+EDDUsA4/GNoWFZa7yETizn3DusjYkvF5auO
	wCTj82Ck0DnMiIl/JS0/CZ1KjSWPm9qajq/evauf4n1U3OSeKKVet6Qfl3bFTbzxWiy
X-Google-Smtp-Source: AGHT+IEu1vDzbKs7I7Y2fxV73AUw4WocoWZ3S+yonWf2wLofuc/3i9UvSC6dX6IXU9yETNGe3ZMUpQ==
X-Received: by 2002:a05:600c:444b:b0:434:f586:7520 with SMTP id 5b1f17b1804b1-436e2679a31mr29981125e9.6.1736354914223;
        Wed, 08 Jan 2025 08:48:34 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddefcbsm26275945e9.22.2025.01.08.08.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 08:48:33 -0800 (PST)
Date: Wed, 8 Jan 2025 17:48:31 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Simona Vetter <simona.vetter@ffwll.ch>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	Wei Lin Guay <wguay@meta.com>, Keith Busch <kbusch@kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Dag Moxnes <dagmoxnes@meta.com>,
	Nicolaas Viljoen <nviljoen@meta.com>,
	Oded Gabbay <ogabbay@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 0/4] cover-letter: Allow MMIO regions to be exported
 through dmabuf
Message-ID: <Z36sXzCpRhh_WXMY@phenom.ffwll.local>
References: <0f207bf8-572a-4d32-bd24-602a0bf02d90@amd.com>
 <C369F330-5BAD-4AC6-A13C-EEABD29F2F08@meta.com>
 <e8759159-b141-410b-be08-aad54eaed41f@amd.com>
 <IA0PR11MB7185D0E4EE2DA36A87AE6EACF8052@IA0PR11MB7185.namprd11.prod.outlook.com>
 <0c7ab6c9-9523-41de-91e9-602cbcaa1c68@amd.com>
 <IA0PR11MB71855CFE176047053A4E6D07F8062@IA0PR11MB7185.namprd11.prod.outlook.com>
 <0843cda7-6f33-4484-a38a-1f77cbc9d250@amd.com>
 <20250102133951.GB5556@nvidia.com>
 <Z3vG9JNOaQMfDZAY@phenom.ffwll.local>
 <20250106162757.GH5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250106162757.GH5556@nvidia.com>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Mon, Jan 06, 2025 at 12:27:57PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 06, 2025 at 01:05:08PM +0100, Simona Vetter wrote:
> > On Thu, Jan 02, 2025 at 09:39:51AM -0400, Jason Gunthorpe wrote:
> > > On Thu, Dec 19, 2024 at 11:04:54AM +0100, Christian K�nig wrote:
> > > 
> > > > > Based on all the above, I think we can conclude that since dma_buf_put()
> > > > > does not directly (or synchronously) call the f_op->release() handler, a
> > > > > deadlock is unlikely to occur in the scenario you described.
> > > 
> > > Right, there is no deadlock here, and there is nothing inhernetly
> > > wrong with using try_get like this. The locking here is ugly ugly
> > > ugly, I forget why, but this was the best I came up with to untangle
> > > it without deadlocks or races.
> > 
> > Yeah, imo try_get is perfectly fine pattern. With that sorted my only
> > request is to make the try_get specific to the dma_ops, because it only
> > works if both ->release and the calling context of try_get follow the same
> > rules, which by necessity are exporter specific.
> 
> We already know the fd is a dma_ops one because it is on an internal
> list and it could not get there otherwise.
> 
> The pointer cannot become invalid and freed back to the type safe RCU
> while on the list, meaning the try_get is safe as is.
> 
> I think Christian's original advice to just open code it is the best
> option.

Yeah open coding in vfio is imo best, agreed on that.

> > In full generality as a dma_buf.c interface it's just busted and there's
> > no way to make it work, unless we inflict that locking ugliness on
> > absolutely every exporter.
> 
> I'm not sure about that, the struct file code has special logic to
> accommodate the type safe RCU trick. I didn't try to digest it fully,
> but I expect there are ways to use it safely without the locking on
> release.

Hm yes, if you use a write barrier when set your file pointer and clear it
in release, then you can use get_file_rcu with just rcu_read_lock on the
read side. But you have to directly use your own struct file * pointer
since it needs to reload that in a loop, you can't use dma_buf->file.

At that point you're already massively peeking behind the dma_buf
abstraction that just directly using get_file_rcu is imo better.

And for anything else, whether it's rcu or plain locks, it's all subsystem
specific anyway that I think a dma_buf.c wrapper

Not entirely sure, but for the dma_buf_try_get wrapper you have to put a
full lock acquisition or rcu_sychnronize into your ->release callback,
otherwise I don't think it's safe to use.

> > > IIRC it was changed a while back because call chains were getting kind of
> > > crazy long with the file release functions and stack overflow was a
> > > problem in some cases.
> > 
> > Hm I thought it was also a "oh fuck deadlocks" moment, because usually
> > most of the very deep fput calls are for temporary reference and not the
> > final one.
> 
> That sounds motivating too, but I've also seen cases of being careful
> to unlock before fputting things..

Yeah I think knowledge about this issue was very uneven in different
subsystems.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

