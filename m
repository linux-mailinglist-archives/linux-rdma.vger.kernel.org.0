Return-Path: <linux-rdma+bounces-398-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D9B80F9CA
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 22:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9083CB20E1A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 21:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240F564CCB;
	Tue, 12 Dec 2023 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2YUche9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABF3B3;
	Tue, 12 Dec 2023 13:55:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c3f68b649so38636775e9.0;
        Tue, 12 Dec 2023 13:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702418154; x=1703022954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zy8FfFNpNs+NX51gAcRgfZF0RZVCxGvpcLqeDklhggA=;
        b=F2YUche9VuF+Ei4sBTmAOiQr91telRKNJyCboEP07rYmJQTSSC3YicVd9T7lNo9g4n
         PKuYU5TgzqB6sbg0zpCUycwbnPK1QJWi7rgHgQMS6bFfY1c8jJ+0Pw2yjnCWyWn7IBqW
         14HUQZNCn9DiETUPWmyVKvOKf8zTWhtPeecnedHwTUZGKs77TkKnqL7X6MYSRiqS329o
         pCc6oGjol+LEgocpjjPkQLq5JBH1aFK2M1WCqN4umBZdZ31Ck/r9L2QjJ6uiZKb/J1DJ
         Pp+hsriCB1twStEhBy8kRVCfcGYzoE8dc/ty+wR3Ga5TCh2Rs+8xF6mnjsLbOQAlgjZh
         8Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702418154; x=1703022954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy8FfFNpNs+NX51gAcRgfZF0RZVCxGvpcLqeDklhggA=;
        b=aRjYVInu7DcCDaFpe8ysXoWjKBtawswnM7r6dLYGLLFhMgv/RZqrvyoL+/SOuxwIhk
         ka66UxUhV4UXR7HW2tJODhYgL2oXUnMmEdg1uAgk9OJK/Ky1fXBSuzRHw/ZdCCjkRu12
         FcSuP16A8XQlqvPRlY3Jp0vZSXJBQI09sXa3oeqFKsiImhEaLx7YDFX6N7FdAEXujPvc
         ZmekZGh2c8J+FxnbxMn86/y/4mTDCgU/U14Hx+nqNVQbG9rCt2o6Zyqa5h2/uIu6WYIZ
         asyY+UXKc6F0KcTyj87K0/l3rwz7RcqqLnJho+BdZQtj/4esy3NARsKS7qNY/X2MMy3b
         5yjQ==
X-Gm-Message-State: AOJu0YxIT/eVeLf9VuK5pmoxQEhyUpk9MueTOV7inLQkamqT+zK1bvNv
	0OsSlCb7VxblO6/vGmBgmgI=
X-Google-Smtp-Source: AGHT+IFWa9taipty31yOr6nNvJiECuCxJgZFLbRfYP89EFnIEOzxUOphJnn6CKgmt57xRKS/PY6LEw==
X-Received: by 2002:a05:600c:3ca3:b0:40c:4dc5:b308 with SMTP id bg35-20020a05600c3ca300b0040c4dc5b308mr1028228wmb.196.1702418153566;
        Tue, 12 Dec 2023 13:55:53 -0800 (PST)
Received: from [192.168.0.209] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id d13-20020a05600c34cd00b0040c496c64cfsm7615484wmq.12.2023.12.12.13.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 13:55:52 -0800 (PST)
Message-ID: <b4f22a3b-3cab-4c0d-b4b9-700c58b62826@gmail.com>
Date: Tue, 12 Dec 2023 21:55:51 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] mlx4: Fix spelling mistake: "mape" -> "map"
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231209225135.4055334-1-colin.i.king@gmail.com>
 <20231212203043.GF5817@kernel.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <20231212203043.GF5817@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/2023 20:30, Simon Horman wrote:
> On Sat, Dec 09, 2023 at 10:51:35PM +0000, Colin Ian King wrote:
>> There is a spelling mistake in a mlx4_err error message. Fix it.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Hi Colin,
> 
> I am guessing that you are focusing on error messages and other user-facing
> spelling errors (perhaps you told me f2f in the hallway track at Kernel
> Recipes).  But I do wonder if you have plans to address other spelling
> errors in this driver. codespell flags many, including 'segements' in a
> comment in the same file.

Yes, there are so many trivial spelling mistakes and typos across the 
kernel that I'm just focusing on user facing error messages for the moment.

Colin

> 
> In any case,
> 
> Reviewed-by: Simon Horman <horms@kernel.org>


