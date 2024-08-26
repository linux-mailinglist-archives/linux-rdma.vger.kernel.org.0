Return-Path: <linux-rdma+bounces-4571-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 456A295F684
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 18:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8611C21E99
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2024 16:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81863194A6C;
	Mon, 26 Aug 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="T95uKQrq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022123.outbound.protection.outlook.com [52.101.43.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444C194A75;
	Mon, 26 Aug 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724689631; cv=fail; b=kP8DvaEYNwqYir5ApfSoICJ4B28bjpATXGMNGvnPJq3VhOEK4YmlH2fo4O38JUnMk1A9TeZ+UZRM9FU4MLSXqiGtJ4t1rtGTVfj1fnL93rmMxGASFprJ0X1gE0BuWbV3FS+LfQXK9NC3t1JnsoLn8v+QnPWmBT2KhaO1rGlm+1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724689631; c=relaxed/simple;
	bh=arqhVqVW0dECyndUVxzwk+2wgqatupt62fyVGBp853Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yx6uOuLXJBefqtqC6HUsRu5aCBF1egi1Nkiw+Wx9UQtzURkeVt+eMU8825/MnkQxKB8zYpy62j/8dTSnQeMxWG5WDgnNjvM4JJ9qpWLVSIFW9zY9RRdCKVQWVcPGpKC4dHBtntj56mD/31Xu0/Gi5UgL0xftQZ06h4BgEOFhrMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=T95uKQrq; arc=fail smtp.client-ip=52.101.43.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaOJDzTEnQTXR6pbdjYkxhi8YrZa9edlexgpAqc1BWpJFTdyt0i04rFzUWDqCDzNWmojQSKTQkyLvyDLNA2YclqqVSElsG++//Zq/Zhq0T4RVQ/S7SYji7pfVuGponeA6LaeyFVqrsxVzEDl7iYS2yfGFwnYQEpIf05gUfCHkoY1AxUrryT07xDZUPdKsQqUSRqX3dz55cYuMWlmGACBSR/O2GY97gQXF28fhaGdo5Sgai/1NRVcEZKilk1HXl6cgIJ90JvzrbJ69IKlPdN9rcZLVXp+seKBJa1qCNcJ95YwmMgWsaCTHyg79/CJO2gsvSDAs1xNKs6U/0KuJ7vJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9WW82ajwMeIndqahovkZ7+KyBnJ1bpiRudImBPpPyo=;
 b=azK46I9dTvts4tL4tAitdPRwedTPllsr14Nsi09WF6tnCQLHz5E5w8zYFmIrr0ix4MzU4zc5S/z2WCqDbmuGgwQghI9dR57iV8IZOM4zPyXi6EbubR19Hvn6cT/2YJ2QcKltf/cALQ6kCTz/kLjpXIqGzce8N84ePVY7f2fCL1msY5agT4AaC7rGHcHssz1LLo7QvuEl2ee3lyBB04y2k9wTFqH16b9941uC2J0sr2uVP8Sjme+n65/G2I98YQcFgO6VH1Bm8K22fIqOowH7XAjCatmdo3AOjR7MoTHWPxfubaCnIrgXTvCZan9T2vyF/fpWyWviwBveULYTgvuNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9WW82ajwMeIndqahovkZ7+KyBnJ1bpiRudImBPpPyo=;
 b=T95uKQrqPaFdJciwFoXU6R6R+k9AxW/mpxvPVWMSdiqdW2bblxIMeCCkF9Zcuqzz/jc1clBOXiKeDsW1tT2PexEkrp7oPNfl0mORS7gi+Jm/gtl1aT/C/vwsxtX+GbNVCBkLXpnPwpVE6g5NHjz26AxeeV+lDeS2UD/8Lxhh2hLUsQI4fbKjPJ6VudD4efRI5Kbfh1GyZsIdzzcbnl8j9xgy3Nmgl/J0ZexkjFvJZmKVM3OOsz86txJLdDjL29ikfOUawlPQybJDGKcnx/tlxGX+GZpsax/jZjV/oOAYTUUTVuf8c2QFhc4p6JbnHX8XSRU8hHnFkjg5dUy0Royv8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 BL3PR01MB7042.prod.exchangelabs.com (2603:10b6:208:35d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Mon, 26 Aug 2024 16:27:06 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 16:27:05 +0000
Message-ID: <842aef7f-d6e1-490a-97b9-163287ddfe2d@cornelisnetworks.com>
Date: Mon, 26 Aug 2024 12:27:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Using RPMSG to communicate between host and guest drivers
To: Doug Miller <doug.miller@cornelisnetworks.com>,
 linux-remoteproc@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 OFED mailing list <linux-rdma@vger.kernel.org>
References: <133c1301-dd19-4cce-82dc-3e8ee145c594@cornelisnetworks.com>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <133c1301-dd19-4cce-82dc-3e8ee145c594@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:32b::10) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|BL3PR01MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: c9328666-384d-4be6-a10b-08dcc5ebec88
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1ZrVDhKaDJua2NhKzdNNml2YnBZVzltR2ZvN3JyaUVsOXlzZERGQmpFdWl0?=
 =?utf-8?B?N3NGY0liZGhUWjBPSXZpY1VTcU84YzkzbnpabVdTbmJETURRelpGOWhDRWFE?=
 =?utf-8?B?RTVBRllpN3NEVGJ5Vk9JOHBwSitsMkZvY1Qyc2hyS2psUEVQZzlNajVpSEVw?=
 =?utf-8?B?RHNKelFaY3ZjU3Voc1J0b0oxWE5xeXhuczlOWVZqZVFnWlM4Q3dtbkg1eUNp?=
 =?utf-8?B?M3Q2V1BVSDhDK3NBK252NGpXKzlGNHhaY1Nmc2FLSUNOZ3FIQ1hJVnNIZUpZ?=
 =?utf-8?B?R3JXZkxLVVI0ZFBMRVVlR3dlL3R6Mmh6U2ZPTGNuN3phdVJTNHh2dERtZjJy?=
 =?utf-8?B?VjVnSlNjOXR1eDh3amtxM0ZKZGYveVZ1ZytFR2ptd09zbWUrZFZpSnh3amhT?=
 =?utf-8?B?RTI1N3Z4Zm1hM25GSWtIS0NmQ05tbnVFelR1RlIvS3RzbjJUeUJqNTd6M0ZI?=
 =?utf-8?B?SDJLT2RIbEFJYko5R0NCYTFxbENONXh1T3dnRE96TDJKZlhaaTVPQ3hnU2dC?=
 =?utf-8?B?QWtLK1ZaY2ZiYTVZU1hQaVdUcWRBcVl1YzQxaEg5TitZM1Y5Z3piK2R5ZFBH?=
 =?utf-8?B?Z1pSYUxqNkFTM0ZDOXIxMUdhMSswTzFEWCs2Y281TU9PZlNrOWxtMlpiVGZj?=
 =?utf-8?B?TWl2SlVjb3VHRVNTbUZLVE5qWm5oRFIxRlJkcnEyYTB3VjlNS1U4djhETFFX?=
 =?utf-8?B?K3Fic1MrMWNrRmlVZWYyQU9halcrYVFHYjVPS2RabjZiaUlvS3BzclRvZEQv?=
 =?utf-8?B?OGVCdTZQeGp5alg3ZTQwYTJRQlRqTlRtZWcvQXU4YlFFRUJBdWJUMllTdFJL?=
 =?utf-8?B?dHN2aGFIV1BSL0hqdXhZVmR4ak5aVS9JbG5RTTl5Ny9aSDQ1M2JIOWJyN245?=
 =?utf-8?B?eHBtUzZnRitQY3FaTzltN1NSSlNoYTZQcUczSldhV1ptbkZIb3ljVnIzcXV1?=
 =?utf-8?B?WlVzRmRXLzhpc2pEQTZvZGt4dWFXaW4zNWxvWlJRZXVkQ2pOazNwNWowUVUx?=
 =?utf-8?B?WE9ubGl5YlErcUt2OVBpZzN2cGRRV29lR3JDQ3FPaTJVVEEzRHVKMWJYZ1FZ?=
 =?utf-8?B?eWZPOG1MNDFZNmw1UmthZy9EUXo3UytpS2VJUkt0SFo2cDJwaUlsN0JKZmZx?=
 =?utf-8?B?ejlML3JBZXNQSWJZZEg1ZHN4TWg5Z2FwTlRoU3VMb0R4TzRGb2V5SDV5T0R0?=
 =?utf-8?B?M1JYaXNyR3dud0VLUHUrTWpyZThFWkN6Z29kWFAybHZKdHNpUURubEpqY1hV?=
 =?utf-8?B?emh6VFIvbGh5QU1jYlhQei9idmpaVEY5MU5GMUxDcGNmVFcyQ1B5N2Uxb2tt?=
 =?utf-8?B?cmFIWXkwS3lXNjJidm5sQk9STnA2QUxhOExMV250YUlTdUZTb0JybFNLSHhs?=
 =?utf-8?B?NU9WUnJOTHBPZ21EUTFVbmxFck9USzBwNUpZVmxhS3ZXaXYzYXA1bHo4L0c4?=
 =?utf-8?B?UDRuTGZGc3JkN0cwemhGUUJjQVZzNVhsdHZtdm1WdGIrRXQ2a3JoeDRKZlor?=
 =?utf-8?B?OG9ZdHFIWmMrZkZoOUtBc1E1dDdvSjlXbXpxb0RrUm9kdDh5QkhZM215R3FN?=
 =?utf-8?B?TWZJOHNYL2dtVDJWcEo4QjJFTnZvczVQa0NYK2s0dFowbHNINHBBTW5DRG5Z?=
 =?utf-8?B?Yks5WCtGbDIxR3RkZWEvWGtnUnJLYVpoNzhKM3JITm40VzRmVUo2amxXWFZy?=
 =?utf-8?B?YUU1OXgyd3NYTDI5M3c0VzEwSlptOUdWMWNzRXlpTnVSTUs5SjE0OUtJb1hJ?=
 =?utf-8?B?MjBGbktXRmlGbyticGFnbkRoa1cyeEVvYUxtakpjdjJic0hFN1M3NnY5WThl?=
 =?utf-8?B?U094VnByN3BxR1BzQWNjQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3JQL0FGbis0Vk9NZ2VCMGxwWEpMbW02K0l5bjJVZXk2ZExqWW5rMVdEbzgv?=
 =?utf-8?B?YTlkNWFrQVp5YzhLSkRVR2tRY0REemYvUDl5T3JHU2VBMi9vZVd6VmFiai9X?=
 =?utf-8?B?WjlHeDFpbjh2MEFZZVV4cWdBKzU3bFdZVVFKRWxKQkJUVTRLTS9Vc0g5ZmR2?=
 =?utf-8?B?c2YxRk44N2ZKSGQrK3JZUWVVR0luMEhIcXFLNXJRNExyaHpBSXZZZXkva3VV?=
 =?utf-8?B?c2dlWEY5RUZlb1pyOXFrOGtxQVZYb3hkNmwwSTY1dzZJZGdZQnZHRHlFNDRu?=
 =?utf-8?B?dFBNbWNWckF3QWhTcm5GVDVMK0NIeklUVDdtZzRROUJTcW11VEtDUEJaS21B?=
 =?utf-8?B?Ykd2V0tQU0taUGdLN1NKcTByTnFXbFdTRzVBdFhYbzA2Q2dRM3phb3JjN2Nx?=
 =?utf-8?B?NDM3bnI1Mit6V28zSWc1dWMzc3JlajFqQzFpWGVSYUgxZW9GeVhickdGanpE?=
 =?utf-8?B?V3hYMHpGaStWbW1OcGVFL0VHaUkyNE84eUV0cVdqM1k0akRnN1BnQVNoazVV?=
 =?utf-8?B?SGFXRTByaTZ6Q204bG9QQlp6K1JkU1MyZGcxcWJ1TWlQUzJIUG5GRlZjMjRE?=
 =?utf-8?B?ZUYwUmh0SWxJVVFIQzFha1h2cmp4MEhPSHR4bmF5K0JiL3pXQTJqQWxXSXAx?=
 =?utf-8?B?bmV0MTZXZTl0S1VaWTd4QnpndmF5RFR6MkVZajVpVG9TamJ5NXd6OWhqNTBQ?=
 =?utf-8?B?dWRhUkJCZTFwZm5ZbVRHVk5ka0ZZUlNlV1lXK1JMQmErdVAwdmlyOVloUkg4?=
 =?utf-8?B?aks1RVR5WjUwYkhCc0RkVjA2VUZHVEIzSzhkcGdrZ3pzbkNqZFo0bzVXNE5r?=
 =?utf-8?B?UTNTdG9ZN0d6eU8rZnVVU2QzeCtMSlVSdDR0UkZnaUJiMU1OWVIyUXozYU1x?=
 =?utf-8?B?azNuRHlDNitqcmRmenI2ZHpNQUJOQWlJRitMdmhoMVYvaHhuRHNtSWJNcnU0?=
 =?utf-8?B?Mjl5VEtjZENsdDVLUGJEL05MbUR2WUVCb1c4aERFbUVGRkpPUUN6T3ZjaS9N?=
 =?utf-8?B?VXA2SGRBVmxhSFNsNmxXcFBZaCtCT2I2NXFWNGxWa2Z5Z0ZqMUE0ek0rVzMr?=
 =?utf-8?B?UUFPdzhXK1B1RUxlNE5CTmhlN2pUYjJMNGd6dVUrdkdpeEFVaHlQQkVaVFN5?=
 =?utf-8?B?OHJnL2RuVVlNbEdQWmZtY3JTcEp4NTl5ejZEK0dWZXE0MUVuVjFDazRpM1NF?=
 =?utf-8?B?Q1h0OHd4bVZnY21LajNBYklXWXRDbjdkRlhQalI3SjZUUlpCeGRWRGVTYzFB?=
 =?utf-8?B?eThMenFQUFhkVTZ0aWNxWDlSRTNxRHpDeEE2S3N4cDhQWWlGbU03Wmd3MWNQ?=
 =?utf-8?B?N1hHUzI3TWxxd0d1SUc3WTUwelRiZ3poWVRzbjcyQllONEUydHc0VzcrazJM?=
 =?utf-8?B?UGhiR0EwTW5abVE5SVdvMDNoU0Q3emdsSXIxWGFMQ3NiTWpGMWc5WjJ6V0s1?=
 =?utf-8?B?N3JtWGJhakJDdGY2cVdJbTFUK1NNZDRCV2ZnUS9OdWZFY214YVZ4QlNpekZp?=
 =?utf-8?B?WlF0Mi9CZ1F0ditML2lmTVN5QVg0NU1rVjNYV2diN1MxU1UrR3paQXVQWkxB?=
 =?utf-8?B?M0VoR3FHanBCeHA0cXl4bklDSThWNC82R1I1eGh5OHdZZm1mRytEZXVCdzJK?=
 =?utf-8?B?OS9pSWx0S0MvN004ZDZ3d2RFWmNlK1RNWTBoVWMvLzBnL2grMi9qWSs2SHBT?=
 =?utf-8?B?TUxVcE9YbVloTzNERkZjN0RVWXRneTRzYlhlZWlocUZHUE1GYUR3SmFEb3p6?=
 =?utf-8?B?UnhmTzRDdk55Zjh3V1N1MlNOU2JzRUUyTGNsNVpQZE5XZUxEa1BnelprR3Rn?=
 =?utf-8?B?bkU0THBTTUFNYWpkUDV2ZmF6YjVPdDZkUTk2VTRHZXBHaTR6WUpTYjVaeGti?=
 =?utf-8?B?NW42a2pOYURCejEwRHRYNlRyNUJXMVZWZnkxMmRZNElzOElwR3dqZUJOVTM1?=
 =?utf-8?B?Tmdrd3ZMN2lWVDZIM2hzS2F1a2JHK0FhS1pmdWdsMmVGQ0VlUTBwWk5SU0px?=
 =?utf-8?B?dkNPaHloU0tkek5XLzFlZVVDVXFwZnArdC9tMzh5Ylh2UjRybGY1b01YZzM4?=
 =?utf-8?B?SDE1RzFkbjBsaElON2hwM0huQnR3M0hsQmU0dW1FbE5tU0V4YnhubmlZRkEx?=
 =?utf-8?B?em5DYjd5d2ROSmhzb3ljN2FLSHBDSTc3anc4c2lIdFdoakhCVlVTaU5vdkVV?=
 =?utf-8?Q?2+r58Ec8FYJsJKqHqXZqLvo=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9328666-384d-4be6-a10b-08dcc5ebec88
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 16:27:05.8915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1HjN0g+Di51nmMtXSkLHB+wCPuPWt4iGxJBcK4BW5cQ1nA9eiOo12IxAW0WVQohut4M2kM2QPBFSvT4NcB3d6aiCz4upF+2REQM7mWzRdhmY3D7MlDmyPBI7WfMBhB7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7042

On 7/31/24 4:02 PM, Doug Miller wrote:
> I am working on SR-IOV support for a new adapter which has shared 
> resources between the PF and VFs and requires an out-of-band (outside 
> the adapter) communication mechanism to manage those resources. I have 
> been looking at RPMSG as a mechanism to communicate between the driver 
> on a guest (VM) and the driver on the host OS (which "owns" the 
> resources). It appears to me that virtio is intended for communication 
> between guests and host, and RPMSG over virtio is what I want to use.
> 
> Can anyone confirm that RPMSG is capable of doing what we need? If so, 
> I'll need some help figuring out how to use that from kernel device 
> drivers (I've not been able to find any examples of doing the 
> service/device side). If not, is there some other facility that is 
> better suited?

Hi Bjorn and Mathieu, any advice here for Doug? Adding linux-rdma folks as that
is where this will eventually target.

-Denny


