Return-Path: <linux-rdma+bounces-3357-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434F390FCE9
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 08:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA895282919
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 06:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA163BBED;
	Thu, 20 Jun 2024 06:41:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113B22BAF3
	for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2024 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865705; cv=none; b=sY89b5eJUerHIV17r/CiPh9/EKDmmpuoFNU2AfnZx6lXt6JCHqccHWMQVcWLJNpth6YE9fChyjYINNuIOctptKPGPK0WSkDSM1zmQP96PLdNU98mA5HatpJpGxAFVidxDklVljuhkaWwaOrILCszbvv+/+8i3KRLhohkY2UwIEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865705; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dl33tcuMz2THXfVgk3cdCpHwRBHrCg4dSPubNhGTCjAtvpACi6pmxkH1gBGZagtaYSYwh4JUwlhHZI0X4UuHf0BfPd/ZbykNGdHiSZepZ6jb9Y5AgoEJ/iTyBE4aRaZyDYxfg7WIlA9Ym3zznYhywGlyJdURYKZ/EW2oXaKJp/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b96eafeeaso76507e87.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 23:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718865702; x=1719470502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Prl7s873TjSOkAS2+LY1K5vDD8MZWNbr+XfyZO4KRZWeg7Po0XR/DeF/poXxMJq91H
         C3w+4YrpUUsBlb410ziDxcyx52E12yXj0dPVW4OhHHZNmwkVQU+66cLLCPg3UYErMS+u
         IhT+CpHJQo3tnmJWNGoCjKANCuePx2zzPI9hbrcDXQmbRZXGRGrk19pj6LF5VjFPkuyl
         McszoaofmDfnU04t6gayR6+Hf3Gt/y5xfgcHmG5/ZHl89z7lIS5fMNMSIZ1aLDdCgPjr
         9gcMztQSWT/8VKC5k0WVXVMQ2LUiJ4m5HSIPZebECsCXeSQWMZcryVWTTZSa4O3DGooI
         jssQ==
X-Forwarded-Encrypted: i=1; AJvYcCXihnC3e2pjlQ06yFVeOsOpFOrSHmGWeaa+DFKwDebw8+U7pqMmQkNuyEY6g5fTyQOM3zWqE2j65XKcv5vKs7xm35okp2ru1+oByg==
X-Gm-Message-State: AOJu0YwJ7xHlqo0n5KnRlyyq3uZ+m7dU4XXGQW/pYY0hUBSBsxPYeLpl
	FPaFM+j9xVlEMd0ckG0nKKjQwDWmj8lrPGNA0w4XuM7N4NZddfFUjewKTMNA
X-Google-Smtp-Source: AGHT+IGOC4BQj4OY3S/auNc6PVwOas5Gb4lQbz5Wu4u8PaV6+35jDO7h/KCQt0fAHessUMKoWiqsYA==
X-Received: by 2002:ac2:5e3c:0:b0:52c:a121:4b08 with SMTP id 2adb3069b0e04-52ccaa880a9mr1922911e87.6.1718865701862;
        Wed, 19 Jun 2024 23:41:41 -0700 (PDT)
Received: from [10.100.102.74] (46-117-188-129.bb.netvision.net.il. [46.117.188.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208e08sm13690625e9.35.2024.06.19.23.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:41:41 -0700 (PDT)
Message-ID: <4966e9fc-987a-4a87-80cc-c70e09c548ce@grimberg.me>
Date: Thu, 20 Jun 2024 09:41:39 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] IB/isert: remove the handling of last WQE reached
 event
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240619171153.34631-1-mgurtovoy@nvidia.com>
 <20240619171153.34631-3-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240619171153.34631-3-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

