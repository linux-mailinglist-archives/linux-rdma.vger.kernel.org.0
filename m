Return-Path: <linux-rdma+bounces-2723-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426F38D5868
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 03:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16C6283D01
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 01:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6468F52F6A;
	Fri, 31 May 2024 01:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zxc9R0Ul";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Hez62OKO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DC6FB8;
	Fri, 31 May 2024 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120498; cv=fail; b=mI2Jh9YBetChgxzg+uXXBK3kRSd5/vfOkIui4LLdcRotgMBwzWuNxChMYwnHBSCcXW6vEFTKE1KNXqFH3y6cmZHb2H6sd5c16eiMeETVh+9zz0UUjLJvla8g6yzW24jLFpucVx2rehWqWV7JJt7s7LLdMGObD0gtaj8kbJQ4H0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120498; c=relaxed/simple;
	bh=rvT71Q76PrRVfQ7drtUTWluDtUN+G56T51s0m6AOUg0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y5mbQYLRe/HvXhHdn39L709Zh/HrwK+Qky5GfGcsQt6UmAG6q0HbPCas4X1u13cKmBP+kUl78BluVkMqUF7CI5oEe+ZUDbZFagIiisZOn4mPQq/cD+xGj6z/DsweTR7G0v2c5hveGG8P8uU5N0Om22wBAdF4KiPR0yPhHCNpfow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Zxc9R0Ul; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Hez62OKO; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717120496; x=1748656496;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=rvT71Q76PrRVfQ7drtUTWluDtUN+G56T51s0m6AOUg0=;
  b=Zxc9R0UlWd9VdHWK/8H9+YX1Cs4b+SEK3AuaGA8lsLuYdJZx6wE00CNO
   DNgZZxMkcMO+DqR3DaTwudP4xUQPcJ3G3KhK2Ox3FiWLvJF/zg8ZbsPEO
   L+EBc8DbgUqbUEiauVIaPiv7ppoPEOJ471i0dUxpcTeOWIVhkMB9pOKwB
   z5izyRh0U0CeZHQBwBmUYAsq93bKayE0S2MPDz7uGo/BlNIvvE0leA+0x
   s3Wy55YaJdZjhqXIRhYzNraHnDITNOIfVYjHdicuAdDJf0vSSh5WjLcqo
   qZvwmEP2ZzdDZvHRgeiBW2tBpT4WxXBin5+qh6N2FKS3vTqCcOxQ84cu/
   A==;
X-CSE-ConnectionGUID: zXtG8FKeTei8iHONSRxYdg==
X-CSE-MsgGUID: 1W6kUUZuQ6KKHnMA4FZhUg==
X-IronPort-AV: E=Sophos;i="6.08,202,1712592000"; 
   d="scan'208";a="17689141"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2024 09:54:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2ZpYNYBsR4my0bCYq6jm6XSM7atqXD79QLNFWCiVDHXcDsgzTNLnNSIUbX3VV9ztuptLYNJHivTlMyqoAgHmvgYvw03AaoI4Gr/3tNhbAYRuCMMv43Uc+TTtHO9l3Hdu5kPMPd431vfaR4mbeLtU59wE6FLl3+cSnoCbLM4GvkYGQ1br3PPx3A4O5YcjaX6jG11b89wpjVET+JApEd7+CXlFJ/QCYvzflcmpYH1WwDKyDZfV4fhe8UV3Z+aBYx7Wi15OXXYKwEYs/81HSihyXgOjJK2julZVHjvuSVprHKM9sncoLSJ/I5mFdxlxbYjBW3w+wd7u3YeO/SxK8pLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrG5wbDLFDaNKO9ot8g1xU0Ql77uDI/TOo1P8gbKND4=;
 b=jSm9ElGWV0BZiyJ0v7Tk13H3/hCET3OSCI3NZhimdb++1kId4hROb9kPXtOe+J9VNuwdF0HxfJ16A2PiBgSk3bjUbXzhBBSY9lSHISo33OHSdfF7VyxG8JnjLVj7CiUD9rOV795tm6F2psLB62X+OMxxtIVNZCmCS9WzUvQeyZaPHqYUBkVFf8egPW+GozuP0nlZxf9SESjiQnAeOVKPk0kNShtjZ13ybNJTDs88B5lCR9svEDAe0epOpm+nSeUDk52j9gTpAdUH3cl8sjMP9KVSlT2uJWt4Wdph/r43qEnq2pRJI1M5YZqrLSr+uBedFa4y03fu7Oz+ahI0PNgPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrG5wbDLFDaNKO9ot8g1xU0Ql77uDI/TOo1P8gbKND4=;
 b=Hez62OKOiCljbe8yp4qAcXEeeV1kaqcDzJrklHuiUkZdOPLkVfF2muOtUCtjl+VZWPTMkPKdF3qIjhhuuIojFf4/x3ueyxHldekSlc9pgSgDPpfIC4B7dr5RNZBchSYKtMR1zskbWrX2VMuXR0JKDUutLXnVWxCeDJa6ukecXsk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6993.namprd04.prod.outlook.com (2603:10b6:a03:226::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 01:54:46 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 01:54:46 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.10-rc1 kernel
Thread-Topic: blktests failures with v6.10-rc1 kernel
Thread-Index: AQHasv2DeM2gCBvvcEWHNHypcj0XAQ==
Date: Fri, 31 May 2024 01:54:46 +0000
Message-ID: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6993:EE_
x-ms-office365-filtering-correlation-id: 6c22f80b-cd38-4f35-1f6a-08dc8114a638
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QL1Iwye/f7meltlcTK7E8vgx1S8hylgQuXw/JQ3SMMaPGkytr1+5QltA15Pl?=
 =?us-ascii?Q?tWADT0H3sp8G8dE7HTEhbYuS4sRUmPeU8hh+OYCp/sCtjtNazwcXki7RvM+P?=
 =?us-ascii?Q?XBWzHdQ9S6jpFTDiQeTPcxj7Sdmzb7XzyDFLWlDCDqzfIj9w7mtgxxD1ga2f?=
 =?us-ascii?Q?X3It8SkqTgSSedpftm63L6FtRFO+zpXIWU7qV1U/Hq6lMPAmfMbMSdAzyLWV?=
 =?us-ascii?Q?I3fAbOU0geGye87JbV4ukOeh/KNXtRv/t8JA4Jki7Mkh1u0bKMbVCMVe7CSr?=
 =?us-ascii?Q?XcxcBmZ8I1RU9e9At2ZxW2nLdo8hnNEr0MxAllCGCaTG5T6u+UfRwkhXvbKb?=
 =?us-ascii?Q?nx7B9gnNPVgEi42JUpbGfdSzD78/KatLfAfTJzPUCKGUWLQAi6HFeVkv9G/d?=
 =?us-ascii?Q?muNf38sF2P8f6P96Yn+wQHw6f0km9nJqUruV905WJ5/OvwD3GySS0kusD8VN?=
 =?us-ascii?Q?f2jIcKcHDfuTrdm3q/fmbsW2YOxjv5vYbMSJAnpov2FpLaDiX23mVNYfu4Qp?=
 =?us-ascii?Q?+C6kljOiFLSUgdHOfKQEZqtkVLK8LcUIW6CuEqpNa7+5BvD6EhTKFOGyWZoz?=
 =?us-ascii?Q?fp8HGxAZzWN19fAZvAztyH8orfOP+CotHYehbQ27qwzzveC4hekbs/oiS8gX?=
 =?us-ascii?Q?IqEEUWizl5MsaOpGkTt2XYiZNfS2yOLvOMXF4RGBv8CTtR6TT386YF0yLB9h?=
 =?us-ascii?Q?u1NPBfy0ltfrHuec37yPK3jB20vDO72Go2imTTGslI25CHqTZFf0vuQjjI8b?=
 =?us-ascii?Q?XlKK04THx6BCxmpDms8/ZekDTynUBpd2T9Odnz4MNgRsb4+FSI5vAEJc6/aj?=
 =?us-ascii?Q?60DQx5BihUM9YEvFE0ecmCIfYTfoeG1TobRIkn87Maz+RfoJOS3G89Bca21m?=
 =?us-ascii?Q?auDyGqcimsqkudsH+c4qRzRtGZ5SxSRG+xgfP1p2jmNmQjlkJ0vNwUcCG2PN?=
 =?us-ascii?Q?hVdRShQzr+b0mwTPLLHzbd7/MXMa9HvNtvQCT9Q1Ag1PV8oPlQWr+/fLDCGp?=
 =?us-ascii?Q?I928fzXKAUQLFAx4cacJtHybOICKY33YSdpdjsbOCO/KvD3BDdevzQVkd9Ot?=
 =?us-ascii?Q?kXqu0Iq4qCKEITOBcSUiJgPgr0Jimc9NjuNRcXHpCJKZeNPmsdKEawOEHy8b?=
 =?us-ascii?Q?80TicewCSm19sSIjdJmk8z4kt+qZz62R/ClwQ2vUGBhtAuwNMWPWlqOzDVkP?=
 =?us-ascii?Q?ddQOnqNNtn1ow97zrIQ3i8JdlmKBcDDkHs6OSIQKl9i36L3Gyv9DKbRpH1kF?=
 =?us-ascii?Q?XshdvGVAmEzMx/9p93NAeSgKwEmYRvsWk29DkIuIft2kNQA6j/Pvv5d27IZW?=
 =?us-ascii?Q?y8U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GmRe+F3D3VLKHgWuLyvygUmBiB1YlkMDYKvHx3EtNfhGUW6BngMRXzSWuRZ2?=
 =?us-ascii?Q?UxP0v2c7oK+oRV3/fj8itCchXVVvB+lbZl/pFFJubqEM6Xmo5e8b5JHRR41K?=
 =?us-ascii?Q?BZF7GtOcHY4+ulXs/A4F5Rl1hN9ToappJkqVd5Jd4OEtzlGH8hCMYJelqH9T?=
 =?us-ascii?Q?hY92tYuHn3BcK7Y2J7ZHosvfVN9bfAjE18SYKvtXhVMXs4ZUOq//Cvf7NZJ4?=
 =?us-ascii?Q?4DYlzKAcT+xstJ0nXMNQyO4wNvwt8SERl0ceTTHtOgv15mADeLJEzImAEp2b?=
 =?us-ascii?Q?cW3CSJGf3hnnWf0fRz7EFrwprPCeY3RZKyKpFgJcXMBRea9s/29b8FLQOZUG?=
 =?us-ascii?Q?LPTaGimskG6iOChii1eovraATtn0C0MnxaFPDgwzt+q1AbZzgmEHPenxt11z?=
 =?us-ascii?Q?kCC+V/MHBvUnQMRsKU66s3+y69I18RpBuxlQaN7jnnhDJR+HC99qEHGSnLDZ?=
 =?us-ascii?Q?OK6/1rAbmCPXIFm4W58N5HhM/DV6FYrBf6PnQTDUhtZ+aZLZlyj5YaDJYwMw?=
 =?us-ascii?Q?lrPNd2MAO2GXkdaszW3vmbBNguM6U/W86vgkragIzIRhGSg2sFi3PhRO81nW?=
 =?us-ascii?Q?ptjbrVoGThDrBAgWCFHe0tMmjKuJLDtGbQUF38rZYv8X65EjjC9V6/JCpXUE?=
 =?us-ascii?Q?oQBI3pAG13z4KnP2YsdaNT9zBsm4HqrOjswgnDhB/5w8a3Eknt9TlLFv7Mfp?=
 =?us-ascii?Q?NlNBfJaB/VBXykw9F7pPEJCYh6vwEH3iOdQIU/c8FZXMa/cMhKlHCaXTloMg?=
 =?us-ascii?Q?Ea0JLqDBOh9lS9dPK6n6XGeDx6/k2abdhcHVrP4ZCvmZGacDRgn1xkP5qyaq?=
 =?us-ascii?Q?eA7rGNws9DCR2E6UZ7f0jVdJhYKGWOJp9WorNreFwoKSrgO0PGEjtZv5ljWG?=
 =?us-ascii?Q?OWEavaFi0lwLZVeqIWag8nZ1n2dSz/2TJix5EvhCw1Msp5129dTM6rESgSou?=
 =?us-ascii?Q?wY7cPIgsNteSdbvQeuxodlgGynhEyOJnvBUVde+xSsnSHb+OCA39S8KAkJD0?=
 =?us-ascii?Q?Gu/lo+FOS5MFAZlsNC/w03rGeFJMwLh3sNB4z2zkXDRRbYlyVirCKPwzYkn3?=
 =?us-ascii?Q?FjFnrdE5MUGQ+Zk1b/9rwDvGaZ1Ux1Z3MuJOEXmFOdDQ3nrypqH/9AuSJmsK?=
 =?us-ascii?Q?Y14Njcdj3h9JcFTI08sM0kMcjI2RzTLMqxfHpCEGdDtoa+xh+52eVkWGghEk?=
 =?us-ascii?Q?Qd+EW6v6aYLlc12gaUJOre3bP5POaL7DAkmYLByTXPp7Mw1NI6yxNDXF/8+w?=
 =?us-ascii?Q?Wr4HAbnmdXpu6u4GtNE3YUSn9CU5kqRuM00xiLXKSUPdte20x29231M0Bngh?=
 =?us-ascii?Q?g5xj6TWteg1Qq8tkaTVVNhoW7Bzdidav+XDzD4B4rYIMAMF+sZsIX8RXoqKC?=
 =?us-ascii?Q?IUDOQfuDYT4IPr0EEsMQGoZUif4agD94ydivvVBbE6Exyq7TveYLL0p6VRSh?=
 =?us-ascii?Q?DQKJhaOnOZ+/XtkmBWlri+LlBkPdqPm981MGrwEbrTxDmkEKivm6WWfOo8Eb?=
 =?us-ascii?Q?85EN5oabvMt42oPmpeHnQs69rNafS2w3sEmA6OinU94lEEeHsUjHkHY4yu8W?=
 =?us-ascii?Q?XZfLa9p6hT1LDR7UAIL/BcP5FqTJspa5mn5xaTyxfuER4afXmEeCfUzDblHu?=
 =?us-ascii?Q?0VJKzhfdJGbBkV29FHjeT70=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A7D87954673FFD4A868A290018636B21@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1hTSf1xrMhoba2QHWQqo8TL+OsKCMOPuglEBa8ikAG9RFX/W8+zirxxfM7b534NEWCmbNA6xE3Fsckh65JuGTEJnRsJCm6SYDqKmezZEQygYyLTUp46kBBItZTgtm+N6zRp5awTxOkFuEBlft7tykMiyFZkzQCfHMbjbagH2ZTaw94eF+/kF+Ynpnf6gt1YAcWuV7zqFGU3wyuZ1FyEH18CU//gjoJR6ASE1BaP5tZ5y2EsfiUnuslAsYmA33l3cC7twQBNRUtVLiR2MPo3a0lWo6ZdpVTZyIL71iog2b4igCKYfmB5wgIQuQ4GiJMXqg92gdNZQCmju6PSlYrqpjc3XCartabyD6GX0u2fJFnLRmBp0nP2yUzFrSLfn8vsJZBzUVLkuB2OQa7R6lxC3pRPikMXRqTnkXV0TciXq09MuvCYTRbbdVvdL8UH68VPa4HmEK5zc98a2b4fSdQ2cphTvlz4SAMA6Jx52nWE/qiZXtT/nxpMQhr9+nGbQLEZjdyaMT2S7sza4IUG/2Buz0NGXrw2/WOCpPEyVCCJKn9WJUq+fO44tLVtFStb51L1pmBaNMKfR5QQrJgIU3hwOVSazkfUUtGTD7xT+sb8vXjWVPveq7hbMwhiTWNm7sHGw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c22f80b-cd38-4f35-1f6a-08dc8114a638
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 01:54:46.7676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3yguDPB+PmS7gvCmrt9VpMlDbiDKo5Nblk+t4TZuYwo6npVnHjuq38qEcqfhlmdYzfjXmnMqNy4LSduVEMiCb/SZsZDcmY9nTKOkxFszpJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6993

Hi all,

(I added linux-rdma list to the To list since blktests nvme and srp groups
 depend on rdma drivers.)

I ran the latest blktests (git hash: 698f1a024cb4) with the v6.10-rc1 kerne=
l,
and observed a couple of failures as listed below.

There are two notable differences from the result with kernel v6.9-rc1 [1].
The first one is srp/002,011 hangs with the rdma rxe driver, which was disc=
ussed
at LSF 2024. I no longer observe these hangs with v6.10-rc1 kernel. Great :=
) I
found Bob Pearson made a number of improvements in the driver. I guess thes=
e
changes avoided the hangs. Thank you very much!

The other difference is nbd/002 failure. CKI project still reports it for
v6.10-rc1 kernel [2]. Recently Josef provided blktests side fix [3] (Thanks=
!),
and it has not yet applied to the CKI test run set up. The fix was made for
nbd/001, but I expect that it will avoid the nbd/002 failure also.

[1] https://lore.kernel.org/linux-block/m6a437jvfwzq2jfytvvk62zpgu7e4bjvegr=
7x73pihhkp5me5c@sh6vs3s7w754/
[2] https://datawarehouse.cki-project.org/kcidb/tests/12631448
[3] https://lore.kernel.org/linux-block/9377610cbdc3568c172cd7c5d2e9d36da8d=
d2cf4.1716312272.git.josef@toxicpanda.com/


List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: nvme/041 (fc transport)
#2: nvme/050

Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: nvme/041 (fc transport)

   With the trtype=3Dfc configuration, nvme/041 fails:

  nvme/041 (Create authenticated connections)                  [failed]
      runtime  2.677s  ...  4.823s
      --- tests/nvme/041.out      2023-11-29 12:57:17.206898664 +0900
      +++ /home/shin/Blktests/blktests/results/nodev/nvme/041.out.bad     2=
024-03-19 14:50:56.399101323 +0900
      @@ -2,5 +2,5 @@
       Test unauthenticated connection (should fail)
       disconnected 0 controller(s)
       Test authenticated connection
      -disconnected 1 controller(s)
      +disconnected 0 controller(s)
       Test complete

   nvme/044 had same failure symptom until the kernel v6.9. A solution was
   suggested and discussed in Feb/2024 [4].

   [4] https://lore.kernel.org/linux-nvme/20240221132404.6311-1-dwagner@sus=
e.de/

#2: nvme/050

   The test case fails occasionally with a QEMU NVME device. The failure ca=
use
   is the lockdep WARN among ctrl->namespaces_rwsem, dev->shutdown_lock and
   workqueue work completion. After LSF 2024 discussion, Sagi and Keith wor=
ked
   on the solution and Keith provided the fix [5]. Thank you!

   [5] https://lore.kernel.org/linux-nvme/20240524155345.243814-1-kbusch@me=
ta.com/=

