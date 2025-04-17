Return-Path: <linux-rdma+bounces-9516-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1372A91A9F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 13:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FD95A767C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 11:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EB723BF83;
	Thu, 17 Apr 2025 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuoXE6cJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990923BD12;
	Thu, 17 Apr 2025 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888920; cv=none; b=G5jZexQg8+QcZF7z9YEYDwDLInEzaDxZC6goTQ/0XsvuOE+RVLVq/tvffz2Y6TDOxmdjJGrmDUCbqszXUj48DVTyz9AXbprEKRbksQvK7K7PJXNrMGVbyRQosC+eYEmX9Smwzuhz1Xp/PV4NMeAYz1bV8yJ8fU4rAHlUGBy6DUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888920; c=relaxed/simple;
	bh=wWxqD7PLoMNqodfwOiSlpTMPsKQPQwdwPmoBHXS34CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwgKFkUgSJm4OpmswagVi6zkumED6Kxzm0llN59MgLwfpcB2DR4FJmOsanWRRqCIb8oARiKgAZLVxK8Ka4uTsYFR9tvkr7CBAhOiSxJHtZe39VJP4AO4NzksoOhsEUrylOwnnANPKsJwSF/VZbxOab3NRBPWUis1yBFa+ViEptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuoXE6cJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39CDC4CEEB;
	Thu, 17 Apr 2025 11:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744888920;
	bh=wWxqD7PLoMNqodfwOiSlpTMPsKQPQwdwPmoBHXS34CI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuoXE6cJLXYX1IA083XIbNnOBowdqog2FTl9p2qbwwpFoz7V8R54PIvyTQruGL2DV
	 j3wBG8ygGeQ5+RaOE57WfcZEsjVYsXw1qFaMk4T2Yu4au8ua1lMhtLinwkg//OpxeL
	 MlY3SINHsyiaeGHCpzUTwiKO3NuhjFQSn0Wu7smDM6VjPV6epFtJk3UQfidR8biCRi
	 iLrcSnbhuzne/Rjls0FPwsyGbpSjxQ4mqAKE39jNG/sr3hPnJUPinEk9RnJuoaWEf0
	 MnQ8V8UdWqs2sWCWub8qA3W30CQfGATTuAgfKo7wQDASFokPlwXKUifsNkBOgRu4BB
	 QWz6K3n89bNZQ==
Date: Thu, 17 Apr 2025 12:21:56 +0100
From: Simon Horman <horms@kernel.org>
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: jgg@nvidia.com, leon@kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [iwl-next v5 4/5] ice: Replace ice specific DSCP mapping num
 with a kernel define
Message-ID: <20250417112156.GF2430521@horms.kernel.org>
References: <20250416021549.606-1-tatyana.e.nikolova@intel.com>
 <20250416021549.606-5-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416021549.606-5-tatyana.e.nikolova@intel.com>

On Tue, Apr 15, 2025 at 09:15:48PM -0500, Tatyana Nikolova wrote:
> Replace ice driver specific DSCP mapping number defines
> ICE_DSCP_NUM_VAL and IIDC_MAX_DSCP_MAPPING with
> an equivalent kernel define DSCP_MAX.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


