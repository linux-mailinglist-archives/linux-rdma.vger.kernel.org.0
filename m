Return-Path: <linux-rdma+bounces-8526-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0FAA590E5
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 11:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA23D16C475
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 10:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9037D22655B;
	Mon, 10 Mar 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPxsdkTk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4ED226541;
	Mon, 10 Mar 2025 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601828; cv=none; b=SEoMgNRqNeUi7LzmG1bMG5PqXDc1p/YCNmDHonG4DDjSI5bJBX9gvnMTvc1317U8iksnnMmxA2uMV/ZqZf2tNYyUAw8HFte5vDqVRWBZX2bkgZI7ugcSJVtrpu+myQmXxNw1qJxL13ENq/F/RO+GoqpBGphhU+0WWGE7yQwhaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601828; c=relaxed/simple;
	bh=3bQKUh9/WHcVsfFHSkppMzH72EwhpdPqoUM2LhQMk3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEsnRhVlegEbukWF/4yz2D2QtyNIEt+N31xItSL06b1KIHn9OC23BGVJPsOzjr2bOc1xK4Q3pRUHxFq1vzJc214bjzrU54LaGV2/83Gb9618pDxstJFC20eyyS11hUl80YJIMHNVn3wIdsI7sCgOVHpRmtw3aFYkC7nuC65LcEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPxsdkTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D246C4CEF1;
	Mon, 10 Mar 2025 10:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741601827;
	bh=3bQKUh9/WHcVsfFHSkppMzH72EwhpdPqoUM2LhQMk3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPxsdkTkyuW/m469BaBT7WTlnbCVcIoazoYb+UUHgouaASXxBp6zD33s3RKRwARuy
	 PQ1mg/7nsdg8YgZvmHApu5/6CDmcdiHfYfn0/317DW5U0GEx3YpjmQrWwlgkAMCP0d
	 9RR/BVctg9yLgY/o+bxSfxXKOV+N1f2Xn7RESBs+0bMvgBLIKKuGXouvICLQHrgfhH
	 /7kSW8D770ucZOAHOQcyII5WtfBsu73taB4o1xduWJNjkgX7uzDaNFjbRYa+LXLj1c
	 /sPCSCVjFGJRzXJDTZWrrvvWcEDRIlI2Zydzbe2CquRDhCLyUFeF24wjcqyXSi1aFx
	 nuML3CoPAiM6Q==
Date: Mon, 10 Mar 2025 12:17:02 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Publish node GUID with the uevent for
 ib_device
Message-ID: <20250310101702.GC7027@unreal>
References: <20250309192751.GA7027@unreal>
 <20250310070156.8068-1-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250310070156.8068-1-jain.abhinav177@gmail.com>

On Mon, Mar 10, 2025 at 07:01:56AM +0000, Abhinav Jain wrote:
> On Sun, 9 Mar 2025 21:27:51 +0200, Leon Romanovsky wrote:
> >On Sun, Mar 09, 2025 at 05:57:31PM +0000, Abhinav Jain wrote:
> >> As per the comment, modify ib_device_uevent to publish the node
> >> GUID alongside device name, upon device state change.
> >>=20
> >> Have compiled the file manually to ensure that it builds. Do not have
> >> a readily available IB hardware to test. Confirmed with checkpatch
> >> that the patch has no errors/warnings.
> >
> >I'm missing motivation for this patch. Why is this change needed?
> >
> >Thanks
>=20
> Originally, I was looking at this function in order to solve a syzkaller
> bug. I noticed this comment from Jason and I assumed that the motivation
> would be to identify the node on which the event is happening.
>=20
> With the name, users can identify nodes however Subnet Manager uses
> node_guid for discovery and configuration of the nodes. To conclude, I
> think just using the node name might not be sufficient for unambiguous
> and reliable device management in the network.

Up till now, it was sufficient. Let's add new uevent when actual use case
will be needed.

Thanks

