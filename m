Return-Path: <linux-rdma+bounces-6761-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5EF9FE304
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 07:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89DF01881868
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 06:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CE01991B8;
	Mon, 30 Dec 2024 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tJn5lgAr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFBE259482
	for <linux-rdma@vger.kernel.org>; Mon, 30 Dec 2024 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735541207; cv=none; b=olDGAPuQ++yd8V7oe6DQ4KvOArvWrQYdh0lNMbMjk8LYhiOVhXmfVUrnWGamXKL5TgGlKNXYaw+1Ob1i8wgt84ihR/m7gwuYWBC/AKj4NxaMdzjT68At6A/xnVg+A0DeKa/RHW8U0KMqu/2/RdJr8FMX/8HPP9V8tU0nBqW2wxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735541207; c=relaxed/simple;
	bh=ZozCgMM3J1cl35UrxdPK0asHt8ek9rfcj8trMDNu4b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqfrRMe7s7XWiZJfDcDBihrGxTkHnH62tcyyfj1ZpvgwO3BejMZTwMQ9JVYPyO/eBG0TXs83+jqJFCKqBl1D/9/4lCrdi0i1aUcUyygGVzKIzH6CK9yMz2KBYYvzRvh2UQzNpPLHEVtjZ4RgGHEwX5j4kXa2j6VHoNKFF/6T6zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tJn5lgAr; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5de4f98d-6253-426e-95f5-808a4fb595fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735541202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjnNeCMpCcZi6KKOO2XBXmgsiB9ybMwGuD4+BIQKvko=;
	b=tJn5lgArqHqrgm9V2erftaJvzZBQHG8Ba2szvuFseQ5re1upVti9Lj15B84XvOae1nVFWs
	P/sOTR/3AScRmlhyYU7JdXasXbrXmwZpgsqmzvAmQQEY5n0FTAnWB1pXjlStI0qjNmgYoe
	n3egCXlnC7gOgN774BaNaDymrboahL8=
Date: Mon, 30 Dec 2024 08:46:29 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Reset device on probe failure
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, Firas Jahjah <firasj@amazon.com>,
 Yonatan Nachum <ynachum@amazon.com>
References: <20241225131548.15155-1-mrgolin@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <20241225131548.15155-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 25/12/2024 15:15, Michael Margolin wrote:
> Make sure the device is being reset on driver exit whatever the reason
> is, to keep the device aligned and allow it to close shared resources
> (e.g. admin queue).
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
> @@ -685,7 +685,7 @@ static void efa_remove(struct pci_dev *pdev)
>  	struct efa_dev *dev = pci_get_drvdata(pdev);
>  
>  	efa_ib_device_remove(dev);

This already calls efa_com_dev_reset(), you now perform double reset in
the normal remove flow.

> -	efa_remove_device(pdev);
> +	efa_remove_device(pdev, false);
>  }

