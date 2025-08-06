Return-Path: <linux-rdma+bounces-12595-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FA3B1C1B0
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 10:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62E7186372
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DAE21D3E8;
	Wed,  6 Aug 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDyPiXYo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7B017E0;
	Wed,  6 Aug 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467210; cv=none; b=JpJdPdkuAIWF/DZxIK436mJs+7lhDJyaawjb/g9m/uVb5GD++wlAla790Q4inWpdZgKVGbYYdcYzOrZzCudOZe5TT5WVrV+m1y/W5rYiFYthnAbaSkgq2WbRNJa4nXUlZKSsbKrQ20HFxq4t3sBEvhWN2zVvdJBGbegL/3nmd+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467210; c=relaxed/simple;
	bh=CnHwwat3DsZ5w80ktAM6bSW2BL8Kdx6DHBhQ7Q7i7jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQ44JGEqd2W1OM2/pNaK17L8djp5dnk3GP5Mi9M0gms40bQI3NLYSO6x4s9i6h6tlnhG0PPFI1q1tHFDw3UUIccALGi0jD082EmbCinRaySd51UeejR8d3Y0dLrw/fQwpRlxvsNtA/HLyLyGZDXd5+jqpFXyKuRuQT0gk18dZ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDyPiXYo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459e7ea3ebeso812135e9.0;
        Wed, 06 Aug 2025 01:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754467207; x=1755072007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ol1AUB0va8lveXJEC3LVdXGnsCA1nHu3yUD0vxeORd4=;
        b=kDyPiXYosiREuze39vpy8VkQk7+7PINHoNQ/55l2euve89K5UHa9Jg4PeQsxLaAyQ7
         uAldsdj2LRCiLDq0pi+h/fSdZu+i9E9Ao02aUK66Y5xu/orfZS3z9rwBIbITfTSk1Ifp
         gcLHu+eE3qwMw43IY6vaJQu7xmtm+UHFKfhL/px9ltnbHEQGSGk3sTEcnQPSbpmq/JaD
         jm2nTpMItOC2ZkWPY6nZ8+VRSKjRwD5enmDXlojrOZO1242lDnYmU4BJKfEFFAM3T6en
         ktouvbB1pGLktRj7vjJLeeATcm2Ug3+h+tCMPXkqt82YvJ3Qs5rdg12AZlKn3igYY4T1
         Bwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754467207; x=1755072007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ol1AUB0va8lveXJEC3LVdXGnsCA1nHu3yUD0vxeORd4=;
        b=kdvmxaVO7zZuznS91/Wy1kxhFqfalixt0p6mZtBH1KnBwuBtJjvNq5wZufTpxKjjFP
         LBGDGzotJA1CPdbt8+RTC40DrZ7rgB4LLUNfWmj0wkAMcaUNMC2QpDdV+CHIH72aVa+4
         elxtpkRfO0SDkyKCBRWVjKak3tJcaJ/rBmk1yl8Zpwkc1jJJuHmr1OkhYpmiU+7psRvr
         IgFze340t8B//Ssis9+80CpDDlpNi5WcMhckT44yxMaf8gQUFfmBa4QscztEJ9QgHW/2
         GC5h7XS0sgUuhEWf9vG8HPciLYiFnwRUTGR0bUFwdoO8Ngue7MTgTz0WJSPGpTaYKytD
         N37g==
X-Forwarded-Encrypted: i=1; AJvYcCU2cXT7IEv3Cw07eshmj2O5pvbmPtckbW3SiS3Wabs4txFP3yCrnb4fpkAg7MIzttlKm4K/Lb5F/X6vKQ==@vger.kernel.org, AJvYcCUK+DpMkmv1Ljazl4b4kU0E5CWtQAzcnyNCr7T9AvghSSgGs63NJ+PvH+2lB1QigocRO+qJsj2J@vger.kernel.org, AJvYcCUsmrLy9BOwEx+Q7CJQJu0nzI3xqi9Wrnpvx2VibYpBlTx7A44dTe5n6e6HKVvgDEOORcGHn4csKjJ9Whg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwERFeouUN7/uyHGyt+/1un7BySqB6LX3jf22PWJCtmo007+ODQ
	j8A71NkKgkWKp9Qwu0x2vJuv5BBwLy9lkMeO9YlYBZddkmInq66ZcHf3
X-Gm-Gg: ASbGncu1Powvp17dtvfoDskS1hWwy/bsLdpplsYA4lJAdzvC4H2O5Fh6XRYx3+033X0
	gUd5DRGPHONW6POULehd+NpUB1YomqUmB+omWm0TWP4TJtz1mAzz1kExsc7ynEECY/wSoms3EPY
	th8ANwLayERzLGB1kSKj+NKS2KsCQFpHHRzsRn7Wbsh24ffsP8C8lIjipx8RpZCPjvUc6S3EzIf
	kFPqjn361pgKu3AN2cgCFj2gdFMWFG/NHy6y/v87OsLxmyGzIexHrmFsFCojL+x4OdPFCUQ+Fjp
	z25cWKAm8dHFQLQWv8e5qMTVhYElv+2ewPAxQR3kKwZv0eXgVVIGsfXZoxpY5BQbjrXrPlYpi2H
	1lMbAI6Qs48CU4e5zuDVzH8eSLGTUM/L1J1Hb0Gv16G0=
X-Google-Smtp-Source: AGHT+IGWyh5Ktnnnqyl4cD5bU3LRVX6XvSe6gqv2EDBHyQSp1zEQdILfTRY92fltUKYyY6loOZeflA==
X-Received: by 2002:a05:600c:4ec6:b0:456:29ae:3dbe with SMTP id 5b1f17b1804b1-459e7103684mr13252115e9.24.1754467206999;
        Wed, 06 Aug 2025 01:00:06 -0700 (PDT)
Received: from [10.80.3.86] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469582sm21683126f8f.52.2025.08.06.01.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 01:00:06 -0700 (PDT)
Message-ID: <7fe7a7ad-4e32-4435-a93d-0f3b182ef90b@gmail.com>
Date: Wed, 6 Aug 2025 11:00:04 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eth: mlx4: Fix IS_ERR() vs NULL check bug in
 mlx4_en_create_rx_ring
To: Jakub Kicinski <kuba@kernel.org>, Miaoqian Lin <linmq006@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250805025057.3659898-1-linmq006@gmail.com>
 <20250805160720.0187e36d@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250805160720.0187e36d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/08/2025 2:09, Jakub Kicinski wrote:
> On Tue,  5 Aug 2025 06:50:57 +0400 Miaoqian Lin wrote:
>>   	ring->pp = page_pool_create(&pp);
>> -	if (!ring->pp)
>> +	if (IS_ERR(ring->pp))
>>   		goto err_ring;
> 
> Thanks for fixing! Looks we previously depended on err being initialized
> to -ENOMEM, but since we have an errno now, I think it'd be better to
> use it:
> 
> 	if (IS_ERR(ring->pp)) {
> 		err = PTR_ERR(ring->pp);
> 		goto err_ring;
> 	}
> 

+1

