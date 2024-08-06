Return-Path: <linux-rdma+bounces-4223-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D10E794986F
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 21:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AA21F22340
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2024 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341FD14F9CC;
	Tue,  6 Aug 2024 19:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6U4GKhQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7B14B06C;
	Tue,  6 Aug 2024 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972987; cv=none; b=TWQSlTxuLFDDGlE6JXZZLd4qy45O+chU4dxVEajlRFbN5n3toap5ccd3KtivaBOKFUjH7FZ49GoJBfJmhnX3H3BNL8mQwN5L4DPDNG77D392+liJPQdHFzVGPk60dUFSKQVvc2Ju/OUnrC+v7KEFPVRy5pd2bLrTvy6dPFgcho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972987; c=relaxed/simple;
	bh=sc3W7vyVOLMiqCp+8siDA6OhvxTfa07DqrM7vyqqtQg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CfN0yGqEzCTAtFb/XG/Ql3Ky3sYzbHEArbh+IzARCLXm79tT7qWTb8xajawqt1JIz8fWBtW7BRYM8kh/YT2dQgaFE91Oa1D91m577Aj12DoZIGI+o9t8Ha+kLZ9Zc/qzkodm58O4XMpYWdJ+7OmadU8cvjGDva6sK1r0+ohf+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6U4GKhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19283C32786;
	Tue,  6 Aug 2024 19:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972984;
	bh=sc3W7vyVOLMiqCp+8siDA6OhvxTfa07DqrM7vyqqtQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=J6U4GKhQHq2r95nPZIN9AKQw9uIc/m8Px1mUUL+OGd4whSuOa5T4JhCQQRm7ykbds
	 m+dtVS1i8WQG+TsI3DraVl4ByJpQn4qZfG2tdczdw7QF175p2sPq0TL0IG5rtNiLgv
	 I6A156sj3pWp9tXQ9yH941Y30ueG3eFuVRJqThW5DtwMhrs8uOf9JiJMuGMqZoSkBx
	 DmaR8SZRW5ioUcan5fjVwDeJM4IwrR8Fw5NGU+JfMQrrpSwVmCvngbvdrD3Wmij3yy
	 fW1S2QapgzIzfvg5fNgpETIZjQ1erBNGLbPSkFNo18oxxMMk4lyZ5fStAxuMSpGU9C
	 tjIdDX5I4WsuA==
Date: Tue, 6 Aug 2024 14:36:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: macro@orcam.me.uk, alex.williamson@redhat.com, bhelgaas@google.com,
	davem@davemloft.net, david.abdurachmanov@gmail.com,
	edumazet@google.com, kuba@kernel.org, leon@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de, mahesh@linux.ibm.com,
	mika.westerberg@linux.intel.com, netdev@vger.kernel.org,
	npiggin@gmail.com, oohall@gmail.com, pabeni@redhat.com,
	pali@kernel.org, saeedm@nvidia.com, sr@denx.de,
	wilson@tuliptree.org
Subject: Re: PCI: Work around PCIe link training failures
Message-ID: <20240806193622.GA74589@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806000659.30859-1-mattc@purestorage.com>

On Mon, Aug 05, 2024 at 06:06:59PM -0600, Matthew W Carlis wrote:
> Hello again. I just realized that my first response to this thread two weeks
> ago was not actually starting from the end of the discussion. I hope I found
> it now... Must say sorry for this I am still figuring out how to follow these
> threads.
> I need to ask if we can either revert this patch or only modify the quirk to
> only run on the device in mention (ASMedia ASM2824). We have now identified
> it as causing devices to get stuck at Gen1 in multiple generations of our
> hardware & across product lines on ports were hot-plug is common. To be a
> little more specific it includes Intel root ports and Broadcomm PCIe switch
> ports and also Microchip PCIe switch ports.
> The most common place where we see our systems getting stuck at Gen1 is with
> device power cycling. If a device is powered on and then off quickly then the
> link will of course fail to train & the consequence here is that the port is
> forced to Gen1 forever. Does anybody know why the patch will only remove the
> forced Gen1 speed from the ASMedia device?

Thanks for keeping this thread alive.  I don't know the fix, but it
does seem like this series made wASMedia ASM2824 work better but
caused regressions elsewhere, so maybe we just need to accept that
ASM2824 is slightly broken and doesn't work as well as it should.

Bjorn

