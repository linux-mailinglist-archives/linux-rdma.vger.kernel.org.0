Return-Path: <linux-rdma+bounces-604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBB782B061
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jan 2024 15:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 993A2B21E90
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jan 2024 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9216A3D384;
	Thu, 11 Jan 2024 14:13:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA6E3C097;
	Thu, 11 Jan 2024 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Received: from meterpeter.fritz.box ([84.170.86.196]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYNaE-1rjG3i2Sfa-00VRpy; Thu, 11 Jan 2024 15:13:48 +0100
From: Christian Heusel <christian@heusel.eu>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Christian Heusel <christian@heusel.eu>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/ipoib: print symbolic error name instead of error code
Date: Thu, 11 Jan 2024 15:13:07 +0100
Message-ID: <20240111141311.987098-1-christian@heusel.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wNGA7dXoti0IL3TEU+KqUFkCUciIMfSkkSMI/NYja8ogVepUL3e
 TGRjkyirGIb2pJZIOOoixzOEJ22UU7f9uOW/LcGSDDepYJfZHreeH46ifoTTtlKkR4SCg6Q
 lQBBO/1SvCNkPAnI5wBULXewHYeLtNxzoqXoqxofmaUAOCWcb0v98uqzfgC3JjjABfMcJCU
 7YgGfJECClgkraUFsW6Hg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jNuHSP06OIQ=;aGQlGeZEK9YIGpp7rzf504hGOpP
 mUtBN3bf8+j3vfgUJ6FY+uh+lsD3+JmsGOZuY0ihSXSheHJmSxlXlRqUKkHYRE0N4KUhjrK97
 EQlq8X+DMEr0Ac56tEgQnSAOa4kfm5k7RPbx7zJjv2IZQXuGRn8goU+TiogdzREq3A9QmHXVE
 +6I1ExsyMCnQsfTnAo2ACu6q1aSy7sy+789wkWvUeqv89L4CAwjsYA0G2gCDTYNOAQTRmXfkV
 lHslwo7G1dk4sy7ymkLwJf1FLfYmZLLAZJNo7Xkak+cEIY/msZr8SiIqrIIl0T5cINAg7LaF9
 R/SPZQXf3NsCBap5hsj4RRzR+ytyk9GNrf8FkghitAGnKd5IJtUamNbiX5b0f2qYiO0Loo8R0
 qGKpjLqaVf8N40JUFQUMxuc+Wfz/DzstUHKwQdpaj7Ho/9Scthe0kX0OGVfNdDxNVWiw6WTcb
 3vxTdiWjWiu/08HthslVChk5RxyR66P1kYOL6t3fv01YMoukowP3KrFB884BzKpdA50wdcguB
 VDPSuFRy7FhTCK1YAArCXlIycOlkw04YDTahXVp1fRW7o1P4GjiCxR1Iuk6QDzyFOcCBbwDZE
 HJs+/s+hKBR8t1yjGknSi+PAjgcJTyb4ffC+L5bUtxizIXFElT9y5CG1FqjSfvKBocmgghpJQ
 Gl43Hdk0d5z0Z06GQTOOgdIXVWRfmy6SJV5roMVIhFBFhLPtW8rdP4RzlxdqhLkCgaxShL86r
 yDcN2lMjX/4rJjqZ4sVGOG9090ltBu6xvcbNFmyCqtXQXDb2Lvi4oQazfWpSOHgSHzKTpmLN2
 Ky1lIN5ScEnn/UlrrkO+bJ1rLJlmiI9nzz9VAZNNWDoZlPI2Eo97pO2PyxrKtv2kq2b3LXlJM
 45NZwFUz2mSyjBw==

Utilize the %pe print specifier to get the symbolic error name as a
string (i.e "-ENOMEM") in the log message instead of the error code to
increase its readablility.

This change was suggested in
https://lore.kernel.org/all/92972476-0b1f-4d0a-9951-af3fc8bc6e65@suswa.mountain/

Signed-off-by: Christian Heusel <christian@heusel.eu>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 5b3154503bf4..b9cb2cc6ebf0 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -287,8 +287,7 @@ static int ipoib_mcast_join_finish(struct ipoib_mcast *mcast,
 
 	ah = ipoib_create_ah(dev, priv->pd, &av);
 	if (IS_ERR(ah)) {
-		ipoib_warn(priv, "ib_address_create failed %ld\n",
-			   -PTR_ERR(ah));
+		ipoib_warn(priv, "ib_address_create failed %pe\n", ah);
 		/* use original error */
 		return PTR_ERR(ah);
 	}
-- 
2.43.0


