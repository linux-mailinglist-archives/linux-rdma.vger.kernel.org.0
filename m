Return-Path: <linux-rdma+bounces-13929-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 423F1BECE90
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Oct 2025 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 101924E9D31
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Oct 2025 11:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56025A324;
	Sat, 18 Oct 2025 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="by2FxsRJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T1EGIe8X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724FC199252;
	Sat, 18 Oct 2025 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760786795; cv=fail; b=HXngbKxuocsaceeZalcg32X742002SrJnKH/gU2Juuv56EN5kDCIkcn7IPOpGdLuAzg3WvNWARLEvz5c+pdFsJ3ISh88M9WyktQ3TY6ol8Gms2HXCCq4iEO+BRqKlttiMLtvfgwveUUcLIsx8H/Ex9/oaq+Qz1SYYu5lUBaCZGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760786795; c=relaxed/simple;
	bh=J1XRUsSOorZtQcHAWRbUjbIOjzC8YkT0KgpWQ/Nu0Uk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MbVdD5Hb40HOcqsrcsU03Gru/vyOy2bFOZb2RyIsigDQ8Nzd+35fteufSaWy4ITrTB7iUrjnPcPUymY0T8z0TrLiGuhHIeVIJDGv1mUhN51OsAOol/pUd79qzxUyWKLa5rZUz6S9xC9bNVs24d3ire0LvMHUc6yqb65KksHfAO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=by2FxsRJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=T1EGIe8X; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760786794; x=1792322794;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=J1XRUsSOorZtQcHAWRbUjbIOjzC8YkT0KgpWQ/Nu0Uk=;
  b=by2FxsRJppfKDanStpUGUxKCArVhy+aDnXkyayJqo45eP6kpwbDhZeG5
   lQEVQ+Il5xry9k+0UZs6SEiaI6D+4wp6Ab+vJOwEcMMzQ6NBsoi2X0Rol
   9HoaIncTigD8qv6JCbM/59pIeBJuNwyJ0BO4iLCn4BCZaSwFsjAAdo6KW
   6bjmh2iPGBmDoFdpGF/6dhEWHvRlPz4tIZ9QekW5UxJ8YLaa/fJyUU3yK
   4WK5KN6C1hqFfYTAYUpaq2tfnaYoOF37hcoxjVSBAOkoV85BjM28M05LG
   v4zbx/DTsJ+VeDdImeWZBgtzZpicmZ++28fl3i8SBrMVttsi5Z8DSgkKJ
   w==;
X-CSE-ConnectionGUID: fYyB1UTXTyiHmvNJjlKUJg==
X-CSE-MsgGUID: umUypzlASFudEPfQykoSwQ==
X-IronPort-AV: E=Sophos;i="6.19,238,1754928000"; 
   d="scan'208";a="134439176"
Received: from mail-westus3azon11012029.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.29])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2025 19:26:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGwoKcoMjirCulzG4tmvpoYvqv+o+TGCCbAnvfh1D1zlS3RXpK9N+7F2L6gKwBfNAJcsc23F0T3U20/5IT6389afv8T09BbnNAOguoAIw6selt8lySdKI/vGDpOqQvxaBOB1EizSlz2wbcxQnPmNWZHMasC5vLa2E7meWmMZT1YGSvAsaAtMdxNgVLR56OIN02adc/uZCLewpiVX5AeJoWfDV7WjHVeJBFjYijrN6EO5Gmv8krmZyTPa92Tj5EtKedp0GtNn+Vggyy0eMW+wyXCJfolFU4+XMLCEVBOAIY7NEkgILzqPm3yqnJIWJU0U5pvrJNyTavYA4VqXy7BTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7yNkGs72vDFMb8P2Tf7L2tC3JrPkNqcHnHMXZHw8Y0=;
 b=TnPpcXL1ME1yA4qotnGs+9QmbHQ4efXDERPCtC8DRrs/ks2uqNYq1rlrjpFOaD2oE1l6wBq5DJEytixTquGOkJAl2pyfq5io89GUiwiIh3yzGyfGDjJzu6WCUsC5WxGzMcwrpPummaeb77oWlm4w7U+eTTwj6Im+IRHIE880E35ANuIYzLvM0QSYheTUIewbVsRZgW33WTwSDjPlRwxNryUyotlYgolZMRkGg356mVXReo3dH8cLpFfaiP+mgrBrX1Ic6ZEM7Tc7cgE9rCn4yvdiidnUtfh2NMk2y/drEbEGAAy7nnEu/JNjmqV/h3Uat9In60gXzBFpbDOWq/10Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7yNkGs72vDFMb8P2Tf7L2tC3JrPkNqcHnHMXZHw8Y0=;
 b=T1EGIe8Xqjdg6DYiWsr+PPdBm7sU85Xw8VmhVCxQUHBokzFdAlXIxWeRuHRwidlIqTQsru7qShIC7O6DMIZw2iw0sHemjw3/DA6FL5iwfDaNruCMOzJAbAdZPWGeXNkMiOGWK6rZFo0GgLB7FTisYNEPvewn9iSIKwN3IAAaX1k=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB8539.namprd04.prod.outlook.com (2603:10b6:a03:4ea::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Sat, 18 Oct
 2025 11:26:24 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9228.010; Sat, 18 Oct 2025
 11:26:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.18-rc1 kernel
Thread-Topic: blktests failures with v6.18-rc1 kernel
Thread-Index: AQHcQCII0P3TZOpx506A5UYeFbyrKg==
Date: Sat, 18 Oct 2025 11:26:23 +0000
Message-ID: <ynmi72x5wt5ooljjafebhcarit3pvu6axkslqenikb2p5txe57@ldytqa2t4i2x>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB8539:EE_
x-ms-office365-filtering-correlation-id: d528c693-e375-42e1-41d6-08de0e392b8c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xYsgLuIBw54rJWKD75j3UYZgfPAmtRO3ce15bfnh6bUqCrY4JRra4JtHSH5O?=
 =?us-ascii?Q?8+F+R7yqTImRF34u5PSBBjr9Wn7QPBw+BdG0Us1krlDYWb17pgb/ni7owYhC?=
 =?us-ascii?Q?UsZqPA7bpvy8Mw9vfplZ4XrFp+1K7qOo3HNl8qBqMgUO8nRZ+onwsFvFMiVl?=
 =?us-ascii?Q?ODC+SzlIK5B+kvGKe8DsPi4yHNGWKN9qveqggCeMgIbAFE2aZe/nPv/ZZVwQ?=
 =?us-ascii?Q?NVQBHnNfrd8vDuK9XCq3rbo4qDHbS/oTGK5CHxZsK8gkOBYENgPbefFqnh8l?=
 =?us-ascii?Q?CZEgw1+63++EEAcO7MXYPQHnn51sI0e1/3eou/vBw0qOwhBmR/52P8Zt/Vi8?=
 =?us-ascii?Q?ztiVH/+fg7YwzJpKr+HgbHjgkJA3ZVYNWX0V3mceyUEwtvBGOoZqcme9COYu?=
 =?us-ascii?Q?SPdhXL2h3HRkcgeT+6I9ViuI/RsbzaUUH9uPJSQlE5504by+R8spj0N9NGHW?=
 =?us-ascii?Q?oSNoFdikx6LpVhGbGI2OBbbnj/KzG7wH+F5H3Mw+8d+8gpLBFT2rdTYJBJzD?=
 =?us-ascii?Q?+znRF45KqvX3OAOnVLz6JF92qrGD7Ww4qqxuID3GxB6i4yD2zDGm00LURvWU?=
 =?us-ascii?Q?Zt1w/4ySkC6rHdhwaBAoGWf1aLcduhpyeApYqO0y0ReQEiKkqn2jOHMElz/T?=
 =?us-ascii?Q?f7RmxV+KAzDvqaM8A8PZZBsB412NM86JnChkCS4U7r5AyplTrltyLaEtr3xk?=
 =?us-ascii?Q?a8OkqpC5HcunzDgl2a0LuitPV0ajxpjpjpAkj2PW/gyMLQngSSDBwFYlLSIw?=
 =?us-ascii?Q?N3SpjDtkDjVR+F0BBTfw5pEUN+ubtGK+w8WtT/+/FKYwtB6rBaH5dXBBWIXm?=
 =?us-ascii?Q?kEBsuWQRGFoLBUAXEHe5BDhI7mJ0r2fI0ENTJAK9bbPuKx2A7y//2sdOSIgl?=
 =?us-ascii?Q?MrhNg86w2HOzaSk62HmeHwHND/H8qkbRvatBof8XgnOBYb7xJwNe43BBKXTG?=
 =?us-ascii?Q?ByBazBDzJst6TOjqHT3aws+yqx9BXEKiqgIPYNo523bEKqVrD+9SJxK/0L2o?=
 =?us-ascii?Q?hTUP6lVTRfYWgDIrl1bylNtgiHXr/Diq7JRrlz8S09hykuHPA+P7l4AnyucN?=
 =?us-ascii?Q?UjT4AAIJgTOtTWl2ScoAzIDTCtnv+Ao8/5XsMwwlkRnHtOFJ0Nq8IXfSfbo0?=
 =?us-ascii?Q?2shg9GwxnXAkU8NPcu5sAEU5SNGPHeV0D3a0qdZ0ubm921g6q+hrjcilWS4T?=
 =?us-ascii?Q?Xe2CCjmoua9ncECIykLk112GPvUHtpxhIVZypOD7bw8yYUOMC2gJ1EIYmFTz?=
 =?us-ascii?Q?frtKLfgcITBL7B/JV5uWimyZnHHk0mOCiAsVKMqdZgCn99FxvYVFTxqYZynq?=
 =?us-ascii?Q?F6tDXny0wEj5fdQA7UHUIA4J7vJVC0MZ42RcwZOtrYAtNkia6MixsaLh/R+4?=
 =?us-ascii?Q?B6an5b4gHzQGMuGwK6XYUYsnnDjUhi7VfyOnbg2vu8BTemVJChUKX/Viv509?=
 =?us-ascii?Q?di5pGz50biBAixilWqtW3a6a7CWLObYT5kV+8SP24U0EYLJypWqKutcuyEVX?=
 =?us-ascii?Q?Ly1DjpqJMarBYNksl8V18tRMUnJ30pC6wAWTJYl0yhl5JOyI4q2rbdhNmA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?75ceaH/vhgFhNpevmLuyWKXwpkYFEC4sRn78BNTj31PYOkK/Mj8qKIqG+D9o?=
 =?us-ascii?Q?avq6AA0b3ZpKXaQyKk6WBoBxwDhvBEKIVLTPeQGcp/tRw7lwDDdayH857i/a?=
 =?us-ascii?Q?5t1Cm0Nwj6Sa41Qr3nxGH11Y9ig+h3McjyL2b36AdF3qbS4cDqsmWDryztG0?=
 =?us-ascii?Q?HnZ3s75Sjc6gl6zl/i328k8Jcivl246X8c8ATvbEt3eeTCsihDvDwu6KU6W9?=
 =?us-ascii?Q?U4N/tpJiV8t2lm5lxIGmKvklQXTzfP7qLntR4TCqqI7dZqn1cCcDQCyFKrRf?=
 =?us-ascii?Q?UgPgpZ6UF/4PwohGKjZWWv+dPv3g+TnwPcTYjS4Jg8aSC7kBI5bHtEIZDXhb?=
 =?us-ascii?Q?8t69ps6tXPTu7XEDT8+9Ot/J0PkrhfxUqF8xtbWZ7rWIzSrUPIwXRIYgcjhD?=
 =?us-ascii?Q?xxAwKl04Ff90nsB8IZt24LPLmzI7T1HENaiZvh/wLCIxdq7qZrrkvyxUOqvJ?=
 =?us-ascii?Q?QDdgTeVpOF2BuL8/vVV+kfHpq6dg1Qh1/LKuLOHhVZ+a8LwQBkN2w1R7cPus?=
 =?us-ascii?Q?BoqQUwKMVKJUOWBj6JUEqIgjK1ifPRgPaL0kV6tdinuhvMzb1q9pPYQ5ZThU?=
 =?us-ascii?Q?4EeCR6/D2S4MP4S7vA8gbvuy6VO+QXl378KYVMsQjqTVYALBsVeMWqaP9O7u?=
 =?us-ascii?Q?ZWX1zVnjR/FcIDHMF3LdJmOMLkUpZ07kl602cxOXx3vckmmNCH8q9UbvC6te?=
 =?us-ascii?Q?SomB5Me23ZfZYuAm07L+Cf4h0wOkfUELvb8Jovh3umTAwyVMmDPrRzP0hUV7?=
 =?us-ascii?Q?0sM9tjzAnOyU1J3ogHAJflqN7pAGSGK7f5mB3cR/LPULGDLwDu3XofHCKQkA?=
 =?us-ascii?Q?/oo73WaQHzNqJUhmirEGwjBh41mcQfLDdQ2v7MMFQJmKGxpP3b25fk2kYlGz?=
 =?us-ascii?Q?TnMJHymBV9SFx9gN+cYT/GR/uRj6U9FL75Yj1PPeOh1qjg2xDS/FhkEJl0cL?=
 =?us-ascii?Q?43sorzdhPDBZvwve2A4MUUM28z/ePkfPvNAX4M4XAo2bJoMBJObW3hM2Bey2?=
 =?us-ascii?Q?ZA5tMAqF93ICAANS3l3zaP+3qe77uWIg3ZHyH7YFd0OXVBMEhFefIr+o1R2I?=
 =?us-ascii?Q?dyk2hmNL8uGUD45yEOHJ02z/eH0fP5RgyYHGLsQFaTTLnfyqA02Yrl5pJS0O?=
 =?us-ascii?Q?XFakmoS6hJJgpueggytyXbuCy1tH3FUOlyuRTlqLtNqRQxC2BWn+rTMrZfy8?=
 =?us-ascii?Q?Rq0OslCOIgE7vi4MRuzXySu/LkivQMRQzBFxWwOLLaUWn1uNfWOtpRa7Ibnm?=
 =?us-ascii?Q?MS1/cVEbotJWipPJNYK87aDdabJ7zVjxSEjtotcvsYPR67J/coovvLV04G9f?=
 =?us-ascii?Q?fDvN+9YjIyv1+wueCOsriUIQsnd/S7Sf9JxY2wEQC+O0iWXFAIYl7TW784ul?=
 =?us-ascii?Q?xLE/atLHYzhk5q6WB80k1Z6sI/WfGRfGVRMdbChdcVmOtvdMGXnNJY/F7rL6?=
 =?us-ascii?Q?rwVl5hS0D1wU5a49jPBAdF13iejq9MJ8tMMrQR7SeE+WRXpYHq1JSYGEdHcA?=
 =?us-ascii?Q?mfYHcdVNa+90h9BpQ3RFxk2Nm2g7Fn/dTYft79fys1DdOMwUVknt4tXP+Oi+?=
 =?us-ascii?Q?Yf6nbIA3A3ckm1CpyWQw3Yt8zu9ctpxqbPmBR0nYPSZP8iSCzn4Lly/hy8fv?=
 =?us-ascii?Q?VnRy5JWPpoP3aOO303Gl20o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3B490CCC92F71543BFB673D157313260@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PF8Vp5LAjr6urvwRH099bDmCU6BE0rlmJgTX0PiEaXOSKvt4REDkXvwlmEdWHFvyYatWUZISXSA7qRcyCN9djrSAtzgHXzSIrf7HP8KRMFX/cuO3I2M/Fr5RWIU8N/Yy6r7u8j37UpEzW2GCvtOqYTMyGFeygqFcuXi2pYB+GLEXsFlb7VqG9XB33fg0HDziCIRzk1BArIKqHg8/1UU9NNzCfzksykp8Ewn1q8jixChqI885Yg4xZj1D+xcH1SfPBqspi37GPkUSbjqjNTOLo6EPqNlyWI9thooIrXjMvAHojalrbaKmT126UyggqF7Fxl7pHW+7eDTtB93h2w6lnYXRhsR3g70T+z7rKxdnFmgczMj1NaoewoFJBbKdQiFMs5y5Y3oQLZq0NtB1Y/OcrjrnygZ1yHPDLuBfViDFl7jmwsfpet3huW6nx3SaAIwW265tHdnnD+J6CejHvZXPLEFTGbz/hORb383QZJXOsdEMWIYiO8ELE3zAMKPwNNqGiTOgQOgWAvcqEUDzk56S9QmvAbOPcoRwq3xlaaQ4FYlQ6i2a1ZjUMVuA+KNfz2xbwQAFVy918Fpnov3EiyWjfC7u5SECWrH4hpnG2Uxhiki7nXxcDlkLOuZxGHK55NKX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d528c693-e375-42e1-41d6-08de0e392b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 11:26:23.9203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JKrU3Olvn4wtGyX787Dx9nneITmsJtDsMD2kcdRTjgHF+pGypnOaSmAsfaBXTlNzNynmUl3Uibm4RVhf2at2kEPUQTZYA0zwWuvGVUs3Xsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8539

Hi all,

I ran the latest blktests (git hash: 1673a2ba4d37) with the v6.18-rc1 kerne=
l. I
observed 4 failures listed below. Comparing with the previous report with t=
he
v6.17 kernel [1], 2 failures are newly reported (#3 and #4), but they are n=
ot
caused by the kernel changes between v6.17 and v6.18-rc1. These new failure=
s
are caused by lockdep WARNs, and were hidden by other lockdep WARNs.

[1] https://lore.kernel.org/linux-block/3bbujxlhhzxufnihiyhssmknscdcqt7igyv=
zbhwf3sxdgbruma@kw5cf6u5npan/


List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: nvme/005,063 (tcp transport)
#2: nvme/041 (fc transport)
#3: nvme/014,057,058 (new)
#4: nbd/002 (new)


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: nvme/005,063 (tcp transport)

    The test case nvme/005 and 063 fail for tcp transport due to the lockde=
p
    WARN related to the three locks q->q_usage_counter, q->elevator_lock an=
d
    set->srcu. Refer to the nvme/063 failure report for v6.16-rc1 kernel [2=
].

    [2] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7w=
j3ua4e5vpihoamwg3ui@fq42f5q5t5ic/

#2: nvme/041 (fc transport)

    The test case nvme/041 fails for fc transport. Refer to the report for =
the
    v6.12 kernel [3]. Daniel posted the fix patch series [4] (Thanks!).

    [3] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhb=
ohypy24awlo5w7f4k6@to3dcng24rd4/
    [4] https://lore.kernel.org/linux-nvme/20250829-nvme-fc-sync-v3-0-d69c8=
7e63aee@kernel.org/

#3: nvme/014,057,058

    The test cases nvme/014, 057 and 058 fail due to the lockdep WARN relat=
ed
    to disk->open_mutex, kblocked workqueue completion and nvme partition
    scan_work completion. Yi Zhang had reported it in Jun/2025 [5]. And it =
was
    observed during blktests CI this week [6]. The failure looks independen=
t of
    transport type.

    [5] https://lore.kernel.org/linux-block/CAHj4cs8mJ+R_GmQm9R8ebResKAWUE8=
kF5+_WVg0v8zndmqd6BQ@mail.gmail.com/
    [6] https://lore.kernel.org/linux-block/oeyzci6ffshpukpfqgztsdeke5ost5h=
zsuz4rrsjfmvpqcevax@5nhnwbkzbrpa/

#4: nbd/002

    The test case nbd/002 fails due to the lockdep WARN related to
    mm->mmap_lock, sk_lock-AF_INET6 and fs_reclaim [7]. I observed this
    failure symptom with v6.17 kernel also.

[7]

[ 1580.296055] [  T80776] run blktests nbd/002 at 2025-10-18 19:23:26
[ 1580.464349] [  T80797] nbd0: detected capacity change from 0 to 20971520

[ 1580.533605] [  T80798] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1580.535626] [  T80798] WARNING: possible circular locking dependency det=
ected
[ 1580.537820] [  T80798] 6.18.0-rc1 #100 Not tainted
[ 1580.539720] [  T80798] -------------------------------------------------=
-----
[ 1580.541870] [  T80798] nbd-server/80798 is trying to acquire lock:
[ 1580.543950] [  T80798] ffffffff8c68d080 (fs_reclaim){+.+.}-{0:0}, at: __=
alloc_frozen_pages_noprof+0x1c0/0x650
[ 1580.546179] [  T80798]=20
                          but task is already holding lock:
[ 1580.548738] [  T80798] ffff8881357a62a0 (&mm->mmap_lock){++++}-{4:4}, at=
: lock_mm_and_find_vma+0x2d/0xc80
[ 1580.550307] [  T80798]=20
                          which lock already depends on the new lock.

[ 1580.553212] [  T80798]=20
                          the existing dependency chain (in reverse order) =
is:
[ 1580.554958] [  T80798]=20
                          -> #6 (&mm->mmap_lock){++++}-{4:4}:
[ 1580.556639] [  T80798]        __might_fault+0xc1/0x140
[ 1580.557656] [  T80798]        _copy_from_user+0x22/0xa0
[ 1580.558541] [  T80798]        copy_from_sockptr_offset.constprop.0+0x12e=
/0x180
[ 1580.559506] [  T80798]        do_ipv6_setsockopt+0xa61/0x3770
[ 1580.560440] [  T80798]        ipv6_setsockopt+0x79/0xf0
[ 1580.561336] [  T80798]        do_sock_setsockopt+0x156/0x380
[ 1580.562290] [  T80798]        __sys_setsockopt+0xe0/0x150
[ 1580.563238] [  T80798]        __x64_sys_setsockopt+0xb9/0x180
[ 1580.564127] [  T80798]        do_syscall_64+0x94/0x6c0
[ 1580.564977] [  T80798]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1580.565901] [  T80798]=20
                          -> #5 (sk_lock-AF_INET6){+.+.}-{0:0}:
[ 1580.567303] [  T80798]        lock_sock_nested+0x32/0xf0
[ 1580.568081] [  T80798]        tcp_recvmsg+0xdb/0x530
[ 1580.568822] [  T80798]        inet6_recvmsg+0xfe/0x640
[ 1580.569590] [  T80798]        sock_recvmsg+0xdc/0x220
[ 1580.570368] [  T80798]        __sock_xmit+0x287/0x440 [nbd]
[ 1580.571163] [  T80798]        nbd_handle_reply+0x6be/0xd40 [nbd]
[ 1580.571957] [  T80798]        recv_work+0x21a/0x760 [nbd]
[ 1580.572673] [  T80798]        process_one_work+0x868/0x14b0
[ 1580.573428] [  T80798]        worker_thread+0x5ee/0xfd0
[ 1580.574199] [  T80798]        kthread+0x3af/0x770
[ 1580.574911] [  T80798]        ret_from_fork+0x450/0x580
[ 1580.575599] [  T80798]        ret_from_fork_asm+0x1a/0x30
[ 1580.576390] [  T80798]=20
                          -> #4 (&cmd->lock){+.+.}-{4:4}:
[ 1580.577713] [  T80798]        __mutex_lock+0x1b2/0x22c0
[ 1580.578451] [  T80798]        nbd_queue_rq+0xa9/0xe50 [nbd]
[ 1580.579212] [  T80798]        blk_mq_dispatch_rq_list+0x39b/0x22f0
[ 1580.579979] [  T80798]        __blk_mq_sched_dispatch_requests+0xaa4/0x1=
500
[ 1580.580820] [  T80798]        blk_mq_sched_dispatch_requests+0xa8/0x150
[ 1580.581628] [  T80798]        blk_mq_run_hw_queue+0x1c9/0x520
[ 1580.582360] [  T80798]        blk_mq_dispatch_list+0x4e0/0x1310
[ 1580.583103] [  T80798]        blk_mq_flush_plug_list+0xf8/0x680
[ 1580.583852] [  T80798]        __blk_flush_plug+0x26a/0x4e0
[ 1580.584558] [  T80798]        __submit_bio+0x4d9/0x700
[ 1580.585275] [  T80798]        submit_bio_noacct_nocheck+0x3d4/0xaf0
[ 1580.586084] [  T80798]        block_read_full_folio+0x3db/0x780
[ 1580.586848] [  T80798]        filemap_read_folio+0xa2/0x200
[ 1580.587556] [  T80798]        do_read_cache_folio+0x1ac/0x420
[ 1580.588350] [  T80798]        read_part_sector+0xb9/0x2c0
[ 1580.589054] [  T80798]        read_lba+0x183/0x2f0
[ 1580.589729] [  T80798]        efi_partition+0x248/0x2000
[ 1580.590425] [  T80798]        bdev_disk_changed+0x592/0x930
[ 1580.591221] [  T80798]        blkdev_get_whole+0x144/0x200
[ 1580.591985] [  T80798]        bdev_open+0x610/0xc60
[ 1580.592667] [  T80798]        blkdev_open+0x2a7/0x450
[ 1580.593340] [  T80798]        do_dentry_open+0x799/0x10d0
[ 1580.594198] [  T80798]        vfs_open+0x76/0x440
[ 1580.594895] [  T80798]        path_openat+0x1a52/0x2ac0
[ 1580.595567] [  T80798]        do_filp_open+0x1c1/0x460
[ 1580.596240] [  T80798]        do_sys_openat2+0xef/0x180
[ 1580.596911] [  T80798]        __x64_sys_openat+0x10a/0x210
[ 1580.597627] [  T80798]        do_syscall_64+0x94/0x6c0
[ 1580.598280] [  T80798]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1580.599003] [  T80798]=20
                          -> #3 (set->srcu){.+.+}-{0:0}:
[ 1580.600175] [  T80798]        __synchronize_srcu+0xa0/0x240
[ 1580.600845] [  T80798]        elevator_switch+0x12f/0x660
[ 1580.601518] [  T80798]        elevator_change+0x2de/0x550
[ 1580.602201] [  T80798]        elevator_set_default+0x278/0x2f0
[ 1580.602899] [  T80798]        blk_register_queue+0x31b/0x470
[ 1580.603579] [  T80798]        __add_disk+0x5fd/0xd50
[ 1580.604275] [  T80798]        add_disk_fwnode+0x10f/0x590
[ 1580.605003] [  T80798]        nbd_dev_add+0x6cd/0xa50 [nbd]
[ 1580.605714] [  T80798]        0xffffffffc0bdf14c
[ 1580.606395] [  T80798]        do_one_initcall+0xd1/0x450
[ 1580.607148] [  T80798]        do_init_module+0x281/0x820
[ 1580.607902] [  T80798]        load_module+0x564e/0x7550
[ 1580.608581] [  T80798]        init_module_from_file+0xe5/0x150
[ 1580.609334] [  T80798]        idempotent_init_module+0x226/0x760
[ 1580.610119] [  T80798]        __x64_sys_finit_module+0xc9/0x150
[ 1580.610864] [  T80798]        do_syscall_64+0x94/0x6c0
[ 1580.611515] [  T80798]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1580.612290] [  T80798]=20
                          -> #2 (&q->elevator_lock){+.+.}-{4:4}:
[ 1580.613481] [  T80798]        __mutex_lock+0x1b2/0x22c0
[ 1580.614164] [  T80798]        elevator_change+0x12c/0x550
[ 1580.614917] [  T80798]        elv_iosched_store+0x27a/0x2f0
[ 1580.615730] [  T80798]        queue_attr_store+0x23b/0x360
[ 1580.616430] [  T80798]        kernfs_fop_write_iter+0x3d6/0x5e0
[ 1580.617236] [  T80798]        vfs_write+0x52c/0xf80
[ 1580.617888] [  T80798]        ksys_write+0xfb/0x200
[ 1580.618545] [  T80798]        do_syscall_64+0x94/0x6c0
[ 1580.619209] [  T80798]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1580.619973] [  T80798]=20
                          -> #1 (&q->q_usage_counter(io)){++++}-{0:0}:
[ 1580.621221] [  T80798]        blk_alloc_queue+0x5bf/0x710
[ 1580.621924] [  T80798]        blk_mq_alloc_queue+0x13f/0x250
[ 1580.622627] [  T80798]        scsi_alloc_sdev+0x843/0xc60
[ 1580.623372] [  T80798]        scsi_probe_and_add_lun+0x473/0xbc0
[ 1580.624205] [  T80798]        __scsi_add_device+0x1be/0x1f0
[ 1580.624947] [  T80798]        ata_scsi_scan_host+0x139/0x3a0
[ 1580.625708] [  T80798]        async_run_entry_fn+0x93/0x540
[ 1580.626403] [  T80798]        process_one_work+0x868/0x14b0
[ 1580.627181] [  T80798]        worker_thread+0x5ee/0xfd0
[ 1580.627879] [  T80798]        kthread+0x3af/0x770
[ 1580.628510] [  T80798]        ret_from_fork+0x450/0x580
[ 1580.629224] [  T80798]        ret_from_fork_asm+0x1a/0x30
[ 1580.629916] [  T80798]=20
                          -> #0 (fs_reclaim){+.+.}-{0:0}:
[ 1580.631062] [  T80798]        __lock_acquire+0x14b7/0x22b0
[ 1580.631729] [  T80798]        lock_acquire+0x16a/0x310
[ 1580.632412] [  T80798]        fs_reclaim_acquire+0xd5/0x120
[ 1580.633165] [  T80798]        __alloc_frozen_pages_noprof+0x1c0/0x650
[ 1580.633933] [  T80798]        alloc_pages_mpol+0x151/0x380
[ 1580.634597] [  T80798]        folio_alloc_mpol_noprof+0x12/0x210
[ 1580.635418] [  T80798]        vma_alloc_folio_noprof+0xc6/0x180
[ 1580.636131] [  T80798]        do_anonymous_page+0x786/0x1820
[ 1580.636825] [  T80798]        __handle_mm_fault+0x137d/0x1cf0
[ 1580.637620] [  T80798]        handle_mm_fault+0x220/0x7d0
[ 1580.638294] [  T80798]        do_user_addr_fault+0x231/0xa40
[ 1580.638989] [  T80798]        exc_page_fault+0x83/0x110
[ 1580.639691] [  T80798]        asm_exc_page_fault+0x22/0x30
[ 1580.640471] [  T80798]        rep_movs_alternative+0x75/0x90
[ 1580.641239] [  T80798]        _copy_to_iter+0x1d9/0x1630
[ 1580.641951] [  T80798]        __skb_datagram_iter+0x411/0x7e0
[ 1580.642691] [  T80798]        skb_copy_datagram_iter+0x66/0x170
[ 1580.643459] [  T80798]        tcp_recvmsg_locked+0x1516/0x23c0
[ 1580.644194] [  T80798]        tcp_recvmsg+0xf6/0x530
[ 1580.644865] [  T80798]        inet6_recvmsg+0xfe/0x640
[ 1580.645562] [  T80798]        sock_recvmsg+0xdc/0x220
[ 1580.646262] [  T80798]        sock_read_iter+0x268/0x4c0
[ 1580.646947] [  T80798]        vfs_read+0x7a8/0xb10
[ 1580.647651] [  T80798]        ksys_read+0x17e/0x200
[ 1580.648371] [  T80798]        do_syscall_64+0x94/0x6c0
[ 1580.649096] [  T80798]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1580.649857] [  T80798]=20
                          other info that might help us debug this:

[ 1580.651564] [  T80798] Chain exists of:
                            fs_reclaim --> sk_lock-AF_INET6 --> &mm->mmap_l=
ock

[ 1580.653383] [  T80798]  Possible unsafe locking scenario:

[ 1580.654615] [  T80798]        CPU0                    CPU1
[ 1580.655301] [  T80798]        ----                    ----
[ 1580.656041] [  T80798]   rlock(&mm->mmap_lock);
[ 1580.656725] [  T80798]                                lock(sk_lock-AF_IN=
ET6);
[ 1580.657523] [  T80798]                                lock(&mm->mmap_loc=
k);
[ 1580.658385] [  T80798]   lock(fs_reclaim);
[ 1580.658962] [  T80798]=20
                           *** DEADLOCK ***

[ 1580.660368] [  T80798] 2 locks held by nbd-server/80798:
[ 1580.661037] [  T80798]  #0: ffff8881397b6e58 (sk_lock-AF_INET6){+.+.}-{0=
:0}, at: tcp_recvmsg+0xdb/0x530
[ 1580.661998] [  T80798]  #1: ffff8881357a62a0 (&mm->mmap_lock){++++}-{4:4=
}, at: lock_mm_and_find_vma+0x2d/0xc80
[ 1580.662981] [  T80798]=20
                          stack backtrace:
[ 1580.664118] [  T80798] CPU: 0 UID: 0 PID: 80798 Comm: nbd-server Not tai=
nted 6.18.0-rc1 #100 PREEMPT(voluntary)=20
[ 1580.664121] [  T80798] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.17.0-5.fc42 04/01/2014
[ 1580.664123] [  T80798] Call Trace:
[ 1580.664125] [  T80798]  <TASK>
[ 1580.664127] [  T80798]  dump_stack_lvl+0x6a/0x90
[ 1580.664132] [  T80798]  print_circular_bug.cold+0x185/0x1d0
[ 1580.664136] [  T80798]  check_noncircular+0x14a/0x170
[ 1580.664140] [  T80798]  __lock_acquire+0x14b7/0x22b0
[ 1580.664143] [  T80798]  lock_acquire+0x16a/0x310
[ 1580.664144] [  T80798]  ? __alloc_frozen_pages_noprof+0x1c0/0x650
[ 1580.664146] [  T80798]  ? ip6_mtu+0x162/0x3b0
[ 1580.664149] [  T80798]  ? lock_release+0x1ad/0x300
[ 1580.664151] [  T80798]  fs_reclaim_acquire+0xd5/0x120
[ 1580.664153] [  T80798]  ? __alloc_frozen_pages_noprof+0x1c0/0x650
[ 1580.664155] [  T80798]  __alloc_frozen_pages_noprof+0x1c0/0x650
[ 1580.664157] [  T80798]  ? lock_release+0x1ad/0x300
[ 1580.664158] [  T80798]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10
[ 1580.664160] [  T80798]  ? ip6_output+0x262/0x780
[ 1580.664164] [  T80798]  alloc_pages_mpol+0x151/0x380
[ 1580.664167] [  T80798]  ? __pfx_alloc_pages_mpol+0x10/0x10
[ 1580.664170] [  T80798]  folio_alloc_mpol_noprof+0x12/0x210
[ 1580.664173] [  T80798]  vma_alloc_folio_noprof+0xc6/0x180
[ 1580.664175] [  T80798]  ? __pfx_vma_alloc_folio_noprof+0x10/0x10
[ 1580.664177] [  T80798]  ? ___pte_offset_map+0x2a/0x3d0
[ 1580.664180] [  T80798]  ? lock_acquire+0x17a/0x310
[ 1580.664182] [  T80798]  do_anonymous_page+0x786/0x1820
[ 1580.664185] [  T80798]  ? rcu_read_unlock+0x17/0x60
[ 1580.664186] [  T80798]  ? lock_release+0x1ad/0x300
[ 1580.664188] [  T80798]  __handle_mm_fault+0x137d/0x1cf0
[ 1580.664191] [  T80798]  ? mt_find+0x4fa/0x660
[ 1580.664193] [  T80798]  ? __pfx___handle_mm_fault+0x10/0x10
[ 1580.664197] [  T80798]  ? find_vma+0x9d/0x110
[ 1580.664200] [  T80798]  ? __pfx_find_vma+0x10/0x10
[ 1580.664202] [  T80798]  handle_mm_fault+0x220/0x7d0
[ 1580.664204] [  T80798]  do_user_addr_fault+0x231/0xa40
[ 1580.664207] [  T80798]  exc_page_fault+0x83/0x110
[ 1580.664209] [  T80798]  asm_exc_page_fault+0x22/0x30
[ 1580.664211] [  T80798] RIP: 0010:rep_movs_alternative+0x75/0x90
[ 1580.664214] [  T80798] Code: 05 c3 cc cc cc cc 48 8b 06 48 89 07 48 8d 4=
7 08 48 83 e0 f8 48 29 f8 48 01 c7 48 01 c6 48 29 c1 48 89 c8 48 c1 e9 03 8=
3 e0 07 <f3> 48 a5 89 c1 85 c9 75 91 c3 cc cc cc cc 48 8d 0c c8 eb 86 cc cc
[ 1580.664216] [  T80798] RSP: 0018:ffff888122a9f5a8 EFLAGS: 00010246
[ 1580.664218] [  T80798] RAX: 0000000000000000 RBX: 0000000000003000 RCX: =
000000000000051c
[ 1580.664220] [  T80798] RDX: 0000000000000000 RSI: ffff8881283b0790 RDI: =
000055a1d4280000
[ 1580.664221] [  T80798] RBP: ffff888122a9fb20 R08: ffffffff89945d48 R09: =
ffffed102507600e
[ 1580.664222] [  T80798] R10: ffffed102507660e R11: 0000000000000000 R12: =
000055a1d427f8e0
[ 1580.664223] [  T80798] R13: 000000000000001c R14: ffff8881283b0070 R15: =
000000000000301c
[ 1580.664225] [  T80798]  ? _copy_to_iter+0x1c8/0x1630
[ 1580.664228] [  T80798]  _copy_to_iter+0x1d9/0x1630
[ 1580.664230] [  T80798]  ? lock_acquire+0x17a/0x310
[ 1580.664231] [  T80798]  ? find_held_lock+0x2b/0x80
[ 1580.664235] [  T80798]  ? __pfx__copy_to_iter+0x10/0x10
[ 1580.664237] [  T80798]  ? __virt_addr_valid+0x22e/0x4e0
[ 1580.664239] [  T80798]  ? __check_object_size+0x2eb/0x5d0
[ 1580.664243] [  T80798]  __skb_datagram_iter+0x411/0x7e0
[ 1580.664245] [  T80798]  ? __pfx_simple_copy_to_iter+0x10/0x10
[ 1580.664248] [  T80798]  ? __lock_acquire+0x497/0x22b0
[ 1580.664250] [  T80798]  skb_copy_datagram_iter+0x66/0x170
[ 1580.664253] [  T80798]  tcp_recvmsg_locked+0x1516/0x23c0
[ 1580.664256] [  T80798]  ? __pfx_tcp_recvmsg_locked+0x10/0x10
[ 1580.664258] [  T80798]  ? mark_held_locks+0x40/0x70
[ 1580.664260] [  T80798]  ? lockdep_hardirqs_on_prepare+0xce/0x1b0
[ 1580.664262] [  T80798]  tcp_recvmsg+0xf6/0x530
[ 1580.664264] [  T80798]  ? avc_has_perm_noaudit+0x3d/0x290
[ 1580.664268] [  T80798]  ? __pfx_tcp_recvmsg+0x10/0x10
[ 1580.664270] [  T80798]  ? __pfx_sock_has_perm+0x10/0x10
[ 1580.664275] [  T80798]  inet6_recvmsg+0xfe/0x640
[ 1580.664277] [  T80798]  ? __pfx_avc_has_perm+0x10/0x10
[ 1580.664279] [  T80798]  ? __pfx_inet6_recvmsg+0x10/0x10
[ 1580.664281] [  T80798]  sock_recvmsg+0xdc/0x220
[ 1580.664284] [  T80798]  sock_read_iter+0x268/0x4c0
[ 1580.664286] [  T80798]  ? __pfx_file_has_perm+0x10/0x10
[ 1580.664288] [  T80798]  ? __pfx_sock_read_iter+0x10/0x10
[ 1580.664291] [  T80798]  ? rw_verify_area+0x6b/0x5f0
[ 1580.664294] [  T80798]  vfs_read+0x7a8/0xb10
[ 1580.664296] [  T80798]  ? lock_acquire+0x16a/0x310
[ 1580.664298] [  T80798]  ? __pfx_vfs_read+0x10/0x10
[ 1580.664299] [  T80798]  ? lock_acquire+0x17a/0x310
[ 1580.664301] [  T80798]  ? __fget_files+0x1aa/0x2f0
[ 1580.664304] [  T80798]  ? lock_release+0x1ad/0x300
[ 1580.664308] [  T80798]  ksys_read+0x17e/0x200
[ 1580.664310] [  T80798]  ? __pfx_ksys_read+0x10/0x10
[ 1580.664311] [  T80798]  ? __lock_acquire+0x497/0x22b0
[ 1580.664313] [  T80798]  do_syscall_64+0x94/0x6c0
[ 1580.664315] [  T80798]  ? __pfx_css_rstat_updated+0x10/0x10
[ 1580.664319] [  T80798]  ? lock_acquire+0x16a/0x310
[ 1580.664321] [  T80798]  ? handle_mm_fault+0x36d/0x7d0
[ 1580.664322] [  T80798]  ? rcu_is_watching+0x11/0xb0
[ 1580.664325] [  T80798]  ? find_held_lock+0x2b/0x80
[ 1580.664327] [  T80798]  ? rcu_read_unlock+0x17/0x60
[ 1580.664328] [  T80798]  ? lock_release+0x1ad/0x300
[ 1580.664330] [  T80798]  ? find_held_lock+0x2b/0x80
[ 1580.664332] [  T80798]  ? exc_page_fault+0x83/0x110
[ 1580.664334] [  T80798]  ? lock_release+0x1ad/0x300
[ 1580.664336] [  T80798]  ? do_user_addr_fault+0x4c6/0xa40
[ 1580.664338] [  T80798]  ? rcu_is_watching+0x11/0xb0
[ 1580.664340] [  T80798]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1580.664342] [  T80798] RIP: 0033:0x7f0c58a88462
[ 1580.664344] [  T80798] Code: 08 0f 85 61 42 ff ff 49 89 fb 48 89 f0 48 8=
9 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 0=
8 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
[ 1580.664346] [  T80798] RSP: 002b:00007ffdf41c9538 EFLAGS: 00000246 ORIG_=
RAX: 0000000000000000
[ 1580.664347] [  T80798] RAX: ffffffffffffffda RBX: 000055a1d427d020 RCX: =
00007f0c58a88462
[ 1580.664348] [  T80798] RDX: 0000000000003000 RSI: 000055a1d427f8e0 RDI: =
0000000000000005
[ 1580.664349] [  T80798] RBP: 00007ffdf41c9560 R08: 0000000000000000 R09: =
0000000000000000
[ 1580.664350] [  T80798] R10: 0000000000000000 R11: 0000000000000246 R12: =
0000000000003000
[ 1580.664351] [  T80798] R13: 000055a1d427f8e0 R14: 0000000000000005 R15: =
000055a1d427f0f0
[ 1580.664355] [  T80798]  </TASK>
[ 1580.753702] [    T458]  nbd0:
[ 1580.824444] [  T80806] block nbd0: NBD_DISCONNECT
[ 1580.825131] [  T80806] block nbd0: Disconnected due to user request.
[ 1580.825747] [  T80806] block nbd0: shutting down sockets
[ 1580.879783] [  T80812] nbd0: detected capacity change from 0 to 20971520
[ 1580.883993] [  T80802]  nbd0: p1
[ 1581.923717] [  T80820] block nbd0: NBD_DISCONNECT
[ 1581.925322] [  T80820] block nbd0: Disconnected due to user request.
[ 1581.926377] [  T80820] block nbd0: shutting down sockets
[ 1581.980348] [  T80823] nbd0: detected capacity change from 0 to 20971520
[ 1581.984519] [  T80802]  nbd0: p1
[ 1582.040071] [  T80830] block nbd0: NBD_DISCONNECT
[ 1582.041644] [  T80830] block nbd0: Disconnected due to user request.
[ 1582.042681] [  T80830] block nbd0: shutting down sockets=

