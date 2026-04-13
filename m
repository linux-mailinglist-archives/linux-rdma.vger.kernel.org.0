Return-Path: <linux-rdma+bounces-19271-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI1nKJiT3GkkTQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19271-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 08:56:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D783E800E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 08:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86A2F30055B3
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 06:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10587392C25;
	Mon, 13 Apr 2026 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="ejoCOThO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-edgeMUC220.fraunhofer.de (mail-edgemuc220.fraunhofer.de [192.102.154.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911A3164BA
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.102.154.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776063381; cv=none; b=sIV3OqkY136WENoffxQ5tl83GBRgHzyLRsiaxOcq4FEo7ALnbOBvv4MHwJd3pe+o90PnA8fa38ETvM02WHe+ZlWB7d63njKHNo04yfJrtxScYwcQtgzO2T4+2omua4TxF/JElIu0M6GOltF0o8UThh2YqIOUoJCmG+4WAofT9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776063381; c=relaxed/simple;
	bh=svoG3tn4Vjakjdnewdy4I6Cill5MvuGaI/SveubCNKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ryOYvz6/T4MmDnkLf5N5I88uciFM4hrmVOI12k5dJuIQeuZnLn9/QltlF30O4FzwPat2bpZhhrPXGBrtZX/l3uMlXnYRDod+bMdMk3YPjU7FqBlkbgZ/lyF4RmCNJVtIWSNpkI9r2zimc2eYzXcfBGN8uXm8gCM2FPYXgegRBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=ejoCOThO; arc=none smtp.client-ip=192.102.154.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1776063369; x=1807599369;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=svoG3tn4Vjakjdnewdy4I6Cill5MvuGaI/SveubCNKY=;
  b=ejoCOThOZUmu7aAns+6WftZACQKrx2N3XLhJ93EH/kpP6/jWciGbY9FU
   98Yl7l19B6te50F/GXXJigvGbLbpI8+1RzxaiUUFgpoE9vDUDfcSqMo4x
   dKbhh2bOGzIxeSIronf1AAqF20gJL4EKzT8ScOMCxk/PVDDZSxe8qBYSL
   jwGMnbZqtot9G1X3LhErczQJml0tDNlxME1wlj1Cbijer4U7jHKiiJbjz
   MR2zPdJwCUbBTf8s2BqIgb3ppBmCmigTwiBM1qVso+EKL0mqHEmryI01s
   YcnMzzOa74t37Aqfv7b/WjsJcKJoFnXeIaLJRMkHgSLMPcNitfnMoJyxb
   g==;
X-CSE-ConnectionGUID: WrUg9SCuRe+0PBAf+2SAoA==
X-CSE-MsgGUID: nONjw2Y2QTOBIGv6TveeHw==
Authentication-Results: mail-edgeMUC220.fraunhofer.de; dkim=none (message not signed) header.i=none
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2GNAwD8kdxp/x0BYJlaglmCQYEHgWqWTAOBE5tcgyoPA?=
 =?us-ascii?q?QEBAQEBAQEBCAE9FAQBAQMEhQACjSwnNwYOAQEBBAEBAQEBAgUBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQYBAgEBAQQIAQKBHYYJRg2CYgGBJIEmAQEBAQEBAQEBAQEBHQIUd?=
 =?us-ascii?q?gEBAQEDJxM/DAQCAQgRBAEBAR4QMR0IAQEEDgUIgnuCcxQGsR14gQEzgQHgK?=
 =?us-ascii?q?AYJAYFDhT6DGAEBhDyBIYUTggxDgRVCgjA4PoJhA4EXMBowg2OCLwSDMIRdi?=
 =?us-ascii?q?npSeBwDWSwBVRMXCwcFgSNDA4EGI0sFLR2BIyEdFxUfWBsHBRIhKm6DRXYuX?=
 =?us-ascii?q?hoOIgI5XEo+C1IFgXYCgR2BAgMLGyExPTcUGwMEgTWKZSOCaUNEAhc5SEKBH?=
 =?us-ascii?q?QPGNAMEA4I1gWeMHpVwF4QEjROGSZMLmQaOCZU0hVkCBAIEBQIQCIF+ggBxg?=
 =?us-ascii?q?zYfMxkPlzW7F3gCOwIHAgcNAwuReSOBSwEB?=
IronPort-PHdr: A9a23:zKFRix3SHLPeoTOusmDORwIyDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeCo601xwSWANmTq6odzbaN7+a4AS1IyK3CmU5BWaQEbwUCh8QSkl5oK+++Imq/AdjUKgcXJ
 4B8bmJj5GyxKkNPGczzNBX4q3y26iMOSF2kbVImbuv6FZTPgMupyuu854PcYxlShDq6fLh+M
 Ai6oR/eu8QYgYZuMLo9xgfGrnZGeelbxWxlLk+Xkxrg+8u85pFu/ipftv4768JMTaD2dLkkQ
 LJFCzgrL2866Mr3uBfZUACB/GEcUmIYkhpJBwjK8hT3VYrvvyX5q+RwxjCUMdX5Q74sVjuu9
 rlmRhD1hisfODE37G/YisprjKJGux2hvABww5TVYI6OKvVzeL7WcM4ASmpAWsZRUDFBAp+5Y
 oASAecNIfpUoo/grFYVsxCwGRejC//uyj9Qh3/5w6s60/g6EQrb2AAsBs8CvGjIoNnwMqoZT
 OK7w7TSzTjbb/1Yxynw5pXUch4vov+MU7B/ftbex0YgDA7FkkyQpZD5Mz+JyugBrW6W5PdgW
 +K1jG4nrhl8rjaqyMcrkInGnYcaxkjZ/ihlxoY6OMe4R1Bhbt6/HpdbqiaXOJFwQsw/WWFnp
 jw1yqYctZ64eygK0o8oygXFZPyGaIiH/A7sWPyfITdinn1lZbS/hxa18Uiu1OL8TNO430tUo
 SdclNTHq38C2QDJ5MedVvt94lmu2SyJ1w3L6OxJI0Q5mbTUJpMl3rM+mZoevVnBEyL4hUj7g
 q+be0Yn9+an9+nqf7vrqoGfOoJqiQzzMqsjl8ixD+klLwUDW26W8vmy2r3k+E32WrRKjvsun
 6ncqp/aI8YWqrS+Aw9P3YYu7Qu0ATS+0NkAgHUKLFxIdAiDgoXoIV3CPer0Aem7jli0jjtmx
 uzKM7PkD5nQMnTMirbscLNm5EJB1AY+yN9S6pxRB7wEIP/+XFL6usbCAR8jKQO0xv7qCNB61
 owDR22CGrSZMKbOsV+Q4eIvPvWMaJcVuDnjL/gl4ObjjXojll8ceamlxJ4XaGyiEfpjP0iVf
 37hjs0PEWcQpAU+UerqiF2FUT5deXmyRbgw6SwlB46+DIfDQJ6igKCZ0SumHpBbaHpKB1SNH
 HvyaomIQekAZSaKLs9kiDMEVLyhS4E71RGpsQ/306BoLuzJ9S0Cq53szsN16/fQlRE17zx7F
 N+Q3HuMT2FvgGwHWyU63K5loUNn11eD16h4g/tWFdNN/fNFSBo1OoDEw+xgF9/yQh7BfsuOS
 Fu+RtWmADcxTs8+wtMXeUZyBtCigQrY0iq0DL8aiaaLCIY38q3CxXjxIdhyy3Lc2KkmlVkmT
 dNDNXe6ia5n6wjTG4nJnl2dl6m0cqQc2jXA9GSdwmqUukFXTgpwXb/CXXAFaUvatdL56VjaQ
 L+0FbsnKhdBydKFKqZSdNHllU9GS+n9ONrdeWy8g2KwCgyJxrOIdYbqfnkd0z/eCEcejQwe+
 WyKNQYkBii7vmLeCjxuFVXhY0zy6+lysm60QVEsww6XbE1h1r+19wYNi/KTRfwdwK4KtTsnp
 TlsAVm92sjZC8CcqAd5ZKtSeMsz7lhf2WLCrwx9MIStIbh7iFAGfAp7p1ju1w15CopYkcgls
 ncqzA1qJKyAyV1PbzyWjtjMPejzJ270tCqobqfQ3U/F08ferqMC7/IQqFj5ugytUE04/CM0/
 cNS1i7WxZLQBk5aeJT9SEs+7FIy87jcbjMw7piS1np2O4G9syTP0JQnHuI4zBancdpFdq+JQ
 lyhW/YGDtSjfbR502OiaQgJaaULrPZc16KOcvKH3OumMOltuQ+N1z4fpo5n21+K9y1yR/SO0
 5tWi/2b3w7SUTD6gR/ht83sgolLaHkUGXb30inrAoNdJ+VycI8HBH3oIpixwdNz76M=
X-Talos-CUID: 9a23:zhGkwG9PGEgb+Gn0tuWVv3EOJ890SVbA9nqTe3eSIGgqEoa8TnbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AM+7WWA6uQD8hAis5+bHNkf/LxoxuxIKsFxo8y6w?=
 =?us-ascii?q?6nOOlGjIuBymQgRSoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,176,1770591600"; 
   d="scan'208";a="17480295"
Received: from mail-mtaka29.fraunhofer.de ([153.96.1.29])
  by mail-edgeMUC220.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 13 Apr 2026 08:54:55 +0200
X-CSE-ConnectionGUID: sub0g5tBTIW8stpes6h4ig==
X-CSE-MsgGUID: tR1Q/+cCSwCHCMw+ig9ZTg==
IronPort-SDR: 69dc933e_++wQeHkqQXLoiRMGj80wvzMr/YI3M4bgU4n3YYaIQAmwFYD
 DwcfKJrde0PJvV8yVIs7eaJi7eRtxEfN3FQ9JTw==
X-IPAS-Result: =?us-ascii?q?A0BVBQB1ktxp/3+zYZlagS6BK4FuU0EBRWGBCYgjA4Usi?=
 =?us-ascii?q?HkDgRObXIJQA1cPAQMBAQEBAQgBPRQEAQGFBwKNKyc3Bg4BAgEBAgEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQUBAQECAQEGBYEOE4ZPDYZaAQEBAQMSFRMGAQE3A?=
 =?us-ascii?q?QsEAgEIEQQBAQEeEDEdCAEBBA4FCBqCYYIkBBIDNgICAg4GpTQBgT0Ciip4g?=
 =?us-ascii?q?QEzgQGCDAEBBgQE2ycYgkoDBgkBgUODfoFAgxgBAYQ8gSGFE4IMQ4EVQoIwO?=
 =?us-ascii?q?D6CYQOBFzAaMINjgi+DNIRdinpSeBwDWSwBVRMXCwcFgSNDA4EGI0sFLR2BI?=
 =?us-ascii?q?yEdFxUfWBsHBRIhKm6DRXYuXhoOIgI5XEo+C1IFgXYCgR2BAgMLGyExPTcUG?=
 =?us-ascii?q?wMEgTWKZSOCaUNEAhc5SEKBHQPGNAMEA4I1gWeMHpVwF4QEjROGSZMLmQaOC?=
 =?us-ascii?q?ZU0hVkCBAIEBQIQAQEGgX4mgVlxgzYfMAMZD5IihRO7F0UzAjsCBwIHDQMLk?=
 =?us-ascii?q?XmBbAEB?=
IronPort-PHdr: A9a23:guyn0BcoV6groX3Fdfg8xKU7lGM+/N/LVj580XJao6wbK/fr9sH4J
 0Wa/vVk1gKXDs3QvuhJj+PGvqynQ2EE6IaMvCNnEtRAAhEfgNgQnwsuDdTDDkv+LfXwaDc9E
 tgEX1hgrDmgZFNYHMv1e1rI+Di89zcPHBX4OwdvY+PzH4/ZlcOs0O6uvpbUZlYt5nK9NJ1oK
 xDkgQzNu5stnIFgJ60tmD7EuWBBdOkT5E86DlWVgxv6+oKM7YZuoQFxnt9kycNaSqT9efYIC
 JljSRk2OGA84sLm8CLOSweC/FIweWUbmRkbZmqN5hGvAoW2kDbZvMhAxCiWZ5b0V7cRQjS96
 Z5FeBnilhwALRwnz0/x2s0opo5Ru0fywn43ydv+UKu8Cvs9UarmRcs+eDd+U5xyTAVFDIi1f
 tsXKMg+GudCoa7NgGFetRKwAVOTAvu27xV2mUCug4hr2tgOFzPvzksHGeIztX+Lr4TkK5gPW
 OekzKjZnA/eQNVT9AbNtK/vWSwaguiqT6IpLJWLlmtyCFjkiUutiY3eHRCWzvku7FqGwNJPa
 PqetjUGpgQtg2H0m8Zy25OYvIQT6Hnf2CJi+LgOGfKfWmNGRcHxQ9NA8iCAMI1uRdk+Bntlo
 zs+1ugesIWgL0Diqbwizh/bLvmbequhuEOlWvyYPDF4g3xoYvSzikX6/Uuhz7jkX9KvmBZRr
 yVDm8XRrH1FyRHJ68aGR/c8tkes0DqCzUbSv8lKO0kpk6rcJZM7hLk2k5sYq0PYGSHq3k7xi
 cer
IronPort-Data: A9a23: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
 xDyff7YmQT5gDuB7CY9h/BiLisg
IronPort-HdrOrdr: A9a23:cBX7PqwJuSGGvqqo/2mdKrPxj+skLtp133Aq2lEZdPULSKOlfp
 GV8MjziyWYtN9IYgBZpTnyAtj6fZq8z+8/3WB1B9mftWbdyQ2Vxe1ZnOjfKl7bamfDH4xmpN
 5dmsFFYbWaZzkbsS+T2nj+Lz9K+qjjzEncv5a4854bd3APV0gP1XYaNi+rVmFmTghPApQ0UK
 Gb+tdGoDSYf3EWZNSQB3UOXeTPzue72a7OUFojPVoK+QOOhTSn5PrRCB6DxCoTVDtJ3PML7X
 XFuxaR3NTuj9iLjjvnk0PD5ZVfn9XsjvFZAtaXt8QTIjLwzi61eYVaXaGYtjxdmpDh1L9qqq
 iDn/4TBbUy15rjRBD3nfIr4Xij7N8a0Q6i9bZfuwqnnSW2fkN/NyMLv/MiTvKQ0TtcgDg76t
 MM44vRjespMfvN8R6Nm+TgRlVkkFG5rmEllvNWh3tDUZEGYLsUtoAH+lhJea1wah4SR7pXY9
 WGIfuskMq+S2nqGEzxry1q2pihT34zFhCJTgwLvdGUySFfmDR8w1EDzMISk38c/NZlIqM0r9
 jsI+BtjvVDX8UWZaVyCKMIRta2EHXERVbJPHiJKVrqGakbMzbGqoLx4r8y+Oa2EaZ4hacaid
 DEShdVpGQyc0XhBYmH24BK6AnERCGnUTHk2qhllu1EU33HNcjW2AG4OSATepGb0osi6+XgKo
 eOBK4=
X-Talos-CUID: 9a23:aqu+FWwNfPZUEmNhOBCiBgUPB8p9fSDB5kvxHB+jFX5kU+OVFV6frfY=
X-Talos-MUID: 9a23:IurTsQiDIQma3Hb5txv3c8MpKP0x2uPtA2s2jr4mkOybdi1/agWhg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,176,1770591600"; 
   d="scan'208";a="53718085"
Received: from exo-hybrid-bi.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.179.127])
  by mail-mtaKA29.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 08:54:54 +0200
Received: from XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 13 Apr 2026 08:54:54 +0200
Received: from FR4P281CU032.outbound.protection.outlook.com (40.93.78.50) by
 XCH-HYBRID-03.ads.fraunhofer.de (10.225.9.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 13 Apr 2026 08:54:54 +0200
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR3P281MB3229.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:59::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Mon, 13 Apr 2026 06:54:48 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%6]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 06:54:47 +0000
From: "Korb, Andreas" <andreas.korb@aisec.fraunhofer.de>
To: Leon Romanovsky <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [BUG] librdmacm: Accessing out-of-bounds memory
Thread-Topic: [BUG] librdmacm: Accessing out-of-bounds memory
Thread-Index: AdzGjkqsA5mJJUzyRWCXQCvGuFkGawD9uvyAACMAD/A=
Date: Mon, 13 Apr 2026 06:54:32 +0000
Deferred-Delivery: Mon, 13 Apr 2026 06:53:25 +0000
Message-ID: <BE1P281MB24354B8B12B48B807C4453E5CA242@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
References: <BE1P281MB24351AAE7EF6E96BFC08D5C9CA5AA@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
 <20260412140401.GC21470@unreal>
In-Reply-To: <20260412140401.GC21470@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2435:EE_|FR3P281MB3229:EE_
x-ms-office365-filtering-correlation-id: f342f35f-2446-46ab-60b3-08de99298d72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: RjaTVYOO9VS38Q9JTQXce970N3CVW0v5C284W8ic+t0DSmFWH0HzqDxscRRExvRyoLTugIftmQrBk6N01qAKLyaQqJ7cBDhjdlEKVFPphE+dRP4VMKW+Wa6SavybDCQoVG5tQCZyYrKNPTHjvFj4hOz8z+DGy/BkEoTapAcxUduO+P276jMkYtuFBeHFJoaFG00bXjQnQPt4jxLZCA+PLzvYgS1kUvkBKyMBcN32YDMfzhAAv9ioADNn52/t0n7IEpB0bS+ULu9OXPvMP3snm6cVk06Gts4zvdkTn/8fHiY0aZ6hnOhp6NowkJIv0YSZfbCHxUUQNyVleuOWucPZxgAmC0Cirg+ywC8lDLI5RvxZemeW3cCpwsOgARZ/ho5tz7C3IeXtgm8LBTkMTOkw5CqTECBsTnZSGk9XdpPqIZOJfKwiyLpBEcayaz5W7DaKxcwHUdxbjUS977I9NXO2y8ekJ9oZb2Ph6rAgoB8PsgwaZFGvCyM7FbdbLImjOyvgpDYB0OZoKixu+R+Lf6x6AoIHR30/6o11Eg+Oi7RZSysoom7fJx05ESpf4eMRUuDC1LwhhUnTtBuLoM4JOR1Keu97rP7+tsRPInUaw2hZVNu77FrqffCt+J6cZ6x7ZNyoABrfP7ZNgycg9a1s/nwNNkT3zmW2MwDy8c6nD4HgOVt91dFu39EkC8mPwSph4vYavuDOljtmTs72ukZcwKaLcpJEYHTh50sMmpcFNhQr8KkGmFBRrB83o8jyWlDC0yxb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pJEqYJSV12pCOMIcIYff45wCSARHk16rd/TQPVZnqatKQfAdeBkydlbsu4wp?=
 =?us-ascii?Q?7MzPJt3S3mDf/qaMSoDZRBFttXgUeagjGNSmQThQgRYEJlO7yFxNAX4FN+/U?=
 =?us-ascii?Q?N6ECFzd2mH2ZbJpJMwGMzH1IKogGBtURq2/bIlBxKqaYJGcfvSxQGJcFRfW0?=
 =?us-ascii?Q?OM2hKvfHTntsQ87dsb5/kXShAA2xGx5ET+LKX20SdE3PQ2DAvYh+Y5mTGiz2?=
 =?us-ascii?Q?oXqMxNWfZ5BKRxs8/VopOUF6/y+ioqrGex9kzvvWIC1zoK2K4nhDfrktFrvx?=
 =?us-ascii?Q?gmgE26jWLjubwjatqTIigjI4qtLolZ9KCGvZNKtvS1DQ4eny1iLLYe0F4qhf?=
 =?us-ascii?Q?AWJSoHDGeuly/2ZEZLhM2UzL682hBfALFJfEuLTMqodYXcdaUK+JDlQLpNlj?=
 =?us-ascii?Q?3OdyhhY5u0P7iE15ZgWzPWmxI/GHr65fxkv4KHXnNCHXA3Xd0G+88GCmBSsm?=
 =?us-ascii?Q?ngUb+lpvGyETac3QIBbC7ynSe7S06JGJADdwq/devNPHcsAMsn8iuRUuhcdC?=
 =?us-ascii?Q?1Wl+wdlcg/qHkKJmO51wxk3bDoIV9MNwsb82TsYloAAk9ZdDhras+6tHnmXS?=
 =?us-ascii?Q?fJ4ehRJ8UWF37g81fp/Bnp1CFSbV7SyplkhSobID25/HIpFBtEjnqfCUmw30?=
 =?us-ascii?Q?ZdHRGqxcqwchgYvG4Q1UhkSV5+J26atDJGjgnzZxwKXNp7lBSjpJjREgtCYf?=
 =?us-ascii?Q?JGC8v/UzHSJRPSpKcUTMW5JsBYe8G7XXjqVmOoc87dkW3WobDn42dpc+TDyv?=
 =?us-ascii?Q?1bKRADt7k2tc3xI2hO3KF5lz4Rl+w+kkR9IIiI1CaOGY9CTbO6zbEuMW3cXU?=
 =?us-ascii?Q?cglsTh9smNjA3lqET3dlw+NxwVP1BE8nIpH8Q5qFXunHnRIkGTAnwwXzoCB8?=
 =?us-ascii?Q?6nB/0vLihzIwiwk7ryCOizNFOoz/ad1hytXkEnkHFtte/R7EFYSvvoJTfwpD?=
 =?us-ascii?Q?nkphs7st8f7Wv4ZXq/ZsRC8dj0fm7z/OTXDqYGbVdJwgrrINlrir8rjax2GM?=
 =?us-ascii?Q?mJJdQD1jGOJXXlorZXXRLTW8HAzwugS+p6gTU7kQMZr2T9UHw54pjzGJf3Zu?=
 =?us-ascii?Q?7ZB3RKJ0ViFXWrMWildrZ1Gp8vtYPDko6rUbfvyhNKZqeunhOwFV0NfvK0V+?=
 =?us-ascii?Q?Bl9MHR1hkvfQ+90b+4AdRHFQgkCm3SgqoHsuCk7x9rKmnIbf6cdx1pMR9wXM?=
 =?us-ascii?Q?DMEzYuxMLoV8/G2OVZcR6igMeQBTU438UpzWsYc2i3jvXQTE3rtiIuxdh2T+?=
 =?us-ascii?Q?hP1Q8v//fyNR46lvZUI2ulFJGgHMz8VpDPYdi/K+r1UlSkI8AaPjupYa9H9M?=
 =?us-ascii?Q?pkAsOPE3mcBhXda3BySByYXyq+ZS24fHQnfpsTXfX/+PF61sJUieQM/1DR6v?=
 =?us-ascii?Q?rTcBAFYqBEZ95RLTa/iLAXVYnnNcPk/epGIibG+VuipyolY+Mib1+b2Wh1X2?=
 =?us-ascii?Q?6J2zH4BsLrxd/sYnfn6q7Q4n6RCd+oFA5JsUoM2l8B1CjRsXu2HJ5HQkFAST?=
 =?us-ascii?Q?y8/Cz7HrpoL7ubDQWsNnNonviNM21JKGm48mnTeOCyHfniYqfSVHCgyRICJE?=
 =?us-ascii?Q?VUPVqc2KI0xPHs+gUiRAzm1i72C/1mOKeR+Ig7QXObgTMNZj00DsK2U4k7pj?=
 =?us-ascii?Q?W2cJNzFprEbb+HHE3rXtSldrHamcIDo7ZOd3+5hq9KWlcnmvYHc4o3ks+QSK?=
 =?us-ascii?Q?GNZpBnGoZ5YAGx29zCRI82xEc8XBw6d8czduTZ7WCSjx6QncjfbKMx8nl0AN?=
 =?us-ascii?Q?EguIPg1fiKPBhh8q2R6GMYZDb4zCi08=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Wcc4jiL2ytiViKl4N8qJ4HWWnaWN+8QuYUERhUaHIjKl9EItDLecR20X4dhte1jI7xlreCSbJiwtGsGCsnpuG9QWWpJxo/DzR0qpfri74WujlpY9hXotcPd5NuBqmN38TkHn7c4rCTbLHFT8TNZyM4tl0nOdrLXaPw3amK64mN4QXvkgAiBrKeUU7PvHw+4fjUK+w9SQHG6/q/XSDimJKcTGxFAr/6tkuW/wzBiGmCI2ReNtrkcPn6MARwsUlklz63TF07UIiNV/k2LPQsREZXC34nocsBQASJCR1+UNIZATwtHfsB6ec9vmtIU0h3Fitnqc4DFJZ3qhnaJcHyvcWw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f342f35f-2446-46ab-60b3-08de99298d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 06:54:47.8381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccbUUzMaxmFqRAVRipPPcc+E0nLrU9I8jZZ264xt5vqNizpqCGu+YOJctd2Ot8jjeBI1GtMCE41MAPcin325MuyIowABu9sr0VYjbc/E42gVykuh85OC7Iy5FOCZ+2wi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3229
X-OriginatorOrg: aisec.fraunhofer.de
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[aisec.fraunhofer.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[aisec.fraunhofer.de:s=emailbd1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19271-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	URIBL_MULTI_FAIL(0.00)[man7.org:server fail,BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM:server fail,sto.lore.kernel.org:server fail,fraunhofer.de:server fail,aisec.fraunhofer.de:server fail];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aisec.fraunhofer.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreas.korb@aisec.fraunhofer.de,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[aisec.fraunhofer.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 21D783E800E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Sonntag, 12. April 2026 16:04
> To: Korb, Andreas <andreas.korb@aisec.fraunhofer.de>
> Cc: linux-rdma@vger.kernel.org
> Subject: Re: [BUG] librdmacm: Accessing out-of-bounds memory
>=20
> On Tue, Apr 07, 2026 at 01:14:45PM +0000, Korb, Andreas wrote:
> > The function `ds_init_ep` in librdmacm/rsocket.c may access memory via =
an object that is not allocated for this object.
> >
> > Relevant lines from this function:
> >
> > // (1): Prepare `struct rsocket`
> > ds_set_qp_size(rs);
> > // (2): Allocation
> > rs->sbuf =3D calloc(rs->sq_size, RS_SNDLOWAT);
> > // (3): Copy pointer to rs->smsg_free
> > rs->smsg_free =3D (struct ds_smsg *) rs->sbuf;
> > // (4): Copy pointer to msg
> > msg =3D rs->smsg_free;
> > // (5): Write to msg->next
> > msg->next =3D NULL;
> >
> > Within my podman container:
> > Before (1): rs->sq_size =3D rs->rq_size =3D 384
> > After (1): rs->sq_size =3D rs->rq_size =3D 0
> > Therefore, (2) does not reserve a buffer, but still returns a pointer w=
hich can be freed later, as described by man-page calloc(3p).
> > (5) writes data to the buffer allocated in (2). If no actual buffer is =
allocated, it overwrites arbitrary data, yielding undefined
> > behavior.
> >
> > I found it by executing /usr/bin/udpong (without any arguments) with li=
bscudo on an arm64 server with memory tagging enabled. It
> > immediately crashes with a segmentation fault, then. Without memory tag=
ging, the bug stays undetected, and execution continues.
> > The code behavior described above also happens on x86-64, there it does=
n't result in a crash and is silently ignored because of the
> > lack of MemoryTagging. Valgrind also detects this violation, however.
> >
> > In summary:
> > The libc man-page states that if the allocated buffer size is 0, then e=
ither:
> > >        *  A null pointer shall be returned and errno may be set to an
> > >        implementation-defined value, or
> > >        *  A pointer to the allocated space shall be returned. The
> > >        application shall ensure that the pointer is not used to
> > >        access an object.
>=20
> Can you please provide a link to these sentences in the manual?
>=20
> You provided invalid value as sq_size and rq_size. It is expected that
> library won't work after that.
>=20
> Thanks

These sentences are from: https://man7.org/linux/man-pages/man3/calloc.3p.h=
tml

When the incoming values of sq_size and rq_size are wrong, that is a
bug in udpong then. However, since librdmacm is doing the calloc allocation=
,
it should still refrain from undefined behavior with the own allocated buff=
er.

