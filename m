Return-Path: <linux-rdma+bounces-13429-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1985DB5A1AE
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 21:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8541C01EFF
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 19:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A242DF141;
	Tue, 16 Sep 2025 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0+eeMU/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08A8F6F
	for <linux-rdma@vger.kernel.org>; Tue, 16 Sep 2025 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052412; cv=none; b=N503Sx3JOtIaot9URuSth0+TT6jRvMAxdEhdlR8qMs+DbsF7Q9sKfTsWx/hE4ydVgSOmojRyTTHLfCUzxpNb8DeI8G8YzCdJjGvbAjgiIWynNkx00/mEgjr5kFSD4VRVKGwJKQ2dEOzd8t4HOy9bzJGQr7cK2PMqaOx5PU3PG+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052412; c=relaxed/simple;
	bh=3T9D2t1qq69LqhN17EDkyhBUgxegMxL2fRfUXiYb7qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVVkpRQg8OIYY1ara4/hRKwhuNwbRgVB6ltMy296Ht9ctFMP2F7yvWHEoPmGquKoBl2hzg2Lnr8KEkx9JNzRFHDR97jFqBWXVZ38zdnA/xnnNM+nM1vtUoctkqtzE/sDyFPGShrzjetYTA/uovxIzqSl58rULvewtK86OdTlCzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0+eeMU/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso36933095e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 16 Sep 2025 12:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758052409; x=1758657209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Op/mfZsVaCIiTyvcgrObOgRcD7fjVHYfzWijrbsL1E4=;
        b=H0+eeMU/odAE2HFN91lkgYZbFr9UjZqmOnfFf1IUkva9P3H28pTiKdQtVAqPj5WVrf
         l5MeqimiUyvt4jF2MrhF4c93jfb9qR4389blVOPwnwfmJMzk5rP7/n3Cltm8Wc4+SSSn
         0RtocYq7A1NFedPaBxaJkSY7z5JNygUT3mxrNcIcH5IloDpHkpM25HfGjaKXQ/0cq3UV
         lBdJiw2CSD9uDUl13xuDfX1hBKanbprTPyqZTblbBVSpPqnj/uOJX7rCOTlmDU48gVGw
         JpJ6iTNqnmC9GChTpxSpBkhoYzw9Gws+LKhje2y+e6xLEkl8VNeK0qi0PJWqbQeESI+6
         3sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758052409; x=1758657209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Op/mfZsVaCIiTyvcgrObOgRcD7fjVHYfzWijrbsL1E4=;
        b=M4Gc2cTKr74rRmy5OnzgqeEhlpAvohnIBEo91a6Rj9TPCyH8hSPjt+RyedsKn5cVdb
         eWFJUcPMzfZtGulOHOwWLWwU8732rvgE5hzow2N33f9+8/OqMMAdBDLE2/R6repBsCaZ
         RzyJ8+jwW1py8QEOv/AzxHg51yfDR9TuOPYI503BTzutsVysem1LYqIQbqt2ztfcWXws
         BGfmU1nR4V92zc/WCDDQfNTqNPGD/yeEX+na27DtKmQKFDrPlq8q0T3xrzt3Q0YsOIUx
         hdp3cjL4NV4r8AqUn5YuqzlayMp0mStRV0rruVmgkvPHljDA1eEpxfNEwXS5/+JBK2zd
         Zfjw==
X-Forwarded-Encrypted: i=1; AJvYcCUWBHKy3yqYg7wOInTF7HC24ptIp4SJfwZCNhFasO+ISnfyahR2spyldGmTdCeLxbys8/G/y59fxOXV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlkf9CjVLJP3aGuSmuD1C8jTi8KxuaZf/U9ze061y3t61XJOSz
	ANsRxab4+n37aDblUU4z7Nt0UCwPe0cgkovkSZ9JZQR2Qjlovbw8TsVT
X-Gm-Gg: ASbGncuu3b+hg7fkbM0M7EIpXRZ/T2GIKe+kuu9KHJv66VtLkEr3mk+IZV5AmXXS23Z
	3VD55aGOhalhU/2FywyD91ey3QiC43WDLSbNorRQ9RB+E+0JGbdcGtkLZvmJJUegSx9EB6HeaS+
	NLaqnHWQ4mjNlD2qu52nXt6i5ZB5KzNt4kfm33Ja1AUYrex5vppf2+WHwnFwt1h4b+hT7iv6nra
	sd1ngGIXPVlLB68+3qamItTnJzyQ5Ee0Ww5/afiVCGvZ4iOOL8pUrzZugykpWJ+MipT4V2H2st/
	kPUDrkcUtDhQqOSL2kewZj6294+jCJdwgS/c/uVHTjJSk27V0BoyxrCfdK9lzPAz84gearu/tZN
	cANlM3vcoPUhxA3z77iU0iGikHmS8mPHk2E4AVaBuTZ2xpo8D5g==
X-Google-Smtp-Source: AGHT+IFsJDK9nhbWZy8UpoS+giPB9I8eqLFrqS1+V+EAPmi5yJXPv9nuFGXnTz8G4O98qeZZKmgX/w==
X-Received: by 2002:a05:600c:3505:b0:45f:2843:e76b with SMTP id 5b1f17b1804b1-45f2843e99cmr107649975e9.2.1758052409285;
        Tue, 16 Sep 2025 12:53:29 -0700 (PDT)
Received: from [10.221.203.56] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46138694957sm7592775e9.4.2025.09.16.12.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 12:53:28 -0700 (PDT)
Message-ID: <c9533a24-a02a-4601-9b4d-197b03634c4f@gmail.com>
Date: Tue, 16 Sep 2025 22:53:26 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/mlx5: Clean up only new IRQ glue on
 request_irq() failure
To: Shay Drori <shayd@nvidia.com>,
 Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org"
 <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
 "elic@nvidia.com" <elic@nvidia.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anand Khoje <anand.a.khoje@oracle.com>,
 Manjunath Patil <manjunath.b.patil@oracle.com>,
 Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
 Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
 Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
 Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Qing Huang <qing.huang@oracle.com>
References: <1eda4785-6e3e-4660-ac04-62e474133d71@oracle.com>
 <d9bea817-279c-4024-9bff-c258371b3de7@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <d9bea817-279c-4024-9bff-c258371b3de7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/09/2025 8:24, Shay Drori wrote:
> Hi, sorry for the late response :(
> 
> On 27/06/2025 9:50, Mohith Kumar Thummaluru wrote:
>> External email: Use caution opening links or attachments
>>
>>
..

> 
> now that the condition is only one line, you need to remove the
> parenthesis.
> 
> other than that.
> Reviewed-by: Shay Drory <shayd@nvidia.com>
> 

LGTM.

Acked-by: Tariq Toukan <tariqt@nvidia.com>


