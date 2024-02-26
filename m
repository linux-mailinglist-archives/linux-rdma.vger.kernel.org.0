Return-Path: <linux-rdma+bounces-1136-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1C18680D9
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 20:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24ECB1F24958
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Feb 2024 19:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ABA12F59F;
	Mon, 26 Feb 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cXt6ry4r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LioDkSWg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F512DDAB;
	Mon, 26 Feb 2024 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975337; cv=fail; b=OFrS0o3IZ6D17JSFZdgnr9RqiZ0FMKvuDXACf654E9Cgs50JVLWy98eb9J+hfkc1uBhSCAN+bKJ5jaTyk+dV/OVORbqV7iNQl24BrK7Z0L2HMQioNxNdDaQLbiKRBu+Z4iPMk6vl75UpJr0WdktDJuCppcfKRFvDp6TtJ5gcDKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975337; c=relaxed/simple;
	bh=NWwefbgxBjsHgXsdnv6TyE4xqOpBLPke0JpQJXg1jKU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZSR0t0VKbzwNsq7KxpS5bTfeMa88ckyXcF2FiqPtHZXMiv9BxA1/j3z7+/UyCXIX7UvUhikrydmg9er1YrzihVVI5JE074S8zmJjaBsTAl4j30ISwmYEu/1guzrMgepJ/DR9lnPP1WRS4d55lDI4wsGQpykFy0Ax7SKGpCctKKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cXt6ry4r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LioDkSWg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGmnNv007025;
	Mon, 26 Feb 2024 19:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=NWwefbgxBjsHgXsdnv6TyE4xqOpBLPke0JpQJXg1jKU=;
 b=cXt6ry4ruSGR9PUC4ZqWRKp9abZ8Q4oaMGXJh1ApcjxOHQf2mLzwUgP1QcJqsXKAyKrO
 /gBEtoj1w89u0qMtfR2wRfppn/rxalB4N9Dee8PqU26FN9VF3oHJ655U3PyhW0r9N7c1
 MHyx4qPyq02gnb0YzebMuTb+kgvDs6fR4vqCaNMgqVSSNpZZc/PQeJQQyJkhFzq8yQuo
 XDQKCw7h4QVS6wwNHQ93986j8W4uJCM8ODD/5cOPIvwsKuFIr0plNuKSLUoafnQ9V9RT
 lJil9sZYWAaDS8ZCeX871xhauzxFNGv4HhWib3oOXj5anX+LZZCCl186H4k7jn1ny8RZ yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gddhvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 19:22:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41QIjkwt001669;
	Mon, 26 Feb 2024 19:22:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w62et1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 19:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvDq2sVSj1AlmwU91fjKk9Tt+ZO3H1Pdyl0GL6rI7e/KmYtQ1tNATRxah9Yz9lekmWuGkAY5z6se/BIYInKYgN+9ICMAd6ZlNlnuaQejGSiVKYRF+PGD2K2XXUDQA+oLgm2BJfD4LBSzLqCYH2kN37chF5CuIGePaCUI4iJ8nJ5La6XBCwnpZFROLYhlndX3p/KXWmHfcza1vXNaAVAny9HTjQ/pHyIrCa4zYKpti2g7z4CYM4T1bluRml+2YES1qG7X0R4RgyHH3CCAzV+KKDdD/3jcPi9ukKjQkxaAmBMVG1tLcCs/x5WPZXSk1OMiVjVXwfxGArP5hqHxYBfWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWwefbgxBjsHgXsdnv6TyE4xqOpBLPke0JpQJXg1jKU=;
 b=VKWY7FhAcpTGyX47Fr0c6PHF98zfWWweFvC8DKhZ5pfWGLjCscn5UPzXuNib64TNZ+1gkZ1U9VQyjVX9TxSOmt5AGu6PwtJcvX4qp4z3OiOcbgqjLTtAuNA4r4MEacoTEJXauwR7386lFIMA+xt6U9RuPvTUGtyJiBFFoE/yk+OW0XorxjZhtOyDNI7HXY4VmGHNoH67v8wvgx5TbkAmDtnjX+fHdLOlgCL1jryP1kPf4sXNXs6m3mbpDjBgZyIZ8Plq2Pdww9BTpGUX8RJZ6Kd5cRV+kZVpCt49tyg78HSDFHkLq17JC2qv+WfHGM0vwBzMjRVGTWsAYmX98qCdJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWwefbgxBjsHgXsdnv6TyE4xqOpBLPke0JpQJXg1jKU=;
 b=LioDkSWgOh84JozTeYuXC/XkhLPUo0EQfL027/2RSQ9+TfQ7LIQl7K7WJfts3V4TL7P+seBLVjeqHMDuhuo5D4KveCBb20F0LHZgLa030KEPPBtq6WvFizNCQ3hjTveLwLhVNpwbu1QsyIQX2ElPxB7oDz+kT+hp+kwZS3U/dHY=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SN4PR10MB5655.namprd10.prod.outlook.com (2603:10b6:806:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 19:22:01 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::3ebe:ef87:e29d:e6f6]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::3ebe:ef87:e29d:e6f6%4]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 19:22:01 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "kuniyu@amazon.com" <kuniyu@amazon.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "sowmini.varadhan@oracle.com"
	<sowmini.varadhan@oracle.com>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "kuni1840@gmail.com" <kuni1840@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v1 net 2/2] rds: tcp: Fix use-after-free of net in
 reqsk_timer_handler().
Thread-Topic: [PATCH v1 net 2/2] rds: tcp: Fix use-after-free of net in
 reqsk_timer_handler().
Thread-Index: AQHaZn1j6shPJyIbeUqIG1HJ/6dALLEYOeWAgAAFVQCABMPMgIAAAiMA
Date: Mon, 26 Feb 2024 19:22:01 +0000
Message-ID: <725e8196ad84a91fadcf8858422b20b13f71ca0c.camel@oracle.com>
References: <20240223182832.99661-1-kuniyu@amazon.com>
	 <20240226191421.66834-1-kuniyu@amazon.com>
In-Reply-To: <20240226191421.66834-1-kuniyu@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SN4PR10MB5655:EE_
x-ms-office365-filtering-correlation-id: 4dcb6de7-9b90-474f-2ee3-08dc3700356f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 oPoHvHJXrAZwXFyfAWLXoRaQrCs+5Yr8tBy10rL7SM2Gpc3urg147rGgireO8gRUmvb9T1Qh9EPdppfneBLKjnmE5A18qGqhVsY6w/wldmsb1XwieV21OZtNo2QJnKl4+ov4gKepbdxxgOpVWYt6afQYNuoNrTfaX0K1e7Pl2iP0cYs18ntAer5pnUua2tm3nSQIWNAE6KUqDvdBwP9Cfz6c1mWv1tWSqpQyCpjEM5twoyqSUhHIHuirY/pJlnEs0k8c97G1YOveeEWUP5jvXht0LCxlCAvaC69cFluP3ZWVVgbQEm30hfEY1BsAzPEiAvgkvj2sEWT5uHYu02BqP96pOsTKvEps8eJ925GpCxriTJ4e+WD0SWwn/BhR0ycCPaHuEy0qbVazqJDDWXjRw++VIcSixD1nwcEDbfSeAys/Qa/SsBX5O5ECA+eHS75KY61ezOvbGrrwuPQ+pfhLT78Nj9sIhvrAf076o/PxXlQ/CbznZUDyo3+huPce+EZzfLX3x+ZUIJNf1n974+3MzUOMZMaMdmt5YwZgpQQmkaXfR4og9XLD/zF7NZnMj7982LENVauB+8gnKi54AKGGTe43qrQYyTRCnJfyBRNFAUAT8K7upNYO1hQcLVuznvkIQL/axpNfU14A4ADSC55Q4Y9GOMqe6YSuMMDaMWeDSZDBBQpNPCb1WRHf2kuRNhcU64p0XLMgC/q92Rtlrd6Msg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cGo4Yy9NRFAxdTJpeUtuRjgvVXM0QWw2aTA1K0thVy9WZTJCSTgwTkJKQmQr?=
 =?utf-8?B?aVU1c1NSVVl2c1ViZXdwemE3S3BISEdjMzFYR3ZTUTVkb1oxTU01b0ZOV3Va?=
 =?utf-8?B?bkVESVlYTzloQk0xbVAzQlpOOW5OUWJmK245TGtqQ2k2K0pjT1QzWllERDZC?=
 =?utf-8?B?bktjem1rZGtqRlU0NWlwRVphTDBIcFhER296Q0J1TmIrcUJ5a3QzeXZCWUpl?=
 =?utf-8?B?UWJOWDlBTmRnZ2NBb0kzRlJxWkllRGs0T3hSUkM3UFZScC9abVRCVWt3RGI4?=
 =?utf-8?B?cW9nalgyY2c5bDRSei9yaXp1ZG9rTlFDVkJRMEd0U0RSVk1LWnlPZ3ZOemlk?=
 =?utf-8?B?S0FGMnFrYlVHU0dweGJhT1BEU2toQ0hScWZURy9IcU9Sa0lsME8yWlIyOFEr?=
 =?utf-8?B?d1QvV3VxYTZSQ1Y1YzlNV0poWkVHNFRHT3RUTytFVWt2SG1GRldRK0lDSStr?=
 =?utf-8?B?L3FRT2VqZEhHR1RuaXcrV2FyNHVRL3FWcEprcjI5SExrWm96d2lLRG4rRmdY?=
 =?utf-8?B?dkVxa1RDYzg5TW1hbk5VZGtnWm8zaVFkeGlYbVhhY3hXaGNrVFQ5T3YxN2pr?=
 =?utf-8?B?Y3RhWlhBTUErV0N6RXpLNFdIa25wb3pDYnFJMlEvOTd2N3ZDZXFIY1pqaUNW?=
 =?utf-8?B?bEZMVjkwVFFaOGlpRVYxMDd2aUYyeWdIeG5CTzJNL3VlcEw2TTN3VGNReGdt?=
 =?utf-8?B?WDJLZ3pSYitxejA0aGM0Z1M2NkRzNkZnNlp2WWdSRm9KclVCajB1N3dLZTI3?=
 =?utf-8?B?ZTFPUEN1Vm1ROUhXaHlGKzhUc2Y4MnlPNkFNeUNsSzlJd0QwQWt3VUJxSHVE?=
 =?utf-8?B?S2FxOFB2S3dLbVpFMFhnK2dhb2pNNitzS3BkUHl2TEpCMDJYQTRGTHhNRVV6?=
 =?utf-8?B?QnhjS0NYZGI1OHFCYXE0WUNaaDFIdElZcStxTVVVbWlqL2RLVm8reUtvMHRQ?=
 =?utf-8?B?T2kwd2I2RkZ1OG8yc0RFVjhCOVl5Z3NaRlhWeEdrZlo1S1pJRHdnMThMQU5i?=
 =?utf-8?B?cjNMcWkyK2xPOGRqZU5xdG5OL0Y3UkZIWmY5d1VaZTFoWmRFTHhkMDBMVW9W?=
 =?utf-8?B?R0tPeEx1cTZsNjVCS2QyYzRqY1RqVlVPRXhjYjNtbTZmRFQ4K0lidTVrZkpX?=
 =?utf-8?B?NmlOZVhjSFp3M09KY1p4RTEwQTNkV1lhV1YvYVBkdWo3bEFCSlp6a2R5UFcw?=
 =?utf-8?B?VTkvZmdxWkM5ZWl4a21TVnRhWmpOeGYwQkZ5N0tOYXI4SEpiMXFiZ3Q5dk9G?=
 =?utf-8?B?OG5uKzRwemRLZW1OWWF6ejBuOUlrdEpNZlVQRm1lWWgyUkJFcWtsKzUyWDBj?=
 =?utf-8?B?ejh6MGMvYzBWQ1dTTmpaL2hiaE5mTFplMExHQ2NTL0s1K0RZKzdPTW1pd2Q2?=
 =?utf-8?B?bzZKN1MrVEM5OUFHNllpK2pLSjFFaXVVdGhkTFJDZmRob2xqMzFCNEdydFV4?=
 =?utf-8?B?cHlveDlHYzZiMWc0d1VLSWFSOHkwUWVGVDA3VlZmekV5bEJHWFpiTGx0Z01m?=
 =?utf-8?B?WUdXWVNmOXdDK3lMS0JPdllvV3JFekpvQlA1RjNicW1FVWZ3cnk1c3Z5L1FZ?=
 =?utf-8?B?ZklGSjJlWU13cGU0Zm5keS9BMUY4OVZBSFU0ZTFNc3ZYTm9reVZvSlV4ZExD?=
 =?utf-8?B?OGxJbkpyVDA5SVVPOE5CaVVkZGFvNm1OQ3paaGg3TnM2TitMUnJyUW11M0pq?=
 =?utf-8?B?OWFTRXZjK0tXbENqZnJ1SmJkSWFlZ2hHSWt3VUZKZW1ueFErQ0JMbzJCaTVJ?=
 =?utf-8?B?YVdEWFV1MHBXNEtPTHl4S1UzNHhaUzh1dUY1YTBjdjNrU3VUVmVPV3JwcW13?=
 =?utf-8?B?ZE14ajNsaTJjZkRvZXBBaEVCTnhQK0lmQ0llaUhneFdweFYzcm1CMkFJSEVM?=
 =?utf-8?B?UGhhQ3pyNjloMktOeS9rYkJ1dUJsVUpzSmtZZ0NKNnJsekdyWlIwRzVxc3ds?=
 =?utf-8?B?Unh1TjFYV2tqTEJDYzVyc1BJUFl0SDY1bVNIbU9LR2VzbzVsRTh5Y2NSME1K?=
 =?utf-8?B?dnplYmdST21YaXBuR3cvU2ttZU1IN09XclJUN2VldzRadUtaRzE0MS8zbHdK?=
 =?utf-8?B?ZU1PdGhuVi8zTWNSbCtBRnZKbC93alFpRi9iOCs3cnBvQnA1NnlMVzVicWFV?=
 =?utf-8?B?V3lndmFBdWFTUXZPdFRTakRybkhkK3owUTBmY0ZiczRGUWgvUnpVTWxOQXFL?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0335BC2B499E84890BE6157A0B88D14@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z2WzCX7vEZZ52CZ2hrK9ahm1iaMoBJJhein67Grt8rtuxgXcLuFoeuaZMYg6UGoYRPLhjzrBXG9v7bNqVbCEB3lsg9FJWsp6sH34O44Te5jzR9hX2lCTwED5eIuQVTCLrfupZ6TBAdzunPguBdP5l2PGgsQS3EeKx0MQk3LBZAmzlDVc+D0XCEvi0JkqX8WQuFhUx1uDOAviLbdRPZdPryvB6a3rWJjLErBqF/0TVUWmnU/vBENboaUMIoSycVfjNT1SgUnw28tQEt6EBj7jPpLDXAvCURyBji2b1oZCFBmDO8zEYVPtjcfGi3hA1qE3tOeHZJSxCFHPbrNlCjdRJs3+yXU70VkRVO5G5AzODkV80E8N4Wn3D8Seq1t+iPveVubRKlzaVnfpdcLPO1EWoEaCK/2aeQpVcSQJvOdXNtbh1TW7cY92idUonVkZbm2jMVi/zeLpPiRA3jCCTHdxFGwbCb7OL/fSLqrqGH4grgtT+J3RvagVo6n2xhHHDEghp5aIH7oOm03a955jW3/1uLxHf20AAXeA032CgS0S8El4TBgb1ynftJLXYRboK4OMvSbaGVG2XzU726HDX6BFE501DR+EGv1kXaZ4WqungzY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcb6de7-9b90-474f-2ee3-08dc3700356f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 19:22:01.5604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hK6DQlbXSO/tWmC6hLGCw6kyOq7XImlYFQwEDnkKyd1ld8g33HbmCQpf+AHpK2cctwn+HMpKuGs/Dbb5kmqjB3aHlZTLKU5CObEzcoQZbwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260147
X-Proofpoint-ORIG-GUID: 9nROMyMoVbi0wJSxzybrjfSoFGEQnx7K
X-Proofpoint-GUID: 9nROMyMoVbi0wJSxzybrjfSoFGEQnx7K

T24gTW9uLCAyMDI0LTAyLTI2IGF0IDExOjE0IC0wODAwLCBLdW5peXVraSBJd2FzaGltYSB3cm90
ZToNCj4gRnJvbTogS3VuaXl1a2kgSXdhc2hpbWEgPGt1bml5dUBhbWF6b24uY29tPg0KPiBEYXRl
OiBGcmksIDIzIEZlYiAyMDI0IDEwOjI4OjMyIC0wODAwDQo+ID4gRnJvbTogRXJpYyBEdW1hemV0
IDxlZHVtYXpldEBnb29nbGUuY29tPg0KPiA+IERhdGU6IEZyaSwgMjMgRmViIDIwMjQgMTk6MDk6
MjcgKzAxMDANCj4gPiA+IE9uIEZyaSwgRmViIDIzLCAyMDI0IGF0IDY6MjbigK9QTSBLdW5peXVr
aSBJd2FzaGltYQ0KPiA+ID4gPGt1bml5dUBhbWF6b24uY29tPiB3cm90ZToNCj4gPiA+ID4gDQo+
ID4gPiA+IHN5emthbGxlciByZXBvcnRlZCBhIHdhcm5pbmcgb2YgbmV0bnMgdHJhY2tlciBbMF0g
Zm9sbG93ZWQgYnkNCj4gPiA+ID4gS0FTQU4NCj4gPiA+ID4gc3BsYXQgWzFdIGFuZCBhbm90aGVy
IHJlZiB0cmFja2VyIHdhcm5pbmcgWzFdLg0KPiA+ID4gPiANCj4gPiA+ID4gc3l6a2FsbGVyIGNv
dWxkIG5vdCBmaW5kIGEgcmVwcm8sIGJ1dCBpbiB0aGUgbG9nLCB0aGUgb25seQ0KPiA+ID4gPiBz
dXNwaWNpb3VzDQo+ID4gPiA+IHNlcXVlbmNlIHdhcyBhcyBmb2xsb3dzOg0KPiA+ID4gPiANCj4g
PiA+ID4gwqAgMTg6MjY6MjIgZXhlY3V0aW5nIHByb2dyYW0gMToNCj4gPiA+ID4gwqAgcjAgPSBz
b2NrZXQkaW5ldDZfbXB0Y3AoMHhhLCAweDEsIDB4MTA2KQ0KPiA+ID4gPiDCoCAuLi4NCj4gPiA+
ID4gwqAgY29ubmVjdCRpbmV0NihyMCwgJigweDdmMDAwMDAwMDA4MCk9ezB4YSwgMHg0MDAxLCAw
eDAsDQo+ID4gPiA+IEBsb29wYmFja30sIDB4MWMpIChhc3luYykNCj4gPiA+ID4gDQo+ID4gPiA+
IFRoZSBub3RhYmxlIHRoaW5nIGhlcmUgaXMgMHg0MDAxIGluIGNvbm5lY3QoKSwgd2hpY2ggaXMN
Cj4gPiA+ID4gUkRTX1RDUF9QT1JULg0KPiA+ID4gPiANCj4gPiA+ID4gU28sIHRoZSBzY2VuYXJp
byB3b3VsZCBiZToNCj4gPiA+ID4gDQo+ID4gPiA+IMKgIDEuIHVuc2hhcmUoQ0xPTkVfTkVXTkVU
KSBjcmVhdGVzIGEgcGVyIG5ldG5zIHRjcCBsaXN0ZW5lciBpbg0KPiA+ID4gPiDCoMKgwqDCoMKg
IHJkc190Y3BfbGlzdGVuX2luaXQoKS4NCj4gPiA+ID4gwqAgMi4gc3l6LWV4ZWN1dG9yIGNvbm5l
Y3QoKXMgdG8gaXQgYW5kIGNyZWF0ZXMgYSByZXFzay4NCj4gPiA+ID4gwqAgMy4gc3l6LWV4ZWN1
dG9yIGV4aXQoKXMgaW1tZWRpYXRlbHkuDQo+ID4gPiA+IMKgIDQuIG5ldG5zIGlzIGRpc21hbnRs
ZWQuwqAgWzBdDQo+ID4gPiA+IMKgIDUuIHJlcXNrIHRpbWVyIGlzIGZpcmVkLCBhbmQgVUFGIGhh
cHBlbnMgd2hpbGUgZnJlZWluZw0KPiA+ID4gPiByZXFzay7CoCBbMV0NCj4gPiA+ID4gwqAgNi4g
bGlzdGVuZXIgaXMgZnJlZWQgYWZ0ZXIgUkNVIGdyYWNlIHBlcmlvZC7CoCBbMl0NCj4gPiA+ID4g
DQo+ID4gPiA+IEJhc2ljYWxseSwgcmVxc2sgYXNzdW1lcyB0aGF0IHRoZSBsaXN0ZW5lciBndWFy
YW50ZWVzIG5ldG5zDQo+ID4gPiA+IHNhZmV0eQ0KPiA+ID4gPiB1bnRpbCBhbGwgcmVxc2sgdGlt
ZXJzIGFyZSBleHBpcmVkIGJ5IGhvbGRpbmcgdGhlIGxpc3RlbmVyJ3MNCj4gPiA+ID4gcmVmY291
bnQuDQo+ID4gPiA+IEhvd2V2ZXIsIHRoaXMgd2FzIG5vdCB0aGUgY2FzZSBmb3Iga2VybmVsIHNv
Y2tldHMuDQo+ID4gPiA+IA0KPiA+ID4gPiBDb21taXQgNzQwZWEzYzRhMGIyICgidGNwOiBDbGVh
biB1cCBrZXJuZWwgbGlzdGVuZXIncyByZXFzayBpbg0KPiA+ID4gPiBpbmV0X3R3c2tfcHVyZ2Uo
KSIpIGZpeGVkIHRoaXMgaXNzdWUgb25seSBmb3IgcGVyLW5ldG5zIGVoYXNoLA0KPiA+ID4gPiBi
dXQNCj4gPiA+ID4gdGhlIGlzc3VlIHN0aWxsIGV4aXN0cyBmb3IgdGhlIGdsb2JhbCBlaGFzaC4N
Cj4gPiA+ID4gDQo+ID4gPiA+IFdlIGNhbiBhcHBseSB0aGUgc2FtZSBmaXgsIGJ1dCB0aGlzIGlz
c3VlIGlzIHNwZWNpZmljIHRvIFJEUy4NCj4gPiA+ID4gDQo+ID4gPiA+IEluc3RlYWQgb2YgaXRl
cmF0aW5nIHBvdGVudGlhbGx5IGxhcmdlIGVoYXNoIGFuZCBwdXJnaW5nIHJlcXNrDQo+ID4gPiA+
IGR1cmluZw0KPiA+ID4gPiBuZXRucyBkaXNtYW50bGUsIGxldCdzIGhvbGQgbmV0bnMgcmVmY291
bnQgZm9yIHRoZSBrZXJuZWwgVENQDQo+ID4gPiA+IGxpc3RlbmVyLg0KPiA+ID4gPiANCj4gPiA+
ID4gDQo+ID4gPiA+IFJlcG9ydGVkLWJ5OiBzeXprYWxsZXIgPHN5emthbGxlckBnb29nbGVncm91
cHMuY29tPg0KPiA+ID4gPiBGaXhlczogNDY3ZmExNTM1NmFjICgiUkRTLVRDUDogU3VwcG9ydCBt
dWx0aXBsZSBSRFMtVENQIGxpc3Rlbg0KPiA+ID4gPiBlbmRwb2ludHMsIG9uZSBwZXIgbmV0bnMu
IikNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogS3VuaXl1a2kgSXdhc2hpbWEgPGt1bml5dUBhbWF6
b24uY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBuZXQvcmRzL3RjcF9saXN0ZW4uYyB8IDUg
KysrKysNCj4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4gPiA+
IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L3Jkcy90Y3BfbGlzdGVuLmMgYi9uZXQvcmRzL3Rj
cF9saXN0ZW4uYw0KPiA+ID4gPiBpbmRleCAwNTAwOGNlNWM0MjEuLjRmNzg2MzkzMmRmNyAxMDA2
NDQNCj4gPiA+ID4gLS0tIGEvbmV0L3Jkcy90Y3BfbGlzdGVuLmMNCj4gPiA+ID4gKysrIGIvbmV0
L3Jkcy90Y3BfbGlzdGVuLmMNCj4gPiA+ID4gQEAgLTI4Miw2ICsyODIsMTEgQEAgc3RydWN0IHNv
Y2tldCAqcmRzX3RjcF9saXN0ZW5faW5pdChzdHJ1Y3QNCj4gPiA+ID4gbmV0ICpuZXQsIGJvb2wg
aXN2NikNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0K
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gPiA+IA0KPiA+ID4gPiArwqDCoMKgwqDCoMKg
IF9fbmV0bnNfdHJhY2tlcl9mcmVlKG5ldCwgJnNvY2stPnNrLT5uc190cmFja2VyLA0KPiA+ID4g
PiBmYWxzZSk7DQo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgc29jay0+c2stPnNrX25ldF9yZWZjbnQg
PSAxOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIGdldF9uZXRfdHJhY2sobmV0LCAmc29jay0+c2st
Pm5zX3RyYWNrZXIsIEdGUF9LRVJORUwpOw0KPiA+ID4gPiArwqDCoMKgwqDCoMKgIHNvY2tfaW51
c2VfYWRkKG5ldCwgMSk7DQo+ID4gPiA+ICsNCj4gPiA+IA0KPiA+ID4gV2h5IHVzaW5nIHNvY2tf
Y3JlYXRlX2tlcm4oKSB0aGVuIGxhdGVyICdjb252ZXJ0JyB0aGlzIGtlcm5lbA0KPiA+ID4gc29j
a2V0DQo+ID4gPiB0byBhIHVzZXIgb25lID8NCj4gPiA+IA0KPiA+ID4gV291bGQgdXNpbmcgX19z
b2NrX2NyZWF0ZSgpIGF2b2lkIHRoaXMgPw0KPiA+IA0KPiA+IEkgdGhpbmsgeWVzLCBidXQgTFNN
IHdvdWxkIHNlZSBrZXJuPTAgaW4gcHJlL3Bvc3Qgc29ja2V0KCkgaG9va3MuDQo+ID4gDQo+ID4g
UHJvYmFibHkgd2UgY2FuIHVzZSBfX3NvY2tfY3JlYXRlKCkgaW4gbmV0LW5leHQgYW5kIHNlZSBp
ZiBzb21lb25lDQo+ID4gY29tcGxhaW5zLg0KPiANCj4gSSBub3RpY2VkIHRoZSBwYXRjaHdvcmsg
c3RhdHVzIGlzIENoYW5nZXMgUmVxdWVzdGVkLg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L25ldGRldmJwZi9saXN0Lz9z
ZXJpZXM9ODI5MjEzJnN0YXRlPSpfXztLZyEhQUNXVjVOOU0yUlY5OWhRIUtIS1VRS1VEbk5DZGlF
Y2I0WksxVkJpWVNpdGFyRWItQ0FXZVNKdmFlSzA0ZmdXNGN1V2VQZzNBYzJIbUlBUFVIdXFlQ3dn
dDQ2NmZIRUtBQWRmYSQNCj4gwqANCj4gDQo+IFNob3VsZCB3ZSB1c2UgX19zb2NrX2NyZWF0ZSgp
IGZvciBSRFMgb3IgYWRkIGFub3RoZXIgcGFyYW1ldGVyDQo+IHRvIF9fc29ja19jcmVhdGUoLi4u
LCBrZXJuPXRydWUvZmFsc2UsIG5ldHJlZj10cnVlL2ZhbHNlKSBhbmQNCj4gZml4IG90aGVyIHNp
bWlsYXIgdXNlcyAoTVBUQ1AsIFNNQywgTmV0bGluaykgYWx0b2dldGhlciA/DQo+IA0KPiBUaGFu
a3MhDQoNCkhpIGFsbCwNCg0KVGhhbmsgeW91IGZvciBsb29raW5nIGF0IHRoaXMuICBJJ3ZlIGJl
ZW4gZG9pbmcgYSBsaXR0bGUgaW52ZXN0aWdhdGlvbg0KaW4gdGhlIGFyZWEgdG8gYmV0dGVyIHVu
ZGVyc3RhbmQgdGhlIGlzc3VlIGFuZCB0aGlzIGZpeC4gIFdoaWxlIEkNCnVuZGVyc3RhbmQgd2hh
dCB0aGlzIHBhdGNoIGlzIHRyeWluZyB0byBkbyBoZXJlLCBJJ2QgbGlrZSB0byBkbyBhDQpsaXR0
bGUgbW9yZSBkaWdnaW5nIGFzIHRvIHdoeSA3NDBlYTNjNGEwYjIgZGlkbnQgd29yayBmb3IgcmRz
LCBvciB3aGF0DQplbHNlIHJkcyBtYXkgbm90IGJlIGRvaW5nIGNvcnJlY3RseSB0aGF0IHRoZSBv
dGhlciBzb2NrZXRzIGFyZS4gIEknbQ0Kbm90IHF1aXRlIHN1cmUgYWJvdXQgc2V0dGluZyB0aGUg
a2VybiBwYXJhbWV0ZXIgdG8gMCBmb3Igc29ja2V0X2NyZWF0ZS4NCldoaWxlIGl0IHNlZW1zIGxp
a2UgaXQgd291bGQgaGF2ZSBhIHNpbWlsYXIgZWZmZWN0LCB0aGlzIGxvb2tzDQppbmNvcnJlY3Qg
c2luY2UgdGhpcyBpcyBub3QgYSB1c2VyIHNwYWNlIHNvY2tldC4gwqANCg0KSSdsbCBkbyBhIGxp
dHRsZSBtb3JlIGRpZ2luZyBteXNlbGYgdG9vLiAgSWYgeW91IGhhZCBhbm90aGVyIGlkZWEgYWJv
dXQNCmFkZGluZyBwYXJhbWV0ZXJzIHRvIF9fc29ja19jcmVhdGUsIEknZCBiZSBoYXBweSB0byB0
YWtlIGEgbG9vay4gIFRoYW5rDQp5b3UhDQoNCkFsbGlzb24NCg0KDQo=

