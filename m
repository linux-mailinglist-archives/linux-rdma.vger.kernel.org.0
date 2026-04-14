Return-Path: <linux-rdma+bounces-19326-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Cc6LSn93WlLmAkAu9opvQ
	(envelope-from <linux-rdma+bounces-19326-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 10:39:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1359C3F7721
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 10:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AC2C301E988
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 08:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B723B6BEB;
	Tue, 14 Apr 2026 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b="YN0n5nSV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-edgeBI195.fraunhofer.de (mail-edgebi195.fraunhofer.de [192.102.163.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91E39A040
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.102.163.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155894; cv=none; b=suITCc8MomPjqJXqBtugFDbNdg5wspouBo5arXyGPLxP2iG4M1nNV1lhrmVEuUBT7KJ93VWigPnFKGvMXlB6Nm9j9LrOfSjIp2jrLqhyw2MNalGS7+YaGyKufvh4d0nAs2v4sk+y5uhm/+PeZpATiOL25ch2a9fqpQ/49NOdCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155894; c=relaxed/simple;
	bh=1qySHBt3v1DCI2XwMSr1ujmCYk9PpB5qkr0qMBJPYJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M5Bo1b6fdVrnXJT6TzszBED/NEk6FZ+vQxUj6ej+ooMXvLtVNWUbCgiXpYSYxV7yKBzcEr6k3bDiJAlD03eXIZH2M+iNCmI8Av5/tkTo/hq+QjYoBRpHnOEVDC5+psBLz7s2XAY5edJNM1EBBuqRRXjKVhgJ3ehHhMioTYKEASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de; spf=pass smtp.mailfrom=aisec.fraunhofer.de; dkim=pass (2048-bit key) header.d=aisec.fraunhofer.de header.i=@aisec.fraunhofer.de header.b=YN0n5nSV; arc=none smtp.client-ip=192.102.163.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisec.fraunhofer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisec.fraunhofer.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=aisec.fraunhofer.de; i=@aisec.fraunhofer.de;
  q=dns/txt; s=emailbd1; t=1776155884; x=1807691884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1qySHBt3v1DCI2XwMSr1ujmCYk9PpB5qkr0qMBJPYJ4=;
  b=YN0n5nSV3KK9Yx/tMVURhiPmPQ5DvJ62TNyCRgHp++xCL4c5vO0/XXZC
   ab21tANfdv7a20KSwF6tF3qEoCfxIOSd+vo8NKFEZkv+QgjCL4bPZEUph
   W/THKEuhGj36+JBTOOhY6rrQh5ZQTONqRtYWMomivU3n4v07KOFtx2zFD
   CwJ5s5Vcn7R/Jrmxr1ptxGJTeRYxjPVCjB9WfyHEX7ZRzG0d0wy25oocx
   aXgIZ8kSvkN4dqyUnO5RnZMsp2VUZfDkrSTCunVBmWgGt21RSRn1/uGLs
   llS14N3OuFYUt/Da3H3O+csbncyCItxli4dXS3utrUGAwPPgj8isxiSOi
   A==;
X-CSE-ConnectionGUID: cXyM1cZQQBSfeYHeNip5mA==
X-CSE-MsgGUID: kF2wj8g/R86N2aN/wqxxxQ==
Authentication-Results: mail-edgeBI195.fraunhofer.de; dkim=none (message not signed) header.i=none
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2H3AwAQ/N1p/xwBYJlahRqBB4FqlkwDgRObXIJrPw8BA?=
 =?us-ascii?q?QEBAQEBAQEHAQFKBwQBAQMEhQACjS4nOBMBAQEEAQEBAQECBQEBAQEBAQEBA?=
 =?us-ascii?q?QEBCwEBBgECAQEBBAgBAoEdhglGDYJiAYEkYAc/AQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEGAg0HdgEBAQEDJxM/DAQCAQgRBAEBAR4QM?=
 =?us-ascii?q?R0IAQEEDgUIgnuCcxQGtC54gQEzgQHgKAYJAYFDhT6DGAEBhDyBIYUTggxDg?=
 =?us-ascii?q?RVCgjA4PoJhAQEBAYEWMBowg2OCLwSCIoEOhESKdVJ4HANZLAFVExcLBwWBI?=
 =?us-ascii?q?0MDgQYjSwUtHYEjIR0XFR9YGwcFEiEqboModi5eGg4iAjlcSj4LUgWBdgKBH?=
 =?us-ascii?q?YEDAwsbITE9NxQbAwSBNYpTIoJpQ0QCFzlILRWBHQPGNAMEA4I1gWeMHpVwF?=
 =?us-ascii?q?4QEjROGSZMLmQaOCZU0hVkCBAIEBQIQCIF/gX9xgzYfMxkPkiKFE7pFeAIJM?=
 =?us-ascii?q?gIHAgcNAwuReSOBSwEB?=
IronPort-PHdr: A9a23:ev9dJBLVBrJdoE66ptmcuKRgWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEuLM11BSVBduLo7Ic0qyK6PymATRBqb+681k8M7V0HycfjssXmwFySOWkMmbcaNPMUWkRM
 f8GamVY+WqmO1NeAsf0ag6aiHSz6TkPBke3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55I
 AmroQnLucQbj4tvJrwtxhfVrXdFdPhayGJrKFmOmxrw+tq88IRs/iletP8t7dJMXbn/c68lU
 bFWETMqPnw668HsqRTNVxaE6GEGUmURnBpIAgzF4w//U5zsrCb0tfdz1TeDM8HuQr46QTut4
 751RRHnlSkLLzE2/n3Zhcx2l6JbvQmupwdjzI7OYYGaL+Rxc6XAdt4HX2VBX8JRVytcAoOga
 oYEEuQMMfpEo4T7ulADtgW1CxWyC+zzyz9Inn720rM80+Q9CgHNwQgsE8sTvHjIsNn5MaEfW
 v23wqbV1zXOd/NY1ynj5YbVbhAvr/KCXbxyfsXNxkcgGBjIjkmJqYD5Iz+ZyvgBv3ad4uF9V
 eyvkWknqwRprzShw8ksjZPJiZkQxVzc6C503IA1KsCiSEFle9GkC5VcvDydOoRsRMMtXntot
 zggxb0do5K7fy8KyI48yBPEcfOHcpOI7Qz/W+qLLzd4nmhqeK+5hxay9kigxPPzVtOu3FlXs
 CVIi9/BvW0C2BLP8MaIUOd9/lu/1jaV0QDe8u5JLE4omafZN5Is3rE9m4YcvErMGiL7l0X4g
 q+Se0g5+eWl5eXqbqjkq5KYOYJ4lx3zP7kul8CiAeo0LhUCUmud9O+h2rPj+kj5T69Ljv0wi
 qTZtYrVJcIZq6KjBA9VyIkj5w6wDzenzNQYnWQHI0lfdB2biIjpPlfDK+37A/enm1mgjTdmy
 v7cMrDlA5jBNGXPnK3/cbt+80JQ1gs+wcxR6p9RF70NPOj8V070udPDExM1Lwm5zunpBdh40
 44TWWSCCbKDPqzIq1+H/OcvLvGJZI8SpTnyNeAo5+XrjX8lgV8derSp3YcPZHC4APtmJ0KZb
 GLpgtgbEGcKuhMyTOn2iFKYVDBee2i+UqEm6jE1EoKpF5rDRoatgLyG0ie0AIdWanpbBV+SC
 XvodoOEVOkQaC+KP8NskjIJWaKlRoIgzx2iqRX2x6RkI+bM/y0Xr5Pj1Nx75+3JkhEy8CR5A
 N6b026QVWF7gHkHRyQs0KB8pkx90EyM3LNijPxZDtxc+e9GXh00NZ7G1eN6FtbyWgLGfteHV
 lmmWM+qDiwvQd4p2d8Bf159G8m+jhDExyeqB74Vl7qWBJ07667cxWX+J8NnxHvdyqkhgEcpQ
 tFVOW2lmKF/7Q7TCJDNk0mDkKaqb6sc0DbX9Gif1WqOoF1YUAloXKXBQ38fYU3WoM/65kzcV
 b+uD6ooMg9bxc6FMKtKZcXljVNdS/j7ItTRf3qxm3usBRaP3r6AcpLme38D0yXDC0YKiRge/
 XOcOgg/AietumfeDCB0GlLseUzg7+pzpGm1Tk8u1Q6Kckth17qy+h4bm/OcUekf0a8atys5t
 jp0H1e939fOBtSYqARucrtSb88h7VlBzW7Wqgl9MYa6L69+nlMQax15sVvh2RlvEYVAicYqo
 WsywgRrMayW30tNdyiA3ZD+IrLXKnf9/BSoa6POwl/Qyc6Y9KhcoMg//nHuuwfhLE0n+nNgz
 cJWwjPI4pjNCiIRXIj3X0Jx8AJ18eL0eC44ssn30mdmdeGdtDPY1tsyTqNxwxCsZdpWK+WHE
 xX4O8QbHMWlbuIwkkWvbhUKMfoU+KNibJDuTOePxKP+ZLUopzmhl2kSpdkliipklgJ5Q+/Mm
 psJzPyy/1LWCnHyll68tMDwl41eIz0fTSKzyinhUYhWYKA6PYMGEnynLMD/wNJiz4XsVHhV+
 B/rB14P1MKzPxvHaVv70GVt
X-Talos-CUID: 9a23:36adAW+rD1D1WsqFTYmVv0UkC+V8eU/k9V3rLUKJKWtPSaXITHbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AbLVTJw3CkgYhdNcYytfN15sIiDUj4Ir0F0JdntI?=
 =?us-ascii?q?865eibyVWfCiEnCSne9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,179,1770591600"; 
   d="scan'208";a="18675383"
Received: from mail-mtaka28.fraunhofer.de ([153.96.1.28])
  by mail-edgeBI195.fraunhofer.de with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 14 Apr 2026 10:37:54 +0200
X-CSE-ConnectionGUID: dYv302PpTl6CYnVDDs+FdQ==
X-CSE-MsgGUID: 3CqK136UT2OQfi/c7hXwGA==
IronPort-SDR: 69ddfce2_QF92xOFT4m8wDSkcmqRJW8xAbOOYq6Mr3Qme4nkiv+dGH3K
 c7OktnL6FxOs3vcF3joNTkOSMX4VpgB1lOvrexg==
X-IPAS-Result: =?us-ascii?q?A0DvBQAQ/N1p/z6wYZlagS6DGVNBAUVhgQmIIwOFLIh5A?=
 =?us-ascii?q?4ETm1yCUANXDwEDAQEBAQEHAQFKBwQBAYUHAo0tJzgTAQIBAQIBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEBBgWBDhOGTw2GWgEBAQEDEhUTBgEBNwELB?=
 =?us-ascii?q?AIBCBEEAQEBHhAxHQgBAQQOBQgagmGCJAQSAzYCAgIOBqhEAYE9AooqeIEBM?=
 =?us-ascii?q?4EBggwBAQYEBNsnGIJKAwYJAYFDg36BQIMYAQGEPIEhhROCDEOBFUKCMDg+g?=
 =?us-ascii?q?mEBAQEBgRYwGjCDY4IvgiaBDoREinVSeBwDWSwBVRMXCwcFgSNDA4EGI0sFL?=
 =?us-ascii?q?R2BIyEdFxUfWBsHBRIhKm6DKHYuXhoOIgI5XEo+C1IFgXYCgR2BAwMLGyExP?=
 =?us-ascii?q?TcUGwMEgTWKUyKCaUNEAhc5SC0VgR0DxjQDBAOCNYFnjB6VcBeEBI0ThkmTC?=
 =?us-ascii?q?5kGjgmVNIVZAgQCBAUCEAEBBoF/JYFZcYM2HzADGQ+SIoUTukVFMwIJMgIHA?=
 =?us-ascii?q?gcNAwuReYFsAQE?=
IronPort-PHdr: A9a23:nlCM1hKdvBpmpDniFdmcuChnWUAX0o4cQyYLv8N0w7sbaL+quo/iN
 RaCu6YlhwrTUIHS+/9IzPDbt6nwVGBThPTJvCUMapVRUR8Ch8gM2QsmBc+OE0rgK/D2KSc9G
 ZcKTwp+8nW2OlRSApy7aUfbv3uy6jAfAFD4Mw90Lf7yAYnck4G80OXhnv+bY1Bmnj24M597M
 BjklhjbtMQdndlHJ70qwxTE51pkKc9Rw39lI07Wowfk65WV3btOthpdoekg8MgSYeDfROEVX
 bdYBTIpPiUO6cvnuAPqYSCP63AfAQB02hBIVjab3TGqb5nKlyuguelR3nGCLfL9YJwVQRH/7
 r9bRjLDtw4EEGFhyz3lpukl38c56Bj0pQV50d7ff7i/OdUjUp7ET9kUGGZkZP5scjN5KaehV
 IZMPuY/Attq9o6kmQNJqz+gFzK0X/ys0Wds2WPUhoQEz7oBCwz37A4/QPIk63mNk4zeK/9Cb
 fC/kqvanArqV91IiRPf5q6ZeEk+oKyrdOoqQ5bJxU4mTh/M0Ge+oqa9ZQyvifZWgVC+zfBMb
 9O9s14jtTFRuCWNwctv24Db249IxXfv7QpC7J5vA+KFHR0zcZulCpxWryaAK85sT9g/R309o
 C8h0e5uUf+TeSELzNEi2xf8QqbXNYaS6w/lVOGfLC0+iH82ML68hhPn6UG70aW8Tci71l9Ws
 zBI2sfBrHED1hHfq4CHR/Jx813n2GOn2Rra9+dEJk45j+zcLZsgyaQ3jZ0drQLIGSqepQ==
IronPort-Data: A9a23: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
 R6NACdqmQX5h/8GrJGNVxVjLg==
IronPort-HdrOrdr: A9a23:nsj/ka21t+VaONt2PDg4HAqjBLokLtp133Aq2lEZdPU1SKGlfq
 WV954mPHDP+VUssQ4b6LW90cW7Lk80lqQFg7X5X43DYOCOggLBEGgI1+rfKlPbdREXbIZmuZ
 uIepIObOHNMQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AZAH6QGkoyU9L3Pamwpx1asCKh5DXOXHs0iyIeXe?=
 =?us-ascii?q?gNWI3Y4yTd3O84+BKn/M7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ALeD/cQwvBZmofoBuNtVjnpwwJeiaqP+FEWNUyss?=
 =?us-ascii?q?7h5OjDCJxfDzCjASobaZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,179,1770591600"; 
   d="scan'208";a="53879614"
Received: from exo-hybrid-muc.ads.fraunhofer.de (HELO smtp.exch.fraunhofer.de) ([153.97.176.62])
  by mail-mtaKA28.fraunhofer.de with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:37:53 +0200
Received: from xch-hybrid-05.ads.fraunhofer.de (10.225.8.50) by
 xch-hybrid-05.ads.fraunhofer.de (10.225.8.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 10:37:53 +0200
Received: from FR6P281CU001.outbound.protection.outlook.com (40.93.78.4) by
 xch-hybrid-05.ads.fraunhofer.de (10.225.8.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 10:37:53 +0200
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::5) by
 FR3PPFACB69CFAB.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::17c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 14 Apr
 2026 08:37:52 +0000
Received: from BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb]) by BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae34:1ec2:9d34:a9fb%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:37:52 +0000
From: "Korb, Andreas" <andreas.korb@aisec.fraunhofer.de>
To: Leon Romanovsky <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [BUG] librdmacm: Accessing out-of-bounds memory
Thread-Topic: [BUG] librdmacm: Accessing out-of-bounds memory
Thread-Index: AdzGjkqsA5mJJUzyRWCXQCvGuFkGawD9uvyAACMAD/AAE21sgAAikXfQ
Date: Tue, 14 Apr 2026 08:37:38 +0000
Deferred-Delivery: Tue, 14 Apr 2026 08:37:16 +0000
Message-ID: <BE1P281MB24357992741C16BFEF1E33B3CA252@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
References: <BE1P281MB24351AAE7EF6E96BFC08D5C9CA5AA@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
 <20260412140401.GC21470@unreal>
 <BE1P281MB24354B8B12B48B807C4453E5CA242@BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM>
 <20260413160227.GM21470@unreal>
In-Reply-To: <20260413160227.GM21470@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2435:EE_|FR3PPFACB69CFAB:EE_
x-ms-office365-filtering-correlation-id: f93cfed9-6183-446c-2912-08de9a011df3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: k0XIfU4vYXaBHhadOWi04nm9GxfACmE9Pha/cCxP6VMS/bgb0RQ7/IgRVlbOwLuv0+u0cLIovlqerbh1MV7unxHrEHOtIH4r1eBf1XgzWzz4pBr1eY4BQaR4i/E0ixv9iMwMzqYTaf6AeP37vCaw/GeoEHM/5pju2FHMciW9UVcdV0TyVMKWklD/nGlEjeH2IPTrOPIn36nX8UvOlJBgqFTyp5S4Uy22HbltGnzACGpG/9eaufluRgXSQrt2h+zFKn8wO1xybzNGB80oQIwTOa7kqNHVbaYZwazSj4owmHMCAtINYTezBTjbvx1M4MU2UOiH7SSzBpIxyLx1nvnmZLRh4qkZ6zCRRejSFrOdyrimaUbpPT9VeyX+4L8XGUeB8CTp/sGYVerlGaBaOT9KYbk+fTCmaO78Ry2uzis2woYSFMwicpiIphNFYctpEgRcz2p+cDFVqLhwhNHLH1u/PirpTffOILpE5pPBmRzMPLx5YfZl+hP0SoMIQTWcqHGwS9twZcgdqrXjHGDC22iQGq8LBNZr+M9Oc1ccaCsnmpQLNo7h643zeKXCaysjNlJ/8kdJYSk/m0Eq80nD1xRQkUPOstiRv9gGFmpPY/rFQoZFpQAH5kTgyc9nhgxMYzPJtR9X6lDWwFL0nZhJPKCqs5AzlGK90pinlEEUSelwRHmSyvfUMuMhNe6cM0g8BO5ceUtjpqLACOBMWRe0YC64qJJrJgJlYXcXUqdVLkigMSuijjh8G46eY3pBlQtdo9s6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vf72/ZoTVtRhUnchQExFYldaRDs3WfRT6LHFSVofZ/RraFYYxrniqqSxRi0v?=
 =?us-ascii?Q?U/aWGMWr6zm9KfIan/rBADUTK/RvaFwJ1VYT/0oTgIFBEaM70UOv3bD6pqec?=
 =?us-ascii?Q?3OZmsAkYltaFuXLU3MkQBcdPLPzeL715Jw+FPRTXdnhTdS7DwOy+jAF6QrwV?=
 =?us-ascii?Q?nF04EpWbHU5HLxDmDA9tHD7thQMzlMu9ez+WIPgLlDGY3OjZBSd179TX+6PL?=
 =?us-ascii?Q?/8iaDRJLHQHaumCVpkhb1/wsNLor4kCcGqPbUQ4cceVxHirJYXt1svdM53S3?=
 =?us-ascii?Q?TTSFCUYVpOS4rYl0n23JLrP0FjQ3yvhmmETJebv4tyVKpy+oL6jDJezN9cSJ?=
 =?us-ascii?Q?/BeT/baD5F0gERyMI4yqi9pR8f8Zyc6A6TuRv92wBRNozHQPf5kvjY6Vt6bh?=
 =?us-ascii?Q?RH9S7cLavMLyzsDRpbuu9Lz1Y0dc38w6oJANhxgdrLRwTz9wWBLngCw+Ipgz?=
 =?us-ascii?Q?/Ezas2jkdGan4yI2Y3eLLZgTdMSOJeF+1MOJHZOrGK3DCXsWkebPoATy1qEp?=
 =?us-ascii?Q?Rq5fERy849StMhFKCCTQ8Nb6HMnD2EOB7G1n2QBiLLGWbr4AJ0t2L4WuV3lF?=
 =?us-ascii?Q?1w94UZHfxOOL7Vd+M+Ufr1x7YY1FNFN4oWMol/cG6nrwKN7QVUWknTvihyfd?=
 =?us-ascii?Q?roLSEeBELM6jUF0bPibcw/P8n/99dT56hc/CP28S9kCpffIEMBo6GZEYXV94?=
 =?us-ascii?Q?3AaC55PxFUi+v3a8yffOD8QSlpC1UGuLLV25nkOtaYQLNd03fj9mTevnv0rv?=
 =?us-ascii?Q?eMFZgcxQniOvX6mjba+TDvtOn8cb9gUclhnj9pV8/THT6R1Nbkplg5PWtAvd?=
 =?us-ascii?Q?2pupPztYK8viuFv/hCrmUcCPfXGXgJS+GyjTx7DvQmOQu9kY8TUOujUELgSm?=
 =?us-ascii?Q?nOktq7VB34hqSVLEa9ZQNsaQ+QD/331ywDhkvRo+dHqRFryzKBTVVcAdoqxP?=
 =?us-ascii?Q?k2MhI0ut7L2Z0CmwWFZUcM46DKdzZNvabuEg0yVfQoP/rTbfzO8+5voilGSj?=
 =?us-ascii?Q?93DGxFhk7z2LxoKor+l+M1yxdYKzErKCVPXCl6qv8cIwc69IjuHhE9HaSuxr?=
 =?us-ascii?Q?tvsZRwwNIpjKoknAZlAF6lEU8dqFcpxjfytoFIq9UDhAorV8dLK+OYwIBiJy?=
 =?us-ascii?Q?fBfFfcISHcC9PVemVThvPx5N6dbeqBEZFey0d63TSrDuGH458RSftrpE83Ed?=
 =?us-ascii?Q?yVCfc/KjKOgbsafqnYps7d/EatcP7lNIbjDmM4wg+Sqd+UvhTW5RwnfO/N/k?=
 =?us-ascii?Q?PIHZGd8OaaRuu/FnsBOhpelJcnNzG1CCzY4FauUlh3BRUkV5dfj95X7Cwsty?=
 =?us-ascii?Q?4QUweuzdCtF/+3+ruQ8w4ZM2cGnVMcQxyXxfCSYPzZPx1Bd4y12idBh61ake?=
 =?us-ascii?Q?mMk0BNZN7sv1rCnomhX7J45VD97AK3GqksScc5BVRYtGalpG0xf22HSYEh+N?=
 =?us-ascii?Q?GU53PCEuUmPZrwQWuwfB4w5x6fOYrMzQPca5XiU277pqVO9FQer+T6EP39wj?=
 =?us-ascii?Q?6UQPpqkYXD3x0nriWy7vLrL5Lca0TewyryMscMTNlZbU2Me6nAbh72WHQstn?=
 =?us-ascii?Q?0QUpfMcbOyNuEl6RI7eDMNL6QluW88yaZ1zHTTH6fM/GCwj9YOKgGso435dJ?=
 =?us-ascii?Q?ONZBDi6oNosa3L5oPhNzhi+W2ejpWnAC7qttjyI2tt/FBqpYwQjqv72hLMH7?=
 =?us-ascii?Q?Cs13VdkryGH6VJGWWQZM2+w+hbknkkqqTx/der176OsCx5rkhc2Ku1kM6TZM?=
 =?us-ascii?Q?kVHFK7fCY9iAsv+XpzCCjoZYHi/oXhY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wMW/TMppB2th7UHhNY92NZut3sAl5wvF9F01yDneW4N5q+uI2iPnnimDW/GLWUR1dJDAmTW0iQ7dPWc2QHgMlXHNQAKoYZWvm+iJPzMdRwp5GT7FmQVlsR+ooPXwNQuRA9VKUGtLZRasXhPafSuVp0cE9wrMdHEnVktpB8CkKSR+Z2EcYtD5itRxzXcePixAPv74OxF074/8LsnUW/7fYtsNpWvv0G/VY/unijrQ486jPEfDcm5ZIJWVeFqXWGB+OYwkRU4L52WXwmLUd7cX3KOmGusf7ru7jQjTEc0TtrY1KnMYKMxLJkxwvitLjcXtSvXzh/eYTLsxUOUhEFIxgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f93cfed9-6183-446c-2912-08de9a011df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:37:52.1059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7SPPDOj0DdkU5PycxLxH+kYsJ3FRb1Q+HoMVb7ii+xbYyLKFAADnSrsBvzq6EvDatEp1cNH/EM+TpbyjH0JiF9GHZTDviH0sVz0jU2CwAU1i6uSDbs8CTzYVntQlHyX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPFACB69CFAB
X-OriginatorOrg: aisec.fraunhofer.de
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[aisec.fraunhofer.de,quarantine];
	R_DKIM_ALLOW(-0.20)[aisec.fraunhofer.de:s=emailbd1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19326-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,BE1P281MB2435.DEUP281.PROD.OUTLOOK.COM:mid,fraunhofer.de:email];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[aisec.fraunhofer.de:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreas.korb@aisec.fraunhofer.de,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1359C3F7721
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Montag, 13. April 2026 18:02
> To: Korb, Andreas <andreas.korb@aisec.fraunhofer.de>
> Cc: linux-rdma@vger.kernel.org
> Subject: Re: [BUG] librdmacm: Accessing out-of-bounds memory
>=20
> On Mon, Apr 13, 2026 at 06:54:32AM +0000, Korb, Andreas wrote:
> > > -----Original Message-----
> > > From: Leon Romanovsky <leon@kernel.org>
> > > Sent: Sonntag, 12. April 2026 16:04
> > > To: Korb, Andreas <andreas.korb@aisec.fraunhofer.de>
> > > Cc: linux-rdma@vger.kernel.org
> > > Subject: Re: [BUG] librdmacm: Accessing out-of-bounds memory
> > >
> > > On Tue, Apr 07, 2026 at 01:14:45PM +0000, Korb, Andreas wrote:
> > > > The function `ds_init_ep` in librdmacm/rsocket.c may access memory =
via an object that is not allocated for this object.
> > > >
> > > > Relevant lines from this function:
> > > >
> > > > // (1): Prepare `struct rsocket`
> > > > ds_set_qp_size(rs);
> > > > // (2): Allocation
> > > > rs->sbuf =3D calloc(rs->sq_size, RS_SNDLOWAT);
> > > > // (3): Copy pointer to rs->smsg_free
> > > > rs->smsg_free =3D (struct ds_smsg *) rs->sbuf;
> > > > // (4): Copy pointer to msg
> > > > msg =3D rs->smsg_free;
> > > > // (5): Write to msg->next
> > > > msg->next =3D NULL;
> > > >
> > > > Within my podman container:
> > > > Before (1): rs->sq_size =3D rs->rq_size =3D 384
> > > > After (1): rs->sq_size =3D rs->rq_size =3D 0
> > > > Therefore, (2) does not reserve a buffer, but still returns a point=
er which can be freed later, as described by man-page calloc(3p).
> > > > (5) writes data to the buffer allocated in (2). If no actual buffer=
 is allocated, it overwrites arbitrary data, yielding undefined
> > > > behavior.
> > > >
> > > > I found it by executing /usr/bin/udpong (without any arguments) wit=
h libscudo on an arm64 server with memory tagging enabled.
> It
> > > > immediately crashes with a segmentation fault, then. Without memory=
 tagging, the bug stays undetected, and execution
> continues.
> > > > The code behavior described above also happens on x86-64, there it =
doesn't result in a crash and is silently ignored because of
> the
> > > > lack of MemoryTagging. Valgrind also detects this violation, howeve=
r.
> > > >
> > > > In summary:
> > > > The libc man-page states that if the allocated buffer size is 0, th=
en either:
> > > > >        *  A null pointer shall be returned and errno may be set t=
o an
> > > > >        implementation-defined value, or
> > > > >        *  A pointer to the allocated space shall be returned. The
> > > > >        application shall ensure that the pointer is not used to
> > > > >        access an object.
> > >
> > > Can you please provide a link to these sentences in the manual?
> > >
> > > You provided invalid value as sq_size and rq_size. It is expected tha=
t
> > > library won't work after that.
> > >
> > > Thanks
> >
> > These sentences are from: https://man7.org/linux/man-pages/man3/calloc.=
3p.html
> >
> > When the incoming values of sq_size and rq_size are wrong, that is a
> > bug in udpong then. However, since librdmacm is doing the calloc alloca=
tion,
> > it should still refrain from undefined behavior with the own allocated =
buffer.
>=20
> I don't think so. This buffer is allocated in application memory, and if
> the application is buggy, that is its problem, not the library's.
>=20
> Thanks

Maybe we're not talking about the same thing. I'm specifically talking abou=
t this line of code:
https://github.com/linux-rdma/rdma-core/blob/de593a02932a5ee7c729bd92df90e1=
fe8892b584/librdmacm/rsocket.c#L1169

Here, the buffer is allocated within the library, and the violating access =
happens in the same function in line 1186.
Both appear to me to be part of librdmacm. However, I'm not that familiar a=
bout this entire system.

Thanks

