Return-Path: <linux-rdma+bounces-13685-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BCABA6546
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 03:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790BA3BD66A
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 01:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E215E1E520F;
	Sun, 28 Sep 2025 01:12:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6731B0437;
	Sun, 28 Sep 2025 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759021927; cv=none; b=ZaHFJKLhk7vBRDsz1Rh8iadIZA7FgS8+op/Zc/Oz1wYLjj8EzEyWhhISAg00OPg1zFS8xuEwTO43dsDYx8wuzC6o6E1HD15OgQJWQTG2/ykC1hoWZjPbx+FN+HB64SX5dIVc5/tcAxNWqbvVUCwrKbF6uu8plXoXA3GYGZLJWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759021927; c=relaxed/simple;
	bh=Ym+lOpEDJ6rg6IAsMDai+yUMnqKX3EHZ53E7Vkpr7iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMm6PNM4kJHaywQbVAktBAd/iw8hBvyOYCjMXQ+aWmzy7S4U8ltPCuvRfT4X79+1CFhn4cE5pv4O0JpOpqkMGof5GIWC0/O4NLsJMO+kO2UR1HzKin3MTBXJ73wDAMjL2WlO9mv0EoZUcc1lLxDFSuNIQvremklOSVnl6/e8ZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1de4ca609c0811f08b9f7d2eb6caa7cf-20250928
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:23c84d5a-90fa-459a-9a74-8930edae4114,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-4
X-CID-INFO: VERSION:1.1.45,REQID:23c84d5a-90fa-459a-9a74-8930edae4114,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-4
X-CID-META: VersionHash:6493067,CLOUDID:ce2806c42d044d27a9092e4cfabdb046,BulkI
	D:250928091153PVYNBJ56,BulkQuantity:0,Recheck:0,SF:17|19|24|38|43|64|66|74
	|78|80|81|82|83|102|841|850,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:99|1,File
	:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DK
	R:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,
	TF_CID_SPAM_SNR
X-UUID: 1de4ca609c0811f08b9f7d2eb6caa7cf-20250928
X-User: daiyanlong@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <daiyanlong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 103233453; Sun, 28 Sep 2025 09:11:52 +0800
From: YanLong Dai <daiyanlong@kylinos.cn>
To: kalesh-anakkur.purayil@broadcom.com,
	yanjun.zhu@linux.dev
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	daiyanlong@kylinos.cn,
	dyl_wlc@163.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	selvin.xavier@broadcom.com
Subject: Re:[PATCH v2 rdma-rc] RDMA/bnxt_re: Fix a potential memory leak in destroy_gsi_sqp
Date: Sun, 28 Sep 2025 09:11:48 +0800
Message-ID: <20250928011148.4593-1-daiyanlong@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f207b88c-da98-4fe2-b91f-ed07354ff019@linux.dev>
References: <f207b88c-da98-4fe2-b91f-ed07354ff019@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kalesh, Yanjun

Thank you both for your time and reviews.

On Wed, Sep 24, 2025 at 10:31:34 +0530, Kalesh wrote:
>Hi YanLong,
>
>Few generic guidelines.
>
>1. You should select a target tree in the subject prefix and specify a revision number. Since this is a bug fix, the target tree should be "rdma-rc".
>2. When you send an updated version of the patch, please mention version number. Also, mention the changes made in each version. i.e. under --- you can add extra info that will not be included in the actual commit, e.g. changes between each version of patches.
>
>One comment in line.

Thank you so much for your patience and guidance throughout this process.

I have incorporated all of your suggestions in this v2 version:
- Added the "rdma-rc" target tree prefix in the subject line
- Used proper version numbering (v2)
- Included the changelog below the '---' line as recommended

Gentle ping on this patch.
For easy reference, the patch is available on lore.kernel.org here: 
https://lore.kernel.org/all/20250924061444.11288-1-daiyanlong@kylinos.cn/


---


On Fri, Sep 26, 2025 at 09:11:11AM -0700, Yanjun wrote:
> Hi, YanLong
> 
> In regions where Chinese is not supported, the email may appear garbled. 
> We recommend replacing any Chinese content in the email with the 
> corresponding English to ensure clarity.
> 
> Thanks a lot.
> Yanjun.Zhu

Thank you for the reminder.
I have replaced all the Chinese content in my previous email with English to ensure clarity and avoid any encoding issues.


Best regards,
YanLong Dai


