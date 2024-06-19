Return-Path: <linux-rdma+bounces-3303-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4EC90E6C9
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 11:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B1C2832B5
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 09:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F8580024;
	Wed, 19 Jun 2024 09:18:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE881AC3
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788723; cv=none; b=YlngnEXJZhO2bkpFqitFKNvEcUefX+4uP6a3mQl0iFoqOJ14W1BFzJgO98dpNfp9LTrs5b4qNBIAJS+svo+YeL+PJ4oDJt+yuT/TfEmM+CTpUhqIENl2RAgNGAh9lmmjJA4s+Wzbrm0NP1oCTgyYciFi+CzElxaWSaBKQvGhphM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788723; c=relaxed/simple;
	bh=ZqBTKUIkDMWrrV9BblVdHJH4Bj8Ava4UrdiXMFjAAOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgfxLRqXTEqkCRdLHpSx201gJBUju7uqRyoomhud1J8kuxeHcF44e2HFS3CrYVePqgMCf1O+aiPOLh6l+pF0WS17g11OA87fN+zHOPAmGgqPnFL7h+kRozLbXmWPWSwTpKtURM4SlwXMarRTIlY/4jkb5DgeUynH5+Jz0ozBrKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3590b63f659so468335f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 02:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788709; x=1719393509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqBTKUIkDMWrrV9BblVdHJH4Bj8Ava4UrdiXMFjAAOA=;
        b=bBb1EjZWfnSDHom6wRKmFp5z++9n/3qlce4n69yyXpGmoN2nAoMUpBV4VI4pWOqAG4
         SMuFlp2Y/M/QbGf+hEZnVX02FHC7Jfo1xjxGmucEdHOGOg+f+ruRQgxFuS6CXgy++5yk
         ooBwRXWdiWU4EjB3oTbuuZJojwx3gzEA+Ifiv7afoNtfPFx+zh4vXRQOnskq56Ep/c8Z
         Is1HqZmtj1p9IVYAAavWG9802BGj7vr7SLw2z+bJ1MFqi3I2fg6TX6BvbuNrH3mNxobD
         ra09Y8tcxbwIlctWKkGvZ2hOVgfE2aSByWiFZfgKfnELqdA1qWKmakBebc5hKreFeqgn
         t0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYXHZoEwomtdX8HBL6agH4HxdcfTpwmgoMoYI7/am7fZ303KxyX0VT66wBteRi4PR1fndHgjCohzGUTaMSgAodurGimWJ+Hvi5RA==
X-Gm-Message-State: AOJu0YwPKJtPQzQ6pRO9WewQDEK9FCXhWhyiM1vFMdhU8RJ/ER4+lxEd
	nQ9cFhTO5HWG4Py6ut7Phi7vwSpNFgWisMuULTAXy4kFMS/xkNn5
X-Google-Smtp-Source: AGHT+IFNOithI+CHKmPz/Md7IW5UDaxr+VAVXKDzXdXLjDKwa8ZVwWk/9vIkYYoVgniFWW3pR4L3kw==
X-Received: by 2002:a05:600c:1d1b:b0:421:7dc3:99ff with SMTP id 5b1f17b1804b1-4247529a5d1mr13303145e9.3.1718788709236;
        Wed, 19 Jun 2024 02:18:29 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad082sm16387252f8f.59.2024.06.19.02.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 02:18:28 -0700 (PDT)
Message-ID: <66d87932-eeb8-47eb-8c89-e1f10cee32d4@grimberg.me>
Date: Wed, 19 Jun 2024 12:18:27 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] RDMA/IPoIB: remove the handling of last WQE reached
 event
To: Max Gurtovoy <mgurtovoy@nvidia.com>, leonro@nvidia.com, jgg@nvidia.com,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 chuck.lever@oracle.com
Cc: oren@nvidia.com, israelr@nvidia.com, maorg@nvidia.com,
 yishaih@nvidia.com, hch@lst.de, bvanassche@acm.org, shiraz.saleem@intel.com,
 edumazet@google.com
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
 <20240618001034.22681-7-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240618001034.22681-7-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/06/2024 3:10, Max Gurtovoy wrote:
> This event is handled by the RDMA core layer.

I'm assuming that this patch is well tested?
Looks like a fairly involved change.

