Return-Path: <linux-rdma+bounces-1363-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE16A877699
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 13:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEFC1C20E97
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6DD208A1;
	Sun, 10 Mar 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="lC0KogEM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F316FF23;
	Sun, 10 Mar 2024 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710074214; cv=none; b=bDNh87do+c1ghCPPj/GynvoFUvXA+FJBWsXFBBPxoAOEB2y/3o7FtrMg1UPg3nwXQJb77Qvg5xYsvFLESLytxyO85Xnd69S9aohOHF/Widn4D2W6yZ7cDcl9rukOETjorQhSjqV06FqjEubYBBJvwfdXbrgZ1e5DmLFMTwc5mZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710074214; c=relaxed/simple;
	bh=FHkI/XTtwAO2bphz0FP9YeV3o6idfDLKkX3YyUFYqv0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=buo48tZermijYUiXKfQnZbZnZfAscQifQdWIJxxfmAozfpe/Dw7bZxAEpwFM+JE/6Jfo04Qz9+//GC9jEs/CQoDB3sUqsqmlkhDGOlsR5OHXT5v6lckM0ZLpWX7L43abHvJAOtI3hAagx2ZxHbdYL1J3D+EBWJ139T5Rhcw+/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=lC0KogEM; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710074198; bh=xhILMpXmjh62wZTAFQ4UaRzNQOPst+CVs6ZuyVeh/8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lC0KogEMEb/4iYqtfE1JaBUbZWTUCwNNxfLA9Ts4s+z1SQaN3GFMYxE0M+lW1Ss6H
	 dwZrAcjiFJD3MIn5iR0dJqH4KmTGUKFQS5p1ut6TsGSa18AL01rXlGFra4jMeXqKk5
	 5iXtxpcC/6LsVVrHbXkgZr3uBDLjVQxUm+WN35Zc=
Received: from localhost.localdomain ([58.213.8.163])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 9241D2F1; Sun, 10 Mar 2024 20:36:36 +0800
X-QQ-mid: xmsmtpt1710074196tfumjurs7
Message-ID: <tencent_688B20450ABBA409637C5A4BC3A7B0191D07@qq.com>
X-QQ-XMAILINFO: OGvgEoGelOUdHurlUnToO+m81M24ckg367b+/dp254AnKIZvlDyeKxKrO/gMk8
	 b91c0QhLa5yZIEWaZh9v7Jna9+dCVnEERKBOevSHhyAy9cLOjQXANaCddOL8ZN8JxILN6U77Xru1
	 QVbA1f5m4AWaWg8VNZwSVf4ivmkfO2+5gFrX4jr+nV09E3FxBBQ4u6VwvyndyaZuDumDHRHT6Rnw
	 QCIWlmKPLfcY+b+eCN+9AmfpYwTNJXGtA2Yhp4RnoYHAtaRmoukCnXxERtuft+UC7ZbLJ3pzPRQ6
	 COp9Lslu2Amk+GjOuzVWPvtG231gXP4JL2hDI0heS49SenvKdRC327Sg98reVIZyrVg2LRBHupc0
	 DFvu48aDs+avBWS04mdOfGt6WkTx8PRtaFy6m7dGfSKP4ZnRcjlcV56OxAkEcKNP2YG8iswWFA+k
	 1tZuo1RwGB+hz6ZhtLOTGGX9vcFa7L9aKebO+MUIz+8cu/drP55USYMxPcfkW5Hr+lQDTXq4YsBq
	 5GqXmIv/Xfo/VU9RBFtXUBLfJ+Qt6SxKX1cGt3cIklWdFi7sVq8ZWNw5rZB1ij1v47+TkROWTo6f
	 wKU75smHb4x/vYy4FJlNoryWlDEPxkoax1fR5c+EP1nPVmvc51HdkdWEElJ1pECC7n326Y96POZd
	 bqDEOAFojecnMyXy6LosOIKIptAJ1qneXQcadj1e2K7F6ZY/eRL3QCr0Cdm73Z0/dryH9AsDtDrq
	 Qdv55k9Zvlfa35nM3i5x2V2bMEDLxUFanzM8fzw95w80MyBUG3sT1Cxdf9a2S+vh8xlGvuO6pm7P
	 dazVStddgY89245lLr1oETDaWRMBSw+2Bu2toXkkv46iRNYFWNdjTnPNXiZPq5YZ4tg1zdBy5Q06
	 BuDznGL0Ph6M+JnKnRvILKKA8EsRsadp733EfZM9lV6Hgta3HhXQehONeCYBIaDOfGu478YKhVDX
	 REoSyXMrLQQiGlT7pq0OCi/Qp8Jp75MKfJVlWI3N7P+7cFB3gkNwMn1P5xzlyGzIMaxrmNmIkOvL
	 UyABIfAswCiZ4ta8uqFMo8/Rhy1aXie9A289yM+9yGHxykl5nQRri+B6oO0eMZBs33dCnR5A==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: linke li <lilinke99@qq.com>
To: yanjun.zhu@linux.dev
Cc: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of re-reading it
Date: Sun, 10 Mar 2024 20:36:34 +0800
X-OQ-MSGID: <20240310123634.69189-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <2d508574-c2b8-489b-a26d-71b1c36961cf@linux.dev>
References: <2d508574-c2b8-489b-a26d-71b1c36961cf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> In a complicated environment, for example, this function is called many 
> times at the same time and orqe->flags is changed at the same time, I am 
> not sure if this will introduce risks or not.

I think one function of READ_ONCE is to read a valid value while the value
may change concurrently. And there is a smp() above the READ_ONCE, which
means that the READ_ONCE is well ordered. I think it is kind of safe here.

> if you need to ensure the consistency of the flags throughout the function, not sure if the following is better or not.

> if (((orqe_flags=READ_ONCE(orqe->flags))) & SIW_WQE_VALID) {

This patch looks like exactly do the same things. The only difference I
think is the code style.

Thanks,
Linke


