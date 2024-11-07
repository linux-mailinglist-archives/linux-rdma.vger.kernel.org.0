Return-Path: <linux-rdma+bounces-5841-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE219C0B9C
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 17:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8451F244CD
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E99216A3D;
	Thu,  7 Nov 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="yLlJQshv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D897C216A38
	for <linux-rdma@vger.kernel.org>; Thu,  7 Nov 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996670; cv=none; b=M6mBfRkb1CbfzVDcT/lv1+Sc1TUIbbfHA4n8lK6o3axxOgvyVNEpx4/OHNuTWogw+ChziR+UBwNXJ1lbjuA4EzejbKkeituA87rKn/cU5+JqQmIfIRmlIpu7as9G4sY6qYrysteMCHKl9OdYnY6qfNnF6BxBUPiA1V9bPYoBhLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996670; c=relaxed/simple;
	bh=Wj4fOkQPXhbMAKih4r/Sld5wkvE3/LKYljfOua0Ngvo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imQVEKmLEs1OSrF7BX2EHaudVoF1iz0o3WKCSDt5QM19T5tfKufiOrQ8D54/Wi9SSt8sufrym6YfjESJrhbCcXZxHrsOnOJvdgvwdT4PoZi/zl3/zSgIOgzbvDfcIY/Mq7EMLxJVuW3Hv4RXfICkoTcix6pXTy25yMVdN2zbGbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=yLlJQshv; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ee6edc47abso879158a12.3
        for <linux-rdma@vger.kernel.org>; Thu, 07 Nov 2024 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1730996667; x=1731601467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8yOLzTUzlsG9KWjjsp8XyTHL3cnRzRcNsutj7MGbeA=;
        b=yLlJQshvv+pa9pFYeZEvqoh06SJrOZowUSt6xDaZ3OUjwboAOpQOO9lqTl1h23UTDZ
         W4jCAA9i0U2WapwQdkhkXZlc2C4Q2j13p2G0IHhPksiHiCiUZUAqPya9TtfAOwzB5i4k
         HWlvELT2kZJnc26bnJwVo9gLS5F27zalnd+YZJJcbYpHH3tC1ycRd9Wfc1fbMF14XuwO
         llJiRnNKtKGva8pyejrHZwD+zKLIoFBKIIm8kYTMNHL5cRPbe+vzTm9Hf5ambKenf8eZ
         2cxDRx3A1zy0yv5mWqRsVJiIdSs9oTpxj4igqG6v4fEBlw+1DJw4N2tXvMvJDfalwRHZ
         UGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996667; x=1731601467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8yOLzTUzlsG9KWjjsp8XyTHL3cnRzRcNsutj7MGbeA=;
        b=ePjif19PLJ9udsg1k/y1VfEgM3yzjt3L7aroDh5jVGcXwpgwNpzD/GAeh7IFi9ErGf
         of79Qs6wfmsZa/lfOr0dU6xV28BZG+swMwMDVadZiEKbT8skWkXENtiBIz4EUJnji7Z4
         beBVzeEQH6twceawiXgU4muEkW2z9hyak71erKJf8JSYKSkjh1hz4x2pNVzkWXQEngBc
         wyKEk5fl5FkMFsGmqQD8cRl5lok5fG/H1EXf7Wv4jWVjF3vdA8IkrUJIK+Mj8ujljSH4
         tva8zkJ3tjHGWQnPVU59Y/QnjTjGwCxeWaIEQDYCIKvelGkYb5DA6m1Z2aob0ry4Rodd
         jyXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcvv5jFqUPV9kQedDRZNE+dt7XQPUuquxrO3byhKyQogMFmGwwlksusopnsrc+IGCcV37h6XBRywp2@vger.kernel.org
X-Gm-Message-State: AOJu0YyoI4YsIeWsEzvy7kIHTSP0ne0sIn9Th0VpnrLMlY8okDZ5H07D
	6hWLm5r9y8xzT+g2xWSgoS+idRMx4qIfVxknnflM09DZ1HU0ZlZZ6rB3iHXQlvc=
X-Google-Smtp-Source: AGHT+IHlyVELjNAj2aJjY2JaCe7i+zLzQHpoz9KmkrKWBUeqMW+AT55BigFJRiYbmuvbEeUxhzrhvw==
X-Received: by 2002:a05:6a21:6d9f:b0:1db:e587:4c3d with SMTP id adf61e73a8af0-1dc2057719amr146642637.23.1730996667070;
        Thu, 07 Nov 2024 08:24:27 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aaa01sm1796761b3a.100.2024.11.07.08.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 08:24:26 -0800 (PST)
Date: Thu, 7 Nov 2024 08:24:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chiara Meiohas <cmeioahs@nvidia.com>
Cc: <dsahern@gmail.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>,
 <netdev@vger.kernel.org>, <jgg@nvidia.com>, Chiara Meiohas
 <cmeiohas@nvidia.com>
Subject: Re: [PATCH v2 iproute2-next 0/5] Add RDMA monitor support
Message-ID: <20241107082424.5fa1fa68@hermes.local>
In-Reply-To: <20241107080248.2028680-1-cmeioahs@nvidia.com>
References: <20241107080248.2028680-1-cmeioahs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 10:02:43 +0200
Chiara Meiohas <cmeioahs@nvidia.com> wrote:

> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> This series adds support to a new command to monitor IB events
> and expands the rdma-sys command to indicate whether this new
> functionality is supported.
> We've also included a fix for a typo in rdma-link man page.
> 
> Command usage and examples are in the commits and man pages.
> 
> These patches are complimentary to the kernel patches:
> https://lore.kernel.org/linux-rdma/20240821051017.7730-1-michaelgur@nvidia.com/
> https://lore.kernel.org/linux-rdma/093c978ef2766fd3ab4ff8798eeb68f2f11582f6.1730367038.git.leon@kernel.org/

What happens if you run new iproute2 with these commands
on an older kernel? What error is reported?

