Return-Path: <linux-rdma+bounces-2872-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031748FC4BC
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 09:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE7528359E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 07:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CE318C333;
	Wed,  5 Jun 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pdjC4k+Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uLtfCjNa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C350763F8
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573174; cv=fail; b=ZYqrQlUIBR5lF2Y2cizyFe+mF8cv6vHmvD2yR7UTxphn0NHQThybMgMEdOjqh05HLCIWz4suQTa9s3I5MxKxJu1eVprgF5sfsGx8SCIZk2GHswbIC59xuJTOrWa3QHF8ZNVmtK+bHnADPWlre3wDIBonajC95/8wbofDQ4vFkVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573174; c=relaxed/simple;
	bh=I41LhFZknCOkIMbOpRT0alqirizNKklrfoF8bZEX3fU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IsDyzJi0m4Zhw9LcsHlO+5c6XxwZuVFoZyPL6WRM1nMpbwkpXMyiitIHHNeSDZNRh7y01ODwRL+FKVXmHNs+FcLMzE+rVes3AUaueXirwoAAbdiWeQ95CE04CjM/Nml1gUEah8IF9rUYaYDWb5hungJBcpj0qTMLbXZC+cl0ONU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pdjC4k+Q; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uLtfCjNa; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717573173; x=1749109173;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=I41LhFZknCOkIMbOpRT0alqirizNKklrfoF8bZEX3fU=;
  b=pdjC4k+Qku0QpzEWBNEIGXDozrF8mTk9BWSA1EmOAKwT7Ke0PKTUJbtK
   nNCVwlIasCb94LCz1JudakvZyMJNmrKKaAsWQ+AhI5EGaj64bC6i8Fvsh
   W4XRVtkEII0t7yHRh+v9meLwt2UaNPrqLn7LZuiYZl5OOCzwVj7sJU0Pw
   SFF+cstuddEIkJQClzKeA8dLqAs6pKnHterYV37SUzzpP5or9vPCkB5yO
   m9F6m1LtbEX8A8GkL3lSreEPeA17kR+9cQT5Y8ELi4uECPIF0/PMENtAK
   QRdIJze/0TdkURABIA6gW1F+6yMjfnspN7jcPthwSkaU83P+c6DbAJ749
   Q==;
X-CSE-ConnectionGUID: 9ZzxZ7ZeSXavKSTisgRWXA==
X-CSE-MsgGUID: rjcsp0P5SuKLpyymHg8Iig==
X-IronPort-AV: E=Sophos;i="6.08,216,1712592000"; 
   d="scan'208";a="18226811"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2024 15:39:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADHk+gHWDnKoWe363DUKSpBu+WvkAPxcjfPsFpg5sWcKn6PZtU+V/CrrL5PhcpnjZKXY6Lm6XPnnoMdN4Kb8u63BXSqzGe/nMSXyG2nLbeOR8ke0dwQica2PX3SoZkRVsklJBBLR0nFMW3LlWEWzYjLhpUu2YIPUVuTg5HGfJ+EhZjMagOOZBh5oGTn74tEYueFAXtej0xJq+pHQmoqBZs/bYywpC+ytll+XwDvr9cZQn7FwVMMfgLSOi1QQON8PEssCHOtt9wVNiD0EGJs2IhVOzR+NNykNzdsfmMeFoqyFMNu3lr5jtyXyCn8xas4XWM/4EQWFrEwKOXj/h6jOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I41LhFZknCOkIMbOpRT0alqirizNKklrfoF8bZEX3fU=;
 b=RRDtJlU8MbDT48/7wSP2CjfO2ix1DvMjtFs7zT4z+Ct/ZJEtUTSEElVXIgOGUp0ydh/knG/2q4y2RkvyQNX4ydX+qdcAzR75LKC3c4XcWJt7Y66IJh6Hz2uRRD9ua4HGYP9Zyja+pNSo80RnRhCmhJ5CoXU+Bb4BPFFcRW8Iv4dOSXp1tRmBrfEr8uX0MeuGNMs3iDqNt90WzkScRIf8fgiCgS0ryxkUVXJ9YOs+iu0t2ICGhx1qJkt+B21LCFv/QpcrYsxrYqH+fXCVIOheUX2jatflFo2Akk5RVj1YuUPx0YZ1T6MVqv48NgBICTFr1vBjWR/vWYPoKY6PT5xwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I41LhFZknCOkIMbOpRT0alqirizNKklrfoF8bZEX3fU=;
 b=uLtfCjNanBLsklsmug/rInMjLri27VDX9tsyrcmelDwi/QP56N9260Vst8klz+N2WiQW4U0xI5z+XTIhpD6rS/KBwk5qWYI+54SrQ4RX1H163n0xJe3yHejNYNV92aXaaLMTsw6MHpiVejd9Py6KeKJor8Pwt6o3gvM+NfkCOZk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA3PR04MB9302.namprd04.prod.outlook.com (2603:10b6:208:51b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 07:39:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:39:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [bug report] KASAN slab-use-after-free at blktests srp/002 with
 siw driver
Thread-Topic: [bug report] KASAN slab-use-after-free at blktests srp/002 with
 siw driver
Thread-Index: AQHatlBevjdEqNl9WEGGLP8JyoPSxrG3VfQAgAF0ZAA=
Date: Wed, 5 Jun 2024 07:39:24 +0000
Message-ID: <bjp5be6qrz4qj6beclnwated54f2k3dxesrvvaxq4v4a5tdrce@os2gdj3632mw>
References: <5prftateosuvgmosryes4lakptbxccwtx7yajoicjhudt7gyvp@w3f6nqdvurir>
 <6bcbe337-c2fe-46ee-8228-a3cff6852c28@linux.dev>
In-Reply-To: <6bcbe337-c2fe-46ee-8228-a3cff6852c28@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA3PR04MB9302:EE_
x-ms-office365-filtering-correlation-id: d7edced8-dd3e-4a59-2a7d-08dc85329f58
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?X2AbdJ8TWkeTEsJYnSi0nJLEXqgXL4oqvk3PUL/LrmIzo1zIVq6TDPnbKXxm?=
 =?us-ascii?Q?eW1T8sDlaNYPtVwI+dFOJgcECAeP1wneMIsM8fE2uuiYpiS/e1tvkkLeJ6Qa?=
 =?us-ascii?Q?kSLJ7BEIfkmzNXBGTJFWw4RZWpHC9hGSmSLkRzRSKTcymTJMmz+Vg9GwIld0?=
 =?us-ascii?Q?V57V11+pqnblXQZc8/5x1gOz4KRZTutJbC8WHDSBBI6CmpqcT+aMGBwJ3UdW?=
 =?us-ascii?Q?humxD+zfW5NQlfWWFdM0AfrgS42cfQWyYiyPihyN13aBWKk+X4JrqGfgMPf/?=
 =?us-ascii?Q?mUvn6g7+P1qyiLHi9HsZlr3FVXFcH3YimjMCDBNXIRVaIl5c3Hqyr/xKc5Y9?=
 =?us-ascii?Q?4E/kfvX5NbLdK8Hn1mPmMXrji7kCWqJNWnIZXeANywg1gdqIK45sm4hfr4ld?=
 =?us-ascii?Q?Cp+/CorjR3h6ZwWjHYFDDaHUP5NXv1JLeKaeLBeqTgOxpSdPd35Bt3ZkZHm0?=
 =?us-ascii?Q?+QAGwASPeRmx6SestmVcciDXNUzrYzoTuKXt3xK3Bgc3fWRAn7M+CZ7XyWcB?=
 =?us-ascii?Q?CAFhIDE1i0aA50+2/JnOpGtEpcPCIRaq/NEadNLx5UMXQrOZFOn/VUtBFLkN?=
 =?us-ascii?Q?yGiRN80u8eoj5n4za6QTGe69htMljWSdG+6ER+P2vJmL/9JyYOL/louZwybJ?=
 =?us-ascii?Q?0FSNDuYQ2RZlwN3F3BTx9jBoOu0DJfmwgdpdVWsrH6pBG4UsTCATm7/1turp?=
 =?us-ascii?Q?bn4gdl1RfuvUWljPQGxzyX7lw4yxESknWrbMTgZ6Lzw6q0Yj8vjvZ8Ldz2Hj?=
 =?us-ascii?Q?ohpxfDD4AZDgToR5u2MAW3hAncNAzOdADvDk44E61gIAr5aY2nlNcolEgl0l?=
 =?us-ascii?Q?VfKj84REFvMqaecXZM3MmODI0C9iA1T8Mk5V9W2uFXX7gTIR8Cr3x6fwXvZG?=
 =?us-ascii?Q?kV3NGpArIEx0CMwi9yOS8m3omWSNGV4HaHZjvo0Eb/DsSGo3taaTsF2cE7cS?=
 =?us-ascii?Q?0dIXz7Fd47/kl9hOZyvUF7elVu1GnLShJY29u0uOArDuFAXKkYOQxdf1nGls?=
 =?us-ascii?Q?WBd3fNyK/cX2yNv3cyy4xwnnu/M/k+Tob/kRfX7OZKUbohdlBvRzUWYys2Je?=
 =?us-ascii?Q?ByhCBW7H+XVXtqB+NkIn1rPmFQPnhKKmXceS70FUFD6n6i8g/JCFlijugWqJ?=
 =?us-ascii?Q?HVtKYjAW3SsSU7WsIvGaOqTbvxUuDovI8SvBVcQUcD3DQFpC74CSQbuY7bjW?=
 =?us-ascii?Q?YmvTOgYQserbRe+JyCuKdFT9y25MsqQDIOlndGTV4rDuYTeF1Vx+0X6j/f3U?=
 =?us-ascii?Q?DQ6E2nGcv7I4bK6Z2LtTLYYAyRGrP3ZAghU91f3qPBQsN0MB/q1lecVUHG77?=
 =?us-ascii?Q?5K/6qypqxYte2UCfvIldP20PMJ8ejYgF7HUG7MQwucGwzQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5Hz8rzbhQ0Qu0R0s8NFhzySvIT5jFVTB25LGDQsWK64BioxBBresaOWPhqPt?=
 =?us-ascii?Q?Ac2MY+DRUQvYhSUl++dZ1AM/5ACJNDI6Qal0U60ORXK7F25YLqu4MdJRyVp0?=
 =?us-ascii?Q?ThqGUVw2kUbIukgX2+ZpWkMQt66z4R2jPjS3fVTCrlPHiPrpINDPHjM4StpG?=
 =?us-ascii?Q?r7Q6HEGEsPn5JKB91KzA2oLZBuHMnnABy+I3FStYpDNIqPDF6BwS1Lwvc2yW?=
 =?us-ascii?Q?oqvhv0nkN+EGQY+HjCwENTWf/66mlKBhEY3BUC61j2BBxWjdMxOa+MU83QIF?=
 =?us-ascii?Q?lK+Z0f3HtbmYnrj5g7dhT6y+vC3CRCkHL7DEDzfZuKiyTYU7IrUMHTFA4hFu?=
 =?us-ascii?Q?KWVMFCfI7qYso7He+VNGstb9dWnnw5XF2ULAgxFJpf1QMuegdxc6FfKJwVhZ?=
 =?us-ascii?Q?KiCHVLXCwScrVEJYfXvT+bI9rslRvl+6VUWX0TzeUhyKL6x3gpEXsrAVuoFE?=
 =?us-ascii?Q?IprlitfqqC51f0FVCaWBh5DjMpxqhfGsaw4NynsxKjRENfGLShYwZTaIXlD6?=
 =?us-ascii?Q?DwF9JJHyi/6NS4a1HI9W1HS6JchRqHNKnl9E4GKh+DbWIw00DQuGp5CKRQvQ?=
 =?us-ascii?Q?zUGEtM+mw9Q1QmFGuAwUcUqQjDurznNrQI9b2/aHSfjqu6iAjOFdo2YWHwEb?=
 =?us-ascii?Q?Fac7i5WnID2cbOEYxMjmETmQoI9pY1K/uXGx62+OXLlBPS7yAeXsv2/pCbpm?=
 =?us-ascii?Q?lg1NO98OcLaV+BOVh5tX+dEdtOvcGC3a0FOJXqsNAsMbHrqjoeA9jHiNTAq9?=
 =?us-ascii?Q?QOnEGY+XrLqod6kBHfl0MTk/z6883f0s8xASMKBmfstrkzFaatd6Lx69IrI0?=
 =?us-ascii?Q?NqfHUoEU+2FlXNyfhNuVtZs9AbD0YEvDrD6J+UjVHxIO6xzLJsSFBxVTAgHi?=
 =?us-ascii?Q?W5EEee2X4Uun8QcdmZn2hE1X1IZFo9GJUU/89L3Iu3f9pS7x61GIxy6mFWn6?=
 =?us-ascii?Q?12xKSDK6NsLiBfQx5YBH302CVh9r0pc2wzuWVFcxhLEU9/e1/CcHPJodQId6?=
 =?us-ascii?Q?XL+qK1/OpTeglZGnYWzRSDYVyzMjMPNQAYJn9+J8lDF5yz9QtGF0WfAHG2T+?=
 =?us-ascii?Q?so8bfAxc+DYwpDNIvRukfwgAdATn9GrSVHmzoxsrqQUGuhg8MeCS39v878la?=
 =?us-ascii?Q?LSQtPgQlIC6iw7zsZ9fOsYva7KPGRIHcKcT22HAgQP+Orup/cfHrAGiJ5PdS?=
 =?us-ascii?Q?CprZ0qkoWMRgeQY5lxRnq7ya4rmTkpcpVD/JTbRGjjCPkuouAx+Psj/pkTnC?=
 =?us-ascii?Q?lo4R+jeoP0gdzw4JiQa2DX9N2V7g+dxtR0Z3fwOHxIc57Wa6pThnnbFziTbt?=
 =?us-ascii?Q?sb0ynz2mua+pGzmFSIG/+5V7f+QOwADZaalfkSmqd2GRp1PJ5VaHtdSHIAFs?=
 =?us-ascii?Q?kkpra8zXS1/AFm60pJE/IXXTJooCPlmTuGh/uzV/26BY3YT6Fein9abDzo9J?=
 =?us-ascii?Q?waveWjugh+UjrCCG/i+NNUAsZ4w4XtGtEh6r1mljC5cpSKLUt9sC91emiSN8?=
 =?us-ascii?Q?1TB3C+Y9XAMKs/7SCpFkX88P7pLamYUCo6xyG/o6biO8zfOdbNwn5Vi4QhMY?=
 =?us-ascii?Q?D9V7LFgh0WILVnaHcQeEgM8rcO97JEJtR4T0uB9Uy2zxq5CUA/aZBm/rY7qz?=
 =?us-ascii?Q?ZFzH2sTJPMo0g+Fj1YeWj0o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FE78FF232DCE64B9A4D07561E738DA8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RIaztHxDaKjjr+DWblDRHGlOwBU5Yk8pYkyjTaqPN1c9PSYvGSfectewJYdQ2Y8JQrb9sw4YPvTKIsafn/sRuLLg/Gp6X8SFZEnSY5Y7zaP8XBLWppcWZP6ijnrptKxo63EHW13qQFxHmgdXeOQ6M6WMDpObVm4kohxvDiYQX5zEJV35AJgwnlfCigMF1gUUgr3z808TF/DyjQVcwKnnYPjkx+6udkbZVMOmczMZj68m2DlIpgEp1pAXJGQJVyX8MI8jedTjbfbt/nK+Rjxc8DTPyB2FHgK9v97Bxwq68RmAKBn376M3ymAxDkEZ6W3FyLbBZINX8bVNe7JM/y5uSlc7W7OaWKjYSDDbTc78rkEeCVDf67pClY1NSIJRwi1xQxqdLUslThNlVlA1bKcZ4qYseLCDhihzkr+Il+rQTGjZvGoVW156Gk5P3VdKw9UFNNAWK3/2MjEmaqQtoh4sR1eFF9Q3+t4bxCnC94fSUDL+mZ6No4G5DYEeEiPozwipguTsI+iH9VnO1vpiolszPF2XGctP2Jyid1TfeHEWSX/6ss5asOgUMQx/q3AzqpJsU2V7fqJvEy+sQuxfkrHjLMFTXj/5YL4oKOF4Wnb3/f8qC5mCx2KR9yqyx/7VvCP+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7edced8-dd3e-4a59-2a7d-08dc85329f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 07:39:24.7914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CI5wlPDSeY+ZvIXRBjOPkAHm0COAYiHrx2UGooRWkV5Kg7T5jhJBUAMEENqweVbd7TA3qvTcUifmGdiWQuqRkR/o0mjPULI9xKtRQpNCQO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9302

On Jun 04, 2024 / 11:26, Zhu Yanjun wrote:
>=20
> On 04.06.24 09:25, Shinichiro Kawasaki wrote:
> > As I noted in another thread [1], KASAN slab-use-after-free is observed=
 when
> > I repeat the blktests test case srp/002 with the siw driver [2]. The ke=
rnel
> > version was v6.10-rc2. The failure is recreated in stable manner when t=
he test
> > case is repeated around 30 times. It was not observed with the rxe driv=
er.
> >=20
> > I think this failure is same as that I reported in Jun/2023 [3]. The Ca=
ll Trace
> > reported is quite similar. Also, I confirmed that the trial fix patch t=
hat I
> > created in Jun/2023 avoided the KASAN failure at srp/002.
>=20
> "the trial fix patch that I created in Jun/2023" that you mentioned is th=
e
> commit in the link?
>=20
> https://lore.kernel.org/linux-rdma/20230612054237.1855292-1-shinichiro.ka=
wasaki@wdc.com/

Yes, but I understand that it is not a good fix. I used the patch just to c=
heck
if the KASAN observed now is the same issue as the KASAN observed in Jun/20=
23.=

