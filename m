Return-Path: <linux-rdma+bounces-11173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F864AD441B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 22:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 445197A8893
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 20:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C194265CAF;
	Tue, 10 Jun 2025 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XadqBqK0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD0264A61;
	Tue, 10 Jun 2025 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749588610; cv=none; b=d+dj7KuSy7oIE+Khzf1SVaNzIjTbGmluL76m+Nr6XHGhMyu5R0Zu0o8TQCGvCe+ceF+DNo4fO2rCP2LLP5xUJpcoKWKe0K50CfElwBJROpvGDaCYuGVh7YU0D1lN+s/NTtfzytCexeeP5VAQ1Kbqb6sj8dh8I/BXrT1R+0Glxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749588610; c=relaxed/simple;
	bh=of7UYPlQNL0BUt5UhVuQaRt6pgNvumMg7Gi3ocSSEyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEJXtQryBXUx4ABHGY6srkCobutloqR+rkf5re4s9Obxg8bqqzINjiEparUUBEkMl9i4y50C/W6kPhAZBmXz5kSSUfOcFUugt/z9c4mbtiama/4/zmfn6b5WwFQuam55k3tLGZaELFV660tm06urzwVbJ40Ur3TjZtxXPoGqr2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XadqBqK0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vRTuGqOV61BtZUAA0h2cOCMoW50hggZm8Cvj6Rql+UI=; b=XadqBqK0ZleF25YwrRe90PmPoE
	+9N9/37eqzPmgXcPFrs+NqmjETGwzbOCZQxvCi1r+++JKJPF2kHgwxTWD7x6c/VNGba9GC6qfw5tg
	+XxfM/sO3R6LXkxwtTayqAoGYrVPDa72Mp3fP/wmJ58D/PpP9K60ol1YWeeQRJl0OSg8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uP5v4-00FJwt-9r; Tue, 10 Jun 2025 22:50:06 +0200
Date: Tue, 10 Jun 2025 22:50:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH RFC v1] rds: Expose feature parameters via sysfs and ELF
 note
Message-ID: <aaef74e8-5517-49ae-aaf5-2ca82ca4ee28@lunn.ch>
References: <20250610191144.422161-1-konrad.wilk@oracle.com>
 <20250610191144.422161-2-konrad.wilk@oracle.com>
 <4531f0f8-db0e-4a94-82a3-f1f8fccea865@lunn.ch>
 <aEiYNk7JjdOnK-5M@char.us.oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEiYNk7JjdOnK-5M@char.us.oracle.com>

> Right..
> > as /dev/null.
> 
> Not sure I follow. Make them the same a /dev/null? Meaning link them to
> /dev/null when the module is loaded?

I mean the contents of the file does not matter. All that matters is
if the file exists or not. The IOCTL etc should never change, and if
they do, the patch which changes them will be reverted. So i would
make them a 0 byte file. You can even make it have mode 0000.

However, i would first try to copy existing ideas...

	Andrew

