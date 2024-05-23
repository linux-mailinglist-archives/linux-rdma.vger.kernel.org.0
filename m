Return-Path: <linux-rdma+bounces-2594-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24C8CD073
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 12:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193D51F240E1
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA4F140394;
	Thu, 23 May 2024 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kusmfesi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J7QUZF/I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56CC13FD6A;
	Thu, 23 May 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716460713; cv=fail; b=Zhdwt8v37akSy0j8nHHMze9FlHoUHCcu4TWtMb2qSNBxW9HMaNWwoc2mV0fpPS4FtL0zMit2Puv2r3DiNaSZ9LSbAU/psuA/NX23M2odeyptrS6ehU8jdU3I5s18NZRlNXtsPeyTH8Y9vUHEPv1h/5ijzFROIHwdEQq0u9sAfAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716460713; c=relaxed/simple;
	bh=7EO8Yln7xs8vvnn5vmQvl9o3MY2CIf68xFa5aVaGATw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EIqg5ayq4429H3CoVPGmoqibZJ+RHFkeP7pa91dboqrG0bL/9pt8uoZfuHN5NOYyZ/wRVlW7mqXzsUGO4CMz447WhngZ6Yn2MHTiGavinqNdWprFGcm5GO736kgl5OOj/VGBBj4wEXKIPLZpIyOLl6NR/ze5gYWAvnqQ0yutb1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kusmfesi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J7QUZF/I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44N9NVKI025651;
	Thu, 23 May 2024 10:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7EO8Yln7xs8vvnn5vmQvl9o3MY2CIf68xFa5aVaGATw=;
 b=kusmfesi9Yk15VElEuIpNI3pmLzx7SKwIPH0S+XrPVvFTYZBBvWuSq3QV/3lXrekSjCg
 h9IPlVynuj3NXKhZnU+Rr2aWedoNRrMH3qpWOchi79aECmXQa6zU8D4zglkZUuaKy4AI
 HO0IZGtIn3QZSDzmjnaL4QB9B/PIq/3Y17/MWkkwu9d828Wk5I3AGzubwExi+xGj7Wy9
 2VRuRc1Kr2Rb/ZLdvKrCul0nAzy0QWJjHEetSvOZ55xWYRaUTsaO6hXRlC49pkycNQPf
 FLAhLff3spFe1YIrp3V/cxHyMDpjGBo/8pVg2poSOqKtO4VpYCMm3ZZ5BXHKZqA2MRov GQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6m7b9e6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 10:38:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44N9d2bb002688;
	Thu, 23 May 2024 10:34:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsac6wm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 10:34:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR16i9dYSACIJD2BzPNIeOHjseaNKHRTmYPV36J+YG6VGRfzCqDMbuKp6HyQqnUxbu8pyDh43GQweQlBxEIck4kt0JxFJI5ax51Jy/sr2j+mh5wBObwKYQ/og2ipJZC/Z/hn8ZMQp6BYvjOC3pnFHd42gDAz+Nn86DxHFqm4ikBTRw/TImA20lErfyLk9xbEdmCi4CVuHRukaPv1mRvWW+s+DLlHvhoQZX5mormdGvaT2xSh7UTPF3NWWzqUK4GVbc/J0+Jg9iRN+7E+Nh381NeTwIp3Iq0+Oo9l2H8Bv01MlR3Y7/002mzMY8JtK+4NwGeJq0atH3FHEaej5j6jsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EO8Yln7xs8vvnn5vmQvl9o3MY2CIf68xFa5aVaGATw=;
 b=nfQXIldq6vLco5Nd4z02WLOxIu3Uv+vZdAVwgfV6+/W/syDkeYlmgEy1SfZnlowlAZRCiGdlUHPgUzUMKVOICiLlRQKUo1TYEZQ5F7t+KLKl7iJBch8UkAPjZQMn2twAS8Fmk4kN2SWgDfOKLJEwcq63DxXW7uvpi1y4gdD2mPNHKOgjBNPTlQK0JJu/a2Icr97GvXa5Aw4OEYdXQLNpLxR1ApLQ7t+6Q8pFqbzlBDDTSCxlHwEr3v0RieIs5TFPaaMiu4h/0W1guYUP+y4b94SEAbIPY2WUVnw9XiYcdG0Yhl70mpXx35jdWliDmCk+PBBOuf4I7Vcx4OwNOG8wWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EO8Yln7xs8vvnn5vmQvl9o3MY2CIf68xFa5aVaGATw=;
 b=J7QUZF/Iv1R8Q+vUHywEtNekDfEposHUQRJc1xqxablNSix92fR5cBuFe/6mmlPOH1NvnyLTxbJ+uJ8PRRcPNmjlOlspDXd6lbsP2xE5+p4Dtn8IUtvpskp3gLyLMo87rToBwvMsGuTQFOmMic26aYy+t0QjmQVxD9pGO+SnUag=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by DM6PR10MB4379.namprd10.prod.outlook.com (2603:10b6:5:21e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 10:34:19 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836%3]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 10:34:19 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Christoph Hellwig <hch@infradead.org>
CC: OFED mailing list <linux-rdma@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Tejun Heo
	<tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Allison Henderson
	<allison.henderson@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Chuck
 Lever III <chuck.lever@oracle.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v3 0/6] rds: rdma: Add ability to force GFP_NOIO
Thread-Topic: [PATCH v3 0/6] rds: rdma: Add ability to force GFP_NOIO
Thread-Index: AQHarE+dJGcbgWGUd0CV1VPowGjUPLGkeuWAgAAl9wA=
Date: Thu, 23 May 2024 10:34:19 +0000
Message-ID: <B7E7ADB8-168A-4396-9E66-65F940D21A60@oracle.com>
References: <20240522135444.1685642-1-haakon.bugge@oracle.com>
 <Zk77x71LCqlgIING@infradead.org>
In-Reply-To: <Zk77x71LCqlgIING@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|DM6PR10MB4379:EE_
x-ms-office365-filtering-correlation-id: 4af0ffac-3562-45b5-3575-08dc7b13e721
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SXVXQzQwWXlwYzZubE43T3ZPcnA4ODRMZ3c0MnJxREh1Rm94MzVhM2tLWUd2?=
 =?utf-8?B?MDBDMFM4bW0zU216b20rNVR0MVVTbEZCY09jK1U1b0dRZ3RNVlo3ajFGeVlS?=
 =?utf-8?B?Z1BpWnp1ZDErTHNCU1k4bGMzUysxSi85eFowTGpOaUpPOC8ybVUrbStzeTRH?=
 =?utf-8?B?aS9NdWR3V1YrQzdSb2Z0UEN5VXloRkFOczh4YjI3eit4WlZURk96M0ZkaXZQ?=
 =?utf-8?B?SWtDOFRJbytMM0wxdDBCU1pGajY4b0plck5sM3FVN3ordjZjdXlYZnZaRGFN?=
 =?utf-8?B?U1YrMEh0bnRwN3dpczZtQ2dyaCttS0o2NXVMY2VXKzNxNGZHdVRmMUQ2dHNE?=
 =?utf-8?B?M0RuWHBieGpnOHI2ampnT1dMUkRpdHZhMkdhUkFlVGZ5a240VHRBNk9KV2Fp?=
 =?utf-8?B?U3EvUEtzMGRaT3BaTTZHRG5KZjhBMzNoeUlQajNJcEd1TEtmSmFhVWlKaStq?=
 =?utf-8?B?UHFIRm82bGJCZ05Calp1MWk2UG50T0x6REhmUXh6NjE1VXJ5ZURsamJBb3Y5?=
 =?utf-8?B?WVNZQjRpMy9ZR0YwaVpjRXlHOGVZMDZ1Wm9uM0NVbWhFdlY3VGIrellGa3Q3?=
 =?utf-8?B?N2poQzdJQU8xNm5PRExUa3VjVzV5RGVUUVZpbWlSbFZUVk1pVVdOSFNDQXI1?=
 =?utf-8?B?OGFSU254M2RJcDBIVjBaQ3FFT1Budm9lRytZUWw4eVhpcU9XWWFGOXNTc0ph?=
 =?utf-8?B?eFMrZnYrN1ZTMUU3dWxGR0JHRGlPbVNOV0FPQnVQYlJEYVpWUnpxVEhOUENq?=
 =?utf-8?B?OEJ3Q3E2SWdaUlE1Ym5pb053Ty9sMEtnNzY3TEduOGg1d3BXUHl3SURmcjQ0?=
 =?utf-8?B?dVd1TjFsV0ZDaWt0OWxrb09HdDhBMnc2SGZCQ05QSC9ocVkvQmtodlR3WjJS?=
 =?utf-8?B?ZzhBekF2clhUMG15dHd6a1JZVEx1c2VZcFl3Rk1rV3JmLzFBSnEvMERuSEpa?=
 =?utf-8?B?R3N0cWVTK3hBK2ZIQ3RWSmIwNU5tZ1Z4Z0lmQzRCRXJOOS9QNlNjTG5XK2x3?=
 =?utf-8?B?SnZoOUpsMm9adUNoak16OTIzWis5Zk9GcUJnOVF6bkJwTk9Dd1oxL00xSEkr?=
 =?utf-8?B?WWEwdFlaYnQ3N2NsQ1kyOGZmd1RodHdaMUl6bGwxV0NTVm43UEVGbTlNQjNu?=
 =?utf-8?B?Q1MzT0RLbG9zOUxkSHU3T1NERklPRTdoVmk5MWc5eGtJaW9lMnRxZEp1YUdr?=
 =?utf-8?B?c1VkNC9pUC9Zc2lIYUV1bU5RTVR2cFlQaW9ZdVBJeEhMVXozQ2h6VTNiLzhw?=
 =?utf-8?B?WDlldFpESVJlVm1acTFZWC9aYW1pZVlVL0dpN29YRk9HYUw3a2U1d2FsYjFH?=
 =?utf-8?B?YVlqeERpYUtZcGJoZVlWM3pJcnMzQitlWHN5NVc5ejUvVmZHUlVqRWJjTWlz?=
 =?utf-8?B?YkhUOVRpaTZxL2d3bW1FaXo5MFRJemtVSHNkYit2UFV2dWlNWlloeEQrQmk5?=
 =?utf-8?B?SUd4Q3c1YVNIenhaMzJCbitncGNCQStCMVhJYWFEdkhIdWJ0ektubTFMSXRp?=
 =?utf-8?B?QjNib3NBTFZmbTFpRFhlQ0FMVjRuTk53bFpmdWFEQUQyemtYQ292RXBzbU44?=
 =?utf-8?B?RythSWZORWpsdkZsRm9OQ2dPejhoYTRROXZpL0ZDQmhORURmc2RjRk9wQzEx?=
 =?utf-8?B?YzdGa0RFeGdDRjdSR2V1RjVrMXdrWnVJNGhpZU5jcWdPSnI3QU1FZHZNamRs?=
 =?utf-8?B?SEtlaHMwdFRKVTNuWlphRnZiV2k5M2k1NEZVbmdSQUpiVXRoSGNHSHdIQU9M?=
 =?utf-8?B?T3BjUWZ5RTFsMHlYdEV2Zkdla1R0YWpLNzZ4ZXdDd1h1aU40cnJEZnRRTXRH?=
 =?utf-8?B?TnJYaUJId0t3dEdGL1phZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dWw5enhtWEw0Zkx0dEEwWk9wL3I0S3p1dkFreGFMVUNScFQrczVGL0VudzhC?=
 =?utf-8?B?dk9QcjlLOVpKQjcraW5WSjBHRDRVNHpHVkxGYVF2Z0JhM1I5RHBBZnViS1hn?=
 =?utf-8?B?SW9SZDNUNHdBclJ0YnlKZW1FVkFzZ1dtalZUZU5uQjNDeUExMlcyK0FTVllo?=
 =?utf-8?B?cnhyV3lUaXN6enlaeHZZTVJoOFU0a201bDcrWWpTVnV4OFB1VENES0NCaWhX?=
 =?utf-8?B?ZFpFbTJ3djNiRkVSc3BJbGVOSEFDL1hLN0dDaWdtUnFIOU9PNkFaMzNXbkkx?=
 =?utf-8?B?YUNUSmRGWDkzN0JOOHRaZWpCVndsdjdHeWlCK25wZUQ4S1B2SFVrODhadEVQ?=
 =?utf-8?B?Qi8raWJ6L3VKeXh6YUgwa0lnV01EbHRpcmI0UEtrQzREa2l1UGxIMFZxV3JV?=
 =?utf-8?B?OTk0N3BuSUlIK205OG1veGF6TnN0SVVmbFRZb2FLQzZqdTRZNEtENkdFN09E?=
 =?utf-8?B?d0Z2dzNTZlBrTCtPay96cExuME1tYnBuUjJCMlJaZjBVd2g4cnBIWHFGcXAv?=
 =?utf-8?B?K2gweHI0U2d3RXJvaVpiQ05Tb0VJWndOT0VlRjU2WjQreFVidkY2UGR4QUhZ?=
 =?utf-8?B?dE5helhWVGtLWmhTSnJtWEV1cnJoR25MTzE2amRma0dBc05mQ05SY2YvSkcy?=
 =?utf-8?B?cmRpOG8xVFRNb3JsQy9NTENsOWVqTFhNYlRDbzZYam1oTVkxb0o3cm5uVVFh?=
 =?utf-8?B?Vi9leW5YOXA4bWU3eXBvemJ3RW13N1dYa3E4Y3htc2RQL0V5bVRqNnRLVG1U?=
 =?utf-8?B?a216bzU2d0lndTNEWS9WZVQveWpYdXh0WmtFeTJMTWpKQ25sWlZPQUVGZS9L?=
 =?utf-8?B?QzJ4YmxtUjlieTJmN0c1TmNaeGtMaWc2T0lpY3RwK1lVWm1Ubnd6WWZrMjB2?=
 =?utf-8?B?VXZoVTgxQ3lNbFd2TmR2ekZ1clNOam9hV1F2U0pEOUhCZmdCbVFKZHgxY0VM?=
 =?utf-8?B?Y3Y1MUFWUjhPcnI0Mjk2NW5TUU1POC9rbHFRa2xEVTV4aWdJQWtpSHFJRS8r?=
 =?utf-8?B?RW1SamFsbUtBSXpaY0VURFZZKzlVbEt0VGswTjdJTjZjK3Fzak4ycS82eEh0?=
 =?utf-8?B?bkttNFNHOFNTL3hZanR0TysvKzJiVjdSY1c4UFZnZTFMYWwySzR6UEJ0d1Iv?=
 =?utf-8?B?VmZXdFBVejlJR1N5bzRUMHQvT2ZsTk16ZHJVRFZPQ2hNR0ovYVUwcytTRU1I?=
 =?utf-8?B?YXltSUpUSVhwcHM4YkdLZlFBM1FzVk1wTmVBVkpyRkdmb3hWN2Z5b0pGWGhD?=
 =?utf-8?B?aEJMbWpRRjRiQUtaaGJVZUxvTndJQ1NLM1ZNNngxVnJYZ0t6d0xOdTZVWUlp?=
 =?utf-8?B?U1FmNTd0MEJmRVlJdkIvSFg5RnBhdG0wT2czL3FSdzZZdGpnM2oxSGN5NmFU?=
 =?utf-8?B?UUxhQ2diZUtYa21VT3lOUFhycjIrMXQ0eUd4RkpnYzVNMkRyakN3d0VJOWc3?=
 =?utf-8?B?RjUrcXlaSGVIMUwvVW5NUHZHUEQySFpmd2pUOTJyYzdVK3p0N2dmbExzVTBF?=
 =?utf-8?B?OEJVVmd6WlJaVDVDMGwxVWJtUWs5cEIxWldML3pBTVdsTUNXdnExcjNzTGhr?=
 =?utf-8?B?QWlYcEhtZmRaR3lNeDJTcE9oOXBxTzBGTXZRR0hnL3YyMUtUTG10dmY3Y2ZM?=
 =?utf-8?B?aTBPOGhMTUY1cTAvK2xkU0g1ZnlZaTFjd2xoTVA5WWxCNzlJblB0ODd0V3R2?=
 =?utf-8?B?U0d1alpZdFc5UTRCUHpQQlhnNmNSZlFWOFpYeGR6QWNpL2x5OCtpK3BaSWZu?=
 =?utf-8?B?Z3lTKzFwczFKYVcvWjMzVWNFWVFxNDFNOW1OMmVDSTF5TUZvLzRxY2pCTzFh?=
 =?utf-8?B?TUNVcGlPbFdyNCtjbDRWemFINEZTcWFtTVRRcUd0bFV2aHhETjB5R2xQakww?=
 =?utf-8?B?Qm05emptR053dWI1WkV6ZGFGNDNiQ1Jsb1JrVDk5ekRaT1g2OE54WWNicVF3?=
 =?utf-8?B?ZktId3c3NFNGdDBpMmFPemRQQ0psNlVFS0xrZTJ5b3B3R1J0VS9lY1BhYXBu?=
 =?utf-8?B?aUgrK1BRMVZ6cHFlZDY1K08zQmVHeFd4SlE1QUplSGpOTkFJbHRPWlJXUEor?=
 =?utf-8?B?czhCSFpCZVJJdkhXMkZIUUxjUTFZTTE1RHhUcmpNSnFwc3Zhbmk3TlhQK0Vy?=
 =?utf-8?B?a0xWeGFUemVEajBVZ09SUUJEL21IWWNZL1RISjl3N3RRekNZRG1TMHVxTlZM?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88C933F13FC79A4096B8FD76A6770108@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WglX4A9ircb9zWbFdZcTWYDwU087WZKvTU1SGUQW309PqusbHNgQI615SEdIXMZyQMNShNNYujNnaWpoyCsu/6HmuYFr3D7wlLkJQqAZK2gDyrveD7yBzyS56pmzVDRuuZf1ql+zEoT1fH4idctCLgMAQw75ZgkWOkjthBrmaSC49ftiLZ6W9pUsBBGSWwHTQaH8/7W+XyB7b6MiSAq1Qfznc4OJlvCIDGB02kbU2Pidycv3s+A2coekbSksUZ/FwFFsukWuQuV+W9O5TI+GFbnZg0X1j1NKXcLbatug4zLLtlsWjYPDj0PeO7bpH4viKtpoF7g1EPlI/wm9kmeeGUcR17U1/qMuRrIzzJtAkP3zoDQECQNnTZ4aX2Z1L9bDwNOE+f5NxShK2+sAo0Qejj1ZC3T2RbpzaYvYV0lED+4tNj7MMxL0Aml9dyTqO8SHKx/k6p8jizhKV3fneVmHOwb3Jx2nTxsdm6qbPTNKWxAiJ8Ybt3RgAnSUspZdOh0pa4TxqjvE4vJDq15sP9iGkzZ4sq8a9mTFtJIixc0aZFTPIkMv2BZV2VJPkfYH8GkwEpxO18nSlGh+E4678FThDVoPzRz5V0F2CJ7F2lQMV/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af0ffac-3562-45b5-3575-08dc7b13e721
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 10:34:19.1933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GR4lowXe62jCjZ8XCuVn29gUAz9Yt/dEmxTMF5kiGgOTf2fEJEKIzNav/MjYv0N0jDJFcEqCgVb1P9Up63IzuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_05,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=816
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230071
X-Proofpoint-ORIG-GUID: zi1RVRTax7JaKqaBFtOAjDlo8pp_ANnb
X-Proofpoint-GUID: zi1RVRTax7JaKqaBFtOAjDlo8pp_ANnb

DQoNCj4gT24gMjMgTWF5IDIwMjQsIGF0IDEwOjE4LCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiANCj4gU3RpbGwgTkFLIHdpdGggdGhlIHNhbWUgcmVhc29u
IGFzIHRoZSBwcmV2aW91cyByb3VuZC4NCg0KVW5kZXJzdG9vZC4gT3VyIGVtYWlscyBjcm9zc2Vk
Lg0KDQoNClRoeHMsIEjDpWtvbg0KDQo=

