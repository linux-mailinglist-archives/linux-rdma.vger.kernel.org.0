Return-Path: <linux-rdma+bounces-7896-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2B0A3DC3F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 15:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0DE57A8640
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 14:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58851EEA27;
	Thu, 20 Feb 2025 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F2E3alSy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE6433BE
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060830; cv=none; b=IDwhQUN4s+rAceDInZ6la5cct6WDI5qsFkTsycr4BXo20opvZCFKKfioPNnifFChuGbR00VLtFt8boMSzP4cTWg8QAj5Z5PiZeOvvTEXlOaUVQCFrXLe/mFbnaUCA3NbqC615rivp3r6i9a1ZdO3LRJwVtseNNkc2fKTOu61oj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060830; c=relaxed/simple;
	bh=Hm2J6WxKpWskBe1jvIPWfwmfW6yTavCvRkoDXkvOrkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNAkDV5YeNFA2LDzrcfNgchtpZ6L3ImxicCnzCfn0hmuw8NKD8Xfj3ScQKFlEvHczrxrKUv9+Rz/Sbo813C53Bf7Wj1RNwBx1lV5OhdhAop5crmiolZj0UzwVjtvlokQ83e3tRahZOxEkRlmxsLBJBjZgzzRogZvKJQp1Z7y/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=F2E3alSy; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46c8474d8f6so8552941cf.3
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 06:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740060828; x=1740665628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hm2J6WxKpWskBe1jvIPWfwmfW6yTavCvRkoDXkvOrkc=;
        b=F2E3alSymk3Pkctk07uV++KvxfXyxvR2pL2D5Ls3z/2S4XB14S0rSIr3AHf0RzhTwS
         dI2WhlG0esjb+N8HVo/zUaRkfZfv6I/O27T6tUE8KMh6Vo0txQGd/VV8Jq3/KkO36J8W
         kZjh0f4y0JbIxqusgEAp+FpGKM4SPfssDjSDAUvPkpzMIipgrP+Ry3FBVarrVUANAOS9
         nzIqx3DEf0rDFN1e8gr3fr2bwyPadU4K+ilC0Ej5L8nhAGgsONbYNpqRU+JpfhgIlIAG
         X3B1ZL7UxfmMNjhb3V4ykwK/JxIvdE8YXwHQycOu6OnxIciL1OdzmOmpk+ll0SLhrDTt
         CW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740060828; x=1740665628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm2J6WxKpWskBe1jvIPWfwmfW6yTavCvRkoDXkvOrkc=;
        b=CEQox9MbLD6YgWSppKN7i7m/k/IevZu9PQDtHS3rykbws4nEcW52QUQtk8GcJg5vNm
         1RMdiftGR+h61C03HMpEY3lOg5LyTYXJQcYLkOEDm+NYnzbrq9xccoXZU+Vyvqg9qvdO
         A8o2ZwWhE519JlifPNIjFItIMC1Vfw6UlKtbwwBRGS1yInRFXNcU6Yv1I52R2HPduF21
         sCncESBKcP4YfEauT6+JmnQoPfA5iGQhO/FNnQh/2Lh+IZhUOA0ZO3kJ1uKZAsqKMxbs
         OuAZs4NX50b6cSWHRSmO+GhSUUQ5p4ktdLf29/z5AISZ4WD8t5trb+rgQNj4uLl40lsG
         /kRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb2z9Yj+CPfyWvvF51aa69pGOGsVpO4Baj3jWYOmk5y+8yVtWITNZ1Hw9o7HxV3rT2OXn+Js/Y4q2x@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi9nbHMQcjsoLflXLO0QQ7kcZe1lDlLkFAMq4IgT6RVvDvJRJP
	PXb6G4Y+bhSvFk9KwN09zKxLM+P7Aq68AaPD1cfvFYkKhJnnqoahi6FE/UyN7ZNwRMtSA/ux7c5
	l
X-Gm-Gg: ASbGnct+7gVfjl7Zgu3Ywis1x/8RxsYlqojKBsE3PWMkGVKNePhmG8lRyVkyzvZhqKE
	G2L/vsZM07oHa8BZEK4qbYiWKoUPJ1pdkJXgBfdPQ2B6bGinmI9HInZRtJo5uLoZXAOVmnYtEoq
	LHXQtaFcasmAbHets2OkWkWR6pXQG50/06JUP0yLZSWtZWKj4Ei4g6NmAKOJ5edfotXaHt+3Xod
	gfAqMJoUXwNE9mK85AczBpX2T0Jcbs8Z6o3UNUEX2OsJJjOoSsYUIEU8vOqw/yomX2d2UDzYaF8
	Pk4nFwBUBdxvguMmu67DD3Kp6yfJKDC4J/V8eQAbDX6dIXsbY2nubbJLqv7RH2fo
X-Google-Smtp-Source: AGHT+IFrVPgabU1QBj05zoABA4W6iGWcBtFmdw8G4qL/eEsKlhYA+5GhZnKfQJdsKExW0woWzlR+EA==
X-Received: by 2002:a05:6214:f09:b0:6e6:6697:5a28 with SMTP id 6a1803df08f44-6e6a4c17270mr41026856d6.36.1740060827936;
        Thu, 20 Feb 2025 06:13:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785c14sm86213166d6.40.2025.02.20.06.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:13:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tl7JC-00000000Gkz-3xn4;
	Thu, 20 Feb 2025 10:13:46 -0400
Date: Thu, 20 Feb 2025 10:13:46 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, tangchengchang@huawei.com
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction
 mechanism
Message-ID: <20250220141346.GW3696814@ziepe.ca>
References: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
 <20250219121454.GE53094@unreal>
 <bb0a621e-78e1-c030-f8f6-e175978acf0f@hisilicon.com>
 <20250219143523.GH53094@unreal>
 <e8e09f3e-a8f9-429a-ac60-272db35f25fb@hisilicon.com>
 <20250220073217.GM53094@unreal>
 <bdc9cae7-4d8c-4294-18a5-687e9b7edac8@hisilicon.com>
 <20250220090856.GO53094@unreal>
 <542860d8-34a9-b109-2a85-794149df1fe3@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542860d8-34a9-b109-2a85-794149df1fe3@hisilicon.com>

On Thu, Feb 20, 2025 at 07:05:06PM +0800, Junxian Huang wrote:

> Mailbox carries information of the specific resource (QP/CQ/SRQ/MR)
> that are being destroyed. It's impossible for FW to predict which
> QP/CQ/SRQ/MR will be destroyed by driver during reset before the
> reset starts.

That doesn't make any sense, the device reset is supposed to clean up
everything. It doesn't matter what the mailbox was doing, after the
reset finishes it is no longer necessary because the reset was the
thing that cleaned it up.

You need a way to track the reset completion and cancel all
outstanding commands with a reset failure so cleanup can
happen. Combined with disassociate and some other locking you need to
create a strong fence across the reset where there is no leakage of
'before' and 'after' reset objects and kernel state.

Jason

