Return-Path: <linux-rdma+bounces-2510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E38C796E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 17:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6007228B1E3
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225C914D430;
	Thu, 16 May 2024 15:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hhbsIko2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dimd4kMC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C5614BFA5;
	Thu, 16 May 2024 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873275; cv=fail; b=TZKTPJ0rbywiyvMgu6TOEUIN7PxTdcK9wXwwRc805MJCaoNNVkwyaOwHMvJmMe6BFbOatv++qRdg6JsMOwmpUek+Z1z4z/iWIOrNlBplIfICs9/qIHZJRfplE88KkqnKAWzvcLd2ebBYeOVTlrlDthQlk2qIkFBPOmCEapCW4CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873275; c=relaxed/simple;
	bh=uk7CvoMNSxbuWyp4ifrIl3dvpZg/TCM+uINLvS2K4ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PhTGIcsbRy78CMjHyBh7yBHSr67JWcyD2LaK0wuBgZyizHGI+vpYr45lOeEgB0ZFSuMCTTbS+42soNSK7ilIHEW93/2oCISZHSgOXEvJhQrLV+B3Coix8XKHMubaah2ti5dF+cGyZntQFseCm9dtHa6gx6jmVewVjZ2x5i/MLuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hhbsIko2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dimd4kMC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GFJCga018639;
	Thu, 16 May 2024 15:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uk7CvoMNSxbuWyp4ifrIl3dvpZg/TCM+uINLvS2K4ws=;
 b=hhbsIko25CGTypQitQSg0ldtSfakC2UfrZka1jxblw/q3rMetFUhgLW7GYB8G6QPiVeY
 xxtb7smTFKJHSpfvG5quYFd8B/NaDSs3vf14n8GMAQJqbonLZzgx0/C0Fs4YgyiMxVGu
 4o1Eu4+blyGvc8MU8qrb8/ZrXFdEERsqJNurva3DJ12z8HpmuHG7flJnDObQB5e35U81
 L/cv8MEU+mOeQgdZ6Drb1IDIRip56NOipN+hwx/iC2hEafxj9iZxRQzt6h41HLycC4r/
 HiYLgjQlkeYE2A28By/WTf+lUZRkLg7cfwcpI6UEFxvqvFdEHtOzCexUivcjo/1NevDN kw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx37j0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 15:27:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44GEVAhX038390;
	Thu, 16 May 2024 15:27:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y24q05217-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 15:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWBU+9X5tqXmp81qea2ZoOE4IgMUJtGoWgQjpeyLrRmQyWxFcT/6u0VgG3ftViSMYBbYkfEzyhmW26oW92pgSSBUT3mmuPD6MPoV5V88S4oKd7de424ljBqXV7ijnkl6XcYL3A23ZuuJPbKEWi7PeAgY+SP6oszMO+j3q2JNewSEuWRRFxk3zuWQZqFjEvBHDmaNVmd/yRq9Rc5qkrX44REIAXBAxuMJRjDFGMrpYMNYVLF4CRjCXaCFIRLuRweiVYKyIorsGJPs8nwlUaWAyn4F/Y0ePG/vtOZAA8yYEtezJSMgYeE7F+GFN8WrU/+w/72moRoj82tr35xK5T8G8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk7CvoMNSxbuWyp4ifrIl3dvpZg/TCM+uINLvS2K4ws=;
 b=L3tWK9XDKSOcIIKkZGeo+UFI7sakTcuIQxaKCyvI9dUvieq1mvRi3Uo+c/MlFPLG6SVm+IaWwvjl19IFR2N8HKpsuqr12pCe3sMxP2rWUEL2ROp0w2q6uUSG2AxXQFrysWA9Nke7qBjrEIBwBJjBjftMtSHbL2EWYweh4jbYyZhkjSlmCaIsc7rxyTajzh/psYiuc4BJK785CjZS0nJE79o076TLMpunZTQPE9TlAoo+AY+IIY9qa8wdzyHFO8+ORkBm7ZZuLka8De7N9vTmsHk6SULe5KBpYplJMTig0wnh/zJegk3ELD8y8RFfjKXSYF1KCPTyn77Dsug5TklFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk7CvoMNSxbuWyp4ifrIl3dvpZg/TCM+uINLvS2K4ws=;
 b=dimd4kMC9JV6fy740ARqP2i6tomHX7owNoulioAkD8be3ZgBheHpNJ2ypTvOu2IPosbFOA6XAxpa2sCn4ChTonGQK+3/yIFDzLiYrL63eiyckqiZW1gJCb/oDuU7UOtfy5INVyIbdDyz9NZpV3BoWpaexAjWwut7WhMb3km1Sck=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by SJ0PR10MB5804.namprd10.prod.outlook.com (2603:10b6:a03:428::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 15:27:16 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836%3]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 15:27:16 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Tejun Heo <tj@kernel.org>
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
        Paolo Abeni <pabeni@redhat.com>,
        Lai Jiangshan
	<jiangshanlai@gmail.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Mark Zhang
	<markzhang@nvidia.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Shiraz
 Saleem <shiraz.saleem@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH v2 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Thread-Topic: [PATCH v2 1/6] workqueue: Inherit NOIO and NOFS alloc flags
Thread-Index: AQHapscbQhw1QOa7v0WunJjCVUME57GYg3aAgAF5/4A=
Date: Thu, 16 May 2024 15:27:15 +0000
Message-ID: <D9786636-CACE-47E1-B4B6-26AB2C4244C3@oracle.com>
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
 <20240515125342.1069999-2-haakon.bugge@oracle.com>
 <ZkTos2YXowEFS2fR@slm.duckdns.org>
In-Reply-To: <ZkTos2YXowEFS2fR@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|SJ0PR10MB5804:EE_
x-ms-office365-filtering-correlation-id: e7ad3d9d-e2e7-4839-6c3f-08dc75bcaad1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TW1UaU5UemNXQVZGbHZaQUExQlJlS2hPTE9KbmNzVGpLcG55VFdSdXlqQ3hZ?=
 =?utf-8?B?ZHkxSFlwQmdjZlBiQk5jNnJoTE0rZlZqb0JyVXMrQ2NzTGxVZFFSUXhVMEs1?=
 =?utf-8?B?eXRXYVZKVG5RSUxsZUFTWU9UN0VsNjlDcC95UTh6SzY3V2FqSUIycTVyWVZ4?=
 =?utf-8?B?V1ZYaDBTK0Jxd3REQlRmb0pBZUlMZE5FSWhPb0RuOGVMeVcwVS9Id3U5b2lq?=
 =?utf-8?B?Uis4NlF6WjJ4ZTJ5bFA0MldxdkNMZDZRU2J5eVRKSjlBbmRzdjloWmp6YlA1?=
 =?utf-8?B?dkRKSmtiNFNITmFFMS9HdWNDMHhaaE81aUJUbDNBaFhNUkNIMThhTUVaQ28w?=
 =?utf-8?B?TDdTcFA3eHZkaytPVlJ2Q0M3Tk1KYVA1OW1HdnFleERUMHJrbzhDYlNjelgx?=
 =?utf-8?B?bytsODVVOXI2MWlyMUI4SHVBZktJVUZZYy9HRWowS2tJR1hqYzlaa0pDRGl1?=
 =?utf-8?B?ZWdaeFlKZ2tha1BxUzJ4SGdOMzYwS1AyN3RMdzRkTThGNG9SR09XN3VDU1hj?=
 =?utf-8?B?dHpSQlpLc285dXJURjEvcmFjVjhKMnphUEtZdlRDbUUzMzNyQm9uUEI3S1pB?=
 =?utf-8?B?TG9WYTVKTzdoNDZyc09UczB0WE1IL2tpTnJWTjJvdFA3cmphbE5MT1dmTmJa?=
 =?utf-8?B?aEpMSzNmakFIOXlBTWVwUXVrbVowMW53eHQzU2cxNUlWR0NYZW9Od3NyODlJ?=
 =?utf-8?B?VThpRWlDWHhMVWU3ZVlwMG9yYWo0Q2ZDNkNwVmdMaFZxUVJpWHkxaGc1Zk14?=
 =?utf-8?B?Tm9iMDBPSHQzYmRtUVVUKzByb2JYbVRNZGQwaXMvVVhkYmZJNStsK3RId1V6?=
 =?utf-8?B?UlZwaHBmeXVrbWRNcmFZZFdRWjJ6Q1pBN2Q0MkpwU3oxNng4cS9qQlBtT003?=
 =?utf-8?B?VkhkWTFVVmQrVDh4YUgyUGVtWUt0RThzOFJSQUhKemkwMkRkVTNUQmFMZ3B1?=
 =?utf-8?B?VnVyK2drVGg4dDFnZ2ZaOUJnSXhMRjVMNUFtWkgzdVQzdDRTZS9HRUhoY0Zm?=
 =?utf-8?B?ZWJSaGlOdlBtNGJkWVVtRGV4Q290bHF3S0pZM0JWRVBhZVF4NWRTTEplZnlM?=
 =?utf-8?B?TGFOTUtLUWNwelZhR2w5alNJTlRQdjdTcHVPd3pwKy90R3hLNnBOdzRhcER6?=
 =?utf-8?B?Zm8zZHI3ODB0SHNvRlA4ak5xZFIrWnpRb3RSVWdnNkZwb2NxOVBkK25MNm1o?=
 =?utf-8?B?ajJPSFk1SWo4V1JlV0tQQ2xUMFZsR1ZqaDlKcjk0TFVocFdYbzZxTU5jdFF0?=
 =?utf-8?B?ajFVczdtV2F0Sm05MjJUR1RRRFN1clZBVWNoQTZBQktVdHpOMDcvZXJJQnpl?=
 =?utf-8?B?dEhjRm11UHE3REFEU1dYZFFXYk5KemgyTDVjN2ZOWG9HMUt6QWswU0t1RlpD?=
 =?utf-8?B?OElzcjMySFdoaVhYMUEyRXRQaWlYWlUwNU1pOVVKT3NhdEl0Q1Jld3ZSOHpG?=
 =?utf-8?B?d0hBYU40SGRYcHpCUktZTWVMMWJhSUtncHR0V0laeGZNc1hqdUdaWFhleVRH?=
 =?utf-8?B?MjhLNklkdDB5eWl4bis1Q1N1MThEUnl4Lzd3SVJxVFQ0STJsZmp0QzdJQStR?=
 =?utf-8?B?c3FkT1lNNTRhVEU0dEJaRGRDcFZuTzBmQ1pPVjVCK3NXdWVXNVNzNEh4U29z?=
 =?utf-8?B?UUlCTVJaZG5ZR25vTExrMTZSOEN3Si9pSS9vc2pXNUdYdkNwV2huMm5JaHFy?=
 =?utf-8?B?a0lFUHRkTHJjMkY3T2lhdFREUkJzTVJCMFBGek5yUms4cUt6eWwrd3Z3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Nlgxdlc4VHgyNndWUlJ1UnZvOVdaK2VSVG1pRHgwa0pOTXYyeS8rSG0vNXpG?=
 =?utf-8?B?UU5oWWlvZVZtYW1BS1pLOU9RKzlVUmtNZEszR2o5NzRwakw1RUE0V1dycDFr?=
 =?utf-8?B?Q2N5Yjc4azJVMi9jaHliOW92SlVPbnVMOTBCNUtJV1ZvQ2JCc3pSK3luSUJ1?=
 =?utf-8?B?cHR4VHRTUWljcW1ZWUJ1QXNYT3RwWkFiZjEwWmpsOUs0cUpVem5DY2pZLzls?=
 =?utf-8?B?ZUhBb2VxaS9IM3NqcnBSYXN6VVNPNDN3Y0V2YlZ0TlZPOGp3KzNmR1phcElN?=
 =?utf-8?B?akZwWWlWUFhoVFkyenBrSzk5R0dJZDh1S3M4eHZjR2ZSOXljVTFGRFo2VDl1?=
 =?utf-8?B?LzJZd25sUUt0L1JVcFM3RDhqOHcraGhoRloxQmVKVmIydDF6QS9lNzVvb1Vl?=
 =?utf-8?B?THlDeXFjU0tRQWloSGlWcmZWQkIwbndCemh1M0Y0TkpRSmpKaGJrY3hqNHpC?=
 =?utf-8?B?b0xZYzRqZWlpdHhTMGQ0dk82VGtkN3k5WFoySHNNOVFxWEFkQTArMkZRK3N6?=
 =?utf-8?B?S1lUM0EzaDB4QWVLZkxzSUYyai9acHo5djBPYW0zUXpBRUZiVXowOStlekQy?=
 =?utf-8?B?a0VkK3BpQWJ5WGZYNE1XUzdDanJlamFWVThDdmk0THNlSmVGZkJnQjkzNHZJ?=
 =?utf-8?B?N0pLcnIvb2x3a0tWdCtvQWw2eW1YTU1oYTZwSjdIY0Y1clZsVWZZd3NlNE9s?=
 =?utf-8?B?Mk5JSGVkKzNBT0V0UktwRkorR1UzTm8vcDNNVWdjRmpqak9QVm10QUptUStR?=
 =?utf-8?B?dlB3akFCM2lZanRsVU9pWnFyM095YTdvaU1OOGVKT0hzTTRnZzY1cGFoSGx2?=
 =?utf-8?B?N3I4QjFaSVJ5T2phNk5GME1tWk9SZ3VVeVNjdzNJSHJXWXhuT1o5S3liTXI5?=
 =?utf-8?B?MGxZdisrLzNzTUcrWXl2V2RKYWJXdG1TbzU0ZHVYUjdpbDkwMTRUYVRPRWhH?=
 =?utf-8?B?N0FrTUZhQU5ONHdWQ3I1bENlOXNxUktMK2JEN3EyQ0tmMDZkMnhSM3FZMC9L?=
 =?utf-8?B?dE9SKzNmV0VmNFhEOW5Fb09jRVNRZmZ0eWhMRUY2MlNjTnorTm5UZFlYUWdG?=
 =?utf-8?B?bUk0Q2ZDYmppZXlpZXZVQWpPcHR4NS9jL2htbGdNemtLanZ2SVVFdEduR0F3?=
 =?utf-8?B?R3RyY0traFdUT2E3N1g1OC9BR2pXZzM5K2NFaHdtRllqYXRtdEEyeHlxZWhK?=
 =?utf-8?B?djJ4M0NLT1lWMk5pa1VHVUkzbWVINzVIS2pSVUU0d1U3eHVXejl5RzJKWmlH?=
 =?utf-8?B?OXFVUDI5dzNNVXBxV0dVU1JmWEJFc1lVS2pZUm9uRzJRcGVpT25xQ1RCVVl3?=
 =?utf-8?B?NGMwSm96L1RJMFB5S1dDVGpFUkxMUlVzdU5OYzBGdWlCUEpFekVzUnlJSGt4?=
 =?utf-8?B?QjU2WU1MdnUrc2NTWmoxZWZNdzVjSmdVcFY2R2VBcVRTaHlHem1UWjFiZE9V?=
 =?utf-8?B?VlArQzBvc3ZkYmhmaUJraG5VRnFONU5PWUxJNWJ3MG5SazlaSXlxN045YVNz?=
 =?utf-8?B?aWxuc1RLVU5mcFh4TkpVZGlqM3NwZm9JRlJmTks1YWJhbVo1RlRHV0g1eFRB?=
 =?utf-8?B?ZHFOclJXWndyWkMvdGovQnd1ZjJRWDdKelJZNURQc3loNzFOdTlTTmEyc0x0?=
 =?utf-8?B?VVBXSU5KV3FGcTRVMjNoeTQ4WU84elpHdm9UVFVDVXJ6QUtHSlJ2QXI2UTVo?=
 =?utf-8?B?RmFJVXNpa2puYVFUMEFJY2dkMmphVm43SURNUkkza3YzT3V1QnljYkhBK1dG?=
 =?utf-8?B?b3IvSFdIbG5iWlczaDMxcWVmYytPU1RnZjVnRGRnQTVNQXBNRGRNaU5yeSs3?=
 =?utf-8?B?WlNFZlppdkxBcFVGMFBhUFJDaVpUU0ZQVnlFWmxiN0d1OFZZK1J1QW9CeS9o?=
 =?utf-8?B?bnYya2gwc3dvZ2RZNkNZNkVPR3ErTjV5QWphT1hjZHRrWFNIL2RBb1hCbHZK?=
 =?utf-8?B?eTBzOTlvV2psZGdmSTVRakRZWHhkajkxdkQ0UjQrWXY4M1ZJK0NXM2w0TVVl?=
 =?utf-8?B?ZXlQdE0rRmJ0WjBTNWZFeTZtYTR2ckVKTllDTW1VdjhSb1FnRFJYK0ExZDh0?=
 =?utf-8?B?UXdCdnpROFNWdUJldDREUzBMcVJiWm9VTnp2eFpMT3NBdHUvVnhxSHhvQ0Fq?=
 =?utf-8?B?SU00SStQaVJOS3pBUy9Bd0E3Z243S00rTkJHSmp5YU1MemVXYUVIUnlvVGxt?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6F235B108C3B948BB669BA2EB5B8D31@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	M4zhVgxGOxF0KlMqWczhKqhY6PCx5Yh3NzA60hw74BLujlcoz75KOmiK53iMV+L+HWEXKBpXz6klw/uda1lMf2JAldx2PTMncAwfmtnBp1L16e7SyeQo1WQ80cEUoS2CrkgWHSu3P70C6XjeJEcllq8tWomR+LFvcaF+pNBOfR7Vw7faoHKsl+nAnIVgqcgyntt55sCbjC/V452LAawh+vWIHVYcEet7hXFw8wgmMNi/OAhTW9Nlj4hVuov9ZtLcOqup2x0ZO0vJfWYaPHkeegdef+bmWAMaIrNJSZnst/j2iWRw1Li3OC4cdAoN9+C3YTvEJGlCuP7Vlt2gDPGDqMyny1+sMmo1X89s65436GdnpN8zgRuP/37dgTai9+zflAbsg0hYi4BLUYRLHGmbHE3fOs+UyMeP4nabnuPuGLcvCljQ9LOgqrxnfDIVb76duQy9FJAGNMLgPe+I4UmnEP08wjIqxgR05fNzwWo+bf9+uABbFr8bMrIPEbr7hL5qYYsNkxFT34x861P3fcyp0C9F4lOLvyBi/o9IaO5ntkQ4PvfHtRlMUckkbMtVoPRzwcxQzL6FLzD0uwmptxso7vePcZwZtJtkiB/BJw89l28=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ad3d9d-e2e7-4839-6c3f-08dc75bcaad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 15:27:15.9519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUHj+7HprAgiYJZfsk4QkaFaRWeKXTQokuXwFFKZdIVnhTbvAN79WMaZ7eXyKPGGQ3jDZKP0CHKqkv5FouN2EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405160109
X-Proofpoint-GUID: y7y9TC6qot-RwvBqgpObx6E2_VWJy7w7
X-Proofpoint-ORIG-GUID: y7y9TC6qot-RwvBqgpObx6E2_VWJy7w7

DQoNCj4gT24gMTUgTWF5IDIwMjQsIGF0IDE4OjU0LCBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+
IHdyb3RlOg0KPiANCj4+IEBAIC01NTgzLDYgKzU2MDAsMTAgQEAgc3RydWN0IHdvcmtxdWV1ZV9z
dHJ1Y3QgKmFsbG9jX3dvcmtxdWV1ZShjb25zdCBjaGFyICpmbXQsDQo+PiANCj4+IC8qIGluaXQg
d3EgKi8NCj4+IHdxLT5mbGFncyA9IGZsYWdzOw0KPj4gKyBpZiAoY3VycmVudC0+ZmxhZ3MgJiBQ
Rl9NRU1BTExPQ19OT0lPKQ0KPj4gKyB3cS0+ZmxhZ3MgfD0gX19XUV9OT0lPOw0KPj4gKyBpZiAo
Y3VycmVudC0+ZmxhZ3MgJiBQRl9NRU1BTExPQ19OT0ZTKQ0KPj4gKyB3cS0+ZmxhZ3MgfD0gX19X
UV9OT0ZTOw0KPiANCj4gU28sIHllYWgsIHBsZWFzZSBkb24ndCBkbyB0aGlzLiBXaGF0IGlmIGEg
Tk9JTyBjYWxsZXJzIHdhbnRzIHRvIHNjaGVkdWxlciBhDQo+IHdvcmsgaXRlbSBzbyB0aGF0IGl0
IGNhbiB1c2VyIEdGUF9LRVJORUwgYWxsb2NhdGlvbnMuDQoNCklmIG9uZSB3b3JrIGZ1bmN0aW9u
IHdhbnQgdG8gdXNlIEdQRl9LRVJORUwgYW5kIGFub3RoZXIgdXNpbmcgR0ZQX05PSU8sIHF1ZXVl
ZCBvbiB0aGUgc2FtZSB3b3JrcXVldWUsIG9uZSBjb3VsZCBjcmVhdGUgdHdvIHdvcmtxdWV1ZXMu
IENyZWF0ZSBvbmUgdGhhdCBpcyBzdXJyb3VuZGVkIGJ5IG1lbWFsbG9jX25vaW9fe3NhdmUscmVz
dG9yZX0sIGFub3RoZXIgc3Vycm91bmRlZCBieSBtZW1hbGxvY19mbGFnc19zYXZlKCkgKyBjdXJy
ZW50LT5mbGFncyAmPSB+UEZfTUVNQUxMT0NfTk9JTyBhbmQgbWVtYWxsb2NfZmxhZ3NfcmVzdG9y
ZSgpLg0KDQpJZiB5b3UgaW1wbHkgYSB3b3JrIGZ1bmN0aW9ucyB0aGF0IHBlcmZvcm1zIGNvbWJp
bmF0aW9ucyBvZiBHRlBfS0VSTkVMIGFuZCBHRlBfTk9JTywgdGhhdCBzb3VuZHMgYSBsaXR0bGUg
Yml0IHBlY3VsaWFyIHRvIG1lLCBidXQgaWYgbmVlZGVkLCBpdCBtdXN0IGJlIG9wZW4tY29kZWQu
IEJ1dCB3b3VsZG4ndCB0aGF0IGJlIHRoZSBzYW1lIGNhc2UgYXMgYSBXUSBjcmVhdGVkIHdpdGgg
V1FfTUVNX1JFQ0xBSU0/DQoNCj4gSSBkb24ndCBtaW5kIGENCj4gY29udmVuaWVuY2UgZmVhdHVy
ZSB0byB3b3JrcXVldWUgZm9yIHRoaXMgYnV0IHRoaXMgZG9lc24ndCBzZWVtIGxpa2UgdGhlDQo+
IHJpZ2h0IHdheS4gQWxzbywgbWVtYWxsb2Nfbm9pb19zYXZlKCkgYW5kIG1lbWFsbG9jX25vZnNf
c2F2ZSgpIGFyZQ0KPiBjb252ZW5pZW5jZSB3cmFwcGVycyBhcm91bmQgbWVtYWxsb2NfZmxhZ3Nf
c2F2ZSgpLCBzbyBpdCdkIHByb2JhYmx5IGJlDQo+IGJldHRlciB0byBkZWFsIHdpdGggZ2ZwIGZs
YWdzIGRpcmVjdGx5IHJhdGhlciB0aGFuIHNpbmdsaW5nIG91dCB0aGVzZSB0d28NCj4gZmxhZ3Mu
DQoNCkFjdHVhbGx5LCBiYXNlZCBvbiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2Rl
dmVsL1paY2dYSTQ2QWlubGNCRFBAY2FzcGVyLmluZnJhZGVhZC5vcmcsIEkgYW0gaW5jbGlkZWQg
dG8gc2tpcCBHRlBfTk9GUy4gQWxzbyBiZWNhdXNlIHRoZSB1c2UtY2FzZSBmb3IgdGhpcyBzZXJp
ZXMgZG9lcyBub3QgbmVlZCBHRlBfTk9GUy4NCg0KV2hlbiB5b3Ugc2F5ICJkZWFsIHdpdGggZ2Zw
IGZsYWdzIGRpcmVjdGx5IiwgZG8geW91IGltcGx5IGR1cmluZyBXUSBjcmVhdGlvbiBvciBxdWV1
aW5nIHdvcmsgb24gb25lPyBJIGFtIE9LIHdpdGggYWRkaW5nIHRoZSBvdGhlciBwZXItcHJvY2Vz
cyBtZW1vcnkgYWxsb2NhdGlvbiBmbGFncywgYnV0IHRoYXQgZG9lc24ncyBzb2x2ZSB5b3VyIGlu
aXRpYWwgaXNzdWUgKCJpZiBhIE5PSU8gY2FsbGVycyB3YW50cyB0byBzY2hlZHVsZXIgYSB3b3Jr
IGl0ZW0gc28gdGhhdCBpdCBjYW4gdXNlciBHRlBfS0VSTkVMIikuDQoNCg0KVGh4cywgSMOla29u
DQoNCg==

