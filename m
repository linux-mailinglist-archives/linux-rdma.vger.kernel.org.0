Return-Path: <linux-rdma+bounces-13011-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8931EB3D1C0
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Aug 2025 11:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66CC04E00C5
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Aug 2025 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD5F2494ED;
	Sun, 31 Aug 2025 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dbwfZMbe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VIqfHGHA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8643169;
	Sun, 31 Aug 2025 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756634219; cv=none; b=pbeQXBO9ZDRXU0TluutNNMHkjS1P0CHv/I1vebnqdnIxSj4mkiBmp8KyS4SmRctQASvWXrccUtpuLOKGscu9HOa4G2wbk//xA/42ecNZKwD3by79cV8qSFkog4W342a7kfkIZ7sM6OtltNW9f+/nfgCfxxcMrc99OKMWNASdvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756634219; c=relaxed/simple;
	bh=kGtb2RYRdn0Swor8JnLakxT+7d1PidwrZ50+oMn5EfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bU61zLBJwc5cjQDy4yXghDCBGjUzIuJcUBZDpebiL4upmYDbICa9kfbebChdl25bAIrl19QFm92wYWdpVKNj9qn+iNuen0MguE8cZo5QP1piLCp2okCxevU72rc7TqB5hndc3GS+W0a7E/tJQV1OnosHOxF4shdbINo/y1p7DnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dbwfZMbe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VIqfHGHA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF3717A0081;
	Sun, 31 Aug 2025 05:56:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 31 Aug 2025 05:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1756634215; x=1756720615; bh=mMODJHU8uJag0Sf9/rM/P
	gx0JRSeeuAwd53OX6+7mb8=; b=dbwfZMbeDYjv794TZ23lsZMClqVFnbES34qBk
	g431yYz8s9qWehiHtDLypgl754h4/XQWRn2/t2Qfe9d+bvDrNnMDETolbmJaRLX0
	9LytDpC5vLa5w4Fp6ngXSluOF7zk9UP8tkc2YP3UtbCjYJV3ieFsf8tmuzKuwKrH
	8YEtZx6J4ik7hO9Hdcz7OmKG0lvRdfkp7wazKbKpzboXD0Ne1V6Jd4ZRSAy8hWiG
	cGbTGqmI1Z3cx/BfIbJzYGW9nFE1oR4ENvZ9HFzHP2LA9/gh1NsbFEnCyk0/Ez1u
	cA1LjyMuCj2+aRrVBFi9X6zQgIv1p46wQX1zpQxNHl1qjZ6xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756634215; x=1756720615; bh=mMODJHU8uJag0Sf9/rM/Pgx0JRSeeuAwd53
	OX6+7mb8=; b=VIqfHGHASRhyo9pBXT9JGZ412656Aed9cntq7ERzVImFXydwQlk
	GfcF50Gn98ueaA5AvnGElS91yZAOn/bl1HPDbB4Uho8+1ltiOIUgutH37OKSPiKP
	DknauPeKoSdShFpGfqBOzWjvCPSSfHWEzVg9fS2DV76yG6gyjaiWBbHq7b4AuSWZ
	7WdzIEqUG70SH3ZyFaa+E6ierO7ebQTDzVXJ7n8KhLpOUDLlB6NwTWgDroAb3SNw
	xDI7ZcZg6yWhmxU1Mi7u40cQGqk3vU9ZlrTCyjLhif93nKlLWSw1K8XJSLIZ72Kv
	byvxJwGX3hS//wtqJubzvQtsajaQtPBA1rg==
X-ME-Sender: <xms:Zhy0aAJC2lhyQmjjshdiop8-ZsiNCm6qardy6_RkNGiJIJS13uB8Yg>
    <xme:Zhy0aFKEOcgC0dOCb_KUau0Fi8Vw14CxN44j_K5MqiusttCmxKi2Ft7GZIv1YwA8a
    3ZKPGeC5U5YVg6blV8>
X-ME-Received: <xmr:Zhy0aBnKYyCWJcfcaFaGLN36oT3URPDIHTwD696tw95zaI-D0fyERlGiTWcK7oax6vLPhhv7G0gW_MdxRS3ZIRR3f7FYxxg6ktJ2T2RNQCNgLaFo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeflrghmvghsucfhlhhofigvrhhsuceosgholhgurdiiohhnvgdvfeej
    feesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeitdetffdutdfhve
    dtvdejkefglefgvdeiveduffdvgfeifeeiveejteeitdegkeenucffohhmrghinhepthgv
    shhtvggurdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsgholhgurdiiohhnvgdvfeejfeesfhgrshhtmhgrihhlrdgtohhmpdhnsggp
    rhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgsuh
    gurgeslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopeguuhhsthdrlhhi
    sehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepshhiughrrgihrgeslh
    hinhhugidrihgsmhdrtghomhdprhgtphhtthhopeifvghnjhhirgeslhhinhhugidrihgs
    mhdrtghomhdprhgtphhtthhopehmjhgrmhgsihhgiheslhhinhhugidrihgsmhdrtghomh
    dprhgtphhtthhopehtohhnhihluheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgt
    phhtthhopehguhifvghnsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoh
    epuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigv
    thesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:Zhy0aDLG2UOT7rrhj6x0VMrZgK08wSh27r9MfAit9Drri6RBqXmQqw>
    <xmx:Zhy0aEWmGrQGYcR7ldzuTwK2ryDNvdWYwaaKsb1YGIQVQQQtc3TXyQ>
    <xmx:Zhy0aANCDraOso4Pgy9jpvONZvnDZvbl3wPXYfzs6cg1insEfmgt0A>
    <xmx:Zhy0aInU7d3muP6s2nJMO2_PaP0_jvzQOuVgxS76OKYtFVt_8Z0mpA>
    <xmx:Zxy0aMrsv0wi-BviLZ2YU1JR_k9zRhQM7Y36BKUy-vBqZS8Le8VZnSYr>
Feedback-ID: ibd7e4881:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Aug 2025 05:56:52 -0400 (EDT)
From: James Flowers <bold.zone2373@fastmail.com>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	skhan@linuxfoundation.org
Cc: James Flowers <bold.zone2373@fastmail.com>,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] net/smc: Replace use of strncpy on NUL-terminated string with strscpy
Date: Sun, 31 Aug 2025 02:49:47 -0700
Message-ID: <20250831095535.176554-1-bold.zone2373@fastmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strncpy is deprecated for use on NUL-terminated strings, as indicated in
Documentation/process/deprecated.rst. strncpy NUL-pads the destination
buffer and doesn't guarantee the destination buffer will be NUL
terminated.

Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
---
Note: this has only been compile tested.

 net/smc/smc_pnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 76ad29e31d60..5cfde2b9cad8 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
 		return -ENOMEM;
 	new_pe->type = SMC_PNET_IB;
 	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
-	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
+	strscpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
 	new_pe->ib_port = ib_port;
 
 	new_ibdev = true;
-- 
2.50.1


