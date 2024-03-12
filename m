Return-Path: <linux-rdma+bounces-1395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD2878C4B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 02:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33FE1C21837
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 01:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1078517FD;
	Tue, 12 Mar 2024 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ky1stH+F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D75680;
	Tue, 12 Mar 2024 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207078; cv=none; b=H4stL0Vn3xSlcDWYKK5AqyXZCCaR6wwHVQDNJyMlAPYQ0cjNvi68Quj9CHxbeuiz95r1rszM1jmYy5jWlw672vAPxytdpwdTyxWIFiqaVv6tfWTU81JPsvwdjgMhZH0l7hDPXEEDXJwiqCBFi/5nQScyIYpRC+HirQM0abcQhb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207078; c=relaxed/simple;
	bh=G7z5Xa20Y6OhAEEqHoy1gNyjz0yJL/0dWRXq5t5dXyc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=MyzkfoPBIq+5l1CUUsOdQNt4hebLa6TX4l5+gnlEGoRDfU07/cmGLk+MZRm5JBy3RzlkNxFSqJUHPj2LEIA2ICsIGOkqR/jD8sFL4U81dR41Fm22ZMsczeP62AWLoWeLzt6CBfLf93ay40DvHY+2/fir6LJjgf5ce6hDXzwM8b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ky1stH+F; arc=none smtp.client-ip=203.205.251.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710207057; bh=m7+wnQChZmkhnImIsbpelvMqvnfxMx9nnC44Q9Damq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ky1stH+F5O4JaBqvNk/IFkCfZyw5ZvAF++3SG77hnMgz2BxvQhdb+nwvrE+lbgNm0
	 7j0C9y/mbMJDIwZG3urXcNrmg0S315ZIMxByiEWqQCJ5eZ4lDhJb1pn6aUGs8ek97Z
	 JDbvCuO+Jc5I133L3CAvuz5Xk88tEZmUSxLlt7DA=
Received: from localhost.localdomain ([58.213.8.34])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 7B70F29F; Tue, 12 Mar 2024 09:30:55 +0800
X-QQ-mid: xmsmtpt1710207055t39dcbo8y
Message-ID: <tencent_0343C5B0419D94A0498AF8A447630B5A5807@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCMaijtKIZsKnezezVSBAor1mINA7DjMqxC4I8Pjz6pPJO/6z2Wo
	 5BnpZQXbrEV3nLxlYQrQFhHGfKXflJWuTZn8ni9z4kjZ34g2BeFB6QHkI98+VjP9j/ZpmwbNPkX3
	 R8BvQu22Cz+accpvkqTx57kmpQCFz2NuX9Ry1LNch32NFhqINF3tE2p2tCU/ZFh5GtyYnaaLPBu4
	 QGfn/M80LPLCqwyePZWtxHmttxbb0z84qV3ByXOxMuLX0WQiUbyqmLutD8o19zd3TDkOnT1OftRQ
	 8MpGeLm430x70uVHeb6TrWBWEa+lpZWzd+JMPb+ZoKA840p4BDdldyoAEJY7aMDBXH3k0CW0oqf2
	 nSRBMQDmgA4MrTf2Nc94RU5/+xhQE0I49WwV0jABh73Klhb/hil0lX2FOaOQTKdxenzf4GrFtX1a
	 uUJq815lJz/W7xlSewFTEpcKvWaxAyd3rkcvRLzk2rNLbyfqpsmuXlclOW4p3+9ltUlybD+ixIwh
	 owk6NUUqVLrh2edHFcRhZYr+yqslzFCzYwYzeG32RW48BY5QKcBYWjpmUdAdGfu3xvdB32Rmlec8
	 +20wCW0jqJ2I2kzIoDgGmBJsj2JEXOgOpJGzh85bTouuQuqFSWOha5ZOsOAKvuUJyX/NSQPhX4LU
	 8AGEyDn6Sr6P14vyNVzeVv+S9GuWdbm+Sgm31pWBlxUg091AoYiYjne0tPZhZFwJ2XWEYWkUD2ZQ
	 pAbbUPxUNUml2aWJcZ4Z37PPVegsp1TTcnnIwIM75eaVYKA6uMn0zXjSRpOnbZM5jYtfG510v1JQ
	 OjAequqlJpb3WMykjzDOMmwuVSrccvacWj1svXmP2Ef67g9Pzpk/lm0JDsxvDwqa5yqBah7IJs9i
	 GCc/csAZK7Zy5bTWxaNSR8UHHAT9QObU/MxFAIJA4KPi5UVO9i494mPpMdt5pJjeMZB1Jk+ATEho
	 LhpkSdsOfFcXslf5zAW1vQ+xjL/4KsJHxmW6rdueT+6h0Dy3OzP1jD/rIrPjgKKdrNZPq7mrw6aQ
	 VK3ctv0tnxbQB3mvv2
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: linke li <lilinke99@qq.com>
To: bmt@zurich.ibm.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of re-reading it
Date: Tue, 12 Mar 2024 09:30:53 +0800
X-OQ-MSGID: <20240312013053.84542-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <BYAPR15MB32080B7AA8255352C1F691A199242@BYAPR15MB3208.namprd15.prod.outlook.com>
References: <BYAPR15MB32080B7AA8255352C1F691A199242@BYAPR15MB3208.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your reasonal reply. That makes sense. But you may still
consider to make it better, like this patch, to read the flag only one 
time. It will avoid some potential risks. However, it depends on 
maintainer's choice.

Linke
Thanks


