Return-Path: <linux-rdma+bounces-6846-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6F5A034DE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 03:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90604164302
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 02:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9B2AF00;
	Tue,  7 Jan 2025 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o8inFtEd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BqX+g9KJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBFA2594A3;
	Tue,  7 Jan 2025 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736215531; cv=fail; b=qp7e2tpZ9FyOPde4rEm6FTtxs2phpSXGvN6QqE9urSAz3R2La0JfW1MnigGiWFD7zMhHLu1XHenxz2AlcDRlBdcUP39WtTeAl4qUJr0YINKjZOEBw0CcrsCb9eHcjL4/7bEVQYPRFx7NoXVtrjDjeO2kB8hH/gZZJfClQcACcc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736215531; c=relaxed/simple;
	bh=9wXjg6vwdOWhaZNzSv21t+izazeYSGBcKSljlty66GY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CnIls15UPuYapvKoMugAcutIM1Unk2q+mXartvBzzwuRrdRGYML78Y7BzRnF7yq3OWJ2PJy/RIWHFZWTpdnBA4Nkcg9ZN441wQak1Ddg8rdA/u3e26YuRFHxQlLZ3n57vc1wFjwL6daSu89h+IKe9ZFcBU56mqX3sMGwRxXDZkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o8inFtEd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BqX+g9KJ; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736215529; x=1767751529;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9wXjg6vwdOWhaZNzSv21t+izazeYSGBcKSljlty66GY=;
  b=o8inFtEdpi9jp4Uu5BedW+CaEBGBzD9WwX8VbfZ/eUmhu2MWDdk9tYGw
   85W4RojA5/P9SNtXGecuhD7cG2pKzz0ecKIaALf19wOnWHFezIu2Uy+hs
   7PURQaXs1XUWhqIRdQYAuwQd9d9UwLOJCWWaTxH4CMHO+rJ3s3oV7wpjf
   aMLRFQ01bJm8dMHN1OmAlP4HCdOq+gsY6A20yf6IYV/chguu14IujJVps
   7CNZbXuXP6RbxBvTyfezEuDXxvwDq7PE2httf1Ow+gBoVlh5OEU2FATrQ
   Zf7YZT9ZIhlzDPkRRgnQPvprQdD/AWDlInTZGeiTsg2nA18eCRPzxkgeh
   Q==;
X-CSE-ConnectionGUID: jf0wskf7RZGEpVYa29b21Q==
X-CSE-MsgGUID: as2wnlLhRdSlTZQ3bxh5gw==
X-IronPort-AV: E=Sophos;i="6.12,294,1728921600"; 
   d="scan'208";a="35852476"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2025 10:04:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1l9ZYygMlsVUblBrn0vs37UyXB6yBSPQ3sAxS6V49o6Vuyg1uSBfm27D6BUCOh+XdVFjJstqJAUDiHqrI8gKHKrqlFrxbW6tZYoAr5aHD8aRpEna51fuY8cQLGrA1MjytM7b2nPXtFNa0zKqX2TqCduf3f9HcXagk2qf3jD6zxvMvC2ImH2TJ6OxB7TGVaYujOFMwqGm0XdW15h803a5ZUxlmogbutBnuN5mqb6errGoDXpITp5RVHWCQdZ69TJX7Rsys8j1oGVyiFKxc1rBd0OJ2zBYJMQEXqueYoWQLXPJfjuVLTJVZydL+KL8hRoLhEJM9BFtN52tqg/exocjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYi6IGdCgk2OSs8yuuOmNQUu3sIlgF8z+evaC2Y9RHw=;
 b=pAMV43MG9pZFWEYbvnpyY3jTfVSF7i7i1Z7PTR7DBlingMhhO5vd+3RRNHA13Lr0UNjOmqScxuPDQdnBQwJ9gJEDuGO5017WrtTKRNSOb6BUMEDd/Da8gVi5oztwv0C8SLn+Y2QifKQluez3IH6yghup1W2d9pBK5UHL1aUNHSnsyisxoMJ1/BPnmD1Cm37/MZpO5Wzui/zE2Hjb2+bsaVBw3GjJj3xCvAxxIuaHJuZNpRigMi+uSiUt6pBoE5NApcJXEoceU/IqWKqzpneUNAPp/0RsPLGp5Ml1BwUjxp1waX/zVPLidvFP/QCWXOJX+4ZttdFf1DWX/+wbrwcEhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYi6IGdCgk2OSs8yuuOmNQUu3sIlgF8z+evaC2Y9RHw=;
 b=BqX+g9KJtfgiVYo30uduh029zrcgsOVRfYO3AKdVnY/vx3zIEQMAjZFsLauMm5FcCYbCTPuprHUiRlmObpUUD5GDLamwgiqNAmLdNgYABHNSLLhACzc8OJvTVxTePqE3w35H+VHQnvcg9Ab166bqtZ2YaQ4D9Y68fr8DzcGNemA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB8401.namprd04.prod.outlook.com (2603:10b6:510:f0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.17; Tue, 7 Jan 2025 02:04:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 02:04:14 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Jack Wang
	<jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: Re: [PATCH blktests v3 1/2] tests/rnbd: Add a basic RNBD test
Thread-Topic: [PATCH blktests v3 1/2] tests/rnbd: Add a basic RNBD test
Thread-Index: AQHbXY5W1hgxdS6jnk+eToMNpK0Q4rMKlciA
Date: Tue, 7 Jan 2025 02:04:14 +0000
Message-ID: <bdla4xc6cza4a3nzcr2vwbj33kuxmqgv5o4rzoxp3sj3cbnzsd@vcpz2z5lkvtg>
References: <20250103031920.2868-1-lizhijian@fujitsu.com>
In-Reply-To: <20250103031920.2868-1-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB8401:EE_
x-ms-office365-filtering-correlation-id: d86dc6f4-d9a5-4b3c-5120-08dd2ebf95cd
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sLFySQ0dS4xFUR79w7gfD54EzBRcXEr7GwfwH/SS64Mu3fb1+MDjr7lAs3eH?=
 =?us-ascii?Q?PK43z4k/PMHCCBusDAvpZ6VB9axVX1hHNXcaxC2jOG7WJW+9bIuZxGAWLMAN?=
 =?us-ascii?Q?iBMIkQzILZJT+WZFlSg6BbC8fgASQVys0zmSSSW1t7nKcGE6N37jyNetSSCb?=
 =?us-ascii?Q?J1/becr5ggTOnFdwvvU/jMupux0cagwA9L1GyO321gmLdFBYYet6YpuEaAr0?=
 =?us-ascii?Q?ezpejSgHNaXhn8kwgS24armOLr7zMXKZQmnuEjCJUtK7DAjWtW8cS60HaP2E?=
 =?us-ascii?Q?JEingBM43sZJfOqejkljCnd/AZRIsHvwVBOSbJgQQwDOwYY47YglnA8pXllc?=
 =?us-ascii?Q?uEaXnVNUjjYX92S/9kuc5tpfQcOSJSHBcL/oPyKaY5VLR9bjTRPvYrFVkflc?=
 =?us-ascii?Q?xlcN3NJXUh1+sYiwhjbgAkfe4RlSPgLlb4MNlMfIiS9rpvEsZrJwfyKuTiuE?=
 =?us-ascii?Q?UxtygXplx6MfP01FcJFHliLU9+DaGkBMwHW1FafJmg6F2ONSgLRlCjCFGdTH?=
 =?us-ascii?Q?nzWvh7O9S+fiUiF74naVgf2ByJ/gvEkBPssn/fXwrZp20x9cILlGip1hLpGZ?=
 =?us-ascii?Q?kQBcPoM47FhWj2uKvMvgjMP+d3fvcdpLrbMnf/dJbmM3ObKgvSRuwIfjvcgr?=
 =?us-ascii?Q?6891Z/5nQzKN7x5mgmbU0Hqicmk39gnru0Mbig4JHGBavzItRH5GQzvrviPa?=
 =?us-ascii?Q?eEb6Z1FGPzFkZCXS/yfU7wIOErkGiRo0IM3IqYJVIjoHgFthdJaO53LdXSFd?=
 =?us-ascii?Q?LBa5SfX4kCqm0X3xzKONnEUaB9SpTR2JNd4+H4gBO9rVyCUfCqvOkAUv1fZf?=
 =?us-ascii?Q?Y5Ze7NQUsLvE7yXxO7sSEhcqTMwsbHc/L8VL4ESOJs1VqTwBWuBU3ftxOitk?=
 =?us-ascii?Q?mI1RhDkDpLEARGPb14QvVcnMyuotyj4g+rGgun5uvQgqPR0+QIM48NqJ+68r?=
 =?us-ascii?Q?MXdxVebWBADBZS3KiwIn/zJneJ9wDhGqZv+gmCv/4Vn209t/7pruUGlljnsO?=
 =?us-ascii?Q?sj5jWAhpba0sH5DN8Imbc4UJrc68uZlRqtKog9G0oh8vOdcqodlzKW4/4p3E?=
 =?us-ascii?Q?ZK42+gTUh5esqWEI4FrPoB8vMfsIlLeUL/3uNI+GK8xgscXUZpIzXPjppbXx?=
 =?us-ascii?Q?rZ3tFAYiiEMhR5/OS7Zq1RYYJ/sWEbr88P1qXrmpDEDx+gkLGIugKR+uJkwX?=
 =?us-ascii?Q?882eFQgz5bd+gWDvQZkdtnNz0G/IfVx+FQXBQETdnYA5oC1PGksvtEohRjlO?=
 =?us-ascii?Q?lZYDMFv3snP8mew2G0qKg6B6YbHSgfplP9aL0fBFnxpM1zujFHfS+R4BABGA?=
 =?us-ascii?Q?mOOjY/iKTTA7YS10H48TrC2y2/39VKo5IUvvRI3iHuhKSVhGVIPL9Y1wNT6l?=
 =?us-ascii?Q?6HVh/5371g894nT1MRpgsK2+Af3NncepTAb7leNTVM9z30HN5MJyazAZ1cyw?=
 =?us-ascii?Q?FxUjNnqYq4d+uvE7uoK2QuvY+5IhwbNa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QHOAXa5tM63XNSY/PdN4ozN0piL9GuFjg2p9eERQ+mVVL0fmsgTF50odygVh?=
 =?us-ascii?Q?3xvh8DTZSn8K3q5htvcdAEtg+zvz1vZMCMiv+tNvW1+7tIbqhJGR5jZ+oSim?=
 =?us-ascii?Q?JBPR19ld7D9jOf+W6kXgm4F7+2QGmiVZ9nMA6HhdDLnuRUjZJepNELSnnwpI?=
 =?us-ascii?Q?ON2duCIyAyqWIMEByyAesVBrFxuhMXurOPTeSm7b+usvYfeX5gic9Pr22xfK?=
 =?us-ascii?Q?a4BUenxICOshy1wbrwULn+n3zHx5zuiiK1jsABGaPD5tMDbPmznI1Y8j27f1?=
 =?us-ascii?Q?eQDWPq5a9MNjUngm3++/ZG659uWmyEFRkZjt3MDSqhGesS6a8gvlh2Kexd8T?=
 =?us-ascii?Q?OrKdy7UtdBr0Qtf6nqUZHxoIrAKwoQ/GC1SdrPFCpH3I0IHSyTx0PcPUVGz5?=
 =?us-ascii?Q?HN8Db15XRSRo1T5G2E7yPXa4B+1VD4vDTPSaOt+UxlLbqGjHigEb8Ig7ruJf?=
 =?us-ascii?Q?ctHoSdw1moP0I3+OM0TVQ/403/TgjLWTdJN9w0j8EAV5KWtykjO2ZtbJN+MD?=
 =?us-ascii?Q?l3I+BJJvFyG3ErNPudNgwQMv+cPWHZyGn6xV3mbjezZ0i41PDOsStxmPyzfH?=
 =?us-ascii?Q?rJAxWufUEr73s5EE2uNt3oVliuKlhqnUswFFG1MiMmoC+7cpT2TXRo/pAgGs?=
 =?us-ascii?Q?j2KIlGInRZVqiLohRJdOlvOWMKPz2c5YIO+7e4lP2TmV/EGw4Kl5fKf/PD3q?=
 =?us-ascii?Q?ZkIl7kuNV+ufhoic6Ta1NOXvdxOkmN/k8yTQQkC9OzxdzSJN+sz/wvPtFve7?=
 =?us-ascii?Q?TN/PqOYtGso6a8hVkv75mejAM3QJGm+C9Gjs5jaF4/19JaOh7TPGKj1Y/pmf?=
 =?us-ascii?Q?RFMfA9zLnE257ffRxxVZ5X2+eHKioNRfUcLry79c5AqnhZuOn0YRE0WsVLCO?=
 =?us-ascii?Q?tiaQBdqXUFMPISiYc/SMkIX3aJ39BdZd3GOVeL1EWI2vQXnoXj/uaBHyZ4Uy?=
 =?us-ascii?Q?cr+56+NYiGDHXMCLnOZQoDPswidRfvGkivQYPhDdgIqaaRlIvdteAtfImVJu?=
 =?us-ascii?Q?XSFPge3f2qxP/jPzjViEEIRDTXUYChCpXTeOhNSsR7G52fHyGZ/YKbg7vLb8?=
 =?us-ascii?Q?KrHd8snFtcfY+7rybPm8Aj0YAULAcisUcHX0cBxlNK9CWD/3i73kj39B8LE1?=
 =?us-ascii?Q?3r4zUs7FrOmN5jdVQHu2yMvukvqFy7gbTv0HNtW/imFdEpXdX64tujyfB6+l?=
 =?us-ascii?Q?FCpbaZtJrpuumOB3YkohMCO99VnrMUi5tvb0lhZ9PbIaD9jCygqabagPb2rW?=
 =?us-ascii?Q?Pv01JuVXkFhdFckxJBdp8a3ZVdinJ6PB9LicUwJh0jyPO/Q7xvAWAnohqLmp?=
 =?us-ascii?Q?ZPymfvr2pcr1HJM1VLFf3nw/oJuThP4ZBxb2cDHIxaYhaKNEC45Egr5t2xRK?=
 =?us-ascii?Q?ZeNhWMOGNHu4sumkWK7OOzlFIUnqV7GQpXgp+N6m32TwkDUCHIyWdn7MESNH?=
 =?us-ascii?Q?D6So7HTphqpxccTnHZu1KMB/KKbML4DdL6ne6cQ0MlqSkhpixJnzSfJGQ1p6?=
 =?us-ascii?Q?hazSFfxzuOMxqueiyYLwSb0ogYKqB5FX8Panwx5PgkcSuzsPili7DTasKzCV?=
 =?us-ascii?Q?j5zJbjgewzWMlz6Nd4ejkXGTi7b0Tpen7GEuNmbw33PuM0O79eA3ZEttztnK?=
 =?us-ascii?Q?1xZMePrTEbLxmLoXI4D6Mlw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59949E546A700A4E84EE818ECF86893A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9O2axQ+I8h/yOEM/f84ssJiN8Rd59G4OZE5pb+vwRJkYi56eQLq2XN2PY38BM+UK+NpieTgfcDh9G332Ps8DPghiUGKd9WXM9W/0YMwzp+0LleFmHD7n2tSq0H+jD2h0UI4dGCnchkqMnZFoJ5n0zjE2tQXVNejxz2jvmwH6LTYvTZ697KiW6JLL0lQpmyg+0vHfS2gfiOfZeXFtKCI2zL9fNksFqxbvZtkv0i8tnz9VrcfzPi/F/jxUvubnb3NXT0KUx7zlcrY6zGFZ/a4Jm6V85byBHegWe4vqac9bBJ7vg4RcR5Hiu/zDaDkh3JxhsCu6G9Cb91OTTmaMo+Gq9Ez0QiFbpUzOzAuK1tndo2qHpOn1nto4VQCHfSPX2xVpiFZe0wozMeNDz4ALelH+hoxZ2cj8eJggrBJGAl6Uld0O/l/Fe1b+NYxfyDEkYe6mP9QGJb9VY29TprSyyTb5p6N8aXfCj1arzqn2JlLFUHm2N8BhjRnLgaNPmAEbA806Ut6UP34/0TGsZ0xPMW/tbBKh9oDEOUVQj+8Q4srneJcMc5kBu4dY6kT63U0ewCjjGLWDmIWwc7f0UeYDmocqaJFMRVIXIy0/LmNsb/maVC+ff4cu2b7chTljvJnZ6ab8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86dc6f4-d9a5-4b3c-5120-08dd2ebf95cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 02:04:14.2741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wtn+f6N9HtlXTaJscckBwJYUimadaxmugdM4lwpDv9bF+IogX+Y/nlrhs9DcPo4O6fkLS8p30zceJaLeI9AEnasKZhRF60OKPMjQp87C50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8401

On Jan 03, 2025 / 11:19, Li Zhijian wrote:
> It attempts to connect and disconnect the rnbd service on localhost.
> Actually, It also reveals a real kernel issue[0].

Good to find another bug and another test case, thanks :)
Please find a nit comment below.

[...]

> diff --git a/tests/rnbd/001.out b/tests/rnbd/001.out
> new file mode 100644
> index 000000000000..c1f9980d0f7b
> --- /dev/null
> +++ b/tests/rnbd/001.out
> @@ -0,0 +1,2 @@
> +Running rnbd/001
> +Test complete
> diff --git a/tests/rnbd/rc b/tests/rnbd/rc
> new file mode 100644
> index 000000000000..1cf98ad5c498
> --- /dev/null
> +++ b/tests/rnbd/rc
> @@ -0,0 +1,51 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> +#
> +# RNBD tests.
> +
> +. common/rc
> +. common/multipath-over-rdma
> +
> +_have_rnbd() {
> +	if [[ "$USE_RXE" !=3D 1 ]]; then
> +		SKIP_REASONS+=3D("Only USE_RXE=3D1 is supported")
> +	fi
> +	_have_driver rdma_rxe
> +	_have_driver rnbd_server
> +	_have_driver rnbd_client
> +}
> +
> +_setup_rnbd() {
> +	start_soft_rdma

The added test cases check exit status of this _setup_rnbd() function, but
this function is not likely return non-zero exist status. I think the line
below instead of the line above will make the exit status checks more
valuable.

        start_soft_rdma || return $?

