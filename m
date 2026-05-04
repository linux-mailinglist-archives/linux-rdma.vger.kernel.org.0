Return-Path: <linux-rdma+bounces-19967-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGmXHCkk+Wmz5wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19967-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:56:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 157D24C49E6
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67A56304C075
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 22:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8238BF80;
	Mon,  4 May 2026 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZV+R6HH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9FD38B150
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935255; cv=none; b=QAdcUIFb2yOaQAtaAexEuHxhH1y0+errm3iHJelDe6JehVO8obP4WW7uUcze13HADUe7YWqPDzkzdT5eWDzX0x1flVwY29GkawkL2hB1PaE2U9TJP3i7W3jvDIVRtbOf00E7nlbbBO8EnCbeTc4TsBZUwfic7BCwHw3kznP6ZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935255; c=relaxed/simple;
	bh=GJA5seVahYpViKnGZOh3rNiBjtA0B+KD0LRZTUEpgoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/y7zIldk7UN4SallQwCduuYQKzWitj7UQzpORODcwFFiayhSBMby3cMGwhmkD1DWpcoNj31621zfz3OmkQlFrd/yV9EiknajM7jDRjBjsD4uLpC/A1iAVSuTBpReMKGC9RqwbJqOHCBQpKAdmgcsP3vozLBfkrtMZVFZdQOpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZV+R6HH; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36536771300so1094410a91.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777935253; x=1778540053; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ugfH2lM7nQgOC3+hZY16zqoQboC9qbhlDerkTWHT2Q=;
        b=DZV+R6HHRl2Ey2t3N3yv3xwGuB30C/kzGN7Tq/IPskIxfiKxxF0RXYE5d19hJeWkh7
         M3eceaUMnvjnz2yu5bKALKMVbo5tTJ0zSQOEwetuBV7Y1jQFJipQ8SV1H7OSIHHoVA59
         HIsPgRuPqqHCtqWkKqzRugFIbu/QbGOHWLl6QKrCi4zCBp1GurcsCSxu8O6fyKaMfNam
         +OFzRzwSGViW00TaV2NafVAphvxP34SKk4SB7j3MiJdW1avgzQRsNLxknPA6tMS/l/oL
         ssl6edK1TGxxm4uJR09O8l1RmfZyC5o+fr+xYWhEuJQzE4rtGSTmuxt6faHImSwEY+Ry
         raWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935253; x=1778540053;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ugfH2lM7nQgOC3+hZY16zqoQboC9qbhlDerkTWHT2Q=;
        b=Z2mqe5toDjPTieCeF3ZljPsOVnJ9uGT/chjZiKpIBepxqc46tdt4HFNAv2XJl+Ae5K
         JSZ9s8haJM9sjLhFvDytDSXFEzFNrClEZQsxfXENC7WJCFVMMIsUoQH9Ywl/viSht97D
         bO4BGfRb2wMruUYkeZeY/u8b7uII5R/ktvhvdbF/gOr89SXd8g/VNyT3HOR3eRVAPSsj
         ehjI+pgH8Mt9/Q5cl/bLH7WslPMMY/RZRWFd1hIOSIFnNQ415CaMz/b0WylORoArAAJe
         iG8jQYq8QMF1P/0i/BISJdGQ5bjyn6ZE2+qyI6vvyg1kCUXH8UJ9KQ5RLuWTZWmmRei1
         PEEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/lFymSnwqoxw2HFwM+OELWhfrXSnyvL34l4DDQHLAmh/cR89RziPCKQgAkboASrE6KAdM7YJyV5TPc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1LqLMaQRwsjY/gIYnYuGQulcUOGOfjvcnAurCMMEyD3fMQ1ZO
	KZo0ahm3BMJ0lunp2SC+sgmWYuchYD319R8GV4SFyDNLct2D8df5qW14VZo9QZYKBw==
X-Gm-Gg: AeBDiesoRhJvTlgF7VG4VE8ubc1otUinAu48JH1IsH61kYaYDaiL52PIGygKVHdDnX5
	n74lNhHS99GizGi3YE6rLukGz5BMjmbMowhimgAGsOLqXRortUYrBns23dYkoVVffiSJz+5A5K0
	pfXIw+kvazZPGTsJiHXVq7It4PEIDljNxiWz/+SMI4iCz4bDB29gqZ15Y2h69NwZcFVA+XSpEAx
	npIHWTx6Rcx6Y9wiNp/XdAA6i6Yqx6MGkc5nu+puOIz+PDHK3lSVt1UOoYGSXRv6vz/YDK0M8GZ
	Nw+cjl0VmMDLA8mk5L8ID2qPt5rb+quMLMAftYqfrHwqVMArfiIU3yxBWKNbutkUaByh4/imyHs
	+udvMrkHKAD94e4vXWmzqrmz/aULzPj/AQI/t5T3rNApGWorH7MnHOfkiLkPVPSa2AhwelPQ0Ih
	oAkTwiqFk49wSeglOI5hV3/d4isTD8R4um9a8GJZVGa1fDWMP2tkB8CgNsxEnVKMJYMld5fXFxz
	CoSPg==
X-Received: by 2002:a17:90b:2e85:b0:364:a497:db8f with SMTP id 98e67ed59e1d1-365727322f8mr956720a91.9.1777935252914;
        Mon, 04 May 2026 15:54:12 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9f0b21c4bsm88242915ad.29.2026.05.04.15.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:54:12 -0700 (PDT)
Date: Mon, 4 May 2026 22:54:08 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev, Josh Hilke <jrhilke@google.com>
Subject: Re: [PATCH 00/11] mlx5 support for VFIO self test
Message-ID: <afkjkBq8B-4KjhS_@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <CALzav=ci8bi3=sY+F3HJTB5sOQ_pJ8Lm+kz0CDBBWVXry5P98w@mail.gmail.com>
 <20260501164314.GA1381708@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260501164314.GA1381708@nvidia.com>
X-Rspamd-Queue-Id: 157D24C49E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19967-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qemu.org:url]

On 2026-05-01 01:43 PM, Jason Gunthorpe wrote:
> On Fri, May 01, 2026 at 09:11:11AM -0700, David Matlack wrote:
> > On Thu, Apr 30, 2026 at 5:08 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > Add an mlx5 driver to VFIO self test. This is largely a remix of the
> > > existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
> > > to issue RDMA WRITE operations which effectively perform memory
> > > copies using DMA. Since mlx5 has a stable programming ABI this
> > > should work on devices from CX5 to current HW. The device FW must
> > > support the QP loopback configuration.
> > 
> > > This entire series was coded by Claude Code in about 4 days.
> > 
> > Very exciting. Josh Hilke from Google is also working on using AI to
> > create a selftest driver for Intel IGB NICs so VFIO selftests can run
> > in QEMU [1]. So it's encouraging to see you were able to do it with
> > mlx5.
> > 
> > [1] https://www.qemu.org/docs/master/system/devices/igb.html
> 
> Yes! I would feed DPDK in as well in this case? Combined with the
> kernel driver it should be doable. It is much easier if you understand
> how the NIC works, of course. This worked out significantly because I
> guided it through sufficiently small steps and knew where to find all
> the quality reference material..
> 
> > >  - Make it work on a PF too (this is surprisingly hard!).
> > 
> > Can it work on CX VFs? We're interested in continuously performing
> > memory copies across a Live Update using a VF via selftests to
> > demonstrate SR-IOV preservation (when we eventually get there).
> 
> Yes, I started with VF because it is simpler.

Makes sense. I tested it out and was able to get vfio_pci_driver_test
passing with a CX7 VF.

> The PF support flow requires a bunch more complicated stuff.

Do you think it's worth supporting PFs? If anyone with a CX NIC can
enable SR-IOV and run selftests on a VF then we can keep the driver
somewhat simpler.

