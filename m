Return-Path: <linux-rdma+bounces-15352-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D428CFF0F2
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 18:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E107D36D3784
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A874332EA3;
	Wed,  7 Jan 2026 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NCuAI91n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E538BDC2
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802536; cv=none; b=POijYxCVhJEusDJTOpJp9teI3Nsj1aQtPCdWngjS7fRnOTHJasYJBjiegavschMBgXIrLQsAEJLMAuXKcx0LwYEVWWR/3of6idaVoOL2wM7BG6O5t/CAI/C4iBoRpsbJDkg44SCXsI9nV2xBGa4c6moqt11GT7+V5TvsxlogTe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802536; c=relaxed/simple;
	bh=/SGjqxl29UjQpo3GNDo56uuz77EMdRQNx6vVfLcBWas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpd0Txg7nnx16uh2VBofJaBwPYFl7z5Kzq6UENTll1yxr6k+7kwDUQOD6cDlk3mA5nVWjcQVNqlqwPl27jwgSVaQLNzxBlCJRN4Yv7WlfpsA+pZN4MueLZIuUDzyBR4Zral+wQX1Zl89YDCK9ypnFtMeEyIqhuoxjxTdVSmuTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NCuAI91n; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so3032815a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 08:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767802527; x=1768407327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCagQb//k4T7AzFSb7Fdwhar+hrTq512bPNBjVt4R38=;
        b=NCuAI91nLpd8ZyRV9mI2LFDnFTU4dV0Nmt53Vuai1Ovuv2UEUG3VD4LH+kSuPzb5t/
         M6IoUjlPn+wBLq6FI9QeGSR6y02fv0T+uwDX5Dyvw3YCA9XuSc9BiQls2BbTgry3uHxB
         IC3/DU2jOyITw4Pu2Xc1HVX55dFMuJ/HpKZoKA1gCF8xfo3+AvXKfwfCFt7giY9BzZ6P
         givT4EB320RKYJ27sNrxbkImR7bVf/hFL9NUZ7SUypddC/Z5xVMdxd8VmImNuMUCESJR
         zrF4VazzcwibkRJ3bTUvzCJ9gSIDZNHymA3et1LfAjAZXKb6kVyjcOCgnWNEj1WN37G0
         oPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802527; x=1768407327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TCagQb//k4T7AzFSb7Fdwhar+hrTq512bPNBjVt4R38=;
        b=bQEP1LyFyicn2XVf7JxJNClJPFzQIlwps32f/Kc1VCwoKXvUid8551Mu3cfOix3zHj
         RdctBPPbNV0MCd4mAZxuz5Ed/rufm5VyEsRxYai5OsbZton/UrL9py8L+UtEaALsnaZD
         47UI5T6rREL0MfHipE45S8LI3tmkjqXoR6d7k/8KRKWKuDsP/5zenoKG9n7WrnHmlQnN
         eBEnVqibcr+uA94W56++WkJ/lAxZOHNv3cugZUpzEsbiBv/nl74Kl/5b18S6QbE9lOtP
         63lJbemEl//US2Vsh2ITbGsyUjg2wPRaHQ9w+JN2tGztYIyAQFSAjDGXu0PN+eL1bK/N
         YDMA==
X-Gm-Message-State: AOJu0YyA67L7TvxIJrwUpJTXPOGudTDTiAAD6Vdfefr+kI9QNE1JSJXa
	gdCw6oMJRGrfsE+Xdqo2u0PfN930v3tPhGB1O+gCjg8Fjt3i4JjNbidKbCWpeng9MtL8GB+BYFG
	AMfiF
X-Gm-Gg: AY/fxX7UhZSdNEMW7bK2VBcUXZ+j4T+EgQTHZaKpqooPArRnGV4xUGYabcM2tIVVoD9
	4MERxRkLTjtOVaYO3wsKroPPHZfdIibVNXhZK2zM62Ye1SpOMnpCv2y9bg3pwO5WQsAKonBwxAp
	rJtlcB+yF+sPVIwtq8S9YlxZ/O4l+yYYYqMLoSd/e0/TKxNB28E7GKBfXOyC9c2Q4uozMR2GCMh
	z2d3U6K/X4jjNG8BV6rYf7Gsu7z1thRdsUE/rdyBuDWnmUC/U4efR57Ucv+nQweFMgFWxWZsLpQ
	Ir/dce6iAJNZFCaA0cPJQdYAmpQXq3R8o5IKw0J0wwKfbdxgo5jtQon7UIOfoMj79xgt0RS6ARW
	4EsKBcSplCNfVLmMcMnEOT2K6gsHOHiKOrWxssrkp3IbjPya1w/vMB0JomPwII1g/cpdtZfl5Vl
	OABlGiZQ6i9Def99lLxqRsWz5TkH6Ue+8nehbL+XJUUU1RVSGDHktLL/nZcQLXxifiQrKuD2/oi
	flAeWyvAExXtl1A4KMhcZQ=
X-Google-Smtp-Source: AGHT+IHA5cJAMZEfeAZeBKqhgYIr1gw2piWp83INCOxD/ckb7FirR56eI9Dms+6a8PFSDK/mninawQ==
X-Received: by 2002:a05:6402:4408:b0:64b:83cb:d943 with SMTP id 4fb4d7f45d1cf-65097dcba4fmr2876648a12.6.1767802527040;
        Wed, 07 Jan 2026 08:15:27 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4864773a12.10.2026.01.07.08.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:15:26 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH v2 10/10] RDMA/rtrs-srv: Fix error print in process_info_req()
Date: Wed,  7 Jan 2026 17:15:17 +0100
Message-ID: <20260107161517.56357-11-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107161517.56357-1-haris.iqbal@ionos.com>
References: <20260107161517.56357-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>

rtrs_srv_change_state() returns bool (true on success) therefore
there is no reason to print error when it fails as it always will
be 0.

Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 09f4a16b4403..2e09811a10b2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -883,7 +883,7 @@ static int process_info_req(struct rtrs_srv_con *con,
 	get_device(&srv_path->srv->dev);
 	err = rtrs_srv_change_state(srv_path, RTRS_SRV_CONNECTED);
 	if (!err) {
-		rtrs_err(s, "rtrs_srv_change_state(), err: %pe\n", ERR_PTR(err));
+		rtrs_err(s, "rtrs_srv_change_state() failed\n");
 		goto iu_free;
 	}
 
-- 
2.43.0


