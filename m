Return-Path: <linux-rdma+bounces-13870-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8EEBDE4AD
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 13:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4E919C43F6
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 11:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EB93218C9;
	Wed, 15 Oct 2025 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dmtD6A3U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NVO504XQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94043218B3;
	Wed, 15 Oct 2025 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528310; cv=fail; b=TORJZ2vqjX3ZvYjm67+Q70jfkk7Gn1Rnh2sXcYLbpolZMgr7Mokm8T+V71rkBY6OOyRXD9zPlq815BJ6MSlDrAKOMQOztKMgmIhrdug7feZ6kacRR2sEm2XY2GKYOTUO1FwV2bc/DL9yN7HPZdCjmLX1GuNjHJmf1oA56YPpAOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528310; c=relaxed/simple;
	bh=5UVpkX/EyA0lTNqGzfCiaWXiQatQ6os7S8R/6w/Goxg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VCT9QBURNV+NW/TqMFIuW5cRE7QtSjVwSiGccW0KAChz4w7Gnac9SF/eYLor9koIg9Com+xj6wDE1SrJWc+bMKvycUIo9RatH7PIalkqh4d8rABmzXIDPuOxAooWlwVMDEqnIjkOiBmrbua6lKCdduhTGIwJ+sENs25ol8l+fiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dmtD6A3U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NVO504XQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F9nlx3026440;
	Wed, 15 Oct 2025 11:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5UVpkX/EyA0lTNqGzfCiaWXiQatQ6os7S8R/6w/Goxg=; b=
	dmtD6A3Ul3czcduaCTGyBvMfS5J7G/5FhOG15boFMMiCwCreFGjBK7w+1G6N/Rp4
	bM+MbT8EPSR21i2GvuBV4LOMglmdOfIp8T/Asx02e8CifXGCPFWSZhk9N7+Cz+4v
	ULAhG5l9c6w3e5Nsd9bLx6ubrdmWlsrQXvkkYK+e1YjwgQV5esdwlcTovwCN+u/9
	leZ9367QQJxEEXP1XtHO6/1mZIlJPCgSHUwvUhaUrFHzoje9V/uy3y72/+/fqlkJ
	Z7lWinuujtGrFjksnkVwgUDf720ZtS6ODo+HvefrpiTDK4Mdgg+f2V9iXKbC8OUG
	NI+bhY8S4D8yURy6aO+Bsg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9bxgfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 11:38:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59F9NbTG025655;
	Wed, 15 Oct 2025 11:38:14 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp9yypp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 11:38:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyrjOIMZKQrXy28gjdifFaDkTcKchjoGqWscG5j9NuPzLp5GkMgixUiYQyy/vNIHQdW5g7/KU57FBM0WP6FsAk3j0jntjTdEQ/ehtEriYdHZUyE63nMJWr1xC7UEI4b2qjtEXQsb0qYs7oITTVJu+JfvlM6EGBdLCSzSwP+qGL0k61GYPuvsrQCQFtNIE/j5Z9Z8FQuW8GUoqkfmHfroe4tiO4l6uw2mu1LiWef5midsV4kJDKKGeAU3V3yTHFDlkiRqnP/peOFDOuF/Am4OQNKbWuhc24TvvrbW24mErIiMN3oDGlsLkF1f6BKOB6JIlzuAbWrTcB6AoV7huUxpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UVpkX/EyA0lTNqGzfCiaWXiQatQ6os7S8R/6w/Goxg=;
 b=I19/0L1rPR8vHZi1SRCQoGNiztBcoXW+meGq0oTiryT/Ryb48lxwqPwlGutgVkjqOzn05f4lRsCkghbrAWHxpkqxcHgzsbf20GgH5CFbNX39my8n9Y2DR574rwqCXk8dmQROoq+Pp3Gi8l3k6reW0wQL6WSzzkKZxVgwwY3nUkfvggEB3IhmMmC2xHBvIRbG2wceMmAiVkXToTVdrRbBCJiZhohIDiQyUNo4gD1vKeXiWohCcQ9i5P8tfGnnxCL+PRX1jjdKwTzK+/aHgm/+wMed0wrtShyFuvQEsntI98o3V3FWLc/nh9HCnV90iyrl1sz6m0tLZDg7ksYe4zv7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UVpkX/EyA0lTNqGzfCiaWXiQatQ6os7S8R/6w/Goxg=;
 b=NVO504XQWimqASktD9NWgQyy27DMnutk3hj83GcSn7M9SxPKzwzW54o+CQMazL/ryF/fXVitmKQcgrFSYrT+0uMbdLqXyXuIOjezMmuCz5PmKJspSrEM7Knon3ACSiew/OjrX0gVfEESa3zUP54KqnP0r+A0KXIb6tjXhlXTub0=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by SJ5PPF8DB18B996.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 11:38:11 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%4]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 11:38:11 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Jacob Moroni <jmoroni@google.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sean
 Hefty <shefty@nvidia.com>,
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
Thread-Index: AQHcI8zHdy1KL4KXCkyexoudDHS8M7SV4d4AgAAFLICADfC2AIAcdSOAgAL71AA=
Date: Wed, 15 Oct 2025 11:38:10 +0000
Message-ID: <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
 <20250916141812.GP882933@ziepe.ca>
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
In-Reply-To: <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|SJ5PPF8DB18B996:EE_
x-ms-office365-filtering-correlation-id: c9d6a863-bf45-4d7f-9785-08de0bdf517b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVh0YjlKaWdWNm5EV1NHRG1SaTFNZHJWUlBldU1HQXpKakxVRVpiR2NzdDhG?=
 =?utf-8?B?ZUlES0xRNVNtdHptWGdQMjl3cm8rOTlzem9qdW1xNGJFVmJMb0RCS0ZqSC9p?=
 =?utf-8?B?RmJOdDJsbGJMV3Z4Z3g3MTVnT3E3Y0RlcVk2VnJUd0RkWTNCRWtmR21oV0Rl?=
 =?utf-8?B?UGxreXF0ZjhVWk9JNlRlMCtwYWdYTVFWcEdPUFlmNS9hSzVoS0ZtT2lUK3kz?=
 =?utf-8?B?dERXeGhQZWR3Tk50Y0IwWUVsYWU1b1B2Tll4ZlZ1SHduVFF4NXlKUEhZSlg2?=
 =?utf-8?B?NGIxZDJoeTZDKzgvaXFMb3JwNlZpNjA3NmZBZTdLQjNsTWR0anJlWnR3ckdi?=
 =?utf-8?B?YzN2VVJTWU9DOUNWbnB4K1dKUTZSQ0J3MzI0alFpNjkrNzVxRG9INlp0NnhU?=
 =?utf-8?B?VE1KcEttTDVSYlBYd05XOHUwZGdJK2hFdFUzV0l0KzJOYis3LzZqZFkycDhz?=
 =?utf-8?B?Zkg5QzJhMytqMDZXWXZBOFhXV0ZlajlLYmVTSUxJRENOTS85YWRzQWxzeFNM?=
 =?utf-8?B?V3hYMXFKYm5tVWVSWnFoWDRGa1BJTGZWK1FSY1k5RGpRU2tCVDZVc1RPTzZl?=
 =?utf-8?B?VTNEYUNqVnVKbGRZNFpYNUpMRk53Y0dUeDczUWplWjhwdTNkcWo5SVJidW11?=
 =?utf-8?B?S1N6b2ZXS0E0QlJwY3pNeFdOc1hZT1E2ZGlDcWFkSzlibWp5dFJFME5Ja2xG?=
 =?utf-8?B?VDVZMEl2SmVWS1AzM0NvVzhONXY3cEVPVGZOZDRxUEwvK1doVVd1R0NENnVH?=
 =?utf-8?B?TU9taFI2eTJLcEtZY0NOK216UmliUVZwYVluWEtZNHEzeEdpb3BkY2dRV0Q1?=
 =?utf-8?B?aVJ3cnRXYVhhaEFRbkN6NWp4bW1Vc2hnZkFMbnU0aXpkMFdKNXoyRjh0ajlh?=
 =?utf-8?B?SWlmVzJMU29hckI5U1dnQlVWbjEydHZ5WGNteGs0MVNuU3M0UDJhbFV0MVVJ?=
 =?utf-8?B?ekM5TU1hRWJyTEsxdmdXbkNSSnBlMmUyRGdhc010NFFkY0lVMjRxdG1NejAy?=
 =?utf-8?B?ZkNIc2hyN01vZ3R3VWZQRFJTUnRobW9uNFJBKzJIdStnYjdoZlN3NVQyVGs0?=
 =?utf-8?B?MlNiQjRYQ1hpZjJscUNjSzJwVHRCUzhVNFVNeVlPT2taOWlxV3RBUVdWMmda?=
 =?utf-8?B?SkdhZWd4Z0ZMUDZTU0xZc1laR21PTFU2enpTVFh0Ym5icnhYayttVHd1SE1N?=
 =?utf-8?B?MGFvKzZGRThjMWUvUFk5Z3Y4U095OWt0TEYyZ2Q2L1hUVUFueHdPd2diRm5s?=
 =?utf-8?B?eDJFa3RmVkNnT090bHRiNXVFKytUVVBtZzZNMXBZMTJDZUYvcUJOejZ4REgr?=
 =?utf-8?B?WXNTY0p6b29NN2RYZ25icS9MSVhWT1pBaUJGNmdKZzlLNzFkNUJPaUVVQVZQ?=
 =?utf-8?B?NExMdE1QYXFFcjBBNmx4RDJHR1MrUWF6NlczR3ZZTENOZHFsZk5HMnM4dXpv?=
 =?utf-8?B?M0FaVDRaam9CUHNhUDBVNC9pUG5qWjFUMVZXb3FlRS9NdW1vRHYram5iVURy?=
 =?utf-8?B?L281TEYybXcwU25JOVpMNmluYlRLeVhrc2pYM0cycUI5RXVra0dvZFF1c2Jy?=
 =?utf-8?B?cmlDNVRKQ1Q3SEZUOFcrbUFvRjVRYmVvallYeU9mUXYxNWtjMExTbW9SalVZ?=
 =?utf-8?B?K3RKR0pFbWIxVzlGL0VNVnJPa0VVSUZtNkZIelpoQUFYcnU5UEFwR3dIQlZD?=
 =?utf-8?B?R3pXV1lIQTV5UzRSRXU4MnhTTkU1aURDQW5LTDBQQ3dNS2E5eTRNdVJUMTd1?=
 =?utf-8?B?SXFtWEo0WXZLdVQveGZ2RzhERmpzU3NmQTF2blZ6cGE0WlorWVVqdml4ekk0?=
 =?utf-8?B?OWsyZzdGMUhaYlhRM1FObnVzK2lyNThpUUhuenpMa01FU0ZzNW90ZENaV0lo?=
 =?utf-8?B?ZGdLSURXZ1RuWnhlNlpjRDBYcSsvWEhDbU1rT3NMUmtnd3dNSm5lM1hZaUF6?=
 =?utf-8?B?QlhibFJtRDVGSGRtUkFHZUZ5TSs1elhFbVF6NmVKQ3NQMHI5dmNLdVQzSkNs?=
 =?utf-8?B?TmlCdGJWbkpROXo2QXJzVVMvRVNzaU53ZEdxdWZPNnpUNFBXYm5qVmNYZlpC?=
 =?utf-8?Q?3Vci0k?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkZoc2oxNVc1bnRFZ1AzL1FDYS9mblNoUFp6bnphcGZtdFBxT1NZbEFUclZ3?=
 =?utf-8?B?WTBjaHZWcW1uUTlKL3l5QUlodFJqOWJiVGdBYkZzeVFmQVhqbEJlUExlWnlT?=
 =?utf-8?B?NTA4MUduanJFRkRSdy9vTmlGTW5SQTg1K2pNN2IrQkxZK3dKZ010dHJ5c2ZJ?=
 =?utf-8?B?UnNkQkZ1QXBtUHV2RERueGVreWZhVzI3RlpiYVJwZEJwcEJXSGRaOUdNZGJy?=
 =?utf-8?B?UzFzbW1kZmRMQnN1d3drV2lKTHRHK3dleHFpSmpvd3BLZmlnem5MQXd2SE5L?=
 =?utf-8?B?b1ZEYm1MZDNVRU40S0QzaHVXUkZ4ZE1zZTNUeTRZOWtJTUJ4bUsranNJaWVJ?=
 =?utf-8?B?N0RxNVBEb3VFOE1IY1IzeC9OU1JMblZpLy83SWtrVjBmZmNrQXpPSk55dklx?=
 =?utf-8?B?ekt6VEh3RHRMbTMzc0tCc0o3ZUhUc2QvWDc2dXpoM05kRDhzb0p1dE9kVnBV?=
 =?utf-8?B?SnZiUTlpcWo5bUpUUytMVVNIU0MrZTArSGlYaTJtOHpGcUNmNE11dFl3azV2?=
 =?utf-8?B?SGdpZEoybUt6bmxUZXppVWRLZ2FqVDJEYUNRNjV6ejVnL2xHTXlreEE4VTYz?=
 =?utf-8?B?RndETm56VzVPeEhnYkt1RFpEcnE5dWw2VWdzaW5MNkMvQzNINWU1Q1NMT2l4?=
 =?utf-8?B?MWIyTytSTjlVYmJhOSswS3lIdmw0QnZmSzFxZGcxWjdMZWRYdzF1YzU4aHAv?=
 =?utf-8?B?cCtTaVhtTVFaZnVpQU1NUVNVVElKZmJxNy9KbGpIekFNeGtoNFlxR204MXI4?=
 =?utf-8?B?MFhRSGQxdlE2Snd1NnlGZVZ6djc3NGg1cXdaY0FwNTllWnhEenVTWlMzY2wr?=
 =?utf-8?B?emFZaCtTVHF1YnI5bDBtK3dUaVpPWWh0ODhsZDNBSnpUV2p0WFlpcWN6S0hu?=
 =?utf-8?B?UmtXSFBMeXBFeE51cnNHZ1Y3MHV1RTVDS0dGcktjTGp4bkxFWkJ1Q0oxUVNO?=
 =?utf-8?B?TXZiZnFUVEFxS2trcU9Neng3cDE4ZC9WNVhRaE83VUFpc2JEWTZON0JNdlhI?=
 =?utf-8?B?MFYxZk9sL2E1Y2tFYTBMbzVEWHgyN1hPUmptM08vbkZBa2ZhZHdPeEliR2xq?=
 =?utf-8?B?cGNrZWM0MmNtWVlhcldaSVhGOFppSGsrMGY5aEZBVlZEcHhqNWE1QlhMUHNK?=
 =?utf-8?B?ZmF0MXBkcnZoRTNPSjl1cjh2dXFPbmxPL3RRaHN4MkNlV3haSXh1T2pXaGRU?=
 =?utf-8?B?RWtNT2pVTFZvdnlJQUhLMDlSSVFDb01sTkN4ZzVtbGVIcnFidUIvQlZNSk1j?=
 =?utf-8?B?Uk8vUzZySXl6NHdTdU1jQ1YyNHRZSHV6VitYNWZEcW96MG5sTjBHUXNaSXFq?=
 =?utf-8?B?MktoTENodkt2cm0wZDEvVTg3VW9jUTYwdEF0b1hvNnNhZWdqdGVQWkloeGNs?=
 =?utf-8?B?OGxNckd2ZWFFQUtJbVIrc3Zlc0NOWWV0Z241SklyamRQdGlQWFJ5U2JLaTlk?=
 =?utf-8?B?TzdycGIveGpCZmlYZ3JIWEt2bGJhRjFSUDVFRTluQnJCL0NGdWxsOVljWHF3?=
 =?utf-8?B?WC9HL2ljM3VxeXk2RDlqUXRTNW8rZGlnQ0wwREZJTlB2a2lJY0RTWmZCQjlm?=
 =?utf-8?B?eUdJS1R6bFF0N25uV3hJTUVvSzArbjZERUVXZ21URG1VK1FrbnJXcThaNlc2?=
 =?utf-8?B?ck1WZXQ2S1RWRlVWSUxuVzljaW9hWDFTa1ZYYWtZQjRsVGdxeklGRVEzTHhP?=
 =?utf-8?B?MVRQVTd2TjF1UHVnV1loWDR0L1dlcG9vRTY0T3VIeWtGbmxoUDhKVERsa2Qr?=
 =?utf-8?B?djVGdWdybTAxODZvSWdMTmd6U053VzlQeTRFNDFWY2h4QmtyV2RIUEJuK0xk?=
 =?utf-8?B?YStmd3JoblpnNlM5UXpTc01BZ09HSXBwb29YaUVFR3d0Uy9wZDYxN0J1NFZm?=
 =?utf-8?B?UnE4dW0vY3doUFBXTGVoL0JXNnA0dE1RbFg5NkVGRU93YXhvLzU2U1NPdy9I?=
 =?utf-8?B?eUcrVytRalBGRHBEVUYyRmFSZTZ3ZjJSZnpxdHp6cUlXSlIyUnBYaWd3em9X?=
 =?utf-8?B?Y1cxelJwVXlYZ1A0WlNOYm5ZNnNtNTRMNnhRblJFUk1uSndzb3dwY3JkUXhp?=
 =?utf-8?B?cWFKUFZxWU5kS3RxN2lYa3ZUOTZWekM0VWJzK3Z1a0I5RHVEcEUzU3J2OUtL?=
 =?utf-8?B?ZVBxeFUxMlN5cEo4Z0RIODhtd3FWMG1iOVFlQzl1N0ZpY0YveExQZVUxWVlO?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74315050B3FA74479BF62AD0D9A89604@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DHVdidVoLdvq+PzX9A+VHnQDIGVkwTjFYTcs7ts019S/g7FR9jpe8qS8L+3d4dTtjeLzHdcb4dyhbs53Fjx2QI/FO3vXfXeeA6msIrstugOzmwq1IaUErbSP6k8cWVPD6gG1C38pP1d1Q1MFsEduDeb0Nc7dHIUwUbGMVfPJWl7puMXLZqUJvlKU0vrca3UNN5jcD0uSLc4IRdKutGc9jrFoXKnNnVNwuqpZFJ/06qrUuDkjxa5oUXz5GU+Huo9gj15vjiIc6bAaJmrJaK7hN8ZeBQ3BJApU5niKjYwx6P7brbu50gE+8xbbgIS0Skq79HZHSVbPYZZW6CL/khRjyQ9cVLXWFB88DddXasco6FXOxhO4vERh+O3pJIpPRVNXMD1tK4j5lN5xR2AsCDI0rqxjmhsNfzPTDTbteolZcyt2LCDBmpddd0NgmQMWlWjRxuzDM584gM3ZxTdtOTnvWZnuLqPcARJnkynR6LPrIo1jEqcvvrOtHla5stmYtyh0cJGwHSRad2H/f6k7uPSkP5PetNQ9MyXf17Yh58KjFb+qIkckNkvO+gJMLRF/O28PkqVIkRyo0M8XPNcDThbJTHNuOP5plaz1/BagcQVhXBg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d6a863-bf45-4d7f-9785-08de0bdf517b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:38:10.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XAJ9RSKhWY3vZKjvx6CAEIEXWwvDHXb9rZDBWJHxlo3IuZ3LIgTmaol3lHUuB+fn79Ps2/eVakZ7Qwvycj1V6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8DB18B996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510150090
X-Proofpoint-GUID: CTEU0WMOrkmUZqBf8qKGYneqpHf7FEEz
X-Proofpoint-ORIG-GUID: CTEU0WMOrkmUZqBf8qKGYneqpHf7FEEz
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68ef87a7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=tlVQLQ5pGouDxNmWQbAA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX2cJHkOEBPc/q
 HCxG7J76pGZKgS0lcnnSytb4NBGP0H2kQ96rZh8kxct61wwsOa+YETZOMtoehLo32V/J0xRPU5S
 onfCXTxvPBVXB1aOg6r/7rwRK5USvUfvrUomf9dryy1Y4mHxlI+uuGzybNqGuA/ZMbEhJfuYbfg
 B249A57uctt8ToC82Lu85hf/ewu+3r7WpeBVZXG4YOKlelY7mHIZA+X/WuUczzvhiG/gQYItDSE
 E6ZQmrtB7vRjr2D+YDrn1j9pnUA5p1oDQElIvcv/XkFuERZvjwqROagGzLh9Y7LvW4A6j/x1FhT
 33kY16aqW6w8GKcEBrf/f2sMXwnz3HFHpMskvrzQVgSt4VmhsAYvegpVefI+NBiA1B6d5R6Biu7
 GoMEdKNSZ7d0u/7Qo9c44vjH/VsVhBAYT+VJ09DexO7uKkcWCZQ=

SGkgSmFzb24gYW5kIEpha2UsDQoNCj4gT24gMTMgT2N0IDIwMjUsIGF0IDE2OjA0LCBIYWFrb24g
QnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPiB3cm90ZToNCg0KW3NuaXBdDQoNCj4gTXkg
dGFrZSBpcyB0aGF0IHRoZSBWRiBpbiBxdWVzdGlvbiBoZXJlIGdldHMgd2hhY2tlZCBhbmQgdGhh
dCB0aGUgTUFEIHRpbWVvdXQgaGFuZGxpbmcgZG9lcyBub3QgcmVzb25hdGUgd2VsbCB3aXRoIGhv
dyBDTUEgaGFuZGxlcyB0aGVtLg0KDQpJIHdhcyBhYmxlIHRvIHNpbXVsYXRlIGEgd2hhY2tlZCBW
RiBieSBzZXR0aW5nIHRoZSBDTUEgbWF4IHJldHJpZXMgdG8gb25lIGFuZCBvbmNlIGluIGEgd2hp
bGUsIHNraXAgc2VuZGluZyBvZiB0aGUgTUFEOg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL2NtYS5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCmluZGV4IDli
NDcxNTQ4ZTdhZTEuLjQzZWZmNTQxNTE4MzAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2luZmluaWJh
bmQvY29yZS9jbWEuYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCkBAIC00
NSw3ICs0NSw3IEBAIE1PRFVMRV9ERVNDUklQVElPTigiR2VuZXJpYyBSRE1BIENNIEFnZW50Iik7
DQogTU9EVUxFX0xJQ0VOU0UoIkR1YWwgQlNEL0dQTCIpOw0KICAgI2RlZmluZSBDTUFfQ01fUkVT
UE9OU0VfVElNRU9VVCAyMA0KLSNkZWZpbmUgQ01BX01BWF9DTV9SRVRSSUVTIDE1DQorI2RlZmlu
ZSBDTUFfTUFYX0NNX1JFVFJJRVMgMQ0KICNkZWZpbmUgQ01BX0lCT0VfUEFDS0VUX0xJRkVUSU1F
IDE2DQogI2RlZmluZSBDTUFfUFJFRkVSUkVEX1JPQ0VfR0lEX1RZUEUgSUJfR0lEX1RZUEVfUk9D
RV9VRFBfRU5DQVANCiAgZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL21hZC5j
IGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvbWFkLmMNCmluZGV4IDIxYzg2NjlkZDEzNzEuLjlj
MTkzMzNhNTA3ZDggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9tYWQuYw0K
KysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvbWFkLmMNCkBAIC0xMDU3LDkgKzEwNTcsMTMg
QEAgaW50IGliX3NlbmRfbWFkKHN0cnVjdCBpYl9tYWRfc2VuZF93cl9wcml2YXRlICptYWRfc2Vu
ZF93cikNCiAgICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmcXBfaW5mby0+c2VuZF9xdWV1ZS5s
b2NrLCBmbGFncyk7DQogICAgICAgIGlmIChxcF9pbmZvLT5zZW5kX3F1ZXVlLmNvdW50IDwgcXBf
aW5mby0+c2VuZF9xdWV1ZS5tYXhfYWN0aXZlKSB7DQotICAgICAgICAgICAgICAgdHJhY2VfaWJf
bWFkX2liX3NlbmRfbWFkKG1hZF9zZW5kX3dyLCBxcF9pbmZvKTsNCi0gICAgICAgICAgICAgICBy
ZXQgPSBpYl9wb3N0X3NlbmQobWFkX2FnZW50LT5xcCwgJm1hZF9zZW5kX3dyLT5zZW5kX3dyLndy
LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMKTsNCisgICAgICAgICAg
ICAgICBpZiAoIShqaWZmaWVzICUgMTAwMDApKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBw
cl9lcnIoIlNraXBwaW5nIGliX3Bvc3Rfc2VuZFxuIik7DQorICAgICAgICAgICAgICAgfSBlbHNl
IHsNCisgICAgICAgICAgICAgICAgICAgICAgIHRyYWNlX2liX21hZF9pYl9zZW5kX21hZChtYWRf
c2VuZF93ciwgcXBfaW5mbyk7DQorICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBpYl9wb3N0
X3NlbmQobWFkX2FnZW50LT5xcCwgJm1hZF9zZW5kX3dyLT5zZW5kX3dyLndyLA0KKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpOw0KKyAgICAgICAgICAgICAg
IH0NCiAgICAgICAgICAgICAgICBsaXN0ID0gJnFwX2luZm8tPnNlbmRfcXVldWUubGlzdDsNCiAg
ICAgICAgfSBlbHNlIHsNCiAgICAgICAgICAgICAgICByZXQgPSAwOw0KDQoNCldpdGggdGhpcyBo
YWNrLCBydW5uaW5nIGNtdGltZSB3aXRoIDEwLjAwMCBjb25uZWN0aW9ucyBpbiBsb29wYmFjaywg
dGhlICJjbV9kZXN0cm95X2lkX3dhaXRfdGltZW91dDogY21faWQ9MDAwMDAwMDA3Y2U0NGFjZSB0
aW1lZCBvdXQuIHN0YXRlIDYgLT4gMCwgcmVmY250PTEiIG1lc3NhZ2VzIGFyZSBpbmRlZWQgcHJv
ZHVjZWQuIEhhZCB0byBraWxsIGNtdGltZSBiZWNhdXNlIGl0IHdhcyBoYW5naW5nLCBhbmQgdGhl
biBpdCBnb3QgZGVmdW5jdCB3aXRoIHRoZSBmb2xsb3dpbmcgc3RhY2s6DQoNCiMgY2F0IC9wcm9j
Lzc5NzcvdGFzay83OTc4L3N0YWNrIA0KWzwwPl0gY21fZGVzdHJveV9pZCsweDIzYS8weDY4MCBb
aWJfY21dDQpbPDA+XSBfZGVzdHJveV9pZCsweGNmLzB4MzMwIFtyZG1hX2NtXQ0KWzwwPl0gdWNt
YV9kZXN0cm95X3ByaXZhdGVfY3R4KzB4Mzc5LzB4MzkwIFtyZG1hX3VjbV0NCls8MD5dIHVjbWFf
Y2xvc2UrMHg3OC8weGIwIFtyZG1hX3VjbV0NCls8MD5dIF9fZnB1dCsweGUzLzB4MmEwDQpbPDA+
XSB0YXNrX3dvcmtfcnVuKzB4NWMvMHg5MA0KWzwwPl0gZG9fZXhpdCsweDFlMy8weDQ0Nw0KWzww
Pl0gZG9fZ3JvdXBfZXhpdCsweDMwLzB4ODANCls8MD5dIGdldF9zaWduYWwrMHg4OGQvMHg4OGQN
Cls8MD5dIGFyY2hfZG9fc2lnbmFsX29yX3Jlc3RhcnQrMHgzNC8weDExMA0KWzwwPl0gZXhpdF90
b191c2VyX21vZGVfbG9vcCsweDRhLzB4MTYwDQpbPDA+XSBkb19zeXNjYWxsXzY0KzB4MWI4LzB4
OTQwDQpbPDA+XSBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ni8weDdlDQoNCg0K
DQpUaHhzLCBIw6Vrb24NCg0KDQo=

