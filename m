Return-Path: <linux-rdma+bounces-16803-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBYNOSzHjmk1EwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16803-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 07:39:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A06E133477
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 07:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D7D4300B9CF
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 06:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDFD24DFF3;
	Fri, 13 Feb 2026 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FFUBAshL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jd7OR8sN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE61F03EF;
	Fri, 13 Feb 2026 06:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770964773; cv=fail; b=amUthI2OT9FtvdghftarPvDVSk2HL6NhJLr5NaF+W1WvwbDSt53R/f0aPHsFPxZSTOHsRAAP8mOCIPcLfKkrFiOi8bdwHVFD5a6O41+jL6SyJRV6q1TU8kmTDy9/JpeApSv08pz7Slmgz25B0RuSY8qdDNKqJcQV3Y27UTWS0Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770964773; c=relaxed/simple;
	bh=bXYytqh8H7bMHfEvMPwlErf39XJITljQjx4fOOYFc4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqvUBZ4lixyvMYwo3DNFhifC3+6lrf1Pst5f4JsSbxJfG0/zZPXhI1JKSpjZAwRgei5vrqubHscQCxJStwnUPVOUQVii5wNvYsV9XFZ78MQkMwT13Zh4QgO7YVZGb1/Ft23WLW2Iiv2Vi4ZqOx6k5Rxib/LSWNEOWdVJd6yKA7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FFUBAshL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jd7OR8sN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CGNCme964564;
	Fri, 13 Feb 2026 06:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bXYytqh8H7bMHfEvMPwlErf39XJITljQjx4fOOYFc4E=; b=
	FFUBAshLZHUazQXd3YegkcCb8wrlaXRBY2t+P3KsO7aj9rRgF/6G4uaBbZ/Hp5Sc
	M+bhpO/SKpax+kSG7ejf/5lRg75rUghWIZebS3hg2bTKnnSNyHjdyr07dXW5Npnl
	0IxlC7E4MyjpWjMsWzuZysB0lRDEu9AqaDjJCgD/MKps4E6XbnpFy21vfmZtOR2a
	nvnjdG8cWusUC/WkPtUTl+f8+5l0iclnEvyoIQ1U5TA6FSB5sD5T36X/15dSQNDi
	adkyF1C8YkZCYhYp2TG3ENgGehZ0FDBEODsH5rDg44+TqHawLu/ACpMlfDx7zQb6
	+Ea+ISm4WrnR1Cl7759Tjw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c7rxu63qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 06:39:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61D6W1sr030178;
	Fri, 13 Feb 2026 06:39:25 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c822by12v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Feb 2026 06:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beiAt7io7CCgce4WPeelTI2H48A5ViRoTqA5JizN5tFfX2Ktj+TpralzxocbzKO5qJjfyknvF7uhJLeyaSRCOYQCeR20erDRkqXFd9MZtlxW01YlqQBiGAiB1if+9XrYTJBUCUJ9Alx4tr5itAPmeLIHSkduydoFVMGfqZg22fkeBHWLl7B4KiMNEskypUZ8FovW4qiM6I3y0oRmlf+6Im0HAQpdQqkj0VI4rkOqlVBGd+5MDgtEF+aeTGYi/6m8M0APwDban7+qXeSXmCZmKRNs38HF207WEsNrqtTqfNKH5wUwDaoT7iWLm5rVzdppTKMczqtskhrl7PZhrRjmKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXYytqh8H7bMHfEvMPwlErf39XJITljQjx4fOOYFc4E=;
 b=LY33UnYKaaRFx4TQjBCPRJBk+50nfqWs2+9Q2qyfusK0ARQfLgal1J1Rt8gLb85vIMtdFeg/jlsEebpKKSbDyhUOQUROtzEQm2KR2jq0cBNQ4nsVrZK2NLsDrjdJ5zm32GfzP3STbuYXtJQRi1hEIlVCo+Alaw8w3r67vUGCyDvWqwEtlX0OsP50kta6NLH/PhLkXqmUN9CCdHnZgtaPmga46lWOuotYh++2wU/5G/Bm7goTKc+1DQY9NzRi3db0Qq3lqb4YY/aZ1PNLwAfZfFblzWDeVJscyAovYB08MyC6XSPYbiymjk6VOVPvywG65lM1icMNFL68RrYmqh46eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXYytqh8H7bMHfEvMPwlErf39XJITljQjx4fOOYFc4E=;
 b=Jd7OR8sNlRNy52xyzBfpJK/o2w5R9t2dDwlC0Wu+tDYs2mWuBUe7ZodZzPPvtdXnAGk8Z7d8OcJDDFJn6afAL2LpWnHPHibUIr99RNvs6wRSY+PIOwT5x3rb6IjiCSGjVMPxKASlxj88X4oTQFq/nRwv+Iv23MniDwQ147UeJbk=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 SA1PR10MB7789.namprd10.prod.outlook.com (2603:10b6:806:3ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 06:39:21 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::42e:713d:d4c8:793f%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 06:39:21 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuba@kernel.org" <kuba@kernel.org>,
        "achender@kernel.org"
	<achender@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net v2] net/rds: rds_sendmsg should not discard
 payload_len
Thread-Topic: [PATCH net v2] net/rds: rds_sendmsg should not discard
 payload_len
Thread-Index: AQHcmrAb5IDQK1Cy/0mV2TteQyePkLV/9d0AgAA7twA=
Date: Fri, 13 Feb 2026 06:39:20 +0000
Message-ID: <161c459cb7c3aebe91601286e7842dc26692a850.camel@oracle.com>
References: <20260210170952.1836306-1-achender@kernel.org>
	 <20260212190534.7faf2878@kernel.org>
In-Reply-To: <20260212190534.7faf2878@kernel.org>
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
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|SA1PR10MB7789:EE_
x-ms-office365-filtering-correlation-id: ed341595-1366-4415-5880-08de6aca9e9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NlFTbDV4aGRpaUtsNEVndzJEZnZMbzU3em5qaldsYzVCTDVLUjJ3aUM0dEZ5?=
 =?utf-8?B?Ui9iTmtqVW1SVEdqcGxQQUg5aElmN1VKSG9ZNjB6Y2lVdTFpTk9FcWhwRER6?=
 =?utf-8?B?ZTFCZ214V0c0RzJGbkpJQVhEL1pEeEtpZDlHMlF0eXNlWHQvSnExNnNsUDc3?=
 =?utf-8?B?UHhTN1ZTU0RsVHpCN0RILzFBS2Q3UWRjVjJBdWJXM3gvb1l2K1h3NDNoa1Rs?=
 =?utf-8?B?ZFNpclFNTGZJaC9Wa0J3bDJpRE1ad2RxRnZBRXRnVEIvYU1qMkR0S0dmSEIx?=
 =?utf-8?B?dG93cGN6YXlMeTAzWUVFTS9IRjA3SGExT3cwVzFibVh0cnN2Q0ZpdXQ5OWk5?=
 =?utf-8?B?S2ZjNFNkODIwMmZWblhnQVJNaUFuYnNWbkc3dW8ra3NYZVM1NXNsWEpEWnRr?=
 =?utf-8?B?OFVxU0g5M09KeHRtSWVrT05CdlA5Q3p2cVB0d0M2ODIrd0ZUMzViVUQ3ZnpU?=
 =?utf-8?B?dE16dGtrTlhEeGRmUU14QW8zcWdxNFJ4VTB3ODRkU0VoQit2clh4MkRjYUZW?=
 =?utf-8?B?TVNOOVoyU2gwdjBPZWtzeDFQVmFUYlVuNk1SK1llcjRZY1ZEVytpSHVjcWpW?=
 =?utf-8?B?N01Yd0JocDNEK0xtOS9nUU90eGdRZ0tyQkJuc1VsS2ZlVFhHK2k5QkQrblVG?=
 =?utf-8?B?ZEgxZ3lIYm5kWGZaZHVBSHR6NnBiQWlxZ2lJMzhSSHhSNXJKRXY5TkhqdWRm?=
 =?utf-8?B?ZXNwSFAyemQrWGxmNlRDUUxEM0JBejlYMFlMOTBoY0gyMUhYMkNhbURFeU44?=
 =?utf-8?B?U2d1aWRQbG1LcElWV01FSkdBNFh2L2s3SFY0UTZwMTA1K1h5ZzQzM0pqUkVI?=
 =?utf-8?B?TVJlNlJGanZGaVFxaHJKNVhFZjNHTXhaT0hhbStiN1NLYVFGeDA5NzljQ0xR?=
 =?utf-8?B?VmJod0srSDhNc2ZLaUUzbmJrWWF0eG40SE5TMXBaWWdQSDNLL25HblhlQlJu?=
 =?utf-8?B?TWMzbUQxb0YyNFpVZGN1SjVWTnAvZkJQbTFaTy9LYll4MUxuRklDQkxycmE3?=
 =?utf-8?B?dGswVVZuL3MvUWRwdFN5YlVNS0pyM0xOUUZrRU5PcWdiN2FtZmtNSVcxS3F2?=
 =?utf-8?B?WnBjWGJmQnRKYlVkZW90NEhEOFREQzhsbUJ2K3A0aVNra3BZaUttRDJuVVRV?=
 =?utf-8?B?MHNIcnU5NXROYmQ5YVZBVmhXT0ZtQ052MFVSb1FlQmlxc3VrK01pMkVXbkVP?=
 =?utf-8?B?c1lZNkUwZUd4ZkErS00vdDZLa0puWUNKVHYrS1RzTGZSR3JEbWtuVk9CcmpT?=
 =?utf-8?B?UlpOY3duKzVTU0g4NDFzU0FadWM0SjU4SlJ3MFVaS0Z4aEdlT204N05rODl3?=
 =?utf-8?B?c0VSa3RpV2NQVWw5OVppTlU1aEFJMi8yRTlKMk1yR05RUWpUOVZ6WSs1dENa?=
 =?utf-8?B?UWs1bW1xVHRzUk1IbEhodDRJa0ZMVzFZNjZnMlRqMDc2bFIyKzFrY1c0Wk1D?=
 =?utf-8?B?NG9JdzlGU1hybnVmRFFBK1BPWTFBSkFtKzRDQzg3RWJsSHdsTTg3OWhDcktG?=
 =?utf-8?B?WEI3VEJSc2l2VjJLOXk5WXFIUk02WHUrZnN2MC9LWDR3dTM4TFR6MVZJQ01I?=
 =?utf-8?B?M3ROT3NWeFZ3ZTVwZ0RjVCtKM0pPQmQ3eHNaQndtUlh6Q0J2WmpzMEtKNndy?=
 =?utf-8?B?UzdseUU5SHltSXhkTm54TkMyWnpQMndKeThiK0pkOWpFMEVSb3N6eDZ6bG9Q?=
 =?utf-8?B?V1k3TlV0Ny9vaVV6Zkg5RjN3VTVrUitPTGRzVTJZY3hTN05rODBZTk4vak1W?=
 =?utf-8?B?Sm1ra2JmajRZb3FHOG1QdGl1YmpERnpsdWNDZFZzTGxNbURtdjZwTjJHbVRF?=
 =?utf-8?B?eGl2b0M1R3YvVm9mdSs3Q09UUlluSENqZ2p6dHBVem8zbDJUYk9yQUtHSHFS?=
 =?utf-8?B?SDRhbTI3dkIxaElMMHFSU05UTEsyd3V2d3NpaVVpR3M2dkF4L1ZQRHFPa1Z0?=
 =?utf-8?B?UEdVb3pVM2lYNFZOQkQyeGRMMzUvVHpuNXpxWDJHbWJjNFp2cHhOY1M5SGRk?=
 =?utf-8?B?RHdMYU1SdXdMazd3dE1PdHM0NGdyNXJrQ3pZWEZwR2V0aThSNWNRSG0vTnc3?=
 =?utf-8?B?T3pJeXZ5QVhNTmJaVFMxMGkrR0ZibWJCejdlODdtTTdjMUJqM0U4cmJ5NXdJ?=
 =?utf-8?B?VytRUmVrbjVvSVE5emZXYWZYbzg0NmVodit3dHhlcFdoa0tXTDRmZDJHZkpn?=
 =?utf-8?Q?Yf4q+SyCPgdvyqebl+lv5xU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzlQTkdsMXdtekRJR21YalZRUG9hb3psNTB0VytGc0pKbXB0UGI5WGlEazlt?=
 =?utf-8?B?alpFeE1HRU9mT2t4Z1FxaGlqQ25HNkQ2REJESXJHUXZHazcxQ2lib216MjZ3?=
 =?utf-8?B?RUp2cDY4Y2xjM3RQRU0xRkF1ckFzWjZqeWhLUzZGNU9IbGs4SWpGTmcyR2xM?=
 =?utf-8?B?V1NoTHZaVkVRek1IdzkxQllyMThHM1BuaEpTNkc4Qm40THZBZWVGRzc3c003?=
 =?utf-8?B?Z0ZpcXNIenpDV0w1ZnNmeEZIYkNvc005cGhDSi9qNEtVd0s2Tk0rMlZaS0p6?=
 =?utf-8?B?cXZha1hkaUJqcXE4ay9GMUY1Qk5nMVZaTW10SnluaGkwd3J2YVhHN2xMRjl1?=
 =?utf-8?B?N1QvWkRVQ213UUVPQkFCNTBKR3ltSmQ3ZTRSVk1hcHV6QjdON29nVCtsMnZn?=
 =?utf-8?B?M3JJaE10L0U3M2VkWVA3R29GTVVTQ0hZa3plR2YzdFpGT2pqNVdPNWZjQzJz?=
 =?utf-8?B?UkdPc1QvNC9OVDJxSVoxYVgzd29DT04zRk5MNldOcDFNaXJ4Zk5MMWVHZmtv?=
 =?utf-8?B?WWM4NWNrZldzK0dobjFRQitzQk12Ti95eFlWbG9CNE8zTTFsLzVlRHRHNUJJ?=
 =?utf-8?B?MXhNU2ZndFJZSFRpL2JTR1RpTy90SUNBSjRXMGVvaDZDZ2VsUWx3VlpDUFVl?=
 =?utf-8?B?dGF3a3JhQ1gyQnphY3BJczdwamdnZ0hPcEFrK2xlUCsrN28xcVRrZGROVEVv?=
 =?utf-8?B?a0NaUWxWOUlmdFlLV3NBOVlidEdHdStxR2xiOHA5dkhwSllTR1JnQ1Vkc2Zj?=
 =?utf-8?B?WU54dnlCQWNjbGpCUmZndGZvU2trN0RRdktOSEVrWGpSWmtqUVJNSEVtVU9p?=
 =?utf-8?B?UisxUG03V3pReHljVEFJclFEczhZMzkxcm5RenBWVmlBbzVESyt2VklYTmpL?=
 =?utf-8?B?ZG55eXo1dUxqMDRVZVQrcEUyK3pJb3MrVmNDUHd5bzZKWDEzdXNWNnJPc1dD?=
 =?utf-8?B?YXZRanFLQzQxOVYxdTZ4YjBXMzEvNWllN2ZmTFRFNGhMOWd5RXFrOVhBSXpU?=
 =?utf-8?B?NkdoUnh2SFY2V24weHc5ckhrc2dkTkFicTZBb2NES2RvclJUMXhvT2k1cnNH?=
 =?utf-8?B?VWxiT01SczJVVDcrRkZobHc4VGx3eWxtckVSSXM0MmRRcnljWll3K24wTTNG?=
 =?utf-8?B?ZXJLWGFLS0I3M0xGbW1wOUFqZC80YWRvb3RLSUdxNVFkaHVJeDdyNEQ0U2lW?=
 =?utf-8?B?ZC9leHZJRnU1SHc3MFFORmh0THZKYmNCaDVIbnhEWXdWRkpPV0FGNEIycS9v?=
 =?utf-8?B?UkM3M21RUjBVdzQrOXhzWDBEdXpQTVlxMFppNDFWSytlc0FFYlVYTzJqa1FI?=
 =?utf-8?B?Mk9IRnVHNmZoNXE3K1prUUVjU1kyT05nWm1FUXNFZEFFbDV0YnhYWFN3WFQ5?=
 =?utf-8?B?a2tEc2N2ZTNnTzRhNWdOUFRZbjhGczdYL3BjTGs3RXd2aVJGUjBObWdwcDZT?=
 =?utf-8?B?MzdXcWxZckcrVWVkd1N3M2NNMit1V1lKa3RLWWhhZ05qam8ySk1WT3k0NEFo?=
 =?utf-8?B?K1NhaTJ0Z1c2WTA3WWFVenNyZFd5WkNoRklteEFJSzZNdTY3eUR0bm5JZit0?=
 =?utf-8?B?OWFOaGQxR3RqRXdzbElOd29qRFBnYkxaV0dmalVDcndXdHZ5RVNEK3VYY3hh?=
 =?utf-8?B?YklvWk00aTRReEFlTlRxeS9FT2tlbjVSUXBxR3JBTVo1dzZqL2JlQnJyL0hx?=
 =?utf-8?B?RmcyWkJzU3kycEtTM3ZzWjJmVVQ0cUYweXB3dmZxdnRsZzBYa1AvKzlXVXpL?=
 =?utf-8?B?OFZKNUFsT1ZoSXhnK2t1UmVacDVEeHZuMElsRURwVzFMNE5STmF3VW9nRUZk?=
 =?utf-8?B?UGJOSndjZENqSHh2UWtpSS9tb2pHSWpOUjMwdytocGxQMUZoQkVOazVaUUZm?=
 =?utf-8?B?V0FYTm42WEpLLzF0UVVzUmMvOGZNS3RITTdjUXBsS0RWb3Y3ZUM4MUlDcUlQ?=
 =?utf-8?B?OWRCMTRySE5zMWE5UFBSaGNuUU42QVpRMVl3V2phU00rRVhJRW42eVRaZCt1?=
 =?utf-8?B?ai9hSlVnTk8yY28wQzNrRGNRMXc0aGZoVXkyZFFhTmFVS2VJSS9ybUtuVVdF?=
 =?utf-8?B?cG9SeGIrQlRjNjJIZ0hmM3Bjc0pVYWtZUFR5OHZrcnFFNG10MHdadlNNK0RF?=
 =?utf-8?B?SFBqUFRBUVcxTVV6RVNBNnBpNUpocTFLYXhIYk4wVStNeGF2eGJOaEhpT2JO?=
 =?utf-8?B?R25JTGZ5UG1nUmhOLyt4Tk1iRlVMNFJXSjVXZnYvbE9tRUtSZDFPZ0VXd0Y1?=
 =?utf-8?B?bllnKzVyZTB4ME16OG8vUGROK3QwNk9FdENLemZLSDBBR0twYzZGUUlHb0xl?=
 =?utf-8?B?ZXhiNmRQMDdDc21GZGlLSDk5R3JGSXI2YTNQTC9oNEZJWmdUYllqRnE5YnhE?=
 =?utf-8?Q?jru9kgr72HVHtB/E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED87B2A1B101884D93A788B5A6DD842C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QfUj1TCqX0WWd/gK3SwosjphIoo4P5RezL1vfVx2qrfh/7q4Bl3oXGcGAMPycR62TLhRb6ZfwITsHIqwdj0oH647OUvY9qKDvqui8W1u2PaCEImM0b6E4hwmy19x0pVmBsISA7cBxFOySKt6WmxIqutGAmL9ZKDblUpqFntult1gHM2HIsoTuJCcFPVkxrIVjpiVpi4J8y27WobNgURPskL+XYenaxhC5SlTWHX2yMl7Q6XvIWsA6ST2Lp8fQ4RZU4KQ55UdZARlisR0m3+RcI2ox+FU1vOcBOVp4ubp0/Bms+fXeReqaXxPVjFUbZ9+z5kWfeGjYoQ3rQoHnJq2QVJqny33hFjWUgX/3Em+T8bFPUXwX5VTUHlyfg2+pCI8w8HFvIrF1P1+J+DKsDueEHu7tlgXaHOqpR7nAewS9ibW+m58fVStcveHeVthBAxiYTwc2LVK98xclbJFPtznWLZgonIAfi9mC8ilHUwDXm5p1eg/Ay9HpxYuf+Md9b4ZL/Zto6T61Zq36yimMKx18B0K8Mbrt43k8qToSE42+WuiXZg/tM2zMiOOFtMFgkI2Sky0ZJP0Xx1+suZnu/AVPaUDcKcMwGeQMK3iFgLMAv4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed341595-1366-4415-5880-08de6aca9e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 06:39:21.0030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9c2fPOFILARO5i2EEQyeVAeglkmtuHjVzi4HgqV1nYbL8WofTVDCQDl0JmngwPRpGBHE2QpahazSdAKt7/QySkaYsfErH+d99qFyL0OTJ0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=727 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602130049
X-Proofpoint-GUID: OcU3-lC-H0IciQpz6BU2S_33bGaiJttO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA0OSBTYWx0ZWRfX+h/C9+1nUQ+H
 fYJVMFIQT8aHQRfIaqhNhj+nj+gxquaH5TM1DFXwKaFFmiKr/fDIWpl/wemszzE5A9FbmJcf7QT
 ++dX8F3TA+dptbTO1/MJEo6+ShO1qUdGxxmCHhsAnObV1oKoAKA7d+9a70+8SL5MxyTSVGZudYU
 s7yaxIwNbwrn62YjhiEUfamHrqsqHuA6hT7m+Gaavb9oyWmqHHiWtF+u3xqlifuFMDyNkYFUDhW
 Tdob1ViZ6FLQOyVAh9JR6jCW3Bj8sncUMIcRx9vNTfk9ltBOkp60jH2dbTb/kzic30fC2wLlzej
 9NYLN0IxcIR8/E7RUxpuE8+USAvWa74rz+qe3ttNaIlp3Vxbufp5ZWN/FanB8sVMplWZR7krX6E
 5gVo64zevlDqh5fnIGRVO/ccVBIQs7j/OlmvsZwjXqzsjNL9e/sOrepT2EBHNwrjm8h7o87vcaN
 XUrrok5H269W+RiU5DA==
X-Proofpoint-ORIG-GUID: OcU3-lC-H0IciQpz6BU2S_33bGaiJttO
X-Authority-Analysis: v=2.4 cv=Y6f1cxeN c=1 sm=1 tr=0 ts=698ec71e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=fnoXvU27NHKG9McTGYAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-16803-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[allison.henderson@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5A06E133477
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTEyIGF0IDE5OjA1IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAxMCBGZWIgMjAyNiAxMDowOTo1MiAtMDcwMCBBbGxpc29uIEhlbmRlcnNvbiB3
cm90ZToNCj4gPiBDb21taXQgM2RiNmUwZDE3MmM5ICgicmRzOiB1c2UgUkNVIHRvIHN5bmNocm9u
aXplIHdvcmstZW5xdWV1ZSB3aXRoDQo+ID4gY29ubmVjdGlvbiB0ZWFyZG93biIpIG1vZGlmaWVz
IHJkc19zZW5kbXNnIHRvIGF2b2lkIGVucXVldWVpbmcgd29yaw0KPiA+IHdoaWxlIGEgdGVhciBk
b3duIGlzIGluIHByb2dyZXNzLiBIb3dldmVyLCBpdCBhbHNvIGNoYW5nZWQgdGhlIHJldHVybg0K
PiA+IHZhbHVlIG9mIHJkc19zZW5kbXNnIHRvIHRoYXQgb2YgcmRzX3NlbmRfeG1pdCBpbnN0ZWFk
IG9mIHRoZQ0KPiA+IHBheWxvYWRfbGVuLiBUaGlzIG1lYW5zIHRoZSB1c2VyIG1heSBpbmNvcnJl
Y3RseSByZWNlaXZlIGVycm5vIHZhbHVlcw0KPiA+IHdoZW4gaXQgc2hvdWxkIGhhdmUgc2ltcGx5
IHJlY2VpdmVkIGEgcGF5bG9hZCBvZiAwIHdoaWxlIHRoZSBwZWVyDQo+ID4gYXR0ZW1wdHMgYSBy
ZWNvbm5lY3Rpb25zLiAgU28gdGhpcyBwYXRjaCBjb3JyZWN0cyB0aGUgdGVhcmRvd24gaGFuZGxp
bmcNCj4gPiBjb2RlIHRvIG9ubHkgdXNlIHRoZSBvdXQgZXJyb3IgcGF0aCBpbiB0aGF0IGNhc2Us
IHRodXMgcmVzdG9yaW5nIHRoZQ0KPiA+IG9yaWdpbmFsIHBheWxvYWRfbGVuIHJldHVybiB2YWx1
ZS4NCj4gDQo+IG5ldC1uZXh0IG5vdyBiZWNhbWUgbmV0IHNvIHRoaXMgbm8gbG9uZ2VyIGFwcGxp
ZXMuDQo+IFBsZWFzZSByZWJhc2U/DQoNClN1cmUsIEkndmUgc2VudCBhIHJlYmFzZWQgdjMuDQoN
ClRoYW5rIHlvdQ0KQWxsaXNvbg0KDQo=

