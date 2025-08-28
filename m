Return-Path: <linux-rdma+bounces-12971-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C276B39373
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 07:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15DB1692BF
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 05:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6CF2773FB;
	Thu, 28 Aug 2025 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ORxGzBym";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KhWB/CET"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E04A02;
	Thu, 28 Aug 2025 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360585; cv=fail; b=i3l/ugCEOtZREBwRboZFsSn7TRuWkrtqS0fZJSgiFYQPf/DnLv9zjV5Cxm92Sg91ACGUlw7QdiXLbAIm9ZqxP+SV5EyG2yh11Z5urIXAtwWmJOPtoXHqoz8clvbxY2b/5yIW315D4Mz+F0mdADWNFfKGXLNs+6iGFDdqORp3I80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360585; c=relaxed/simple;
	bh=klqQRcn5CkRUKP/5ObkWdni546tqG0awnqIJCBBWuwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mq5ZOgv6Rk4LQ2IEyL1Oqfblia+fCRh4k08SLENBUwjcHeajqXMq8ruX7sP2Or7pTsRfyXceDxbGk/F78iuRwobD7QQyOkJZD8bjrIMjpcJiGy6/57o9UZmrTJoatwdWKjLbuh8nmBGfQPUX/UhIANzyKcew0H4UouhotaXvAls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ORxGzBym; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KhWB/CET; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756360584; x=1787896584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=klqQRcn5CkRUKP/5ObkWdni546tqG0awnqIJCBBWuwQ=;
  b=ORxGzBymPYMuYqyMZZ2/JONGTRoQwYxTUDX4bqRyuTk3F3vYVVsK4Cv2
   ZRpOcW9P8XmwbT0EXBWfVeOeQsbNNRmJ5wh23o2du+GLfmt63oB0K+Thr
   FJVxy2Om+8ckVGfKA7SeP/bN8Gp9saVc9Gz5wGaOO+dqMYEAkoROV0Bz+
   QgZso+z/treDbtaBQzrfT8tTN7o7XSbfZwYHVdsafEIS1g2/nPCN/M9yq
   J24vNWaZvo/vnMIkqZLlOm8GmzgTyUcm/Z+sRhVgm8UJscU7NraYuYHFI
   uVc7s9F00QSxsuRtkvJsMCk8bBr0O+CLuIoGjY1HuTCe8s7e04BDmTndG
   g==;
X-CSE-ConnectionGUID: EIwyaF2eSs2smH4f98XRxw==
X-CSE-MsgGUID: gITq7UabTeShDryMXASSrg==
X-IronPort-AV: E=Sophos;i="6.18,217,1751212800"; 
   d="scan'208";a="105977656"
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.57])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2025 13:55:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FAoA7aO8DvDGgWL1o2jbf6SDBsw+Gnc2SSg2yD4UNiPFbOFHpEoyvLx8XvV5YtRGy/+Dm/+lQ64atJbJq4IUvmjyHd84Cln/0SOK8x4kPuNRA1A5YUA13/vbzhB9+Q52DuHssNlyvLd4F40JwKDS6E6gIc9u/pu5gYRolkhmEns9daFRT96czfeuLwZGdnZXezDzTPra1FvBSVOoZa/z8T4X7t5faMr3tl+0EyCTuaS+AHgWK3UKNeeKR/gihuxhIGW6OZWkS+0uuM4FC79NEshoH0A++c5nO3A0rDHtLZWudR+hqD1b+VdXgIKDF2AlTkzolCSszCZdU5J86pmINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7eNWNa2V/4gjbUQxCeNcWVRkurWOld0sp+zzq77uBI=;
 b=M6NkrpZFF2EeIGXMQiibiI/51FS9snM0du2Gsq1aeYGKiH0kWyJEryZYPrFtSWRmjNPF0D03Qr3h5wVzrX6aCQ3vaF6FoQ7OrmoxZQWB9OVNLM1lpsIbrB5ErihC05grX0JUSg8Iin54S2ZLwrqz7R1FO7ylqgr1iQZ4GMZn3QmxMp6qesVU4MwD09ulyCEqeJ1g6TYLCXoOmPBi1s6RygPmGDLf+KMJg7UTAZeSyL4XdxFnsmHl1D4LIrRTcI2yZ5QVAVmYotXUtJowseAYqmOhk2lbgk09rUxBMsa8VjSuviD+1WzZv8A6Dv4SPxmzKTJxYs2TyUski38amkKVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7eNWNa2V/4gjbUQxCeNcWVRkurWOld0sp+zzq77uBI=;
 b=KhWB/CETcg8t+4Yh6xMMK8zVBcF1kYcixXoIQ6E+5sy1ULD2hXn/AShELPS6xDHWuQFOb/NH5hf4nnfJAToiHZI1KaWAd0//mFQPs6lXu7/wQgkn0S9HkhGpD2lhNfWtEGA87EFLPPv93D4XXlITAO54S0CT3aLcaZ4M4tLqxWA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by LV8PR04MB9778.namprd04.prod.outlook.com (2603:10b6:408:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 05:55:07 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 05:55:06 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17-rc1 kernel
Thread-Topic: blktests failures with v6.17-rc1 kernel
Thread-Index: AQHcDEAYP1DNINhgd0uqNNYw6OHN7bR2XR0AgAFK/gA=
Date: Thu, 28 Aug 2025 05:55:06 +0000
Message-ID: <rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3>
References: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
 <ff748a3f-9f07-4933-b4b3-b4f58aacac5b@flourine.local>
In-Reply-To: <ff748a3f-9f07-4933-b4b3-b4f58aacac5b@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|LV8PR04MB9778:EE_
x-ms-office365-filtering-correlation-id: a75e6d39-6abe-45fe-66b4-08dde5f770d2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?t9bzXSKGwOV3Cz+DjGPfGscfAnRHzWvWgI+G12J7rBXCsidieQitoxZGUGF8?=
 =?us-ascii?Q?39WDeVABxfUpCiTsYtGSBhOmfmhsVIhoZiATLQEfMZfivdXk/nMTE9TeU+rz?=
 =?us-ascii?Q?bG/VTXCPEudUXRA3shtEcj/bPV8+lAHnRFbPA6/oE0Td7TnrwmgAZns53BRi?=
 =?us-ascii?Q?4J2TFMRqhhQxTuv7TbXyR1d9sfrgARrGmASmUrsLh+di4W/QelDMs+6J1eQX?=
 =?us-ascii?Q?FQ/fe93Th7oagz1ZzneuPJr7m6Q8B+7adGTSLHIIwIjD2pD9Af0y1PNSGQ3N?=
 =?us-ascii?Q?BcVjWH8dMC7QcYl4V1CGuh7k+Jm54LCtKqK5kmbdstZTh0TRS1WVSAVDJ2a7?=
 =?us-ascii?Q?s6b5VGVJ4RNKlX47KQNAx71QB2v6Lpqvzajqka69BwDrBMQ6Yy/zXHhAPKSj?=
 =?us-ascii?Q?A45jHtibCEl+xNDAnMjlr3+H81S10AlNMzkF7WwjZLKMMcPpk8DUMK5BHbWb?=
 =?us-ascii?Q?vKVqCIQyOr7ZT9IduS2PNEbLsxeorOj2SF2LdUpWlVZ+HqY72YzfcOVm9mLo?=
 =?us-ascii?Q?Q8ce6HafOwubKbv3na4zK3rmljWFIim1B87dFEKUvjA44kuf2u2bk8XO6Rfh?=
 =?us-ascii?Q?AFx/DVnU/bTi9i0R8JAX+QtPrwTJ3mp/nrq0T98LqvSST8TSw/Mqq0Fnniyo?=
 =?us-ascii?Q?JE/8BlASkI5b7KDDI8ImqsHLI1MhgZNrBrzd4bPrrG+uKs47BUJlfMW7hgq9?=
 =?us-ascii?Q?5L+zBOmOnvpH3wAZTSpNaIP5UAOp6M9bHO1c8OwT2svkGTM0Yovy4NGYwdjw?=
 =?us-ascii?Q?IZlBhbkxXQJLCwqasepXWnVJRhDckXCHsKc3UmNBrbMC65CW6qZXL18aOK9i?=
 =?us-ascii?Q?t8CgsFCsbi4oTyrJh3xgo67DEFi/vFb5ygWSQfF0jJLuO1/cNTgJlOXh2koO?=
 =?us-ascii?Q?K2IEE593hMqa1M+h4K8t6crA799l1oMhxwEC4c04ch3agA1UiTKbzpCugLlm?=
 =?us-ascii?Q?y0sRbzGTUrc0GfR5kpD6//fg1HdmPGGufuup8c7jjG/RfFHDDB00Z/MoXMnx?=
 =?us-ascii?Q?RVnS+LJgX7l7f5QMLBmgJxXztSCmZlUPYt94L6AHcOx8wNjGqT9QVqp6uvyI?=
 =?us-ascii?Q?t5xm0iJe4R6C+sLSJ0Da/vf7YZ19u3YoUsUdgI1dJE0k1O819YHxuaKhYEwk?=
 =?us-ascii?Q?SRulrFuGVrZoWNxbQLukLa2l+0EniLDkuaGQEz+BVTCD7kX/8TvKB7G+T01A?=
 =?us-ascii?Q?GtK/wa2rkIONCyekJGi+0wJgVGcIyqsS/LK4s3W+PGyFV5BPv/GvbbjOdbqT?=
 =?us-ascii?Q?icOO3JPufAUFLmK8Ajmv0zT4+tx+xtgwuEymmrRfv+ok9/pWL6mfdE9Ep93p?=
 =?us-ascii?Q?0kh1XXmbE+i+SaUyUplkz/bqM2XAgzVmzRpAZKj5Wl/tjei+EZrO4gewhpI4?=
 =?us-ascii?Q?oWoMpc+JuwEXevFjwNULxQg4AKgoCVYc5LOvFKOC/vtHkIZKpqD4h8+WWC4e?=
 =?us-ascii?Q?UaXRWZezZudpkEYRkU6o22Tdb0xpHHQtXD2fQ0NLIOu3+7aUe4zqiD7pZf3e?=
 =?us-ascii?Q?74rFGdhiIMTG7Rk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qVh4UzoHs2PrgQTRP1IUYMq1H2iIwVmoUGoT7BollJ1NrVTwT/qGf1wfQA/3?=
 =?us-ascii?Q?/X7whhylBsSDyIDC5DqwvNdPOibDCor2Qy7Ef3Ga8TRV9Foi7p/VSWP9tcai?=
 =?us-ascii?Q?hwgScRZSAANhwtawpBU4CoRY1mwa7Fj+wZf/aoCN0lc17eP22IjNyHp2QG7F?=
 =?us-ascii?Q?fyMyi5rtMQaocVR9V/AqPoGYmWWkTwQZNRTmCD/Vv6TT9PQLZsD3wo934eY6?=
 =?us-ascii?Q?Hh9g0kkcebVNWuxvwNPNK9FMbfxR2MmB6VyTICm9NokCJFxKCbndzozCbT53?=
 =?us-ascii?Q?ZGyiS0jef5vN5+vzs+6wLoz9Zxi0wgsDz5A6edZ/MjZ8pYFuGiSzNE7rDFE5?=
 =?us-ascii?Q?2nMfsADwyNluvsKnurda1NqWVVQFYprvTofhP7zVzKxcSoDdoe+CqT2otuha?=
 =?us-ascii?Q?nr01+oCHMMS4+ziONxWk2AexnROWQdRFYrbNeJon9VbEqjlklzOSghi79+VV?=
 =?us-ascii?Q?rsjVz9snjhsoP5MxZM4HrjVyh8pjGCajo4K9hNjiRa7bGeI89EtDL4LhVAh/?=
 =?us-ascii?Q?DqTqClTwV9Cw6U1e9AL3/TaAcSjCEPtghRYYjT3NaFspZSfsID9Dl3zndclG?=
 =?us-ascii?Q?QnHWwSucOiyr8Azu59eBaKcFRP9Ja6Y0dHaB64WP0X1X3Cyym53vI0rzXMai?=
 =?us-ascii?Q?fyBcl20tdP7kuteW/Epw2cnCJToRtN0HZiFIP8boDLExgp7fux2GS6UcrbrM?=
 =?us-ascii?Q?eSrlmumZB/yuYjGFuVEf4k7yaD/beFFJAFfN4BYhCChL4h18i38jhKzuudD2?=
 =?us-ascii?Q?idNe8zxIsflkAs9pVmYefKX77uRA30kCJ7PCuLLO+7iLU4pPVmafmuQYmoKT?=
 =?us-ascii?Q?WC+FLTD9XN8EW9L11/Ow2ct0Z28eCI7Og+BZvWcMSwbuMxt/dZlEzRFYD+/l?=
 =?us-ascii?Q?U3/mAs0kTom49JSVqTeGMusUx5KB+39HlmMjV+z5ye3frF4XeXDswZqGpiZy?=
 =?us-ascii?Q?HMi8r73VyYsqZWj1aDOTIzFDyRKOYe6aWjw/9n48N1HLhjX8XyMZAcL/EJRc?=
 =?us-ascii?Q?BstsWMEQFNbhwpWjKhEOvp1ZMMZrZH1V7yopS/CKw8MAja6F3q2H0Utf6x1f?=
 =?us-ascii?Q?Ng2rwYyNgZTQAhWozep6c5qCRf5pfDVs/7KUim3TQkdtPvts73K39qpnXcsG?=
 =?us-ascii?Q?E14QIMd/Hd6Nws7hWsMeVh3myBNFSBLcTwcbk1xMbUGCWyjftnVM+qIr35Bb?=
 =?us-ascii?Q?pKxZVj+6H3VydHNxtNGVdCHNdj7gcKkbz8tSf8WhYoKybt8Q13rWCKZHHqQ9?=
 =?us-ascii?Q?zYWVegO+lXqaAGpui4q5//7TAIOWhtQFhfjnHnjDNhdL0M32mG9WH8i0DwRD?=
 =?us-ascii?Q?ykmzx2Ax+xkCcf6rNEw1unBd6Cd2M1IavvTMM4g0/RwPZ/Hu/ySS/MF6+/PY?=
 =?us-ascii?Q?pcLo6ZEHcgjrPDhMPgoJfXczpaLdcyvxUaMOiShZ8zFiOGeJ3crNgI+sLwZm?=
 =?us-ascii?Q?MWkP/K1Irkg/Ot9oD2MlZrW1/x5/aPKWZl9BJO5ESBdWW/q/nECDjr6rudec?=
 =?us-ascii?Q?V19Mjbp1WKbBEiTGhf7oJA+OqWpj+tzOjpShNL5lU6gCwHcPVBjuUA9VEK2D?=
 =?us-ascii?Q?VADXNtw65WOAA0KEwLUZTCK9ezQA8bcDhlOw6eMeE7tHKw4N8mkX8p24N8Bt?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <908645ECBFE33443B9BC6E56A2011ED7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OFPEB0pye2rgPc8Tw1ULtO8YDcRQTknxrIzuk4e8qepgj4+Hfln0Ip6xuO5hcTLzkp+WTa4la+i6GYdp7w2fEk/reutWw7XVYmPv1KvXpUNJaKbmkGVPPjkNIO9idZkDQJPpn/UNRFkMxs/HWthbxDD9iwWxcBKLsfjf3Llqio1cDXprFYPfVL7s8Cgpy/M4s5XHVfE4ReyLZDyLK/P7qqayYg75VS018CDDSKynPUpER9d4HZDEbCRYRsatrPfwaaxU4Nn+VlkLp3udqJzATSQEyzb4fYcWFreuKZJuLdT8hLQsERFJ3NZbqOacHdNTCTn81DA0LWuMEjrvqsbDEOz5aYqwqxJkUv+23E5yNZlZu8hsbv7b5Up7ml5Z+i6PPoF1ezZTzTMLe2gucEAf3DIfEu+T1hSVgKcnr61E/fjfwl0kEDX7UzsKWByRRO5LrOGb3QOJoM5c4NzOQ0xCrahHM6H003opjAR/5NTtjvF6pK6IWE74C9UCBFmedwP/ffDgSGwv7NLWmQtMesqdgkjUkHPL5rsje4ZIwB2uu1gezTmu7p80PYMoNLyqz97Knoj5wmIIN5unIrzjDcrlpApfGY/yHNuNmCnmjctn1A+8klJ/VWb/bkSYvgw1AB2h
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75e6d39-6abe-45fe-66b4-08dde5f770d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 05:55:06.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZ+tUTwUL8YRDSGrJ8biDU/sIP/wnECLCcAmG/zZUDUlw/7C5+LzoeCOJbscgfar2hEokdZX6fjYNVVqpyAx/jpurWKx/akma0YGdB4/7mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9778

On Aug 27, 2025 / 12:10, Daniel Wagner wrote:
> On Wed, Aug 13, 2025 at 10:50:34AM +0000, Shinichiro Kawasaki wrote:
> > #4: nvme/061 (fc transport)
> >=20
> >     The test case nvme/061 sometimes fails for fc transport due to a WA=
RN and
> >     refcount message "refcount_t: underflow; use-after-free." Refer to =
the
> >     report for the v6.15 kernel [5].
> >=20
> >     [5]
> >     https://lore.kernel.org/linux-block/2xsfqvnntjx5iiir7wghhebmnugmpfl=
uv6ef22mghojgk6gilr@mvjscqxroqqk/
>=20
> This one might be fixed with
>=20
> https://lore.kernel.org/linux-nvme/20250821-fix-nvmet-fc-v1-1-3349da4f416=
e@kernel.org/

I applied this patch on top of v6.17-rc3 kernel, but still I observe the
refcount WARN at nvme/061 with.

Said that, I like the patch. This week, I noticed that nvme/030 hangs with =
fc
transport. This hang is rare, but it is recreated in stable manner when I
repeat the test case. I tried the fix patch, and it avoided this hang :)
Thanks for the fix!=

