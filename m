Return-Path: <linux-rdma+bounces-11790-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAAEAEF271
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 11:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F433AF16D
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730B2246784;
	Tue,  1 Jul 2025 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+gHXcV8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527CF260590
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360579; cv=none; b=KxrM+XTjtmTR/sy6ZR+i6oWFiS3DUg0AZTkDdLPlm4tbvPZPtY5xgiEG3CU1gA+Jl1LVd1I3afZBym7HlxoMQDJyVrlV6Y+0lR5LmI8Lx9LV1GtnWKMlxj8VfqixCN34kCGJDvNHGOeQNq62t0iSifro8wHFwVriajfUeOSee4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360579; c=relaxed/simple;
	bh=1CRUAXr5GBbRdmumb0+cV0Od7MCxxqW2fhnqqDHHk8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxDYgVOJqxcs4ejrNr5V4VIZ4Er5seu+PNeZstB8+OhhrpzInGUcJ5eoLwlU3BqVsEnN2AvrCx8/w62jeNWxLtz/7SU3zm9mrJSKUjI3x0yFNlNGMsWwYiwQ8zzntQ7ERB64E84ZtkWBIzoFolevVU0ELC3sDAm1EBSpgJtVkcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+gHXcV8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751360576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=odFmyP7U2sVYXt+ILmpIyMRKTHdQ4Z+Ben4YpGt3RBA=;
	b=Q+gHXcV88/pQIu1kcI4uU1ZtbqLwG6jQDQw7WkWsAtQgFx6Ftg1WbMqueMTf7Kw2EiSOJM
	1kCyrQKFST4ByxR6QRkZOQMc9SWFVpBuzrkpF269h/VjfptgJJi3KwXYwcK6+8+HWOyEdo
	ikpEsIXlJUHIO56Q54iyNKaMUFQ0f0c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-6YzGq9mRNJaKBioVnI0Y6Q-1; Tue, 01 Jul 2025 05:02:55 -0400
X-MC-Unique: 6YzGq9mRNJaKBioVnI0Y6Q-1
X-Mimecast-MFC-AGG-ID: 6YzGq9mRNJaKBioVnI0Y6Q_1751360574
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so3450809f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 01 Jul 2025 02:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751360574; x=1751965374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odFmyP7U2sVYXt+ILmpIyMRKTHdQ4Z+Ben4YpGt3RBA=;
        b=LkFJPcjEQ7rv3dwn2vdfm2uQQuyzx4niF6J4mV4Y69q9ydmeN/ygR9hLg4XAceSG3p
         yHJHd5YOrw8wIGbZemuMkwt5dXbTftFIFx4cqLwPOGyYC0KcRrig1gqKY+xdCmStINlz
         FZlIu5WeHZaKwIeL8jadR8vEC/Cj0P9zNqK0fABeLxf/3B9YckvsV9oi3c0f8eK8u888
         qR4RxZHpStlGH0BADFwINKBTTwtSZDhd7zmaZXl4eREmKkBNX6P+OZRD/XURR+//25CI
         F2xg9vDy785wznfesnT/fgx70eFgeo4gF0B9LigJdLR8QA9FbmuxfL8++kW4o7zKSd2y
         p5vw==
X-Forwarded-Encrypted: i=1; AJvYcCWP34pI3eIKVZYjJr+jgHdfFJHtXWy301CxmCb6ewzLf/hu0upxPFa2OoQhZv45WgLhw6BjKQFe6aSZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnrjaXfqd1dncGFPCahBZXwFOsDPlB6PEDr3IrRESYnhj6/HP
	YFsG1pCSOmaf50ncJk717FLnZxC8qdqTQTFwRET6HcJEiv2ZGcqEkH3pnvVriERnMfZ3EJIDnak
	lksYw/q2FXNyj6jBNe9JN2rPUN7GS8Z+SJTDcfBvbp3VdObF70DKnmJoK5JKV+MU=
X-Gm-Gg: ASbGncu27gQ879Tg6oCsuX3mVPiYJnpeo2Z0MCZ7bfGSVLFSY3KRoqq2Hp4KicQ+INR
	ZDLGD9ERXGgz9J4AkxMbjUcZcjcCixDURinn3n63+W5jUwxKBHQRlUfr0EAARJGCHKulB+WZHRq
	1gw8TOg/dpVJ0k8kUnJQdTXnkNBnp+2OYLikuleOGeqya4XXSMKXeL0npshw/bY7OQqrzeo2v0O
	y5YQ58lB5ZFFQLuswUOXRKD4TuGq7uR3xh2yAJDAvLykJdEFTcLIZBZCCaqeLXgcY6LiHFowSE9
	yqa94xmNguVtoz2OAtoW3duY3XCWJ3e9EnG/rkOpfZKjJBFU5n+F9fY8yFssBOB+/jl9pw==
X-Received: by 2002:adf:f6d1:0:b0:3a5:52cc:5e29 with SMTP id ffacd0b85a97d-3a90d0d7317mr11929800f8f.7.1751360573697;
        Tue, 01 Jul 2025 02:02:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYRKtwQ5aZnc0XqPhfEJjz3LC5qLMurZ/9vUE7Xlx2VhB/BrreyXJkwS9hDRJ79YaRjeUeIA==
X-Received: by 2002:adf:f6d1:0:b0:3a5:52cc:5e29 with SMTP id ffacd0b85a97d-3a90d0d7317mr11929762f8f.7.1751360573210;
        Tue, 01 Jul 2025 02:02:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247b:5810:4909:7796:7ec9:5af2? ([2a0d:3344:247b:5810:4909:7796:7ec9:5af2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4064b1sm161825945e9.29.2025.07.01.02.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 02:02:52 -0700 (PDT)
Message-ID: <c405f957-0f88-4c88-98d7-3a27e5230fc8@redhat.com>
Date: Tue, 1 Jul 2025 11:02:50 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/9] net: Remove unused function parameters in
 skbuff.c
To: Michal Luczaj <mhal@rbox.co>, Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
 <20250630181847.525a0ad6@kernel.org>
 <beea4b9f-657f-4f98-a853-e40a503e2274@rbox.co>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <beea4b9f-657f-4f98-a853-e40a503e2274@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 9:27 AM, Michal Luczaj wrote:
> On 7/1/25 03:18, Jakub Kicinski wrote:
>> On Thu, 26 Jun 2025 10:33:33 +0200 Michal Luczaj wrote:
>>> Couple of cleanup patches to get rid of unused function parameters around
>>> skbuff.c, plus little things spotted along the way.
>>>
>>> Offshoot of my question in [1], but way more contained. Found by adding
>>> "-Wunused-parameter -Wno-error" to KBUILD_CFLAGS and grepping for specific
>>> skbuff.c warnings.
>>
>> I feel a little ambivalent about the removal of the flags arguments.
>> I understand that they are unused now, but theoretically the operation
>> as a whole has flags so it's not crazy to pass them along.. Dunno.
> 
> I suspect you can say the same about @gfp. Even though they've both became
> irrelevant for the functions that define them. But I understand your
> hesitation. Should I post v3 without this/these changes?

Yes please, I think it would make the series less controversial.

Also I feel like the gfp flag removal is less controversial, as is IMHO
reasonable that skb_splice_from_iter() would not allocate any memory.

Thanks,

Paolo


