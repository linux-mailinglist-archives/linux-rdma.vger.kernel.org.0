Return-Path: <linux-rdma+bounces-4066-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1B893F5C4
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 14:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE8A1F23E8A
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2024 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B350148FF5;
	Mon, 29 Jul 2024 12:45:19 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AF31E515;
	Mon, 29 Jul 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257119; cv=none; b=O9htHQYMXodtYAv3CsvWLcWTq6/NsjWtSXriMDN9JEnXEeIBc40p4rAdhnYwQLkmeALXhLJrpHYPp/es5xcm4N7olHQmzdi/W/dteESLBmfGL8pwugvM6Uys2aWWgJkRuUCHtvKlO5+203eqgglmzhqRD9OTd10U3rZNZHYWbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257119; c=relaxed/simple;
	bh=xXNZw508FXcZjuW7rOEkNJ5ujjtTvoH1lvrNm/sH9dY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMhAq13SkJLSOOnkK0RQT40IbGpNwueN28lWu19VY9thMt11c5eGAdYsXccbeheKHPDMdLrOGyNcUmej7y5gdM47PTShS6lEl31JO2DLqfcA9hvNzY3tDCQYAo+AhYAWYcybVkdl81WYHJmRUMfCheukvNwfkjmWoYbWw6DurM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WXdLB0yXnz6K91p;
	Mon, 29 Jul 2024 20:42:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B2E75140B2F;
	Mon, 29 Jul 2024 20:45:13 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 29 Jul
 2024 13:45:13 +0100
Date: Mon, 29 Jul 2024 13:45:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <ksummit@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>, Borislav Petkov <bp@alien8.de>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240729134512.0000487f@Huawei.com>
In-Reply-To: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> Enter the fwctl proposal [1]. From the CXL subsystem perspective it
> looks like a long-term solution to the problem of managing expectations
> between hardware vendors and mainline subsystems. It disclaims support
> for the fast-path (data-plane) and is targeted at the long tail of
> slow-path (config/debug plane) device-specific operations that are often
> uninteresting to mainline. It sets expectations that the device must
> advertise the effect of all commands so that the kernel can deploy
> reasonable Kernel Lockdown policy, or otherwise require CAP_SYS_RAWIO
> for commands that may affect user-data. It sets common expectations for
> device designers, distribution maintainers, and kernel developers. It is
> complimentary to the Linux-command path for operations that need deeper
> kernel coordination.

I'm reasonably on board with the basic justification for the
fwctl proposal (and it may solve some long term challenges for us), but
I'm concerned by ABI guarantees.  In particularly what happens when
we get decision wrong and expose something via fwctl that we later
have more general kernel support for.

This was triggered by Dave Jiang's (perhaps unintended) use of Patrol Scrub
as a test case for the CXL FWCTL RFC.
https://lore.kernel.org/linux-cxl/20240729130528.0000139b@Huawei.com/T/#t
I'm using this specific example here, but I think it is a more general
question.

By exposing the Get / Set feature controls, a lot of effective user space
ABI is added (some of it setting a taint).

Scrub control is an interesting example, because there is an active
proposal to extend EDAC to cover this and similar RAS related control
features, something we are going to be discussing at LPC.
https://lore.kernel.org/linux-cxl/20240726160556.2079-1-shiju.jose@huawei.com/
One of the key bits of feedback we've had on that series is that it
should be integrated with EDAC.  Part of the reason being need to get
appropriate RAS expert review. Something fwctl won't naturally get.

If we expose that particular Feature via Set Feature we may run into
future problems.  It is probably possible to make the driver stateless
so any interference from a userspace program using fwctl is not fatal
- in this case userspace code should probably be safe to state changes
anyway. We know about this clash today, so could easily block fwctl
from exposing this feature, but it is illustrative of a wider problem.

We will get some decisions about what should be exposed via fwctl wrong
in the long term, even if they are correct at time of initial decision.
So how do we cope with that?

1) Make no guarantees on ABI for taint causing operations.
   So we can block this FWCTL in a kernel if EDAC / ras control is in place
   for the same feature.  I'm fine with this but it's not obviously
   a correct thing to do!
2) Allow the footgun. Keep the fwctl interface and harden the other kernel
   support against state changes that result. If userspace code breaks,
   then tough luck.  (Another form of ABI break, perhaps comprehended by
   existing proposed FWCTL rules).
3) We are stuck for ever with not supporting anything via other interfaces
   that would break if fwctl was in use.  Ouch.
Note that I think this only matters for the Set path as Get side shouldn't
have side effects and is fine to expose without synchronization with
a clear statement that values read are a snapshot only.

So before I'd be happy with fwctl in CXL, I'd want a very clear policy
decision on this that isn't going leave us in a mess long term.

We could say it can only be used for features we have 'opted' in +
vendor defined features, but I'm not sure that helps.  If a vendor
defines a feature for generation A, and does what we want them to by
proposing a spec addition they use in generation B, we would want a
path to single upstream interface for both generations.  So I don't
think restricting this to particular classes of command helps us.

Jonathan


