Return-Path: <linux-rdma+bounces-8874-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51786A6AA31
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 16:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC91E165E5A
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44371EB5D8;
	Thu, 20 Mar 2025 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KH7ylrRD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226481E9B0F
	for <linux-rdma@vger.kernel.org>; Thu, 20 Mar 2025 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485567; cv=fail; b=CzoC7fyXmiK5UHnU+H915dAjQXm5wZdkjdWfXsSBYlZ/X+3ZvzD8nsz+F9JnQ0GaN7py14jWiOsXGH7SPrjRutexHu4LjFt7yqJtaRXSL4YtSQlEE79WXAdAWORPdkJmhisoIe8/DE0dG/TgRSYB0LdXXGS8eM6c4lK7IRStWew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485567; c=relaxed/simple;
	bh=si1alxR6X/dIBJr4s75Nkj2aySnmTzRk0yuuZwHq+Mg=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=RhIy1YcWWwwXgecJJNapge8ty5/O+Kj8TDcIfIUsvOTFskrWsazGe1ng/fTvz/+mA7hBSoqwFtRm/7qNJtnPMtn9AGdwkByY16abrOFTE7JS2huYrihpuN8Kc/s09Bo/ox7l4AQeshZ1OzBU/5k/zf1LwIGXFufiyWpL47NrcWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KH7ylrRD; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KFKxNw030406
	for <linux-rdma@vger.kernel.org>; Thu, 20 Mar 2025 15:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ore727
	rIr9UVnhsn4yxqEttgGC/zkGqTeItx4w2cjIE=; b=KH7ylrRDY00OH4teRlCAcY
	xBXKHRHncM+ELske424uJUojicHkkfvnf+1tj7jp66sR5r/i7tUorZA3txOsvh79
	5Syapo5GsAPWjzi+W11+arH8oFM/pIaf8tNHvgzePfCZDdWbtbXY+VW1CuXCjP+7
	pvZ7ZxnVFEGaLhyH93euWJ0NKhMXCMFmcc0IBmXU+7FzT/Xq3NnnTC9CaeXPHLWf
	O5u8V5ITPvKPwtzvaENrR09qWPzqGobhwkewYn/ACzNurXqVGJ97GORqEnJwfaqn
	Hy8wxmeQ2g+/9Rczmsnz1ZDWp4KUVPmfrYc/aDKQmpDrt726tcZ/lMDofBV8EMqg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g53qd1kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Thu, 20 Mar 2025 15:46:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52KFk1tF031437
	for <linux-rdma@vger.kernel.org>; Thu, 20 Mar 2025 15:46:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g53qd1k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 15:46:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7J6DzdtycyQRMML8dINPULZdK4wBDbkDQA0//E2Q1TAtDg/WHMx5/9rD14BfoCfbHZHXnaDTrReYLrn3ftqe5LUxLWU5KX9RKC6KM2Jl7qhfkNeXdwQF2T1jfCdY6EO09YVqISfgD6GoAmYBXTem0G3FDxpAoq1Paau4MIJc7vPoZfobxi0djog8ajWcHlzuyKqLs6aHTljxasr7JsheBbGdavEMTljzacvMWVTJD54U57nXRstZecRhVIHPO5tYlkTx2HywBlrnTjLQvVTV9hsXBrqEV0Hp4zv0utNX1zo2LbFSMvnGhkIG3WJQJq9dr7AQu0AlUyll6LcQOAK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh3kJlw+aLScPr60PfJa+7Y3KP68CPMadQmEy59W4nA=;
 b=SV+n0VZUpmi0mkCwBcN+XUon45j0SRSaO8mbP4Bff9ZKDcXcSd4X/eEOmbK3ML7WMvY+Cv/rUqv/lqqro0QFFxu5bYOsuE6kLQ/qh4DuFQRa2N2sqF4sibZ9yQTlFfftTTt+/vCnMiCpbhqRpupNu4PuRG7cMl7N8SZpVhoS5Qn6p0CICx4xdajIwE94+Fi8wcUvaXYZ97QuwmA4ekEjBpX7lypUF0VB1GI9RzWV6Av+T8ZNcIfWmyj562EJn0Lw5cGH2TdkzpAEklT7FZKA8U77jvk4Aud3R32yoRXKaWyLIgzcsyo7RIP8yTxTbmUrIteItFkdkLAAOXxkU1a5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by IA3PR15MB6745.namprd15.prod.outlook.com (2603:10b6:208:519::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 15:45:57 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 15:45:57 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>,
        syzbot
	<syzbot+17fb1664c4f5a2eeb36f@syzkaller.appspotmail.com>,
        "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Thread-Topic: [EXTERNAL] Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read
 in ib_device_uevent (2)
Thread-Index: AQHbmXPo3UI1AXVEpEqrUuxMIw3PFLN8KbuA
Date: Thu, 20 Mar 2025 15:45:57 +0000
Message-ID:
 <BN8PR15MB251302BDC48D4B001F6A540E99D82@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <67b25ec8.050a0220.54b41.000d.GAE@google.com>
 <c7ddbc01-f526-44dd-a7bd-69b9a38a040a@linux.dev>
In-Reply-To: <c7ddbc01-f526-44dd-a7bd-69b9a38a040a@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|IA3PR15MB6745:EE_
x-ms-office365-filtering-correlation-id: 68d76ff5-5648-4b14-fe8e-08dd67c64eb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZkFDS2VDWGI3cHZSZGI1SGxhWUNJbWl3cGtSTFFHaUJSWHFYNHQ0SUdoTmRP?=
 =?utf-8?B?WGVqQnpldm81ZWhBbkRNZyt1OTRhUGNNMlFpOWZ3TkpJcS9JOHlTYVJsbnp4?=
 =?utf-8?B?WHFZNVhYTktaUHRMeHkwT1Ezbk9MVUplREVSN0dyeTFhdXVwbnZhRkhnSUdF?=
 =?utf-8?B?NXYrTlo2YkttZHFKOXZiclE1SzQzSGp0ZHYrVWN1bU1rT1RnVmJQenVSem54?=
 =?utf-8?B?MlR1WTdNaENZRVNZTk9rRnVZRUVWOHFzYTRKZ1EwWFR1eTg2UENzdXNuSitJ?=
 =?utf-8?B?V0pIZEZjLzJtZWVvcTIwdTYrSVJYbys2bXdkVHdaWlpxQmZyeEk2bFkrdXRl?=
 =?utf-8?B?WER5eEM1KzVyTzlROXpYWE9mU0xINEtDVDdIWEZQSUg1d3FwaGtJcTROcWJL?=
 =?utf-8?B?d0lxK0lKaHNwQ3NBbHpiSHVqc3lUQ0UySi9WZDNYOXpwSHowK05hSTdFUVhj?=
 =?utf-8?B?d1AxQ2tmRXY0UXppOEUwbjQ4aUJtQmJLK3E3djU2OGI2QW5Xd3VVVUxwSzFG?=
 =?utf-8?B?ek9pRWdrNHFvaERTTEdNdlExR0RpM05JNWFXSUhEU00zZmRRMGxNQVFDb2xi?=
 =?utf-8?B?QzBXK1FFQ0Yzc1JsQ3prY1VpU2lJTWJqVEVPRWVRWVp4NzF5VXUzVUd5YUpz?=
 =?utf-8?B?UW82MmtBR1d0eGM1emdYTGxNTHFqemhzMVJTSWNTR2Noai8xa0dMYmJ2V0xK?=
 =?utf-8?B?UGg3Z2N1elIya29DSjFxTkQ5bzhhdVEzNkwzdURSWVdPazlWRmVJVkx0OXhR?=
 =?utf-8?B?b3hXYUM2VGswVGRHQzFVaWJNVnRUMG8rNXdsbHFHcWIwMXM0dURrSktKY1lh?=
 =?utf-8?B?TkRQMXFSbTQ5UzZNNWpHakZwU0pidHZkeDQ4Z0hMLzdpSVI4cCtZd0o5ZVJL?=
 =?utf-8?B?dnNSUldmMy8rbWd1elZtZ0p6OC9Pd3dYR2UrYXFCSjRBcmUvYmlzWVR1a0F3?=
 =?utf-8?B?aXJheTdmWUlZUGZmdDhZYzJjZEJmMTc3Z3dad0g2SlI1VEltWVIvcnBqcnNI?=
 =?utf-8?B?Z3doaGdIeFBMZW9MUlJPcERNWWZrZkhXMnBYdUhrMk16d1huSjg0azJKSEV1?=
 =?utf-8?B?L3lUM1VBL3dRc01WVE9hU1BrQTRWVWprR216bm5CalFQbFhCb0U4RGl3cklG?=
 =?utf-8?B?aENEcmUrWjBpVjBhQmE2aEt5NGo5Q0J4V3E2bVlvM25zWVVnWmFZeWFrZGVE?=
 =?utf-8?B?NDRKR3k0RHN6ZVpTV0VKZDdJNHlMNHNYM2tRMG9CcHZzSXlybktLd2VSd2tu?=
 =?utf-8?B?c0JxL3daT00rb3hVdWpITW1TaXhJOHVTSGM0aEI1TmtJUlZIUFhiUEt6UHVX?=
 =?utf-8?B?UUtod1hEZ0RScCtnVkRkOFpWSW0rNStKR29ITmNzaUw1dFNCTnJZMHNIRDdj?=
 =?utf-8?B?WENvZVdONkxKRURRbzBaVXk2anN5VHZiWGFHbUdzS3B5UVRPL0xlTjloamVE?=
 =?utf-8?B?dy9sTjdVTC9VZUxnNGFEUHE2Wm81eUNha3ZJc0lUMDBFT1dCaGRCb2Vkeml4?=
 =?utf-8?B?L1VMcXRjc0ZXRERxUktBbEVDdlMzRmZ0cDdiYURQS1I2VmdDaW9nZzVyQXla?=
 =?utf-8?B?em51U1E0YlpOMGlGZDJqc29sZUpHdFVXN1dlNE90K0Z2dmlqL2JkZzNGY3RW?=
 =?utf-8?B?c1Y5SFdrNUtJZkxIL2FHblY5VVIxMWw0RlpHelc2M2Nwa1dzTm9vNXF4R3NO?=
 =?utf-8?B?WU1jRExjSGNtWitQVWtwSDFlR09BOFNZdEJhcFk4YUJCSTAwYWlkempxYzJF?=
 =?utf-8?B?MGhZOHNCTkY5N2JUN0d6QURUaVcyWEJnSnBWTWI2MGh4UHlxbVdZZUppeWpj?=
 =?utf-8?B?SUl6VHNVQmI1OUdRSkp3SFNDcm9zZkw1eXJEd0FQYlcyOFcyZUlzQjVSZXRz?=
 =?utf-8?B?WVdTU3pRdWpQb0tBbEYyVFN2V1pqZ2RFMjQ2elFEUnlCaUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0VXTW5kSTc3N2lXMDhpdkpPeHhnQyt1cTVleE9qU1N0WUxiZ3haU2ZCeGIx?=
 =?utf-8?B?QStoK3R5VER4QnlrbVM5WHgzZW5qS2FyZEFGZWJZbGl5Z3VTVlFNUU1Wa0RS?=
 =?utf-8?B?NThDemd4SFRWYVVzMEZSdFgrSkhEbWUxekV1ZDYrVUNWRUoyU3dFVk5VeEl0?=
 =?utf-8?B?MzRvVUg5WUtaWFJqQndtNmk3RGY1VW9GclFrOXR1RnROclZucXJnYlpoU29G?=
 =?utf-8?B?M3VTYVFTMDhmOEhBSVJsbHlMTDAxcjd4bW1PcEdtenVTcjNmSzM1MlNCUlIx?=
 =?utf-8?B?VDQwOWNlVWJwc3VhV3VReTFabG9CVk0ralZVU1BTcCtZaHdpUm9lR0ZrOWEz?=
 =?utf-8?B?T3djUUorazBkS20weWl0M0hOMmxPNGJjTENPMWtKZktZWnRpTFNmUko3ckdi?=
 =?utf-8?B?RmJLTzc2NFFlMFhyaUFIWDA3UDlVNzB3cmFtN3ZnOXg2WC8xUEY0UGhnTGRw?=
 =?utf-8?B?WkZKVXE3bmRaanVpQVlhcVVKdjBHWVZmR3NKRTdqeEdZYkRnL0RRLzQ3UzlK?=
 =?utf-8?B?RFVDaGlzNnRiSDcyaXZVTVdjbCsxWHFtT0lzczNYaUZBTkdVZFZNZ05GVWpw?=
 =?utf-8?B?MXBOb3RiNG5pME85NVk1ZnAzRUtNaC9razd4cExzdU01dXFRZmNoTTFhb0Z4?=
 =?utf-8?B?TDJPLzFOSmxlaWRTcXVJODVEMG5xTVFuQ3dJVi93TGpGSit4d0lNdEdzekJx?=
 =?utf-8?B?YjNWcjdJNDk4REFIUHRsbkFjVEdNR0pONWVkS1ErbnFmb24vSTNPc2tURldz?=
 =?utf-8?B?YW9CZnJJRFFaZkR1cWV5cFYzNEZROU1BM3pIWlJkRWwwNnJSUHNXRUgvTitE?=
 =?utf-8?B?VVBmRVo2SnN3aVZwemNsKzZZTGMva2ZOVlFsbk9GUTYwV2gyeHRWZVhKUUZo?=
 =?utf-8?B?alh4akg5R2JIY3lJZVBuRzV5YzA4NXQ5R0N3L2dYOTZTR2Q0cmcyeUNkQmQz?=
 =?utf-8?B?RlVQRmxYU2xKVmNmb25MK0lteU5QQms4Vms0UDVRRXY2bmkrWWNiRE9hSEtV?=
 =?utf-8?B?ODhmOTBVSCtWSGNJbmVlMUVCUHhkeEFVaUxkVXYwMEFMTUNvejAyN0NvdzRX?=
 =?utf-8?B?MnZZQzgzdmRpczJ4VDA4S0NleHBJS2s1Tld1MDZaaFpUME5WdkNFMytHUlBJ?=
 =?utf-8?B?NENDTm4xWGlIN252WnNsd0o4QXVUTWM1eFhQYVhjSXkrcnByZHdWRGhSbTBE?=
 =?utf-8?B?L2pHbi8yNGJRYkhVY1IwOXlja3hCOWxIanhmcDZNSDlWTlNmZmVzZkM0RHVD?=
 =?utf-8?B?Rjg0KzdGNkZjR2N1dER4NWdkdXJid1laVktsU2l4ZTFaUml4YThtdU9GMXRJ?=
 =?utf-8?B?ZGI0K3EzdTUzUGJHWHJFQlZvMERyQ2hDazZUWmdXblp4dVFoSkdacHZGUEdj?=
 =?utf-8?B?S2ltV2dHRDhnQmJOWUxWS0cwS2Q2SndhUSthRmJOK2RHUGhhZytub3FvOVA5?=
 =?utf-8?B?RWtlNSt1Q2FhSzZMSVVZTW96YlFlV3pnSjhIc3dHcTcxbXpCQldQdThBUzg3?=
 =?utf-8?B?aEhqaWY0MjVZclExYzl4VHRxR3lJc1BSekgyR2xYOHBjQnI4Y1k3L1dTdTE3?=
 =?utf-8?B?alZrbzQwWEZqT01paHdxNVVSanQ1RXlocUU1K3UvNmlwOVNQMlNZSjZJWFM2?=
 =?utf-8?B?MlJrd09NbGE3ek9BZWJuTytPSFJCME5TK1Nqam0rckZ3dlA0V1F2ZmhMSVlz?=
 =?utf-8?B?RXVKWlorWlMrbVdxWWtIckl3NGgxQytJbm5HRTJvdU95dzZxWnZhQjAwZDdZ?=
 =?utf-8?B?eng2QW81UmhzalcwT1pOU3JBemlxbi90UEtnOHZJVUdpUG1xN0E2NXgwVTNj?=
 =?utf-8?B?c08rZzJpVUdFVmxGdHBQK1BKbVpkd1NCRFFzWSt6dDRpU2xCSUlxWDdkdHhU?=
 =?utf-8?B?VmlOZWdmOGlIdGRxT2pJUkhkcE9ZUnJFUUJMT3hLWWtTRHdlNW8zM1NoM2hR?=
 =?utf-8?B?Y1ZYbmIySnFkUVNuaEFIaXltZUpISGNvODQxdDFVQlI5a25kUlpJc3habkp2?=
 =?utf-8?B?c09lTndma1IzbzVQMDFSRmMwVzBoYUxJeE5GWEk0czF5NGxtVmJ3dUFEVDla?=
 =?utf-8?B?bUVGVlNFb0Y1NjBRS1FBK1FnUGhQK1Vwd0dMRFNwZS8waXI5TjF2SGlKb3U1?=
 =?utf-8?B?Rnp6WWJBMHo2L1diRk05YWRkWGdJSFdzUTFjVWFGbS9wVm5MU2MxNHlWRitI?=
 =?utf-8?Q?8pqRfKof5hIyuU/BF+CXBpA=3D?=
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d76ff5-5648-4b14-fe8e-08dd67c64eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 15:45:57.7532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVJ943uBJVAOA0gO05SWWB5drRNyefUqu0z8Ld7N9J7fn+O5yLvdS0RLg0isi+nYeRHNM2AcCGO3UsThuJfQTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR15MB6745
X-Proofpoint-GUID: ZEnmSxfjL6sRPnojAxygmdl3OAmxqt6P
X-Proofpoint-ORIG-GUID: ZEnmSxfjL6sRPnojAxygmdl3OAmxqt6P
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ib_device_uevent
 (2)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=2
 engine=8.19.0-2502280000 definitions=main-2503200097



> -----Original Message-----
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> Sent: Thursday, March 20, 2025 9:41 AM
> To: syzbot <syzbot+17fb1664c4f5a2eeb36f@syzkaller.appspotmail.com>;
> jgg@ziepe.ca; leon@kernel.org; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; netdev@vger.kernel.org; syzkaller-
> bugs@googlegroups.com
> Subject: [EXTERNAL] Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read =
in
> ib_device_uevent (2)
>=20
> On 16.02.25 22:55, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    09fbf3d50205 Merge tag 'tomoyo-pr-20250211' of
> git://git.c..
> > git tree:       upstream
> > console output: https%=20
> 3A__syzkaller.appspot.com_x_log.txt-3Fx-
> 3D140563f8580000&d=3DDwICaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZX=
bhvovE4t
> YSbqxyOwdSiLedP4yO55g&m=3DsrgskMI0sa3T0mS2H_izLLDgZ1Sh2TpNoxBofzPAozKcJ4g=
PxEc
> BAbeCqJelsb3Q&s=3D4HoaGCofTzC69mNNZLu7urW39zt-qZ0jHEwjCNq3e9Y&e=3D
> > kernel config:  https%=20
> 3A__syzkaller.appspot.com_x_.config-3Fx-
> 3D641fe3e3cfee64bb&d=3DDwICaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUc=
ZXbhvovE
> 4tYSbqxyOwdSiLedP4yO55g&m=3DsrgskMI0sa3T0mS2H_izLLDgZ1Sh2TpNoxBofzPAozKcJ=
4gPx
> EcBAbeCqJelsb3Q&s=3DjAjZbjn-w2sZsfK2gPXlLFltAGHvZLQFzWfk1TvVDc8&e=3D
> > dashboard link: https%=20
> 3A__syzkaller.appspot.com_bug-3Fextid-
> 3D17fb1664c4f5a2eeb36f&d=3DDwICaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_=
4MUcZXbh
> vovE4tYSbqxyOwdSiLedP4yO55g&m=3DsrgskMI0sa3T0mS2H_izLLDgZ1Sh2TpNoxBofzPAo=
zKcJ
> 4gPxEcBAbeCqJelsb3Q&s=3D5B7eaLwpVQ_61Ux3yGd2CKLvh-uQsJf4-9v4bbRC0uk&e=3D
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for
> Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image (non-bootable):
> https%=20
> 3A__storage.googleapis.com_syzbot-2Dassets_7feb34a89c2a_non-5Fbootable-
> 5Fdisk-
> 2D09fbf3d5.raw.xz&d=3DDwICaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZ=
XbhvovE4
> tYSbqxyOwdSiLedP4yO55g&m=3DsrgskMI0sa3T0mS2H_izLLDgZ1Sh2TpNoxBofzPAozKcJ4=
gPxE
> cBAbeCqJelsb3Q&s=3Dhw8G10Pj-FRcaJZfChWmSKE8GaozuUeI85UvisfTHEQ&e=3D
> > vmlinux: https%=20
> 3A__storage.googleapis.com_syzbot-2Dassets_31b409a4b675_vmlinux-
> 2D09fbf3d5.xz&d=3DDwICaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZXbhv=
ovE4tYSb
> qxyOwdSiLedP4yO55g&m=3DsrgskMI0sa3T0mS2H_izLLDgZ1Sh2TpNoxBofzPAozKcJ4gPxE=
cBAb
> eCqJelsb3Q&s=3DIh8IyDMEvy9jwvc2noeIX5E0FgZRM8D2RmxTNE3nih4&e=3D
> > kernel image: https%=20
> 3A__storage.googleapis.com_syzbot-2Dassets_27f349d4d8cb_bzImage-
> 2D09fbf3d5.xz&d=3DDwICaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZXbhv=
ovE4tYSb
> qxyOwdSiLedP4yO55g&m=3DsrgskMI0sa3T0mS2H_izLLDgZ1Sh2TpNoxBofzPAozKcJ4gPxE=
cBAb
> eCqJelsb3Q&s=3DPMgqb590AII6znT2g--1TKjjkadAlznJi0aFX-v9Pnw&e=3D
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> > Reported-by: syzbot+17fb1664c4f5a2eeb36f@syzkaller.appspotmail.com
>=20
> To this problem, I just looked through this problem which occurred on
> iwarp. I remember a similar problem which occurred on rxe.
> To the problem on rxe, the solution
> https%=20
> 3A__patchwork.kernel.org_project_linux-2Drdma_patch_20250313092421.944658-
> 2D1-2Dwangliang74-
> 40huawei.com_&d=3DDwICaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZXbhv=
ovE4tYSb
> qxyOwdSiLedP4yO55g&m=3DsrgskMI0sa3T0mS2H_izLLDgZ1Sh2TpNoxBofzPAozKcJ4gPxE=
cBAb
> eCqJelsb3Q&s=3DYC4HmD2kVw28DToigJwJRY1U8oNFfvQgMF2S5wpatak&e=3D
> seems to be able to fix it.
>=20
> I am not sure if this problem can also be fixed by the above solution or
> not.
>=20

I would assume yes. The stack trace is very similar.

Thanks,
Bernard.

> Best Regards,
> Zhu Yanjun
>=20
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:632
> [inline]
> > BUG: KASAN: slab-use-after-free in string+0x4a6/0x4f0 lib/vsprintf.c:714
> > Read of size 1 at addr ffff88803e895ea0 by task udevd/6903
> >
> > CPU: 1 UID: 0 PID: 6903 Comm: udevd Not tainted 6.14.0-rc2-syzkaller-
> 00039-g09fbf3d50205 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-
> 1.16.3-2~bpo12+1 04/01/2014
> > Call Trace:
> >   <TASK>
> >   __dump_stack lib/dump_stack.c:94 [inline]
> >   dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> >   print_address_description mm/kasan/report.c:378 [inline]
> >   print_report+0xc3/0x620 mm/kasan/report.c:489
> >   kasan_report+0xd9/0x110 mm/kasan/report.c:602
> >   string_nocheck lib/vsprintf.c:632 [inline]
> >   string+0x4a6/0x4f0 lib/vsprintf.c:714
> >   vsnprintf+0x4c8/0x1180 lib/vsprintf.c:2843
> >   add_uevent_var+0x17c/0x3a0 lib/kobject_uevent.c:679
> >   ib_device_uevent+0x4e/0xb0 drivers/infiniband/core/device.c:502
> >   dev_uevent+0x28b/0x770 drivers/base/core.c:2673
> >   uevent_show+0x1d8/0x3b0 drivers/base/core.c:2731
> >   dev_attr_show+0x53/0xe0 drivers/base/core.c:2423
> >   sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
> >   seq_read_iter+0x4f4/0x12b0 fs/seq_file.c:230
> >   kernfs_fop_read_iter+0x414/0x580 fs/kernfs/file.c:279
> >   new_sync_read fs/read_write.c:484 [inline]
> >   vfs_read+0x886/0xbf0 fs/read_write.c:565
> >   ksys_read+0x12b/0x250 fs/read_write.c:708
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f7681378b6a
> > Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31
> c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0
> ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
> > RSP: 002b:00007ffcbdf9d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > RAX: ffffffffffffffda RBX: 000055efbec7de20 RCX: 00007f7681378b6a
> > RDX: 0000000000001000 RSI: 000055efbeca9490 RDI: 0000000000000008
> > RBP: 000055efbec7de20 R08: 0000000000000008 R09: 0000000000020000
> > R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000003fff R14: 00007ffcbdf9d518 R15: 000000000000000a
> >   </TASK>
> >
> > Allocated by task 12483:
> >   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
> >   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> >   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> >   __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
> >   kasan_kmalloc include/linux/kasan.h:260 [inline]
> >   __do_kmalloc_node mm/slub.c:4294 [inline]
> >   __kmalloc_node_track_caller_noprof+0x222/0x510 mm/slub.c:4313
> >   __kmemdup_nul mm/util.c:61 [inline]
> >   kstrdup+0x53/0x100 mm/util.c:81
> >   kstrdup_const+0x63/0x80 mm/util.c:101
> >   kvasprintf_const+0x164/0x1a0 lib/kasprintf.c:46
> >   kobject_set_name_vargs+0x5a/0x140 lib/kobject.c:274
> >   dev_set_name+0xc8/0x100 drivers/base/core.c:3468
> >   assign_name drivers/infiniband/core/device.c:1202 [inline]
> >   ib_register_device+0x7e0/0xdf0 drivers/infiniband/core/device.c:1384
> >   siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
> >   siw_newlink drivers/infiniband/sw/siw/siw_main.c:431 [inline]
> >   siw_newlink+0xb60/0xd70 drivers/infiniband/sw/siw/siw_main.c:413
> >   nldev_newlink+0x38e/0x660 drivers/infiniband/core/nldev.c:1795
> >   rdma_nl_rcv_msg+0x388/0x6e0 drivers/infiniband/core/netlink.c:195
> >   rdma_nl_rcv_skb.constprop.0.isra.0+0x2e6/0x450
> drivers/infiniband/core/netlink.c:239
> >   netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
> >   netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1348
> >   netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1892
> >   sock_sendmsg_nosec net/socket.c:718 [inline]
> >   __sock_sendmsg net/socket.c:733 [inline]
> >   ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
> >   ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
> >   __sys_sendmsg+0x16e/0x220 net/socket.c:2659
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 12485:
> >   kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
> >   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> >   kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
> >   poison_slab_object mm/kasan/common.c:247 [inline]
> >   __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
> >   kasan_slab_free include/linux/kasan.h:233 [inline]
> >   slab_free_hook mm/slub.c:2353 [inline]
> >   slab_free mm/slub.c:4609 [inline]
> >   kfree+0x2c4/0x4d0 mm/slub.c:4757
> >   kfree_const+0x55/0x60 mm/util.c:43
> >   kobject_rename+0x179/0x260 lib/kobject.c:524
> >   device_rename+0x130/0x230 drivers/base/core.c:4525
> >   ib_device_rename+0x114/0x5c0 drivers/infiniband/core/device.c:402
> >   nldev_set_doit+0x3be/0x4c0 drivers/infiniband/core/nldev.c:1146
> >   rdma_nl_rcv_msg+0x388/0x6e0 drivers/infiniband/core/netlink.c:195
> >   rdma_nl_rcv_skb.constprop.0.isra.0+0x2e6/0x450
> drivers/infiniband/core/netlink.c:239
> >   netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
> >   netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1348
> >   netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1892
> >   sock_sendmsg_nosec net/socket.c:718 [inline]
> >   __sock_sendmsg net/socket.c:733 [inline]
> >   ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
> >   ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
> >   __sys_sendmsg+0x16e/0x220 net/socket.c:2659
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > The buggy address belongs to the object at ffff88803e895ea0
> >   which belongs to the cache kmalloc-8 of size 8
> > The buggy address is located 0 bytes inside of
> >   freed 8-byte region [ffff88803e895ea0, ffff88803e895ea8)
> >
> > The buggy address belongs to the physical page:
> > page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
> pfn:0x3e895
> > flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > page_type: f5(slab)
> > raw: 00fff00000000000 ffff88801b042500 ffffea0000a05a00 dead000000000002
> > raw: 0000000000000000 0000000000800080 00000000f5000000 0000000000000000
> > page dumped because: kasan: bad access detected
> > page_owner tracks the page as allocated
> > page last allocated via order 0, migratetype Unmovable, gfp_mask
> 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 11986, tgid
> 11985 (syz.1.1513), ts 150711065425, free_ts 150704805794
> >   set_page_owner include/linux/page_owner.h:32 [inline]
> >   post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
> >   prep_new_page mm/page_alloc.c:1559 [inline]
> >   get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3477
> >   __alloc_frozen_pages_noprof+0x221/0x2470 mm/page_alloc.c:4739
> >   alloc_pages_mpol+0x1fc/0x540 mm/mempolicy.c:2270
> >   alloc_slab_page mm/slub.c:2423 [inline]
> >   allocate_slab mm/slub.c:2587 [inline]
> >   new_slab+0x23d/0x330 mm/slub.c:2640
> >   ___slab_alloc+0xc5d/0x1720 mm/slub.c:3826
> >   __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3916
> >   __slab_alloc_node mm/slub.c:3991 [inline]
> >   slab_alloc_node mm/slub.c:4152 [inline]
> >   __do_kmalloc_node mm/slub.c:4293 [inline]
> >   __kmalloc_node_noprof+0x2f0/0x510 mm/slub.c:4300
> >   __kvmalloc_node_noprof+0xad/0x1a0 mm/util.c:662
> >   kvmalloc_array_node_noprof include/linux/slab.h:1063 [inline]
> >   __ptr_ring_init_queue_alloc_noprof include/linux/ptr_ring.h:471
> [inline]
> >   ptr_ring_resize_multiple_bh_noprof include/linux/ptr_ring.h:634
> [inline]
> >   skb_array_resize_multiple_bh_noprof include/linux/skb_array.h:208
> [inline]
> >   pfifo_fast_change_tx_queue_len+0x157/0xbb0 net/sched/sch_generic.c:909
> >   qdisc_change_tx_queue_len net/sched/sch_generic.c:1410 [inline]
> >   dev_qdisc_change_tx_queue_len+0x166/0x380 net/sched/sch_generic.c:1457
> >   dev_change_tx_queue_len+0x1a3/0x1e0 net/core/dev.c:9362
> >   dev_ifsioc+0xdfe/0x10d0 net/core/dev_ioctl.c:608
> >   dev_ioctl+0x224/0x10c0 net/core/dev_ioctl.c:826
> >   sock_do_ioctl+0x19e/0x280 net/socket.c:1213
> >   sock_ioctl+0x228/0x6c0 net/socket.c:1318
> > page last free pid 11986 tgid 11985 stack trace:
> >   reset_page_owner include/linux/page_owner.h:25 [inline]
> >   free_pages_prepare mm/page_alloc.c:1127 [inline]
> >   free_frozen_pages+0x6db/0xfb0 mm/page_alloc.c:2660
> >   __put_partials+0x14c/0x170 mm/slub.c:3153
> >   qlink_free mm/kasan/quarantine.c:163 [inline]
> >   qlist_free_all+0x4e/0x120 mm/kasan/quarantine.c:179
> >   kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
> >   __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:329
> >   kasan_slab_alloc include/linux/kasan.h:250 [inline]
> >   slab_post_alloc_hook mm/slub.c:4115 [inline]
> >   slab_alloc_node mm/slub.c:4164 [inline]
> >   __kmalloc_cache_noprof+0x243/0x410 mm/slub.c:4320
> >   kmalloc_noprof include/linux/slab.h:901 [inline]
> >   kmalloc_array_noprof include/linux/slab.h:945 [inline]
> >   ptr_ring_resize_multiple_bh_noprof include/linux/ptr_ring.h:629
> [inline]
> >   skb_array_resize_multiple_bh_noprof include/linux/skb_array.h:208
> [inline]
> >   pfifo_fast_change_tx_queue_len+0xe1/0xbb0 net/sched/sch_generic.c:909
> >   qdisc_change_tx_queue_len net/sched/sch_generic.c:1410 [inline]
> >   dev_qdisc_change_tx_queue_len+0x166/0x380 net/sched/sch_generic.c:1457
> >   dev_change_tx_queue_len+0x1a3/0x1e0 net/core/dev.c:9362
> >   dev_ifsioc+0xdfe/0x10d0 net/core/dev_ioctl.c:608
> >   dev_ioctl+0x224/0x10c0 net/core/dev_ioctl.c:826
> >   sock_do_ioctl+0x19e/0x280 net/socket.c:1213
> >   sock_ioctl+0x228/0x6c0 net/socket.c:1318
> >   vfs_ioctl fs/ioctl.c:51 [inline]
> >   __do_sys_ioctl fs/ioctl.c:906 [inline]
> >   __se_sys_ioctl fs/ioctl.c:892 [inline]
> >   __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Memory state around the buggy address:
> >   ffff88803e895d80: 05 fc fc fc fa fc fc fc 05 fc fc fc fa fc fc fc
> >   ffff88803e895e00: 05 fc fc fc 00 fc fc fc 05 fc fc fc fa fc fc fc
> >> ffff88803e895e80: 05 fc fc fc fa fc fc fc 05 fc fc fc 00 fc fc fc
> >                                 ^
> >   ffff88803e895f00: 05 fc fc fc 05 fc fc fc 05 fc fc fc fa fc fc fc
> >   ffff88803e895f80: 05 fc fc fc 00 fc fc fc 05 fc fc fc fa fc fc fc
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https%=20
> 3A__goo.gl_tpsmEJ&d=3DDwICaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZ=
XbhvovE4
> tYSbqxyOwdSiLedP4yO55g&m=3DsrgskMI0sa3T0mS2H_izLLDgZ1Sh2TpNoxBofzPAozKcJ4=
gPxE
> cBAbeCqJelsb3Q&s=3D9KITFSQjSP-M8czK13OhII3KvAyuGKJaXzqd8UkFCUA&e=3D  for =
more
> information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ%=20
> 23status&d=3DDwICaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZXbhvovE4t=
YSbqxyOw
> dSiLedP4yO55g&m=3DsrgskMI0sa3T0mS2H_izLLDgZ1Sh2TpNoxBofzPAozKcJ4gPxEcBAbe=
CqJe
> lsb3Q&s=3DJclx0sFtbIZqLvA1ZP_CtdN-lZHrwyGSFSAz6f8W4Ng&e=3D  for how to
> communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
>=20


