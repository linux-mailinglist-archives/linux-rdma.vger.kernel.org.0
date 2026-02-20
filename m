Return-Path: <linux-rdma+bounces-17038-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id G04DL4KsmGlSKwMAu9opvQ
	(envelope-from <linux-rdma+bounces-17038-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 19:48:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C5916A2CC
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 19:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86888302E93D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 18:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52796315D35;
	Fri, 20 Feb 2026 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Ce5X/8MW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020129.outbound.protection.outlook.com [52.101.61.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38F22DFA5
	for <linux-rdma@vger.kernel.org>; Fri, 20 Feb 2026 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771613310; cv=fail; b=qakN8NFO6XMtmU2hN0VgCDSkXAPEMJOHCAs54XugURvtf6CRwa6GunAl64OLw1by3MRiP5F21Sy63gmYJ4nTnKZgXoM1Zm7tAr4BPbPbvO8pS6xNJoRl/PzsC/JR2KKVztwPYFuQwiaXFDod8lL46DIg1deMheGPpXN24EAu1XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771613310; c=relaxed/simple;
	bh=z1Qx8nwiEwigNvehA1xHqGFsaiQSZ+cTOJYkqHtV/Kw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fIvV3vGzrRjz1GKLgq58aRpQdqlVZkM+H7Pid7h2yREvj97ptRF+cZm5abUXg0/5QrNte90bkZRabpB+gb4V7a5GQ+Stz1C8gQSj3IiG2Y+7P99EK495lNCfsTfeRz26EJoOzX9Ve3C2OrTTPiZyUpyqIlykLTDM2ITKAsKpFF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Ce5X/8MW; arc=fail smtp.client-ip=52.101.61.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReW6ynOm2dyEBrU9fm17+M1vit8veDwPEaq4YgJdXREl5V0h7lOaPAPUHtPRtTCmzD2/FggYjun55K7oLWgHEKsHzQkDHsMfOEFl/e0MopN9H/9LfFe9Ohcp2UG7ceynyCJQ5wiyo9uN8R6w4KfgHrfS619AIazRSjQhPxOJXgx6Bz73HwKE6TNjmiklPhF8AcwcB8q6C65+BmFWOOilhOirgyMcPp//c2SKnI1ph5T4SIW7ILpuTaiVL22IYaXJum7a5jXRxroMrCuQxPWqdY1myXZ+6TOktNK9NKMP5P3ULdgV96HZhRqOT0lQHv4bnsY6D/208NXw5QUJGnXMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlggU61LjwnZpQckEt0FPMyGVvfcWkILcXneLAAPRg0=;
 b=s6q97QQQX4ACrh4P2Nd29vkb7HtqlRVCILH1fS5QT9NouzCgJ61UMXQd8gujFibT4HNwDBmLY2UldAa1ZXPMQz2SSJeWhwj3Sg3jBXOMRVb6kaZsKnNGMeW+1QADOmc7vM6xSr5R4TJgu0lTXbhXemAOIqrfVOrWQyvxCNEQPGFmzBGL5u+DWXkmrWlt83dDTFvLVdXtkVUObSbamP1PNVpqmcdKiOWF7xHa+sx1EAvHC1KLbGz+2gpqw/ybZtCyEQZcwOVr7tTidHoEkTDi4Of8B1wNssVpMvdMzL811OW6zHxGLI8N6JxiMkkWkD4eHkyXRBecAWb5RzkhYM9FnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlggU61LjwnZpQckEt0FPMyGVvfcWkILcXneLAAPRg0=;
 b=Ce5X/8MWdSTs7k82dlGhedZFaE/CwNCksjkbT24/TtOY1ouXApbKA+CR5hB14qm1B+sR7O9V8OCl39yNyRQ4sfVeCYhjRDcAVy7pzEz4o1xBOfZARSS2p1WAtEtsKe8Ac4ApwE2b+URioLUCDHCDpMOtxzCus4XK6vxQ2QnCDaS0Trx0gHdGA7uFOsXoYMnBRakwIjmfpRdXrpRpGJsJc0xcA3WxgqW6jxa/I5hFtHu5SbKBtA1DH9nZNuJzowIUUDtWQAv1A4OQcAXDLxMaOOD1k+Xh1pD+fYcymn1NhFv9lo3KEb9NcbOeiietH8bPmUUhrbzeQF2h5IhWZfdkCg==
Received: from LV2PR01MB994099.prod.exchangelabs.com (2603:10b6:408:34f::11)
 by MW6PR01MB8366.prod.exchangelabs.com (2603:10b6:303:24a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.16; Fri, 20 Feb 2026 18:48:21 +0000
Received: from LV2PR01MB994099.prod.exchangelabs.com
 ([fe80::2af:c9b3:39d5:9ae6]) by LV2PR01MB994099.prod.exchangelabs.com
 ([fe80::2af:c9b3:39d5:9ae6%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 18:48:21 +0000
From: "Hebenstreit, Michael" <michael.hebenstreit@cornelisnetworks.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: problem with duplicate resends
Thread-Topic: problem with duplicate resends
Thread-Index: AdyillY4tQD1L1e4R3uzVVjHaf5+AA==
Date: Fri, 20 Feb 2026 18:48:21 +0000
Message-ID:
 <LV2PR01MB9940993E9E56B23CEF734AC4909B68A@LV2PR01MB994099.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR01MB994099:EE_|MW6PR01MB8366:EE_
x-ms-office365-filtering-correlation-id: e4ed0bdb-e3f1-40fa-d5b1-08de70b09edb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?d1cljuvNaSadmlAB/A4ba4SYSHmclIB/lwdbHd4+UlHzJa+h856qnz9scC?=
 =?iso-8859-1?Q?F6bZicU8kSSm3zbPmyx3TqhlyE/Y/Hm+iZ4KxH1oWExA+MtdCy9hmzkwIz?=
 =?iso-8859-1?Q?CS4X1MYfr1t3ik1nQatOlfu8wfS6y1hnSbVvWQE19r5j6+SLqt+uionco4?=
 =?iso-8859-1?Q?7p3m+NlzAJ5aXwpL2M5aDK+fmZPrB0smGwa18XrQsRZS7YBN6fb4cxTsQ2?=
 =?iso-8859-1?Q?kQEeqZV9goZ3l9N1Musp39ciqbUYhKE8oJ1zQY6xKKIzS95GYfO3ODEZUt?=
 =?iso-8859-1?Q?v6ZnRFblKYPo9JJs4hzSA7NTMo66twQgkeNHNxMmdUT/P/tfWlaiCUlg/e?=
 =?iso-8859-1?Q?qiqO76QVOL4biHvHsH/Lx93BpPfzKJ9T4GvN7JDgASICskfDbtDSPMJaWW?=
 =?iso-8859-1?Q?kCAahAVE/0fv3RyXD0mYE5/UpeYbYcCqcdC3nh/1h62FX2DR0Y/2Xc3yfZ?=
 =?iso-8859-1?Q?ilXfAxHzWfinlDoPlA56JmB7h//m0BZZ/5ruIOsPDGdHDHKrZeTRoDSNLV?=
 =?iso-8859-1?Q?8flrC8gbo0LkXQV2Z1oZ1ajpQG6PiRXOFtD40I6La6a/dOQFeSPkjbhTeL?=
 =?iso-8859-1?Q?w+GruRCkBxMPfg+QCnmoKFt0lHhTZQn0QcdClpqzln3vhdAORFqb/NdPSa?=
 =?iso-8859-1?Q?Wgz5SU7BYBDReQIGWWuvCk9cK5gLGgSWOFjlhjetOMHUVfiP78+khXfizQ?=
 =?iso-8859-1?Q?1gPXk/C+gwNPtmN7wv2/YyrUslGsZUZsRETek0lg07HXCv4yB4pqFhwG0O?=
 =?iso-8859-1?Q?fCsFDrrFeCHDCWNVjqZ+CJYCgfsuQIuM2Z83a5qLxuz/nxPbvefVM7Xhcd?=
 =?iso-8859-1?Q?xJY7jbkyicp8vtiq+OVhCJ1gZ6jq+iNV2Pns1hbjBV7wLGpIn0AYN26jZl?=
 =?iso-8859-1?Q?OFZz9y+ayFi/iGJckbxNb5IsK7y10eSW8cAlX/KZgxLxtxI4rxm8F5uNVV?=
 =?iso-8859-1?Q?F7niTK2KGyOsechwtbilik8n9mzc5XXBpPl1ALBBZJZ8tSkmJNhVG65oFk?=
 =?iso-8859-1?Q?pIv2XU4i/E7aW/aWcBkr0JjgH+LFyodCB3lQzdIa5NWwzpiKJhS+12ytdf?=
 =?iso-8859-1?Q?T8hSN8iwBGnVW89wdQvbzF4EiD07BUrGB3fAAa2kFbl7aTX7TgQb5SHl3Q?=
 =?iso-8859-1?Q?UsI3C9DPx5/VLYRaFQZyZ1vWsOADzZna87CK+Lv0K1/XQR80FwI/rrHcl0?=
 =?iso-8859-1?Q?ef8AMGctvOsfBSzwMosEPdxFKR+NZfSjZy795tgeuoCFPRcmTtYNOALwBK?=
 =?iso-8859-1?Q?9IgTQ3wyQYX6UvlShw8KbP3LOeOuLnhfuIgxtA2Ewiga0BHnn9NbXtx3eP?=
 =?iso-8859-1?Q?dxq6+if/kL9/foPma4mlZKqFhSjPLa0RXCqFTvjWcuLV+g4aAIGZQJo6mT?=
 =?iso-8859-1?Q?/0soi+PoZv69hb+olwHJMsMh2Tv7eR+ZZxalxDCV/gVjHNnCeWp5c+jisI?=
 =?iso-8859-1?Q?UR+DrubYuPln6iiV8WkoPHjWcBvf/sPmKhgKaVZNVoIM0vWt5byAXxM8a9?=
 =?iso-8859-1?Q?NNo+O277uyzIS4mlznj2CtEtdIP4ry+Wcz3aCrrU+TK1IxPLCmHASoUemr?=
 =?iso-8859-1?Q?EulfVmQe8KN+YCWTB1nFJ29pykrzc+Dl//klFQwpYesGOdW5Xhnp0/cdwr?=
 =?iso-8859-1?Q?rHCBDqxWE1flBTrFoVnJ1mTMk8WuRjn2AjiVILgnVhVOctqFauWVOPyfY+?=
 =?iso-8859-1?Q?NdiiOfMfNZsejXgwdpo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR01MB994099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bvkKTHUCsnmVoddDxm7XPjAitsyJIYPvvi4aMU6pR5VdSgwCd+DybJGrsT?=
 =?iso-8859-1?Q?UpWuVVIP7ztqOBNyj31wH3OGuNXU1SO5EqnHRVTOvfRIukJlxJ6I2Hx97e?=
 =?iso-8859-1?Q?SCUrMfEvjbPKB0IFaJI1gBt90wrPQZ/mcBC5uaKIlVkGxc/VgSopy4ROkx?=
 =?iso-8859-1?Q?hk2iRex3ExrNFwa71xXitJzctBODqthrPZRdjVApbpt7JPAcPVY6ddqlqV?=
 =?iso-8859-1?Q?L+OMVZUIawbJAaY2FdKbNycXDPJZcnGr6ufz+fc79QzsJi+j+GMWZnUBde?=
 =?iso-8859-1?Q?TxNs2+bjcD3ol00V0409wYl9wgX9Xwsj4N5/OM+5M2cs48lrNwCjVVNFxq?=
 =?iso-8859-1?Q?mdiFOMTUuulXLWkY7xBUw5zEA133CllCUkaN9IV8QWHUPpp6yLf+veZMLM?=
 =?iso-8859-1?Q?IpUX8D8G/a2EgAAG1/raa8erfumLi+kfkUI4o56Sdw6c2Nxj1YZ+DaoyCx?=
 =?iso-8859-1?Q?1WQt2H8/Nh9tmOHLfFKIjVRrPTYQJd5+xvBHt5igl6NUS71ih0i+ZFaD0q?=
 =?iso-8859-1?Q?zucLxWC5s0cu3RB7iwqusZN8ywYzO/1IoLqj05/Dyt324PcQtj6Wipsy1r?=
 =?iso-8859-1?Q?PoCouBwCO2CwdBRDbiqMPhADn7hUzrhgR2U8Q6y+ulXKe9vSzw/nLVnxJ6?=
 =?iso-8859-1?Q?9GfkhTloEF7kPHij1fJsqs86xyVLAtsZp4og69aQtuACjRHXzhI8GUUWvA?=
 =?iso-8859-1?Q?SUFnjS5jd0T3pyxtwZLH0gXtXxpscGaflaNO46XncpRaAQm747MoD1VlJH?=
 =?iso-8859-1?Q?5q0t6XkwLlsaARteFlIRCAX3Bnt7BN79rUsQvC0mZgx8qfd7TUd9kYzZsl?=
 =?iso-8859-1?Q?gxsqg/Sv1hTMwOi8R0penL5Ox1Q52cp3BLRIIXnGyKp4AZweM1oqARUGwl?=
 =?iso-8859-1?Q?PYRW4ZU+Je336KoiGpAgMnFL6aPQ8PewUTFc91/DLwqcrYm4vOOEnhy6MK?=
 =?iso-8859-1?Q?+UDIQqBOCFFG0gdvp0mkz+7d2Qh91+b24uxVSuFAcqNy/ATJ6mu076ZUPE?=
 =?iso-8859-1?Q?4v9Rr27nTwS1+zBmq8GN50oMeh9OIv6wxtieb15atGzRxSwro8N0gc5rBk?=
 =?iso-8859-1?Q?wEUtMBmwd+kn+NTEHgqOkienWcqHwg3E4v8WwH3SiUv7VfilINpc+bW5HQ?=
 =?iso-8859-1?Q?UhPdlijHZxL4Pz6gyQTMX3PL32Cb6bvRfE+ghm8hKsj6Q07Nyz3hAe2/St?=
 =?iso-8859-1?Q?x1oKiOeUM+yCOk/JpK8t18urZhbcnHHQyaC+b6WAR+W7sgzAnBwJUoYMKu?=
 =?iso-8859-1?Q?78yE7gRrkR5aYfK4gsDjl7pt81e9RBLOLoNOl9d+wxfAFBUdhEmmzFu4Kw?=
 =?iso-8859-1?Q?t3oROieiTsn3kQXUYiTS1J7xdzMVm51GmVhyp5MJ0h0cvjv1lF2AP3trU9?=
 =?iso-8859-1?Q?xNjmGTkqRY+YnSuW5bLUsn479GOlu1PjdLnQhD1/KTgH56CWZRYeEqgtPa?=
 =?iso-8859-1?Q?7nLTzbvmbl60CU19KuLMW2TiBzViTVGSZp/KCISMaagbQTgFdDVSEGu0m3?=
 =?iso-8859-1?Q?nVjKsnGrSNK8amfJZux36VzcNPQebPVwkhxGx65gm0o+Bnv0SSNBP2W/KU?=
 =?iso-8859-1?Q?9IdxWdDZ6HFfK8GjquCCCFDmvBYZBT47U1lZAb6A1Kd7hcAVClFxpf+Tje?=
 =?iso-8859-1?Q?MvW7Pcqac8W8nLxw66QBk2PSYGhqIhWWaEMlF3No603eyJvH2ztoES9kWi?=
 =?iso-8859-1?Q?2aNjl0EnH8Gob9WSGcYC0DmBo+2NEi6r0EpPG6i0rxAHWMqu7cLokx7ijg?=
 =?iso-8859-1?Q?y1FrY5hS9OSms7/7K9MnNQcHkn+p+utVt7WU5xBU+8TAUjmRhd5YSSB8Ue?=
 =?iso-8859-1?Q?2mEHHTr2CWGJORpd+bvzdDOm7URzP24=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR01MB994099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ed0bdb-e3f1-40fa-d5b1-08de70b09edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 18:48:21.4536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVsACmYtoBc6JYcoedEO6PPKqXEPcbxh9qJo+RahA7YI1Zx7rA+9u17wrIx7Y74DC3x6i/ex9IrkA/ybp87LEBdBv3sRFsP1y05eOohVNC9ukBHnbhRgdoVP8QjWd5dq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8366
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-17038-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.hebenstreit@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14C5916A2CC
X-Rspamd-Action: no action

Hello

We have a problem in a Linux cluster using Omnipath 100 and GPFS. Typically=
, after a complete reboot the cluster works correctly for 10-14 days. Then =
problems start, happening about once ever 2-3 days. This makes the problem =
very hard to debug.

The problem starts with one or more storage nodes (A, B, C...) being unable=
 to write to a "bad" storage node X. A/B/C/... would then throw an IBV_WC_R=
ETRY_EXC_ERR error and close the QP pair. In response NodeX would also clos=
e the connection. Afterwards GPFS cannot re-establish a new connection fast=
 enough and everything goes south until the NodeX is rebooted. GPFS is NOT =
my question here though.

During the last crash thanks to a new monitoring system, we discovered that=
 NodeA/B/C/.. would execute 6 RDMA retries and accordingly the RcResend cou=
nters on the hfi1 driver would go up. But on NodeX the RcDupRew counter wou=
ld go up in step with all the RcResends. That indicates the resends are inc=
orrect and had already been previously acknowledged.

The operating system is RedHat EL 8.10 with a very old rdma-core version 48=
.

My question - is there any known bug in libibverbs/libhfi1verbs-rdmav34 tha=
t could explain this behavior?

Thanks
Michael

---------------------------------------------------------------------------=
---
Michael Hebenstreit         Principal Performance Engineer
Cornelis Networks           Performance Team
Tel.:+1-385-393-5444        E-mail: michael.hebenstreit@cornelisnetworks.co=
m

External recipient

