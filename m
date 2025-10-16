Return-Path: <linux-rdma+bounces-13901-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5B4BE434E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 17:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E30D3574C5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 15:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305583469F6;
	Thu, 16 Oct 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QR73vpe8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mhQtGO8g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5332C31A;
	Thu, 16 Oct 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628333; cv=fail; b=a6r/DWTT3GHUa5DUdIeJIpUHVznFXBthCO5XX4g7FlhbiojisXzCSnQh4hNtiwK+L2J8bpqAl/1AOEtWcdh6W5Po6r/ETKA9MYqjpyMjb+n3V0DZ/hB6oTyPPrxrc5591kYSvSQkTablNo1NyH1zsDiq0J6J+ecuzqTkyjcko10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628333; c=relaxed/simple;
	bh=2+z6Y+x37xISPIlHZlUTQh3YsSbFwZVRle1eRwzAxrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rqE/OzapCLK3D2MqoBZhv55XlIIz6MDOBu8pWP/Ahczrza5Uu0eCnFUYGpQ496T4FuLBI03XFVc7Yl+DASxi0uUQRbMis2uGcSbhl/BONqwAs84T7PjozjFxk1mR1nsPF7e+sJlr/qJCYa8Lga2/IpyRt5GfOCmFE8MAsNYWhqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QR73vpe8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mhQtGO8g; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEVNk6000855;
	Thu, 16 Oct 2025 15:25:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2+z6Y+x37xISPIlHZlUTQh3YsSbFwZVRle1eRwzAxrA=; b=
	QR73vpe8KaoBUeKjMlVV1lahn5ttHczq7GzOY2uNWdMEwCaS1l9SKuYpJwSJqzA8
	0J6qjVdxBeGItWeiSZAnUczK61cprUTZKImqELWu8DuzQvXTUxOqyfrXn78QLtHM
	zp3FezMvzLeVgLpILMAvE77GitwlSdTNwd48SD20WXXYDi84csj0orTz4Et3nRjH
	/VE7eHt3vGW4ge7IFLX3fvwMaeKiPKDtyYwrVrj51nLyStiJNPJj0jaeIpYwhZ2y
	dAttl6LiF5jHJ7KCyUutZeVlclyg67uz4qKm916LrGWRye8Rq2bo0xDOUVIUxMWi
	EaDUY0l3e6dG5wWln8Ua3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfss14s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 15:25:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFFLPd013640;
	Thu, 16 Oct 2025 15:25:25 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpbks82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 15:25:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oo1L3fhagjYSrO6sIVns6CDx5H7+AkzPDatObHPi/6bmz60nxXW6bZJPk5iuZDMFKuqYmQU2Q4WisKIHR7EkySm6AuFr43b5WToihkHzkQKvjb2IQMxLRjDEFfs/Kkcdt96GGiceecraXC+MBR4k6nVcZ96EmsG7Vw5xwLaubjpPnvla4QJiOevhpsklzHD5IPTd8LMMNYx/FaIT0bygTHCQ603EkJT0CFBP5wsf+3IYnSlTq9Uyv0g8ZTBu1UzhERBk90mnuLZ5WyWFL0cWIEicUXALcxL0xnU8E6kVC7hiXrYcjFYyvgZ36gCIQrjpeEK3MSAg+l4MfeFADSNMtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+z6Y+x37xISPIlHZlUTQh3YsSbFwZVRle1eRwzAxrA=;
 b=eh4xQGNNUYth9ZWeAI0HsbiNxmJC6hDSGzLAE6VnOHKfvB/jT2Y3p/5CtHyuuvntsFjhj8WZq2v6V+tUpG9H4v7y7iK1UXzYRYc7B3oymRBBLdeme5A2CGzNB85986vNQQiVLy1hesj+Breg7/i1bwwEODV9E8WgFKuExNpjA9uFUBPxqWLBYBneAb6v34Hyzj/Q1Im0MCqG6bemGEkARmi3ZNQxDtQdlUEHQgWErSf0z8tKEqb5vSAn7fpTsyr6u/mDVSTdz6btSDE5T8UGptf4HjnOL/+tRABwSCgvp+N3G/Y50LUY0jxhPsIpkMkofqxfyEQdV0UnWFio0NcQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+z6Y+x37xISPIlHZlUTQh3YsSbFwZVRle1eRwzAxrA=;
 b=mhQtGO8gYyWWDCF3i2OJGW81crmVsBB/0ah2tCBhM1C/MaZ6TmY/DnEK9Jyhohf1vje25RASz9nMdlUF0uAHffqCDQ8227vr64INyLOQ5tOZFPeEumXQ9nYKoT2EIRPtOiCrKaNrh+67SoCM5a+Aren0Jh+aEKSCEaRzekc5jXk=
Received: from DM4PR10MB6839.namprd10.prod.outlook.com (2603:10b6:8:105::10)
 by IA1PR10MB7199.namprd10.prod.outlook.com (2603:10b6:208:3f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 15:25:15 +0000
Received: from DM4PR10MB6839.namprd10.prod.outlook.com
 ([fe80::dc16:2669:e9f9:4c9e]) by DM4PR10MB6839.namprd10.prod.outlook.com
 ([fe80::dc16:2669:e9f9:4c9e%5]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 15:25:15 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Sean Hefty <shefty@nvidia.com>, Jacob Moroni <jmoroni@google.com>,
        Leon
 Romanovsky <leon@kernel.org>,
        Vlad Dumitrescu <vdumitrescu@nvidia.com>,
        Or
 Har-Toov <ohartoov@nvidia.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Topic: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Index:
 AQHcI8zHdy1KL4KXCkyexoudDHS8M7SV4d4AgAAFLICADfC2AIAcdSOAgAL71ACAAFcGAIAAHVyAgAAC/wCAAVplAA==
Date: Thu, 16 Oct 2025 15:25:15 +0000
Message-ID: <49A8CE60-DC8E-43F7-9620-D4D5F8EB2A08@oracle.com>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
 <20250916141812.GP882933@ziepe.ca>
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
 <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
 <20251015164928.GJ3938986@ziepe.ca>
 <CH8PR12MB97419E98111F553FCC117E36BDE8A@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20251015184516.GK3938986@ziepe.ca>
In-Reply-To: <20251015184516.GK3938986@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB6839:EE_|IA1PR10MB7199:EE_
x-ms-office365-filtering-correlation-id: 0658a07f-bf11-47a4-ebba-08de0cc834c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkFmc2Y5MGFkVjRPaHdqUnpXaktNK2pLYnhCZmI4d1BSZ3JtVE1HRnU4L3JT?=
 =?utf-8?B?OUhCOWxUUVozWVVaWDZDeWtNYXBsZ1ZMSjNZQk1ISXNTN2xBUC90U2VqVnk5?=
 =?utf-8?B?T0hZMGJPY0NzZElrc0ZrU3NJZGRVQ2JURHhhU3F3VnBQalQ5a1NPOFBJcDYy?=
 =?utf-8?B?dXV3MEFGUmpwZTVKNmpqSFFSYk43Y2ZYM2lFc21KMGdLZUJuajg1RCt1Nmp0?=
 =?utf-8?B?WXZ0ZnNKcmVLTTk1OWU5QzFxV2VqakZHTVNPaElMVHVVSHNtRVZEckpjQ1Jy?=
 =?utf-8?B?T0dWQ1NJNVk5ZzRxWWFWdU9XZlh0VDRwUFZLWGFPaXdQUVd1NWNhZFNrb1NE?=
 =?utf-8?B?V0dzUnovU1FKeFNZWFJxbk1xVmkxL1h2OG03eXM5UVA3ellZR2w4ckVKTFFE?=
 =?utf-8?B?VGpCSFIxQmYySVYzMkswYjV6cEdkYWxObEh6VnlmbG1ReW0xTG5rbWNXMC9l?=
 =?utf-8?B?cTh5dk1WYWVBVlFreGFXV3RNcDZYYks3Zm93RUZtLzBsMzVRbVNpeHhYak1t?=
 =?utf-8?B?ZFRoVXhGSjhlRThpU1ZxT0FnQTcxd3UzZUNlVjZHYmxPQWUzNE1SdVlaNTVH?=
 =?utf-8?B?YjhkUVN4YjhXRjlpam5Xa2NKb09ib01ZWXZubXZiUDZ3dGl5c0NGeXNkcVBD?=
 =?utf-8?B?VmVBTkRJUkFiVUhUam9lbG1NQWRYbVp4N1M5dkx5eGNKTnR2d2QxeUpmbkVJ?=
 =?utf-8?B?dTNYVkdzU2RRRDJVUlVWVCtxV1JIdmRPWXB0TDdaN053dlBhSkhOZTJQOTZN?=
 =?utf-8?B?UE56Ni9Hek5CbERBYlhjTHloLzdiZ3p2UzZUTzhvUzBNNER4WTBoMTI5ZjFF?=
 =?utf-8?B?YVpVNENOdytmYXJtb2hEYm5lUTdybUFGVU9BbnlLV3E5MUZPazVHSStybzVH?=
 =?utf-8?B?dy9yMU92bkJJUHljQ1RvMzRQdTJtVTRhZTBEYzhBM1FDcVNYcDJUVVBvamN2?=
 =?utf-8?B?TllVVlVWUnBnSVdGcnBQSVN1U0wrc1F6S0RtTEI0bWo4TzNkalVFUW02Z1Nz?=
 =?utf-8?B?bm5rMGN2Mnphd3l1eitRUDRROTFJZHR3NE96K2Z3aGEzTkg0WThkcDZZSmZH?=
 =?utf-8?B?L3c0YS9XTmpRWWhLMWpjM21oby80Z3JmZkdFajczWndUREhaaENmMXdjOXF4?=
 =?utf-8?B?MVp4dVpoR2MvczBTNldMRzFaUW85MExObGwwc3ZlaGJGb2lyaldkbFR0eXlV?=
 =?utf-8?B?KzFVMm5HRVN6bEhJbENiNUpQbS9JSXIybmdPcjEzRTZsa25oaDI2NUpZUGRG?=
 =?utf-8?B?Zk1YRS9pUWYrVmdEU0M0dDlXMnFNU2ZBU3lhbTRiZWF0b0dKTElhK2lEUGRI?=
 =?utf-8?B?UjRwemE4T05xcjdZT1lsdVdicGhIQ0I2aE00SU5PNkk1a3dyK29GTUxEV284?=
 =?utf-8?B?bm42NXV3MVNwUWY2SDY3dFVMRDFKSE5SamRjUEx0V0pxRmV6WTFrc2M4bHhw?=
 =?utf-8?B?SnQ4REh5RTBzMHlYTmNYbmg2THdhVDNPUDBVdC9lY2hEQTE1MGxwYmxYNnhF?=
 =?utf-8?B?blhtNHpQRmpXN3NqeGRMc0p0dW83M0ROTC9FTDZuUzJpRTI3MldXR0ZXTGFF?=
 =?utf-8?B?L2N2UVRHMzVoYlJkMmcwVGE4ekV1RGNiWTNGU1UxVlV2VEpNTjVXOVZxc2dQ?=
 =?utf-8?B?VVNITlBDbnloQk9VSmJGU2xQRWF2ekZIdlkyUTd4WW9hRWNtd0V0VnB0a04y?=
 =?utf-8?B?aitJOXpJeEU0V2ZFVFZEOWVBMmI2VStwOFNlVU02MDE1bEpSYlZHTWJXeGdO?=
 =?utf-8?B?VzZ5dGdXTWtFUmF2WlRnV0JZSW1RYzVhendjc1RpdjFDTWRKSVBERE5ibGVr?=
 =?utf-8?B?VGJ4eDMrOHE2a0lsT1llM2ZnYU1KWEFaNTFlQWpxMXNqZ3Y2eFZuMi9yc3RH?=
 =?utf-8?B?czhiaGc0Ym8zM0tCaWhmekdSUTlsamZxWHhqN1A4K1dhV24yMVIyUmo3SWJV?=
 =?utf-8?B?MnFjbmJ3Q21YbURoYS93dThXWGVCSkI5WW9UbUFGWGZRdWlrb2RDb0Y2cEZq?=
 =?utf-8?B?MWZ1VVNTbkY2bUxDZjI5bmh5ZXozVGtzU0VMM3ZuMXJoWmFCb1RkdmttYS9m?=
 =?utf-8?Q?ly//vP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6839.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2VNamxZV3pMZk5SOU5nQkV4L3lmc3RQOXpHTlE5Unp1VFNCTzhaUW1lYW9j?=
 =?utf-8?B?OFFQRjEzSHE5ZlE5bFhUL2k4Ulh6aGtqUEU0L0FYVXZ3Vk9pZjBaSkFQc1N1?=
 =?utf-8?B?d05DRW9PVFp5QlRrNlhWOWtic21SMGdpejlpTGVwekxHM2ROQm9xeVg5RHFo?=
 =?utf-8?B?VE5Ld2Jhb3hvVnU1QWYwd1BlVkswS1lFUFI5Mm90S3JXOWpTQ21RRmFUa3Jm?=
 =?utf-8?B?MlpqQzZ3dUtxajVUZXpRLytVbGREVFhHRk12L0R3YzY3Y3VpdGFkZkplcUVx?=
 =?utf-8?B?QkNFZ21iODFjWmJmb0QwUmNQdXFxTzdNU05vV016aWxOWCtkNThnazQ3TENW?=
 =?utf-8?B?cG0wK2pvc1A2Y1llNncxUzIwZXowMzAxMjliVUtlbzAwanlIcEIyajZ2cDJs?=
 =?utf-8?B?T05UMXdNRFlIdkQ3amJLS1N4WWVmbzZNNDhyVG5TdGU2TFlMeThoNW1lektS?=
 =?utf-8?B?K1lqMzRVUnByYmgrWjIyaXNDVG80MlEzdEhoZzFNUit3V0RtTlJwUVdUZVY1?=
 =?utf-8?B?bU5GN1B2S2NwclNDMkJFYUVuQ3NKZ0xUMzZmYU41N3ZQM092NTNTZ1VmekZK?=
 =?utf-8?B?N1FTSy9QbGJjUHh3Vm5GbUZOUDZkS082eUEwWTdWOGliYUl4VmlzTFFnajBx?=
 =?utf-8?B?UDFTaDc0V0RoUmtZR2IxVVVtYy92RnFmMFBJU3MvWTRwWTF5YVl5NklFSHJt?=
 =?utf-8?B?NE1uVUNieE5zV3BmSFhXZFpuSCtqUk9uTFdia0NuWjlHYUZTWkY4R3VsOGl0?=
 =?utf-8?B?akRUUklxalRQbSttQ2VyNjk4VTIwbkVCNUtkNzFINWtITGI3N3llWUdKYm5K?=
 =?utf-8?B?NUtlZW9CSktUc0ZZMkZQNTB0MlplYzJPWEJWSUlEWStMT3JtcEVlV2p4a0FX?=
 =?utf-8?B?S1NLcU9GVVcwcXdqZHFSMml1eC9KWEw1WDhyMVRINkl0Ukh2R1c0MmNjSWlk?=
 =?utf-8?B?c3hqTldqZ2t4bnM2djdMdEN1UHRQemF4czBVeXdibUdVRTZnNm9jQ2JnRDNJ?=
 =?utf-8?B?dGplNUFydjJuRlBjeFlMZjFNKzZjM1VEL3h1bDlEV2xFSWtGNXhyVCt1cjYz?=
 =?utf-8?B?c2xpVEZGbGppMHNZcXA4aEpyUkNLcmhteWkzL3FJT2x5ck5NUkFPRWZ1cWRl?=
 =?utf-8?B?RE84N05wOWc2K2gwUmR4MU53aTlwU2tjMEpFZkVJYWVmcThnaTZ5ZXZ3WEl5?=
 =?utf-8?B?eUY2a1IvbkNaYS9OdGk4ejRYQ1lEWXh2RUtBSitpeGdKbjVxODVrbUtrU3N2?=
 =?utf-8?B?TzBsYUVRd1Eyb0hWeGJyVmlKdXlQVmlyQnJsTEwvVFUwMUdlbi85QTBvVmZM?=
 =?utf-8?B?NTlWSUdSNXN1cEplWXF5cUp6emNZNUFndDg0cTNYeEU5VFlteDRQWWhCVXYr?=
 =?utf-8?B?cldWZGZZeHo5QkxoeXFuTEFJWVhZeHVQdDhnR1FVbE5JbTI2R0VZdDdIeVVa?=
 =?utf-8?B?QVN3cUlkNm5YS0o5L3dUUG1hNGNWakxlSTg5SGRhVTVROFhlTUo3N1A1RXBu?=
 =?utf-8?B?bFJrZm5sUFAvWi91UGVZWUl4aTFPY2ljd09mYzgwQWg4NWxlK0lrVFVUQ0ZO?=
 =?utf-8?B?QW9ycDRTTGVubXdLSi9xbTNnU0FKY1BZTzFzOHh2ZTVGdFNXelUzMWhTSUJu?=
 =?utf-8?B?SHVoTG5RQW1xV1FFREc4NkFrcmJ1S2RYU0wwc09qZG1TZTFZaXRXc1RRMWl4?=
 =?utf-8?B?RjgrUHRBTVhEUGMycDZabGQzd09KaXcrSmgwMHlRdkhmTVJsb2ZQTmpsazl3?=
 =?utf-8?B?cTNnUVB5YzdicUF3TXpXaHVrM01jWTBUSTNmSEMybER0OGVtNmFIQjRDei95?=
 =?utf-8?B?Z3M0T2srV2pEeUVPR1YzRTMvd2FrdFc0RE5CY1ZnRiswZjIzSlhTU3Y1Ykhl?=
 =?utf-8?B?cTVKeHlFVnB3VjJkZXR3ZnMxaENpb2lxZFpTVERCZzBnTEhxQm5Mc3FRbm9u?=
 =?utf-8?B?eldsZThkOHhvY1FoQXVMbjZCam9uMjZJS0lYM2RLOW1CN1lPVWpGQTk2ZVdn?=
 =?utf-8?B?WW5FMVBtand3bnRTd3JLUVBjeVhZTHpaN2lPZytOWmE2a1h3QUhTVElabmFN?=
 =?utf-8?B?ZFA2YmV2bmptcEdaZVVHMXgveVN2Q1djb2RUYlc1NHFEUHBmNXliQVVEay9C?=
 =?utf-8?B?QXZyRnRlSnRZVEVkS28vdXVja0ZBa255ektibS9lZXJObHUwVzdEOFd4d3J4?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D19F3DD47554274A862FE554987FF2F5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sjRi/T0939ptPRXJoBAVZ3A/0eY7VqKC4PPqWJXt25tsqCdkD7RqKup91U5Yx/vmd1R+bebYUWp9Rk695p3p7qBhVnT5KH3GbIQIK9Dzk5r41YjWyESX9SabqLfkSQllDa8K/5v+f/QS570LD6fjA1/KoBhTEaZycmsce7LDypaim7uDFLrjZdYM5nvlbnBib2hm/L9m+w0TA/TKOG4uxQx6Dn7pw/wC8lWXjyWB5ZjCT9tNOdR52CijMcwrlAUZl2DWTkld1gYfFea+cIEEKHLVtK0z0rDbgkJnSpm/fY2qLnZ8B1S/OY0FkJ0z2jxrgVONCcEDruFkW0c0wWUKlXcyHAWMh3GdzymhrkmUr79pbBji5GfPvyaFGBXWGmsx6Fa4Q6kvPQ2ZA9DPoaP9C7/8sgryORUgQEYcQoVFR3bF55HUuEiStQeY8InFmHXlPRjaA6oQeSZl3HK8qJgAiaWFvy0tKQf7r1qJZlU39my9MwLaw0gWp52DvwTuaTUYUrTDTSekkcT+lYFWhHQaDbR2wRjHsNq7lXZ+vYZS3euT5Y1dD1+oARtdQnoVOOSYsksT5FF6tc3awAp7GKH9vYAZ9KwE14KdK0P2HTPL2NI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6839.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0658a07f-bf11-47a4-ebba-08de0cc834c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 15:25:15.1665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kUEukRfK1SErUYG8dTmmcJr9E+VylBIFC1MgKUgyvC5BEXvAIhGCdT3hTy2A13Ec/amlvVCPKmLrdaBxko409Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510160111
X-Proofpoint-GUID: ClropNDfV2oV9raW2jAKTitMZtU_Jp4H
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68f10e66 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9jRdOu3wAAAA:8 a=TQzMNT3qu9RE19OALDUA:9
 a=QEXdDO2ut3YA:10 a=ZE6KLimJVUuLrTuGpvhn:22 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX2Ih3iRChJt/u
 Pk4nZmElyiUdGIIIcnucsRpS4Cf+VKpiW8kHN4WW7ndXVtNGRUFiOJHfv+F2SPXvNVZXBGub1e5
 J1rhugwcNAGuMZZEXAnfwCKb40Pxua0DI/a8h+oKwmlmYOzC8gerYfc/BR4e49qSmOK5c9AUHhK
 YeB44CJtsQouiOtOrCr9fdLESBl6qbBHFuhyfvNSrjTDzsvsc2UwDpML0UXP0Ze7vUFYyO/ElKd
 wFNLOs38iccpN3/vH9pHKPRxwIFlvNgETlRdm+9SOGZvBfvwZTKTxWhgmPcthM7T0bTKFIkkNYP
 +3+ee+Ivg7xMlVsuGrSy48DRQMaaaB8rb2nShmeETAab2Qq2/4SyfatFRQIcKGI8pUa96XV4dCF
 oXdskLz49iMJSGengaA4JYrzn6UHsjwOgdVjfb2yyNZtCmlfT74=
X-Proofpoint-ORIG-GUID: ClropNDfV2oV9raW2jAKTitMZtU_Jp4H

DQoNCj4gT24gMTUgT2N0IDIwMjUsIGF0IDIwOjQ1LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE9jdCAxNSwgMjAyNSBhdCAwNjozNDozM1BNICsw
MDAwLCBTZWFuIEhlZnR5IHdyb3RlOg0KPj4+PiBXaXRoIHRoaXMgaGFjaywgcnVubmluZyBjbXRp
bWUgd2l0aCAxMC4wMDAgY29ubmVjdGlvbnMgaW4gbG9vcGJhY2ssDQo+Pj4+IHRoZSAiY21fZGVz
dHJveV9pZF93YWl0X3RpbWVvdXQ6IGNtX2lkPTAwMDAwMDAwN2NlNDRhY2UgdGltZWQgb3V0Lg0K
Pj4+PiBzdGF0ZSA2IC0+IDAsIHJlZmNudD0xIiBtZXNzYWdlcyBhcmUgaW5kZWVkIHByb2R1Y2Vk
LiBIYWQgdG8ga2lsbA0KPj4+PiBjbXRpbWUgYmVjYXVzZSBpdCB3YXMgaGFuZ2luZywgYW5kIHRo
ZW4gaXQgZ290IGRlZnVuY3Qgd2l0aCB0aGUNCj4+Pj4gZm9sbG93aW5nIHN0YWNrOg0KPj4+IA0K
Pj4+IFNlZW1zIGxpa2UgYSBidWcsIGl0IHNob3VsZCBub3QgaGFuZyBmb3JldmVyIGlmIGEgTUFE
IGlzIGxvc3QuLg0KPj4gDQo+PiBUaGUgaGFjayBza2lwcGVkIGNhbGxpbmcgaWJfcG9zdF9zZW5k
LiAgQnV0IHRoZSByZXN1bHQgb2YgdGhhdCBpcyBhDQo+PiBjb21wbGV0aW9uIGlzIG5ldmVyIHdy
aXR0ZW4gdG8gdGhlIENRLg0KDQoNCldoaWNoIGlzIGV4YWN0bHkgdGhlIGJlaGF2aW91ciBJIHNl
ZSB3aGVuIHRoZSBWRiBnZXRzICJ3aGFja2VkIi4gVGhpcyBpcyBmcm9tIGEgc3lzdGVtIHdpdGhv
dXQgdGhlIHJlcHJvZHVjZXIgaGFjay4gTG9va2luZyBhdCB0aGUgbmV0ZGV2IGRldGVjdGVkIFRY
IHRpbWVvdXQ6DQoNCm1seDVfY29yZSAwMDAwOmFmOjAwLjIgZW5zNGYyOiBUWCB0aW1lb3V0IGRl
dGVjdGVkDQptbHg1X2NvcmUgMDAwMDphZjowMC4yIGVuczRmMjogVFggdGltZW91dCBvbiBxdWV1
ZTogMCwgU1E6IDB4ZTMxZWUsIENROiAweDQ4NCwgU1EgQ29uczogMHgwIFNRIFByb2Q6IDB4Nywg
dXNlY3Mgc2luY2UgbGFzdCB0cmFuczogMTg0MzkwMDANCm1seDVfY29yZSAwMDAwOmFmOjAwLjIg
ZW5zNGYyOiBFUSAweDc6IENvbnMgPSAweDNkZWQ0N2EsIGlycW4gPSAweDE5Nw0KDQooSSBnZXQg
dG9ucyBvZiB0aGUgbGlrZSkNCg0KVGhlcmUgYXJlIHR3byBwb2ludHMgaGVyZS4gQWxsIG9mIHRo
ZW0gaGFzICJTUSBDb25zOiAweDAiLCB3aGljaCB0byBtZSBpbXBsaWVzIHRoYXQgbm8gVFggQ1FF
IGhhcyBldmVyIGJlZW4gcG9sbGVkIGZvciBhbnkgb2YgdGhlbS4NCg0KVGhlIG90aGVyIHBvaW50
IGlzIHRoYXQgd2UgZG8gX25vdF8gc2VlICJSZWNvdmVyZWQgJWQgZXFlcyBvbiBFUSAweCV4IiAo
d2hpY2ggaXMgYmVjYXVzZSBtbHg1X2VxX3BvbGxfaXJxX2Rpc2FibGVkKCkgYWx3YXlzIHJldHVy
bnMgemVybyksIHdoaWNoIG1lYW5zIHRoYXQgZWl0aGVyIGEpIG5vIENRRSBoYXMgYmVlbiBnZW5l
cmF0ZWQgYnkgdGhlIEhDQSBvciBiKSBhIENRRSBoYXMgYmVlbiBnZW5lcmF0ZWQgYnV0IG5vIGNv
cnJlc3BvbmRpbmcgRVFFIGhhcyBiZWVuIHdyaXR0ZW4gdG8gdGhlIEVRLg0KDQo+PiAgVGhlIHN0
YXRlIG1hY2hpbmUgb3INCj4+IHJlZmVyZW5jZSBjb3VudGluZyBpcyBsaWtlbHkgd2FpdGluZyBm
b3IgdGhlIGNvbXBsZXRpb24sIHNvIGl0IGtub3dzDQo+PiB0aGF0IEhXIGlzIGRvbmUgdHJ5aW5n
IHRvIGFjY2VzcyB0aGUgYnVmZmVyLg0KPiANCj4gVGhhdCBkb2VzIG1ha2Ugc2Vuc2UsIGl0IGhh
cyB0byBpbW1lZGlhdGVseSB0cmlnZ2VyIHRoZSBjb21wbGV0aW9uIHRvDQo+IGJlIGFjY3VyYXRl
LiBBIGJldHRlciB0ZXN0IHdvdWxkIGJlIHRvIHRydW5jYXRlIHRoZSBtYWQgb3Igc29tZXRoaW5n
DQo+IHNvIGl0IGNhbid0IGJlIHJ4J2QNCg0KQXMgYXJndWVkIGFib3ZlLCBJIHRoaW5rIG15IHJl
cHJvZHVjZXIgaGFjayBpcyBzb3VuZCBhbmQgdG8gdGhlIHBvaW50Lg0KDQpJIHdpbGwgcmFpc2Ug
YW4gTlZJRElBIHRpY2tldCBhcyB0byB3aHkgdGhlIFZGIGdldHMgaW50byB0aGlzICJ3aGFja2Vk
IiBzdGF0ZS4gQnV0LCBzaW5jZSBHb29nbGUgaGFzIGVuY291bnRlcmVkIHRoaXMsIHdlIGhhdmUg
b25lIGN1c3RvbWVyLCBhbmQgSSBhbSBhYmxlIHRvIHJlcHJvIHRoaXMgc2l0dWF0aW9uICh3aXRo
b3V0IG15IGhhY2spIGluIDEtMyBkYXlzIHJ1bm5pbmcgb24gYSBzaW5nbGUgc2VydmVyLCBkbyB3
ZSBleHBlY3QgdGhlIFJETUEgc3RhY2sgdG8gaGFuZGxlIHRoaXMgc2l0dWF0aW9uPw0KDQoNClRo
eHMsIEjDpWtvbg0KDQoNCg==

