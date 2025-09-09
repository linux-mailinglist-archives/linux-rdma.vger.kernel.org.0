Return-Path: <linux-rdma+bounces-13183-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D2AB4A54D
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 10:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18249174AC7
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 08:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6B624418F;
	Tue,  9 Sep 2025 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjAIUQYs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA66112CDA5
	for <linux-rdma@vger.kernel.org>; Tue,  9 Sep 2025 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406717; cv=none; b=PKtTas7jZZGwRWVMMPiD7a4wBmOxQENYmQ6vsdGUHUpRQaFx2C/xDcRfzaghiahuvu1efUfaRuaS6Ll5m+QC4XVVNj+sIfUGNE30On1HoXxerEnnFoRMOa1XVbyG1vfwBAZ1QtbcBRsg1WITjwjUnep1RI5gItBl5FiqDUwr2z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406717; c=relaxed/simple;
	bh=6G6CgNfZE3HhCmcVYoqhzdz20x6QjWDcqIpAGfIuSYg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=t377LZdYBDCHdDroEyhM7LZZv0q5jvJ76RwUFvTO9pyJ6U4IYJO02KuGQVdiiwijOXH7irq+J80KXfiQSERLPcESDJAaQ/8yaGZuahwQul6q0eNZETkkRznNwaWyKZjczsHw0YOWmUBtMHdLa2dZCmLJa4rEVBiQqmGopjFYTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjAIUQYs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757406714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3JiqpXYLeFdSyLXqDESG7NejUBS/eexgYk1TpT8BmU=;
	b=gjAIUQYsD27UqMlN1WzdzIdBRd25bfxCjW/PsPG4dav7FIH6Z9VJwHBf+uXRm7CfT8a5vA
	xorWuLkqcEacsY4ClC2geq4waH4Du7+2DJAZ9SJvCdgSx44tQBjYv2NU+KkDixF/TbDIrP
	kB1m1otV+doyEHbEHa47aat670TVsjk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-TiE2oYEVN6iygSAs-U6zgg-1; Tue, 09 Sep 2025 04:31:53 -0400
X-MC-Unique: TiE2oYEVN6iygSAs-U6zgg-1
X-Mimecast-MFC-AGG-ID: TiE2oYEVN6iygSAs-U6zgg_1757406712
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e38ae5394aso3202829f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 09 Sep 2025 01:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757406712; x=1758011512;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3JiqpXYLeFdSyLXqDESG7NejUBS/eexgYk1TpT8BmU=;
        b=c0RD/lrq+BM67pT8IIiYjdoszKAcEyryfVuu4hmjFhVcrQ1/hEdLPg7NpZw1LkySIx
         2RdxwXIaw/+JoiLWMSi3bxuO8X7PXlAfWQN4OgY2IvWUTOna7qEpKW5GU/5B96ESygKm
         cm0Seoq1A/0lF+/C0lF9SZkvD86Bn8HVGwwIn6xGuZNylCkWT+3fqzqyrH/OFfFagxgt
         n9b98AgIPXvAy+LEBlsWjkTxOJxJj1SinECUsbHP0Mme9d8lFojnfS7sEfvR9G+34B4e
         pyoz/i+U2KqHJ+XZB0ppN0B8W1Zwy1yrAiQJMoDd7D8zHwTYDmelFiHKTrnkPRmKMzpB
         hv/g==
X-Forwarded-Encrypted: i=1; AJvYcCWy7TkcYjmhW4Gv9HYPtxmZ9V3L/EyRKWDD0ceclbgjfZfUuZkgD2lwgfIkpUC8+tvs0wrs7ANu12qL@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbJhhPfzSEg1stIdEmgFM4Y6w0lPoxJsxg20Z/v4Pem7+5uTC
	3Q/DYSF7VJn7FuIBtVSFu5DSsMtIgSSifTaOOMgo6wsz4vgs86CvZRRQrrmSJvycUPvt+fQqaR/
	kYTb4hcU3GHD+YhKt5WLc2Z4ynmBV0dpezFimqQnGRIe44mryDRiArVYisb7oWQQ=
X-Gm-Gg: ASbGncsH10GeuQfbI+qinm1Vo8lbyuvbuv61TyABu/OWSbBii6kERmtlOoSEqEJ6Hqn
	IO3NaP3eo4KwoL6XB1xUiHuXnnpPlOF4mV+meX5Al5z77zCEgqNJIZoivgwU7U494Ql7Mk1XWpu
	tEjq64BrUetz8zt35uDMM8MOk5kwVCfXX6wDg9PDSh6Wc6WWO9eos1EWKPcbSgztBHyCZjVe433
	BlchONWsaof5WlUiHz1IF04EozGkK2Gnq9PcSg7tglCqgVWu9NJrlaOUwVDAUe/Xq6ioYtumv6k
	aecg8OoyeXvESF6S6Ur58+MMYBqlVVPGjlpezD5FzKqpWsfyn5AIFNJUa8eQ0hEQ1lOgEUFaNkT
	TbHzZsWFbuCY=
X-Received: by 2002:adf:a2de:0:b0:3e6:e931:b3e7 with SMTP id ffacd0b85a97d-3e6e931f910mr5636039f8f.61.1757406712233;
        Tue, 09 Sep 2025 01:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFvsITKaBUrZYvh6g6weJGpHyBKLHpO6IqHhZjtEprYVnnx/USfiBncaI/4OPGMS02ilTbLw==
X-Received: by 2002:adf:a2de:0:b0:3e6:e931:b3e7 with SMTP id ffacd0b85a97d-3e6e931f910mr5636017f8f.61.1757406711837;
        Tue, 09 Sep 2025 01:31:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521ca123sm1717027f8f.22.2025.09.09.01.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:31:51 -0700 (PDT)
Message-ID: <9873f106-0e32-4ab2-a05d-2b17d281e997@redhat.com>
Date: Tue, 9 Sep 2025 10:31:49 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next V2 1/3] ptp: Add ioctl commands to expose raw
 cycle counter values
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
 <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
 <ca8b550b-a284-4afc-9a50-09e42b86c774@redhat.com>
 <1384ef6c-4c20-49fb-9a9f-1ee8b8ce012a@nvidia.com>
 <aLAouocTPQJezuzq@hoboy.vegasvil.org>
 <3f44187b-ce41-47e8-b8b1-1b0435beb779@nvidia.com>
 <aLmQt838Yt-Vu_bL@hoboy.vegasvil.org>
 <1f85b803-eeda-4d62-b36b-8fc84390e74f@gmail.com>
Content-Language: en-US
In-Reply-To: <1f85b803-eeda-4d62-b36b-8fc84390e74f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 7:52 AM, Tariq Toukan wrote:
> On 04/09/2025 16:14, Richard Cochran wrote:
>> On Thu, Sep 04, 2025 at 03:09:23PM +0300, Carolina Jubran wrote:
>>>
>>> On 28/08/2025 13:00, Richard Cochran wrote:
>>>> On Mon, Aug 25, 2025 at 08:52:52PM +0300, Mark Bloch wrote:
>>>>>
>>>>> On 19/08/2025 11:43, Paolo Abeni wrote:
>>>>>> can we have a formal ack here?
>>
>> Looks good to me.
>>
>> Thanks,
>> Richard
>>
> 
> Hi Paolo,
> A kind reminder, we got the needed ack here.
> Yet patchwork state is still 'Needs ACK'.

I was traveling in the past days.

I see Jakub has some perplexity WRT this series. I read that as "I
prefer don't touch it" (as opposed to a "no-go") and I think that the
feature makes sense.

I'm applying this now.

/P


