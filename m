Return-Path: <linux-rdma+bounces-11667-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C33AE98CA
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CDA1893787
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 08:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71F8296163;
	Thu, 26 Jun 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXUJPd3n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F17295DBF
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927533; cv=none; b=jouqIxNj2HlYFYtbwMueSGtX90S7IC7hM4U22U8BpQQsWdUL66rqbe2mJtrXA3tbgbB3/XI6S7wutoOs3hx7IqWR/yc2VqbYZZrR+wWQMh0eO86Q6DKu1El3czWkoD062MQr7QWepZUHycWNfa9h/X6AfA937IcVSUma/slOCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927533; c=relaxed/simple;
	bh=TtBYmGz09D1CMPRG3OSGWyOHLjbRQBekiXRFdglC5Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCYNJXWiXKG5n/37nT7L0T/72+hsDC5YB/1JU4UKkhEp35Q5JZuvjzL0jucIQKSawZc1532+X4ZutBJMCDTXjXuaq07+Tu2xOvOn28gJNb55lk2GEICtRohO3lH2Kopa+3xlFOW3BNf724aBeUoq1q+KYH/OnK5LC/kLGQNSfgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXUJPd3n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750927531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cWzGMtcq1CX7XXiip+KlPwG5ITrP6Qiqqd5StDP8cc=;
	b=hXUJPd3nAQAGNON6NuEn9J4rG4aSDRlbu6gPRL4HspGs5ITZCe6XjxMeEPf9f49LX72hoO
	OCCYVk8AO23DSC5VptuzbDrS6AUye9iKxVT/WYn/IovWUJxy4LfVfGf8/xtLlSZFDYrvIe
	t7Odn5rFGy7TRDFEjWyr9dJUX2fH8EI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-q8vyiCF8PWihXtJOSKjtBQ-1; Thu, 26 Jun 2025 04:45:29 -0400
X-MC-Unique: q8vyiCF8PWihXtJOSKjtBQ-1
X-Mimecast-MFC-AGG-ID: q8vyiCF8PWihXtJOSKjtBQ_1750927529
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a58939191eso236165f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 01:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750927528; x=1751532328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cWzGMtcq1CX7XXiip+KlPwG5ITrP6Qiqqd5StDP8cc=;
        b=axV6Lx+JeG+PE8Ry6pMekDBEtobsz0Q61K4pECN3rW0wL616JrWCNFhF7oP3fmmuC5
         wO6WwhgKgr8ipVIiOQHUcxYblnXzWLUqC99FdrXLjn/RW5Bl5GHsSwqkZPb9xW0rHGZk
         tLCFIj7gn5Nq4dCb/GaFIm5eWWg7NOm5QzUw0gutZ3e1qhXR4Gk0ISYqNsEvjaJk19Jv
         KGCTpYvbTfqcyXm+vzXXIJGreQiSBc8+gp/tP9uGJuaUw3HKjImVxAZeNDRSa+VE0nW+
         SvyleunVNaAUXEZvZ/bCcRrOn9BTiGDA/+t/tA4GKleuRT15w0PDWBnZtd1s2fwgAI7J
         JqTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRtJ/0xMCjBxP9RYFGnoaBUdjBQsG+sKJ53wtYamZSyXUNLnRr3uqe463/ul649P7SySNRtGbzJdUJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Rlds5LHYc2q86VrOvD4CzEJ3cxmQumMNVa9NT3iJgF9eC/Cp
	IKChd45Z7Hs1YLIaVL2f0TK/GAdku2QTBL5uC5FbxgYd6ksDQscna9rliWSz/n7xD/e49VoiEY0
	5Y8d3LWdjEKNpUE5VqubxVAFZAN5zBeNsvWIC9Rdg58x0WDsxDNDbh+Qm84pA2bk=
X-Gm-Gg: ASbGncvPfkjuB85u117+Xq2uVeUSg6jgPWWotuhMzCPbTgop32VRY7UQ40uCwPwWmaS
	qehWqPM1Kh2bulBSd1Zwa3FopMOKo9eJEuuTEHcsUHZlM+T/HXM1Kql6q/udK4ZfhNd0tQf+Vl4
	+enmpxMOyPRbSBgKBDghYQkufL/Ou8lSBdPFaCPqlIwNiu3Y6zutGvYlSi/eyiW7a1LIOWEb1Zd
	d6p98aQ8zC/IyJIQtuacUX1bQBF+Q7IFR/nYUfTFC/rxCHZUwgk+7Nmx0XvwAVoClnqMqAvMX8V
	/Xy1vIOqrCmQn0ODG7lXfZ1ZzjZT89XxGx6t0KRSsGRBJF9vpcBMbx6j7ytWT5FoE95oPA==
X-Received: by 2002:a05:6000:178f:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3a6ed6690e4mr5277897f8f.59.1750927528353;
        Thu, 26 Jun 2025 01:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfVGIXnx8DHzz8BcUPW88UwI44879NNMEZ1ofZ9l4yo10/vH91SYC8imFRfdyLgvvW1VRVWA==
X-Received: by 2002:a05:6000:178f:b0:3a6:d93e:5282 with SMTP id ffacd0b85a97d-3a6ed6690e4mr5277871f8f.59.1750927527937;
        Thu, 26 Jun 2025 01:45:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244f:bd10:2bd0:124a:622c:badb? ([2a0d:3344:244f:bd10:2bd0:124a:622c:badb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm42572895e9.3.2025.06.26.01.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 01:45:27 -0700 (PDT)
Message-ID: <182b7c26-2573-40df-9bfc-663dd53a394d@redhat.com>
Date: Thu, 26 Jun 2025 10:45:23 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4.1] rds: Expose feature parameters via sysfs
 (and ELF)
To: Jakub Kicinski <kuba@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
 andrew@lunn.ch, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623155305.3075686-1-konrad.wilk@oracle.com>
 <20250623155305.3075686-2-konrad.wilk@oracle.com>
 <20250625163009.7b3a9ae1@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250625163009.7b3a9ae1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/25 1:30 AM, Jakub Kicinski wrote:
> IOW applying this patch is a bit of a leap of faith that RDS
> upstreaming will restart. I don't have anything against the patch
> per se, but neither do I have much faith in this. So if v5 is taking 
> a long time to get applied it will be because its waiting for DaveM or
> Paolo to take it.

I agree with the above. I think that to accept this patch we need it to
be part of a series actually introducing new features and/or deprecating
existing one. And likely deprecating new features without introducing
new ones will make little sense.

Thanks,

Paolo


