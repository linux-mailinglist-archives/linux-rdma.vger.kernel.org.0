Return-Path: <linux-rdma+bounces-20461-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id halNBY/aAmrJyAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20461-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 09:45:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8692551C169
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 09:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 279803043FA8
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 07:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8033947F2EC;
	Tue, 12 May 2026 07:39:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899DB480321
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571553; cv=none; b=gR7jqdqYyP4W47UU76lVzHFfJkbfYg2UgloGptzlmPtzJd+cIcnIltcvHq8qlxDBgVZqJcV70xA8Kq78XlHEk4lqpkPd1gSQ5IP8Pm0NgBMcZYoUnD/wYZ8C6mXi2v7NlJyF8m/v49KE96X2gqqFQQCwHiaP8mqi/vwqOdiINJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571553; c=relaxed/simple;
	bh=Lm/FG5Wpy1FW1RIxdsKhpGjED6zLBQROkj1gf+H9ooo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZXt/zTktp0a+Duwy+HuvmwpMlCn//rZS6xCHGs001LKYMeJ79a9gBsitxtqEMxiBhBMRrA7Jo8ayIT3Fb91e3pDuFItA525hwrkeR9wBapGq9hkrOwEp2ykvrfP4iXxFdEZ0VTudmNrSPYQCd1DpUCshntZwDcmX4wVHSMZeOwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a4d203ec4dd511f1aa26b74ffac11d73-20260512
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_MAILER_MTBG
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_PRE_RE, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c37330d4-a0a8-45c2-b6fa-e3dc87df1375,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.3.12,REQID:c37330d4-a0a8-45c2-b6fa-e3dc87df1375,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:e7bac3a,CLOUDID:fac2b08dd925e2343b1cd245b5578a89,BulkI
	D:260426204238VAH4KHHD,BulkQuantity:4,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:99|1,File:nil,
	RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DK
	P:0,BRR:1,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a4d203ec4dd511f1aa26b74ffac11d73-20260512
X-User: cuitao@kylinos.cn
Received: from [192.168.108.130] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 539740481; Tue, 12 May 2026 15:39:01 +0800
Message-ID: <4ab73129-b690-497c-83b1-d2065f52e7bd@kylinos.cn>
Date: Tue, 12 May 2026 15:38:59 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] RDMA/nldev: add resource summary max values for usage
 rate display
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20260423061352.359749-1-cuitao@kylinos.cn>
 <20260511101258.GF15586@unreal>
From: Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <20260511101258.GF15586@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8692551C169
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.982];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20461-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Action: no action


Hi，Leon

Thanks for the review. You're right that a percentage alone is not
very helpful to users.

在 2026/5/11 18:12, Leon Romanovsky 写道:
> On Thu, Apr 23, 2026 at 02:13:51PM +0800, Tao Cui wrote:
>> Add RDMA_NLDEV_ATTR_RES_SUMMARY_ENTRY_MAX netlink attribute to expose
>> device resource limits (max_qp, max_cq, max_mr, max_pd, max_srq) in
>> the resource summary alongside the existing current count. This allows
>> userspace tools like iproute2's rdma to display resource usage rates.
> 
> While I'm fine with the overall idea, I think we should spend more time  
> determining the proper display format for this information. Once we agree  
> on how it should be presented, that output should be included in the commit  
> message.
> 
> Presenting utilization as a percentage seems too imprecise, and users would  
> likely prefer to see the maximum value instead.
> 
> Thanks

I originally chose the percentage format for its intuitiveness.
The expected output was described in the corresponding iproute2
patch [1], but I should have included it in this kernel commit
message as well.

[1] https://lore.kernel.org/all/20260423064711.360024-1-cuitao@kylinos.cn/

Here are the display formats I considered:
1) qp 123 (0.0%)            -- percentage only, loses the actual max
2) qp 123 (max 131072)      -- clear but verbose
3) qp 123/131072            -- curr/max, concise and common in Linux tools
4) qp 123/131072 (0.0%)     -- all info, but too crowded for one line

After comparing them, I think format 3 is the best fit. It is concise,
follows conventions used by other Linux tools (e.g. df, free), and
users can easily estimate the percentage from the curr/max values.

  Before: 0: mlx5_0: qp 123  cq 45  mr 200  pd 10
  After:  0: mlx5_0: qp 123/131072  cq 45/65536  mr 200/1000000  pd 10/32768

In JSON output, both "curr" and "max" fields will be provided so that
scripts can compute percentages if needed.

The kernel side change (exposing the max value) remains the same. I'll
update the commit messages to include the expected output format and
resubmit.

Does this look acceptable?

