Return-Path: <linux-rdma+bounces-12946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3491B380A4
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 13:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04261887E8C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB02D335BC1;
	Wed, 27 Aug 2025 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzElD+qh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4230CD9F
	for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293298; cv=none; b=KJSEkcwPzy2ME6UAshmwkmntszmoc/m267ioWCi/iJQM+7mE5y1wZ/uM26E/OD8jlPAwVJHBaiKxFa3aP8uH/pyidXhTvHs7Kd/IRzYTVVztluMyZMnCuoklCZ0sgbZf8ZAodzlafdDJe/TphFdYe259WKo+3m9ZJL+NN+PWDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293298; c=relaxed/simple;
	bh=OkzI+esUgg2TOUYfT34RpxxsKTDtal6Iw23msifomQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmGwU1O8vQarXpVhhbtpbVsfxZhcl+2P5WsHePQ69fjk8mcnSpl9FCUWd2RYJFTXaqUrx/gXl0BvgWyAvU2pIg8My/fZn85UAUSo94LcGQ/hT7pDRgxvmNu2M3rS6GhHcKhhdEKZWYLZvDcwulp4hjAIvWXNpTehKd2f/34KG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzElD+qh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24457fe9704so61851825ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 Aug 2025 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756293296; x=1756898096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9AUMpHG9hYrL2HIyah8t27L8dq0k/MJO/hNIBcX44o=;
        b=DzElD+qhuByAqRGJUJbFm3H9MyRgh1BNCaBHeENp/p03aucYTFlT9SZnHt9Yq9Kvrr
         EVyM933Um85V12vov2by4NK5IKs3ssJiy67VSHtwMbQEJYMs7nxxcRcypnvuSPUrM56r
         ZROmIURKdBajRlAxVQ0Aq0AhIuquYp55o6l+KU+PKrjlz4AMbvrVErJUStlSMjYJRj0a
         J2+HlrxAlMcyGlrIkbXIVUR6sbs5Ghl8NHyIgi2HWFOkmXyqAZi+bhrXcojZH2nY3AvX
         i9i+tY4iPs1KA9kIH37HgGKRZ3A+Ktj25uzuo73JguzlgAPCQTsrOn0ERMVUrqIDNZXz
         sQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756293296; x=1756898096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9AUMpHG9hYrL2HIyah8t27L8dq0k/MJO/hNIBcX44o=;
        b=BIzkw1Hi5Jo/vUOVwBOvCw3q6y5rn6yl7jd8Ck/RtNS//9UM3+e4s8oRjP6gZV05Th
         +uCxfP9DKMHSYB3Y1lZmrxfK88BcnhAspyOXMSTfP8NXSlP2zOWIcou4svqeVOoGp+s1
         F1SDAgcxrt4lEzHnu1MswCKg68vlJYAQPWwgUuhI4t3ZPxhCEFemDwNwKoPYx1qxtpDB
         eMXJoA7Wr/W84B7t9yOLw5lA2A5m9tLoNdG2Erao4xpvUlzU99vijWVZVgJUdn+RxIim
         m19rCpzm1jj5JtvPGZHSa3tXSNSGmALFTvrJ6fIzfB6MC6xF++6jZ1UG+EuwPQefdTSg
         DnNg==
X-Gm-Message-State: AOJu0Yx+EazwG7zEAsaSYRvc29KX3DMoUWtdUdY8goXXRqp497ELXUNo
	NRuEx0YrhYNoDBwKwb431/gQEXfO/oOhruXWCDQNa1WzXos7ix7iHG8T
X-Gm-Gg: ASbGnctz43hfU5oruJC/o0d81yMIf7/RyhldhQLlTqRgmhzLQjGqEbzTk68aj5QxEls
	SawsAUAmwHuYT7a8FBYZdYpyDVngLtmKE5RzSA3vZbqjPjyxhgJOZhiE/ejW6+pNN+Bg7MuslNd
	vpbrxZyKDgjZclM4CpQW6Z1DW24lUM+LARmssxEX8lVrmztxiiWYFXZr7wWO4PhOLTBS+3M7Lc1
	6wPcYZFkNiBE7xga5Cs+VDpnBksIeOO1NPJyZUhi7pafvwxRN6DgqM4mGjSR8em9iuBC5RArdaR
	rR1iXst0/2apRoCcXZsXE9Q7fFxHuQzOc29Vvs48fC+RrvSPr6kFqrKN9A2CDk2l4lJpTjWB+b2
	2vFg9h5OvFDXxm/O5PEN2hne2tT6B8EuHOoihQMQhBd6EKVulAsCZ4bMylNVyr4j2K6/t2mPJiA
	5u
X-Google-Smtp-Source: AGHT+IE7AVCK7fXVKkZOkprLKnH/X4jdNzylKT6eul1eVTUMwD8O7rDc8lRLIrc5TRXBu9sp1TViWw==
X-Received: by 2002:a17:903:3885:b0:240:6aad:1c43 with SMTP id d9443c01a7336-2462ef70541mr214209325ad.48.1756293296415;
        Wed, 27 Aug 2025 04:14:56 -0700 (PDT)
Received: from [192.168.11.3] (FL1-125-195-176-151.tky.mesh.ad.jp. [125.195.176.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24886269169sm27303875ad.159.2025.08.27.04.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 04:14:56 -0700 (PDT)
Message-ID: <a59640c4-f166-4a7d-9da5-f8318aadb394@gmail.com>
Date: Wed, 27 Aug 2025 20:14:53 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-rc v1] RDMA/rxe: Avoid CQ polling hang triggered by CQ
 resize
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, zyjzyj2000@gmail.com,
 yanjun.zhu@linux.dev, philipp.reisner@linbit.com
References: <20250817123752.153735-1-dskmtsd@gmail.com>
 <20250825181053.GA2085854@nvidia.com>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <20250825181053.GA2085854@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/08/26 3:10, Jason Gunthorpe wrote:
> On Sun, Aug 17, 2025 at 12:37:52PM +0000, Daisuke Matsuda wrote:
>> When running the test_resize_cq testcase from rdma-core, polling a
>> completion queue from userspace may occasionally hang and eventually fail
>> with a timeout:
>> =====
>> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
>> Test resize CQ, start with specific value and then increase and decrease
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>      File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_cq
>>        u.poll_cq(self.client.cq)
>>      File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>>        wcs = _poll_cq(cq, count, data)
>>              ^^^^^^^^^^^^^^^^^^^^^^^^^
>>      File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>>        raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)')
>> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
>> remaining)
>> =====
>>
>> The issue is caused when rxe_cq_post() fails to post a CQE due to the queue
>> being temporarily full, and the CQE is effectively lost. To mitigate this,
>> add a bounded busy-wait with fallback rescheduling so that CQE does not get
>> lost.
> 
> Nothing should spin like this, that is not right.
> 
> The CQE queue is intended to be properly sized for the workload and I
> seem to remember overflowing a CQE can just ERR the QP.
> 
> Alternatively you can drop the packet and do nothing.
> 
> But not spin hoping something emptys it.
> 
> Jason

Okay, please drop this patch.
In a sense, the failure indicates that RXE is behaving as intended.

This issue seems to have always existed, though its frequency appears to vary over time.
Perhaps the switch from tasklet to workqueue introduced additional latency that influences this behavior.

Thanks,
Daisuke


