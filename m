Return-Path: <linux-rdma+bounces-13013-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6334BB3D6F3
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 05:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57CC1897FAE
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 03:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB87215F6B;
	Mon,  1 Sep 2025 03:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gCigEEZJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h/XLzxOS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20A1E1E16;
	Mon,  1 Sep 2025 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756695925; cv=none; b=qJP2JDcu2UsdJZBk35wS9KyAffgEEMoSq5D8dyti/4fRbBil1PGHQ7DWr1OQwAIl5gVrDb+IjQMqJ4Y52RSlfvX6hGyUvBM6i4FvI14XWzbcL0cA6pYdhjz3ExnI7aV+RQU1TzF6wzppnuTB0nLr1KSOOpPVIRdWk7uT5Xk5pYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756695925; c=relaxed/simple;
	bh=6ZqVjz11T6NgHRoxkP0c/fthAyB+tP5UMnSLs6XUddg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VT/vjQ+Mn7X2FMUT4zI//IzAlpQ336Fug/PdrkZF24CQbrxlKN4MMA3AAO9pNIZeSAsA7TlGVjZG52/UDSi5fPKQPXbVy/3a/e8U05CN/EBnYgeU60BSTw2PQuKJF9IyaOa2dOhTh4O7/+K7VKYxCxNXmXKiC5GiM5MOJ/bnNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gCigEEZJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h/XLzxOS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 32517EC03F0;
	Sun, 31 Aug 2025 23:05:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 31 Aug 2025 23:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1756695922; x=1756782322; bh=HCVb74up17CQJGagrHKdC
	3DaQ/TG9d4iRUnKKTAPwTk=; b=gCigEEZJ9txQmMk1WQ1nPaOM+Kg8gc82UBV6K
	5wSiiuxhdU5+ZUfgRKqEvh2nRCqMi0ZLshIeBtPFr46VnDJVW3PYFSxsNB3wXFC2
	oPnrflq0qvAm1kwEsCgCXOsggyYUShta69WgNryjYK2a2x0HhqzCx4Auxu5DoJXX
	NJc2aPHCbhOcOKzd72j73pjTZA8dGWd8eIab5TbRvnYxUHmZjEAMigyJvjrV8Kz4
	vZYl7xiWpyCZ2s4WhZI3kd1mKWAFXg/VTxDlak5qSXFithSzNNYSRMjXCmp8sqvD
	9NcWZUciz9bw/NtAOe/gusspMULuiPWN28UV39aB8pU3d38Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756695922; x=1756782322; bh=HCVb74up17CQJGagrHKdC3DaQ/TG9d4iRUn
	KKTAPwTk=; b=h/XLzxOSFqwKkhwyEzMp7gF5ruYfgW77ntEx8p9zNNzGbadNYx1
	ubjVc7dEY0pyjTdAMOLEsWuwTNbMBmW43yfEYR0ged4OdCeFH2lY+rjtcgRmEQXw
	li3K+0OplHkuNcoqbhiqBx5AzMDMU2+1SiaRpcjyxEFOIjSTWawszrVNrWoyCKjH
	CVD3D9N72Na4JNitUsYiULBXMtPsWnpXcHSGCHA9LfKl32BbJH15BN1Vj5WPYZe4
	ON2FDM+B0kNmOEKU6GDjHZ5XGf8FGce+Wrd6OAtrXfxFjxn6NXWcLemI1eMQhnkO
	aMovwsJk3ppHbkXo+4YcH7+Uf6PN05cwQNQ==
X-ME-Sender: <xms:cA21aPuNPLkcp0dd3hVdBc7PJlTLFFrbQoKPqw47VtZS1SmI2madEA>
    <xme:cA21aFeT4Rkj5A4vuPUg50Enab4-AnQqZFftCnsBIivfTKH8eNL4qYhN7pPJUw40Y
    fL_Oxmvp1cLaL6pnpY>
X-ME-Received: <xmr:cA21aDqtDBFatsAoZjS9jqhlrQgt5E-LEcqXehoj_gFcoa4pQb3heduG9mR0-GbbF7CKexg0DA9oAgWi4yZCuayvOV4qQMpLOG03DKMYd2baV1vD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledutddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cA21aD8hPnjoG5-ONPi5VTbNz5YAY36JtjlRHWUppVnIeqmw551cTA>
    <xmx:cA21aM4Yn2JTQqvPofaLSy5jgdp0JD2abqnfMvRlj0_QT7ZNV-wfCQ>
    <xmx:cA21aFgcpmdqKUGtVOfeCS2QpyCWOkGl434aux6_RgDvnT_ZoC45Kg>
    <xmx:cA21aLooGuZy4BBQM-uUUpdHIB3kvNHAJOCaGY9ulW2scw3_PqYpAw>
    <xmx:cg21aJ9PVN8FdO1UP3_2CFFk0NH78iUkq8VCIvu3Vw6mdtVCfKSbz3E7>
Feedback-ID: ibd7e4881:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Aug 2025 23:05:17 -0400 (EDT)
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
Subject: [PATCH v2] net/smc: Replace use of strncpy on NUL-terminated string with strscpy
Date: Sun, 31 Aug 2025 20:04:59 -0700
Message-ID: <20250901030512.80099-1-bold.zone2373@fastmail.com>
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
V1 -> V2: Replaced with two argument version of strscpy
Note: this has only been compile tested.

 net/smc/smc_pnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 76ad29e31d60..b90337f86e83 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
 		return -ENOMEM;
 	new_pe->type = SMC_PNET_IB;
 	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
-	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
+	strscpy(new_pe->ib_name, ib_name);
 	new_pe->ib_port = ib_port;
 
 	new_ibdev = true;
-- 
2.50.1


