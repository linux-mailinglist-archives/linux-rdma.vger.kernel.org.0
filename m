Return-Path: <linux-rdma+bounces-14099-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AE4C14050
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 11:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E5EA4E862A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580B3302143;
	Tue, 28 Oct 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ft4FLfAt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D421CC44
	for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646444; cv=none; b=a0c+S/mTrvx5IoZH9Cuta9fnNAlW+q2QSFSBjXQ5lRiixn5bXYYm1671qOAyyYY8HxQWBi2AlDxLNEBfs23MdskVRx5jANXk7XXzyMnaXmys4PgaTaVw4Oox9ieYojaF1XamQsDqGGteJpEKGWFFtX+1XF/cwcyhJHMRzuILts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646444; c=relaxed/simple;
	bh=m4so6IGFPXEcYvbhKAT6MoOPeAqvtbCZnJg8zIhms94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBiEIe/O2JOgdg0B0RLI+rdO8tLJU+1fno8cxVud3ZYkaq9m/q4TabQ83zct4/CGNG96zCHkS0SVesnTJXAs8BMt8v7bGb7YzWaLFzY96c5Vo8LGhTLPxBLjdHrNa5fHOXMv4zZApoa2Nve1FL29KEppBUrdjRCvukBOwzkRNpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ft4FLfAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761646441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6UDUZTk5Iy4k44e3/ML5QCHFRg0Z07tvb3WKav93qg=;
	b=Ft4FLfAtDLfGCdQDbOUGNpParD+6rQLkcfi0nCecLk7zaK+qLpB4L11YGtifSRlEQOEcrU
	oglZ5MZrEKY2XmfOztvOOXibBNXL6bmfroopT1NtBTycRdBZzADCiMjJ0PgRmQl5B7aTRJ
	5d9/nI8xz532/DH1siYU44t0dyx0H/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-VJRhOaObNROAUtRCX12faQ-1; Tue, 28 Oct 2025 06:14:00 -0400
X-MC-Unique: VJRhOaObNROAUtRCX12faQ-1
X-Mimecast-MFC-AGG-ID: VJRhOaObNROAUtRCX12faQ_1761646439
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-475c422fd70so47172725e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 03:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761646439; x=1762251239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6UDUZTk5Iy4k44e3/ML5QCHFRg0Z07tvb3WKav93qg=;
        b=S9dCSS9noaMbKFPs+a17b5nySvx0MCUNyj3DZAgOFVNjtUKWBcJihIQ25puHK7XHt6
         QYytOIjvcQfdeZ4xrNwEP9kbbia2jdhLNFLKMzG2qjSt8VlbXouJDg0rgc9GQPMHzxL5
         tXzAXZxoYA/JdiVCLbv+BlZ2iWtbK4m3LochCdusXTASgLw8zLUO9s6rbGxsDIkajtJh
         wU5Uz+TxeRl6ZX7xB02WGH0Bt1PtfKU3DlV9+sJSy1Xo59r+582WLz+lfQbG+F60JNfL
         nxdI4qXj30dIXv9oAW9OZeyQ0f12Tx8LgQViRz3Vbc27JLqrz1bs0wx9kKlsGIZ4qI+D
         /C9A==
X-Forwarded-Encrypted: i=1; AJvYcCUi+jHmSsbv3MLgPPZlLs6MJ5uiP/F7OdjMVWjIbwpRDrRnNR9GL8MK5NrGXUp3pBaL9iLmaaveSHw+@vger.kernel.org
X-Gm-Message-State: AOJu0YwF3Ob499RWOJ0B7wIHOS/xf7JwJfAYUZQF/XERFtjsn4FatWg7
	HLn1y922BlYsraprTNll254p52wNokjFr/uZPA9b4Iy/GnYCxjj2oKzEjA0Y9brnH2tkfAVv7WJ
	bxYcbW5NuyWsqI1z3Ykn2O4YMdfZElrfHStDRqDPOSqDwaXo8WxthFaFSv4+ldss=
X-Gm-Gg: ASbGncvEJBE63RDQm3e/E4Fl9FjVbcR0eh5pK7MINa5XsOB5rrbkJAJISitvnVdy75G
	SlztLm7PYLmNbkLRW7WkFPNTZEwuhSXhzd7+Y4ka0jJUs2sO7MSAMFu643+OCirHn5024ORcNWI
	SvNKpQE/3MHSVHj1ZAQYaRQGkpF60oFyiFRJReCjmo0ATUihGOlTdmIBZJlvH3q7arRBiR+kDJh
	t4uaCSoIopYkiWqchnSwPPXpQrCBmV/5QKpy+nS8rFdS4Zq1NGt7wfQrpzqeTKlBYp9sU6udpLX
	zAKdNalqA+oqq7kULcwIreKuKKgQK9yr0vhjjUKWxEsjIZUg1RZvit3Mzoc1ZLdbeoYDsM8/mAk
	lFWIviLqY4qiREmQ7FIRfL2I/LmtFldHD3GJHBBLKKEbrfgs=
X-Received: by 2002:a05:600c:4fd4:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-47717e6befcmr28032245e9.32.1761646438794;
        Tue, 28 Oct 2025 03:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ0ZBf/JaFACw6W5VidqgGCD57Uclj71azPGP6UqMT6JqtBFJAx5Wu2NucJErwaxI1+vp7eg==
X-Received: by 2002:a05:600c:4fd4:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-47717e6befcmr28031835e9.32.1761646438355;
        Tue, 28 Oct 2025 03:13:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb55asm19552829f8f.17.2025.10.28.03.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 03:13:57 -0700 (PDT)
Message-ID: <b95eecd5-3dab-4557-aa2a-36f58779c230@redhat.com>
Date: Tue, 28 Oct 2025 11:13:55 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] net/mlx5: Add balance ID support for LAG
 multiplane groups
To: Tariq Toukan <ttoukan.linux@gmail.com>, Zhu Yanjun
 <yanjun.zhu@linux.dev>, Tariq Toukan <tariqt@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Shay Drori <shayd@nvidia.com>
References: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
 <328ebb4f-b1ce-4645-9cea-5fe81d3483e0@linux.dev>
 <2f84a4ee-8e45-460a-8e62-3f9a48da892a@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2f84a4ee-8e45-460a-8e62-3f9a48da892a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/26/25 1:53 PM, Tariq Toukan wrote:
> On 26/10/2025 1:59, Zhu Yanjun wrote:
>> 在 2025/10/23 2:16, Tariq Toukan 写道:
>>> 1. Add the hardware interface bits (load_balance_id and lag_per_mp_group)
>>> 2. Clean up some duplicate code while we're here
>>> 3. Rework the system image GUID infrastructure to handle variable lengths
>>> 4. Update PTP clock pairing to use the new approach
>>> 5. Restructure capability setting to make room for the new feature
>>> 6. Actually implement the balance ID support
>>>
>>> The key insight is in patch 6: we only append the balance ID when both
>>
>> In the above, patch 6 is the following patch? It should be patch 5?
>>
>> [PATCH net-next 5/5] net/mlx5: Add balance ID support for LAG multiplane 
>> groups
>>
>> Yanjun.Zhu
> 
> Right.
> 
> Indices shifted because we sent the preparation IFC patch a priori:
> 137d1a635513 net/mlx5: IFC add balance ID and LAG per MP group bits

No need to repost. I'll adjust the indexes while applying the series.

Thanks,

Paolo


