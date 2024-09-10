Return-Path: <linux-rdma+bounces-4850-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F745972B4C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 09:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3B91F250CE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 07:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45846183091;
	Tue, 10 Sep 2024 07:58:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1843142911
	for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955086; cv=none; b=MEMpaj1qRsgm3NhhGl/jLsQ4HO2Eqbbv2iIaBwrGJbg4MdNj9dePocFYw714UkNQXMlBbn+dMrob7rhkQ/AwJUFySRk/py2m5/zoPBIRAc1cViHefnobJg40tYabRRGhef2EvLgd+1iHQ5rc2aEYYdiIQ6fGMNr7Hin60crfJI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955086; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPDUWvLsCNf67bxWQeljGBIunqqIlpk6kb9k+47WyiWDcfEHvomfnsbaa2Ze/4EE79IqnXuOzl7BjUT41CT84YkLEmuVn0n09ASrOKZ9wvY7oRF8ygLpN9t17iR623ibxUlDqboQ9UbNiLro07A0piT/K9Lov9hOvpuTCZ91WIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso24343415e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 00:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725955083; x=1726559883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=rpb9I9S5+gRj5GegmE43muJF5yC8rsOI7Galw1nO9bmP1exZqwGuoR8O+LXhgTo+FW
         S38xx/yLvXqX60VXzfCDGH62nPlKugfOJ+trEWPD20ln6LbOmeSYLjeBMmp7/XyqvkgO
         2YZFF3ijPGTqbXznp4+ufCZgglzQY6D8KzS29lUPsLzTkLPn5mb6KFnzJa591D3sRe1G
         en5u3OyHG4pEvESnpHEnD3EGjWXkBqIVPoOczHDHHy2XcK80QiTiM0+4hRon9cNms9Ys
         oVsP0CU0+y579Hp3XCFQw2q/XIf2cP9yKGh5+Xzsi0JRjrkiqsEdVXsqHtthYRx3bKce
         t29w==
X-Forwarded-Encrypted: i=1; AJvYcCVBlz26p0BboxMHOjzgj0f72lwgnna1XyIIVsIW9VvX675Upe1w0iZPXUKozBUxqDLt6Wd1HWUu20PT@vger.kernel.org
X-Gm-Message-State: AOJu0YzULOu6ou6m9w71H/4Q1dHVYXnTIsI9Bf3eZ2WRU8qUT/mIqCAt
	XFCdpgv4JRXXFL4n/O7gDgCpEzFcx7F6G2YRavhG9zQcMb9pgtKQ
X-Google-Smtp-Source: AGHT+IEJNzV07H308KVC53rXaa+e/ANP4EAv5pYS+FXzQm4P5ybRUrPyzrbePofUDPxwwF204WTfmQ==
X-Received: by 2002:a05:600c:4918:b0:42c:a387:6a6f with SMTP id 5b1f17b1804b1-42ca3876ae9mr111089315e9.20.1725955082123;
        Tue, 10 Sep 2024 00:58:02 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb33a92sm101683145e9.20.2024.09.10.00.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 00:58:01 -0700 (PDT)
Message-ID: <ec481be8-c65e-4cab-8daf-1d71c23e2b24@grimberg.me>
Date: Tue, 10 Sep 2024 10:58:00 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] IB/iser: Remove unused declaration in header file
To: Zhang Zekun <zhangzekun11@huawei.com>, mgurtovoy@nvidia.com,
 jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
 dennis.dalessandro@cornelisnetworks.com
Cc: chenjun102@huawei.com
References: <20240909121408.80079-1-zhangzekun11@huawei.com>
 <20240909121408.80079-2-zhangzekun11@huawei.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240909121408.80079-2-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

