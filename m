Return-Path: <linux-rdma+bounces-15567-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41180D2146C
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 22:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B64CD300EBA2
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 21:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BFB356A38;
	Wed, 14 Jan 2026 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="sOfRrOQq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="bPJqsM9u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from send146.i.mail.ru (send146.i.mail.ru [89.221.237.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13D733B6E4;
	Wed, 14 Jan 2026 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424935; cv=none; b=iDntiW6SPsU+aYWus6IAR0Jl3wCYtPrQmtN4Chhwb1bwM0x/V5IUyor8O+OZyn3PMWEq8xHrq6b2KGd2vuYTzyng0Su0EQ05TvknLsZ5CKrtzxmyepP+2ogzPchwhMj6RF4/fz3RaIiJoG101Z0tgPPvRZrBFUZrKAX3eoDSJc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424935; c=relaxed/simple;
	bh=obB9wgoUdhaANA+3HX+XD3/tCBDS835xcuQKmlWNp1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gknv8480w2uxX5GfZTPBeFLqtYdOlcGnMrFXCDwBgk7GRdAX3g1ZaIViH+02dSfdU9j297tdl0OzIKHCtS2O8AXauEkzqQCJAtzyxZNiMfutjlIi+jsI9cRMcyztfk51eJSlbkq+9WrktBeKg/tpUU89CGS6SAP5xMV3kYNIp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=sOfRrOQq; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=bPJqsM9u; arc=none smtp.client-ip=89.221.237.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=hAsQbInFZza4IHkuBhl1VOD8SVZBaB7XHSojd59t0As=; t=1768424930; x=1768514930; 
	b=sOfRrOQqMTVAlLHa3w7n5upw1IeulFVa+w/aHKLitqOcfi5t4KFKZhadWPWX/A8iKgsQII9ee5Q
	A0H9ddnkWz8r0uycLc6diQRnLeMOXJupB5qMt8r3/lnrzkVtvAtVSVbn5FogWNoof99TpLTMCYXYc
	4Vi0Uq20PtTsJ8YCcLbeucWd0rZyYq3L8J4CZEuq/tCu9KMKTE2ov9YDqaH/LCgyvB/Pl0Y0UkbHy
	Mi66DNocLYKqTFGb8SplG3WkJ8Q8A3+seDwHB7BXZeR1Cq6UPp7JzKRQCyrNfHYwWzlTLshMQysvN
	y/W5wi//S7/wah+TiuzSSwqW7dfzjkqpj3Vg==;
Received: from [10.113.235.125] (port=50024 helo=send59.i.mail.ru)
	by exim-fallback-97ccb984d-ht4r8 with esmtp (envelope-from <listdansp@mail.ru>)
	id 1vg7s4-000000009KK-405J; Wed, 14 Jan 2026 23:53:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=hAsQbInFZza4IHkuBhl1VOD8SVZBaB7XHSojd59t0As=; t=1768424020; x=1768514020; 
	b=bPJqsM9uYJhMAAWxLdlNxKWN7Nv5MsL4NABReKk/iIo28Ko58KEjbvpyUwCg4kkYHzpnleHVPZR
	3y/5vNhHcYGd32GD+EOFO/vQfbBEgTEmXX+En7ZSUNjA2KZpFdl17tyNbPSsiKGMfUzmV6QS7mH56
	fFST94sslGTj3NYXS7E56l1Nr647nHwU/BiTqZfKIdjYGOFx2p7IThp0dqxdOFqt+cDeS1D0gbC74
	+ARr0uTqodZ9IlUUhLPKqEK+vaZoja8jxW2V13EU9aC9jhYqyTzYBHxDazQEwEWn7DO9QbovACde0
	ProeVYdIZpxn/6bB+672lzXjPjVjIb+NjCmQ==;
Received: by exim-smtp-55f9c6db88-rgbzp with esmtpa (envelope-from <listdansp@mail.ru>)
	id 1vg7rr-00000000CDf-0vdF; Wed, 14 Jan 2026 23:53:27 +0300
From: Danila Chernetsov <listdansp@mail.ru>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Danila Chernetsov <listdansp@mail.ru>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] RDMA/core: Add error handling in rdma_user_mmap_disassociate.
Date: Wed, 14 Jan 2026 20:53:24 +0000
Message-Id: <20260114205324.136273-1-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD99B884C1B59F9AF80402D74434AEA9E313BAE90C9A56B8046182A05F538085040C09EB3FE44E869513DE06ABAFEAF6705D29771EC7AE8B9A3B38767CA568622C528006A18B89A766F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7235646FAB97B4BEDEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB5533756680939BF45BBEA696E4F9AA5306331FB82DD9ADA34C66821360609899925BC7CD8EEF46B7454FC60B9742502CCDD46D0DD2A98E5A6551E3E5117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC5FC25ED3FCEC3375A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751F2CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE9647ADFADE5905B1A9D86F9317F2E7ACD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE37812A6222701F215302FCEF25BFAB345C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637CD70681E7BFD3F6EEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5549CF97499944CF05002B1117B3ED6966A1E95A3395AD433ED71F038FC046993823CB91A9FED034534781492E4B8EEAD4ADCFBF7921B375DC79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6590B86BFC39351147ABF6C5D78DF350EF861257EBC0A1BC352FB35B3E00767AE71429F565EA63FAA0EB8341EE9D5BE9A0A90F0F7429DB2AD0CE9A411EC2077A6818534271EE733958F721D270AA2B885D14C41F94D744909CE04437D853D7CD20871FE3B1D98EC473624A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVVt0N+pdRHOZWnR3hidzLMs=
X-Mailru-Sender: F244DC1430FACE54DBF327DE40F86FDA0E56F3008FD6D1C53DE06ABAFEAF6705D29771EC7AE8B9A3977EED7048DEDC7C8A08967417F2D5E3FB559BB5D741EB96C31AF20DAA089319D7A14DD9E34ECE7467EA787935ED9F1B
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B48BD2CE4D659F6DFAA6F9C8104983AF78E028BE2DCE08E35B049FFFDB7839CE9E13A8E46255CC07794C397C46595CA5D663351C5960966BD0445E499385DB1660EECAD6CD99F284DA
X-7FA49CB5: 0D63561A33F958A5FB4F52DB9C1AFE445002B1117B3ED696CC8E2CA274A521BF75CAC6BD4D76D0B202ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZx48+8dEHEnfBV54LsburEg==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

rdma_user_mmap_disassociate can be called before
ib_set_client_data(device, &uverbs_client, uverbs_dev); and cause an error
 when calling ib_get_client_data.
Also, consider checking the result of ib_get_client_data to handle errors
 in other functions.

Fixes: 51976c6cd786 ("RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages")
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 drivers/infiniband/core/uverbs_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 973fe2c7ef53..a8a2d87f4d3e 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -901,10 +901,12 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
  * This function should be called by drivers that need to disable mmaps for the
  * device, for instance because it is going to be reset.
  */
-void rdma_user_mmap_disassociate(struct ib_device *device)
+int rdma_user_mmap_disassociate(struct ib_device *device)
 {
 	struct ib_uverbs_device *uverbs_dev =
 		ib_get_client_data(device, &uverbs_client);
+	if (!uverbs_dev)
+		return -ENODEV;
 	struct ib_uverbs_file *ufile;
 
 	mutex_lock(&uverbs_dev->lists_mutex);
@@ -913,6 +915,7 @@ void rdma_user_mmap_disassociate(struct ib_device *device)
 			uverbs_user_mmap_disassociate(ufile);
 	}
 	mutex_unlock(&uverbs_dev->lists_mutex);
+	return 0;
 }
 EXPORT_SYMBOL(rdma_user_mmap_disassociate);
 
-- 
2.25.1


