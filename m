Return-Path: <linux-rdma+bounces-1564-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC5A88BC5A
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 09:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517061C2CC85
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 08:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722D5137779;
	Tue, 26 Mar 2024 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RxG/ncDU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D71369B8;
	Tue, 26 Mar 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711441699; cv=none; b=MPEkKqRpu6+G09fNV+hdIDoXpNILUsV1VnumWf7fq/obHsZubSQO6yssIONs1KmFS7CCM1TyeOwxqk52lgxmEDk83TOwOpQ9jBQhpnQ0DSVcfuxX2RX/5M75Fgivi+wwsSxlyxzL1q8bqiRYHM3wOEqslF8sk9oijZsrmN96uYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711441699; c=relaxed/simple;
	bh=96BDswjuIPcZg1qhOZIkzTSwczxsMEua47evXf14TnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts0hAJe6+m3emiy7aNmF4e4wDNbdyXT4YasilSISdtdHszeIVZyBYbZaSoG9fWfl/lLZW7hPk+YARAo/3MQTKAy2+T0mFoWHaxbrRDtdF3RbQ1AE5DrnIBiK6abUeLIy3EYQ+9KvzdtdpMXSstZqY5k43gTJ+mtIUUXC6NJAObk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RxG/ncDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09485C43390;
	Tue, 26 Mar 2024 08:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711441698;
	bh=96BDswjuIPcZg1qhOZIkzTSwczxsMEua47evXf14TnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxG/ncDUNX4/TQRQ37YMA/tgly5hlKCcMt7eJY0HhwuFwTGKbpHnqDXspdqXSeTAz
	 6/Y0SZpQZS7m7O59ZsyIkMKIARh7/BDEvQVP+xzLqN+WCNa0lvdQK0bvME1twyoLP7
	 EjKWKE6g0qxwIv7z73HaM8pwD+C6vl8IYemUdXG4=
Date: Tue, 26 Mar 2024 09:28:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
	Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
	amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/28] usb: hcd-pci: Use PCI_IRQ_INTX
Message-ID: <2024032609-rage-faceplate-23be@gregkh>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-6-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325070944.3600338-6-dlemoal@kernel.org>

On Mon, Mar 25, 2024 at 04:09:16PM +0900, Damien Le Moal wrote:
> Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> macro.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

