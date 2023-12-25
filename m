Return-Path: <linux-rdma+bounces-490-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8851081DF56
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 09:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0438F1F21E35
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Dec 2023 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568AF20F7;
	Mon, 25 Dec 2023 08:59:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF62580;
	Mon, 25 Dec 2023 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d4ef21007so4904865e9.0;
        Mon, 25 Dec 2023 00:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703494788; x=1704099588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BLnlsv7151utYGKtwHR4SbLkizP0jYNg7FfcdirkIWh/8b6+ayOwCi6NZBbm0frDIT
         L8RurD47hM+WWiHN3MwogS2Vwi/ebfVg/jRxUcCTp6XKaPHGh1NbaHb/Yqww7Fqzsk/H
         JdOIK4o1EjxwNMV+Eqe+wqkNWl3LVah6HOqI+QSI/ie9cGkD3SH7OjOpSuokT2B7v2i0
         uQTQDAwVKrm80JPSYx5NF9g4xXu+t+JKgECf+8camydvR8MKq+uQYa5rq2+124wqPNvX
         2aRwlJ55cY+pUDcAjlcNqKKxRAZibzo7FjVhT4Y9UdoKlQx2oMtIvNpBwc539ePf2m7+
         zclA==
X-Gm-Message-State: AOJu0YwodQcgiQxUi4ZUOYH2U3p/M0PCH3Vaprhu6xTMC3c7G68zR1Uw
	9DY1ZRe2upRdQABmmATTO8I=
X-Google-Smtp-Source: AGHT+IFTDe+ljAmlHhABV5DVfyzoPbfh4oV7vaM1fgXWk9CzJePCRAq8/Uk/b/Tj/jz0Y/5tAoOUuA==
X-Received: by 2002:a05:600c:1ca8:b0:40b:2708:2a52 with SMTP id k40-20020a05600c1ca800b0040b27082a52mr7285174wms.1.1703494787530;
        Mon, 25 Dec 2023 00:59:47 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u4-20020a05600c138400b0040c03c3289bsm16680191wmf.37.2023.12.25.00.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 00:59:47 -0800 (PST)
Message-ID: <a2abe374-92f6-44b8-a151-eab80c41d74a@grimberg.me>
Date: Mon, 25 Dec 2023 10:59:51 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IB/iser: iscsi_iser.h: fix kernel-doc warning and spellos
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
References: <20231222234623.25231-1-rdunlap@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231222234623.25231-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

