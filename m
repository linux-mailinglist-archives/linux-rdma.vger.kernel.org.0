Return-Path: <linux-rdma+bounces-15065-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DEFCCB841
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 12:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BBE8307F8DD
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5906322523;
	Thu, 18 Dec 2025 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bmE85/fx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Lxf/hpJY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8B1F9F70;
	Thu, 18 Dec 2025 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766055580; cv=fail; b=By/pTQe6z5NMgNIlbKv9If3iPMOiuwbO8KMO1f+I5W+9mkHTHb7Bm4u6wd+SWZodHyvHyKuNqrVLLUFkIeS7zjIf62zJ4JyVFhILOiSmfX0KFZTyayym1Rn2nqRx0Cwro7i+r3+Cre2IyIqxVF8zmEK5R7FAPejU4gBcSi3HVOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766055580; c=relaxed/simple;
	bh=JJi/P79eEKukUH3lSrAi86s6HvctKNkeVCTOIPA/IhY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y4f7Ykk/F7b8YsDrov/k9r50u49HXBFVaEsXE0FAwwhX62sCGeu4MghmiB2Tsjhzx0S51FTyC7E4oQrcyJcM+nnKzSalKJeaBspsr0lvjRvE/LxFG/FCtD7w+ljJYKFcXB2gUCmr9wojrLlIpRos+Flinsg73Fkfvo1Ty68JUsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bmE85/fx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Lxf/hpJY; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1766055579; x=1797591579;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=JJi/P79eEKukUH3lSrAi86s6HvctKNkeVCTOIPA/IhY=;
  b=bmE85/fxwJdog69WtAWIOp3p7cxoeO4FCHoHm0S34ttBTdw73LqkHqTz
   fNiQAFctPzFUcl1YxiPYqEJtpD3Fkaw3mV0+e8U35QO9A1TQTftRHUi+f
   XLbZvNqF2Obkjiby1xxUUT98OYlM27Pum88gSl0agxnfHFKNcPNXSm93k
   blkDts8Uj/A5eLKTR6IL0/a1YLFSOwwzCwkpAN4yCMMDpyXwFLL1EjSvx
   fr17eOQQlWpgWgy1v7eFh5ZIH0SyxxSCQmgvlraPokeTwH2N7Q6jriX71
   Nh92JDz2cE4xyfiwCNRHKiNmB0P0pQluBZ9qVc0kUQ64vkE+KSv3ncZv+
   Q==;
X-CSE-ConnectionGUID: TWq4IM5lQnm08BIvcpX3TQ==
X-CSE-MsgGUID: my+XgFtuRBqwRs7NfLHyBA==
X-IronPort-AV: E=Sophos;i="6.21,158,1763395200"; 
   d="scan'208";a="138126727"
Received: from mail-westusazon11010024.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.24])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Dec 2025 18:59:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENJWRvhmwp5KCce14LgvOlwey+oJVWuj2XG8oZLv9sikjBXPonHbkgS4SigygNnNDhBz0QqO5XRWKoAjIiJk7losByX2nk4c2T/iCWKgbuotMrPv30+K54o3WOOv4p7WEXDNl+1eki5DDbdT77iAr/S9o2TiyNxGanknFz0gXMReoMUGyXyJT8b/mNcgUxWdrU7duF3LD1hZEazd6XRDp1ur2CmiNpbb6tU+HwnjY0qokU4KBhXq2koaiyPD5ULoUcI3GHrdXpIGmV3Bg1mVlRCobsHkP3NL2Ht4zN2Tn2wM7/4CK6TR7tWgNqWMPzQFAaXA12NzFBdpMr4hv7yO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJi/P79eEKukUH3lSrAi86s6HvctKNkeVCTOIPA/IhY=;
 b=WV6BccteWEhangoR92pMm2/4iy24pjHq9zvGktJKz0AmWtaAZZiG0HyINEENIlR3yXxV2oryj3kREG0vu5Wew9Xh0nqxqukqK7HwNo6dZ8RUls1jpLmceLRnBVjJkCZLCkJnrKdmigJ75CR8SGkcOoNlitLFfXvIzWyhYAGk0oDWJj4U3vo+boFq5JYdBwTvhxsPWAZgZY9q8z8VyGtKKJhm4wBa9cDgb0HAJc7ZyAstH/8x7RGBz0+Ddgv3PF8W1aiy4Sy4s9898564xpkX6/t+tjbgVPa8F+Q/Bu7MPr5sG20o1SR3rVM/ut1bOfD2JHJpTi8i0vAw2mlauRuz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJi/P79eEKukUH3lSrAi86s6HvctKNkeVCTOIPA/IhY=;
 b=Lxf/hpJYrIgdWLAVSEZIT1o7weDa6YKPin/DidMED68PI+Ugyp3g6lqM+E4Z9DQ8p9wmJtPokCc0JE8pwpB7yOL9Z6QXroDHPirFnoFHp2jugQrpKIqUOf8khV11oKc2xdwhaBIIox9Lr7x+Z1mT7kizwYuVW5OzTmGy+3oh3UQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH7PR04MB8974.namprd04.prod.outlook.com (2603:10b6:510:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 10:59:30 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 10:59:30 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.18 kernel
Thread-Topic: blktests failures with v6.18 kernel
Thread-Index: AQHccA1irokedhVZcEmLqK3rVMow6Q==
Date: Thu, 18 Dec 2025 10:59:29 +0000
Message-ID: <5b023828-b03d-4351-b6f0-e13d0df8c446@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH7PR04MB8974:EE_
x-ms-office365-filtering-correlation-id: 060bf4b6-b2b8-4372-2973-08de3e2484d1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UlQvV3JYOHFFc0psOTdLTlFJZEJVYTcvdm01Z09heUFQZ3BiNld2WHVxMW5U?=
 =?utf-8?B?MnZtTm5rTGhvTzNxbmNxVG1uc1BGRzMreDZNOUl1M05TME5ONTB3dmp6WW9w?=
 =?utf-8?B?ZDVsVGtuelB4OXBEUHJvZ0xSakZ0T29HZWtpOThId01rVWJnSkpYMGhmbnBj?=
 =?utf-8?B?WDB5NUFwNmJ4b3dieDlzTWUxZTQ3UFN3QkVWZVBKclVSUzNvQmkrUmFQMnhO?=
 =?utf-8?B?UFUwZjAyKzZlM0l1LzhSb1NwL3piRTQzUkhwK3VNeHpHMFlxakwyVStvZTZB?=
 =?utf-8?B?dndnNVF3U1ZFVkNmVVIwajRUdkJMMGVTcksxWCtFaTZ2OG1RbUh3cE40Vk9Z?=
 =?utf-8?B?STNpQy9sLytWeitScE1wWVgwVzVGTDZvMGJnY2krcFl5WUxLZFRHQWt0UWdG?=
 =?utf-8?B?TDM1cHZEM3dwZ1NPYWNtY1JTbmpRd1R3dTJURHJzUWszbHJXOCtKTkxBdHpl?=
 =?utf-8?B?dFhOTndzT3VkL3lxQ3FKdXZmdXFEbzdwbS90dFZIVkRUQ0dENjE3WHlmZlVH?=
 =?utf-8?B?WUI4YnJ0MjhZeG1hMlF6VEVWdmhEWEluTzRvTUlka040eGdmSkR1dnZJeWp2?=
 =?utf-8?B?aFJycXBGeTAyUm5GRUkyTFpQNFovVVg5ekxQRGFtcFIveVc0Wlc1NTBpbStY?=
 =?utf-8?B?c2ljNGhKZjFPRXJRYUJOR2ZqbFUrcytrQUZuaGpVTVowdWdGQm5XTkd3T2o4?=
 =?utf-8?B?TzV5R2g2VklxMkxzZXNZWGpBZXBUOStGNW1SSU15MHU4VGplUjd3TGlRV2NR?=
 =?utf-8?B?d2RNUXpRekppR2tmSVM3RGdvWlhlZ3FjSFd6cjdTeFlJY3M4Ykd6SmZxSzIr?=
 =?utf-8?B?Kzg4OFJ4OUliZlRLVUkrK1BVOXFHRGE2VU9FVmwvSk5CVEY3VisyVUFCRk9N?=
 =?utf-8?B?Y2VIeVhLNHJKVHJoNzM0Q3JoajFMQm80UHVoeXRwVlVDcDJJbEJuTStGdjY3?=
 =?utf-8?B?SFdUanJLcHJZMHFid0pVZHF3emNNa0hZck52OUZKNE9tOUtyQ01sc2F4c2JG?=
 =?utf-8?B?MGJIenoyVndDS096NG9PaEVuRTVTbEdVcUc2dzZvcUY3azRnTHpETkVBbEZk?=
 =?utf-8?B?OHM5aEk5NlBjenUwZ2RuaUhpL2R4aGJjczdxdVJTNzdZNmtRT2lmTkVMbjhE?=
 =?utf-8?B?Z3phR3RCc1RpYWhqWjFaakFYWVN0cG9ieTN6Z0l4NkFQSCtFQ2VtVjlKVWFj?=
 =?utf-8?B?YnN0MFpJTThYMVc3ZG5rc3FRdGhvN1Q0TkhJandkZXpUQWFPTDB1Zmh1TG5G?=
 =?utf-8?B?UVVTVkNDaU40STlzcjZQWWt6eHlVSmY2SElWWDBoakQ5cmhUdXVMVlgwY1E0?=
 =?utf-8?B?eXdjYnlpZWRYN09WOFc0ZlMveU0zQzVIYUZMRFdKSzdaaEMwdy9PTUJsdE9l?=
 =?utf-8?B?aXJIbzNNelovM28yQ01SemJ1b1pyc1F0cEdOamd6RmRVRkFIZkZQSXRjaGE3?=
 =?utf-8?B?WFNIaDVsNzhUOElidXh1dVZHMmUzY2h0MVZ6cVVSd1kyYko2UEorYTRvbS9C?=
 =?utf-8?B?c2lUZml2c093bjZnWVJtREI0WG9kZ0cwVDNSeXJGbDJUWERCeUkva2IzMjBG?=
 =?utf-8?B?MzlPS29NalczcVdlbDVjNENpWm1nWHlrYzJHYnRWdEZFOHgwbENjRjdFNVh1?=
 =?utf-8?B?b2M3TXdGMmUvZmh6RzR5aUZrV1dvN1FCc043QWVqdnVxSUlzWnRNOERQaDV0?=
 =?utf-8?B?SWk5SVVDNkM2c3VzcFFDbEIxQXZVc3YzTzAwTlVTMnY1M01mM241SXdmVy9n?=
 =?utf-8?B?M0RaZnFlQlVGaHZadWtTdG9WbzFGVEEyaWRJZkJVbzFYd3VtallrNTdLSm1M?=
 =?utf-8?B?NUNtaS84QkpZUFIvK0dzOWlVZzk3MXhFb0VRa0NtOUxsT3EyeDRudEFEVmNZ?=
 =?utf-8?B?WmNPNHVnU09wSC9TQUpPRHgxUGZPNzJ3QmFnSHE0cDdjU2pudEx2aFB1NHRR?=
 =?utf-8?B?ZE16NTdyaW5keGRjSDhxRGxHckI2NndlKzBpTG5oUTlKQmhZTzU1VHpGVlJm?=
 =?utf-8?B?YllWV1JjTWY3WFJyZndjUUxpM2NpNHk4U003YmVCMllkalc3OFBQNVo0bG1x?=
 =?utf-8?B?SytpV3pLMDlMSENhRlpueVEyL1d5dGNFOFlXQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3kzMW0wUUVaQlZnYjhPZHBqYVhWcWo5T2Y3UW5hZERMNXNDQ3lMRU1LaE0w?=
 =?utf-8?B?UktlYldwb0FnM3A0VHRNUmJCV2lYc1BBazJEZnlkYVNORnFFd1RVK3dNTGVZ?=
 =?utf-8?B?THFGdzBRNU1oWXFhZk5aaTU5S0srTGNjVVdTbEIvenZDZEFGY2c5azNDS0lS?=
 =?utf-8?B?M1JGazVmVXRCeUtFdFVaUWdZMjRYaFFzbmRGTUZBNjgvT05MNjFPT0dWTVdH?=
 =?utf-8?B?azg3b004OU5YOXV6RjlueVRJOUdYOXBCZG9BREJhS2JyanFiYjBHSVlMQk5a?=
 =?utf-8?B?Si9CRjl4R0VRMGZieGhQNGlZditHV2NBOVpYMFI0Z3NSTENmUHlvVi9abWNR?=
 =?utf-8?B?eEZ5aEowbUtPdGZVZ25xcUlLTzljd3JxSXJQVk4yd29FNXd3VWNEZmtXYVRh?=
 =?utf-8?B?SVBQeHRXdnZ5T0ppWjFWYTg5TXduRldGa0Y0OGRYNWlsM3lCMEkvUlBhQzVt?=
 =?utf-8?B?N1F5SnNOT0V2UkNVT25YMENhVUZGTFJQOTFHMUp3aDhmUnRUbFJUVlV0Smh1?=
 =?utf-8?B?bEtHWjFHSElBQm1lMnphMVFPZUxxVmpOc1RVQTJHRWtnYnJtM0RNQXg1UHhk?=
 =?utf-8?B?dVN3ek5yYnRCTVNrRk5wSmV2YXB1RDF2ZEFJTS8vcnlsK1BFeWk0R2RzMEg3?=
 =?utf-8?B?MXpRRG5nOW9UdjBPSjJLUHIrRGhwL3dJcEt1akNRRFFSZGVuOHdQNmlZQTgz?=
 =?utf-8?B?Szd3U2tRdklhajRRYTRud0JqblBTdk0xT2Q5RGVibmJScG9XL0RSUU0yYkFp?=
 =?utf-8?B?SjVLZWFYKzZBTmFvQUpxNU9Ecy9telRIQlVOdjlRR0RFMWxnVkE2UFZJN21J?=
 =?utf-8?B?dmR2TVBYTzQ2MU5pcklHVnJxcTFpM1Z5YzgyelJrSE1TT2FQY1ozSDlFejZ4?=
 =?utf-8?B?SXpFbVJDRG5YVkpZSUZ4QlVjV1E3YUFIZnEvZWd1TVZ1cjhZZWxIaU9QSytX?=
 =?utf-8?B?MklmM2hva1hkYUJ1Y0lWQzEvSy9RMEVLOFp2TDBORWVpSHZiUjhHeFVTVUls?=
 =?utf-8?B?QVdTOS9FK0hzYlF0SnRsSjBNdGFraWpya0k5SjRYUE9qS1NTRFp5Vmw3TWtD?=
 =?utf-8?B?UlJvcmdhMnlFRWdFQ2xscTNET0VqMnFFQiswQjA3ZWNCM2I3SUlGL09vZkoz?=
 =?utf-8?B?dTVSMlM3eFZIUHozelZ6dTJkZVpVd1greTNFUWN6WTZHQ0NzZEQ2R2JhdzIw?=
 =?utf-8?B?RmpKdmF0R0pDMFlzL3h5MTF6Q1Q5cE5NWkdEMnZEUFRhbXRvTTdUS0RWOUUz?=
 =?utf-8?B?MWhLR1N3UkdSc3BUaDNlRU5WaE9LWTlrSjlaZXNEdTdDOTZYQkRjdC9FOUdG?=
 =?utf-8?B?U0dCeDBHU1gyYkVpUi9NV2FxVDBtQUZ6QWFZMWJtdWE0TkpQZEFzRWZGeWl5?=
 =?utf-8?B?WWZucGJNTG91ZUhPSm92VUoyVDh5dVJtQ1puK3NvNnBIRzNxYnRlVWcxTnFZ?=
 =?utf-8?B?bHhrSkdWREd4Yk1Pbi84V293T3JoSFBpV1U4dDRxRmdzcFRiRUtzTHduQTlw?=
 =?utf-8?B?a0w5SHpDR0dmTFBUWGtuL1l1TUhxanVTMmZHZHZtUnJsNFNEcHdBOUh5QlZ5?=
 =?utf-8?B?bExLbzJ4YUZSR3JkcTgvWWprM3F1WWZUa1c3QTdoZnVFbHBxdEhWamZJdzNE?=
 =?utf-8?B?ZDJVN08vWGgwVXFPSjgyWERMQ1hqNkd6RzN5dUszNWpZZ1RNRHNnM0JKRTlQ?=
 =?utf-8?B?R0wrRnAyWFpGOXk1Rlk1NHlxVVczT1ArUW90MWV5MFZoWEljTFlzRWFMWldi?=
 =?utf-8?B?RUtDYmVDWlpLNHhTcmZaK2REWFA2MmdXSGk0T3hseWhxUnIvYWdkOWFJRVhR?=
 =?utf-8?B?bHcvL3krMUVTQVd5Uk5vTXByUWVDYnVYNE9zVlBGOEpLK3NUemlSM2o2SmtH?=
 =?utf-8?B?R0lBaXpOYlN3T243WVpzM1RrbUljcmY4bWRQdkE5VmpXRHlEc1hYT2N4MFVa?=
 =?utf-8?B?SVhEZjNqR0ZGVTZvb1QzNDd5Y1N2dHNPaGZjdGhtOWErakpXcWVTWGUwdHZS?=
 =?utf-8?B?Z2paL3R3MnJCbXE1ZEdlZXovTUtPeGpZRXorR0JOS3BXdEtkUGhZdmx3Z2Rp?=
 =?utf-8?B?aWZWajQ4YWp2YnJxUjliSjJlZ0dzc3J5QjNOZitpWXV0SElzbVpvSXdtVlpw?=
 =?utf-8?B?cEtvVVNUdFlzaFc4RnBYQ0d1cDhkVlQxbHdlNEFGa1dPYVlobVd0emV0OTht?=
 =?utf-8?Q?DpYpzfPe8/SooIKFXt9wAGg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99F985D9D912A544B197E81DCFC083ED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DP8gw4C3qF3b15tnvclQI7Hg7bfN//9eq7XF3t+/as9P37tjJSf/4xjKrCXf6zaIgwUDGTsUxQFDEfWnGbtGWEVOHWNgSpl/9q2bt4oTn5EEIyd0ATI0Upv2B/PfADnFDilFgFJBFCaYaSX1VmpJ69QJl1S3EP9fsyT0SU5puA7UrQwTJitlyRYKlPDR650jQY+ooGSRWVI0AyTnkkqnmdzScAtcS8kPCuLjutDPVYEV/pPZWreb05JVyvgJWZLPC8/Ufw0tzObAGbmmeJMow/A3TKWok+YuPlaeMkL7BeIYzHIVU/S1+yuL2yS2j5Ls89WH/1yRmJstsYWzL8s1WhcwScAaks2TBlrMeh+AIw+Yb22RDB5EknFsPrImKA/hQPtcXR2nDUjrK9BUqPJo7mREYBk09hKAFTb+37MU+OJNr02yS2A/Ix3IEjV4g31du3Kw5gLcN0Xs1BhmmupGtQVzDyTrrO/kvOsLvgrSPHwnAlXwxrjM3Mcm+S+Uh3ydQpwR2LucT7S1Wp3NPuZV0ogX1Yw08BV0Va7Kn0swA6kFG19ANGNv2Jrewmde65ChP2A0tL1V7HD12TIbtybeuUvcryZEtSl6jp1zMeOnYKSSv53n+kxQIKsLhmOCtKl2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060bf4b6-b2b8-4372-2973-08de3e2484d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 10:59:30.0884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvH4n6ymtBFBQS7NoaKh3fJqRxK3JhaLCxCW8RPvSEk80I1YEDOWVosJ9rx1Dc0NMV2xrbn2673wT+owwvXWlaRzoaap4alJk+mSAMX4HVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8974

SGkgYWxsLA0KDQpJdCdzIGEgYml0IGxhdGUsIGJ1dCBJIHJhbiB0aGUgbGF0ZXN0IGJsa3Rlc3Rz
IChnaXQgaGFzaDogOThkYzZhZDY0Yzc5KSB3aXRoIHRoZQ0KdjYuMTgga2VybmVsLiBJIG9ic2Vy
dmVkIDMgZmFpbHVyZXMgbGlzdGVkIGJlbG93LiBDb21wYXJpbmcgd2l0aCB0aGUgcHJldmlvdXMN
CnJlcG9ydCB3aXRoIHRoZSB2Ni4xOC1yYzEga2VybmVsIFsxXSwgMSBmYWlsdXJlIHdhcyBmaXhl
ZCAobnZtZS8wMTQsMDU3LDA1OCkgYW5kDQpubyBuZXcgb3RoZXIgZmFpbHVyZSB3YXMgb2JzZXJ2
ZWQuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay95bm1pNzJ4NXd0
NW9vbGpqYWZlYmhjYXJpdDNwdnU2YXhrc2xxZW5pa2IycDV0eGU1N0BsZHl0cWEydDRpMngvDQoN
Cg0KTGlzdCBvZiBmYWlsdXJlcw0KPT09PT09PT09PT09PT09PQ0KIzE6IG52bWUvMDA1LDA2MyAo
dGNwIHRyYW5zcG9ydCkNCiMyOiBudm1lLzA0MSAoZmMgdHJhbnNwb3J0KQ0KIzM6IG5iZC8wMDIN
Cg0KDQpGYWlsdXJlIGRlc2NyaXB0aW9uDQo9PT09PT09PT09PT09PT09PT09DQoNCiMxOiBudm1l
LzAwNSwwNjMgKHRjcCB0cmFuc3BvcnQpDQoNCiAgICAgVGhlIHRlc3QgY2FzZSBudm1lLzAwNSBh
bmQgMDYzIGZhaWwgZm9yIHRjcCB0cmFuc3BvcnQgZHVlIHRvIHRoZSBsb2NrZGVwDQogICAgIFdB
Uk4gcmVsYXRlZCB0byB0aGUgdGhyZWUgbG9ja3MgcS0+cV91c2FnZV9jb3VudGVyLCBxLT5lbGV2
YXRvcl9sb2NrIGFuZA0KICAgICBzZXQtPnNyY3UuIFJlZmVyIHRvIHRoZSBudm1lLzA2MyBmYWls
dXJlIHJlcG9ydCBmb3IgdjYuMTYtcmMxIGtlcm5lbCBbMl0uDQoNCiAgICAgWzJdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrLzRmZG0zN3NvM280eHJpY2RnZm9zZ21vaG42M2Fh
N3dqM3VhNGU1dnBpaG9hbXdnM3VpQGZxNDJmNXE1dDVpYy8NCg0KIzI6IG52bWUvMDQxIChmYyB0
cmFuc3BvcnQpDQoNCiAgICAgVGhlIHRlc3QgY2FzZSBudm1lLzA0MSBmYWlscyBmb3IgZmMgdHJh
bnNwb3J0LiBSZWZlciB0byB0aGUgcmVwb3J0IGZvciB0aGUNCiAgICAgdjYuMTIga2VybmVsIFsz
XS4gRGFuaWVsIHBvc3RlZCB0aGUgZml4IHBhdGNoIHNlcmllcyBbNF0uDQoNCiAgICAgWzNdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvNmNyeWRrb2Rzeng1dnE0aWVveDNqanB3
a3h0dTdtaGJvaHlweTI0YXdsbzV3N2Y0azZAdG8zZGNuZzI0cmQ0Lw0KICAgICBbNF0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbnZtZS8yMDI1MDgyOS1udm1lLWZjLXN5bmMtdjMtMC1k
NjljODdlNjNhZWVAa2VybmVsLm9yZy8NCg0KIzM6IG5iZC8wMDINCg0KICAgICBUaGUgdGVzdCBj
YXNlIG5iZC8wMDIgZmFpbHMgZHVlIHRvIHRoZSBsb2NrZGVwIFdBUk4gcmVsYXRlZCB0bw0KICAg
ICBtbS0+bW1hcF9sb2NrLCBza19sb2NrLUFGX0lORVQ2IGFuZCBmc19yZWNsYWltLiBSZWZlciB0
byB0aGUgbmJkLzAwMiBmYWlsdXJlDQogICAgIHJlcG9ydCBmb3IgdjYuMTgtcmMxIGtlcm5lbCBb
MV0uDQo=

