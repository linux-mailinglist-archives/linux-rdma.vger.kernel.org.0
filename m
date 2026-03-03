Return-Path: <linux-rdma+bounces-17425-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPEfMVc0p2k9fwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17425-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:19:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 874841F5E10
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F8D1305F322
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2254B396589;
	Tue,  3 Mar 2026 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WlNHjhg0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951F39656E;
	Tue,  3 Mar 2026 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565576; cv=fail; b=LH3AU+uYxLeZ4J2KquW1OO71DJYEA+YCM5i1Rf072CpfdNgy6ZbqlxUOq089TWu9fLt0xsn4oJX23wtYCU3b42xSFOJVxHS9UoEQEWxH2szSAEPyuge9XyrWEhph/+94+kCvmJ0rGVJt4fXvdXzDng9bSD4/iVL9jBnYXk8M794=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565576; c=relaxed/simple;
	bh=T7QUzr6ahL+Thz4liWgCD8DFbR6Iv8Z7ngJ2J7X4e9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OT6SK4Xpt30ZQVg6xYu+ntaVU/JvyWdKMDlZEXoRvwlwcPvj6KE7DkLqtq6nXj+6pUDHgcE4G1NffyU66mCjspxYxxTeiGq6dNbF8Y3QtbVkxh038t46LJLdns8hO/LuLJrYcsHnrvO/ZaCqAG2daMGiH3JjRPBzSMoli8aZ//g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WlNHjhg0; arc=fail smtp.client-ip=52.101.48.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGy2QlFZaVWZfrQ1CyYL/V3mtnn/F29+RiDfhkNfJr4cdylXz31M3WxOihQPtUbisXAEGsHUVsZ3/mA9h3poCLtB+tEhd8g/SV1AipF2R0VUOwgSjB702lHXvcAgxljTRf8m+aNMVeBpNTgLRGGs5BQgnXxblnZBxClCMwA2+pg/jlQc9MlK+4gtDg9ZKfcbhFtPpQsCW6C2DmZ5cY+VL6oSLS4K55m14WQ4XY0OkVl6cvFjOe6nA7erbwt1mR5bk+sNwoV8Ip6r3BrYmRweX1LLueUa0iecjOhakixYTVais3anhsJVc71DumGdO5ejpK5U/wGVMB1HmLwp9ZwBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7QUzr6ahL+Thz4liWgCD8DFbR6Iv8Z7ngJ2J7X4e9g=;
 b=GeXgFgCgL0/qpyL0BxQqkDGRlze8FG2u/F+ZG9a9dFA9x7NoQytwBIDeVxFGa+KrElpnzeU0c5wEG2y0MUWWK+/mb6iYS3p9T76iRe8lIbO23ZVDh//QyYrqQaDMm21VO59WlWxGf4uih9pPe3X51avN/BWaTWcEKrfjXV4C0ou1bNJKRDJKKJvUZ29Nf38eMDpCb8Et5zlz8A23dGR8htkUxgIa9FcLzoue1VDyyvSjdBib6+9RrUdXAoC6Y81yBkDmqRWYkV/f5EyiI1xVPehwTr/Pl6jmJ4SXwJdvQlV7LRl9yHUm4ZggbQOXlmW63+5AHJ2IzPbJ3NO6l/S8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7QUzr6ahL+Thz4liWgCD8DFbR6Iv8Z7ngJ2J7X4e9g=;
 b=WlNHjhg09t6bO/kpFhJRBqg+7VGy51cK1OaT8QaiPM32hp+RnmIL4NIaKavTgRX6/8ZViBIttzh+Fn5G0yGGkbWvmXvC189Hrga+Frkle95RalrNPNTmmK6KcTsnignk428G1K/npiWAk4DiKOBvcuGuKcOqD6INBJFXdDhzRyvngsW+xv3QUuLXQIbmDULG6eeBlAkfq4dRwCXta8I5zXArVAD7QFPYLo2bP94xJFUFnPI6grUWTBGAxviQ7slJ5suZGCKfCKEAzwsyNMMERmsls6gj5qUxhiKOObWickjiHO9GESG1nkx97LfPATyu5635xh2CY/HSVe1ik7JOsQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:19:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:19:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v7.0-rc1 kernel
Thread-Topic: blktests failures with v7.0-rc1 kernel
Thread-Index: AQHcpvcwQ4wuN59YckSu4sxsMI434LWVE2kAgAYDh4CAAiBxgA==
Date: Tue, 3 Mar 2026 19:19:30 +0000
Message-ID: <a5036526-8d94-42d7-ae94-2732b7cc8dec@nvidia.com>
References: <aZ_-cH8euZLySxdD@shinmob>
 <4c7aea9f-ae97-43c8-8b08-905696303978@nvidia.com>
 <20260302105051.GP12611@unreal>
In-Reply-To: <20260302105051.GP12611@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB6842:EE_
x-ms-office365-filtering-correlation-id: 93e8db38-4ac9-4b1a-0f91-08de7959cb31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 Je79Mr2VMF1or9crwey1GcbIijRWDqrHE4tcW6u21llpQh5b/O8diIi/VeeiqP4uaRiKyy3GciEANMaenh5L0UT3BLoEyZhezWTXvymLRD4Sr7nZ0346BTcBNrtaZoLrwTxOqYyt30reYMPhLbmquvSZbc0j0htEiein/GSxVpddh3ZW8KIWmnj/V/+kuuOEWLYx6ujk/dJxmc+Z7YsLRNvWyNTzyUZSOYp6wBX+lWA+jg6FF48dLR84+Y/QKs2/CLvSvxFziuzD/g2ubWDgHhc+YEb/77MnEqKXWjTrEaEx7Wbk1ZziA9pSLXIwb/cIcCca+EGm5tbmxefCPZJyLKUQuvf3WHO55+hwUVj7oh4ZJiVVXLrAcjho6jC+/5Jz1VT3KvwmYhIICoE0L7aMBkc/mMOLLIrTmrc6H+s8JwB8JEuSbzWVCZhZtkUtSItb73S6RxLRe8vPL/9V6wo9noVPUUM+YrkKxEpJVT7gPGgkxSLnkc1v0qHHfuFPwAVboBX/4o/bqiYSBHF9ehImyFGbaiD/SZ3V7t1KRfF7kTc6/GnL2afX+BcqlPUmIiTEGLVYz+h6/C6DiwwDnSli+1by18xbDsKyibQe3HshLi0vQs+aJgCkB4c8xu5+amQ9pInTU7Z6MMn+1xvial3hyL0b9pzNUY/tbJFwJN8WKlMDrEK3C4ZipUuCnoJtXZr2oab1UK1uejJh3/NUtAZSBs0otSNDOFsrd7FHjLx2tsvKdz2fy7bxZ7y9vX7Foef+oKVeuoOb4Uikc6+EilsCKG8Hs3GjNBqUlkx7o4deHpI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXhkZGJmVXJpN1ljY2phb09raDVkaHFZcFFNeVhKenNBVnVhYklzdmVzSFZw?=
 =?utf-8?B?Zjhhcis0d0s2c3RJT3FsL3I1bE5wRndIZG5jeUhQaWthWjVJRUpVRUFudlNV?=
 =?utf-8?B?a3UxcjVYMlViMndXc0VxTU9jYlVVSExwMGZXdkJFeU4yempVNWlQK0x4Vm5u?=
 =?utf-8?B?UDV2V2dSNDBHNnFxSFhRdnRjNDljeG1nZS9ZVitJNFZ4Q0c1dStMWjMrVVNm?=
 =?utf-8?B?Ti9oUElzRElTSUxOQUE1Tk9MTk8zQ1JyL2NSeXVRUk12c3R3R0pLNGZCeU5K?=
 =?utf-8?B?dFpkcEtJNThpbkR6dEo3Sjh6dVJqSllxNXNKcVVIczh4UmVUTzNPa2V6enZm?=
 =?utf-8?B?Tk9CQ0ltUW5Xa0VPaWY2elNrSkNtbVY0UVVEQkZwT2hsN3dJTHRpc0VzT281?=
 =?utf-8?B?enMvZnJUOW5YNGZMcnVWeGpsbjN4VEtheG4rUVpDY2pnaGxGOG1NMldsb0FV?=
 =?utf-8?B?c2R1RFd6cHFSdjlOZVcrSVNGcnVmdmw0T2c0cG1lMlpvUStvMUp6bWhxdnpy?=
 =?utf-8?B?MWx0NVMyODhBajREU0R4bTZhaFNQc0Y0ck9oVzcyenV1WEdadUdSRVVvZmtz?=
 =?utf-8?B?WnBTK3JSeEtiaU1pUlBLK1EyUGpTNTh4bkRCTDM1RHBGOUszVlg0WUpieFRD?=
 =?utf-8?B?RE1WSGtKRWE4OGY0RzArZkVxNWlSQngxc1RrWXNFL0huUXNvQjg0Yk1vM21G?=
 =?utf-8?B?N2luQWRXNEFQRCtVNEFNTUhhbEQrV2M0VW5JcU9yK2lNWE04b3JJOHQxQ3R2?=
 =?utf-8?B?TW5hWU9HNlZIclphVFVLRHY5U3Z5L2huTnRMK2tOR3ZoYUhMdllMZFhSOUZY?=
 =?utf-8?B?ZVFpZVRZR1I3Q3BEOUtvSFViOTNKSVdVNnNTdTFMMVpKbmlQZzh5Mzh4LzRu?=
 =?utf-8?B?OWYyTXYrTnBoRE1XQnlRL0hScGFtR05vM0kwR2U4RnJTTGd6d1Vnc2p6S2xi?=
 =?utf-8?B?MjJqWGtXQ3RySDRLZ2xGbG03VnBOMlJpSzVqOGFyWmNCRVJjR3FHSmVRWWd5?=
 =?utf-8?B?bjZuZWpXeXBOV1V5NTRGcFRUS0doR2l2emh4SUM5NXJzNFRZVXFqVkdmbnZh?=
 =?utf-8?B?ZVRla2VsSmltZGJhek5sZUlvUHlBZDlmNnBoVVQyN0ZUNUtQYWZ3Vy9qZyt4?=
 =?utf-8?B?L2dpQVdaY2pxbTBpVkEyQlNuOWMrQzltSWtOLzRFOE95aHRJMXhjcGFEMzdW?=
 =?utf-8?B?QUNrUUEzYXVpNFozWXRWRCtWdWdhdmhFSFpDTis1cnFNTHVnbXhlUStKRUJk?=
 =?utf-8?B?Y2N6allvVVJiR1FKa3FiN0xPTWY5cy9wY3dQSkxzaDJRc0xKRkpBNThvdGVn?=
 =?utf-8?B?dG80M1FPMWpRQ25Ub0FXVlhkV1JJamVVZXAxcnkvTWpQcjkvcTdvOEsvbEFS?=
 =?utf-8?B?MDRXbG1CM3crbGZQTXdmY0dDdlZvNkZudnRLaU92SnVlcGxFRHE1MExGTWMv?=
 =?utf-8?B?VlVzYmR6ZFYrTjJ2ek9QTTV5N1E5S24xV0d3NDZKQURRZnFQODVXZWFDLzJC?=
 =?utf-8?B?eS9kMjQwQ0JNdGMzRldUTmM5c0xpY3ZHc0xPb2hOZHd4bUp0QTNHWE5ON3Zr?=
 =?utf-8?B?SVd4TytuWTJLdXN1TnRLN09NTXJlaEwzVFRVQUlzOXVGTjlqd0xaYkovUHJX?=
 =?utf-8?B?TDRJYnlPUzdqREYyaUx2NFNaSHZ4Y3NjbHVQaUlKd3B3cGYrd1FiRW05bXNZ?=
 =?utf-8?B?TnlncE9MMkpsa2ZPZWlucmVvdG9zam1VQUNpbTNJbDc4ZjFWOEQxSW5zdHF5?=
 =?utf-8?B?bW1LRTBHVGdqMzhzbWR0RllneVp0RWc0b3FtR2FSMmdYL3M2cWhtcWFBRTZF?=
 =?utf-8?B?OTB4dUlabHpGaGlRelpSOGJXOEc4bk9WVkdJTEUxQVA2ZUxiWlNpd21PVFdM?=
 =?utf-8?B?VUlrTlZDMGh3dGgvRzZvN1VvNS9kZGNYUG9QSTR6cWU4czErUW9Tb1J5NHZQ?=
 =?utf-8?B?Z2VCK1lnRVBEVjMreVlobGM4aHVGcWdFWWhtUU5PVWE0QUtNaEpzUjRzcFNm?=
 =?utf-8?B?Q1E3ZGJjQUZQRmpxREFNNDFEdy9ZSitEWTZXVFZHQ3NCanJya0pMREx1UDhu?=
 =?utf-8?B?SFIxcmtrbGthbUU3cklsQnZvTEhkMTJybEZvbkNxc1lhUVJHRktneU0yYTRF?=
 =?utf-8?B?cHRuWnF3bENiQk40Zld3OHRvL0M4OTMrRlI3ZFhqVWtqSUFwMk5vS1FhUmlw?=
 =?utf-8?B?OUZTbmxRdnNlTnVWeWxPZ3VBOFc5R2xJTk84d3d4QmZKWFlZYnZTSU9XQmE1?=
 =?utf-8?B?Rk5rbHRkNUU1UXpiTlZCbWRaN25GbTlZUVluMXpoTGdSTDRFTGhWZ0RVdU8z?=
 =?utf-8?B?VzhPcUREQUFCbVhycmh6SFdhclZRMVZWUkJDcXVkRUZBb0twTU9QSUh2L1Vr?=
 =?utf-8?Q?fbGcHP72U/iHcCM+nGl1QKAWB4LiJNPJd9e0kQDaVwOd3?=
x-ms-exchange-antispam-messagedata-1: 82p1KygMRtcjIQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A55AEF1D06F31B45805152D5F8CCDB11@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e8db38-4ac9-4b1a-0f91-08de7959cb31
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 19:19:30.1066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QgQEj6p7QMsxTomwz3nK0iEv0E3nN9c+CV4aLFHhA6pQp+o2zWX0fFEdSHujjjbCyEKiBNv1gx1+HqM6wdXZwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842
X-Rspamd-Queue-Id: 874841F5E10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17425-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chaitanyak@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

T24gMy8yLzI2IDAyOjUwLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+PiBhbmQgYmxrX2FkZF90
cmFjZV9ycSgpIHBhdGhzIGFzIHdlbGwuDQo+Pg0KPj4gRml4IGJ5IHdyYXBwaW5nIHRoZSB0cmFj
aW5nX3JlY29yZF9jbWRsaW5lKCkgY2FsbCB3aXRoDQo+PiBwcmVlbXB0X2Rpc2FibGUoKS9wcmVl
bXB0X2VuYWJsZSgpLsKgIFRoaXMgaXMgYSBiZXN0LWVmZm9ydCAicmVjb3JkDQo+PiB0aGUgY29t
bSBzdHJpbmcgZm9yIHRoaXMgUElEIiBvcGVyYXRpb24gYW5kIGJyaWVmbHkgZGlzYWJsaW5nDQo+
PiBwcmVlbXB0aW9uIGFyb3VuZCBpdCBpcyBib3RoIHNhZmUgYW5kIGNvcnJlY3QuDQo+Pg0KPj4g
V2l0aCB0aGlzIHBhdGNoIG5vdyBibGt0ZXN0cyBmb3IgYmxrdHJhY2UgcGFzcyA6LQ0KPj4NCj4+
IGJsa3Rlc3RzIChtYXN0ZXIpICMgLi9jaGVjayBibGt0cmFjZQ0KPj4gYmxrdHJhY2UvMDAxIChi
bGt0cmFjZSB6b25lIG1hbmFnZW1lbnQgY29tbWFuZCB0cmFjaW5nKSBbcGFzc2VkXQ0KPj4gICDC
oCDCoCBydW50aW1lwqAgMy42NTJzwqAgLi4uwqAgMy42NDlzDQo+PiBibGt0cmFjZS8wMDIgKGJs
a3RyYWNlIGZ0cmFjZSBjb3JydXB0aW9uIHdpdGggc3lzZnMgdHJhY2UpIMKgW3Bhc3NlZF0NCj4+
ICAgwqAgwqAgcnVudGltZcKgIDAuNDM3c8KgIC4uLsKgIDAuMzg5cw0KPj4gYmxrdGVzdHMgKG1h
c3RlcikgIw0KPj4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmk8a2No
QG52aWRpYS5jb20+DQo+PiAtLS0NCj4+ICAgwqBrZXJuZWwvdHJhY2UvYmxrdHJhY2UuYyB8IDIg
KysNCj4+ICAgwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2tlcm5lbC90cmFjZS9ibGt0cmFjZS5jIGIva2VybmVsL3RyYWNlL2Jsa3RyYWNlLmMN
Cj4+IGluZGV4IDNiN2MxMDJhNmViMy4uNDg4NTUyMDM2NTgzIDEwMDY0NA0KPj4gLS0tIGEva2Vy
bmVsL3RyYWNlL2Jsa3RyYWNlLmMNCj4+ICsrKyBiL2tlcm5lbC90cmFjZS9ibGt0cmFjZS5jDQo+
PiBAQCAtMzgzLDcgKzM4Myw5IEBAIHN0YXRpYyB2b2lkIF9fYmxrX2FkZF90cmFjZShzdHJ1Y3Qg
YmxrX3RyYWNlICpidCwNCj4+IHNlY3Rvcl90IHNlY3RvciwgaW50IGJ5dGVzLA0KPj4gICDCoCDC
oCDCoGNwdSA9IHJhd19zbXBfcHJvY2Vzc29yX2lkKCk7DQo+Pg0KPj4gICDCoCDCoCDCoGlmIChi
bGtfdHJhY2VyKSB7DQo+PiArwqAgwqAgwqAgwqAgcHJlZW1wdF9kaXNhYmxlX25vdHJhY2UoKTsN
Cj4+ICAgwqAgwqAgwqAgwqAgwqB0cmFjaW5nX3JlY29yZF9jbWRsaW5lKGN1cnJlbnQpOw0KPj4g
K8KgIMKgIMKgIMKgIHByZWVtcHRfZW5hYmxlX25vdHJhY2UoKTsNCj4gVGhlc2UgbGluZXMgbGlr
ZWx5IGJlbG9uZyBpbiB0cmFjaW5nX3JlY29yZF9jbWRsaW5lKCkuDQo+DQo+IFRoYW5rcw0KPg0K
Pj4gICDCoCDCoCDCoCDCoCDCoGJ1ZmZlciA9IGJsa190ci0+YXJyYXlfYnVmZmVyLmJ1ZmZlcjsN
Cj4+ICAgwqAgwqAgwqAgwqAgwqB0cmFjZV9jdHggPSB0cmFjaW5nX2dlbl9jdHhfZmxhZ3MoMCk7
DQo+PiAtLSANCj4+IDIuMzkuNQ0KPj4NClRoYW5rcyBmb3IgdGFraW5nIGEgbG9vayBhdCBpdC4N
Cg0KV2UgbW92ZWQgdGhlIGNhbGwgdHJhY2luZ19yZWNvcmRfY21kbGluZSgpIHNvIHdlIGRvbid0
IGhhdmUgdG8gYWRkDQphYm92ZSBjYWxscyBhbmQgbWVyZ2VkIGZvciBub3csIHNlZSA6LQ0KDQpo
dHRwczovL21hcmMuaW5mby8/bD1saW51eC1ibG9jayZtPTE3NzI0MTM2NzYyMDczNSZ3PTINCg0K
SSdsbCBiZSBoYXBweSB0byBzZW5kIGFib3ZlIHN1Z2dlc3RlZCBwYXRjaCBpZiBuZWVkZWQuDQoN
Ci1jaw0KDQoNCg0KLWNrDQoNCg==

