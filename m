Return-Path: <linux-rdma+bounces-12551-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2D6B16682
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 20:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE55F58482E
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 18:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776EA2E266C;
	Wed, 30 Jul 2025 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4M64qoG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349901F949;
	Wed, 30 Jul 2025 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901258; cv=none; b=tY0xQyuow3QRpxnaCMVPjtCg1H2ef20wW0PMpQ9xUfShCF6wbaZEOEPXExv5UfAhTxOGCbzu8Cd7D9BmKhuaVeGnLNY313GdLTn32Ak9x/p3qlBQ02Ckwpx6F0TvqVc5DkOtZabZEaaMRJLKHOOHKr1fXdIgknIpoUGZGnIXjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901258; c=relaxed/simple;
	bh=K7getUpp6HPWmQC8VsVkURa3c8jDl/KttxgQhok/8hE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LAHKCOKoITG+NL2Bn7Kkh21XADWr5Fp0cyVwQA+hq2rfMO7aLTgIugTamHDFP9HfPZmPGyhX450miYx+JjjpXDrqsYjg9agMtQkKIedUe+gEXUzU4OYUF8KPeVx+cbUWiorheCgsjPpCIl1i6tsx3LEeYC0h3ESmXPgNzqoQwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4M64qoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D90C4CEE3;
	Wed, 30 Jul 2025 18:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753901257;
	bh=K7getUpp6HPWmQC8VsVkURa3c8jDl/KttxgQhok/8hE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=S4M64qoG28vMa8DJ6D6FwDxkQ0rcqqWoeeLlkxdbOBhCCujhbNIHpq4+hi8NIlsCH
	 3fQ5ymtnNyUZ2pUuSmgLvcKkWHHlsexGq9NXBzRwWnd7GVZEe3xYoYkfVVSO2GIzp2
	 RrzfGYJetzZQn7HIUqbiHCDAg7gpXOaPyqAFfEcTetQ1/GJP3dkRJS9Y6lY609Bvn9
	 cWx/UE0fzZeCU1Ny5EJinBUa1gB0VONaCwNK2LMlhJcDV0lJgOou28n2CpKxCmZ7zp
	 CLzR73mKEC/wk4M1KIYkuxGxFPPUjokK/2lTArreCUHamKzkTp5vRiypA2SnwR0yyD
	 QUo1ONZ0/SaWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1DB383BF5F;
	Wed, 30 Jul 2025 18:47:54 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <450d3876-90a9-4b1c-8d73-62ac19048991@suse.cz>
References: <450d3876-90a9-4b1c-8d73-62ac19048991@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <450d3876-90a9-4b1c-8d73-62ac19048991@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.17
X-PR-Tracked-Commit-Id: 8185696483dcb29688fc23c45c99d86b73754982
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8d780dcd957d80725ad5dd00bab53b856429bc0
Message-Id: <175390127353.2433575.8108860167868806042.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 18:47:53 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Harry Yoo <harry.yoo@oracle.com>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@gentwo.org>, Roman Gushchin <roman.gushchin@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Pedro Falcato <pfalcato@suse.de>, Bernard Metzler <bernard.metzler@linux.dev>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, David Howells <dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 18:56:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8d780dcd957d80725ad5dd00bab53b856429bc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

