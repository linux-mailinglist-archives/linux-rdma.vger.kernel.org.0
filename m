Return-Path: <linux-rdma+bounces-4707-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F7968D1D
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 20:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468C5282754
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2024 18:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD341C62A7;
	Mon,  2 Sep 2024 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmU2WXgc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347AC1A2640;
	Mon,  2 Sep 2024 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300778; cv=none; b=ToGDSUWn5lmjpY91sN8tcP15VaAkgA9y04QwG0KvzEZxgbbLFu2Xm12G5itbiO2Q8seKgq+srSXQBwEn5nN7GM2kMryM20Z1m6+V0boXo9drNmoqEHWt4R9B5RuDArw/i0yhqUHrb+rA6MtpMbDSLbRuscqD2N+axhLvaXc2Ni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300778; c=relaxed/simple;
	bh=wTPqaKqHLzhAjxYXnUECpotow3wHFY2aVzdyea0pgis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evA5MJW1U3tgtG3gLGOoUjRO614/3eNj9BuzXO8mhd7UqJ1Ii9P9Sc8ZdEbOLYFp4RV69G5aOAeTmyA9KrMonf1W+63kU2jb6jFzaGS+EUeC3vHwjGrLPWcKCo9f4EEwBw6YyDywuVnHIIFHySmJxP/jVZz1n9z91ImkhCuIiYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmU2WXgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37201C4CEC2;
	Mon,  2 Sep 2024 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725300777;
	bh=wTPqaKqHLzhAjxYXnUECpotow3wHFY2aVzdyea0pgis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmU2WXgcJYUBfcDo6ha6IZKW7ve8E2w9YI9Pwv45SMfJbDi9sS308a2QmRqQTGkXN
	 T0L0jtCAjxNcBRgQlF0qu/sKZhi11oxaG46EBLWNrQtBkjLvfjm1aZ2XFJ1bAUP0MM
	 0ErERn92y5ntRPIUNeFoyxFRlTeD78+hfcnHMsu8WsH8JQghRGcRdR5DT6a37pClXc
	 l7FARh3DYX9v0ZPGMBjpuyQp+wKPWdZjBOBg8hSVv9OAguvr8vvajJwSQTmveaCLVd
	 QpiRXwHhrwzJcDgc9upXi4Z/571O+nMCcfoHZtR16Egyf4qfgn5bJX6Xb1/5n5EWHW
	 uLfCmts9G4PmQ==
Date: Mon, 2 Sep 2024 21:12:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>, jgg@nvidia.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Chiara Meiohas <cmeiohas@nvidia.com>
Subject: Re: [RFC iproute2-next 2/4] rdma: Add support for rdma monitor
Message-ID: <20240902181252.GG4026@unreal>
References: <20240901005456.25275-1-michaelgur@nvidia.com>
 <20240901005456.25275-3-michaelgur@nvidia.com>
 <cad1d443-ccfb-4d10-ac2d-26bb10c99d05@gmail.com>
 <20240902075426.GD4026@unreal>
 <8e652f69-78d0-40f0-a712-60ef8733cf29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e652f69-78d0-40f0-a712-60ef8733cf29@gmail.com>

On Mon, Sep 02, 2024 at 10:55:15AM -0600, David Ahern wrote:
> On 9/2/24 1:54 AM, Leon Romanovsky wrote:
> > On Sun, Sep 01, 2024 at 08:22:50PM -0600, David Ahern wrote:
> >> On 8/31/24 6:54 PM, Michael Guralnik wrote:
> >>> $ echo 4 > /sys/class/net/eth2/device/sriov_numvfs
> >>> [NETDEV_ATTACH]	dev 6 port 2 netdev 7
> >>> [NETDEV_ATTACH]	dev 6 port 3 netdev 8
> >>> [NETDEV_ATTACH]	dev 6 port 4 netdev 9
> >>> [NETDEV_ATTACH]	dev 6 port 5 netdev 10
> >>> [REGISTER]	dev 7
> >>> [NETDEV_ATTACH]	dev 7 port 1 netdev 11
> >>> [REGISTER]	dev 8
> >>> [NETDEV_ATTACH]	dev 8 port 1 netdev 12
> >>> [REGISTER]	dev 9
> >>> [NETDEV_ATTACH]	dev 9 port 1 netdev 13
> >>> [REGISTER]	dev 10
> >>> [NETDEV_ATTACH]	dev 10 port 1 netdev 14
> >>>
> >>
> >> at a minimum the netdev output can be device names not indices; I would
> >> expect the same for IB devices (I think that is the `dev N` in the
> >> output) though infrastructure might be needed in iproute2.
> > 
> > I understand the request and it is a good one for the users of the tool.
> > 
> > However, we will need to remember that "real" users of this monitoring
> > UAPI (from kernel side) are the orchestration tools and they won't care
> > about the names, but about the IDs, which won't be used in rdmatool.
> > 
> 
> That's a big assumption.
> 
> It is trivial to convert indices to names, so this can be readable for both.

We had an internal discussion about this earlier today and came to same
conclusion that we will convert indexes to names in the rdmatool without
need to change the kernel API.

Thanks

