Return-Path: <linux-rdma+bounces-3300-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A56190E69F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 11:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1791F1F235C9
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 09:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862BB7EEF5;
	Wed, 19 Jun 2024 09:14:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFF42B9AB
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788494; cv=none; b=geh6g2xoly/VRgT9/FO0GWvFeWXouPdeD887eKpu/eIXkyfOtUDuqKxygPU9lwWq+YhS/Gb8aA3vEL2Vvy42KwK6wOSJ/1e84gNl08LJD7ziqfj88svAWf9j7OGjC6yEceKGfdZnoZQyyRQj6t9rsajS/8mH3Gniiqps54E6bh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788494; c=relaxed/simple;
	bh=d8whzM7UteiroGKKRTVsINyGzgFXWbVxvZ10mUfpdZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQYG+qme4D3tPl+TJ6P+zi9Xg7n0zQpnYzf4pzLDMI4f18Le77WfhbueIjNlF338/iXUJ8bjciEJceNcnpOeyS/jFnWKss5KC7j3VrDCUfICgePLa4A48beoCXmwYazsIt5Zq10magP8K/2Ja8MQf+5KPyuY4WqP+b5RLbBvXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36354272c2dso104665f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 02:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788491; x=1719393291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XkPhKL+v59TVHhZ9Rit+LBFD4C4IHcE3EoHQOPi/5U=;
        b=ko13SXEzxfKEnkYB333UsERy0j7wiohAkiz+SxYEtfnDwhMDEWgTcPpifwHlqH0cXh
         1Nu9ax3cBrdE5YnTT3CkjD/C1fLSGuXHQjN/U6AN0CvQtG+Wt+mK2j4R6BjMk/jPt+Jr
         Gzb3O11ZEDcXEVSNwuvbEXKLqEgx5CNsGYJaHWm8xLHo42AmFL4G4F1gPQipvTEY2KR4
         OIu6XoYPzkDD7GFABgdfhvdo+MuHRRjkKWey3UFmh0QH+Cd+NC9LRugXv6uJ9DTaSr66
         IzJByFH/0Kxu6+8/si9tMCUN5Al+pEYPSMKspJbJSZWe1VQbs4iixb9e/EsKt2aW/ja2
         Tmcw==
X-Forwarded-Encrypted: i=1; AJvYcCVXITjif696cznrUGJmY3cyuNUWq/rHhAKOocHnLQVbihdt4Cg5FJXTihVy0QEnilzQLbMEKa2NXynoEmgvX2k78QTIEq02+Q2Aww==
X-Gm-Message-State: AOJu0YypNk5yxQyau+3P9DijZgPs5tZ8H66FJrqWWRSfFAmBfwocf+Bw
	+EIMK4soKNESTmf5n1i6/VTUWh6/DoEOF74GhinekZ3Ta6J7Stno
X-Google-Smtp-Source: AGHT+IEp+nd5YhSsx9fCkGmkYb8QCLmcYR2ayGXZ2Xz6m9wp3Azg3981v+/AoLP0zpKTO3ckc+0DSw==
X-Received: by 2002:a05:600c:1c8b:b0:423:146b:36f8 with SMTP id 5b1f17b1804b1-42478e41349mr4312055e9.4.1718788490893;
        Wed, 19 Jun 2024 02:14:50 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42306049f1asm181934235e9.22.2024.06.19.02.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 02:14:50 -0700 (PDT)
Message-ID: <85c93883-8383-4ed0-b742-cf062bf2a271@grimberg.me>
Date: Wed, 19 Jun 2024 12:14:49 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] IB/core: add support for draining Shared receive
 queues
To: Bart Van Assche <bvanassche@acm.org>, Max Gurtovoy
 <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, shiraz.saleem@intel.com, edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-2-mgurtovoy@nvidia.com>
 <244b708e-be75-435a-8b27-c48e976d4cdd@acm.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <244b708e-be75-435a-8b27-c48e976d4cdd@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/06/2024 19:07, Bart Van Assche wrote:
> On 6/17/24 5:10 PM, Max Gurtovoy wrote:
>> +    if (wait_for_completion_timeout(&qp->srq_completion, 10 * HZ) > 
>> 0) {

I think this warrants a comment to why you stop after consuming cq->cqe 
completions
(i.e. shared completions).

>> +        while (polled != cq->cqe) {
>> +            n = ib_process_cq_direct(cq, cq->cqe - polled);
>> +            if (!n)
>> +                return;
>> +            polled += n;
>> +        }
>> +    }
>
> Why a hardcoded timeout (10 * HZ) instead of waiting forever?

Agreed. Is there a scenario where the IB event is missed or something?

