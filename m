Return-Path: <linux-rdma+bounces-10712-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB5AC3A04
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 08:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603FC3B1E73
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 06:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88CF1DE3AB;
	Mon, 26 May 2025 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+6+tyP0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EF35383
	for <linux-rdma@vger.kernel.org>; Mon, 26 May 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748241554; cv=none; b=O13fcAzDG1IVzBV0Q94fRpV1Yk8ZkN8Dz5g2bnIORm12wtGLy36CeF/KTm1IJiCA4xM1dN35S9BkHZDmpPjbu6R/+kjUjC2UlKIRD+MprwJBE0d2UI0ZV9vvytFMJE3E7vh+BpSq4aFmBTDWKjTtT7ioxg4/3bhwZro6Pi6jM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748241554; c=relaxed/simple;
	bh=Ae4tSg4kmOccm2miOn6Vld2T7LyPE4HZAwLWC/VQ3jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhxH+mNmYWU2JzjKTr7dPgRU6M227iN7dJsejYmqa9tAMV7YnNx71uF8RRMx/fJHmBJBV1EspsjpaHRStB8lMHb5pizio4flVCJ2SV0/ftdvG6/cCXwWYmKQyxRdM7x8VYDjgYReXwF0123o8hWyeSPOErMi979yvQvkljKxzyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+6+tyP0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748241551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nm4c9M80Q1z8j97S6rw42ru1/YFOaWVgzS3+rocsC18=;
	b=A+6+tyP0bSve7J177ap6d8vT6Yq+VIio1AO/s/l58Rbx4TvDSgog1PRb9kjxgJhOtFLFfu
	42L6mGoGKJC5kTtXGMa8IQQ//cmU1ldRq6l8+VXj0eJrpYat8yqxaLMQ6v/G4ZofLiPwm7
	vOZQvTv0v2P8RhoNR5V2ALqUhrACk/s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-s-6qFty9NYG0YPL4y_SOHg-1; Mon, 26 May 2025 02:39:08 -0400
X-MC-Unique: s-6qFty9NYG0YPL4y_SOHg-1
X-Mimecast-MFC-AGG-ID: s-6qFty9NYG0YPL4y_SOHg_1748241548
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a36e6b7404so886045f8f.0
        for <linux-rdma@vger.kernel.org>; Sun, 25 May 2025 23:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748241547; x=1748846347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nm4c9M80Q1z8j97S6rw42ru1/YFOaWVgzS3+rocsC18=;
        b=QboUMc3mIWDkK3eWOTFnHf8plaDzzpkVdmW39ejFarxEAqlS4MdceETOoeXtIm/2Sd
         vOcqm+ql093nonxo8ceJQH7jD5vXeKqSczdWT99/ilUxMPnBQR/hlRZ+VU5l/MALu/6d
         n0WJnGKtMc0lXDIWWE6SqMV1+q+YOLxqmHobc2FwokLBMNlM9cwuzii1iYJhR2lfv+OS
         ED8oha60vTqDu1gTq9lcJMDWWQPnfxXnf5aXzc9HZ3xP1je4iEGD8Nxqm8IzORe9dEl6
         rd6o9btOAIUiQ18Rd0HNeFKkvZmmWtDOe6UwUYl699U4gIhBp1UNZBtNqA2sfpmzCuZO
         97sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWZWagPNLUOWpIMCW5nzLS8MiNeF/XCRfOqYDZ2zUz30EljIhTPrTUBjwk4RM5h1GKHNjz1/rg+cL+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz72U/4ALxhjSy2U05aP1gm4L8SpHKBYJF4Fwdu0JvO1sDHDv38
	Ee9eB7Jf1g9U1NIEfDPOAqZ4Ku70yLF6+7oJEGodz0fICwQ9qXbhrpAM0MZitcoiEknOdk2wEQI
	z3skzbJVpxj2emQSssdHAOmHheKQLMI7iBlxCAnl1sRUfm0MH65uZw+rFgDT0TDw=
X-Gm-Gg: ASbGncsmSW5pht6GAs52+nEUUSA8JupWkg/XFvR2qAwvqqUA0LPudBPUruRFw7nTPFa
	dSSPg71kn8jrUJo5ntuFXDRNHTEg3WTdilApE6g+SzFcleCsXjrmHLq6Pgvww2L69LJ1xpDminB
	wQsYM+o+SdIbcC8UZCxipVJgRyErvYCyWRmIyAFlx+NK5FsvSkNvNcQaZ8KepyG9hnMpxUBSG0C
	d4OhZFItM4Sa3D/gKalb+i33k0nMBgJfuZDsmillbJr5ClWEI+EHRTm/WTzbyjNDcheamJx3z6F
	FNMpd2tSrEun4tv311k=
X-Received: by 2002:a05:6000:2507:b0:3a4:dc32:6cba with SMTP id ffacd0b85a97d-3a4dc326effmr712391f8f.4.1748241547628;
        Sun, 25 May 2025 23:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHndZUEepyKYMwEo5a/tkf0IiFhlmHejT7ojvDBOeg+h7FMmR/yDqdIddZzGS2LYqvecgN7Sw==
X-Received: by 2002:a05:6000:2507:b0:3a4:dc32:6cba with SMTP id ffacd0b85a97d-3a4dc326effmr712375f8f.4.1748241547256;
        Sun, 25 May 2025 23:39:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f0552esm223589205e9.11.2025.05.25.23.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:39:06 -0700 (PDT)
Message-ID: <be4c5d3d-f2c9-4a09-96ec-0b25470ef9f7@redhat.com>
Date: Mon, 26 May 2025 08:39:04 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net/mlx5: HWS, make sure the uplink is the
 last destination
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman <gal@nvidia.com>
References: <1748171710-1375837-1-git-send-email-tariqt@nvidia.com>
 <1748171710-1375837-3-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1748171710-1375837-3-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/25/25 1:15 PM, Tariq Toukan wrote:
> @@ -1429,6 +1426,14 @@ mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx,
>  		}
>  	}
>  
> +	if (last_dest_idx != -1) {
> +		struct mlx5hws_cmd_set_fte_dest tmp;
> +
> +		tmp = dest_list[last_dest_idx];
> +		dest_list[last_dest_idx] = dest_list[num_dest - 1];
> +		dest_list[num_dest - 1] = tmp;

Here you can use swap()

/P


