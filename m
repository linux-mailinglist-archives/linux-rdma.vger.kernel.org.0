Return-Path: <linux-rdma+bounces-6694-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666049F9F59
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 09:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDE7167382
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 08:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D031E9B3C;
	Sat, 21 Dec 2024 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BBFR7+ng"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DAF1DE2BA
	for <linux-rdma@vger.kernel.org>; Sat, 21 Dec 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734770276; cv=none; b=V96BCo39aAlKkuSKXB2rFeQCN0H2t8Xse2hk9LTprM36W63pI6nv3S8k8BgXdN+YELMAVapVQiKGlXKrGD/wiScvxj4s9S0eZFvON9/0N+5k8jQsHYT12YTW6ToZBK/h0/s88Uo2qlF03NaZcCYjmL5Z+4dq5H1Y8j5xBDafVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734770276; c=relaxed/simple;
	bh=UL3Sf6uBk05ivJq0pWe3qNJzZkxUnt+8W7nARGBSjpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SecQbxobzboBRuO32d6CoTSSntp0voX7lcLgyaWJQyLuJUyH91DT7X2X7Q6QBxP7XAvjRi0wjhyM5x3TbE9OCvbFEkPxc+yWuntDwX+GLzAVlVq17RXdP8IYgu1xHbRAhvK6XPRf9BPYsdTgmb+EMVyJZKnz71OalXD15JfIQbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BBFR7+ng; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7f0908c3-f730-4c5d-88d7-85677810082a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734770272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=icSdx9/MWHiX3V/PMC7h3dLMlG6j9oI5Om2PXl9q7eM=;
	b=BBFR7+ngGbF3viR8GleE99x4wZ37YlwuR3rRKNA568Ibqoph3rAQZ/P9pbF+fWDHOCO+fG
	1zcaodNrgzSSojcHq4hlHYVq+6pejOcurAch8zpIiAOJ9qxmE+WVbv2l/6IIuycZ8sGEYX
	+47TWPf0JSwBsnRNnBUKrQWGmL5XZv0=
Date: Sat, 21 Dec 2024 09:37:46 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: failed to allocate device WQ
To: Holger Kiehl <Holger.Kiehl@dwd.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <8328f0ab-fbd8-5d43-fbb3-f2954ccbd779@praktifix.dwd.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <8328f0ab-fbd8-5d43-fbb3-f2954ccbd779@praktifix.dwd.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/12/20 18:10, Holger Kiehl 写道:
> Hello,
> 
> since upgrading from kernel 6.10 to 6.11 (also 6.12) one Infiniband
> card sometimes hits this error:
> 
>     kernel: workqueue: Failed to create a rescuer kthread for wq "ipoib_wq": -EINTR
>     kernel: ib0: failed to allocate device WQ
>     kernel: mlx5_1: failed to initialize device: ib0 port 1 (ret = -12)
>     kernel: mlx5_1: couldn't register ipoib port 1; error -12
> 
> The system has two cards:
> 
>     41:00.0 Infiniband controller: Mellanox Technologies MT28908 Family [ConnectX-6]
>     c4:00.0 Infiniband controller: Mellanox Technologies MT28908 Family [ConnectX-6]
> 
> If that happens one cannot use that card for TCP/IP communication. It does
> not always happen, but when it does it always happens with the second
> card mlx5_1. Never with mlx5_0. This happens on four different systems.
> 
> Any idea what I can do to stop this from happening?
> 
> Regards,
> Holger
> 
> PS: Firmware for both cards is 20.41.1000

It is very possible that FW is not compatible with the driver. IMO, you 
can make tests with Mellanox OFED.

If the driver is compatible with FW, this problem should disappear.

Zhu Yanjun

