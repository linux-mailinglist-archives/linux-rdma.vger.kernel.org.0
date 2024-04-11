Return-Path: <linux-rdma+bounces-1904-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6CD8A1305
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 13:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0C4282563
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Apr 2024 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E689B149DF1;
	Thu, 11 Apr 2024 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBX6hqBe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3323149C7E;
	Thu, 11 Apr 2024 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835056; cv=none; b=SCsmeeSrRJLNP2dttH/enz//zkWAz66vE4Zt4wSq3kBuugzivRCFn3oEnwKHnZFwpRRNaIb4/mBB1+EU8lLW8CeFXqVyNlj0A1rNNil1+tPrf3aW1wScDiUThiYrUtdJY2n+M9uY7LfDuTd98kzif4miKo9enjSo0tbAjI6Mt/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835056; c=relaxed/simple;
	bh=Kwx54nhmPY00+9N7lPGZ2tKmthOSaboHtcpEwCDAZ5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MbzLuHmtuzHtTG3PC7RCueUbTekDh+0IoyV9vE58zpFFbvDZeEaCcxnrme55K/HVtZFJzZ1OW38eHzWhwXa0BOfbTkXyw8sGsfwbieKvzqy04RYN/hqx7Nu/6Tnpn1nmJUKVuUXztEaITK56z1dMz3bpDb52KFcDYzZRPVWJJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBX6hqBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0EDC433A6;
	Thu, 11 Apr 2024 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712835056;
	bh=Kwx54nhmPY00+9N7lPGZ2tKmthOSaboHtcpEwCDAZ5U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hBX6hqBegSJ1tXAJ1wOLF/7VmJNahXmZjhkYZUlPyjR63MFEz9pXThLfLe7waqxdL
	 Zkq2AtyNn1KwUhSwEdoqw4ecTBaev78DQcsLkt1Z9QoGNpUNpTieS7XgWUx0g7dYdw
	 H2OohjDDz6lxbcqgGATA2+0+Vvsv/1wrCOXJimLfqRXR4AOiA+P7GTir2YpajyII2p
	 ZiJcBHgPwk8jU8NSME4xp29meWm2eilr+y20L9udR8J6bhn8Kk0lprdvcKU3bGfahA
	 NE/1nDSrjvSHlAIek3MGmDdG7I/Rdp7gP5P+VAAvyKPWqIHFCdO1MR4RFVf0CXn+Vf
	 eEm+CZULm47Xg==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com, 
 jgg@ziepe.ca, Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1712672465-29960-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1712672465-29960-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: remove useless return
 values from dbg prints
Message-Id: <171283505187.703164.5742320074517904978.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 14:30:51 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Tue, 09 Apr 2024 07:21:05 -0700, Konstantin Taranov wrote:
> Remove printing ret value on success as it was always 0.
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: remove useless return values from dbg prints
      https://git.kernel.org/rdma/rdma/c/c8fc935f4b198d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


