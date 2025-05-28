Return-Path: <linux-rdma+bounces-10828-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10582AC6331
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 09:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA801BC3CAC
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 07:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E32459C5;
	Wed, 28 May 2025 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E15l9DXx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846F24469C
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417945; cv=none; b=gKk/9h+7Lse47aA2QrUDtdofWbShJH1RnDa56+4/NNW30WnaNfYHIgghiI4JCjqQ/JrxdRVEb746sKxUdyGE1P56uL5v4FOy6ogRzO0tp+ukj7OMhXefC3BGDu5Y2240282viVsQIhiSQ3ZvwHG5CjOvE7JqtbpNcpCKypsOM3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417945; c=relaxed/simple;
	bh=Kwd4D3iO9t/KxBmG0gWf433ndLq3AijK/cv4VbwcCHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7bnfoZPiGlFoinsz8cTlUYGgcI3P1QHMyJ3DAk37UcEptQqo5IQI2RA+CxkLkAqx1lqIQklCvzsw0iQcRUgQ8VtgBxuWX7j1jaXOxsxhCMe0A2ahYC4a6iRo+82YKudm+i+CX4fpCGelS9d2k4t9oJV69UiJDo5IGkHirGcyqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E15l9DXx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748417942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSKWq23IFPg5EC17AwxJ8l+Mvez7SXy8zK+EDFRJYSE=;
	b=E15l9DXxCW8UV1tKUrKTTj1JJF86hWLatJcmThpMUDhs1qX8L7hOwulA+0Aojr08ZJzPn8
	+C3FtNtYLLJwjYad2psCvvizCT0B5B61BJuPysDCvECcPyHsi+Varj3aIJ1SsTg5An0o+S
	c4oJyuzptktPtlRz9mVg8BmFkjONmKs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-qwQnAnYSNLusAeyli8pt9A-1; Wed, 28 May 2025 03:39:01 -0400
X-MC-Unique: qwQnAnYSNLusAeyli8pt9A-1
X-Mimecast-MFC-AGG-ID: qwQnAnYSNLusAeyli8pt9A_1748417940
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4d6d22b1aso2013350f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 00:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417940; x=1749022740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSKWq23IFPg5EC17AwxJ8l+Mvez7SXy8zK+EDFRJYSE=;
        b=Yw8SCwh8DGaLMbyofs+prIrPf9uT0JQ6ektKRAhU03Ja8UG4U8VNSoaG6i7+eH9sQc
         rjXbQXBZvk0ZmIzBBEzntAJtCM0O3lBgSgeM74jBUGjz/x1mftyErpmi+oJ2LMz8hhkA
         wUv1fRVksW+WKd06ZDTPjaxvTha/qfmL1Qj+EVupyzdvVoKqnf3OuGp6dcm6htLumAJJ
         SzgjlLDygSok6+XmkRJC95xqU22LU+GwN7LjPIMp+0w4Hxy2KIzT866ZtwHU01AyOnpe
         Ww0nm6SMeDIPgT26c0KSbxWNy1uypnPGG+lr4VFOks8MEek8NpFKafXUm+IpP7emH4fh
         SPzA==
X-Forwarded-Encrypted: i=1; AJvYcCXPNMgZk/tGVr22JkGq8Jr0dqVi8T5AXltKbHZ3ZrLbu3OuIQfSHJb0VlmSibDy5p4SfiUcGP9NHlDD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Bx3KA6MkaKKYnBaws0wZcCZ6aZUoaDgM+0bGC679ZK3NZFw5
	rCJJ58GThVLNBxRpk/UonStnxHPQaW7yxgQyD0bZLmITZpaXEcS0VEn14dCVkZ3+LEkFan1Cxuy
	4hJsrGfTl/ZEp23lIcxWc/ngT0PY85OJCq6A0HHbRJKLJlXVCK9yo/S2dqkHILis=
X-Gm-Gg: ASbGncsWr+mVfPnYVtlrtrWRyEs698ZMR34pUeSYKXrrUX37uv3UwSjREs0DV+uhejZ
	Pu9aE+g924Oh/XtppnBVS6P/j6DHyRjHE2IFXFypy4pA8CoH00Bv7mqB+q6/rSeVog+eS7izHs+
	qKM0NqTGDjdxp5DPyi+I8KBFySJSxfy8JG+MiPukG3zU+sJFGk2dsgiXpSgDk5HebwpK532mrsT
	vN5PiHaShu+Yof61r9SyI9tDyla4A/cCwQ+1Azieg+pn86n9AFRSlnyKkXJBLRkn93P91nhhtXt
	mNatgFYnm5faBmb1eXVqQ7Bi9Aa+8KgoIOyUpSnX+msAnTRFmSWRXRh5x8I=
X-Received: by 2002:a05:6000:250c:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a4cfbf5352mr12216041f8f.4.1748417939719;
        Wed, 28 May 2025 00:38:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNYhjHAxReC/Ixya4lOF3PnV5KGf/9AcxrbJuA4KPA3QtleoMxjf4OVnE0RS7jlPOoVlPG7A==
X-Received: by 2002:a05:6000:250c:b0:3a4:cfbf:51ae with SMTP id ffacd0b85a97d-3a4cfbf5352mr12216017f8f.4.1748417939301;
        Wed, 28 May 2025 00:38:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450787d3aacsm8564785e9.33.2025.05.28.00.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:38:58 -0700 (PDT)
Message-ID: <249a78c2-97cc-4f30-a156-d420bf285fc1@redhat.com>
Date: Wed, 28 May 2025 09:38:57 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: Flag state up only after cmdif is ready
To: Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250527013723.242599-1-zhaochenguang@kylinos.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250527013723.242599-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 3:37 AM, Chenguang Zhao wrote:
> When driver is reloading during recovery flow, it can't get new commands
> till command interface is up again. Otherwise we may get to null pointer
> trying to access non initialized command structures.
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

This is a fix, it should target the 'net' tree in the subj prefix and
should include a suitable fixes tag.  See:
Documentation/process/maintainer-netdev.rst.

It would be good to also include the decoded stack trace for the
mentioned NULL ptr dereference, if available.

Thanks


