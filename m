Return-Path: <linux-rdma+bounces-17210-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Gt2L1ARoGnbfQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17210-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 10:24:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 308671A350E
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 10:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F173305E359
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED902396D3D;
	Thu, 26 Feb 2026 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dHuL6M/0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EiVCIGUH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4182BCF6C;
	Thu, 26 Feb 2026 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097564; cv=fail; b=Cj1fRk8zs3IGcuxtYPKy34ggktTbWNITwq4qT+00xF6iiqTfG7SQC3VCLW1xs8VJJmaTLhUE7235W6mkgi6wNQeDjAJ6XZW1fxjOrnzs3vRQnkcIcZS4RcJ1D38oOSX0+kZrkdThmJj9B000URRnhX6ctvjrwRV//XhBrIZ2dbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097564; c=relaxed/simple;
	bh=G+n1ISJtZXULdpYTyHBNPjDP7IAvtT7DMjPJ2RSeCI4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rBOYvvZQsXGJtfzgWfmTgnHzHL/5kp7ppIAEJiVsjc5GH8SO3rV1OOoDMjWUih5L6/3U50KjLaH1YmgQtNwqlvNg/dglneJTGulEQmmM2nOjt3PJNaJgACjw3IA99z+YK6gfFkJUUM6BOR+/N3EQWbbB9x/z4TIXDRhug3zuWDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dHuL6M/0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EiVCIGUH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q6GkeP1271917;
	Thu, 26 Feb 2026 09:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=L3NNsxz+lnLeHWfMA/IPzsKtf0cMaDl7EX+SgqpK1e8=; b=
	dHuL6M/0LnnyDUHGpgfMUkyPe2lisSfAWFUFMMx8tjOqmCkQnFNvw2a+rpdlDr/F
	oIODFgOcwFZLbdt9DuIWh6swkhW7JVU34BqumhwDSVxAkvVAow6HtzzQIOK4a0ae
	jxjMcb6cfrP98lhrvU2Ng69QolM8rwrMRNCNmYxz+zUyKkUbAAmNmPphjupt+M8f
	Xm7aEhdtrUikWZQRv5vaXKeZO6AIMbbcXBcNL9VepvXfrmv1MVKNopyhUivODX+u
	xc/1XXCBORITOvxsz6q0Zc2TaEk76yFhSH4aOJcHTSg50IXdpU0TF9jYNIkixvwe
	J8MQvQhz5KnmEhSRa+m1Ag==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgs006tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 09:18:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q8AtFk006272;
	Thu, 26 Feb 2026 09:18:42 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35cgfj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 09:18:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snFfGEVNJkhXe6zScyzBH/8jRA1jc4+XFdICHkojr/MgKgjgm7Cy4YAKJ9qepbFgkYQMMdn7ZEJ9x1AoCjhgf1+1StH3W1tynx7Bb1LbcVZR616q6pUY75KHLmW2U++s2vvZXqyXbm/X5QE1lePrQ64+V50KyZs1cYinpXHgmgDQco19lDn9DZse6aRJ6UZJMi8Ib/t/iw3/rGxRU44hwPrgOycIO3Q6FsgsvwxscAsqFAycXhZbpLzwQ6aw8aXch8SR2pNx4vtZDFeqF06o8FOUjaG6RIIm79fgk0scqcxxeF8g+4AOu+0wjtHh7aLhI1To7vGfGSFdFqkc7OFO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3NNsxz+lnLeHWfMA/IPzsKtf0cMaDl7EX+SgqpK1e8=;
 b=JfmkhD3zPLBBnTG3nc1ZPM6u/UhejsvIbUwFkEJKMeIT1t2FpfYo0DI6rge/ke2XClCFYO9I3Cy6EVTOqX2Rlv0I7V458z8vUABGkwAowPg0kpZ3UkYD6Xq889d3qG2Jc/gfxbBV9nteGm5ob1QuJ0peF3KdXstUgHnHS5cG1E0KzgZDCFJ0W1JSv3u9U1tVWWUIxfJo6H8lkKrepSOSPHSlg/UkgHoLwNI4LyrhysUVf7ItlrSGEssURLWTX1x5iWsVUa/foiWHMf0E5WOQ858IlYBPAVt+MTHQSupK4vM97sSZylfFKcwuYlEG8gwUyXwGbhqlT5g0xJ9PvsMh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3NNsxz+lnLeHWfMA/IPzsKtf0cMaDl7EX+SgqpK1e8=;
 b=EiVCIGUHKQNGDTofE25BU6/BStwWz7J1lQrqwSqH6+KqP46uRe0dZtm7EHhanN8+juTFmEHIS0puQWY2XE7SW9WHs0kVRXqNL7K//uX+cSZHefYNKpOZBI4HSDXXtQIMSSicVAJuMbx+zPovPSGjMI74JIyRpSp67rl/mJ8BHSE=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH3PR10MB7496.namprd10.prod.outlook.com
 (2603:10b6:610:164::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 09:18:39 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%4]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 09:18:38 +0000
Message-ID: <15ee757e-6140-4151-a1dd-cccb781c89a1@oracle.com>
Date: Thu, 26 Feb 2026 09:18:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v7.0-rc1 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <aZ_-cH8euZLySxdD@shinmob>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aZ_-cH8euZLySxdD@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0353.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::16) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH3PR10MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9f8fa3-3aa5-41c2-39e4-08de751806b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	K/bF9VI3jlJxXWpXGZpo5lszAh6F2ezt+A9rb8cstzvYgPBQOH29Uq99VHnf91+Qo319wV1KwhdaO9FJ7eaIyTNIGtDIztbsQpoa3gK/Yj1JYeQTDn8vT8LwIiGnkBeoEorWIDKCzm7qg7ADbNCU2WSIfFeLKVvOxuGN+LEYwa3dlsnwnyrjNxSZigZ/dDrEEMuUbv6X1TjLPeLP1KP87tmnprFRWe04hZ55ZbcSlVWLIt3ATfQ3gRf2buvzTJuOdWU0swLFG4lXioDHrhmlHrj0INUbUDh87nml9GbhX0rlsi/b6vcY9qZlZOMm38711ngAkPVUFN93MqTQxhIq0A23051ByKb3blEWLS9x4w41yi1WyRGrvk2LIIs1RBbD4zwXS19V6e4lVg1LxQ2JWzhbmX0G2SVIqq5tM2GDoulf2YM0R1pIKl+FH31CY+nn1WPzb7AAAljd5RAq0tjAziVkpBZa2n4/iIYxT0XIujaMNy/eofsJTXQimUiK9qTbSPunIILFU/mrENRDcoeaMCeAwuoNiK9ldVMdjVHGXvS0J+oamtTTiYgCZSpR2Pp81jKitsMwu2KC/hZc6ixVEjEWedafsn7F/OA0/IkttwteK+lrv4PAf/CnPR1IrBPvxmLc+6xjMga/P13WUh/sfxvFF56rjZa698cfq0DhTR9fYLFpdfojr+yqyXtgkFMtzQrKmzOcTYESgF5HQJVQr3NVJsX0qVLe7iUKyIWxlks=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tzc5R1FmdSsvdG9zVjFNY0xrKzlRQzBBcmNyejUzVGRhVndzTnZGdWRYZm1H?=
 =?utf-8?B?cUhMSUFrMkcvK1FQK0VpN0R6NTJWRjNhZFJxNXVqczlrRDRQSERLSTZ3ak1C?=
 =?utf-8?B?V0ltUXUvV1dtSzJuMjd0d2p2dWRraW81cUdwZzhYZTE1c0F0MVY2ZXBBODZq?=
 =?utf-8?B?WXM4TDJ0ZkVleGxISkVPV3h0bXJja2tYWmxJWmViUWdRRisvQVZVTmI4NUF2?=
 =?utf-8?B?RjhwdXVhU1hkVTMxWm5iNTd0b2xKN1I1cm1weHV2blJac1krVkZsMTVmU1JV?=
 =?utf-8?B?MkFlei9rYlZycThyVkpnazBsSUlid1lNU0gyL3BLTitZYmVncGRFR1FIZFVh?=
 =?utf-8?B?emczUVpnblJDWGpHVjVIckZ6SkdwczRNVGM2bUY0S2VJTVBnMUt5bTdFNGhJ?=
 =?utf-8?B?akptSlJITGRHNHBJa3ZJMlBzOUt4b1VJWUpXY3oyQ2w1WHROaEFxeU1EaGo2?=
 =?utf-8?B?d2RvOG1RS0NDRTY5Vk0xMDJ1b3FSU2ViSEp0azNVaWZlcUF3NUxXYmFFUWxU?=
 =?utf-8?B?WEZNRm1wNUFzSVdXS2U4ZXcydWFzdU5Hcmk2R0JmYWorNEFwaWZWTmEvbncz?=
 =?utf-8?B?aDZDUnF3aUVDZjY1UGt5VitzT0c0RkJJeVVLV0llTEkva3lLcGxCemZVd3I2?=
 =?utf-8?B?SUNxMEJvZXpBWG5SRUtKbFQ5ejRSK2hpUTVZV0VyY3dlVUo2RUVzOXRJN1Vp?=
 =?utf-8?B?L28yemVWMk5LQnoyU1VRVXVOTzJyRVVqb0lXakV3NURUOEU4OEtKYTBrRXlC?=
 =?utf-8?B?UWdKUUxRbkUxQUFseThEek1RNGloeGVuTHZrVG5ISmxPNGZnTk9Wd1hoak51?=
 =?utf-8?B?eStvM2xSQWdZaHhlcWFOSVc0NTNaWHpDbGtYMEEyc0JhaWZxbDJ2VDRJZ2s3?=
 =?utf-8?B?UUFVeEZMM3Q2NE04dllsSU1Cc1VScEVKNm1hZ3E2M3Z1VjZlN0xpZjBxZmJj?=
 =?utf-8?B?RDFRc3RjSWNTQUdFK3htS3c4T1kzeWRJUWcrQ2N3cjhZTHB0d0MyTWlmaWJO?=
 =?utf-8?B?SDFMaGtXdTdiU1VRNXBjSHl6WU1sUlR1OHAxNTViZHFrUmc2eFV4TmpLeWtT?=
 =?utf-8?B?K3ZyYmp6VUw1c2NFclYyeWowcWtWUUNhM1NZakhGZHVEZlhlNE4yWUIrODAy?=
 =?utf-8?B?RGhDR0s5OWhLUktwbE01ZWFNdEJ2UUY0a3lLa3l3QVdaTjBrTFFHWHcyU21C?=
 =?utf-8?B?ckRzMHlQY1JXZzd1LzhseVc5dUphaEMzNU9DcHFRUlZDWWZGVVpYUE9TdDhZ?=
 =?utf-8?B?K2UxdXBvcGJiVS90eE9BSytTcEliVEFqeThXSFQwcE9QS0lhSE54VW1QWENK?=
 =?utf-8?B?bGVsd3lpZHpzTjlibWljYjZwc0twSDM0OXlPR0JqUmM1YU1pVENhSTFHSlAr?=
 =?utf-8?B?VXJkVTRtSFRvQ2xXbDYwTDIxeXhDdW0zaXhJb0RDdkgwYkRDaVFQN2xiRjZD?=
 =?utf-8?B?TWR5TnZuaVhnaDRPTU9GMzFRZW5PYnd3ZWR6bmJ4QXFCaHBRS0tHS0R1djRZ?=
 =?utf-8?B?cnhTUkdxemhEdDBpMkhaZzJuT3M0K3FNcGtPV3VoOEkvMEVQd1hSQTJZdnFw?=
 =?utf-8?B?cnRyWVVNNkxWYjVmb3VoV3RuZzFLZDhmK2duL1k0eXM5VEhXcjhCS1AzR01D?=
 =?utf-8?B?MDlraDdiSkFEeE9Ga2hWaXRvcWYyVGptbHNnTEJHY3hiY2xpRlhuaktxK3B3?=
 =?utf-8?B?eW9pNnlVTHV4M2dsZ0xzeDNvVitLUmRFQ1kzZ3phUE9oZTZiY3ZpY2p5dWNK?=
 =?utf-8?B?U1RwTWcyL28yRTJxaXNQNDRrYWNEYkFrRitxTnVqRDltazB5Zm1qOTJPUmhE?=
 =?utf-8?B?eTFPUVY3eEs0Q2t5MmhtOE5TdzFRUmd1QS8vVXVJMzh6cFB0YWFpSUQzRE5P?=
 =?utf-8?B?MzZmKzFWMXAwczdtS0p4eE5ZY2VSeEZXajBZd1VQQSt6aVQraHlkMmJROXk4?=
 =?utf-8?B?MEtZc0FzY3crUmlrV2xoQ2s4eHRaL3p0azRHeEJUaFI0Z05lKzJnNjFoR3Jn?=
 =?utf-8?B?UGxLNTRnN1NkalordTI0dzJWNCszTmVRV08yWGluYS9xd1pOcUtzQzJaVCsx?=
 =?utf-8?B?elRSREV0aG5ocExjWFNZYjRyaE5OeE9xRjRpcXVGcjEyQnBDNndUc3RqTTJZ?=
 =?utf-8?B?WjE1WXRzaW9NdGNOS0pqRkdMTERubGtJTVJBY09NZUZNbHhkWUd5Tlk0REVa?=
 =?utf-8?B?ZVlWOEpMRlRpM3o1L2dqNWh6MzJ5WHpTT1d0cW5jSlh3VTFpY0VyOHVtOGpD?=
 =?utf-8?B?ZHFzbzNRbm9yZUloamVYOW9wZUFkSi8xQWRHb2NhRHVMZlRwcFkyT00zdWdK?=
 =?utf-8?B?dithekFGQnRGOHRDUmd2blAyRUR2bzlUYnkvajVYdnRyL2tWWnJGeVZCbW9k?=
 =?utf-8?Q?5xbHHYL5dOG0RbzI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oyc6D86hvi5lO3uOSsBM+HxEU9SzXgYR1CIGixJsE166ZuY2b06HIUiDUh2BLsDC6Bw7y9crI5gfxsYEztwNpFRx0v6FnLKUTFnAjBC8Wn4Ncgfnqo+waUFax4R8ayWF23gnyZvv45MtJFAkCcLfLRVQ4dA6bqTnIwRsYd/mMjG6j2OPPGo4pEdEm6qiR5mKz+OjVvEyVNxTFf8nZKb59p0qiLPgVBYnhZquci+Trbv/0mXWH/W8WX8QAn2ENA8y3Tm3r0wlagpx0c3Go0aU9p8oBGlaM7m2noD8CzTRNZgYg182ZC6pAowxuv3fVZMRrYFCApQM36kDeMc9J5u+tLLi/A034x6ztpwsOUDyOZtL3Mn6WUbmwPdLJutiRbWl7447DZilZM9HpPQSO6iGD+2uo2Y6/Xjhb3ydX3c3JGVLWaYP8irdGxtd30sso2VEwXa9TqcjJY6apmzd8gEn8OL1LffTz+7apJpyV9UcnsthTEV3t4Gs7BOl6dCgyZ+NLKiwKU7IC88li3Ii/tZOGbi0qoi7T1y4coL9th6U21OMksFm4iSXNQEGOqmjGlcUEd9bAMubYYgSY08eh75sPhWBQT++Z1v9/vTrib/CGT0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9f8fa3-3aa5-41c2-39e4-08de751806b9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:18:38.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XQa6ZWxPtEKWMdMfazQp5UIHsghfiAeeJZSHLZH5xsUhEWB0afK3yZH6zIUk6euLLqfuXt8BRyPn+x/OXjzaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260083
X-Authority-Analysis: v=2.4 cv=BKK+bVQG c=1 sm=1 tr=0 ts=69a00ff3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=gBn6iPgPYT3qVw0s6m8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA4MyBTYWx0ZWRfXywGSjdQ7GHDD
 ha5DC4fE7ZRkYZEFh3Z8bPB1uPi68zrSYUVZsGsz7r+2fojYOm4BpsMcbAdmfVuiWk01d6a+JkP
 OIKa67qNi3J5x8bzo9SGH1VcMLpOziOxqx5bgl//zzJ68081d1SGleYhka3oRGLV3dbUvLNtFzA
 rPEPhCKNJIedXc3y+wy8/p4indo8+3adEs/Fsa8+aZ9Dd5wTI/7MijlHGTNPtnpys83/D2TpZ+y
 5N1PBJxT0oJ3fg+eTwlGE8RU5jju7hnG5CzMIxCX6F4kiuTFj07E0iXN5NJBJXnfElUlHw+7QDO
 jg/yeI5aWOWVy0x+rg+aFB/zrMYzoMReEt5BXwDAEAg5WTNUbQMIDYAPm0Ed1tQ5lZgk3gss0uB
 6BIAgrbduQ1Pa9KmpBz+hjRvuxCaKPJJQnh609DDz68bIpGi3/XL4JqXxPKhJTRGGnCIppX+52X
 /Z7Y3f/DkNIrDgbjIDQ==
X-Proofpoint-ORIG-GUID: xG_QCLb0EcY7px98sUO-EGoU7G0AhmBX
X-Proofpoint-GUID: xG_QCLb0EcY7px98sUO-EGoU7G0AhmBX
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17210-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.g.garry@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 308671A350E
X-Rspamd-Action: no action

On 26/02/2026 08:09, Shinichiro Kawasaki wrote:
> Hi all,
> 
> I ran the latest blktests (git hash: f14914d04256) with the v7.0-rc1 kernel. I
> observed 8 failures listed below. Comparing with the previous report with the
> v6.19 kernel [1], 1 failure was resolved (zbd/013) and 3 failures are newly
> observed (blktrace/002, nvme/060 and nvme/061 fc transport). Your actions to
> fix the failures will be welcomed as always. Especially, nvme/058 and nvme/061
> are causing test run hangs for fc transport. Fixing of the hangs will be highly
> appreciated.

JFYI, I saw this splat for nvme/033 on nvme-7.0 branch *:

[   15.525025] systemd-journald[347]:
/var/log/journal/89df182291654cc0b051327dd5a58135/user-1000.journal:
Journal file uses a different sequence number ID, rotating.
[   21.339287] run blktests nvme/033 at 2026-02-26 08:45:20
[   21.522168] nvmet: Created nvm controller 1 for subsystem
blktests-subsystem-1 for NQN
nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[   21.527332] 
==================================================================
[   21.527408] BUG: KASAN: slab-out-of-bounds in
nvmet_passthru_execute_cmd_work+0xf94/0x1a80 [nvmet]
[   21.527494] Read of size 256 at addr ffff888100be2bc0 by task
kworker/u17:2/50

[   21.527580] CPU: 0 UID: 0 PID: 50 Comm: kworker/u17:2 Not tainted
6.19.0-rc3-00080-g6c7172c14e92 #37 PREEMPT(voluntary)
[   21.527589] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   21.527594] Workqueue: nvmet-wq nvmet_passthru_execute_cmd_work [nvmet]
[   21.527636] Call Trace:
[   21.527639]  <TASK>
[   21.527643]  dump_stack_lvl+0x91/0xf0
[   21.527695]  print_report+0xd1/0x660
[   21.527710]  ? __virt_addr_valid+0x23a/0x440
[   21.527721]  ? kasan_complete_mode_report_info+0x26/0x200
[   21.527733]  kasan_report+0xf3/0x130
[   21.527739]  ? nvmet_passthru_execute_cmd_work+0xf94/0x1a80 [nvmet]
[   21.527776]  ? nvmet_passthru_execute_cmd_work+0xf94/0x1a80 [nvmet]
[   21.527816]  kasan_check_range+0x11c/0x200
[   21.527824]  __asan_memcpy+0x23/0x80
[   21.527834]  nvmet_passthru_execute_cmd_work+0xf94/0x1a80 [nvmet]
[   21.527875]  ? __pfx_nvmet_passthru_execute_cmd_work+0x10/0x10 [nvmet]
[   21.527910]  ? _raw_spin_unlock_irq+0x27/0x70
[   21.527920]  ? _raw_spin_unlock_irq+0x27/0x70
[   21.527930]  process_one_work+0x84b/0x19a0
[   21.527946]  ? __pfx_process_one_work+0x10/0x10
[   21.527951]  ? do_raw_spin_lock+0x136/0x290
[   21.527964]  ? assign_work+0x16f/0x280
[   21.527970]  ? lock_is_held_type+0xa3/0x130
[   21.527982]  worker_thread+0x6f0/0x11f0
[   21.527998]  ? __pfx_worker_thread+0x10/0x10
[   21.528004]  kthread+0x3dd/0x8a0
[   21.528010]  ? _raw_spin_unlock_irq+0x27/0x70
[   21.528026]  ? __pfx_kthread+0x10/0x10
[   21.528031]  ? trace_hardirqs_on+0x22/0x130
[   21.528043]  ? _raw_spin_unlock_irq+0x27/0x70
[   21.528052]  ? __pfx_kthread+0x10/0x10
[   21.528059]  ret_from_fork+0x65e/0x810
[   21.528069]  ? __pfx_ret_from_fork+0x10/0x10
[   21.528077]  ? __switch_to+0x385/0xdf0
[   21.528087]  ? __pfx_kthread+0x10/0x10
[   21.528094]  ret_from_fork_asm+0x1a/0x30
[   21.528113]  </TASK>

[   21.546173] Allocated by task 1328:
[   21.546459]  kasan_save_stack+0x39/0x70
[   21.546467]  kasan_save_track+0x14/0x40
[   21.546469]  kasan_save_alloc_info+0x37/0x60
[   21.546472]  __kasan_kmalloc+0xc3/0xd0
[   21.546474]  __kmalloc_node_track_caller_noprof+0x2b6/0x950
[   21.546478]  kstrndup+0x5c/0x120
[   21.546482]  nvmet_subsys_alloc+0x361/0x750 [nvmet]
[   21.546501]  nvmet_subsys_make+0x9c/0x420 [nvmet]
[   21.546513]  configfs_mkdir+0x484/0xe60
[   21.546518]  vfs_mkdir+0x631/0x990
[   21.546522]  do_mkdirat+0x3e6/0x550
[   21.546524]  __x64_sys_mkdir+0xd7/0x130
[   21.546527]  x64_sys_call+0x1fb1/0x26b0
[   21.546532]  do_syscall_64+0x91/0x520
[   21.546536]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[   21.546800] The buggy address belongs to the object at ffff888100be2bc0
                 which belongs to the cache kmalloc-rnd-02-32 of size 32
[   21.547326] The buggy address is located 0 bytes inside of
                 allocated 21-byte region [ffff888100be2bc0, 
ffff888100be2bd5)

[   21.548115] The buggy address belongs to the physical page:
[   21.548374] page: refcount:0 mapcount:0 mapping:0000000000000000
index:0xffff888100be2780 pfn:0x100be2
[   21.548377] anon flags: 
0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   21.548380] page_type: f5(slab)
[   21.548385] raw: 0017ffffc0000000 ffff8881000488c0 0000000000000000
0000000000000001
[   21.548387] raw: ffff888100be2780 000000008040003e 00000000f5000000
0000000000000000
[   21.548389] page dumped because: kasan: bad access detected

[   21.548645] Memory state around the buggy address:
[   21.548895]  ffff888100be2a80: fa fb fb fb fc fc fc fc fa fb fb fb
fc fc fc fc
[   21.549150]  ffff888100be2b00: fa fb fb fb fc fc fc fc fa fb fb fb
fc fc fc fc
[   21.549393] >ffff888100be2b80: fa fb fb fb fc fc fc fc 00 00 05 fc
fc fc fc fc
[   21.549635]                                                  ^
[   21.549867]  ffff888100be2c00: fa fb fb fb fc fc fc fc fa fb fb fb
fc fc fc fc
[   21.550103]  ffff888100be2c80: fa fb fb fb fc fc fc fc fa fb fb fb
fc fc fc fc
[   21.550339] 
==================================================================
[   21.550647] Disabling lock debugging due to kernel taint
[   21.552579] nvme nvme1: creating 4 I/O queues.
[   21.554074] nvme nvme1: new ctrl: "blktests-subsystem-1"
[   21.556678] nvme nvme1: Duplicate unshared namespace 1
[   24.849982] nvme nvme1: Removing ctrl: NQN 
"nqn.2019-08.org.qemu:0eadbee1"
[   49.368933] SGI XFS with ACLs, security attributes, realtime,
quota, no debug enabled
[   49.377335] XFS (nvme0n1): Mounting V5 Filesystem
48f88624-c9cd-487e-87a2-de1c0c1cb9b6
[   49.392190] XFS (nvme0n1): Ending clean mount

* this branch did not seem to make v7.0, and I did not test v7.0


