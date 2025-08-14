Return-Path: <linux-rdma+bounces-12748-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09679B25B86
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 08:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BCE1C85ABF
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 06:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E4238C36;
	Thu, 14 Aug 2025 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pB4o/+if"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FBF22AE65;
	Thu, 14 Aug 2025 06:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151442; cv=none; b=ZWtIM1R56fYMDVL9Aqi3auIYnqeruqMfz7s3Yl9WlikWk8F5KuuAhN8Ipzv95a585u0uZcP09neyMZb+mizYaDAI2xRG93IduNEvyaFEK1m90hVUcFtmqCc81mCVNLS2z/GipmowMjB+O2b1xg2BX8P3uK6a6ZDoVMDk2tFnC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151442; c=relaxed/simple;
	bh=60Ftf0DARQkpjZvRX6ryo7HU42ZASmSF5OfaZKP+h2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Npz9o8MWUrSfm8dqW6Fb4am81MRaDBGQc7bhheFQYq7nEUqqWMUSDPU2a6gdfQjWwfzEF/PX8K8Xf3HHpyr0VIuyOWet+JTs6yiPVJ119s2mnw83Xv3V3tNqgaIz/P5wcc+efzkHIdBWySBcu+eCaqkwGAbRsWw6WDpVlq80MO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pB4o/+if; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XJNzi2C0gN4PJ/y69bDjrKc7lnX+PbRVUIRwlssDM1Y=; b=pB4o/+ifLt4CQSmrt6q+08RTAr
	ejT+P8jGFWUx7m5P6z0hEsi3bQJyjseBuzQpDOaGzHEt1YDMVM5itInNIiIYyDH7/zoCJzB+WDUyG
	jbQXy6TNlsnsFxYHHE2+PJRmrZcufoM9W7Tbdzs6PLEVd3FFotVEemWmp5yhN4NuqqHm8QBUYLYyJ
	/RVfimbe6boAsH25+SiIEbz31ETPtkqy5UPE2Vtc4v8KJHGn1st/v4TIREXuwtW//QXvVa2OrC3zX
	xAu+eix3QcsySbZfJMjRTZWwKiapNeVkJkasqwDawaC0ct9b/U3FehFzKH3mYdHg8WJcENCFpUa2T
	bwKZL/cA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umR4A-0000000Ftj7-3zIX;
	Thu, 14 Aug 2025 06:03:58 +0000
Message-ID: <095d545c-d3cf-4029-9b57-639e27a7fed5@infradead.org>
Date: Wed, 13 Aug 2025 23:03:57 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/14] RDMA/ionic: Add Makefile/Kconfig to kernel build
 environment
To: Abhijit Gangurde <abhijit.gangurde@amd.com>, brett.creeley@amd.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca, leon@kernel.org,
 andrew+netdev@lunn.ch
Cc: sln@onemain.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
 <20250814053900.1452408-15-abhijit.gangurde@amd.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250814053900.1452408-15-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/25 10:39 PM, Abhijit Gangurde wrote:
> +Support
> +=======
> +
> +For general Linux rdma support, please use the rdma mailing
> +list, which is monitored by AMD Pensando personnel::

s/rdma/RDMA/ 2 times.

-- 
~Randy


