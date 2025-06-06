Return-Path: <linux-rdma+bounces-11050-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB76ACFDD0
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Jun 2025 09:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2951784E3
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Jun 2025 07:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F696284696;
	Fri,  6 Jun 2025 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BKGhgaoL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PGG2xKV9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4817FD;
	Fri,  6 Jun 2025 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749196506; cv=fail; b=KfrRw2YDEMKmI1EcT+o8Ymjai0J/4avyPXgtEekpbxtXoycY+7RQLvxrtLQTCVVg627w+kjmq3k+5AKXgL9rHFxXS6qm5uDH/ocriEUqmMzsBZtssMt96BWyZB9MBJ7ypEAYMIGGccaW2btz071JhLrVOi7es+ATy6sc3Roq96I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749196506; c=relaxed/simple;
	bh=YICUXt3IYNOgc0stavb8O7gIZjxLncqm7cfJVsXw+2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qfOst0LuTJX9r9/VGRE9swbMmE1xyE25h4sYBh6oUkANPN90owRIWfzKUz+zizRG4rx22DHVnDQaBfSd49yzqqSUuPNgCo569lSUBbHDTF2inxCi5NA7maZzFKNIOMQE2zByPJZHije41POtRp/oEz8CeIxTjsEfxdPbWm8QGIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BKGhgaoL; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PGG2xKV9; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749196504; x=1780732504;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YICUXt3IYNOgc0stavb8O7gIZjxLncqm7cfJVsXw+2w=;
  b=BKGhgaoLZ/KG3FGjnGfUtecOxIJbVHBxRuWKUj325YOujBfDNy8OJGlK
   6mSkJ/p9VbOEfaqvEdEzL4GfIdbNCNWueOCSWl4JbEYrtiCsZAvEQGcXU
   pmBxuIiP7nNA1rzo3WgW5xZN791rBMNc5/Bk54iA7qLNhiNNbIf4Ege3j
   jvT24jX1Bx2vthSNnsQOkCFQ8d+qvElIUSMkpNYwRWwOoTW2keoPGnAiq
   hKpFQLkypaKGoztxJDs/v7rjOxcu4RU3KpvufwUnVlc3k2Ps83/7wokH5
   SKa6bFmC+RhaD/gLuWU+/ig/CTg3a0qnL04NmUXGu5pXkeCmeBiakfeoP
   Q==;
X-CSE-ConnectionGUID: xkecNOAyQLChkhylilYFmQ==
X-CSE-MsgGUID: t2xaiMUBSlGm4SxGddwXdA==
X-IronPort-AV: E=Sophos;i="6.16,214,1744041600"; 
   d="scan'208";a="83553122"
Received: from mail-sn1nam02on2049.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([40.107.96.49])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2025 15:54:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7zpDv00NQt/BJnUyTJV6ZBeLHi0a87V5z1VE77y5DwT+x/mNPo9L9Xg5W05Sy+qAWzhu0MbwOaDwn7HU7pN4tc8WugtNwztoEzeNnmpBrBHTJrMhp/MsDWvjpxpaeiNa1RJDc2N5seUfhHy8D1o5Hz3idkd6VJU99aEF39AyxDXigbOJ5PDR63Jlmb1hFbA7U9aqVRPOpjcDust8iT4HEZKrRTtlxH9VE4p3jrnA3YXX0debvAckPdfP9LD7yQV2Qg0dqJkk5IHvfF53CDUpGq7QGdmw66yjbsM3izjZiYdVcYTDMONvWiK1g6e9Eo5tUIETEdWjlDBMVNTCc9Pag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVqUtI9cDEJZLKGzccoSGwW+gukN8EcMJrS8W6JrfSY=;
 b=Vb/nbT38Mo+Se41HLB+5sAKS1yjFNPB0urkr2jcWElF+TEglK60oo3TjcPYrpO2Z+a38b8RQiKzqS2uUpuRUjexaDRJcHgfDNjoY4A5j8QKZ2CMNVaHjd93aAR1JoKF70i2qGckqpIJGc5AlmkmMXSNoGMaLEu4PgQIWuzlAy71Q3HZTAVyosxN1KvQ4hXju4icuUUM/UD+rwp4JyxpJ22wW45/kVN352/Qp3Gku/R6LeRF3SgBgaTvx5Pcuu+7xHiJgQQas/FTT5ILlUVp+QR5xYH8THkcaQ7zBzkRn3m+lepsEbzuDQS36GFo3ciIX86HanmFfjxkny8qiOkXStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVqUtI9cDEJZLKGzccoSGwW+gukN8EcMJrS8W6JrfSY=;
 b=PGG2xKV9VY42IfB6vfoO5ioziGIK+iSw1P8hi4t6Tjc3ThkeU3iRqv4v9CdFOxnJff9ZSYKOX9qG7cRXADuXrFaNoMNvvSFAUeMMX12mWFo0Pvb1mL+WxtAHHJBsOWWxlDquStfgq2xpWvhNE5XY7tSgvIDXA2LLb3Krk2urL1E=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by LV8PR04MB9732.namprd04.prod.outlook.com (2603:10b6:408:297::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 07:54:55 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 07:54:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>, "yizhan@redhat.com" <yizhan@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.15 kernel
Thread-Topic: blktests failures with v6.15 kernel
Thread-Index: AQHb0HYvN//Uc3+takahHhtvsJIVubP0k2AAgAE8RwA=
Date: Fri, 6 Jun 2025 07:54:54 +0000
Message-ID: <rcirbjhpzv6ojqc5o33cl3r6l7x72adaqp7k2uf6llgvcg5pfh@qy5ii2yfi2b2>
References: <2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk>
 <7cdceac2-ef72-4917-83a2-703f8f93bd64@flourine.local>
In-Reply-To: <7cdceac2-ef72-4917-83a2-703f8f93bd64@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|LV8PR04MB9732:EE_
x-ms-office365-filtering-correlation-id: 19beb01c-da88-4ee5-5a45-08dda4cf6ce3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RztYKUeUlgCCOjVhlkDrwERGf9R0+dWPgpj6imC6dqthBzo7ExKnRJKTAz9B?=
 =?us-ascii?Q?jhinUsAbZ+pdz5hVfli9qfUfx6zOkKWcrynn/ZvqZ+oj640ItS7RVAbOo/mD?=
 =?us-ascii?Q?tMQ5kEVV++DYHB0SXXq7Sfof1aZjEm7V9k6Gh8bKN8AOOmuX2vhw1wXNjIcp?=
 =?us-ascii?Q?SiU+0kxk5Ly9j7F4s7tMVQ7DMZB5Ha/7qxz8TgfezjSLpTiJRVBGVCD/80Zz?=
 =?us-ascii?Q?+gN/5LWEsYMgjeRchR+2fWmlSM6voO01AZg2NnvjEIVYtveFwWxznomkUv7E?=
 =?us-ascii?Q?xcsL4QhtBmZOPbQ6aO5jjKT+VVjRuLM16Eu0Gfwe0t7UFkzMWJPFx5qYbTAN?=
 =?us-ascii?Q?MNJlA6PZ+6Z+JsmPKDSknDmAx210BV1vbSUNN+7vYNC38tQX5WGXQgv0gbKT?=
 =?us-ascii?Q?MvcsmCK9IWOtYZto+OaeplYlcYZt2Pd9R9V+9dP2Z7+N5TEPpKspELIB4P3p?=
 =?us-ascii?Q?nbqwhUAl2WBCAk8rH3zJzvxk+lMnrpEkDPBxEfnay+JRFYkM+idu/WWmcgWz?=
 =?us-ascii?Q?wOKSWitY/wAJv6bg8iIRU1tjaSA8JhYh2szXTXJEDUnoEpRqqYNElSPFQd8z?=
 =?us-ascii?Q?PdzQ3rUc4QnSF9LuIlW13l2bIzuYbHLc5RuLhho5SG4VFzuw3/xj0uYLCGe6?=
 =?us-ascii?Q?VLOPWw1yvQtcFQUNRNivv4eEWGoA3EZ5Aj5z8K6wZb+HVqY3kFsFOMvSg3lz?=
 =?us-ascii?Q?utm9ixDPJQVdrKg3VOHg4D2HWEAl72OreS/WwLYlEllKe6fcOSU01iIctGjC?=
 =?us-ascii?Q?b/mm/9OMgtP1Jr/RsBStD87Np2zSvpc83WCIEp7PWWglkpXnhGB8vlJdiPUn?=
 =?us-ascii?Q?b5KPn1V3kXsPjKD0Xyp0QP99P96JUSw5Nb6rBp9ZjGujAAH8hVaGVqQ55lgP?=
 =?us-ascii?Q?7yEEWoQKZvWTTmGukVfE9zXullucGkJrxLo0evqH7l9HypIAr4RuOb8+KfFM?=
 =?us-ascii?Q?4ImUNT/NKAOuKEoiVULqUuEVn4OPDAITyNoGW7+2EMnRvN/QhklIRX7eAQ0+?=
 =?us-ascii?Q?wEWPFq8e8ia3qXdQakevY9WnO0r5d6FJTRdKgvxA4lmlquO8PLHVWaXywzMc?=
 =?us-ascii?Q?3lbPp4grInpH/5cIZP6zc5s82vVBhp1ebskxDcqmHDh0eg1Yu4BGpVmbIBfj?=
 =?us-ascii?Q?l1vHvlpBQi9oOKI9RHriqpOJlU8+a697W/SnFe1jAtoRd8em/kGeazSZlFMv?=
 =?us-ascii?Q?3wt3iDOOreE65x+9sJSAgdr/mTiQIZMzupD0oY6sKRFXmHov//iiHw0xeWnw?=
 =?us-ascii?Q?g3srf9FwHF34SgwCNtTPXTOx6DKeu2GdkxRqMpFln2efiwPO0E3NUHJUoIa1?=
 =?us-ascii?Q?L6eFdk8uVYx2xU1ZNr3fKi4TcvRZV0faJUfbvGLhyGfRlobeffirHMeuGIlX?=
 =?us-ascii?Q?pIMYR0FQaAxn3UFKkUBRXa8i1sASYhItSBYHgnc7tCjEV4t+e6zZpMPJ6pO+?=
 =?us-ascii?Q?18ajiX6aT9BxEmKGhPXik90OerLZw5qk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZQjTuCa2dUSzI3aIL5rftxgyNV0TN4+44kkuJQv38ovGlrGqZNbRtDrrVTZu?=
 =?us-ascii?Q?8LFIlWDEqDBAIVAPhd/uoUl4d8lmBcGZZgU3DYrL3HMFAVjkHTxOob9Bj03l?=
 =?us-ascii?Q?jQC3T3VWamfW6Kekfz1MjDvl8Yl2ofAP2ZYHAi5hHiPriHLm/MJEkWKkdMss?=
 =?us-ascii?Q?7OyaG3pN43LZnEgjk6CDbR/NWz/fIK9nRDb0TwtWTJEAiMsIECg1OUARjWBL?=
 =?us-ascii?Q?yGkWutMLt/nUaVrlvvKKmd6d/qo6D6JHXWP2is//z6da8nVPuNptDuyV6sAW?=
 =?us-ascii?Q?2v5U3uWxT6zE5bBEjP7OikRSVn3W3mvZ5T+0ZGIwb9W7q7aVkyCbv5yKyTF3?=
 =?us-ascii?Q?vqoxbCs5IdaAKp4MIJ4srSq2Y7nZ1Yffql+h7DpnnfoobvN1rr2ls1Xc8Jq0?=
 =?us-ascii?Q?yCWVosEy3y9ri31Nj6Fdb68GP+q5UDDQGx9FBzTONkBrhTBSH/SVaJKlKHQb?=
 =?us-ascii?Q?sq1KkQN/hcmQXbgECPNMMa6EKoFSraAZ3rodJavvQcJCHu6XQHJXDCBuKLho?=
 =?us-ascii?Q?le2pAh14onp8FWSK/GGitt2RHQQv2rD+AcI6++1ocSwBJ5PPhI5+myBCDnWY?=
 =?us-ascii?Q?UG47tjW3NTkF3/Di5ORjvzsPYOaEEtNR/hAmqEhnAHy0GEoSEwqtGLK11aUo?=
 =?us-ascii?Q?DLLL+EXQKDhfF87XuG7mpvTCZK1XbWEVVM25xThQ4UhJwjupmJDigv0Xvb6i?=
 =?us-ascii?Q?Ki7OiH45jOp97/uPF0dJwbep2c1vnSsnESMTH4mEWZAXoAKM5GxFoUA9QMKm?=
 =?us-ascii?Q?qC4E+ahGYx7yM7ClgJ7QdXvW+iE1ELfiiWZs/1ih0ZYXbagFCO9TPCSogxBb?=
 =?us-ascii?Q?YsFsWXBKWmYXYHJFWZCzA8GPkIYJ1jRkhe5/nRFguPDDYj1zTK6RNLRHmVg9?=
 =?us-ascii?Q?ZyngMS5/gf+JL07Cg/g5nepT+aILk9ih6ljOkAAZFIuq82WU+s51zVo0x4A3?=
 =?us-ascii?Q?H37rpQGFltfYm228iViGT6b6X+XNMppsvhAi6jgT2tGHDlaHyyb4MPjQnlHd?=
 =?us-ascii?Q?J6Czyyb406D7MSyTZUfpq8uC+GngZ+ZF/2PiJZYHcEQOUM/q81EbUsoAZrsr?=
 =?us-ascii?Q?h2FoxXfffkaCQm5mf/NiOZyNbY5HeM4dNExTWwEB6fbGQHhDGVwva1XRjy1G?=
 =?us-ascii?Q?Yz3grqqT9YehVh7rDjlBe9+nlxjlDD+bRH1S5TkOV3FQiCs+mAritGM9pxiQ?=
 =?us-ascii?Q?okWfGByCWZ38CZVOF453yt6MPjjVshSBu2JJfPgSvOadpvhCimbwXZ5Sz/Q2?=
 =?us-ascii?Q?Ijr2hAI6ZjIj2r9uv8+KtZWc7/qlcaX+/MveJkR0AwvpWKIjgmspvvNnZHri?=
 =?us-ascii?Q?P+CoHYL1fUiUcsnYzzLvBDOjvJ/adZTxQMN1rqLMTHO1rCssqo3+pQfJow5Y?=
 =?us-ascii?Q?bCug+pGXGRNApbuA9fGET66FYbQqciY5wAzNpcXFWIqY4JxEZkVMaNy01emb?=
 =?us-ascii?Q?ARYZz6QUf/txHQe7FMHOOM+biqxq5mEIuBcDVqLAKsbGiyu/eBnYb6yEuLcC?=
 =?us-ascii?Q?TLRKrD++Df2uSnwv2eK8p5Udru7bBSZbs53uvTvBRsQpouHxe04C0YCfgRU2?=
 =?us-ascii?Q?e4/cRE/hnILzSRm7e1aBP5DEhe86hzMDOfzQAxKdEUm/qUtGXSvcfbJWXD+8?=
 =?us-ascii?Q?6LlEmtPJM5Ugk1bqhhzCgIc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2456DEDF0FD730419AC04A6E1BDD037E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OXE28FGxZagZFTplQYjaObi03N0U27DsSGplfHyPmBqvqB6WSEXNsYWFy8sz8LJnpeiRLgLM1gpb10pXPS5c7UrQ9kRtzv3sCEh2Po7bG2G6uJQNTp0YCTphP76DZgjUEVunWlO72N/++T6QfHJO3fFLYkoJMWUymEP04ncuTm1cKCY+IhIbopoHFipyvK2PnXkJV3GBuqAgq1NgZzjiysSxxdCbCJUe6ai8Rf85mGsDPnXRH3kvMZisdESzGy1PZI7ge/xQ5Z1mw6Wn3/yWknapETJkLSn6iYhDYIDbRveJ6+MsWfo5koRaBsTRC+lD1YkMfoT2BCcpAg8r7LFjKHkhVRTrtu7gBQ6+1hsWrJVsa04eB8zpxA+wo9aSDrhcJuC2RK5rfQUUSqGzlarqAoFmTNmOniLDtrvkmHri1ki3U+V/RlQ9eFtV3sJXSm9qBuG2oAW05sxokmXhxZGIXlo3bKonJz8GUnO0Npcfp9wtJOiM31c3iR/EFtgXgVbSLMgMA2VduZLZQFnh1Jtpuf/Hj/jkT+QodbpF2TUzU5rwW3zrtXIk59BpNBbax6EUDTRC5xAQUrrYs8adwdyNGhQFd2ACZGJmoprPW1tOlXNEgYyyLemZRa5KlWgwKEea
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19beb01c-da88-4ee5-5a45-08dda4cf6ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 07:54:54.7873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKmrElIH70GOetbguKRLhXwJIFzGfcghYCR0E4mE80WwV554/DCZlM+qcEYwkoUozJmJjcCWGZdHkCpyVyvVSeL+SIARRMhxc5yXO+osSu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9732

To+: Yi,

On Jun 05, 2025 / 15:02, Daniel Wagner wrote:
> Hi,

Hi Daniel, thank you for the fix actions!

>=20
> On Thu, May 29, 2025 at 08:46:35AM +0000, Shinichiro Kawasaki wrote:
> > #1: nvme/023
> >=20
> >     When libnvme has version 1.13 or later and built with liburing, nvm=
e-cli
> >     command "nvme smart-log" command fails for namespace block devices.=
 This
> >     makes the test case nvme/032 fail [2]. Fix in libnvme is expected.
> >=20
> >     [2]
> >     https://lore.kernel.org/linux-nvme/32c3e9ef-ab3c-40b5-989a-7aa323f5=
d611@flourine.local/T/#m6519ce3e641e7011231d955d9002d1078510e3ee
>=20
> Should be fixed now. If you want, I can do another release soon, so the
> fix get packaged up by the distros.

As of today, CKI project keeps on reporting the failure:

  https://datawarehouse.cki-project.org/kcidb/tests/redhat:1851238698-aarch=
64-kernel_upt_7

Yi, do you think the new libnvme release will help to silence the failure
reports? I'm guessing the release will help RedHat to pick up and apply to =
CKI
blktests runs.

