Return-Path: <linux-rdma+bounces-14708-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996DBC7E37E
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 17:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69813A8A3B
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 16:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1282D3EF1;
	Sun, 23 Nov 2025 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO6AroMu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0A21096F;
	Sun, 23 Nov 2025 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915164; cv=none; b=ovBIVoqdwo2LsHcEryuIe8xzAYmNe4ICl0htnYyrdVa0T5pxB3JOtC1XgG4wKBqxgA65ETiWUopBlIEY0CH2XqouCQ96SFQYIH08QuSgVZG/Wzo+BQ2oJ6u02W9o0QboCnGp3vsSGHNqtOCKhhyUoeaHs2HEQXWVLaG1Mauo9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915164; c=relaxed/simple;
	bh=IpypDbETTmlOiIImLrwJORIbNMHAYctmL/8ZP3CQDt0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCslcwe5qMOwhP9/U7H8Yh0P5oIiVIjHmZVUnksZkmONK2Rdgm7RkiVGpzHXOLL15421eVWlGpZinTUOjIC2SILGlyfhHs/wxjpDCNlzKeCsl/sL7yuBi8AW2i3zrtq9jdY5FTtNZ2Jhs6G7CHNvl3KOAn9Waxf10s5ZstGeYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO6AroMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F1FC113D0;
	Sun, 23 Nov 2025 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915163;
	bh=IpypDbETTmlOiIImLrwJORIbNMHAYctmL/8ZP3CQDt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kO6AroMuEmP/rEciBJx/zMeN8pCllhvUzUIDV9MGzHKO5xF9wr8TX4LMYz8gJG/yM
	 hp6PgcrXzEjgnVzXDzdtdZ/04ongMoSSzYjRm+sx/mx8Q6KJk1eXjWNQ7V6StgYOYo
	 YuEwJ6YuNqRwVKUpxKWk8WmZRzdRUv/nrRWBUHXgVtYN6UGJnmEu6YuVlUbvn1Hqgb
	 bkdU7BG5BiX76O3neRksceyqpizrIto9Js61L5tQM0kG+O7RKzSqeQ4q4pizmxURfI
	 7iBfSfor3Y0lXFMTKcp10zL+Y/35DLXvGY+DpP6A5JKf7rpsDVefeN3gf56nuDa7h1
	 l5ofUhCyrpMeQ==
Date: Sun, 23 Nov 2025 08:26:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V2 00/14] devlink and mlx5: Support
 cross-function rate scheduling
Message-ID: <20251123082601.04bf8043@kernel.org>
In-Reply-To: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
References: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Nov 2025 09:22:46 +0200 Tariq Toukan wrote:
> This series by Cosmin and Jiri adds support for cross-function rate
> scheduling in devlink and mlx5.

networking/devlink/index.rst:55: WARNING: duplicated entry found in toctree: networking/devlink/devlink-linecard
networking/devlink/index.rst:55: WARNING: duplicated entry found in toctree: networking/devlink/devlink-eswitch-attr
-- 
pw-bot: cr

