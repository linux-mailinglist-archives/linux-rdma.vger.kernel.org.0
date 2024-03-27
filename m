Return-Path: <linux-rdma+bounces-1589-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8231D88D37B
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 01:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E88B2355C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 00:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE59517740;
	Wed, 27 Mar 2024 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UezsQDLg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB0F4FB;
	Wed, 27 Mar 2024 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711500436; cv=none; b=KZrMYUuRTTOGVHvltL6k9USnDR2VF6bsvtlddvVpTOwuZa3qzVwgG07wV/s+U8QDgqrC8Ms/ZkmBEuO1sotpYmRu7aLa/qLY0m9jcwikM+INqT33eL2gziymfy4J6xp/A5RRzE9dFOpUbXZ30uM76hrQ8MZgf8gFXE+OI5URSyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711500436; c=relaxed/simple;
	bh=2q5crH4HwBtEVMAdw9c1ugeNy2Oyqk30hp+EirVO3q0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkWMNTzbZfTgA/IEK/JK4+B3v+mSz4F4UIfx8jWMKdsdXRYM468WolThpJmZcjldQiYiJ6V404RZu7IVIxEvecn6uZ5hlm61RPXIxMnleGnLxuMfGp/TnnNoplqsZH1bymKTDlsOWOugTIC/5Ldq1Xneczg6q9NQGyW050/URjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UezsQDLg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EB0C433C7;
	Wed, 27 Mar 2024 00:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711500435;
	bh=2q5crH4HwBtEVMAdw9c1ugeNy2Oyqk30hp+EirVO3q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UezsQDLgF9nL66A4jsvBTDD2EOr0eqDdVGhmNGprFvTwmA1eJHgPOWS9WJ7ECimcd
	 RDE0aan9K8Zg8d9M25lbWh96ZCpZ7y0mP+R19goxTSdH2JUd8JcPPdRW83X8rI6QM8
	 MJUThd//pIxYMao207aSg2QzHNfqWYJLPbB+dCwBN2EVPijRRPNUhHocfcqdZVwTSk
	 P3meIA4B8q4n+12qJIk0cKVZsdNFWx3sQ+EkouWPRC+ZdDc/jHiwushF/bhTIdgyqo
	 iwYU8SW6CRg3wKHM6DqpqtfSkZUOfF7qjVM0qmdXWxlmO2PGuFkWXuQEEE+muZ3xGT
	 sSHlZk7LNCyaw==
Date: Tue, 26 Mar 2024 17:47:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Ariel Elior
 <aelior@marvell.com>, Manish Chopra <manishc@marvell.com>, Hans de Goede
 <hdegoede@redhat.com>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, Maximilian Luz <luzmaximilian@gmail.com>,
 Hannes Reinecke <hare@kernel.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Helge Deller <deller@gmx.de>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>, Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH 0/9] enabled -Wformat-truncation for clang
Message-ID: <20240326174713.49f3a9ce@kernel.org>
In-Reply-To: <20240326223825.4084412-1-arnd@kernel.org>
References: <20240326223825.4084412-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 23:37:59 +0100 Arnd Bergmann wrote:
> I hope that the patches can get picked up by platform maintainers
> directly, so the final patch can go in later on.

platform == subsystem? :)

