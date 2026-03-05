Return-Path: <linux-rdma+bounces-17525-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPmjKR+CqWkd9gAAu9opvQ
	(envelope-from <linux-rdma+bounces-17525-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 14:16:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B196421282E
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 14:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FE473006D77
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0365722578D;
	Thu,  5 Mar 2026 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bxPYiyFq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y75Tt72+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E17221D96;
	Thu,  5 Mar 2026 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716569; cv=fail; b=qh7pyD+BsgNljIOjZqxSynScxwELtI6+x4c5yrwqtbTiSnEaxQFOU0LkhU0OSyyfxZCB5vOsjiy0TM7iOjCYNFhrFRMbyanOKz7QfUyrCvnEQPO0BOe3J6aL1WdsA2zuJ5N/5USn0zgjwzIVe4+oqZWqTkzgXS7JA/u9c5Scq6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716569; c=relaxed/simple;
	bh=YYdTU6CWwZThCJON0+4lD+SThxeWuLz2LdmlYtFY580=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hszmaXpWVjCYml/p0fFQGjs7oyeu02qWRvIj4jU8nP49BmFR6LSMS/V/QfK6jD8liCd2vDatU546tsjx5+605AZoEN4/dWRtseVa7aY7+sH4uvxtIAAubzB76GHmDhTckpQRQK9KeiKuDiyS1v48fXqDZBjN2Yh2kPz1XOtd2Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bxPYiyFq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y75Tt72+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625D3rGB942148;
	Thu, 5 Mar 2026 13:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rOayBQlyCaCDgdyv528+fMlU4hMVDp+Icx/XueS3CPk=; b=
	bxPYiyFqMorAJiwEGHDMIfg1CB2F0z/zfMWXaPnwYXUNXKTe5xKR1dBw1BSQ1sG8
	Ld1oOzgWUAH0+vyiLkb8msl+0TMtjHAfWTEI/sFn+v/TJPV+iWRdF2PidhTWw5q2
	TCbU96jH42QVjeQLV8lMCgWSyrCh2m4/Z67AAAFwieklL0MOPQIuqPI1nD1ohGAt
	mDf/oFUDLEkqcoS94sDOt5EUbuHN2vgMqp26+OTPNxefysf4IIg463nKxL6McI1I
	ISOZ4MyMEFK0c0C0M/g7Dv9kTCYaoxn3vGz2dbEzhRPU/hi+1iOKYdn0Qg/7D29i
	tup0gphz+KDh2cKMHW8IHA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqacc00eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 13:15:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 625DA6MY036944;
	Thu, 5 Mar 2026 13:15:50 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptcyy46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 13:15:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIjeGvgIPnntbWjGNkTPzhSTB/8OLZKnwJaBcWyotKZy6ZbxUpSGVczB5NfLSiAUGd2LfS6XqzkPS8x9xeYJkehn6ceZ0UG+QbUrcw/1mTwtxYMSIQKENPzYWeeL54L6nsD2OFX9O5Xgi7jpGoCse2Tf3CEG1laShDaPf3lM0TPC8jCEo8+nfojH6Q3VFnSLHPQBEOMrtq+t+bN4cnLU1Zl35i/IImXv9k1PIo2sKMVZeXxtITytkyLFOYSjTozruIBvdzqVssIv5MjuA/PgLaNBAGSKAqW4VaOGIAXemCHMtUZeROzzqpeBoKHwR2lJjZ3P9pYiLhu9NogA9so3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOayBQlyCaCDgdyv528+fMlU4hMVDp+Icx/XueS3CPk=;
 b=EAjqxMAV6oL3BnRl3WTdjCyvRf4VA+OI9fSCDJTUpblUMl5lo5GkkKN1OYCSwTkzdUPo7cvXuFxTTCcbq4hyI2SipHW/6wmPUpzYqsUEBDiaRpKyRG59N1sTcjIx/OubD2oW5MQjlz4l59qkbs5vubKor4SUF1sdz9XXfYXHC2dZK6LIVClvxp6+0FWmAHQHAKuQWDWIc7tK38mVOPiNeZsFEVROy4nKVdNfZoeYKnV/eahu+AXLnZpH/feWfK4t5CpaaYEFSMhAFYrGo6doQs+Po2HI5JUl8AIq+WN1ehWE3c10/rcEbxjt8HdAG32rpI9fJJ8Dn0Z/v/Rgj60x3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOayBQlyCaCDgdyv528+fMlU4hMVDp+Icx/XueS3CPk=;
 b=Y75Tt72+K/izsZqzoyRFNfiSC+9wVcl/DcSaz9Bqp3IriBdVWt98hLY6d4WitoN0RZwsMZ8zKmVl+xasEzzgQR+5s9EVgZ99tAaAeiJpTell70MwXLdOoN+/cF3iI9jghku+zZDF9vFBqR4OWDnp5BeLiuwINegJrYfR+w/rwI4=
Received: from CH3PR10MB7704.namprd10.prod.outlook.com (2603:10b6:610:1a9::8)
 by BN0PR10MB4920.namprd10.prod.outlook.com (2603:10b6:408:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 13:15:46 +0000
Received: from CH3PR10MB7704.namprd10.prod.outlook.com
 ([fe80::2a5a:b9d9:26b5:25e2]) by CH3PR10MB7704.namprd10.prod.outlook.com
 ([fe80::2a5a:b9d9:26b5:25e2%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 13:15:46 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: kernel test robot <lkp@intel.com>,
        "saeedm@nvidia.com"
	<saeedm@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "tariqt@nvidia.com"
	<tariqt@nvidia.com>,
        "mbloch@nvidia.com" <mbloch@nvidia.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        Rama
 Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        Anand Khoje <anand.a.khoje@oracle.com>
Subject: RE: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Thread-Topic: [PATCH] net/mlx5: poll mlx5 eq during irq migration
Thread-Index: AQHcq/Jc3KuDnivfpU60Ol++d2Bny7WfyywAgAAhLVA=
Date: Thu, 5 Mar 2026 13:15:46 +0000
Message-ID:
 <CH3PR10MB77041C5B106DE33FF83006728C7DA@CH3PR10MB7704.namprd10.prod.outlook.com>
References: <20260304161704.910564-1-praveen.kannoju@oracle.com>
 <202603051910.7oo8wCfc-lkp@intel.com>
In-Reply-To: <202603051910.7oo8wCfc-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-03-05T13:15:22.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7704:EE_|BN0PR10MB4920:EE_
x-ms-office365-filtering-correlation-id: 4d4e7c0e-d948-4207-1ad0-08de7ab95002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|13003099007|921020|38070700021|7053199007;
x-microsoft-antispam-message-info:
 r5UnSB5lgdO3b4A3wUBI/13EdemFpKh5ZQtVdAOpfgLftVcIr+Vi4Gfs4UgwM3nPrBBOdAcvFpqA41/CPs7Zss6tV4/2IqKjCwA+bp4d3g84l/6RHSzn3Y+a1iy3ne5aAkbwCehLxo8ucFqbH1H1tDODpkPfPnpwHXlDHYHowsGaLUUU7X3ENDetJq97haDv5rnwfTaASD2S31XH22vW0GOQeuoP4zkn49+2wKK1SYsqYvcwkz7jow7URAh9BpFhxiRahZz4GgutZBTSPVZ9Os7B6YRGASVU68t+vnBIGWHTVHu2rmRLXwx1AKc8ultMj9v2gN7as8JPoA49AM3o61HNfVatZb+Pxf+QXQtc4cZlNrkuMD8T8iUUyx8iaJPF9EkFYigqLKN3C1KDhk150K2iohAM4GZA+p6XFY2onEmBo6CzkG6x/sUmoMI5ZX/D5kXIIo8vKndKg5/+B79iqKCyBDRaAAHkiqKjpRMsezHfFLpMtF3qJnQ/PUQNvlDyLvkyOh/TccImH3E/U+5Xz6cs2uEqj9qllc6Yg0fs2s7W0Dy+nSt3aCGzCJsOaj8bPdHV7UVOSAPdHJp1doRhIWcE24bXVRD/rIfd4ripVzsfXkd4ln4OdbKF/jxmVP8b+fwZ7jiWDqOcRAH64dUuBOMtRtvH1kyUvH7fzVN83HtyqKmXn6nCRpKD+i/eWidjCgGO44v/EssT+DgNU4dKkz04HUUGyvMV6nP67EJUfCi41bfLXQY83/8jW5WBtpuG/C14OXUyD3CdfUTsYxyC7A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7704.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007)(921020)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?c2pYRFlzdFFZaTBSWWVRZmFpUk5tdkNlL1hvbzFOYmhvTTA0VUtFVlJ3Tk5R?=
 =?utf-7?B?M2ZXamZUVGZaY2w2eDNydnAvYTRvOWJYazdHZERnaEZWcjJPd3hnb0FadEg0?=
 =?utf-7?B?L2ZMS0tIVC9wSExSNWZVSVgwOG9vanVleURTaTBBWFEzYi9LbFk0dU5Qc200?=
 =?utf-7?B?dUdwS2VmckZIcHB5NW1PWFN0Ky04dVZyMmZYRjk0YkZ5VDA2UXAwUHdxejVz?=
 =?utf-7?B?emE4WnBqNldVV0kxdmMzcVNWMjY4c0hUWFI0aEcyKy1LdVVHNW5FNFJNS3ZE?=
 =?utf-7?B?WHFXSk9FZ3ZvVEFoUnVlRHZpMWR5NXRvbklITjZmNk8rLVhJTFA0aUZZaktW?=
 =?utf-7?B?b1loVnI1V1ZxQ0ZzT3BUNDFGZ21sMzE4OW5yMjlpYVpidlJiWDdOT1lpaXRm?=
 =?utf-7?B?OEpHN2RWNHl2ZE9JZGptU0VUZlFVaHdFUGc1dGxtcFlCZEE5a2k5RmxWeXl5?=
 =?utf-7?B?ZnFOUHd6SWVnSXh3cUhlVEdUM2ZudlFxdk1hZ3VGVmI5WmtMc2NkOFlQWm5z?=
 =?utf-7?B?cG5OSjg2Z2pzOXB5VWFla3dRckhyZnliWDRGMXg4V1c1c2kzYW5uZEYySkZH?=
 =?utf-7?B?UnRZeS9KWUJCS1Y1bFpwWmJiYXhqWExGV05SeWxWWjJ4OEltTnB0SjV0MWV0?=
 =?utf-7?B?aXJUbUZKODVpajMzUTBJcjBtY0VrTUVkVExIcmZhTVhOYkFjdmh3bENVMFdT?=
 =?utf-7?B?c20yWmxQcm9iV3Qvd0dCSnZqMUR3ZmlHZEJia0JiMlpjVFdhSGI4SDBMSnpW?=
 =?utf-7?B?MW5Ud1E1LzlCNVZ1SjFmMnhJTHl6am0vd1V5dFZybFpsZEp4UkFYbS9IMTBV?=
 =?utf-7?B?UkZiREhjTFlJRTdveWk2VGpvTnRYM1VRMW9UcystbHVoYXVKc3dYN0tsdW5L?=
 =?utf-7?B?d0kvazJxcE4yZmdUR01ORUU4R0VNckRUZ3RPY296Q01VdUsrLURuWW83ZnlU?=
 =?utf-7?B?ZjV5YklBcThkVk5GbFZTZndEdG9NVE9wdEZZck1mL3RtemRNcUNpUlcwVG52?=
 =?utf-7?B?dFdHZDhSOTVtSFlTenA5OVhSbUR0N05VKy1UR1hnKy1qVmVzbTduT3RMTS9U?=
 =?utf-7?B?WHpmUFVvb043YXlNMVIvUzRmQUV6ZWE4U3FFczdJSUVwcnlJbmRJeTNPQkhP?=
 =?utf-7?B?b2FpODlsVWVLUnRhcHVnSXJIOFBScC9PNnBUL3VxMXQ4Rmh5UlBtNXc0N2kz?=
 =?utf-7?B?YjNzTndGRjZWNFV0WkZaaHdaWHQ3UFQrLW1LcVhYazBGY1ZUYjJyMXMrLUVt?=
 =?utf-7?B?OTY1d3p4VnFseFE2ZXUxTVVqNEdkOS9KOE9NMHhIMUxXVERmZFJnbWUzUVFM?=
 =?utf-7?B?dGdlZXdxdHp5UnM1akdWSmM0cjJDRTZhNEMveDlRcUVIMnlMeFByeS9hRFFI?=
 =?utf-7?B?cmY2UFZEZ2VsSUpHQmczakJjZDZHejFwREdmRExDWHpaNnU1Skk2TmdQOUl6?=
 =?utf-7?B?aktiTVM5cUdVM3RnYWxaMlBCb3pwbkpYb0VPY3ppNk0zN2lFU3BVUWRwSUV2?=
 =?utf-7?B?V01qYmhUdDBkSU9tbzBDbXJQd1d1RWxrNlJvSkJGVWczMXZ4RVppL3Y2Q1pu?=
 =?utf-7?B?bkR6U0Nma2VYWEUxSWMyVnQzZjRSaEtCRzZXQWdscHFzV0RyZ3VNSSstQkUx?=
 =?utf-7?B?Y1J1emc3bHdsc05ObkpCQ05aVWt0VystQ1laVm9UNVFvRmNzWThIeXk1dzQ=?=
 =?utf-7?B?bSstemZML1J6OXluN21ndHJ6MmhhL2dLbzdPckZUZnAyZ2xyN1Y2TDVEYS90?=
 =?utf-7?B?em9rVHVwdWNpLy9qd3BKUzhvSVEwOTZjKy1DUHBaeUhCVWl2VHRMdnJhekw3?=
 =?utf-7?B?U0ZlSlYzV0pZL1g3cld5RzUzY0ZQUk1nSmYyUWg4bmpCbVZ6bUhpRDZ5RjRD?=
 =?utf-7?B?L3J4dkpOUVF0MXdMMXhKeGdQVEJYamo3MnFqcGpOYjJ1Y1NSd1JkRFprTUZy?=
 =?utf-7?B?N3Z1a2Q0VEs4S2h2R0l4R1NFNVE4M0xuYlBjci9LVnkvMFVRV2dIL1BGdTlP?=
 =?utf-7?B?ZWdvSW8zZjVIdWx3c3VyejRiTC9FcGdqMlpoTUZEalBXem1MbkE3c1c1a3hH?=
 =?utf-7?B?WU9uVFZFbGRJbVQ1U3M5YmdnbTVDZ05lbGNhVistUTVOZWJMZnZkaXJVMlBH?=
 =?utf-7?B?ckpDN3Vhc3I4VnFoZ2VvYzZad2JjR3V6cy9kelVwWS9xbXhTMlZsdXllNENP?=
 =?utf-7?B?NTJ5VUF2cSstRXNic1dCMmo3aUhuY2NnL3dKZVRTbUdZWlRmTkcyaGpaRmhx?=
 =?utf-7?B?MUJ3WGpKcm4yRnNTV0lhOUUyRFc5bEVkNUVKZHgyYlQ1SDFGKy1td052UzNk?=
 =?utf-7?B?T2dPNVhmeVhHdTk2QnZrTzJ2RHhBMEJseUs2ZUliUHRkdDVhY0MzRFlHTVN0?=
 =?utf-7?B?YWZqUzlvTGFOL3d3K0FEMEFQUS0=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dXiMl0NKU5YGMcuqK1CwMXxHKaQtxo7kE0VuMOn5VXUjkcagpHSnNDvAlq/KT8cyia7tuM6rZkYypPMwXqZeTpO68rL9ECKNCRF3t3YeTc1fyt76JvjIw2Lm8N7imtgb+ufk/IJxDBZsuvd6N7sIr7ywOwIO+muo0HgJ74/O7JnVMlMh5rAvMduaQQoChZVBy0iygEYCKkxNwlE8lEdPW5Slrzhjfiob2RX0AyZNTnb/psdEKafTOerkWyqci9AB1mJfJQ+4cTAGBY8esIxEiHr0p5TL9w/5iH4EE/B5GIlybWNn0P24tuXfiCLzjeomkXH3EaKfsiJFCwCl3HsUNDgekj7xoUsFVPiBo0stAtF0+mm7KY0izcxwPz2wKg+ThUpNiIInbM7ZX2T64nL2441GHKYJCLn6dWOFBkITgI05b6kYDjQZ4+KX6wPTEi8t2MClpOQMpCscHkp6mbyA/35cGdcSqCPHcTa3mskjtXQcHFSt+8qdc27eWGX66MW25y79GMTQfAqlGk40xN8LSv/KFotig28kuJi2bTcTWhCUVmgh7IUxiXBxVC81PIR59KHAgQMjerXFtyvVXusWbKYh8/O0gnUimng5UiiRNlc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7704.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4e7c0e-d948-4207-1ad0-08de7ab95002
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 13:15:46.2432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /m+O6ej/ekTWRL/Xv6LFFV09Nhvwxi5hO9Fm1Akhv+h5eOMNRjw9fbfTD58/r4Hin7q4lhcCCXhD84vOszVecF0vqI0wrSDZnAyq4ObOJEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603050105
X-Proofpoint-ORIG-GUID: NClwu_u9T688QwO8wJ2L_rQc4H6g_bbq
X-Proofpoint-GUID: NClwu_u9T688QwO8wJ2L_rQc4H6g_bbq
X-Authority-Analysis: v=2.4 cv=JYmxbEKV c=1 sm=1 tr=0 ts=69a98207 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=wzW8d0FwaosA:10 a=YU3QZWNX-B8A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=anyJmfQTAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=XFJw1KJJAAAA:8
 a=mQvHCebiAAAA:8 a=BXszkKfDAAAA:8 a=c1PdSmG1AAAA:8 a=hggDf0hBAAAA:8
 a=NSIbRwiEAAAA:8 a=XlRjxQ70AAAA:8 a=QNEIRpixAAAA:8 a=oWxm5cCpOaTR0OiRIVUA:9
 a=avxi3fN6y70A:10 a=mmqRlSCDY2ywfjPLJ4af:22 a=y1Q9-5lHfBjTkpIzbSAN:22
 a=DKZDSSD9H29Cdu8kcpdD:22 a=wsrb8zZI_WQ3QAEBCXTy:22 a=duu7wrcty9prphiCz_fF:22
 a=4iM0TfZbaBQr0p37pvCp:22 a=7ilw6d6txcz0Yr6I31bG:22 a=ijqVwrIbDdJfMQQjsWiJ:22
 a=1uMOUU2w0DxzEe95gQqD:22 a=qWpmzA7Y7fjpuCUfDRU4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEwNSBTYWx0ZWRfX2H9afIUL2t40
 3zF0Pw9/6U1q1cDS7829kvkJe2zSvU0CqYUFk0QbMrsleldBTvhRU5Twlol1xIp72HGhtWB6F3x
 0kP5UyCo1WgMfpwuq8nVkBKmE/2tcVnaQQI/tozOSOgY+A1deFxCpwdqyl2Z+CWuZg1iEAbRcEp
 4Vf0iaydKHs/tm+c0k0wRelBdyT02iT2BSngrPKru9O/7sm9yc/BH/qj1bqXMxFptOD83DhgGs7
 Gx+3vmhCWRUVAbB18rKGQydZ0b8LKiYV9uEc/83sTmy+/1QkkgRBYFCaOw3g9YHXngXLXqYSPk4
 MwPdSmPGzx0z3myTrmOsKgkBPZK+pTPJvAaB2E2CWBS6HtRHCmU4Q6MrLiQVF7NRCCgercxdV9I
 peOFLqxzI4mlxxanbNUqoD1gwSVWeCkjlYLbQ0RfVTCtim88sb2hrrYPAIlODWSqHyqeOhdYHuA
 BYm9fwVESjjeYgJ3OAw==
X-Rspamd-Queue-Id: B196421282E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17525-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Confidential - Oracle Restricted +AFw-Including External Recipients

Patch applied to the wrong git tree. Will resubmit.


Confidential - Oracle Restricted +AFw-Including External Recipients
+AD4- -----Original Message-----
+AD4- From: kernel test robot +ADw-lkp+AEA-intel.com+AD4-
+AD4- Sent: Thursday, March 5, 2026 4:47 PM
+AD4- To: Praveen Kannoju +ADw-praveen.kannoju+AEA-oracle.com+AD4AOw- saeed=
m+AEA-nvidia.com+ADs-
+AD4- leon+AEA-kernel.org+ADs- tariqt+AEA-nvidia.com+ADs- mbloch+AEA-nvidia=
.com+ADs-
+AD4- andrew+-netdev+AEA-lunn.ch+ADs- davem+AEA-davemloft.net+ADs- edumazet=
+AEA-google.com+ADs-
+AD4- kuba+AEA-kernel.org+ADs- pabeni+AEA-redhat.com+ADs- netdev+AEA-vger.k=
ernel.org+ADs- linux-
+AD4- rdma+AEA-vger.kernel.org+ADs- linux-kernel+AEA-vger.kernel.org
+AD4- Cc: oe-kbuild-all+AEA-lists.linux.dev+ADs- Rama Nichanamatlu
+AD4- +ADw-rama.nichanamatlu+AEA-oracle.com+AD4AOw- Manjunath Patil
+AD4- +ADw-manjunath.b.patil+AEA-oracle.com+AD4AOw- Anand Khoje
+AD4- +ADw-anand.a.khoje+AEA-oracle.com+AD4AOw- Praveen Kannoju
+AD4- +ADw-praveen.kannoju+AEA-oracle.com+AD4-
+AD4- Subject: Re: +AFs-PATCH+AF0- net/mlx5: poll mlx5 eq during irq migrat=
ion
+AD4-
+AD4- Hi Praveen,
+AD4-
+AD4- kernel test robot noticed the following build warnings:
+AD4-
+AD4- +AFs-auto build test WARNING on net-next/main+AF0- +AFs-also build te=
st WARNING on
+AD4- net/main linus/master v7.0-rc2 next-20260304+AF0- +AFs-If your patch =
is applied to
+AD4- the wrong git tree, kindly drop us a note.
+AD4- And when submitting patch, we suggest to use '--base' as documented i=
n
+AD4- https://git-scm.com/docs/git-format-patch+ACMAXw-base+AF8-tree+AF8-in=
formation+AF0-
+AD4-
+AD4- url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-Kumar-
+AD4- Kannoju/net-mlx5-poll-mlx5-eq-during-irq-migration/20260305-003505
+AD4- base:   net-next/main
+AD4- patch link:    https://lore.kernel.org/r/20260304161704.910564-1-
+AD4- praveen.kannoju+ACU-40oracle.com
+AD4- patch subject: +AFs-PATCH+AF0- net/mlx5: poll mlx5 eq during irq migr=
ation
+AD4- config: loongarch-randconfig-r121-20260305
+AD4- (https://download.01.org/0day-
+AD4- ci/archive/20260305/202603051910.7oo8wCfc-lkp+AEA-intel.com/config)
+AD4- compiler: loongarch64-linux-gcc (GCC) 15.2.0
+AD4- sparse: v0.6.5-rc1
+AD4- reproduce (this is a W+AD0-1 build): (https://download.01.org/0day-
+AD4- ci/archive/20260305/202603051910.7oo8wCfc-lkp+AEA-intel.com/reproduce=
)
+AD4-
+AD4- If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
+AD4- the same patch/commit), kindly add following tags
+AD4- +AHw- Reported-by: kernel test robot +ADw-lkp+AEA-intel.com+AD4-
+AD4- +AHw- Closes:
+AD4- +AHw- https://lore.kernel.org/oe-kbuild-all/202603051910.7oo8wCfc-lkp=
+AEA-intel.
+AD4- +AHw- com/
+AD4-
+AD4- sparse warnings: (new ones prefixed by +AD4APg-)
+AD4- +AD4APg- drivers/net/ethernet/mellanox/mlx5/core/eq.c:25:14: sparse: =
sparse:
+AD4- symbol 'mlx5+AF8-reap+AF8-eq+AF8-irq+AF8-aff+AF8-change' was not decl=
ared. Should it be static?
+AD4- +AD4APg- drivers/net/ethernet/mellanox/mlx5/core/eq.c:958:6: sparse: =
sparse:
+AD4- symbol 'mlx5+AF8-eq+AF8-reap+AF8-irq+AF8-notify' was not declared. Sh=
ould it be static?
+AD4- +AD4APg- drivers/net/ethernet/mellanox/mlx5/core/eq.c:978:6: sparse: =
sparse:
+AD4- symbol 'mlx5+AF8-eq+AF8-reap+AF8-irq+AF8-release' was not declared. S=
hould it be static?
+AD4-
+AD4- vim +-/mlx5+AF8-reap+AF8-eq+AF8-irq+AF8-aff+AF8-change +-25
+AD4- drivers/net/ethernet/mellanox/mlx5/core/eq.c
+AD4-
+AD4-     24
+AD4-   +AD4- 25        unsigned int mlx5+AF8-reap+AF8-eq+AF8-irq+AF8-aff+A=
F8-change+ADs-
+AD4-     26        module+AF8-param(mlx5+AF8-reap+AF8-eq+AF8-irq+AF8-aff+A=
F8-change, int, 0644)+ADs-
+AD4-     27        MODULE+AF8-PARM+AF8-DESC(mlx5+AF8-reap+AF8-eq+AF8-irq+A=
F8-aff+AF8-change,
+AD4- +ACI-mlx5+AF8-reap+AF8-eq+AF8-irq+AF8-aff+AF8-change: 0 +AD0- Disable=
 MLX5 EQ Reap upon IRQ affinity
+AD4- change, +AFw-
+AD4-     28                         1 +AD0- Enable MLX5 EQ Reap upon IRQ a=
ffinity change.
+AD4- Default+AD0-0+ACI-)+ADs-
+AD4-     29        enum +AHs-
+AD4-     30                MLX5+AF8-EQE+AF8-OWNER+AF8-INIT+AF8-VAL +AD0- 0=
x1,
+AD4-     31        +AH0AOw-
+AD4-     32
+AD4-
+AD4- --
+AD4- 0-DAY CI Kernel Test Service
+AD4- https://github.com/intel/lkp-tests/wiki

