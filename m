Return-Path: <linux-rdma+bounces-11726-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B03B2AEC312
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Jun 2025 01:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ABB3AE3F7
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jun 2025 23:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D919291C0C;
	Fri, 27 Jun 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzwrB48l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AE3290095;
	Fri, 27 Jun 2025 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067637; cv=none; b=HD2uXHYRL26EchGb0guoNNzWxJgpSt+sfSQ5GcdC9k8jtYPRG+e9HxpVSXB/upbE6GVPUYFS2oLU2PHrc5/SrVnpQEHpwlKzs8UYypR/66kX2Qcw494R7vSqKQPOsHR3Y+EGhE6Nkdu1vQp/uW41lal5mrohkRupe++awqe6BdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067637; c=relaxed/simple;
	bh=GU/MMqTCtY/mnSC6TIWLdAKtJvLTP40P40z3oOY8SQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daPaJ/B/5l/rfyYwdagh1Z1XKwVP9yzSkkENQednIIJpGKxYsJVPsqqOi8Ld3Y/ZXpdbYHe1mkKvYnFXJUWGgDadxR+RAXbkgg6XcooDuldB6uCVadVHax1SG5hkvN939RqKuB0J5GbXeC0eD/ri8AirBq5358SnCxFhbLCDqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzwrB48l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EE9C4CEED;
	Fri, 27 Jun 2025 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751067637;
	bh=GU/MMqTCtY/mnSC6TIWLdAKtJvLTP40P40z3oOY8SQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hzwrB48lhOcycXueIFvKgHl5QoouUY1QfWmnu+sgvtro69ETwlVWxQzHLLnIz9Pdb
	 MTjDFFSNLmXauKa8mDxByXqNz2jCGQGgBkC/dvEatLaa1Hl4zYVBFSo/Aly3dcSMG0
	 L1ki0YSDtP8Zy64UR3ve9bZ5SmvO53B+KKWZOpfX9Z7OFPmb5Y6uS8GEkTh1IFtLOU
	 /nAxE/r38soP8s3pLwbueI6dyQ20n5rpTBYJUmj4nqdKO9jk/qmAFBCuHjKTwA2gYO
	 FIE+fTVEl0m35fMypRH1lC277ZPVXkFeXBXXDtm0tCpWM6LmZFe+goVU4rH3PvYI6b
	 SBuz4e5Y9qbLw==
Date: Fri, 27 Jun 2025 16:40:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jiri@resnulli.us, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksandr.loktionov@intel.com, corbet@lwn.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/3] dpll: add Reference SYNC feature
Message-ID: <20250627164035.3ef705fa@kernel.org>
In-Reply-To: <20250626135219.1769350-1-arkadiusz.kubalewski@intel.com>
References: <20250626135219.1769350-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 15:52:16 +0200 Arkadiusz Kubalewski wrote:
> $ ./tools/net/ynl/pyynl/cli.py \
>  --spec Documentation/netlink/specs/dpll.yaml \
> --do pin-get \
> --json '{"id":0}'

For future patches -- I think we should switch to using ynl as the CLI
name, and the --family shorthand, since the good folks at Red Hat
RPM-packaged YNL (kernel-tools).

IOW instead of the above we can say:

 $ ynl --family dpll --do pin-get --json '{"id":0}'

