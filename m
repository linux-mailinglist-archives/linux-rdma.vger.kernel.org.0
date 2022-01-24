Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439A8497FBE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jan 2022 13:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbiAXMoD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jan 2022 07:44:03 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55388 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238175AbiAXMoD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jan 2022 07:44:03 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20O89pLJ027682;
        Mon, 24 Jan 2022 12:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=L802hLyO3YIq6eMZubioDPHh69Dnpkf/HpZSYoCpa+s=;
 b=ZZq01THO+FZSn+o/NExwFzmR4jW7Pa5ivvzUfy0dVHQtu2hYe/TC12ws8INpV6Pjq43A
 +97iCsfIX98PhmEuxer7OGacNoKC/3+BFOYF5Jybdy6QqqoY3krodoV1hjHzGmzHJblw
 nQXOdxqhgRFlXgt/K9xbkIH28I0mCdo9T+jvJuwB9ZSXYdB5qMV2YD4Xi49Y5XYs4Yje
 caf91QtZzCyfyASPt5O5qo/ZbKOwr4xX7dpxv07zxD4OHVRxBwPtP3M3m9pS+8ax3YVe
 5OCFU01lWiaXFVviWHURQBry091vSzZ/+iMgvq1wnYKcuVPn6A/JAQBV3F+/YdXQRCLD Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dr9tb3un8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 12:43:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20OCfC51181790;
        Mon, 24 Jan 2022 12:43:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3dr7ydpe9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jan 2022 12:43:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lp/j+Ii1RNtpBbRY+dQbzzjq6ZWYdS/dCmGqeTEA7ih0ERfXG8B1B2lxA6Q6GLJLJRiU36iKZS7ckRCw8vR6SZe8WQEUZCXzdm+jdOnozd04J4s1wdWCs2R63RLHI1wiHzt3eR8/fzfVvc1sxN/HjuorXzBXcCC8bR9byi1BRmo8QiZDPmSnVicGp3zcoGniHWa/E3u2QnnyYwVUMcY1oDy6DPAla03JsQkgsMVuXLEsUgtYZKXgh3iiC2s/HCbVnfL53sje8Ute1ZixbWdTvFEkUJWyVJkDa6dmb3nX78GlgRWz1XDinOCRyGTxDtTg/m/R0/Dhq/9UkZc0GeEp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L802hLyO3YIq6eMZubioDPHh69Dnpkf/HpZSYoCpa+s=;
 b=Y4hSHmK+/sN7SCMy9uI+GrfFXHPoWqJg1lO3fXVTHAHnJckwhzQ9umLJxhWulJg+JPaLwT8RY1jwEiaTdafrQzT1fGwtB52FijnKKr+rqzAK6cQgH0CO7CJiL54QEB2SOKhr9dtc1Iqn0uWpLUsApANDtRDS+gLAbN253v4UKKNgnGSjq13rhNzTlmq18VDgXDM+R9DkBPGQqnsDo9AEB4+pafJ8BikIkrsYigBpA1nPSi7AXFY/5AsxFtOd47hPVRIDJ/lSf5q+IXXeBvZ7DUWfz87JR3SVzeDk8PTC4BS7+EyuCk3CDdm/Ydb741Lk4q25XxQNkvZQhIUDKaXnDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L802hLyO3YIq6eMZubioDPHh69Dnpkf/HpZSYoCpa+s=;
 b=F6hN+VPBMp0maB19N+C9uLyfCD3URb+o1vFbuS0mJQBVsIVN0Mdsprjpyx0KhWdHGtaJYZpApIyTpttOTC0i83YhHGS3J5X2Z/ceJKjtpQ/0ohiTigQfXkfP4LSEvn79k3ttWBH9+INpxEFUygt68ks1dTVlyChpvFMicuNQC08=
Received: from SN4PR10MB5590.namprd10.prod.outlook.com (2603:10b6:806:205::5)
 by DM5PR10MB1595.namprd10.prod.outlook.com (2603:10b6:3:13::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 12:43:47 +0000
Received: from SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0]) by SN4PR10MB5590.namprd10.prod.outlook.com
 ([fe80::54fa:f1f7:d24b:e1b0%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 12:43:47 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "mike.marciniszyn@cornelisnetworks.com" 
        <mike.marciniszyn@cornelisnetworks.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/rdmavt: Validate remote_addr during loopback
 atomic tests
Thread-Topic: [PATCH for-rc] IB/rdmavt: Validate remote_addr during loopback
 atomic tests
Thread-Index: AQHYDRbqy5Gwv8UplUmU/FE5niN4Zaxwb3QAgAGxUwCAAAJTgIAAAseA
Date:   Mon, 24 Jan 2022 12:43:47 +0000
Message-ID: <4579CC13-F537-4F54-887B-B9CFB570DE43@oracle.com>
References: <1642584489-141005-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
 <Ye0vPMAF6NdF0pMu@unreal> <E3A123CC-3C34-4EE9-BF6E-3F9FEF04A939@oracle.com>
 <Ye6cry944qSVHi6z@unreal>
In-Reply-To: <Ye6cry944qSVHi6z@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.40.0.1.81)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed4347d8-5f83-4870-11ee-08d9df372a78
x-ms-traffictypediagnostic: DM5PR10MB1595:EE_
x-microsoft-antispam-prvs: <DM5PR10MB1595CDB944AF4C7489A3653FFD5E9@DM5PR10MB1595.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uqECo/1sCW/+tsZ4xW75FUKDFlmUQNdPITrvuPHfkw0WmCNcTNA27Lb50viHXtGxKPfU96Oc+i2mOakcvKIbEsJLGVOD/gLy1WFE7riopcTML3C0enXvVtoKI+OEL9E1I5ungZ7j6lE7zpxrVkF4uthQZ7/jCPaYFwDwJPVPrkgGjql42t58a5JLfAaHiHfjkdo6G8AbeaROjt53RyGa0i/ZIyDiuFbDLHJJaZd+rlYGo2AjX1j8L4aT/SwjPPr9XXB2DrcE8sqYX7VAAEKhMnx1sWAJ9XultfTiNZNIzcXsh8FNdF/c65SXUEbowW3mkDGiwNPTdixFncRrQByiPX5WqeUGNe1sRc8Cro8abAu6iQccaJM7/TGpZWLApV8xbIGvgxz+N0FtW8LY1ikuVSGv9ayDg1wJK+QdmLnLME0dQ55K7VHzURsKxbKpLu6fHqIrB/3FL7rGx3GiD+FSo/F2Fz9xuqGSV0le2cxIca6RApIA7L9scGLKyvzKCBdSyc77T+BY+c8ug4wuaF9noxpGIk4lv4L+MHJ2lab4xAEmNdkv5vqXcJX9aiHgeke9Z5KdjPb3xE7TL/DGKHSJwy1A+ZcZHblEL379/SHyERtFyRjaclVGEsHGEkPOr2G16hX5wHSiOw6y6qLb5XMMUs8ypoI+5MrIX1pyg5d8O/lpcoommaay6dxYFE5UcmxKcv1i+xuGh6Fsg9meIe5agcdHMCPxu5vauPo080GnbfPdNRt+UFV+IgbNtiXA1xWW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5590.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6486002)(33656002)(26005)(71200400001)(2616005)(8936002)(53546011)(15650500001)(508600001)(83380400001)(316002)(86362001)(66574015)(5660300002)(66556008)(8676002)(38070700005)(66946007)(6512007)(66446008)(66476007)(44832011)(6916009)(36756003)(91956017)(64756008)(2906002)(4326008)(76116006)(38100700002)(54906003)(6506007)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXJOSTRxU0EvYUhuNTdPc3YrVnREMUNVRE0rK2JFUTI0OEpmRUMvY2V4WjRE?=
 =?utf-8?B?OFFvRE8rMC9aQkxKdTIyNjl6Z3hqcEZkekpCamRsejQzWlBBNGoxZHNEVElh?=
 =?utf-8?B?UUFWQWgyRHJqTmlmNXdseHhiNFR5NmFlMWJQM2Z0djJUWHA1djBVL09udnA2?=
 =?utf-8?B?bmpHd1hDczNkakJkWVQ4OXdDZERaL21XWWxSYmF4VDVtbVZaSUc4YkVDL0Vi?=
 =?utf-8?B?QmE5YXBTSXp4MnI1Nm11dDg1OVFOL2pxd01sRTNONThxaHZzYkVsTStoaW1t?=
 =?utf-8?B?VkVQMm5kT2IxKzBDWGRpaS9kRG5rRk0yR2x5TDc2RUFkSUJXVUVmMW1LZmRT?=
 =?utf-8?B?QUVoQ094RFBjRXEydkFMdmVWNWVLaTg5Wk9sNG9jTDl5M1RuSHBCbnFzWU1K?=
 =?utf-8?B?TTd3Syt0STRhbUNaRU5qTjJQU2htY3R1N1o4MHlISGRDeTJkSjBORXBTNnlH?=
 =?utf-8?B?OEMycWVsMlo2UlhVOEk0dmRtV3ZlTW53OUhYRFFVa3laTXhuczBsTDdCc3FF?=
 =?utf-8?B?ZzhMUko5N3Q0QVN0ZzFFSGgyOWFYaXU1YVJqb1AydGdjVnRjNEFXSHhGalF3?=
 =?utf-8?B?UmI3bytWeGNvMlc4K1ZEckFJLzU3NFpSbnBmZ3dEVGl4Y2RyeVozeXcxZDVW?=
 =?utf-8?B?K21Gd2tQRlZnakRGMHFMR1N0RTlkbUVyVW9mNFVSLzBMTmNOZjBSZEUwTFBs?=
 =?utf-8?B?V3pvTS8reFBjNUxWcTZ0dDJLb29CbDFvSXY4M05QWG1YT2xSWXpyTEhLUmt5?=
 =?utf-8?B?UDBiTDRIYU5lbE1jWk9hQkVjc0FPNHhET1N1SHNVV1R2MzV3aUJOcGhKYys5?=
 =?utf-8?B?UTRjbFh4UExsR3NjWjV1NGVoaVRCYzUzR1FZYklZdUNCaDBuQmVmZmgxTDVa?=
 =?utf-8?B?ZEVPNG56Q2lOcG9oZytrM2RhampVYkhrZ3l4OUYzRzJ2ZmxDcTdEN3llY1U4?=
 =?utf-8?B?eE11cGtDNTlpYjkzRnhxU2JoMkJRUk5Ca1hjT04xQW84TTRmUVkyeWMzaHR4?=
 =?utf-8?B?dmRpY0VRdURKNHo5eTg2b2E5RUgvTjU3dWdCb3pJWTRKZDB1VW91WWhJQTJ3?=
 =?utf-8?B?YjJyM3BSREtCYVVaMlFWMkY0ckQzL1ZkU1YvVjQ0bDlJQkJGellIa0YxRisw?=
 =?utf-8?B?M1pNbFFqZWpRRDMwUjR6M3JsMkg2bmd2ZmYxU1RDM1pGTm01Q0VrdGNQSGlD?=
 =?utf-8?B?Mm9lZGZsODU1RGFtSEY1VWJxRE5JOVJGYmNpMU5MVlZLbjVuSy9nZk5UeEh5?=
 =?utf-8?B?YVAwa2oxTTduNGtyRWw1aFoweHA1WEFRTjJ6aDErSXg4UHBvMVhHNk4wdGZG?=
 =?utf-8?B?OVFEVXNSYi9qZ0JydHI0c0FxKzRxcnpjU0FSQlUrMFRwSG5vb2duTlJJbDdy?=
 =?utf-8?B?c2FreXJoRnJvd1ZDL0llakRBUGtteHlYT2NxTGlVYzd6VUxHUXppeks4aHpk?=
 =?utf-8?B?aVQvWHJYYkpyUG1oSzNJbkZtOVVjeVh5NzZsaFdVYmduWXdWSmFGZ29qd0lp?=
 =?utf-8?B?aUVTNEhmK3RseXFlckx2Q0o3UzA2dUs3OGtzOTRROTZ2ckw4Zk5WTFd6NHc1?=
 =?utf-8?B?RjBwTWloTW9BbUdsTmhWd2x1VWhrL0xhc0I2TDV6bmtpYVpLWlFtbHVYaGpG?=
 =?utf-8?B?L2Z3VHJNWjhUYk1xakg0OG9CWSsxRFpmejhwSmxISlZvZmZwRU41MEJkZXFt?=
 =?utf-8?B?alR4Y3VZVzFiQVFtTVlDTWhsdSs1eGxpUTBHR1YzNmZ3UlhxblE0TWhEbFNF?=
 =?utf-8?B?UFcrMkpKOG9Vdmh1cWxjVjlIMEJNRE9lMkhhU0xHYm0xM0ozKy9LL21WZ3hr?=
 =?utf-8?B?V0hrNkVyTXRTZ0NkMVlYekFDN3FxbEdjZFhPb3dGKzd6aFdoUFVVRFhMaWdX?=
 =?utf-8?B?c0hBR1owM0RoTDRhcTJxRXNlNjUveFYzYnRSNWt1NDN2TDhUUUhKN0lIeXFF?=
 =?utf-8?B?K2RUYm9TUFJuOVBUM3VWWUZEVzNTNHZkQUdaOG5CWnBVT0wwWFFNVWtYdEpZ?=
 =?utf-8?B?TTYvRXZ3Tmo3bUczekdpZCtpbHQxL0dlTDNPQmRCdmM0S2ErQlF0b2hLaW1D?=
 =?utf-8?B?cjN6UmpNTkF6YlZLYkpRdTNLaDRNcWFhMXhGQ1dCaXQ2WjVSK1A3aFpBK3lj?=
 =?utf-8?B?bW1Eb0NkR25qeTRMdUVOTHpFL216NlRVUUdOMGlIZkFZQjl1QVp3V1phQXpL?=
 =?utf-8?Q?wwrzXB92jeIGEogtKSd7JKE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58ED8D63F89F374DBFE994B289CEC81B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5590.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4347d8-5f83-4870-11ee-08d9df372a78
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 12:43:47.7501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Krj06fAXBQCX6++xjMK+VTT14CjBI1itRG/wpX/6htFKQTgiEKXCmXBAdEnc8MOxdY/nng1ahJ55R2mhX1FiJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1595
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10236 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201240084
X-Proofpoint-GUID: 6Sxs6prFKCSkXcJm7R1TbEgcnh_VSXDN
X-Proofpoint-ORIG-GUID: 6Sxs6prFKCSkXcJm7R1TbEgcnh_VSXDN
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjQgSmFuIDIwMjIsIGF0IDEzOjMzLCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEphbiAyNCwgMjAyMiBhdCAxMjoyNTozMlBN
ICswMDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDIzIEphbiAyMDIy
LCBhdCAxMTozNCwgTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+
IA0KPj4+IE9uIFdlZCwgSmFuIDE5LCAyMDIyIGF0IDA0OjI4OjA5QU0gLTA1MDAsIG1pa2UubWFy
Y2luaXN6eW5AY29ybmVsaXNuZXR3b3Jrcy5jb20gd3JvdGU6DQo+Pj4+IEZyb206IE1pa2UgTWFy
Y2luaXN6eW4gPG1pa2UubWFyY2luaXN6eW5AY29ybmVsaXNuZXR3b3Jrcy5jb20+DQo+Pj4+IA0K
Pj4+PiBUaGUgcmRtYS1jb3JlIHRlc3Qgc3VpdGUgc2VuZHMgYW4gdW5hbGlnbmVkIHJlbW90ZSBh
ZGRyZXNzDQo+Pj4+IGFuZCBleHBlY3RzIGEgZmFpbHVyZS4NCj4+Pj4gDQo+Pj4+IEVSUk9SOiB0
ZXN0X2F0b21pY19ub25fYWxpZ25lZF9hZGRyICh0ZXN0cy50ZXN0X2F0b21pYy5BdG9taWNUZXN0
KQ0KPj4+PiANCj4+Pj4gVGhlIHFpYi9oZmkxIHJjIGhhbmRsaW5nIHZhbGlkYXRlcyBwcm9wZXJs
eSwgYnV0IHRoZSB0ZXN0IGhhcyB0aGUNCj4+Pj4gY2xpZW50IGFuZCBzZXJ2ZXIgb24gdGhlIHNh
bWUgc3lzdGVtLg0KPj4+PiANCj4+Pj4gVGhlIGxvb3BiYWNrIG9mIHRoZXNlIG9wZXJhdGlvbnMg
aXMgYSBkaXN0aW5jdCBjb2RlIHBhdGguDQo+Pj4+IA0KPj4+PiBGaXggYnkgc3ludGF4aW5nIHRo
ZSBwcm9wb3NlZCByZW1vdGUgYWRkcmVzcyBpbiB0aGUgbG9vcGJhY2sNCj4+Pj4gY29kZSBwYXRo
Lg0KPj4+PiANCj4+Pj4gRml4ZXM6IDE1NzAzNDYxNTMzYSAoIklCL3toZmkxLCBxaWIsIHJkbWF2
dH06IE1vdmUgcnVjX2xvb3BiYWNrIHRvIHJkbWF2dCIpDQo+Pj4+IFJldmlld2VkLWJ5OiBEZW5u
aXMgRGFsZXNzYW5kcm8gPGRlbm5pcy5kYWxlc3NhbmRyb0Bjb3JuZWxpc25ldHdvcmtzLmNvbT4N
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogTWlrZSBNYXJjaW5pc3p5biA8bWlrZS5tYXJjaW5pc3p5bkBj
b3JuZWxpc25ldHdvcmtzLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IGRyaXZlcnMvaW5maW5pYmFuZC9z
dy9yZG1hdnQvcXAuYyB8IDIgKysNCj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQ0KPj4+PiANCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yZG1hdnQv
cXAuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yZG1hdnQvcXAuYw0KPj4+PiBpbmRleCAzMzA1
ZjI3Li5hZTUwYjU2IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcmRt
YXZ0L3FwLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3JkbWF2dC9xcC5jDQo+
Pj4+IEBAIC0zMDczLDYgKzMwNzMsOCBAQCB2b2lkIHJ2dF9ydWNfbG9vcGJhY2soc3RydWN0IHJ2
dF9xcCAqc3FwKQ0KPj4+PiAJY2FzZSBJQl9XUl9BVE9NSUNfRkVUQ0hfQU5EX0FERDoNCj4+Pj4g
CQlpZiAodW5saWtlbHkoIShxcC0+cXBfYWNjZXNzX2ZsYWdzICYgSUJfQUNDRVNTX1JFTU9URV9B
VE9NSUMpKSkNCj4+Pj4gCQkJZ290byBpbnZfZXJyOw0KPj4+PiArCQlpZiAodW5saWtlbHkod3Fl
LT5hdG9taWNfd3IucmVtb3RlX2FkZHIgJiAoc2l6ZW9mKHU2NCkgLSAxKSkpDQo+Pj4gDQo+Pj4g
SXNuJ3QgdGhpcyAiIVBBR0VfQUxJR05FRCh3cWUtPmF0b21pY193ci5yZW1vdGVfYWRkcikiIGNo
ZWNrPw0KPj4gDQo+PiBObywgaXQgY2hlY2tzIHRoYXQgdGhlIGFkZHJlc3MgaXMgbmF0dXJhbCBh
bGlnbmVkLCBpbiB0aGlzIGNhc2UgdGhlIHRocmVlIExTQnMgbXVzdCBiZSB6ZXJvLiBBcyBwZXIg
SUJUQToNCj4+IA0KPj4gPHF1b3RlPg0KPj4gVGhlIHZpcnR1YWwgYWRkcmVzcyBpbiB0aGUgQVRP
TUlDIENvbW1hbmQgUmVxdWVzdCBwYWNrZXQgc2hhbGwgYmUgbmF0dXJhbGx5IGFsaWduZWQgdG8g
YW4gOCBieXRlIGJvdW5kYXJ5Lg0KPj4gPC9xdW90ZT4NCj4gDQo+IEFuZCBpcyBJQlRBIHJlc3Ry
aWN0aW9uIGFwcGxpY2FibGUgdG8gaGZpMT8NCg0KRm9yIGhmaTEsIEkgZG8gbm90IGtub3cuIEJ1
dCB0aGlzIGZpeCB3YXMgaW4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3JkbWF2dCwgZm9yIHdoaWNo
IHRoZSBmaXJzdCBjb21taXQgbWVzc2FnZSBzdGF0ZXM6DQoNCiBUaGlzIHBhdGNoIGludHJvZHVj
ZXMgdGhlIGJhc2ljcyBmb3IgYSBuZXcgbW9kdWxlIGNhbGxlZCByZG1hX3Z0LiBUaGlzIG5ldw0K
ICAgIGRyaXZlciBpcyBhIHNvZnR3YXJlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBJbmZpbmlCYW5k
IHZlcmJzLi4uDQoNCg0KTW9yZSBpbXBvcnRhbnRseSwgdGhlIGNoZWNrIHdlIGRpc2N1c3MgaXMg
bm90IGFib3V0IGJlaW5nIHBhZ2UtYWxpZ25lZCwgYnV0IGFib3V0IGJlaW5nIG5hdHVyYWxseSBh
bGlnbmVkLCByaWdodD8NCg0KDQpUaHhzLCBIw6Vrb24NCg0KPiANCj4gVGhhbmtzDQo+PiANCj4+
IA0KPj4gVGh4cywgSMOla29uDQo+PiANCj4+PiANCj4+PiBUaGFua3MNCj4+PiANCj4+Pj4gKwkJ
CWdvdG8gaW52X2VycjsNCj4+Pj4gCQlpZiAodW5saWtlbHkoIXJ2dF9ya2V5X29rKHFwLCAmcXAt
PnJfc2dlLnNnZSwgc2l6ZW9mKHU2NCksDQo+Pj4+IAkJCQkJICB3cWUtPmF0b21pY193ci5yZW1v
dGVfYWRkciwNCj4+Pj4gCQkJCQkgIHdxZS0+YXRvbWljX3dyLnJrZXksDQo+Pj4+IC0tIA0KPj4+
PiAxLjguMy4xDQoNCg==
