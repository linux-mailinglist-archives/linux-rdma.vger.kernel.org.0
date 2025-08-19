Return-Path: <linux-rdma+bounces-12815-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AEFB2BC18
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Aug 2025 10:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D105F7A8F8E
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Aug 2025 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34AA311944;
	Tue, 19 Aug 2025 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yt4PjlWN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3734C3115A7
	for <linux-rdma@vger.kernel.org>; Tue, 19 Aug 2025 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592989; cv=none; b=AD55DAk1Nm/i96QuvpmlmmiqgDMyW1Pnl1GVDIQZ/ccmY3dp/0RQ2YwH6BkXidVvGCpjIG+Hx3B2bRKSWPiSwoeAmvBwi2UT8ImHcOmHBlV3lRdZ2tA6YVfV04w9U04TGZ+cemYaJKm013100MiBtmA9nC9LGTy8i0f/jYFIqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592989; c=relaxed/simple;
	bh=uiXQE0NRvooKnb00ZyDFhzitwmlzgW0GBH3yhlrAOPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUVhbNjxjsdo+DgqOofQFF8Prl1xY4UfdLbN1P6ybTkBTPHo4BRrmC0Jlce4N05LXy7g5ZbSwJ91h6xlkEzQ8Df+FJ5v4k2ygOpD10UfSbq71WRdqC1hy301ESsgLFFTRCD/CJNCQAbGplOfoGSN7SqmpBvbhD98kbnOU1X7x3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yt4PjlWN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755592987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nj9EkvlpuR2O71TRrkQ6effPG9eafUyoJmenDbBRkkc=;
	b=Yt4PjlWNTR33A17qSKrH/TVis3t3b//Nqh9rUTDOS1iF0b/a1nydLY1SPlMtv/z6eSECqw
	y+4KJ+KwFeWAO5a345R1WutrYy+LdLgu75ohWXhpPTSl3lTySfG+dFfc+XR6hF3nmshw9r
	iZflmXyzZTkOvfQA2c0Qm4oySpFRU2k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-HXVBMq0eO4yBPlgokd-KrQ-1; Tue, 19 Aug 2025 04:43:05 -0400
X-MC-Unique: HXVBMq0eO4yBPlgokd-KrQ-1
X-Mimecast-MFC-AGG-ID: HXVBMq0eO4yBPlgokd-KrQ_1755592985
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109be41a1so228147791cf.2
        for <linux-rdma@vger.kernel.org>; Tue, 19 Aug 2025 01:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592985; x=1756197785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj9EkvlpuR2O71TRrkQ6effPG9eafUyoJmenDbBRkkc=;
        b=Ro5zB8WOt5lQ5vY/HnBc81dnJVzX9cF/acNVbLQbR77N3X+jFZP7HnddM2BsfHYDMu
         G+YgJNC867BlenvYtNDNJ0CK5aN2niFGvIJo9AGolFqYSkjQSd/vfYlKTzTyn4tBgFcg
         U1+AjF0xmSFPFNz8Dkft55kQpUw9Oqr76xI/qke2hnDfzOLUhUrFgK80zSwtNaaddFMA
         S3QoWmO+UgPY5lexZeyFBM9bIyhDAiR9dbuIyO1IaZZZZjc1vUzHsE+Mxy71OAN9bmKl
         vD2ZxVUcnAmxqY+P3V6/8uuD46F2eKAyHIrbBm7De+Yrynsq9YdTXHh6ThaC98phBbJq
         kbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9HKyyzFg3NEz9S8GetM8if559MQ0hwzie3xbTV24CJ8DZmrfb6jsdAWBV8tXhr6yEFqJJYXQDlKYs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ESD1332jwqJzcqRE3TYGknAWIVFNlE5zR1wh/3bTCJTNcmxI
	KBHYdbIddFtXYuONqB6nZl4bZ6T4+AzdaUK2xUsRBHbkFHUBhOROdXeDoCU3vvPHFsJ7LXshABC
	4n2B+sEKngLAGgfeyEFqi7co2iNu9l4rBSG4eqS/94cVF41HVurY5uyfaTL6308vhG/fgiA8=
X-Gm-Gg: ASbGncuDckMomhSy4tURhuYkQqR7yTgb4YTIYpfV997L86BWQwp8OvbAwhBKBFl0GlY
	AAamVMHQLipH/3QgTSklJu6ZlVgu2kDZKLTXxPzVyTEkdfNY25cvnl63YACayfZe6flw3bwLf3f
	EQoZSJXGWoC3buEWYyZLEc6GLbNuVyxyvMPRDv1Xtk8a26tgzu6GhmuL5PYENAHgULWvSCoqO7P
	HkIsu23mWcm9bx5oWhuUN5M+Cbj73ZJpp7R2ZSULffNOy7raaxc3f8ChULLC9mvqZhpOsGIUUf7
	dGC07dbc5o50/lwfxbSoCqiebMoTvJD4kAdrVVGKzRubxN2sTvD0tJYqXvcF1udEOW/vOFN9dt5
	/TXwkrc1AgRs=
X-Received: by 2002:a05:622a:4d03:b0:4af:1837:778e with SMTP id d75a77b69052e-4b286d9f7ebmr18161781cf.31.1755592985088;
        Tue, 19 Aug 2025 01:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw7UB9FBrpGjQ2XSRXKjMIthoW12C3rhlMGUbObj2mrt2S/t/HnOA8M/IRXI4lKNYc+qncPA==
X-Received: by 2002:a05:622a:4d03:b0:4af:1837:778e with SMTP id d75a77b69052e-4b286d9f7ebmr18161561cf.31.1755592984715;
        Tue, 19 Aug 2025 01:43:04 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc19631sm63346241cf.12.2025.08.19.01.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 01:43:04 -0700 (PDT)
Message-ID: <ca8b550b-a284-4afc-9a50-09e42b86c774@redhat.com>
Date: Tue, 19 Aug 2025 10:43:00 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/3] ptp: Add ioctl commands to expose raw
 cycle counter values
To: Richard Cochran <richardcochran@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
 Carolina Jubran <cjubran@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
 <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 4:17 PM, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Introduce two new ioctl commands, PTP_SYS_OFFSET_PRECISE_CYCLES and
> PTP_SYS_OFFSET_EXTENDED_CYCLES, to allow user space to access the
> raw free-running cycle counter from PTP devices.
> 
> These ioctls are variants of the existing PRECISE and EXTENDED
> offset queries, but instead of returning device time in realtime,
> they return the raw cycle counter value.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Hi Richard,

can we have a formal ack here?

Thanks,

Paolo


