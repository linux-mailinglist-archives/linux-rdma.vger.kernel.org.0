Return-Path: <linux-rdma+bounces-960-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E484D22D
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 20:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6FC1F22819
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 19:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7308562D;
	Wed,  7 Feb 2024 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="nC/6q8bY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5111584FB4
	for <linux-rdma@vger.kernel.org>; Wed,  7 Feb 2024 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333475; cv=fail; b=Pj9gO6wTt0OCUMKR4Jz0MxNtUrE3+5rWQi12bakE1RGfT5BJzgXVptZEl1CHn3j6PR+ghCSvOq6vPjGyywNbezovK+F2NIK1F+w3gau9FkgLBUN7bS7p6LorDhzzMTXVHXKIDpLQvzqolY3Kylu0DEgz6C/HWZoUP3XTFAzL40U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333475; c=relaxed/simple;
	bh=CclNUNzuMZv6xP9mJRgm8iuMYMeR3ST9pPVJfDueJDY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fldKuv2fk7dk90/9LpIsUDPjCpGjPHNg21Bh2mBZq+iNi0W+gTDr4PxKBLsEjlpBqWn/iW2DyLRz7QTRg6mQKUGLP8MFBFahIGC3ljBZQbvL7R5zLMzvkFHWhf1Ebe0Q4k7e+aDjY5TyA82QIfZ2oh6AkIVtN9OA8NQCFF+udpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=nC/6q8bY; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417IQutA012347
	for <linux-rdma@vger.kernel.org>; Wed, 7 Feb 2024 19:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=CclNUNzuMZv6xP9mJRgm8iuMYMeR3ST9pPVJfDueJDY=;
 b=nC/6q8bYdza61Xm12/toYoXUYauexnkt9zUa/xgzr1vRx267Gacd4JcoB0ullQbe/uEq
 D+YCP4IWu+FlXN+69zVL/3NG5+Jx9Zxz09UZmMHZ4I89wjkjqfrWtnetHngC6rcQY2d+
 mpHO4vpDfUiaY9vflRDOj94IBahbPrVz7Bxw3GEOpLUo4rYj5JY+YEdUNPowH6m6ZOuk
 4w98tqWTDSdQqSKh4GP6fPkhZ335Q3s0j34U5/Rxll+DIY8VPSH0BQGomdQDSXY4csSU
 T62+mHqSVX1EgbO02nfelf+i1YgLtfiQH2TiEY0ogxXyTnu8OYh+TE1TyZh9Dd64RAIX Uw== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3w464fx23t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Wed, 07 Feb 2024 19:17:52 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 05DD7130E0
	for <linux-rdma@vger.kernel.org>; Wed,  7 Feb 2024 19:17:21 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Feb 2024 07:17:10 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 7 Feb 2024 07:17:10 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Feb 2024 07:17:10 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrPQw0f6A/JC8bEBUIICBs/vLDZ/ywnR6u73tzeC8ZWCzkWIgIQO9aPL+28R0kZ1/cK+TdbcZIYWLdY+E9Qowws/WX4AKku7PWBWGscuEqyfAcwPO0ig8zToeljYWwPXEFcWi1VozVGqYOjrhrT3kQ+vtLNkaYzR85TUUiZGb7OebdpEfAjRHMjloUqwlg83zFQ2UHdQooyWs/sfH3WXBySjI7DPax+CeWp4QqLuHNwj5BZyIzmT8KH9nhuRy9p5Tj7xZ0VHiq0fOD3V+1gS1uEZC1Api6EtwsChRsSR/FhlMLe1sXjJynSRFzeoB6Boiy69S5bVyvtvNcH30onyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CclNUNzuMZv6xP9mJRgm8iuMYMeR3ST9pPVJfDueJDY=;
 b=YZxay+JUL6GfTD5h9J2CDxlimsdcHVpid3JAmJwQHtGvDuqoRNC+OtWCv7tORzuVwJQlbiIrp1omXAPkNzjoxMrrTjPRATy9z7Kd6de48Ro9k3LxCmRQedNQdDMpwGB/mzPIOnwSjqDvGIKO3/n1iTj2NCtcTbZJmZE8RiJbIyREFXRHTwVReklTCRkjf55Rmkp37rcuc65zrYSw+Y9SYwEK8blqRexjaMlK+G5rqjLStq7Rkuxid2X+ngFx9soCRB8EgdBI7BzlCHZZPuKtCncVybAb8NfHsMfbw/EIU7m5PvZhdfhUf2uBsaxNa9zzuws6ADI0SbXRnm0plzpK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB1798.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::8)
 by CYXPR84MB3705.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:930:e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 7 Feb
 2024 19:17:02 +0000
Received: from SJ0PR84MB1798.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::62a0:c45e:d36a:cad2]) by SJ0PR84MB1798.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::62a0:c45e:d36a:cad2%5]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 19:17:02 +0000
From: "Rehm, Kevan" <kevan.rehm@hpe.com>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Segfault in mlx5 driver on infiniband after application fork
Thread-Topic: Segfault in mlx5 driver on infiniband after application fork
Thread-Index: AQHaWfo6y2D65uYlUkSBtikbBgXU1Q==
Date: Wed, 7 Feb 2024 19:17:01 +0000
Message-ID: <E25C1D96-0FBF-44AB-A5B5-71CDA49E73D1@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.81.24012814
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB1798:EE_|CYXPR84MB3705:EE_
x-ms-office365-filtering-correlation-id: f97c9b98-b554-4dd4-e7c3-08dc28115cd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lbflrdh0bEmNu5cFsdDKNeimvLoLDw+ka6id/Px09Q8DPNg7cZRzui8NaeSvCFT1KvmDIugVPir+Rbw+pkNH7lT+Mb0kqPGjmc1hdxnL4SZr6yjQ0QzoN+zjNQymlJkof8KQoHSkbsnf+EgI+CZQiqibPMO60a9tgX+dwIVSzGLYMYDTIbF6Cws4K4nqrIpyRt4yQ2P8nUj57NOOmqMg7QTAx9iqscY3BkUoLteLhEVMSgDhMV2tpclDLONrmOd3d/ITNlXA5ek2fP1D+PJ6Q0x5AHBVdBlXSy6mxNrTYt8na0vUlRZmfFsXnehPl4iujdss4O/lUrUKNi5O5/7KleNNYue+VLYOaI0IOFkvRv9UFFggAyyLmH6A7lMwtWFdqWZi0RUqjmqHet6nUzAs7Fy7s1BsfR9Ze9M271dCHAnuB/FQWHLZ1Jsqkko/j4GSgE8z37+nXZWnjYQ4fZvzu6/abPkmxVE2eXIvlBjxB2xZ59YJRiKfK2zOIWuN9+ceUC7n7frrP8+lD/EDV4Jajd00s7hrED6/CEk4nB2oF4R0uWskofbYdDIHgzPJIGUURMK/LvqtGA0sqh1ss058+vo9lrN7HXe6+PoKdDa7+TisnLcmIDTCOL7KRy8dPuXk44Leeh4O5dLOv0ofCPwhHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB1798.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(82960400001)(36756003)(6486002)(76116006)(478600001)(66946007)(55236004)(33656002)(6506007)(66556008)(66476007)(66446008)(64756008)(71200400001)(6916009)(8676002)(8936002)(316002)(38070700009)(6512007)(122000001)(26005)(86362001)(2616005)(38100700002)(83380400001)(5660300002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWlQZGhVZ09oVC9BUzRGaXFSdjR5N1F5eE14WlE1RWRJU0JiSWl2cmJYSTVq?=
 =?utf-8?B?ODY5NEJ5eXlXYzN4KzIwZmEyTWJYeERJbjMwMVptK3NNaDR1SUdmeEZIS3No?=
 =?utf-8?B?YWNoT2xya1hlUGZCanE1SDBYQzF4WUtZK2oxb0JIazRTeFZSVEpsbTE4eXc2?=
 =?utf-8?B?RXNndmUzL1dHRVVWS2UrcU1jSkxXRGFyWGpGL28zYkYxUlBkNjlwa003MHZM?=
 =?utf-8?B?RmVBMm5ic0FMbk1EUTJRVkoya0V6bVBwQ2Qvc2ZyL3p4ZFVOQlNpZm5LRHFi?=
 =?utf-8?B?WjJtNCtrdEhWVlJpL0RwRUk3YmJwRlVBSFVwOXN4cjYzSFhhUHJGek5HbWZV?=
 =?utf-8?B?ZVBWdExaemtKT1ZzQTdzYXhYczBtTHJzc1B1b1Y3dzRPYnI3bXVNajhMVFdW?=
 =?utf-8?B?R3J6SVA5cVU3STdJcDljMkE2azJNM3dzWUI3NDlBcTd5cDJ6aGpqN0hJam1i?=
 =?utf-8?B?ekVka0pXekEvSTdtZmZuUHdvWXA5aXQ2QWpQMEtuT1ZkaU5GSUUyZndzR2dy?=
 =?utf-8?B?N0NzMi9CTnNER1lVM0xHekFGaWVPS2NFOUtMTTNyajhJSzd6ZUpraDRXa1cr?=
 =?utf-8?B?RFhENFhpRVNDWTg0WVpybUdFZzBjbU55RkcwREE3NHRSUDJQRzRldG1JVzVp?=
 =?utf-8?B?ZmhHZUE1RnpFQ2o1dVY0dnQ5MWhubUNvZkNUOFhFWnN2YS92T2pYR2hMSzZZ?=
 =?utf-8?B?VXpTMzliUGNEWVh5OE5kR3U0UnFicCtsZzV6UEZKcHZUVWhxaHZpZjdscDBF?=
 =?utf-8?B?Zkg0ZHUvS1NGNHZ1S2M2RjUzN0dmbEpxRVM0N0lHb2Fna1FwamNramZ2OXNI?=
 =?utf-8?B?TzYvRjUzVlhLTWFqS3RkVVp0RlNzV25tQWEzcVZIZ1J6L2k2MVFkTFlhV056?=
 =?utf-8?B?WEpTRTR0SzMwQWVCWkNFTUVER1BTczZNcStQSkk1emR4SFRUYnVzaDdaWEdC?=
 =?utf-8?B?Z2FsNmxCRzI0emh1aGZ4TGU2ME8ySHVhRlZsS05jRWYxT1NEUFRCZjBHMzZX?=
 =?utf-8?B?eStrbXpyZVg4NytOYjgwQWxyeGowdUpQYUN3WnpzbEMvVnRjbjZxNzNBem9W?=
 =?utf-8?B?U3NVTWtUNjJ4ZE8vVlNnZ1VQYjNkSmhmSzYxRXFWcTdHeElURytBbDdmRzRq?=
 =?utf-8?B?Q2ZBVk45MkYzYVI3WEVmQnUvZ0k4a2xaVW4xRnZEQXViM3NmcFdubnllcHJ0?=
 =?utf-8?B?N0JrQVZ6aitQRTduSFU5dHk3RHN2Q0F1NGdDVFhaNDU5Mmx0K0Y5WXR6bG10?=
 =?utf-8?B?bW9kREZKNjJxaS9lZG5jVmp0RWg5cUtDLzJBQ200SHAyYkxlR1UxYVVrMEJr?=
 =?utf-8?B?T3luRThQcW16dWpDZ0tHTHh0WVlTMXRjaEhkMlV0WDBiVFNTWDc3bS9yZy84?=
 =?utf-8?B?cWxtVTgxblBoR2lXbnlZVzc0bjJpZWVvV3piNGxUMUJJRUh2U3NWazFTTS9H?=
 =?utf-8?B?blVVelRDNEhVOHFnWkhRZzlwNDN6aU5JeC82QWtjREpleS93dzJzdkZTUXVV?=
 =?utf-8?B?TGR1MFEwb0VqV3FzMDd2S3d3b2VTVSsrTXFPNmhuMWxQdkpIdkFsbkdVYmVI?=
 =?utf-8?B?U0ZyZUdSb2UyZ1UyWTVFVHp5MUhWWFhuRE9nNWIzdnF2SEpZWGZuR08xeUlw?=
 =?utf-8?B?TjdNR2pkbTltc3oyNGgvdlovSXJSb1FRT2xpaHJsRXBLWHY5VXJDc3FNRnlQ?=
 =?utf-8?B?c1JxWkRFZ3N2WUR1WDdOcGRpWDRhajNPTzhoeDNUN3V1TlFnSEJ0VVlHYnJD?=
 =?utf-8?B?U0hva1B0alVxQXExaU1uS0ZZeGkwbUd4dzlPUVZ4VXlWNUcvZEViMTFCNFdR?=
 =?utf-8?B?dE5ROEdWM2RjU0hqYnlWbW5wREl0cTBMOUNkKy9XaGRoT09PYnRrSWZxMHRq?=
 =?utf-8?B?WEk0eVp0WnNUbEtyczVCOXdkQ09XOTRNMkc5Zko0N2pIMGJkQWFQbHJINER3?=
 =?utf-8?B?c210cVM3WVZWbm1DSHBHOW1yL3RzblN4NjNYYURDZXlQVEhaWGcxanBsbnhD?=
 =?utf-8?B?R09Gc3dJM0hjK1VUQnRsVXczMzFTLy9hY2ptLzVzRkJRMkwremd0RFNzRjNw?=
 =?utf-8?B?dXR6RFJWZjRPdHFsNkhQK1QzVEFXaTIzdHJ2YXA1VnpabjdSYWd0U0xIOWgv?=
 =?utf-8?Q?N1G9ayaOp0rXLGTkfxSWcJsGr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C806BAFF758A3E40BCA36A5DC476D676@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB1798.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f97c9b98-b554-4dd4-e7c3-08dc28115cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 19:17:01.6178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b/kpMw3ecTgOa4Tw1VPjwF+SgYSnTLBOJrRc4HZVbSo/MUiZvVsp3o4kgctAYdnvBgdWDZZ4pBi1sQpSM7pEjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR84MB3705
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: wWVDOaOxWIe2cqwCHwwX8CiKfvZfcqQG
X-Proofpoint-GUID: wWVDOaOxWIe2cqwCHwwX8CiKfvZfcqQG
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=804 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070143

R3JlZXRpbmdzLA0KIA0KSSBkb27igJl0IHNlZSBhIHdheSB0byBvcGVuIGEgdGlja2V0IGF0IHJk
bWEtY29yZTsgaXQgd2FzIHN1Z2dlc3RlZCB0aGF0IEkgc2VuZCB0aGlzIGVtYWlsIGluc3RlYWQu
DQogDQpJIGhhdmUgYmVlbiBjaGFzaW5nIGEgcHJvYmxlbSBpbiByZG1hLWNvcmUtNDcuMS4gICBP
cmlnaW5hbGx5LCBJIG9wZW5lZCBhIHRpY2tldCBpbiBsaWJmYWJyaWMsIGJ1dCBpdCB3YXMgcG9p
bnRlZCBvdXQgdGhhdCBtbHg1IGlzIG5vdCBwYXJ0IG9mIGxpYmZhYnJpYy4gICBGdWxsIGRlc2Ny
aXB0aW9uIG9mIHRoZSBwcm9ibGVtIHBsdXMgZGVidWcgbm90ZXMgYXJlIGRvY3VtZW50ZWQgYXQg
dGhlIGdpdGh1YiByZXBvc2l0b3J5IGZvciBsaWJmYWJyaWMsIHNlZSBpc3N1ZSA5NzkyLCBwbGVh
c2UgaGF2ZSBhIGxvb2sgdGhlcmUgcmF0aGVyIHRoYW4gcmVwZWF0aW5nIGFsbCBvZiB0aGUgYmFj
a2dyb3VuZCBpbmZvcm1hdGlvbiBpbiB0aGlzIGVtYWlsLg0KIA0KQW4gYXBwbGljYXRpb24gc3Rh
cnRlZCBieSBweXRvcmNoIGRvZXMgYSBmb3JrLCB0aGVuIHRoZSBjaGlsZCBwcm9jZXNzIGF0dGVt
cHRzIHRvIHVzZSBsaWJmYWJyaWMgdG8gb3BlbiBhIG5ldyBEQU9TIGluZmluaWJhbmQgZW5kcG9p
bnQuICAgIFRoZSBvcmlnaW5hbCBlbmRwb2ludCBpcyBvd25lZCBhbmQgc3RpbGwgaW4gdXNlIGJ5
IHRoZSBwYXJlbnQgcHJvY2Vzcy4gDQogDQpXaGVuIHRoZSBwYXJlbnQgcHJvY2VzcyBjcmVhdGVk
IHRoZSBlbmRwb2ludCAoZmlfZmFicmljLCBmaV9kb21haW4sIGZpX2VuZHBvaW50IGNhbGxzKSwg
dGhlIG1seDUgZHJpdmVyIGFsbG9jYXRlZCBtZW1vcnkgcGFnZXMgZm9yIHVzZSBpbiBTUlEgY3Jl
YXRpb24sIGFuZCBpc3N1ZWQgYSBtYWR2aXNlIHRvIHNheSB0aGF0IHRoZSBwYWdlcyBhcmUgRE9O
VEZPUksuICBUaGVzZSBwYWdlcyBhcmUgYXNzb2NpYXRlZCB3aXRoIHRoZSBkb21haW7igJlzIGli
dl9kZXZpY2Ugd2hpY2ggaXMgY2FjaGVkIGluIHRoZSBkcml2ZXIuICAgQWZ0ZXIgdGhlIGZvcmsg
d2hlbiB0aGUgY2hpbGQgcHJvY2VzcyBjYWxscyBmaV9kb21haW4gZm9yIGl0cyBuZXcgZW5kcG9p
bnQsIGl0IGdldHMgdGhlIGlidl9kZXZpY2UgdGhhdCB3YXMgY2FjaGVkIGF0IHRoZSB0aW1lIGl0
IHdhcyBjcmVhdGVkIGJ5IHRoZSBwYXJlbnQuICAgVGhlIGNoaWxkIHByb2Nlc3MgaW1tZWRpYXRl
bHkgc2VnZmF1bHRzIHdoZW4gdHJ5aW5nIHRvIGNyZWF0ZSBhIFNSUSwgYmVjYXVzZSB0aGUgcGFn
ZXMgYXNzb2NpYXRlZCB3aXRoIHRoYXQgaWJ2X2RldmljZSBhcmUgbm90IGluIHRoZSBjaGlsZOKA
mXMgbWVtb3J5LiAgVGhlcmUgZG9lc27igJl0IGFwcGVhciB0byBiZSBhbnkgd2F5IGZvciBhIGNo
aWxkIHByb2Nlc3MgdG8gY3JlYXRlIGEgZnJlc2ggZW5kcG9pbnQgYmVjYXVzZSBvZiB0aGUgY2Fj
aGluZyBiZWluZyBkb25lIGZvciBpYnZfZGV2aWNlcy4NCiANCklzIHRoaXMgdGhlIHByb3BlciB3
YXkgdG8g4oCcb3BlbiBhIHRpY2tldOKAnSBhZ2FpbnN0IHJkbWEtY29yZT8NCiANClJlZ2FyZHMs
IEtldmFuDQoNCg0KDQo=

