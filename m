Return-Path: <linux-rdma+bounces-1445-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAE487C533
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 23:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780521F21862
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 22:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB916119;
	Thu, 14 Mar 2024 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iYtn2H4X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZJ5YU+i7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9158623;
	Thu, 14 Mar 2024 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455870; cv=fail; b=fH0oPl4jyA4YUyV4uxn+Q7oLw2gTxBqbtEgTMwR0UTi1kRCxOM+U+fVEdI2CCuAtpMsWuRSI0l2mJAogGYDcYl8Xw4J7hI1IUOL+z3zZKIDm4RF9bY2NjUZVRcaNcJZD21WyA7OkexgfI+NgCgwelTWwDkG2ixI9KlHKrgaOE1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455870; c=relaxed/simple;
	bh=dZ22ndMT1yWb0yuxlgj3ld/9MvFp3H2faJMQUM3KGGo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e7Z3tT+SeJAlKVZnUI7MJGTkTiegVGxwI777Xg/882ykZJXoRgFeo7JMD9AN+42G9hxhGBoVpgxZiR1nHhcd9efbUS5Sbu8FxuazzmgbT3CC/A6d6wBIxWwewqze66rDEVvW64qgVFIUrPYuNGLJDP/tZcllq/tYjB+HlBfn46w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iYtn2H4X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZJ5YU+i7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ELDX6R016328;
	Thu, 14 Mar 2024 22:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dZ22ndMT1yWb0yuxlgj3ld/9MvFp3H2faJMQUM3KGGo=;
 b=iYtn2H4XGQOfAQdq5ThDPQpCUCnS3j42GcJNwtngCqRhpKcWmSn+er7L9IHaPd91G4EY
 91xtXHESzC4V/ZSjxHU83R4Do95KuPAHlZV98yLLyddvnz7fIi8p7QZlKft6HQSYQayt
 QD+5diBSzug66KSQmhdRmQueQKft93xhi8JS30qRHwC/oBK1Rt941VMus6YbAR2LYcG/
 +lR8ysPdolAN2sz/32atReiw9IIvM46TdOGJr5yHLDARnaiba9lCM9efiq4MkAXFhnYE
 bUFKBiB3WkBxV0JXA8mBN+FQNDVEJnF7y7mgO6TNrEETh4FK0V1tTVgFqDRovrKqsvBR dQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0absdae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 22:37:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42ELKodl028567;
	Thu, 14 Mar 2024 22:37:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7b4b45-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 22:37:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQh9LBUinulG1L/UxaDE++Fu+2//ryvMmC5hK/sJxMGN3huynVKPLddigvTbAORcw0swdA/ZptC2ldqcBREjrcrsCvMe5lMn3PYJE11gPZa/krYgyTkoQ8jd1Y7TWzAlHRWlBf3Ww5MHbwzTofyVbs0R1hqVA83ll0raC858j/r+/r00ujGS/YKcYxmw51ynklLeT3ybILXQqLVapwq6e41cdFrwKOYR8W98A6TRjTICSzt5q9E/bdbfdRdKPpMDA0pLe2nahrrD3sum/ChxefI2HHYJ8GRgH/C9CUNfRsa3zZcvnZfnMGnfbOHP2B7HLcD9oSufTsJ5aNQz4GTpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZ22ndMT1yWb0yuxlgj3ld/9MvFp3H2faJMQUM3KGGo=;
 b=hdMXlIPxLoAZzpr97umJRKNr/Ed1fD94awqEmrYLjx4yYcM9oKMkk0E+6B8Pst+inwSjy4cPNK0XnUydn95QEWfHcyS+6SNoGmgw9XE8LGL5a2INW7djsO+hy9s3aYAMkDKMnxY7LOMM+tyKiLI4nSCHCkw6N/Vi8lkVjP07+VegTP1CGWzB7BvbGmm/p+rxH0+fG+b6Ty/5vs/N0z56cCIo4BmjmL3Euv+mtWH7pFVa/bjvwAVDh60RIxP/WsPH25Yh7MoNJZ9HuI9foK/3kryr1tGkAvZS+OjQYhUFi03x6tTmvNVliq4TDtie12KwGsEK+vgVrKASksZwfRcmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZ22ndMT1yWb0yuxlgj3ld/9MvFp3H2faJMQUM3KGGo=;
 b=ZJ5YU+i7Ms1xy9fLMVqtrG3/4dPdux8Lxutd976xift2NpRrASHvPxtkdWIWISuMkyksBSMerfmdX2kyundT4G9hvNLxGGkieHnbgIyTgwrFl3ha1x+C6kq63MVhmo3S6JGOG0Ed2wB7q0Uktbltwt3N1OxdQr1Qw/uvLviS4nU=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CY5PR10MB6144.namprd10.prod.outlook.com (2603:10b6:930:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 14 Mar
 2024 22:37:29 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::fe4e:ebf3:2157:7f36]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::fe4e:ebf3:2157:7f36%4]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 22:37:29 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "michal.kubiak@intel.com" <michal.kubiak@intel.com>,
        "woni9911@gmail.com"
	<woni9911@gmail.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "threeearcat@gmail.com" <threeearcat@gmail.com>
Subject: Re: [PATCH net] rds: introduce acquire/release ordering in
 acquire/release_in_xmit()
Thread-Topic: [PATCH net] rds: introduce acquire/release ordering in
 acquire/release_in_xmit()
Thread-Index: AQHadgHMgGAJTd0I20K2atNq6wza2LE3H+0AgAC0cgA=
Date: Thu, 14 Mar 2024 22:37:29 +0000
Message-ID: <4997357157f5735d07efdc7cd45388bd32375e5c.camel@oracle.com>
References: <ZfLdv5DZvBg0wajJ@libra05>
	 <ZfLkyiTssYD8wmVl@localhost.localdomain>
In-Reply-To: <ZfLkyiTssYD8wmVl@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CY5PR10MB6144:EE_
x-ms-office365-filtering-correlation-id: 8796a371-b24b-4eb3-342c-08dc447754e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DAubBwbrJTK2FyVAhQV2eKktL041oZcUq8I56sFjGNBLo8Zpqt3A4HHKGLWuyKmNkMBFm4O8xYyh8x8KP3vWNRk/xD4JpzfS9ZuOBIBukcqmgsz3HJg/iJtpEDmreADLl8rZo4oT8KLuGVH1lxbwoLsNxjj9EDMrKwfj2fRTGKFTcr8vqIDBHyhp7S4T9hJxzCuvFuiH3auE468JEeVyPBaQVDwgRrW5uhzOBpU4GMq/O8Mukpdb4O0k12jhA6Kd98iwLRnvnrtirqHfXXMRZ/9ovJVq43dW4/gE0TB16Er0TrbyR5Iy6Jm0cpUr2z8rCHrTU8SbC2xFQWahmTq4gxNH2y5XQuIv45Q6hHPpTkQWIN3HYNn6w7WkBFpDhfEQGgrwSHib6bBBdHbBqzP0qdQDcY2H6770if61SEWvYSeUTcS7g+riDdjA+pvEupLb0CD2rv1sAYBUF/5eGnhfa3PC3pQoX9KSWViSQBHfz1WmdCQ8Gd+Isx4Mal32CNfBwAPlti24FllLZrAo5AAClMxR0Zd/Gz65YLG+kg7nIrcLUO2HJcqhVSBMhY0c2CbmxiOeUypVFvJKczpHfP70zpMSLLBvP/Ubj2BRcCky3F+mYet6CxYas26MloEBL7cTvR/IvB3aiSLzeV+YbaP6ZkoyW6XwhuqEPywmnW7kDhnTosaUpgbEj5lhR1PvAwahubTsh3lptpGv27nBaQJqB4JJVR8lIrPfC8wZ4Yf8g2Y=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NmdDRDBNQThDRUhaYTNhS21zMGtqaVMrb2tEcHRHcWlNRmVQL1h2VjFNL3RF?=
 =?utf-8?B?Q1NCd0lxWlptNFZrOGVnbUtTZjJQSWRNeEI2aS9XS3BsZnI3U0VON3FIZmhJ?=
 =?utf-8?B?eU5yN3lVTTZJYXpWd2N2WVNsNk5GYU02SmtBT0x4NGNnbWF5MmJmYnA0N2JP?=
 =?utf-8?B?VDVZa0JTb3REdU1VOGFFK0VqTW5vTnNZd1lyUEJHWjFyc2F1eXIrSWFhU1Nk?=
 =?utf-8?B?RWtORFJxTGtUMUlSWTE0dUxSR0RmVXZVRGxMdmp6NjBZcjRvNWtsYlRFS1ho?=
 =?utf-8?B?TDVHM3FQb1dueHNyaXdBRGVLcXFVN01OK2pod1JpdEdyaGcvQlYyN09UYndQ?=
 =?utf-8?B?UzI0azRQMkpVOFNXVWlxd21rblZ3a0RjaFhaTGY5WVAvTHl3Tzl2WlRFeEhK?=
 =?utf-8?B?V3lTZGtWVldXaXh1M25NR1VRbUNQeG9JaDJURVRrUGNRaHBjVjM2WTJrcW9i?=
 =?utf-8?B?ME9IYzFrN0NMSGZBbW9QK2Z6dENtS0N2eENIdUxnVndxSkZaSjZtRzdhNndT?=
 =?utf-8?B?Z25TWkJURHl5QlUwMXBiK0ZHZElwU3U1OFlBMzB0d1cyeHllSWtpMTB4TTVT?=
 =?utf-8?B?TXc1dFRFSHR6REluRmlOelVkVW9jN2FTN3g2ZjhYZHpxeEU1ZUdvaTlIOGxM?=
 =?utf-8?B?aWtxTXZaaXBZMEs2R3VMYjZPcnlhQ0lzbytpQkg5RC9NSVR3TWNFVUZDaGxi?=
 =?utf-8?B?WTRLbi90RGRKbE1YbEJqNnNYT2xJMGdCM0tYYXBVaUkyNSt3SjBESjU0aGxh?=
 =?utf-8?B?ZkJhZ1E3MmplZUdEeW0wQUs3RVpxbjJPTkxubFVjOCtob3dPYlBXVzhOUnIr?=
 =?utf-8?B?THBoMlo0MEVDQjJlOWdHVWVXQ0JZb2VtU3ozUnFFbzFzM3YvTG5zR1BMdzBN?=
 =?utf-8?B?Z3Jybk5Ya0c4RWtZZ2NIMHRSUE1HTjl1Y216bDdtUDdZcGtlaFlwVzRmNXdq?=
 =?utf-8?B?UkJMNGxZRDRPNnRzWUJXMkUvcXk3YUNCRkdBRlg0L1J1NmpsalJOWnhCS1g5?=
 =?utf-8?B?cm5SN3pMQ3EwdnhubkJmcFNCeDdramhJbGNMeEVrT2ZNL2JQZm90V0orS1Iw?=
 =?utf-8?B?cEpxcEVTbVBxVldsUzlUQ2dtMWlkL29YNzhWUlVhTXJTV2JXMXJHVkdNbUJv?=
 =?utf-8?B?ZlV0VTVPWkZHYXYzMHFDTVl1QzJuaXlzMmpZNGNTeU5HbTkzcHIwbFZQN1FB?=
 =?utf-8?B?K0h1dXpETlcwMWZQZTc4dC91YzlBckd6NFllbTNFMnR3MlppUENOb3NDMERI?=
 =?utf-8?B?TDgvRFk2aFBkdjNpWksyd3NuNVR1d3AxajBOWmlNenJLc2VTeHpWMVRjZC93?=
 =?utf-8?B?TzZRdCtIaGxiWk9lelRxenk5SFQrUHg0SHAzTWNBT2I4OVNWUksxVnNkZlho?=
 =?utf-8?B?enppanFaaGo0aDJuOEpCbkJxTFNUL1M5NXUra1pUbVNwZm9TWWhRb2dBUWFa?=
 =?utf-8?B?aW9wRWtVeGZLVWxzQzI5Yjl2WHFNYWE4V0FvTE5TaTZ1THgyajFwZTVHc1lS?=
 =?utf-8?B?VTJYR0FmU1RaR2tDaVpGRlZ6Q3ZCK2VXbjRtaXQ2ZTZoZ2hCcGg0NWpHSUEr?=
 =?utf-8?B?c0xkZHJGMnIxZk14cVIyWnJJcnM2QmJ2ZmJya3RWWXEvSktzODB1WDNaWDl5?=
 =?utf-8?B?RnVsZkRTUi9qbXgrTU1IWFJ6VktOM0diUGR2Y08rOVVrWHl6dlkzS1hKRG5o?=
 =?utf-8?B?Snh0QXJlRFM2QjFyTkJFczd0dlAydmVhdmVJZ1o4c1RFUG5STHlMY1RIOWNK?=
 =?utf-8?B?bzRHVTNzbjVIbmM5aU1vd3FXZXVlQ0JuQjRZWkMvTUF0UFA3YktvT01xdmU5?=
 =?utf-8?B?czBPK1JudGw1cnhXTmtGVDB4US8rMU1CSUI0WWJKa2ErS0VCWDRmc08zY2ln?=
 =?utf-8?B?YXdYMVhNK1hkMkZmQVg0VnBhWEtLSEFBN0xuQjVudGhqd2I4REd3WkVEeDRy?=
 =?utf-8?B?YUlBQjhlL1lERmx5clB3bzB3bTgyTDN4WlFmSG9Renk4SG4vdHpib1UvWTA3?=
 =?utf-8?B?SmxrdXQvd2ExL0JZcURwVUVuWlNMQzZjRVprZWU0WTdPc2w5Y0I5MFRzcVlC?=
 =?utf-8?B?WTFHWnM5QnM3eCsvenZGOUJBUk9Nd0J6N2JLbDRVSmdWek1yS0hFd242SGwy?=
 =?utf-8?B?UVFOdlk1a3VidFBmR1RRK2xHQVZNU2JaTGdZdWNpTkNxY0FIdEtPL0U5UHNV?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCD7CBD25D8FFE40A773CA245B62EB2D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FqUTN5f5y5yjtLbi2CaVtmdIqesXhbOX2hUwm4rytu/+0QVoTZjDHlZMRFWXMQozW1ew99ApBziimqRY82UFR+oEr2hHm0Vq72x0zI3ozCPkgIfwpY2nlG1sGxUbbDv/qgTHPqy0Du5ln7jldQaMP7plXKRp0CM0Icon0XmMuN2QxewYd3UuVWbxjT2hYsq9GMghGXPKC/og3B0i/a5Bv97dao/SZTeX5OF+htzkzdSxeKPFcn5hrD9MNC+HEBt7z9xwRLbEbZfeqZ6eNWZO9tFngkbZbZ9hMeQHgcFV6l9ptrp51Bndd6/5qvYsVmyeQvCwGxHz6zpKba3NPGGJhcxB73AG4ucEU18L+ym10zpAdz+ROKpPXifm3KL71ums7L1ACIFM8GkcAa2dPcDrzw8K7TgRwlBNKOFnL5Bpd8lokN8sKg9WKZu6tcyWXWGuY/1PPUcOdoZpYk52QVIJJKX7qgyPlynxVdgWvi3wL3/pKQm5Z/x1Qsxb1Jy4iPgFwonbmrHrRhzMC/bhg/SpiDkq3gzEW9SyMvpu8qHOqATpI5632mjLvcLkVnZcHOo4uhtOJg1J6DzOXoIyy1toKZxoiuOUTeXhw5BUyY5sPTc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8796a371-b24b-4eb3-342c-08dc447754e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 22:37:29.5597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCokuSr56zTfqDu6bbHJSFl7NvT8pTUzzcnMz+kqEXHIEHTUgbHYYyczOsxCvQQwsYIQymH3aUp0IaLSwmEgMw11E0lUkQq3mx9+NDiCf6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403140173
X-Proofpoint-ORIG-GUID: GWJIXVIAWEpo5apPws27m-KPBPM0PA-B
X-Proofpoint-GUID: GWJIXVIAWEpo5apPws27m-KPBPM0PA-B

T24gVGh1LCAyMDI0LTAzLTE0IGF0IDEyOjUxICswMTAwLCBNaWNoYWwgS3ViaWFrIHdyb3RlOg0K
PiBPbiBUaHUsIE1hciAxNCwgMjAyNCBhdCAwODoyMTozNVBNICswOTAwLCBZZXdvbiBDaG9pIHdy
b3RlOg0KPiA+IGFjcXVpcmUvcmVsZWFzZV9pbl94bWl0KCkgd29yayBhcyBiaXQgbG9jayBpbiBy
ZHNfc2VuZF94bWl0KCksIHNvDQo+ID4gdGhleQ0KPiA+IGFyZSBleHBlY3RlZCB0byBlbnN1cmUg
YWNxdWlyZS9yZWxlYXNlIG1lbW9yeSBvcmRlcmluZyBzZW1hbnRpY3MuDQo+ID4gSG93ZXZlciwg
dGVzdF9hbmRfc2V0X2JpdC9jbGVhcl9iaXQoKSBkb24ndCBpbXBseSBzdWNoIHNlbWFudGljcywN
Cj4gPiBvbg0KPiA+IHRvcCBvZiB0aGlzLCBmb2xsb3dpbmcgc21wX21iX19hZnRlcl9hdG9taWMo
KSBkb2VzIG5vdCBndWFyYW50ZWUNCj4gPiByZWxlYXNlDQo+ID4gb3JkZXJpbmcgKG1lbW9yeSBi
YXJyaWVyIGFjdHVhbGx5IHNob3VsZCBiZSBwbGFjZWQgYmVmb3JlDQo+ID4gY2xlYXJfYml0KCkp
Lg0KPiA+IA0KPiA+IEluc3RlYWQsIHdlIHVzZSBjbGVhcl9iaXRfdW5sb2NrL3Rlc3RfYW5kX3Nl
dF9iaXRfbG9jaygpIGhlcmUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWWV3b24gQ2hvaSA8
d29uaTk5MTFAZ21haWwuY29tPg0KPiANCj4gTWlzc2luZyAiRml4ZXMiIHRhZyBmb3IgdGhlIHBh
dGNoIGFkZHJlc3NlZCB0byB0aGUgIm5ldCIgdHJlZS4NCj4gDQo+IFRoYW5rcywNCj4gTWljaGFs
DQoNClllcywgSSB0aGluayBpdCBuZWVkczoNCg0KRml4ZXM6IDFmOWVjZDdlYWNmZCAoIlJEUzog
UGFzcyByZHNfY29ubl9wYXRoIHRvIHJkc19zZW5kX3htaXQoKSIpDQoNClNpbmNlIHRoYXQgaXMg
dGhlIGxhc3QgcGF0Y2ggdG8gbW9kaWZ5IHRoZSBhZmZlY3RlZCBjb2RlLiAgT3RoZXIgdGhhbg0K
dGhhdCBJIHRoaW5rIHRoZSBwYXRjaCBsb29rcyBnb29kLiAgV2l0aCB0aGUgdGFnIGZpeGVkLCB5
b3UgY2FuIGFkZCBteQ0KcnZiOg0KDQpSZXZpZXdlZC1ieTogQWxsaXNvbiBIZW5kZXJzb24gPGFs
bGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQo+IA0KDQo=

