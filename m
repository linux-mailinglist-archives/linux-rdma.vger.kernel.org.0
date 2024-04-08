Return-Path: <linux-rdma+bounces-1824-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA3D89B7AD
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 08:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDFE281EC7
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 06:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58EAEEA5;
	Mon,  8 Apr 2024 06:35:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C784D1D52C;
	Mon,  8 Apr 2024 06:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558125; cv=none; b=ky0GDW73yjWyYPx0s8ahwRhHtnJe59QFWBgJT+nmZhtzDt4vze4zH4UsUh+sk/SES60sQyy2L56SvEyFfoBPvO5zMOnNMarrY3+dJfmQlmtD71FtM/y+n2qhkqOjo0zZd8wUTrS5+F/kIbkVRnm89SeV9zNkCn9wXkEbgnCDgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558125; c=relaxed/simple;
	bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYZL38Z/YPlbX5CnEncegqU5YvCtQR5AOnZd7kaHy5REDW4JTyoyCi6vwFtb9pfT5LGPmCDWXKCiHSaW/guaGZ6otOGSL3bzrTLPRjblC4mRSEjNnA7LUk/Od8O3W5VhpYzc2MjYWcaW0HZ6hNe8gj7VBUvROog2uA644m1RZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4167082dabdso946495e9.0;
        Sun, 07 Apr 2024 23:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712558122; x=1713162922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=rIWolup+fF/JdenwNEaEzc+lbOEPqTJjhS/4mSR7b2E9Fm6deNxifJd+dSoWXdYfjv
         kl5ZhPlTJiMvdwTvdQAX8xGlZS9v3Alg6h9eYU6CR4KMlfDP/L2jbmZKg/LdYhbZNoiG
         xR543HRvgyhYpVghB17b8wm1J91B3daanGR9YmSzC7O4KT014m8918zyWrcXSouSoLqM
         RLQ9dn2kO00MZ0nLf/2zpiVVePiIoj6pc9LIQxLc05OtYwTdBIytUfE/VOupEK+hFQED
         /fmJsiKKUOIFYt2JN3th4lyOR0G/dD95k7iKORtFOZp6wOpWRHhSZFLOsKH7a0CbF2QO
         HOkw==
X-Forwarded-Encrypted: i=1; AJvYcCXzrQFkztSNddltB3uOM76pesg4PhzI4hleyXmTF3fKqamV0SvfZ0m8o5CDGrabMchcOi5DekB5MN7bENNih6kKPp9Gg33rX4LtniSLa0b+eknLh+W7TDCVxnAXhaADDuvwlc5bPpJGFDPBHge3SDbeDkZefX7UuL9iem9kDdOxC6NDn84=
X-Gm-Message-State: AOJu0Yxz8NBC5TCnK5baIRShSXcy5UsKSxaU8qsRIZQsxjvITIH6JX2O
	86awN6no0vNy7fGxrB5EmWy3pQd6/QYElGnUJXPB4uaXyKiZ4sTZ
X-Google-Smtp-Source: AGHT+IFSyt0zPSTcrnhe5XjpfseqpCtC+DiCJFueKoydoT+hbLBs5WFMLMjDRBKfZIA/WEgashqa5Q==
X-Received: by 2002:a05:600c:3b96:b0:416:7b2c:df09 with SMTP id n22-20020a05600c3b9600b004167b2cdf09mr693106wms.1.1712558121952;
        Sun, 07 Apr 2024 23:35:21 -0700 (PDT)
Received: from [10.50.4.160] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id l25-20020a1c7919000000b004161cb3e794sm7174390wme.1.2024.04.07.23.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 23:35:21 -0700 (PDT)
Message-ID: <6d038491-b05d-435f-9f34-53afc6e67029@grimberg.me>
Date: Mon, 8 Apr 2024 09:35:19 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] scsi: iser: fix @read_stag kernel-doc warning
To: Randy Dunlap <rdunlap@infradead.org>, linux-scsi@vger.kernel.org
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
 target-devel@vger.kernel.org
References: <20240408025425.18778-1-rdunlap@infradead.org>
 <20240408025425.18778-5-rdunlap@infradead.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240408025425.18778-5-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Acked-by: Sagi Grimberg <sagi@grimberg.me>

