Return-Path: <linux-rdma+bounces-961-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82B784D2BC
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 21:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB102864F2
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 20:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6634D126F29;
	Wed,  7 Feb 2024 20:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fs2o6ORJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YybG0GyG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42085947;
	Wed,  7 Feb 2024 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337059; cv=fail; b=E0tIKsKY5HwC5sN07GHOqfXay933wgegik2JR0oFn+oWOl3CauIB7AeYR44Pwj5H0BIyFGR6j40tK55VkT/gHH24sj/HzHK2Qcv5DF0GuVXhpye5mqLkOM2mwJMmy97dyuaEcvtbenN2CWaAe3uRnz63DcDySyvwxraBQyI6mu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337059; c=relaxed/simple;
	bh=4aKDGfoHe/MWHJXWxhBNP/qzrxUheR2z1A4i2sRhE+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qq52zyeuiHAZ/3PnShJg35Kgald5kH281Je57NfE2q4gyJykedqkm6pHsvkfj/BEVwdwDqbndh+lFGHLBoU5NDs1r74zlIiWrsXEAliWGzPzxQ4l1LzwcqOCVqrjMv9d+l8bCbBA+722Cm7BY1bjLwp8O2b6hhrSCBK39P3p5xE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fs2o6ORJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YybG0GyG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417IJ307016657;
	Wed, 7 Feb 2024 20:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=4aKDGfoHe/MWHJXWxhBNP/qzrxUheR2z1A4i2sRhE+A=;
 b=Fs2o6ORJW9+v2Hzu6nMUo5L7wCjx+dvSOWBuMZLat65cTlGUFEzmazAHdup8qOA32aSq
 8pvrdebgnr4ZOux3bdTuLtDE7Ct7B3895iNkv8RkbaFhuXAU1pImygX+6s18P/X9TtMh
 vXzeh+KSN/XAYJmGNop/JwppTj6ztjG55Nl133mgrWjljAk82mbZ1E14Ub6imFvZWmj6
 SHfFLqfjBqUmxobkCcMsWasEqjt7PxgOsOuRMFDw/rjjIWgc4yv3LOvZmrPCmalF9miQ
 Qks52ferEjEjROn6dRRm9S3qAp15sivk/pSJVfLK1yUmlILQB/C7zx+sN/FZ36GIFe8a Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c942xub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 20:17:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417Jx560038332;
	Wed, 7 Feb 2024 20:17:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx9k0an-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 20:17:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvZ3q5U7HCVwOItwDS6N/QZIRW1D9Fitlu7MRcZetnvc2jaCmzznDvUr1OVg43ZjApjI/VCxJFqfPbbXKdMQtRIou3vpWnt+KeTJuxYeU9LqN6ImYvcHTNBpUImKTLMJhD+7hMQqD0DWmaP36fFXmm0550lvK4+BkO8xSiL+COJF/lYCTaztxuazwx9RPys6TpTvlUYHIbzuQIbJdpxtb2HR43UEbI0E5HRvW7UzUJoPpKAsMR9ekDRenjOYT6MH95jy90owKeCah1/OmlZMy6TIEEY4B70jirBvBVQvxO1MfYUDyCV79sSDX39dUaqXXcWl2rW6dNwBY3ycTGC/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aKDGfoHe/MWHJXWxhBNP/qzrxUheR2z1A4i2sRhE+A=;
 b=HDW5a9Dk3YaAPSEuphL21eWrxWvnvH1XQ1nmSIzzrpi7Sd2Zd9NZGCGxFBM/0Ng5jAkmf0y0HPXIzBLtSh6O2exn3aosIxJPZTeAnOfTNVbkZ1S2FNh3Xnb3y0SZBtH6uMHledaLMLWADn35x1JqSeeS149mq81cs0L5btgznI7FjZPXjvvclIE5+f9M2OIYJ1Xocfyd7DzWSOWSheSNx3fzTon4AajTIahm5+gvIt/CmISO5tOVJVLfXsLDivqv3DJk6h/UgRNu4xHOtZp9lZCOrC6xskQXUISeo6WMtHM2lfmyD5u1EoTvi2KJHHIqOjWzcbjzBIwnOtJ/rfp/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aKDGfoHe/MWHJXWxhBNP/qzrxUheR2z1A4i2sRhE+A=;
 b=YybG0GyGIkw/k8VgxXyoonHf5Nd2zCmu9+Ue/p6Ln0CSSMHyW/Zamg1RC8mQwSSTYtHOS6F1WGakXQ30km1qJeU4aNAyP+KxdEIeTq/jd/TMeSEKDNL+gEiMTfrPwFaHZiNIUCP736FcispjSiF15syzWKH39T1wQCz1ZcDDjaE=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by IA1PR10MB7472.namprd10.prod.outlook.com (2603:10b6:208:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 20:17:25 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::68a8:709b:34ed:2aeb%5]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 20:17:25 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH v2 1/1] net:rds: Fix possible deadlock in rds_message_put
Thread-Topic: [PATCH v2 1/1] net:rds: Fix possible deadlock in rds_message_put
Thread-Index: AQHaVG6LDphLu37HU02eZhIVlnxlVbD+N02AgAD0rYCAAAnhAIAAJpoA
Date: Wed, 7 Feb 2024 20:17:25 +0000
Message-ID: <8b309e69474dd3cd208b025c466e6e177a0c652e.camel@oracle.com>
References: <20240131175417.19715-1-allison.henderson@oracle.com>
	 <20240206184809.1a245236@kernel.org>
	 <6c63549d6771bfb1ab410338b2dcea3e3fedb415.camel@oracle.com>
	 <20240207095914.49ba5293@kernel.org>
In-Reply-To: <20240207095914.49ba5293@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|IA1PR10MB7472:EE_
x-ms-office365-filtering-correlation-id: 53eae0f7-51e1-4d15-b52e-08dc2819cc9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OTsC7eKRp3BXcQBbtpDE1YWv8Fw8mhQW5ezb1lZkTddamhmRTi+K7tskYEYAkTVacibqUFHpa6TurizJ+cjsZdQ1C/X0gL2dSDmjx6Dp6qGSOD5yFUeWCXSM7uZB8m5lb4E0atxh1AotV60ynCAaOuO0u7Yk7ohV5QMFFQUCLhJVqUhqadzmBd2NReohqBuel/sR712ngDa2Qi2VAFmbNhaUnydSNAXXzKkrJxlxAhFF4ToOC8L9Q2P2qJ9wz+bpYl224Z3n7Zr0oyGrThqiui7T9GaVLann0XtV5EWZHOzMtOWcZd5NPMOAQ3Vg//M0zFgwHk0rVNLpipS5GJvQE+Ioe3wSlFbt2eKHYsci3l/BH7+PC95J1VfzNirol2E9C/wCP+iytrOfGFDhBbfvQfmOn1XgopbPs/rSiEYI/6wQbeZe6hlGpdjHuNZo6h+Ad2CZmynnBItd9dQw7MHQHnbjxwofHFVi+qrg1qujimlENrG4mckTlCe6/qxWlhczbqOsxLtQSXW3trFzAmsXPsv865PQ8tmZTNQlZieMQUQDM/7g8azfKJeoi4CrXBAlfasR865WOIpub7cFyf3M8oF68Op42+8pZI6W1DtckxPKTNqjh3vcUwcSvrosjUZO
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(44832011)(5660300002)(4744005)(2906002)(86362001)(41300700001)(66946007)(26005)(38100700002)(122000001)(2616005)(83380400001)(6506007)(66446008)(54906003)(6512007)(64756008)(8676002)(71200400001)(36756003)(66556008)(478600001)(6916009)(66476007)(76116006)(6486002)(8936002)(38070700009)(316002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?amgzenAzeWE4Q0RadkEveXV0L09hWmFDM0ViZzV0OFQ2QW9kWGVDdk9PUldQ?=
 =?utf-8?B?bVNIOWxSZkhyRi9ka3lpTTNLNCtkbFNTU0piOU5hZ2I2L042QWpCQ0hlU1Y1?=
 =?utf-8?B?U25Ucm5sK2tqSXd6Rm1vZGk1RmxYRkIzMmJIZlI5STZlNVBrVUJLcGpLR2xS?=
 =?utf-8?B?REtER0hoeTREc21mVUZ6ZURKQTJ4SW9maDBSdThHdTN0cWJyWU9vcFlKSU0y?=
 =?utf-8?B?Z0ZEN2VzUnl0MGV1ZnhpRURoOHY1VklOV3pEQkthS2VTNmN2QXBBc21pR0Jv?=
 =?utf-8?B?QVBQOHI0N2FQQy9saXNONWE2eUE4SWN5SE5Qb3VlTDR2NlI3Rkd5ck1RRFhR?=
 =?utf-8?B?VTNyTllEcE54aFVYblBlbXZuSHd4Qk9RU1REZXU1L3o1bkpteEV6SjdBNGhZ?=
 =?utf-8?B?d2dHVXFLOGM0QmR1MGQ2N2FQZFBOKzlBSnFyK0hJK3VUejdDbGlBUWoyQnB0?=
 =?utf-8?B?c2wvRGFQbHFHMmoyMWtVd2U2M0x2NTc5TmVUUUpPa1Zyd2FGYjAvcDhjZHR3?=
 =?utf-8?B?QzFVZzFnczlUeGJkQ1M1d0VkQUVBL3F1Rnk4bzBRRUEvVmtPbkQ4RnJONzJS?=
 =?utf-8?B?RDErV1I0bWwwVmFHSHFBelpCT3Bhd3hlNG5mbkoxTHZ3U1pDQmkzeDFIZFli?=
 =?utf-8?B?YkorMzBSeGVJNTVmNzIzWldHNVdmQVd3V1BFOGsva1ZRc2xNdE0waitZV0lP?=
 =?utf-8?B?Sno3dGRlS2NydkR2VWdadlZYdGdVZ3FCNGFYNldpaGM1ckcwb251N3VUbzh2?=
 =?utf-8?B?NlI5Szk0TUVMY044d0ZXcVo3d1BZME9YZXpYeDVsNHZRTytpeWRMMUlveFNq?=
 =?utf-8?B?K3VacDBpRlVwSEZtSmFmNjk1TW4yQXNLbE9HT0hPN3VWZWl2TzVFbGNkQTBq?=
 =?utf-8?B?SlF1SzY5dFQ4NGNmQklwQU5sbDc4VThtSjJjNk5LUzkxUXVSWDdwVlFkSXJD?=
 =?utf-8?B?NVVtaDFiM3p5Q1VSRzJ0cEwrNEdNWVRhaU9UcDE1VXYxVnM3WWxBS0lwRFlV?=
 =?utf-8?B?RXR6RzVuaW5GcGR3Q0tMRmxudkkyd3hsdmZtcnFPc011R1IvVGpYTUZhZUZK?=
 =?utf-8?B?a1gvWktVaFZFTit1WmsvdTg1QXpCdW5uZStCczlTNGxFd0YzTFRXdWthYW82?=
 =?utf-8?B?YzhON0hsN1dpV2pDcVJkMkl4T0gxelM2SktDZTNqUWtIcU9LV2tIdEdJRnp3?=
 =?utf-8?B?NDdZUUVyZ0NBa2t1L0R5TlFjRnhINVA2WVpvTmQyVkdLc2grZ2hYTHJZL2pZ?=
 =?utf-8?B?dkE5V0p4emlSNUFGekk5NUJCcFVPUTBSVkM1S1JMaWxpSWhkNUdrbENWdkMr?=
 =?utf-8?B?VFVWaFg5MlptdEVRZW85V3JLd3gwbzhkdGoxZ2sveUlNUytmK1c1bFZnaVpi?=
 =?utf-8?B?QmRSY2NubG9xMzNIQXludDk4UU84c0VWOUtwNDdWZzlrN09CeFlJTWoySDMy?=
 =?utf-8?B?S0xiUWFGdHdheDh3SDZZbFd0UVdJVktJakMraDRGU1ZJS3U2eDRodG14aTFR?=
 =?utf-8?B?TUY1dHVOcHhRWHRnUHovNXBHN2FZMGtKT0EwS2F4Y3VkTzFnRGo1YmhCTVhl?=
 =?utf-8?B?Y1hUQlc4WUtBNm1hemFSY2QwUDA1dGxKb2gzQmJPaG1Ga0pXYzkxM010akNC?=
 =?utf-8?B?Z3JtZGtyNTBqVE9ISjg5SjNyc2NReUV6ZWZWaWVjcUp3cytHQzhpVWx2U1BH?=
 =?utf-8?B?b1VQVzYwUGNhN1JXZ0tuTnpocStFOUlwTDJlanppRWhkZW9wTXBVTnlKSUla?=
 =?utf-8?B?ZDVBVk1yd3M4bTNUbjliVWswZ3ZIWEEzM2c4cmRRWi9EU09MOWhPMW5RdVI5?=
 =?utf-8?B?LzZsQ2RlUWN3b1JrMUxFeCtCMW5kZjd0dCtLRGtVRTFIQnVpREJDSTg3ZXBK?=
 =?utf-8?B?ck0rUm9ZTkpUMW9ubDdMamVST1BHWVR3cmNmVkxXdStqN2I5M29odDAwOXIz?=
 =?utf-8?B?TWthN2FEUHAwZUY5M1ErS256dGVsanorZExNWXpUR3hFNHAvd1p3eUxPVUxt?=
 =?utf-8?B?VWg3TEFMcDB1aEYrODJCck4vSTkrYmhPcE5OdnduNmpOVmhneUlvYWZUWmZ5?=
 =?utf-8?B?YnYycjlwV2Mxd3VwSmh6T2ZRUnE3REhpMHY2YTRoSnlzeHBxZDZXUVkyZ2Yx?=
 =?utf-8?B?UGpmZ0I5R3dDeFd5UVp4Z3NtMFRRVG5rVHhMZzV2QktwQW95WXdXYktJZ3JS?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <332BFA6DB3801845B75F7AB928E6E9F8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YR2F7Tr0/BlZPSojfZgbhXhes80E/ejKVv4W+t+ro5TmvXnP5/CCYEJGr/VJjgi8vVRkmdiS5T75UOp+APkOajkIjxKlGrj662yyD/cAaJiDd9FNJE4ULLjEH0+LUb050hrH6P3D8eOL69hFjSgdeyjuOlGuyoGRz8hfN0EtFglksGzNALI3yJugKfM7+i5F1bdC3g/u9kr4sva7k2Sy5y9i2Sf6YyNqWixAeMCJK8gmMbqXcFansZjVG/IeHsxQ8C/zxyypA3l5dEwBk/WSMUBE33oXEU3fOBmSn+/k+G1qoAcUWMkwE8zspv49kyREgkbRirLxBayKUqbvxaQXRMYP3Pe0PgTOShPFcTX6Jr9N2ElgECoZy9M2+5QKCFcgPx7AiXSzShXx+LyTaEn5vBHlSkE1WRBawOhfamvHdHJSgXa9ir8uZd+wagrZpXS7zkOXrutCdN9oD37ZjTnhf9wOYpLHja+RsV6ozEGdYxpDYxhcgbTu8VSb/kjdkzt8EkjrnSCzwlIlXWZ0zanzR4klemkJ0d2KZdz1hxpUZRZuzqFCBVHOVXe3ZNu8cTxVIXKILtnodGntYGCbyS/QHVWlN1zYuWK5EziSm9ZZ+FM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53eae0f7-51e1-4d15-b52e-08dc2819cc9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 20:17:25.1534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +N+hMCQRXaKFXdEB1vx+YfruD0/mrJ0YHnQUCAstoJgGrE/QSjmygoRROVMk+QyetSXyWdN10u5MHmu+Yr0YKDYS+mhh0eYvSWApxImiEGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7472
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=847 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070151
X-Proofpoint-ORIG-GUID: ZZhEm1QyGWY1KpjcuROSt65uepb-clqU
X-Proofpoint-GUID: ZZhEm1QyGWY1KpjcuROSt65uepb-clqU

T24gV2VkLCAyMDI0LTAyLTA3IGF0IDA5OjU5IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gV2VkLCA3IEZlYiAyMDI0IDE3OjIzOjUzICswMDAwIEFsbGlzb24gSGVuZGVyc29uIHdy
b3RlOg0KPiA+ID4gVGhpcyBpcyBub3QgYSBjb3JyZWN0IEZpeGVzIHRhZy4gUGxlYXNlIGxvb2sg
YXQgZ2l0IGhpc3RvcnnCoCANCj4gPiANCj4gPiBTb3JyeSwgdGhlIGZpeGVzIHRhZyBpZGVudGlm
aWVzIHRoZSBvZmZlbmRpbmcgY29tbWl0P8KgIEkgdGhpbmsgaXQncw0KPiA+IGFuDQo+ID4gZXhp
c3RpbmcgYnVnIHNpbmNlIHRoZSBjb2RlIHdhcyBpbnRyb2R1Y2VkLsKgIFdoaWNoIHdvdWxkIGJl
Og0KPiA+IA0KPiA+IEZpeGVzOiBiZGJlNmZiYzZhMmYgKFJEUzogcmVjdi5jKQ0KPiA+IA0KPiA+
IElmIHRoYXQncyBub3QgYSB1c2VmdWwgdGFnLCBJIGNhbiByZW1vdmUgaXQgdG9vLsKgIFRoZSBz
eXpib3QgYmlzZWN0DQo+ID4gcG9pbnRzIHRvIGEgdmlydGlvIGNvbW1pdCAxNjI4YzY4NzdmMzcs
IGJ1dCB0aGF0IGRvZXNuJ3QgbG9vaw0KPiA+IGNvcnJlY3QNCj4gPiB0byBtZS7CoCBMZXQgbWUg
a25vdyB3aGF0IHlvdSB3b3VsZCBwcmVmZXIuwqAgVGhhbmsgeW91IQ0KPiANCj4gVGhlIGluaXRp
YWwgY29tbWl0IGZvciB0aGUgY29kZSBiYXNlIGlzIHZlcnkgdXNlZnVsIHRvIGJhY2twb3J0ZXJz
IQ0KPiBJdCB0ZWxscyB0aGVtICJ5b3UgaGF2ZSB0byBiYWNrcG9ydCB0aGlzIGFsbCB0aGUgd2F5
IGRvd24iLg0KPiBMYWNrIG9mIGEgRml4ZXMgdGFnIHNheXMgIkkgZG9uJ3Qga25vdyB3aGVyZSB0
aGUgYnVnIHdhcyBhZGRlZCIuDQo+IA0KPiBGaXhlcyB0YWdzIGFyZSBtb3JlIGFib3V0IHRlbGxp
bmcgYmFja3BvcnRlcnMgaG93IGZhciB0byBiYWNrcG9ydA0KPiB0aGFuIGFib3V0IGJsYW1lLg0K
DQpBbHJpZ2h0eSB0aGVuLCBJIHdpbGwgdXBkYXRlIHRoZSBGaXhlcyB0YWcgd2l0aCB0aGUgbGlu
ZSBhYm92ZSBhbmQNCnJlc2VuZC4gIFRoYW5rIHlvdSBmb3IgdGhlIHJldmlld3MhDQoNCkFsbGlz
b24NCg==

