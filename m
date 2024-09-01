Return-Path: <linux-rdma+bounces-4678-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC538967737
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2024 17:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2CC281E71
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2024 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6A817E005;
	Sun,  1 Sep 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="OZQXdoy6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E3537FF
	for <linux-rdma@vger.kernel.org>; Sun,  1 Sep 2024 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725205475; cv=none; b=HdR3Hw98CXsBRg2kWX/PX9v2fBNvZDwizBsXgMTLFcHgIRegLtsNH5sQHCaTv15EhmHr/8SlcMTErJV5KStQBYiZrgee2H3eufpIPfe/OATbLDaYHeYOcaTTpgAwqB1MxJbkXuqBVWZ1ek1Q2fdIiz7MfGqcWi7cduGFIfMeLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725205475; c=relaxed/simple;
	bh=DczUd06nVT5nIzJNVLSfc6hQnNe6cNY2fz9Yw3hyiaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/VpkVfD20yJ5rlVItNgx9HOFzguE0ZSe13VfwEQ3tgifuDsr6f4ObsvyJG0ClKzsVGs+eX9u7moH5u0yw0hhQiP/jh8xzX2fQUCq5HZs/K+rsuu69Bgsz6KYL7Z/lhvZ4AfrlX//Zy/Z0jJnVKjzV2OwYq2ZYg+hCAlX1+ZlSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=OZQXdoy6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7b8884631c4so1323037a12.2
        for <linux-rdma@vger.kernel.org>; Sun, 01 Sep 2024 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1725205473; x=1725810273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZT1NQWw/ZlShvEGltiI6n/2Cdo57EpJmGnMMIxvmUk=;
        b=OZQXdoy6OX1nqjS592gXRvDLNNQvdNMBV3ulhqV14kxMMnrMlhLUBDYJ8otm32NrKo
         CtbHK4+Mpq2/o0MWykz/acxgxETE3dywOShXFrFE0Chg1at8n6/hg3/bN/bemU7iKKcn
         ka/4udqjW2dmGZCre1f/zpEcpL77s/qCpuVccVtVXnLngbDqAaYJSz53Mm4vNqiShqnq
         rVtWF4/CM65nLrP5BHq52WQBJDM84NanlPFJ+M1RwVhrPy8pVGyQMP/dPuwWQJpLN9I6
         FHnoahJgXu6C7RiqK02RWMKoYEvlF8c5bAkCiXBNqDkQQjtjQJt0VMZkuPDuspnF9BpJ
         mkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725205473; x=1725810273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZT1NQWw/ZlShvEGltiI6n/2Cdo57EpJmGnMMIxvmUk=;
        b=Cw694n8PNoUKPLH5sqhjTw5u4iokcMhPHV7WAb+xl8ZT+gEQmMb3vRMA8xVCoqMn2l
         /jGCI1T08jrNuW2FNeVd53hcARxSCWkMPgVuAmv/Sk5QXMVcuYDbaNRVRpwS8+EBaKxg
         D3kI1TUGz7b0ikZ71jKPxSbd5yW1d6tmOy82rtrnQgA2Losy5uLe5BLX2HA7RONxhK2o
         PvhObBgnfy+u4wVm2qIbI+2hoKWT8LZIgiOY7YJpp54w2a8EAVbvR8lbLDIPwDzFMf88
         tUlOE9s0xBHHj88RSHA0wEGYfW+EQr50GZoffTda/8q5BRCOS4B35txJs7sVjgF2elqC
         hWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0Xkv1gT1FFY0yoFsC/UveOiISN3fFokpaxhvRoMjv9FR+9K5XeT2BQjluXRxUTt60KAhK3RYxIXvt@vger.kernel.org
X-Gm-Message-State: AOJu0YwHm7Pk8fxSZsCg2fGI3P8c5nglRy+L4pcmeDiQ05zOHFt0/3uQ
	OnVuwKbFy1kYm0TxHStWDGzP0zWbpboat/jk9nnp2CAE7vZsf7X8NETS4GaHIrA=
X-Google-Smtp-Source: AGHT+IHA/aUv7MLDKVraJzKMQaRlCyk6sMlbvsm57KXaQwtcy811MRlc0HVoFTScIWQWGzFk2UJNEQ==
X-Received: by 2002:a17:902:f546:b0:1fd:8c25:4145 with SMTP id d9443c01a7336-2054612c3bemr56256935ad.17.1725205472915;
        Sun, 01 Sep 2024 08:44:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2054cc60828sm22314045ad.210.2024.09.01.08.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 08:44:32 -0700 (PDT)
Date: Sun, 1 Sep 2024 08:44:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michael Guralnik <michaelgur@nvidia.com>
Cc: <dsahern@gmail.com>, <leonro@nvidia.com>, <jgg@nvidia.com>,
 <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Chiara Meiohas
 <cmeiohas@nvidia.com>
Subject: Re: [RFC iproute2-next 2/4] rdma: Add support for rdma monitor
Message-ID: <20240901084431.1639ff75@hermes.local>
In-Reply-To: <20240901005456.25275-3-michaelgur@nvidia.com>
References: <20240901005456.25275-1-michaelgur@nvidia.com>
	<20240901005456.25275-3-michaelgur@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Sep 2024 03:54:54 +0300
Michael Guralnik <michaelgur@nvidia.com> wrote:


Suggest these minor changes.

> +static const char *event_type_to_str(uint8_t etype)
> +{
> +	static const char *const event_types_str[] = { "[REGISTER]",
> +						       "[UNREGISTER]",
> +						       "[NETDEV_ATTACH]",
> +						       "[NETDEV_DETACH]" };

Break array initialization into:

	static const char *const event_types_str[] = {
			"[REGISTER]",
			"[UNREGISTER]"

> +	if (etype < ARRAY_SIZE(event_types_str))
> +		return event_types_str[etype];
> +
> +	return "[UNKNOWN]";

Might be useful to use snprintf to static buffer and print the hex value
for unknown events.

> +}

