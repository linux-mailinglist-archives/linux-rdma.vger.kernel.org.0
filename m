Return-Path: <linux-rdma+bounces-4779-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DE596E4AA
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 23:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A4D1C2371D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD721A7274;
	Thu,  5 Sep 2024 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yAlZTpYh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1E190055;
	Thu,  5 Sep 2024 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725570745; cv=none; b=e2jNIRATBvFmjBLA+2C3A/9WxVNG/1IjRdEDySX7zKLNEMhzgsBkwpob3b8oml3ChiVERmx21ybMhhO/LV0TPfffiRnNKS65Cky0PGbIm5C3BcsR6HlookTyuPYroniwdxrDtdk9U7EXFT/nRMJFvqddIPyNgiNapPfdClDehhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725570745; c=relaxed/simple;
	bh=+bOa6QW5FmuMcO105/LbMmVHUNVXol8GWDUPshcMEL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBnMtpEsGiaAYlVRTtmpJVvdVZ/rCkQWJlscoYD9/6OsE5jlUptZ0AFc/juCFp4OH1c96GlFSLm7W2iZ/oUq1AxFYr4k5iqFj4V89gx+Gl/GFowPVyRWOlxtBhDyTPiMq7/34iw9BKP/EBXxD1bWG2lVgLWaQpwRk3Btz7qfpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yAlZTpYh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DUUCJRCL/bp0W09NMfCQBXj6Ku3xJmKiYVLu17As/b0=; b=yAlZTpYht7UwGy88iN+mnO1WaM
	Q+VcufKbb2ac1RZXYNlBLPMKoUfzmeGTXTovhWTwW/w83cEJKSCaF4ltTn/z8lpMt8tltUAaQ3boB
	Ki7wOtzKN81ozoZFNbVYHQW+iIoJTXBc1yw4nKW1M20FGJX9QbqhROrwTqN1+FVLJ9AY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smJm3-006ioi-N8; Thu, 05 Sep 2024 23:12:15 +0200
Date: Thu, 5 Sep 2024 23:12:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
	wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next v2] net/smc: add sysctl for smc_limit_hs
Message-ID: <9a3aec30-37a6-4c62-b2b6-186468b6a68f@lunn.ch>
References: <1724207797-79030-1-git-send-email-alibuda@linux.alibaba.com>
 <0ccd6ef0-f642-45c3-a914-a54b50e11544@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ccd6ef0-f642-45c3-a914-a54b50e11544@linux.alibaba.com>

> Hi everyone,
> 
> Just a quick reminder regarding the patch that seems to have been
> overlooked, possibly dues to its status was
> mistakenly updated to change request ?

Once it gets set to change request, it is effectively dead. Please
repost.

	Andrew

