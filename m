Return-Path: <linux-rdma+bounces-14105-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B79C7C152DF
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 15:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B91B71B23E41
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 14:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC215331A42;
	Tue, 28 Oct 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGyFEA+2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24321883F
	for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661897; cv=none; b=CrKTDKOUE0ySgbNF0/HJX1QGbTGcaRsn3l+gpSN2mM/6nKfxLrg2jz1yU5gFLMgs7J6XFB+2OLKY8cDRZ+MVeCN5J3XIm61kcrzrl3qdr8x5ZWFtyb7lSQUlJ/m5ljx0+PrlkP+GP9U9ygliMJcbjdc2i42Qi5sQyDAPc2uWTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661897; c=relaxed/simple;
	bh=lSvM53GFft+J8S+6HgqdJu8eZNoSNRi/6wce+FaPoNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsnHp1lFpWOXfdcDuYGMDoaNEDdkSusf/tKbXy8ewsnqJzKN32Dwg1DHFrhXIhLa9P6A7QeXTzMk32zja2a1o/9WoFwmLCtEpFscobWtgc7QcptRHpY11lGsMot+ahgU4PKK/rbK21VpUZ3VBNWhZ22R3jOwxmeEVxeMjvfiQT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGyFEA+2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761661893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73/xPfC9sPKYuWBDNGOrntIS8v774C/e1wt54BijNYE=;
	b=hGyFEA+2qNou4Kab0bzN/De7BVeD2N4vPfemk2obMoAu5zyolB/b6i6x+6650VKtlxkwPd
	gL6gd7w0GEz5P4SAes75p83y8Wnk4rUsCaKGuGhldCzseLsd0f49LybvUZE4GTnfZFOezK
	N3QOnncFGfdzJzFsmGPtYEHbsJ7AGDI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-80ludj4DMUaKLjoypXuH9g-1; Tue, 28 Oct 2025 10:31:32 -0400
X-MC-Unique: 80ludj4DMUaKLjoypXuH9g-1
X-Mimecast-MFC-AGG-ID: 80ludj4DMUaKLjoypXuH9g_1761661891
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4298955a6d9so4384155f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 07:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661891; x=1762266691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73/xPfC9sPKYuWBDNGOrntIS8v774C/e1wt54BijNYE=;
        b=HS/hnVFgYuqIhXLUkiHZGa51nK6sXchYHMUKfojryjKcqas5l0LQYmFSK5PjGuY9vN
         uX2UyirsIfITNOri9QcT5P5AIDZynovkip6W3567mNg1VVtLKYxsEKbjORjm2QvsrqpB
         lEvbWRpTyS6wiffHTrMCa2MAqHyXPkWr57x46NXIRD2jI4ulhhaLZo81LQ/BILyjR4oA
         9aaKywFyWUeH21Yk6Lusou5VIBYg5GZdnjiwGdkg6GCwbcYjJdvXtTRWUyfe3KTTSc7L
         Vp3fJyRy7KiicQhg4c6lOu96qCv0L3mbh9w9GiYJJDI/UHbaTMCdSKcajWN3w8ucB8Rt
         AsVw==
X-Forwarded-Encrypted: i=1; AJvYcCXwouHvbv/hAiut7V32ykbEVwMqEczEg/l6AKxl92AEG6WFB8eUtEhY8g+hN2jSJoE8zoDkn73Fb56q@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjbRENWzAQfIVz6bdxP3a2k/qyMFmYS69/NZWd6mAalZ9+gT6
	qS/LMBM6uO5V+n67mE54rCKPky+X6XmFnwusn2f9xn8HbQGtQ+Z6IMha+jqXVbWmCYJESFA3uqU
	Y4FkUCQUtdPk7W8e0oJkj2sACumm1c9eYii02i7jUSgtXPiG5rsoooOZQhVL1D+k=
X-Gm-Gg: ASbGnct7Qps9W2NNl08ZCQp0UiXfZC0zDex6mYwlyVqDkPVGKNPQeb3hxCkl7oFXFeh
	crahty84Cd0zB6qQ74XeGsIy6jTnMVSycRTYrUuIw/N2xg4S947t9m/NG9G2aZ8WbuVRNwWa7DB
	FKk5NmhXWph0RwO+LYf0WfMHPMgfPK6dNVUWAgHUPCEmlrLWQyr+/pwJPy1HIu513uX4a7g1IqK
	E5NJbbe6JhQaw8ZrSmlaTYQj5yRGM/ohjNdnj9kdPgLjFVoMbX7udGinJZO4al53wQqyxdKqxOF
	uW0wnZkPFVIgM/eUqcRLwJPLWBFTbz9DNp0QTO9xU0Z+0GLKeslW/XhQvJkXfJh9/XU+UdONhs2
	YiCuEfqDsdc/I4zbcVZVIRBi1E7bXifn2DhXYXWoYvHenkRs=
X-Received: by 2002:a5d:64c3:0:b0:427:928:78a0 with SMTP id ffacd0b85a97d-429a7e9cb6cmr3247948f8f.63.1761661891161;
        Tue, 28 Oct 2025 07:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMOTsGZSXAVq3SjJu/2WS9NseH84hxo6jnqAKfyR6/9FeNPp9QtVjNi6BEGt5SyDkugzoCAA==
X-Received: by 2002:a5d:64c3:0:b0:427:928:78a0 with SMTP id ffacd0b85a97d-429a7e9cb6cmr3247897f8f.63.1761661890726;
        Tue, 28 Oct 2025 07:31:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a94sm24431112f8f.5.2025.10.28.07.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 07:31:30 -0700 (PDT)
Message-ID: <76598660-8b8e-4fe6-974b-5f3eb431a1ec@redhat.com>
Date: Tue, 28 Oct 2025 15:31:28 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next, v3] net: mana: Support HW link state events
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Cc: haiyangz@microsoft.com, paulros@microsoft.com, decui@microsoft.com,
 kys@microsoft.com, wei.liu@kernel.org, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, leon@kernel.org, mlevitsk@redhat.com,
 yury.norov@gmail.com, shirazsaleem@microsoft.com, andrew+netdev@lunn.ch,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1761270105-27215-1-git-send-email-haiyangz@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1761270105-27215-1-git-send-email-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 3:41 AM, Haiyang Zhang wrote:
> @@ -3243,6 +3278,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
>  		goto free_indir;
>  	}
>  
> +	netif_carrier_on(ndev);

Why is  the above needed? I thought mana_link_state_handle() should kick
and set the carrier on as needed???

/P


