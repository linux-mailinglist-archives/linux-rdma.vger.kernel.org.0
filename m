Return-Path: <linux-rdma+bounces-5365-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7023D998B35
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 17:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06201C20CA8
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040D41CBEBC;
	Thu, 10 Oct 2024 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="GcUiC6x5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EAAB646;
	Thu, 10 Oct 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573489; cv=none; b=lK3Nic9HJ19EK/X+lsYCoXbSuXbTrhJpQOg/pbqrZbPD1b6oIHMEilkXa+FMSaAyD5O2NftuTW6vt5at3DKN5xBlxkIr1uB+emY4m/YaO7fO5lAhsdCxspk5Kc7n9pgCaRx7V+xXqMDVCcHeHV6xww0i17MHWtcZb9un2htgaAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573489; c=relaxed/simple;
	bh=YUSySbBWp08I2dMPVF+Lo5oQQvSwVDiGRyoQNS9kAvM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cAoPODQ+kGrL3lveNL7GEBVZ8hpAO7wxauSoIGtD/cvJP9qcnbeAkAYrYs87g3iZy6CEPXHzqAsHmexHUESzVUi3GEXyRYyie8zaWfYC0fTWIm4ghyEJUIA2dGqmCtImFKI9nZA8aekNYzQq4C2uQgwf8wSjybl6MVDQ7cUTHgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=GcUiC6x5; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Received: from [10.10.34.132] (unknown [195.37.88.189])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 9793DE0361;
	Thu, 10 Oct 2024 17:11:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=uddkim-202310;
	t=1728573084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q+XKIu6e8sY0nrLlJEOX8BdUbse7XfS6RaSAivR5UEc=;
	b=GcUiC6x5igoKsl2yUQJs7vc5qYIz0zbnGgfzksVi7dzSyKmzgjg9wGR3ZfiPMBKG6D1X5i
	IfC1ukGJFT2Ap0Bv+m2coE1i+Ce+Vf/G3B8z3mrBm7CCrs2/ZFUTFh8nHuf1tXjUauxfN0
	/hfqKxYPJ2P/JoIddytKCBnJFyOyra0CjHYW6+6OVfg5jS1Dx66z+ez1/OB6Ip+1rgGscV
	L++n9+THXrJUdVDr6c2hMTtFZsbkP5MleTWNRxNUlb2SdQwf/x/pSqM3KemaqPRze6sYN+
	A7bDCIJTHQ4IfsO1Mz4HJx3oQCnan2AfLg/NtAtgDKUpR1dYqwFXU+QxM1VHKw==
Message-ID: <bc8ba1b7-e4ad-40b5-b69d-9ea1e7a18a40@tk154.de>
Date: Thu, 10 Oct 2024 17:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: saeedm@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
From: Til Kaiser <mail@tk154.de>
Subject: [BUG] net/mlx5: missing sysfs hwmon entry for ConnectX-4 cards
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=mail@tk154.de smtp.mailfrom=mail@tk154.de

Hello,

I noticed on our dual-port 100G ConnectX-4 cards (MT27700 Family) 
running Linux Kernel version 6.6.56 and the latest ConnectX-4 firmware 
version 12.28.2302 that we do not have a sysfs hwmon entry for reading 
temperature values.
When running Kernel version 6.6.32, the hwmon entry is there again, and 
I can read the temperature values of those cards.
Strangely, this problem doesn't occur on our ConnectX-4 Lx cards 
(MT27710 Family), regardless of which Kernel version I use.

I looked into the mlx5 core driver and noticed that it is checking the 
MCAM register here: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c?h=v6.6.56#n380.
When I removed that check, the hwmon entry reappeared again.

Looking into recent mlx5 commits regarding this MCAM register, I found 
this commit: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.6.56&id=fb035aa9a3f8fd327ab83b15a94929d2b9045995.
When I reverted this commit, the hwmon entry also reappeared again.

I also found a firmware bug fix regarding that register inside the 
ConnectX-4 Lx bug fix history here (Ref. 2339971): 
https://docs.nvidia.com/networking/display/connectx4lxfirmwarev14321900/bug+fixes+history.
I couldn't find such a firmware fix for the non-Lx ConnectX-4 cards. So, 
I'm unsure whether this might be a mlx5 driver or firmware issue.

Kind regards
Til

