Return-Path: <linux-rdma+bounces-13083-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B170DB43CC5
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 15:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619F11C21BFB
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D530301022;
	Thu,  4 Sep 2025 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5S5goeX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2A2356C9;
	Thu,  4 Sep 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991634; cv=none; b=guIN3hx6pyt2/R/+WXlM/SQXhs/olH23eW5ypP7qS7IwraZ7lW7Ez5zQrGEBkQcu8wNp40KBWkXBd6RapmhDjrUbSu9r1NbiSp8ELqJ+VwuTp3XSa7145sEzaqjBsBk7xRCPsLsi0HxNOj7QyZZs7UJUz2IN3/zBvGl1eCZpKoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991634; c=relaxed/simple;
	bh=Bn4/xmGOOXZEWDYkD1BiChxDFd+yskU5Xd81KlPYiO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKp3aANamgAlTGTZnkYV2CdgNBc8iP9Q41q7N3kTbs38rje6sfBDWYhoY9abEIe1df+POOy/xcbkP2oeyWwGKkfF7aRk7n55D9gDt6aIs8ZqGsHZOPuLI/YKxfIG4l2p1IfBpU1ONMfHgGbFKiZeRvUQn90nxSLA6BfdCkV/5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5S5goeX; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d605c6501so10502727b3.3;
        Thu, 04 Sep 2025 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756991630; x=1757596430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LH7LTZA0LFoRV127Jw0yCNL5LEvQmyntlFClrTJFhI8=;
        b=a5S5goeXUO7IlwoPYZEIQ3w714DNdp1Pn6Jq1YIV1bOPNOBPGtVolyKUmDQektAWff
         3TPaWlkJZPG6pRw9axiFshl446R5gcT4zrQf98b2P1rpa2VSoOwbGm5X5PmnJ8c8QYG9
         G3EvjUTlr5HLFrmvuJZUwkENYerVQdR+Qy7WX+yN9V7xaDGWEXAp1HFDItGAPlRhmU3h
         cjesSPrVG4RfRgxNTODBtmiOU+aZuJtpf9R35ZO2YnOeIA/uyWgtI5eKN7QhxgmiUyVB
         P2AC9wCRO8zbBEGZal9fAr+7Yt4L3O9Thn4aXRwaMvIR5XLScINWzZ4KMSoSoEyJj6Qz
         uzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756991630; x=1757596430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LH7LTZA0LFoRV127Jw0yCNL5LEvQmyntlFClrTJFhI8=;
        b=osBcbUdkh6UDFUdYFbd6CK18Tjie41zyokcSZkKkfUlitg67tTXRAKptbBxViu2dBJ
         5AuqaEFuxr2aBGUwelA1Nx2hYQP0762wfQWZNfrgf2OvfD/GQxI2PkgfbS2sgTaB6VL3
         y97/eua++kEeJXGicuOaD8XQ2tRjk9CDtQRFA/DytfhzM0sn6k3gEEOZPwz5btlEQ3u5
         HMH8gwe7X0lyX567gXbIipWHUu4tsPqo9EzcOChcbbUlMM148B4hlNTPoiBMu8fsz9tW
         i2d2epOujCycHnYleXnUHwo9pltWDHX/NuH5Ext1qv7Bo96eEFOGpxQrKUtgOmOWaaoX
         Fhkg==
X-Forwarded-Encrypted: i=1; AJvYcCUk+oycuUlnAmSihfPkYytlFn1UanQHur/H2mgakZuJEzg9vdApSb37u8X31DLtncjAH86EgEblO2bdewE=@vger.kernel.org, AJvYcCWHTfYX7m0Mw15i6rSQnGI7BdyrzMqovC7Zro5i1sZl8b9ttYToqvutFDTJKf4ykHlm0Z+Mwv9uoOhNyQ==@vger.kernel.org, AJvYcCXVQA6nxKp2fx6fPfuVM+t1ucPYdiid1A5xTnivfysi/YJy8ZuBqH53PIhtYtHCDOkTn7PHeYE3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3fyGSzG6nDraEA9p8mXydxIbfcIYdxZ3wqP9P+Bd0Yr0b1N5R
	3Yq8DLOErbLLxuRFSc94zEVvzUQpSTDR0yjfD7gsdqLhxoWYKRdMZJlK
X-Gm-Gg: ASbGnctIA1eXwxUcbSP9dRM2PurnVU8UV+keUntVL2rH9Xg1r43800eCtkzaZUQWYz0
	xsGI8YhbqGaBTU2TcVCzRE2a8e01rSLA9iMfllaM+CjpmYv8eNII+G2iCf2YrMgSeCOrbpHWk56
	QtQdwZMXFt+lK09bKbiikqJ5KGn3ZNZ3xLW7GdFZRc4VaVA8WnM7FHPl6cZntrXBcMPb7ls8Ufn
	R7/5sMkaKhraJcOfbIpGcP29013NqBDvCyrtgE4yKlMmLz1ZVcAaSiME/8BoRM3/O+uiGI2uBrS
	Qx0+Vbp28oESxCyXjWbqXxoPkwwgix1KvFzb9v/L86kcc6KXuNe3H0G4LFthhI6gh5Ym2TGnHAD
	RVJON7M9EENh2x/izgShqyekrKjcQHwLrv8cg3fWGdA==
X-Google-Smtp-Source: AGHT+IFxCX0FPAFrAq7cMJ2jYvzuzwez7IWM1fSRoaoHtERYCHbEqS0gxBnwmzewR6MRW/8N2rzRxQ==
X-Received: by 2002:a05:690c:6307:b0:723:adfc:5a4a with SMTP id 00721157ae682-723adfc8a35mr98239467b3.33.1756991630055;
        Thu, 04 Sep 2025 06:13:50 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a856914esm20965507b3.60.2025.09.04.06.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:13:49 -0700 (PDT)
Date: Thu, 4 Sep 2025 06:13:46 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carolina Jubran <cjubran@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 1/3] ptp: Add ioctl commands to expose raw
 cycle counter values
Message-ID: <aLmQiiwI_1Uvb4J3@hoboy.vegasvil.org>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
 <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1755008228-88881-2-git-send-email-tariqt@nvidia.com>

On Tue, Aug 12, 2025 at 05:17:06PM +0300, Tariq Toukan wrote:
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

Acked-by: Richard Cochran <richardcochran@gmail.com>

