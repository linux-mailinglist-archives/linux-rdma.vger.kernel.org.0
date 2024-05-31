Return-Path: <linux-rdma+bounces-2737-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61228D6A41
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 22:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6091C22644
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 20:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969DC17C7AA;
	Fri, 31 May 2024 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0qaWpk7L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3931946F;
	Fri, 31 May 2024 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717185702; cv=none; b=WnbwcECV9b8/6HV4dTBNn0l0ItpTbVje6QLCKGDPUJS8Lpyq9czf4oEpF37ADwvFM5EBnQ2ySEseCXAIu8X/UKLFubEUBz9W2vSowRmdAcUaYttOVbwKY/AWQ9eCb03ZpAqrMB5hrYhWTr33TOk9p4NgKV4sHBS/l8i46uAC5NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717185702; c=relaxed/simple;
	bh=wJVz7bNhHOT1cnkm63pYOAOw3gi8sYgMJUnqLRq3Cg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mWn6DdtfZu3U7EzDmvpQ+v0bMoCwN0eq8nYSA9TVdMJ27qTliZIea97BPssFPbefmY6keEXqArI2BtAykhTIMBJjRpMopGzDGRQNaiDBCy5sxEsdj1e96Hmv83ntqdWim2d3lBwllK+nVb94h56CyHw5OTuEXro4KzNrSntSDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0qaWpk7L; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VrYsw0P8dzlgMVh;
	Fri, 31 May 2024 20:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717185698; x=1719777699; bh=wJVz7bNhHOT1cnkm63pYOAOw
	3gi8sYgMJUnqLRq3Cg8=; b=0qaWpk7LyCjJgdcs5tFsFpgx3U3bRd02qzRhuffi
	vrRsYtwQPZjIv+79S0usRcHMXbjCZqBHevbisr2+SU/LkqtyzMlmPKQJIx0M05XT
	u1J1xOmofSVaKUGXZFArJgAytpjE3rCaRq3EWUrPjwfueCmlmpdSCsFCVUJOFsq1
	v/ib1zsZv4/ZVt+U4abRuTlDklcFKPAAk1Rv7DyhnYFg+P0Neb6DhMbxzfoB4bF6
	4u528cDpoABVbf35aQElwopj+uuEiYTTD3JVRyPqFS7OYCovWQvpmgxfKu02ePMM
	l4clx/11ej7G9yeT+V7+OgszY1q6qM3d6i74xszNCDVJdQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id imhqH5Wwtsdr; Fri, 31 May 2024 20:01:38 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VrYss1qT7zlgMVf;
	Fri, 31 May 2024 20:01:36 +0000 (UTC)
Message-ID: <b29f3a7a-3d58-44e1-b4ab-dbb4420c04a9@acm.org>
Date: Fri, 31 May 2024 13:01:35 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.10-rc1 kernel
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
 <6cd21274-50b3-44c5-af48-179cbd08b1ba@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6cd21274-50b3-44c5-af48-179cbd08b1ba@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 07:35, Zhu Yanjun wrote:
> IIRC, the problem with srp/002, 011 also occurs with siw driver, do you make
> tests with siw driver to verify whether the problem with srp/002, 011 is also > fixed or not?

I have not yet seen any failures of any of the SRP tests when using the siw driver.
What am I missing?

Thanks,

Bart.


