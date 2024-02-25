Return-Path: <linux-rdma+bounces-1126-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AE6862BAB
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Feb 2024 17:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF91C1C20BD1
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Feb 2024 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F17175A6;
	Sun, 25 Feb 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEQe4hJ0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D549012E70
	for <linux-rdma@vger.kernel.org>; Sun, 25 Feb 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708878131; cv=none; b=BbWjN4xi9PTJ4mH94AJAT8qWGU8h81uD+UwHN1fj219QaCV5/dnwxSE7w3P03yTj0smjqd2JGKLrCI5k74CSCtR02Pg32t9M2NhDWaB45Tt3ivXo66uYXrdmQn53uFgW3ihLqbrTLV3DtqRmq6xKj0RSj+94KfTH/VryI0pgLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708878131; c=relaxed/simple;
	bh=aMkgEQiv/w00gkHaZqx5ERPnMHYEgIfUNs8cnsZR2U0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gQ+W0pfUuBxZyPeSKkNuF2QI6M7bTmnQE1bqs/7gTp/GaPKrNvkmZQNRtTNI5RTOl6JGv4Hbop+CtzHpX9ODxu+aaSdEg+jpyMr4ZK4PvMubUT6cUkK2diJyuRagukRSxgBX4fp6PkJH2v7lWMkgYh1PmJjesb0WFTAF1YrQenU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEQe4hJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF42CC433C7;
	Sun, 25 Feb 2024 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708878130;
	bh=aMkgEQiv/w00gkHaZqx5ERPnMHYEgIfUNs8cnsZR2U0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BEQe4hJ09XgCx1utW9DxmPM31MUUKXh5GB0TQDK6w0HoMGgGb7xjGtbsfld5ai3mR
	 ok0CxwEJdle0Yp7rMvlWlhQxlCR4d0BWu6M/799MIArpLy34I4RvOX7PzGpA5mNYXo
	 6q2PqRwVQO6KfdPvkKp4G/rh6Tr8wzuhSwm3FbVwBXg3zNQxrKK6JPXWKF2bxvcVCP
	 d/I3pt8L9wFCVPLf/v8TFicjzrw+kX1HD+F4kuqjZOmUzqMKE6W24VyrUEmFbX1sPw
	 1sZfVBVztEVAGq0GHUQYROoSPoeqGxU7z+bFhXFSqAeUtK937Gm6MxiZrUwymkj18m
	 WXeIT2waETs3g==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc: Haris Iqbal <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Gioh Kim <gi-oh.kim@cloud.ionos.com>
In-Reply-To: <20240221113204.147478-1-aleksei.kodanev@bell-sw.com>
References: <20240221113204.147478-1-aleksei.kodanev@bell-sw.com>
Subject: Re: [PATCH] RDMA/rtrs-clt: check strnlen return len in sysfs
 mpath_policy_store()
Message-Id: <170887812528.1848572.567135815688149745.b4-ty@kernel.org>
Date: Sun, 25 Feb 2024 18:22:05 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Wed, 21 Feb 2024 11:32:04 +0000, Alexey Kodanev wrote:
> strnlen() may return 0 (e.g. for "\0\n" string), it's better to
> check the result of strnlen() before using 'len - 1' expression
> for the 'buf' array index.
> 
> Detected using the static analysis tool - Svace.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/rtrs-clt: check strnlen return len in sysfs mpath_policy_store()
      https://git.kernel.org/rdma/rdma/c/7a7b7f575a25aa

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

