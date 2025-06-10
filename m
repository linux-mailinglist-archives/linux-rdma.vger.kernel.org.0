Return-Path: <linux-rdma+bounces-11170-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF68AD43C1
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 22:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398503A5E1C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 20:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E632525DD01;
	Tue, 10 Jun 2025 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ekqP1kus"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19F17BD3;
	Tue, 10 Jun 2025 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749587433; cv=none; b=KmCc5mAZYqyCH/o0iOxyb6r7Pz9PYu43Q8EG8djwjARgPWbfGCDj01++Vd4ovenIX4h/ml4OPnki1fF+Xk1ygWmDHEQy4oIJWzAUeOyxK1FlqOFvI3ofjYolsOdQtfRNEf+7lNJm88ffC+pLI/5RLHJQ5DJmib9Sgxs5jh+Pai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749587433; c=relaxed/simple;
	bh=HQMB3+SvPse3R8MIezTVy0RDBSmkU6Tpe6NCORXyq+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh6dFGghk+g1qdGUTOWxewb5pCUVA44OYpDJZc75my2oZBcLLFS7pZJiXpySDk5ZOVHAGp3/vJQyDGOpCPkQjC1iuGuetxVj+8xI+Gu6xht4L0gvpNnWLr/8sEdKqkGNxXv5ezXpwO/xP7h5JC0CFUnJrn6Rp22Y/Hhjy1uMMNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ekqP1kus; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lDxmLE1jPO1VI0jONs4c76mO7n1Vg87qiWp7hT7GcV8=; b=ekqP1kuso37czHfXAgPFieh6HP
	Q5LAx66x9P2+6ygrdhjfTWdlCyKzfgH0krWckymGTyG5J83WZxcdK45DiAbd5fd7HgnUq+6gvSW/D
	r+IW+CKDdMZs/luprXm0Y315xLDxRBtEqSOuB7MsgkWeYwsQuIT8N5h0bZTxyi6+qrGg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uP5c3-00FJqb-MK; Tue, 10 Jun 2025 22:30:27 +0200
Date: Tue, 10 Jun 2025 22:30:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH RFC v1] rds: Expose feature parameters via sysfs and ELF
 note
Message-ID: <4531f0f8-db0e-4a94-82a3-f1f8fccea865@lunn.ch>
References: <20250610191144.422161-1-konrad.wilk@oracle.com>
 <20250610191144.422161-2-konrad.wilk@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610191144.422161-2-konrad.wilk@oracle.com>

> +What:		/sys/module/rds/parameters/rds_ioctl_set_tos
> +Date:		Jun 2025
> +Contact:	rds-devel@oss.oracle.com
> +Description:
> +		The RDS driver supports the mechanism to set on a socket
> +		the Quality of Service.
> +
> +		The returned value is the socket ioctl number and this is read-only.

From this, can i imply that the IOCTL number has changed sometime in
the past? That would be an ABI break, which is not good.

More likely, none of the IOCTL numbers have changed. All you need to
know is if the file exists or not. So i would makes the files the same
as /dev/null.

Also, these are not actually parameters to the module, so putting them
in parameters seems confusing at best.

I doubt this is the first time this problem has been addressed in the
kernel. Maybe look at:

$ find /sys -name "*features*"
/sys/kernel/security/apparmor/features
/sys/kernel/cgroup/features

and see if you can copy/paste ideas/code from there. And also ask them
if this was a good idea, or they say not don't do that, it was a bad
idea, just call the IOCTL and test for ENOIOCTLCMD.

	Andrew

