Return-Path: <linux-rdma+bounces-8323-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB4A4E644
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 17:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB993BA7FD
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 15:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE4B25FA0E;
	Tue,  4 Mar 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="gqL5BQrT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD22BE7D9;
	Tue,  4 Mar 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102753; cv=none; b=iiwgvE6dnqb/2W1LNZmXPeOkIZOBHiT3jzY53mwcCK0ClO0tC2BwsqQrdyOqNTBIgSHjnW3RXiXtQRtUfP8usMUpdgbVPA4lFMOV8r3Ky4FS3eIVMqqLXgCcd/V8JHtm/aKoCv13AuBcNGB+gHq4RxxLGDsJ3uk1S0X2PfgRJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102753; c=relaxed/simple;
	bh=auG9fhIEk5WNSfZP00zkFoUGxi1ycw90jpxVYjD4uzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+IiN9P1qosVIi0Z0iBW65oDfHHumPLEtwOsk00KtaIAL4tD9kwHHCH95vJsfFH8IkAlypWvB+EabyT7zInl/NnTvRmpMJXVhV4jACcrRpugoDgxiq7vc3G4H8jMJwbQIKNtaqjaIKYf1fuKziuy0nsggdeXOLnrwPpsxAq2q1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=gqL5BQrT; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=CrZJzgsPb563EHYUAm6DxIL/LwlblsMqudybIt3wKg0=; b=gqL5BQrT4i54xtk1
	lSBohzS8FZec1wIdT1h3LfiBsRZFAnV4bGG2yT6CthXjPfaayOpfvJMhFjvCysNG1V169asaH2peJ
	zsXsQVdP3ykBwnbl/AjqQFIDW2qw6xWKtJRvGZQCNhQlDKYBWJXN8WBSqifzkCG+sHPKG8vrhRwsV
	F7+k3BkAdY783bkiyijiUboMi3VPhUghuTWh+5j+DvLWY8Bg3v4cJWZcrgeogC5jyCSgS4QvyKzX1
	l/1A7s6x4CoKR8+1+op8s0elNm4oTkAc1gY81H8Yg8PC+ZWfBCgfB4xz1ldvlfyxVD8JBPngUuQCA
	cP2jsC3E48ANWLDBLQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tpUMH-002XPv-01;
	Tue, 04 Mar 2025 15:39:01 +0000
Date: Tue, 4 Mar 2025 15:39:00 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Bryan Tan <bryan-bt.tan@broadcom.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, vishnu.dasa@broadcom.com,
	leon@kernel.org, bcm-kernel-feedback-list@broadcom.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Unwired pvrdma_modify_device ?
Message-ID: <Z8celFfGXR8P6Mk8@gallifrey>
References: <Z8TWF6coBUF3l_jk@gallifrey>
 <20250303182629.GV5011@ziepe.ca>
 <Z8X4Ax5UCerz9lP8@gallifrey>
 <CAOuBmuZdG7SWWmmhtEF09B5A4O-s+_h_uZnmTOPyKtQJGM9=wA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuBmuZdG7SWWmmhtEF09B5A4O-s+_h_uZnmTOPyKtQJGM9=wA@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:38:19 up 300 days,  2:52,  1 user,  load average: 0.02, 0.04,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Bryan Tan (bryan-bt.tan@broadcom.com) wrote:
> On Mon, Mar 3, 2025 at 6:42 PM Dr. David Alan Gilbert <linux@treblig.org>
> wrote:
> > * Jason Gunthorpe (jgg@ziepe.ca) wrote:
> > > On Sun, Mar 02, 2025 at 10:05:11PM +0000, Dr. David Alan Gilbert wrote:
> > > > Hi,
> > > >   I noticed that pvrdma_modify_device() in
> > > >    drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
> > > > isn't called anywhere; shouldn't it be wired up in pvrdma_dev_ops ?
> > > >
> > > > (I've not got VMWare anywhere to try it on, and don't know the innards
> > > > of RDMA drivers; so can't really test it).
> >
> > Hi Jason,
> >   Thanks for the reply,
> >
> > > Seems probably right
> > >
> > > But at this point I'd just delete it unless pvrdma maintainers say
> > > otherwise in the next week
> >
> > OK, lets see if they wake up.
> >
> > Dave
> 
> Thanks David for bringing this up. You're right, it looks like we
> never wired it up to pvrdma_dev_ops. Feel free to remove it.

Hi Bryan,
  Thanks for the reply - OK, I'll send a patch later to remove it.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

