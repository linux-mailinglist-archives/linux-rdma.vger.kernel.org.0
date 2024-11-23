Return-Path: <linux-rdma+bounces-6081-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115E39D6771
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Nov 2024 05:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A110B219EF
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Nov 2024 04:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B729016BE2A;
	Sat, 23 Nov 2024 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAiavkj6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715AF7E0E8;
	Sat, 23 Nov 2024 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732335029; cv=none; b=Sm6QU49NpS9R6dPyomGXvOoAaxOLw4/VhVgz8ovOOr6CPNBSyNsnUli/cVLYGnfVTKToFtnIESEbx1aT/t38D1pLar9sluK3IWiykUhZ7V+7h5MdJupMScDB6rJgyoK42/Me1vYYQrirOuM6OJnrZEzuJdwizEW7vZfRRkUy+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732335029; c=relaxed/simple;
	bh=LwVZIubD2F+DzYWVOJditvYk7swy3HhWDFT4INpEMu0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tWfFABJ+PUZGnQvmXS0gvhp18pj1fRKdylhiVR+8KBjep8dCho+CcZUdVzpW8FX7rn2lX1/3GWsvFMERDqGISk0rA/4uJw81iMKtmYKiTBdL+cmjHI8OBdfZ7Vi/qGp0Gwh/8WxxP0NGxBQvnPRcz0Bo0aiGz4lHuSeJdMqPPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAiavkj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540CFC4CECF;
	Sat, 23 Nov 2024 04:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732335029;
	bh=LwVZIubD2F+DzYWVOJditvYk7swy3HhWDFT4INpEMu0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rAiavkj6DlUTX9CTDknf9R1wJhCMAnTaGt3vKCii6njMqtfTSZ1v4hA1HjERivu0K
	 3REyiIzBJCMRUN5osBC9BKTYwHSbRzgU9JCQlU9TwxcKqOSPYcy01oYdTxc+V7X0FX
	 Ed2VTavIEC8JMkcEHFlNufUtssq4n6bIjM1gzmwozcPrfR1zh5zC/h1MsS3hx6cYX4
	 R/BpnK7pA7xtEQjQPpWFfrUHqjbaFu/BxI8Q8315j72GyErqZH76V6Xc6Ac8O5INBK
	 nwC6nffy4VbGFloKATUiFm6agCeOs8BxPE7kPCGMqm2SDYFPOL5okiXuLCKYCi7VnE
	 IVyzVmh6H0LQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CC2D83809A02;
	Sat, 23 Nov 2024 04:10:42 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241122183628.GA1102912@nvidia.com>
References: <20241122183628.GA1102912@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241122183628.GA1102912@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 68b3bca2df00f0a63f0aa2db2b2adc795665229e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a163a4cea153348172e260a0c5b5569103a66a3
Message-Id: <173233504162.2897203.15209598676665816169.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 04:10:41 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Nov 2024 14:36:28 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a163a4cea153348172e260a0c5b5569103a66a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

