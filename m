Return-Path: <linux-rdma+bounces-8417-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1D4A549C9
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 12:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6B6189950E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 11:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB021325C;
	Thu,  6 Mar 2025 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CjoS44jK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2121.outbound.protection.outlook.com [40.107.22.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE320B1EB
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261002; cv=fail; b=ofxZI2ap22RgMuQQ0uNGTAJIeRj+k1sqfKwmdSmAKxlUx2UkUy/EVVts88+kFl00zqZcEO43vNC5yz7s6W/UBKfi8c6kbbDr570/WZtbP+JupPCTJzHUeaKD2aN2KZ+XRmoPUUMyLrSK+p6saJESanujZ/OaIBTjKZJ4ERkP9EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261002; c=relaxed/simple;
	bh=qqB2ELFbjvTHIPi/A/8eT+g6AH0vqNGixgf2RQLjNeE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hmBV9qge8hTtsTII5RF6A4gFAAkbvf3oDyzQnuYcB0nGsn6bMIKn4tlMTHeeL3U/+tcXcFBUOFwlN1/dYU/4qtJBOvVYwHuZanmQSWweouuOBVu1qdxzMeeV50fLWLpEJ7f6j5DGFV9RbwynJfhjnynloWy5O9rgFhCwz1X9fXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CjoS44jK; arc=fail smtp.client-ip=40.107.22.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqrG3gZlfngdMtpw98FJDr8AKdeb6eHZgSlQyh2+T9jOAS8lPfyCNBzCFtRLCR9yVdxniETeIkFC87gzIsS1ql8nZNndh2n6v0T8pJdORlh0HZEYjZfndRrJ+WYtewJVckAUcc7znmC49L0vGUH3HUGx9YEqJ/cAtPCl7zgCCDCEH8Yc3XvgH4NWaoOcjlvLyUaY3hYHLPN+wEfdhTNZK/rS2pvmRqL2ho1mPmU3AgJ5fnEXfUBPOql0gfNR3rYcyp2Dpi0nCuKDO9o/a5Us9qa+mf7lfb/skbRPRF/3tpIMJ6csrTcPTYZH+uA5lnHZgjRI3ByKId/Z5AfSYfuwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqB2ELFbjvTHIPi/A/8eT+g6AH0vqNGixgf2RQLjNeE=;
 b=NBEPkwhO9V5Z7aO/iMy9btOmFL+HeGe0vUP6ISz0+DuqjROJspDG3pvSx79o62TXp7dAEfCoGIX8nZg7DEEVaGskik3gvtx9zARbjHwuJEa5zHdRbDWxqMRpepK609DpIzYr/zVZ2fhh+zX/H80c2QP0a3farqPanPQLdRBY9TEqsiKPu4gtN4Sr/rO518QEdPzcm3r8wZg5P7otxBqXByPV7ZVzHfdC7ykyQbcu7ESxlZGrw0MKDbHYFw9+hON43umjaw5+IxxX/zvo5Yx0MLOqWXHPKra3sOJrjhohCEhCi/Kt4uVghXkEBh4djyT+E31l4ZmItNtS8feueq3I0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqB2ELFbjvTHIPi/A/8eT+g6AH0vqNGixgf2RQLjNeE=;
 b=CjoS44jK9zVD73ldkoeqdN2QEh5EVjY2qg3Wb/cXpVme5C6dNceDZFFYwsIgJB4r4m7sqqKn6GZwOoZTRsGjomAANTA9Lvan2C8ekw2XUbJChcMya7bplIzRVR2qK21W0944WLGso262HXzFo6g+zoN7y918OYFdIty7chjIMvI=
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com (2603:10a6:102:44c::19)
 by AS1PR83MB0541.EURPRD83.prod.outlook.com (2603:10a6:20b:480::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.9; Thu, 6 Mar
 2025 11:36:37 +0000
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4]) by PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4%5]) with mapi id 15.20.8534.010; Thu, 6 Mar 2025
 11:36:37 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [bug report] RDMA/mana_ib: implement uapi for
 creation of rnic cq
Thread-Topic: [EXTERNAL] Re: [bug report] RDMA/mana_ib: implement uapi for
 creation of rnic cq
Thread-Index: AQHbjnZeYfFFK1/i3kOyKRQdocIziLNl+o3g
Date: Thu, 6 Mar 2025 11:36:37 +0000
Message-ID:
 <PA1PR83MB0662A3D85BF76B509E9617E1B4CA2@PA1PR83MB0662.EURPRD83.prod.outlook.com>
References: <26f9cf15-2446-4a73-bc34-5d07dfcfa751@stanley.mountain>
 <20250306090125.GS1955273@unreal>
In-Reply-To: <20250306090125.GS1955273@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cd8faba8-f996-4997-b634-e82c0a29f593;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-06T11:34:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR83MB0662:EE_|AS1PR83MB0541:EE_
x-ms-office365-filtering-correlation-id: a178194a-4693-4efc-80e2-08dd5ca327d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cVNnWXM5cTRHUmU0LzlCTzdZbUNEcVlQNkJiWk1WeThNbWxMQXJPOE85SjdK?=
 =?utf-8?B?R3BFSjdFQWdDdGlvVkp5ZEcwb2srVkRPL09jN0dYTC9IOWVld2Q2UjZrQUV2?=
 =?utf-8?B?RE5CWloyT0p1TzlVVFhPT0lJRVJFUlltR0w2OGNsUjZXd0grd3p0alJRTWhn?=
 =?utf-8?B?UVBUTkJ1ckJ1c04wd2kzeXpxamhkNHRSVGd2NzJNQUlweTZ2cmdsZFRNVnNI?=
 =?utf-8?B?UTlTMzlORG1Gd2lHWVVmalNyNXdPUEJpQmtaSlNpTGhva3I5Z0hoMTdEcnQ2?=
 =?utf-8?B?eS8yQm1abTZYYXNQSUJuSDFqZ1RiT2ZCS3hLNFFkb2F5MzhVdnRZTkkrTDZo?=
 =?utf-8?B?dUVrcjg2VWloNEdFUVhlaTBQZzQ1RERqWTdxdGpVYTNFU1Azak53UWpZRTFx?=
 =?utf-8?B?OFZqZkYrV0IwSFJFYWU3U21OcDViNGlCSEZYNkNwLzAwbFNCeXozSmlXSWFs?=
 =?utf-8?B?U3ZocWY4bmlkdkVZTlFJSzNNWlNZeVI4ZEZ1ZFN2VGJIY0ZRK0lzbzZGS0VO?=
 =?utf-8?B?SDNaTUNFRHZvd2hURlk3N0xxUUZPbGZzNWlhcE1PQldIb0tFM3M3YzY5SXJP?=
 =?utf-8?B?VVk5L293U1U3KzdWeTZOWjRJV0dVdVpIWk1lMmNTa29LcWJYSzBKVGY0K2hu?=
 =?utf-8?B?QWVOTUZWendCc2p3VUFrSzMxS2dnZHVJNjlCNHlNek9uN1JMa2xTdXVGMDBz?=
 =?utf-8?B?VllvOEUwd1JoanoxSk5UdHBjeEptUkloZ1dYc1dTN1UwZmdtci9YWnZkQXBX?=
 =?utf-8?B?ZEVwejZDZElDTzlScWpka1BLVUxaQnVJMWJGWTNvUDZtVmxEVlUwV2JIZ0ti?=
 =?utf-8?B?YWVFdXY2MGJ4dkZwYkoyRTByWnd2OXBCZkc2dk1MODlwa0lnVStmWTRlMkh6?=
 =?utf-8?B?UjRscko5SHRRelYza1VyT2R4dTluMmQybDBxN1J6c2J0QllyNXhGZCtkeXFK?=
 =?utf-8?B?L1hPa0N3Qm9yaFQ4eTB6QkZMdVJEN1FpckVPZzNwd2RYay9hOFBFRlpUS2Vr?=
 =?utf-8?B?ZlJYRmwzQXBwUDllZ1E2Q2h3NlhkYlZVaGlRRUdkMFQzb3k5UkpJUWcxVTdL?=
 =?utf-8?B?cno5ZktRSE1kT2VUcG0rTTY1QzB4UnFjalRHUHliUzlCdWphaXlqV3BKWjVI?=
 =?utf-8?B?Zkw2a2dSUmtQaG51NmlhOWtqdkd3eklZZVFZUjNJMHBtSDlGaGVIVWVBdElT?=
 =?utf-8?B?YnBZV0NHd0czRHBkY2NjWU1xZlltUk03cTk5UlNQZFRxSEJsa0FKYlMrancw?=
 =?utf-8?B?MVI5Z2MvMG9uT1BFNWFxbjc4ckJzd2szd2NDei8wSm1qWVc3N3RvWC9oaVNQ?=
 =?utf-8?B?SGJPSC9LWkJqTlNYUWVaQW9yT29nOHFaN2xXSjRCaEhxekdTUXZaTWdiVk1R?=
 =?utf-8?B?SjdCUitaNXhlU3RXOFdkMjIxSk0yNW5handmVGVyS1JiMkFRZFBwb3RqZnVB?=
 =?utf-8?B?dHVxUGRQblpjMW9DT1NNYkN4eDZ0MXZiMEhsV0svdEY5Sk5HWlNMSzNmY3BR?=
 =?utf-8?B?NzRWWnNXNFBHa3IyZ0tNeC9pd2dUN0pCRkg0djF1UVg0L0JNeDFRbkRzaDds?=
 =?utf-8?B?cHNmMXROV3JTSUVySDdYRWtOUndndlJYTTNBUThMRXR1SkVBKysrVnUyZHNn?=
 =?utf-8?B?a1F1aTh4NldiYlM3aW5SZlk4TEQ2cjN0RC9iY2thVnJjS3VhUk0wVk1QNmFE?=
 =?utf-8?B?YXh6UE5Ubi94MXF3OFl2ZXl0dnJ0YkF2MnpiSTRxQVkvMWIyU1VBOUlWaEVC?=
 =?utf-8?B?NzZ4dFFKNUJPbXRiNzM2MXY1NCtZb1JhZVE2Yll4SXlpNG5zTkw0Nm9NU2NH?=
 =?utf-8?B?Z0d0V09ldnZKZHFrbkRmM0h4NDQyY2lmNnFDU2FMb3dsUEFpaWgrcndaT3Jj?=
 =?utf-8?B?Q011dmJHcFRTRlN4SGgvTUVBY3RUNmw1UjlzL2JBN3JkU1NEM2Mxa0RtWVMy?=
 =?utf-8?Q?bRCHIJgBdDnW5f9LCkZoRZDtkVXZODKP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR83MB0662.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFhhWXJYMDZQZmhDTW1mNzlvTGcwRC81dzVSS2hwWXZKcDZaYmNlME5XSXdz?=
 =?utf-8?B?N25BM1dGWWlwQUxVaHpNcC9yL01aMmZCRGJOdjIxL2p0VXhyNDMwZEk4TTRW?=
 =?utf-8?B?RXJOdm9JWFkwa3dkcCt3K25BaTlOR0oyYWlPWkxDQWJKekZOajMyd1IrRTB0?=
 =?utf-8?B?K0Q3dk9SdTRqb2E2WFg0dU9CYkhnREN4cWsxMktZOFc1ZzZ6d29nMmVoRUcr?=
 =?utf-8?B?b1o2UjU3VGJ4eGY5S3d2WHlNbzYyeVdEZnpsRXFGcWlUMm5nNHU3OGEyaFpB?=
 =?utf-8?B?Q1NUQTc2K1pRamhwY2MvanBLQmFRZWVXbk1PNUtGWTdzUkZEMGFocjRmY1R1?=
 =?utf-8?B?bnZpMkU3NG5uWFBtb09ySDdhNEFzQ00vZlJYcVI2aHFOYUNtKzh3ai80c0hD?=
 =?utf-8?B?d1JUWlZMUSt0RGllUzZZNGRrb0VIUDRHVWZhUzA2NDR4TlNWcC81cUMvekJ0?=
 =?utf-8?B?S2JBbFVHK2RCeXllUEtzWDhIb2lSRGVCOVVrNW5ncHcxUEdmTjZJeFpRR2J4?=
 =?utf-8?B?VEUrdEN2dVdtYWZRV2dnamUzTmMyVktxS21KeG5EdUpLSytCc3BkTWp6aE1Y?=
 =?utf-8?B?T2l3QUVpZmRSU28zQWtRTk1kSVpLamdXSlZVTVU2c1lyN3lTWDFVemNnQVRr?=
 =?utf-8?B?TisrMmRsYjRuSXB2ZzhCWStycEhSUVRybnJNZUo4akx4YWdjcTlYSDI4Snhw?=
 =?utf-8?B?MGhHeXlFc29xOGZycFpSckZ6SEZXeXNObjFLUjhMR01FZWRiZ0djMmlLYjVC?=
 =?utf-8?B?UzlLYTVxdmladmtRQVVhVTRlT1Y5ZHNuMUpOOTFQZkIyR0JHVWxmM1djUXpD?=
 =?utf-8?B?UFUwRVRTa051Zk56a1BZMnJwK0Z0ZGpPY0N0T1VIUmk4RWc1c1FUT0JURCtv?=
 =?utf-8?B?bktxUlg2VDlHTUthc0hQU3p0clVZZEJmTG9TMmtubURla0g0UkF2d0J2NjZz?=
 =?utf-8?B?Zjk2YVJiQXFaVktLS3dLL0VTTitLOVUxWVhVSmRLVTltdEQydFREYVhLeGdF?=
 =?utf-8?B?N3BYVlJXblVmRVNvNUZ5WmdKUThwbUhHODF4WVdMVld4UUs0NlY0eUFCYnBk?=
 =?utf-8?B?V2M0QWFqbTdOays3dHFMcEpmQ2NUVmZ1NDF0aDZMVFZsbDZsQmw2Zm5jV1ha?=
 =?utf-8?B?bzY5eVdvY29VTEZTYnA1U3R0WTkxdElkajJlenpPcmx6SkJaSVpkWGQyalRX?=
 =?utf-8?B?dXRhNkRiWjhaL1d2Um1WaTRscmpFY3JNVG1DTFBBSytUWXF1dnBFM1VBZDNx?=
 =?utf-8?B?TXp1L21wcE1jNjZycmpIbFEyNjZHQkt4ZFV2d1RCa283SlBxQzhkdTJ4OCtO?=
 =?utf-8?B?Q0pUZVN3d0xnakUwalNUc3VhdDVUVlhKWDhhdFdsRE9NRDRMVjNVQVBQM1Y4?=
 =?utf-8?B?MnpHVDBWYnZNMjZORFROOEViYk9sV2lsMzJla0pvZnNKa2ZXOUQyQ2VnYjBP?=
 =?utf-8?B?enRQVmJINEZTdjFlbyt1VDNhZnZweXh1eWx1Qm9GcXBDZHdVMzlnQUh5dzFK?=
 =?utf-8?B?VS9Gc1NUNVB3ay9oTTBIeXc5T3hkWFplZWZkZHlKczY1QUh5bTgxNjdtRmd5?=
 =?utf-8?B?MkVkV0xzNnkyV1FvWVBWT1dhNnYwUjRWMythUGt2amljYzYwMk5Nd0NEbjRi?=
 =?utf-8?B?TjVBUWhLdTNKUHFkdGdZVHdzbGhRUWM5REx1UGg4VXdZRGdSc2NxTzl5M0N5?=
 =?utf-8?B?SFl6K3JEV0ZxcEo0Qzl1TU9lekNHem9nUGlIWnBnY1BXUERRVit1eFRwTGt4?=
 =?utf-8?B?bVEvQW84Q1JyUzIyRmZmMk91Tnhtc0hvOGRtRWpBRUJnZ3B0Z05tRFlXSXZV?=
 =?utf-8?B?QUVlN0RPc0c4VTNSbjRJaTNmOFQzdldNVUNOWXpXcGVxbUtsMjJiaktsbVNx?=
 =?utf-8?B?ampEMEZOMVFuWEFlellGRnFmTVRPcEtVblhkLy9ZaG9mSTR4YytkZFdxQkYr?=
 =?utf-8?B?cjMwcG5yVmV4OE80dy9NRHlEUDJXVDlVMHBSR3VvOVdpY09ZTjN1b1VvMHk0?=
 =?utf-8?B?QUlXdEVxOTJTNGcxZFVZa2JNMmp3Tm55SEJ3MnVETy9ZbzlGbmNFdmdFdHpM?=
 =?utf-8?Q?5D8Ocy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1PR83MB0662.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a178194a-4693-4efc-80e2-08dd5ca327d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 11:36:37.3447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FewHDHWSn09g8VqveuXWna9ZAWucjRCgNjr415jkR5iceIHWj+lqGz2AE+W06l4G1HPJqbQPe809hPh9hUvg+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR83MB0541

PiA+ICAgICA0Ng0KPiA+ICAgICA0NyAgICAgICAgICAgICAgICAgY3EtPmNxZSA9IGF0dHItPmNx
ZTsNCj4gPiAtLT4gNDggICAgICAgICAgICAgICAgIGVyciA9IG1hbmFfaWJfY3JlYXRlX3F1ZXVl
KG1kZXYsIHVjbWQuYnVmX2FkZHIsIGNxLT5jcWUgKg0KPiBDT01QX0VOVFJZX1NJWkUsDQo+ID4N
Cj4gPiBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eDQo+ID4NCj4gPiBUaGlzIGNhbiBsZWFkIHRv
IGludGVnZXIgd3JhcHBpbmcuDQo+ID4NCj4gPiBUaGUgY2FsbCB0cmVlIGlzOg0KPiA+DQo+ID4g
aWJfdXZlcmJzX2NyZWF0ZV9jcSgpIDwtIGNvcGllcyBjbWQuY3FlIGZyb20gdGhlIHVzZXINCj4g
PiAgIC0+IGNyZWF0ZV9jcSgpIGNhbGxzIChzdHJ1Y3QgaWJfZGV2aWNlX29wcyktPmNyZWF0ZV9j
cSgpDQo+ID4gICAgICAtPiBtYW5hX2liX2NyZWF0ZV9jcSgpDQo+ID4NCj4gPiBJJ20gbm90IHN1
cmUgaWYgdGhpcyBpbnRlZ2VyIG92ZXJmbG93IGhhcyBhbnkgbmVnYXRpdmUgZWZmZWN0cy4gIEkN
Cj4gPiB0aGluayBpdCdzIHByb2JhYmx5IGZpbmU/DQo+IA0KPiBJdCBpcyBub3QgbmljZSBhbmQg
d29ydGggdG8gYmUgZml4ZWQsIGJ1dCB0ZWNobmljYWxseSBpdCBsb29rcyBsaWtlIHNpemUgKGNx
LT5jcWUgKg0KPiBDT01QX0VOVFJZX1NJWkUpIGlzIHVzZWQgdG8gZ2V0IFVNRU0gbWVtb3J5LCBz
byB3ZSB3aWxsIGFsbG9jYXRlIGxlc3MNCj4gdGhhbiBkcml2ZXIgd291bGQgbGlrZSB0by4NCj4g
DQo+IFRoYW5rcw0KDQpUaGFua3MuIEkgdG90YWxseSBhZ3JlZS4gSSBoYXZlIGFscmVhZHkgcHJl
cGFyZWQgYSBwYXRjaC4NCk9uY2UgaXQgcGFzc2VzIGludGVybmFsIHRlc3RzIChpbiA0IGhvdXJz
KSwgSSB3aWxsIHNlbmQgaXQuDQoNCi0gS29uc3RhbnRpbg0K

