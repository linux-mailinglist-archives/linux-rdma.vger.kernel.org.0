Return-Path: <linux-rdma+bounces-11929-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44737AFB248
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 13:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FB667A5851
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 11:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37631F09A5;
	Mon,  7 Jul 2025 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tYtQfaTf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83DFFBF0
	for <linux-rdma@vger.kernel.org>; Mon,  7 Jul 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751887861; cv=none; b=EGChF2tsF99w5OvVHEeaTlCMEgCvHIBlj/35X6v5KYOPyDGmhJTW6Ako9qS8xZQ93EK6n/WMovrs3hk51WPhDOIwKDjcqhWCq+b9Ci6t7kOO5Q42t3f+lSNyxEUOzIS9PhLs1DwFhnZdy7NGJ3BXKV5o7ran2aLstNY9z9Ug6xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751887861; c=relaxed/simple;
	bh=1RBRA2kn8ofFGQEcZmA0UEyEn8kmx2/iyfK7WtHzlws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwFmQfnZIdGNnjVTvyl/6VVnWVnkfkSxufeLx1LjbaGm2zGjTe6FJaLASxK7rS9iomkyvO8B1hswIRbfGS+MmvsMnWevaGnY4yKZRhrjeMYQ9xdow+go3Y7ThvaY2UjrJcEIrF+/dvgrMSxzr/b6mfrzRMQKJSJys1V36xPyjgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tYtQfaTf; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd404a3f-9555-4e6f-8c38-66d5e1ac2e44@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751887855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIg29e9LRATk4kZZyL6KqfBY2F7pB886LeCCcjlG69o=;
	b=tYtQfaTff8Bne4sjcfkSqEiGeD2QY8xlrxkoLVkLYXAOrtNfuhDRXPn3+QphnsEBBabxQS
	VhwY8h1UKb3W1WZG8ckUha0OkeDK4eTEMuzdnSdFpA3MDzueK0zP7c4d/Fih8ej990xB6k
	UPksSRHTpr0GUpaj0hoyqLUA5OKs/MQ=
Date: Mon, 7 Jul 2025 14:30:52 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v2] RDMA/efa: Extend admin timeout error print
To: Leon Romanovsky <leon@kernel.org>, "Margolin, Michael"
 <mrgolin@amazon.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org, sleybo@amazon.com,
 matua@amazon.com, Yonatan Nachum <ynachum@amazon.com>
References: <20250703182314.16442-1-mrgolin@amazon.com>
 <20250706072523.GQ6278@unreal>
 <2ca6de0f-e3d7-4d11-affc-259fd9deff40@amazon.com>
 <20250707062808.GT6278@unreal>
 <f8fc9034-41b4-4b2f-8032-1bc9d2bcdb99@amazon.com>
 <20250707102830.GV6278@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20250707102830.GV6278@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/07/2025 13:28, Leon Romanovsky wrote:
>> It's not for internal debug, it is used in production. Why would I upstream
>> internal debug prints?
> 
> It is used in internal cloud for the NICs not available to the rest of
> the world. So yes, it is your internal debug print.

It is available to literally anyone in the world through AWS, with
upstream kernel.

You may like or dislike the patch, but this argument has nothing to do
with anything.

