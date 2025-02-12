Return-Path: <linux-rdma+bounces-7668-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1400AA32309
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 11:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC8B163842
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881620AF68;
	Wed, 12 Feb 2025 10:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=keysight.com header.i=@keysight.com header.b="VohMoZgn";
	dkim=pass (1024-bit key) header.d=keysight.com header.i=@keysight.com header.b="Vf/ykP/U"
X-Original-To: linux-rdma+owner@vger.kernel.org
Received: from mx0a-003cac01.pphosted.com (mx0a-003cac01.pphosted.com [205.220.161.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB972080CB;
	Wed, 12 Feb 2025 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.161.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354438; cv=fail; b=aiinT45h8grxxP27qVndpvRn0XqcaIhYncJcBqJba25rNM/VEV33yVutmXKfWKaiMPz0Y6oFxuUbauAu/VCvQT+ADtyL4kN6IpD45+wuM0ALxEixjmeBlibjaiI8LjBveVgXiVpB6WbvYrtyvdY5D7n3gQ7FpnRnVdG5bhq5dOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354438; c=relaxed/simple;
	bh=hPlkGltt7+g9Kif32M/k6widfQ/0g2/qlywuCQo0y9k=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vd+zjOtxzAumhoEAS5n3RKJHcbIJ4Z5DJ81e8rYAxEYtAmVzF2LYD9avzPCJj8Xba4Rf8+9/jp6U/NsoptMFOIUca7ZfcCYVpHaV10mB3SyFPxX2pIcM6I9V14So3/9QxtCBZmdqI4Pu5Uz82AW6Rk5qXI1BWEp2KimNFaIDN2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=keysight.com; spf=pass smtp.mailfrom=keysight.com; dkim=pass (2048-bit key) header.d=keysight.com header.i=@keysight.com header.b=VohMoZgn; dkim=pass (1024-bit key) header.d=keysight.com header.i=@keysight.com header.b=Vf/ykP/U; arc=fail smtp.client-ip=205.220.161.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=keysight.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=keysight.com
Received: from pps.filterd (m0187214.ppops.net [127.0.0.1])
	by mx0b-003cac01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BKct47008723;
	Wed, 12 Feb 2025 02:00:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=ppfeb2020; bh=hPlkGltt7+g9Kif32M/k6w
	idfQ/0g2/qlywuCQo0y9k=; b=VohMoZgngUaWtHKnmf4jtQkyO/LeLjO8Sef3uB
	hP2muyR69nS8oKtm6xim5K08GwAU12R4RHXnXbVWF5Kd/SDu+J2ozBk9RqByuz7V
	2FaWlnoRrBElJHaluiuaTYIWx22uuEPA0F3rID2Wgk/H5KH5TGs5iagRNEeCWjpZ
	EXYB0Y2HhZK6B692MsyFLVbewxBKDvM5mRaDJ20qcp+eosm6Lzuv5D8T7L0X93WM
	u1ET7E3ZeO3GlXFITb+KEmKy96ZvCrxERf0g4vvY1BorqcXWp20xccrj68gCbWHZ
	t9OszfoKH0dSXZs+4UjDJEdFYgT+Ckl5nS7UNaQd3FuM3e+w==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by mx0b-003cac01.pphosted.com (PPS) with ESMTPS id 44p5exrafs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 02:00:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9+3/DnhHFHc64eEEFu/YbmdW/lKadDzqfccp/ttBloeV0NRCqUvXLlWCscH2tW7C2ic8q5mFB+ZSxWmNmMaBate0ny7UP8grh4uMDATIJCkxCyYFm2bzvYsStO9zJ5ZGnRFaesO3XS4LQoTViEW1JSSgv2W4Kwcg0w7H83Y+qruZ3bgE5NANEClmCFQUoP9LQbvR/pW8uIb12gQtKtvIQfJxva63PfZ01lAI3Pxp884EaJiCT8iQVIYHFHOZrjgf0DJbfMqPQMOav3cDmptjwkaPYJ4nW8gYCg1ae28Hsh2RgE6fH8IBmWXcaCD3Bikb3S9psiMYsBfZp9kzlk4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPlkGltt7+g9Kif32M/k6widfQ/0g2/qlywuCQo0y9k=;
 b=eW+dwaTUp1XS3JlcM2bUPq81nTUxfmeVfojd9zzKmm/FBRr1FfxXPK0RbCyY9t+xcYcc8G1sKm7BTAYgzuK4WUkQNwAg2fqcdhWN0mesx2tLh0OgfaOeZSynXdfziUb/aAyT2Pk5p+DlqyAxrarLDIah/uNIDtIHUm/9eYVhtI6K+efY7m8tK/OMf/RMMjabUYNxosXLNnlpZ9NlVHlzhl7Jg7l9SqF0+HGuNIMwIGPqqyMNWp9csq/ueRoR+3vbsusxuEXghMsedQw/8wxUO4c7u/yMJRxWwaQQ/MvktvbH1y0ZJYRSQxVvELP6gkZbDXgQVvCKtazPxpE7Wp6bqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=keysight.com; dmarc=pass action=none header.from=keysight.com;
 dkim=pass header.d=keysight.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPlkGltt7+g9Kif32M/k6widfQ/0g2/qlywuCQo0y9k=;
 b=Vf/ykP/UT3jh/urbMxUq9fx5NelSn6umnrWHVbKZBNEiqGakWF+lGX0bPPPxv9pnmwQ2RYyYaXHy6XYplye4zEecXPmjoXeVx/JqeA/hS8Nazak9V/gzwxfW60YbUScf56yMD/UgugeVUqD0QhVWk8t6OC8FgZUFx4s/fEzlmCU=
Received: from SJ0PR17MB4581.namprd17.prod.outlook.com (2603:10b6:a03:35a::21)
 by DM4PR17MB6245.namprd17.prod.outlook.com (2603:10b6:8:112::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 10:00:33 +0000
Received: from SJ0PR17MB4581.namprd17.prod.outlook.com
 ([fe80::7f8e:cef4:46d:b3d7]) by SJ0PR17MB4581.namprd17.prod.outlook.com
 ([fe80::7f8e:cef4:46d:b3d7%6]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 10:00:33 +0000
From: Andrei Sin <andrei.sin@keysight.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "linux-rdma+owner@vger.kernel.org" <linux-rdma+owner@vger.kernel.org>
Subject: BUG: RDMA IPv6 loopback uses MAC source address for destination MAC
Thread-Topic: BUG: RDMA IPv6 loopback uses MAC source address for destination
 MAC
Thread-Index: AQHbfTOKnshNc7YQvEGsvJTT7sF1cQ==
Date: Wed, 12 Feb 2025 10:00:33 +0000
Message-ID:
 <SJ0PR17MB45817B76451A84002F01E681ECFC2@SJ0PR17MB4581.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR17MB4581:EE_|DM4PR17MB6245:EE_
x-ms-office365-filtering-correlation-id: fb68d0af-94ee-4fb9-f6a2-08dd4b4c16fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?hVfYx2aFVH52b3W9CrFmRXk/7GMgMatSLhL99nHl5LGQJxxQ6Z5mA0jTcY?=
 =?iso-8859-1?Q?4VuVtAEH5vSuzZ+VjU05uhihgWlrrSTn5lxYAObFcoGUQQbe0zyfUGbr78?=
 =?iso-8859-1?Q?aVraisu6JVB+jmpG0SOPk+9tWnsggDfU0F8qW6jhnMkJpFAmE7iy1wF1he?=
 =?iso-8859-1?Q?0GPptWJzHdXGv8LO/xChljYG8pShUeieiiVzNIyjbnEH2wpC0FSHkVQuZ5?=
 =?iso-8859-1?Q?jZ4faBZFlw9Po0fM++vrpGtrUhADFF3aRTWIfwJ8hN8PchPa1zzQcfVMyF?=
 =?iso-8859-1?Q?mCMR2GxMWX7LIxGnOuOFnXioRtCvzdECYdt2vEMpZD7lvGWrvhj7RC6TFV?=
 =?iso-8859-1?Q?OBEhaW/eeDuMwoQrVv9rCW+iI9aYiYbQLbnMjaxMIlBUmgsAHBmmCqPHgA?=
 =?iso-8859-1?Q?WfEhFdCJV1zvkvG0Y1yGks3ZDcD5nRalPWimsL3TvyPBQI7DbGJbztRq1a?=
 =?iso-8859-1?Q?i/BqL/wLr3g0eWmgXoPB/+zuc1Sryrn6F+K5kez/NINrkTKrq4+V4yEzAA?=
 =?iso-8859-1?Q?v5O0m6mHYaXeQJSqDxBMKY28EvAM0kTMD9/FDny9MCc8qV/YXhXKboWoRU?=
 =?iso-8859-1?Q?l9kobp2MnUjxI7G5uerDi3S9IYqJKKZKWNuGfBGbHOUYoMhPidAE1RkfV+?=
 =?iso-8859-1?Q?X+vpmrtsS+enNZIhTSexRVrXA41PHGyMokTS3ckpfeSgsQaNU1hYemKbg/?=
 =?iso-8859-1?Q?g+Q8jPuosGip8iSm1J9EYOnNSG+NIFpLYvY8tzEhSDhAvsguqib7rcDIUC?=
 =?iso-8859-1?Q?a85dGDxDf1KmZAkwmg/g8isduoMYoh9S2BMXljAkcSUxUJ2ERS48GokQf0?=
 =?iso-8859-1?Q?T0azMBBLGC/QMCE50G4vl2U2/aF16GuHSDjcsUK5r9ZKwvcWkQWgyIcodP?=
 =?iso-8859-1?Q?TaOw+UwZE/RLnS3LpIs5uMSu4ExMzinuYqotJUWpqPklWFwSZ5dh0rTKrO?=
 =?iso-8859-1?Q?LBUst9w8FtXpEklL7lJiipFL0ANXBDEnb0Tpx7pn/zCMAuWGLCPpUWmDio?=
 =?iso-8859-1?Q?uWLxaFVH4Jkm7z+I88teVztodkGVk3FSKHf+x5nzwllUiMNaDIO5ToG4XU?=
 =?iso-8859-1?Q?QPxPqT3cfZvbpLLBH0WwVi8lVUj1zBnaZwNZtk91JqNXvnCDx1InNkPFKH?=
 =?iso-8859-1?Q?btGwimA5oOV9Z8lVlrhV9wkkJjNisl8SnZlDou4ukt1BXTbMBiH3ZRxaO7?=
 =?iso-8859-1?Q?JdojDiSFYPXlf6MxqPUZzAzVuJJIbu4h4lJVlGy+KSWERHv1BuH9gBJjJI?=
 =?iso-8859-1?Q?0ZtpNIjZbBeBUiAVO+5qpYZWZP/HCgoPBJYFEXA8xI+rI/yfpRGWYtxK6l?=
 =?iso-8859-1?Q?a1G2xDirk5StFrKqXKm7tzK2OXdHvtbMjUVegoz/HCU7v5f57eVW6xDaek?=
 =?iso-8859-1?Q?j6ntdACoyxbnPuVfmaitaHLzONvShNQ8mAqc7/pDrrRTmX4Cjhs7ZdhnX7?=
 =?iso-8859-1?Q?VJREYcfve+t202RN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB4581.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?PSXhd8bW+dPxMx5cuG3S2iTrkgOB9hKzIFkXnt63auh+RvHXY0/tUpq6sh?=
 =?iso-8859-1?Q?V4qGnG9WPdsm+YBp00w+CiHQHmHUp+kqOi+x4lYeWJBKlI6dYcG4+NFKRX?=
 =?iso-8859-1?Q?EkPtiW2cAN/2OXrQkqlgRADSc2ziTbdq/MuXxAW/hH34ONjd8qJW3gVzyy?=
 =?iso-8859-1?Q?qJGaDCWaLkRqy5hY331gNzFbji3p+G2/XIJijlyJBP/kX411uqtAvDbeCa?=
 =?iso-8859-1?Q?kGcyRjUKOVGPJeb7A9hAZzF0OdIsV5hly6sB6I9ucZuYdNX/0Y8+a0tKv2?=
 =?iso-8859-1?Q?IP3jIxee8Y0Pj805iwONK3TK+wE/z1EhZEkKhqO9PaWL6WPJgbmzNbzTWi?=
 =?iso-8859-1?Q?Niv0xmlKpb6kp+hdAyZUb6sx67tDb9dK68esAluHUZonKoWFE3ZdxNb3Ya?=
 =?iso-8859-1?Q?2x9J2/oxu/aMoBRjwnH1Xi0RnU/FS3XUTcuGEpLGR5I78TT6HQKXpHXAot?=
 =?iso-8859-1?Q?50yamjSwlvWYvyB/zfDTVXr1pa1i4Fw0dVIX7RUloJ+3FSfxnWIsrMEcpt?=
 =?iso-8859-1?Q?Dbs/ri+01vAIOG6uy39KHoMmWmjLFzryUClKOSSbBQ+c2zYPEXXArZPw70?=
 =?iso-8859-1?Q?O0NWIdTzFB03iLQ33hEaKAuyEQnFNxeCEW6HrXspymzVmDR+ng1/9WCS3j?=
 =?iso-8859-1?Q?yp6tTRKAdulzzmWDB7iQtTJK8Z8SyfFpjlBhkdyJAib1QGvH5ja7PXZZ38?=
 =?iso-8859-1?Q?/zPUf84ZyamMjGkXideLZZmOBwixsxSbD3ihAAh2vjcErxY05gpSosBRec?=
 =?iso-8859-1?Q?mcU0vDKNuj6AKMe7tf+Y03r+P9RdZDi9322Yfg3D1uSuBwRdtcaLhdeUEC?=
 =?iso-8859-1?Q?1GSO23PgbmK2fXngSVjhtZThoxDbZMcFeGV8hVDG0FKbuZW3XVzhaH1TYD?=
 =?iso-8859-1?Q?aynuwlkakhbpkfPf5MHmQEhO1WtbHIra5afJAui7bnfGQ2kL4Inan+U5O0?=
 =?iso-8859-1?Q?o8MtBc+rbB6M4kMKOceKeqshdEt68MN9Tr8afeOGi+zOocFWrxqUTBzzuZ?=
 =?iso-8859-1?Q?THT7lH7PpewG+1wjElBBP228ku73cnc49f+D3UjG72J/xTRJYIZ1LQCtCh?=
 =?iso-8859-1?Q?Irllsj3Z94IZTOqAEO61Kx0pjlgAIhlhZXFVDtbjNUK5TLvh/tFiB3wFzV?=
 =?iso-8859-1?Q?HaAKEYibIHQWb1cy6wy2jkMd7rYp7jnwwWasqWGHC6mrD+XIYZp9BMFQsK?=
 =?iso-8859-1?Q?gCIjjXG1dRiFrbyvBljJc8XZnG1K5TXeAiE97BNQX4hAtuiXUNQLwq6kD5?=
 =?iso-8859-1?Q?SgAGxg6Ny/XDWAMneblEMB2CcsgJKdGvQ+w4r4ptZJApVDUtypRYz6Ngaz?=
 =?iso-8859-1?Q?iYlT3Xfw/deyMI64Wkhw/GrxWT5dC4mfSIhXXOjM1jb5yWQfLrI2aeIXH8?=
 =?iso-8859-1?Q?Ojm36Hy0wVsIOmbSHfumVOphf92mvmh/mCILJlvTBCvNDEl8DvXlMjPiY1?=
 =?iso-8859-1?Q?nQbieuGhPvlnbWMlK41B+V3TiS2u5OVuAm7jAKRo97N6xM1P+YSrvExoS8?=
 =?iso-8859-1?Q?wiqhpe7UWAmCeV81gqC20mepLXagYJsp5dg4AFRBDzoCOXS+0DITHkhcCO?=
 =?iso-8859-1?Q?ADSjnZI12RaZjZRZgNvOpPylETAR5N9d2L+OCNCSM1/H9gM1WiMXjIXlu2?=
 =?iso-8859-1?Q?lHbkH27zDIGyhfC/sXNhFmBQk8PCCo7Uag?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g0h+iSiKgzd0Vh6j6kzD+jf6pveGdJJZbPGUOVBR1j/gmUDxnPNU1SxTAD4p6p+yLA8q0ZE4svB0RKjwIgUmFJ1Hft+BWBApx6vH7BipxcXt1++XOodFiMoKOwmPdQ3rutPw/AnJD/3vAQl76FIpYKY7kNO0BATWnIfm9d96EGDpTrBFpRzzAOPXxM60jBassxCqDLtXUAlYVe7zVVtkVdY2Lkf1Baxf1Oz8zgEazu8b2le4MAES/PbqNRnyWFkccc1q1EdLBZH0+01pQOGhVsNiJyg3wfynCr7wIklqOQDHUu3qvrUOtxg6TJgvOXi46MFOf5156a0Z+ZeMqTy1G1vtPm5uJfrhKacI2AUInk9r9+hQKXuMwNEq5dhm/VCZorBuTV4rm2bJ2oFh4WejmebQVBJK2SZwwcDIvmkxVVHRBWtdJQrKnAeX66dm54VQYKXUJk77ofFDE/DxNabzOvgetXNpFAMPNpgIvYhZKs6kVdcm8ga/pMMeivAQEz6wJ70ZkoMKlmTKYIkh87juOCxMQfepEqorCpDAEfckhGUZVHx8igo+g3GbjKvW3zIERVFidr8a8rA4vverhV+BaD9XnwKyTyr/Q2isSizU/RAontZM/DiTenN7GxmNcZjo
X-OriginatorOrg: keysight.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB4581.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb68d0af-94ee-4fb9-f6a2-08dd4b4c16fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 10:00:33.1456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63545f27-3232-4d74-a44d-cdd457063402
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H5A65MKBAlYmMn0M6hyJy1+GHJzTvTdfeHCtEO5Afag9FexLkWhOyBFZe/KCyS+fopiLeHuC/xGAo6P1TMrsMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6245
X-Proofpoint-ORIG-GUID: M1UNqhaqePsUCIYJQdxOkMsU4JlKxWtr
X-Proofpoint-GUID: M1UNqhaqePsUCIYJQdxOkMsU4JlKxWtr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_03,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxlogscore=838 clxscore=1011 phishscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120076

Hello,=0A=
=0A=
I have a server with 2 NICs RDMA capable with IPv6. I've tried to rping one=
 interface from the other but it does work.=0A=
After some kernel debugging and some TCP dump I've noticed that packets lea=
ve interface with destination MAC equal to source MAC!=0A=
=0A=
This happens here in kernel: https://elixir.bootlin.com/linux/v6.8/source/d=
rivers/infiniband/core/addr.c#L464=0A=
=0A=
Let me know if this is the appropriate mailing list or if you want more det=
ails how to reproduce it.=0A=
=0A=
Thank you,=0A=
Andrei=

