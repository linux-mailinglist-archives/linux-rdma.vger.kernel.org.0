Return-Path: <linux-rdma+bounces-10824-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5545AC62E5
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 09:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824E01BC1597
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 07:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216E24500E;
	Wed, 28 May 2025 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ff6Tt3Wk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DFC206F23
	for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417089; cv=none; b=EoAYCR7vmXnx42b6/EfMKg82/UsNFOd+uK4AlSlUK2f7eIkRtZnCmCqvriv6XCZ3Wn3J0czCP7KTrTbqsHF/ICUa0eNm75AcRFpZSCS0KAvD8fpspBJn7xeKKxAcJ4Kp2lozqj/FLt+TGsTNH2pLOJoXUX/QPZFjyZ6N3orrA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417089; c=relaxed/simple;
	bh=6xJQzx4C9XKRYxfQfKcV+U7e1I4Iv7BNohHvGevc1l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMBmPenUvhDC58y8uO89zquAcT8hl+oCrHEN/0gyiomlCRIYrkeA0FH+7eVjk8FgW4gDcjNOYVSfJeFOF/QUP3JZywc4TpOod+QQIWFEhEsjaceUEGVETg3A0s8YeAelwClxCWsn5qRoWkpIZDH5verKqU9CwKeFavv9MREGB60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ff6Tt3Wk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748417086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XYHyB+9SF/Z+X8QKiEUWQZQ80MVzujdD87l+S5+Um8=;
	b=ff6Tt3WkDfS/WEuuQYI8kxdyNwFSZMOSvcGPDm6CZsAP2i1rvkwkpi6o+K+e2gbjoN2SwN
	/9cqQXQj9Dt6VoK9YwyREchpeDFjjgO/QHRaq51MyX8kiygMhzWEcfuXiW8OdtmeuUMelY
	uzRUr8xqOU1YNPopnODosrZogkDODmo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-l27q0uzLPiGcOKRlj7Vfsg-1; Wed, 28 May 2025 03:24:44 -0400
X-MC-Unique: l27q0uzLPiGcOKRlj7Vfsg-1
X-Mimecast-MFC-AGG-ID: l27q0uzLPiGcOKRlj7Vfsg_1748417084
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442cd12d151so35840005e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 28 May 2025 00:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417083; x=1749021883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6XYHyB+9SF/Z+X8QKiEUWQZQ80MVzujdD87l+S5+Um8=;
        b=k4+i4EQYXbNX3L7MLu5+51CC39eLKZHKqM6fKwEpD6353ZYEB1jEU5pDkZ6g6uL1H/
         e9TkjFDTwTgL9VjIthF1N2LgxwiFGB0uPMMqslcM1p31qLHJoZSGMxO5LPusuXOsdEnl
         qxOqrXwb9PfRzWNaqatW3H45OtxEw7x1d1KBAC05cuhtHI4R5Ij9kmiiqf7WeJBS+zg8
         69Z3DAvehU823ZcpR0hVg03ThpIrN/wZDAYnz6TZU+QLeovaINxsuSZIy6yOiiaXrG9G
         K0QfTwnw6pNE8haVjX0Kh59ZgFT7Ea5vd/v5IRoj7GMkGILdhyRdt9uNQlGjTtUlr52F
         eSiA==
X-Forwarded-Encrypted: i=1; AJvYcCWilBZZID4Tg6JOHwnphW4WCdA4+Mp9J6I3YIDKBQwl/3QO95+SjwT5lxbMIiKVRqwdnVBz0b38Qevi@vger.kernel.org
X-Gm-Message-State: AOJu0YwhheOKbOIAab8hOD9ofdSqNLDBnkTj/HbyVROiWw07WSXW40NP
	LigEfencCcwAFlUnQ1Ex/sCJg/1ddt2ShtU7xXW/93v6hmWD8/J1m7MyJTMZJ5gLisd7n0HTF6C
	6dxehvAXLjWksDTaCxVvc3/BxSdJdTuCi4tRB5kF752+hxR8tfyR+FYO559l2J5E=
X-Gm-Gg: ASbGncuKk4nJ9yAIrEj4SHNiLlV0u2pUjv+CN1sBkbqbe+hWa+xnbFxAP8CUfAxNTta
	dYORSo26b/0y7lxCosuHZbfGS6lUSVeu1JTamSdljB/Gx9t/d2D2WxiRvZ17FL6vV1Jfs0qKETD
	6s5jOCbF6Q5Q6L5V+PcTj8yvEbKuCRAovP1n1wt8fssICeaoSZMJI6wzyTlc2P0BUtqpG9zCJjU
	j+22l6DtGm3yDDah0+yjFrFjGLu33j3Cxr6UeIr4L2qmnfj9psYlG+GnwKV3ja3EsLMDnNglAAK
	Y3Ahgu1AideJiXn0GE0rTKaO3cxXIR1eyWtUHRumeIPjU4F87pW4ayNonRw=
X-Received: by 2002:a05:600c:5618:b0:441:a715:664a with SMTP id 5b1f17b1804b1-44f840b38bcmr46892645e9.20.1748417083451;
        Wed, 28 May 2025 00:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCqE1uwRo600JGmvrx2hbwcJjRSG8+fqxy1BRdw24yujy5GkHaEMyOu3ekjIht4ITlGdwQlA==
X-Received: by 2002:a05:600c:5618:b0:441:a715:664a with SMTP id 5b1f17b1804b1-44f840b38bcmr46892395e9.20.1748417083030;
        Wed, 28 May 2025 00:24:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064ae775sm11977185e9.22.2025.05.28.00.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:24:41 -0700 (PDT)
Message-ID: <dbc34cfe-c788-46bb-bd26-793104d887ab@redhat.com>
Date: Wed, 28 May 2025 09:24:40 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/3] dpll: add reference-sync netlink
 attribute
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jiri@resnulli.us, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksandr.loktionov@intel.com, corbet@lwn.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, Milena Olech <milena.olech@intel.com>
References: <20250523172650.1517164-1-arkadiusz.kubalewski@intel.com>
 <20250523172650.1517164-2-arkadiusz.kubalewski@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250523172650.1517164-2-arkadiusz.kubalewski@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/25 7:26 PM, Arkadiusz Kubalewski wrote:
> Add new netlink attribute to allow user space configuration of reference
> sync pin pairs, where both pins are used to provide one clock signal
> consisting of both: base frequency and sync signal.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Same reasoning of the other series, please repost after the merge
window, thanks!

Paolo


