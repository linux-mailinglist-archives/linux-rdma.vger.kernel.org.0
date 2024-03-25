Return-Path: <linux-rdma+bounces-1552-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0272388B244
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 22:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F0D1C63609
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5C66B56;
	Mon, 25 Mar 2024 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQB/RO/B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAF95B1E8;
	Mon, 25 Mar 2024 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400687; cv=none; b=XbEJSi1DiD6qQdrMT51AW+ZGOld1pEod9mCk98guEVTfcMYGOH9bx1P1GgXJCqY+05pjPs9U+eC88QQYKCkPw0qbE1CDa2ttxCNziOCkJ0bjKisCIo8QNqHtyezuZM+aHyXkLA1nFmtU30Tik+9+jBiporoQM67nl/0QYwLtabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400687; c=relaxed/simple;
	bh=dQwGwZ+Gav/BpPhKx3Wa0ikFo4EZJchq5Waw+sq2uOE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xl2YP09k0IO+mC6ghOuUjw7LtPiEaKNo88uXRfGNZbGz2/eURDAjcE3Rr86vz3Bpa899oz13LldOjvCz2hm0ASsXUohgY2lUQuUgx3yCFRpVlCuh3X5IG0mAPkAeIb0gUtu4lKDe9e8LlJ74dvqkkw2cguiwC4Z6k9KkKUVoNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQB/RO/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA71C433F1;
	Mon, 25 Mar 2024 21:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711400686;
	bh=dQwGwZ+Gav/BpPhKx3Wa0ikFo4EZJchq5Waw+sq2uOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aQB/RO/BdbSwsm4YVZOTcLoSEoHNn1nENBpDFKUfosZwRbY6uK+mzFHmQX3R2A3bz
	 Lr+uvxIaoRmIFH64uTfjIz4xZjz/mqSot2JFYFo8bhh/dH8jDck2MzEvLuab/6QtVs
	 N3ao6t6vj+p8usmZbstXhSMgGJDHiJs9X7sjH9ltdCNb1aLiII2n0eQyUy4EOKHS/r
	 4pEc+5pIpfQ54Y751Gr9hY2iRSNc+uyTQu3w3X15NmFwMUal1vmNajw6blETHn9dYk
	 SvwXtnqDJ0Q3dKnkfZcslSJjhcjxB0RSn8pAjhrzBk9kIvMUoEomg/E0SdzIV/Koz/
	 e1s8/FRDSrkrA==
Date: Mon, 25 Mar 2024 16:04:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
	Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
	amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/28] mfd: intel-lpss-pci: Use PCI_IRQ_INTX
Message-ID: <20240325210444.GA1449676@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHS-qZliVyFD5xh@smile.fi.intel.com>

On Mon, Mar 25, 2024 at 09:39:38PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 25, 2024 at 04:09:20PM +0900, Damien Le Moal wrote:
> > Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> > macro.
> 
> Not needed anymore. MFD subsystem has a patch moving this to MSI support.
> But you need to coordinate with Lee how to proceed (in case of conflicts MFD
> version should be taken).

Thanks!  It looks like your patch [1] has been applied already and
makes this one obsolete, so I dropped this one from the series.

Bjorn

[1] https://lore.kernel.org/all/20240312165905.1764507-1-andriy.shevchenko@linux.intel.com/

