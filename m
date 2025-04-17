Return-Path: <linux-rdma+bounces-9523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3906A91E3B
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF2819E7697
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 13:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9262B24BBF8;
	Thu, 17 Apr 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bN2HJ9+w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C1F24BBE5;
	Thu, 17 Apr 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897163; cv=none; b=MPlpXmpuPQObVi2qCVcChBuIdH8+Uc3kpvKolfQ0n0QDMOemb23udsMKr20IomqPe6uzNn3hZfrt7m1vITZ6atOJ7P+2LrgA24qHnDp1ECm/OOk4iw0wV9s3Vk7wAQ5aYlMvljH5ldgA8wiFKeSRrbGcMM0OK9buBbXkfEIq9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897163; c=relaxed/simple;
	bh=C7wAWc8APSL79TtUAcTI7txGwu3TsmVXYyy8u8T2vb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OC45nOAvmUgPT+6x0xwi3/mPOM/YALgCr2L105bImzghfUQoCs4rmCFHnOc4AnPB8Sej6GzDFqXGvtZT1WOUSysCyaevJyiNpKQQf7CSs3hjRiyvlYZYtE3vZF0ZuQiI/BiOCwsWEMKH9lEmssGkgZoyh2MZWoVTzz7D86ZF388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bN2HJ9+w; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744897162; x=1776433162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C7wAWc8APSL79TtUAcTI7txGwu3TsmVXYyy8u8T2vb8=;
  b=bN2HJ9+wYeHy1VKMFb9QEvX343X8j0moTLYaMv1VvageG4S2YNgmtmio
   iuRmK0ye4UcHYTnM3DsrSzs+GR5bZ8Ke0Z1zNSAAZo99Fg3QVJAfH8gHx
   fGDuEJ+0ewuZ0g4aVIqbsFG2IP5ghmFLZrAzN3jIxu2XEpKqEm0Osfz/Z
   tXIM2BpRNuxYO6BlSenccYaEz5U15MgUSi66AUo66nxvoges30/2sp+LP
   ggXdKg3o1D2fYsM7NK0vc4eNt7KqDqLpRizN6KF5FlZEMwglNKYmdnJZE
   26HNBDSI1/zpsj9ONQKK3TggyZNPNEYQO3BlfAs1l0fyQqROLlu/MNmOo
   Q==;
X-CSE-ConnectionGUID: iTiLT1TIS2WW9GvATYhp6g==
X-CSE-MsgGUID: ghmzGDxhSt2LJZ5NoHZX0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="50133116"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="50133116"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 06:39:21 -0700
X-CSE-ConnectionGUID: p3dR8Pc/TZ2ZAuqpm3aYyg==
X-CSE-MsgGUID: Gu+8ZZ8pRdOS/0xCVRwXtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="161758340"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.99]) ([172.28.180.99])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 06:39:16 -0700
Message-ID: <4918f292-46b5-491f-a8da-5d42432bde56@linux.intel.com>
Date: Thu, 17 Apr 2025 15:39:13 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 0/2] net: Don't use %pK
 through printk
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20250417-restricted-pointers-net-v2-0-94cf7ef8e6ae@linutronix.de>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20250417-restricted-pointers-net-v2-0-94cf7ef8e6ae@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-04-17 3:24 PM, Thomas Weißschuh wrote:
> acquire sleeping looks in atomic contexts.

typo? s/sleeping looks/sleeping locks/

present in patch descriptions as well

