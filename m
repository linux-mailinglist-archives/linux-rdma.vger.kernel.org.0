Return-Path: <linux-rdma+bounces-6836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACF7A024C5
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 13:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3C43A566C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 12:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7311DC9A3;
	Mon,  6 Jan 2025 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ZKMdps5r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996471D935E
	for <linux-rdma@vger.kernel.org>; Mon,  6 Jan 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736165114; cv=none; b=C0TuNvP7CyaInlJ1baBggIplKNC9KUI70Ho1HXKz8vyoGDBNINxlBQaFl7CPkGexxu43OknBrqXSIv9iYaP2cee+nIiC+P8n9ynb8WVV/BoU97qbHx/ZiYGqStSaA9OB7oWKlTRKbM4oF7G7mzbHwNL7UvBPV+mxq48DT53htf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736165114; c=relaxed/simple;
	bh=0iRa6EEImH6dlHzlicrBzOn2LQ3TjBMLZL0GCnr0KlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG69Nk6aRN1VzNQNhr0Dq5y3dKol/pzWS4UTJWpDlY5A9RyNizMmXGDu8eBBVgqi+UNpIPrYIYH03JkLrc7YZwifb6LzQgUm95rzAw+UwaMLyquCuN9OHlCF7as4v1WV9SR62EILGpsOJ7pvu8cJ1vjqag+aLMDba3hPAOhZtL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ZKMdps5r; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43635796b48so86102635e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jan 2025 04:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1736165111; x=1736769911; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mR8gi6U4cwYS0aW4/hxecZgCrBHXc4kljGv3GyLWPoI=;
        b=ZKMdps5rr8hxY8OWxiAsjbBp0PhFEyWwquLG9eS1/W0PCDYq7tbmJNhXvUWwmn5Eaw
         yQBPJOkNBYQfd8BZCztnn2iVgO8gIJp+KWuwCk8Tn0swnz3kP5REstSZcTOUfQJbV9oJ
         GAkiSkEzwPxb8hvnR+tvx6o9jHsMN/nGilpOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736165111; x=1736769911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mR8gi6U4cwYS0aW4/hxecZgCrBHXc4kljGv3GyLWPoI=;
        b=Ha01jg+H5F3uBWPvGVJMReKwFmx0i+0StrfnoUY/f3RWCPL8uoICXXuD8ST6KMkZwQ
         dC93bQ/I1nkR5QPycFBPXC/PRi12/THXT0qqQFek+A0SXM91xK8EzEMz4WpvL3eJoFBG
         +wgyFqqJmB3vjxPnIPfpmTFrDEPX0g7Gnsjw7gldgB2IBaAAprhKcaQgj7+YezBrGsAI
         nIa38sh86njxBojnJqI0T+daj8XzYj7WqbehqGoP8v35202idvP6b2RuTksU2rsfO6mx
         ndlT5qYwYG1Sc56Qj/AHM311cd2RBHJDlWWfwNLzWcji05XNeVR269PHPPEjKm7Ts4XB
         7w1w==
X-Forwarded-Encrypted: i=1; AJvYcCWeMJmusTOg+16FecAR4S5j9PxB/Z1lte3CjfNeCZ7QjVBG+WbBFShzX4Ew90zTWgGU+BqxHE8FamVu@vger.kernel.org
X-Gm-Message-State: AOJu0YyQgULi5hfbWyF5zqt0AG/Xk8Rqw6vnvA3otM/BJMZDfs0JN8D4
	cmPFJqwk7kvXO0s0Vl2zszMshVSdT0opqwWxoayf6F1+Qy+hj7rpl4isQ/EB2Lk=
X-Gm-Gg: ASbGncvq+tkepbEuYHGEP24CpliA0+wWjJFwZCrQvkiARwYOdSfg9Ky3EXzGiSlGvDb
	CQOKxkfoDCpLXhai6+16i1NbPGkyGC9YZEEQIPknP34Ty3+GJPgi7iXP3yt9g1hi9/5kTUWVPmY
	T9uTMwNJkFlA97YWXMzO3B9mRYAXRwHqSBpKOZfUD/DcBMBNH9ctqAWOP33g34Bpb8pOshylgdT
	G0c2wR+j74uKaWCoeFpPSAgd0ebt2nF/XDDVBizfMG+6/i2y1CEAJNfD7X1OVgHAD8G
X-Google-Smtp-Source: AGHT+IGqrYDLO8WuLsURv5mBKdZnSYgPAQgK5+8FmFCtidEbzqmhldfGSWYEyPKtEVnMyQ4Knh1myQ==
X-Received: by 2002:a7b:c3d9:0:b0:434:ea1a:e30c with SMTP id 5b1f17b1804b1-4365c79aa7dmr532914215e9.13.1736165110894;
        Mon, 06 Jan 2025 04:05:10 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43665cd9c29sm548387705e9.14.2025.01.06.04.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 04:05:10 -0800 (PST)
Date: Mon, 6 Jan 2025 13:05:08 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
	Wei Lin Guay <wguay@meta.com>, Keith Busch <kbusch@kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Dag Moxnes <dagmoxnes@meta.com>,
	Nicolaas Viljoen <nviljoen@meta.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Leon Romanovsky <leon@kernel.org>, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 0/4] cover-letter: Allow MMIO regions to be exported
 through dmabuf
Message-ID: <Z3vG9JNOaQMfDZAY@phenom.ffwll.local>
References: <89d9071b-0d3e-4fcd-963b-7aa234031a38@amd.com>
 <Z2BbPKvbxm7jvJL9@kbusch-mbp.dhcp.thefacebook.com>
 <0f207bf8-572a-4d32-bd24-602a0bf02d90@amd.com>
 <C369F330-5BAD-4AC6-A13C-EEABD29F2F08@meta.com>
 <e8759159-b141-410b-be08-aad54eaed41f@amd.com>
 <IA0PR11MB7185D0E4EE2DA36A87AE6EACF8052@IA0PR11MB7185.namprd11.prod.outlook.com>
 <0c7ab6c9-9523-41de-91e9-602cbcaa1c68@amd.com>
 <IA0PR11MB71855CFE176047053A4E6D07F8062@IA0PR11MB7185.namprd11.prod.outlook.com>
 <0843cda7-6f33-4484-a38a-1f77cbc9d250@amd.com>
 <20250102133951.GB5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250102133951.GB5556@nvidia.com>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Thu, Jan 02, 2025 at 09:39:51AM -0400, Jason Gunthorpe wrote:
> On Thu, Dec 19, 2024 at 11:04:54AM +0100, Christian König wrote:
> 
> > > Based on all the above, I think we can conclude that since dma_buf_put()
> > > does not directly (or synchronously) call the f_op->release() handler, a
> > > deadlock is unlikely to occur in the scenario you described.
> 
> Right, there is no deadlock here, and there is nothing inhernetly
> wrong with using try_get like this. The locking here is ugly ugly
> ugly, I forget why, but this was the best I came up with to untangle
> it without deadlocks or races.

Yeah, imo try_get is perfectly fine pattern. With that sorted my only
request is to make the try_get specific to the dma_ops, because it only
works if both ->release and the calling context of try_get follow the same
rules, which by necessity are exporter specific.

In full generality as a dma_buf.c interface it's just busted and there's
no way to make it work, unless we inflict that locking ugliness on
absolutely every exporter.

> > Yeah, I agree.
> > 
> > Interesting to know, I wasn't aware that the task_work functionality exists
> > for that use case.
> 
> IIRC it was changed a while back because call chains were getting kind of
> crazy long with the file release functions and stack overflow was a
> problem in some cases.

Hm I thought it was also a "oh fuck deadlocks" moment, because usually
most of the very deep fput calls are for temporary reference and not the
final one. Unless userspace is sneaky and drops its own fd reference in a
separate thread with close(), then everything goes boom. And untangling
all these was impossible.
-Sima
-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

