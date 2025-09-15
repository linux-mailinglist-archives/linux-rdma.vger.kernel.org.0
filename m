Return-Path: <linux-rdma+bounces-13365-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505C4B57510
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 11:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065C217DA33
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E82F9985;
	Mon, 15 Sep 2025 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZaRhs4oS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v0oEYTSp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C31F4701;
	Mon, 15 Sep 2025 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929464; cv=fail; b=sgtpufZ08gKZ2bem/FpweFSH9Vwe9kVMMhZlRdK1fOtNwmyYH66oxAJ3YypkdfNk49V0Yf9l67C4EbONkChUfteaTNPzoI+KoIj+5l6dY64il21ySTa699SztSyx7uT7aclE50JsEzL2f+mwiHYpnVWJ2TH1mb8vFNaanmjo7ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929464; c=relaxed/simple;
	bh=0tSGnY/EUccQWIH60VcuiUlLGcaZu+WIiVXK0b7D8nA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jn2DTJzGJoIULJgL7POTAHkx12cPqW2o7j5htWDP5XryJRLvryQnZU6Gt6qyOQsyQXl9R9MQI9AUpWmICMhvKs1mYQVIaMDUnzBwdgkhljCw0ioboIlKpmMaPGPhyRmrf1z6PC4TfjS1D0ocLApsCYaecxbPK/EmF2N7SA9lABs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZaRhs4oS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v0oEYTSp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6hTWL028162;
	Mon, 15 Sep 2025 09:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=0tSGnY/EUccQWIH60VcuiUlLGcaZu+WIiVXK0b7D8nA=; b=
	ZaRhs4oSKOtUzUZ1Y3hKAxpIr3L2RXWNSByY5EKYIqKk3fQN0PnEbIdiZpDvBSAH
	Mz8k2ikXTLDxk0PUrlLeYdNxU+bkeILf8US3ZvqXSBGlJvt3cOJYBnzahsKxfL0+
	HroAroqEHsbT1qcfBAsmuweIFTOl22PM3qT86sWzQMPoiRA1166w9aW026YIXaA9
	+TCf6JbSXwVXzxmWOnvc15WeqplrnPjVaj3ZflO0qBZhPce25CH8zfs/1mq87m9C
	B2AJmuqAlJAsuUWwwNvwy/aidVPwXyzztR+loHVZ/MOIAImsJ2txiI4esCDHkQY9
	TQneSkF9OcJ32T/JmwS5AQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49515v1xtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 09:44:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8fbsN011214;
	Mon, 15 Sep 2025 09:44:17 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2asjgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 09:44:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ug9HS4VRkINzhTjFBa0oJvLZSg64PSTFygkPbA+G0DJhvaDp1lXoBcgUTREtdA5BYQ4Zme/WaDfsqoZyUvTUcN4Edi4Cfzoo0v6Sj7BYNKJtYK1yGP/0iFxS70KYw7/fD2S8cSuyREnpOBaSS10BGE3HCK53o+NQAdE6P1P9ujuhaGxWdfUEtPXdXfZIoS7tV1PzEDER2ldLm14/HtNRuWItnMV7acyoJf/O4GgEi97gdBV2sH1oWHosVHzYibp3F8HlhxLm/vj9sAoEKJxu/uQXiHVbQIuLU3jO2V6lFsd55Qnr6NRudZrhhmYUdmt/LnQDXRRJaKjCtS3L1se63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tSGnY/EUccQWIH60VcuiUlLGcaZu+WIiVXK0b7D8nA=;
 b=gX0QmAeod0q506sTCXb5nBxLFmKj2vIfe5xdyD0NitCjvYBbToi6y3Y+vOqZfs8WNhhl1KbAvhF/ktxLYcD/5RgBlHDn8WGFq66gE23hgVeCsTw5ZXIUuB1WfZZOiw8Ff4R8LVGVaVQGF7Gg/Zu8XzU8spHckErGYFAcjK5Rcqmc5LB3JBd9k3VwB8qdO4mg62vgUIfIE5THhcXwNUIL25L0M6g1CB6JrT76yrrpmQSlw4QpbpNYkadPk17buaOJAyeplPUyrfwAJYMgeObsoB8OZByqjCdP0jmAqVn6sgo818+hG8i/9iS3dmBKA4vvGube0HfjeAz9zz4EAMI4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tSGnY/EUccQWIH60VcuiUlLGcaZu+WIiVXK0b7D8nA=;
 b=v0oEYTSpHPfMJvcF/PwvajxHRAZuZV7i+QlUrU2wVqhsEDtecsXmJ1y79D1U/zdNreNdKZISiadZc/GUYUyyandgt2kvRaZ8wlHjxjr2M2RAvBNTDGP7KHrv4LDN8h8XzTgqP3FyuxbueybUDYpeaEcfhXFli1cFzsl4NLuwBpM=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by SJ0PR10MB5804.namprd10.prod.outlook.com (2603:10b6:a03:428::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 09:44:14 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%3]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 09:44:14 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Sean Hefty <shefty@nvidia.com>,
        Vlad
 Dumitrescu <vdumitrescu@nvidia.com>,
        Or Har-Toov <ohartoov@nvidia.com>, Jacob
 Moroni <jmoroni@google.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Topic: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Index: AQHcI8zHdy1KL4KXCkyexoudDHS8M7ST4SAAgAAhzwA=
Date: Mon, 15 Sep 2025 09:44:14 +0000
Message-ID: <5CE8AD4E-1ED3-4492-9062-D9910C9B1502@oracle.com>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
 <175792218281.1172128.11777926053050212672.b4-ty@kernel.org>
In-Reply-To: <175792218281.1172128.11777926053050212672.b4-ty@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|SJ0PR10MB5804:EE_
x-ms-office365-filtering-correlation-id: f33052f9-e98c-4206-6654-08ddf43c6e54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RE9TTDVsa3ZTb1hhR1kzNVdWTEFQOUk1bUh4TmttMDE0M01vcG1BejFjdEFP?=
 =?utf-8?B?ODVjTG1kRnlSY010N0pIYUhLMHE1WDk2ZTMzQVovSk03aU8vRjJranZMNklr?=
 =?utf-8?B?aURwVUJvNHp2Y016TGpSVWt0WFNtL2dmSHR3RU42b3JENmVpYjlSVTVNeUUw?=
 =?utf-8?B?SFdIbkYrdUdCTTZlLzUwcUczRDZWVXA5bVpHd0kweTNhbnJuNHY3OW5iOUpF?=
 =?utf-8?B?Zi80V280RmJHcWdudWxqUXo3U3dWRkxDSGVxWEZYNmtXQlU4b3pJSFNjL3ZG?=
 =?utf-8?B?YXJMM0R6NDFhOHg4cjBkR2NiODF0bVBzdmhTWGU3YXZTdzhuL0NrVzRSTVhE?=
 =?utf-8?B?UHdtaDR4K1EzWElDZUszNERBU1BWaFZUSERXRXptbE5GRFdsM1B1N3ZTbDZi?=
 =?utf-8?B?SWpDaUltVmxiTkN6bG5RNDNEVmQ4Rk03MkN5NGQ4ZzV4N2lIT2swR3RiNG9a?=
 =?utf-8?B?V3MwWlVHTHI3TXdEclFqcnUxQmVQU1JBc1N1blJCWUpoTFNVeEVkMHRpTHlI?=
 =?utf-8?B?UVRPSlhmVnVId1FxNTVUWUVUY1VBUnNSTFFrbit4MVZRQVFIQW1xR2k4cXlt?=
 =?utf-8?B?UXBWSkJVSGczQlZNYmZtelg0U2NaNkdUZFI1MlVUb2t4dmdUeUt0aG1CSFVh?=
 =?utf-8?B?QVVUbW80VlBtUDgzaFIwZmdlcXlFVlJhTkp1RFJ3cVQvWjJMNzBXSmZkeUl5?=
 =?utf-8?B?Y0V6a2RRTW1oc0IvQTRrUnMyNDQydlYvMWVZckxQSDh6Qm8rREYwMzhpR3J2?=
 =?utf-8?B?MDJWZ09UT2VFU1FUMzQzYkpYS0Fyc3FCdDFPQnFjUEV2M0tIYjRSbmtvTTZ0?=
 =?utf-8?B?TzMzSDhWY0tvVW9KMWdkR2tnWEQ1bUZHTmwyRS8yeEJKbmY3amZtbE1nbHhP?=
 =?utf-8?B?aFg3QzhwTmIxMVRBb0hFWVRuSExjU1I5Wmx1K0tObWR5NlQyQkpibGFMdkFa?=
 =?utf-8?B?ekJPY2tkL1VUOGhsemNEQkxkOHBZK1pRa2dCY0dVcWl0bERidUwwaHczTnZa?=
 =?utf-8?B?SWkwUUZIbFNpMXVHZTFVQlFocmVySENNQnlwcWF1NnF5Um1ING8wMGlTQmlP?=
 =?utf-8?B?c21lcU4wbm8yakpYWGpjNnhycmQ4OWNGcEhlMzF2NDROcWxFd0hqK1F2Vy9J?=
 =?utf-8?B?TG9pcHlPQlhkSStMQUhicjNYdVNuRjgxK3ZsWU9TMXhsUmV4ZHJoVjQvOUNk?=
 =?utf-8?B?WEpzVzRZZzFUMmZBblhJeW92dmhoVStNRk5QL1E5QjF0ZUFMdmZycmo5N282?=
 =?utf-8?B?NFQ0SVVnQnBTQXkzZHg0eGJQd0pRUlYyNGplMTNla0JveHkzb1FCa21sbHpY?=
 =?utf-8?B?TWtqa0JXaEZ3amdmY2hYVmt2QWhqcGJ5NnNZRm5jUDl4V1JydUM1NndSbW42?=
 =?utf-8?B?YXJZN1JkMG1oYTBMbjFZQ1cwWGRKWmc4MkNOcmVrK0l6VzR6NWdrTVNJN0t3?=
 =?utf-8?B?VkhOb0R6U1oybVE3V010RXRUcy82TlRBSVF0NDRGR2YxVkQ4ODV0d1p5c2dU?=
 =?utf-8?B?S0FjcXNuVEs1eG94RGJQWlpBVS9FVTc3S1U4bFhiMlBJbnlHRWlwRjVJU1Ux?=
 =?utf-8?B?c252REw0Z3cwZWNuZlJxd2h2NlUxc0l0VjZKQzgxUVh0bm9DY3ZYOGExYmw3?=
 =?utf-8?B?Q3FYaFBxZVNzNVNXbkN1cnRQOVhvZ0dROWJKL3N5ZDJnRWtXSGJZNDlmaUha?=
 =?utf-8?B?U0pWMk8weGJrZnBsTStJZnVnNkkvU0VtMjlYKzhZWURoZTB5Yk1LVVBHTUFT?=
 =?utf-8?B?T0RXMUZOeXlOL0FyOWhRUE5JSFZqd2x0cnkzSkVScmthc0R0NTZnaVFRTFY1?=
 =?utf-8?B?Y2MzeEZFZHNMdjRyVEdXU1M2K00rUGJ2WG9EWjhvS204aUVhamcySHc2RmVH?=
 =?utf-8?B?b1JnMEhMTUUzQ1JsZGszdGl3ZTlkaHFTUWJEMHpkUU9xNXd4QlJqYm5iNDQ5?=
 =?utf-8?B?clVXNkdTaE93WjVhTmN3OXhOOGZGcjBQMUt5YnlObkpiWTYyUWEvU254VGNS?=
 =?utf-8?Q?8yF15vhbK/AGX14Ly+hnVnc91YrPFg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clhYZ0xSYUZIbiswMjUrcmVjMVllaUMzQVlyc0YrTjB1SUt0RUtQTHNIR3pi?=
 =?utf-8?B?TDhTVTNVeDgyZkdLN0tFd1dLMCtxNldBTXlZS2x6dVAveXFudWlyaENHNTIr?=
 =?utf-8?B?SFhDUytUeGFPOVZhZWE0eGp2cUJzYWh3L2VNWHB2citDWjNOdHpyNXo0a3V5?=
 =?utf-8?B?SS82V1dSREl2bm9TTjhIelhoVFljQnU2T1Y4TlFJRHVZNW03eG1Pa0lJdVFi?=
 =?utf-8?B?SC9Hc1MzM29ESXI3aUhMT3hnbHd5aTl5QWFHSzZIbG9aQU5YbVRsaHp4RjZk?=
 =?utf-8?B?N0pLYkhhTmdwK1J5TUlCUnE4K0JJSllSdUg0d3k1Zk9COE44M2FudGM2TnpB?=
 =?utf-8?B?Z2RtcXJ3YzVHYzdNdnJOVGtXTXpVRHY0Nk91QXFLUkhiYmVpYXVpUlVpTzVU?=
 =?utf-8?B?R2I2MTJta3RUTFdOdFIxSWk4NW5wekExOEFvMUY1N3NNQlVoZTBZUTZGK3NH?=
 =?utf-8?B?WHFTdGUyUzFFNEE5elVuenIvZDZ4V280bVJJQ3JBQTZPNVRFNFgveEJRN1hq?=
 =?utf-8?B?NkNmOUp4WjBsY3BLQ2g1RllQVjgvWlF1MDhMSklXazhrOE5WUVdTdHlobElN?=
 =?utf-8?B?blh2TFh2WWc0SXFwUW5kSWYwUVNQaHpkbVdTcDVlTE1za1lhOVNpckR1Lyt1?=
 =?utf-8?B?QlZYclM4akVHTE9sbVYva1U3RitDd000QzFKSmxReGZMelRFYzVoMm5GakI1?=
 =?utf-8?B?ZTRnRHgyMzlMU3ErM2tPWjg0QlNsRVc2N1F5cDFZZ2VGSENZajdYUEF6YnBY?=
 =?utf-8?B?dUJlRFVnbmx2ZndvOTgzV1VNYUdtdWpETEZVNEM5V3FjOHRtbDFWck0zR1hz?=
 =?utf-8?B?NXpNTUdRRmgwSlZWd01UVXNzZG5qOG9HNTZRK2NxRUtUMk0zQk81Y2Rud2Z2?=
 =?utf-8?B?TnRRRWpIakV4Vy91aEZXV2QwUVVvYzJ6aXlwNEpkQldtWHRTMDFOOVExRHp4?=
 =?utf-8?B?ME0xbGFSOUZDbVhFdmwxb1I3eUQzREZSUVFxMS9LVmMxVEdwOC9uMHVpNSsw?=
 =?utf-8?B?RFJDWkhubHBDazZ4dkZKSGV4Z3NxWUNTejlIVWEvQmxVbjk5WW1tcDQ1eUI1?=
 =?utf-8?B?RlZHTklPS3p5KzJIN211bXIzd1NuWVdnMXYrQ2V0QzlJQjdMbnpwNlA4ZWVU?=
 =?utf-8?B?QlVYOTNncU5KaXRZMDYvWGlKb3JIcjY0eVRJVU8zZ0VDajV4MFlwckdERnFM?=
 =?utf-8?B?TmtjLzVkWmlhZ2ZVOVlwWWtCNml0N29wVEprSUJvM2ZRVnJnVlVKNVhETHlI?=
 =?utf-8?B?M0pJM3pjTlllSUcyaVJlcStzTFIxQ0p4MDlkU3F5VWxvREhjVUNOdWJiSlFT?=
 =?utf-8?B?cjUzWk5LTHF1TjRlS1dpSTBjdlBxNXdaanVzdkZKL1pFdlZ2ZUpFZ2czbUlS?=
 =?utf-8?B?WXNyckw1RXptMG0zbUY0aXppYzZKR3UzQW93RTBHVm03aWJyOVhpMkp0a2FQ?=
 =?utf-8?B?b2U1Z1hlQU5xeWFUbnQ2K0Nrb05iQlc2SnJ5SS9NZHhvMXVGNXMyeTl2MURq?=
 =?utf-8?B?aUd5bEVVbmo1alUzOFNJK3c0NDdYV2Z3SXJjOUdhNVdYeHR1SktQMmNnZTBq?=
 =?utf-8?B?QmRVVExYM2V6RUtIRHdiNXNIalhrRW1xeHB5R3EwMFZ0RysrZzl6Zy9KaGRw?=
 =?utf-8?B?anJNUlBiekNxTXpxTGRrRFV6T2I0cVdIRGtmRmVaY1V6RFBaQWI3U3lKU25S?=
 =?utf-8?B?ZE5BeEZtTWhtWTkvejdPVWtoMGZtcjVPOWJldldSV0NIczJtRXk5Z0V0bkx3?=
 =?utf-8?B?Smx0eTB6emZwaWFQZTdReTlNVVZGYnUzWW45SW5xS3NLWjdMY29pOVl1L1Bm?=
 =?utf-8?B?ZGttSkJ2SWI4dzhsNUJ2KzZXTFg1dWFjblBBN2VoZWtaV1Y3czJWNW1LTUda?=
 =?utf-8?B?ZmJ2ZjdnenhDOTRjWTJwUWt0K0V3a000b1U2eEdBYW9Jd2ViZ3ZuRTBtY0tJ?=
 =?utf-8?B?anlzT1FrWU9Ic0FCQVpTa2UyTVZwaVh0by9JdnJ3emhxb05PemRLZC9XY2Rr?=
 =?utf-8?B?YkltbllrbThlSjhWY3FkVTMwS2JoTCtOdFgybnZGWEJBQnFqL2cyT3NkWHlu?=
 =?utf-8?B?WFJwYWNiVlV2VWpMbnpjeTltYjZ2cGd0L1FaNTFVTmdXOVdyMytQSXQzU3dr?=
 =?utf-8?B?K3BqWkh2eUFLZ25zMGFESk9hTDN0SVp2OE9YRFdNZGFneDFNQ0RvSXJWOXpx?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AF83B826A8CFC44B14FD9A259D4B9C8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	olkcpcdubq7hiJ/Jtb2BGb331tWBh2iTGvvXee04fnrbr1HfHhA5DiNrsmt/yb0M4B/fYvzi9YEzRI468LBQkSXno3VZXo8Muomowq4FO2KEbBx5+/x86GwO27ddLcZ40heDc4j546DwMLSexe2agx08VJK78MjTCbhYObdorI8OBGbyFaDXRAQYqKgN76nDx5ELGaR+hblRSmjKkUFUYFpo5MBRbYDsMiTbv8PVG25a2wBQBiAZFauIuzfWZY0qhzrYjOoWmxmJ0KfPJdVv5D/rYJgzGaro9TC9OR7EwQYE0dQkhWSxQHC0H3uxUMqYCH86wSY5j8UiXFnV9QqIHCfVjgWdOFeL7vkTgzQF/euttzI4FA7MkgkS3qVhGNmQNFb90X/wLA8tu9DJZ0Bec3B5WmBtgBrp/VhNFk4LTg7UglseFPdL+h2KeYbYLFTcxDIPUW01M8SIOJ6BZp03uVcgrtANNu1TbsP/q77AhfTMwD5R9I2nt8Pj4qarrfMnClGblNqPF2YjYz9W1O88pOuNw5NyhNxhlzKZOK9w6/wEsZcHYN3vPhTGDCUAq/mO0nPe4vt7hzPLi9MnqVWebUZHxkZLBmPzUFaadlrS1qQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33052f9-e98c-4206-6654-08ddf43c6e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 09:44:14.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3MvnaHSiLUBOztbLtno4QJRGoAGz1dqpc0uZjToaMumeN0oQKGo8IElpMW2ZvBugAdLpVkd/glS9eCV5XffOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=978 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150091
X-Proofpoint-GUID: I_qUQfUDkg-AF8oXWmuS76lC5nrWiKDw
X-Authority-Analysis: v=2.4 cv=RtzFLDmK c=1 sm=1 tr=0 ts=68c7dff1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=vaHAwIBSzsuKa3FuzzwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMyBTYWx0ZWRfXydM6VZYKJM94
 xyqThIFl6OdIsTPVYnhjlmPyHTSI/aZgnZgeH+jxL2zF5mlhYXyaU57MhguWKxGERdVhfgndljn
 d/iiRI3gAsISZqG4zVzLn/QcphB6KZyEHoPbWOajrruMcLnYutkCKr1l58HqO37MPexzhmdfN5Y
 vpQnkTYxbjrNh4hVw0UdfCyj7+wfSGIcTFmy1hkMl4lfbD8OWewRvX80tPLCSAPG9MK9HYqanpj
 siOkmCFSbPbE/VBdLQVJFEtvw5SvPSUdDmc6Px8RwLYzHA/KW9MinzbX4TKQSyVBL3UfE+OCh5x
 HJhMzEkfzxX7enGHGqz2T6amOK7peuzDrqF+COL5K1647aPmrrjvbN2DANRFXZ47+qXfffLWM51
 qRTo+eaY
X-Proofpoint-ORIG-GUID: I_qUQfUDkg-AF8oXWmuS76lC5nrWiKDw

DQoNCj4gT24gMTUgU2VwIDIwMjUsIGF0IDA5OjQzLCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiANCj4gT24gRnJpLCAxMiBTZXAgMjAyNSAxMjowNToyMCAr
MDIwMCwgSMOla29uIEJ1Z2dlIHdyb3RlOg0KPj4gV2hlbiB0aGUgZGVzdHJveSBDTSBJRCB0aW1l
b3V0IGtpY2tzIGluLCB5b3UgdHlwaWNhbGx5IGdldCBhIHN0b3JtIG9mDQo+PiB0aGVtIHdoaWNo
IGNyZWF0ZXMgYSBsb2cgZmxvb2RpbmcuIEhlbmNlLCBjaGFuZ2UgcHJfZXJyKCkgdG8NCj4+IHBy
X2Vycl9yYXRlbGltaXRlZCgpIGluIGNtX2Rlc3Ryb3lfaWRfd2FpdF90aW1lb3V0KCkuDQo+PiAN
Cj4+IA0KPiANCj4gQXBwbGllZCwgdGhhbmtzIQ0KDQpUaGFua3MgZm9yIHRoZSBxdWljayB0dXJu
YXJvdW5kLCBMZW9uIGFuZCBaaHUgWWFuanVuIQ0KDQoNClRoeHMsIEjDpWtvbg0KDQo=

