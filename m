Return-Path: <linux-rdma+bounces-1388-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D38878172
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 15:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C9AC1C2157A
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A193FB95;
	Mon, 11 Mar 2024 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YgJwbZiO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874FB22079;
	Mon, 11 Mar 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710166460; cv=fail; b=UlPt0AL5PnvbUwWDzJ1sLiD5oFsFoeoRHwyQbO7SbQZKxCWk/lDx51Yt8kd29qhgdsnm/3EdTCaJgUDm/oJpiYquBMQAPU2MCkhOELow9FJ0txpjy1GyWIBscS4s9pXj845a8jM4P9XWkzbSfU4KTteno61RwTtj1AlomLHqiJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710166460; c=relaxed/simple;
	bh=9vJ5t413Q6ZU2ASPdtbkVwb8gYPZHI7SHkDKGYLh3GI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=C9ETOA6+QpT0XF4J8d1OLBY9+XjWNKRHVcNi8Gqutkx3jAmNfaHc76TwcEo/r67IprWpDGpEji+qby7bIczXphdgXHVhu6+bHhUDDftHi+ncKjRrHBN/oj8dJczZ0/xC4unZPDXfad7JD3pP1BCnYytRx8WsFvZjj5AgRm6rBYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YgJwbZiO; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BE2gd3024599;
	Mon, 11 Mar 2024 14:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=9vJ5t413Q6ZU2ASPdtbkVwb8gYPZHI7SHkDKGYLh3GI=;
 b=YgJwbZiOuGrDA8PJTsOkVE0tOg7dKEHq2+YZKXhJtjjctZ9APl9+VA/V2KrrB9zHQNSc
 ri+5vPpKO/MlYlc811qBhQfLRf5qbxefAUi7IrljwvQuJq75llPbOzI6bp/AHphK3uJ2
 Ity7hJNzEuuURIp/ayB4g21MtDmGx0XQJy9tI3t+q5249mjCuZAyeU+lx8o+hFjUx1QF
 EF8FtkHDLcbooFO/eJeJJxXV+lt/9hM5kyI2dTNpM7A6RDUa0kvhtqVHm5qa8x4eCTwf
 /SNs9fjRi4TPsi1aybxu2cbkwOxeld87Y7bJGjf+ycoZIHGpZqEWq8a1KfGCqZBhoMVT nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt3c7g9t6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 14:14:13 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BE45Dn029809;
	Mon, 11 Mar 2024 14:14:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt3c7g9sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 14:14:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmrXfN/5Fuf6TMDezbJX+Ka9w+WxMGK+eTQ31QWyJpp4YyXcPfqy5YoG5ozQvICMAJ2qmkQf27v7J3j/qZdkBfT2ct0cHr8jkFCC/NH+oJ9r7WhXt8Cg9ln0rkWLZnVbZHXrSSEozxRC+JzUnd60sOW5ZbkZevzYnLQ7s5uB0YIatdppMbJNi1o0UXhQcQ8I+B8VuR09LG9v28sgTpYmAIIw87Mr/DMr/Z8LjC0ew3D/qCS5cCtDzYurPGt8zIgocsgtI5Q04mRUN8x71H91Bvc6mJkchAfN2C7ucLCga+N+K16jCfvfEfVkPEBR83meDWLSgPpQOC2n/id3SEW1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vJ5t413Q6ZU2ASPdtbkVwb8gYPZHI7SHkDKGYLh3GI=;
 b=GgzB5F4R8iax4nGC+MHeqziG08XwtRMZaWVYP+HlEKxq9oqGuG2mqsPKEuobDGHWYgBhd+pUN/sjdOtmsXaLxeyQQH6jdaBXifqsX+vauCUzcA5UYytc9dKy9D44qAjNBSiBLqwo2kkrtgaoCgvlkappYMElUqfubusMYsgL6cwTeagWt4GAKw2ah79laCt9eyYeeZx10Sm6aCHAloTMtjCIuPVSrWlPfrBVe4izeatoM6jlVkwj8NpVsGcfG92L4/EbT4kxlYjOPrz37i+BzVnHIF5GWR8kR8EEGEMa1o3+VQclM3CVJcTmAWmTH5pQ0uK40gfDgLwEIjRen53kdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB3208.namprd15.prod.outlook.com (2603:10b6:a03:10c::13)
 by SA1PR15MB5047.namprd15.prod.outlook.com (2603:10b6:806:1da::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 14:14:10 +0000
Received: from BYAPR15MB3208.namprd15.prod.outlook.com
 ([fe80::a482:99c6:5e9d:e560]) by BYAPR15MB3208.namprd15.prod.outlook.com
 ([fe80::a482:99c6:5e9d:e560%4]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 14:14:09 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: linke li <lilinke99@qq.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] RDMA/siw: Reuse value read using READ_ONCE
 instead of re-reading it
Thread-Index: AQHach13aXbUy+IdAE6aHBqKSSZ2zrEyeAoA
Date: Mon, 11 Mar 2024 14:14:09 +0000
Message-ID: 
 <BYAPR15MB32080B7AA8255352C1F691A199242@BYAPR15MB3208.namprd15.prod.outlook.com>
References: <tencent_32C3AEB0599DF0A0010A862439636CDA2707@qq.com>
In-Reply-To: <tencent_32C3AEB0599DF0A0010A862439636CDA2707@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR15MB3208:EE_|SA1PR15MB5047:EE_
x-ms-office365-filtering-correlation-id: 3fdbcde5-defe-48f7-38b4-08dc41d5853b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tfEAdCtHkp1wAfshvMvxRaFPmSbx23p2MSSTXeRxrbM2XlpDvVGH5gZAtecR9YUoh4Oe865LwErZk+p89YK/htjmkbfCLWiTAv5383y9+UMaZpyaj+4kZm3pwBciaVy5I1e91KCVCbz9KoelCEZVO3P1OpfkNEmXcZ4Cx2tHFDuaUcmtS8qdJCAG9E8KfPispM8wkBWFfTEGwgmAZzVwuv+C2PIK4Tk/e3RKBE4z+i5gKZunP9RCCT5R71rhAbQbJV/y8QaLo8y0nda6wnPb0tsdIDksm5MehDqqVHTLxRoOYQHswsOPLbuWK3jedxATeS8NlDudjxlBiRIY30dYvLsB28AWZmIvs/H82qyjUtBtyJZ+Rvdk40rdyLit0MqhaULRjFMFd0hmz2xfD077D1L48jQL0+9aejHsyYVsBgi8+L47rKTKAbFdw/elkqWQteQFPzNd5MDpOUXZQ8ZLQkbUaZXH5xu12qEFq9+O9TLgaYfV5m4uywfTQXUOt/5C7JrSgey1DsO0XRWz/HoJ3N6YdFN9kQ1zMS2VllKdqHKms5VpqZUmu4Xuw2M8oujpwiClKNNJpRBRpY+Y+zlKXk1Rw/1wK655/v9k69MPFh1BhaegLCwxpqHrhpHfmES4kJ33gqx/TwVxOvG3MVwNc1lALXAIlOeYbela/5+GzoGjJDTS8yiFc4WMl78+GS3X5EktH7BY7lS3DA7cjHSCFbR7LthdHeJo55d+UV7fbgY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB3208.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UGIvcjVWOFNpQVR4NVZaQ0NRNllyNlk1RWk1VW83MWF3aDVyaUMxeThvQ0FL?=
 =?utf-8?B?REJWSnJxUG00Wk9kNVJYNmVxYlphRkd6SFR1dEdmUTI3TmJuOEpLU2dnTzdv?=
 =?utf-8?B?YlFPekszU0JEeXpCTVVuNk1tck9jTXlJSVJ1VUoxTUdRdHB0NHhCNE5CVEMy?=
 =?utf-8?B?TGZOYVp0VnBtUHRPL2gxa2JIZjJpbEd3NjVpdnBMYzVzL1NvMFdHMmdmVmE0?=
 =?utf-8?B?V0ZGSTVKVm9yYjgveGN0YUs2Tml1Z05KYzhQRW1mcnFBMVVNQ2FZNEhhdW9L?=
 =?utf-8?B?cmR1dHdXdkRPenRUamJSb3N3KzJvWWN1M3FpNE9YeHJlNGhCaG04ZUlWYjFH?=
 =?utf-8?B?Q0hOVlFBWDVEcFE1RWtZQUl3bDBwK2k2eUFHNkV3RUI4S3Jnb3dMZE51MnI1?=
 =?utf-8?B?M3dSYlh0Z1RMT2VNNFhlR0dyRGFocUNuZ2Y1NnAwM05HSUlIak9GUWF1YVVF?=
 =?utf-8?B?QUVTUi9ZYVFxZ2Q0UzNubTJSN0pUb0dZVi95K29pS09sS0dhQ2d1SG4raWFT?=
 =?utf-8?B?ZGNJZlM1VE9JcDU0Umg5Uks1bnRLUmlhU2E1UXdJWndoeXZOTFpacTUreTZC?=
 =?utf-8?B?eXpUUzBwdlhmVWhjeGNJN09Yb2xncWdXd2NjS3FUWE0yM0tUNXNKQlRnTDNO?=
 =?utf-8?B?MTdPSjZ6RTZVMDZyalBxQmlFNm90MHVGcUFUVDltR1lZc2xKTlhSNW45S1Y5?=
 =?utf-8?B?ZFAxajhob0ppT1hIeVE4VjhLK2VsSzAxZjFZVjdXSTAyM2tuM09ncTRqQ1o2?=
 =?utf-8?B?NjZRLy8wTmVLc3IwT3ZhcUpFU21xUkVEVVdMVTBoTnhhc3lsT2NQZ3BzbVl1?=
 =?utf-8?B?K1NOY3lYVlZmNnBIU3YzU0JETDRBSVFZTVp1Vm5mWjFFU1kxeXpFSFFQbUIx?=
 =?utf-8?B?bkp1a0RYMXRDNkhoODBQZ2hHK1FLQlA4UU5hbjllRVl5cHdZdGZSbGtneXQ0?=
 =?utf-8?B?RHAxcG56aTA0MUtzdnBlanFieEgwMGRtT2NpM3I2UXRicEdweU16dy81R2dP?=
 =?utf-8?B?YS9ReW50WjFFTFlBV1VXK3hUK1lUaU5UV2VTYlRPcnpPRUcxT2Z3NWZxTmls?=
 =?utf-8?B?ZUdQOFpvbE11b3BINWR3NUg4YmxlMGVKSHpnT3BoY1c0ai9mb1FjdGZlZklQ?=
 =?utf-8?B?OW4rRnVTOGNaSE0yNUFybjJqeW9yYUpFWEs3SjUrZmJmblAveG9HNG9PSE9I?=
 =?utf-8?B?c0R3MjZQdFdkMGhMNXNuNGZscGFWVkpkVEhBVy9aUTVJYTV3dXc1dU4xQUpP?=
 =?utf-8?B?WHNub1RmcUNwZmRuQlByampBTjRtaXBQdWdYNWRkWDJiMS81N1RWQUFKU3RW?=
 =?utf-8?B?RUIzdUViNytIRHduWVU2TW1vU0pmU1hQQmNQaGZOM2tMWklZVEdxWTFjUnM3?=
 =?utf-8?B?STN5VHdLendDZE9Oa21mdU94VG91Myt5U0daMGpIK01BVU5hczhiaW0zUUtz?=
 =?utf-8?B?aVVqYjVvQ2xnQ1RhMml3ek9NN3pVNm1DWVBhQjdQSFlscW12elZnVzA1LzFP?=
 =?utf-8?B?Umg4T1ZSdjZkd2ZPMGVmN2xDVUw0Y1dSV2lKT0JWR0dncmMrM1F1S240VEg0?=
 =?utf-8?B?QTRHVlpPWXRpd2hhWXhDTUFvRHNjdDNOSlJHa1hmQ0g5Unc2N0s5WDdkN1Q4?=
 =?utf-8?B?bk1wNUdCNm1lSGp2THhFNkpXcDlBZURUcU1SVjlWM1hNMTc4MllGUlo5Kzgz?=
 =?utf-8?B?VXhhWlUxdld0TjVOZG5OV3lQVjUvS0FIbjRhR3V1SGNYLzVod29wMUl0OXlB?=
 =?utf-8?B?dWlzYTFaUXNHTC90L09JNXBCRnJoMVFHRHBvdWJEcFFUbUJpNVhYaDAxZ3pV?=
 =?utf-8?B?dkxUNWQ3c2FpbTZ3ZDlmR2VmYnN4LzYwSGErN0g2TTlmYjFvVjdVRjV2eHNV?=
 =?utf-8?B?VlRoc2dMTmtuMU8rNjZTb3NUKzE2TnZvRlRLeUNZZCtnZFpXb24wUzVsZUtQ?=
 =?utf-8?B?VFdWUEJmblZhTW1BM2xKU3hCTTFiVy9ZY082T0ZmWDNzVi84aGZmOTlUVzFI?=
 =?utf-8?B?TkJOSnplbS9IU2c5d2NoM29QVHAvWG10a0FsODMzQ0t3R1lOOHdrZG5KdUF1?=
 =?utf-8?B?WlhCZzBDMlluRlRwYUxzdm5LVXZMdWxPYnZ0dDRuV3lhczN0bkRGb1pXV0t0?=
 =?utf-8?B?emtQNFRlR2N4anV6eFJMbFM4MU9qbDAycmZyNjU3aUNoS1pPNzlteXhwckNl?=
 =?utf-8?Q?4XcYfkES4jbS6WjGxBRsHSQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB3208.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdbcde5-defe-48f7-38b4-08dc41d5853b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 14:14:09.8805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+YSbXuEwNtqw6xlOSz86BL7yaX2JAEpbgAV1/0sQZiQCEGAPJvkcfe/LS6deNzGr2tGu4iEju0FKPezzVt8RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5047
X-Proofpoint-GUID: 6e9XQ6jkVLRQRsNM2wreh-1Qm_hbP5A4
X-Proofpoint-ORIG-GUID: Nppm9ukXdl5KOBRNyJUD2kUThRx1PmcO
Subject: RE:  [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of
 re-reading it
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=999 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110107

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGlua2UgbGkgPGxpbGlu
a2U5OUBxcS5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXJjaCA5LCAyMDI0IDE6MjcgUE0NCj4g
Q2M6IGxpbGlua2U5OUBxcS5jb207IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29t
PjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAemllcGUuY2E+OyBMZW9uIFJvbWFub3Zza3kgPGxl
b25Aa2VybmVsLm9yZz47IGxpbnV4LQ0KPiByZG1hQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSF0gUkRNQS9z
aXc6IFJldXNlIHZhbHVlIHJlYWQgdXNpbmcgUkVBRF9PTkNFDQo+IGluc3RlYWQgb2YgcmUtcmVh
ZGluZyBpdA0KPiANCj4gSW4gc2l3X29ycWVfc3RhcnRfcngsIHRoZSBvcnFlJ3MgZmxhZyBpbiB0
aGUgaWYgY29uZGl0aW9uIGlzIHJlYWQgdXNpbmcNCj4gUkVBRF9PTkNFLCBjaGVja2VkLCBhbmQg
dGhlbiByZS1yZWFkLCB2b2lkaW5nIGFsbCBndWFyYW50ZWVzIG9mIHRoZQ0KPiBjaGVja3MuIFJl
dXNlIHRoZSB2YWx1ZSB0aGF0IHdhcyByZWFkIGJ5IFJFQURfT05DRSB0byBlbnN1cmUgdGhlDQo+
IGNvbnNpc3RlbmN5IG9mIHRoZSBmbGFncyB0aHJvdWdob3V0IHRoZSBmdW5jdGlvbi4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IGxpbmtlIGxpIDxsaWxpbmtlOTlAcXEuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3J4LmMgfCA2ICsrKystLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF9yeC5jDQo+IGIvZHJpdmVycy9p
bmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfcnguYw0KPiBpbmRleCBlZDRmYzM5NzE4YjQuLmY1ZjY5
ZGU1Njg4MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBf
cnguYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF9yeC5jDQo+IEBA
IC03NDAsNiArNzQwLDcgQEAgc3RhdGljIGludCBzaXdfb3JxZV9zdGFydF9yeChzdHJ1Y3Qgc2l3
X3FwICpxcCkNCj4gIHsNCj4gIAlzdHJ1Y3Qgc2l3X3NxZSAqb3JxZTsNCj4gIAlzdHJ1Y3Qgc2l3
X3dxZSAqd3FlID0gTlVMTDsNCj4gKwl1MTYgb3JxZV9mbGFnczsNCj4gDQo+ICAJaWYgKHVubGlr
ZWx5KCFxcC0+YXR0cnMub3JxX3NpemUpKQ0KPiAgCQlyZXR1cm4gLUVQUk9UTzsNCj4gQEAgLTc0
OCw3ICs3NDksOCBAQCBzdGF0aWMgaW50IHNpd19vcnFlX3N0YXJ0X3J4KHN0cnVjdCBzaXdfcXAg
KnFwKQ0KPiAgCXNtcF9tYigpOw0KPiANCj4gIAlvcnFlID0gb3JxX2dldF9jdXJyZW50KHFwKTsN
Cj4gLQlpZiAoUkVBRF9PTkNFKG9ycWUtPmZsYWdzKSAmIFNJV19XUUVfVkFMSUQpIHsNCj4gKwlv
cnFlX2ZsYWdzID0gUkVBRF9PTkNFKG9ycWUtPmZsYWdzKTsNCj4gKwlpZiAob3JxZV9mbGFncyAm
IFNJV19XUUVfVkFMSUQpIHsNCj4gIAkJLyogUlJFU1AgaXMgYSBUQUdHRUQgUkRNQVAgb3BlcmF0
aW9uICovDQo+ICAJCXdxZSA9IHJ4X3dxZSgmcXAtPnJ4X3RhZ2dlZCk7DQo+ICAJCXdxZS0+c3Fl
LmlkID0gb3JxZS0+aWQ7DQo+IEBAIC03NTYsNyArNzU4LDcgQEAgc3RhdGljIGludCBzaXdfb3Jx
ZV9zdGFydF9yeChzdHJ1Y3Qgc2l3X3FwICpxcCkNCj4gIAkJd3FlLT5zcWUuc2dlWzBdLmxhZGRy
ID0gb3JxZS0+c2dlWzBdLmxhZGRyOw0KPiAgCQl3cWUtPnNxZS5zZ2VbMF0ubGtleSA9IG9ycWUt
PnNnZVswXS5sa2V5Ow0KPiAgCQl3cWUtPnNxZS5zZ2VbMF0ubGVuZ3RoID0gb3JxZS0+c2dlWzBd
Lmxlbmd0aDsNCj4gLQkJd3FlLT5zcWUuZmxhZ3MgPSBvcnFlLT5mbGFnczsNCj4gKwkJd3FlLT5z
cWUuZmxhZ3MgPSBvcnFlX2ZsYWdzOw0KPiAgCQl3cWUtPnNxZS5udW1fc2dlID0gMTsNCj4gIAkJ
d3FlLT5ieXRlcyA9IG9ycWUtPnNnZVswXS5sZW5ndGg7DQo+ICAJCXdxZS0+cHJvY2Vzc2VkID0g
MDsNCj4gLS0NCj4gMi4zOS4zIChBcHBsZSBHaXQtMTQ2KQ0KPiANCj4gDQoNClRoZSBvdXRib3Vu
ZCByZWFkIHF1ZXVlIChvcnEpIGlzIGEgcmluZyBidWZmZXIgd2l0aCBvbmx5IG9uZQ0KY29uc3Vt
ZXIgKHRoaXMgY29kZSkgYW5kIG9uZSBwcm9kdWNlciAoUkVBRC5yZXF1ZXN0IHNlbmRpbmcNCmNv
ZGUpLiBUaGVyZSBpcyBubyBwYXJhbGxlbCByZWFkZXIgYW5kIGEgc2luZ2xlIHdyaXRlci4NCg0K
VGhlIHByb2R1Y2VyIChzZW5kZXIgb2YgdGhlIFJFQUQucmVxdWVzdCkgc2V0cyB0aGUgb3JxIGVu
dHJ5DQp2YWxpZCBhbmQgZG9lcyB0aGlzIG9ubHkgb25jZSBhZnRlciBjb21wbGV0ZWx5IHdyaXRp
bmcNCnRoZSBlbnRyeS4gSXQgZG9lcyBpdCB1bmRlciBxcC0+b3JxX2xvY2suDQoNCk9ubHkgaWYg
d2UgZmluZCB0aGUgb3JxIGVudHJ5IHZhbGlkLCBpdHMgY29udGVudCBnZXRzIGNvcGllZA0KYXQg
dGhlIGJlZ2lubmluZyBvZiBhIG5ldyBSRUFELnJlc3BvbnNlICh0aGlzIGNvZGUpLg0KDQpUaGUg
b3JxIGVudHJ5IHJlbWFpbnMgdmFsaWQgdG8gc3RvcCB0aGUgcHJvZHVjZXIgZnJvbSByZS11c2lu
Zw0KaXQgdW50aWwgdGhlIGNvbXBsZXRlIFJFQUQucmVzcG9uc2UgaGFzIGJlZW4gcmVjZWl2ZWQg
KG1heSBiZQ0KbXVsdGlwbGUgZnJhZ21lbnRzKS4gVGhlIGZsYWcgZ2V0cyBjbGVhcmVkIHVuZGVy
IHFwLT5vcnFfbG9jaw0KYWZ0ZXIgdGhlIGNvbXBsZXRlIFJFQUQucmVzcG9uc2UgaGFzIGJlZW4g
cmVjZWl2ZWQsIG9yIHRoZQ0KcmVzcG9uc2Ugd2FzIGludmFsaWQuDQoNCg0KVGhlcmUgaXMgbm8g
cG9zc2liaWxpdHkgYSB2YWxpZCBvcnEgZW50cnkgZ2V0cyBpbnZhbGlkYXRlZA0KYWZ0ZXIgaXQg
aGFzIGJlZW4gZm91bmQgdmFsaWQsIHNvIGl0IGlzIHNhZmUgdG8gY29weSBhbGwgaXRzDQptZW1i
ZXJzLiANCg0KVGhhbmtzLA0KQmVybmFyZC4NCg==

