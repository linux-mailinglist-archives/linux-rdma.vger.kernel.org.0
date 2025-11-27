Return-Path: <linux-rdma+bounces-14810-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4361EC8F86A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 17:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500C93AA907
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 16:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E02D7DE6;
	Thu, 27 Nov 2025 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbT4Kp5J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2C5DMv4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18B2D77F1
	for <linux-rdma@vger.kernel.org>; Thu, 27 Nov 2025 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764261297; cv=none; b=RTottwxelajSncV4NT15KKX9ZqGKuv/C0w6hze6EDrkndsLPeZFqZu5l1ZtmRc47nWZbLlj07lImulSB0wJp5kQhHnlTCZi1hwhanUAvcD5k+ILtrYi1xvyTZx4et7LihCu9JubD2NYDLPmBQHuU80YqbSMdsYaV+uLsfbD0vXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764261297; c=relaxed/simple;
	bh=qbwQQeYnhh5Jp+VwwIUbFfb16SXJjHTfT04dLegf2aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AienP/ZFA2zyuwQ2ASePDrOASLC3kWOFo7sk9Qi4Wc70+WqN4v5Lt8woajMFczZ2AduLI7zIutzbuPQdqFqR7z8NyFk87LxsV1NMCdQCYWaZFjkpQS2yZ082zeqpJuWZaQk6XDjFLn2WVHh/2JQNB8d5AdFkHlJc2X1Xl5cmPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FbT4Kp5J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2C5DMv4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764261295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4iwbs1h8WPfjtCWRn3LxmIB+8Vn4N4Td3zMk03YVIE=;
	b=FbT4Kp5JEh7tvFojDAoPB9nmDPJ3gbOF1FJLdq8DnXxdiTf+3rP3q532DziiX9deXqbztK
	5hHrUZ9YXQXO9/UoPa7IUlVauTThZ+NNx3zjXE0ZLaJykrU3FvkaRlXq4ruIOKXPsp6mUV
	HQPkIEqRqcIhsdY6qGlk+SGNGRkwvPQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-f1bUBiiSNOu3WXE9LGCr1w-1; Thu, 27 Nov 2025 11:34:54 -0500
X-MC-Unique: f1bUBiiSNOu3WXE9LGCr1w-1
X-Mimecast-MFC-AGG-ID: f1bUBiiSNOu3WXE9LGCr1w_1764261293
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b3b5ed793so672074f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Nov 2025 08:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764261293; x=1764866093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4iwbs1h8WPfjtCWRn3LxmIB+8Vn4N4Td3zMk03YVIE=;
        b=N2C5DMv49YAmipiVLj942vrUXgAqs8MW/pqT4xpbd2xp7SNzLOsxY5xE9E8ofIetrM
         FnKxyvQTqNbUKB7X4HDCj2i/QBomZ7bXVlYdX21Q6VWjI13LirRLYiY3Xcir1SiCkZ8U
         qTsI5oBcjc8k3Kd4piiaWHCiw+7bzTlvgpfc02gxn3WFmmqKWhA9wNVNzqos/gTzzpv7
         sDKE4qh/4WQ9dXak5jbdLyD1MhGqNqzb1AEbE64sxOgF9Hl5JGaQr26bIgIXic9bHrR3
         BNoiIgD8xLj7aep8mTK5byHIfcCZaQydHYr+BxFiX59iXqPvC3AcO9klq/JQgldDlkfC
         ySPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764261293; x=1764866093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4iwbs1h8WPfjtCWRn3LxmIB+8Vn4N4Td3zMk03YVIE=;
        b=WQjPA/BKbXo4VUFQ100dQJnuS7IsPdSYJNUf4jBOTu7KHVQoMYsYwiQGvo3CaiSeBp
         LOmzMxUgO9LUYuLFy2ZJ3cHfRlEbNxqLWsXrZH/X6YaaofOPAPnoj6PVaOkeQVshe1uL
         FcQKeuGZ0njwH7YQJ+qmkNZvlGGtQvEpmfE5YfTu8TQFsB/quqDGiG2Z505ayMvihlpy
         LpLnR9VJjJWjpICRqGdwkszaJvRfRnzPxOaixlvCbDT0+dXqJE+Ed99NSdb1ehzXlo8t
         NYxKhvSBkR+ANbyc0r7td14/1vpRxeZAuUVqGfuwsGYOkcoeLTsPh+yA0/xqxwxxttD0
         LiFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmyBp5a6KF7qzgAdMAAvFM5YT1kzTpr0uZ1L+zG32gdtLsIF7asrBrGSBccgdwOc4DfL39taZrOCT0@vger.kernel.org
X-Gm-Message-State: AOJu0YywT6zFXuAjlPzoALySQwHCYWme07RmMe8jinOH7LDDTLNWegxS
	UTtZoWNCrWD7pHmsuqes5fpLFfY0gA6S66iKakljWX2XpQyUbcD2a2rHr5FPaoEywn2RWtfsDbJ
	7QYmfea+kfjpoK2SKbohbpNlRcovLuvIas6UnkH0itS6Baf2U3+aPBKlBLfCpff4=
X-Gm-Gg: ASbGncuKcgk7lDUZpA8heMzToSwv0Zt1XHIP4sumHI9Z22nKqhbpHqn5FSAvnlaUYWJ
	b9R3V+5PASqMIa6Jtk8/lTKkEjjuW/1XGyWKuS4Vk8R6tXjBg1I+SohwHRnLpnbwwsO2TJiuPD8
	JHnfd7BsqJKB63OAE8qxxs9XsHUhNmfGN9O6Mwb6+Go0iUH6UO2P8rXQc4E2fj/vnfQq+lRNVb5
	GakTqI3Fwoc3Dhj0O8+FaTkfGZMnbXeJ2nMAcysrLMjsy42xWVJTP9k1AABZRJKuJIwjuYt6WHC
	6stSVvm8O7MKlteni7Gek/Qznk7Xlngwk0lvb1cv4A2lBqik0f05zJJ72aH+4B6iparrwNr44wA
	MlF+3A1vuNGG1AA==
X-Received: by 2002:a5d:5e01:0:b0:42b:3131:5435 with SMTP id ffacd0b85a97d-42cc1ac9de0mr25419572f8f.2.1764261292606;
        Thu, 27 Nov 2025 08:34:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBjcdBlqLKajPU/sQcGkGD00QWIR2/Z2jTb31o5tzKYhK4fsXo5kSSU+5/YPOKYslbkKRh+g==
X-Received: by 2002:a5d:5e01:0:b0:42b:3131:5435 with SMTP id ffacd0b85a97d-42cc1ac9de0mr25419529f8f.2.1764261292099;
        Thu, 27 Nov 2025 08:34:52 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c3c8csm5641761f8f.2.2025.11.27.08.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 08:34:51 -0800 (PST)
Message-ID: <3dd5c950-e3e4-42b8-a40b-f0ee04feb563@redhat.com>
Date: Thu, 27 Nov 2025 17:34:49 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: define IPPROTO_SMBDIRECT and SOL_SMBDIRECT constants
To: Stefan Metzmacher <metze@samba.org>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, Steve French <smfrench@gmail.com>,
 Tom Talpey <tom@talpey.com>, Long Li <longli@microsoft.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Xin Long <lucien.xin@gmail.com>,
 linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-rdma@vger.kernel.org
References: <20251126111407.1786854-1-metze@samba.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251126111407.1786854-1-metze@samba.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 12:14 PM, Stefan Metzmacher wrote:
> In order to avoid conflicts with the addition of IPPROTO_QUIC,
> the patch is based on netdev-next/main + the patch adding
> IPPROTO_QUIC and SOL_QUIC [2].
> 
> [2]
> https://lore.kernel.org/quic/0cb58f6fcf35ac988660e42704dae9960744a0a7.1763994509.git.lucien.xin@gmail.com/T/#u
> 
> As the numbers of IPPROTO_QUIC and SOL_QUIC are already used
> in various userspace applications it would be good to have
> this merged to netdev-next/main even if the actual
> implementation is still waiting for review.

Let me start from here... Why exactly? such applications will not work
(or at least will not use IPPROTO_QUIC) without the actual protocol
implementation.

Build time issues are much more easily solved with the usual:

#ifndef IPPROTO_*
#define IPPROTO_
#endif

that the application code should still carry for a bit of time (until
all the build hosts kernel headers are updated).

The above considerations also apply to this patch. What is the net
benefit? Why something like the above preprocessor's macros are not enough?

We need at least to see the paired implementation to accept this patch,
and I personally think it would be better to let the IPPROTO definition
and the actual implementation land together.

Cheers,

Paolo


