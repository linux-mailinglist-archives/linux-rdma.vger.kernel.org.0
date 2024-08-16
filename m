Return-Path: <linux-rdma+bounces-4396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9D0954F97
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 19:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE8AB20D9B
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D091BC9E6;
	Fri, 16 Aug 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wNDZPZZc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9801BDAB3;
	Fri, 16 Aug 2024 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828221; cv=none; b=nIIQRCkImkUTYmxJxd9no/1ozNiL3dzz/JSJ4X5wQz9LM6CrK2vXOC/z4xl5eoVWtBkFs2pEPyBlHZKUTyRK3oTUwHd0HKPlEI/hoXiN2zljpCTIYAN18HGi2gqEGJIePvfMn4GoX09mGpK5Bfgo0qnhfu05r5HiynB1veGh2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828221; c=relaxed/simple;
	bh=nw06WkzHqUhCs9XA+U6TwdclHGU4IUDbSVBxWHsVP3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwJAvf09Qj/TSXFp+g9L11NmEnFZ5h8F5Fk2Epm23FidloI7rX7IliUuKqNDv/PCCv2t+/nB7QcfmenWs0x1szVij78bziG6RWYBUScNrBD2fIv6G9mOvMBGuqqZ9w2z1I22o8u10fXllMsUW9YPyEC5gT1HONeb2m++1B0D4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wNDZPZZc; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WlpQg5cJdzlgMVQ;
	Fri, 16 Aug 2024 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1723828217; x=1726420218; bh=nsyBi0d5vmkpkWIxsABPwjBz
	rMnHygjf1ygvaZFGSJo=; b=wNDZPZZcZtk93U4cg2C2dwhCSsqFuXh4tMTZgqjp
	CUlUpVE7uvrxjre9B4Nmy432XLhEoZZbqNmBoJhNyT5dGAr6aUZfppEgjy1WKzBX
	PqvWdiyiV+4ZKa0thAW439Uvz0KgKTWy9FhyRPW+Vo6dChVFptDdT3NC/hfN4a9B
	53OyLU1R/oPyjjx6paVr2oCEaVtjUQtBQ8lb+bwT/HHgcQ7GGkUIZO+516pDaQ5Z
	RmC4ncAxA8cF6EciJxLiJZVPo0T/oPOnah02eOrYhhkceBk0QBYJqx0CSnFZVJyQ
	ejTw95ESkEO5vvp4raKNWgjeFS5yoqQWh1hvFe1OaRhOLQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id deLSP4MbBMAF; Fri, 16 Aug 2024 17:10:17 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WlpQc61dHzlgT1H;
	Fri, 16 Aug 2024 17:10:16 +0000 (UTC)
Message-ID: <3411d2cd-1aa5-4648-9c30-3ea5228f111f@acm.org>
Date: Fri, 16 Aug 2024 10:10:16 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [RDMA/iwcm] aee2424246:
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
To: Zhu Yanjun <yanjun.zhu@linux.dev>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-rdma@vger.kernel.org
References: <202408151633.fc01893c-oliver.sang@intel.com>
 <c64a2f6e-ea18-4e8d-b808-0f1732c6d004@linux.dev>
 <4254277c-2037-44bc-9756-c32b41c01bdf@linux.dev>
 <717ccc9e-87e0-49da-a26c-d8a0d3c5d8f8@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <717ccc9e-87e0-49da-a26c-d8a0d3c5d8f8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/16/24 5:49 AM, Zhu Yanjun wrote:
> Hi, kernel test robot
> 
> Please help to make tests with the following commits.
> 
> Please let us know the result.
I don't think that the kernel test robot understands the above request.

Thanks,

Bart.

