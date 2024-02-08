Return-Path: <linux-rdma+bounces-979-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110EE84E5FF
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 18:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC13528367F
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4169282D8C;
	Thu,  8 Feb 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OJDEdqAv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S6LGcQiF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A104811E0;
	Thu,  8 Feb 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411809; cv=fail; b=mvGEmcwxJEyAerfFYssK9mULzK4ovWJyJUbH6A2ZdA5Fj/8TbIhrRT4YC+EAczPitXmrmSpGUvPLYdrqll7fPE6jBKU/ZwBF8vdxg34MHjgmUiotlOAv+r3+/tzEUFOTTuKm/5JihTbtmPyFcCwVyudFJEmVXp7bgY1FkCtV+IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411809; c=relaxed/simple;
	bh=IRQ39RRWIS/akoMFG0XACTS6mvzuCAgn3i9Z0QC0/nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jBWdi0MFvPHdlR/Fs1O9+V3+9+EhVtx+Y3bkhgiwAPC9V1Dmp3DBHgd5y0aVK/L/gGWHvdT24FaVQp92+GGGne9qkoAv13QQ34IzSL/waV1a+/NV6CkZ6bSJ1IaanlzacE9lL9agrZY7xSS3nLea6eLVaFbsFj/z5Psp+tAMQgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OJDEdqAv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S6LGcQiF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418EmvPQ025918;
	Thu, 8 Feb 2024 17:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=IRQ39RRWIS/akoMFG0XACTS6mvzuCAgn3i9Z0QC0/nU=;
 b=OJDEdqAvfWRC6KUalPu2X2qElz2+v4cZa6pkt5CogdloWzy1l6MO6oG8pn6dn1Ym9W3/
 R+vZGQJ+3vvx0Xt50DYgLZE0ie+0ZTgLV//UXCB6saYpSI2et7/J/5X/Q5qwIkBIzXQy
 UPUUh3gHPD0ub3DKVXvL3ur2OasNlnpb8viICmZ0eycQ8Im4m3V4qbZdluj1SG6dSxz1
 T4gpmhV+v/UStXtVpOpsoz8UMkR3+CNpWy8A2/b0+2A0VIYBC78X8sBHHNbJe2AVymVb
 HII2qpIiktIQ2wu20/Xz0okc9O/d4XKgNPAzGzdC7I6g4sZaUk3p/UqlfZLatO+o5yIk AQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3unaxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 17:03:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418G6qZq036744;
	Thu, 8 Feb 2024 17:03:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxayae2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 17:03:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=netJmF9axyQnBx+L+jjKcFnESXymQ5+2Av2UqyjvD5HfHL4eQDmVIZDRoQgbX3SgCMh6Anyognpyv2/hPwdFDqEk1PcIvbvW3ZdoKw4v9yiv0zydl+PxHV8e6AXeE5M8QeKdnLYfxX9T4Fb29J3TjL4Y4NMUDNifL+aemnLPtxo+UpY0a+vjp5fMEUDLCuKydWO/ZGjdMTBvNiatrRx627Rut88Flg6Z8gh5Rb09Q0Kuo3Ge0gghLJBO5jfhpW5t6aHZ2835DVAOEgckTU53EoQXZXwzdbvvouNDzjALZrHPFeaZ3cRjoanWKzdnKktI1Kzq1eTAj0JHK2vwA79I4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRQ39RRWIS/akoMFG0XACTS6mvzuCAgn3i9Z0QC0/nU=;
 b=GW0EFEM/WiUTuUbTGtqcv9i6d5O6fAltDGEqLPduu+fm3LUhwLazZqEp4MqaSF6HdNnd72IMBxSuKDt20xXBpm7L+ld0qu27N09lflXg5BzulcRhaeBgTxI2BbhOLvYuSZkdgKEHUqFGmW8pD5aLu8A0CtIwBob3kAUcHe7MLjB1MXkNFx5Mjkif4MHM9pbPNs/iGtHFo3AZfeuSGcu5UFL0tS9ho5PjE/8YC5SlfLnWJuW+j5cT1MAU6oy/rHaDmnGO8zV9KftE4RMBG98nGiRxBJs9DHVBDGC6DHREHI1vc5dn0hljS/soiAiZw1KqBQDOBJqPMjH2/lMVHKk90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRQ39RRWIS/akoMFG0XACTS6mvzuCAgn3i9Z0QC0/nU=;
 b=S6LGcQiFMa4vyBPFUIpa2T4ZVUgomzJAJunvqZux5gILA+7icgFU1ZhMJPLmzfS9qwDmgbWc6xQ9cS64FDMDsygxQ/j6trr8h8WUdRaZUDWGZtcPGCISkYi3lv5G8dHSt8MIAUpMHD4MzCmI+vRgwd0/fElJ4FZaI+lfrKz/pBM=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 17:03:05 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb%5]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 17:03:05 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Santosh Shilimkar
	<santosh.shilimkar@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/1] net:rds: Fix possible deadlock in rds_message_put
Thread-Topic: [PATCH v3 1/1] net:rds: Fix possible deadlock in rds_message_put
Thread-Index: AQHaWh7UVk0OhRuwTEKrTTH7B2lnKrEADwsAgACeEoA=
Date: Thu, 8 Feb 2024 17:03:05 +0000
Message-ID: <e49be1a312a449d435af3bfef42493ca9b984869.camel@oracle.com>
References: <20240207233856.161916-1-allison.henderson@oracle.com>
	 <c2ff1709-2e4a-4844-af86-216ae678be0b@linux.dev>
In-Reply-To: <c2ff1709-2e4a-4844-af86-216ae678be0b@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CO1PR10MB4450:EE_
x-ms-office365-filtering-correlation-id: 6de5db39-a850-475d-ffb9-08dc28c7d128
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 n1GKOfY2pHYyVclbeuj3iHYKsTgyLXRjZ0LlFXhJCo7UrxS+3Juh1+KgxLlxIIoyn0dz/0XcgkJVDXychjiy1TcpUr5vGcQ8rdLHRiKAWCzIrnxHfHFqHvWV0tWVgLm/EySDFJQFRn+CMs9NyhraOI5lKSLyISULNGZEuUgUFGFAqvLNU1T6OdhzwmpxKBg5SYCRaq3pHzHiTEJByISLYyVx7QC3b0x+nDuEJKXNbqosU0E7bboVD0QRH9vaMyqnnjA9NV3IPj9Kr4WRFCvPQqQH7LoB1ld5/MXSHo6uHKCviWHdXTC599X+qLpAgph/BvTlxPh2uDRNDsLe4jFGhknEjlrXnNNyTm0zyJgYlMGCzw3x+5G3U9d3+8qnkgXDhgrMfQ+GHfeNQyw5n0IEoXSxRsUBVYDeTH8YXmjafEBbkkJjoH+fW+sDid3PAmWd4UPBtYRDuy07jIFDN6T6tiBgu0zpwg5tVCHN3dXpqCqfZYTopoSE39hdf04v5N8Xp7rm2iLiBA1b7RdF+mhLV3a9Yt9LLxSTXezlwbTmocyYVvFHxiPzjyrqyno3ZbrUcF9it7/0TgFI1pkFT5xlqfh1OriWLH5loG/kaJ+wYpE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(4326008)(8676002)(41300700001)(2906002)(44832011)(8936002)(5660300002)(83380400001)(86362001)(38070700009)(36756003)(26005)(110136005)(64756008)(66946007)(66556008)(2616005)(66476007)(6506007)(71200400001)(76116006)(66446008)(38100700002)(122000001)(966005)(6486002)(54906003)(316002)(478600001)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TllaNkpzeVJva2RvRjJ4U3BWRHViY1FieDhtYzlBOEZzNlZRUXdyZWovanh0?=
 =?utf-8?B?VXBHclNabkxwSXJxUStTeFZIRjhnajFHVWRyT1VRTDR3WXpPSVJDV0o2YjRT?=
 =?utf-8?B?di9meXp6NU5UQzN5eUpKdGhMTkZRUXl1bkZNMVlrTDVGemprczNndDQwM0Fk?=
 =?utf-8?B?MFFWQVQwZ0MwSjhsRG9SUTBHVVgya0F1emlCN2ZWQURqbE55VzBiaXBOTGU5?=
 =?utf-8?B?WFVYSUhVQTlsVmlpM1JPblVVMUkrNVUyZW9VbEgraHhOdnUramdQbSt0azN6?=
 =?utf-8?B?MXFxWXZpbFRVS3lpQUtvSmJPckt5UzZEZzR6UUhDZGUrK2krS3d3K3FiWGFu?=
 =?utf-8?B?SDU0WkFwL1BzY2pOK1VobGlRYVhWZHoxTnZKMVdPa2lGUjdJZWdxL2VhR1NQ?=
 =?utf-8?B?cGlhV1FFVnpqVkJBYUJqVmRYYXJ4bkFkWlNzRlNHTkMwbHp6ZGNXdkxzMzk1?=
 =?utf-8?B?eVBoUTNLMEtINHZJdG45aXcxMlJ6cXdNSTh3SjZoNWJZcVRUc0FzSEF1V0NS?=
 =?utf-8?B?U3ZNTjdVdXluZUI1UzM5OWUzMExRR3MzWjMrNVVXbjNEaDF3MmtUWkMydHJx?=
 =?utf-8?B?UWd2bTNhMHJsckhicEJGUC9rNU1Za1g3emI2Z0EvWG1pbE1VYXVFNFJIaURG?=
 =?utf-8?B?WEJLNDRLUlFDWHBJU1BMOTMvakZmOXA3VW9xd0tOV2ZqcEx0MEtFNEhPdVFt?=
 =?utf-8?B?cXoweEVsQlhXWHczRURVdEovQ1o2OE91d1JqZlk5OXlPVk9vNzA0OGxPdGFt?=
 =?utf-8?B?RU8yTXhNazVqeXQ3SHo1NjREWTgzS0VGN2JQVUo1aWl1SnpKelovbUIxSzJ3?=
 =?utf-8?B?ZHRmci90ZmdUQVBhWmZzajRVcXltNmtOS3BWV3RGekxyVm4zVWVTdzYwWXQv?=
 =?utf-8?B?bGF3eUpFbkEwWG1ZeDJ5dUUvaWRUZEswTXlXR2gvQ2hZaXg2REEyS2dXdE5m?=
 =?utf-8?B?UWt6eGY1MW1raGVxQ0lxQVp2UTZqaWdBL0pmU2hGalFRQ1YrSlJGUGxQU2ha?=
 =?utf-8?B?eVZFZXFkb3p0c1ZnYzNBaTd5cjJkYVJ5VDFyaUgzdExieVVxK2pxY3h1SmVB?=
 =?utf-8?B?NTZaNFFTbVdFY3grYVhZMzdITG5yRHJXMnpyYVBzOUpQd0t6bldVekFJTEp3?=
 =?utf-8?B?VCtJMXgvcWZhS2x0TUU2OG94a0hTUmtJWWhta3ExRWM1eE15S09NZ1V0Nldq?=
 =?utf-8?B?Z2NHZndWY3NHSFpDYVhvTVR3VzhrUnNuWTVUeVRIV0ZuRHdrbDRyNVhpaGpD?=
 =?utf-8?B?U29LQ2cxVDl1WW9GRGM2d0VRT3Y1d3VRMUxmMUs3anlTcTdNZmdxaE1wemti?=
 =?utf-8?B?TVphR0diQnF5cFlMVlJjWXJZNXVJTCtBZlo2UEtjNVdFdHVkbUlYTy96STNl?=
 =?utf-8?B?dHlBVTJPS2RXWU4xRlk5RjZHVkl2OHFERXFxN09PYVlrOG5VUHZmUGt4NEFK?=
 =?utf-8?B?S080V05yMzN1UDRGTHdheExSU0R5NUFBcDVIR2ZwOU52YlBXWWtjV0ZGdW13?=
 =?utf-8?B?SWUyT05vRGVSSm9STTl6WHgxRmFXU0VFNTJOTnlIbTJMOHU5ekxHWFk0cXNN?=
 =?utf-8?B?TVkyWm9xTnFqNnErQmZSY2Z3amNWOVZ1aVpubGxweVFVeTF3cFZCS1I4azJ0?=
 =?utf-8?B?czEvV1d4NDdWOHh6V1J0QU1VQUNETVNYZVB1enEzTHZRMnlBcEZJdzB6SExM?=
 =?utf-8?B?WStsUXNKN1paMkpNejMzdmFNcnArdTRzWmpaVUJQb3d5TUZ6bUlObWxoOEFu?=
 =?utf-8?B?bnZicVVmcmIxd0pUMVVXYkdseFF2cnovQUI0dWdXeUxDY211VjNWalpSSzZp?=
 =?utf-8?B?dTAvYnNUVkxnN2RyVS9hSlNMZEIyVXhBdWxGcU9XWW9MUXY0anV1Z09OTDF3?=
 =?utf-8?B?WmhieWdKRkw3Z3ZsT3JCQ1NCTzgvczYxM0NabTZZV29kZVFrOWpyTkx1cStk?=
 =?utf-8?B?bTEzOW8zZUVlSVFFYURNWWJLcGpOY3B2Y0hNVXJHa3VreGN0Q2NzVDlpT2hG?=
 =?utf-8?B?VTJXTWVxL2N1NitvMlZ6bVBsTnNoTk5nVGt0aDE0aTVrbzUzaWtKT01zTDVn?=
 =?utf-8?B?WGtoN0tKZEZoQ1A4a2xSUUVBdXZjYkpkTlMvVmJjZHpKeUpvNy8wZkl6ZDVM?=
 =?utf-8?B?Rm9XZk96cDZ1V0k2V3NTSjdoLzF2U0RML3ZvaGlwM3FQUERUUVJoNDVUNCtL?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F76D7663ED4E9418FC088DCAD6DCAC7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7lTFwoOPLo1ZegMhhcmIqimkFZdGYmodq1TsZRYCTJw0evZlOXJKuAShp3Dzdj2bzz4bgzjiofGo97IqTr3FhiKH4xewSg61Z5lgmz2xhckh8Kv1uJxVNkTF/DoaZ+FcEVrCsgBX5D24u583DHghTyOYZo5ud8UeWuphdtHgJpETsIB3Ya69cSYt84vCQzh3th0QRLKsWyZxDxBsGbv4+bANUIzr+3aoGyDGj6iwt1wJNEQHnMBUZY8eDwsjpsCodLGHt7BifDa+8FO1oABgkxQpRKinOIdlg6mgxGqXHsotHyLXdTvsGWvi1k9EoXEsq2aAxOnx7JzGKPrdTe7z0tfeGndgyDAIa8nDmtgkobX3qyQ8JYsHuAJT2CXRONmyJAM0JPY1NvzcojToT7K1hv8HQSSfdhLihNfrSTQxuRtgzi8HWnHiJ0KjjQe9+qrYjB1Jw/8E66zfgKlGLbxuf9x7gZMFXFluc1HweFSASrnR1DIuBsFRsgtZ9RgsCW23Pigh1bV4ZfagAPzTIRfcC5nfuCAT54NvDqjIYOJSay88aSaBCv0nzk5sSktlGzHjtOhYslscRRCJEvG70Ly77PK0tyOzkDiBQBwYJE11We4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de5db39-a850-475d-ffb9-08dc28c7d128
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 17:03:05.2247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rnj+RrRjk1YOyEM/zyxJ66/UofoEtyr0YqBVUzhxSDWydIKdC2cNtNiPwVY8n/lJlzm8TX4GV7wRWkLQywmtBEgejFpNas84by6CDQ0XRNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080090
X-Proofpoint-ORIG-GUID: 5H0tY8_ApNYqF0mQWikKwBUKunP86-MI
X-Proofpoint-GUID: 5H0tY8_ApNYqF0mQWikKwBUKunP86-MI

T24gVGh1LCAyMDI0LTAyLTA4IGF0IDE1OjM3ICswODAwLCBaaHUgWWFuanVuIHdyb3RlOgo+IOWc
qCAyMDI0LzIvOCA3OjM4LCBhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29twqDlhpnpgZM6Cj4g
PiBGcm9tOiBBbGxpc29uIEhlbmRlcnNvbiA8YWxsaXNvbi5oZW5kZXJzb25Ab3JhY2xlLmNvbT4K
PiA+IAo+ID4gRnVuY3Rpb25zIHJkc19zdGlsbF9xdWV1ZWQgYW5kIHJkc19jbGVhcl9yZWN2X3F1
ZXVlIGxvY2sgYSBnaXZlbgo+ID4gc29ja2V0Cj4gPiBpbiBvcmRlciB0byBzYWZlbHkgaXRlcmF0
ZSBvdmVyIHRoZSBpbmNvbWluZyByZHMgbWVzc2FnZXMuIEhvd2V2ZXIKPiA+IGNhbGxpbmcgcmRz
X2luY19wdXQgd2hpbGUgdW5kZXIgdGhpcyBsb2NrIGNyZWF0ZXMgYSBwb3RlbnRpYWwKPiA+IGRl
YWRsb2NrLgo+ID4gcmRzX2luY19wdXQgbWF5IGV2ZW50dWFsbHkgY2FsbCByZHNfbWVzc2FnZV9w
dXJnZSwgd2hpY2ggd2lsbCBsb2NrCj4gPiBtX3JzX2xvY2suIFRoaXMgaXMgdGhlIGluY29ycmVj
dCBsb2NraW5nIG9yZGVyIHNpbmNlIG1fcnNfbG9jayBpcwo+ID4gbWVhbnQgdG8gYmUgbG9ja2Vk
IGJlZm9yZSB0aGUgc29ja2V0LiBUbyBmaXggdGhpcywgd2UgbW92ZSB0aGUKPiA+IG1lc3NhZ2UK
PiA+IGl0ZW0gdG8gYSBsb2NhbCBsaXN0IG9yIHZhcmlhYmxlIHRoYXQgd29udCBuZWVkIHJzX3Jl
Y3ZfbG9jawo+ID4gcHJvdGVjdGlvbi4KPiA+IFRoZW4gd2UgY2FuIHNhZmVseSBjYWxsIHJkc19p
bmNfcHV0IG9uIGFueSBpdGVtIHN0b3JlZCBsb2NhbGx5Cj4gPiBhZnRlcgo+ID4gcnNfcmVjdl9s
b2NrIGlzIHJlbGVhc2VkLgo+ID4gCj4gPiBGaXhlczogYmRiZTZmYmM2YTJmIChSRFM6IHJlY3Yu
YykKPiAKPiBBIHRyaXZpYWwgcHJvYmxlbSwKPiBCYXNlZCBvbiB0aGUgZmlsZSAKPiBodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvRG9jdW1lbnRh
dGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3RfXzshIUFDV1Y1TjlNMlJWOTloUSFN
aUVlUzZKN1g5MkxEOGhoRjVqSGw4ODJBOHZKdERFWGZ4UGRCRzNjbUU3UWhzaWMtLWNTUUtnRWJQ
REYxVy1pX1pYZE02NG41Y29GcGMxeEVJT1pXbUZob3ViTiQKPiDCoCwKPiBGaXhlcyB0YWcgc2hv
dWxkIGJlIHRoZSBmb2xsb3dpbmc/Cj4gCj4gRml4ZXM6IGJkYmU2ZmJjNmEyZiAoIlJEUzogcmVj
di5jIikKCkFoLCBJIGhhZCBtaXNzZWQgdGhlIHF1b3RhdGlvbnMuICBXaWxsIHVwZGF0ZS4gIFRo
YW5rcyBmb3IgdGhlIHJldmlldyEKCkFsbGlzb24KCj4gCj4gVGhhbmtzLAo+IFpodSBZYW5qdW4K
PiAKPiA+IFJlcG9ydGVkLWJ5OiBzeXpib3QrZjlkYjZmZjI3YjliZmRjZmVjYTBAc3l6a2FsbGVy
LmFwcHNwb3RtYWlsLmNvbQo+ID4gUmVwb3J0ZWQtYnk6IHN5emJvdCtkY2Q3M2ZmOTI5MWU2ZDM0
YjNhYkBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEFs
bGlzb24gSGVuZGVyc29uIDxhbGxpc29uLmhlbmRlcnNvbkBvcmFjbGUuY29tPgo+ID4gLS0tCj4g
PiDCoCBuZXQvcmRzL3JlY3YuYyB8IDEzICsrKysrKysrKysrLS0KPiA+IMKgIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0
IGEvbmV0L3Jkcy9yZWN2LmMgYi9uZXQvcmRzL3JlY3YuYwo+ID4gaW5kZXggYzcxYjkyMzc2NGZk
Li41NjI3ZjgwMDEzZjggMTAwNjQ0Cj4gPiAtLS0gYS9uZXQvcmRzL3JlY3YuYwo+ID4gKysrIGIv
bmV0L3Jkcy9yZWN2LmMKPiA+IEBAIC00MjUsNiArNDI1LDcgQEAgc3RhdGljIGludCByZHNfc3Rp
bGxfcXVldWVkKHN0cnVjdCByZHNfc29jawo+ID4gKnJzLCBzdHJ1Y3QgcmRzX2luY29taW5nICpp
bmMsCj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHNvY2sgKnNrID0gcmRzX3JzX3RvX3NrKHJz
KTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBpbnQgcmV0ID0gMDsKPiA+IMKgwqDCoMKgwqDCoMKgwqB1
bnNpZ25lZCBsb25nIGZsYWdzOwo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHJkc19pbmNvbWlu
ZyAqdG9fZHJvcCA9IE5VTEw7Cj4gPiDCoCAKPiA+IMKgwqDCoMKgwqDCoMKgwqB3cml0ZV9sb2Nr
X2lycXNhdmUoJnJzLT5yc19yZWN2X2xvY2ssIGZsYWdzKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBp
ZiAoIWxpc3RfZW1wdHkoJmluYy0+aV9pdGVtKSkgewo+ID4gQEAgLTQzNSwxMSArNDM2LDE0IEBA
IHN0YXRpYyBpbnQgcmRzX3N0aWxsX3F1ZXVlZChzdHJ1Y3QgcmRzX3NvY2sKPiA+ICpycywgc3Ry
dWN0IHJkc19pbmNvbWluZyAqaW5jLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC1iZTMyX3RvX2NwdShpbmMtCj4gPiA+aV9oZHIuaF9sZW4pLAo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluYy0+aV9oZHIuaF9kcG9ydCk7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsaXN0X2RlbF9pbml0KCZpbmMt
PmlfaXRlbSk7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJkc19pbmNfcHV0KGluYyk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHRvX2Ryb3AgPSBpbmM7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoH0KPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiDCoMKgwqDCoMKgwqDCoMKgd3Jp
dGVfdW5sb2NrX2lycXJlc3RvcmUoJnJzLT5yc19yZWN2X2xvY2ssIGZsYWdzKTsKPiA+IMKgIAo+
ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHRvX2Ryb3ApCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmRzX2luY19wdXQodG9fZHJvcCk7Cj4gPiArCj4gPiDCoMKgwqDCoMKgwqDCoMKg
cmRzZGVidWcoImluYyAlcCBycyAlcCBzdGlsbCAlZCBkcm9wcGVkICVkXG4iLCBpbmMsIHJzLAo+
ID4gcmV0LCBkcm9wKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmV0Owo+ID4gwqAgfQo+
ID4gQEAgLTc1OCwxNiArNzYyLDIxIEBAIHZvaWQgcmRzX2NsZWFyX3JlY3ZfcXVldWUoc3RydWN0
IHJkc19zb2NrCj4gPiAqcnMpCj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHNvY2sgKnNrID0g
cmRzX3JzX3RvX3NrKHJzKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcmRzX2luY29taW5n
ICppbmMsICp0bXA7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBmbGFnczsKPiA+
ICvCoMKgwqDCoMKgwqDCoExJU1RfSEVBRCh0b19kcm9wKTsKPiA+IMKgIAo+ID4gwqDCoMKgwqDC
oMKgwqDCoHdyaXRlX2xvY2tfaXJxc2F2ZSgmcnMtPnJzX3JlY3ZfbG9jaywgZmxhZ3MpOwo+ID4g
wqDCoMKgwqDCoMKgwqDCoGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShpbmMsIHRtcCwgJnJzLT5y
c19yZWN2X3F1ZXVlLAo+ID4gaV9pdGVtKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJkc19yZWN2X3JjdmJ1Zl9kZWx0YShycywgc2ssIGluYy0+aV9jb25uLT5jX2xjb25n
LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLWJlMzJfdG9fY3B1KGluYy0KPiA+ID5pX2hkci5oX2xl
biksCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbmMtPmlfaGRyLmhfZHBvcnQpOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxpc3RfbW92ZSgmaW5jLT5pX2l0ZW0sICZ0b19kcm9w
KTsKPiA+ICvCoMKgwqDCoMKgwqDCoH0KPiA+ICvCoMKgwqDCoMKgwqDCoHdyaXRlX3VubG9ja19p
cnFyZXN0b3JlKCZycy0+cnNfcmVjdl9sb2NrLCBmbGFncyk7Cj4gPiArCj4gPiArwqDCoMKgwqDC
oMKgwqBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoaW5jLCB0bXAsICZ0b19kcm9wLCBpX2l0ZW0p
IHsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGlzdF9kZWxfaW5pdCgmaW5j
LT5pX2l0ZW0pOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZHNfaW5jX3B1
dChpbmMpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoH0KPiA+IC3CoMKgwqDCoMKgwqDCoHdyaXRlX3Vu
bG9ja19pcnFyZXN0b3JlKCZycy0+cnNfcmVjdl9sb2NrLCBmbGFncyk7Cj4gPiDCoCB9Cj4gPiDC
oCAKPiA+IMKgIC8qCj4gCgo=

