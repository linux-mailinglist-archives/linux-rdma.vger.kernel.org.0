Return-Path: <linux-rdma+bounces-15251-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E053CEC079
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 14:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 985FF300D90D
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 13:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922851DF248;
	Wed, 31 Dec 2025 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="QuyXT1iW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F874184
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767188431; cv=fail; b=MHmt70CKHiHfX2TNSCeDxl9v45v3tSSh6Qz4HwGQ5lGREe0xAJzLLaAFmhyqbuEbsS9J2m1WTUVviJagUn4R3kkm1B82WUL870YrkWHZ7KbEHFAe3wmrGH+LJO0nomNGK2GgO+EKEiohJaVik9h8aklnAMTq5CGEZCkcT4JmAhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767188431; c=relaxed/simple;
	bh=c7OKKZ9r7gPm8/RG5V+YnpgMHLVyam2pjtdIZQpz1vI=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tWtsB+BUJozd85skYCS2BW6tM5gVx2KOjio9gXtk+yya7G5lCFjCPPA8LeJYi2bqzMBKqX2eYw9EWJlFWo9eYL41+nHMhcpCvXS/YD7iOROfgLF5qU9Tc8qvfJEWwPE30CZQGR5marsSe45P/fA3VteImNL48rXY5tMEcNHLA2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=QuyXT1iW; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023119.outbound.protection.outlook.com [40.93.196.119]) by mx-outbound10-237.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 31 Dec 2025 13:40:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMCFllgrD69xFU9mlBr/cHCDm+YFCey74fXK3+Gl3q75oB+i4tDtKFg50T1khKlvebkmx+ce27W7JKUf3UEvZu+x7kp4+CU3mvlmwI0UkUMmd7aQdkU5nsIMOExcbUwcqW/Vmt1Mzk8VozMseeVC87bZaMUkbPbSyTlV3Xy4ocN5ECR1rsXItArlktzb9Kaqhw0ACdrSZDMNuvxudsnQWOkQihaxLsqjl5cmVnatjss1uK9dgnMYCIDg8tsoV/kGYNLMEcpaE4NrIUccVTp9D35CVBuW8eudrnhFBMHGDc5AGCl1MjB0+hIitEKDW0i7JONwH+ifhQjjsaRwarYY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUUe+8sBLnjZ/gGOi7eqSvMZVpr5o6LJw38lzLjXsy0=;
 b=nf1vPYpsTVoPDnpIqp3XyyQIwx/FaBVwmXDLVGRXdT5cYEjFVqQYzRn9MiTJP0forXZscXEl1/Fes5NLAQGPi4ErxugxXPS0za3XdMY7Kz6wbrDwL2nn2E8o/hm1xBiZvR1RpGNXhh+h0jvdxTdCsR9Atnn4eVei/BP57qYYjYJiIewiwYWlK9+NPn+TOCrNNCjb53TxGDGXfPbCjfHrRESRk/vUiAEowxAu+hb/gmujBsZv7/HeHarvetm1c4uhQYSwb4kSenG3EcLH6sk+GwJsIoFGAEvDNke7su8BLCra0dRxsezgrx39nA+znQr6Vl0kZp0Qt2WcmDQcuHzggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUUe+8sBLnjZ/gGOi7eqSvMZVpr5o6LJw38lzLjXsy0=;
 b=QuyXT1iW/1GA/JJM75WFo5WQ/7tyLdpdvTGegOul1mWJFCkk4LWn1gwddL14Sb71B3s2iz3AImB9IevGcJJc3V5GaAUFople7Eaj3EOWpL3L+O9wLDu3yiARB2+3jjidJ0ykMWbyOhM33XvobtXmP5PF5iXx4BDY689GOIn205U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from SA1PR19MB5570.namprd19.prod.outlook.com (2603:10b6:806:236::11)
 by DS3PR19MB9462.namprd19.prod.outlook.com (2603:10b6:8:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 13:07:56 +0000
Received: from SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::86c0:62c4:85f6:be6c]) by SA1PR19MB5570.namprd19.prod.outlook.com
 ([fe80::86c0:62c4:85f6:be6c%5]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 13:07:55 +0000
Date: Wed, 31 Dec 2025 14:07:45 +0100
From: Etienne AUJAMES <eaujames@ddn.com>
To: linux-rdma@vger.kernel.org
Cc: Romain Fihue <romain.fihue@cea.fr>, Gael Delbary <gdelbary@ddn.com>
Subject: [PATCH] IB/cache: update gid cache on client reregister event
Message-ID: <aVUfsO58QIDn5bGX@eaujamesFR0130>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0314.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:395::16) To SA1PR19MB5570.namprd19.prod.outlook.com
 (2603:10b6:806:236::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR19MB5570:EE_|DS3PR19MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbd6abd-11a5-4389-2b51-08de486d9d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGxSTVNjTFF5c2tVUmZMWUFHbGNyTDNqbXFmUys2eVVwWFBIUWsrRDY4Uzhj?=
 =?utf-8?B?WDBNMmNFczF6U2dlS0QzbDk0ZjlkSW40eDk1NTMzTmE3M0o0QzhVMkpNME5M?=
 =?utf-8?B?SVhPMVJKbnQvK3IrOTZDWjVnVUhqS01URFNtblJjVU03cHN2eW83dWpTMTU2?=
 =?utf-8?B?cHlNVldmWDF5NHR4czlSb2pNbjMvY1p3dk84Ykd5akRadFhTMkwzUVdveklB?=
 =?utf-8?B?TFh2ay9qRTJIc0N2N0dpQzAzcTE4OUhtbmtzdmdzL0xqUzR3TEJ0K1BMNnZF?=
 =?utf-8?B?M0pTY3duNzlQOEJyQ3YvL3hoYU9YTXFUakdwL0tULzEyb3p4ajBHeXJYZ2ow?=
 =?utf-8?B?STlyOTg2ODNpQml6UUVRMTBVdHNKUkZjK2g2alpScUhJNVpBL2NmbEZ4aGZK?=
 =?utf-8?B?V0l4OGpoRUpEUUIwWDZ5RG5Mcld0MHJiL0ZwYmVXMUVWVkxLVFdpR0d1R1J5?=
 =?utf-8?B?UE8rQnV5T29iQ3JoelB6RmlCeFJCNWd3cGFQbFM0MTdOZ2dyUFFVSkd2Nndl?=
 =?utf-8?B?M3I1MU5WaGVKVzJFVmVGUXZRclJrb1Q5cGx1clUvMGRZbzRJbFZKbWlVVjlG?=
 =?utf-8?B?QVJRUFhIZVFxTGFjdmdGeWt3dTRMY3NtdmtwanJGazRMV2d4elllTVFqTVV1?=
 =?utf-8?B?VUNkUGVNaW9EelZIYlZtWUh4dEFGSnZXYXYzRHNVVURJb1YxWndsQjZhdGc5?=
 =?utf-8?B?NVBzaGxmUWFES0hrTEpqdXN0cnpXZUNEeVhlMzB2Y0M3V1FYVjRxaTJiSHAy?=
 =?utf-8?B?RmlhWUVYY3BNUDF3dEsvbFIyaW0rQ1ZCVUlZYVhvc1htckNaWGd2QzBhcGY4?=
 =?utf-8?B?WHlSNU54OC92S2MxNS9IQ28xZHZFZTg3QnFZNXkxRnB6cjYzVFRGckloQWhY?=
 =?utf-8?B?R2VkVmhqRC9EbXJ5R3FRaFRPZ0dWWWZXbEtQeTJZNHdWempUR2xWZm41ejZK?=
 =?utf-8?B?RDdwdFp2MUFJNENhT1lGQ3JNTHI0WGsrOEE1OFhvZ28wOXlOczFLbHRES3VK?=
 =?utf-8?B?R1hsWHRuNlh1RGNJTTlta2hPZ0FLYWs4WWFtclpkRnZlQjhHa3k4bkFHSEcw?=
 =?utf-8?B?UzZuVURNb0NXYVJPMmFLMG1peTU2ZUZrS2Zia0FIVkhBTmNnRStlL2R6REpX?=
 =?utf-8?B?Y21FRC9hN1JBNUExZ3lST1d0bmFkaHRlVVdqdmpqVGpwbFpnb2dtQWxWODg3?=
 =?utf-8?B?ekpEbXdsZUE5cXBiUkZPVjJWUzdVeWNrUVEvaUd4RkNNY1I4aUNVRFZzUy9u?=
 =?utf-8?B?REpheWoxQ0JjWU85VHQzdk4wU3g1STZGQUoyL3lnTUllREIzM3dMV1lTNmtu?=
 =?utf-8?B?YmloK3VtOGRHT2JQaWRXbityT0VSdzRoWkhmMmhLdzFHckVIMHpVbTFIcHJu?=
 =?utf-8?B?algxeEF3cTZ0Y2oxZ0xYYjFOMnNlT01xb3p6NjhFOGljb3hES1ZqanRpVlA2?=
 =?utf-8?B?RlJYYXhueE93b3UxVU1zTzM2QjdLajUzL1JBdFE3eUpQYjJUWDFpY1pBbjdU?=
 =?utf-8?B?K0FQSWVjZFdPbWlPeHRISTgrcCsrZ1hsMTMvZWNEZGVhVitDeUh0My9WT3dk?=
 =?utf-8?B?ZTc1RjEvWEhPRXQwaTh6cnFMRW1VWEF2YmtHUCs0OFl5aVEyQXhZUkJreHRw?=
 =?utf-8?B?Vy9VbEJyUXdyNHFrZ3FQaDZWNVJJRjdxMVNoTDhsUGpWZWZrdXp3Y2dHWHVy?=
 =?utf-8?B?MnZ0ZHlMWlFOTUZqR0lldTk2am0rYnlzKzZXVG8vRzF0cEtaRCt1MDZXcEp2?=
 =?utf-8?B?UlZCME02UTJ5MDQwUVlyYTMvQU9DZzczUXJzd0lERVI3L3FFVVI2dFloSk4v?=
 =?utf-8?B?WFZIc1Zwb2RSeDUzalh4WWdHczVNTTV5NXFYbWJIbkIrczRVK2RxVmcvYnk5?=
 =?utf-8?B?Z2JkcUZtRUJ5VFptY2JNallpNE5NUEFick10OHlKR0t4cjB1dXNpVWZnalFM?=
 =?utf-8?Q?wtt8vM13HbmyhMISsOF69iDs9CclDSUz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB5570.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NStoWnI5UFZtSFNiK2lVR21VbFhMYnoyZ0ZOZ2ZLeWRSZVZ0M0xFSS85QlhO?=
 =?utf-8?B?a1hCZU5OZk1ONWlvaEFMbm1TU1lvYkJVb0JiVFd6bWJ6cm05MHpDRDRTRGRm?=
 =?utf-8?B?NXhtdDdNdndQbmFRd20zbnR5QlExUlRVbmEzSENJc0VuSjVNU0hZN082VXpj?=
 =?utf-8?B?VXRBS2F5T1NJblhGNTRDZG9rM1BmV0grNzRubU1kRlJkd0d5c3hjRndOTllE?=
 =?utf-8?B?bkNSMGhKYWltVlZoR0kwQzlUMGs0Z3hZV2czRlNwaTBpU2Zrczd1SWRuZERP?=
 =?utf-8?B?T1djQlpaTS85RFZvRW1Qc3JocmhEK3NDbjNFaDRJdUdEaW1aaHJUMUtRVFZx?=
 =?utf-8?B?VE53UlNZSGlYMjlPdHE1T01JMGZUWGZpa3FzcDIxS0ltV2plZGFGQjB3cDY4?=
 =?utf-8?B?WTBGNVh6N1NZcWF3dXJjZERQc2ZtRGRWaXVCRG5ONFRrRFdJb0ZXZlIzU3U4?=
 =?utf-8?B?MFBCVzlQVW9Rbm9zNHRJVVlOYjEyQWFoUW95YWI0ek1WVU5ON3hrRUtON0F0?=
 =?utf-8?B?TGFITThSNnZuS0d6Z1RIMG5vR0E0L012N0VZMFVDaGptaDV2YWZtTjNOdjdi?=
 =?utf-8?B?MjYxa3Z4Wk1MNXNXQ1g4enFQZzc3cFFoMDZnU1d0OFBIMnN5MFZYYmF1V0Ir?=
 =?utf-8?B?bCt3U0lxaGxUUGVJUkNQUEJrWU1rYTkzWDdOcnJWS1ovMVNiejZwNjZUbU9y?=
 =?utf-8?B?QVBzZmtOTFVUMmVSeVJJdE9uallGVExRYUszd2FaRzg2cFpuSU9kdGx3OXBR?=
 =?utf-8?B?MzZHcnBqd01VZGdPTlZVWE5Wdk5DUFMrL3NwWFM2cEplWDNBNnpacU5ZaUJB?=
 =?utf-8?B?YnMwaS9QRnUrR0ZUQ1B0bXl6WUozVGlCaVFpWk1Ob3RpbVJZZnpvRytkbjd4?=
 =?utf-8?B?dlBCU010Yng0Q0pBL0pHendoN3laRTZUWVFDUFBacXRuK28wNGRWTG5GaUZ1?=
 =?utf-8?B?YTdyUFp0cHRSQlluQWJrOFJZUWxyNjZRU2d6Qjlud3BJcVlhUWZ6SmtCUHFi?=
 =?utf-8?B?cGRrOFJwS0lRQXNFR0tENkdEb3NOYk83ZkV1eWZkZXBIM1doMXhSM1pQb09x?=
 =?utf-8?B?REh2amN4SHRsODZITHNaeENYMVNQdVpRb21jNmFlMk5qSzlZQTV0YVRRVmpZ?=
 =?utf-8?B?S3kvdmt6VVFCakhCNE1CRkxPaGVHYTNYYWo3d1hvY0l1R0NIUkh5VXBQendP?=
 =?utf-8?B?cENjUDhFTHBUbk9GYmJuWExDQmtJQ2w3RDdramtzUW9RU1I3WmRZMTdzT1VM?=
 =?utf-8?B?ZGE2anVHRC9DbVlRQ1FTSDRiTjViSjAvRlFUMktPS3N4eGVYVEpSaGkxYWlD?=
 =?utf-8?B?d1o5Yk90c0JHZENWa2VFVVlvKzdlUjBDNmFuS0lJS1JJeUZSQTZkNVFQVkZj?=
 =?utf-8?B?N1FJNnh2Vlpwd1JCZERCUGJjdzVzNVFxaFVLUFl3dHVEUndXTFRodUFUYm1B?=
 =?utf-8?B?MjBaakdpTjFUTmtZL0xwTUtrdUdHenBrbW44Qk5NUkNFZnJyN2I2TmFjdjJz?=
 =?utf-8?B?MnI0SU54bC9sbzh4MGV1OHRudGg4OHJ4ZFJNRStyUStpdnU1VlcyS1FvOU5G?=
 =?utf-8?B?SmdIRHA5bHhiRkVob0xpbW10SlFUVUEydDU0YXh1OTJ4OEVmMXhSN0hHb2Vk?=
 =?utf-8?B?NzBDZWhWSXVXZ1JCZGg2Ry9qUVd5d0Jxb0lLQzBYTTE1aEltVWhLbGUzZEtx?=
 =?utf-8?B?L0c1MmkxVmdnbnQ5WkdFYktVQjljS2tNS0ExREhaaTExWTQrUzlJTDRObTZz?=
 =?utf-8?B?T1VncktVNmV3S2graHdTWlN3aTFDNHdZdjBhcllBZVAzakMvaVNXS0FPT1VU?=
 =?utf-8?B?b3BNbFg2cE5jdjRncDNENHhWcTVhYU4vS29XbmRkakdnYVFiTzVwd2N6VytY?=
 =?utf-8?B?cnB6UER5QjEreC94NkE0MHA0WTUxeUduQWU0Y3FMMFVsckszSmxXMSs3OXN6?=
 =?utf-8?B?WG5OaityaXVERGxMU1dKUmUrQ1V3QmN1K2lKaERlTVRCeTJUUWd4MlpCVTd1?=
 =?utf-8?B?aVJnYWgyTHRiT1VQeXFrWEJrS1RzVks0ZjdWVkhLSDdOTXVhWUZaK2pGanpp?=
 =?utf-8?B?aGQvbEl2VUlMbGZyOFo2L3hTaHdZZ1VIZkY3WTZUWWlkdlpxTXoxeFE4OFNs?=
 =?utf-8?B?T2hkbnc1YVgyMGQyWFAvZHlmYm5YQVZVTnpBNVE2Wml2UVFOampWTG1pUUxU?=
 =?utf-8?B?M1hLSnFjdEhKODBEYXlRUnpRU205dUF0VmhiTjJsMHlNUWJxdWZvd0VORU11?=
 =?utf-8?B?NU9DUHRwNzZCdC82Z2Z2THdJQmc0dUgzU2tNLzQrTUd5K1NTMVFqb3hOVXBs?=
 =?utf-8?B?Q0EyU0ZmaGtOd2plcnRma3A5UEc0VXhYdmMray9GdjJhbFpIWStuWnczTDFv?=
 =?utf-8?Q?j4OYPcgQWn4w+TCYoW9F/ww2ZQa6zwvvAhQkX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+Hidc7PPIcuRl/t2vMYvve4h+6ArKed/qSV2wRFchoY4YN/N3aVF6XTM3l5wgknY90VnyMaKRAs4C11ei4dGT/SShvIVSKBvA6upEp9jStmbc6ebZVBfF3ajiLYHuAycEgZ1bnlxhOil8Ybdv1xIE7azJ/PfHV2HiBExqZSZdjZ2oG83Mxf2XbUi6cDcoZhV6+tLV400EbdTzGY+8NJS9AvN+n8NOePjWHVDU5cU/vu12Z/q4zvC5uyHMavd3sCU6wBo6MhqN5vTtsmCyC46PgH6/7Zbw1mjTVzEFNu61wGQl9cCDZLGCxWIfnZi5/qrxtZBLRYhg5AdUXhfPZwvG5LBEkWeWRxdAU5gAEns5tR3GiZ9IollljhNFPf/P11VxobCLgrvThkMUA9WyudVNeN2C2ovFd8CqCObji0fEnV15Yy5uyXo6WzTdLP0w/pJ+1250NjdneqRrlHQulLeOJ+dT5NmRDpMAoQJqGTfg4EST4EidsDUtDPVRmfLwz2+LYmec21EQKvgGc8iLXPUPyhzW6LoXz1h52wNiz5efHaREThfzZ0BzjYWHMFaa6VPbUv2LAnp8mIAKK/TrNXUyU7GQaq7E2BeCSK8RbDIG9UbuGsoZszPgUYljFyyafahzciAOHyTwPksKv5Mo/hDmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbd6abd-11a5-4389-2b51-08de486d9d1e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB5570.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 13:07:55.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V46pf6bCfH6hngQKuLKjbiqrQNaOTeKbp2sVdc/lPEaMjr9kLhdQOHxINwcxY9Eh/pzl351omLMvpqlWkuyGMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR19MB9462
X-OriginatorOrg: ddn.com
X-BESS-ID: 1767188427-102797-16278-572-1
X-BESS-VER: 2019.1_20251217.1707
X-BESS-Apparent-Source-IP: 40.93.196.119
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmZoZAVgZQMNHYNC0tzcLY0t
	DU0Dw5JdXEwCI1zdQkySIpNcnS1MJQqTYWAK4caQNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.270063 [from 
	cloudscan19-112.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Some HCAs (e.g: ConnectX4) do not trigger a IB_EVENT_GID_CHANGE on
subnet prefix update from SM (PortInfo).

Since the d58c23c92548, the GID cache is updated exclusively on
IB_EVENT_GID_CHANGE. If this event is not emitted, the subnet prefix
in the IPoIB interface’s hardware address remains set to its default
value (0xfe80000000000000).
Then rdma_bind_addr() failed because it relies on hardware address to
find the port GID (subnet_prefix + port GUID).

This patch fixes this issue by updating the GID cache on
IB_EVENT_CLIENT_REREGISTER event (emitted on
PortInfo::ClientReregister=1).

Fixes: d58c23c92548 ("IB/core: Only update PKEY and GID caches onrespective events")
Signed-off-by: Etienne AUJAMES <eaujames@ddn.com>
---
 drivers/infiniband/core/cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 81cf3c902e81..0fc1c5bce2f0 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1537,7 +1537,8 @@ static void ib_cache_event_task(struct work_struct *_work)
 	 * the cache.
 	 */
 	ret = ib_cache_update(work->event.device, work->event.element.port_num,
-			      work->event.event == IB_EVENT_GID_CHANGE,
+			      work->event.event == IB_EVENT_GID_CHANGE ||
+			      work->event.event == IB_EVENT_CLIENT_REREGISTER,
 			      work->event.event == IB_EVENT_PKEY_CHANGE,
 			      work->enforce_security);
 
-- 
2.51.1


