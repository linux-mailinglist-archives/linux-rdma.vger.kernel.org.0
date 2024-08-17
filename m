Return-Path: <linux-rdma+bounces-4400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73686955673
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Aug 2024 10:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6CB1F22206
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Aug 2024 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360491448C4;
	Sat, 17 Aug 2024 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RqKv1fF/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2A13AA31
	for <linux-rdma@vger.kernel.org>; Sat, 17 Aug 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723884408; cv=none; b=J/u/SDS501lQIYNJk1OB0enFNv28j/BS3+jy+F8oa1Dta7iD13bGn5Z5Pq0dMLPptZIYm86LLyhG8ApDfBjhyZ6Ee8AmFD5HWiQjxu9jufdI+B1fDIs6YOIIRtCFwV/KaQ5hwDHj3aRxZHfDSRDm4vFpWz28COS2F3FyUwSJdpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723884408; c=relaxed/simple;
	bh=HgGLgbu1/qWVx1lyyESDChPt/OUUW1ebFpe2qoF8JxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvqKzsfX9he8+mRJFHxbQh/hN9B1wE92cWLRUyyJjSsefx85/9+wCtn0B6wjX4vjyVqGIHCccZrkIbibCcQb+rnZgB1Zvl0bUq+OmdwjT7xW4WVI+8PWsfCG9nvdboerG8YZj7zZ73eIa77X+4g3w0XRcZuzlVTnMuva5N0Qjv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RqKv1fF/; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5377e3e7-9644-4e71-8d2f-b34b2b5ae676@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723884403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGHIyJLxgTPX0taP7YAbOFdfgE44JycCOF1YZWtuhWI=;
	b=RqKv1fF/88Z+Xul3C305DJxXKKxibkUnzyg61xqo1g6L5Cyra7uxiE8zm755V84DyKBwIa
	Rc4X9Sh23MUqHGjuaWkcsW234Jm6mVP0YWx+dRwllUK98tY0YEHMp1yxGjukzqiaHVHq20
	aGApkRYDo5GijH+AdT++w3A/XNxbwMc=
Date: Sat, 17 Aug 2024 16:46:23 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [linus:master] [RDMA/iwcm] aee2424246:
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
To: Bart Van Assche <bvanassche@acm.org>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-rdma@vger.kernel.org
References: <202408151633.fc01893c-oliver.sang@intel.com>
 <c64a2f6e-ea18-4e8d-b808-0f1732c6d004@linux.dev>
 <4254277c-2037-44bc-9756-c32b41c01bdf@linux.dev>
 <717ccc9e-87e0-49da-a26c-d8a0d3c5d8f8@linux.dev>
 <3411d2cd-1aa5-4648-9c30-3ea5228f111f@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <3411d2cd-1aa5-4648-9c30-3ea5228f111f@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/17 1:10, Bart Van Assche 写道:
> On 8/16/24 5:49 AM, Zhu Yanjun wrote:
>> Hi, kernel test robot
>>
>> Please help to make tests with the following commits.
>>
>> Please let us know the result.
> I don't think that the kernel test robot understands the above request.

Got it. I do not know how to let test robot make tests with this patch.^_^

Follow your advice, I have sent out a patch to rdma maillist. Please review.

Best Regards,

Zhu Yanjun

>
> Thanks,
>
> Bart.

-- 
Best Regards,
Yanjun.Zhu


