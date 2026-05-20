Return-Path: <linux-rdma+bounces-21050-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CtNLACRDWpyzgUAu9opvQ
	(envelope-from <linux-rdma+bounces-21050-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:46:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAB858BEAC
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85E933004DE3
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0293AFCF3;
	Wed, 20 May 2026 10:46:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336EC3D9DB5;
	Wed, 20 May 2026 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273970; cv=none; b=pQvjOpH3KheYbyW5rKNmQ4R4jCwx2xverG8jRv0kA0Rpitw/GUOM8i7ArBPsf8XvrtFx2SU+2FaWnz3+j998hDibnkcOaBrsi9/Xna36d0IbQi4wTmBnnNZdeFgCBEmIidqzK1A7CyADBVM/f0aE8EojAA39cBS9Z7k1r2rQnw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273970; c=relaxed/simple;
	bh=CPU+y8xfAvtZUmhjQwm5JL33T3A2cLnyf1JIwW2LKEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rrRNQHgbNZw8TLxooPAgVHrM1WIlJrWvlUH7RzHS01Vbup+iz0Ab2rs4PwnsyMTrNkxOXiihnvmWKhZ5IDKs/wcOyUqllsAgzYFnTYxASnQ1eBoSjH60gczOgEBz8gLsIZWI7Yt/aqk+QJJ2rVOQeyCU9D+eM9hKELqOmmiwhw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 17ffd560543911f1aa26b74ffac11d73-20260520
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a9af3e17-17d3-4621-a667-c3fcf450e41c,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:a9af3e17-17d3-4621-a667-c3fcf450e41c,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:3ab5c49e7d804d137ce54022cca48e48,BulkI
	D:260520184603YYXVP1K7,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 17ffd560543911f1aa26b74ffac11d73-20260520
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(183.242.174.23)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1167474192; Wed, 20 May 2026 18:46:01 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: leon@kernel.org,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next 0/2] RDMA/counter: Two bug fixes in counter error paths
Date: Wed, 20 May 2026 18:45:44 +0800
Message-ID: <20260520104546.1776253-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	DMARC_NA(0.00)[kylinos.cn];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21050-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5CAB858BEAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This small series fixes two bugs in the RDMA counter subsystem,
both related to error cleanup paths in drivers/infiniband/core/counters.c.

Patch 1 fixes a variable mismatch in rdma_counter_init()'s cleanup loop:
the loop iterates with 'i' but indexes into port_data[] with 'port',
causing double-frees on the failed port and leaking hstats of
previously initialized ports.

Patch 2 fixes a num_counters leak in alloc_and_bind(): when
__rdma_counter_bind_qp() fails, the counter is freed without
decrementing port_counter->num_counters.  This leak accumulates
across repeated failures, permanently preventing the port from
switching back to AUTO mode (-EBUSY) and leaving the mode stuck
in MANUAL when it was originally NONE.

Tao Cui (2):
  RDMA/counter: Fix num_counters leak on bind_qp failure in
    alloc_and_bind()
  RDMA/counter: Fix incorrect port index in rdma_counter_init() error
    cleanup

 drivers/infiniband/core/counters.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.43.0


