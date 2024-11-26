Return-Path: <linux-rdma+bounces-6097-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E29D9058
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 03:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68647169933
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 02:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05061CD2B;
	Tue, 26 Nov 2024 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ToNnL+z2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LAuXYD5f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7738C;
	Tue, 26 Nov 2024 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732587593; cv=fail; b=JM+djSZxkyMQdHC8EbaEREg2V9/lG9M69vkdB68paVQKSzBE56ryWSx2Bsjtheqb4rRKDt6gza0wsE5NaeyQIjkPSdvirQUc+NogG3p3ZleAvBc55MlYMASdDknUa2Etqn26yKLxJGAUjPAnf25XqJw2mUMPSQpgMhxRJjbWqj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732587593; c=relaxed/simple;
	bh=ingHWMF6/g11IT+0URF19SszXgCrJbCO4sJ6L2fCVoE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I24oyFPGXM/MMCdzfF5IIqiw1x7cZa+3lEdr2dahNfJS2YuR9/sAoJFY7TOJeStuqKXIDsKzRa4LVM0JvWgIL3AJN46sCYplaQqLqHlPV58wKCw322TkiVMs06aWdXK+uRB0G9AhED7CyErLEd3jC3blT/zn2vkQa4SrlsuXe20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ToNnL+z2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LAuXYD5f; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732587591; x=1764123591;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=ingHWMF6/g11IT+0URF19SszXgCrJbCO4sJ6L2fCVoE=;
  b=ToNnL+z2UwK9HrlZGHtDfS7rodxC57o34kywF2CL1z6T2Z7Vm2zdPo9w
   uTeQSZt0GxuIjKVXAmfoOH+sQu1aIgp6fKpowERZOH5w68+EZdA+ILgkx
   hdYBWVN9ZmidhbYfjPfTvLRkg2gjqZNH3IKmOFDQYE8pmQgQ2/IdL8zQA
   ZPwjecWukR1WcyzKzJRhCdaDSf3BEetVGoj1Op1sFrD+Szwx5TyB2Nn5j
   jkxynyEAaQr4TuJsULFUUBoJcgmnLD3TnWJbP4sap7qmrLwst/rhS0enr
   XQx/hm+YlwjLiLKw7rjBDoaMQCV1ZqEbVFCi4oRXtnc638m4ibi6T9dWz
   A==;
X-CSE-ConnectionGUID: cBbkszSjSZSbY1HYGX1UYw==
X-CSE-MsgGUID: Qc5BVShHSxi+1QZwWlDgTg==
X-IronPort-AV: E=Sophos;i="6.12,184,1728921600"; 
   d="scan'208";a="32260497"
Received: from mail-westusazlp17013079.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.79])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2024 10:19:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn7UCUxiaNUNxKk+EmqtfDJRBtNUZnfbf5rOjCJRWpz5lRNZ5TwOaotc54AumbVmsYErj927I1WzuvKADUfvOhn2NSInRabOGBTn5nq+tyFF8HBFj4263unahur7Vie4vi6JNjkC2zknGNpCGdx1j1W+lyKaEKa3V8bh5sTtz/ZH3862xYUagfkU3qcaLaxCJ0y4Epztx+DPc8nxyq15YdUC8qv8qJXg8r50jkD5ILyOY5dgtq7HAUYayj427LjAOx5/MSbMPtj8xKF2SKwLec+5EooaYIiqRRvKgFpTdD78i4iUIzEdOVzWSKLbPceZxGGen/D0W7HimbQEM85+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7DqHKSro7v6x4LicCePBocAg68X3NXJDutHIMDZhNo=;
 b=rZFyP4s/T7ridp/nOhyE3I/rceHsDXKme3mLFnlZarYxpSqgr2j2akZUh96u5pCR6FN8yUHO2uBceS4qAQzYyybJxVHOt6jvFH07ipkRIDsBqo9YOcZTXrOBGFVi1vogp+w+u92n33bEs/ovkltwokpjx5ew+oKLMPZKNvQSuy+Gv/lV95WhawNuh7P6XLwNxVaizBrEbY7BktUjnktTCcOHrT433GFm9X1wK5m0P1dscF/arXDEJoZtUQTZkHOP8KeeMFzuDQUpLshlWzhxbHKm6brwVTgoI3H4zeg2XWgrvxcTmBIUr6D5Xe/gTw398Od1nYuZwrl3iA3vgk+Wig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7DqHKSro7v6x4LicCePBocAg68X3NXJDutHIMDZhNo=;
 b=LAuXYD5fNTNxRSfkbPfj3kMV8r0g4t7QlayJm9T7pDX1z/LOE9e48UA2KMl0f5lVArS0uPg6XqJQVjeRP2w0hEA+afMDfzsEo3DMsmhkIPbkK0oCJjQc5YdHbJ23NhQpSL54tOX0dPzBBHVhTwVy83cx9FWHrI5AWpu9EqOqGjk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6715.namprd04.prod.outlook.com (2603:10b6:5:24a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.21; Tue, 26 Nov 2024 02:19:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 02:19:42 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.12 kernel
Thread-Topic: blktests failures with v6.12 kernel
Thread-Index: AQHbP6mmd/vQzXdXIE2SKsJ/nchSFQ==
Date: Tue, 26 Nov 2024 02:19:41 +0000
Message-ID: <6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6715:EE_
x-ms-office365-filtering-correlation-id: 8d7c5cab-45b5-453e-c721-08dd0dc0c96d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FJhQCLrX7MzLuH8tFcSiRvqZIWEvTT2YuuBeYn80hLdCntDqQbJrfaQkJjoh?=
 =?us-ascii?Q?ddHXB8Ur91A7bHiuoQ/dQfPU7yhJr11R5eIE6WzIX3dBbC2X27Yh1Kbylbm9?=
 =?us-ascii?Q?UMan1PVvhNMqAZD6W1hJTUxXFGq/MsoZE/49BQNvedziTAy798F/YCHaJp/Y?=
 =?us-ascii?Q?ZxtObloDnVT4b90bQ1SCGWIZizDwoaDb0A0uN9schGi5M6Gx8zZl0qOv4gS9?=
 =?us-ascii?Q?5EHQNY6sXeKa3ofdKgTYwdAEXhOx/7Mlgnj9y7ZISUWPgsepL8fmQ5OYq5yb?=
 =?us-ascii?Q?zLrIT+JRksxtz1LzD+yjDNz5d8O3T3TMYEbzxVeaeLdezq0np4gA0+DAz5Cy?=
 =?us-ascii?Q?MWwix9FGb3cgrP9OaZtiMKXVLGjPx/uDDwllBWYj8zLanWnpph8+V0Q5OCA8?=
 =?us-ascii?Q?4kUZ7xcjX64iiBktL+fDjOqHWcK/0+ChnT5Sz9FrJt9Utgn8KRqjFx2i7+Uy?=
 =?us-ascii?Q?bVmCyfBq3lwedJ4/vMy9JGDtHL0/hVidOhbmrFCcIePFxWS16TTUJVAMG4Jt?=
 =?us-ascii?Q?3rAT8MNCkpD4WX9DgJXcdCvfOA3PfLgV0y8sJyCeRjiTH9re3heCNRL266LZ?=
 =?us-ascii?Q?YTa3Sy6aSXk04ij5+ljH4wAIS6KJtNhcDmkM9zhwwqCQ4R1CNPp8IT13uOT4?=
 =?us-ascii?Q?4ieBMHVWxz0RZRwCQByKFkmXsC5Q+JXTPnSXhDS3lJWBip2mOoquOVYDpnU/?=
 =?us-ascii?Q?qa/L8+Tb2haTVPwCZf4315hKgAQQ3zaN4UYMXir+myUb34aykTMy3r864dOK?=
 =?us-ascii?Q?ULddGRdiA7wi/mjT8Xx8pSfD68Hb8+vEHAaynGod2uc2v1p8e533lhDT7lse?=
 =?us-ascii?Q?z8GysX6U6kYSFm2hldhFhR61lZa2CvbusAXvU4vnUVr89NTH95VAlbKM0X/9?=
 =?us-ascii?Q?Sqh3H781ZsgsnNBDvArKQpXW+mFjf+jOXsgifKqHtGzfk4sjmAgZwCKrWPBW?=
 =?us-ascii?Q?tzMztIGPr3kP8oDIL+Gm9M8KWzC/ytJmXrJAjVBfQr5DgOlxLscw93Kf49ha?=
 =?us-ascii?Q?0C7ums+2IySdNlRIqueDPgMNCYpIY4+Ibd7obzmpxjEBELd3kzKoKjCIq1re?=
 =?us-ascii?Q?8jaxqONIGAhMx8Tu8idspkuBE1jFbOjTgiwYu1m4ZEKZLSh1YBfRYwcd0Bmb?=
 =?us-ascii?Q?eD8t9O5Bre5mxPhIqTkla7fX6sgMScUe21hbedXlgX5k/iuWHJSDtI3GwvcG?=
 =?us-ascii?Q?8Wq9mV7fcoT4Y0wNaX1NkmndY+D/oj8FoAQqCC6BWyni4xwhkMrfIgn8AK+u?=
 =?us-ascii?Q?ToTVEU8Nds4F/JQGCYJLGt9FVZlHrk+K+nqBToL1BoHrLinmYJ41s2gRkmLS?=
 =?us-ascii?Q?5G5DigTDW03EXaAyLjwBnDqRUAhC0K3rJHO7Quq/CxdNEInUAv5Fpc22FHQD?=
 =?us-ascii?Q?A/JNlUk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kPkcVDB/mYhs4qDrD2cRbOwzylHwXL2Y4yPDxs719tLY+fSnU+amDLuJa9SG?=
 =?us-ascii?Q?v8k3Jd1A7rW+zRVKzw/GEM46xUe/BYQ2KDwMr56SGp4QauZgX/H0dIeXr6Ci?=
 =?us-ascii?Q?x0xK4zqsb1DLNVPbhhRp90ahE27QwPSG5nHCA3g5JR4l1uSzwulw+j4col4x?=
 =?us-ascii?Q?k8yTgOFPfodcRgrPxbV4zkCxs+vLywvfykm31enygfQ774CsFtZZhGfcqBRn?=
 =?us-ascii?Q?Jag/6UHiS8BpFVlr4V6U+1GTG/KnvSMVAphIYTLndvU0Uvj2qwVNw5cJDc/X?=
 =?us-ascii?Q?MCPYM42pcBtgh4CIY+d3gOMaF2hf5FCaMZHdefXmNxyNDCPo1DKVI/QLxE0C?=
 =?us-ascii?Q?EBi1Vex++R80FW/O7nRqBqd1HkqwxRqQMh9rfaQ+f1wDVt2Nrw3FYSMiluBJ?=
 =?us-ascii?Q?IK+vdIVjAPiXg5jZ7IZCeCgIxrQTYCkDwUQDOFFtQ9SKzVoO/z5Aaa9ccX1M?=
 =?us-ascii?Q?nvmjT47eAtCMHcXNucmCAw02hAvAK8qIT0Ypz93iRTfsmpOdfe5GYklQlty2?=
 =?us-ascii?Q?oPwlbq5XQLV0T8VIa24R09GhZAyjf+xqVmCBsgRPLbdoeQLpCQLvqCUy6Koq?=
 =?us-ascii?Q?X9Gvur6kS+4FZ0RAtU8jXOKCB3pdSwfMWOeMMmTiJk3MNj/Hw+KuwJVHili9?=
 =?us-ascii?Q?IP/R6Fu3eux1Ax6zasNhVnBA/3VduBaL3AjDbpYd4dFFTAxzwabdq+VggkQt?=
 =?us-ascii?Q?3S6P3NgD0DF9T/Ma9zM81lYCN4ErT7zzvdEuZqNBm6lHtV45pcnwGIikurYf?=
 =?us-ascii?Q?qGolZuWH5nRROuleh3L/e6erN7oracibhUXWp41Mi0g5F96dN2bHoPAhxKxr?=
 =?us-ascii?Q?UfWAMXi8JtxGS2Z5Zoo9b0GLW3m5GKZoCgjRczekR4mQwkevKKS1tcBAnX0g?=
 =?us-ascii?Q?RXjfpIj5oOj0ytTS9309+URCWyfj1VLhHOBI2PttR3ekrzm0ZLUe9skwIJRN?=
 =?us-ascii?Q?Yqa0sQDIIFP3oGz7f6VJq5gMALm1eN2fsqDFavjZz7I93PmAPLG29nbVCQ8+?=
 =?us-ascii?Q?iA9A0SXt0GbCoBhrT3j5iLYOyqT2eV5v9dfi4V5zQce2s68FJpriJFjHUtN6?=
 =?us-ascii?Q?xP8LuOZnVwRqjGBNlEjg7GhJGoZVYdwvrYi/weTvMOE4hrdQKWDVXgKETG2r?=
 =?us-ascii?Q?0eNoqXJT7Apv5pQsR/Dj0+PZKP3puy5+t4JSYK39sospQYciXfedyr/oBSZa?=
 =?us-ascii?Q?2nHlvvEZj4CPkoAfElKYY4VWk341EOSDQ34PtmSMpYmj4GeADeYv9uVy+p2Z?=
 =?us-ascii?Q?U8y3IMIBhAWWsttFi0x5usdLVarZg4soYE1Sv4EtXn8kZWxUXpKP7ys8zVcy?=
 =?us-ascii?Q?5OKiFz9c3bmGJcjkXRGBxv+nz8++kJg2dk+gW4c59nIxwGL7MMq2k+afd1cJ?=
 =?us-ascii?Q?SCm7ruJ0CpaZCMYmxn18zTbcGVrScOSAEzBNEO2h8ESCRHkd35GATLCfhz95?=
 =?us-ascii?Q?qjoWR0HLByiMsJImCK9vE334zgNcODdjEEOASxSgcXFEaTG/oacUbKnKnf/k?=
 =?us-ascii?Q?QcFcm/RJwNHHbWS0D6QfSpFJCLqQotbxMHU80BVCGiRa9tcExAmzOGIf25+g?=
 =?us-ascii?Q?pzfI7t0kH9hTzEyrbd9VkKc/8o86uhrfkFMAheHQXZXeDiqYkdALryDHQPiY?=
 =?us-ascii?Q?WVCra/vEdRucOxnOiqifRyI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5216FEE5546D984398413E8014C29E31@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VDr0b4jFw2D9ohZX3UL9fZjZx9wiyUDkZ+2vUlu3jmNkG1KD6jR99VxzzXE0Y7Gqa2WLkD2GLqShy1Kdg0KfR2SPigDbRPHxbUVq77PoC/Uy8xYvxGEjirxaQNsnoFNwHJ2ODH/U2PvJVJJcfPt+ytUgMSdJyQiVORZp54SHYcHETd0MVc8XUItJlfceWpmI/zYQswsIBSSwOK4j5d9FWbbnOHgLzG9LwO0eo2cYIM3fWGbakVvjpnr2ESGKMimVtKS+v8lAePq4CpSH8ZwjWofafIOQUbV6Dy7RyPL1X0Bmw7aw8WflxPJjsuqJwx7tHyYPDj/1ZzIlc2brmZH0q25RHD/p11ZwvoL8xAFvxViy0pVXdV8z3HLlCn9TkzskULgIm1kJ9V8/Vr/+vbXuJRrlJd05EIvM8blgAjNTPL79t9G7vgFJrcK7pwMFfx1pqfFbhILauTeg6VpCoqVFikl+XmtJ0RJibmFydpC+DNvpk08PieHqp69HlVAoH7lOQ9eAD/hXFwmpVpAYHUaRHRqWYrrA5Kawxw9TGwCg0VGi3Tm7KSEzyN9ivtI+S1RIRuaxXZJaQ5uLFBLsGCyLXoJR08dJ99pKUiIpMU/dT/XBwxoMSPgNF4TXEzLZSR7k
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7c5cab-45b5-453e-c721-08dd0dc0c96d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 02:19:42.0202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EexXNtXLOth+QevGjsvVsFyzq1bAvy/l9OmV8jhvNLPzeOLqhtN6ryNvrATfs7Iwa9koFlRCDFKMlh4VzlnEHTqXUsygfBrSLkyOkD9+/y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6715

Hi all,

I ran the latest blktests (git hash: 83781f257857) with the v6.12 kernel. A=
lso,
I checked CKI project runs for the kernel. I observed five failures below.

Comparing with the previous report using the v6.12-rc1 kernel [1], two fail=
ures
were resolved: nvme/014 and srp group. On the other hand, four new failures=
 were
observed.

[1] https://lore.kernel.org/linux-block/xpe6bea7rakpyoyfvspvin2dsozjmjtjktp=
ph7rep3h25tv7fb@ooz4cu5z6bq6/


List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: nvme/031 (fc transport)
#2: nvme/037 (fc transport)
#3: nvme/041 (fc transport)
#4: nvme/052 (loop transport)
#5: throtl/001 (CKI project, s390 arch)

Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: nvme/031 (fc transport)

   With the trtype=3Dfc configuration, nvme/031 fails due to KASAN
   slab-use-after-free [2]. An INFO message about lock confusion is sometim=
es
   printed before the KASAN message. This failure was not observed before.
   The trigger change is not yet identified. Further debug is needed.

#2: nvme/037 (fc transport)

   With the trtype=3Dfc configuration, nvme/037 fails:

  nvme/037 =3D> nvme0n1 (tr=3Dfc) (test deletion of NVMeOF passthru control=
lers immediately after setup) [failed]  runtime  5.569s  ...
    runtime  5.569s  ...  5.543s
    --- tests/nvme/037.out      2024-11-05 17:04:40.576903661 +0900
    +++ /home/shin/Blktests/blktests/results/nvme0n1_tr_fc/nvme/037.out.bad=
     2024-11-23 16:31:13.580069487 +0900
    @@ -1,2 +1,3 @@
     Running nvme/037
    +FAIL: Failed to find passthru target namespace
     Test complete

   This failure was found during the preparation for ANA test cases [3].
   The failure disappears when the test case is modified to add short waits
   after nvme disconnect and target cleanup. Further debug is needed.

  [3] https://lore.kernel.org/linux-nvme/2e4efaf9-d6cc-46b2-8783-d400f6e498=
29@flourine.local/

#3: nvme/041 (fc transport)

   With the trtype=3Dfc configuration, nvme/041 fails.

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

  [4] https://lore.kernel.org/linux-nvme/20240221132404.6311-1-dwagner@suse=
.de/

#4: nvme/052 (loop transport)

  The test case fails due to the "BUG: sleeping function called from invali=
d
  context" [5]. A fix candidate was posted which sets NVME_F_BLOCKING to lo=
op
  transport, but it is not the best solution [6]. It is desired to have a b=
etter
  fix and the test case to confirm it.

  [5] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w462=
3cnxj3knoobfcanq@yxgt2mjkbkam/
  [6] https://lore.kernel.org/linux-nvme/20241017172052.2603389-1-kbusch@me=
ta.com/

#5: throtl/001 (CKI project, s390 arch)

  Recently, CKI project added a configuration to run the blktests thortl gr=
oup,
  and failures have been repeatedly observed for s390 architecture [7]. I
  suspect the failure message below implies that system performance may aff=
ect
  the test result. Further debug is needed.

  throtl/001 (basic functionality)                             [failed]
      runtime    ...  6.309s
      --- tests/throtl/001.out	2024-11-23 20:53:13.446546653 +0000
      +++ /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kern=
el-tests-public/kernel-tests-production.zip/storage/blktests/throtl/blktest=
s/results/nodev/throtl/001.out.bad	2024-11-23 20:53:21.332699696 +0000
      @@ -1,6 +1,6 @@
       Running throtl/001
      +2
       1
      -1
      -1
      +2
       1
      ...
      (Run 'diff -u tests/throtl/001.out /mnt/tests/s3.amazonaws.com/arr-ck=
i-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-production.zip/=
storage/blktests/throtl/blktests/results/nodev/throtl/001.out.bad' to see t=
he entire diff)

  [7] https://datawarehouse.cki-project.org/kcidb/tests?tree_filter=3Dmainl=
ine&kernel_version_filter=3D6.12.0&test_filter=3Dblktests&page=3D1


[2] kernel message during nvme/031 run with fc transport

[   41.909054] [    T996] run blktests nvme/031 at 2024-11-26 09:19:23
[   41.989534] [   T1044] loop0: detected capacity change from 0 to 2097152
[   42.057779] [   T1061] nvmet: adding nsid 1 to subsystem blktests-subsys=
tem-0
[   42.185556] [     T70] nvme nvme1: NVME-FC{0}: create association : host=
 wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2014-08.o=
rg.nvmexpress.discovery"
[   42.189922] [     T12] (NULL device *): Create Association LS failed: As=
sociation Allocation Failed
[   42.191731] [     T70] (NULL device *): queue 0 connect admin queue fail=
ed (-6).
[   42.192357] [     T70] nvme nvme1: NVME-FC{0}: reset: Reconnect attempt =
failed (-6)
[   42.193111] [     T70] nvme nvme1: NVME-FC{0}: Reconnect attempt in 2 se=
conds
[   42.194243] [   T1062] nvme nvme1: NVME-FC{0}: new ctrl: NQN "nqn.2014-0=
8.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:86979=
8ae-feb0-47d7-b9be-0445cc28afbc
[   42.206255] [     T12] nvme nvme2: NVME-FC{1}: create association : host=
 wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000002: NQN "blktests-subs=
ystem-0"
[   42.208544] [     T11] (NULL device *): {1:0} Association created
[   42.210139] [     T11] nvmet: creating nvm controller 1 for subsystem bl=
ktests-subsystem-0 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-48=
56-b0b3-51e60b8de349.
[   42.214131] [     T12] nvme nvme2: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[   42.218801] [     T12] nvme nvme2: NVME-FC{1}: controller connect comple=
te
[   42.220739] [   T1085] nvme nvme2: NVME-FC{1}: new ctrl: NQN "blktests-s=
ubsystem-0", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0=
b3-51e60b8de349
[   42.325043] [   T1101] nvme nvme2: Removing ctrl: NQN "blktests-subsyste=
m-0"
[   42.333646] [     T12] nvme nvme3: NVME-FC{2}: create association : host=
 wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000002: NQN "nqn.2014-08.o=
rg.nvmexpress.discovery"
[   42.335156] [     T47] (NULL device *): {1:1} Association created
[   42.336156] [     T47] nvmet: creating discovery controller 2 for subsys=
tem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress=
:uuid:1ed3f3e5-20f1-4bb9-905f-a528d31f4b7c.
[   42.342550] [     T12] nvme nvme3: NVME-FC{2}: controller connect comple=
te
[   42.343199] [   T1091] nvme nvme3: NVME-FC{2}: new ctrl: NQN "nqn.2014-0=
8.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uuid:1ed3f=
3e5-20f1-4bb9-905f-a528d31f4b7c
[   42.350091] [   T1091] nvme nvme3: Removing ctrl: NQN "nqn.2014-08.org.n=
vmexpress.discovery"
[   42.365624] [     T70] (NULL device *): {1:1} Association deleted
[   42.374017] [     T47] (NULL device *): {1:0} Association deleted
[   42.374600] [     T70] (NULL device *): {1:1} Association freed
[   42.376457] [     T65] (NULL device *): Disconnect LS failed: No Associa=
tion
[   42.430613] [     T47] INFO: trying to register non-static key.
[   42.431210] [     T47] The code is fine but needs lockdep annotation, or=
 maybe
[   42.431914] [     T47] you didn't initialize this object before use?
[   42.432559] [     T47] turning off the locking correctness validator.
[   42.433168] [     T47] CPU: 1 UID: 0 PID: 47 Comm: kworker/u16:2 Not tai=
nted 6.12.0+ #363
[   42.434053] [     T47] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[   42.434999] [     T47] Workqueue: nvmet-wq nvmet_fc_delete_assoc_work [n=
vmet_fc]
[   42.435758] [     T47] Call Trace:
[   42.436082] [     T47]  <TASK>
[   42.437591] [     T47]  dump_stack_lvl+0x6a/0x90
[   42.439258] [     T47]  register_lock_class+0xe2a/0x10a0
[   42.441000] [     T47]  ? __lock_acquire+0xd1b/0x5f20
[   42.442696] [     T47]  ? __pfx_register_lock_class+0x10/0x10
[   42.444449] [     T47]  __lock_acquire+0x81e/0x5f20
[   42.446132] [     T47]  ? lock_is_held_type+0xd5/0x130
[   42.447812] [     T47]  ? find_held_lock+0x2d/0x110
[   42.449416] [     T47]  ? __pfx___lock_acquire+0x10/0x10
[   42.451073] [     T47]  ? lock_release+0x460/0x7a0
[   42.452673] [     T47]  ? __pfx_lock_release+0x10/0x10
[   42.454386] [     T47]  lock_acquire.part.0+0x12d/0x360
[   42.455991] [     T47]  ? xa_erase+0xd/0x30
[   42.457444] [     T47]  ? __pfx_lock_acquire.part.0+0x10/0x10
[   42.459054] [     T47]  ? rcu_is_watching+0x11/0xb0
[   42.460571] [     T47]  ? trace_lock_acquire+0x12f/0x1a0
[   42.462099] [     T47]  ? __pfx___flush_work+0x10/0x10
[   42.463630] [     T47]  ? xa_erase+0xd/0x30
[   42.465026] [     T47]  ? lock_acquire+0x2d/0xc0
[   42.466425] [     T47]  ? xa_erase+0xd/0x30
[   42.467778] [     T47]  _raw_spin_lock+0x2f/0x40
[   42.469125] [     T47]  ? xa_erase+0xd/0x30
[   42.470419] [     T47]  xa_erase+0xd/0x30
[   42.471663] [     T47]  nvmet_ctrl_destroy_pr+0x10e/0x1c0 [nvmet]
[   42.473087] [     T47]  ? __pfx_nvmet_ctrl_destroy_pr+0x10/0x10 [nvmet]
[   42.474572] [     T47]  ? __pfx___might_resched+0x10/0x10
[   42.475891] [     T47]  nvmet_ctrl_free+0x2f0/0x830 [nvmet]
[   42.477200] [     T47]  ? lockdep_hardirqs_on+0x78/0x100
[   42.478482] [     T47]  ? __cancel_work+0x166/0x230
[   42.479678] [     T47]  ? __pfx_nvmet_ctrl_free+0x10/0x10 [nvmet]
[   42.480970] [     T47]  ? rcu_is_watching+0x11/0xb0
[   42.482131] [     T47]  ? kfree+0x13e/0x4a0
[   42.483221] [     T47]  ? lockdep_hardirqs_on+0x78/0x100
[   42.484389] [     T47]  nvmet_sq_destroy+0x1f2/0x3a0 [nvmet]
[   42.485595] [     T47]  nvmet_fc_target_assoc_free+0x3a5/0x1fd0 [nvmet_f=
c]
[   42.486863] [     T47]  ? __pfx_nvmet_fc_target_assoc_free+0x10/0x10 [nv=
met_fc]
[   42.488169] [     T47]  ? lock_is_held_type+0xd5/0x130
[   42.489258] [     T47]  nvmet_fc_delete_assoc_work+0xcc/0x2d0 [nvmet_fc]
[   42.490486] [     T47]  process_one_work+0x85a/0x1460
[   42.491550] [     T47]  ? __pfx_lock_acquire.part.0+0x10/0x10
[   42.492678] [     T47]  ? __pfx_process_one_work+0x10/0x10
[   42.493786] [     T47]  ? assign_work+0x16c/0x240
[   42.494966] [     T47]  ? lock_is_held_type+0xd5/0x130
[   42.496025] [     T47]  worker_thread+0x5e2/0xfc0
[   42.497041] [     T47]  ? __pfx_worker_thread+0x10/0x10
[   42.498118] [     T47]  kthread+0x2d1/0x3a0
[   42.499088] [     T47]  ? _raw_spin_unlock_irq+0x24/0x50
[   42.500149] [     T47]  ? __pfx_kthread+0x10/0x10
[   42.501148] [     T47]  ret_from_fork+0x30/0x70
[   42.502124] [     T47]  ? __pfx_kthread+0x10/0x10
[   42.503115] [     T47]  ret_from_fork_asm+0x1a/0x30
[   42.504127] [     T47]  </TASK>
[   42.505071] [     T47] (NULL device *): {1:0} Association freed
[   42.506183] [    T234] (NULL device *): Disconnect LS failed: No Associa=
tion
[   42.548620] [   T1110] nvme_fc: nvme_fc_create_ctrl: nn-0x10001100ab0000=
02:pn-0x20001100ab000002 - nn-0x10001100aa000001:pn-0x20001100aa000001 comb=
ination not found
[   42.555441] [   T1124] nvmet: adding nsid 1 to subsystem blktests-subsys=
tem-1
[   42.584147] [     T47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   42.585392] [     T47] BUG: KASAN: slab-use-after-free in nvme_fc_rescan=
_remoteport+0x3c/0x50 [nvme_fc]
[   42.586789] [     T47] Read of size 8 at addr ffff88812229e890 by task k=
worker/u16:2/47

[   42.588794] [     T47] CPU: 2 UID: 0 PID: 47 Comm: kworker/u16:2 Not tai=
nted 6.12.0+ #363
[   42.590019] [     T47] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[   42.591405] [     T47] Workqueue: nvmet-wq fcloop_tgt_rscn_work [nvme_fc=
loop]
[   42.592607] [     T47] Call Trace:
[   42.593522] [     T47]  <TASK>
[   42.594405] [     T47]  dump_stack_lvl+0x6a/0x90
[   42.595452] [     T47]  ? nvme_fc_rescan_remoteport+0x3c/0x50 [nvme_fc]
[   42.596611] [     T47]  print_report+0x174/0x505
[   42.597720] [     T47]  ? nvme_fc_rescan_remoteport+0x3c/0x50 [nvme_fc]
[   42.598895] [     T47]  ? __virt_addr_valid+0x208/0x410
[   42.599962] [     T47]  ? nvme_fc_rescan_remoteport+0x3c/0x50 [nvme_fc]
[   42.601133] [     T47]  kasan_report+0xa7/0x180
[   42.601139] [     T47]  ? nvme_fc_rescan_remoteport+0x3c/0x50 [nvme_fc]
[   42.601145] [     T47]  nvme_fc_rescan_remoteport+0x3c/0x50 [nvme_fc]
[   42.601150] [     T47]  fcloop_tgt_rscn_work+0x52/0x70 [nvme_fcloop]
[   42.601154] [     T47]  process_one_work+0x85a/0x1460
[   42.601160] [     T47]  ? __pfx_process_one_work+0x10/0x10
[   42.601165] [     T47]  ? assign_work+0x16c/0x240
[   42.601169] [     T47]  worker_thread+0x5e2/0xfc0
[   42.601174] [     T47]  ? __pfx_worker_thread+0x10/0x10
[   42.601176] [     T47]  kthread+0x2d1/0x3a0
[   42.601178] [     T47]  ? _raw_spin_unlock_irq+0x24/0x50
[   42.613300] [     T47]  ? __pfx_kthread+0x10/0x10
[   42.614351] [     T47]  ret_from_fork+0x30/0x70
[   42.615397] [     T47]  ? __pfx_kthread+0x10/0x10
[   42.616438] [     T47]  ret_from_fork_asm+0x1a/0x30
[   42.617521] [     T47]  </TASK>

[   42.619281] [     T47] Allocated by task 1063:
[   42.620296] [     T47]  kasan_save_stack+0x2c/0x50
[   42.621322] [     T47]  kasan_save_track+0x10/0x30
[   42.622337] [     T47]  __kasan_kmalloc+0xa6/0xb0
[   42.623360] [     T47]  __kmalloc_noprof+0x1c5/0x480
[   42.624384] [     T47]  nvme_fc_register_remoteport+0x27c/0x1330 [nvme_f=
c]
[   42.625559] [     T47]  fcloop_create_remote_port+0x1c3/0x660 [nvme_fclo=
op]
[   42.626726] [     T47]  kernfs_fop_write_iter+0x39e/0x5a0
[   42.627787] [     T47]  vfs_write+0x5f9/0xe90
[   42.628764] [     T47]  ksys_write+0xf7/0x1d0
[   42.629735] [     T47]  do_syscall_64+0x93/0x180
[   42.630428] [     T12] nvme nvme2: NVME-FC{1}: create association : host=
 wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000002: NQN "blktests-subs=
ystem-1"
[   42.630738] [     T47]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[   42.630743] [     T47] Freed by task 996:
[   42.630745] [     T47]  kasan_save_stack+0x2c/0x50
[   42.630747] [     T47]  kasan_save_track+0x10/0x30
[   42.631946] [     T70] (NULL device *): Create Association LS failed: As=
sociation Allocation Failed
[   42.632275] [     T47]  kasan_save_free_info+0x37/0x70
[   42.632496] [     T12] (NULL device *): queue 0 connect admin queue fail=
ed (-6).
[   42.632733] [     T47]  __kasan_slab_free+0x4b/0x70
[   42.633113] [     T12] nvme nvme2: NVME-FC{1}: reset: Reconnect attempt =
failed (-6)
[   42.633428] [     T47]  kfree+0x13e/0x4a0
[   42.634178] [     T12] nvme nvme2: NVME-FC{1}: Reconnect attempt in 2 se=
conds
[   42.634527] [     T47]  nvme_fc_free_rport+0x238/0x370 [nvme_fc]
[   42.634533] [     T47]  nvme_fc_unregister_remoteport+0x365/0x470 [nvme_=
fc]
[   42.635137] [   T1147] nvme nvme2: NVME-FC{1}: new ctrl: NQN "blktests-s=
ubsystem-1", hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0=
b3-51e60b8de349
[   42.635436] [     T47]  fcloop_delete_remote_port+0x324/0x4c0 [nvme_fclo=
op]
[   42.651451] [     T47]  kernfs_fop_write_iter+0x39e/0x5a0
[   42.652539] [     T47]  vfs_write+0x5f9/0xe90
[   42.653528] [     T47]  ksys_write+0xf7/0x1d0
[   42.654509] [     T47]  do_syscall_64+0x93/0x180
[   42.655529] [     T47]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[   42.657461] [     T47] Last potentially related work creation:
[   42.658555] [     T47]  kasan_save_stack+0x2c/0x50
[   42.659652] [     T47]  __kasan_record_aux_stack+0xad/0xc0
[   42.660704] [     T47]  insert_work+0x2d/0x2d0
[   42.661681] [     T47]  __queue_work+0x6b4/0xc90
[   42.662674] [     T47]  queue_work_on+0x73/0xa0
[   42.663684] [     T47]  fcloop_h2t_xmt_ls_rsp+0x295/0x390 [nvme_fcloop]
[   42.664823] [     T47]  nvmet_fc_xmt_ls_rsp+0xe1/0x1a0 [nvmet_fc]
[   42.665929] [     T47]  nvmet_fc_target_assoc_free+0x57c/0x1fd0 [nvmet_f=
c]
[   42.667110] [     T47]  nvmet_fc_delete_assoc_work+0xcc/0x2d0 [nvmet_fc]
[   42.668288] [     T47]  process_one_work+0x85a/0x1460
[   42.669356] [     T47]  worker_thread+0x5e2/0xfc0
[   42.670398] [     T47]  kthread+0x2d1/0x3a0
[   42.671419] [     T47]  ret_from_fork+0x30/0x70
[   42.672452] [     T47]  ret_from_fork_asm+0x1a/0x30

[   42.674366] [     T47] Second to last potentially related work creation:
[   42.675576] [     T47]  kasan_save_stack+0x2c/0x50
[   42.676620] [     T47]  __kasan_record_aux_stack+0xad/0xc0
[   42.677706] [     T47]  insert_work+0x2d/0x2d0
[   42.678727] [     T47]  __queue_work+0x6b4/0xc90
[   42.679759] [     T47]  queue_work_on+0x73/0xa0
[   42.680764] [     T47]  nvme_fc_rcv_ls_req+0x729/0xb20 [nvme_fc]
[   42.681877] [     T47]  nvmet_fc_target_assoc_free+0x13c8/0x1fd0 [nvmet_=
fc]
[   42.683080] [     T47]  nvmet_fc_delete_assoc_work+0xcc/0x2d0 [nvmet_fc]
[   42.684276] [     T47]  process_one_work+0x85a/0x1460
[   42.685330] [     T47]  worker_thread+0x5e2/0xfc0
[   42.686336] [     T47]  kthread+0x2d1/0x3a0
[   42.687314] [     T47]  ret_from_fork+0x30/0x70
[   42.688307] [     T47]  ret_from_fork_asm+0x1a/0x30

[   42.690162] [     T47] The buggy address belongs to the object at ffff88=
812229e800
                           which belongs to the cache kmalloc-512 of size 5=
12
[   42.692494] [     T47] The buggy address is located 144 bytes inside of
                           freed 512-byte region [ffff88812229e800, ffff888=
12229ea00)

[   42.695571] [     T47] The buggy address belongs to the physical page:
[   42.696659] [     T47] page: refcount:1 mapcount:0 mapping:0000000000000=
000 index:0x0 pfn:0x12229c
[   42.697938] [     T47] head: order:2 mapcount:0 entire_mapcount:0 nr_pag=
es_mapped:0 pincount:0
[   42.699223] [     T47] anon flags: 0x17ffffc0000040(head|node=3D0|zone=
=3D2|lastcpupid=3D0x1fffff)
[   42.700522] [     T47] page_type: f5(slab)
[   42.701441] [     T47] raw: 0017ffffc0000040 ffff888100042c80 0000000000=
000000 dead000000000001
[   42.702733] [     T47] raw: 0000000000000000 0000000000100010 00000001f5=
000000 0000000000000000
[   42.703966] [     T47] head: 0017ffffc0000040 ffff888100042c80 000000000=
0000000 dead000000000001
[   42.705208] [     T47] head: 0000000000000000 0000000000100010 00000001f=
5000000 0000000000000000
[   42.706450] [     T47] head: 0017ffffc0000002 ffffea000488a701 fffffffff=
fffffff 0000000000000000
[   42.707727] [     T47] head: 0000000000000004 0000000000000000 00000000f=
fffffff 0000000000000000
[   42.708960] [     T47] page dumped because: kasan: bad access detected

[   42.710842] [     T47] Memory state around the buggy address:
[   42.711870] [     T47]  ffff88812229e780: fc fc fc fc fc fc fc fc fc fc =
fc fc fc fc fc fc
[   42.713076] [     T47]  ffff88812229e800: fa fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[   42.714298] [     T47] >ffff88812229e880: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[   42.715540] [     T47]                          ^
[   42.716501] [     T47]  ffff88812229e900: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[   42.717713] [     T47]  ffff88812229e980: fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb fb
[   42.718939] [     T47] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   42.779285] [     T12] nvme nvme3: NVME-FC{2}: create association : host=
 wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000002: NQN "nqn.2014-08.o=
rg.nvmexpress.discovery"
[   42.782208] [     T47] (NULL device *): Create Association LS failed: As=
sociation Allocation Failed
[   42.784050] [     T12] (NULL device *): queue 0 connect admin queue fail=
ed (-6).
...=

