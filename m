Return-Path: <linux-rdma+bounces-9537-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40F9A93019
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 04:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7591B64DB9
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 02:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E18267B9A;
	Fri, 18 Apr 2025 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcFy89Dy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0162638B2;
	Fri, 18 Apr 2025 02:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944166; cv=none; b=rEUrqrfeiLIvP8tUFE+CbaA5tgFkERcyOVnPWD9Gs0w4bueKisocJQaR19DkENPsVhOsSKh1TpepKjp5k7T/1k6GhVOuRNwbBgJAY+CtG5tY6EJttLb44/lKtgWYjEx2rdMxuyryU4tlGFgyxFBuKC2w6F0RhCUOjiPvXuSs6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944166; c=relaxed/simple;
	bh=vCR/txIULWnpJdYgJcGl2dcE/ZHWqbNMeCvb4Pa2QEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1qxfT8+v++uOsSw6lZXZG00+tHyc8FhnHqtY/fYw7ApGtkruS+1Tj52Zj+P5LY57iQefwHAlhZRmHS6ecTBkTMAFiMq7qw1oxPyZzhQ8Fyp5N75ISb1wS8UCkG0eYXDV0oF60loj2ZQ3WLJns8+X0BUJeQpNNmMzjShox9qadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcFy89Dy; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-30effbfaf4aso14854951fa.3;
        Thu, 17 Apr 2025 19:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744944162; x=1745548962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vCR/txIULWnpJdYgJcGl2dcE/ZHWqbNMeCvb4Pa2QEU=;
        b=hcFy89Dy4m+wqXZejh1A4f4uHvf6YnyieFR/FAeej3DJTxmsDjeXKl4Md3YzhDTkKM
         xV9+oMiHdXryRr05pS1GPB66wlqnMXLt0xT+VBPcJh5e6r0BLKHs9liUdPvRAKpR3dz8
         pN8UN++GNqpFidpZAd4W+kA0qd0yFI61j+4lrCuRYxmz6gbAdB4ZYdA8EJbLz99ZzVDg
         gVmB+YyoPWy7C3/x+SSj9h/JM8nZ15eg+sxRrRuGFCscEckv/1TmEmhL1Leg5dN6ODXw
         4QMQXTtAmaWkvgEs9HEynZYx+rY8Ds7eH31s7IZD9OlfsnZZYZ1xwQqxzV5uWti7d3HU
         sdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744944162; x=1745548962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCR/txIULWnpJdYgJcGl2dcE/ZHWqbNMeCvb4Pa2QEU=;
        b=W49q+cC1RwJwiMa5Lq5HJDZG8Ufw44UCplSwtma2Tsqym/IAwP8FLntZ+1URQyG6Jm
         KgwgxIYo5ZSaJ9OxWpRdJXmlNzSH5CulzMZEwVeAtPpQ6LFRRjdAVApjLTDaAoCMykH7
         9me6gGlPjRmJ8wmcyo6X2IQygyYsIZeKV8U3kyVy4dBp7gqTmUwVoFwQuIS+/f+daVJQ
         oKo4Khcaq8xAZ+0ZqXUyrUBLEcba4snKvMoOeUj68jwt3E8NYUkI723KhRXRPMEeZ6Bw
         ojyaDELOLjVUWhPzfc33EG9/sBQxlVhmcqQV5rj//SWh7JAaoezWM8HhMjdl5nlcx252
         2zuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHxHBggQngmqqah8p5dy9FNIRhkRLnfps66tijccHSgha63MimPPgmEA/zDuF7qtWp05Kf+Eh/@vger.kernel.org, AJvYcCXnx0CuvVKEZJiup6T8NfcRwuBptNWb7H4lX3BuehHU12zbwNUrxDFOr0ifugOlcb5gg1lr2OA3m9IPMg==@vger.kernel.org, AJvYcCXpA9OmhL1Z18MhqnG/PXLaavS/oU0nl6qZaw/rpmjbpvn/FSCwjd6WMGXPTZGBCQL/+KHW021gyaaBUpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwXKfn6tVoIykic5aJRb+RRJlYlMLHQs7aRIyE7OFUyJBJZtSL
	PnwjaqLnb6fz5NYy/5sWrWoepyeJGtEkgF5Il0pr37zYAac6iTS1jaecVv+sJ5hK4zgsRC85X/p
	KyOg2yOG+f5z6PrC9CDiTovUt6Ie9dlftzwEWBdzP
X-Gm-Gg: ASbGnctHkjIfELsWSEgsUNlAdgh/A/gjuszcJ+CfTWLC90O1fiz1rx3y+N/JzUX5bl9
	m/KJ68EjNgjTXxR6Wxq7eM20oa6eFE3a/LvSW1p65jBkXpIMMLSHXhYDd8ezAN9SvNoI+9EOHHZ
	+BWrp6RmnaMYwjISgNJZXPng==
X-Google-Smtp-Source: AGHT+IFEcgZP6o7kgqV2a2nLZkb68A0xRAIqaJpeLsSwKFNGfcH7MsfTkcVH5j0idw/Lai0/XP3hxkoN8nRq68PB2AY=
X-Received: by 2002:a2e:bcc2:0:b0:310:8595:7a60 with SMTP id
 38308e7fff4ca-310904c64e5mr3417951fa.5.1744944162045; Thu, 17 Apr 2025
 19:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416092243.65573-1-bsdhenrymartin@gmail.com>
 <20250416092243.65573-3-bsdhenrymartin@gmail.com> <817d5a9f-63c0-40b2-8e97-4a29185c0455@nvidia.com>
 <20250417080422.6a22ff04@kernel.org>
In-Reply-To: <20250417080422.6a22ff04@kernel.org>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Fri, 18 Apr 2025 10:42:35 +0800
X-Gm-Features: ATxdqUFjqkCj5sFr45-WGuw2jtT8EQMI9lhJK3EB5blO0heLfWj6U4s_Y9kX288
Message-ID: <CAEnQdOq=JjJRogysZSQho4yAH7WFAyGbCQhXjJFV1f--TArNRQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] net/mlx5: Move ttc allocation after switch case to
 prevent leaks
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mark Bloch <mbloch@nvidia.com>, saeedm@nvidia.com, leon@kernel.org, 
	tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, michal.swiatkowski@linux.intel.com, 
	amirtz@nvidia.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> A bit hard to see from the context but I'm guessing this fixes
> a memory leak? We need a Fixes tag..

Thanks for the reminder. I've added the Fixes tag in v7.

Regards,
Henry

