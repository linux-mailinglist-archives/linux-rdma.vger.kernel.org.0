Return-Path: <linux-rdma+bounces-3356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98FB90FCE8
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 08:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD512858A0
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 06:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F513D0C5;
	Thu, 20 Jun 2024 06:41:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15D2BAF3
	for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2024 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865696; cv=none; b=lW3tT8BdG9mpJp2mQHKAvFzpL3RnJmBxxoF9hERuulgZZAKbz9rbfjOcmKxW3D6F6D5ivVjPMCi9d8MaIONo35LHJIb3BqZE7osIp3RqVnd+1IDsepYYPOTTgY8pO3wB4wyl5cKwunF4eizf1cY/B5drd7vZIrEsOpDU7k1V6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865696; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvUKteuI9Pdh0amBKTt+rUYakEf6NFc63CWrSpLJv9w31LOxzrD/oScYGsFCulxkLcAJJ8EnONF13zddqvDRClvSfFi45ljORw6EWKIGJITv9Xc/lG8XmGxx7YntoaVEYfF01oBZD0dG/oIWJ9X/Tg6hNqrHhgcDQEBOkbIsGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ec34f0110dso458481fa.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 23:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718865693; x=1719470493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KUWAovlio16tqUT2x+s84Mu2q+RDewqvib/aK+JOIy4f31rV6rE95P8wILKvZMDXPJ
         dRAWsyHaDxClVJU06MiD8g5KLQA1AzB+W0I9C7xEZh6Fg+Vvpu007zL2NawRlmMW4hWT
         XYvCfbydLvTSkClM6aJmbQ0q8Z89Ts2WwD9YOTse0EaPg+lTJsXsqj398GbwMypk7+H5
         /BtEs5P7Hg0/0AGUuS3ZwpRnanmfnqoF+tLGSTFQtINZ2+h4i1jukmQPtjqmTaMq3Nrj
         akJ2swjiehdgzSZrSmSEh3lqkQM/PKm5lQSDelllyQ7nbwd58IYpbDAio3DqXG/a0ajP
         XQyA==
X-Forwarded-Encrypted: i=1; AJvYcCUF12fbnjkXVY3aQYf9yVAf9dEnTwhdgSpYdhb1zw2lrClkn1/ZYL7Jj0e0YucoDZnfOCpkUIJLLkmm5lfRCuGid3Sr/sJEQvL9ig==
X-Gm-Message-State: AOJu0YzDjY5+0ROp9TrE+gT8ZHTAbuY+rgK/tXhdX5KZ0Q1rA0FBP8UZ
	ClI3SP5anNlixhS8FEFfdrHEAUcNEYLOZd2Un44tIS7cD9H4VkeC
X-Google-Smtp-Source: AGHT+IFJqt7HNRnrba7BZb7AEYkfRfwqwKmsOv6r42Tpi6zsO1emn4kjDf30cV9GUlUv1C+OOtqn1g==
X-Received: by 2002:a19:7719:0:b0:52b:bd23:1e9 with SMTP id 2adb3069b0e04-52ccaa4eb27mr2135888e87.1.1718865692651;
        Wed, 19 Jun 2024 23:41:32 -0700 (PDT)
Received: from [10.100.102.74] (46-117-188-129.bb.netvision.net.il. [46.117.188.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36437896ee5sm2013893f8f.20.2024.06.19.23.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:41:32 -0700 (PDT)
Message-ID: <4f39e136-d891-478d-8a0b-3a5a2a4df4ed@grimberg.me>
Date: Thu, 20 Jun 2024 09:41:30 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] IB/core: add support for draining Shared receive
 queues
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240619171153.34631-1-mgurtovoy@nvidia.com>
 <20240619171153.34631-2-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240619171153.34631-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

