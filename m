Return-Path: <linux-rdma+bounces-13194-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9903B4AC37
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 13:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD01B24FA8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 11:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDF82E8DF7;
	Tue,  9 Sep 2025 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMv4v4J3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AAC1B78F3
	for <linux-rdma@vger.kernel.org>; Tue,  9 Sep 2025 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417682; cv=none; b=UurbpbEVJM/SsSlhP+8tB5ufHbSlHRg/ULujuj7lzl14kDp8uuBofFz4LaoA3Lkqo5mb2uD+kCpDd2nxsyTrvaueAy8dx42YJshtmPyuP/TmdYRXrhteDPUjtyuLF5+zpyGvTA5WAKr/PwcVHI2ni3xdKBnq84ngo7NtLUo4dWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417682; c=relaxed/simple;
	bh=sENPlbQRZQK0f+ZpvkTMNl6040J+1Uhos83IvcsHa2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw6geJ2ZtyeRZ0KyIM4pEA9AV7PN20kbkbDXvHgJEu5Hb2dMtiZq7Y+21xes7G7GkZIuTLGkzOH0N+0b6KHJzazgrjb5lS6zfHxqhF0SzmnrrDkGxq1ezbx8w9qB0EW4of8MuDNEFU1jZqMxySfjxEUfdjOHFMS3Ejndswb6Glg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMv4v4J3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AAAC4CEF4;
	Tue,  9 Sep 2025 11:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757417681;
	bh=sENPlbQRZQK0f+ZpvkTMNl6040J+1Uhos83IvcsHa2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMv4v4J34F8F9+cx5LEwp2lCGAOc7VDu+9gZV6OHhb1A3brNDcK2tZRZTp9mPLrqh
	 DSd9m5o9LPli69Ai/KCyvqTvxLHpnG6LdDPa35ru4fSDUMXMpYCLic3098zN3ZljEC
	 +svL4QjyyKfqTH2yv3pFnXvztgAt7yAepes6VjePpPtmbIu0RMCu3DlHUBZuF97VyS
	 Ohqe8e1MnOlgPdRNDqUapRfWkLa0ojSYj2U5ZSTAvVMpaIKm5K4lIexB4t0+Qb2nhN
	 z16W4tad+XzZ8p7OUGaJQZjUq4UNxUJ/7UkrtIszE2ZjZParYXnpMF5Qh2ILw1keWY
	 ObA3LRKOU+WeQ==
Date: Tue, 9 Sep 2025 14:34:37 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jacob Moroni <jmoroni@google.com>
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>, jgg@nvidia.com,
	linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com
Subject: Re: [for-next 00/16] Add RDMA support for Intel IPU E2000 in irdma
Message-ID: <20250909113437.GE341237@unreal>
References: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
 <CAHYDg1Taj9PBoHRoNjBJsgmpWWYtkD9P5BHLRJ-BSi+4J6kU_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1Taj9PBoHRoNjBJsgmpWWYtkD9P5BHLRJ-BSi+4J6kU_w@mail.gmail.com>

On Wed, Aug 27, 2025 at 03:21:28PM -0400, Jacob Moroni wrote:
> Tested with rdma-unit-test (https://github.com/google/rdma-unit-test).
> 
> [==========] 522 tests from 43 test suites ran. (1872510 ms total)
> [  PASSED  ] 481 tests.
> [  SKIPPED ] 41 tests, listed below:
> 
> Tested-by: Jacob Moroni <jmoroni@google.com>

What did you test?
I don't see any rdma-core changes to support this new driver.
https://lore.kernel.org/all/20250827152545.2056-8-tatyana.e.nikolova@intel.com/

"""
This change introduces a GEN3 auxiliary vPort driver responsible for
registering a verbs device for every RDMA-capable vPort. Additionally,
the UAPI is updated to prevent the binding of GEN3 devices to older
user-space providers.
"""

Thanks

