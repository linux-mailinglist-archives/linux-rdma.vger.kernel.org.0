Return-Path: <linux-rdma+bounces-22509-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ng/bGu+iP2rxVQkAu9opvQ
	(envelope-from <linux-rdma+bounces-22509-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 12:16:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4396D1BB9
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 12:16:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=mail.ru header.s=mail4 header.b=HTRiTwNw;
	dkim=fail ("headers rsa verify failed") header.d=mail.ru header.s=mail4 header.b=161Iv00w;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22509-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22509-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=mail.ru (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 521933020D58
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 10:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEA1346E40;
	Sat, 27 Jun 2026 10:16:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from send215.i.mail.ru (send215.i.mail.ru [95.163.59.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3522F5A13;
	Sat, 27 Jun 2026 10:16:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782555369; cv=none; b=mb8Yncn82X5b1gz1PZYrFiqvQer9ucnkEFMbEHMebu+kT8KBTeA8+rQBtalcJZ+TirNUvG7gQsr58TZXrUO3nek10fECt2MzuSTx+A7cwEUkc1ze+02F6A8yiazZpLuXO6q7K7QJ7yr+w/c8gAk07bLEBmguSyFjryF9Jh2Qdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782555369; c=relaxed/simple;
	bh=iwLB92wDAtZQdeU7nBSvchry2oEEaCdrX6j3dnVPGsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R11HKsASVSw7zwa9K/25VOiyi2VouLskcKwSlrqClzmg0fJTBXr4rVPF7ZUE6cSGHoF+g3jVAoh7tZln4PKFdjJhdXnpJaMm7Jp+eKYO0OOJ9PIrtrb0OLdE4B+3b3WNyCNIuMj6InzIGHf10oRv2CfyUOO86CT1+9FiRb6VWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=HTRiTwNw; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=161Iv00w; arc=none smtp.client-ip=95.163.59.54
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=AlTxHppGW49I+7rzYj5kXls9+Hyxnj48yOdeDdyvvhs=; t=1782555366; x=1782645366; 
	b=HTRiTwNwZJih7equVd7ZPdlXNxnPy8pnMAS4XeixaVitJ63J+Ncbl0Hc0oqxlaBSgheGdTY7ce5
	r+Yx1bsqkfzScK9+iwYVZPy0htA+JUQeii55RYbdTq6mGzOJUo93zSZLpVZK/U1MV4lDuJ/lYhZXs
	D0yDQM+fwirv/0DGn2w898/2kNXxEy52pFdGpz3fJ6sxW48njBL/YV6NyLslrhF8nDr9210KbnCf1
	CDd8YL8EWQDqpfldWqTSuOibzzOXSCeFyFy6zEOxh6EZNk00/Y2G0nkF4F/JPt0LFgPhP8bxrureO
	f+3wx8GKNbL0QO5MzBcDqbldr7tln/R2owMQ==;
Received: from [10.113.26.96] (port=52722 helo=send217.i.mail.ru)
	by exim-fallback-7db886947c-ndjvm with esmtp (envelope-from <listdansp@mail.ru>)
	id 1wdPqI-00000000JHM-2RS1; Sat, 27 Jun 2026 13:00:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=AlTxHppGW49I+7rzYj5kXls9+Hyxnj48yOdeDdyvvhs=; t=1782554454; x=1782644454; 
	b=161Iv00wvCigLtXzJeCXXK9YAlfg29VpIPtcs8Mz75izck0LcaGspeNDJtBdSbZDSY3Qv0qCPZM
	xrn6SsdAD4YJ7hjl/vMaNMFSdBf+gO2CvCwNnwB7+GdVLNay9TRknw6MrtZ4gYqE99nc8iHWtyh0d
	NmiUDn5/QCXvSwDeP5fdHwiiwHKmYXAe34p5TFJkCMeoXQtQqudpIGwUwtrQTWreapO5fFnuIOAsd
	DMT0YBtD7mxd/FyxYG5dznQb5+3P5Dg7OlGCX0nRlG9P8oDMUBreUpChs8GVQ8ZVVRvwoMmFEKyxG
	rtmmDerJ1ZNXAw8ojXjtz5y/Hu0pfQ4v1ESQ==;
Received: by exim-smtp-78b8b8c574-gm9fd with esmtpa (envelope-from <listdansp@mail.ru>)
	id 1wdPq7-00000000Cj1-2PFg; Sat, 27 Jun 2026 13:00:43 +0300
From: Danila Chernetsov <listdansp@mail.ru>
To: Chengchang Tang <tangchengchang@huawei.com>
Cc: Danila Chernetsov <listdansp@mail.ru>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] RDMA/hns: Fix potential integer overflow in mhop hem cleanup
Date: Sat, 27 Jun 2026 09:59:51 +0000
Message-Id: <20260627095951.51378-1-listdansp@mail.ru>
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
X-77F55803: 4F1203BC0FB41BD918D6BB028DF8CB61525AEE36BB20624716EA9B3F2CFF9942182A05F5380850403B79FA10D0BC433A3DE06ABAFEAF67052D94457CB7F273E3CEB945A4E9837C66B21206976FA500EF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F5F08398AF01CA1FEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FE9EFE935CD7C6AE8638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2AE87DCB91A4E9CBD2E070BE324C7D3C47A7054B6AEFD18C2BB0A4F435E46E6718B35066C979671628AA50765F7900637D0FEED2715E18529389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C08794E14F7ADDB10D8941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6A50BD5087FBFCDAACC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C22498E8BC65031C7C62476E601842F6C81A12EF20D2F80756B5FB606B96278B59C4276E601842F6C81A127C277FBC8AE2E8B8E53866E69B3F3EC3AA81AA40904B5D99C9F4D5AE37F343AD1F44FA8B9022EA23BBE47FD9DD3FB595F5C1EE8F4F765FC72CEEB2601E22B093A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE493B89ED3C7A628178128A6D463EDFD0DBBC4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A54406712978602BC25002B1117B3ED69668353E5E849EF3C0466072E6821086B3823CB91A9FED034534781492E4B8EEADAE4FDBF11360AC9BC79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659AF31A035AD67FF02C41BF6711E59318A904F8ABA21C66D81757DE8CD49CBEEFB40A208BBE7CB2DEAB8341EE9D5BE9A0AC8124F0A54B06336FB5B8D150FBAAFB8014B286DB53A4FDC39A4D55D2591C6014C41F94D744909CE04437D853D7CD20871FE3B1D98EC473624A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVYrk7BQKFwEtCTCQ/sHIUQcEjAfzmRu5mA==
X-Mailru-Sender: 4CE1109FD677D277A25EA9D9B320DF534C9A2857547B3B36B951B70A5BD4BD8E1599F26258E64664E3F52FC5FCA1AAF6C53BD13D3F6EEB2F3DDE9B364B0DF289C95E31D8FCF52BE1594FB4C9F0DBF4120D4ABDE8C577C2ED
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4FA133F958ACA88638E64B5B6F18F8E395F4284038122D8BB049FFFDB7839CE9EC8994B5FF94C904238AF526D9416FA10BE35764BB9C94AEB1DF848742A47B20F01A415A327828782
X-7FA49CB5: 0D63561A33F958A5F9254ADA20A8D2425002B1117B3ED696FFF4040A5F9D33D93E359E1F9564EB4B02ED4CEA229C1FA827C277FBC8AE2E8B538B21105C9D74DF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZQX/9dqvSnfqQK/Dq7T2q9g==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[mail.ru : SPF not aligned (relaxed),reject];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[mail.ru:s=mail4];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22509-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tangchengchang@huawei.com,m:listdansp@mail.ru,m:huangjunxian6@hisilicon.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mail.ru,hisilicon.com,ziepe.ca,kernel.org,vger.kernel.org,linuxtesting.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[listdansp@mail.ru,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[listdansp@mail.ru,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mail.ru:-];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[mail.ru];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxtesting.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E4396D1BB9

In hns_roce_cleanup_mhop_hem_table(), the expression:

    obj = i * buf_chunk_size / table->obj_size;

is evaluated using 32-bit unsigned arithmetic because
'buf_chunk_size' is u32 and the usual arithmetic conversions convert
'i' to unsigned int. The result is assigned to a u64 variable, but the
multiplication may overflow before the assignment.

For sufficiently large HEM tables, this produces an incorrect object
index passed to hns_roce_table_mhop_put().

Cast 'i' to u64 before the multiplication so that the intermediate
calculation is performed with 64-bit arithmetic.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a25d13cbe816 ("RDMA/hns: Add the interfaces to support multi hop addressing for the contexts in hip08")
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 7041a8e9134b..92edec4fa61b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -836,7 +836,7 @@ static void hns_roce_cleanup_mhop_hem_table(struct hns_roce_dev *hr_dev,
 					mhop.bt_chunk_size;
 
 	for (i = 0; i < table->num_hem; ++i) {
-		obj = i * buf_chunk_size / table->obj_size;
+		obj = (u64)i * buf_chunk_size / table->obj_size;
 		if (table->hem[i])
 			hns_roce_table_mhop_put(hr_dev, table, obj, 0);
 	}
-- 
2.25.1


