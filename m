Return-Path: <linux-rdma+bounces-18425-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNuNJrG5vGnQ2QIAu9opvQ
	(envelope-from <linux-rdma+bounces-18425-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 04:06:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B122D5511
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 04:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DABB30620FE
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 03:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0052DB7AA;
	Fri, 20 Mar 2026 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O/Px9qqd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UcY2Ruu7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116429ACC5;
	Fri, 20 Mar 2026 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773975980; cv=fail; b=DA14H4+CVxI9sodA0AX1MzWA91MRg3RFjJliwWotLWm/iORogCX0AyR/sXzJNgJwZhvzsbIGpInlGlzrsD+Amy0g24SOxeRGcZRuuNEt0klJIXXUDMb5TQ2CxX08OfHmPO9FId1TpNpOAZecbzs8Wh1euWHJB5KkbaetrM6FVPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773975980; c=relaxed/simple;
	bh=9nzZCoiQUQElh3oxHGxKPHjjBeb9iGJXXA5GZJPPsgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OiBlnXltXILweR9M1Ui0AF3zeoqC8BYwlrrxa9kNDQv0fMSGRh+g/HIQp5MgYAitzCtR3rEN3FAfxG+xDh044QTgfrxYaDp8hFT1jR/dkBLjISJ4E4qsy6d1sr8t3MLejOx9B2wsphnHOkc6l2/ejdVZyVTfnE6/ZuVZxLPzMg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O/Px9qqd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UcY2Ruu7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JHUG0I2707460;
	Fri, 20 Mar 2026 03:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9nzZCoiQUQElh3oxHGxKPHjjBeb9iGJXXA5GZJPPsgM=; b=
	O/Px9qqdP/HFBGS6GGlfCyNLO/InB6s92YuTfi4v5XZ3Ot2fIddxxVx1GiM4ymp7
	xa7T9JudBekb1lFJiDs9LP2D8qXsMx9fMkCMQ0VDOmE5wbWUw/da2BppUTxI9RaM
	YWv0PjHf6weu9wb/cDc+UROizoO0+iwHqiNQxRRBaMGvUKx0U5Fzd8d5ep/eqHKc
	rTsDHdHCkPT71u6e0BETeUofQ2xKxqp0N4T4ZlOUDpVtr++q4xLkTIQh0Jmd22MR
	Rm8gx279UFIHoDWxplc7HuyiEqgK/I9eD/lpbGS0cPTus+xWzZYirkRh0rt1O3vW
	frwiD50hEkTsqCBYRQhZ0A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxf48uvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 03:06:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62K0MolZ002736;
	Fri, 20 Mar 2026 03:06:04 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4qybuw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 03:06:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/VjyC8DnIn4LwaAZyn+qJxZJqPapdP97CrmEVGH0fjCE8y6lv0TV7iHmjgV5OzXUI53+3BJdnvYRq72RzLEfqlonQ6oMtdeI2Ek6U7H41Wks+z57bzpjlzDFTPmgD6JJD5TXVRXVLsZbGvTa41eacPtJiz9LcaatrgRxCI3WT5jOzZx2jIZgA4ahOykOE8q5Bm/NbeHrNd+V+nkbB0KXG0fzraBppLk+Czt9hhVWsUIEhW5Wop2Z8A7cjj2wQs9b+TIHXNFJ9L/eMXiCuDb46YQa5pi279qON6n4ZuybGvqkeJt9C+wtl2X9PfIHK3KiLMSR8BplhtS0oWgmgIDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nzZCoiQUQElh3oxHGxKPHjjBeb9iGJXXA5GZJPPsgM=;
 b=LHHcyLX+8/IxemsB48n7hi3SKGsoJMoCpFiNitSa7crsoDiJSctlg+RPG8esRdZZvrPPEg35VsWr4DyEaaP4vcGn0x0BLkR443UH30S9FEzUGoPVuPiEgZepU2zwk5VflBYHFnaIG0ABYRi+dOyVBO/Yqxa1BjJ+gmipoZgcFgQ52NEckg1UfwbNpvitsTRKwZdOnoohVW40EULgueN7LrslOw/jhSeymVULgq86oB3w4cgwgO37JEN18CBUSncRnjHV3LLAjgCTmzCsRHuCaWvu5wWA8TdutiAWjzt2pQ0aqiNYfaEwodQ5dQotNfl0lNF70ubBHaMzuotVmYNOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nzZCoiQUQElh3oxHGxKPHjjBeb9iGJXXA5GZJPPsgM=;
 b=UcY2Ruu7ljoX4gf5im/jFXY6eBmqHzcVJI1SE5TqTVru9lBdm1/+2U6SJKt5qeQJTveSvW6AHKzXzrlBPfyWNmu+lQJBWcu9GtzkhUfQgEuqe35NyOu1w2iZE1s1Ucp5Gb9oCASuXGV+hGd2cpAbUm+LJRkS0gHqQrDgik9v7ZQ=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 03:06:02 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%4]) with mapi id 15.20.9723.019; Fri, 20 Mar 2026
 03:06:02 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>,
        "achender@kernel.org"
	<achender@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH net-next v2 2/2] selftests: rds: Add -c config option to
 rds/config.sh
Thread-Topic: [PATCH net-next v2 2/2] selftests: rds: Add -c config option to
 rds/config.sh
Thread-Index: AQHctznShNiAZ7rPnEqRk+0uoShFsbW2TAOAgAByf4A=
Date: Fri, 20 Mar 2026 03:06:01 +0000
Message-ID: <a6d102955037bb1a57891da8c6361df6b58d08da.camel@oracle.com>
References: <20260319004618.2577324-1-achender@kernel.org>
	 <20260319004618.2577324-3-achender@kernel.org>
	 <20260319201613.GV1753385@horms.kernel.org>
In-Reply-To: <20260319201613.GV1753385@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHUBBMB
 CgA+AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAmiSe
 HYFCQkpljAACgkQyD6kYDBH6bOHnAv8C3/OEAAJtZcvJ7OVhwzq0Qq60hWPXFBf5dCEtPxiXTJQHk
 SDl0ShPJ6LW1WzRSnaPl/qVSAqM1/xDxRe6xk0gpSsSPc27pcMryJ5NHPZF8lfDY80bYcGvi1rIdy
 KD0/HUmh6+ccB6FVBtWTYuA5PAlVOvwvo3uJ6aQiGPwcGO48jZnIBth96uqLIyOF+UFBvpDj6qbfF
 WlJ8ejX8lmC7XiY8ZKYZOFfI7BRTQxrmsJS2M+3kRTmGgsb6bbPhaIVNn68Su6/JSE85BvuJshZT0
 BmNdWOwui6NbXrHgyee0brVKbngCfE4+RZIzleoydbHP2GnBtaF2okhnUWS/pNKsOYBa3k8IXdygc
 CbiXmjs3fIf+8HIm0Vzmgjbi5auS4d+tB+8M22/HWdxmdAB0sHUFMtC8weYpVxvnpGAsPvy166nR5
 YpVdigugCZkaObALjkJzNXGcC4fuHcqZ2LVHh9FsjyQaemcj8Y6jlm4xUXgyiz7hkTNsWJZDUz5kV
 axLm
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|PH7PR10MB7056:EE_
x-ms-office365-filtering-correlation-id: 2bbd8de9-080c-42cf-7a13-08de862d9e42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 naxXmFY9/e+uN6I+xVc+gTxQVBm6X9T8y6jebmtRnBvNxt9Rp28oxXWwnLAv2FntOK/+/jvHhI2GVISjJbWgw0bb4eXiS6vbXBDuc0UsAhEGmUH6WXVdX6OTmchupktiDguC5OFV1aFHl1ncQl2BZzd4lx2nWW30i2PbdIKYu+KdNHRzZ9mDdDJyb+cTXCZnDg6uuDr4WxDSar6LCgOhK2JAzruKHVenU0NczgGnFUUyyEHYzthSJnbtooR6wqhWrRROEyPxuzLwToF4sfkJakePBtDuT/RRg+cLts/JGjds5/na5KFobmWMEjvlcUXOdQrTxdGYfoB3O4vCfCAlf/8WaDyS1DxdKCElcno+TW2C8i9kBEc4+Xw/j12QFgbAzqTi3G8vka8LL+Fe+CUc1+Lr3J6b+cMukY2k4EMKMzQzoFh4TGZKVv6aRKfVzi9m0sFqIcYrV/HSSRTYd7Y7m0GcqEwqB2YOJInQM7C28hx9iVE9QWL4XGTePytIhnheXExaJteTyF64czt3nRensBEXI7PxdJUIkuf1CCrpLQe6MBGDQJK38c6iEmffEW72nbsC3ibT5v6SB3eAJr0AbVAJanixD12WoknMREt7CrBr/bV4uduLBZCJ9iNgZqckbbvHjwpOMSJOrWzVaMtMEv0spPlpOdPSHHao6Uj58qBSGj0B/L1RsHD4o9JxjadOZMtER6tCIit0ihwmJvDd1/+M0lZR/8ptxUkxy1kZcw2sU2VKU5XTDrfvO4Q6381uCqePrgZbVPAeAcC4eg0UfF6QMOylMBOyIvA/FtPjCzk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVo2ZUxJZjVHdTRFdGdneVZOcjBPeUlGN3I5VHpjN09PQmxIa2JvU244TnAr?=
 =?utf-8?B?WWdPQ2FCYmxDaHR1RlUzNU9PV2h5MUhxZVhYNUQ3WWMrNmFqMGtLcUVMUDhX?=
 =?utf-8?B?dFR6c2tvd2tCY3V6Wk8vSG1rMjJ1Mm1yVE91RmVUakU3SnU2Q25TL3hLVVFm?=
 =?utf-8?B?eVhBWDhPMUFsdWNQdGUrREVhbFFkTHErMU1wZGh5SGpoWE5HSDl2NjJPU1I2?=
 =?utf-8?B?RUtFM1A4YnFzTkNha0dFbEpvK1dsRHVjbU5nR3c4UWdSK3phOXlvcTZYNTdX?=
 =?utf-8?B?U2VMQXZUNCtWRExURGthdW5oaVQ2S0hUSG5TMk5uaWEzK2JzRFpRcEtUOEZk?=
 =?utf-8?B?WXk0U1RnMjVmYWRIWnJUakhUdis1dnFpOEhpUDdaaE1uQTdmemU2UXBjaGU4?=
 =?utf-8?B?T0tWU1JZd3RFTW95alNVZW96RU53R0RPR1lsalVVNG9MYnFZS2NiOCtZMnpT?=
 =?utf-8?B?OXdzUmZHdW9EYkE5U3JZMjVwM0FRV09Lc2dSbFpYTTJPSUs0bzJLYTFFREE1?=
 =?utf-8?B?dG5lYzhSMzFUYWk1MVhOTE5KRXRSWVE2WDROMmo2dTFENSt0dDFTblBjWVd0?=
 =?utf-8?B?dWg3bGk1Wmwwak5wYWF1UUFLb0M3a3NlSXo0dkI1bG1UcHAyNHlCd0xsUUZk?=
 =?utf-8?B?Y0dHR2RGbUhvamxha2ZyVDBPdVc5R3ZZRkVud1Q4SG1tRGw0MGVDL05ydXRl?=
 =?utf-8?B?NkExcXoveVE4UmhUNlB4SDRRdVlQQkZFZVRUY1Mrb3EzMHVScllUM3hVK0RU?=
 =?utf-8?B?QXpiNHMvYkg2UUIwSWhiRi91d0Q2VWhMSS9pQ1NvNWtFM3pUWXB0S2dWdStj?=
 =?utf-8?B?djJuclNPVUFQaVZLWTlBb3JuR3VvME1ZcjR0cGlBRHgzTE9LNEhBL1lqQVpm?=
 =?utf-8?B?OW52TmFHMlpiYkwvQkpScXJlN0dwa3I4R3FJVEgxN0RIeHJySU1WZ3duaStG?=
 =?utf-8?B?ZmlPTmVDWDlSVkU4bzAwWE5jdXZoKzI4ajJaMUZySU02Wkc3c2VGcU1uWFd1?=
 =?utf-8?B?SjV3YVM1N3NnN0t6cUxNVFk2V3VPTjUyMVQxZVF1MVhKUkVHaXFNZmREV2cz?=
 =?utf-8?B?c2M4UGt3c0RpYnN4L3JGd3lIQit4L1JGK0luSXd3WmxxZ0RQZUJyWXNZSW14?=
 =?utf-8?B?aER0U08ySEJzMmlUbEd0ZmtXNGE5TllIVytaTWhuZTBiZFpKVis4VFFnWFR0?=
 =?utf-8?B?WTZsL2JhcG42Y3BwVituS3JQTDZFbDhHUU12UTdDeElZbjQrSGN3N3YzTXc2?=
 =?utf-8?B?SWpVUTJIamJ6eWVMbFFheUduS1R1OE9WdW9VRllYTEhlMFpWSHUvdzEyVk42?=
 =?utf-8?B?MU5wc1ZzOGxQbTdWVmFLeGlGcFFPbzh5ZlBBUkhUN1puZGJOVGk0bm5WbzY2?=
 =?utf-8?B?aVlqWXRZNXJ5MjdaRnpQNkVaQTNUTkJrTVBCVjBmc05CeTQwZFp2ck83aGIy?=
 =?utf-8?B?S1FDODJveGZnQk9oMEFHRkJ3YzNlQ0FndGtOeHdkNGtHZEFRWU8zYUtLRGU3?=
 =?utf-8?B?RVlKMm1RS1VuMHp4OFFpWTkrT1ZxRzhWSy91cU9pV2p1WncwTjgzclVxVkRl?=
 =?utf-8?B?UGxMOEVjc0N2VkJPSFg4c0V0aUN6ZzRMbjZ5OU1nbjFyUEp4RUh2eGlyYWp1?=
 =?utf-8?B?T0h0Y2hyQXNGQUU5MHZkNCtsc1NFTUZSbEgveTlINUxpQmoxVmNqdVJ2OUJB?=
 =?utf-8?B?QTN6a1VkWGs2VHM0SGlEY1A5V1RxTE04c0I2WlNaYk9yd1NMTnd1TGkvVmZY?=
 =?utf-8?B?YnFZTk9uY3NPYnRQaDB4c2JERXlXa2d4aE01YU1xMC96SSs2VmZXckRpNTl5?=
 =?utf-8?B?WkluZG9Lc2JZbXk5MjV6b1ViL0ViUXM5ZUljWnl3MEVuT3phVERqTUVjaTVH?=
 =?utf-8?B?TTFpRlNxeWRFY3lGdHlYV3RGQzJlaGlYdDh2ekJaMXhiV0VsK0V4VVNiL3R6?=
 =?utf-8?B?eWQ1bGFRQ1hFaFF6TDVLNDVWRjBrbFVPdEJMN3IzOU5vNytiREtQc2VFSjQy?=
 =?utf-8?B?SThjRXljUEV0ZlNmekRHeTMvREY1RTFyVlhnanAzK3FwSjhpemlnVE5GZUNE?=
 =?utf-8?B?TzhrVnYyVjhTWHpFOXlaVzRpNlVpSkxsVEFUUFQ2bDV2cWhJS0JQSFhEWk5H?=
 =?utf-8?B?WW11Y1NBZDBSdElTT0ZyQy9BY1BJMUUvT3V2Nlk3UE8wL3F2UHVlVTRoODVx?=
 =?utf-8?B?TlZaS0xxazEvZTNjN2NzSllveHBRTTE1eXpnVmJTNDBQN1UvelIrU2VUblIw?=
 =?utf-8?B?NWowOUJDU09Pbmxlbm0wV3NhNFJzQzRsOFJjcEpYUEJOU3I3MFhNOFRxdFV5?=
 =?utf-8?B?blZ5M0o1SHlSN3pFMjNFYlYybnlua2JkZ2JXalg5MVFhQnM1bWlXTi9QUXoy?=
 =?utf-8?Q?AhVCyIPwApppJmbg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED9895937033A94BAE66DC771C421A70@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	EAdYfN/YpSNL0Ghk4+BA0mk0WV6XTVXVWQEARFH6P3tCgUvtTgiWJxW3/eTrNX8LPQ6i/mJUCL7RZP+rJBu9nG4p7Q9vYdbMCKvEgNc/vr7orv2lg2Y0KDWrFpevDJP+MGHLjETWZ7LgfgIZDWy7z9NyTqeiTXnWryiT0vzZiXrH4aTsRVvQc4Twtxj4SD5fx2UZO16xe/AUsf8Bc0NYmx+GDUEGB/o2nstpP/C4RkkO/zaSwzl5+zlDbusED4cfxNWqET5xQh/Nwi898a54fJpVBsK19Lku7pFHM2vXMDUgolpPyrZW3Gn/GXcdg4r3w4yIQYOilEXeFhLxG8aLSQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VWta+ZojAwcuPHEFyeatbWBUNlphST0QvDf2kaDGQmKz04TEvEFnSSJlSL1La4pdgI85MJ0hxW/DB255Qaw/7ZW9Hv3nhz92JvBQLtMpHxHGE868wtq/jgot/1Av1w+c3cvbugkhGtGHNPxHZKbhT5xPEgfji98ILius1BrW3BJiWttM38Bxd9/ARIbZuXWP0S0i6B8rDJokWF8uFJXWInFzdZOXVDNz55KBV2OoXvG/3uTzknqyZ5a9oSBy5z8TRQGYEqvwPaWADte45LTeYqTu5KChtwa33sOtz/4xo7kPUz0cCnXEAqJsbc+SQADQmzXholdGEdVgq7qVuHdI7tYvoEIuGOTce8ebUhZ1z1eXlSLFww9YRIRoi1cO0kfn4cO8DxCyZj2ldWaonTvRuhOmqTmGnXwMkoDrxRKKQyB2+vaVWKrvf6UqA1hxXAX4oqk0W5E8CCDSMXSJ5C2IFahdO6hjDoElxHMblgQsIUCDd/9Tg95Cui2oNDEa5pDAjQOyMXYULdm4ufrxq8gwVlQe7cASa0iPl1HuazpkJZ4wl61ZeUnMg4reywgjaYlywsv46tb6l+f+GuPKpNJ8uyhaz/uENxib7bOS1rmo/qI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbd8de9-080c-42cf-7a13-08de862d9e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 03:06:01.9922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNaMeWftQjC40JxX32RXpBSgBpEVcOFZ2ErrWk2EJA2KsdbNclxFo3XnK1Z9agELZyG+drAG/jbVC2Hn9zb8xH8SkIuoc/HnNJwz3182pVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603200021
X-Authority-Analysis: v=2.4 cv=ftrRpV4f c=1 sm=1 tr=0 ts=69bcb99d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22
 a=VwQbUJbxAAAA:8 a=_hUUPP620HP1o1bBkjsA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12272
X-Proofpoint-GUID: XcIryXERir1tZAAH29AnypCiCSHr9RBn
X-Proofpoint-ORIG-GUID: XcIryXERir1tZAAH29AnypCiCSHr9RBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDAyMSBTYWx0ZWRfX7D5Ue9D7sr1V
 P/VAba1Q52/pBrpEbUeuL5ZN1KD2GYls7XwwbIzgAxz5NoDDtJnge5jgjWkNTprQFJ6lzxKyO1N
 GVJxKwZoehWphMReUGmLvGuCvR2AEUSGqwD+CFdzUaHn5iLnWLKRQ/7N1VG2GeLXBNWovUVyVgn
 nKg6WHe57CLkLkqSAR/zEJOwcTaIz5KvwLvHsB/av0u0MDTT/sdOzRdsn6vrO8X7Z40H380lRNm
 owDKX+OxNDGvOZJavb0ikuRQbCSi8MP2BlS2p9Vwk0N67ofJEUi1pjXozlFxfPWxqGFi+394bj7
 VwiYJnrRrR5mLOc1Z3NML//lJOlm30MWSG/9NysiBR8iVDAPsh16WfdQFRv47sMqG7fuVCRncYW
 yxetWtrOpIwN+fAirpaofsP/FHk/99jgHP6B3eN/Ar9W/YX4r7CQpfiYHmADgnMPoqaypTzVM91
 5KovbSwzlM3XMn2CZrBf77PXTRbb1pQdVeyCKpn0=
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18425-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 46B122D5511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTAzLTE5IGF0IDIwOjE2ICswMDAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IE9uIFdlZCwgTWFyIDE4LCAyMDI2IGF0IDA1OjQ2OjE4UE0gLTA3MDAsIEFsbGlzb24gSGVuZGVy
c29uIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIG5ldyAtYyBmbGFnIHRvIGNvbmZpZy5z
aCB0aGF0IGVuYWJsZXMgY2FsbGVycw0KPiA+IHRvIHNwZWNpZnkgdGhlIGZpbGUgcGF0aCBvZiB0
aGUgY29uZmlnIHRoZXkgd291bGQgbGlrZSB0byB1cGRhdGUuDQo+ID4gSWYgbm8gY29uZmlnIGlz
IHNwZWNpZmllZCwgdGhlIGRlZmF1bHQgd2lsbCBiZSB0aGUgLmNvbmZpZyBvZiB0aGUNCj4gPiBj
dXJyZW50IGRpcmVjdG9yeS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGxpc29uIEhlbmRl
cnNvbiA8YWNoZW5kZXJAa2VybmVsLm9yZz4NCj4gDQo+IEhpIEFsbGlzb24sDQo+IA0KPiBTaGVs
bCBjaGVja3MgY29tcGxhaW5zIGFib3V0IHVucXVvdGVkIHZhcmlhYmxlcyAoU0MyMDg2KSBpbiB0
aGlzIHBhdGNoLg0KPiBBcyB0aGUgc2NyaXB0IHdhcyBwcmV2aW91c2x5IHNoZWxsY2hlY2sgY2xl
YW4gaXQgd291bGQgYmUgbmljZQ0KPiB0byBrZWVwIGl0IHRoYXQgd2F5Lg0KT2ssIEkgd2lsbCBm
aXggdGhvc2UgdGhlbi4gIFRoYW5rIHlvdSENCg0KQWxsaXNvbg0KDQo+IA0KPiAuLi4NCg0K

