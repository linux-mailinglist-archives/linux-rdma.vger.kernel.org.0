Return-Path: <linux-rdma+bounces-22906-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5Q3vDOJ5TmoiNgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22906-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 18:25:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89563728AA3
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 18:25:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=mail.ru header.s=mail4 header.b=cuv32GpM;
	dkim=fail ("headers rsa verify failed") header.d=mail.ru header.s=mail4 header.b=Fqz72cvx;
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=mail.ru (policy=reject);
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22906-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22906-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A82B63009094
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 16:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EA242DA46;
	Wed,  8 Jul 2026 16:24:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from send288.i.mail.ru (send288.i.mail.ru [95.163.59.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D03F12D4;
	Wed,  8 Jul 2026 16:24:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527895; cv=none; b=IhF51Mxin1Iec7+q9EWuwPJraz4dVDVpPeLIwXkoHZFp52lCXJsj6FUg6qQ1dVhdYFf2BPU89j6DuTBxGL1ZWcwb2s4e3ePBYo2IcGX3cDb1vD20AKFkEwvektYqgj2QleyhvvVRolQ+U1lO/87WBoOOGobd2pEPKZuVhI9C2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527895; c=relaxed/simple;
	bh=qg1NE8CG11A1gqi4QFTo/Fxw3S9CNpmoCcfQxIl4gSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KdNN6/PbdjymKhG7WQSDzReEghxMXQS/1hoOuoO5pr2NI5rdhPNhv9g8WZleaCwdjaUKq9bnYKwKqD5g4N72s6svIMmn8Z4GzhBclqwP9loeSSgl8MJOqsICQAyGnf/6j9JikmAuE0dFrTPsogmj8e6pWHy/GB/RbliXVLdEunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=cuv32GpM; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=Fqz72cvx; arc=none smtp.client-ip=95.163.59.127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=388YApFBcN7uteJ1gWg2Ile4a78g62h/9cXnDx3811g=; t=1783527892; x=1783617892; 
	b=cuv32GpMqFvvB/B6ffjC7P2gQzhrx2nLLCX+YLuxg4lsxlVp9xEmfZY4sMB5ZXkFXj1BcoWRUOf
	Nw9vBgQZqwVWG9ohF2nHnL9zGA4hGSo/LCf6U06NMBBRJgUpdfJ1RSkJn1zMzSCUu2sqxhbYja6Z0
	Ikyy0yA3ndqr286zpc05HhB5uFOabuoL8MjPIpxWN++dml1zlQFwbyny0ocQxOSgNA5wv3cm/foSh
	CvLAeg1G/bWygtemvf/Fo3E3VRev/wl3EXJnSyvDsrSlP79V1xBb/kziemRAX2E8jkaIz8HJZvDZs
	d2qIRJL/QbctPUVCCewLX2oXYc5tzmvCKftg==;
Received: from [10.113.48.92] (port=39266 helo=send152.i.mail.ru)
	by exim-fallback-b76dc578-8tbgd with esmtp (envelope-from <listdansp@mail.ru>)
	id 1whV4k-0000000051x-1t5e; Wed, 08 Jul 2026 19:24:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=388YApFBcN7uteJ1gWg2Ile4a78g62h/9cXnDx3811g=; t=1783527882; x=1783617882; 
	b=Fqz72cvxhtimVDyi9eFWiWdMC4qYhl2cnqJSctyj9rOcIQA4w6Fas0kpvSYmCFP4sf7IdXMeI/C
	y2vgoxBBY01px2F/qYvjfcsP0YtX3vdIdcHhzcWVZYDbz6LK/joxfXtwERn8YUS42ljUjJvJRmdGC
	ELNft4QQdXFCoJdAdivC0nyxtLlbMNUz7k9lAUd8iMB8jkYCH3/AJVjRf1+VBjoYh/bjDwlmDrUWj
	BrepJf61LSbHHWydWfseLGa8pHtntd+i8J0XaKERmXIsutbwI5alnWL+LIUIr+BrSmuVzGftcRrgy
	+eiXS4p09XgZTVO0oM/TlqGRVNMDQvRNogkg==;
Received: by exim-smtp-9d444bb98-kp2gx with esmtpa (envelope-from <listdansp@mail.ru>)
	id 1whV4Y-000000004cQ-3uHC; Wed, 08 Jul 2026 19:24:31 +0300
From: Danila Chernetsov <listdansp@mail.ru>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Danila Chernetsov <listdansp@mail.ru>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] RDMA/hfi1: Propagate sdma_txinit_ahg() errors
Date: Wed,  8 Jul 2026 16:22:52 +0000
Message-Id: <20260708162252.936634-1-listdansp@mail.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9D32B667BE48EA3A0556D75B7D38F54C749613C0E45C3EB24182A05F5380850404C228DA9ACA6FE27BC59416DEC305EBE3DE06ABAFEAF67054B4B19C0AB6EF28CB090AB29B9DDCEAAF5EC2512189958EF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73230F712CF4B3924EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB553375660A3335E8F372667885F83DD305A585475DEA88E42FFB42822A6CD0C2E0BAF2218EEF46B7454FC60B9742502CCDD46D0D78444BBB7636F62AF6B57BC7E64490618DEB871D839B73339E8FC8737B5C2249E954A0C70C50C109CC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C03257DF78C985F6198941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C088988B59C992DAD07B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050FB28585415E75ADA99F804269016115C9B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B4E87A56E745D374075ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5B0BFC91A95C4896F5002B1117B3ED6966F8DF8C317D1C41630C8F815570A35303610D81D389A125CDE35189EBF2DEA28FEA14CD2CD220BB99C5DF10A05D560A9880EC71AF561E0AAD9143641EC25BB39C559DAE3FA25FE38F36E2E0160E5C55395B8A2A0B6518DF68C46860778A80D548E8926FB43031F38
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65984FED499FB928881DE06D021350E751DDED4ACD0BE66FA216DA8FEBBECF799DF56C5A7CDEF0DADA3B8341EE9D5BE9A0A46E59895C6F8A83AF07A01552131F06E513F15D1637C4E9FDABE3362BFED2FD64C41F94D744909CE04437D853D7CD20871FE3B1D98EC473624A389F0E278DBF4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVYrk7BQKFwEtRz7U2gjhlsbT9HN3PmyZQg==
X-Mailru-Sender: 4CE1109FD677D277A25EA9D9B320DF5395CECFD5F3BD8862B951B70A5BD4BD8ED75840550A34FE02AAC282D28BAD6852C53BD13D3F6EEB2F3DDE9B364B0DF289C95E31D8FCF52BE1594FB4C9F0DBF4120D4ABDE8C577C2ED
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4B9BFAEC4A56250D11E81761E756FC7E79B63F64F0E380F52049FFFDB7839CE9E307654E31992F31C400CF023DED42349DA8B7F1810198C36FFC7DF070F7F7D4476DD166190F759F6
X-7FA49CB5: 0D63561A33F958A52B850F3F3DE06D9C5002B1117B3ED6964C5B24D175B20F5EE409568A2FDEBC0902ED4CEA229C1FA827C277FBC8AE2E8B824111D70BBBF633
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZZZ5UTgcompj0XBVlPOyn4g==
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[mail.ru : SPF not aligned (relaxed),reject];
	R_DKIM_REJECT(1.00)[mail.ru:s=mail4];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22906-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dennis.dalessandro@cornelisnetworks.com,m:listdansp@mail.ru,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mail.ru,ziepe.ca,kernel.org,vger.kernel.org,linuxtesting.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[listdansp@mail.ru,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[listdansp@mail.ru,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kdeth.om:url];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[mail.ru:-];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[mail.ru];
	FORGED_SENDER_FORWARDING(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89563728AA3

set_txreq_header_ahg() ignores the return value of sdma_txinit_ahg().

If sdma_txinit_ahg() fails, it returns before initializing tx->txreq.
However, set_txreq_header_ahg() ignores the error and returns the AHG
change count, causing the caller to continue processing the request as
though initialization had succeeded.

Propagate sdma_txinit_ahg() failures to the caller and abort request
processing when initialization fails.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e3304b7cc4f1 ("IB/hfi1: Optimize cachelines for user SDMA request structure")
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
---
 drivers/infiniband/hw/hfi1/user_sdma.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_sdma.c b/drivers/infiniband/hw/hfi1/user_sdma.c
index 8ea5ed918a02..be6b82ba93af 100644
--- a/drivers/infiniband/hw/hfi1/user_sdma.c
+++ b/drivers/infiniband/hw/hfi1/user_sdma.c
@@ -1026,6 +1026,7 @@ static int set_txreq_header_ahg(struct user_sdma_request *req,
 				struct user_sdma_txreq *tx, u32 datalen)
 {
 	u32 ahg[AHG_KDETH_ARRAY_SIZE];
+	int ret;
 	int idx = 0;
 	u8 omfactor; /* KDETH.OM */
 	struct hfi1_user_sdma_pkt_q *pq = req->pq;
@@ -1130,11 +1131,13 @@ static int set_txreq_header_ahg(struct user_sdma_request *req,
 	trace_hfi1_sdma_user_header_ahg(pq->dd, pq->ctxt, pq->subctxt,
 					req->info.comp_idx, req->sde->this_idx,
 					req->ahg_idx, ahg, idx, tidval);
-	sdma_txinit_ahg(&tx->txreq,
-			SDMA_TXREQ_F_USE_AHG,
-			datalen, req->ahg_idx, idx,
-			ahg, sizeof(req->hdr),
-			user_sdma_txreq_cb);
+	ret = sdma_txinit_ahg(&tx->txreq,
+				SDMA_TXREQ_F_USE_AHG,
+				datalen, req->ahg_idx, idx,
+				ahg, sizeof(req->hdr),
+				user_sdma_txreq_cb);
+	if (ret)
+		return ret;
 
 	return idx;
 }
-- 
2.25.1


