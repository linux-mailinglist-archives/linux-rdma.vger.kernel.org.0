Return-Path: <linux-rdma+bounces-7222-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A0A1C7C0
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 13:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415213A707D
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2025 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD06225A64C;
	Sun, 26 Jan 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaxIGtrZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B57D645
	for <linux-rdma@vger.kernel.org>; Sun, 26 Jan 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737896007; cv=none; b=U06phZHRUw5nXsKi9bchy5WiTScQoDGpxUb5Q4eaPa/OCcdxmUFHCRx99DetcvPxQTGYR495bmhcqfj/Rv2P6mNRC8WzjEmMoG3+pAiiqOEj/XmipMUOrq2EzK+wAXKyxA11IJz9/T5ZTas5RCCQ8ARmJ0ZLwsk4rBW6ZpC0r1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737896007; c=relaxed/simple;
	bh=zRC/DeApFMNdQ99CU9SfV96LI5NThSjgTju76rwJu4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n68jPN6ZZ7UGi46kJ9dF/ke3MINbS4oVLkBBzQ4T1+dBVLYNGYbXpY8SBK/EGDSvyEiXYbR5Lvr8B/YXfFmE9nybYGZuAIDY5Vw650cwMCxiMYBiavcY1AIE+PbiZWs/X8KSBEOihmIjbfd28jkQUi7JoMbtAPy0co/DKkOxGkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaxIGtrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE26C4CED3;
	Sun, 26 Jan 2025 12:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737896006;
	bh=zRC/DeApFMNdQ99CU9SfV96LI5NThSjgTju76rwJu4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iaxIGtrZRWJDqoFYxhijaBs2Ydb3gZevrlWicZyKGfn+Z+ER5OtKSWI9FaX9RPaSm
	 smetXxTeViq4ERWzLZGWvHjNYgbOK6pz/s/CYGobH1YdXAPG5GLCarTbaW4WS0SNz9
	 mIIcJqQfbYjpVGrN3wgAwquaXgeG15gt6NDIwoL8VJvAqLsdJqKqYf3LPKWRI3A8qP
	 m+xuQad8irh+2Udq3sGCop8yIiFMI0D/gJxI+XGSvMnX34m0DdcUXOVShmG7GruFe8
	 vGtA0PqRq/HyICpZ04RczVizGlMOim1WYgVRyBkn7P3TqkD9UCcZ3OPA73poXoa7ms
	 lBiVf1yBOUdTg==
Date: Sun, 26 Jan 2025 14:53:22 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Rita Han (she/her)" <rhan@purestorage.com>
Cc: linux-rdma@vger.kernel.org, Matthew Carlis <mattc@purestorage.com>
Subject: Re: Handling RDMA_CM_EVENT_DEVICE_REMOVAL in rdma-core
Message-ID: <20250126125322.GA74886@unreal>
References: <CAJGGzq9AhXns6y4i5LBY-g0eQY4JSV=3AG4Rt6-eMhNtE7fu4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJGGzq9AhXns6y4i5LBY-g0eQY4JSV=3AG4Rt6-eMhNtE7fu4w@mail.gmail.com>

On Fri, Jan 24, 2025 at 04:30:33PM -0800, Rita Han (she/her) wrote:
> Hi all,
> 
> I am currently working on validating PCIe DPC above Mellanox devices,
> and I've encountered issues where the device does not recover after
> injecting DPC above it with ENOMEM returned from rdma_create_qp. It
> seems that the rdma-core library does not support hotplugging or
> handle the removal of InfiniBand devices
> (RDMA_CM_EVENT_DEVICE_REMOVAL).

I was under impression that rdma-core supports it.
RDMA-CM disassociate support - https://github.com/linux-rdma/rdma-core/pull/750

Thanks

