Return-Path: <linux-rdma+bounces-12747-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 734DCB25B74
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 08:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAD3178C0C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 06:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FAD235044;
	Thu, 14 Aug 2025 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ChL7xFU6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E3D230BD2;
	Thu, 14 Aug 2025 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151251; cv=none; b=W/J9KDI/bTwvzkx9u5RJq0GCgdeeBw6fH+N+UGG+mmg2xoUmw/Z6dTc3ggwTT+ul75qdHJuip/L7EBvvwJjJnxK7LaJ6b9E5zDRly/Py5HWcfUM02y9ef2NvMRoOfphTO4/zdii/hUNUMEwgsnn9/4hlT99o2U8uI76c/Uj9rIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151251; c=relaxed/simple;
	bh=JC/RWVioF1QV3ACGfJLGvNWucnG7XrmTqAIPB21t45Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uX6o0/1x4TObQo65UHaopFqoZJHU/1T8Ue1VOqtHF4iDYcx5Uk43Q8bcSO4GCUHH2TgAcwj6TStA4l1IBuT4NDNwWv0oIAPzbzpenPFEpDl6v+c5W8y2109RlHU0ERCoBvtQFd8cgO4guTqngn5ZX6S3PxbzD8c/JDmKbx/qjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ChL7xFU6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VHwBCELpy483gJxb6QuMvzNBeU1vQC2waNJoabTWiKU=; b=ChL7xFU61wQj98+eRVxbj6+nOp
	dRLr8ewfvO5xwGwenuItHN5CApsc1a/oaJOChoROm7p4/7x3gCPjrz7igCSU0UIelKnKTZ1mB9ZAE
	73wxUu/fBbxaLQzS6qMiGlmKNKbhmixdMClnCmUSdxzbTef6ekagcTN8gkm5L/DbRkmneeXh2Pf30
	PCRDxEwhAz5Xebdm0wpYP9+Rwc+uuMb7/o6ZQRgEqocZSohu/aZRiwQah2115FdZhjZjpUI8QerM3
	yy9QoyUFNSh7mL/n1MTN/24hb+dNT6u+RW2OPwmfPXP4cv2hysWPJHHyE9ur1FmCdqrkdFnA+zTfh
	oj3wgJvQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umR14-0000000Fszj-1NYZ;
	Thu, 14 Aug 2025 06:00:46 +0000
Message-ID: <4c51b440-03c2-43cf-b9c9-67c0be3c3c25@infradead.org>
Date: Wed, 13 Aug 2025 23:00:44 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/14] net: ionic: Create an auxiliary device for rdma
 driver
To: Abhijit Gangurde <abhijit.gangurde@amd.com>, brett.creeley@amd.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca, leon@kernel.org,
 andrew+netdev@lunn.ch
Cc: sln@onemain.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shannon Nelson <shannon.nelson@amd.com>
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
 <20250814053900.1452408-2-abhijit.gangurde@amd.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250814053900.1452408-2-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/25 10:38 PM, Abhijit Gangurde wrote:
> +RDMA Support via Auxiliary Device
> +=================================
> +
> +The ionic driver supports RDMA (Remote Direct Memory Access) functionality
> +through the Linux auxiliary device framework when advertised by the firmware.
> +RDMA capability is detected during device initialization, and if supported,
> +the ethernet driver will create an auxiliary device that allows the rdma

s/rdma/RDMA/ as is used elsewhere. (?)

> +driver to bind and provide InfiniBand/RoCE functionality.
> +

-- 
~Randy


