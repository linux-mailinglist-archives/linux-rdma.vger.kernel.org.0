Return-Path: <linux-rdma+bounces-14899-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC4CCA5F59
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Dec 2025 04:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D147B30B6521
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Dec 2025 03:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E47A2F0C62;
	Fri,  5 Dec 2025 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CH52zDzb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589CE2EFDB5;
	Fri,  5 Dec 2025 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764903877; cv=none; b=oA2joWuOS8yjKlYfdgFqUWsc6XpOT7JAN3+vlmZ+nFL2pu20TyzaLkXeLxvTaX/gMV/IbAKA+BXR0mOdsj93J5AzkQSYyfPTCIlgSgG5EhequtByjmaYvxvWrjtiN0up8Vz1DhpnYooc4KCCKg5Hur45Ma0kVQCmAujlZVSgC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764903877; c=relaxed/simple;
	bh=g5oU9Ee8Q7YA88f9mKv9OkRuaNGvwZYAX46HHUW/QQE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rN0ehn4Q1KKUcghAztPTpYI6BvapEPcpYH3+RMXdMUTfqAIcQsSKJmkYUC6ohDFFwt/+EB1TLGG6y2Ws8pW1nH5G9mIk2jfyKlnKavw56IMrB6NsCcMzjaLQsNNeV+q1bJj43uLDDFRoXNzPFYeT/OBsa6faKjw7ry3nZOsnoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CH52zDzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A716C4CEFB;
	Fri,  5 Dec 2025 03:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764903877;
	bh=g5oU9Ee8Q7YA88f9mKv9OkRuaNGvwZYAX46HHUW/QQE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CH52zDzbrk5zIihTIUzm9tGRuFbndxv87BrMUlqtaiZKr//3km3t7Xsn7LCImPbOz
	 PK43141Xg647eLXIXzaO0EZ60f+V1/zOBF9hNP5YUhALgfe6NQKfhmoudmGjpVCiFW
	 gSA/fsU6Y4AtCt9t0/nmk9cGi0E1VWHsNbkfSOOhLCWOsXL0FkC7MVAPfoCqoZAwfP
	 DRcd3hLVd5kL5kij3Ox+ALQ/J2vt4VLg+hdhR7iB1nTfjG2BOHefSDtRJQIu6ACUyS
	 /Jcj522NX1CD25ue+HSKZSJbjMRZ0ALHzTlHLZtOOC/oijXDHBIrQeFdy4k1Bd/g4A
	 uZZb2tH+dKX4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7897A3AA9A89;
	Fri,  5 Dec 2025 03:01:36 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251203151847.GA1224837@nvidia.com>
References: <20251203151847.GA1224837@nvidia.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251203151847.GA1224837@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: 80a85a771deb113cfe2e295fb9e84467a43ebfe4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55aa394a5ed871208eac11c5f4677cafd258c4dd
Message-Id: <176490369528.1073302.16512041061853736945.pr-tracker-bot@kernel.org>
Date: Fri, 05 Dec 2025 03:01:35 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Dec 2025 11:18:47 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55aa394a5ed871208eac11c5f4677cafd258c4dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

