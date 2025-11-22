Return-Path: <linux-rdma+bounces-14681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 209DAC7C7FA
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Nov 2025 06:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8436E35AFBF
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Nov 2025 05:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A41B29E114;
	Sat, 22 Nov 2025 05:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cMJWU5Rk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50B72622;
	Sat, 22 Nov 2025 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763789353; cv=none; b=nNCYNwOK5kBwk4lm9JJx7HjwTA6ZqfEW6xg3sIPPLhh22Q2t0TWEUklSu24sQG70Hi13f6gWX168Ralk2cweqEO//yAf1FGp1Ys+V7CvC6OpU6wYqn+xMhSV4NLdU7gzl/Sim/qpr8S3VKWTAFqwdcUgxRxcZxefwGAfDvxfO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763789353; c=relaxed/simple;
	bh=JHnyGanJdKBv1lmhk4hIYwjzvp2kyvgpJi8HlRz6v2Y=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=bqE5Mo62U6T4TLgTJPk4sw9AfquWFOGRR187vNqh1sBmpYhHT4h8jDdrz+QiNPwF5aEK7s9zs3wSt+SmFsmsHLk1BgbnoHX6uDWmP03g7MlJlWPdAv5Jq1dKPR3mynHi6ev150eag6VOHImzki+HU46DbWi0ZXBSo8y1aXvIkZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cMJWU5Rk; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1763789321;
	bh=JHnyGanJdKBv1lmhk4hIYwjzvp2kyvgpJi8HlRz6v2Y=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=cMJWU5RkGLf0plkIKPH4/h+ByIUQLDefy8efiejdDvFhptEC4FOu2PbxnPTWpTi2V
	 +k2krCCUWRG5N0tHUs127XZ/eM4FpdamLun8jD+6b2iZxFqTaNCpSHZqJhThKxtbDV
	 UJDI1MUIU6q091dGHGoIYzsVHZkuny5k64zRm+38=
EX-QQ-RecipientCnt: 8
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqRRDMu1q775QruR7Y790WuywJEQvw7b5Zs=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: XRNTu+GrJrUl+I074H3im/c2i3Qkw1iaOTJPGAJuieo=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1763789296t14bfa025
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?Tmlrb2xvdmEsIFRhdHlhbmEgRQ==?=" <tatyana.e.nikolova@intel.com>, "=?utf-8?B?bGVvbkBrZXJuZWwub3Jn?=" <leon@kernel.org>
Cc: "=?utf-8?B?c2hpcmF6LnNhbGVlbUBpbnRlbC5jb20=?=" <shiraz.saleem@intel.com>, "=?utf-8?B?bGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc=?=" <linux-rdma@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>, "=?utf-8?B?6IGC6K+a?=" <niecheng1@uniontech.com>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re:RE: [PATCH] RDMA/irdma: fix Kconfig dependency
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 22 Nov 2025 13:28:16 +0800
X-Priority: 3
Message-ID: <tencent_25349C931FCC96137880D01F@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20251117120551.1672104-1-guanwentao@uniontech.com>
	<IA1PR11MB7727692DE0ECFE84E9B52F02CBD5A@IA1PR11MB7727.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB7727692DE0ECFE84E9B52F02CBD5A@IA1PR11MB7727.namprd11.prod.outlook.com>
X-QQ-ReplyHash: 2448271237
X-BIZMAIL-ID: 2146458608414262690
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Sat, 22 Nov 2025 13:28:17 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NImvdRhE6fHp1TYj7/vl3op8hweCcOZ/X2DvZlIfM0MTL12szw/EwRre
	gWPfN2LH6wwRcHZj8YCApHrF+6SfeYoTzI5EwRjcnTFZhUuDHtrnwyX9wACl4snY2HHuCmm
	0OWcXyHOHRjGTkac4roYMy6G1cLZySjvVWggtqNE1JD2dMHPC30dn7S5yP0HolQspWChrn0
	UyRwUa563xYjIIdaD5pRO9/2ObFSato7yRaSW/vAbEHHaUjPMQZne3t9PGxMgH2awc+30v8
	YVAhRDye+7QIG3oEja0z/pJu9fQOm8xSrjHdM0kL1k6huHrMz9y8uu2d0Uf99sSdzoGJGta
	VVOIR9h5auRODwbDOYK2lWvHYKE07hCZK9H6vOCpVWdyA+EG9A2xGzM8WSXRhYbuhK2+aR7
	jGSC1uxeOU3AMElroMNS6AyAAgiHvv9K6JeeD7Me+HooTqGru4ERyT22PxFsRfQ+zyGRUiY
	7WG7zHN3LdIPcUyQXQy++kH6/qfDjeVYU7uroPD3iZnwpvU6GxZOMS63LC9HlpW0LQRb465
	OxP5m9sSGdnuV8fHcpaP2CIWUw3ZZj6tHq5ZjwpOgALp5Fzk8h+ooTvivATf9eMOfpFqIZx
	1Xkzx4LaVD5eX/ABU8m7x1E2bs30YqUmC0mM+FZmOtexz1xxyEi/JSQ886xLJa+HZ4xhts5
	5hQqLG9eiUsIwBTIAqAkc1IE4IF74uPsMYxDUbn6p3Dab46E8hPHocbGJJGqRtodRypl7N0
	x8K2qLKT3cJzRXG7XIRUPEAz/wj424/sDv7yFpFcuS+S+Bg/qRPaYkn5bTDNFrwgys0pVcJ
	Oi9nyHdbo2nnEi3YC6fvtSVmtfAqqWnSAE2dcKswYokUX4e+7O3GeF4m6SdxyBE4GEakoe6
	+HoAIqpLL1GuLX+FBLwkrjdbu7NJoVeJR8SIKXnQxjLOfE99IB/3qPO5HMl5E8Qo+hZ9kMV
	WD9BPu7T3lDRGAItsGYfG/hzBaG01QAn/xRkMh9WwvohBB8Rc9DyNoLACrb0UKZyzFlg42E
	ad79U0EwYjk8g6e0rTMtfTIbhlni+0Ij9sY1w8Eg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

RmluZSwgdGhhbmtzLg0KDQpCUnMNCldlbnRhbyBHdWFu


