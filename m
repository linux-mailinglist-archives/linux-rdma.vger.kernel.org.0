Return-Path: <linux-rdma+bounces-523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A40822200
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 20:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392651C229AA
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 19:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528F15AFE;
	Tue,  2 Jan 2024 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSQFzGzb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2915AF6;
	Tue,  2 Jan 2024 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-35fd902c6b5so82044345ab.3;
        Tue, 02 Jan 2024 11:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704223800; x=1704828600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dLzJTPxirZd6kW8WXj95cv8++GN7i41+6PgBQongBc=;
        b=eSQFzGzbZg6tROrl+Qcqzu9qjGwH5tA4deBoyWW6GmyJEyQBR34tW2m2Snli5Fyiw1
         th4IR22f1xitbeiNQ9oCXhOmqva+ykEfmp2yR0Fq+Za1tKsp4rSkH8iBZEIGyy6uM7Hs
         1BsKoN8ZRGqarr3PzI68qdnpKG0SZ4/D6P4iB7u1HidftP8LqN9IgXSHc0f5YSUHpQmU
         fbeCJI1mkV3cafYoY2y5zv0St+zYRfY3CmVe1caZ2NRVpNRTtixKa972iY7f2fEk7Ijv
         zRB2HEwOeDANCiPs+CAVLRIhU0gxQVXR+wlzRkGyulZ/wyxWRdOEHFuEESOMl9BtWF6p
         WiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704223800; x=1704828600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dLzJTPxirZd6kW8WXj95cv8++GN7i41+6PgBQongBc=;
        b=jfPGIRvEq2a7L8y3kSp01sTUol0ib8Kc3D3Ex6Fne8Fx79iUW7xs2fFjAp/Q1KJ7gx
         OGiKuCpGxfv5T3Hary2FhliDkL7qyxaBmfxOo1A7HtqYH/Mxt7jn4+qdw/kOdgrjXm2P
         PAlNKGjuuIgqp3QqtXTlnGOL4AEt7Rbqqj7+7ZPsD7XWtNxO0z5Me9OJQxorIsFj5q52
         23gpvZSb5NhaLotoJu2QwVaL4GYeG2AksIIv9WaPw/kJYs4pLK59ktTsh7X82zHNTRH+
         ht5H2uMKj0h6BHnWDVnSZSLLM9f+LJKV2CQkdXh8+RRXeJHWeUcK0c9EPkbt2bLRyjSi
         4apg==
X-Gm-Message-State: AOJu0Yz6KrRy3a9EO773vIkQMpApO8tX956a7W3S0dzAombIAip4jF+I
	m9LKBWUEmg3rpQY9BjrE9f0=
X-Google-Smtp-Source: AGHT+IHZfduyvxdowlAgFeALh+0JD54971ApQGhLj0NNcRFVRfJq3vCoS/FL3GlTSK7oZkhyaqnWew==
X-Received: by 2002:a05:6e02:1521:b0:360:fe1:8abb with SMTP id i1-20020a056e02152100b003600fe18abbmr17508304ilu.119.1704223800080;
        Tue, 02 Jan 2024 11:30:00 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:5017:6182:740b:2f80? ([2601:282:1e82:2350:5017:6182:740b:2f80])
        by smtp.googlemail.com with ESMTPSA id bf12-20020a056e02308c00b0035fec699584sm6772857ilb.13.2024.01.02.11.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 11:29:59 -0800 (PST)
Message-ID: <17a2c694-2c48-46dc-b028-68793a31a984@gmail.com>
Date: Tue, 2 Jan 2024 12:29:58 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-rc 1/2] rdma: Fix core dump when pretty is used
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Chengchang Tang <tangchengchang@huawei.com>,
 Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
 <20231229065241.554726-2-huangjunxian6@hisilicon.com>
 <20231229092129.25a526c4@hermes.local>
 <30d8c237-953a-8794-9baa-e21b31d4d88c@huawei.com>
 <20240102083257.GB6361@unreal>
 <29146463-6d0e-21c5-af42-217cee760b3f@huawei.com>
 <20240102122106.GI6361@unreal> <20240102082746.651ff7cf@hermes.local>
 <20240102191701.GC5160@unreal>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240102191701.GC5160@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/2/24 12:17 PM, Leon Romanovsky wrote:
>>
>> Part of the problem is the meaning of pretty mode is different in rdma
>> than all of the other commands. The meaning of the flags should be the
>> same across ip, devlink, tc, and rdma; therefore pretty should mean
>> nothing unless json is enabled.
> 
> I was very inspired by devlink when wrote rdmatool. It is supposed to
> behave the same. :)

You need better inspirations :-)

It was a mistake to merge devlink source code into iproute2 without a
commitment to bring it inline with other iproute2 commands.

