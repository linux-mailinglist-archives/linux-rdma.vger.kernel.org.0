Return-Path: <linux-rdma+bounces-7409-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFA3A27E4F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 23:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FAB188522E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE9921ADCB;
	Tue,  4 Feb 2025 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH6hCmsd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFDB1FF7A5;
	Tue,  4 Feb 2025 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738708521; cv=none; b=lNqcWBQOPJHeAymmaJSrrOvi+nqakrM4nU8AJikKJr54EZUhhW/RYZMIK8LMOmNRyHlnzHKVBpUYBm0DFwxWwWKLWPPooC9mXIpyDRcX5cpnCr9b7K71Poq+Vow6YeBLcYTYMGVF+Nf8wfcWMBoU4zVsFHqUgVREkwwt02S6nfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738708521; c=relaxed/simple;
	bh=mI2V72X0a2VUbi0NqJ8QzQBM8+pbwjo+YnbCECgSDWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYJZbWbwWu2CrztRu0m8q5Mfo2l+c8aNX9mI6pJzvfto8EVH8w9UvN3dUKuK92dBrcn8sBQDp3I01Gw5ncaKMUgXSd0UrIf/whxQ1TtmSOaeSgv1pBsqMTsQLa8z0WzYiP0oR19Ub5yddUTKQHDzKNlrl124ThjmSiaVQX8ibhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH6hCmsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF65C4CEDF;
	Tue,  4 Feb 2025 22:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738708520;
	bh=mI2V72X0a2VUbi0NqJ8QzQBM8+pbwjo+YnbCECgSDWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YH6hCmsdpAQfWAPW5Ur+F34mn54gGCp3aEsgO0mVmbKTUzIRvphrHqo/NHUs2KK//
	 wljj3Mx/3bcyp9gYw9HJ4NV9TUPyUGa0/6WgEV1aGaT8McBi3GTw+WT4M0iJkVp9mV
	 UE4ZdFnWvwVi2M6gqw1Hdy9YE+JMElkK8nuEku+SUjWb65laDWMaWTnwT6f5tp25u2
	 LmaDOzC27pWqrRjsyeM2U+m0RXjinG66HWshulbYMrl28+/UT3P4Cz6Gv9i+T4yC45
	 EJvO+vOLdna2t6Lx+1qh4BzZb/1TFJQl2jFdFxbT/CfbvqfD6982FFs8LOT6gYjDru
	 eeA0CXhZpBHQQ==
Date: Tue, 4 Feb 2025 14:35:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, sridhar.samudrala@intel.com,
 jacob.e.keller@intel.com, pio.raczynski@gmail.com,
 konrad.knitter@intel.com, marcin.szycik@intel.com,
 nex.sw.ncis.nat.hpm.dev@intel.com, przemyslaw.kitszel@intel.com,
 jiri@resnulli.us, horms@kernel.org, David.Laight@ACULAB.COM,
 pmenzel@molgen.mpg.de, mschmidt@redhat.com, tatyana.e.nikolova@intel.com,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ice: devlink PF MSI-X max and min
 parameter
Message-ID: <20250204143518.1583217e@kernel.org>
In-Reply-To: <20250203210940.328608-3-anthony.l.nguyen@intel.com>
References: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
	<20250203210940.328608-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Feb 2025 13:09:31 -0800 Tony Nguyen wrote:
> +	if (val.vu32 > pf->hw.func_caps.common_cap.num_msix_vectors ||
> +	    val.vu32 < pf->msix.min) {
> +		NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> +		return -EINVAL;

> +	if (val.vu32 < ICE_MIN_MSIX || val.vu32 > pf->msix.max) {
> +		NL_SET_ERR_MSG_MOD(extack, "Value is invalid");
> +		return -EINVAL;

Please follow up and either remove these extack messages, or make them
more meaningful. The "value is invalid" is already expressed by EINVAL

The suggestion to set the values at once or as "pending" is a
distraction IMO.

