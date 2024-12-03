Return-Path: <linux-rdma+bounces-6192-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B29E1B0E
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 12:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB071676C5
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E18B1E47B6;
	Tue,  3 Dec 2024 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YfIphNkh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017531E0490
	for <linux-rdma@vger.kernel.org>; Tue,  3 Dec 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225623; cv=none; b=Z8k1j8vA8XsOOwFCNuj5ApzKKyTO5Mo2a14gEkqDrtHxtYurLMr734QjL7ZL234E84Sbv76fI85ecwrhsko6Cjas8il3BPLcUmnbxhVS2abkhpRoUFJXR25DPmcf2VheukdMABMag42gEfnOP8CQrWHIgd8Z5eZP6qAEEpd2HCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225623; c=relaxed/simple;
	bh=AHmmkPHjvu7RIKywEf+EAV3LQMeU6/vP4mpQ4B4VTxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dC9QwOMnVxf8065WWnD8jdoQGWaxmTYCZVMWFXyaLXcvE4a41eeLUXTJ1HY4IPPmkoLG+N27qQvA7gum5X/eXoj8wNoHBSNDkIVKuYiwNEzdia9N25V8ng0/azdfqPsniHMbT8bQ3q2Cb0JOHU30dXFktHx69YMk0zfRcLa4wBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YfIphNkh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733225618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zREU+lwYhiaQLLeLq6O0V37r0ooXMYuGzQk3sQUa+FM=;
	b=YfIphNkhibQPDRaBRLDhx/J+/DFquO94HtzH2Pnd61H/xR0sKx8KAneo+mSGKGihutX7Sn
	u5YIcgiDbgwBukCO5uCtvCOSaYcHumlBXPZlgPv4uqLUpu529cFUmLUNBuIsAF47mrqP2d
	qOSK6EA5HkrVELWop0ZCkqdYGIKsHaY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-00pkQj16PICyv4wvhwC71g-1; Tue, 03 Dec 2024 06:33:37 -0500
X-MC-Unique: 00pkQj16PICyv4wvhwC71g-1
X-Mimecast-MFC-AGG-ID: 00pkQj16PICyv4wvhwC71g
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e1339790so2201297f8f.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2024 03:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733225616; x=1733830416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zREU+lwYhiaQLLeLq6O0V37r0ooXMYuGzQk3sQUa+FM=;
        b=tbFKcKiAXNmSxjPkwkC3wa/BsoWnpT5eenUC4/kkoQuP8PDwm4vEnNLlZ4bCWf+9y9
         31OwoYEO53S8bu9elQX8EwoJTHjDi/1BgF1Z47PNU8QLMrI0bk28ElOcFkJDm90bzuiM
         Lacrh0cyz3Mw/BY2fd5A1ANlElyPV27UvbFkjv/+L7bleB0rOIajyf16mhiLbLYC3Nyz
         D2puHa7oqi3Urz1YzlAhukeFLJBBA2HwrGmsgWZ2tXLJAs3lIl++aa5Eftb6Ger9p6oR
         9WkRIzuQw65me7RMRrIRij3TolvC979gXspBvmwcj2HCVvV/nm5DMgHsGO5d1yXPNiVY
         rsVg==
X-Forwarded-Encrypted: i=1; AJvYcCXdcfDrxgGIfJQb71jpyvXZHE3tDPX0YMTWTdhBzdHpQRlMfXc+q4JgqoCqcCaGsp1Z54lH8CSbOFWc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6bJnmzZGbDqrTNZBHTrNpPyrzPPfi+MwpsR21nGbTCdDB3PRs
	uw/AKn6y/UFxqBy6iTuLxF9qhXNYA2prlo0qvnGQP18KeuPIg0WRX39eFZaMyaFPvJeFFk/0fUB
	4i7Eyx4av9ZUGT+c8cD/Q51OYDKiGb/R8E65J0Uhn8JwTNZiL6kGbFs/cJRA=
X-Gm-Gg: ASbGnctRXqGdK1NHPwJPxkGQKEJ90vZWnxzAztubTu5ul8VQ0lj3f/djVilsaEqyu2n
	WjiC9GWyTtIqTHAhesYR3E5Xs3/qH6AxXVuq25jWIS9kMhZyB+k9WoFrtTFIhzSN1tcYDPPwmHg
	VPsmsFvOppOaDbe91nl6Yy+8/NQUxsd9+YCYb/ALDDyxj6jszttHpjfmwa2CH2/YQ/lOSzrLZ+1
	91z/YWBRy3Kn6gxZFZ65nL4oeBBSYCL51nu3WLKufJoeOiKFvqwh7/+BLeOmJkH50qnSkStcvLt
X-Received: by 2002:a05:6000:1a86:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-385fd43c331mr2302348f8f.56.1733225616655;
        Tue, 03 Dec 2024 03:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhUjhzZs78Nz7CtLp5MQzYsLnMpSAwzkbqY7OFNZJSdUe3DRiH8XjGzF8cD+LMHI88SBHTyg==
X-Received: by 2002:a05:6000:1a86:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-385fd43c331mr2302316f8f.56.1733225616306;
        Tue, 03 Dec 2024 03:33:36 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385fd599b31sm1570921f8f.21.2024.12.03.03.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 03:33:35 -0800 (PST)
Message-ID: <4c426297-6215-46a4-a9bc-371fb4efe2d1@redhat.com>
Date: Tue, 3 Dec 2024 12:33:34 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RESEND v2] net/smc: Remove unused function
 parameter in __smc_diag_dump
To: manas18244@iiitd.ac.in, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20241202-fix-oops-__smc_diag_dump-v2-1-119736963ba9@iiitd.ac.in>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241202-fix-oops-__smc_diag_dump-v2-1-119736963ba9@iiitd.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 11:10, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
> There is only one instance of this function being called and its passed
> with a NULL value in place of bc.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

The signed-off-by tag must include your full name, see:

https://elixir.bootlin.com/linux/v6.11.8/source/Documentation/process/submitting-patches.rst#L440

Thanks,

Paolo


