Return-Path: <linux-rdma+bounces-7188-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA0DA19C16
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 02:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0D03A8EFE
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 01:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CB017543;
	Thu, 23 Jan 2025 01:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GQ+qaT+a";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pJQRXp0n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9742835950;
	Thu, 23 Jan 2025 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737594502; cv=fail; b=M7fyJ0AUZ92EPkqJwQL/c9TSPpPtwRlF3vhqzGDuHkoipvvz3+YpXyWAzctkL825W0a1emSKG6YCE5scoyOEa0PH8tiH4gWk+O66NDHQ3MiN6+hIXBnxH8FbnArhyJWOKgx2vf6iJYDwJgApwIyBtgcXwmC/FJAmA89RV3c9xlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737594502; c=relaxed/simple;
	bh=Jw2+WnPSLpWOeRTTuZFYU9g2gTIqB9Re97MiJC03+xs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iK+2ALR54K6QwOo3ntbF+kZ1NRJby4pTvIT8PV5skgiCMgMO/mIlvdKShvS8APbFDkHCCf4EEbFp5KXiB8UiXwpI3CPzjftNlsqHFxHCTCnALx6ynxo03PZO1/vsPcbpFKloX8F2N8DWfBLV4eSae5CS5QdGOUkOvPkvJzd+nao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GQ+qaT+a; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pJQRXp0n; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737594499; x=1769130499;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=Jw2+WnPSLpWOeRTTuZFYU9g2gTIqB9Re97MiJC03+xs=;
  b=GQ+qaT+aIqZH4ExfL1QpHPn7jM+EcG3LhGcOEnRpN/qesRC7rr0ynpn9
   3Efj8AHKcv6YygpDXaSPBkPGBHYxFnR/cUBEdxEIfFdg0ZI+2vnRMD4EM
   wmXe5M3fNRBJnKtxofVXfdteEJpXVMyy4/h/QL+yRtn6s47HgmM8YjIUq
   PXp6iNEaBUeQm0xGgj0hHoRxUBOU4FC1/1a3vEWvj8WW89Y9YML1WctC5
   /W25gRHA+vbeglshRuwdj/IpYN3GtdFrEPTag9JWJ2XBbX+NV2xYmikpz
   d3iZUAIAuSyJiSYX+hGACnaBD2bTnwwT4YDAw9V45j2EuZagwurfLz/yA
   A==;
X-CSE-ConnectionGUID: Sm+N3VqOSNiC7q0Txs2sAg==
X-CSE-MsgGUID: RjidQBrURKObsZNUU9SqJQ==
X-IronPort-AV: E=Sophos;i="6.13,226,1732550400"; 
   d="scan'208";a="36566626"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.10])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2025 09:08:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vF0dZ3kHeLjKRXtel7ehi/2p+iQigEseia4b+H8y/jqdacrc4el1LLLDb7HSfhTJx4hRmtUD/VSpxVwCKSZ3NAvAJMUSYkdCiUGc+zy02jnRDPWMqQJ4+wzb/JnG45Zyh5SPHUeOe9HUdP+2I8IjR10jgKLR1lK6HR6c1jvSji0oYAqH2wihWaV2OfTOnb21sf3F/Aq7ICvqLt/kRnaZlbJi4/6x85siFLhY8fNC7MTalTlny431BQuv+H26p9SZtsUAUy+ex0pWdNTYGvXC1mx8SPM8QpWooplQdpO8GFuT8S4f4w7ELvVLAWBJqFygW97fiyEMj54dPqftLBqCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JvRl8v/Nt54FD4E9pWk1OUqTZOPoy5CcUTlyZhaeYA=;
 b=YwKjWtJoLYK+KAQtONxNmxDQgeG0vT0/mLs4IN4gHJRgfJXh5udXlmhO8VE2ICRzle/MVu2qD3cmENMMAcQAZmy7xw8Mr1mIj2C74BXhHU5bT2dKjQaWpzhj8a/K9AJ5O6HONm0qzomLsIPZjKd2W13LbC5T5psVsl037hL01SUnHphjOCApks3hldqZ7rn4V1oiZA/Zp+rZffM+9pgPIaUSPiXhEWQKR8ix+C9mni58o9zh825rC0W4iBnwB0MwA7Wj6XQxzOmVEV7eniudwaT5uIYOIFRe1VQYzWQIcvB0eftPD4xnFE1y4z5X2s4gE4aN3tcgss2sSfPlgK6Auw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JvRl8v/Nt54FD4E9pWk1OUqTZOPoy5CcUTlyZhaeYA=;
 b=pJQRXp0n/hQgHEidDYxm+PXrnJzTaLc3rSivx0nLlHMz0B+dI6HwzyymtLa0VP24WSJg3fGObNgpxKhmkOGmHnmIla3Im2yAg7iSmbV663+2oK4lvDYMGQ+K9cBzz124dVx/ciml4BqRE7OHQKaoZ+Dk/R8YcsBQfIWoMwJZuu8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6848.namprd04.prod.outlook.com (2603:10b6:208:1e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 01:08:16 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%6]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 01:08:16 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.13 kernel
Thread-Topic: blktests failures with v6.13 kernel
Thread-Index: AQHbbTNI8FLaoxhYbEyxYyen6bXBsw==
Date: Thu, 23 Jan 2025 01:08:15 +0000
Message-ID: <rv3w2zcno7n3bgdy2ghxmedsqf23ptmakvjerbhopgxjsvgzmo@ioece7dyg2og>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6848:EE_
x-ms-office365-filtering-correlation-id: 030d27c0-db30-416c-6f0f-08dd3b4a6ab1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ioOjDiyF7VW3ZsLBnU0uviuElnUisyPFm8k/ShYxW6nyhEgFrkt37RSXnJZW?=
 =?us-ascii?Q?hVDTiPckq2gHH3SY11Xzm7ILY7GhlK1kncGoX68xFtsmZzvYjIg8rdiPcH0m?=
 =?us-ascii?Q?L3LUlFjXk60ybK7KepR3uLLy5zU51cEz7toSyVQPAEiVqAufGgSUNoYQ60IR?=
 =?us-ascii?Q?Er6qkqGdU+gyj/DfzeZibtZ8cj3cHCwUDuwsFR7ZP0ia5oLLryjIBtUMpnXk?=
 =?us-ascii?Q?RbSfCutpr3VCd2VxLNyEi+/u7M25APyxv9Ia4z6MqXqY2G/ZSWYJz/yFPo/e?=
 =?us-ascii?Q?m+GmuUE7VoKqKzInLPJ2qMEAMAyGjjcR7Eb0xJkRKqk9CMfoCNN2jJZojLZS?=
 =?us-ascii?Q?1VuU1/hYnkxByq4rS1yl7eFxv7ec2lkRwQzStoK8Eu0ypEjOQ263zG0E+AMl?=
 =?us-ascii?Q?TDkfIozXOESGOAEqSdcf2jTZ5mJkh/X1d+zATXTt9S8S8ykgWKboEJ9uvGfu?=
 =?us-ascii?Q?Hlb92j7fuPj/SnkMn47X3pji7dj6EqS48xA2HG5/l7aKkdATMoViAxCKlljX?=
 =?us-ascii?Q?qd59nbNmaWjJwuseJBmEYWuCqL63oPktRTN2GA6cpyJ8maepvKoDpxBm/bCy?=
 =?us-ascii?Q?qYgCw2ca3PxrT4bsyh7UxQKcgM2Yb7T35atc3actYdF5h3S8ic4nTQ0Nd5N1?=
 =?us-ascii?Q?ZqTj3qHzHY4+h7DFEOpBg236CbFLcS/WWprPxgNj3tecHv1Ot7homaC+p6Ny?=
 =?us-ascii?Q?L5ffj+myMOoRg1Jlqu0xlmPQhYMRRKA4vU49L0xUvcPPYEFFmeCNU0mSCyvl?=
 =?us-ascii?Q?V6aQz6fDDfU+V8NA9V60FtA6acrFlx+dY3JGTzhrX/qIjKsfB+3SEKgenBKa?=
 =?us-ascii?Q?vS3Eh9G5Os6FhkmIXlmkVw6pdajDYmSqe1e8WJYg4VYz6bMKLwJkqmZKQ33R?=
 =?us-ascii?Q?cxmAeFgRymrzxycdGhtYyntSVUXKn92SRu2BRlY/d3TfTSAGULmUK52/0O0X?=
 =?us-ascii?Q?I/+Vejeq8qKuDwgUvBWYDeAA2nr6LoXC1ZlSONntAbrPFeKq8mEsqCgzDp28?=
 =?us-ascii?Q?NN0GRIFO0HurfJGnTE+SKRGOY9lwL8+TaaokWNCICnbnIp7c1Hp4UDlgoGZb?=
 =?us-ascii?Q?bU59FwKzU3vM4BW9jsUlCFaLfKBUjkoyMksuG8jVUl8L462he77iYet0qLY+?=
 =?us-ascii?Q?RaYQn0RJ8YgJg7ntqF+OL3qxpVUX+SCiZ9kVNlT5BRTSxCpEWqmr1bKJAmTQ?=
 =?us-ascii?Q?+tZamwtRfc9DhOJrpzRWJnY5nOUwri/G6EoDu/c53x5tAUWJd8CDT7xM0BWI?=
 =?us-ascii?Q?2A3c3MboUuYDZyzcnNZ3DL+FdwL2+d8VDLb59SDLr2lzaSLsBcb3utB3pk7J?=
 =?us-ascii?Q?zvFlCTGetKvTND1kaIG/zl/+E+FjDmkQ9IPjy1USn6SPgRweeX5OISXoHlJg?=
 =?us-ascii?Q?TEJsKoYa0bFmcRwN6LiOQZ2Y/NK6omxBcNMsJQ9tZgNzOKZMUg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PBuqN9yosJluk8f/DmFmwMaf0HxfPvCfBrSmXyK8lliYY4X2wG+VLK+yYcYk?=
 =?us-ascii?Q?Kdf6f+pR9kGktzRophZNkQAAPGHj8E8sOiee9vnbaGXK9zGpOdquomBthTI8?=
 =?us-ascii?Q?opNPphlkx0/0xD2JA/M6TjM5cZQc12eRfnpMqqxOtUw/2JMkGa9RwAwXbOnG?=
 =?us-ascii?Q?l+vb3Q4W3RIhli7FNLuJl2MdMrN0EyrDLEZ4qGsiKMLz/5nKUfvjg6mhDGvl?=
 =?us-ascii?Q?tFgxbqsA0REqtsSfgtai28t3cq/LhnQf3lDve2Ys2JOmr+atcasxRJ5grjna?=
 =?us-ascii?Q?PT/fpJN0+y7d8E7Uu+iefozb5Qi5eH0H/jmPe/sCbep/XP5Zp8aQVsy7teOq?=
 =?us-ascii?Q?XWReU0U6QyLKxk72gybtcuaYZylBr0TEXvkwBlFHztacGXcFFWMUVsxT+4U2?=
 =?us-ascii?Q?Rn9n9X3BhUGeGqlDeuiRzwJoTgyc9duaq6A/CNHkL815W9sVWDXVWN6rqjnh?=
 =?us-ascii?Q?8T9e5xfWIR6rCmG5/ZuhwyQAr6xPO/RFFvDciI2sbTZoxVC+FSaXg+SzPRWT?=
 =?us-ascii?Q?8b0oP+n3wyAizUlkLSxApzsVJNTY80+/RcNF34CiJE7oJrCoVACbHOufx2GR?=
 =?us-ascii?Q?9K3OsJczDogxZdN17CENW9AUhemJRERQ3ccvLk2qHx+3V7rEk5HXgB/gJWiX?=
 =?us-ascii?Q?u8xRtlifhPoJ+9CZc7xohW/B2D8U3e7aMJru1czfq6LqUo0dCriF/I2tt2Ui?=
 =?us-ascii?Q?trtZCvylq8S5ENTGVYEOELfQ0BhOzQmyYxPZOxtrPcIShou3kc/7P+tmT31w?=
 =?us-ascii?Q?TbS7cRYqjcqw+nwYbvv7mbURnLtOAIo3ROBm0V8769fBAjWyd/K4QRdU3mFV?=
 =?us-ascii?Q?csAVG/XVcUZamBU4kEGQeBUxCFOcxyyiLJRf+3RhJrgR+5rrV5z+4nE54+cZ?=
 =?us-ascii?Q?u+hFQF7gfhH1J6w/qM6TgSsTp/DJJhyMheH68rq7rAoiV+iYY3+tp/ursA1F?=
 =?us-ascii?Q?NPWcxYWmeZsOD8CPBNbjZqIA+z+ARfHwg71eofSrOQFpjeq7m7YbqExbrvoD?=
 =?us-ascii?Q?ZBehRZso8VgJMuQ6/TvIigFWdVGtGJnjyJ5NMHerjgKb42x/z+nQqSGYjCNZ?=
 =?us-ascii?Q?UM+LS2mg7IYnVAk7EYTm1kUrNNHTkOSFeYBZlvOYBD9JuJHcPXmH1rtUMMsw?=
 =?us-ascii?Q?+E/7+kGlbYJO4yUR4eSom2/n5XSLGlss+mYg6/+oGpjlbUP55Rq+ERsYEJ56?=
 =?us-ascii?Q?CZN6+HQG7yaW9nX1s1xLkV7vUPuXkG8KXEU1kTVqpIwv1Wa4VP/0MBMrLrSn?=
 =?us-ascii?Q?2/tIVMdRfxNHmxJEV7M0bTHX1Zi41fJymG2EqNkeF4MJafwWYFAT2KXmEhlB?=
 =?us-ascii?Q?kAJ1SQDrdq+n+ezqLDgGOaASOmmmA083iX23KWY2vCR5LgWlvU+NC5tvLl4v?=
 =?us-ascii?Q?4348O7WaIj7UwrYHnpx+iMmbzSkgtgOEQKqYCgm0ecR0MlIWvx/XEV3lKDJ8?=
 =?us-ascii?Q?3r8ztHDjPvbx23Sf0CRCztPDajoBgvBW+2P5JC+jizzhJNUzixHuXKJYPuw3?=
 =?us-ascii?Q?+iK6hSJcE/fxvmyHztHc+80etalzpVSKhp9EMqPn4PQblQPF1oJ8znVFu2P5?=
 =?us-ascii?Q?Oua7uchJDUj9i8TKwTMHnWSN7Cla5FzokuyjAWvH3wNFZDQvut+ty5FP3pv9?=
 =?us-ascii?Q?jBbfnECEB+R4kSsIfBepmuI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3347C25C45DB184CB1F55833C1F65A3E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f03dTBeZJGipPJ02XKk03ByU2SSzk155SYg9mohzRKECtDl7Vvf/CT/tdBpsCz6uoQp0/jWt6VeNJ0y8H0ls8WLz2WEugFY4AMPAiIXuKz6LyJZOKLpFzvWKS8NUA6KQV1KMfiF2NzzbnI22edlkxhdBLZsrp1Ywf24vJEPCdzrgd+oMqCp5WOGnVo3K4BS4rNCjw0/F41PK9RZ4zj3MOwZEtxYnhCPO5Dnf3twsQT5baK2KscJNCUYpRygQx2rvHDZnAYaLInvFv2hPmm/XkUP9kpkfUy4ce+XPK/nxUighxtMG6t/6t5hVlqpteQiRbOmkPLVCqJ2Uj8GGQoCThza6fbn558JF9EG8IpHj3xhemsaHqrqs6ylPQUYR+xRCzSx31zU//FUL2Uo12AsZumW52+zXOZxeVB4JiMKzb9K4XYXgpUixpHk+i56osSXV470Y5DGQw5LyHwrsZFV9eD7iT5+PoZ5LAYnChf6d4XqVg9e/lNplr4PmD8VMw7cu9nr09xoc5mJrpkjcMXlwc8wwfUSrfuce/N0u/kNYWJe43xRjj9D7iOj4lbkNiRRspgSpkPYTeYbAb65Om3WyG9WvMPcNM+ZSEpJ8QNoiUXlfpRQ3FjKLVkHODfSu+6fZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030d27c0-db30-416c-6f0f-08dd3b4a6ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 01:08:15.9519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DlSTJ8sjhldiFWiz2OAOtOWNoF1D/pSu3v8XCTPo+wXS0A0XfmgCxklNkk17FVDavELvr/KL1s+5DpWVYYoD8ZJ5cv47K0iFLPuTUgugK90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6848

Hi all,

I ran the latest blktests (git hash: 50af4ac28c0d) with the v6.13 kernel. A=
lso,
I checked CKI project runs for the kernel. I observed six failures listed b=
elow.
Comparing with the previous report with the v6.13-rc2 kernel [1], two of th=
em
are new.

[1] https://lore.kernel.org/linux-block/qskveo3it6rqag4xyleobe5azpxu6tekiha=
o4qpdopvk44una2@y4lkoe6y3d6z/

List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: block/001 (new) (on bearmetal testnode)
#2: block/002
#3: nvme/037 (fc transport)
#4: nvme/041 (fc transport)
#5: nvme/058 (loop transport) (new)
#6: throtl/001 (CKI project, s390 arch)


Three failures, which were observed with v6.13-rc2 kernel, are no longer
observed.

Failures no longer observed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

#1: block/030:
    It looks resolved by fixes out of storage subsystem.

#2 nvme/031 (fc transport):
    It disappeared and I am not aware of the reason. However, similar failu=
res
    are still observed with nvme/037 and nvme/041.

#3: nvme/052 (loop transport):
    Nilay provided a fix in nvme driver (Thanks!). However, the fix commit
    74d16965d7ac looks causing another failure of nvme/058. Refer to the
    failure description below.


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: block/001

    This test case fails with a lockdep WARN "possible circular locking
    dependency detected" [2]. This failure was observed with v6.13-rc2
    kernel and still observed with v6.13 kernel.

    The lockdep splat shows q->limits_lock. This failure looks related to
    the fix discussion for "queue freeze and limit locking order" [3].

    [3] https://lkml.kernel.org/linux-block/20250107063120.1011593-1-hch@ls=
t.de/

    This failure is observed with my baremetal testnode. It is not observed
    with my QEMU test node, and I was not aware of it when I sent out the
    report for the v6.13-rc2 kernel [1].

#2: block/002

    This test case fails with a lockdep WARN "possible circular locking
    dependency detected". It was observed with the v6.13-rc2 kernel, and
    still observed with v6.13 kernel. Refer to the report for v6.13-rc2
    kernel [1].

#3: nvme/037 (fc transport)
#4: nvme/041 (fc transport)

    These two test cases fail for fc transport. Refer to the report for v6.=
12
    kernel [4].

    [4] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhb=
ohypy24awlo5w7f4k6@to3dcng24rd4/

#5: nvme/058 (loop transport)

    This test case hangs occasionally. The hang is recreated in stable mann=
er by
    repeating the test case about 20 times. Before the hang, kernel reports=
 Oops
    and KASAN null-ptr-deref [5]. I bisected and found the trigger commit i=
n
    v6.13-rc6 tag:

     74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")

#6:throtl/001:

    CKI project reported the failure of this test case for the v6.12 kernel=
 and
    s390 architecture [6]. It looks still observed for the v6.13 kernel [7]=
.

    [6] https://datawarehouse.cki-project.org/kcidb/tests?tree_filter=3Dmai=
nline&kernel_version_filter=3D6.12.0&test_filter=3Dblktests&page=3D1
    [7] https://datawarehouse.cki-project.org/kcidb/tests/16072179



[2] WARNING: possible circular locking dependency detected at block/001

WARNING: possible circular locking dependency detected
6.13.0-kts #1 Not tainted
------------------------------------------------------
modprobe/1776 is trying to acquire lock:
ffff8881343963e0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: =
__flush_work+0x398/0xbb0

but task is already holding lock:
ffff888120f34f20 (&q->q_usage_counter(queue)#23){++++}-{0:0}, at: sd_remove=
+0x89/0x130

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&q->q_usage_counter(queue)#23){++++}-{0:0}:
       blk_queue_enter+0x3dd/0x500
       blk_mq_alloc_request+0x481/0x8e0
       scsi_execute_cmd+0x153/0xb80
       read_capacity_16+0x1ce/0xbb0
       sd_revalidate_disk.isra.0+0x166a/0x8e00
       sd_probe+0x869/0xfa0
       really_probe+0x1e0/0x8a0
       __driver_probe_device+0x18c/0x370
       driver_probe_device+0x4a/0x120
       __device_attach_driver+0x162/0x270
       bus_for_each_drv+0x115/0x1a0
       __device_attach_async_helper+0x1a0/0x240
       async_run_entry_fn+0x97/0x4f0
       process_one_work+0x85c/0x1460
       worker_thread+0x5e6/0xfc0
       kthread+0x2c3/0x3a0
       ret_from_fork+0x31/0x70
       ret_from_fork_asm+0x1a/0x30

-> #2 (&q->limits_lock){+.+.}-{4:4}:
       __mutex_lock+0x1a8/0x1280
       nvme_update_ns_info_block+0x476/0x25f0 [nvme_core]
       nvme_update_ns_info+0xbe/0xa60 [nvme_core]
       nvme_alloc_ns+0x1586/0x2c10 [nvme_core]
       nvme_scan_ns+0x579/0x660 [nvme_core]
       async_run_entry_fn+0x97/0x4f0
       process_one_work+0x85c/0x1460
       worker_thread+0x5e6/0xfc0
       kthread+0x2c3/0x3a0
       ret_from_fork+0x31/0x70
       ret_from_fork_asm+0x1a/0x30

-> #1 (&q->q_usage_counter(io)#7){++++}-{0:0}:
       blk_mq_submit_bio+0x184e/0x1ea0
       __submit_bio+0x335/0x520
       submit_bio_noacct_nocheck+0x546/0xca0
       __block_write_full_folio+0x55b/0xb40
       write_cache_pages+0xaa/0x110
       blkdev_writepages+0xa4/0xf0
       do_writepages+0x180/0x7c0
       __writeback_single_inode+0x114/0xb00
       writeback_sb_inodes+0x52b/0xe00
       __writeback_inodes_wb+0xf4/0x270
       wb_writeback+0x547/0x800
       wb_workfn+0x65a/0xbc0
       process_one_work+0x85c/0x1460
       worker_thread+0x5e6/0xfc0
       kthread+0x2c3/0x3a0
       ret_from_fork+0x31/0x70
       ret_from_fork_asm+0x1a/0x30

-> #0 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}:
       __lock_acquire+0x3118/0x65a0
       lock_acquire+0x1a2/0x510
       __flush_work+0x3b5/0xbb0
       wb_shutdown+0x15b/0x1f0
       bdi_unregister+0x176/0x5c0
       del_gendisk+0x74a/0x940
       sd_remove+0x89/0x130
       device_release_driver_internal+0x36c/0x520
       bus_remove_device+0x1f5/0x3f0
       device_del+0x3c1/0x9c0
       __scsi_remove_device+0x276/0x340
       scsi_forget_host+0xfb/0x170
       scsi_remove_host+0xd6/0x2a0
       sdebug_driver_remove+0x56/0x2f0 [scsi_debug]
       device_release_driver_internal+0x36c/0x520
       bus_remove_device+0x1f5/0x3f0
       device_del+0x3c1/0x9c0
       device_unregister+0x17/0xb0
       sdebug_do_remove_host+0x1fb/0x290 [scsi_debug]
       scsi_debug_exit+0x1b/0x70 [scsi_debug]
       __do_sys_delete_module.isra.0+0x31e/0x520
       do_syscall_64+0x95/0x180
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

other info that might help us debug this:

Chain exists of:
  (work_completion)(&(&wb->dwork)->work) --> &q->limits_lock --> &q->q_usag=
e_counter(queue)#23


[5] Oops and KASAN at nvme/058

[ 2352.930426] [  T53909] Oops: general protection fault, probably for non-=
canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
[ 2352.930431] [  T53909] KASAN: null-ptr-deref in range [0x000000000000002=
8-0x000000000000002f]
[ 2352.930434] [  T53909] CPU: 3 UID: 0 PID: 53909 Comm: kworker/u16:5 Tain=
ted: G        W          6.13.0-rc6 #232
[ 2352.930438] [  T53909] Tainted: [W]=3DWARN
[ 2352.930440] [  T53909] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[ 2352.930443] [  T53909] Workqueue: nvmet-wq nvme_loop_execute_work [nvme_=
loop]
[ 2352.930449] [  T53909] RIP: 0010:blkcg_set_ioprio+0x44/0x180
[ 2352.930457] [  T53909] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 22 0=
1 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 48 48 8d 7d 28 48 89 fa 48 c=
1 ea 03 <80> 3c 02 00 0f 85 09 01 00 00 48 8b 6d 28 48 85 ed 0f 84 c3 00 00
[ 2352.930460] [  T53909] RSP: 0000:ffff888171ba7ac8 EFLAGS: 00010206
[ 2352.930463] [  T53909] RAX: dffffc0000000000 RBX: ffff8881129d21b0 RCX: =
1ffff1102253a43b
[ 2352.930464] [  T53909] RDX: 0000000000000005 RSI: ffffea0004629400 RDI: =
0000000000000028
[ 2352.930466] [  T53909] RBP: 0000000000000000 R08: ffff8881129d2354 R09: =
ffff8881129d2350
[ 2352.930467] [  T53909] R10: ffff8881129d2227 R11: fefefefefefefeff R12: =
ffff88812c148000
[ 2352.930469] [  T53909] R13: 0000000000000000 R14: ffff8881129d20f8 R15: =
ffff8881129d21b0
[ 2352.930471] [  T53909] FS:  0000000000000000(0000) GS:ffff8883ae180000(0=
000) knlGS:0000000000000000
[ 2352.930472] [  T53909] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2352.930474] [  T53909] CR2: 0000559c99fb4520 CR3: 000000017c544000 CR4: =
00000000000006f0
[ 2352.930477] [  T53909] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[ 2352.930479] [  T53909] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[ 2352.930480] [  T53909] Call Trace:
[ 2352.930482] [  T53909]  <TASK>
[ 2352.930484] [  T53909]  ? __die_body.cold+0x19/0x27
[ 2352.930491] [  T53909]  ? die_addr+0x42/0x70
[ 2352.930497] [  T53909]  ? exc_general_protection+0x14b/0x240
[ 2352.930503] [  T53909]  ? asm_exc_general_protection+0x22/0x30
[ 2352.930509] [  T53909]  ? blkcg_set_ioprio+0x44/0x180
[ 2352.930513] [  T53909]  submit_bio+0x88/0x2d0
[ 2352.930518] [  T53909]  nvmet_bdev_execute_rw+0x95b/0xc10 [nvmet]
[ 2352.930541] [  T53909]  ? __pfx_nvmet_bdev_execute_rw+0x10/0x10 [nvmet]
[ 2352.930558] [  T53909]  ? do_raw_spin_unlock+0x54/0x1e0
[ 2352.930564] [  T53909]  ? lock_release+0x575/0x7a0
[ 2352.930567] [  T53909]  ? __pfx_lock_acquire+0x10/0x10
[ 2352.930571] [  T53909]  ? rcu_is_watching+0x11/0xb0
[ 2352.930580] [  T53909]  process_one_work+0x85a/0x1460
[ 2352.930585] [  T53909]  ? __pfx_lock_acquire+0x10/0x10
[ 2352.930588] [  T53909]  ? __pfx_process_one_work+0x10/0x10
[ 2352.930592] [  T53909]  ? assign_work+0x16c/0x240
[ 2352.930595] [  T53909]  worker_thread+0x5e2/0xfc0
[ 2352.930599] [  T53909]  ? __kthread_parkme+0xb1/0x1d0
[ 2352.930602] [  T53909]  ? __pfx_worker_thread+0x10/0x10
[ 2352.930604] [  T53909]  ? __pfx_worker_thread+0x10/0x10
[ 2352.930606] [  T53909]  kthread+0x2d1/0x3a0
[ 2352.930608] [  T53909]  ? trace_irq_enable.constprop.0+0xce/0x110
[ 2352.930614] [  T53909]  ? __pfx_kthread+0x10/0x10
[ 2352.930617] [  T53909]  ret_from_fork+0x30/0x70
[ 2352.930620] [  T53909]  ? __pfx_kthread+0x10/0x10
[ 2352.930622] [  T53909]  ret_from_fork_asm+0x1a/0x30
[ 2352.930628] [  T53909]  </TASK>
[ 2352.930629] [  T53909] Modules linked in: nvme_loop nvmet nvme_fabrics i=
w_cm ib_cm ib_core pktcdvd nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib n=
ft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_na=
t nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr s=
unrpc ppdev 9pnet_virtio 9pnet netfs pcspkr parport_pc i2c_piix4 parport e1=
000 i2c_smbus loop fuse dm_multipath nfnetlink zram bochs drm_client_lib dr=
m_shmem_helper drm_kms_helper xfs sym53c8xx drm nvme nvme_core scsi_transpo=
rt_spi floppy nvme_auth serio_raw ata_generic pata_acpi qemu_fw_cfg [last u=
nloaded: nvmet]
[ 2352.930675] [  T53909] ---[ end trace 0000000000000000 ]---
[ 2352.930677] [  T53909] RIP: 0010:blkcg_set_ioprio+0x44/0x180
[ 2352.930680] [  T53909] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 22 0=
1 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 6b 48 48 8d 7d 28 48 89 fa 48 c=
1 ea 03 <80> 3c 02 00 0f 85 09 01 00 00 48 8b 6d 28 48 85 ed 0f 84 c3 00 00
[ 2352.930683] [  T53909] RSP: 0000:ffff888171ba7ac8 EFLAGS: 00010206
[ 2352.930685] [  T53909] RAX: dffffc0000000000 RBX: ffff8881129d21b0 RCX: =
1ffff1102253a43b
[ 2352.930687] [  T53909] RDX: 0000000000000005 RSI: ffffea0004629400 RDI: =
0000000000000028
[ 2352.930688] [  T53909] RBP: 0000000000000000 R08: ffff8881129d2354 R09: =
ffff8881129d2350
[ 2352.930690] [  T53909] R10: ffff8881129d2227 R11: fefefefefefefeff R12: =
ffff88812c148000
[ 2352.930691] [  T53909] R13: 0000000000000000 R14: ffff8881129d20f8 R15: =
ffff8881129d21b0
[ 2352.930693] [  T53909] FS:  0000000000000000(0000) GS:ffff8883ae180000(0=
000) knlGS:0000000000000000
[ 2352.930695] [  T53909] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2352.930696] [  T53909] CR2: 0000559c99fb4520 CR3: 000000017c544000 CR4: =
00000000000006f0
[ 2352.930699] [  T53909] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[ 2352.930701] [  T53909] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[ 2352.930711] [  T53909] ------------[ cut here ]------------
[ 2352.936426] [  T29734]  nvme6n3: unable to read partition table
[ 2352.936633] [  T53909] WARNING: CPU: 3 PID: 53909 at kernel/exit.c:885 d=
o_exit+0x1841/0x2620
[ 2352.945293] [  T57593] nvme nvme6: rescanning namespaces.
[ 2352.945417] [  T53909] Modules linked in:
[ 2352.969806] [  T57592] nvme nvme5: rescanning namespaces.
[ 2352.969898] [  T53909]  nvme_loop
[ 2352.970502] [  T53882] nvme nvme5: identifiers changed for nsid 3
[ 2352.970607] [  T29734] nvme nvme5: IDs don't match for shared namespace =
1
[ 2352.970634] [  T53909]  nvmet nvme_fabrics
[ 2352.970788] [  T57618] nvme nvme5: IDs don't match for shared namespace =
2
[ 2353.029378] [  T53909]  iw_cm ib_cm ib_core pktcdvd nft_fib_inet nft_fib=
_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nf=
t_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_=
ipv4 ip_set nf_tables qrtr sunrpc ppdev 9pnet_virtio 9pnet netfs pcspkr par=
port_pc i2c_piix4 parport e1000 i2c_smbus loop fuse dm_multipath nfnetlink =
zram bochs drm_client_lib drm_shmem_helper drm_kms_helper xfs sym53c8xx drm=
 nvme nvme_core scsi_transport_spi floppy nvme_auth serio_raw ata_generic p=
ata_acpi qemu_fw_cfg [last unloaded: nvmet]
[ 2353.036622] [  T53909] CPU: 3 UID: 0 PID: 53909 Comm: kworker/u16:5 Tain=
ted: G      D W          6.13.0-rc6 #232
[ 2353.038341] [  T53909] Tainted: [D]=3DDIE, [W]=3DWARN
[ 2353.039661] [  T53909] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[ 2353.041365] [  T53909] Workqueue: nvmet-wq nvme_loop_execute_work [nvme_=
loop]
[ 2353.042905] [  T53909] RIP: 0010:do_exit+0x1841/0x2620
[ 2353.044300] [  T53909] Code: 83 38 1e 00 00 65 01 05 c1 12 d3 75 e9 7a f=
f ff ff 4c 89 fe bf 05 06 00 00 e8 1b e5 02 00 e9 e0 eb ff ff 0f 0b e9 3e e=
8 ff ff <0f> 0b e9 a1 e9 ff ff 48 89 df e8 70 e6 37 00 e9 66 ee ff ff 48 89
[ 2353.047877] [  T53909] RSP: 0000:ffff888171ba7e68 EFLAGS: 00010286
[ 2353.049430] [  T53909] RAX: dffffc0000000000 RBX: ffff88812c148000 RCX: =
0000000000000000
[ 2353.051117] [  T53909] RDX: 1ffff110258292ce RSI: ffffffff8d3c9000 RDI: =
ffff88812c149670
[ 2353.052828] [  T53909] RBP: ffff888119572300 R08: 0000000000000000 R09: =
fffffbfff1d8a244
[ 2353.054551] [  T53909] R10: 0000000000000000 R11: 0000000000046208 R12: =
ffff888122adaf80
[ 2353.056264] [  T53909] R13: ffff88812c148d18 R14: ffff88812c148d10 R15: =
000000000000000b
[ 2353.057992] [  T53909] FS:  0000000000000000(0000) GS:ffff8883ae180000(0=
000) knlGS:0000000000000000
[ 2353.059821] [  T53909] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2353.061465] [  T53909] CR2: 0000559c99fb4520 CR3: 0000000059072000 CR4: =
00000000000006f0
[ 2353.063174] [  T53909] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
[ 2353.064880] [  T53909] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
[ 2353.066560] [  T53909] Call Trace:
[ 2353.067841] [  T53909]  <TASK>
[ 2353.069072] [  T53909]  ? __warn.cold+0x5f/0x1f8
[ 2353.070420] [  T53909]  ? do_exit+0x1841/0x2620
[ 2353.071725] [  T53909]  ? report_bug+0x1ec/0x390
[ 2353.073012] [  T53909]  ? handle_bug+0x58/0x90
[ 2353.074276] [  T53909]  ? exc_invalid_op+0x13/0x40
[ 2353.075562] [  T53909]  ? asm_exc_invalid_op+0x16/0x20
[ 2353.076854] [  T53909]  ? do_exit+0x1841/0x2620
[ 2353.078095] [  T53909]  ? do_exit+0x1b9/0x2620
[ 2353.079346] [  T53909]  ? __kthread_parkme+0xb1/0x1d0
[ 2353.080626] [  T53909]  ? __pfx_do_exit+0x10/0x10
[ 2353.081842] [  T53909]  ? __pfx_worker_thread+0x10/0x10
[ 2353.083096] [  T53909]  ? kthread+0x2d1/0x3a0
[ 2353.084301] [  T53909]  make_task_dead+0xf3/0x110
[ 2353.085523] [  T53909]  rewind_stack_and_make_dead+0x16/0x20
[ 2353.086805] [  T53909] RIP: 0000:0x0
[ 2353.087928] [  T53909] Code: Unable to access opcode bytes at 0xffffffff=
ffffffd6.
[ 2353.089368] [  T53909] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_=
RAX: 0000000000000000
[ 2353.090866] [  T53909] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000000
[ 2353.092348] [  T53909] RDX: 0000000000000000 RSI: 0000000000000000 RDI: =
0000000000000000
[ 2353.093809] [  T53909] RBP: 0000000000000000 R08: 0000000000000000 R09: =
0000000000000000
[ 2353.095268] [  T53909] R10: 0000000000000000 R11: 0000000000000000 R12: =
0000000000000000
[ 2353.096708] [  T53909] R13: 0000000000000000 R14: 0000000000000000 R15: =
0000000000000000
[ 2353.098129] [  T53909]  </TASK>
[ 2353.099194] [  T53909] irq event stamp: 0
[ 2353.100331] [  T53909] hardirqs last  enabled at (0): [<0000000000000000=
>] 0x0
[ 2353.101699] [  T53909] hardirqs last disabled at (0): [<ffffffff8a2f563e=
>] copy_process+0x1f3e/0x85f0
[ 2353.103177] [  T53909] softirqs last  enabled at (0): [<ffffffff8a2f56a0=
>] copy_process+0x1fa0/0x85f0
[ 2353.104627] [  T53909] softirqs last disabled at (0): [<0000000000000000=
>] 0x0
[ 2353.105879] [  T53909] ---[ end trace 0000000000000000 ]---
[ 2353.118197] [  T57617] nvme nvme4: rescanning namespaces.
[ 2353.128761] [  T29725] nvme nvme2: Found shared namespace 3, but multipa=
thing not supported.
[ 2353.134137] [  T29725] ldm_validate_partition_table(): Disk read failed.
[ 2353.136300] [  T29725]  nvme2n2: unable to read partition table
[ 2353.138456] [  T29727] nvme nvme2: rescanning namespaces.
[ 2353.140319] [  T29725] nvme nvme2: IDs don't match for shared namespace =
1
[ 2353.141603] [  T57618] nvme nvme2: IDs don't match for shared namespace =
2
[ 2353.151883] [  T57593] nvme nvme6: rescanning namespaces.
[ 2353.153793] [  T29727] nvme nvme6: IDs don't match for shared namespace =
1
[ 2353.155639] [  T53908] nvme nvme6: Found shared namespace 3, but multipa=
thing not supported.
[ 2353.157427] [  T29661] nvme nvme6: IDs don't match for shared namespace =
2
[ 2353.164329] [  T29668] nvme nvme1: rescanning namespaces.
[ 2353.166402] [  T29661] nvme nvme1: Found shared namespace 3, but multipa=
thing not supported.
[ 2353.167959] [  T29734] ldm_validate_partition_table(): Disk read failed.
[ 2353.168253] [  T53907] nvme nvme1: IDs don't match for shared namespace =
1
[ 2353.169435] [  T29734]  nvme4n2: unable to read partition table
[ 2353.170240] [  T29729] nvme nvme1: IDs don't match for shared namespace =
2
[ 2353.179580] [  T57617] nvme nvme4: rescanning namespaces.
[ 2353.179889] [  T57592] nvme nvme5: rescanning namespaces.
[ 2353.182731] [  T53882] nvme nvme4: IDs don't match for shared namespace =
1
[ 2353.183940] [  T29727] nvme nvme5: IDs don't match for shared namespace =
1
[ 2353.185189] [  T29734] nvme nvme4: IDs don't match for shared namespace =
2
[ 2353.186396] [  T57619] nvme nvme5: Found shared namespace 3, but multipa=
thing not supported.
[ 2353.187663] [  T29729] nvme nvme5: IDs don't match for shared namespace =
2
[ 2353.191043] [  T29661] ldm_validate_partition_table(): Disk read failed.
[ 2353.193068] [  T29661]  nvme1n2: unable to read partition table
[ 2353.239926] [  T57725] nvme nvme1: Removing ctrl: NQN "blktests-subsyste=
m-1"
[ 2353.447377] [  T57725] nvme nvme2: Removing ctrl: NQN "blktests-subsyste=
m-1"
[ 2353.627549] [  T57725] nvme nvme3: Removing ctrl: NQN "blktests-subsyste=
m-1"
[ 2366.284407] [  T57619] nvmet: ctrl 3 keep-alive timer (5 seconds) expire=
d!
[ 2366.290390] [  T57619] nvmet: ctrl 3 fatal error occurred!

