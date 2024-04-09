Return-Path: <linux-rdma+bounces-1863-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7567689D045
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 04:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0D1B1F22DFA
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 02:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815FD4F1EE;
	Tue,  9 Apr 2024 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BFWV9Iiw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C3Ux/oQG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF94E1C8;
	Tue,  9 Apr 2024 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628672; cv=fail; b=d9HLIb5mtqsmFwJmS2tg9OgLmtC5CsHi19H5Cpt20iJa3gHM5TWXsLTRSEfm+RZ0rOU+wI+zWaHUkT3Qt6HCrAb4weMGcXLDYpbVOFbYJJuCTJ6/sWQM2BP4i8fLRxMmNWnWSXUfWrbkQtsAEJb2jyf7e/3QYyoOpV8QjzVcutg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628672; c=relaxed/simple;
	bh=0DbY9xNG6ZXgtKoLGCxyEXwAXikNotN9GnlaJEQ3OFk=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=itwY/bXxIsKygLv183CqhZGGcD1yhA0W5z4DVkFTIxulKG4zaE1j4WwwSJpYUeoO/Mi1AENiiI/XqNFtf/X3GnaMZyPxD/StBGLRVq2SON+iu0VuuvxjuEQTZV4lweJbnmzgPEjcacP/N6Wq1pdsPR9xxg9D1tdXVaEjkVV1/Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BFWV9Iiw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C3Ux/oQG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438LnF5S010301;
	Tue, 9 Apr 2024 02:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=DpBVF0Sx0MiDS6vJkpcr/xUMTOeZGAVQZOfzvOSIbTo=;
 b=BFWV9IiwzuICGv59KTiIDJ3pJlXkYwTbH9z4TqhkV8tpyJkRVHuapAYxYX98UhHJXZ9q
 XSDYq4ayIdpDzqKMSzUtnj2U6K7IcwPFHPsKYy+vTMz9vA4OGyNcDWFX83QV5g8nZrMe
 v2NrhXZibGb3ErYfRCzU416w/RNwaDTQo23dth9QWYvZAxAQjhKUqIvenKA4NnWVvDVN
 6u+GR3DXyWqNAcDc1ouNeWElrjtDefDqorcQvxLyRvWsI7ko3SobOpZObxg7mHy63cMt
 qomVvustfLpUelkzIYkrs/Bn49+De/E3NjwrPeZFfJ5LUuYjoQKH/SB1kunXvOl400BJ Qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax9b420f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 02:10:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438N7vmu010595;
	Tue, 9 Apr 2024 02:10:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu68aug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Apr 2024 02:10:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2iba18BDbKtF+YrHICA95zkWtptMuLpHXQYk0LcFSt35UPAkLiwBT53VvZVFZD2Iz0jMPGMaMpmljrF0ppXtSMrQR56Ksf9cKXg5l6f6y4HVG9uvuTiygBuVe61ko47Fm6yu6vEPLvJxmtHMTt4q+s8gfmE+jq3vR2dUwmqsOZ2tX+MVbA8wO+05WvORL6S5Z8Any/t5sv9BaBrqZukhDK/K502N67qSxBWgUDpZEuDauzuBm59SNljx74X8pU8u7ZM8uXY5sF3Vogka8RtYIiT1hiooORKET++wQgeQLKul6bQQ1AjBdBjDtT9PHMBpOOePS1FwUvRumuFhLxaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpBVF0Sx0MiDS6vJkpcr/xUMTOeZGAVQZOfzvOSIbTo=;
 b=FVL4A4Oy3FmP9/XYtCulxomNERWtdZWh5OSGSKM6MJ4149k+kqBeLo8RMTMRog63edZsS2c2cOhGhNLTVT5nKtbgtLEXOLvV8Q8V4b15CKe6hc5NpiZFzIW0SSACkvO551GXDi8p742BOoeInecpodfK1h68E56cf2j+tGTC6edFj76sEEF3D7SrB82lCLPMrdcFzRRuSJxUhMhygwhX0i7CeBCLUPPGrwyT+r2rwto7jDwilT7IvKst08DeDy5funks3LtRrn5kEbHZkV0TJgi21p58AjTAbUZwR07JQ39hkWY9IuoSkHV/AbqoW7FDdlT18btXyNXe3LmL+Ff8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpBVF0Sx0MiDS6vJkpcr/xUMTOeZGAVQZOfzvOSIbTo=;
 b=C3Ux/oQGPhCX4JB9MN60bdhJHAJ4Lj50G5zMUFWoLIej2/H5e98Ezh4T/RohVbKTdTTHswQVErhxqVNObz8uUnmockmRkzed+UJYZDXPJoh/MGFujhnsutWeHuNq3EutgfsjnCC0fxV4uRFmN2QCNNDhwJM/dY5OJBGvU4DZMwE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 02:10:34 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 02:10:33 +0000
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-scsi@vger.kernel.org, "James E.J. Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Bart Van
 Assche <bvanassche@acm.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/8] scsi: documentation: clean up docs and fix kernel-doc
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240408025425.18778-1-rdunlap@infradead.org> (Randy Dunlap's
	message of "Sun, 7 Apr 2024 19:54:17 -0700")
Organization: Oracle Corporation
Message-ID: <yq1pluznv5c.fsf@ca-mkp.ca.oracle.com>
References: <20240408025425.18778-1-rdunlap@infradead.org>
Date: Mon, 08 Apr 2024 22:10:30 -0400
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:208:32f::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB6810:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SQCGa/n61g5+jOxTXstGjnLZsEgmHXrx+pRcxt9oGohFTwD22GSTNjc3tmUFStzi06t17RmC9kebXYLTePJF0SOl0qwCXNsjAX2pBqvzAPX1aL/B3RjOYqFlaR+8/8Jk7HGtxPTZqHYZIFAyaQ+0n1wls31HZBw6pJmr8Sx9pX1Sjawtgwapb/mcN59LEfEpVSk/Gc743S5o+teKAsNlvYWOELdyE+BQs8KjwWFR8hB0HfJCLeEUVyrqqZ5/2mKPcGUA15wj/pjZ2kBReV5G2HuAH7dieRhofPbRuGJYEQLkIdu2sbtoc/q7YWTLq30dw1xzKcKMHJwYCQPfCcJs7wLc7mzIGaKVW+nEwOVOUK+QRqpsRAKNsvJMQoJ6/2kAewpNngLyimyEQ3FW0rE5Com0P0QIY9++foIjr+4GlaEa25HCbY4aDr0mDqwy0RfXfhs4VWyfaGEKWZDu+0/6Nk+XriOtVBpaV5cBwEumBtZFbNYM15KH/t7s6aFFrIIWwP670kIuIMFeQmbgbQ2Q3uIT7JdYKomugGGUwSKO1puWxPVkFADsLnis7VBgt5ENC7Q5WmyAnr6zOX0o30tNEGYAP/4dcyyRj1CqRJUm9/3rSEPbccQU1A56CrT3IOEgwVGNIujapiK+ESUxHGrWi2Mq/hHfqMluY9YuSJkPcL4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4R2XbW7i4wzAP0pRkam4pYoDy3OFTDXR9WI6zUcmvIYCK9b5ZbTB9cicBoR2?=
 =?us-ascii?Q?YvDztfRFXcjBhSS3OhkuTUfAFCJG/NcXtGfZ/apvDKug+5RAoMH7xSUL9f9O?=
 =?us-ascii?Q?3El7ilAlVqtjxOxwIVbtjQJPfJKA1NW4Gor9gXk2li0/NzblrHN2mfTyUCKD?=
 =?us-ascii?Q?7jVIlS5DLrEX47eNGDlHzuVHXIviUhfOSbB4DULMl0SC7SMPAXW57Y1fRsTu?=
 =?us-ascii?Q?U15wK6zVSuxqM+3T6mH91V9sX2oy0eWd5cIpyKeCgBaZaEKMQjv7mOsofkTm?=
 =?us-ascii?Q?qQH32ETTicP6Zn636XuE7sYtI32GeaOGsqg7EP4OGHolnADcDE0y4YVBJ52v?=
 =?us-ascii?Q?QLDIA/G10trNXyadJtuypp1EtvOiJpv1beSH9kzPogNet7vp3LV91rsjrVkJ?=
 =?us-ascii?Q?v/5vE6nCWlebeFLCVJpZF1Kn8YJjvFZUFShUjEQWSN8ADztvGBgvMPfmByJP?=
 =?us-ascii?Q?sESCDP8TuZXZWhFARTqGhvO8b/VgUU4a6aneVJathxRucIipegz8H9IrOAjW?=
 =?us-ascii?Q?Xhvn0XkayGFwOnAg0RFjnpB4gYdg+dkNucYPVMBz//TxLJQIJIfQvVlJEZdF?=
 =?us-ascii?Q?yrBotRXH+nzo2lj6lTPDxWwkW1rSsHj8h9kQ2LidOrF1uocmSnTgJAliXLMR?=
 =?us-ascii?Q?ChJX3Eg2Hk08VlPTmmaFJuVpAtCLUyMQQqTsUMgB3w7TWF0aKJsBO6BPfRhM?=
 =?us-ascii?Q?9X5PiuVnSbIS+5NIbZCVQ7qnfnxfXw+lnn2I8Fnb0z7vEB0fqxi3l+HZtbvq?=
 =?us-ascii?Q?mBA10wCH7aI4PAu76j2a53Xo4shbMtbZHTHs2hC/bidgBrNv5VaTF+ohg6iG?=
 =?us-ascii?Q?z6wbbnHn4l33zDm/vPCn8dc/vdZvImxe3Etm0VPwhGgWyJOD76NAl/Pm9dCf?=
 =?us-ascii?Q?8mNLP2UmbCND2jviqP4pCq63uRUiiAbT9MCs66uP/8hbcY4od+BKmoCZ45qR?=
 =?us-ascii?Q?hjUXXlA6IqECIOTk8d5UqUR+WLgYNInZpvDQqeu9eUSW8AihIHhGSXlncgWm?=
 =?us-ascii?Q?45tZ4U8HJ/pFQVGJ/Oel1THT6ld7LSmSPvrL9ytNnbUVZeESqv5qTa3x/i5p?=
 =?us-ascii?Q?2/w4KGo7GmUzPbpewD00obVgG2v6I+qgOi68kgbBD5dypyF3DT4VGUkatt8z?=
 =?us-ascii?Q?rpYmimnoYktgTTaxRVVueF5cFJ+0FuoTC/jC7jSYEqNqb5JMReow2JMTpG/R?=
 =?us-ascii?Q?x6joI5Nilf3rKlykTtWTJybjsG1gMPwQHLEx3BYNmce6Y5boBJacIVcSAdi0?=
 =?us-ascii?Q?guZxC0ZYRaHRTnT0fdLuNKFyaFeypsaAD0haEcJs0Fujv/cNUdojV2QokPL3?=
 =?us-ascii?Q?NWLfbIAqrLuHxk+hOaBQAejKchqU9c1FCGWiBdvaKvFyBMNR4cIKIP7EGRhC?=
 =?us-ascii?Q?hJZb4mOVp4XP8iewHesY5Zj3mmDFqnj4oKIQ1J5Rq+z3uQs6M4SsteHDt1QZ?=
 =?us-ascii?Q?npjtoLCE5GszepzAX8YYe9t9yyMZ+DiOwW0AAiNaj0nlqAcEeLEKjOTR2x+x?=
 =?us-ascii?Q?GZPm5FaqHQ+f+VIWCBRu3A1oUgRBs0qJGPQoTAuvlZkfBuRG+WYPBZXPP6yu?=
 =?us-ascii?Q?8EjwWAzfSYQH8tud4BU9d0BeNkDDnsP5xkp3skBqlXKfT7MrVKZ5vtr8+eL5?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YS8WDM5YIbor1N2c2BI07thj0FtqkMM1TSPzKfKNe/atU6kMiXpaVL8kqNrYbG1yLCjTQkNPgEPQZCSW5nGF4JzQBEYT/PgCCZCIC2HWT5E7c7gWVF9ZPH9yZNOOogpnaaAig/DC5qVAcSSevtPSjrjZdDQNIkfeGsrSCSj6XeP23TeWw0nL3LL3FwDcdKCSZLNj0CsBkOSh1f4K2yVkpJrHSRuUMZzcDbEHkC0mjIt/z7RDMbLgmQlPsZNa8nFD1NAXs4XeTO0zxPRnoTWlAgiQgxuULyeCfeA+ixMFn+7hBmBPTX8I3wTBaTOmbicGY35x3M+Kf26jNr0wfP4G1GmuBH7ckfVIVjWCnTSGcIVUTk+72y/PNHzo0CQtAUXW10wNlzsOcJaQQIja4Z+TUY2qujphPFRhGHIAtiYgMk3GJAoC0n1Q9sScwbsK7dd7R1chLILgOndT6Dxl7CFXpPIqMMe7wkZYXrSfxuMDdDGffSOMBpPB4H01j+rAuTqs2dnUY7v/x9hYvOQ3iZwlQVTW1/Yy9MTY7NEB0Wql23HWcuG7miVOoHjEOF4CBjgEUphVbS9ycIK1wXp3OVHpAlW9UPSiynsUuqJLZznqoHo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6307a0-639b-4deb-2565-08dc583a3cdc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 02:10:33.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Re8y4F180NyseR8vP4LjgOrZOQbVHFCY2Ez1yT7tUcG5er+J0D4gno4lwXliJTqcBPkMnZJU7i3FSPZsBIrUoqTf4yQd4Ndah+vWfxHctVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6810
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=989 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090011
X-Proofpoint-GUID: VXKLroeMCSZH5dG9Pez04VRGfJEiJKYc
X-Proofpoint-ORIG-GUID: VXKLroeMCSZH5dG9Pez04VRGfJEiJKYc


Randy,

> Clean up some SCSI doc files and fix kernel-doc in 6 header files in
> include/scsi/.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

