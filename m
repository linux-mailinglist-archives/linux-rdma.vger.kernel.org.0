Return-Path: <linux-rdma+bounces-4773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E9096D758
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 13:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9792AB2423F
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25273199E93;
	Thu,  5 Sep 2024 11:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aMuExzC2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C4199E80;
	Thu,  5 Sep 2024 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536366; cv=none; b=auKz9P7DhGbl0P5KxnoNoy/dazpi2QcjbLMt1HOzaXp985aXj+JaYZOdY/oeYWgWF4M5SutemCqxGwi19oTwHbHQUlgJkpR8vh/HPEnvRCkP4P5FZ9ELDy9D1SXKXK+n4eU3K8cOWAv05M7mGNBChb1sfMloJfngPCfz0iZrTVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536366; c=relaxed/simple;
	bh=NaZHXiNtSs2ZlpSQWGN+YxPdz+YASnDe7DLJQj8SC7s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YHxWXtwWx3fqzsm+hk/XwEMleqRFbJMAL9L17pRgeHN6ZiNDoPz5WPQiFP2WB9kVvxn453M6CCVlZVJS/RweS/14moAeRGLTJ1Ub2sW0l0QBvZw6Iojidyihj0Fr2Awz3AJ3a+Cs5cwqmZLsxFAPsJm8kdEJvlaXiVaFMcTSSpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aMuExzC2; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725536360; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=/hhEMKtprsVbArv+yauOmIjjQBRgsz4rpXSeuzHNeQ0=;
	b=aMuExzC2CtUPOAeBwGr+vrLB0te5yT4S/RtLmO8b6PDfdgaN+505fnroLKPR9kQY6CsGbZ2hzclm/jRB+E8HgKSPuSb/X/AGSTNZFwXJFmRZnAW8v1qVJE6pEO/I/tNnYca+0+UXsfc0FuOo4ZfNnRei+vQlcJi9W6fjDNR/tw8=
Received: from 30.221.149.174(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WELXxjm_1725536358)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 19:39:19 +0800
Message-ID: <0ccd6ef0-f642-45c3-a914-a54b50e11544@linux.alibaba.com>
Date: Thu, 5 Sep 2024 19:39:17 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: add sysctl for smc_limit_hs
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1724207797-79030-1-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <1724207797-79030-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 8/21/24 10:36 AM, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> In commit 48b6190a0042 ("net/smc: Limit SMC visits when handshake workqueue congested"),
> we introduce a mechanism to put constraint on SMC connections visit
> according to the pressure of SMC handshake process.
>
> At that time, we believed that controlling the feature through netlink
> was sufficient. However, most people have realized now that netlink is
> not convenient in container scenarios, and sysctl is a more suitable
> approach.
>

Hi everyone,

Just a quick reminder regarding the patch that seems to have been 
overlooked, possibly dues to its status was
mistakenly updated to change request ? It seems that no further 
modifications are needed.

Best wishes,
D. Wythe

