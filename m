Return-Path: <linux-rdma+bounces-3335-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6392A90F25F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0331F23202
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DBC14B96E;
	Wed, 19 Jun 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0tfTFKJ/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD42D05E;
	Wed, 19 Jun 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811640; cv=none; b=fvYL0o6+/Ku/q7iC7o0pIajhJRgU2s4vaI/q4hPBRkKEbOM0cSl2e1yz3gYiu+nNRz/axxqrkhRBOwfV5JEYizVoGCCsf6WRGTDzeM0bDlNykdeHitqKYOboMsVWWHaNysW3HSb/AQW0NA1aNfn9I9RfKzhKU6UGd35veb/YXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811640; c=relaxed/simple;
	bh=BDgZ3xDn9gxLkDVnmDBRwbhfKz7gr4CntoAHFbS/Gts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLDyHq6RcbFxAgD/TN31zvVKgiD1RSzP15z6fcnYJM7DsSwFK/5uZeQLlTi5mWAq5X656x8EkzaoSHEF3f7GU9kfV4PWFlFJTxu/M6G5AcMcA/9kr5Yj3ubWqLADTSvydDH575TODMyuBYN0bCTtRCux3fiXgKDW2nR56iwPLuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0tfTFKJ/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IKP7HtTH3mOIjMmVFrVD3bx20kA9x7VoTBKnsO5lB3E=; b=0tfTFKJ/mT+g/BYb8Xeh3lXaMZ
	87SRDailod8QsckmI4C70slKv5V6QMQ4u0WyMKO6vWcch5XKw/9xJOl+hLF86AbDk+1kdGZ+5+M8g
	LDOg+gdnjHNmRd5IP4xQDWpEq60zpKA7biAfVcWAKvgtVEyM91WZAW+7e/muqsgzoZWQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sJxQG-000Tz8-Sb; Wed, 19 Jun 2024 17:40:32 +0200
Date: Wed, 19 Jun 2024 17:40:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 09/15] net: hbl_en: add habanalabs Ethernet driver
Message-ID: <e45e8d84-ab71-4ac9-8e97-c2ee13629dd6@lunn.ch>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-10-oshpigelman@habana.ai>
 <20240614171618.3b65b3c9@hermes.local>
 <46806cc6-4008-467e-8ebf-cb70d1b8118c@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46806cc6-4008-467e-8ebf-cb70d1b8118c@habana.ai>

> > Does this device require IPv4? What about users and infrastructures that use IPv6 only?
> > IPv4 is legacy at this point.
> 
> Gaudi2 supports IPv4 only.

Really? I guess really old stuff, SLIP from 1988 does not support
IPv6, but i don't remember seeing anything from this century which
does not support passing IPv6 frames over a netdev.

     Andrew

