Return-Path: <linux-rdma+bounces-13231-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0556B51377
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 12:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7061C265EB
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 10:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA53C313E37;
	Wed, 10 Sep 2025 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrA8bveg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50693313278
	for <linux-rdma@vger.kernel.org>; Wed, 10 Sep 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498883; cv=none; b=pXjQOVvE6cGv7fCNXMeVwsIGKwTl1vl8ToCTWuWQtwFzXNueEjuneVV4du7Y4fFbuUjDFq+E87iZx5SmLyy8ruYaTqeB6A0DMDMTgwNVrTIK0i8U6abhYvLEmMh9D6Hf5be9akRhKPNrVs8QlCRtMSDZ3DjQBAgQBFc77MfDswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498883; c=relaxed/simple;
	bh=fzULQ4/N9e+10HHYdOxKDPJHtxF6Q58wmGYrEpYDCAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4bh3PKIKAbl0KQPFrETh86lJC7f9X7lrRajJn8/VJP1cyJt/OVgcRGtQTyrx3ZEltC2UgrxQNIJ/puRE55m02aBZm/buL93e6XYuQv1W/XvBCIcYocqzrvch62JsNy3CfO8lIYHeTmzWSkGaZCIy7NKuyvRy2Oq+PMtfk3SHgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrA8bveg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19B6C4CEF0;
	Wed, 10 Sep 2025 10:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757498882;
	bh=fzULQ4/N9e+10HHYdOxKDPJHtxF6Q58wmGYrEpYDCAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrA8bvegpO8rR1hY8f7rOCNHr2ROFxtTDPOa1lfFw0tiIcBqfsk0m0pOS3GP4Jpso
	 j0/WWhKLKI3InULIP/AIEYo0Ei0PVn6ICJUAFQm88VAj7dmkCzw58Rd1UTwmAPZEFy
	 yzEvLEs0dRaxbnZRhYRLq03m+42THLqUJip8MiigigmM5YWZfCB6v+IttV8LpdP+PG
	 4MOABRrkrBJk4JWaNTSeDm0rau9cMNZrymh7vYY/GzRbZsQvqJlFoO12EDgHPBaSgt
	 x7nQZZi0ZtS1ZxWvXQl4kzXyEZY6btnuL0zmi5RLwxMCKF6p0XA1XdpIoE0VJ24f7g
	 hpBPPwlMGO7Ig==
Date: Wed, 10 Sep 2025 13:07:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jacob Moroni <jmoroni@google.com>
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>, jgg@nvidia.com,
	linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com
Subject: Re: [for-next 00/16] Add RDMA support for Intel IPU E2000 in irdma
Message-ID: <20250910100757.GN341237@unreal>
References: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
 <CAHYDg1Taj9PBoHRoNjBJsgmpWWYtkD9P5BHLRJ-BSi+4J6kU_w@mail.gmail.com>
 <20250909113437.GE341237@unreal>
 <CAHYDg1QPYK0OJEYWVR2fOfHVyXpkViDebmq4CDs+K2VdYWHJ2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHYDg1QPYK0OJEYWVR2fOfHVyXpkViDebmq4CDs+K2VdYWHJ2g@mail.gmail.com>

On Tue, Sep 09, 2025 at 09:15:32AM -0400, Jacob Moroni wrote:
> Hi,
> 
> I tested with the following:
> 
> Original RFC Github PR from a while ago:
> https://github.com/linux-rdma/rdma-core/pull/1486
> Latest Github PR from 2 weeks ago:
> https://github.com/linux-rdma/rdma-core/pull/1640

ok, thanks

> 
> Thanks,
> Jake
> 
> 
> On Tue, Sep 9, 2025 at 7:34 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Aug 27, 2025 at 03:21:28PM -0400, Jacob Moroni wrote:
> > > Tested with rdma-unit-test (https://github.com/google/rdma-unit-test).
> > >
> > > [==========] 522 tests from 43 test suites ran. (1872510 ms total)
> > > [  PASSED  ] 481 tests.
> > > [  SKIPPED ] 41 tests, listed below:
> > >
> > > Tested-by: Jacob Moroni <jmoroni@google.com>
> >
> > What did you test?
> > I don't see any rdma-core changes to support this new driver.
> > https://lore.kernel.org/all/20250827152545.2056-8-tatyana.e.nikolova@intel.com/
> >
> > """
> > This change introduces a GEN3 auxiliary vPort driver responsible for
> > registering a verbs device for every RDMA-capable vPort. Additionally,
> > the UAPI is updated to prevent the binding of GEN3 devices to older
> > user-space providers.
> > """
> >
> > Thanks

