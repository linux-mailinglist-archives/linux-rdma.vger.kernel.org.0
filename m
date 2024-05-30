Return-Path: <linux-rdma+bounces-2684-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC79F8D4965
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 12:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CE21C220F9
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2024 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D74746453;
	Thu, 30 May 2024 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BKhm14Kx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB2176AB7;
	Thu, 30 May 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717064106; cv=none; b=tLDf1LnMAl/wXPS3ibqXYX6pF52wkJodNn2wSYqar76jUyL6i+6ZyBFh7jmlXBIWu9S3dcR8XlbJ1DSxPm87SZSCqQA3ASUwoV62GnWaLbqBud0YzDG8xsdDEXv4HGZv/dKu7JkkIXSEQWv4W+39booYtY0oxnrjIChjbPm9loc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717064106; c=relaxed/simple;
	bh=i8kpeNVl+8LuhAazbCNqPRnoJ3SJXIs/WARd8X+GA98=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OcaLGZM56ZAK+CJd+5kWdrCJ6gcetxKRhqBLdG3KiXd6gRoJOnG1Clkz+NHqsVNwLmVDD9gUPA1Gbn5OKM3WyInzDOLrbjehrtggHjG8YaYsyig8C9w09ZnPrTqVp2+YNQ9pTUcZzc15BDP4VxbjssapzcgBljq4jLA/Og4r/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BKhm14Kx; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717064101; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=Vhoc/mHXd1mka1wOnf0UEtM2izt0s85wD68ygO4d5Ls=;
	b=BKhm14KxlKvHaBS0tiJHICq4PSf3GwOulszmJGG6TRzceVpSiSJlQB4Nj5o+KGNn9T0s3Zrfo5AR2SB/ADZOtIGnY0ul22Y6vVUS0zuXmNnTwoPE1WOBb0vP+/sREOqimbeqsn25HEaXoz8YXSm1XS1Ak/C8IMo3E3qNftz41MI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7WiFO0_1717064099;
Received: from 30.221.146.99(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W7WiFO0_1717064099)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 18:15:00 +0800
Message-ID: <bd80b8f9-9c86-4a9b-a7ba-07471dcd5a7c@linux.alibaba.com>
Date: Thu, 30 May 2024 18:14:58 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/3] Introduce IPPROTO_SMC
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
 tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1717061440-59937-1-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <1717061440-59937-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/30/24 5:30 PM, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> This patch allows to create smc socket via AF_INET,
> similar to the following code,
>
> /* create v4 smc sock */
> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
>
> /* create v6 smc sock */
> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);

Welcome everyone to try out the eBPF based version of smc_run during 
testing, I have added a separate command called smc_run.bpf,
it was equivalent to normal smc_run but with IPPROTO_SMC via eBPF.

You can obtain the code and more info from: 
https://github.com/D-Wythe/smc-tools

Usage:

smc_run.bpf
An eBPF implemented smc_run based on IPPROTO_SMC:

1. Support to transparent replacement based on command (Just like smc_run).
2. Supprot to transparent replacement based on pid configuration. And 
supports the inheritance of this capability between parent and child 
processes.
3. Support to transparent replacement based on per netns configuration.

smc_run.bpf COMMAND

1. Equivalent to smc_run but with IPPROTO_SMC via eBPF

smc_run.bpf -p pid

  1. Add the process with target pid to the map. Afterward, all socket() 
calls of the process and its descendant processes will be replaced from 
IPPROTO_TCP to IPPROTO_SMC.
  2. Mapping will be automatically deleted when process exits.
  3. Specifically, COMMAND mode is actually works like following:

     smc_run.bpf -p $$
     COMMAND
     exit

smc_run.bpf -n 1

  1. Make all socket() calls of the current netns to be replaced from 
IPPROTO_TCP to IPPROTO_SMC.
  2. Turn off it by smc_run.bpf -n 0


