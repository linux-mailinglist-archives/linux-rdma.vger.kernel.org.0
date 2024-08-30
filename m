Return-Path: <linux-rdma+bounces-4653-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6665B96554A
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 04:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16AFB21299
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 02:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B625A4D8A1;
	Fri, 30 Aug 2024 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DwECmVkf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3745008
	for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2024 02:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985289; cv=none; b=VYwvR5648/iJ2M5jUpUDWTexWkOVbdHSllQABLKaigiUd2KxkUgcCA5b3jYjzgPUY2TfQANKz3bSet/cIkgBdY/Ri4ZYd12awWir1FOaWQPclr6QEAvD336nxDSeM3OyHKTPqTozl9++xCYh3c9vOSwIpC8ESzk/X1nuohslHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985289; c=relaxed/simple;
	bh=PldCtlcrPozwePHYYakeAfU0W4n03D2XjKg0YbNVObw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJe9BZD4Bi2YJcvO8reozmQ6EDM2RJUKRjscW9zM/vsbQPo3Je+Is4r3ie9rCXHcZZTE78tBfI5/ObS8i6UTFVQm6XLtVz7hFZLUY0RZ1Rat5jwoYPKHsbBTfNmZHWnyFZn8F3kzq5O8/wLLcYO4Wf+o0SoAgW4sL87/xjdtKsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DwECmVkf; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724985284; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=03ND757vLM5kBIaba3bIyEPDGpSWVzZ2q4cQorDdImo=;
	b=DwECmVkfglQZioOrWow1xSUy3eg1lTduO2FyC54aFUBTJn6Z/W/8l5utjwm6N0HasGCer3IUNuK6hdOkkmyx98lCuIEvGyVlXLNnxqeHfRAnMI62+MzLtB2ohe43bt4Tk8GQAm70GOR+UD21tJq1nQjK5amkwh4osOAUEvIq3Sg=
Received: from 30.221.114.205(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WDup2At_1724985282)
          by smtp.aliyun-inc.com;
          Fri, 30 Aug 2024 10:34:43 +0800
Message-ID: <e4649d6d-8265-054c-24fb-ca641716856b@linux.alibaba.com>
Date: Fri, 30 Aug 2024 10:34:42 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH for-next v2 1/4] RDMA/erdma: Make the device probe process
 more robust
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20240828060944.77829-1-chengyou@linux.alibaba.com>
 <20240828060944.77829-2-chengyou@linux.alibaba.com>
 <20240829100955.GB26654@unreal>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20240829100955.GB26654@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/29/24 6:09 PM, Leon Romanovsky wrote:
> On Wed, Aug 28, 2024 at 02:09:41PM +0800, Cheng Xu wrote:
>> Driver may probe again while hardware is destroying the internal
>> resources allocated for previous probing
> 
> How is it possible?
> 

The resources I mentioned is totally unseen to driver, it's something related
to our device management part in hypervisor, so it won't cause host resources
leak, and the cleanup/reset process may take a long time. For these reason,
we don't wait the completion of the cleanup/reset in the remove routing.
Instead, the driver will wait the device status become ready in probe routing
(In most cases, the hardware will have enough time to finish the cleanup/reset
before the second probe), so that we can boost the remove process.

Thanks,
Cheng Xu

