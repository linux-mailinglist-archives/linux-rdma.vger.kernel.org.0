Return-Path: <linux-rdma+bounces-13963-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A919BF7AC7
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 18:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 324AA4E50EC
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D754134DB4B;
	Tue, 21 Oct 2025 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K6mjX0jk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YbBOLcCl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE134CFD1;
	Tue, 21 Oct 2025 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064387; cv=fail; b=STYQ+lUr6plsgl8ltQ9XKqr6SpaUZFofBV/G1SizpGoCUIUHbWlItflFfq+50NWophG5xOZSs9zkSrg8SvLpPII34GibjJ+iZBM5UeYK4ol+oBGGP5aP0HG0FCDpDMB0ev4a54AgR4egDxPyuwhv9pq0lG+zKPTIiE+oXizPyrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064387; c=relaxed/simple;
	bh=AjgUzv4DF6WvbbEufbwR1iSrTu8/6CWp7dZ/GgiFcCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TQe1/NURV65+qELUrKbWZtLP5GUF84z9NTPV74reQPnZAO8y0Pbty7OySsryb+4sca0db9FCnDOJ/FT40IgwQvbkQHEM4KMfF5pHR5sjhQsnrNIPuQ1Yqlm3TNWlQxmVtaf7SDuFlMM4W7X1s80cDGWiHs8Bag1B1dPmfHylp48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K6mjX0jk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YbBOLcCl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEIc9t031159;
	Tue, 21 Oct 2025 16:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AjgUzv4DF6WvbbEufbwR1iSrTu8/6CWp7dZ/GgiFcCo=; b=
	K6mjX0jkMQLlrCxyroRYG6tPLPFwYK/bu6XFJKmxcLVISTOUqyK4lQIqpi1+wOnB
	NI/3TsLQO09hdGQWSJ0zwq6ElvzB48eLqqachddD7/1wRlNVHRo7FYbjL0QpebKh
	bAwIHyGYBnOultboUTjPMcLGGEOToZjfuoy/pp/yYQ25V5k0qQ7DXac03/4ek5pS
	jLMWj4iBTKnNH31zjmXvY2PyIR3ot96mRsf+8TZ7AM/vdw7pLOxyFC1XrHvehJqJ
	vrft0i+jjZeDKRbTaBrL5+n5UFSQznyZBed8tnuINgMIhmW6Oj1AXVtOqc/we4+E
	ro9m+brAFQPP2RjRbw2Sfw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3esnxyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 16:32:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LGC5Xq009393;
	Tue, 21 Oct 2025 16:32:57 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bdava3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 16:32:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBZaaOeDHO2h4HAhLhHaZz6e11G3Xecd258HCkRdFz95JhrHiCYIgwy/HWi6+HauUD8yAKwGoN4owC7O/SqkLetMPOPhUoAfKXp1iKHuFiCGkgNT02POk9PFcpaqH8xR1G8pc4UdJzVSBd4XmpYvtjjsTiIonNDLK/qmy0JmTNk/2KGqhOZow0l4revISvG/yF5dxSvekZ99hsEOyJ4SV7hyXNX5S1oUgfKVy02k3AcyYBPk5VPLz8gedNPAAwo3ZCtDShVg38j43gDZ5N5NVuiB9KPxeWU5yFmrKLbaQYp/vX53GILhPC0d+uSVYLRkOmujtuA56XxgvEFs/0I0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjgUzv4DF6WvbbEufbwR1iSrTu8/6CWp7dZ/GgiFcCo=;
 b=R5+y69bv2RIOdZvQlUz/xchfZaKssjLe17Ld4n+5DOkxAiB8ufpGFNkWWn6PhgoJIIOcQ08H4yRdV8GoTur7nCD9lwqGnfO7rlIxMSQ2b6RdSUumVcOFMG1yhO3lqaRJBzxSaU9fMJy7eCI2ukVaewCSpzvUC73Px9yodVPp1XNLXEyX1B+Iw3rztWTvQgG0RYax9mOukgXCG01pL3s2mgwUQGcrg0EYREbIhz79S7hw3CADNaXbMvB37VC2VBc4vQSRtKNAsoBXWfpXi7Wsom0Rpgt4Are3lB8kVgK049Jua4Id8pj9vVswTUhQNB97ymhMmm76Zo6nSzRyJeDU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjgUzv4DF6WvbbEufbwR1iSrTu8/6CWp7dZ/GgiFcCo=;
 b=YbBOLcCl10EJlYZFjrQAJcAHNKNoYKRfa4oMS3tG+Ob15Lz46pKIJuKcXlqK+YaIwg57ZQHhtIGwUt7w13hw2n5axDDJBtE+bkiyLhZg5umBWkzilrTihSr3CdXrH6kc+n75Mfzejs7XH91IsndIQl68CNnQ6+raVSDHhLaElYA=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by PH3PPF44A241B91.namprd10.prod.outlook.com (2603:10b6:518:1::798) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 16:32:54 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%5]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 16:32:54 +0000
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
 AQHcI8zHdy1KL4KXCkyexoudDHS8M7SV4d4AgAAFLICADfC2AIAcdSOAgAL71ACAAFcGAIAAHVyAgAAC/wCAAVplAIAADUCAgAAIjgCAABXNAIAHwgAA
Date: Tue, 21 Oct 2025 16:32:54 +0000
Message-ID: <20B80D1B-6D11-446E-8EA2-5696FA66494C@oracle.com>
References:
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
 <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
 <20251015164928.GJ3938986@ziepe.ca>
 <CH8PR12MB97419E98111F553FCC117E36BDE8A@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20251015184516.GK3938986@ziepe.ca>
 <49A8CE60-DC8E-43F7-9620-D4D5F8EB2A08@oracle.com>
 <20251016161229.GM3938986@ziepe.ca>
 <6244F8C9-2067-4A8A-8DCD-02A4A2D117F6@oracle.com>
 <20251016180108.GO3938986@ziepe.ca>
In-Reply-To: <20251016180108.GO3938986@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|PH3PPF44A241B91:EE_
x-ms-office365-filtering-correlation-id: 97c71872-9816-4bb5-8df2-08de10bf7c6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ckxSY1RZVUtwTWRuVkpBaDJHcFdSdjdmMFRRN0t0aTRPSWVVZ2hKTzhEakNQ?=
 =?utf-8?B?bjB3bDVLV3F0MU1vN1JkTzMrNGUxT3NvaVVyeGF3OGJCeFNaZ1NvNlVJdWZs?=
 =?utf-8?B?bGlJcUw2UFNQVTB0TzE3d1pGUVU1M3RRRUcyYVJLMndZMFVkSVdaZzR6Ty9V?=
 =?utf-8?B?ZjE3cjN2UGZSTGhxVlEzZXF2UG5sc1hxVW8ybjZrWk5DQ2o0TzZ6bGRWVlJ0?=
 =?utf-8?B?WTRvdFljclNjNjdYcHkrSkdQVG43UzBWb0krd2VtVEtoOWg2R3FPazR2emlz?=
 =?utf-8?B?Rmp0WjlySW96N0tGYXZlYjJOU3RsWFg0UGFTVnJubFVkZlBuWjdzdUI0QWRX?=
 =?utf-8?B?ZU9DUXBHSkRxYjNqQW05UnRLb3hKRFg1VEVLSXBIZFlya1JLcVdUTkM2S21L?=
 =?utf-8?B?UlY3bXVmK2NFMzlNMisvaUVWd3F3SytwOTJqQTU1VGxmVEF3a09odjJ0SG5L?=
 =?utf-8?B?Z3VGbDBUYlVheXpXZ1pOaE1ETEt2M0pTM1U2TGlHUDkzeW5lMW96RDlwUmRE?=
 =?utf-8?B?MjB4cWRKZFhUelk1V0lIOTVvVXQzUFc0M3kxUGRsd2RuVFZjMC9IbDBzbE5L?=
 =?utf-8?B?Y3VMZTZTSVJDR2xEMGk4c0RnVG9SbjZ6M2FZdUEvZEZtbXFkZG1NcThaNU5H?=
 =?utf-8?B?TnU1ZndQT0xlM0N3NTUycjJEUHhPak00L0ZCZkk2MHlFU2t4T0ozVkQ3OG8v?=
 =?utf-8?B?YmtrZFBQb25PR1VOckM5T0lFdVVVVHA0SVNoOWZzdGpVcytRTm1uYXVJK3Zp?=
 =?utf-8?B?ZXFKVjlRNTJOWnFLTWRIUlFlYmFZbitjaGxoUDZxVVZzMU1sZmJ6RXA1Nk8r?=
 =?utf-8?B?TjlxWnV0bU1QcElYTHp2elhlTnFPSC9iSUVwQWhVQ3ZGVGdyVjRRZm0vZ3d3?=
 =?utf-8?B?aEdQR3k4Q2VMWUtmWXdPTUhlb0F5TDZBQUxwSWNGaVVTVXBZMytCd3ZXN0c3?=
 =?utf-8?B?SnpUNTBVWUdqcEJrNDNFc0J2eXd4aUJnYi9qeGszWUE1SGxrRXF4clQ5Q05J?=
 =?utf-8?B?SlFydnRjRUJNWjhQVzdLT3ZiWVpIUlZJcUp6SE9qZ2xsMTZ5WVpLMjE0MnM0?=
 =?utf-8?B?aXVOcU53akQ4OTVDc3RIQkpDTllNNTRjL0QvYzdCTEpTZjdwNlI1cDZ2QnBI?=
 =?utf-8?B?SWRGTzMrU1h3T0htZzdpd2k4bjVVY0FISWtsaFNVbFdRdGhlaUZpbkJaYVBo?=
 =?utf-8?B?NE9xV25SSkI0cmUxVjhEaTF1Z0R5SDZ5eXVWWS8zeXZzL3pPa0pPM0FmTjhH?=
 =?utf-8?B?S1V6dHUwWW5tZHlodW42eGdmR2IxS1diSHVBaks4c3ZRejh3WkRrdFJ1Zkhx?=
 =?utf-8?B?MG44aGZYOS9QNzZCdWlWMnlXUzM2blpUT3Y2UXRIYWFmMnJwczBNK0tPOFI4?=
 =?utf-8?B?SzEzbUFRNE9RdDhnc3FsYTUwY21TSS9PeVM3SkdZOWFza0ZPc1p0YitOU25X?=
 =?utf-8?B?OU9TdFVBelVWM2hPc1ExV0QyVzljL2RkUGN5VThTbWVCYzMwUmVWTkQweXlm?=
 =?utf-8?B?ZE90MkNUMFZyVk5HWTBROUJPNXJpWmg4dzc1YzFmWjMwaXFjVlo4VnZ1Skpa?=
 =?utf-8?B?ZHF4N0NjektwaW5oMEhTYU5sYkRMK3hhUjZmZE9IcGo3ZURaQ01UNm1abVVX?=
 =?utf-8?B?V1dMb0k1dXBMU2FEL3UvVURDMVUrTmM5ak4vdEQ3ZlZIOE41cFZTTjFRaXdU?=
 =?utf-8?B?RmhIbkNRczkxNVEwNmlpRTJQVHJNbnpJZnl5bnFqMjNnL1lSUkh5VXZBZ1N4?=
 =?utf-8?B?aFVWV3Q2ZUkxbjd3cTJKYjROTWkzbEc1U2xqaXczaVY3VFIvY1JjVFhvSThC?=
 =?utf-8?B?Rk9iWlk3T2VZdHNKeWlsTEkwRUJ6R0hJbC9oNXEzeDdJaDVUcEg4SVJyVW1a?=
 =?utf-8?B?UmFOTVBub0dsUyt0VURSeS9jK3FsUytPYi8zbG5wdThXZ1ZLU3RMMVZVeUlF?=
 =?utf-8?B?ZFB4Wk8za1FyUmhWU1V4VFcvWVdRYVZpWXVReTcyL1pYbGJ1NXZRUENOdWcy?=
 =?utf-8?B?RWt6TWlkeG81M1hZQVFLWUFmK0VPOUVrcHMyNm9IVVF6Y0E3bHplRFUvKzEz?=
 =?utf-8?Q?VG8lb2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0ZkN2lrYnV1RHVEdXZnc2dpZFduM1VrSWUxVHhxSjd0L2ZyWDJUc1ZWc0pG?=
 =?utf-8?B?VUJUaThDSE45d0I1SVgvK0FVazAyN0dON0lsUXlLcDFtajlCUkI5dHc5VjJV?=
 =?utf-8?B?cHgyZHN5enE0d0ovQWRrUll2dndoM1hpcjZjWlY3MXdUQlU2T1psSnJ5N3I2?=
 =?utf-8?B?R2d0cjV3SGhTTWRLbTV0MDZzU1pzc1V1YVJpSDRWTmZ2UjFndUttQ2RjVlBG?=
 =?utf-8?B?UGw2c0E1VkJrWisrbW9iSUhkSWtYVTlzM0laWmo3eTFDejh4c1pIaTdnNlcy?=
 =?utf-8?B?by9wbDZEeEpyOTR1UEpQOHIrYkpXY2txcVA5L1JPZ3dBOEdITTEyZy9KNmtp?=
 =?utf-8?B?Q091TU80amN6ZmY0VTI4VVZvVHdaeEZ1OTR1ZTJ0Wm8zZ3VPT01udjgwbWg3?=
 =?utf-8?B?UXJhTWpQRWVZL0lZNlFjTkZURDVlSUtwbDB6ZTIwb1Ztb2dNanBPRFRUSjB2?=
 =?utf-8?B?NFVGTW9qQ0Q3STFzSzJ6UHowdHZiYUVkSXR1QUFCWTBKUXRScFovVXRoVFVj?=
 =?utf-8?B?NDZsL1ZnZElVaFZ2cDFBL3V3WHp6MWNETnZiVTlxWWk1eVhoeVpFNzAvZmYw?=
 =?utf-8?B?S2k1M05xSEZjT2dvcUtKV1pNSHhoNmlrUFZPWlcxRk9aNlc5Q3R3U2ZxNnE5?=
 =?utf-8?B?VXZFTWFFejRldzdWTlpHSnNlQWFKM2dWa1gxV2FtcVJVai9xbnVrRFZuVXhE?=
 =?utf-8?B?c2pJcHhuMHprNXJkcjl4WC9aVXgvVHZqU1c4dWdCeXBwNStVbWRDMVE0OVNW?=
 =?utf-8?B?WXBGSzNIb21OenpiVkhROHVkL3dDaHVIN3JQeks0cVdZRjNCV05SR3RkSEd5?=
 =?utf-8?B?S05keENDb2l3SzR6R0g0RWt5QXJuZm1CNzhVNENpd3M4VVpkRkZIVHpPUjM0?=
 =?utf-8?B?RXlybnI0N2RvdG5kb3NDMHN4SGNIYmVxZEw5SHM0V3Y4UmU4eFB0QUNMaXRF?=
 =?utf-8?B?eWlQd3JGYWpmOTVvWStQZ3FpczZCZlJzcm5XcFBIaGl0YlBaQmd3ZVpGdmRL?=
 =?utf-8?B?TVhLbWQ5V01oSUVZNXdqWVZIeWcwbDlsM0kvOFREa2J3R3BxS0N0UXNubU9y?=
 =?utf-8?B?eU1FMFdwRUU5TDJHUFZuSFg0TWlxRWRRdkRkVFBSZkRjbG9DdHQwT2hSMzRM?=
 =?utf-8?B?RWx1OTN3NkVMZTUycmR0ZEhqZktoNmN3K2ZKR3RWTHVaV3dOVHIwZmxPdnZa?=
 =?utf-8?B?SkdiMmNxQzk3bmNZL0dUUExFMlFHMCtDcVd3TUhEQXFweDJCdXppc0pmQ0RU?=
 =?utf-8?B?N0NGZHFGanFMSkg2alVXZUlFaDhqbksyY20xbnVKUWRMVWlvbzJsdWswbUZv?=
 =?utf-8?B?akhreGNuNUtoT0xaU09Dc3gxUmJkaitqeVAyMmh5dEZGRDdsMW80Y3kxRE5a?=
 =?utf-8?B?S3h4S09oSXdONDcxMWZvakgzZ3JZRmxFeGgxY1VBU3BTUkFuNUhjWGpFN1dK?=
 =?utf-8?B?ZzRaODNUSThzeHZkR3h5aDdGLzNFVURGeGF4OFVUUGRmZjF2RUF0MGJSTFRT?=
 =?utf-8?B?MElCdFU1cmVnUjhIVmNmQzFIKyt0WFlrckVVaVVyU21XSVV2K2FlLzZhUk1I?=
 =?utf-8?B?K0RHZXgvbnJ0NGx5dmUvQlUvV2Zwd1FFL29yaC9GVE94a1NETUhkUXpoZ2xn?=
 =?utf-8?B?YmM0VEtkeS9ialgwdUpSTUp3YUF6ZlRTb20xYkF0NlRtM1doMWtCYzJBanph?=
 =?utf-8?B?djhQTnZrYkFmbU5TYVBNMm0wTXZ1ZzBkeWtHV0FHRTRzaW9hSHJQSVF6VzFT?=
 =?utf-8?B?UlozZE5UbmVaaklTTjNYQWtaK0RLSFZFdi9XZGFaV3dNK25IZXNzU1d4L0Rh?=
 =?utf-8?B?Y1RGVUYrc3NRWUpPTmFpNkFiREdlelpYMHI0V2tuNGhnTzBFKys5ZStSckpy?=
 =?utf-8?B?TjdnWFR4OTRYMXkvc2xQNzBmMkJHckNBTy9FSkRnMVhiOTg4VkJGS2ExcFVF?=
 =?utf-8?B?TCsvTkdYLyszZmpaMlNjOEtLbkpQMk4rQUgrSm5CTXVndEhjSE5sSjk5c29n?=
 =?utf-8?B?QTBBeEFTOXc3Zkh2bk5DdjBwM0lsSG5malVmZ1FyMWd3bXM4bjFkWDhOVlE1?=
 =?utf-8?B?UnRFVXZmYjliQTFSZVU3ZGRnNDdqTmVnNzhpRUE0eEU3akIxWTExaGc1Vi9L?=
 =?utf-8?B?NGpRYkd6bkRJTkFlTE9NTmlTZGEzcEZzL29TaHExNWE3RFpiWDNrYmFpNW1o?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <363A68321D0DDB428258E50F79ED087D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	giFAydkM16LDMw+8WOu4AGA6lRLQ0X9Lnwb1+nME0maK4N0amljx17x74CKUk6uNQnnLuYGL+PIp9/OsZlIQzRRU3IAO20TR1ZWnkiUkltfM7OtQlDavlv0mv/cMqW4U93UfLmqwcFRlg5gGmelW4lCNqkG/uJHsPqlabbrn5O9/E/X827B9B3Hsuo1HlhHFSJJGwc05lyExYAHfZKLV9e8MV5qIZ/Od3nau9kayNwdSJHDEq+Hy5TJ/yKZyeXfyR0SYxWvOYFCGtdwdPoHzHIzpN+6GMJ/RhgYOalJ+uk+47tNun5zvi/ESG60T2aprTnna+/ThVXBuujcMOUjL5x54pBoUPjxZZZhfxLXB4c9VfcYjdLv41W8vdaAi5FsLlTPnwYm0MDGmoNKDSJju49E/N0oRbzHkO+C/djsT6b75vToNFulEjMgmcbnilni8XVs8Q73J2uzbaJUvXqU1wI95sdJxyJ6HncxTMRVsBYBYKYFEr8K2CvDP31roE1YCb5LL1OXb/D+G/XOGw8c13csILdfZjzVTZKI0mOPlI/UdS0VdKguoNc+IS9A/geg4pkyplFeCIdDI7aPd9QXsC2on1kYstStQ6nTu7p8a/B8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c71872-9816-4bb5-8df2-08de10bf7c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2025 16:32:54.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uv4zh1j0nBCnVNQRfoGJ5Aa32LVgMCkRX7VBGZSgdgtKppk6wXk+t3lHvKwAOsujgdGSW/MrhXf7UW4kFVlE0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF44A241B91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=985 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510210130
X-Authority-Analysis: v=2.4 cv=N8Mk1m9B c=1 sm=1 tr=0 ts=68f7b5bb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9jRdOu3wAAAA:8 a=5ns0EU3vDk4HAzMnoEAA:9
 a=QEXdDO2ut3YA:10 a=ZE6KLimJVUuLrTuGpvhn:22 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: 6vOAV2spUZDLdnmmUku-_nGvqYlOnwbj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNSBTYWx0ZWRfX4CBlv+3yEpIc
 /fw9L2oJcJmOByw5mMhHeOrkUqL1HyT1J3RPxeGGkfOK/AiGD2q48vxyKcrYesDtL5ZXrQFPuKF
 UeTZkrnhi5FvlfaSVz7HxwiLQ00J+HLxh7cTI/yAb6hHnaGGCEgHwuRXYWAz/2a1F1t4ilvjnmU
 ywLTvhQVhL6BsdhQXip8zJcT+YgoApkxkbrJqgQX2tpD6j4UWV8EVL/qfq9lyqAOP7TzO7yqOxV
 V+OERrZANjkuhFcfjtZSj0KdjabQAQeauZTHjjocYMkEUA0fF8+QPP8R6RzxTt/EHg3NcIYACrR
 m3OJz1I2zwHjpF1nuw2sEDOWsI44cEuH3OnAJkwvlbdsg0meNbO7cwAuRweg+YKxTmZdEI7PSie
 A2cVnEr/lP6uj84sHQQNijsZlZen71Zy3nMqDVLeDjizd3zAsqU=
X-Proofpoint-GUID: 6vOAV2spUZDLdnmmUku-_nGvqYlOnwbj

DQoNCj4gT24gMTYgT2N0IDIwMjUsIGF0IDIwOjAxLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE9jdCAxNiwgMjAyNSBhdCAwNDo0MzoxNlBNICsw
MDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+IA0KPj4gV2VsbCwgSSBzdGFydGVkIG9mZiB0aGlz
IHRocmVhZCB0aGlua2luZyBhIGNtX2RlcmVmX2lkKCkgd2FzIG1pc3NpbmcNCj4+IHNvbWV3aGVy
ZSwgYnV0IG5vdyBJIGFtIG1vcmUgaW5jbGluZWQgdG8gdGhpbmsgYXMgeW91IGRvLCB0aGlzIGlz
IGFuDQo+PiB1bnJlY292ZXJhYmxlIHNpdHVhdGlvbiwgYW5kIEkgc2hvdWxkIHdvcmsgd2l0aCBO
VklESUEgdG8gZml4IGl0Lg0KPiANCj4gSWYgdGhlIFZGIGlzIGp1c3Qgc3R1Y2sgYW5kIG5vdCBw
cm9ncmVzc2luZyBRUHMgZm9yIHdoYXRldmVyIHJlYXNvbg0KPiB0aGVuIHllcyBhYnNvbHV0ZWx5
Lg0KDQpXZSBhcmUgcnVubmluZyB3aXRoIE1VTFRJX1BPUlRfVkhDQV9FTj0xIChpLmUuLCBvbmUg
ZGV2aWNlLCB0d28gcG9ydHMpLCBhbmQgSSBzZWUgdGhhdCBpdCBpcyBvbmx5IG9uZSBvZiB0aGUg
cG9ydHMgaW4gdGhlIGZ1bmN0aW9uIHRoYXQgZ2V0IGludG8gdGhpcyBzaXR1YXRpb24uIEFuZCB5
ZXMsIG1sbnggdGlja2V0IGZpbGVkLg0KDQo+IEF0IGJlc3QgYWxsIHdlIGNhbiBkbyBpcyBkZXRl
Y3Qgc3R1Y2sgUVBzIGFuZCB0cnkgdG8gcmVjb3ZlciB0aGVtIGFzIEkNCj4gZGVzY3JpYmVkLg0K
DQpJdCBhcHBsaWVzIHRvIGFsbCBRUHMsIG5vdCBvbmx5IEdTSSBNQURzLCBhbmQsIGFzIHJlcG9y
dGVkIGFib3ZlLCBuZXcgUVBzIGNyZWF0ZWQgZnJvbSB1c2VyLXNwYWNlIHJ1biBpbnRvIHRoZSBz
YW1lIHNpdHVhdGlvbi4gSSB0cmllZCBhbiBGTFIsIGJ1dCB0aGUgUkRNQSBzdGFjayBpcyBub3Qg
YWJsZSB0byByZWNvdmVyIGZyb20gaXQuIFNvLCBmcm9tIG15IHBlcnNwZWN0aXZlLCBvbmx5IGEg
cmVib290IGhlbHBzLiBJbiBvdGhlciB3b3JkcywgdW5yZWNvdmVyYWJsZSBmcm9tIGEgU1cgcGVy
c3BlY3RpdmUuDQoNCj4gSG93IGhhcmQvY29zdGx5IHdvdWxkIGl0IGJlIHRvIGhhdmUgYSB0eCB0
aW1lciB3YXRjaGRvZyBvbiB0aGUgbWFkDQo+IGxheWVyIHNlbmQgcT8NCg0KTWF5IGJlIFN0ZXZl
IGNhbiBhbnN3ZXIgdGhhdC4gQnV0IGZyb20gbXkgcGVyc3BlY3RpdmUsIHRoZSAiZGVzdHJveSBD
TSBJRCB0aW1lb3V0IGVycm9yIiBtZXNzYWdlIGlzIF90aGVfIHNpZ25hdHVyZSBvZiB0aGUgc2l0
dWF0aW9uLiBBbmQsIGFueW9uZSBzZWVpbmcgaXQgd291bGQgcHJvYmFibHkgcmVhZCB0aG91Z2gg
dGhpcyB0aHJlYWQuLi4NCg0KPiBBdCB0aGUgdmVyeSBsZWFzdCB3ZSBjb3VsZCBsb2cgYSBzdHVj
ayBNQUQgUVAuLg0KDQpUaGF0IHdvbid0IGh1cnQsIGJ1dCBJIGRvIG5vdCBleHBlY3QgYWxsIG90
aGVyIFVMUHMgYW5kIHVzZXItc3BhY2UgYXBwcyB0byBoYW5kbGUgdGhlIGNhc2Ugd2hlcmUgYSBD
UUUgaXMgZXhwZWN0ZWQgYnV0IG5ldmVyIGNvbWVzLg0KDQoNClRoeHMsIEjDpWtvbg0KDQoNCg==

