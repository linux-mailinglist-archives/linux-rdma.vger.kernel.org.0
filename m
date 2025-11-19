Return-Path: <linux-rdma+bounces-14626-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C84B1C716C7
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 00:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AD2E2349825
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 23:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF5032B981;
	Wed, 19 Nov 2025 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Lt1gjpav"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5C28507B
	for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593910; cv=none; b=IRScDUGlfspOX/O8VM2LHNSyDxjGSgjhAd1HPi33/W1P1HDShPhkNoNFHNInwcnIwYDlWY05z3P2pY8aL1wreoHrkSNsjllsQMkhWvBvQnDpqeyb+BAWT/94SBzwsFfSr4/c377BO7bLviMXxyfNmOB9Mtl7nntmiNShZH8Hhmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593910; c=relaxed/simple;
	bh=B4ogaSzeCTEfO2fyf8QMTYxTmdo61Vz7PJm9iZmEd3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6w/l0LNO43k79hWkXo5pwjZSyUyiwGnzLcvb/4/Ee6G/emK+rD1lQjsjwNOEvEIZcR0zUciGgPyPLq5DurxNVil6O0UUFv1xRUDfvTgMuImb5MrsKuF7HfY7k/SpqKDF2IqUijs4p1VOVDb3k8bS6XWlA3bln/9s9Rx/TQYr1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Lt1gjpav; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so385337a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 15:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763593906; x=1764198706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZaTR1bnryMwBTD6jnnFcRa6YP7RbWnYcC+dF48Y8gs=;
        b=Lt1gjpavpSK9inte/G57cwm4PSwPwttll4e+ymij3cyrakoFzX5zF+cp+l0Duw2unE
         Cj9YFP9FCAa6UL+1/iZCK4/U1HfDG8KMkkQFEWfA7LD1ZF0CHRoMFoX+wf2W2gkqNOSr
         baq3Jr8PZC6S8u47xPkFKIYIJlCGbhJHPK6xTeqzSx8ojhjE3YGndy+mljtrna6ezvl5
         wOMrQah3zr0jrP7SlN2OC39R9K0P9FW7TU6F+rAXBFrBzC05zC/ASF+OjJmh1qoahNX8
         XdhULDXE5nKDPxTooC340LvRvgbXlf5s/rs+yKg3nTTjdpM0HrZQHLUpF54qRCekB4Vp
         qFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763593906; x=1764198706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZaTR1bnryMwBTD6jnnFcRa6YP7RbWnYcC+dF48Y8gs=;
        b=m/SWleXcLiDhoJxrheVy3XBgVk2TJg1uyLpOoV/kjnGebYEpFCFbIvTu5r+3y7DduB
         Chx/ybbIgFE48ju1R+k7sIH2sdgWUvhaFHGF8ms23qXSCpmdu7IDeQnk6+aKHkRwF9a0
         2LxDLmmuJJeWw4pYksOpsc4mqwuJu/YxHHHKGYNMDApVN6o6esURbKECKfbninwAqwrZ
         zMWFjfCXpNdPS4DjF7WpdYooGklWUfTTW/5dFz/QRckFkvh9a4BcpGkqUaVQSh+zCfvz
         V5p8f3on34dLwT6evoeZhPtgYIN9xai1FSfbFHNhGqCVRhAedwA4jEvhTmVss1+FraUY
         5pcg==
X-Forwarded-Encrypted: i=1; AJvYcCUpPdnEafrs0tOF83vZPnbpAwfJTsLmrGPYx9HikVsGwJH3TteX8fAY8eEQwRbjk9EtuIgX1zEFfPPL@vger.kernel.org
X-Gm-Message-State: AOJu0YznPEYvV1Z3CBeuxBqKPJvkQGUoZ9DJhIkvPQnLmtpu9ampwheE
	I3P8QFxLAS9+12xJ4bflIFUmHuCGT/VcaucWuPWRX6c+tm98jHBtYCFQ6H0a225DOf8=
X-Gm-Gg: ASbGncuFR6Fj0TvS1WJAqr2slr1Yh79LzU8CeeUTpkPJ9sblNl3u40Vs9V+N2b2kuwV
	lCw+WPC8dbC2ElpmJ83DvlMSpKUP1neB7o+gQaRsXa8q07G8LLAu1yBUgB9kHFhyV9+umMwF0A6
	5w23n1MzDnRevZjzykuUlJdOqBQ2253tdAmI8g453ya6x1eENYgeaVEVCvWJNCHABg7/s7RJLQ9
	R1ycbQtuBzcu3YUpr9vR3wBkxIRkwpMBYI/9/kl5MkX1JnwCkqWfkOW5vBpwiphnR/loKPCtvNn
	T9L4NOCbsxDqOSdYENGKa6IDd9Fe7o0Ix6Yc9EEBRVzJs2FEI4z/YW03QNHmhUyqzg0S7ECFUdu
	MPhyjbXIyM5NL6l9dbJvwt7xvV+STKcZkBCAewLxFHb0dzmmiUIbPb+t9p4fi172AaInMNiaEFK
	s4sSQLFPhHFgIdcyh9POtWAkDZHtl1n3QOtRD9
X-Google-Smtp-Source: AGHT+IGsbJFAHX8SXEuf70GC/fdHzn+3vcHUS7IST+d0xdlWSQsiYTr0gIPPSua8jakHdIJ/TGNUrA==
X-Received: by 2002:a17:907:2d20:b0:b73:572d:3aff with SMTP id a640c23a62f3a-b7654eaf8c8mr99610366b.35.1763593906003;
        Wed, 19 Nov 2025 15:11:46 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b7654d80665sm54469166b.31.2025.11.19.15.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 15:11:45 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: tariqt@nvidia.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dtatulea@nvidia.com,
	edumazet@google.com,
	gal@nvidia.com,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mattc@purestorage.com,
	mbloch@nvidia.com,
	moshe@nvidia.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	saeedm@nvidia.com
Subject: Re: [PATCH net-next 1/5] net/mlx5: Refactor EEPROM query error handling to return status separately
Date: Wed, 19 Nov 2025 16:11:15 -0700
Message-ID: <20251119231115.8722-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <1763415729-1238421-2-git-send-email-tariqt@nvidia.com>
References: <1763415729-1238421-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Nov 2025 23:42:05 +0200, Gal Pressman said

> Matthew and Jakub reported [1] issues where inventory automation tools
> are calling EEPROM query repeatedly on a port that doesn't have an SFP
> connected, resulting in millions of error prints.

I'm not very familiar with the networking stack in general, but I poked around a
little trying to be able to come up with a meaningful review. I noticed that in
ethtool there are two methods registered for "ethtool -m".. Looks like it first
prefers a netlink method, but also may fall back on an ioctl implementation.

Will users who end up in the ioctl path expect to see the kernel message? In the
case of users who run "ethtool -m" on a device without a transceiver installed I
think we should expect to see something as follows?  (Is this correct?)

$ ethtool -m ethx
"netlink error: mlx5: Query module eeprom by page failed, read xxx bytes, err xxx, status xxx"


Thank you for helping on this issue.
-Matt

