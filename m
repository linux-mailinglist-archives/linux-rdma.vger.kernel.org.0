Return-Path: <linux-rdma+bounces-3939-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22D593A000
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2024 13:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC721C22112
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2024 11:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78CD1509BE;
	Tue, 23 Jul 2024 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QxLLppF3";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QxLLppF3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992FA1509A8;
	Tue, 23 Jul 2024 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734590; cv=none; b=YwlTtxZLcTaBjxaDKTfqiaGcq05RzxB5JIyNuai5hd/Sbc2u16NKPvLURQUBAhXMZUzzLBVn9ksCszgQ4bYaJMjwXjA3uxcK2sNueF53MarmvdVQctyS9Lp7sTs+E7gK6x1jRoPiqZgn7NR6bDZHVdYMk3lu4BO/J6JoH02v9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734590; c=relaxed/simple;
	bh=MS6m6IULi+pEAfK0WMjEkJxpK0tYjHKlQi+2WOHrQPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PcwnQeIyxwZGfeTfQtSEa5vGPwoY2ZqpOPW/8JzFgf2Wqx8u1m0M4/Z/Yt2k/is4BXVEsyPYLJuazfUjvnbTr6IA8R5V88os0vI4FmMncWuo0VLwV4eWL8lwgxdshGayPiJOwOqIuZnlnlN/sqIUeFg/swjIq00h7/FkmzZ03YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=QxLLppF3; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=QxLLppF3; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721734587;
	bh=MS6m6IULi+pEAfK0WMjEkJxpK0tYjHKlQi+2WOHrQPU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=QxLLppF3B4lzL7aV4SHiiGm17Got7OLk9K+Cv8IFtclvFddw69huooyT49bW5pgzW
	 PxQxtZJ5zJmzR9E2m/5ElMS3F1NWb2Ik1IxnV52CSUa2k7Go3HVdkp5ElI3wtkPBCy
	 TQhnNl5EN1xJ54iANj9F0rgMCaYQ9Ew997ROMXtU=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9FD011286E02;
	Tue, 23 Jul 2024 07:36:27 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id FvTuh8OnonKV; Tue, 23 Jul 2024 07:36:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721734587;
	bh=MS6m6IULi+pEAfK0WMjEkJxpK0tYjHKlQi+2WOHrQPU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=QxLLppF3B4lzL7aV4SHiiGm17Got7OLk9K+Cv8IFtclvFddw69huooyT49bW5pgzW
	 PxQxtZJ5zJmzR9E2m/5ElMS3F1NWb2Ik1IxnV52CSUa2k7Go3HVdkp5ElI3wtkPBCy
	 TQhnNl5EN1xJ54iANj9F0rgMCaYQ9Ew997ROMXtU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BCB4F1286DE3;
	Tue, 23 Jul 2024 07:36:26 -0400 (EDT)
Message-ID: <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jiri Kosina <jikos@kernel.org>, Dan Williams <dan.j.williams@intel.com>
Cc: ksummit@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, jgg@nvidia.com
Date: Tue, 23 Jul 2024 07:36:24 -0400
In-Reply-To: <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
	 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-07-23 at 13:20 +0200, Jiri Kosina wrote:
> On Mon, 8 Jul 2024, Dan Williams wrote:
> 
> > 2/ Device passthrough, kernel passing opaque payloads, is already
> > taken for granted in many subsystems. USB and HID have "raw"
> > interfaces
> 
> Just as a completely random datapoint here: after I implemented
> hidraw inteface long time ago, I was a little bit hesitant about
> really merging it, because there was a general fear that this would
> shatter the HID driver ecosystem, making it difficult for people to
> find proper drivers  for their devices, etc.

The problem with hidraw is that userspace has to understand the device
to use it, but a lot of HID devices (keyboards, mice, serial ports,
etc.) want to fit into an existing ecosystem so they have to have a
kernel driver to avoid having to update all the user applications. 
However, entirely new devices don't have the existing ecosystem
problem.

> Turns out that that didn't happen. Drivers for generic devices are
> still implemented properly in the kernel, and hidraw is mostly used
> for rather specific, one-off solutions, where the vendor's business
> plan is "ship this one appliance and forget forever", which doesn't
> really cause any harm to the whole ecosystem.

That's not entirely true.  FIDO tokens (the ones Konstantin is
recommending for kernel.org access) are an entire class of devices that
use hidraw and don't have a kernel driver.  There's an array of
manufacturers producing them, but the CTAP specification and its
conformance is what keeps a single user mode driver (which is now
present as a separate implementation in all web browsers and the
userspace libfido2) for all of them.  Fido is definitely not a one off,
but on the other hand, not having a kernel driver doesn't seem to harm
the ecosystem and they can get away with it because there was no
existing device type for them to fit into (except, as you say, an array
of incompatible and short lived USB key tokens which annoyed everyone
by having usability limits due to the oneoffness).

James


